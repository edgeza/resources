-- Dusa Garage Management System - Mileage Tracking Module (Client)
-- Version: 1.0.0
-- Self-contained client-side mileage tracking logic

local MileageTracker = {}
local resourceName = GetCurrentResourceName()

-- Load module configuration
local MileageConfig = require('modules.mileage.config')

-- ============================
-- STATE MANAGEMENT
-- ============================

local currentVehicle = nil
local currentPlate = nil
local lastPosition = nil
local accumulatedMileage = 0.0
local dbMileage = 0.0  -- Current mileage from database
local trackingThread = nil
local lastSyncTime = 0
local uiUpdateThread = nil

-- ============================
-- UTILITY FUNCTIONS
-- ============================

--- Calculate distance between two positions in kilometers
--- @param pos1 vector3 First position
--- @param pos2 vector3 Second position
--- @return number Distance in kilometers
local function CalculateDistance(pos1, pos2)
    if not pos1 or not pos2 then return 0.0 end

    -- Returns distance in meters
    local distance = #(pos1 - pos2)

    -- Convert to kilometers
    local distanceKm = distance / 1000.0

    return distanceKm
end

--- Check if vehicle should be tracked (speed, class, conditions)
--- @param vehicle number Vehicle entity
--- @return boolean Should track
local function ShouldTrackMileage(vehicle)
    if not vehicle or not DoesEntityExist(vehicle) then return false end

    -- Check vehicle class exclusions (bikes, boats, helicopters, planes)
    local vehicleClass = GetVehicleClass(vehicle)
    for _, excludedClass in ipairs(MileageConfig.tracking.excludedVehicleClasses) do
        if vehicleClass == excludedClass then
            return false
        end
    end

    -- Only track when vehicle is on ground and not in water
    if not IsVehicleOnAllWheels(vehicle) or IsEntityInWater(vehicle) then
        return false
    end

    -- Get speed in m/s and convert to km/h
    local speedMps = GetEntitySpeed(vehicle)
    local speedKmh = speedMps * 3.6

    -- Only track if moving (> minimum speed threshold)
    return speedKmh > MileageConfig.tracking.minSpeed
end

--- Trim whitespace from plate
--- @param plate string Vehicle plate
--- @return string Trimmed plate
local function TrimPlate(plate)
    if not plate then return "" end
    return string.gsub(plate, "^%s*(.-)%s*$", "%1")
end

--- Convert kilometers to miles if configured
--- @param km number Distance in kilometers
--- @return number, string Converted distance and unit label
local function ConvertDistance(km)
    if MileageConfig.ui.unit == "miles" then
        return km * MileageConfig.CONVERSION.KM_TO_MILES, "mi"
    else
        return km, "km"
    end
end

--- Get camera perspective mode
--- @return number Camera mode (4 = first person)
local function GetCameraMode()
    return GetFollowPedCamViewMode()
end

--- Check if player is driver
--- @param vehicle number Vehicle entity
--- @return boolean Is driver
local function IsDriver(vehicle)
    if not vehicle or not DoesEntityExist(vehicle) then return false end
    local playerPed = PlayerPedId()
    return GetPedInVehicleSeat(vehicle, -1) == playerPed
end

--- Check if UI should be visible based on display mode
--- @param vehicle number Vehicle entity
--- @return boolean Should show UI
local function ShouldShowUI(vehicle)
    if not MileageConfig.ui.enabled then return false end
    if not vehicle or not DoesEntityExist(vehicle) then return false end
    if not IsDriver(vehicle) then return false end

    local mode = MileageConfig.ui.displayMode

    if mode == "first_person" then
        return GetCameraMode() == 4  -- First person mode
    elseif mode == "always" then
        return true
    elseif mode == "show_on_enter" then
        -- Handled by timer in StartTracking
        return true
    end

    return false
end

-- ============================
-- SERVER SYNC
-- ============================

--- Sync accumulated mileage to server
--- @param plate string Vehicle plate
--- @param mileage number Accumulated mileage in km
local function SyncToServer(plate, mileage)
    if not plate or mileage <= 0 then return end

    LogDebug(("Syncing mileage to server: plate=%s, mileage=%.2f km"):format(plate, mileage), "mileage-tracking")

    TriggerServerEvent('dusa-garage:server:updateMileage', {
        plate = plate,
        mileage = mileage
    })

    lastSyncTime = GetGameTimer()
end

-- ============================
-- UI UPDATES
-- ============================

--- Send mileage update to NUI
--- @param mileage number Current total mileage in km
--- @param visible boolean UI visibility
local function UpdateUI(mileage, visible)
    if not MileageConfig.ui.enabled then return end

    LogDebug(('Original mileage value: %s'):format(mileage), "mileage-tracking")
    local displayMileage, displayUnit = ConvertDistance(mileage)

    SendNUIMessage({
        action = "updateMileage",
        data = {
            mileage = math.floor(displayMileage * 10) / 10,  -- Round to 1 decimal
            unit = displayUnit,
            visible = visible
        }
    })
end

--- Start UI update thread
local function StartUIUpdates()
    if uiUpdateThread then return end

    uiUpdateThread = CreateThread(function()
        local showUntil = 0
        local lastMileage = -1
        local lastVisible = false
        local lastCameraCheck = 0
        local CAMERA_CHECK_INTERVAL = 500  -- Check camera every 500ms

        -- Handle "show_on_enter" mode timer
        if MileageConfig.ui.displayMode == "show_on_enter" then
            showUntil = GetGameTimer() + MileageConfig.ui.showDuration
        end

        while currentVehicle do
            Wait(1000)  -- Check every 1 second (reduced from 100ms)

            if not currentVehicle or not DoesEntityExist(currentVehicle) then
                break
            end

            local totalMileage = dbMileage + accumulatedMileage
            local visible = false
            local currentTime = GetGameTimer()

            -- Determine visibility based on mode
            if MileageConfig.ui.displayMode == "show_on_enter" then
                visible = currentTime < showUntil and IsDriver(currentVehicle)
            elseif MileageConfig.ui.displayMode == "first_person" then
                -- Only check camera perspective every 500ms for performance
                if currentTime - lastCameraCheck >= CAMERA_CHECK_INTERVAL then
                    visible = ShouldShowUI(currentVehicle)
                    lastCameraCheck = currentTime
                else
                    visible = lastVisible  -- Use cached value
                end
            else
                -- "always" mode
                visible = ShouldShowUI(currentVehicle)
            end

            -- Only update UI if mileage changed by 0.1km+ or visibility changed
            local mileageChanged = math.abs(totalMileage - lastMileage) >= 0.1
            local visibilityChanged = visible ~= lastVisible

            if mileageChanged or visibilityChanged then
                UpdateUI(totalMileage, visible)
                lastMileage = totalMileage
                lastVisible = visible
            end
        end

        -- Hide UI when thread stops
        UpdateUI(0, false)
        uiUpdateThread = nil
    end)
end

--- Stop UI updates
local function StopUIUpdates()
    if uiUpdateThread then
        uiUpdateThread = nil
        UpdateUI(0, false)
    end
end

-- ============================
-- TRACKING LOGIC
-- ============================

--- Start tracking mileage for a vehicle
--- @param vehicle number Vehicle entity
--- @param plate string Vehicle plate
function MileageTracker.StartTracking(vehicle, plate)
    if not MileageConfig.enabled then return end
    if not vehicle or not DoesEntityExist(vehicle) then return end
    if not IsDriver(vehicle) then return end

    -- Stop existing tracking
    if trackingThread then
        MileageTracker.StopTracking()
    end

    currentVehicle = vehicle
    currentPlate = TrimPlate(plate)
    lastPosition = GetEntityCoords(vehicle)
    accumulatedMileage = 0.0
    lastSyncTime = GetGameTimer()

    -- Get current mileage from entity state (may be set by server already)
    local entityState = Entity(vehicle).state
    dbMileage = entityState.vehicleMileage or 0.0

    LogDebug(("Started tracking vehicle: plate=%s, initial mileage=%.2f km (from entity state)"):format(currentPlate, dbMileage), "mileage-tracking")

    -- Request current mileage from server (in case entity state is not set yet)
    TriggerServerEvent('dusa-garage:server:requestMileage', currentPlate)

    -- Start UI updates
    StartUIUpdates()

    -- Start tracking thread
    trackingThread = CreateThread(function()
        while currentVehicle do
            Wait(MileageConfig.tracking.updateInterval)

            -- Early exit if vehicle changed or doesn't exist
            if not currentVehicle or not DoesEntityExist(currentVehicle) then
                break
            end

            -- Early exit if not tracking conditions
            if not ShouldTrackMileage(currentVehicle) then
                goto continue
            end

            -- Calculate and accumulate distance
            local currentPos = GetEntityCoords(currentVehicle)
            if lastPosition then
                local distance = CalculateDistance(lastPosition, currentPos)
                if distance > 0 and distance < 1.0 then  -- Sanity check (< 1km per second)
                    accumulatedMileage = accumulatedMileage + distance

                    -- Log every 1 km accumulated
                    if accumulatedMileage >= 1.0 and math.floor(accumulatedMileage) % 1 == 0 then
                        LogDebug(("Accumulated %.2f km (total: %.2f km)"):format(accumulatedMileage, dbMileage + accumulatedMileage), "mileage-tracking")
                    end
                end
            end
            lastPosition = currentPos

            -- Periodic server sync (every 5 minutes)
            local currentTime = GetGameTimer()
            if currentTime - lastSyncTime >= MileageConfig.tracking.serverSyncInterval and accumulatedMileage > 0 then
                SyncToServer(currentPlate, accumulatedMileage)
                dbMileage = dbMileage + accumulatedMileage
                accumulatedMileage = 0.0
            end

            ::continue::
        end

        trackingThread = nil
    end)
end

--- Stop tracking and sync to server
function MileageTracker.StopTracking()
    if not currentVehicle then return end

    LogDebug(("Stopping tracking for plate=%s, accumulated=%.2f km"):format(currentPlate or "unknown", accumulatedMileage), "mileage-tracking")

    -- Sync any remaining mileage to server
    if currentPlate and accumulatedMileage > 0 then
        SyncToServer(currentPlate, accumulatedMileage)
    end

    -- Stop UI updates
    StopUIUpdates()

    -- Reset state
    currentVehicle = nil
    currentPlate = nil
    lastPosition = nil
    accumulatedMileage = 0.0
    dbMileage = 0.0
    trackingThread = nil
end

-- ============================
-- CLIENT EVENTS
-- ============================

--- Handle mileage data received from server
RegisterNetEvent('dusa-garage:client:receiveMileage', function(data)
    if not data or not data.plate or not data.mileage then
        LogDebug("Received invalid mileage data from server", "mileage-tracking")
        return
    end

    local plate = TrimPlate(data.plate)

    -- Only update if this is the current vehicle
    if currentPlate and currentPlate == plate then
        dbMileage = data.mileage
        LogDebug(("Received mileage from server: plate=%s, mileage=%.2f km"):format(plate, dbMileage), "mileage-tracking")

        -- Force UI update with new mileage
        if MileageConfig.ui.enabled and currentVehicle then
            local totalMileage = dbMileage + accumulatedMileage
            UpdateUI(totalMileage, true)
        end
    end
end)

-- ============================
-- VEHICLE CHANGE DETECTION
-- ============================

CreateThread(function()
    if not MileageConfig.enabled then
        LogDebug("Mileage tracking module is disabled", "mileage-tracking")
        return
    end

    LogDebug("Mileage tracking module initialized", "mileage-tracking")

    local lastVehicle = nil

    while true do
        Wait(1000)  -- Check every second

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        -- Vehicle changed
        if vehicle ~= lastVehicle then
            if lastVehicle and lastVehicle ~= 0 then
                -- Exited vehicle
                MileageTracker.StopTracking()
            end

            if vehicle and vehicle ~= 0 and IsDriver(vehicle) then
                -- Entered new vehicle as driver
                local plate = GetVehicleNumberPlateText(vehicle)
                if plate then
                    MileageTracker.StartTracking(vehicle, plate)
                end
            end

            lastVehicle = vehicle
        end
    end
end)

-- ============================
-- DEBUG COMMANDS
-- ============================

-- Test command to add mileage for testing
RegisterCommand('mileage:add', function(source, args)
    if not currentVehicle or not currentPlate then
        print("^1[Mileage] You must be in a vehicle to add test mileage^0")
        return
    end

    local amount = tonumber(args[1]) or 10.0
    if amount <= 0 or amount > 100 then
        print("^1[Mileage] Amount must be between 0 and 100 km^0")
        return
    end

    -- Add to accumulated mileage
    accumulatedMileage = accumulatedMileage + amount

    print(("^2[Mileage] Added %.1f km to current vehicle (Plate: %s)^0"):format(amount, currentPlate))
    print(("^2[Mileage] New total: %.1f km (DB: %.1f km + Accumulated: %.1f km)^0"):format(
        dbMileage + accumulatedMileage, dbMileage, accumulatedMileage))

    -- Force UI update
    if MileageConfig.ui.enabled then
        UpdateUI(dbMileage + accumulatedMileage, true)
    end
end, false)

-- Test command to show current mileage
RegisterCommand('mileage:show', function()
    if not currentVehicle or not currentPlate then
        print("^1[Mileage] You are not in a vehicle^0")
        return
    end

    local totalMileage = dbMileage + accumulatedMileage
    local displayMileage, displayUnit = ConvertDistance(totalMileage)

    print("^3========================================^0")
    print("^3[Mileage] Current Vehicle Information^0")
    print("^3========================================^0")
    print(("Plate: ^2%s^0"):format(currentPlate))
    print(("Database Mileage: ^2%.2f km^0"):format(dbMileage))
    print(("Accumulated (unsaved): ^2%.2f km^0"):format(accumulatedMileage))
    print(("Total Mileage: ^2%.2f km^0"):format(totalMileage))
    print(("Display: ^2%.1f %s^0"):format(displayMileage, displayUnit))
    print("^3========================================^0")
end, false)

-- Test command to sync mileage to server immediately
RegisterCommand('mileage:sync', function()
    if not currentVehicle or not currentPlate then
        print("^1[Mileage] You are not in a vehicle^0")
        return
    end

    if accumulatedMileage <= 0 then
        print("^1[Mileage] No accumulated mileage to sync^0")
        return
    end

    print(("^3[Mileage] Syncing %.2f km to server...^0"):format(accumulatedMileage))
    SyncToServer(currentPlate, accumulatedMileage)

    -- Update local state
    dbMileage = dbMileage + accumulatedMileage
    accumulatedMileage = 0.0

    print("^2[Mileage] Sync complete!^0")
end, false)

-- Test command to toggle UI visibility
RegisterCommand('mileage:toggle', function()
    if not currentVehicle then
        print("^1[Mileage] You must be in a vehicle^0")
        return
    end

    if not MileageConfig.ui.enabled then
        print("^1[Mileage] UI is disabled in config^0")
        return
    end

    -- Toggle visibility by forcing an update
    local totalMileage = dbMileage + accumulatedMileage
    local currentlyVisible = ShouldShowUI(currentVehicle)

    UpdateUI(totalMileage, not currentlyVisible)

    print(("^2[Mileage] UI toggled to: %s^0"):format(not currentlyVisible and "visible" or "hidden"))
end, false)

print("^2[Mileage] Debug commands registered:^0")
print("  ^3mileage:add [amount]^0 - Add test mileage (default: 10 km)")
print("  ^3mileage:show^0 - Show current vehicle mileage")
print("  ^3mileage:sync^0 - Force sync to server")
print("  ^3mileage:toggle^0 - Toggle UI visibility")

return MileageTracker

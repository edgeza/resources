-- Dusa Garage Management System - Mileage Tracking Module (Server)
-- Version: 1.0.0
-- Server-side mileage sync and database operations

local MileageServer = {}
local resourceName = GetCurrentResourceName()

-- Load module configuration
local MileageConfig = require('modules.mileage.config')

-- ============================
-- RATE LIMITING
-- ============================

local rateLimits = {}
local RATE_LIMIT_WINDOW = 60000  -- 60 seconds
local RATE_LIMIT_MAX_REQUESTS = 1  -- 1 request per plate per 60 seconds

--- Check if request is rate limited
--- @param plate string Vehicle plate
--- @return boolean Is rate limited
local function IsRateLimited(plate)
    local currentTime = GetGameTimer()
    local key = plate:lower()

    if not rateLimits[key] then
        rateLimits[key] = { count = 1, resetTime = currentTime + RATE_LIMIT_WINDOW }
        return false
    end

    if currentTime > rateLimits[key].resetTime then
        rateLimits[key] = { count = 1, resetTime = currentTime + RATE_LIMIT_WINDOW }
        return false
    end

    if rateLimits[key].count >= RATE_LIMIT_MAX_REQUESTS then
        return true  -- Rate limited
    end

    rateLimits[key].count = rateLimits[key].count + 1
    return false
end

-- ============================
-- VALIDATION
-- ============================

--- Validate mileage update data
--- @param data table Update data
--- @return boolean, string Valid, error message
local function ValidateMileageData(data)
    if not data then
        return false, "Missing data"
    end

    if not data.plate or type(data.plate) ~= "string" or data.plate == "" then
        return false, "Invalid plate"
    end

    if not data.mileage or type(data.mileage) ~= "number" then
        return false, "Invalid mileage type"
    end

    if data.mileage < 0 then
        return false, "Mileage cannot be negative"
    end

    -- Sanity check: reject unreasonable increments (> 500km in one update)
    if data.mileage > 500 then
        return false, "Mileage increment too large (possible cheating/teleport)"
    end

    return true, nil
end

--- Trim whitespace from plate
--- @param plate string Vehicle plate
--- @return string Trimmed plate
local function TrimPlate(plate)
    if not plate then return "" end
    return string.gsub(plate, "^%s*(.-)%s*$", "%1")
end

-- ============================
-- DATABASE OPERATIONS
-- ============================

--- Update vehicle mileage in database
--- @param plate string Vehicle plate
--- @param mileageIncrement number Mileage to add (km)
--- @return boolean, number Success, new total mileage
function MileageServer.UpdateMileage(plate, mileageIncrement)
    plate = TrimPlate(plate)

    if not plate or plate == "" then
        LogError("Cannot update mileage: invalid plate", "database")
        return false, 0
    end

    if not mileageIncrement or mileageIncrement <= 0 then
        LogDebug(("Skipping mileage update for plate=%s (increment=%.2f)"):format(plate, mileageIncrement or 0), "database")
        return false, 0
    end

    -- Use INSERT ... ON DUPLICATE KEY UPDATE for efficiency
    local query = [[
        INSERT INTO dusa_vehicle_metadata (plate, mileage, created_at, updated_at)
        VALUES (?, ?, NOW(), NOW())
        ON DUPLICATE KEY UPDATE
            mileage = mileage + VALUES(mileage),
            updated_at = NOW()
    ]]

    local success, result = pcall(function()
        return MySQL.insert.await(query, { plate, mileageIncrement })
    end)

    if not success then
        LogError(("Failed to update mileage for plate=%s: %s"):format(plate, tostring(result)), "database")
        return false, 0
    end

    -- Get updated mileage
    local newMileage = MileageServer.GetMileage(plate)

    LogDebug(("Updated mileage for plate=%s: +%.2f km (new total: %.2f km)"):format(plate, mileageIncrement, newMileage), "database")

    return true, newMileage
end

--- Get vehicle mileage from database
--- @param plate string Vehicle plate
--- @return number Mileage in km (0 if not found)
function MileageServer.GetMileage(plate)
    plate = TrimPlate(plate)

    if not plate or plate == "" then
        return 0.0
    end

    local success, result = pcall(function()
        return MySQL.single.await('SELECT mileage FROM dusa_vehicle_metadata WHERE plate = ?', { plate })
    end)

    if not success or not result then
        return 0.0
    end

    return result.mileage or 0.0
end

-- ============================
-- SERVER EVENTS
-- ============================

--- Handle mileage request from client (when entering vehicle)
RegisterServerEvent('dusa-garage:server:requestMileage', function(plate)
    if not MileageConfig.enabled then return end

    local source = source
    plate = TrimPlate(plate)

    if not plate or plate == "" then
        LogError(("Invalid plate in mileage request from player %s"):format(source), "validation")
        return
    end

    -- Get current mileage from database
    local currentMileage = MileageServer.GetMileage(plate)

    LogDebug(("Player %s requested mileage for plate=%s: %.2f km"):format(source, plate, currentMileage), "api")

    -- Send mileage back to client
    TriggerClientEvent('dusa-garage:client:receiveMileage', source, {
        plate = plate,
        mileage = currentMileage
    })

    -- Also update entity state if vehicle exists
    local vehicles = GetAllVehicles()
    for _, vehicle in ipairs(vehicles) do
        local vehiclePlate = TrimPlate(GetVehicleNumberPlateText(vehicle))
        if vehiclePlate == plate then
            Entity(vehicle).state.vehicleMileage = currentMileage
            LogDebug(("Set entity state for vehicle (plate=%s): %.2f km"):format(plate, currentMileage), "api")
            break
        end
    end
end)

--- Handle mileage update from client
RegisterServerEvent('dusa-garage:server:updateMileage', function(data)
    if not MileageConfig.enabled then return end

    local source = source

    -- Validate data
    local valid, error = ValidateMileageData(data)
    if not valid then
        LogError(("Mileage update rejected from player %s: %s"):format(source, error), "validation")
        return
    end

    local plate = TrimPlate(data.plate)

    -- Rate limiting
    if IsRateLimited(plate) then
        LogDebug(("Rate limited mileage update for plate=%s from player %s"):format(plate, source), "validation")
        return
    end

    -- Update database
    local success, newMileage = MileageServer.UpdateMileage(plate, data.mileage)

    if success then
        -- Update entity state for all clients (if vehicle exists)
        local vehicles = GetAllVehicles()
        for _, vehicle in ipairs(vehicles) do
            local vehiclePlate = TrimPlate(GetVehicleNumberPlateText(vehicle))
            if vehiclePlate == plate then
                Entity(vehicle).state.vehicleMileage = newMileage
                LogDebug(("Updated entity state for vehicle (plate=%s): %.2f km"):format(plate, newMileage), "database")
                break
            end
        end
    end
end)

-- ============================
-- EXPORTS
-- ============================

--- Get vehicle mileage (export for other resources)
--- @param plate string Vehicle plate
--- @return number Mileage in km
exports('GetVehicleMileage', function(plate)
    return MileageServer.GetMileage(plate)
end)

-- ============================
-- INITIALIZATION
-- ============================

if MileageConfig.enabled then
    LogDebug("Mileage tracking server module initialized", "system")
else
    LogDebug("Mileage tracking server module is disabled", "system")
end

return MileageServer

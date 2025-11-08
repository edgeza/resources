if not rawget(_G, "lib") then include('ox_lib', 'init') end
-- Dusa Garage Management System - Server API Layer
-- Version: 1.0.0
-- Open-source NUI event handlers for garage operations

local resourceName = GetCurrentResourceName()

-- Track showroom vehicles per player (source -> list of vehicle entities)
local showroomVehicles = {}

-- Load garage manager module
-- local GarageManagerModule = LoadResourceFile(resourceName, 'server/core/garage.lua')
-- if not GarageManagerModule then
--     error(("[%s] ERROR: Could not load garage manager module"):format(resourceName))
-- end
-- local GarageManager = load(GarageManagerModule)()

-- Send notification to client
local function SendNotification(source, message, type)
    TriggerClientEvent('dusa-garage:client:notify', source, message, type or 'info')
end

-- Helper function to get vehicle props based on framework
-- ESX: vehicle.vehicle, QBCore/QBox: vehicle.mods
local function GetVehicleProps(vehicle)
    -- Check global Bridge at runtime
    if Bridge and Bridge.Framework then
        if Bridge.Framework == 'esx' then
            return vehicle.vehicle
        else
            -- QBCore/QBox uses mods column
            return vehicle.mods
        end
    end
    -- Default fallback to vehicle.vehicle for ESX compatibility
    return vehicle.vehicle
end

-- Helper function to determine which column to use for vehicle props based on framework
-- Returns: column name for the current framework
local function GetVehiclePropsColumn()
    if Bridge and Bridge.Framework then
        if Bridge.Framework == 'esx' then
            return 'vehicle'
        else
            -- QBCore/QBox uses mods column
            return 'mods'
        end
    end
    -- Default fallback to vehicle for ESX compatibility
    return 'vehicle'
end

-- Rate limiting for garage operations
local rateLimits = {}
local RATE_LIMIT_WINDOW = 5000 -- 5 seconds
local RATE_LIMIT_MAX_REQUESTS = 3

-- Creation lock system to prevent duplicate garage creation
local creationLocks = {}

local function IsRateLimited(source, operation)
    local key = ("%s:%s"):format(source, operation)
    local currentTime = GetGameTimer()

    if not rateLimits[key] then
        rateLimits[key] = { count = 1, resetTime = currentTime + RATE_LIMIT_WINDOW }
        return false
    end

    if currentTime > rateLimits[key].resetTime then
        rateLimits[key] = { count = 1, resetTime = currentTime + RATE_LIMIT_WINDOW }
        return false
    end

    if rateLimits[key].count >= RATE_LIMIT_MAX_REQUESTS then
        return true
    end

    rateLimits[key].count = rateLimits[key].count + 1
    return false
end

-- Creation lock management
local function AcquireCreationLock(source, garageName)
    local key = ("%s:%s"):format(source, garageName:lower())
    if creationLocks[key] then
        return false -- Lock already exists
    end

    creationLocks[key] = GetGameTimer()

    -- Auto-release lock after 15 seconds (optimized timeout)
    SetTimeout(15000, function()
        creationLocks[key] = nil
    end)

    return true
end

local function ReleaseCreationLock(source, garageName)
    local key = ("%s:%s"):format(source, garageName:lower())
    creationLocks[key] = nil
end

-- Server event: Request garage locations for client-side markers
RegisterServerEvent('dusa-garage:server:requestGarageLocations', function()
    local source = source
    LogDebug(("Player %s requested garage locations"):format(source), "api")

    local garageLocations = GarageManager.GetAllGarageLocations()
    TriggerClientEvent('dusa-garage:client:receiveGarageLocations', source, garageLocations)
end)

-- ============================
-- JOB VEHICLE API ENDPOINTS (Story 1.3B)
-- ============================

-- Load job vehicle managers
local JobVehicleManager = require('server.core.modules.job_vehicles')
local GradeValidator = require('server.core.modules.grade_validator')
local VehicleOwnership = require('server.core.modules.vehicle_ownership')
local ConfigManager = require('server.core.modules.config_manager')

-- Server event: Get garage data and player vehicles
RegisterServerEvent('dusa-garage:server:getGarageData', function(garageId)
    local source = source

    if not garageId then
        LogDebug(("Invalid garage ID from player %s"):format(source), "validation")
        return
    end

    if IsRateLimited(source, 'getGarageData') then
        SendNotification(source, 'Please wait before requesting garage data again', 'error')
        return
    end

    LogDebug(("Player %s requested garage data for garage ID: %s"):format(source, garageId), "api")

    -- Get player identifier through bridge
    local playerData = Framework.GetPlayer(source)
    if not playerData or not playerData.Identifier then
        LogDebug(("Could not get player data for source: %s"):format(source), "api")
        SendNotification(source, 'Player data not available', 'error')
        return
    end

    -- Get garage data
    local garage, garageError = GarageManager.GetGarage(garageId)
    if not garage then
        LogDebug(("Garage not found for ID %s: %s"):format(garageId, garageError or "Unknown error"), "database")
        SendNotification(source, 'Garage not found', 'error')
        return
    end

    -- Validate garage access permissions
    local accessAllowed, accessError = GarageManager.ValidateGarageAccess(garageId, playerData.Identifier, source)
    if not accessAllowed then
        LogDebug(("Access denied for player %s to garage %s: %s"):format(playerData.Identifier, garageId, accessError), "validation")
        SendNotification(source, accessError or 'Access denied to this garage', 'error')
        return
    end

    -- Check if this is a job garage and use job vehicle UI instead
    if garage.type == 'job' then
        LogDebug(("Job garage detected (ID: %s), redirecting to job vehicle system"):format(garageId), "api")

        -- Get job vehicles for this player with garage vehicle type filter
        local garageVehicleType = garage.vehicleType or 'car'
        LogDebug(("Garage vehicle type extracted from settings: %s (raw settings: %s)"):format(garageVehicleType, json.encode(garage.settings or {})), "api")
        LogDebug(("Calling GetPlayerJobVehicles with garageVehicleType: %s"):format(garageVehicleType), "api")

        local result = JobVehicleManager.GetPlayerJobVehicles(source, garageVehicleType)

        if result.success then
            -- Add garage info to the result
            result.garageId = garageId
            result.garageVehicleType = garageVehicleType
            result.vehicleType = garageVehicleType

            -- Add spawn points to result
            if garage.settings and garage.settings.spawnPoints then
                result.spawnPoints = garage.settings.spawnPoints
                LogDebug(("Added %d spawn points to job garage result (garageId: %s)"):format(#garage.settings.spawnPoints, garageId), "api")
                LogDebug(("Spawn points being sent: %s"):format(json.encode(garage.settings.spawnPoints)), "api")
            else
                LogDebug(("WARNING: No spawn points found in garage settings! (garageId: %s, settings: %s)"):format(garageId, json.encode(garage.settings or {})), "api")
            end

            -- Add locations to result (for fallback spawn)
            if garage.locations then
                result.locations = garage.locations
                LogDebug(("Added locations to job garage result (garageId: %s)"):format(garageId), "api")
            end

            LogDebug(("Sending %d job vehicles to player %s for job garage %s (type: %s)"):format(#result.vehicles, source, garageId, result.vehicleType), "api")
            LogDebug(("Vehicle list being sent: %s"):format(json.encode(result.vehicles or {})), "api")

            LogDebug(("[ÖNEMLİ] Final result being sent: %s"):format(json.encode(result, {indent = true})), "api")
            TriggerClientEvent('dusa-garage:client:receiveJobVehicles', source, result)
        else
            LogDebug(("Failed to get job vehicles for player %s: %s"):format(source, result.error), "api")
            SendNotification(source, result.error or 'Could not load job vehicles', 'error')
        end
        return
    end

    -- Regular garage flow - Get player vehicles
    local vehicles, vehicleError = GarageManager.GetPlayerVehicles(playerData.Identifier, source)
    if vehicleError then
        LogDebug(("Error getting vehicles for player %s: %s"):format(playerData.Identifier, vehicleError), "database")
        SendNotification(source, 'Could not load vehicle data', 'error')
        return
    end

    -- Get garage vehicle type for filtering
    local garageVehicleType = garage.vehicleType or 'car'
    LogDebug(("Garage vehicle type filter: %s"):format(garageVehicleType), "api")

    -- Format vehicles for NUI
    local formattedVehicles = {}
    for _, vehicle in ipairs(vehicles) do
        local vehicleProps = GetVehicleProps(vehicle)
        local modelName = "Unknown"

        -- Try to get model name from vehicle properties
        local props = nil
        if vehicleProps then
            if type(vehicleProps) == "string" then
                local success, decoded = pcall(json.decode, vehicleProps)
                if success and decoded and type(decoded) == "table" then
                    props = decoded
                end
            elseif type(vehicleProps) == "table" then
                props = vehicleProps
            end
        end

        -- Filter by vehicle type if props.model exists
        if props and props.model then
            -- Get vehicle class from client
            local vehicleClass = lib.callback.await('dusa-garage:client:getVehicleType', source, props.model)

            -- Mapping: car = classes 0,1,2,3,4,5,6,7,8,9,10,11,12,17,18,19,20 (most vehicles)
            -- boat = class 14
            -- aircraft = classes 15 (helicopters), 16 (planes)
            local matchesGarageType = false

            if garageVehicleType == 'boat' then
                matchesGarageType = (vehicleClass == 14) -- Boats
            elseif garageVehicleType == 'aircraft' then
                matchesGarageType = (vehicleClass == 15 or vehicleClass == 16) -- Helicopters or Planes
            else
                -- For car garages: exclude boats (14) and aircraft (15, 16)
                matchesGarageType = (vehicleClass ~= 14 and vehicleClass ~= 15 and vehicleClass ~= 16)
            end

            if not matchesGarageType then
                LogDebug(("Vehicle %s filtered out - class %s doesn't match garage type %s"):format(vehicle.plate, tostring(vehicleClass), garageVehicleType), "api")
                goto continue
            end
        end

        -- Debug: Log color1 and color2 values
        if props then
            LogDebug(("Vehicle %s properties - color1: %s, color2: %s"):format(
                vehicle.plate,
                tostring(props.color1 or "nil"),
                tostring(props.color2 or "nil")
            ), "vehicle-colors")
        end

        if props and props.model then
            -- Use client callback to get display name (client-side native)
            local success, result = pcall(function()
                return lib.callback.await('dusa-garage:client:getVehicleDisplayName', source, props.model)
            end)

            if success and result then
                modelName = result
            else
                modelName = "Unknown"
            end
        end

        -- Check if vehicle is in parking zone (only for outside vehicles)
        local inParkingZone = false
        if not vehicle.stored then
            -- Get vehicle coordinates from client
            local vehicleCoords = lib.callback.await('garage:client:getVehicleCoords', source, vehicle.plate)
            if vehicleCoords and garage.locations and garage.locations.parking then
                local minDistance = 20.0 -- Maximum distance to consider "in parking zone"

                -- Handle both single parking point and array of parking points
                local parkingPoints = {}
                if garage.locations.parking.x and garage.locations.parking.y and garage.locations.parking.z then
                    parkingPoints = {garage.locations.parking}
                else
                    parkingPoints = garage.locations.parking
                end

                for _, parkingPoint in ipairs(parkingPoints) do
                    local distance = #(vehicleCoords - vector3(parkingPoint.x, parkingPoint.y, parkingPoint.z))
                    if distance <= minDistance then
                        inParkingZone = true
                        break
                    end
                end
            end
        end

        -- Check if vehicle is impounded
        -- Check both impound_type from JOIN and garage column for "impound"
        -- Note: vehicle.garage comes from v.* in SELECT, check it directly
        local isImpounded = (vehicle.impound_type and vehicle.impound_type ~= "") or 
                           (vehicle.garage and type(vehicle.garage) == "string" and vehicle.garage:lower() == "impound") or
                           (vehicle.garage_location and type(vehicle.garage_location) == "string" and vehicle.garage_location:lower() == "impound")
        
        -- Debug: Log impound check for EVERY vehicle
        LogDebug(("Vehicle %s impound check: impound_type=%s, garage=%s, garage_location=%s, isImpounded=%s"):format(
            vehicle.plate,
            tostring(vehicle.impound_type or "nil"),
            tostring(vehicle.garage or "nil"),
            tostring(vehicle.garage_location or "nil"),
            tostring(isImpounded)
        ), "api")
        
        -- If vehicle is impounded but no JOIN data, fetch impound info from database
        local impoundType = vehicle.impound_type
        local impoundReason = vehicle.impound_reason
        local impoundReleaseAt = vehicle.impound_release_at
        local impoundDurationHours = vehicle.impound_duration_hours
        local impoundReleaseFee = vehicle.impound_release_fee
        
        -- Debug: Log JOIN values before fallback fetch (for ALL vehicles, not just impounded)
        if isImpounded then
            LogDebug(("JOIN Values for IMPOUNDED %s: impoundType=%s, impoundReason=%s, impoundReleaseFee=%s (type: %s)"):format(
                vehicle.plate,
                tostring(impoundType or "nil"),
                tostring(impoundReason or "nil"),
                tostring(impoundReleaseFee or "nil"),
                type(impoundReleaseFee)
            ), "api")
        end
        
        -- Check if impound info is missing from JOIN (even if impoundType exists, other fields might be nil)
        -- Always fetch from database if vehicle is impounded to ensure we have the latest data
        local needsFetch = isImpounded
        
        if needsFetch then
            -- Debug: Check if any impound record exists for this plate (regardless of is_released)
            local debugAllImpounds = MySQL.query.await(
                'SELECT plate, impound_type, is_released FROM dusa_vehicle_impounds WHERE UPPER(plate) = UPPER(?) ORDER BY impounded_at DESC LIMIT 5',
                {vehicle.plate}
            )
            if debugAllImpounds and #debugAllImpounds > 0 then
                LogDebug(("DEBUG: Found %d impound records for plate %s (checking is_released status):"):format(#debugAllImpounds, vehicle.plate), "api")
                for i, rec in ipairs(debugAllImpounds) do
                    LogDebug(("  Record %d: plate=%s, type=%s, is_released=%s (type: %s)"):format(
                        i,
                        tostring(rec.plate or "nil"),
                        tostring(rec.impound_type or "nil"),
                        tostring(rec.is_released),
                        type(rec.is_released)
                    ), "api")
                end
            else
                LogDebug(("DEBUG: No impound records found at all for plate %s"):format(vehicle.plate), "api")
            end
            
            -- Fetch impound info from database to ensure we have all data
            -- Note: is_released can be 0, false, or NULL (depending on database type)
            -- MySQL BOOLEAN is stored as TINYINT(1), so 0 = false, 1 = true
            local impoundData = MySQL.single.await(
                'SELECT impound_type, reason, release_at, duration_hours, release_fee, is_released FROM dusa_vehicle_impounds WHERE UPPER(plate) = UPPER(?) AND (is_released = 0 OR is_released = false) ORDER BY impounded_at DESC LIMIT 1',
                {vehicle.plate}
            )
            if impoundData then
                LogDebug(("Fetched impound data for %s: type=%s, reason=%s, fee=%s, is_released=%s"):format(
                    vehicle.plate,
                    tostring(impoundData.impound_type or "nil"),
                    tostring(impoundData.reason or "nil"),
                    tostring(impoundData.release_fee or "nil"),
                    tostring(impoundData.is_released)
                ), "api")
                
                impoundType = impoundData.impound_type or impoundType
                impoundReason = impoundData.reason or impoundReason
                impoundReleaseAt = impoundData.release_at or impoundReleaseAt
                impoundDurationHours = impoundData.duration_hours or impoundDurationHours
                -- Convert release_fee to number if it's a string or ensure it's properly typed
                local fee = impoundData.release_fee
                if fee ~= nil then
                    if type(fee) == "string" then
                        impoundReleaseFee = tonumber(fee) or nil
                    elseif type(fee) == "number" then
                        impoundReleaseFee = fee
                    else
                        -- Try to convert to number if it's a different type
                        impoundReleaseFee = tonumber(tostring(fee)) or nil
                    end
                end
            else
                LogDebug(("No active impound data found in database for %s (is_released check failed)"):format(vehicle.plate), "api")
            end
        end
        
        -- Ensure release_fee is a number and not nil if it exists
        if impoundReleaseFee and type(impoundReleaseFee) == "string" then
            impoundReleaseFee = tonumber(impoundReleaseFee)
        end
        
        -- If vehicle is impounded, it should be marked as "stored" (in impound lot)
        -- but the impound flag will take precedence in status calculation
        local vehicleStored = vehicle.stored
        if isImpounded then
            vehicleStored = true  -- Impounded vehicles are stored in impound lot
        end

        -- Build formattedVehicle with all fields
        -- NOTE: FiveM's JSON encoder removes nil values, so we need to explicitly include fields
        -- even if they're nil, or use empty strings/false as placeholders
        local formattedVehicle = {
            plate = vehicle.plate,
            model = modelName,
            stored = vehicleStored,
            fuel = vehicle.health_props and vehicle.health_props.fuel or 100,
            engine = vehicle.health_props and vehicle.health_props.engine or 1000,
            body = vehicle.health_props and vehicle.health_props.body or 1000,
            location = vehicle.garage_location,
            garage = vehicle.garage_location,  -- Story 2.1: Add garage field for transfer feature
            customName = vehicle.custom_name,  -- Custom name from metadata table
            inParkingZone = inParkingZone,  -- Is vehicle in parking zone
            impound = isImpounded,  -- Is vehicle impounded
            mileageKm = vehicle.mileage or 0,  -- Mileage from dusa_vehicle_metadata table
        }
        
        -- Always add impound fields explicitly (use empty string for nil strings, 0 for nil numbers)
        -- This ensures they're included in JSON even when nil
        if isImpounded then
            formattedVehicle.impoundType = impoundType or ""
            formattedVehicle.impoundReason = impoundReason or ""
            formattedVehicle.impoundReleaseAt = impoundReleaseAt or ""
            formattedVehicle.impoundDurationHours = impoundDurationHours or 0
            formattedVehicle.impoundReleaseFee = impoundReleaseFee or 0
        else
            -- Not impounded, set to empty/null values
            formattedVehicle.impoundType = ""
            formattedVehicle.impoundReason = ""
            formattedVehicle.impoundReleaseAt = ""
            formattedVehicle.impoundDurationHours = 0
            formattedVehicle.impoundReleaseFee = 0
        end

        -- Debug: Log vehicle garage location and impound info with detailed values
        if isImpounded then
            LogDebug(("=== IMPOUND DEBUG for %s === isImpounded=%s, impoundType=%s (raw=%s), impoundReason=%s (raw=%s), impoundFee=%s (raw=%s, type=%s)"):format(
                vehicle.plate,
                tostring(isImpounded),
                tostring(impoundType or "nil"),
                tostring(vehicle.impound_type or "nil"),
                tostring(impoundReason or "nil"),
                tostring(vehicle.impound_reason or "nil"),
                tostring(impoundReleaseFee or "nil"),
                tostring(vehicle.impound_release_fee or "nil"),
                type(vehicle.impound_release_fee)
            ), "api")
            LogDebug(("FormattedVehicle impound fields: impound=%s, impoundType=%s, impoundReason=%s, impoundReleaseFee=%s"):format(
                tostring(formattedVehicle.impound),
                tostring(formattedVehicle.impoundType or "nil"),
                tostring(formattedVehicle.impoundReason or "nil"),
                tostring(formattedVehicle.impoundReleaseFee or "nil")
            ), "api")
        end
        
        LogDebug(("Vehicle %s: stored=%s, garage=%s, garage_col=%s, isImpounded=%s, current_garage=%s, isRemote=%s, inParkingZone=%s"):format(
            vehicle.plate,
            tostring(vehicleStored),
            vehicle.garage_location or "nil",
            tostring(vehicle.garage or "nil"),
            tostring(isImpounded),
            garageId,
            tostring(vehicle.garage_location ~= garageId),
            tostring(inParkingZone)
        ), "api")

        table.insert(formattedVehicles, formattedVehicle)

        ::continue:: -- Label for goto continue
    end

    LogDebug(("Sending garage data to player %s: %d vehicles (filtered by type: %s)"):format(source, #formattedVehicles, garageVehicleType), "api")

    -- Send data to client with config values (Story 2.1: Include transferFee from Config.Prices)
    local transferConfig = Config.Prices and Config.Prices.vehicleTransfer
    local garageConfig = {
        transferFee = (transferConfig and transferConfig.flatFee) or 5000,  -- Flat fee
        feeType = (transferConfig and transferConfig.feeType) or "flat",    -- Fee type: "flat" or "distance"
        distanceMultiplier = (transferConfig and transferConfig.distanceMultiplier) or 0.5  -- Distance multiplier
    }
    TriggerClientEvent('dusa-garage:client:openGarage', source, garage, formattedVehicles, garageConfig)
end)

-- Server event: Store vehicle in garage
RegisterServerEvent('dusa-garage:server:storeVehicle', function(plate, garageId)
    local source = source

    if not plate or not garageId then
        LogDebug(("Invalid parameters from player %s for storeVehicle"):format(source), "validation")
        return
    end

    if IsRateLimited(source, 'storeVehicle') then
        SendNotification(source, 'Please wait before storing another vehicle', 'error')
        return
    end

    LogDebug(("Player %s wants to store vehicle %s in garage %s"):format(source, plate, garageId), "vehicle-operations")

    -- Store vehicle
    local success, message = GarageManager.StoreVehicle(source, plate, garageId)

    if success then
        SendNotification(source, message, 'success')
        LogDebug(("Vehicle %s stored successfully for player %s"):format(plate, source), "vehicle-operations")

        -- Update garage data for client
        local playerData = Framework.GetPlayer(source)
        if playerData and playerData.Identifier then
            -- Get garage data for parking zone check
            local garage, _ = GarageManager.GetGarage(garageId)

            local vehicles, _ = GarageManager.GetPlayerVehicles(playerData.Identifier, source)
            if vehicles then
                -- Format vehicles for NUI (same as getGarageData)
                local formattedVehicles = {}
                for _, vehicle in ipairs(vehicles) do
                    local vehicleProps = GetVehicleProps(vehicle)
                    local modelName = "Unknown"

                    local props = nil
                    if vehicleProps then
                        if type(vehicleProps) == "string" then
                            -- Decode JSON string to table
                            local success, decoded = pcall(json.decode, vehicleProps)
                            if success and decoded and type(decoded) == "table" then
                                props = decoded
                            end
                        elseif type(vehicleProps) == "table" then
                            -- Already a table, use directly
                            props = vehicleProps
                        end
                    end

                    -- Debug: Log color1 and color2 values
                    if props then
                        LogDebug(("Vehicle %s properties - color1: %s, color2: %s"):format(
                            vehicle.plate,
                            tostring(props.color1 or "nil"),
                            tostring(props.color2 or "nil")
                        ), "vehicle-colors")
                    end

                    if props and props.model then
                        -- Use client callback to get display name (client-side native)
                        local success, result = pcall(function()
                            return lib.callback.await('dusa-garage:client:getVehicleDisplayName', source, props.model)
                        end)

                        if success and result then
                            modelName = result
                        else
                            modelName = "Unknown"
                        end
                    end

                    -- Check if vehicle is in parking zone (only for outside vehicles)
                    local inParkingZone = false
                    if not vehicle.stored and garage and garage.locations and garage.locations.parking then
                        -- Get vehicle coordinates from client
                        local vehicleCoords = lib.callback.await('garage:client:getVehicleCoords', source, vehicle.plate)
                        if vehicleCoords then
                            local minDistance = 20.0 -- Maximum distance to consider "in parking zone"

                            -- Handle both single parking point and array of parking points
                            local parkingPoints = {}
                            if garage.locations.parking.x and garage.locations.parking.y and garage.locations.parking.z then
                                parkingPoints = {garage.locations.parking}
                            else
                                parkingPoints = garage.locations.parking
                            end

                            for _, parkingPoint in ipairs(parkingPoints) do
                                local distance = #(vehicleCoords - vector3(parkingPoint.x, parkingPoint.y, parkingPoint.z))
                                if distance <= minDistance then
                                    inParkingZone = true
                                    break
                                end
                            end
                        end
                    end

                    -- Check if vehicle is impounded
                    local isImpounded = (vehicle.impound_type and vehicle.impound_type ~= "") or 
                                       (vehicle.garage and type(vehicle.garage) == "string" and vehicle.garage:lower() == "impound") or
                                       (vehicle.garage_location and type(vehicle.garage_location) == "string" and vehicle.garage_location:lower() == "impound")
                    
                    -- If vehicle is impounded but no JOIN data, fetch impound info from database
                    local impoundType = vehicle.impound_type
                    local impoundReason = vehicle.impound_reason
                    local impoundReleaseAt = vehicle.impound_release_at
                    local impoundDurationHours = vehicle.impound_duration_hours
                    local impoundReleaseFee = vehicle.impound_release_fee
                    
                    if isImpounded and (not impoundType or impoundType == "") then
                        -- Fetch impound info from database if not available from JOIN
                        local impoundData = MySQL.single.await(
                            'SELECT impound_type, reason, release_at, duration_hours, release_fee FROM dusa_vehicle_impounds WHERE plate = ? AND is_released = 0 ORDER BY impounded_at DESC LIMIT 1',
                            {vehicle.plate}
                        )
                        if impoundData then
                            impoundType = impoundData.impound_type
                            impoundReason = impoundData.reason
                            impoundReleaseAt = impoundData.release_at
                            impoundDurationHours = impoundData.duration_hours
                            impoundReleaseFee = impoundData.release_fee
                        end
                    end
                    
                    -- If vehicle is impounded, it should be marked as "stored" (in impound lot)
                    local vehicleStored = vehicle.stored
                    if isImpounded then
                        vehicleStored = true  -- Impounded vehicles are stored in impound lot
                    end

                    table.insert(formattedVehicles, {
                        plate = vehicle.plate,
                        model = modelName,
                        stored = vehicleStored,
                        fuel = vehicle.health_props and vehicle.health_props.fuel or 100,
                        engine = vehicle.health_props and vehicle.health_props.engine or 1000,
                        body = vehicle.health_props and vehicle.health_props.body or 1000,
                        location = vehicle.garage_location,
                        garage = vehicle.garage_location,  -- Story 2.1: Add garage field for transfer feature
                        customName = vehicle.custom_name,  -- Custom name for vehicle
                        inParkingZone = inParkingZone,  -- Is vehicle in parking zone
                        impound = isImpounded,  -- Is vehicle impounded
                        -- Always include impound fields (will be nil/null if not impounded, but field exists)
                        impoundType = impoundType,
                        impoundReason = impoundReason,
                        impoundReleaseAt = impoundReleaseAt,
                        impoundDurationHours = impoundDurationHours,
                        impoundReleaseFee = impoundReleaseFee
                    })
                end

                TriggerClientEvent('dusa-garage:client:updateGarageData', source, formattedVehicles)
            end
        end
    else
        SendNotification(source, message, 'error')
        LogDebug(("Failed to store vehicle %s for player %s: %s"):format(plate, source, message), "vehicle-operations")
    end
end)

-- Server event: Spawn vehicle from garage
RegisterServerEvent('dusa-garage:server:spawnVehicle', function(plate, garageId)
    local source = source

    if not plate or not garageId then
        LogDebug(("Invalid parameters from player %s for spawnVehicle"):format(source), "validation")
        return
    end

    if IsRateLimited(source, 'spawnVehicle') then
        SendNotification(source, 'Please wait before spawning another vehicle', 'error')
        return
    end

    LogDebug(("Player %s wants to spawn vehicle %s from garage %s"):format(source, plate, garageId), "vehicle-operations")

    -- Spawn vehicle
    local success, message = GarageManager.SpawnVehicle(source, plate, garageId, true)

    -- If spawn failed, send error notification and return
    if not success then
        SendNotification(source, message, 'error')
        LogDebug(("Failed to spawn vehicle %s for player %s: %s"):format(plate, source, message), "vehicle-operations")
        return
    end

    -- Spawn succeeded, send success notification
    SendNotification(source, message, 'success')
    LogDebug(("Vehicle %s spawned successfully for player %s"):format(plate, source), "vehicle-operations")

    -- Update garage data for client
    local playerData = Framework.GetPlayer(source)
    if playerData and playerData.Identifier then
        -- Get garage data for parking zone check
        local garage, _ = GarageManager.GetGarage(garageId)

            local vehicles, _ = GarageManager.GetPlayerVehicles(playerData.Identifier, source)
            if vehicles then
                -- Format vehicles for NUI (same as getGarageData)
                local formattedVehicles = {}
                for _, vehicle in ipairs(vehicles) do
                    local vehicleProps = GetVehicleProps(vehicle)
                    local modelName = "Unknown"

                    local props = nil
                    if vehicleProps then
                        if type(vehicleProps) == "string" then
                            -- Decode JSON string to table
                            local success, decoded = pcall(json.decode, vehicleProps)
                            if success and decoded and type(decoded) == "table" then
                                props = decoded
                            end
                        elseif type(vehicleProps) == "table" then
                            -- Already a table, use directly
                            props = vehicleProps
                        end
                    end

                    -- Debug: Log color1 and color2 values
                    if props then
                        LogDebug(("Vehicle %s properties - color1: %s, color2: %s"):format(
                            vehicle.plate,
                            tostring(props.color1 or "nil"),
                            tostring(props.color2 or "nil")
                        ), "vehicle-colors")
                    end

                    if props and props.model then
                        -- Use client callback to get display name (client-side native)
                        local success, result = pcall(function()
                            return lib.callback.await('dusa-garage:client:getVehicleDisplayName', source, props.model)
                        end)

                        if success and result then
                            modelName = result
                        else
                            modelName = "Unknown"
                        end
                    end

                    -- Check if vehicle is in parking zone (only for outside vehicles)
                    local inParkingZone = false
                    if not vehicle.stored and garage and garage.locations and garage.locations.parking then
                        -- Get vehicle coordinates from client
                        local vehicleCoords = lib.callback.await('garage:client:getVehicleCoords', source, vehicle.plate)
                        if vehicleCoords then
                            local minDistance = 20.0 -- Maximum distance to consider "in parking zone"

                            -- Handle both single parking point and array of parking points
                            local parkingPoints = {}
                            if garage.locations.parking.x and garage.locations.parking.y and garage.locations.parking.z then
                                parkingPoints = {garage.locations.parking}
                            else
                                parkingPoints = garage.locations.parking
                            end

                            for _, parkingPoint in ipairs(parkingPoints) do
                                local distance = #(vehicleCoords - vector3(parkingPoint.x, parkingPoint.y, parkingPoint.z))
                                if distance <= minDistance then
                                    inParkingZone = true
                                    break
                                end
                            end
                        end
                    end

                    -- Check if vehicle is impounded
                    local isImpounded = (vehicle.impound_type and vehicle.impound_type ~= "") or 
                                       (vehicle.garage and type(vehicle.garage) == "string" and vehicle.garage:lower() == "impound") or
                                       (vehicle.garage_location and type(vehicle.garage_location) == "string" and vehicle.garage_location:lower() == "impound")
                    
                    -- If vehicle is impounded but no JOIN data, fetch impound info from database
                    local impoundType = vehicle.impound_type
                    local impoundReason = vehicle.impound_reason
                    local impoundReleaseAt = vehicle.impound_release_at
                    local impoundDurationHours = vehicle.impound_duration_hours
                    local impoundReleaseFee = vehicle.impound_release_fee
                    
                    if isImpounded and (not impoundType or impoundType == "") then
                        -- Fetch impound info from database if not available from JOIN
                        local impoundData = MySQL.single.await(
                            'SELECT impound_type, reason, release_at, duration_hours, release_fee FROM dusa_vehicle_impounds WHERE plate = ? AND is_released = 0 ORDER BY impounded_at DESC LIMIT 1',
                            {vehicle.plate}
                        )
                        if impoundData then
                            impoundType = impoundData.impound_type
                            impoundReason = impoundData.reason
                            impoundReleaseAt = impoundData.release_at
                            impoundDurationHours = impoundData.duration_hours
                            impoundReleaseFee = impoundData.release_fee
                        end
                    end
                    
                    -- If vehicle is impounded, it should be marked as "stored" (in impound lot)
                    local vehicleStored = vehicle.stored
                    if isImpounded then
                        vehicleStored = true  -- Impounded vehicles are stored in impound lot
                    end

                    table.insert(formattedVehicles, {
                        plate = vehicle.plate,
                        model = modelName,
                        stored = vehicleStored,
                        fuel = vehicle.health_props and vehicle.health_props.fuel or 100,
                        engine = vehicle.health_props and vehicle.health_props.engine or 1000,
                        body = vehicle.health_props and vehicle.health_props.body or 1000,
                        location = vehicle.garage_location,
                        garage = vehicle.garage_location,  -- Story 2.1: Add garage field for transfer feature
                        customName = vehicle.custom_name,  -- Custom name for vehicle
                        inParkingZone = inParkingZone,  -- Is vehicle in parking zone
                        impound = isImpounded,  -- Is vehicle impounded
                        -- Always include impound fields (will be nil/null if not impounded, but field exists)
                        impoundType = impoundType,
                        impoundReason = impoundReason,
                        impoundReleaseAt = impoundReleaseAt,
                        impoundDurationHours = impoundDurationHours,
                        impoundReleaseFee = impoundReleaseFee
                    })
                end

                TriggerClientEvent('dusa-garage:client:updateGarageData', source, formattedVehicles)
            end
        end
end)

print('^1 SERVER API SV_API LOADED ^0')
-- Server Callbacks using ox_lib
lib.callback.register('dusa-garage:server:storeVehicle', function(source, plate, garageId)
    if not plate or not garageId then
        LogDebug(("Invalid parameters from player %s for storeVehicle"):format(source), "validation")
        return { success = false, message = 'Invalid parameters' }
    end

    if IsRateLimited(source, 'storeVehicle') then
        return { success = false, message = 'Please wait before storing another vehicle' }
    end

    LogDebug(("Player %s wants to store vehicle %s in garage %s"):format(source, plate, garageId), "vehicle-operations")

    -- Get vehicle coordinates from client first
    local vehicleCoords = lib.callback.await('garage:client:getVehicleCoords', source, plate)
    if not vehicleCoords then
        return { success = false, message = 'Vehicle not found or not accessible' }
    end

    local success, message = GarageManager.StoreVehicle(source, plate, garageId, vehicleCoords)

    if success then
        LogDebug(("Vehicle %s stored successfully for player %s"):format(plate, source), "vehicle-operations")
        -- Trigger client update
        TriggerClientEvent('dusa-garage:client:vehicleStored', source, plate)
    else
        LogDebug(("Failed to store vehicle %s for player %s: %s"):format(plate, source, message), "vehicle-operations")
    end

    return { success = success, message = message }
end)

lib.callback.register('dusa-garage:server:spawnVehicle', function(source, plate, garageId)
    if not plate or not garageId then
        LogDebug(("Invalid parameters from player %s for spawnVehicle"):format(source), "validation")
        return { success = false, message = 'Invalid parameters' }
    end

    if IsRateLimited(source, 'spawnVehicle') then
        return { success = false, message = 'Please wait before spawning another vehicle' }
    end

    LogDebug(("Player %s wants to spawn vehicle %s from garage %s"):format(source, plate, garageId), "vehicle-operations")
    local success, message, netId = GarageManager.SpawnVehicle(source, plate, garageId, true)

    if success then
        SendNotification(source, message, 'success')
        LogDebug(("Vehicle %s spawned successfully for player %s (netId: %s)"):format(plate, source, netId or "nil"), "vehicle-operations")
        -- Trigger client update with netId for teleport
        TriggerClientEvent('dusa-garage:client:vehicleSpawned', source, plate, netId)
    else
        SendNotification(source, message, 'error')
        LogDebug(("Failed to spawn vehicle %s for player %s: %s"):format(plate, source, message), "vehicle-operations")
    end

    return { success = success, message = message, netId = netId }
end)

lib.callback.register('dusa-garage:server:getGarageData', function(source, garageId)
    if not garageId then
        LogDebug(("Invalid garage ID from player %s"):format(source), "validation")
        return { success = false, message = 'Invalid garage ID' }
    end

    if IsRateLimited(source, 'getGarageData') then
        return { success = false, message = 'Please wait before requesting garage data again' }
    end

    LogDebug(("Player %s requested garage data for garage ID: %s"):format(source, garageId), "api")

    -- Get player identifier through bridge
    local playerData = Framework.GetPlayer(source)
    if not playerData or not playerData.Identifier then
        LogDebug(("Could not get player data for source: %s"):format(source), "api")
        return { success = false, message = 'Player data not available' }
    end


    -- Get garage data
    local garage, garageError = GarageManager.GetGarage(garageId)
    if not garage then
        LogDebug(("Garage not found for ID %s: %s"):format(garageId, garageError or "Unknown error"), "database")
        return { success = false, message = 'Garage not found' }
    end

    -- Validate garage access permissions
    local accessAllowed, accessError = GarageManager.ValidateGarageAccess(garageId, playerData.Identifier, source)
    if not accessAllowed then
        LogDebug(("Access denied for player %s to garage %s: %s"):format(playerData.Identifier, garageId, accessError), "validation")
        return { success = false, message = accessError or 'Access denied to this garage' }
    end

    -- Get player vehicles
    local vehicles, vehicleError = GarageManager.GetPlayerVehicles(playerData.Identifier, source)
    if vehicleError then
        LogDebug(("Error getting vehicles for player %s: %s"):format(playerData.Identifier, vehicleError), "database")
        return { success = false, message = 'Could not load vehicle data' }
    end

    -- Format vehicles for NUI
    local formattedVehicles = {}
    for _, vehicle in ipairs(vehicles) do
        local vehicleProps = GetVehicleProps(vehicle)
        local modelName = "Unknown"

        -- Try to get model name from vehicle properties
        local props = nil
        if vehicleProps then
            if type(vehicleProps) == "string" then
                -- Decode JSON string to table
                local success, decoded = pcall(json.decode, vehicleProps)
                if success and decoded and type(decoded) == "table" then
                    props = decoded
                end
            elseif type(vehicleProps) == "table" then
                -- Already a table, use directly
                props = vehicleProps
            end
        end

        -- Debug: Log color1 and color2 values
        if props then
            LogDebug(("Vehicle %s properties - color1: %s, color2: %s"):format(
                vehicle.plate,
                tostring(props.color1 or "nil"),
                tostring(props.color2 or "nil")
            ), "vehicle-colors")
        end

        if props and props.model then
            -- Use client callback to get display name (client-side native)
            local callbackSuccess, callbackResult = pcall(function()
                return lib.callback.await('dusa-garage:client:getVehicleDisplayName', source, props.model)
            end)

            if callbackSuccess and callbackResult then
                modelName = callbackResult
            else
                modelName = "Unknown"
            end
        end

        -- Check if vehicle is in parking zone (only for outside vehicles)
        local inParkingZone = false
        if not vehicle.stored then
            -- Get vehicle coordinates from client
            local vehicleCoords = lib.callback.await('garage:client:getVehicleCoords', source, vehicle.plate)
            if vehicleCoords and garage.locations and garage.locations.parking then
                local minDistance = 20.0 -- Maximum distance to consider "in parking zone"

                -- Handle both single parking point and array of parking points
                local parkingPoints = {}
                if garage.locations.parking.x and garage.locations.parking.y and garage.locations.parking.z then
                    parkingPoints = {garage.locations.parking}
                else
                    parkingPoints = garage.locations.parking
                end

                for _, parkingPoint in ipairs(parkingPoints) do
                    local distance = #(vehicleCoords - vector3(parkingPoint.x, parkingPoint.y, parkingPoint.z))
                    if distance <= minDistance then
                        inParkingZone = true
                        break
                    end
                end
            end
        end

        -- Check if vehicle is impounded
        -- Check both impound_type from JOIN and garage column for "impound"
        -- Note: vehicle.garage comes from v.* in SELECT, check it directly
        local isImpounded = (vehicle.impound_type and vehicle.impound_type ~= "") or 
                           (vehicle.garage and type(vehicle.garage) == "string" and vehicle.garage:lower() == "impound") or
                           (vehicle.garage_location and type(vehicle.garage_location) == "string" and vehicle.garage_location:lower() == "impound")
        
        -- Debug: Log impound check for EVERY vehicle
        LogDebug(("Vehicle %s impound check: impound_type=%s, garage=%s, garage_location=%s, isImpounded=%s"):format(
            vehicle.plate,
            tostring(vehicle.impound_type or "nil"),
            tostring(vehicle.garage or "nil"),
            tostring(vehicle.garage_location or "nil"),
            tostring(isImpounded)
        ), "api")
        
        -- If vehicle is impounded but no JOIN data, fetch impound info from database
        local impoundType = vehicle.impound_type
        local impoundReason = vehicle.impound_reason
        local impoundReleaseAt = vehicle.impound_release_at
        local impoundDurationHours = vehicle.impound_duration_hours
        local impoundReleaseFee = vehicle.impound_release_fee
        
        -- Debug: Log JOIN values before fallback fetch (for ALL vehicles, not just impounded)
        if isImpounded then
            LogDebug(("JOIN Values for IMPOUNDED %s: impoundType=%s, impoundReason=%s, impoundReleaseFee=%s (type: %s)"):format(
                vehicle.plate,
                tostring(impoundType or "nil"),
                tostring(impoundReason or "nil"),
                tostring(impoundReleaseFee or "nil"),
                type(impoundReleaseFee)
            ), "api")
        end
        
        -- Check if impound info is missing from JOIN (even if impoundType exists, other fields might be nil)
        -- Always fetch from database if vehicle is impounded to ensure we have the latest data
        local needsFetch = isImpounded
        
        if needsFetch then
            -- Debug: Check if any impound record exists for this plate (regardless of is_released)
            local debugAllImpounds = MySQL.query.await(
                'SELECT plate, impound_type, is_released FROM dusa_vehicle_impounds WHERE UPPER(plate) = UPPER(?) ORDER BY impounded_at DESC LIMIT 5',
                {vehicle.plate}
            )
            if debugAllImpounds and #debugAllImpounds > 0 then
                LogDebug(("DEBUG: Found %d impound records for plate %s (checking is_released status):"):format(#debugAllImpounds, vehicle.plate), "api")
                for i, rec in ipairs(debugAllImpounds) do
                    LogDebug(("  Record %d: plate=%s, type=%s, is_released=%s (type: %s)"):format(
                        i,
                        tostring(rec.plate or "nil"),
                        tostring(rec.impound_type or "nil"),
                        tostring(rec.is_released),
                        type(rec.is_released)
                    ), "api")
                end
            else
                LogDebug(("DEBUG: No impound records found at all for plate %s"):format(vehicle.plate), "api")
            end
            
            -- Fetch impound info from database to ensure we have all data
            -- Note: is_released can be 0, false, or NULL (depending on database type)
            -- MySQL BOOLEAN is stored as TINYINT(1), so 0 = false, 1 = true
            local impoundData = MySQL.single.await(
                'SELECT impound_type, reason, release_at, duration_hours, release_fee, is_released FROM dusa_vehicle_impounds WHERE UPPER(plate) = UPPER(?) AND (is_released = 0 OR is_released = false) ORDER BY impounded_at DESC LIMIT 1',
                {vehicle.plate}
            )
            if impoundData then
                LogDebug(("Fetched impound data for %s: type=%s, reason=%s, fee=%s, is_released=%s"):format(
                    vehicle.plate,
                    tostring(impoundData.impound_type or "nil"),
                    tostring(impoundData.reason or "nil"),
                    tostring(impoundData.release_fee or "nil"),
                    tostring(impoundData.is_released)
                ), "api")
                
                impoundType = impoundData.impound_type or impoundType
                impoundReason = impoundData.reason or impoundReason
                impoundReleaseAt = impoundData.release_at or impoundReleaseAt
                impoundDurationHours = impoundData.duration_hours or impoundDurationHours
                -- Convert release_fee to number if it's a string or ensure it's properly typed
                local fee = impoundData.release_fee
                if fee ~= nil then
                    if type(fee) == "string" then
                        impoundReleaseFee = tonumber(fee) or nil
                    elseif type(fee) == "number" then
                        impoundReleaseFee = fee
                    else
                        -- Try to convert to number if it's a different type
                        impoundReleaseFee = tonumber(tostring(fee)) or nil
                    end
                end
            else
                LogDebug(("No active impound data found in database for %s (is_released check failed)"):format(vehicle.plate), "api")
            end
        end
        
        -- Ensure release_fee is a number and not nil if it exists
        if impoundReleaseFee and type(impoundReleaseFee) == "string" then
            impoundReleaseFee = tonumber(impoundReleaseFee)
        end
        
        -- If vehicle is impounded, it should be marked as "stored" (in impound lot)
        -- but the impound flag will take precedence in status calculation
        local vehicleStored = vehicle.stored
        if isImpounded then
            vehicleStored = true  -- Impounded vehicles are stored in impound lot
        end
        
        table.insert(formattedVehicles, {
            plate = vehicle.plate,
            model = modelName,
            stored = vehicleStored,
            fuel = vehicle.health_props and vehicle.health_props.fuel or 100,
            engine = vehicle.health_props and vehicle.health_props.engine or 1000,
            body = vehicle.health_props and vehicle.health_props.body or 1000,
            location = vehicle.garage_location,
            garage = vehicle.garage_location,  -- Story 2.1: Add garage field for transfer feature
            customName = vehicle.custom_name,  -- Custom name for vehicle
            inParkingZone = inParkingZone,  -- Is vehicle in parking zone
            impound = isImpounded,  -- Is vehicle impounded
            -- Always include impound fields (will be nil/null if not impounded, but field exists)
            impoundType = impoundType,
            impoundReason = impoundReason,
            impoundReleaseAt = impoundReleaseAt,
            impoundDurationHours = impoundDurationHours,
            impoundReleaseFee = impoundReleaseFee
        })
    end

    LogDebug(("Sending garage data to player %s: %d vehicles"):format(source, #formattedVehicles), "api")

    return {
        success = true,
        garageData = garage,
        vehicleData = formattedVehicles
    }
end)

-- Editor API: Get users with access to property garage
lib.callback.register('dusa-garage:editor:getUserAccess', function(source, garageId)
    if not garageId then
        LogDebug(("Invalid garage ID from player %s for getUserAccess"):format(source), "validation")
        return { success = false, message = 'Invalid garage ID' }
    end

    LogDebug(("Player %s requested user access data for garage ID: %s"):format(source, garageId), "user-management")

    local userList, error = GarageManager.GetGarageUsers(garageId)
    if error then
        LogDebug(("Error getting garage users for ID %s: %s"):format(garageId, error), "user-management")
        return { success = false, message = error }
    end

    return {
        success = true,
        users = userList
    }
end)

-- Editor API: Add user access to property garage
lib.callback.register('dusa-garage:editor:addUserAccess', function(source, garageId, playerIdentifier)
    if not garageId or not playerIdentifier then
        LogDebug(("Invalid parameters from player %s for addUserAccess"):format(source), "user-management")
        return { success = false, message = 'Garage ID and player identifier are required' }
    end

    if IsRateLimited(source, 'addUserAccess') then
        return { success = false, message = 'Please wait before adding another user' }
    end

    LogDebug(("Player %s wants to add user %s to garage %s"):format(source, playerIdentifier, garageId), "user-management")

    -- Validate player identifier exists through bridge
    local targetPlayer = nil
    for _, playerId in pairs(GetPlayers()) do
        local playerData = Framework.GetPlayer(tonumber(playerId))
        if playerData and playerData.Identifier == playerIdentifier then
            targetPlayer = playerData
            break
        end
    end

    -- If player not online, we still allow adding them (they might be offline)
    -- The bridge will validate the identifier format

    local success, message = GarageManager.AddUserAccess(garageId, playerIdentifier)

    if success then
        LogDebug(("User %s added to garage %s successfully by player %s"):format(playerIdentifier, garageId, source), "user-management")
    else
        LogDebug(("Failed to add user %s to garage %s by player %s: %s"):format(playerIdentifier, garageId, source, message), "user-management")
    end

    return { success = success, message = message }
end)

-- Editor API: Remove user access from property garage
lib.callback.register('dusa-garage:editor:removeUserAccess', function(source, garageId, playerIdentifier)
    if not garageId or not playerIdentifier then
        LogDebug(("Invalid parameters from player %s for removeUserAccess"):format(source), "user-management")
        return { success = false, message = 'Garage ID and player identifier are required' }
    end

    if IsRateLimited(source, 'removeUserAccess') then
        return { success = false, message = 'Please wait before removing another user' }
    end

    LogDebug(("Player %s wants to remove user %s from garage %s"):format(source, playerIdentifier, garageId), "user-management")

    local success, message = GarageManager.RemoveUserAccess(garageId, playerIdentifier)

    if success then
        LogDebug(("User %s removed from garage %s successfully by player %s"):format(playerIdentifier, garageId, source), "user-management")
    else
        LogDebug(("Failed to remove user %s from garage %s by player %s: %s"):format(playerIdentifier, garageId, source,
            message))
    end

    return { success = success, message = message }
end)

-- Garage Creation API: Create new property garage
lib.callback.register('dusa-garage:server:createGarage', function(source, data)
    LogDebug(("Player %s wants to create garage: %s"):format(source, json.encode(data, { indent = true })), "garage-creation")
    if not data or not data.name or not data.radius then
        LogDebug(("Invalid garage creation parameters from player %s"):format(source), "garage-creation")
        return { success = false, message = 'Missing required garage parameters' }
    end

    -- Check for parkingCenter (admin editor format) or coords (legacy format)
    if not data.parkingCenter and not data.coords then
        LogDebug(("Invalid garage creation parameters from player %s - missing coordinates"):format(source), "garage-creation")
        return { success = false, message = 'Missing required garage parameters (coordinates)' }
    end

    -- Skip rate limit for preset garage creation
    if not data.fromPreset and IsRateLimited(source, 'createGarage') then
        return { success = false, message = 'Please wait before creating another garage' }
    end

    -- Acquire creation lock to prevent duplicates
    if not AcquireCreationLock(source, data.name) then
        LogDebug(("Player %s attempted duplicate garage creation: %s"):format(source, data.name), "garage-creation")
        return { success = false, message = 'Garage creation already in progress' }
    end

    LogDebug(("Player %s wants to create garage: %s"):format(source, data.name), "garage-creation")

    -- Get player identifier through Framework
    local playerData = Framework.GetPlayer(source)
    if not playerData or not playerData.Identifier then
        LogDebug(("Could not get player data for source %s"):format(source), "api")
        ReleaseCreationLock(source, data.name) -- Release lock on error
        return { success = false, message = 'Player data not found' }
    end

    -- Format garage data for creation
    local garageData = {
        name = data.name,
        type = data.type or 'property', -- Support both 'property' and 'job' types
        vehicleType = data.vehicleType or 'car',
        parkingCenter = data.parkingCenter, -- Use parkingCenter for admin editor format
        coords = data.parkingCenter or data.coords, -- Support both formats
        radius = data.radius,
        ownerId = playerData.Identifier,
        allowedPlayers = data.allowedPlayers or {},
        job = data.job, -- Job name for job garages
        spawnPoints = data.spawnPoints -- Spawn points for admin editor format
    }

    -- Create garage through GarageManager
    local success, result = GarageManager.CreateGarage(garageData)

    -- Always release lock after creation attempt
    ReleaseCreationLock(source, data.name)

    if success then
        local garageId = result and result.garageId
        LogDebug(("Garage %s created successfully by player %s with ID %s"):format(data.name, source, garageId or "unknown"), "garage-creation")
        return { success = true, message = result.message or "Garage created successfully", garageId = garageId }
    else
        local errorMessage = result and (result.error or result.message) or "Failed to create garage"
        LogDebug(("Failed to create garage %s by player %s: %s"):format(data.name, source, errorMessage), "garage-creation")
        return { success = false, message = errorMessage }
    end
end)

-- Garage Management API: Get player's property garages
lib.callback.register('dusa-garage:server:getPropertyGarages', function(source)
    LogDebug(("Player %s requesting property garages"):format(source), "garage-creation")

    -- Get player identifier through Framework
    local playerData = Framework.GetPlayer(source)
    if not playerData or not playerData.Identifier then
        LogDebug(("Could not get player data for source %s"):format(source), "api")
        return { success = false, message = 'Player data not found' }
    end

    -- Get property garages through GarageManager
    local success, garages = GarageManager.GetPlayerPropertyGarages(playerData.Identifier)

    if success then
        LogDebug(("Found %d property garages for player %s"):format(#garages, source), "garage-creation")
        return { success = true, garages = garages }
    else
        LogDebug(("Failed to get property garages for player %s"):format(source), "garage-creation")
        return { success = false, message = 'Failed to retrieve property garages' }
    end
end)

-- Vehicle Transfer API: Get all public garages
lib.callback.register('dusa-garage:server:getAllPublicGarages', function(source)
    LogDebug(("Player %s requesting all public garages for transfer"):format(source), "vehicle-transfer")

    local success, result = pcall(function()
        return MySQL.query.await([[
            SELECT id, name, type, locations, settings
            FROM dusa_garages
            WHERE type = 'public'
            ORDER BY name ASC
        ]], {})
    end)

    if not success then
        LogDebug(("Failed to fetch public garages for player %s: %s"):format(source, tostring(result)), "vehicle-transfer")
        return { success = false, error = 'Failed to fetch public garages' }
    end

    local garages = {}
    for _, garage in ipairs(result) do
        local locations = {}
        local settings = {}

        -- Parse JSON fields safely
        if garage.locations then
            local success, parsed = pcall(json.decode, garage.locations)
            if success and type(parsed) == "table" then
                locations = parsed
            end
        end

        if garage.settings then
            local success, parsed = pcall(json.decode, garage.settings)
            if success and type(parsed) == "table" then
                settings = parsed
            end
        end

        -- Extract coords from interaction point (or spawn as fallback)
        local coords = { x = 0, y = 0, z = 0 }
        if locations.interaction then
            coords = {
                x = locations.interaction.x or 0,
                y = locations.interaction.y or 0,
                z = locations.interaction.z or 0,
                w = locations.interaction.w or 0
            }
        elseif locations.spawn then
            if type(locations.spawn) == 'table' and locations.spawn[1] then
                -- Multiple spawn points, use first one
                coords = {
                    x = locations.spawn[1].x or 0,
                    y = locations.spawn[1].y or 0,
                    z = locations.spawn[1].z or 0,
                    w = locations.spawn[1].w or locations.spawn[1].heading or 0
                }
            else
                -- Single spawn point
                coords = {
                    x = locations.spawn.x or 0,
                    y = locations.spawn.y or 0,
                    z = locations.spawn.z or 0,
                    w = locations.spawn.w or 0
                }
            end
        end

        table.insert(garages, {
            id = garage.id,
            name = garage.name,
            type = garage.type or 'public',
            vehicleType = settings.vehicleType or 'car',
            coords = coords,
            radius = locations.interactionRadius or 3.0
        })
    end

    LogDebug(("Returning %d public garages to player %s"):format(#garages, source), "vehicle-transfer")
    return { success = true, garages = garages }
end)

-- Garage Management API: Delete garage
lib.callback.register('dusa-garage:server:deleteGarage', function(source, garageId)
    LogDebug(("Player %s requesting to delete garage %s"):format(source, garageId), "garage-deletion")

    -- Rate limiting check
    if IsRateLimited(source, 'deleteGarage') then
        LogDebug(("Player %s rate limited for deleteGarage operation"):format(source), "api")
        SendNotification(source, 'Too many requests. Please wait before trying again.', 'error')
        return { success = false, message = 'Rate limited' }
    end

    -- Get player identifier through Framework
    local playerData = Framework.GetPlayer(source)
    if not playerData or not playerData.Identifier then
        LogDebug(("Could not get player data for source %s"):format(source), "api")
        return { success = false, message = 'Player data not found' }
    end

    -- Validate input
    if not garageId or type(garageId) ~= 'number' then
        LogDebug(("Invalid garage ID provided by player %s: %s"):format(source, tostring(garageId)), "api")
        return { success = false, message = 'Invalid garage ID' }
    end

    -- Check if player is real estate worker for bypass permissions
    local isRealEstateWorker = false
    if Config.RealEstate and Config.RealEstate.Enabled then
        local playerJob = playerData.Job or {}
        local jobName = playerJob.name or playerJob.Name or ""
        local jobGrade = playerJob.grade or playerJob.Grade.Level or 0

        if Config.RealEstate.Jobs[jobName] then
            local requiredGrade = Config.RealEstate.Jobs[jobName].minGrade or 0
            if jobGrade >= requiredGrade then
                isRealEstateWorker = true
                LogDebug(("Player %s deleting garage %s as real estate worker: job=%s, grade=%s"):format(source, garageId, jobName, jobGrade), "garage-deletion")
            end
        end
    end

    -- Delete garage through GarageManager with real estate bypass flag
    local success, message = GarageManager.DeleteGarage(garageId, playerData.Identifier, isRealEstateWorker)

    if success then
        LogDebug(("Garage %s deleted successfully by player %s"):format(garageId, source), "garage-deletion")
        SendNotification(source, message or 'Garage deleted successfully', 'success')
        return { success = true, message = message }
    else
        LogDebug(("Failed to delete garage %s by player %s: %s"):format(garageId, source, message or 'Unknown error'), "garage-deletion")
        SendNotification(source, message or 'Failed to delete garage', 'error')
        return { success = false, message = message }
    end
end)

-- Garage Management API: Edit garage
lib.callback.register('dusa-garage:server:editGarage', function(source, garageId, updateData)
    LogDebug(("Player %s requesting to edit garage %s"):format(source, garageId), "garage-edit")

    -- Rate limiting check
    if IsRateLimited(source, 'editGarage') then
        LogDebug(("Player %s rate limited for editGarage operation"):format(source), "api")
        SendNotification(source, 'Too many requests. Please wait before trying again.', 'error')
        return { success = false, message = 'Rate limited' }
    end

    -- Get player identifier through Framework
    local playerData = Framework.GetPlayer(source)
    if not playerData or not playerData.Identifier then
        LogDebug(("Could not get player data for source %s"):format(source), "api")
        return { success = false, message = 'Player data not found' }
    end

    -- Validate input
    if not garageId or type(garageId) ~= 'number' then
        LogDebug(("Invalid garage ID provided by player %s: %s"):format(source, tostring(garageId)), "api")
        return { success = false, message = 'Invalid garage ID' }
    end

    if not updateData or type(updateData) ~= 'table' then
        LogDebug(("Invalid update data provided by player %s"):format(source), "api")
        return { success = false, message = 'Invalid update data' }
    end

    -- Check if player is real estate worker for bypass permissions
    local isRealEstateWorker = false
    if Config.RealEstate and Config.RealEstate.Enabled then
        local playerJob = playerData.Job or {}
        local jobName = playerJob.name or playerJob.Name or ""
        local jobGrade = playerJob.grade or playerJob.Grade.Level or 0

        if Config.RealEstate.Jobs[jobName] then
            local requiredGrade = Config.RealEstate.Jobs[jobName].minGrade or 0
            if jobGrade >= requiredGrade then
                isRealEstateWorker = true
                LogDebug(("Player %s editing garage %s as real estate worker: job=%s, grade=%s"):format(source, garageId, jobName, jobGrade), "garage-edit")
            end
        end
    end

    -- Edit garage through GarageManager with real estate bypass flag
    local success, message = GarageManager.EditGarage(garageId, playerData.Identifier, updateData, isRealEstateWorker)

    if success then
        LogDebug(("Garage %s edited successfully by player %s"):format(garageId, source), "garage-edit")
        SendNotification(source, message or 'Garage updated successfully', 'success')
        return { success = true, message = message }
    else
        LogDebug(("Failed to edit garage %s by player %s: %s"):format(garageId, source, message or 'Unknown error'), "garage-edit")
        SendNotification(source, message or 'Failed to update garage', 'error')
        return { success = false, message = message }
    end
end)

-- Player Data API: Get player identifier and name by server ID
lib.callback.register('dusa-garage:server:getPlayerData', function(source, targetServerId)
    if not targetServerId then
        LogDebug(("Invalid target server ID from player %s for getPlayerData"):format(source), "user-management")
        return { success = false, message = 'Invalid target server ID' }
    end

    LogDebug(("Player %s requesting player data for server ID: %s"):format(source, targetServerId), "user-management")

    -- Get target player data through Framework
    local targetPlayerData = Framework.GetPlayer(targetServerId)
    if not targetPlayerData then
        LogDebug(("Could not get player data for server ID %s"):format(targetServerId), "user-management")
        return { success = false, message = 'Target player not found' }
    end

    -- Extract identifier and name
    local identifier = targetPlayerData.Identifier
    local firstName = targetPlayerData.Firstname or ""
    local lastName = targetPlayerData.Lastname or ""
    local fullName = string.format("%s %s", firstName, lastName):gsub("^%s*(.-)%s*$", "%1") -- Trim spaces

    -- Fallback to GetPlayerName if Framework names are not available
    if fullName == "" or fullName == " " then
        fullName = GetPlayerName(targetServerId) or ("Player " .. targetServerId)
    end

    LogDebug(("Retrieved player data for server ID %s: identifier=%s, name=%s"):format(targetServerId, identifier, fullName), "user-management")

    return {
        success = true,
        identifier = identifier,
        name = fullName
    }
end)

-- Real Estate Management API: Check if player is real estate worker
lib.callback.register('dusa-garage:server:checkRealEstateAccess', function(source)
    LogDebug(("Player %s requesting real estate access check"):format(source), "user-management")

    -- Check if real estate system is enabled
    if not Config.RealEstate or not Config.RealEstate.Enabled then
        return { success = true, isRealEstate = false, permissions = {} }
    end

    -- Get player data through Framework
    local playerData = Framework.GetPlayer(source)
    if not playerData then
        LogDebug(("Could not get player data for source %s"):format(source), "user-management")
        return { success = false, message = 'Player data not found' }
    end

    -- Check player job and grade
    local playerJob = playerData.Job or {}
    local jobName = playerJob.name or playerJob.Name or ""
    local jobGrade = playerJob.grade or playerJob.Grade.Level or 0

    LogDebug(("Player %s job check: job=%s, grade=%s"):format(source, jobName, jobGrade), "user-management")

    -- Check if player has real estate job with sufficient grade
    local isRealEstate = false
    if Config.RealEstate.Jobs[jobName] then
        local requiredGrade = Config.RealEstate.Jobs[jobName].minGrade or 0
        if jobGrade >= requiredGrade then
            isRealEstate = true
            LogDebug(("Player %s has real estate access: job=%s, grade=%s (required: %s)"):format(source, jobName, jobGrade, requiredGrade), "user-management")
        else
            LogDebug(("Player %s insufficient grade: job=%s, grade=%s (required: %s)"):format(source, jobName, jobGrade, requiredGrade), "user-management")
        end
    end

    return {
        success = true,
        isRealEstate = isRealEstate,
        permissions = isRealEstate and Config.RealEstate.Permissions or {},
        jobInfo = {
            name = jobName,
            grade = jobGrade
        }
    }
end)

-- Real Estate Management API: Get all property garages for real estate workers
lib.callback.register('dusa-garage:server:getAllGaragesForRealEstate', function(source)
    LogDebug(("Real estate player %s requesting all property garages"):format(source), "user-management")

    -- Check if real estate system is enabled
    if not Config.RealEstate or not Config.RealEstate.Enabled then
        LogDebug(("Real estate system disabled for player %s"):format(source), "user-management")
        return { success = false, message = 'Real estate system is disabled' }
    end

    -- Get player data and check real estate access directly
    local playerData = Framework.GetPlayer(source)
    if not playerData then
        LogDebug(("Could not get player data for source %s"):format(source), "user-management")
        return { success = false, message = 'Player data not found' }
    end

    -- Check player job and grade
    local playerJob = playerData.Job or {}
    local jobName = playerJob.name or playerJob.Name or ""
    local jobGrade = playerJob.grade or playerJob.Grade.Level or 0

    LogDebug(("Player %s job check for all garages: job=%s, grade=%s"):format(source, jobName, jobGrade), "user-management")

    -- Check if player has real estate job with sufficient grade
    local isRealEstate = false
    if Config.RealEstate.Jobs[jobName] then
        local requiredGrade = Config.RealEstate.Jobs[jobName].minGrade or 0
        if jobGrade >= requiredGrade then
            isRealEstate = true
            LogDebug(("Player %s has real estate access for property garages: job=%s, grade=%s (required: %s)"):format(source, jobName, jobGrade, requiredGrade), "user-management")
        else
            LogDebug(("Player %s insufficient grade for property garages: job=%s, grade=%s (required: %s)"):format(source, jobName, jobGrade, requiredGrade), "user-management")
        end
    end

    if not isRealEstate then
        LogDebug(("Player %s denied access to property garages - not real estate"):format(source), "user-management")
        return { success = false, message = 'Access denied - real estate access required' }
    end

    -- Get all property garages through GarageManager
    local success, garages = GarageManager.GetAllGarages()

    if success then
        LogDebug(("Found %d property garages for real estate player %s"):format(#garages, source), "user-management")
        return { success = true, garages = garages }
    else
        LogDebug(("Failed to get property garages for real estate player %s"):format(source), "user-management")
        return { success = false, message = 'Failed to retrieve property garages' }
    end
end)

-- Admin Management API: Get all garages (all types)
lib.callback.register('dusa-garage:server:getAllGarages', function(source)
    LogDebug(("Player %s requesting all garages for admin management"):format(source), "admin-management")

    -- Get all garages through GarageManager
    local success, garages = GarageManager.GetAllGaragesAdmin()

    if success then
        LogDebug(("Found %d garages for admin player %s"):format(#garages, source), "admin-management")
        return { success = true, garages = garages }
    else
        LogDebug(("Failed to get garages for admin player %s"):format(source), "admin-management")
        return { success = false, message = 'Failed to retrieve garages' }
    end
end)


-- Initialize job vehicle systems
CreateThread(function()
    Wait(1000) -- Wait for core systems to load
    JobVehicleManager.Init()
    GradeValidator.Init()
    VehicleOwnership.Init()
    LogDebug("Job vehicle systems initialized", "system")
end)

-- Server event: Get available job vehicles for player
RegisterServerEvent('dusa-garage:server:getJobVehicles', function(data)
    local source = source
    local garageId = data and data.garageId or nil

    if IsRateLimited(source, 'getJobVehicles') then
        SendNotification(source, 'Please wait before requesting job vehicles again', 'error')
        return
    end

    LogDebug(("Player %s requested job vehicles (garageId: %s)"):format(source, tostring(garageId)), "api")

    -- If garageId is provided, get garage info to determine vehicleType
    local garageVehicleType = 'car' -- default
    if garageId then
        local garage, garageError = GarageManager.GetGarage(garageId)
        if garage then
            garageVehicleType = garage.vehicleType or 'car'
            LogDebug(("Got garage vehicleType from garageId %s: %s"):format(garageId, garageVehicleType), "api")
        else
            LogDebug(("Could not get garage for ID %s: %s"):format(garageId, garageError or "Unknown error"), "api")
        end
    else
        LogDebug("No garageId provided, using default vehicleType 'car'", "api")
    end

    local result = JobVehicleManager.GetPlayerJobVehicles(source, garageVehicleType)

    if result.success then
        -- Add garage info to result
        result.garageId = garageId
        result.garageVehicleType = garageVehicleType
        result.vehicleType = garageVehicleType

        LogDebug(("=== SENDING JOB VEHICLES TO CLIENT ==="), "api")
        LogDebug(("GarageID: %s, VehicleType: %s"):format(tostring(garageId), garageVehicleType), "api")

        -- Add spawn points and locations if garage was found
        if garageId then
            local garage, garageError = GarageManager.GetGarage(garageId)
            if garage then
                LogDebug(("Garage found - vehicleType: %s"):format(tostring(garage.vehicleType)), "api")
                LogDebug(("Garage has locations: %s"):format(tostring(garage.locations ~= nil)), "api")
                LogDebug(("Garage has settings: %s"):format(tostring(garage.settings ~= nil)), "api")

                if garage.settings then
                    local settings = garage.settings
                    if settings.spawnPoints then
                        result.spawnPoints = settings.spawnPoints
                        LogDebug(("Added %d spawn points to job vehicle result (garageId: %s)"):format(#settings.spawnPoints, garageId), "api")
                    else
                        LogDebug(("WARNING: No spawn points in settings for garageId: %s"):format(garageId), "api")
                    end
                end

                -- Add locations (interaction, spawn) for client-side use
                if garage.locations then
                    result.locations = garage.locations
                    LogDebug(("Added garage locations to job vehicle result (garageId: %s)"):format(garageId), "api")
                    if garage.locations.interaction then
                        LogDebug(("  Interaction coords: x=%.2f, y=%.2f, z=%.2f, w=%.2f"):format(
                            garage.locations.interaction.x or 0,
                            garage.locations.interaction.y or 0,
                            garage.locations.interaction.z or 0,
                            garage.locations.interaction.w or 0
                        ), "api")
                    else
                        LogDebug(("  WARNING: No interaction coords in locations"), "api")
                    end
                else
                    LogDebug(("WARNING: No locations in garage object for garageId: %s"):format(garageId), "api")
                end
            else
                LogDebug(("WARNING: Could not get garage for garageId: %s (error: %s)"):format(garageId, garageError or "none"), "api")
            end
        else
            LogDebug("WARNING: No garageId provided to getJobVehicles - spawn points not available", "api")
        end

        LogDebug(("Final result - garageVehicleType: %s, vehicleType: %s, locations: %s"):format(
            tostring(result.garageVehicleType),
            tostring(result.vehicleType),
            tostring(result.locations ~= nil)
        ), "api")
        LogDebug(("Sending %d job vehicles to player %s (filtered by type: %s)"):format(#result.vehicles, source, garageVehicleType), "api")
        TriggerClientEvent('dusa-garage:client:receiveJobVehicles', source, result)
    else
        LogDebug(("Failed to get job vehicles for player %s: %s"):format(source, result.error), "api")
        SendNotification(source, result.error, 'error')
    end
end)

-- Server event: Spawn job vehicle
RegisterServerEvent('dusa-garage:server:spawnJobVehicle', function(vehicleModel, spawnCoords, spawnHeading)
    local source = source

    if not vehicleModel or not spawnCoords then
        LogDebug(("Invalid parameters from player %s for spawnJobVehicle"):format(source), "validation")
        return
    end

    if IsRateLimited(source, 'spawnJobVehicle') then
        SendNotification(source, 'Please wait before spawning another vehicle', 'error')
        return
    end

    LogDebug(("Player %s wants to spawn job vehicle: %s"):format(source, vehicleModel), "vehicle-operations")
    LogDebug(("Spawn coordinates received: x=%.2f, y=%.2f, z=%.2f, heading=%.2f"):format(spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnHeading or 0), "vehicle-operations")

    -- Get player job info for validation
    local Player = Framework.GetPlayer(source)
    if not Player then
        SendNotification(source, 'Player data not available', 'error')
        return
    end

    -- Validate grade access before spawning
    local playerJob = JobVehicleManager.GetPlayerJobInfo(Player)
    if not playerJob then
        SendNotification(source, 'You must have a job to access job vehicles', 'error')
        return
    end

    local validation = GradeValidator.ValidateVehicleAccess(source, vehicleModel, playerJob.name)
    if not validation.success then
        local errorMessage = GradeValidator.GetErrorMessage(validation)
        SendNotification(source, errorMessage, 'error')
        LogDebug(("Grade validation failed for player %s: %s"):format(source, validation.error), "validation")
        return
    end

    -- Spawn the vehicle
    local spawnResult = JobVehicleManager.SpawnJobVehicle(source, vehicleModel, spawnCoords, spawnHeading)

    if spawnResult.success then
        SendNotification(source, 'Job vehicle spawned successfully', 'success')
        LogDebug(("Job vehicle %s spawned for player %s (first time: %s)"):format(vehicleModel, source, tostring(spawnResult.isFirstTime)), "vehicle-operations")

        -- Wait for entity to be fully networked before getting network ID
        Wait(100)

        -- Verify entity still exists after wait
        if not DoesEntityExist(spawnResult.vehicle) then
            SendNotification(source, 'Vehicle entity lost during spawn', 'error')
            LogDebug(("Vehicle entity no longer exists after network wait for player %s"):format(source), "vehicle-operations")
            return
        end

        -- Get network ID for teleport (after entity is stable)
        local netId = NetworkGetNetworkIdFromEntity(spawnResult.vehicle)
        LogDebug(("Job vehicle netId: %s"):format(tostring(netId)), "vehicle-operations")

        -- Validate network ID is valid
        if not netId or netId == 0 then
            SendNotification(source, 'Failed to get vehicle network ID', 'error')
            LogDebug(("Invalid network ID for vehicle spawned for player %s"):format(source), "vehicle-operations")
            return
        end

        -- Send spawn confirmation to client
        TriggerClientEvent('dusa-garage:client:jobVehicleSpawned', source, {
            vehicle = spawnResult.vehicle,
            netId = netId,
            plate = spawnResult.plate,
            isFirstTime = spawnResult.isFirstTime,
            vehicleConfig = spawnResult.vehicleConfig
        })
    else
        SendNotification(source, spawnResult.error, 'error')
        LogDebug(("Failed to spawn job vehicle for player %s: %s"):format(source, spawnResult.error), "vehicle-operations")
    end
end)

-- Server event: Return job vehicle (drive-in method)
RegisterServerEvent('dusa-garage:server:returnJobVehicleDriveIn', function(vehicleNetId, plate, garageId, garageData)
    local source = source

    LogDebug(("=== RETURN JOB VEHICLE DEBUG START ==="), "vehicle-operations")
    LogDebug(("Raw garageData received: %s"):format(json.encode(garageData or {})), "vehicle-operations")

    -- Extract garage data (type and interaction coords)
    local garageType = garageData and garageData.garageType or 'car'
    local interactionCoords = garageData and garageData.interactionCoords or nil

    LogDebug(("Return job vehicle drive-in event triggered - NetID: %s, Plate: %s, Garage: %s, Type: %s"):format(vehicleNetId, plate, garageId, garageType), "vehicle-operations")
    LogDebug(("GarageType: %s, HasInteractionCoords: %s"):format(garageType, tostring(interactionCoords ~= nil)), "vehicle-operations")

    if interactionCoords then
        LogDebug(("Interaction coords received: x=%.2f, y=%.2f, z=%.2f, w=%.2f"):format(
            interactionCoords.x or 0,
            interactionCoords.y or 0,
            interactionCoords.z or 0,
            interactionCoords.w or 0
        ), "vehicle-operations")
    end
    if not vehicleNetId or not plate then
        LogDebug(("Invalid parameters from player %s for returnJobVehicleDriveIn"):format(source), "validation")
        return
    end

    if IsRateLimited(source, 'returnJobVehicle') then
        SendNotification(source, 'Please wait before returning another vehicle', 'error')
        return
    end

    LogDebug(("Player %s attempting drive-in return - NetID: %s, Plate: %s, Garage: %s, Type: %s"):format(source, vehicleNetId, plate, garageId, garageType), "vehicle-operations")

    -- Get player job info
    local Player = Framework.GetPlayer(source)
    if not Player then
        SendNotification(source, 'Player data not available', 'error')
        return
    end

    local playerJob = JobVehicleManager.GetPlayerJobInfo(Player)
    if not playerJob then
        SendNotification(source, 'You must have a job to return job vehicles', 'error')
        return
    end

    -- Get vehicle from network ID
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if not vehicle or vehicle == 0 then
        LogDebug(("Invalid vehicle entity for player %s"):format(source), "vehicle-operations")
        SendNotification(source, 'Invalid vehicle', 'error')
        return
    end

    -- Check if vehicle model is a job vehicle by checking the hash against configured vehicles
    local vehicleModel = GetEntityModel(vehicle)
    LogDebug(("Vehicle model hash: %s"):format(vehicleModel), "vehicle-operations")

    local jobVehicles = ConfigManager.GetJobVehicles(playerJob.name)
    LogDebug(("Found %d job vehicles for job '%s'"):format(#jobVehicles, playerJob.name), "vehicle-operations")

    local isJobVehicle = false
    local matchedVehicleModel = nil

    for _, vehicleConfig in ipairs(jobVehicles) do
        local configHash = GetHashKey(vehicleConfig.vehicle)
        LogDebug(("Comparing vehicle hash %s with config hash %s (%s)"):format(vehicleModel, configHash, vehicleConfig.vehicle), "vehicle-operations")
        if configHash == vehicleModel then
            isJobVehicle = true
            matchedVehicleModel = vehicleConfig.vehicle
            LogDebug(("MATCH FOUND! Vehicle is job vehicle: %s"):format(vehicleConfig.vehicle), "vehicle-operations")
            break
        end
    end

    if not isJobVehicle then
        -- Not a job vehicle, open the UI instead
        LogDebug(("Player %s driving non-job vehicle (hash: %s), opening job garage UI"):format(source, vehicleModel), "vehicle-operations")
        local result = JobVehicleManager.GetPlayerJobVehicles(source)
        if result.success then
            TriggerClientEvent('dusa-garage:client:receiveJobVehicles', source, result)
        end
        return
    end

    LogDebug(("Proceeding to return job vehicle: %s"):format(matchedVehicleModel), "vehicle-operations")

    -- Return the vehicle
    local result = JobVehicleManager.ReturnJobVehicle(source, vehicle)

    if result.success then
        SendNotification(source, 'Job vehicle parked successfully', 'success')
        LogDebug(("Job vehicle drive-in parked by player %s"):format(source), "vehicle-operations")

        -- For boat garages, teleport player to interaction coords to prevent drowning
        LogDebug(("Checking teleport condition - GarageType: %s, InteractionCoords: %s"):format(
            garageType,
            tostring(interactionCoords ~= nil)
        ), "vehicle-operations")

        if garageType == 'boat' and interactionCoords then
            LogDebug(("TELEPORT WILL TRIGGER - Sending to player %s"):format(source), "vehicle-operations")
            local returnData = {
                teleportCoords = interactionCoords,
                garageType = garageType
            }
            LogDebug(("Return data being sent: %s"):format(json.encode(returnData)), "vehicle-operations")
            TriggerClientEvent('dusa-garage:client:jobVehicleReturned', source, returnData)
        else
            LogDebug(("NO TELEPORT - Reason: garageType=%s (boat=%s), hasCoords=%s"):format(
                garageType,
                tostring(garageType == 'boat'),
                tostring(interactionCoords ~= nil)
            ), "vehicle-operations")
            -- Send return confirmation to client without teleport
            TriggerClientEvent('dusa-garage:client:jobVehicleReturned', source, {
                garageType = garageType
            })
        end
        LogDebug(("=== RETURN JOB VEHICLE DEBUG END ==="), "vehicle-operations")
    else
        SendNotification(source, result.error or 'Failed to park vehicle', 'error')
        LogDebug(("Failed drive-in park for player %s: %s"):format(source, result.error), "vehicle-operations")
    end
end)

-- Server event: Return job vehicle (UI method)
RegisterServerEvent('dusa-garage:server:returnJobVehicle', function(vehicle)
    local source = source

    if not vehicle then
        LogDebug(("Invalid vehicle parameter from player %s for returnJobVehicle"):format(source), "validation")
        return
    end

    if IsRateLimited(source, 'returnJobVehicle') then
        SendNotification(source, 'Please wait before returning another vehicle', 'error')
        return
    end

    LogDebug(("Player %s wants to return job vehicle: %s"):format(source, tostring(vehicle)), "vehicle-operations")

    local result = JobVehicleManager.ReturnJobVehicle(source, vehicle)

    if result.success then
        SendNotification(source, 'Job vehicle returned successfully', 'success')
        LogDebug(("Job vehicle returned by player %s"):format(source), "vehicle-operations")

        -- Send return confirmation to client
        TriggerClientEvent('dusa-garage:client:jobVehicleReturned', source)
    else
        SendNotification(source, result.error, 'error')
        LogDebug(("Failed to return job vehicle for player %s: %s"):format(source, result.error), "vehicle-operations")
    end
end)

-- Server event: Save job vehicle properties (called from client with vehicle props)
RegisterServerEvent('dusa-garage:server:saveJobVehicleProps', function(vehicleModel, jobName, vehicleProps)
    local source = source

    if not vehicleModel or not jobName or not vehicleProps then
        LogDebug(("Invalid parameters from player %s for saveJobVehicleProps"):format(source), "validation")
        return
    end

    LogDebug(("Saving job vehicle properties for player %s: %s (%s)"):format(source, vehicleModel, jobName), "vehicle-operations")

    -- We don't have the vehicle entity here, so we'll call SaveVehicleProperties with nil vehicle
    -- and modify the function to handle it
    JobVehicleManager.SaveVehicleProperties(nil, source, vehicleModel, jobName, vehicleProps)
end)

-- Server event: Validate grade access for UI
RegisterServerEvent('dusa-garage:server:validateJobVehicleAccess', function(vehicleModel, jobName)
    local source = source

    if not vehicleModel or not jobName then
        LogDebug(("Invalid parameters from player %s for validateJobVehicleAccess"):format(source), "validation")
        return
    end

    LogDebug(("Player %s requesting access validation for vehicle %s in job %s"):format(source, vehicleModel, jobName), "validation")

    local validation = GradeValidator.ValidateVehicleAccess(source, vehicleModel, jobName)

    TriggerClientEvent('dusa-garage:client:jobVehicleAccessResult', source, {
        vehicleModel = vehicleModel,
        jobName = jobName,
        validation = validation
    })
end)

-- Callback: Get all job garages
lib.callback.register('dusa-garage:server:getJobGarages', function(source)
    LogDebug(("Player %s requested job garages"):format(source), "api")

    local success, result = pcall(function()
        return MySQL.query.await([[
            SELECT id, name, type, owner_identifier, locations, settings, created_at
            FROM dusa_garages
            WHERE type = 'job'
            ORDER BY created_at DESC
        ]], {})
    end)

    if not success then
        LogDebug(("Failed to fetch job garages for player %s: %s"):format(source, tostring(result)), "api")
        return { success = false, error = 'Failed to fetch job garages' }
    end

    local garages = {}
    for _, garage in ipairs(result) do
        local locations = json.decode(garage.locations) or {}
        local settings = json.decode(garage.settings) or {}

        -- Extract coords from interaction point (or spawn as fallback)
        local coords = { x = 0, y = 0, z = 0 }
        if locations.interaction then
            coords = {
                x = locations.interaction.x or 0,
                y = locations.interaction.y or 0,
                z = locations.interaction.z or 0,
                w = locations.interaction.w or 0
            }
        elseif locations.spawn then
            coords = {
                x = locations.spawn.x or 0,
                y = locations.spawn.y or 0,
                z = locations.spawn.z or 0,
                w = locations.spawn.w or 0
            }
        end

        table.insert(garages, {
            id = garage.id,
            name = garage.name,
            type = garage.type,
            vehicleType = settings.vehicleType or 'car',
            job = settings.job or 'unknown',
            coords = coords,
            radius = locations.interactionRadius or 3.0,
            created_at = garage.created_at
        })
    end

    -- Only log if there are garages to prevent spam (empty results are normal)
    if #garages > 0 then
        LogDebug(("Returning %d job garages to player %s"):format(#garages, source), "api")
    end
    return { success = true, garages = garages }
end)

-- Callback: Delete job garage
lib.callback.register('dusa-garage:server:deleteJobGarage', function(source, garageId)
    if not garageId then
        LogDebug(("Invalid garage ID from player %s for deleteJobGarage"):format(source), "validation")
        return { success = false, error = 'Invalid garage ID' }
    end

    LogDebug(("Player %s attempting to delete job garage: %s"):format(source, garageId), "api")

    -- Check if garage exists and is a job garage
    local success, garage = pcall(function()
        return MySQL.single.await('SELECT id, type FROM dusa_garages WHERE id = ?', { garageId })
    end)

    if not success or not garage then
        LogDebug(("Job garage not found: %s"):format(garageId), "api")
        return { success = false, error = 'Garage not found' }
    end

    if garage.type ~= 'job' then
        LogDebug(("Player %s tried to delete non-job garage: %s"):format(source, garageId), "validation")
        return { success = false, error = 'Can only delete job garages' }
    end

    -- Delete the garage
    local deleteSuccess, deleteResult = pcall(function()
        return MySQL.query.await('DELETE FROM dusa_garages WHERE id = ?', { garageId })
    end)

    if not deleteSuccess or not deleteResult then
        LogDebug(("Failed to delete job garage %s: %s"):format(garageId, tostring(deleteResult)), "api")
        return { success = false, error = 'Failed to delete garage' }
    end

    LogDebug(("Job garage %s deleted by player %s"):format(garageId, source), "api")
    return { success = true }
end)

-- Server event: Get job vehicle ownership info
RegisterServerEvent('dusa-garage:server:getJobVehicleOwnership', function(vehicleModel, jobName)
    local source = source

    if not vehicleModel or not jobName then
        LogDebug(("Invalid parameters from player %s for getJobVehicleOwnership"):format(source), "validation")
        return
    end

    LogDebug(("Player %s requesting ownership info for vehicle %s in job %s"):format(source, vehicleModel, jobName), "database")

    local ownershipData = VehicleOwnership.GetJobVehicleOwnership(source, vehicleModel, jobName)
    local isOwned = ownershipData ~= nil

    TriggerClientEvent('dusa-garage:client:jobVehicleOwnershipResult', source, {
        vehicleModel = vehicleModel,
        jobName = jobName,
        isOwned = isOwned,
        ownershipData = ownershipData
    })
end)

-- ============================
-- JOB VEHICLE ADMIN ENDPOINTS
-- ============================

-- Server event: Get job vehicle configuration (admin only)
RegisterServerEvent('dusa-garage:editor:getJobConfig', function()
    local source = source

    -- Check admin permissions
    local Player = Framework.GetPlayer(source)
    if not Player then
        return
    end

    local isAdmin = IsPlayerAceAllowed(source, "garage.admin") or
                    IsPlayerAceAllowed(source, "admin") or
                    IsPlayerAceAllowed(source, "group.admin")

    if not isAdmin then
        SendNotification(source, "You don't have permission to access job configuration", "error")
        return
    end

    LogDebug(("Admin %s requested job vehicle configuration"):format(source), "api")

    local ConfigManager = require('server.core.modules.config_manager')
    local jobVehicles = ConfigManager.GetAllJobVehicles()
    local categories = ConfigManager.GetJobVehicleCategories()

    TriggerClientEvent('dusa-garage:editor:receiveJobConfig', source, {
        jobVehicles = jobVehicles,
        categories = categories,
        isValid = ConfigManager.IsConfigValid(),
        validationErrors = ConfigManager.GetValidationErrors()
    })
end)

-- Server event: Update job vehicle configuration (admin only)
RegisterServerEvent('dusa-garage:editor:updateJobConfig', function(newConfig)
    local source = source
    if not newConfig then
        LogDebug(("Invalid config from admin %s"):format(source), "validation")
        return
    end

    -- Check admin permissions
    local Player = Framework.GetPlayer(source)
    if not Player then
        return
    end

    local isAdmin = IsPlayerAceAllowed(source, "garage.admin") or
                    IsPlayerAceAllowed(source, "admin") or
                    IsPlayerAceAllowed(source, "group.admin")

    if not isAdmin then
        SendNotification(source, "You don't have permission to update job configuration", "error")
        return
    end

    LogDebug(("Admin %s updating job vehicle configuration"):format(source), "api")

    -- Save the new configuration
    local ConfigManager = require('server.core.modules.config_manager')
    local success, message = ConfigManager.SaveJobVehicleConfig(newConfig, source)

    if success then
        -- Reload to ensure everything is synchronized
        ConfigManager.ReloadJobVehicleConfig(source)
        LogDebug(("Job vehicle configuration updated successfully by admin %s"):format(source), "api")
    else
        LogDebug(("Failed to update job vehicle configuration by admin %s: %s"):format(source, message or "Unknown error"), "api")
    end

    TriggerClientEvent('dusa-garage:editor:configUpdateResult', source, {
        success = success,
        message = message or (success and "Configuration saved successfully" or "Failed to save configuration")
    })
end)

-- ============================
-- ADMIN COMMANDS
-- ============================
-- Admin command with aliases
RegisterCommand('jobconfig', function(source, args, rawCommand)
    if source == 0 then
        print("^1[ERROR]^7 Job config editor can only be opened by players, not console")
        return
    end

    -- Check admin permissions
    local Player = Framework.GetPlayer(source)
    if not Player then
        return
    end

    local isAdmin = false
    -- Use FiveM's native ACE permission system instead of framework-specific checks
    isAdmin = IsPlayerAceAllowed(source, "garage.admin") or
              IsPlayerAceAllowed(source, "admin") or
              IsPlayerAceAllowed(source, "group.admin")

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print('^3[Dusa Garage]^7 ACE Permission check for player ' .. source .. ': ' .. tostring(isAdmin))
    end

    if not isAdmin then
        SendNotification(source, "You don't have permission to access job configuration", "error")
        return
    end

    LogDebug(("Admin %s opening job config editor"):format(source), "api")

    -- Open job config editor UI
    TriggerClientEvent('dusa-garage:editor:openJobConfig', source)
end, false)

-- Help command for job vehicle system
RegisterCommand('garage:help', function(source, args, rawCommand)
    if source == 0 then
        print("^6[Dusa Garage Commands]^7")
        print("^3garage:config^7 - Open job vehicle configuration editor (Admin only)")
        print("^3garage:reload-config^7 - Reload job vehicle configuration (Admin only)")
        print("^3test:job-vehicles^7 - Run job vehicle test suite (Console only)")
    else
        local Player = Framework.GetPlayer(source)
        if not Player then return end

        -- Use FiveM's native ACE permission system
        local isAdmin = IsPlayerAceAllowed(source, "garage.admin") or
                       IsPlayerAceAllowed(source, "admin") or
                       IsPlayerAceAllowed(source, "group.admin")

        SendNotification(source, "Available Commands:", "info")

        if isAdmin then
            SendNotification(source, "/garage:config - Open job config editor", "info")
            SendNotification(source, "/jobconfig - Alias for garage:config", "info")
            SendNotification(source, "/garageconfig - Alias for garage:config", "info")
        else
            SendNotification(source, "No admin commands available", "info")
        end
    end
end, false)

-- ============================
-- ADMIN EDITOR API (Story 1.4)
-- ============================

-- Check admin permission
RegisterServerEvent('dusa-garage:server:checkAdminPermission', function()
    local source = source

    -- Use FiveM's native ACE permission system
    local isAdmin = IsPlayerAceAllowed(source, "garage.admin") or
                    IsPlayerAceAllowed(source, "admin") or
                    IsPlayerAceAllowed(source, "group.admin")

    LogDebug(("Admin permission check for player %s: %s"):format(source, tostring(isAdmin)), "admin-editor")

    if isAdmin then
        TriggerClientEvent('dusa-garage:client:openAdminEditor', source)
    else
        TriggerClientEvent('dusa-garage:client:permissionDenied', source, "You don't have permission to use the garage editor")
    end
end)

-- Create garage from admin editor
RegisterServerEvent('dusa-garage:server:createGarage', function(garageData)
    local source = source

    LogDebug(("Received garage creation request from player %s"):format(source), "admin-editor")
    LogDebug(("Garage data: %s"):format(json.encode(garageData)), "admin-editor")

    -- Verify admin permission
    local isAdmin = IsPlayerAceAllowed(source, "garage.admin") or
                    IsPlayerAceAllowed(source, "admin") or
                    IsPlayerAceAllowed(source, "group.admin")

    LogDebug(("Admin permission check for player %s: %s"):format(source, tostring(isAdmin)), "validation")

    if not isAdmin then
        LogDebug(("Player %s denied - no admin permission"):format(source), "validation")
        TriggerClientEvent('dusa-garage:client:garageCreated', source, {
            success = false,
            error = "You don't have permission to create garages"
        })
        return
    end

    -- Check rate limiting (skip for preset garages)
    if not garageData.fromPreset and IsRateLimited(source, 'createGarage') then
        LogDebug(("Player %s rate limited"):format(source), "validation")
        TriggerClientEvent('dusa-garage:client:garageCreated', source, {
            success = false,
            error = "You are creating garages too quickly. Please wait a moment."
        })
        return
    end

    -- Validate garage name
    if not garageData.name or garageData.name == "" then
        LogDebug(("Player %s - invalid garage name"):format(source), "validation")
        TriggerClientEvent('dusa-garage:client:garageCreated', source, {
            success = false,
            error = "Garage name is required"
        })
        return
    end

    -- Acquire creation lock
    if not AcquireCreationLock(source, garageData.name) then
        LogDebug(("Player %s - creation lock failed for garage: %s"):format(source, garageData.name), "validation")
        TriggerClientEvent('dusa-garage:client:garageCreated', source, {
            success = false,
            error = "A garage with this name is already being created"
        })
        return
    end

    LogDebug(("Admin %s creating garage: %s (all validations passed)"):format(source, garageData.name), "admin-editor")

    -- Call garage creation logic
    GarageManager.CreateGarage(garageData, function(success, result)
        LogDebug(("CreateGarage callback received - success: %s"):format(tostring(success)), "garage-creation")
        LogDebug(("CreateGarage result: %s"):format(json.encode(result)), "garage-creation")

        -- Release creation lock
        ReleaseCreationLock(source, garageData.name)
        LogDebug(("Creation lock released for garage: %s"):format(garageData.name), "garage-creation")

        if success then
            LogDebug(("Sending success response to player %s - garageId: %s"):format(source, tostring(result.garageId)), "admin-editor")
            TriggerClientEvent('dusa-garage:client:garageCreated', source, {
                success = true,
                garageId = result.garageId,
                message = "Garage created successfully"
            })
        else
            LogDebug(("Sending error response to player %s - error: %s"):format(source, tostring(result.error)), "admin-editor")
            TriggerClientEvent('dusa-garage:client:garageCreated', source, {
                success = false,
                error = result.error or "Failed to create garage"
            })
        end
    end)
end)

-- ============================
-- VEHICLE TRANSFER API (Story 2.1)
-- ============================

RegisterServerEvent('dusa-garage:server:transferVehicle', function(data)
    local source = source

    if not data or not data.plate or not data.targetGarageName or not data.playerCurrentGarage then
        LogDebug(("Transfer request missing parameters from player %s"):format(source), "vehicle-transfer")
        TriggerClientEvent('dusa-garage:client:transferResult', source, {
            success = false,
            message = "Invalid transfer request"
        })
        return
    end

    LogDebug(("Player %s requesting vehicle transfer: %s (current: %s -> target: %s)"):format(
        source, data.plate, data.playerCurrentGarage, data.targetGarageName
    ), "vehicle-transfer")

    -- Call transfer logic with player's current garage
    local success, result = GarageManager.TransferVehicle(source, data.plate, data.targetGarageName, data.playerCurrentGarage)

    if success then
        TriggerClientEvent('dusa-garage:client:transferResult', source, {
            success = true,
            message = result.message,
            newGarageName = result.newGarageName,
            fee = result.fee,
            plate = data.plate
        })
    else
        TriggerClientEvent('dusa-garage:client:transferResult', source, {
            success = false,
            message = result or "Transfer failed"
        })
    end
end)

-- ============================
-- VEHICLE NAME UPDATE API
-- ============================

-- Callback: Update vehicle custom name
lib.callback.register('dusa-garage:server:updateVehicleName', function(source, plate, customName)
    if not plate then
        LogDebug(("Invalid plate from player %s for updateVehicleName"):format(source), "vehicle-operations")
        return { success = false, message = 'Invalid vehicle plate' }
    end

    LogDebug(("Player %s requesting to update vehicle name: plate=%s, name=%s"):format(source, plate, customName or "NULL"), "vehicle-operations")

    -- Update vehicle name
    local success, result = GarageManager.UpdateVehicleName(source, plate, customName)

    if success then
        LogDebug(("Vehicle %s name updated successfully by player %s"):format(plate, source), "vehicle-operations")
        return { success = true, message = result }
    else
        LogDebug(("Failed to update vehicle %s name by player %s: %s"):format(plate, source, result), "vehicle-operations")
        return { success = false, message = result }
    end
end)

-- Initialize API on bridge ready
if BridgeEvents then
    BridgeEvents.WaitForBridge(function(success, bridge)
        if success then
            LogDebug("API initialized with Dusa Bridge", "system")
        else
            print(("[%s] ERROR: API initialization failed - Bridge not available"):format(resourceName))
        end
    end, 5000)
end

-- ============================
-- VEHICLE IMPOUND SYSTEM API
-- ============================

-- Check if player has impound permission (police or tow truck)
-- Returns: hasPermission (boolean), isPolice (boolean)
function CheckImpoundPermission(source)
    LogDebug(("checkImpoundPermission called for player %s"):format(source), "impound")
    
    local playerData = Framework.GetPlayer(source)
    if not playerData then
        LogDebug(("Player %s data not found"):format(source), "impound")
        return false, false
    end

    local playerJob = playerData.Job and playerData.Job.Name or ""
    local playerIdentifier = playerData.Identifier or "unknown"
    LogDebug(("Player %s (%s) has job: %s"):format(source, playerIdentifier, playerJob), "impound")

    -- Get allowed jobs from config
    local allowedJobs = Config.Impound and Config.Impound.AllowedJobs or {"police", "sheriff", "tow", "towtruck", "mechanic"}
    local isPolice = (playerJob:lower() == "police" or playerJob:lower() == "sheriff")

    LogDebug(("Checking job '%s' against allowed jobs: %s"):format(
        playerJob,
        table.concat(allowedJobs, ", ")
    ), "impound")

    for _, job in ipairs(allowedJobs) do
        if playerJob:lower() == job:lower() then
            LogDebug(("Player %s has allowed job '%s', isPolice=%s"):format(
                source,
                playerJob,
                tostring(isPolice)
            ), "impound")
            return true, isPolice
        end
    end
    
    LogDebug(("Player %s job '%s' is not in allowed jobs list"):format(source, playerJob), "impound")
    return false, false
end

-- Register callback that uses the global function
lib.callback.register('dusa-garage:server:checkImpoundPermission', function(source)
    return CheckImpoundPermission(source)
end)

-- Impound vehicle
lib.callback.register('dusa-garage:server:impoundVehicle', function(source, plate, reason, impoundType, durationHours, releaseFee)
    if not plate or not reason then
        return { success = false, message = "Invalid parameters" }
    end

    local playerData = Framework.GetPlayer(source)
    if not playerData then
        return { success = false, message = "Player data not found" }
    end

    local impoundedBy = playerData.Identifier
    local releaseAt = nil

    -- Calculate release time for temporary impounds
    if impoundType == "temporary" and durationHours then
        local releaseTime = os.time() + (durationHours * 3600)
        -- Format datetime for MySQL (YYYY-MM-DD HH:MM:SS)
        local year = os.date("%Y", releaseTime)
        local month = os.date("%m", releaseTime)
        local day = os.date("%d", releaseTime)
        local hour = os.date("%H", releaseTime)
        local min = os.date("%M", releaseTime)
        local sec = os.date("%S", releaseTime)
        releaseAt = string.format("%s-%s-%s %s:%s:%s", year, month, day, hour, min, sec)
    end

    -- For paid impounds, ensure fee is provided
    if impoundType == "paid" then
        releaseFee = tonumber(releaseFee) or 0
        if releaseFee <= 0 then
            return { success = false, message = "Release fee must be greater than 0 for paid impounds" }
        end
    else
        releaseFee = nil
    end

    -- Get vehicle table based on framework
    local vehicleTable = "owned_vehicles"
    local ownerColumn = "owner"
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        vehicleTable = "player_vehicles"
        ownerColumn = "citizenid"
    end

    -- Check if vehicle exists
    local vehicleData = MySQL.single.await(
        ('SELECT * FROM %s WHERE plate = ?'):format(vehicleTable),
        {plate}
    )

    if not vehicleData then
        return { success = false, message = "Vehicle not found" }
    end

    -- Check if already impounded (non-released)
    local existingImpound = MySQL.single.await(
        'SELECT * FROM dusa_vehicle_impounds WHERE plate = ? AND is_released = ?',
        {plate, false}
    )

    if existingImpound then
        return { success = false, message = "Vehicle is already impounded" }
    end

    -- Insert impound record with fee support
    local success = MySQL.insert.await(
        [[INSERT INTO dusa_vehicle_impounds 
            (plate, impound_type, reason, impounded_by, release_at, duration_hours, release_fee) 
            VALUES (?, ?, ?, ?, ?, ?, ?)]],
        {plate, impoundType, reason, impoundedBy, releaseAt, durationHours, releaseFee}
    )

    if not success then
        LogDebug(("Failed to impound vehicle %s"):format(plate), "impound")
        return { success = false, message = "Database error" }
    end

    -- Update vehicle state to impounded (store it)
    local updateQuery
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        updateQuery = ('UPDATE %s SET state = 0, garage = ? WHERE plate = ?'):format(vehicleTable)
    else
        updateQuery = ('UPDATE %s SET stored = 0, parking = ? WHERE plate = ?'):format(vehicleTable)
    end

    MySQL.update.await(updateQuery, {"impound", plate})

    LogDebug(("Vehicle %s impounded by %s, type: %s, fee: %s"):format(plate, impoundedBy, impoundType, tostring(releaseFee or "N/A")), "impound")
    return { success = true, message = "Vehicle impounded successfully" }
end)

-- Get impounded vehicles
lib.callback.register('dusa-garage:server:getImpoundedVehicles', function(source)
    local playerData = Framework.GetPlayer(source)
    if not playerData then
        return { success = false, vehicles = {} }
    end

    -- Check if player is police
    local playerJob = playerData.Job and playerData.Job.Name or ""
    if playerJob:lower() ~= "police" and playerJob:lower() ~= "sheriff" then
        return { success = false, message = "Permission denied" }
    end

    -- Get all non-released impounds
    local impounds = MySQL.query.await(
        'SELECT * FROM dusa_vehicle_impounds WHERE is_released = ? ORDER BY impounded_at DESC',
        {false}
    ) or {}

    -- Get vehicle model names
    local vehicleTable = "owned_vehicles"
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        vehicleTable = "player_vehicles"
    end

    local vehicles = {}
    for _, impound in ipairs(impounds) do
        local vehicleData = MySQL.single.await(
            ('SELECT vehicle FROM %s WHERE plate = ?'):format(vehicleTable),
            {impound.plate}
        )
        
        local modelName = "Unknown"
        if vehicleData then
            if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
                modelName = vehicleData.vehicle or "Unknown"
            else
                -- ESX: vehicle.vehicle might be JSON
                local vehicleModel = vehicleData.vehicle
                if type(vehicleModel) == "string" then
                    local success, parsed = pcall(json.decode, vehicleModel)
                    if success and parsed and parsed.model then
                        modelName = parsed.model
                    else
                        modelName = vehicleModel
                    end
                else
                    modelName = vehicleModel or "Unknown"
                end
            end
        end

        table.insert(vehicles, {
            id = impound.id,
            plate = impound.plate,
            model = modelName,
            impound_type = impound.impound_type,
            reason = impound.reason,
            impounded_by = impound.impounded_by,
            impounded_at = impound.impounded_at,
            release_at = impound.release_at,
            duration_hours = impound.duration_hours,
            is_released = impound.is_released == 1
        })
    end

    return { success = true, vehicles = vehicles }
end)

-- Update impound duration
lib.callback.register('dusa-garage:server:updateImpoundDuration', function(source, vehicleId, change)
    local playerData = Framework.GetPlayer(source)
    if not playerData then
        return { success = false, message = "Player data not found" }
    end

    -- Check if player is police
    local playerJob = playerData.Job and playerData.Job.Name or ""
    if playerJob:lower() ~= "police" and playerJob:lower() ~= "sheriff" then
        return { success = false, message = "Permission denied" }
    end

    -- Get current impound
    local impound = MySQL.single.await(
        'SELECT * FROM dusa_vehicle_impounds WHERE id = ? AND is_released = ?',
        {vehicleId, false}
    )

    if not impound then
        return { success = false, message = "Impound not found" }
    end

    if impound.impound_type == "permanent" then
        return { success = false, message = "Cannot change duration for permanent impounds" }
    end

    -- Calculate new duration
    local newDuration = (impound.duration_hours or 0) + change
    if newDuration < 1 then
        newDuration = 1
    end

    -- Update release time
    local releaseTime = os.time() + (newDuration * 3600)
    -- Format datetime for MySQL (YYYY-MM-DD HH:MM:SS)
    local year = os.date("%Y", releaseTime)
    local month = os.date("%m", releaseTime)
    local day = os.date("%d", releaseTime)
    local hour = os.date("%H", releaseTime)
    local min = os.date("%M", releaseTime)
    local sec = os.date("%S", releaseTime)
    local releaseAt = string.format("%s-%s-%s %s:%s:%s", year, month, day, hour, min, sec)

    MySQL.update.await(
        'UPDATE dusa_vehicle_impounds SET duration_hours = ?, release_at = ? WHERE id = ?',
        {newDuration, releaseAt, vehicleId}
    )

    LogDebug(("Impound duration updated for vehicle %s: %d hours"):format(impound.plate, newDuration), "impound")
    return { success = true, message = "Duration updated" }
end)

-- Release impound (with payment for paid impounds)
lib.callback.register('dusa-garage:server:releaseImpound', function(source, vehicleId, isOwnerRelease)
    local playerData = Framework.GetPlayer(source)
    if not playerData then
        return { success = false, message = "Player data not found" }
    end

    -- Get impound first to check type
    local impound = MySQL.single.await(
        'SELECT * FROM dusa_vehicle_impounds WHERE id = ? AND is_released = ?',
        {vehicleId, false}
    )

    if not impound then
        return { success = false, message = "Impound not found" }
    end

    -- If owner is releasing a paid impound, check payment
    if isOwnerRelease and impound.impound_type == "paid" then
        -- Check if vehicle owner matches player
        local vehicleTable = "owned_vehicles"
        local ownerColumn = "owner"
        if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
            vehicleTable = "player_vehicles"
            ownerColumn = "citizenid"
        end

        local vehicleData = MySQL.single.await(
            ('SELECT %s FROM %s WHERE plate = ?'):format(ownerColumn, vehicleTable),
            {impound.plate}
        )

        if not vehicleData or vehicleData[ownerColumn] ~= playerData.Identifier then
            return { success = false, message = "You are not the owner of this vehicle" }
        end

        -- Check if player has enough money
        local releaseFee = tonumber(impound.release_fee) or 0
        print('release fee', releaseFee, type(releaseFee))
        if releaseFee > 0 then
            local playerMoney = playerData.GetMoney('bank') or 0
            if playerMoney < releaseFee then
                return { success = false, message = string.format("You need $%s to release this vehicle", releaseFee) }
            end

            -- Remove money from player
            playerData.RemoveMoney("bank", releaseFee, "impound-release")
        end
    else
        -- Police release - check permission
        local playerJob = playerData.Job and playerData.Job.Name or ""
        if playerJob:lower() ~= "police" and playerJob:lower() ~= "sheriff" then
            return { success = false, message = "Permission denied" }
        end
    end

    -- Mark as released
    -- Format datetime for MySQL
    local year = os.date("%Y")
    local month = os.date("%m")
    local day = os.date("%d")
    local hour = os.date("%H")
    local min = os.date("%M")
    local sec = os.date("%S")
    local releasedAt = string.format("%s-%s-%s %s:%s:%s", year, month, day, hour, min, sec)
    
    MySQL.update.await(
        'UPDATE dusa_vehicle_impounds SET is_released = ?, released_at = ?, released_by = ? WHERE id = ?',
        {true, releasedAt, playerData.Identifier, vehicleId}
    )

    -- Get vehicle table based on framework
    local vehicleTable = "owned_vehicles"
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        vehicleTable = "player_vehicles"
        -- Reset vehicle state (unstore)
        MySQL.update.await(
            ('UPDATE %s SET state = 0, garage = NULL WHERE plate = ?'):format(vehicleTable),
            {impound.plate}
        )
    else
        -- ESX: Reset stored status
        MySQL.update.await(
            ('UPDATE %s SET stored = 0, parking = NULL WHERE plate = ?'):format(vehicleTable),
            {impound.plate}
        )
    end

    LogDebug(("Impound released for vehicle %s by %s"):format(impound.plate, playerData.Identifier), "impound")
    return { success = true, message = "Impound released" }
end)

-- Get impound ID by plate (for owner release)
lib.callback.register('dusa-garage:server:getImpoundIdByPlate', function(source, plate)
    if not plate then
        return nil
    end

    local impound = MySQL.single.await(
        'SELECT id FROM dusa_vehicle_impounds WHERE plate = ? AND is_released = ?',
        {plate, false}
    )

    return impound and impound.id or nil
end)

-- Get vehicle owner information
lib.callback.register('dusa-garage:server:getVehicleOwner', function(source, plate)
    if not plate then
        return { success = false, message = "Invalid plate" }
    end

    -- Get vehicle table based on framework
    local vehicleTable = "owned_vehicles"
    local ownerColumn = "owner"
    local identifierColumn = "owner"
    
    if Bridge.Framework == "QBCore" or Bridge.Framework == "qbox" then
        vehicleTable = "player_vehicles"
        ownerColumn = "citizenid"
        identifierColumn = "citizenid"
    end

    -- Get vehicle and owner identifier from database
    local vehicleData = MySQL.single.await(
        ('SELECT %s FROM %s WHERE plate = ?'):format(identifierColumn, vehicleTable),
        {plate}
    )

    if not vehicleData then
        return { success = false, message = "Vehicle not found" }
    end

    local ownerIdentifier = vehicleData[identifierColumn]
    if not ownerIdentifier then
        return { success = false, message = "Owner not found" }
    end

    -- Try to get player data using Framework.GetPlayerByIdentifier (for online players)
    local ownerPlayer = Framework.GetPlayerByIdentifier(ownerIdentifier)
    local ownerName = "Unknown"

    if ownerPlayer then
        -- Player is online - use Framework player data
        local firstName = ownerPlayer.Firstname or ""
        local lastName = ownerPlayer.Lastname or ""
        if firstName ~= "" or lastName ~= "" then
            ownerName = ("%s %s"):format(firstName, lastName):gsub("^%s*(.-)%s*$", "%1")
        elseif ownerPlayer.Name then
            ownerName = ownerPlayer.Name
        end
    else
        -- Player is offline - use Framework.GetOfflinePlayerByIdentifier
        ownerPlayer = Framework.GetOfflinePlayerByIdentifier(ownerIdentifier)
        if ownerPlayer then
            local firstName = ownerPlayer.Firstname or ""
            local lastName = ownerPlayer.Lastname or ""
            if firstName ~= "" or lastName ~= "" then
                ownerName = ("%s %s"):format(firstName, lastName):gsub("^%s*(.-)%s*$", "%1")
            end
        end
    end

    -- Fallback validation
    if ownerName == "" or ownerName == " " then
        ownerName = "Unknown"
    end

    LogDebug(("Vehicle owner retrieved: plate=%s, owner=%s, name=%s, online=%s"):format(
        plate, 
        ownerIdentifier, 
        ownerName, 
        ownerPlayer and ownerPlayer.source and "yes" or "no"
    ), "impound")

    return {
        success = true,
        owner = {
            name = ownerName,
            identifier = ownerIdentifier
        }
    }
end)

-- Load Garage Preset
-- Loads a preset configuration from the presets folder
lib.callback.register('loadGaragePreset', function(source, data)
    LogDebug("╔═══════════════════════════════════════════════════════════════", "presets")
    LogDebug("║ PRESET LOAD REQUEST", "presets")
    LogDebug("╠═══════════════════════════════════════════════════════════════", "presets")
    LogDebug(("║ Source: %s"):format(source), "presets")
    LogDebug(("║ Data: %s"):format(json.encode(data or {})), "presets")

    if not data or not data.presetId then
        LogDebug("║ ❌ ERROR: Missing presetId in request", "presets")
        LogDebug("╚═══════════════════════════════════════════════════════════════", "presets")
        return { success = false, message = "Invalid preset ID" }
    end

    local presetId = data.presetId
    local presetPath = ("presets/%s.lua"):format(presetId)
    LogDebug(("║ Preset ID: %s"):format(presetId), "presets")
    LogDebug(("║ File Path: %s"):format(presetPath), "presets")

    -- Load the preset file
    local presetContent = LoadResourceFile(resourceName, presetPath)
    if not presetContent then
        LogDebug(("║ ❌ ERROR: Preset file not found at path: %s"):format(presetPath), "presets")
        LogDebug(("║ Resource Name: %s"):format(resourceName), "presets")
        LogDebug("╚═══════════════════════════════════════════════════════════════", "presets")
        return { success = false, message = "Preset file not found" }
    end

    LogDebug(("║ ✅ File loaded successfully (%d bytes)"):format(#presetContent), "presets")

    -- Execute the preset file to get the configuration
    local presetFunction, loadError = load(presetContent)
    if not presetFunction then
        LogDebug(("║ ❌ ERROR: Failed to parse Lua file: %s"):format(loadError or "unknown error"), "presets")
        LogDebug("╚═══════════════════════════════════════════════════════════════", "presets")
        return { success = false, message = "Failed to load preset configuration" }
    end

    LogDebug("║ ✅ Lua file parsed successfully", "presets")

    local success, presetConfig = pcall(presetFunction)
    if not success or not presetConfig then
        LogDebug(("║ ❌ ERROR: Failed to execute preset function: %s"):format(presetConfig or "unknown error"), "presets")
        LogDebug("╚═══════════════════════════════════════════════════════════════", "presets")
        return { success = false, message = "Failed to execute preset configuration" }
    end

    LogDebug("║ ✅ Preset function executed successfully", "presets")

    -- Validate preset structure
    if not presetConfig.garages or type(presetConfig.garages) ~= "table" then
        LogDebug("║ ❌ ERROR: Invalid preset structure", "presets")
        LogDebug(("║   - Has garages field: %s"):format(presetConfig.garages and "yes" or "no"), "presets")
        LogDebug(("║   - Garages type: %s"):format(type(presetConfig.garages)), "presets")
        LogDebug("╚═══════════════════════════════════════════════════════════════", "presets")
        return { success = false, message = "Invalid preset structure" }
    end

    local garageCount = #presetConfig.garages
    LogDebug("║ ✅ Preset structure validated", "presets")
    LogDebug("╠═══════════════════════════════════════════════════════════════", "presets")
    LogDebug("║ PRESET DETAILS", "presets")
    LogDebug("╠═══════════════════════════════════════════════════════════════", "presets")
    LogDebug(("║ Name: %s"):format(presetConfig.name or "Unknown"), "presets")
    LogDebug(("║ Description: %s"):format(presetConfig.description or "No description"), "presets")
    LogDebug(("║ Icon: %s"):format(presetConfig.icon or "none"), "presets")
    LogDebug(("║ Total Garages: %d"):format(garageCount), "presets")
    LogDebug("╠═══════════════════════════════════════════════════════════════", "presets")
    LogDebug("║ GARAGE LIST", "presets")
    LogDebug("╠═══════════════════════════════════════════════════════════════", "presets")

    for i, garage in ipairs(presetConfig.garages) do
        LogDebug(("║ [%d] %s"):format(i, garage.name or "Unnamed"), "presets")
        LogDebug(("║     Job: %s | Type: %s | Radius: %.1fm"):format(
            garage.job or "unknown",
            garage.vehicleType or "unknown",
            garage.radius or 0
        ), "presets")
        LogDebug(("║     Coords: x=%.2f, y=%.2f, z=%.2f, w=%.2f"):format(
            garage.coords.x or 0,
            garage.coords.y or 0,
            garage.coords.z or 0,
            garage.coords.w or 0
        ), "presets")
        LogDebug(("║     Spawn Points: %d"):format(garage.spawnPoints and #garage.spawnPoints or 0), "presets")

        if garage.spawnPoints then
            for j, spawn in ipairs(garage.spawnPoints) do
                LogDebug(("║       [%d] x=%.2f, y=%.2f, z=%.2f, h=%.2f"):format(
                    j,
                    spawn.x or 0,
                    spawn.y or 0,
                    spawn.z or 0,
                    spawn.heading or 0
                ), "presets")
            end
        end

        if i < garageCount then
            LogDebug("║     ───────────────────────────────────────────────────────", "presets")
        end
    end

    LogDebug("╠═══════════════════════════════════════════════════════════════", "presets")
    LogDebug("║ ✅ PRESET LOADED SUCCESSFULLY", "presets")
    LogDebug(("║ Returning %d garages to client"):format(garageCount), "presets")
    LogDebug("╚═══════════════════════════════════════════════════════════════", "presets")

    return {
        success = true,
        garages = presetConfig.garages,
        name = presetConfig.name,
        description = presetConfig.description
    }
end)

-- Showroom Test: Get vehicles for showroom display (Test Command 3)
lib.callback.register('garage:server:getVehiclesForShowroom', function(source)
    LogDebug(("Getting vehicles for player: %s"):format(tostring(source)), "showroom-test")

    -- Get player data
    local player = Framework.GetPlayer(source)
    if not player then
        LogDebug('Player not found', "showroom-test")
        return { success = false, message = 'Player not found' }
    end

    local identifier = player.Identifier

    -- Determine framework-specific table and column names
    ---@diagnostic disable-next-line: undefined-global
    local isQBCore = Bridge and (Bridge.Framework == "QBCore" or Bridge.Framework == "qbox")
    local vehicleTable = isQBCore and "player_vehicles" or "owned_vehicles"
    local identifierColumn = isQBCore and "citizenid" or "owner"

    -- Build dynamic query based on framework
    local query
    if isQBCore then
        -- QBCore/QBox query
        query = string.format([[
            SELECT
                id,
                %s as identifier,
                vehicle as model,
                hash,
                mods as props,
                plate,
                garage,
                fuel,
                engine,
                body,
                state,
                drivingdistance,
                status
            FROM %s
            WHERE %s = ?
            AND (state = 1 OR state = 0)
            LIMIT 10
        ]], identifierColumn, vehicleTable, identifierColumn)
    else
        -- ESX query
        query = string.format([[
            SELECT
                id,
                %s as identifier,
                vehicle as model,
                vehicle as props,
                plate,
                garage,
                fuel,
                engine,
                body,
                stored as state,
                drivingdistance,
                NULL as status
            FROM %s
            WHERE %s = ?
            AND (stored = 1 OR stored = 0)
            LIMIT 10
        ]], identifierColumn, vehicleTable, identifierColumn)
    end

    local result = MySQL.query.await(query, { identifier })

    if not result or #result == 0 then
        LogDebug(("No vehicles found for player: %s"):format(tostring(identifier)), "showroom-test")
        return { success = false, message = 'No vehicles found' }
    end

    -- Format vehicles for showroom
    local vehicles = {}
    for _, vehicle in ipairs(result) do
        local mileageKm = vehicle.drivingdistance and (vehicle.drivingdistance / 1000) or 0

        table.insert(vehicles, {
            id = vehicle.id,
            plate = vehicle.plate,
            model = vehicle.model,
            vehicle_name = vehicle.model, -- Display name can be enhanced later
            fuel = vehicle.fuel or 100,
            engine = vehicle.engine or 1000,
            body = vehicle.body or 1000,
            mileageKm = mileageKm,
            garage = vehicle.garage,
            mods = vehicle.props -- Use props column (mods for QBCore, vehicle for ESX)
        })
    end

    LogDebug(("Returning vehicles: %d"):format(#vehicles), "showroom-test")

    return {
        success = true,
        vehicles = vehicles,
        garageId = 1 -- Test garage ID
    }
end)

-- Get garage spawn location for showroom retrieval
lib.callback.register('garage:server:getGarageSpawnLocation', function(source, garageId)
    LogDebug(("Getting spawn location for garage: %s"):format(tostring(garageId)), "showroom")

    -- Get garage data
    local garage = GarageManager.GetGarageById(garageId)
    if not garage then
        LogDebug(("Garage not found: %s"):format(tostring(garageId)), "showroom")
        return { success = false, message = 'Garage not found' }
    end

    -- Get spawn coordinates from garage locations
    local spawnCoords = garage.locations and garage.locations.vehicle or garage.locations.spawn

    if not spawnCoords then
        LogDebug(("No spawn coordinates found for garage: %s"):format(tostring(garageId)), "showroom")
        return { success = false, message = 'No spawn location configured' }
    end

    LogDebug(("Returning spawn coords: %s"):format(json.encode(spawnCoords)), "showroom")

    return {
        success = true,
        spawnCoords = spawnCoords
    }
end)

-- Spawn vehicle from showroom using GarageManager.SpawnVehicle
lib.callback.register('garage:server:spawnVehicleFromShowroom', function(source, plate, garageId)
    LogDebug(("Spawning vehicle from showroom: plate=%s, garageId=%s"):format(plate, garageId), "showroom-retrieval")

    -- Get garage data to get interaction/spawn location
    local garage = GarageManager.GetGarageById(garageId)
    if not garage then
        LogDebug(("Garage not found: %s"):format(garageId), "showroom-retrieval")
        return {
            success = false,
            error = 'Garage not found'
        }
    end

    -- Get player ped entity
    local playerPed = GetPlayerPed(source)
    if not playerPed or playerPed == 0 then
        LogDebug(("Player ped not found for source: %s"):format(source), "showroom-retrieval")
        return {
            success = false,
            error = 'Player not found'
        }
    end

    -- Get garage interaction/spawn location to teleport player
    local teleportCoords = nil
    if garage.locations and garage.locations.interaction then
        teleportCoords = garage.locations.interaction
    elseif garage.locations and garage.locations.spawn then
        teleportCoords = garage.locations.spawn
    end

    if not teleportCoords then
        LogDebug(("No teleport coordinates found for garage: %s"):format(garageId), "showroom-retrieval")
        return {
            success = false,
            error = 'Garage location not configured'
        }
    end

    -- Step 1: Teleport player to garage location FIRST (while still in showroom bucket)
    LogDebug(("Teleporting player to garage location: %.2f, %.2f, %.2f"):format(
        teleportCoords.x, teleportCoords.y, teleportCoords.z
    ), "showroom-retrieval")

    SetEntityCoords(playerPed, teleportCoords.x, teleportCoords.y, teleportCoords.z, false, false, false, false)

    Wait(100) -- Wait for teleport to settle

    -- Step 2: Reset routing bucket (player must be in bucket 0 for spawn to work)
    LogDebug(("Resetting routing bucket for player: %s"):format(source), "showroom-retrieval")
    SetPlayerRoutingBucket(source, 0)

    Wait(200) -- Wait for bucket change to propagate

    -- Step 3: Use GarageManager.SpawnVehicle to properly spawn the vehicle
    -- This handles everything: spawn point selection, vehicle creation, player warp, etc.
    LogDebug(("Calling GarageManager.SpawnVehicle for plate: %s"):format(plate), "showroom-retrieval")
    local success, message, netId = GarageManager.SpawnVehicle(source, plate, garageId, true) -- warp = true

    if success then
        LogDebug(("Vehicle spawned successfully from showroom: plate=%s, netId=%s"):format(plate, netId or 'unknown'), "showroom-retrieval")
        return {
            success = true,
            message = message,
            netId = netId
        }
    else
        LogDebug(("Failed to spawn vehicle from showroom: plate=%s, error=%s"):format(plate, message), "showroom-retrieval")
        return {
            success = false,
            error = message or 'Failed to spawn vehicle'
        }
    end
end)

-- Update vehicle state after showroom retrieval (DEPRECATED - no longer used, kept for backward compatibility)
RegisterNetEvent('garage:server:updateVehicleStateFromShowroom', function(data)
    local source = source

    LogDebug(("Updating vehicle state after retrieval: vehicleId=%s, plate=%s, garageId=%s"):format(
        tostring(data.vehicleId),
        tostring(data.plate),
        tostring(data.garageId)
    ), "showroom")

    -- Get player data
    local player = Framework.GetPlayer(source)
    if not player then
        LogDebug('Player not found', "showroom")
        return
    end

    local identifier = player.Identifier

    -- Determine framework-specific table and column names
    ---@diagnostic disable-next-line: undefined-global
    local isQBCore = Bridge and (Bridge.Framework == "QBCore" or Bridge.Framework == "qbox")
    local vehicleTable = isQBCore and "player_vehicles" or "owned_vehicles"
    local identifierColumn = isQBCore and "citizenid" or "owner"
    local stateColumn = isQBCore and "state" or "stored"

    -- Update vehicle state to spawned (state/stored = 0)
    local query = string.format([[
        UPDATE %s
        SET %s = 0
        WHERE id = ?
        AND %s = ?
    ]], vehicleTable, stateColumn, identifierColumn)

    MySQL.update.await(query, { data.vehicleId, identifier })

    LogDebug('Vehicle state updated to spawned', "showroom")
end)

-- Showroom Vehicle Spawn using GarageManager
lib.callback.register('garage:server:spawnShowroomVehicle', function(source, params)
    LogDebug(("[Showroom Spawn] Spawning vehicle: %s"):format(json.encode(params)), "showroom")

    -- Get player's current bucket (should be source + 10000)
    local bucketId = source + 10000

    -- IMPORTANT: Temporarily set player back to bucket 0 for vehicle spawn
    -- This allows GarageManager.CreateVehicle to properly assign ownership
    LogDebug('[Showroom Spawn] Temporarily setting player to bucket 0 for spawn', "showroom")
    SetPlayerRoutingBucket(source, 0)

    Wait(100) -- Wait for bucket change

    -- Get vehicle properties from database (same logic as GarageManager.SpawnVehicle)
    -- Determine framework-specific table and column names
    local vehicleTable = "owned_vehicles"
    local propsColumn = "vehicle"
    ---@diagnostic disable-next-line: undefined-global
    if Bridge and (Bridge.Framework == "QBCore" or Bridge.Framework == "qbox") then
        vehicleTable = "player_vehicles"
        propsColumn = "mods"
    end

    -- Query vehicle data from database
    local vehicleQuery = string.format('SELECT %s FROM %s WHERE plate = ?', propsColumn, vehicleTable)
    local vehicleData = MySQL.single.await(vehicleQuery, {params.plate})

    local props = {}

    -- Parse vehicle properties from database
    if vehicleData and vehicleData[propsColumn] then
        local propsData = vehicleData[propsColumn]
        if type(propsData) == "string" then
            local success, decoded = pcall(json.decode, propsData)
            if success and type(decoded) == "table" then
                props = decoded
                LogDebug(('[Showroom Spawn] Loaded vehicle properties from database column: %s'):format(propsColumn), "showroom")
            else
                LogDebug('[Showroom Spawn] Failed to decode vehicle properties from database', "showroom")
            end
        elseif type(propsData) == "table" then
            props = propsData
            LogDebug(('[Showroom Spawn] Using vehicle properties table from database column: %s'):format(propsColumn), "showroom")
        end
    else
        LogDebug('[Showroom Spawn] No vehicle properties found in database, using defaults', "showroom")
    end

    -- Ensure critical properties are set
    props.plate = params.plate
    props.fuelLevel = params.fuel or 100
    props.bodyHealth = params.body or 1000
    props.engineHealth = params.engine or 1000

    LogDebug(('[Showroom Spawn] Props prepared: plate=%s, fuel=%s, engine=%s, body=%s'):format(
        tostring(props.plate),
        tostring(props.fuelLevel),
        tostring(props.engineHealth),
        tostring(props.bodyHealth)
    ), "showroom")

    -- Use GarageManager.CreateVehicle (in bucket 0)
    -- Pass playerSource for network ownership assignment
    local netId, vehicle, err = GarageManager.CreateVehicle({
        model = params.model,
        coords = params.coords,
        heading = params.coords.w or 0.0,
        props = props,
        playerSource = source, -- Set owner for network ownership
        warp = false -- Don't warp player into vehicle
    })

    if err then
        LogDebug(('[Showroom Spawn] Failed to spawn vehicle: %s'):format(err), "showroom")
        -- Restore player bucket even on error
        SetPlayerRoutingBucket(source, bucketId)
        return nil
    end

    -- CRITICAL: Move both player AND vehicle to showroom bucket
    if vehicle and DoesEntityExist(vehicle) then
        SetEntityRoutingBucket(vehicle, bucketId)
        SetPlayerRoutingBucket(source, bucketId)
        LogDebug(('[Showroom Spawn] Player and vehicle moved to bucket %d'):format(bucketId), "showroom")

        -- Track this vehicle for cleanup
        if not showroomVehicles[source] then
            showroomVehicles[source] = {}
        end
        table.insert(showroomVehicles[source], vehicle)
        LogDebug(('[Showroom Spawn] Vehicle tracked for cleanup (total: %d)'):format(#showroomVehicles[source]), "showroom")
    else
        LogDebug('[Showroom Spawn] WARNING: Vehicle entity does not exist, cannot set bucket', "showroom")
        SetPlayerRoutingBucket(source, bucketId) -- Restore player bucket
        return nil
    end

    LogDebug(('[Showroom Spawn] Vehicle spawned successfully: netId=%s, vehicle=%s, bucket=%d'):format(tostring(netId), tostring(vehicle), bucketId), "showroom")

    -- Return both netId and vehicle data for client-side registration
    return {
        netId = netId,
        vehicleData = params.vehicleData
    }
end)

-- Showroom Routing Bucket Management
RegisterNetEvent('garage:server:setShowroomBucket', function(playerId)
    local source = source

    -- Use unique bucket per player (player source + 10000)
    local bucketId = source + 10000

    LogDebug(('[Showroom Bucket] Setting player to showroom bucket: source=%s, bucketId=%s'):format(source, bucketId), "showroom")

    -- Set player to unique bucket
    SetPlayerRoutingBucket(source, bucketId)
    SetRoutingBucketPopulationEnabled(bucketId, false)

    -- Initialize vehicle tracking for this player
    if not showroomVehicles[source] then
        showroomVehicles[source] = {}
    end
end)

RegisterNetEvent('garage:server:resetShowroomBucket', function(playerId)
    local source = source
    local Debug = require 'shared.utils.debug'

    LogDebug(('[Showroom Bucket] Resetting player to normal bucket: %s'):format(source), "showroom")

    -- Delete all showroom vehicles for this player BEFORE changing bucket
    if showroomVehicles[source] then
        local deletedCount = 0
        for _, vehicle in ipairs(showroomVehicles[source]) do
            if DoesEntityExist(vehicle) then
                DeleteEntity(vehicle)
                deletedCount = deletedCount + 1
                LogDebug(('[Showroom Cleanup] Deleted vehicle: %s'):format(tostring(vehicle)), "showroom")
            end
        end
        LogDebug(('[Showroom Cleanup] Deleted %d vehicles for player %s'):format(deletedCount, source), "showroom")
        showroomVehicles[source] = nil
    end

    -- Reset player to normal bucket (0)
    SetPlayerRoutingBucket(source, 0)
end)

LogDebug("Server API loaded with Job Vehicle, Admin Editor, Impound System, Preset Loading, and Showroom Test support", "system")

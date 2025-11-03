-- Dusa Garage Management System - Job Vehicle Manager
-- Version: 1.0.0
-- Core job vehicle logic and ownership tracking
if not rawget(_G, "lib") then include('ox_lib', 'init') end
local JobVehicleManager = {}
local ConfigManager = require('server.core.modules.config_manager')

-- Active job vehicles tracking
local ActiveJobVehicles = {}
-- Player job vehicle ownership cache
local PlayerJobVehicles = {}

-- Initialize job vehicle manager
function JobVehicleManager.Init()
    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^2[Dusa Garage]^7 Initializing JobVehicleManager...")
    end

    -- Initialize config manager
    ConfigManager.Init()

    -- Set up cleanup timer
    JobVehicleManager.SetupCleanupTimer()

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^2[Dusa Garage]^7 JobVehicleManager initialized successfully")
    end
end

-- Get available vehicles for player's job and grade
function JobVehicleManager.GetPlayerJobVehicles(source, garageVehicleType)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return { success = false, error = "Player not found" }
    end

    local playerJob = JobVehicleManager.GetPlayerJobInfo(Player)
    if not playerJob then
        return { success = false, error = "Player has no job" }
    end

    -- Default to 'car' if not specified
    garageVehicleType = garageVehicleType or 'car'

    LogDebug(("Getting job vehicles for player %s (job: %s, garage type filter: %s)"):format(source, playerJob.name, garageVehicleType), "job-vehicles")

    local jobVehicles = ConfigManager.GetJobVehicles(playerJob.name)
    LogDebug(("Config returned %d vehicles for job %s"):format(jobVehicles and #jobVehicles or 0, playerJob.name), "job-vehicles")

    if not jobVehicles or #jobVehicles == 0 then
        return {
            success = true,
            vehicles = {},
            message = "No vehicles configured for job: " .. playerJob.name
        }
    end

    local availableVehicles = {}
    local lockedVehicles = {}

    for idx, vehicle in ipairs(jobVehicles) do
        LogDebug(("Processing vehicle #%d: %s (raw vehicleType: %s)"):format(idx, vehicle.vehicle, tostring(vehicle.vehicleType)), "job-vehicles")

        -- Filter by garage vehicle type
        local vType = vehicle.vehicleType or 'car'
        LogDebug(("Vehicle %s has type '%s', garage wants '%s'"):format(vehicle.vehicle, vType, garageVehicleType), "job-vehicles")

        if vType ~= garageVehicleType then
            -- Skip vehicles that don't match the garage type
            LogDebug(("Vehicle %s FILTERED OUT - type %s doesn't match garage type %s"):format(vehicle.vehicle, vType, garageVehicleType), "job-vehicles")
            goto continue
        end

        LogDebug(("Vehicle %s PASSED filter - adding to list"):format(vehicle.vehicle), "job-vehicles")

        local vehicleData = {
            vehicle = vehicle.vehicle,
            displayName = vehicle.displayName,
            category = vehicle.category,
            description = vehicle.description or "",
            minGrade = vehicle.minGrade,
            vehicleType = vehicle.vehicleType or 'car',
            hasAccess = playerJob.grade >= vehicle.minGrade,
            isOwned = JobVehicleManager.IsVehicleOwned(source, vehicle.vehicle, playerJob.name)
        }

        if vehicleData.hasAccess then
            table.insert(availableVehicles, vehicleData)
        else
            table.insert(lockedVehicles, vehicleData)
        end

        ::continue::
    end

    -- Sort by grade requirement and then by name
    table.sort(availableVehicles, function(a, b)
        if a.minGrade == b.minGrade then
            return a.displayName < b.displayName
        end
        return a.minGrade < b.minGrade
    end)

    table.sort(lockedVehicles, function(a, b)
        if a.minGrade == b.minGrade then
            return a.displayName < b.displayName
        end
        return a.minGrade < b.minGrade
    end)

    -- Get player name
    local playerName = "Unknown"
    local firstName = Player.Firstname or ""
    local lastName = Player.Lastname or ""
    if firstName ~= "" or lastName ~= "" then
        playerName = string.format("%s %s", firstName, lastName):gsub("^%s*(.-)%s*$", "%1") -- Trim spaces
    elseif Player.Name then
        playerName = Player.Name
    end

    -- Fallback to GetPlayerName if Framework names are not available
    if playerName == "" or playerName == " " then
        playerName = GetPlayerName(source) or ("Player " .. source)
    end

    LogDebug(("Returning %d available vehicles and %d locked vehicles (filtered by type: %s)"):format(#availableVehicles, #lockedVehicles, garageVehicleType), "job-vehicles")

    return {
        success = true,
        vehicles = availableVehicles,
        lockedVehicles = lockedVehicles,
        job = {
            name = playerJob.name,
            grade = playerJob.grade,
            label = playerJob.label
        },
        categories = ConfigManager.GetJobVehicleCategories(),
        player = {
            name = playerName,
            source = source
        }
    }
end

-- Get player job information from bridge (unified dusa_bridge structure)
function JobVehicleManager.GetPlayerJobInfo(Player)
    if not Player then return nil end

    if Player.Job then
        return {
            name = Player.Job.Name,
            grade = Player.Job.Grade.Level or 0,
            label = Player.Job.Label or Player.Job.Name
        }
    end

    return nil
end

-- Check if player owns a specific job vehicle
function JobVehicleManager.IsVehicleOwned(source, vehicleModel, jobName)
    local cacheKey = source .. ":" .. jobName .. ":" .. vehicleModel

    -- Check cache first
    if PlayerJobVehicles[cacheKey] ~= nil then
        return PlayerJobVehicles[cacheKey].owned, PlayerJobVehicles[cacheKey].plate
    end

    local Player = Framework.GetPlayer(source)
    if not Player then return false, nil end

    local identifier = Player.Identifier
    local result = nil

    -- Query based on framework
    if Bridge.Framework == "esx" then
        result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = ? AND vehicle LIKE ? AND job = ?', {
            identifier,
            '%"model":' .. GetHashKey(vehicleModel) .. '%',
            jobName
        })
    else -- QB/QBox
        result = MySQL.Sync.fetchAll('SELECT plate FROM player_vehicles WHERE citizenid = ? AND vehicle = ? AND garage LIKE ?', {
            identifier,
            vehicleModel,
            'job_' .. jobName
        })
    end

    local isOwned = result and #result > 0
    local plate = isOwned and result[1].plate or nil

    -- Cache the result
    PlayerJobVehicles[cacheKey] = { owned = isOwned, plate = plate }

    return isOwned, plate
end

-- Spawn job vehicle with ownership handling
function JobVehicleManager.SpawnJobVehicle(source, vehicleModel, spawnCoords, spawnHeading)
    local Player = Framework.GetPlayer(source)
    if not Player then
        return { success = false, error = "Player not found" }
    end

    local playerJob = JobVehicleManager.GetPlayerJobInfo(Player)
    if not playerJob then
        return { success = false, error = "Player has no job" }
    end

    -- Verify vehicle is available for this job
    local vehicleConfig = JobVehicleManager.GetVehicleConfig(vehicleModel, playerJob.name)
    if not vehicleConfig then
        return { success = false, error = "Vehicle not available for your job" }
    end

    -- Check grade requirement
    if playerJob.grade < vehicleConfig.minGrade then
        return {
            success = false,
            error = "Insufficient job grade. Required: " .. vehicleConfig.minGrade .. ", Your grade: " .. playerJob.grade
        }
    end

    -- Check vehicle limits
    local playerVehicleCount = JobVehicleManager.GetPlayerActiveVehicleCount(source)
    if playerVehicleCount >= Config.JobVehicleLimits.MaxVehiclesPerPlayer then
        return {
            success = false,
            error = "You have reached the maximum number of active job vehicles (" .. Config.JobVehicleLimits.MaxVehiclesPerPlayer .. ")"
        }
    end

    -- Check if this is first time spawning this vehicle and get saved plate if exists
    local isOwned, savedPlate = JobVehicleManager.IsVehicleOwned(source, vehicleModel, playerJob.name)
    local isFirstTime = not isOwned

    -- Use saved plate for owned vehicles, generate new for first-time
    local plate = savedPlate or JobVehicleManager.GenerateJobVehiclePlate(vehicleModel, playerJob.name)

    -- Create vehicle
    local vehicle = CreateVehicle(GetHashKey(vehicleModel), spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnHeading, true, true)

    if not vehicle or vehicle == 0 then
        return { success = false, error = "Failed to create vehicle" }
    end

    -- Set vehicle properties
    SetVehicleNumberPlateText(vehicle, plate)

    -- If this is the first time, add to ownership
    if isFirstTime then
        JobVehicleManager.AddVehicleOwnership(source, vehicleModel, plate, playerJob)
    else
        -- Load saved properties for owned vehicles
        JobVehicleManager.LoadVehicleProperties(vehicle, source, vehicleModel, playerJob.name)
    end

    -- Track active vehicle
    JobVehicleManager.TrackActiveVehicle(source, vehicle, vehicleModel, playerJob.name, plate)

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["vehicle-operations"] then
        print("^2[Dusa Garage]^7 Spawned job vehicle " .. vehicleModel .. " for player " .. source .. " (first time: " .. tostring(isFirstTime) .. ")")
    end

    return {
        success = true,
        vehicle = vehicle,
        plate = plate,
        isFirstTime = isFirstTime,
        vehicleConfig = vehicleConfig
    }
end

-- Get vehicle configuration
function JobVehicleManager.GetVehicleConfig(vehicleModel, jobName)
    local jobVehicles = ConfigManager.GetJobVehicles(jobName)

    for _, vehicle in ipairs(jobVehicles) do
        if vehicle.vehicle == vehicleModel then
            return vehicle
        end
    end

    return nil
end

-- Check if a vehicle model is a job vehicle for given job
function JobVehicleManager.IsVehicleModelJobVehicle(vehicleModel, jobName)
    local vehicleConfig = JobVehicleManager.GetVehicleConfig(vehicleModel, jobName)
    return vehicleConfig ~= nil
end

-- Add vehicle ownership to database
function JobVehicleManager.AddVehicleOwnership(source, vehicleModel, plate, playerJob)
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    local identifier = Player.Identifier
    local license2 = JobVehicleManager.GetPlayerLicense2(source)
    local hash = GetHashKey(vehicleModel)

    if Bridge.Framework == "esx" then
        -- ESX owned_vehicles table
        local vehicleJson = json.encode({
            model = hash,
            plate = plate
        })

        MySQL.Async.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, stored, parking) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            identifier,
            plate,
            vehicleJson,
            playerJob.name, -- type field used for job name
            playerJob.name, -- job field
            1, -- stored
            'job_' .. playerJob.name -- parking
        })
    else
        -- QB/QBox player_vehicles table
        local mods = json.encode({ model = hash, plate = plate })

        MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state, garage) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            license2, -- license2 identifier
            identifier,
            vehicleModel,
            tostring(hash),
            mods,
            plate,
            1, -- state (available)
            'job_' .. playerJob.name -- garage
        })
    end

    -- Update cache
    local cacheKey = source .. ":" .. playerJob.name .. ":" .. vehicleModel
    PlayerJobVehicles[cacheKey] = { owned = true, plate = plate }

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["database"] then
        print("^2[Dusa Garage]^7 Added job vehicle ownership: " .. vehicleModel .. " for player " .. source .. " (license2: " .. tostring(license2) .. ")")
    end
end

-- Load saved vehicle properties
function JobVehicleManager.LoadVehicleProperties(vehicle, source, vehicleModel, jobName)
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    local identifier = Player.Identifier

    if Bridge.Framework == "esx" then
        MySQL.Async.fetchAll('SELECT vehicle, plate FROM owned_vehicles WHERE owner = ? AND job = ? AND vehicle LIKE ?', {
            identifier,
            jobName,
            '%"model":' .. GetHashKey(vehicleModel) .. '%'
        }, function(result)
            if result and #result > 0 then
                local vehicleData = result[1]

                -- Apply saved modifications via client event to entity owner
                if vehicleData.vehicle then
                    local mods = json.decode(vehicleData.vehicle)
                    if mods and next(mods) then
                        -- Get network ID while vehicle entity is still valid on server
                        local vehNetId = NetworkGetNetworkIdFromEntity(vehicle)
                        if vehNetId and vehNetId > 0 then
                            -- Wait a frame for network propagation, then send to requesting client
                            Wait(100)
                            TriggerClientEvent('ox_lib:setVehicleProperties', source, vehNetId, mods)
                        end
                    end
                end

                -- Set saved plate
                if vehicleData.plate then
                    SetVehicleNumberPlateText(vehicle, vehicleData.plate)
                end
            end
        end)
    else
        MySQL.Async.fetchAll('SELECT mods, plate FROM player_vehicles WHERE citizenid = ? AND vehicle = ? AND garage LIKE ?', {
            identifier,
            vehicleModel,
            'job_' .. jobName
        }, function(result)
            if result and #result > 0 then
                local vehicleData = result[1]

                -- Apply saved modifications via client callback
                if vehicleData.mods then
                    local mods = json.decode(vehicleData.mods)
                    if mods and next(mods) then
                        -- Wait for network propagation (a few frames)
                        Wait(250)

                        -- Get network ID from entity
                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                        if netId and netId > 0 then
                            -- Use callback to apply properties on client side
                            -- Don't block on this, just fire and forget with pcall for safety
                            CreateThread(function()
                                local success, callbackResult = pcall(function()
                                    return lib.callback.await('garage:client:setVehicleProperties', source, netId, mods)
                                end)

                                if success and callbackResult then
                                    LogDebug("Vehicle properties applied successfully for job vehicle", "job-vehicles")
                                elseif success and not callbackResult then
                                    LogDebug("Failed to apply vehicle properties for job vehicle (callback returned false)", "job-vehicles")
                                else
                                    LogDebug("Error applying vehicle properties for job vehicle: " .. tostring(callbackResult), "job-vehicles")
                                end
                            end)
                        else
                            LogDebug("Failed to get network ID for job vehicle", "job-vehicles")
                        end
                    end
                end

                -- Set saved plate
                if vehicleData.plate then
                    SetVehicleNumberPlateText(vehicle, vehicleData.plate)
                end
            end
        end)
    end
end

-- Generate unique plate for job vehicle
function JobVehicleManager.GenerateJobVehiclePlate(vehicleModel, jobName)
    local jobPrefix = string.upper(string.sub(jobName, 1, 2))
    local vehiclePrefix = string.upper(string.sub(vehicleModel, 1, 2))
    local randomNum = math.random(100, 999)

    return jobPrefix .. vehiclePrefix .. randomNum
end

-- Track active job vehicle
function JobVehicleManager.TrackActiveVehicle(source, vehicle, vehicleModel, jobName, plate)
    local vehicleKey = tostring(vehicle)

    ActiveJobVehicles[vehicleKey] = {
        source = source,
        vehicle = vehicle,
        model = vehicleModel,
        jobName = jobName,
        plate = plate,
        spawnTime = GetGameTimer()
    }
end

-- Get player's active vehicle count
function JobVehicleManager.GetPlayerActiveVehicleCount(source)
    local count = 0
    for _, data in pairs(ActiveJobVehicles) do
        if data.source == source then
            count = count + 1
        end
    end
    return count
end

-- Get player's license2 identifier
function JobVehicleManager.GetPlayerLicense2(source)
    local identifiers = GetPlayerIdentifiers(source)

    for _, v in pairs(identifiers) do
        if string.find(v, "license2") then
            return v
        end
    end

    return nil
end

-- Return job vehicle with property saving
function JobVehicleManager.ReturnJobVehicle(source, vehicle)
    local vehicleKey = tostring(vehicle)
    local vehicleData = ActiveJobVehicles[vehicleKey]

    if not vehicleData or vehicleData.source ~= source then
        return { success = false, error = "Vehicle not found or not owned by player" }
    end

    -- Request vehicle properties from client and save them
    local vehNetId = NetworkGetNetworkIdFromEntity(vehicle)
    TriggerClientEvent('dusa-garage:client:saveJobVehicleProperties', source, vehNetId, vehicleData.model, vehicleData.jobName)

    -- Remove from active tracking
    ActiveJobVehicles[vehicleKey] = nil

    -- Delete the vehicle
    DeleteEntity(vehicle)

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["vehicle-operations"] then
        print("^2[Dusa Garage]^7 Returned job vehicle " .. vehicleData.model .. " for player " .. source)
    end

    return { success = true }
end

-- Save vehicle properties to database (called via callback from client)
function JobVehicleManager.SaveVehicleProperties(vehicle, source, vehicleModel, jobName, vehicleProps)
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    local identifier = Player.Identifier

    -- Use provided vehicle properties (passed from client callback)
    -- If not provided, we can't get them server-side, so skip the update
    if not vehicleProps then
        LogDebug("No vehicle properties provided for save, skipping", "vehicle-operations")
        return
    end

    -- Get plate from vehicle entity or from properties
    local plate
    if vehicle and vehicle ~= 0 then
        plate = GetVehicleNumberPlateText(vehicle)
    elseif vehicleProps.plate then
        plate = vehicleProps.plate
    else
        LogDebug("No plate available for vehicle save, skipping", "vehicle-operations")
        return
    end

    if Bridge.Framework == "esx" then
        MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = ? WHERE owner = ? AND job = ? AND plate = ?', {
            json.encode(vehicleProps),
            identifier,
            jobName,
            plate
        })
    else
        MySQL.Async.execute('UPDATE player_vehicles SET mods = ? WHERE citizenid = ? AND vehicle = ? AND garage LIKE ?', {
            json.encode(vehicleProps),
            identifier,
            vehicleModel,
            'job_' .. jobName
        })
    end
end

-- Setup cleanup timer for abandoned vehicles
function JobVehicleManager.SetupCleanupTimer()
    CreateThread(function()
        while true do
            Wait(Config.JobVehicleLimits.CleanupInterval)
            JobVehicleManager.CleanupAbandonedVehicles()
        end
    end)
end

-- Cleanup abandoned job vehicles
function JobVehicleManager.CleanupAbandonedVehicles()
    local currentTime = GetGameTimer()
    local abandonedVehicles = {}

    for vehicleKey, data in pairs(ActiveJobVehicles) do
        local timeSinceSpawn = currentTime - data.spawnTime

        if timeSinceSpawn > Config.JobVehicleLimits.AbandonTimeout then
            -- Check if player is still online
            local Player = Framework.GetPlayer(data.source)
            if not Player then
                table.insert(abandonedVehicles, vehicleKey)
            end
        end
    end

    -- Clean up abandoned vehicles
    for _, vehicleKey in ipairs(abandonedVehicles) do
        local data = ActiveJobVehicles[vehicleKey]
        if DoesEntityExist(data.vehicle) then
            DeleteEntity(data.vehicle)
        end
        ActiveJobVehicles[vehicleKey] = nil

        if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
            print("^3[Dusa Garage]^7 Cleaned up abandoned job vehicle: " .. data.model)
        end
    end
end

-- Clear player cache on disconnect
function JobVehicleManager.OnPlayerDropped(source)
    -- Clear player job vehicle cache
    for cacheKey, _ in pairs(PlayerJobVehicles) do
        if string.find(cacheKey, "^" .. source .. ":") then
            PlayerJobVehicles[cacheKey] = nil
        end
    end

    -- Clean up active vehicles
    for vehicleKey, data in pairs(ActiveJobVehicles) do
        if data.source == source then
            if DoesEntityExist(data.vehicle) then
                JobVehicleManager.SaveVehicleProperties(data.vehicle, source, data.model, data.jobName)
                DeleteEntity(data.vehicle)
            end
            ActiveJobVehicles[vehicleKey] = nil
        end
    end
end

-- Export the module
return JobVehicleManager
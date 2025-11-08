-- Dusa Garage Management System - Vehicle Ownership Manager
-- Version: 1.0.0
-- Job vehicle ownership tracking and persistence

local VehicleOwnership = {}

-- Cache for quick ownership lookups
local OwnershipCache = {}

-- Initialize vehicle ownership manager
function VehicleOwnership.Init()
    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^2[Dusa Garage]^7 Initializing VehicleOwnership...")
    end

    -- Clear cache on resource start
    OwnershipCache = {}

    -- Register ownership tracking events
    VehicleOwnership.RegisterEvents()

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^2[Dusa Garage]^7 VehicleOwnership initialized successfully")
    end
end

-- Register ownership events
function VehicleOwnership.RegisterEvents()
    -- Player disconnect cleanup
    RegisterNetEvent('playerDropped')
    AddEventHandler('playerDropped', function(reason)
        local source = source
        VehicleOwnership.ClearPlayerCache(source)
    end)
end

-- Get player's license2 identifier
local function GetPlayerLicense(source)
    local identifiers = GetPlayerIdentifiers(source)

    for _, v in pairs(identifiers) do
        if string.find(v, "license2") then
            return v
        end
    end

    return nil
end

-- Check if player owns a specific job vehicle
function VehicleOwnership.IsJobVehicleOwned(source, vehicleModel, jobName)
    local Player = Framework.GetPlayer(source)
    local citizenId = Player.Identifier
    local cacheKey = citizenId .. ":" .. jobName .. ":" .. vehicleModel

    -- Check cache first
    if OwnershipCache[cacheKey] ~= nil then
        return OwnershipCache[cacheKey]
    end

    -- Query database
    local result = MySQL.Sync.fetchAll(
        'SELECT id, plate, created_at FROM player_vehicles WHERE citizenid = ? AND vehicle = ? AND source_type = ? AND job_name = ?',
        { citizenId, vehicleModel, 'job', jobName }
    )

    local isOwned = result and #result > 0
    local ownershipData = nil

    if isOwned then
        ownershipData = {
            id = result[1].id,
            plate = result[1].plate,
            createdAt = result[1].created_at,
            vehicleModel = vehicleModel,
            jobName = jobName
        }
    end

    -- Cache the result
    OwnershipCache[cacheKey] = {
        owned = isOwned,
        data = ownershipData,
        lastChecked = GetGameTimer()
    }

    return isOwned
end

-- Get ownership data for a job vehicle
function VehicleOwnership.GetJobVehicleOwnership(source, vehicleModel, jobName)
    local Player = Framework.GetPlayer(source)
    local citizenId = Player.Identifier
    local cacheKey = citizenId .. ":" .. jobName .. ":" .. vehicleModel

    -- Check cache first
    if OwnershipCache[cacheKey] and OwnershipCache[cacheKey].data then
        return OwnershipCache[cacheKey].data
    end

    -- Query database for full ownership data
    local result = MySQL.Sync.fetchAll(
        'SELECT * FROM player_vehicles WHERE citizenid = ? AND vehicle = ? AND source_type = ? AND job_name = ?',
        { citizenId, vehicleModel, 'job', jobName }
    )

    if result and #result > 0 then
        local data = result[1]
        local ownershipData = {
            id = data.id,
            plate = data.plate,
            mods = data.mods,
            garage = data.garage,
            fuel = data.fuel,
            engine = data.engine,
            body = data.body,
            state = data.state,
            originalGrade = data.original_grade,
            createdAt = data.created_at,
            updatedAt = data.updated_at,
            vehicleModel = vehicleModel,
            jobName = jobName
        }

        -- Update cache
        OwnershipCache[cacheKey] = {
            owned = true,
            data = ownershipData,
            lastChecked = GetGameTimer()
        }

        return ownershipData
    end

    return nil
end

-- Add first-time job vehicle ownership
function VehicleOwnership.AddJobVehicleOwnership(source, vehicleModel, plate, playerJob, vehicleProperties)
    local Player = Framework.GetPlayer(source)
    local citizenId = Player.Identifier

    -- Check if already owned to prevent duplicates
    if VehicleOwnership.IsJobVehicleOwned(source, vehicleModel, playerJob.name) then
        return {
            success = false,
            error = "Vehicle already owned"
        }
    end

    local vehicleData = {
        citizenid = citizenId,
        license = GetPlayerLicense(source),
        vehicle = vehicleModel,
        hash = GetHashKey(vehicleModel),
        mods = json.encode(vehicleProperties or {}),
        plate = plate,
        garage = 'job_' .. playerJob.name,
        fuel = 100,
        engine = 1000,
        body = 1000,
        state = 1, -- Available
        source_type = 'job',
        job_name = playerJob.name,
        original_grade = playerJob.grade
    }

    local success = MySQL.Sync.execute(
        'INSERT INTO player_vehicles (citizenid, license, vehicle, hash, mods, plate, garage, fuel, engine, body, state, source_type, job_name, original_grade) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        {
            vehicleData.citizenid,
            vehicleData.license,
            vehicleData.vehicle,
            vehicleData.hash,
            vehicleData.mods,
            vehicleData.plate,
            vehicleData.garage,
            vehicleData.fuel,
            vehicleData.engine,
            vehicleData.body,
            vehicleData.state,
            vehicleData.source_type,
            vehicleData.job_name,
            vehicleData.original_grade
        }
    )

    if success then
        -- Update cache
        local cacheKey = citizenId .. ":" .. playerJob.name .. ":" .. vehicleModel
        OwnershipCache[cacheKey] = {
            owned = true,
            data = {
                plate = plate,
                vehicleModel = vehicleModel,
                jobName = playerJob.name,
                originalGrade = playerJob.grade,
                createdAt = os.date('%Y-%m-%d %H:%M:%S')
            },
            lastChecked = GetGameTimer()
        }

        if Config.Debug.Enabled and Config.Debug.DefaultTopics["database"] then
            print("^2[Dusa Garage]^7 Added job vehicle ownership: " .. vehicleModel .. " for player " .. source .. " (" .. citizenId .. ")")
        end

        return {
            success = true,
            message = "Vehicle ownership added successfully",
            plate = plate
        }
    else
        return {
            success = false,
            error = "Failed to add vehicle ownership to database"
        }
    end
end

-- Update job vehicle properties (save modifications)
function VehicleOwnership.UpdateJobVehicleProperties(source, vehicleModel, jobName, vehicleProperties, additionalData)
    local Player = Framework.GetPlayer(source)
    local citizenId = Player.Identifier

    local updateData = {
        mods = json.encode(vehicleProperties or {}),
        fuel = additionalData and additionalData.fuel or 100,
        engine = additionalData and additionalData.engine or 1000,
        body = additionalData and additionalData.body or 1000
    }

    local success = MySQL.Sync.execute(
        'UPDATE player_vehicles SET mods = ?, fuel = ?, engine = ?, body = ?, updated_at = NOW() WHERE citizenid = ? AND vehicle = ? AND source_type = ? AND job_name = ?',
        {
            updateData.mods,
            updateData.fuel,
            updateData.engine,
            updateData.body,
            citizenId,
            vehicleModel,
            'job',
            jobName
        }
    )

    if success then
        -- Clear cache to force refresh on next check
        local cacheKey = citizenId .. ":" .. jobName .. ":" .. vehicleModel
        OwnershipCache[cacheKey] = nil

        if Config.Debug.Enabled and Config.Debug.DefaultTopics["database"] then
            print("^2[Dusa Garage]^7 Updated job vehicle properties: " .. vehicleModel .. " for player " .. source)
        end

        return {
            success = true,
            message = "Vehicle properties updated successfully"
        }
    else
        return {
            success = false,
            error = "Failed to update vehicle properties"
        }
    end
end

-- Get all job vehicles owned by a player
function VehicleOwnership.GetPlayerJobVehicles(source, jobName)
    local Player = Framework.GetPlayer(source)
    local citizenId = Player.Identifier

    local query = 'SELECT * FROM player_vehicles WHERE citizenid = ? AND source_type = ?'
    local params = { citizenId, 'job' }

    -- Add job filter if specified
    if jobName then
        query = query .. ' AND job_name = ?'
        table.insert(params, jobName)
    end

    query = query .. ' ORDER BY job_name, vehicle, created_at DESC'

    local result = MySQL.Sync.fetchAll(query, params)

    if not result then
        return {}
    end

    local vehicles = {}
    for _, vehicle in ipairs(result) do
        table.insert(vehicles, {
            id = vehicle.id,
            vehicle = vehicle.vehicle,
            plate = vehicle.plate,
            jobName = vehicle.job_name,
            originalGrade = vehicle.original_grade,
            garage = vehicle.garage,
            state = vehicle.state,
            fuel = vehicle.fuel,
            engine = vehicle.engine,
            body = vehicle.body,
            mods = vehicle.mods and json.decode(vehicle.mods) or {},
            createdAt = vehicle.created_at,
            updatedAt = vehicle.updated_at
        })
    end

    return vehicles
end

-- Transfer job vehicle ownership (for job changes)
function VehicleOwnership.TransferJobVehicleOwnership(source, vehicleModel, oldJobName, newJobName, newGrade)
    local Player = Framework.GetPlayer(source)
    local citizenId = Player.Identifier

    -- Check if vehicle is owned in old job
    if not VehicleOwnership.IsJobVehicleOwned(source, vehicleModel, oldJobName) then
        return {
            success = false,
            error = "Vehicle not owned in old job"
        }
    end

    -- Update job name and grade
    local success = MySQL.Sync.execute(
        'UPDATE player_vehicles SET job_name = ?, original_grade = ?, garage = ?, updated_at = NOW() WHERE citizenid = ? AND vehicle = ? AND source_type = ? AND job_name = ?',
        {
            newJobName,
            newGrade,
            'job_' .. newJobName,
            citizenId,
            vehicleModel,
            'job',
            oldJobName
        }
    )

    if success then
        -- Clear cache for both old and new job
        local oldCacheKey = citizenId .. ":" .. oldJobName .. ":" .. vehicleModel
        local newCacheKey = citizenId .. ":" .. newJobName .. ":" .. vehicleModel
        OwnershipCache[oldCacheKey] = nil
        OwnershipCache[newCacheKey] = nil

        if Config.Debug.Enabled and Config.Debug.DefaultTopics["database"] then
            print("^2[Dusa Garage]^7 Transferred job vehicle ownership: " .. vehicleModel .. " from " .. oldJobName .. " to " .. newJobName)
        end

        return {
            success = true,
            message = "Vehicle ownership transferred successfully"
        }
    else
        return {
            success = false,
            error = "Failed to transfer vehicle ownership"
        }
    end
end

-- Remove job vehicle ownership
function VehicleOwnership.RemoveJobVehicleOwnership(source, vehicleModel, jobName)
    local Player = Framework.GetPlayer(source)
    local citizenId = Player.Identifier

    local success = MySQL.Sync.execute(
        'DELETE FROM player_vehicles WHERE citizenid = ? AND vehicle = ? AND source_type = ? AND job_name = ?',
        {
            citizenId,
            vehicleModel,
            'job',
            jobName
        }
    )

    if success then
        -- Clear cache
        local cacheKey = citizenId .. ":" .. jobName .. ":" .. vehicleModel
        OwnershipCache[cacheKey] = nil

        if Config.Debug.Enabled and Config.Debug.DefaultTopics["database"] then
            print("^2[Dusa Garage]^7 Removed job vehicle ownership: " .. vehicleModel .. " for player " .. source)
        end

        return {
            success = true,
            message = "Vehicle ownership removed successfully"
        }
    else
        return {
            success = false,
            error = "Failed to remove vehicle ownership"
        }
    end
end

-- Get job vehicle statistics
function VehicleOwnership.GetJobVehicleStats(jobName)
    local query = 'SELECT vehicle, COUNT(*) as count FROM player_vehicles WHERE source_type = ?'
    local params = { 'job' }

    if jobName then
        query = query .. ' AND job_name = ?'
        table.insert(params, jobName)
    end

    query = query .. ' GROUP BY vehicle ORDER BY count DESC'

    local result = MySQL.Sync.fetchAll(query, params)

    if not result then
        return {}
    end

    local stats = {}
    for _, stat in ipairs(result) do
        stats[stat.vehicle] = stat.count
    end

    return stats
end

-- Clear player cache on disconnect
function VehicleOwnership.ClearPlayerCache(source)
    local Player = Framework.GetPlayer(source)
    local citizenId = Player.Identifier
    if not citizenId then return end

    -- Clear all cache entries for this player
    for cacheKey, _ in pairs(OwnershipCache) do
        if string.find(cacheKey, "^" .. citizenId .. ":") then
            OwnershipCache[cacheKey] = nil
        end
    end

    if Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^3[Dusa Garage]^7 Cleared ownership cache for player " .. source)
    end
end

-- Cache cleanup routine (run periodically)
function VehicleOwnership.CleanupCache()
    local currentTime = GetGameTimer()
    local maxAge = 300000 -- 5 minutes

    local cleanedCount = 0
    for cacheKey, data in pairs(OwnershipCache) do
        if data.lastChecked and (currentTime - data.lastChecked) > maxAge then
            OwnershipCache[cacheKey] = nil
            cleanedCount = cleanedCount + 1
        end
    end

    if cleanedCount > 0 and Config.Debug.Enabled and Config.Debug.DefaultTopics["system"] then
        print("^3[Dusa Garage]^7 Cleaned up " .. cleanedCount .. " expired ownership cache entries")
    end
end

-- Initialize cache cleanup timer
CreateThread(function()
    while true do
        Wait(300000) -- Run every 5 minutes
        VehicleOwnership.CleanupCache()
    end
end)

-- Export the module
return VehicleOwnership
-- Patreon Vehicle Granting System
-- Automatically grants vehicles when players get patreon jobs

if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then
    return
end

local function GetPatreonTierFromJob(jobName)
    if not Config.PatreonTiers.job_to_tier then
        return 0
    end
    
    if Config.PatreonTiers.job_to_tier[jobName] then
        return Config.PatreonTiers.job_to_tier[jobName]
    end
    
    return 0
end

-- Get the tier requirement for a vehicle model
local function GetVehicleTierRequirement(vehicleModel)
    if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE or not Config.PatreonTiers.tiers then
        return nil -- Not a patreon vehicle
    end
    
    local spawncode = tostring(vehicleModel):upper()
    local minTier = nil
    
    for tier, tierData in pairs(Config.PatreonTiers.tiers) do
        -- Check cars
        if tierData.cars then
            for i = 1, #tierData.cars do
                if tostring(tierData.cars[i]):upper() == spawncode then
                    minTier = (minTier and math.min(minTier, tier)) or tier
                end
            end
        end
        
        -- Check boats
        if tierData.boats then
            for i = 1, #tierData.boats do
                if tostring(tierData.boats[i]):upper() == spawncode then
                    minTier = (minTier and math.min(minTier, tier)) or tier
                end
            end
        end
        
        -- Check air vehicles
        if tierData.air then
            for i = 1, #tierData.air do
                if tostring(tierData.air[i]):upper() == spawncode then
                    minTier = (minTier and math.min(minTier, tier)) or tier
                end
            end
        end
    end
    
    return minTier
end

-- Check if a player can see a vehicle based on their patreon tier
-- patreon1 (tier 1) can see tier 1 vehicles
-- patreon2 (tier 2) can see tier 1 and 2 vehicles
-- patreon3 (tier 3) can see tier 1, 2, and 3 vehicles
local function CanPlayerSeeVehicle(source, vehicleModel)
    if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then
        return true -- If patreon system is disabled, show all vehicles
    end
    
    local vehicleTier = GetVehicleTierRequirement(vehicleModel)
    
    -- If vehicle is not a patreon vehicle, always show it
    if not vehicleTier then
        return true
    end
    
    -- Get player's patreon tier
    local jobName = GetJob(source)
    if not jobName then
        return false
    end
    
    local playerTier = GetPatreonTierFromJob(jobName)
    
    -- If player doesn't have a patreon job, hide patreon vehicles
    if playerTier == 0 then
        return false
    end
    
    -- Player can see vehicles from their tier and all lower tiers
    -- tier 1 sees tier 1
    -- tier 2 sees tier 1 and 2
    -- tier 3 sees tier 1, 2, and 3
    return vehicleTier <= playerTier
end

-- Export function for use in other files
exports('CanPlayerSeeVehicle', CanPlayerSeeVehicle)
exports('GetVehicleTierRequirement', GetVehicleTierRequirement)

local function GetVehicleTypeFromModel(model)
    -- Simple detection - you may need to enhance this
    local modelStr = tostring(model):lower()
    
    -- Check if it's a boat (common boat models)
    local boatModels = {'dinghy', 'jetmax', 'marquis', 'seashark', 'speeder', 'squalo', 'submersible', 'toro', 'tropic', 'tugboat'}
    for _, boat in ipairs(boatModels) do
        if modelStr:find(boat) then
            return 'boat'
        end
    end
    
    -- Check if it's an air vehicle (common air models)
    local airModels = {'frogger', 'maverick', 'buzzard', 'annihilator', 'swift', 'seasparrow', 'skylift', 'cargobob', 'valkyrie', 'hunter', 'savage', 'hydra', 'lazer', 'titan', 'cargoplane', 'velum', 'luxor', 'shamal', 'miljet', 'besra', 'cuban800', 'dodo', 'howard', 'mallard', 'stunt', 'titan', 'velum2', 'vestra'}
    for _, air in ipairs(airModels) do
        if modelStr:find(air) then
            return 'air'
        end
    end
    
    -- Default to car
    return 'car'
end

local function GetGarageForVehicleType(vehicleType)
    if vehicleType == 'boat' then
        return 'Patreon Harbor'
    elseif vehicleType == 'air' then
        return 'Patreon Airfield'
    else
        return 'Patreon Hub'
    end
end

local function GeneratePlate(prefix)
    prefix = prefix or 'PATREON'
    local plate = prefix
    local length = #plate
    local result = 8 - length
    
    if result > 0 then
        for i = 1, result do
            plate = plate .. math.random(0, 9)
        end
    end
    
    return plate
end

local function GrantPatreonVehicles(source, tier)
    if tier == 0 or not Config.PatreonTiers.tiers[tier] then
        if Config.PatreonTiers.DEBUG then
            print(string.format('[cd_garage] GrantPatreonVehicles: Invalid tier %d for player %d', tier, source))
        end
        return
    end
    
    local identifier = GetIdentifier(source)
    if not identifier then
        if Config.PatreonTiers.DEBUG then
            print(string.format('[cd_garage] GrantPatreonVehicles: No identifier for player %d', source))
        end
        return
    end
    
    local tierData = Config.PatreonTiers.tiers[tier]
    local jobName = GetJob(source)
    
    if not jobName then
        if Config.PatreonTiers.DEBUG then
            print(string.format('[cd_garage] GrantPatreonVehicles: No job name for player %d', source))
        end
        return
    end
    
    if Config.PatreonTiers.DEBUG then
        print(string.format('[cd_garage] GrantPatreonVehicles: Granting tier %d vehicles to player %d (identifier: %s, job: %s)', tier, source, identifier, jobName))
    end
    
    -- Get all vehicles this tier should have
    local vehiclesToGrant = {}
    
    -- Add cars
    if tierData.cars then
        for _, vehicleModel in ipairs(tierData.cars) do
            table.insert(vehiclesToGrant, {model = vehicleModel, type = 'car'})
        end
    end
    
    -- Add boats
    if tierData.boats then
        for _, vehicleModel in ipairs(tierData.boats) do
            table.insert(vehiclesToGrant, {model = vehicleModel, type = 'boat'})
        end
    end
    
    -- Add air vehicles
    if tierData.air then
        for _, vehicleModel in ipairs(tierData.air) do
            table.insert(vehiclesToGrant, {model = vehicleModel, type = 'air'})
        end
    end
    
    -- Check which vehicles the player already has (by model hash)
    local existingVehicles = {}
    local Result = DatabaseQuery('SELECT '..FW.vehicle_props..' FROM '..FW.vehicle_table..' WHERE '..FW.vehicle_identifier..'=@identifier AND job_personalowned=@jobName', {
        ['@identifier'] = identifier,
        ['@jobName'] = jobName
    })
    if Result then
        for _, veh in ipairs(Result) do
            local props = json.decode(veh[FW.vehicle_props])
            if props and props.model then
                local modelHash = tonumber(props.model)
                if modelHash then
                    existingVehicles[modelHash] = true
                end
            end
        end
    end
    
    -- Grant missing vehicles
    for _, vehData in ipairs(vehiclesToGrant) do
        local modelHash = GetHashKey(vehData.model)
        
        -- Check if player already has this vehicle (by model hash)
        if not existingVehicles[modelHash] then
            local vehicleType = vehData.type or GetVehicleTypeFromModel(vehData.model)
            local garageId = GetGarageForVehicleType(vehicleType)
            local plate = GeneratePlate('PATREON')
            
            -- Create default vehicle props
            local defaultProps = {
                model = modelHash,
                plate = plate,
                modEngine = -1,
                modBrakes = -1,
                modTransmission = -1,
                modSuspension = -1,
                modTurbo = false,
                modSmokeEnabled = false,
                modXenon = false,
                windowTint = 0,
                wheels = 0,
                modFrontWheels = -1,
                modBackWheels = -1,
                modSpoilers = -1,
                modFrontBumper = -1,
                modRearBumper = -1,
                modSideSkirt = -1,
                modExhaust = -1,
                modFrame = -1,
                modGrille = -1,
                modHood = -1,
                modFender = -1,
                modRightFender = -1,
                modRoof = -1,
                modHorns = -1,
                modArmor = -1,
                modPlateHolder = -1,
                modVanityPlate = -1,
                modTrimA = -1,
                modOrnaments = -1,
                modDashboard = -1,
                modDial = -1,
                modDoorSpeaker = -1,
                modSeats = -1,
                modSteeringWheel = -1,
                modShifterLeavers = -1,
                modAPlate = -1,
                modSpeakers = -1,
                modTrunk = -1,
                modHydrolic = -1,
                modEngineBlock = -1,
                modAirFilter = -1,
                modStruts = -1,
                modArchCover = -1,
                modAerials = -1,
                modTrimB = -1,
                modTank = -1,
                modWindows = -1,
                modLivery = -1,
                color1 = 0,
                color2 = 0,
                pearlescentColor = 0,
                wheelColor = 0,
                neonEnabled = {false, false, false, false},
                extras = {},
                neonColor = {255, 255, 255},
                tyreSmokeColor = {255, 255, 255},
                xenonColor = 0,
                bodyHealth = 1000.0,
                engineHealth = 1000.0,
                fuelLevel = 100.0,
                dirtLevel = 0.0,
            }
            
            -- Insert vehicle into database
            local propsJson = json.encode(defaultProps)
            
            if Config.Framework == 'esx' then
                DatabaseQuery('INSERT INTO '..FW.vehicle_table..' ('..FW.vehicle_identifier..', plate, '..FW.vehicle_props..', garage_id, garage_type, job_personalowned, in_garage) VALUES (@'..FW.vehicle_identifier..', @plate, @'..FW.vehicle_props..', @garage_id, @garage_type, @job_personalowned, @in_garage)', {
                    ['@'..FW.vehicle_identifier..''] = identifier,
                    ['@plate'] = plate,
                    ['@'..FW.vehicle_props..''] = propsJson,
                    ['@garage_id'] = garageId,
                    ['@garage_type'] = vehicleType,
                    ['@job_personalowned'] = jobName,
                    ['@in_garage'] = 1,
                })
            elseif Config.Framework == 'qbcore' then
                -- For QBCore, vehicle field should be the spawn name (model string)
                DatabaseQuery('INSERT INTO '..FW.vehicle_table..' ('..FW.vehicle_identifier..', plate, '..FW.vehicle_props..', garage_id, garage_type, job_personalowned, in_garage, license, hash, vehicle) VALUES (@'..FW.vehicle_identifier..', @plate, @'..FW.vehicle_props..', @garage_id, @garage_type, @job_personalowned, @in_garage, @license, @hash, @vehicle)', {
                    ['@'..FW.vehicle_identifier..''] = identifier,
                    ['@plate'] = plate,
                    ['@'..FW.vehicle_props..''] = propsJson,
                    ['@garage_id'] = garageId,
                    ['@garage_type'] = vehicleType,
                    ['@job_personalowned'] = jobName,
                    ['@in_garage'] = 1,
                    ['@license'] = GetIdentifier(source),
                    ['@hash'] = modelHash,
                    ['@vehicle'] = vehData.model
                })
            end
            
            if Config.PatreonTiers.DEBUG then
                print(string.format('[cd_garage] Granted patreon vehicle %s (plate: %s) to player %s (tier %d, job: %s)', vehData.model, plate, identifier, tier, jobName))
            end
        end
    end
end

local function RemovePatreonVehicles(source, oldTier, newTier, oldJobName)
    if newTier >= oldTier then
        return -- Player is upgrading, don't remove vehicles
    end
    
    local identifier = GetIdentifier(source)
    if not identifier then
        return
    end
    
    -- Use oldJobName if provided, otherwise get current job
    local jobName = oldJobName or GetJob(source)
    
    if not jobName then
        return
    end
    
    -- Get all vehicles that should be removed (vehicles from tiers higher than newTier)
    local vehiclesToRemove = {}
    
    for tier = newTier + 1, 4 do
        if Config.PatreonTiers.tiers[tier] then
            local tierData = Config.PatreonTiers.tiers[tier]
            
            if tierData.cars then
                for _, vehicleModel in ipairs(tierData.cars) do
                    table.insert(vehiclesToRemove, vehicleModel)
                end
            end
            
            if tierData.boats then
                for _, vehicleModel in ipairs(tierData.boats) do
                    table.insert(vehiclesToRemove, vehicleModel)
                end
            end
            
            if tierData.air then
                for _, vehicleModel in ipairs(tierData.air) do
                    table.insert(vehiclesToRemove, vehicleModel)
                end
            end
        end
    end
    
    -- Get all vehicles that should be kept (vehicles from tiers <= newTier)
    local vehiclesToKeep = {}
    if newTier > 0 and Config.PatreonTiers.tiers[newTier] then
        for tier = 1, newTier do
            if Config.PatreonTiers.tiers[tier] then
                local tierData = Config.PatreonTiers.tiers[tier]
                
                if tierData.cars then
                    for _, vehicleModel in ipairs(tierData.cars) do
                        table.insert(vehiclesToKeep, vehicleModel)
                    end
                end
                
                if tierData.boats then
                    for _, vehicleModel in ipairs(tierData.boats) do
                        table.insert(vehiclesToKeep, vehicleModel)
                    end
                end
                
                if tierData.air then
                    for _, vehicleModel in ipairs(tierData.air) do
                        table.insert(vehiclesToKeep, vehicleModel)
                    end
                end
            end
        end
    end
    
    -- Get new job name for updating vehicles that should be kept
    local newJobName = GetJob(source)
    
    -- Remove vehicles by checking vehicle props (check vehicles with old job name)
    local Result = DatabaseQuery('SELECT plate, '..FW.vehicle_props..' FROM '..FW.vehicle_table..' WHERE '..FW.vehicle_identifier..'=@identifier AND job_personalowned=@jobName', {
        ['@identifier'] = identifier,
        ['@jobName'] = jobName
    })
    if Result then
        for _, veh in ipairs(Result) do
            local props = json.decode(veh[FW.vehicle_props])
            if props and props.model then
                local modelHash = tonumber(props.model)
                local shouldRemove = false
                local vehicleModelToCheck = nil
                
                -- Check if this vehicle should be removed
                for _, vehicleModel in ipairs(vehiclesToRemove) do
                    local removeModelHash = GetHashKey(vehicleModel)
                    
                    if modelHash == removeModelHash then
                        shouldRemove = true
                        vehicleModelToCheck = vehicleModel
                        break
                    end
                end
                
                if shouldRemove then
                    -- Remove vehicle from higher tier
                    DatabaseQuery('DELETE FROM '..FW.vehicle_table..' WHERE plate=@plate', {
                        ['@plate'] = veh.plate
                    })
                    
                    if Config.PatreonTiers.DEBUG then
                        print(string.format('[cd_garage] Removed patreon vehicle %s (plate: %s) from player %s (tier changed from %d to %d)', vehicleModelToCheck, veh.plate, identifier, oldTier, newTier))
                    end
                elseif newJobName and newTier > 0 then
                    -- Check if this vehicle should be kept (update job_personalowned to new job)
                    for _, vehicleModel in ipairs(vehiclesToKeep) do
                        local keepModelHash = GetHashKey(vehicleModel)
                        
                        if modelHash == keepModelHash then
                            -- Update job_personalowned to new job name
                            DatabaseQuery('UPDATE '..FW.vehicle_table..' SET job_personalowned=@newJobName WHERE plate=@plate', {
                                ['@newJobName'] = newJobName,
                                ['@plate'] = veh.plate
                            })
                            
                            if Config.PatreonTiers.DEBUG then
                                print(string.format('[cd_garage] Updated patreon vehicle %s (plate: %s) job_personalowned from %s to %s (tier changed from %d to %d)', vehicleModel, veh.plate, jobName, newJobName, oldTier, newTier))
                            end
                            break
                        end
                    end
                end
            end
        end
    end
end

-- Hook into job changes
if Config.Framework == 'esx' then
    -- Grant vehicles when player loads if they already have a patreon job
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
        Wait(2000) -- Wait for player data to fully load
        local job = xPlayer.job
        if job and job.name then
            local tier = GetPatreonTierFromJob(job.name)
            if tier > 0 then
                GrantPatreonVehicles(playerId, tier)
            end
        end
    end)
    
    AddEventHandler('esx:setJob', function(source, job, lastJob)
        if not job or not job.name then
            return
        end
        
        local oldJobName = lastJob and lastJob.name or ''
        local oldTier = GetPatreonTierFromJob(oldJobName)
        local newTier = GetPatreonTierFromJob(job.name)
        
        if newTier > 0 then
            GrantPatreonVehicles(source, newTier)
        end
        
        if oldTier > 0 and newTier < oldTier then
            RemovePatreonVehicles(source, oldTier, newTier, oldJobName)
        end
    end)
    
elseif Config.Framework == 'qbcore' then
    -- Hook into player loaded - use multiple events for reliability
    AddEventHandler('QBCore:Server:OnPlayerLoaded', function(Player)
        CreateThread(function()
            Wait(3000) -- Wait for player data to fully load
            local source = Player.PlayerData.source
            local Player = QBCore.Functions.GetPlayer(source)
            if Player then
                local job = Player.PlayerData.job
                if job and job.name then
                    local tier = GetPatreonTierFromJob(job.name)
                    if tier > 0 then
                        if Config.PatreonTiers.DEBUG then
                            print(string.format('[cd_garage] Player %d loaded with patreon job %s (tier %d), granting vehicles...', source, job.name, tier))
                        end
                        GrantPatreonVehicles(source, tier)
                    end
                end
            end
        end)
    end)
    
    -- Also hook into QBCore player loaded event (alternative)
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        local source = source
        CreateThread(function()
            Wait(3000)
            local Player = QBCore.Functions.GetPlayer(source)
            if Player then
                local job = Player.PlayerData.job
                if job and job.name then
                    local tier = GetPatreonTierFromJob(job.name)
                    if tier > 0 then
                        GrantPatreonVehicles(source, tier)
                    end
                end
            end
        end)
    end)
    
    RegisterNetEvent('QBCore:Server:OnJobUpdate', function(source, job)
        if not job or not job.name then
            return
        end
        
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then
            return
        end
        
        local oldJob = Player.PlayerData.job
        local oldJobName = oldJob and oldJob.name or ''
        local oldTier = GetPatreonTierFromJob(oldJobName)
        local newTier = GetPatreonTierFromJob(job.name)
        
        if newTier > 0 then
            GrantPatreonVehicles(source, newTier)
        end
        
        if oldTier > 0 and newTier < oldTier then
            RemovePatreonVehicles(source, oldTier, newTier, oldJobName)
        end
    end)
    
    -- Also hook into the client job update event
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
        local source = source
        if not job or not job.name then
            return
        end
        
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then
            return
        end
        
        local oldJob = Player.PlayerData.job
        local oldJobName = oldJob and oldJob.name or ''
        local oldTier = GetPatreonTierFromJob(oldJobName)
        local newTier = GetPatreonTierFromJob(job.name)
        
        if newTier > 0 then
            GrantPatreonVehicles(source, newTier)
        end
        
        if oldTier > 0 and newTier < oldTier then
            RemovePatreonVehicles(source, oldTier, newTier, oldJobName)
        end
    end)
end

-- Fallback: Check and grant vehicles when opening patreon garage
RegisterNetEvent('cd_garage:CheckPatreonVehicles', function()
    local source = source
    local jobName = GetJob(source)
    if not jobName then
        return
    end
    
    local tier = GetPatreonTierFromJob(jobName)
    if tier > 0 then
        -- Check if player has any patreon vehicles
        local identifier = GetIdentifier(source)
        if identifier then
            local Result = DatabaseQuery('SELECT COUNT(*) as count FROM '..FW.vehicle_table..' WHERE '..FW.vehicle_identifier..'=@identifier AND job_personalowned=@jobName', {
                ['@identifier'] = identifier,
                ['@jobName'] = jobName
            })
            
            local vehicleCount = 0
            if Result and Result[1] then
                vehicleCount = tonumber(Result[1].count) or 0
            end
            
            -- If no vehicles found, grant them
            if vehicleCount == 0 then
                if Config.PatreonTiers.DEBUG then
                    print(string.format('[cd_garage] Player %d opened patreon garage but has no vehicles. Granting tier %d vehicles...', source, tier))
                end
                GrantPatreonVehicles(source, tier)
            end
        end
    end
end)

-- Admin command to manually grant vehicles
RegisterCommand('grantpatreonvehicles', function(source, args)
    if source == 0 then
        -- Console command
        local targetId = tonumber(args[1])
        if not targetId then
            print('Usage: grantpatreonvehicles [playerid]')
            return
        end
        
        local jobName = GetJob(targetId)
        if not jobName then
            print('Player not found or has no job')
            return
        end
        
        local tier = GetPatreonTierFromJob(jobName)
        if tier > 0 then
            GrantPatreonVehicles(targetId, tier)
            print(string.format('Granted patreon vehicles to player %d (job: %s, tier: %d)', targetId, jobName, tier))
        else
            print('Player does not have a patreon job')
        end
    else
        -- Player command - check admin perms
        -- Add your admin permission check here
        local targetId = tonumber(args[1]) or source
        local jobName = GetJob(targetId)
        if not jobName then
            return
        end
        
        local tier = GetPatreonTierFromJob(jobName)
        if tier > 0 then
            GrantPatreonVehicles(targetId, tier)
        end
    end
end, false)


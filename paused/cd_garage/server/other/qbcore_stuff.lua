if Config.Framework == 'qbcore' then
    -- Optimized debug function - completely disabled when debug is off
    local function DebugPrint(...)
        -- Early return if debug is disabled - no string operations or function calls
        if not Config.PatreonTiers or not Config.PatreonTiers.DEBUG then return end
        print('[Patreon Debug]', ...)
    end

    -- Resolve a player's Patreon tier (defined early so all other functions can use it safely)
    local function GetPlayerPatreonTier(Player)
        if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then
            return Config.PatreonTiers and Config.PatreonTiers.default_tier or 0
        end
        local mode = Config.PatreonTiers.lookup_mode
        if mode == 'metadata' then
            local md = Player.PlayerData.metadata or {}
            local key = Config.PatreonTiers.metadata_key or 'patreon_tier'
            local t = md[key]
            local tier
            if type(t) == 'number' then tier = t end
            if type(t) == 'string' then tier = tonumber(t) or Config.PatreonTiers.default_tier end
            DebugPrint('Tier lookup (metadata):', Player.PlayerData.citizenid, 'key=', key, 'value=', t, 'tierNum=', tier or 0)
            return tier or Config.PatreonTiers.default_tier
        elseif mode == 'job' then
            local job = (Player.PlayerData.job or {}).name
            local tier = Config.PatreonTiers.job_to_tier[job] or Config.PatreonTiers.default_tier
            DebugPrint('Tier lookup (job):', Player.PlayerData.citizenid, 'job=', job, 'tier=', tier)
            return tier
        elseif mode == 'group' then
            local perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
            if type(perms) == 'string' then
                local tier = Config.PatreonTiers.group_to_tier[perms] or Config.PatreonTiers.default_tier
                DebugPrint('Tier lookup (group-string):', Player.PlayerData.citizenid, 'group=', perms, 'tier=', tier)
                return tier
            elseif type(perms) == 'table' then
                for group, _ in pairs(perms) do
                    local t = Config.PatreonTiers.group_to_tier[group]
                    if t then DebugPrint('Tier lookup (group-table):', Player.PlayerData.citizenid, 'group=', group, 'tier=', t) return t end
                end
            end
            DebugPrint('Tier lookup (group): default')
        end
        return Config.PatreonTiers.default_tier
    end

    local function GenerateRandomPlate()
        local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
        local plate = ''
        for i = 1, 8 do
            local idx = math.random(#chars)
            plate = plate .. string.sub(chars, idx, idx)
        end
        return plate
    end

    -- Forward declare to allow use before definition
    local EnsurePatreonVehiclesForPlayer

    -- Auto-sync Patreon list on player load and on resource start (inline tier resolve to avoid any upvalue issues)
    local function SyncPlayerPatreonVehicles(src)
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        local tier
        if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then
            tier = Config.PatreonTiers and Config.PatreonTiers.default_tier or 0
        else
            local mode = Config.PatreonTiers.lookup_mode
            if mode == 'metadata' then
                local md = Player.PlayerData.metadata or {}
                local key = Config.PatreonTiers.metadata_key or 'patreon_tier'
                local t = md[key]
                if type(t) == 'number' then tier = t elseif type(t) == 'string' then tier = tonumber(t) or 0 else tier = 0 end
            elseif mode == 'job' then
                local job = (Player.PlayerData.job or {}).name
                tier = Config.PatreonTiers.job_to_tier[job] or 0
            elseif mode == 'group' then
                local perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
                if type(perms) == 'string' then
                    tier = Config.PatreonTiers.group_to_tier[perms] or 0
                elseif type(perms) == 'table' then
                    for group,_ in pairs(perms) do tier = Config.PatreonTiers.group_to_tier[group] if tier then break end end
                    tier = tier or 0
                else
                    tier = 0
                end
            else
                tier = 0
            end
        end
        DebugPrint('Sync Patreon vehicles for', Player.PlayerData.citizenid, 'tier=', tier)
        EnsurePatreonVehiclesForPlayer(src, Player, tier)
    end

    -- Function to remove vehicles that are no longer in the Patreon configuration from ALL players
    local function CleanupRemovedPatreonVehicles()
        if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then return end
        
        DebugPrint('Starting cleanup of removed Patreon vehicles...')
        
        -- Build list of all currently configured Patreon vehicles
        local tiers = Config.PatreonTiers.tiers or {}
        local currentVehicles = {}
        for t, data in pairs(tiers) do
            -- Handle cars
            for i = 1, #(data.cars or {}) do
                local v = tostring(data.cars[i])
                currentVehicles[v] = 'car'
            end
            
            -- Handle boats
            for i = 1, #(data.boats or {}) do
                local v = tostring(data.boats[i])
                currentVehicles[v] = 'boat'
            end
            
            -- Handle air vehicles
            for i = 1, #(data.air or {}) do
                local v = tostring(data.air[i])
                currentVehicles[v] = 'air'
            end
        end
        
        DebugPrint('Current Patreon vehicles in config:', table.concat(table.keys(currentVehicles), ', '))
        
        -- Find all vehicles in player_vehicles that are marked as Patreon but no longer in config
        -- Check all Patreon garage types
        local patreonGarages = {'Patreon Hub', 'Patreon Harbor', 'Patreon Airfield'}
        local garageCondition = ''
        for i, garage in ipairs(patreonGarages) do
            garageCondition = garageCondition .. (i == 1 and '' or ' OR ') .. 'garage_id = "' .. garage .. '"'
        end
        
        local allPatreonVehicles = DatabaseQuery('SELECT DISTINCT vehicle FROM player_vehicles WHERE ' .. garageCondition)
        
        if allPatreonVehicles and allPatreonVehicles[1] then
            local vehiclesToRemove = {}
            local removedCount = 0
            
            for i = 1, #allPatreonVehicles do
                local veh = tostring(allPatreonVehicles[i].vehicle)
                if not currentVehicles[veh] then
                    vehiclesToRemove[#vehiclesToRemove + 1] = veh
                    DebugPrint('Marking for removal (no longer in config):', veh)
                end
            end
            
            -- Remove vehicles that are no longer in the Patreon configuration
            if #vehiclesToRemove > 0 then
                for i = 1, #vehiclesToRemove do
                    local veh = vehiclesToRemove[i]
                    
                    -- Get all plates for this vehicle across all players in Patreon garages
                    local plates = DatabaseQuery('SELECT plate FROM player_vehicles WHERE vehicle = "'..veh..'" AND (' .. garageCondition .. ')')
                    
                    if plates and plates[1] then
                        local plateList = {}
                        for j = 1, #plates do
                            plateList[#plateList + 1] = plates[j].plate
                        end
                        
                        -- Build IN clause for plates
                        local inPlates = ''
                        for j = 1, #plateList do
                            inPlates = inPlates .. (j == 1 and '"' or ',"') .. tostring(plateList[j]) .. '"'
                        end
                        
                        -- Remove from player_vehicles
                        DatabaseQuery('DELETE FROM player_vehicles WHERE plate IN ('..inPlates..')')
                        
                        -- Remove from garage keys
                        DatabaseQuery('DELETE FROM cd_garage_keys WHERE plate IN ('..inPlates..')')
                        
                        removedCount = removedCount + #plateList
                        DebugPrint('Removed vehicle', veh, 'with', #plateList, 'plates from all players')
                    end
                end
                
                DebugPrint('Cleanup complete. Removed', removedCount, 'total vehicles that were no longer in Patreon config')
            else
                DebugPrint('No vehicles to remove - all Patreon vehicles are still in config')
            end
        else
            DebugPrint('No Patreon vehicles found in database to check')
        end
    end

    -- Helper function to get table keys
    function table.keys(t)
        local keys = {}
        for k, _ in pairs(t) do
            keys[#keys + 1] = k
        end
        return keys
    end

    -- Function to determine vehicle type based on spawncode
    local function GetVehicleType(spawncode)
        if not spawncode then return 'car' end
        
        local code = tostring(spawncode):lower()
        
        -- Air vehicles (helicopters, planes)
        local airVehicles = {
            'frogger', 'maverick', 'buzzard', 'annihilator', 'valkyrie', 'valkyrie2', 'volatus',
            'supervolito', 'supervolito2', 'swift', 'swift2', 'luxor', 'luxor2', 'titan', 'shamal',
            'dodo', 'duster', 'stunt', 'mammatus', 'jet', 'lazer', 'hydra', 'besra', 'miljet',
            'nimbus', 'rogue', 'starling', 'strikeforce', 'tula', 'alkonost', 'bombushka',
            'pyro', 'molotok', 'nokota', 'starlight', 'strikeforce', 'tula', 'alkonost'
        }
        
        -- Boat vehicles
        local boatVehicles = {
            'dinghy', 'dinghy2', 'dinghy3', 'dinghy4', 'jetmax', 'marquis', 'seashark',
            'seashark2', 'seashark3', 'speeder', 'speeder2', 'squalo', 'suntrap', 'toro',
            'toro2', 'tropic', 'tropic2', 'tropic3', 'phantom', 'patrolboat', 'submersible',
            'submersible2', 'tug', 'yacht', 'yacht2', 'yacht3', 'yacht4', 'yacht5'
        }
        
        for _, vehicle in ipairs(airVehicles) do
            if code == vehicle then
                return 'air'
            end
        end
        
        for _, vehicle in ipairs(boatVehicles) do
            if code == vehicle then
                return 'boat'
            end
        end
        
        -- Default to car for everything else
        return 'car'
    end

    -- Function to get appropriate garage ID based on vehicle type
    local function GetPatreonGarageId(vehicleType)
        local garageMap = {
            car = 'Patreon Hub',
            boat = 'Patreon Harbor',
            air = 'Patreon Airfield'
        }
        return garageMap[vehicleType] or 'Patreon Hub'
    end

    AddEventHandler('QBCore:Server:PlayerLoaded', function(player)
        local src = type(player) == 'table' and player.PlayerData and player.PlayerData.source or player or source
        if src then 
            -- Add a small delay to ensure all player data is loaded
            CreateThread(function()
                Wait(1000)
                pcall(SyncPlayerPatreonVehicles, src)
            end)
        end
    end)

    -- Defer initial sync to avoid early init issues
    CreateThread(function()
        Wait(5000)
        
        -- First, clean up any vehicles that are no longer in the Patreon configuration
        CleanupRemovedPatreonVehicles()
        
        -- Then sync vehicles for all online players
        for _, src in pairs(QBCore.Functions.GetPlayers()) do
            pcall(SyncPlayerPatreonVehicles, src)
        end
    end)

    local function CreateUniquePlate()
        local tries = 0
        while tries < 50 do
            local p = GenerateRandomPlate()
            local r = DatabaseQuery('SELECT plate FROM player_vehicles WHERE plate="'..p..'"')
            if not r or not r[1] then return p end
            tries = tries + 1
        end
        -- Absolute fallback: 8 char plate from hex
        return string.upper(string.sub(string.format('%08x', math.random(0, 0xffffffff)), 1, 8))
    end

    EnsurePatreonVehiclesForPlayer = function(src, Player, tier)
        if not (Config.PatreonTiers and Config.PatreonTiers.ENABLE) then return 0 end
        local citizenid = Player.PlayerData.citizenid
        local license = QBCore.Functions.GetIdentifier(src, Config.IdentifierType)
        local tiers = Config.PatreonTiers.tiers or {}
        local inherit = Config.PatreonTiers.inherit ~= false
        local toGrant = {}
        local allowedSet = {}
        local allSet = {}
        
        -- Build complete list of all Patreon vehicles and allowed vehicles for current tier
        for t, data in pairs(tiers) do
            -- Handle cars
            for i = 1, #(data.cars or {}) do
                local v = tostring(data.cars[i])
                allSet[v] = 'car'
                if (inherit and t <= (tonumber(tier or 0) or 0)) or (not inherit and t == (tonumber(tier or 0) or 0)) then
                    allowedSet[v] = 'car'
                end
            end
            
            -- Handle boats
            for i = 1, #(data.boats or {}) do
                local v = tostring(data.boats[i])
                allSet[v] = 'boat'
                if (inherit and t <= (tonumber(tier or 0) or 0)) or (not inherit and t == (tonumber(tier or 0) or 0)) then
                    allowedSet[v] = 'boat'
                end
            end
            
            -- Handle air vehicles
            for i = 1, #(data.air or {}) do
                local v = tostring(data.air[i])
                allSet[v] = 'air'
                if (inherit and t <= (tonumber(tier or 0) or 0)) or (not inherit and t == (tonumber(tier or 0) or 0)) then
                    allowedSet[v] = 'air'
                end
            end
        end
        
        -- Only grant vehicles if tier > 0
        if tier and tier > 0 then
            if inherit then
                for t = 1, tonumber(tier or 0) do
                    local carList = (tiers[t] and tiers[t].cars) or {}
                    local boatList = (tiers[t] and tiers[t].boats) or {}
                    local airList = (tiers[t] and tiers[t].air) or {}
                    
                    for i = 1, #carList do 
                        toGrant[#toGrant+1] = {vehicle = tostring(carList[i]), type = 'car'}
                    end
                    for i = 1, #boatList do 
                        toGrant[#toGrant+1] = {vehicle = tostring(boatList[i]), type = 'boat'}
                    end
                    for i = 1, #airList do 
                        toGrant[#toGrant+1] = {vehicle = tostring(airList[i]), type = 'air'}
                    end
                end
            else
                local carList = (tiers[tier] and tiers[tier].cars) or {}
                local boatList = (tiers[tier] and tiers[tier].boats) or {}
                local airList = (tiers[tier] and tiers[tier].air) or {}
                
                for i = 1, #carList do 
                    toGrant[#toGrant+1] = {vehicle = tostring(carList[i]), type = 'car'}
                end
                for i = 1, #boatList do 
                    toGrant[#toGrant+1] = {vehicle = tostring(boatList[i]), type = 'boat'}
                end
                for i = 1, #airList do 
                    toGrant[#toGrant+1] = {vehicle = tostring(airList[i]), type = 'air'}
                end
            end
        end
        
        local granted = 0
        if #toGrant == 0 then
            DebugPrint('No Patreon vehicles to grant for tier', tier)
        else
            for i = 1, #toGrant do
                local spawn = toGrant[i].vehicle
                local vehicleType = toGrant[i].type
                local check = DatabaseQuery('SELECT plate FROM player_vehicles WHERE citizenid="'..citizenid..'" AND vehicle="'..spawn..'" LIMIT 1')
                if not check or not check[1] then
                    local plate = CreateUniquePlate()
                    local modelHash = GetHashKey(spawn)
                    local props = json.encode({plate = plate, model = modelHash, fuelLevel = 100.0, engineHealth = 1000.0, bodyHealth = 1000.0})
                    local garageId = GetPatreonGarageId(vehicleType)
                    
                    DatabaseQuery('INSERT INTO player_vehicles (citizenid, plate, mods, garage_type, in_garage, license, hash, vehicle, garage_id) VALUES (@owner, @plate, @mods, @garage_type, @in_garage, @license, @hash, @vehicle, @garage_id)',
                    {
                        ['@owner'] = citizenid,
                        ['@plate'] = plate,
                        ['@mods'] = props,
                        ['@garage_type'] = vehicleType,
                        ['@in_garage'] = 1,
                        ['@license'] = license,
                        ['@hash'] = modelHash,
                        ['@vehicle'] = spawn,
                        ['@garage_id'] = garageId
                    })
                    granted = granted + 1
                    DebugPrint('Granted Patreon vehicle', spawn, 'plate', plate, 'to', citizenid, 'type', vehicleType, 'garage', garageId)
                else
                    DebugPrint('Already owned', spawn)
                end
            end
        end

        -- CRITICAL: Remove ALL Patreon vehicles that are no longer allowed
        -- This handles deranking from any tier to a lower tier, including to 0
        local allList = {}
        for v, vType in pairs(allSet) do allList[#allList+1] = {vehicle = v, type = vType} end
        
        if #allList > 0 then
            local inList = ''
            for i = 1, #allList do 
                inList = inList .. (i==1 and '"' or ',"') .. tostring(allList[i].vehicle) .. '"' 
            end
            
            -- Get all Patreon vehicles owned by this player
            local owned = DatabaseQuery('SELECT plate, vehicle FROM player_vehicles WHERE citizenid="'..citizenid..'" AND vehicle IN ('..inList..')')
            local platesToRemove = {}
            
            DebugPrint('Checking Patreon vehicles for', citizenid, 'tier=', tier, 'total vehicles in tiers=', #allList)
            
            if owned and owned[1] then
                DebugPrint('Player owns', #owned, 'Patreon vehicles')
                for i = 1, #owned do
                    local row = owned[i]
                    local veh = tostring(row.vehicle)
                    
                    -- Remove vehicle if:
                    -- 1. Player tier is 0 (remove ALL Patreon vehicles)
                    -- 2. Vehicle is not in allowed set for current tier (deranking scenario)
                    if (tier == 0) or (not allowedSet[veh]) then
                        platesToRemove[#platesToRemove+1] = row.plate
                        DebugPrint('Marking for removal:', veh, 'tier=', tier, 'allowed=', allowedSet[veh] and 'yes' or 'no')
                    else
                        DebugPrint('Keeping vehicle:', veh, 'tier=', tier, 'allowed=yes')
                    end
                end
            else
                DebugPrint('Player owns no Patreon vehicles')
            end
            
            -- Execute removal of disallowed vehicles
            if #platesToRemove > 0 then
                local inPlate = ''
                for i = 1, #platesToRemove do 
                    inPlate = inPlate .. (i==1 and '"' or ',"') .. tostring(platesToRemove[i]) .. '"' 
                end
                
                -- Remove from player_vehicles table
                DatabaseQuery('DELETE FROM player_vehicles WHERE citizenid="'..citizenid..'" AND plate IN ('..inPlate..')')
                
                -- Remove from garage keys table
                DatabaseQuery('DELETE FROM cd_garage_keys WHERE plate IN ('..inPlate..')')
                
                DebugPrint('Removed disallowed Patreon vehicles for', citizenid, 'tier=', tier, 'plates=', table.concat(platesToRemove, ','))
                
                -- Notify player about removed vehicles
                if #platesToRemove > 0 then
                    local msg = ('Removed %d Patreon vehicles due to tier change to %d'):format(#platesToRemove, tier)
                    TriggerClientEvent('QBCore:Notify', src, msg, 'error')
                    DebugPrint('Notified player about removed vehicles:', msg)
                end
            else
                DebugPrint('No Patreon vehicles to remove for', citizenid, 'tier=', tier)
            end
        else
            DebugPrint('No Patreon vehicles configured in tiers')
        end
        
        return granted
    end

    

    local function IsVehicleAllowedByTier(spawnCode, tier)
        if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then return true end
        if not spawnCode then return true end
        
        -- Cache the tiers table to avoid repeated lookups
        local tiers = Config.PatreonTiers.tiers
        local inherit = Config.PatreonTiers.inherit ~= false
        
        local code = tostring(spawnCode):upper()
        -- Allow all vehicles by default unless explicitly listed in any tier table
        -- If the code appears in any tier, enforce min-tier requirement
        local appearsInAnyTier = false
        local minTier = nil
        
        for t, data in pairs(tiers) do
            -- Check cars
            local carList = (data and data.cars) or {}
            for i = 1, #carList do
                if tostring(carList[i]):upper() == code then
                    appearsInAnyTier = true
                    minTier = (minTier and math.min(minTier, t)) or t
                end
            end
            
            -- Check boats
            local boatList = (data and data.boats) or {}
            for i = 1, #boatList do
                if tostring(boatList[i]):upper() == code then
                    appearsInAnyTier = true
                    minTier = (minTier and math.min(minTier, t)) or t
                end
            end
            
            -- Check air vehicles
            local airList = (data and data.air) or {}
            for i = 1, #airList do
                if tostring(airList[i]):upper() == code then
                    appearsInAnyTier = true
                    minTier = (minTier and math.min(minTier, t)) or t
                end
            end
        end
        
        if not appearsInAnyTier then return true end
        if inherit then
            return (tonumber(tier or 0) or 0) >= (minTier or 1)
        else
            return (tonumber(tier or 0) or 0) == (minTier or 1)
        end
    end

    local function IsVehicleInAnyTier(spawnCode)
        if not Config.PatreonTiers or not Config.PatreonTiers.tiers then return false end
        if not spawnCode then return false end
        
        -- Cache the tiers table to avoid repeated lookups
        local tiers = Config.PatreonTiers.tiers
        local code = tostring(spawnCode):upper()
        
        for _, data in pairs(tiers) do
            -- Check cars
            local carList = (data and data.cars) or {}
            for i = 1, #carList do
                if tostring(carList[i]):upper() == code then return true end
            end
            
            -- Check boats
            local boatList = (data and data.boats) or {}
            for i = 1, #boatList do
                if tostring(boatList[i]):upper() == code then return true end
            end
            
            -- Check air vehicles
            local airList = (data and data.air) or {}
            for i = 1, #airList do
                if tostring(airList[i]):upper() == code then return true end
            end
        end
        return false
    end

    QBCore.Functions.CreateCallback('qb-garage:server:GetPlayerVehicles', function(source, cb)
        local Player = QBCore.Functions.GetPlayer(source)
        local Vehicles = {}
        local Result = DatabaseQuery('SELECT * FROM player_vehicles WHERE citizenid="'..Player.PlayerData.citizenid..'"')
        -- Resolve tier inline to avoid any load-order issues
        local playerTier
        do
            if not Config.PatreonTiers or not Config.PatreonTiers.ENABLE then
                playerTier = Config.PatreonTiers and Config.PatreonTiers.default_tier or 0
            else
                local mode = Config.PatreonTiers.lookup_mode
                if mode == 'metadata' then
                    local md = Player.PlayerData.metadata or {}
                    local key = Config.PatreonTiers.metadata_key or 'patreon_tier'
                    local t = md[key]
                    if type(t) == 'number' then playerTier = t elseif type(t) == 'string' then playerTier = tonumber(t) or 0 else playerTier = 0 end
                elseif mode == 'job' then
                    local job = (Player.PlayerData.job or {}).name
                    playerTier = Config.PatreonTiers.job_to_tier[job] or 0
                elseif mode == 'group' then
                    local perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
                    if type(perms) == 'string' then
                        playerTier = Config.PatreonTiers.group_to_tier[perms] or 0
                    elseif type(perms) == 'table' then
                        for group,_ in pairs(perms) do playerTier = Config.PatreonTiers.group_to_tier[group] if playerTier then break end end
                        playerTier = playerTier or 0
                    else
                        playerTier = 0
                    end
                else
                    playerTier = 0
                end
            end
        end
        DebugPrint('GetPlayerVehicles rows:', Player.PlayerData.citizenid, Result and #Result or 0, 'tier=', playerTier)

        -- Optimize: Check Patreon garage proximity once, not for every vehicle
        local nearPatreon = false
        if Result and Result[1] then
            local ped = GetPlayerPed(source)
            if ped and ped ~= 0 then
                local coords = GetEntityCoords(ped)
                for i = 1, #Config.Locations do
                    local g = Config.Locations[i]
                    if g and g.PatreonTierRequired ~= nil then
                        local dist = #(coords - vector3(g.x_1, g.y_1, g.z_1))
                        if dist <= (g.Dist or 10.0) then
                            nearPatreon = true
                            break
                        end
                    end
                end
            end
        end

        if Result and Result[1] then
            for k, v in pairs(Result) do
                local VehicleData = QBCore.Shared.Vehicles[v.vehicle]
                if VehicleData then
                    if nearPatreon then
                        -- Only show Patreon vehicles, anchored to Patreon garages, within your tier
                        local isPatreonGarage = (v.garage_id == 'Patreon Hub' or v.garage_id == 'Patreon Harbor' or v.garage_id == 'Patreon Airfield')
                        if not isPatreonGarage then goto continue end
                        if not IsVehicleInAnyTier(v.vehicle) then goto continue end
                        if not IsVehicleAllowedByTier(v.vehicle, playerTier) then goto continue end
                    else
                        -- Outside Patreon: hide all Patreon vehicles and anything in Patreon garages
                        local isPatreonGarage = (v.garage_id == 'Patreon Hub' or v.garage_id == 'Patreon Harbor' or v.garage_id == 'Patreon Airfield')
                        if isPatreonGarage then goto continue end
                        if IsVehicleInAnyTier(v.vehicle) then goto continue end
                    end
                    if v.impound == 1 then
                        v.state = json.decode(v.impound_data).impound_label
                    else
                        if v.in_garage then
                            v.state = 'Garaged'
                        else
                            v.state = 'Out'
                        end
                    end

                    -- Patreon tier gating: completely hide vehicles that player doesn't have access to
                    local spawncode = v.vehicle or (VehicleData and VehicleData.model)
                    local allowed = IsVehicleAllowedByTier(spawncode, playerTier)
                    
                    -- Skip this vehicle entirely if player doesn't have access to it
                    if not allowed then
                        DebugPrint('Hiding Patreon vehicle:', v.vehicle, 'tier=', playerTier, 'allowed=false')
                        goto continue
                    end

                    local fullname
                    if VehicleData["brand"] ~= nil then
                        fullname = VehicleData["brand"] .. " " .. VehicleData["name"]
                    else
                        fullname = VehicleData["name"]
                    end
                    local props = json.decode(v.mods)
                    Vehicles[#Vehicles+1] = {
                        fullname = fullname,
                        brand = VehicleData["brand"],
                        model = VehicleData["name"],
                        plate = v.plate,
                        garage = v.garage_id,
                        state = v.state, -- No need for 'Patreon Locked' since we're hiding them
                        fuel = props and props.fuelLevel or nil,
                        engine = props and props.engineHealth or nil,
                        body = props and props.bodyHealth or nil
                    }
                    DebugPrint('List item:', v.vehicle, 'allowed=', allowed, 'nearPatreon=', nearPatreon, 'state=', Vehicles[#Vehicles].state)
                else
                    print('^1[error_code-1975]')
                    print('Codesign Vehicle Missing: '..tostring(v.vehicle))
                end
                ::continue::
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)

    -- Simple admin command to set a player's Patreon tier metadata for testing
    RegisterCommand('setpatreontier', function(src, args)
        -- Admin-only command - check permissions first
        local isAllowed = false
        if QBCore.Functions.HasPermission then
            isAllowed = QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god')
        else
            local sourcePerms = QBCore.Functions.GetPermission(src)
            if type(sourcePerms) == 'string' then
                isAllowed = (sourcePerms == 'admin' or sourcePerms == 'god')
            elseif type(sourcePerms) == 'table' then
                isAllowed = (sourcePerms['admin'] == true or sourcePerms['god'] == true)
            end
        end
        if not isAllowed then
            Notification(src, 3, L('no_permissions'))
            TriggerClientEvent('chat:addMessage', src, { args = { 'System', L('no_permissions') } })
            return
            end
            
            -- Parse arguments
            local target, tier
            if #args == 1 then
                -- Only tier provided, set for self
                target = src
                tier = tonumber(args[1] or '0') or 0
            elseif #args == 2 then
                -- Player ID and tier provided
                target = tonumber(args[1]) or src
                tier = tonumber(args[2] or '0') or 0
            else
                -- Invalid usage
            TriggerClientEvent('chat:addMessage', src, { args = { 'System', 'Usage: /setpatreontier <tier> or /setpatreontier <id> <tier>' } })
                return
            end

            if tier < 0 then tier = 0 end
        if tier > 4 then tier = 4 end

            local Player = QBCore.Functions.GetPlayer(target)
            if not Player then
            Notification(src, 3, L('invalid_playerid'))
            TriggerClientEvent('chat:addMessage', src, { args = { 'System', L('invalid_playerid') } })
                return
            end
            local key = (Config.PatreonTiers and Config.PatreonTiers.metadata_key) or 'patreon_tier'
            Player.Functions.SetMetaData(key, tier)

        -- Sync vehicles for target (grant missing + remove disallowed)
        local created = EnsurePatreonVehiclesForPlayer(target, Player, tier)

            -- Try to force-save immediately if available
            if Player.Functions.Save then
                Player.Functions.Save()
            elseif QBCore.Functions.SavePlayer then
                QBCore.Functions.SavePlayer(target)
            end

            local msgSource = ('Set tier for %s to %s'):format(target, tier)
            local msgTarget = ('Your Patreon tier was set to %s'):format(tier)
            -- Always send chat + notify for visibility
        local extra = created > 0 and (' (created '..created..' Patreon vehicles)') or ''
        TriggerClientEvent('QBCore:Notify', src, msgSource..extra, 'success')
            TriggerClientEvent('chat:addMessage', src, { args = { 'System', msgSource } })
            TriggerClientEvent('QBCore:Notify', target, msgTarget, 'success')
            if src ~= target then
                TriggerClientEvent('chat:addMessage', target, { args = { 'System', msgTarget } })
            end
        end, false)

    -- Admin command to anchor all existing Patreon-tier vehicles to the Patreon garage for a player
    RegisterCommand('anchorpatreon', function(src, args)
        local isAllowed = false
        if QBCore.Functions.HasPermission then
            isAllowed = QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god')
        else
            local sourcePerms = QBCore.Functions.GetPermission(src)
            if type(sourcePerms) == 'string' then
                isAllowed = (sourcePerms == 'admin' or sourcePerms == 'god')
            elseif type(sourcePerms) == 'table' then
                isAllowed = (sourcePerms['admin'] == true or sourcePerms['god'] == true)
            end
        end
        if not isAllowed then
            Notification(src, 3, L('no_permissions'))
            return
        end
        local target = tonumber(args[1]) or src
        local Player = QBCore.Functions.GetPlayer(target)
        if not Player then
            Notification(src, 3, L('invalid_playerid'))
            return
        end
        local citizenid = Player.PlayerData.citizenid
        local tiers = Config.PatreonTiers and Config.PatreonTiers.tiers or {}
        local spawnList = {}
        
        -- Build list of all Patreon vehicles by type
        for t, data in pairs(tiers) do
            -- Add cars
            for i = 1, #(data.cars or {}) do
                spawnList[#spawnList+1] = {vehicle = data.cars[i], type = 'car'}
            end
            -- Add boats
            for i = 1, #(data.boats or {}) do
                spawnList[#spawnList+1] = {vehicle = data.boats[i], type = 'boat'}
            end
            -- Add air vehicles
            for i = 1, #(data.air or {}) do
                spawnList[#spawnList+1] = {vehicle = data.air[i], type = 'air'}
            end
        end
        
        if #spawnList == 0 then
            Notification(src, 3, 'No Patreon vehicles configured')
            return
        end
        
        -- Build IN clause safely
        local inList = ''
        for i = 1, #spawnList do
            inList = inList .. (i == 1 and '"' or ',"') .. tostring(spawnList[i].vehicle) .. '"'
        end
        
        -- Update vehicles to appropriate Patreon garages based on type
        local updatedCount = 0
        for i = 1, #spawnList do
            local vehicleData = spawnList[i]
            local garageId = GetPatreonGarageId(vehicleData.type)
            
            local q = 'UPDATE player_vehicles SET in_garage=1, garage_id="'..garageId..'", garage_type="'..vehicleData.type..'" WHERE citizenid="'..citizenid..'" AND vehicle="'..vehicleData.vehicle..'"'
            DatabaseQuery(q)
            updatedCount = updatedCount + 1
            
            DebugPrint('Anchored vehicle', vehicleData.vehicle, 'to', garageId, 'with type', vehicleData.type)
        end
        
        Notification(src, 1, ('Anchored %d Patreon vehicles for %s to appropriate garages'):format(updatedCount, target))
        if src ~= target then
            Notification(target, 1, ('Your Patreon vehicles have been anchored to appropriate garages'))
        end
    end, false)

    -- Admin command to clean up vehicles that are no longer in the Patreon configuration
    RegisterCommand('cleanupremovedpatreon', function(src, args)
        local isAllowed = false
        if QBCore.Functions.HasPermission then
            isAllowed = QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god')
        else
            local sourcePerms = QBCore.Functions.GetPermission(src)
            if type(sourcePerms) == 'string' then
                isAllowed = (sourcePerms == 'admin' or sourcePerms == 'god')
            elseif type(sourcePerms) == 'table' then
                isAllowed = (sourcePerms['admin'] == true or sourcePerms['god'] == true)
            end
        end
        if not isAllowed then
            Notification(src, 3, L('no_permissions'))
            return
        end
        
        Notification(src, 1, 'Starting cleanup of removed Patreon vehicles...')
        CleanupRemovedPatreonVehicles()
        Notification(src, 1, 'Cleanup of removed Patreon vehicles completed!')
    end, false)

    -- Admin command to clean up Patreon vehicles for all players based on current tiers
    RegisterCommand('cleanuppatreon', function(src, args)
        local isAllowed = false
        if QBCore.Functions.HasPermission then
            isAllowed = QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god')
        else
            local sourcePerms = QBCore.Functions.GetPermission(src)
            if type(sourcePerms) == 'string' then
                isAllowed = (sourcePerms['admin'] == true or sourcePerms['god'] == true)
            end
        end
        if not isAllowed then
            Notification(src, 3, L('no_permissions'))
            return
        end
        
        local target = tonumber(args[1])
        local allPlayers = not target
        
        -- First, clean up vehicles that are no longer in the Patreon configuration
        Notification(src, 1, 'Cleaning up removed Patreon vehicles from config...')
        CleanupRemovedPatreonVehicles()
        
        if allPlayers then
            -- Clean up for all online players
            local players = QBCore.Functions.GetPlayers()
            local totalRemoved = 0
            local processed = 0
            
            for _, playerSrc in pairs(players) do
                local Player = QBCore.Functions.GetPlayer(playerSrc)
                if Player then
                    local tier = GetPlayerPatreonTier(Player)
                    local removed = EnsurePatreonVehiclesForPlayer(playerSrc, Player, tier)
                    if removed > 0 then
                        totalRemoved = totalRemoved + removed
                    end
                    processed = processed + 1
                end
            end
            
            local msg = ('Cleaned up Patreon vehicles for %d players. Total vehicles removed: %d'):format(processed, totalRemoved)
            Notification(src, 1, msg)
            DebugPrint(msg)
        else
            -- Clean up for specific player
            local Player = QBCore.Functions.GetPlayer(target)
            if not Player then
                Notification(src, 3, L('invalid_playerid'))
                return
            end
            
            local tier = GetPlayerPatreonTier(Player)
            local removed = EnsurePatreonVehiclesForPlayer(target, Player, tier)
            
            local msg = ('Cleaned up Patreon vehicles for %s (tier %d). Vehicles removed: %d'):format(target, tier, removed)
            Notification(src, 1, msg)
            DebugPrint(msg)
        end
    end, false)

    -- Note: We avoid registering via QBCore.Commands.Add to prevent recursion with ExecuteCommand.

    QBCore.Functions.CreateCallback("qb-garage:server:checkVehicleOwner", function(source, cb, plate)
        local src = source
        local pData = QBCore.Functions.GetPlayer(src)
        MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?',{plate, pData.PlayerData.citizenid}, function(result)
            if result[1] then
                cb(true, result[1].balance)
            else
                cb(false)
            end
        end)
    end)
    
end
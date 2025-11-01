-- OLRP Portal Teleport Server Script
-- Handles logging and server-side portal functionality for multiple portals

local QBCore = exports['qb-core']:GetCoreObject()

-- Function to log portal usage
local function logPortalUsage(source, pairIndex, portalNum, portalName)
    local player = QBCore.Functions.GetPlayer(source)
    
    if player then
        local playerName = player.PlayerData.name
        local playerId = player.PlayerData.citizenid
        
        print(string.format("[OLRP Portal] Player %s (%s) used portal %d in pair %d (%s)", 
            playerName, playerId, portalNum, pairIndex, portalName))
        
        -- Optional: Add to Discord webhook or database logging here
        -- TriggerEvent('qb-log:server:CreateLog', 'portal', 'Portal Teleport', 'green', 
        --     string.format('%s used portal %d in pair %d (%s)', playerName, portalNum, pairIndex, portalName))
    end
end

-- Handle portal teleportation logging
RegisterNetEvent('olrp_portal:teleport')
AddEventHandler('olrp_portal:teleport', function(pairIndex, portalNum, portalName)
    local source = source
    logPortalUsage(source, pairIndex, portalNum, portalName)
end)

-- Handle multi-floor building teleportation logging
RegisterNetEvent('olrp_portal:multiFloorTeleport')
AddEventHandler('olrp_portal:multiFloorTeleport', function(buildingId, floorIndex, floorName)
    local source = source
    local player = QBCore.Functions.GetPlayer(source)
    
    if player then
        local playerName = player.PlayerData.name
        local playerId = player.PlayerData.citizenid
        
        print(string.format("[OLRP Portal] Player %s (%s) used multi-floor teleport to %s (Floor %d)", 
            playerName, playerId, floorName, floorIndex))
        
        -- Optional: Add to Discord webhook or database logging here
        -- TriggerEvent('qb-log:server:CreateLog', 'portal', 'Multi-Floor Teleport', 'green', 
        --     string.format('%s teleported to %s (Floor %d)', playerName, floorName, floorIndex))
    end
end)

-- Admin command to reload portal configuration
RegisterCommand('reloadportals', function(source, args, rawCommand)
    local player = QBCore.Functions.GetPlayer(source)
    
    if player and (player.PlayerData.job.name == 'admin' or IsPlayerAceAllowed(source, 'command.admin')) then
        -- Trigger client event to reload config
        TriggerClientEvent('olrp_portal:reload', -1)
        TriggerClientEvent('QBCore:Notify', source, 'Portal configuration reloaded!', 'success')
        print(string.format("[OLRP Portal] Configuration reloaded by %s", player.PlayerData.name))
    else
        TriggerClientEvent('QBCore:Notify', source, 'You do not have permission to use this command!', 'error')
    end
end, false)

-- Admin command to get portal statistics
RegisterCommand('portalstats', function(source, args, rawCommand)
    local player = QBCore.Functions.GetPlayer(source)
    
    if player and (player.PlayerData.job.name == 'admin' or IsPlayerAceAllowed(source, 'command.admin')) then
        local totalPairs = #Config.Portals
        local totalPortals = totalPairs * 2
        
        TriggerClientEvent('QBCore:Notify', source, 
            string.format('Portal Stats: %d pairs, %d total portals', totalPairs, totalPortals), 'primary')
        
        print(string.format("[OLRP Portal] Stats requested by %s: %d pairs, %d total portals", 
            player.PlayerData.name, totalPairs, totalPortals))
    else
        TriggerClientEvent('QBCore:Notify', source, 'You do not have permission to use this command!', 'error')
    end
end, false)

-- Admin command to add a new portal pair (for runtime addition)
RegisterCommand('addportal', function(source, args, rawCommand)
    local player = QBCore.Functions.GetPlayer(source)
    
    if player and (player.PlayerData.job.name == 'admin' or IsPlayerAceAllowed(source, 'command.admin')) then
        if #args < 8 then
            TriggerClientEvent('QBCore:Notify', source, 
                'Usage: /addportal "name" "label1" "label2" x1 y1 z1 h1 x2 y2 z2 h2', 'error')
            return
        end
        
        local name = args[1]
        local label1 = args[2]
        local label2 = args[3]
        local x1, y1, z1, h1 = tonumber(args[4]), tonumber(args[5]), tonumber(args[6]), tonumber(args[7])
        local x2, y2, z2, h2 = tonumber(args[8]), tonumber(args[9]), tonumber(args[10]), tonumber(args[11])
        
        if not x1 or not y1 or not z1 or not h1 or not x2 or not y2 or not z2 or not h2 then
            TriggerClientEvent('QBCore:Notify', source, 'Invalid coordinates provided!', 'error')
            return
        end
        
        -- Add new portal pair to config
        local newPair = {
            name = name,
            portal1 = {
                coords = vector3(x1, y1, z1),
                heading = h1,
                label = label1,
                description = "Teleport to " .. label2
            },
            portal2 = {
                coords = vector3(x2, y2, z2),
                heading = h2,
                label = label2,
                description = "Teleport to " .. label1
            }
        }
        
        table.insert(Config.Portals, newPair)
        
        TriggerClientEvent('QBCore:Notify', source, 
            string.format('Added portal pair: %s', name), 'success')
        print(string.format("[OLRP Portal] New portal pair added by %s: %s", player.PlayerData.name, name))
    else
        TriggerClientEvent('QBCore:Notify', source, 'You do not have permission to use this command!', 'error')
    end
end, false)

-- Admin command to remove a portal pair
RegisterCommand('removeportal', function(source, args, rawCommand)
    local player = QBCore.Functions.GetPlayer(source)
    
    if player and (player.PlayerData.job.name == 'admin' or IsPlayerAceAllowed(source, 'command.admin')) then
        if #args < 1 then
            TriggerClientEvent('QBCore:Notify', source, 'Usage: /removeportal [pair_index]', 'error')
            return
        end
        
        local pairIndex = tonumber(args[1])
        
        if not pairIndex or pairIndex < 1 or pairIndex > #Config.Portals then
            TriggerClientEvent('QBCore:Notify', source, 'Invalid portal pair index!', 'error')
            return
        end
        
        local removedPair = Config.Portals[pairIndex]
        table.remove(Config.Portals, pairIndex)
        
        TriggerClientEvent('QBCore:Notify', source, 
            string.format('Removed portal pair: %s', removedPair.name), 'success')
        print(string.format("[OLRP Portal] Portal pair removed by %s: %s", player.PlayerData.name, removedPair.name))
    else
        TriggerClientEvent('QBCore:Notify', source, 'You do not have permission to use this command!', 'error')
    end
end, false)

-- Command to get portal information
RegisterCommand('portalinfo', function(source, args, rawCommand)
    local player = QBCore.Functions.GetPlayer(source)
    
    if player then
        local info = "=== OLRP Portal System ===\n"
        info = info .. string.format("Total Portal Pairs: %d\n", #Config.Portals)
        info = info .. string.format("Detection Distance: %.1f units\n", Config.Settings.detectionDistance)
        info = info .. "Available Commands:\n"
        info = info .. "/listportals - List all portals\n"
        info = info .. "/tpportal [pair] [portal] - Teleport to specific portal\n"
        info = info .. "/portaldebug - Toggle debug mode\n"
        
        TriggerClientEvent('QBCore:Notify', source, info, 'primary')
    end
end, false)

-- Initialize portal system
CreateThread(function()
    Wait(1000) -- Wait for QBCore to load
    print(string.format("[OLRP Portal] System initialized with %d portal pairs", #Config.Portals))
end)
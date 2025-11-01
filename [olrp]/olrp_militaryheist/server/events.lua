local QBCore = exports['qb-core']:GetCoreObject()

-- Player entered restricted area
RegisterNetEvent('militaryheist:server:playerEnteredArea', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        return
    end
    
    local playerJob = Player.PlayerData.job.name
    local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Log entry
    -- print("^3[Military Heist]^7 Player " .. playerName .. " (" .. playerJob .. ") entered restricted area")
    
    -- Check if player should be targeted
    local shouldTarget = true
    for _, excludedJob in pairs(Config.ExcludedJobs) do
        if playerJob == excludedJob then
            shouldTarget = false
            break
        end
    end
    
    if shouldTarget then
        -- Notify other players in area
        TriggerClientEvent('militaryheist:client:playerEnteredHostile', -1, playerName, src)
    else
        -- Notify authorized personnel
        TriggerClientEvent('militaryheist:client:playerEnteredAuthorized', -1, playerName, src)
    end
end)

-- Player left restricted area
RegisterNetEvent('militaryheist:server:playerLeftArea', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        return
    end
    
    local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- print("^3[Military Heist]^7 Player " .. playerName .. " left restricted area")
end)

-- Military unit engaged player
RegisterNetEvent('militaryheist:server:unitEngaged', function(unitId, targetPlayer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local TargetPlayer = QBCore.Functions.GetPlayer(targetPlayer)
    
    if not Player or not TargetPlayer then
        return
    end
    
    local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local targetName = TargetPlayer.PlayerData.charinfo.firstname .. " " .. TargetPlayer.PlayerData.charinfo.lastname
    
    -- print("^3[Military Heist]^7 Unit " .. unitId .. " engaged " .. targetName .. " (spawned by " .. playerName .. ")")
    
    -- Notify target player
    TriggerClientEvent('militaryheist:client:underAttack', targetPlayer, unitId)
end)

-- Military unit killed player
RegisterNetEvent('militaryheist:server:unitKilledPlayer', function(unitId, targetPlayer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local TargetPlayer = QBCore.Functions.GetPlayer(targetPlayer)
    
    if not Player or not TargetPlayer then
        return
    end
    
    local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local targetName = TargetPlayer.PlayerData.charinfo.firstname .. " " .. TargetPlayer.PlayerData.charinfo.lastname
    
    -- print("^3[Military Heist]^7 Unit " .. unitId .. " killed " .. targetName .. " (spawned by " .. playerName .. ")")
    
    -- Notify all players
    TriggerClientEvent('militaryheist:client:playerKilledByMilitary', -1, targetName, unitId)
end)

-- Player killed military unit
RegisterNetEvent('militaryheist:server:playerKilledUnit', function(unitId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        return
    end
    
    local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- print("^3[Military Heist]^7 Player " .. playerName .. " killed unit " .. unitId)
    
    -- Notify all players
    TriggerClientEvent('militaryheist:client:unitKilledByPlayer', -1, playerName, unitId)
end)

-- Get player job for targeting
RegisterNetEvent('militaryheist:server:getPlayerJob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        return
    end
    
    local playerJob = Player.PlayerData.job.name
    local shouldTarget = true
    
    -- Check if player has excluded job
    for _, excludedJob in pairs(Config.ExcludedJobs) do
        if playerJob == excludedJob then
            shouldTarget = false
            break
        end
    end
    
    TriggerClientEvent('militaryheist:client:receivePlayerJob', src, playerJob, shouldTarget)
end)

-- Debug: Get all active units
RegisterNetEvent('militaryheist:server:debugUnits', function()
    local src = source
    
    if not IsPlayerAceAllowed(src, 'command.militaryheist') then
        return
    end
    
    local unitList = {}
    for unitId, unitData in pairs(activeUnits) do
        table.insert(unitList, {
            id = unitId,
            spawnPoint = unitData.spawnPoint,
            spawnTime = unitData.spawnTime,
            source = unitData.source
        })
    end
    
    TriggerClientEvent('militaryheist:client:debugUnits', src, unitList)
end)

-- Cleanup on player disconnect
AddEventHandler('playerDropped', function(reason)
    local src = source
    
    -- Remove units spawned by this player
    for unitId, unitData in pairs(activeUnits) do
        if unitData.source == src then
            activeUnits[unitId] = nil
            -- print("^3[Military Heist]^7 Cleaned up units from disconnected player " .. src)
        end
    end
end)

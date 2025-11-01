local QBCore = exports['qb-core']:GetCoreObject()

-- Server-side data
activeUnits = {}
local heistActive = false
local lastCleanup = 0
local allUnitsKilled = false
local heistRestartTimer = 0
local unitsSpawned = false -- Track if units have been spawned globally
local spawnClient = nil -- Track which client is responsible for spawning units

-- Initialize
CreateThread(function()
    while not QBCore do
        Wait(100)
    end
    
    if Config.HeistActive then
        StartHeist()
    end
end)

-- Start heist
function StartHeist()
    heistActive = true
    allUnitsKilled = false
    heistRestartTimer = 0
    unitsSpawned = false -- Reset spawn flag
    spawnClient = nil -- Reset spawn client
    -- print("^3[Military Heist]^7 Military heist system started")
    
    -- Cleanup thread
    CreateThread(function()
        while heistActive do
            CleanupDeadUnits()
            CheckHeistRestart()
            Wait(30000) -- Cleanup every 30 seconds
        end
    end)
end

-- Stop heist
function StopHeist()
    heistActive = false
    activeUnits = {}
    allUnitsKilled = false
    heistRestartTimer = 0
    -- print("^3[Military Heist]^7 Military heist system stopped")
end

-- Check heist restart
function CheckHeistRestart()
    if allUnitsKilled and heistRestartTimer > 0 then
        local currentTime = os.time()
        if currentTime >= heistRestartTimer then
            -- Restart heist
            allUnitsKilled = false
            heistRestartTimer = 0
            unitsSpawned = false -- Reset spawn flag for restart
            spawnClient = nil -- Reset spawn client for restart
            -- print("^3[Military Heist]^7 Heist restarted - all units respawned")
            TriggerClientEvent('militaryheist:client:restartHeist', -1)
        end
    end
end

-- Initial spawn trigger (called once on resource start)
RegisterNetEvent('militaryheist:server:initialSpawn', function()
    local src = source
    
    if not heistActive then
        return
    end
    
    -- Only spawn units once globally (from first client that loads)
    if not unitsSpawned then
        unitsSpawned = true
        spawnClient = src -- Assign this client as the spawner
        -- Tell ONLY the requesting client to spawn the units (prevent duplication)
        TriggerClientEvent('militaryheist:client:spawnMilitaryUnits', src)
        -- print("^3[Military Heist]^7 Initial spawn triggered - spawning on client " .. src)
    else
        -- Units already spawned, just sync this client to existing units
        TriggerClientEvent('militaryheist:client:syncMilitaryUnits', src)
    end
end)

-- Late joiner sync request (only syncs existing NPCs, doesn't spawn new ones)
RegisterNetEvent('militaryheist:server:requestSync', function()
    local src = source
    
    if not heistActive then
        return
    end
    
    -- If units are already spawned, sync them to this client
    if unitsSpawned then
        TriggerClientEvent('militaryheist:client:syncMilitaryUnits', src)
        -- print("^3[Military Heist]^7 Syncing existing units to late-joiner " .. src)
    end
end)

-- Unit spawned event
RegisterNetEvent('militaryheist:server:unitSpawned', function(unitId, spawnPoint)
    local src = source
    
    if not heistActive then
        return
    end
    
    activeUnits[unitId] = {
        id = unitId,
        spawnPoint = spawnPoint,
        spawnTime = os.time(),
        source = src
    }
    
    -- print("^3[Military Heist]^7 Unit spawned: " .. unitId .. " by player " .. src)
end)

-- Unit died event
RegisterNetEvent('militaryheist:server:unitDied', function(unitId)
    local src = source
    
    if activeUnits[unitId] then
        activeUnits[unitId] = nil
        -- print("^3[Military Heist]^7 Unit died: " .. unitId .. " by player " .. src)
        
        -- Check if all units are dead
        local aliveUnits = 0
        for _ in pairs(activeUnits) do
            aliveUnits = aliveUnits + 1
        end
        
        if aliveUnits == 0 and not allUnitsKilled then
            allUnitsKilled = true
            heistRestartTimer = os.time() + (Config.HeistRestart.restartTime / 1000) -- Convert to seconds
            -- print("^3[Military Heist]^7 All units killed! Heist will restart in 1 hour")
            TriggerClientEvent('militaryheist:client:allUnitsKilled', -1)
            
            -- Notify all players
            TriggerClientEvent('QBCore:Notify', -1, Config.MilitaryStash.notificationMessage, 'success', 5000)
        end
        
        -- Notify all clients about unit death (for cleanup on their end)
        TriggerClientEvent('militaryheist:client:unitDiedNotification', -1, unitId)
    end
end)

-- All units killed event
RegisterNetEvent('militaryheist:server:allUnitsKilled', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        return
    end
    
    local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    -- print("^3[Military Heist]^7 All units killed by " .. playerName .. " - Heist restart timer started")
end)

-- Cleanup dead units
function CleanupDeadUnits()
    local currentTime = os.time()
    
    for unitId, unitData in pairs(activeUnits) do
        -- Remove units that have been active for too long (5 minutes)
        if currentTime - unitData.spawnTime > 300 then
            activeUnits[unitId] = nil
            -- print("^3[Military Heist]^7 Cleaned up old unit: " .. unitId)
        end
    end
end

-- Get heist status
RegisterNetEvent('militaryheist:server:getStatus', function()
    local src = source
    local status = {
        active = heistActive,
        unitCount = 0,
        maxUnits = Config.SpawnSettings.maxUnits
    }
    
    for _ in pairs(activeUnits) do
        status.unitCount = status.unitCount + 1
    end
    
    TriggerClientEvent('militaryheist:client:receiveStatus', src, status)
end)

-- Check if player should be targeted
RegisterNetEvent('militaryheist:server:checkPlayer', function()
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
    
    TriggerClientEvent('militaryheist:client:playerCheckResult', src, shouldTarget, playerJob)
end)

-- Admin commands
RegisterCommand('militaryheist_start', function(source, args, rawCommand)
    if source == 0 or IsPlayerAceAllowed(source, 'command.militaryheist') then
        StartHeist()
        TriggerClientEvent('militaryheist:client:startHeist', -1)
        -- print("^3[Military Heist]^7 Heist started by admin")
    end
end, false)

RegisterCommand('militaryheist_stop', function(source, args, rawCommand)
    if source == 0 or IsPlayerAceAllowed(source, 'command.militaryheist') then
        StopHeist()
        TriggerClientEvent('militaryheist:client:stopHeist', -1)
        -- print("^3[Military Heist]^7 Heist stopped by admin")
    end
end, false)

RegisterCommand('militaryheist_status', function(source, args, rawCommand)
    if source == 0 or IsPlayerAceAllowed(source, 'command.militaryheist') then
        local status = {
            active = heistActive,
            unitCount = 0,
            maxUnits = Config.SpawnSettings.maxUnits,
            unitsSpawned = unitsSpawned,
            allUnitsKilled = allUnitsKilled
        }
        
        for _ in pairs(activeUnits) do
            status.unitCount = status.unitCount + 1
        end
        
        print("^3[Military Heist Status]^7")
        print("Active: " .. tostring(status.active))
        print("Units Spawned: " .. tostring(status.unitsSpawned))
        print("All Units Killed: " .. tostring(status.allUnitsKilled))
        print("Tracked Units: " .. status.unitCount .. "/" .. status.maxUnits)
        
        if source > 0 then
            TriggerClientEvent('QBCore:Notify', source, 
                "Heist Status: " .. (status.active and "Active" or "Inactive") .. 
                " | Units: " .. status.unitCount .. "/" .. status.maxUnits .. 
                " | Spawned: " .. tostring(status.unitsSpawned), 
                'info', 5000)
        end
    end
end, false)

RegisterCommand('militaryheist_sync', function(source, args, rawCommand)
    if source == 0 or IsPlayerAceAllowed(source, 'command.militaryheist') then
        if source > 0 then
            -- Sync for specific player
            TriggerClientEvent('militaryheist:client:syncMilitaryUnits', source)
            TriggerClientEvent('QBCore:Notify', source, "Syncing military units to your client...", 'info', 3000)
            print("^3[Military Heist]^7 Force syncing units to player " .. source)
        else
            print("^3[Military Heist]^7 This command must be run in-game")
        end
    end
end, false)

RegisterCommand('militaryheist_spawn', function(source, args, rawCommand)
    if source == 0 or IsPlayerAceAllowed(source, 'command.militaryheist') then
        -- Reset spawn flag and trigger new spawn on requesting client only
        unitsSpawned = false
        TriggerClientEvent('militaryheist:client:spawnMilitaryUnits', source)
        print("^3[Military Heist]^7 Manually spawning military units on client " .. source)
        
        if source > 0 then
            TriggerClientEvent('QBCore:Notify', source, "Manually spawning military units...", 'success', 3000)
        end
    end
end, false)

-- Test command to give military stash items directly to player
RegisterCommand('militaryheist_testitems', function(source, args, rawCommand)
    if source == 0 or IsPlayerAceAllowed(source, 'command.militaryheist') then
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        
        if not Player then
            print("^1[Military Heist]^7 Error: Player not found")
            return
        end
        
        print("^3[Military Heist]^7 Giving test items to player " .. src)
        
        -- Give items directly to player for testing using QBCore
        for _, item in pairs(Config.MilitaryStash.stashItems) do
            local success = Player.Functions.AddItem(item.item, item.amount)
            if success then
                print("^2[Military Heist]^7 Gave " .. item.item .. " x" .. item.amount .. " to player")
            else
                print("^1[Military Heist]^7 Failed to give " .. item.item .. " - item may not exist")
            end
        end
        
        TriggerClientEvent('QBCore:Notify', src, "Test items added to your inventory!", 'success', 5000)
    end
end, false)

-- Player disconnected cleanup
AddEventHandler('playerDropped', function(reason)
    local src = source
    
    -- If the spawn client disconnected, assign a new one
    if spawnClient == src then
        spawnClient = nil
        -- Find another player to take over spawning
        local players = GetPlayers()
        if #players > 0 then
            spawnClient = tonumber(players[1])
            -- Transfer spawning responsibility
            TriggerClientEvent('militaryheist:client:takeOverSpawning', spawnClient)
        end
    end
    
    -- Clean up units spawned by this player
    for unitId, unitData in pairs(activeUnits) do
        if unitData.source == src then
            activeUnits[unitId] = nil
        end
    end
end)

-- Resource stop cleanup
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        StopHeist()
    end
end)

-- Military Stash System
RegisterNetEvent('militaryheist:server:populateStash', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        print("^1[Military Heist]^7 Error: Player not found for stash population")
        return
    end
    
    print("^3[Military Heist]^7 Populating military stash for player " .. src)
    
    -- Add items directly to player inventory (most reliable method)
    for _, item in pairs(Config.MilitaryStash.stashItems) do
        print("^3[Military Heist]^7 Adding item: " .. item.item .. " x" .. item.amount)
        
        -- Use QBCore's built-in AddItem function (most reliable)
        local success = Player.Functions.AddItem(item.item, item.amount)
        
        if success then
            print("^2[Military Heist]^7 Successfully added " .. item.item .. " x" .. item.amount .. " to player inventory")
        else
            print("^1[Military Heist]^7 Failed to add item " .. item.item .. " - item may not exist in database")
        end
    end
    
    print("^3[Military Heist]^7 Military stash populated with " .. #Config.MilitaryStash.stashItems .. " item types")
    
    -- Notify player and trigger client event
    TriggerClientEvent('QBCore:Notify', src, "Military stash populated with items!", 'success', 5000)
    TriggerClientEvent('militaryheist:client:stashPopulated', src)
end)

-- Check stash access
RegisterNetEvent('militaryheist:server:checkStashAccess', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        return
    end
    
    local aliveUnits = 0
    for _ in pairs(activeUnits) do
        aliveUnits = aliveUnits + 1
    end
    
    local canAccess = aliveUnits == 0 and Config.MilitaryStash.enabled
    
    TriggerClientEvent('militaryheist:client:stashAccessResult', src, canAccess)
end)

-- Export functions
exports('IsHeistActive', function() return heistActive end)
exports('GetActiveUnitCount', function() 
    local count = 0
    for _ in pairs(activeUnits) do
        count = count + 1
    end
    return count
end)
exports('StartHeist', StartHeist)
exports('StopHeist', StopHeist)

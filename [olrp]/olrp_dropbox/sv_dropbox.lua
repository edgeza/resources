local Server = lib.require('sv_config')
local RewardConfig = lib.require('reward_config')
local currentLoc, currentRot, currentEntity, currentRarity
local isBeingCollected = false -- Lock to prevent multiple collection attempts

local function doShuffle(locs)
    local size = #locs
    for i = size, 1, -1 do
        local rand = math.random(size)
        locs[i], locs[rand] = locs[rand], locs[i]
    end
    return locs
end

local function isValid(pos)
    return DoesEntityExist(currentEntity) and #(pos - vec3(currentLoc.x, currentLoc.y, currentLoc.z)) < 5.0
end

local function determineRarity()
    local totalChance = 0
    
    -- Calculate total chance for normalization
    for _, category in pairs(RewardConfig.RewardCategories) do
        totalChance = totalChance + category.chance
    end
    
    -- Generate random number and determine category
    local randomRoll = math.random() * 100
    local currentChance = 0
    
    for _, category in pairs(RewardConfig.RewardCategories) do
        currentChance = currentChance + category.chance
        if randomRoll <= currentChance then
            return category.name
        end
    end
    
    -- Fallback to common if no category selected
    return "Common"
end

local function sendDiscordLog(data)
    if not Server.WebhookURL or Server.WebhookURL == '' then 
        print("^3[WEBHOOK] No webhook URL configured")
        return 
    end
    
    local function truncate(str, limit)
        if not str then return '' end
        if #str <= limit then return str end
        return str:sub(1, limit - 3) .. '...'
    end
    
    local embed = {
        {
            ["title"] = ('OLRP Dropbox Collected - %s'):format(data.rarity or 'Unknown'),
            ["color"] = 16753920, -- orange color
            ["fields"] = {
                { ["name"] = 'Player', ["value"] = truncate(('%s (%s)'):format(data.playerName or 'Unknown', tostring(data.source or 'n/a')), 1024), ["inline"] = true },
                { ["name"] = 'Identifier', ["value"] = truncate(data.identifier or 'n/a', 1024), ["inline"] = true },
                { ["name"] = 'Rarity', ["value"] = truncate(data.rarity or 'n/a', 1024), ["inline"] = true },
                { ["name"] = 'Rewards', ["value"] = truncate(data.rewardsText or 'n/a', 1024), ["inline"] = false },
                { ["name"] = 'Location', ["value"] = truncate(data.locationText or 'n/a', 1024), ["inline"] = true },
                { ["name"] = 'World Coords', ["value"] = truncate(data.coordsText or 'n/a', 1024), ["inline"] = true },
                { ["name"] = 'Time', ["value"] = truncate(os.date('!%Y-%m-%d %H:%M:%S UTC'), 1024), ["inline"] = false },
            },
            ["footer"] = {
                ["text"] = "OLRP Dropbox System"
            }
        }
    }
    
    local payload = {
        ["username"] = "OLRP Dropbox",
        ["embeds"] = embed
    }
    
    print("^2[WEBHOOK] Sending dropbox log to Discord...")
    PerformHttpRequest(Server.WebhookURL, function(status, body, headers)
        print(("^3[WEBHOOK] Response - Status: %s, Body: %s"):format(tostring(status), tostring(body)))
        if status ~= 204 and status ~= 200 then
            print(("^1[WEBHOOK] Failed to send dropbox log. Status: %s Body: %s"):format(tostring(status), tostring(body)))
        else
            print("^2[WEBHOOK] Successfully sent dropbox log to Discord!")
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

-- Test webhook function
local function testDiscordWebhook()
    if not Server.WebhookURL or Server.WebhookURL == '' then 
        print("^1[WEBHOOK TEST] No webhook URL configured")
        return 
    end
    
    local testEmbed = {
        {
            ["title"] = "OLRP Dropbox - Webhook Test",
            ["color"] = 65280, -- green color
            ["description"] = "This is a test message to verify the webhook is working correctly.",
            ["fields"] = {
                { ["name"] = 'Test Status', ["value"] = 'Webhook is working!', ["inline"] = true },
                { ["name"] = 'Time', ["value"] = os.date('!%Y-%m-%d %H:%M:%S UTC'), ["inline"] = true },
            },
            ["footer"] = {
                ["text"] = "OLRP Dropbox System - Test"
            }
        }
    }
    
    local payload = {
        ["username"] = "OLRP Dropbox Test",
        ["embeds"] = testEmbed
    }
    
    print("^2[WEBHOOK TEST] Sending test message to Discord...")
    PerformHttpRequest(Server.WebhookURL, function(status, body, headers)
        print(("^3[WEBHOOK TEST] Response - Status: %s, Body: %s"):format(tostring(status), tostring(body)))
        if status ~= 204 and status ~= 200 then
            print(("^1[WEBHOOK TEST] Failed to send test message. Status: %s Body: %s"):format(tostring(status), tostring(body)))
        else
            print("^2[WEBHOOK TEST] Successfully sent test message to Discord!")
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

-- Test webhook command
RegisterCommand('testwebhook', function(source, args, rawCommand)
    testDiscordWebhook()
end, false)

-- Manual sync command for testing
RegisterCommand('syncdropbox', function(source, args, rawCommand)
    if GlobalState.OLRPDropboxActive and currentLoc and currentRarity and currentEntity and DoesEntityExist(currentEntity) then
        print("^2[SYNC] Manually syncing dropbox to all players...")
        local players = GetPlayers()
        for _, playerId in ipairs(players) do
            local src = tonumber(playerId)
            if src and GetPlayerName(src) then
                TriggerClientEvent('olrp_dropbox:client:initHunt', src, currentLoc, currentRarity)
            end
        end
        print("^2[SYNC] Manual sync completed!")
    else
        print("^1[SYNC] No active dropbox to sync!")
    end
end, true)

lib.callback.register('olrp_dropbox:server:foundDropbox', function(source)
    local playerName = GetPlayerName(source)
    print(("^3[DROPBOX] %s (source: %d) attempting to collect dropbox"):format(playerName, source))
    
    -- CRITICAL: Check GlobalState first to prevent race conditions
    if not GlobalState.OLRPDropboxActive then 
        print(("^1[DROPBOX] %s - Dropbox not active (GlobalState: %s)"):format(playerName, tostring(GlobalState.OLRPDropboxActive)))
        return false 
    end
    
    -- Check if someone is already collecting the dropbox
    if isBeingCollected then 
        print(("^1[DROPBOX] %s - Someone already collecting (lock: %s)"):format(playerName, tostring(isBeingCollected)))
        return false 
    end

    local src = source
    local player = GetPlayer(src)
    local pos = GetEntityCoords(GetPlayerPed(src))

    if not player or not isValid(pos) then 
        print(("^1[DROPBOX] %s - Validation failed (player exists: %s, pos valid: %s)"):format(playerName, tostring(player ~= nil), tostring(isValid(pos))))
        return false 
    end

    -- Additional distance validation - check if player is still within reasonable distance
    local distance = #(pos - vec3(currentLoc.x, currentLoc.y, currentLoc.z))
    print(("^3[DROPBOX] %s - Distance check: %.2f (max: 15.0)"):format(playerName, distance))
    if distance > 15.0 then -- Allow slightly more distance than client check for network lag
        print(("^1[DROPBOX] %s - Too far from dropbox (distance: %.2f)"):format(playerName, distance))
        return false
    end

    -- Store dropbox data BEFORE cleaning up
    local dropboxCoords = currentLoc
    local dropboxRarity = currentRarity

    -- Set collection lock IMMEDIATELY to prevent race conditions
    isBeingCollected = true
    
    -- Notify all clients that someone is collecting
    TriggerClientEvent('olrp_dropbox:client:setCollectionLock', -1, true)
    
    -- Give rewards FIRST before cleaning up anything
    print(("^3[DROPBOX] %s - Attempting to give rewards (Rarity: %s)"):format(playerName, dropboxRarity))
    
    -- Double-check player is still valid
    if not player or not GetPlayer(src) then
        print(("^1[DROPBOX] %s - Player object became invalid during collection"):format(playerName))
        isBeingCollected = false
        TriggerClientEvent('olrp_dropbox:client:setCollectionLock', -1, false)
        return false
    end
    
    local pcallSuccess, rewardSuccess, rewardsList, rewardCategory = pcall(Server.GiveRewards, player, src, dropboxRarity)
    local rewardsGiven = false
    local rewards = {}
    local categoryName = dropboxRarity
    
    if not pcallSuccess then
        -- pcall failed - there was an error in the function
        print(("^1[DROPBOX] %s - Error executing GiveRewards: %s"):format(playerName, tostring(rewardSuccess)))
        rewardsGiven = false
    elseif not rewardSuccess then
        -- Function executed but returned false (no rewards given)
        print(("^1[DROPBOX] %s - GiveRewards returned false (pcall ok, but rewards not given)"):format(playerName))
        if type(rewardsList) == "table" then
            rewards = rewardsList
            print(("^1[DROPBOX] %s - Rewards list: %s"):format(playerName, table.concat(rewards, ", ")))
        end
        if rewardCategory then
            categoryName = rewardCategory
        end
        rewardsGiven = false
    else
        -- Success!
        print(("^2[DROPBOX] %s - Rewards given successfully!"):format(playerName))
        if type(rewardsList) == "table" then
            rewards = rewardsList
            print(("^2[DROPBOX] %s - Rewards given: %s"):format(playerName, table.concat(rewards, ", ")))
        end
        if rewardCategory then
            categoryName = rewardCategory
        end
        rewardsGiven = true
    end

    -- Only clean up dropbox state AFTER confirming rewards were processed
    if rewardsGiven then
        -- IMMEDIATELY set GlobalState to false to prevent other players from collecting
        GlobalState.OLRPDropboxActive = false
        
        -- Store entity for cleanup before clearing
        local entityToDelete = currentEntity
        
        -- Clean up server-side state variables first
        currentEntity = nil
        currentLoc = nil
        currentRot = nil
        currentRarity = nil
        
        -- Clean up client-side hunt for ALL players BEFORE deleting entity
        TriggerClientEvent('olrp_dropbox:client:cleanupHunt', -1)
        
        -- Wait a frame to ensure client cleanup is processed
        Wait(100)
        
        -- Now delete the entity on server (will sync to clients)
        if entityToDelete and DoesEntityExist(entityToDelete) then
            DeleteEntity(entityToDelete)
        end
        
        -- Request location data from client
        TriggerClientEvent('olrp_dropbox:client:getLocationData', src, {
            source = src,
            playerName = GetPlayerName(src),
            identifier = GetPlayerIdentifier and GetPlayerIdentifier(src, 0) or 'n/a',
            rarity = categoryName or dropboxRarity,
            rewardsText = (rewards and #rewards > 0) and table.concat(rewards, ', ') or 'None'
        })
        
    else
        -- If rewards failed, don't clean up the dropbox - let someone else try
        print(("^3[DROPBOX] %s - Rewards failed, dropbox remains available for retry"):format(playerName))
        TriggerClientEvent('QBCore:Notify', src, "Collection failed - the dropbox is still available to try again!", 'error')
    end
    
    -- Reset collection lock AFTER everything is processed
    -- Always reset the lock - if rewards succeeded, the dropbox is gone, if failed, we need to allow retry
    isBeingCollected = false
    
    print(("^3[DROPBOX] %s - Collection lock released (rewardsGiven: %s)"):format(playerName, tostring(rewardsGiven)))
    
    -- Notify all clients that collection is no longer locked
    TriggerClientEvent('olrp_dropbox:client:setCollectionLock', -1, false)
    
    -- Small delay to ensure rewards are fully processed before responding
    Wait(100)
    
    print(("^2[DROPBOX] %s - Callback complete, returning %s"):format(playerName, tostring(rewardsGiven)))
    return rewardsGiven
end)

-- Event to reset collection lock if someone cancels collection
RegisterNetEvent('olrp_dropbox:server:cancelCollection', function()
    if isBeingCollected then
        isBeingCollected = false
        print("^3[DROPBOX] Collection cancelled, lock reset")
        -- Notify all clients that collection is no longer locked
        TriggerClientEvent('olrp_dropbox:client:setCollectionLock', -1, false)
    end
end)

-- Event to retry collection if it failed
RegisterNetEvent('olrp_dropbox:server:retryCollection', function()
    local src = source
    if not GlobalState.OLRPDropboxActive or isBeingCollected then
        TriggerClientEvent('QBCore:Notify', src, "Dropbox is not available for retry!", 'error')
        return
    end
    
    local player = GetPlayer(src)
    if not player then
        TriggerClientEvent('QBCore:Notify', src, "Player data not found!", 'error')
        return
    end
    
    local pos = GetEntityCoords(GetPlayerPed(src))
    local distance = #(pos - vec3(currentLoc.x, currentLoc.y, currentLoc.z))
    
    if distance > 15.0 then
        TriggerClientEvent('QBCore:Notify', src, "You're too far from the dropbox for retry!", 'error')
        return
    end
    
    print(("^2[DROPBOX] Player %s retrying collection"):format(GetPlayerName(src)))
    TriggerClientEvent('QBCore:Notify', src, "Retrying collection...", 'info')
    
    -- Trigger the collection process again
    SetTimeout(1000, function()
        TriggerClientEvent('olrp_dropbox:client:retryCollection', src)
    end)
end)

-- Handle player disconnect during collection
AddEventHandler('playerDropped', function()
    if isBeingCollected then
        isBeingCollected = false
        print("^3[DROPBOX] Player disconnected during collection, lock reset")
        -- Notify all clients that collection is no longer locked
        TriggerClientEvent('olrp_dropbox:client:setCollectionLock', -1, false)
    end
end)

-- QBCore specific disconnect handler
AddEventHandler('QBCore:Server:OnPlayerUnload', function(Player)
    if isBeingCollected then
        isBeingCollected = false
        print("^3[DROPBOX] QBCore player disconnected during collection, lock reset")
        -- Notify all clients that collection is no longer locked
        TriggerClientEvent('olrp_dropbox:client:setCollectionLock', -1, false)
    end
end)

-- Event to receive location data from client and send webhook
RegisterNetEvent('olrp_dropbox:server:sendLocationData', function(data)
    sendDiscordLog(data)
end)

function PlayerHasLoaded(source)
    local src = source
    if not src or src == 0 then return end
    
    -- Wait a bit for player to fully load before attempting sync
    SetTimeout(2000, function()
        -- Check if player is still connected
        if not GetPlayerName(src) or GetPlayerName(src) == nil then
            return
        end
        
        -- Only sync if dropbox is active AND we have valid coordinates
        if GlobalState.OLRPDropboxActive and currentLoc and currentRarity and currentEntity and DoesEntityExist(currentEntity) then
            print(("^2[SYNC] Syncing dropbox to player %s"):format(GetPlayerName(src)))
            TriggerClientEvent('olrp_dropbox:client:initHunt', src, currentLoc, currentRarity)
        else
            -- Silently skip if no active dropbox - this is normal behavior
            print(("^3[SYNC] Player %s loaded - no active dropbox to sync"):format(GetPlayerName(src)))
        end
    end)
end

-- Event handlers are now handled in bridge files to prevent double syncing
-- This prevents conflicts with bridge/server/qb.lua and other bridge files

local function getPlayerCount()
    return #GetPlayers()
end

local function initDropboxHunt()
    -- Check if minimum players requirement is met
    if getPlayerCount() < Server.MinPlayers then
        print(("^3[DROPBOX] Not enough players for dropbox. Current: %d, Required: %d"):format(getPlayerCount(), Server.MinPlayers))
        return
    end

    if GlobalState.OLRPDropboxActive then
        -- Store entity for cleanup
        local entityToDelete = currentEntity
        
        -- Clean up state variables first
        currentEntity = nil
        currentLoc = nil 
        currentRot = nil
        currentRarity = nil
        isBeingCollected = false -- Reset collection lock
        GlobalState.OLRPDropboxActive = false
        
        -- Clean up clients first
        TriggerClientEvent('olrp_dropbox:client:cleanupHunt', -1)
        
        -- Wait a frame then delete entity
        Wait(100)
        if entityToDelete and DoesEntityExist(entityToDelete) then
            DeleteEntity(entityToDelete)
        end
    end

    SetTimeout(2000, function()
        local model = Server.Models[math.random(1, #Server.Models)]
        local locs = doShuffle(Server.Locations)
        local index = locs[math.random(1, #locs)]
        currentLoc, currentRot = index.coords, index.rot
        currentRarity = determineRarity()

        -- spawn dropbox
        currentEntity = CreateObjectNoOffset(joaat(model), currentLoc.x, currentLoc.y, currentLoc.z, true, true, true)
        while not DoesEntityExist(currentEntity) do Wait(0) end
        FreezeEntityPosition(currentEntity, true)
        SetEntityRotation(currentEntity, currentRot.x, currentRot.y, currentRot.z, 2, true)

        GlobalState.OLRPDropboxActive = true
        
        -- Single sync call to all players - this prevents duplicate boxes
        print("^2[DROPBOX] Dropbox spawned, syncing to all online players...")
        TriggerClientEvent('olrp_dropbox:client:initHunt', -1, currentLoc, currentRarity)
    end)
end

-- New timing system for dropbox drops
local isFirstDrop = true
local nextDropTimer = nil

local function scheduleNextDrop()
    if nextDropTimer then
        ClearTimeout(nextDropTimer)
        nextDropTimer = nil
    end
    
    local delay
    if isFirstDrop then
        -- First drop: 15-45 minutes after restart
        delay = math.random(Server.FirstDropMin, Server.FirstDropMax) * 60000
        isFirstDrop = false
        print(("^2[DROPBOX] First drop scheduled in %d minutes"):format(delay / 60000))
    else
        -- Subsequent drops: 1-2 hours
        delay = math.random(Server.SubsequentDropMin, Server.SubsequentDropMax) * 60000
        print(("^2[DROPBOX] Next drop scheduled in %d minutes"):format(delay / 60000))
    end
    
    nextDropTimer = SetTimeout(delay, function()
        initDropboxHunt()
        scheduleNextDrop() -- Schedule the next drop
    end)
end

-- Force spawn dropbox command for testing (placed here after initDropboxHunt is defined)
RegisterCommand('forcedropbox', function(source, args, rawCommand)
    print("^2[FORCE] Force spawning dropbox...")
    initDropboxHunt()
end, true)

-- Single event handler for when resource starts
AddEventHandler('onResourceStart', function(res)
    if GetCurrentResourceName() ~= res then return end
    GlobalState.OLRPDropboxActive = false
    
    -- Reset timing system on resource start
    isFirstDrop = true
    if nextDropTimer then
        ClearTimeout(nextDropTimer)
        nextDropTimer = nil
    end
    
    -- Log startup status
    local playerCount = getPlayerCount()
    local firstDropTime = math.random(Server.FirstDropMin, Server.FirstDropMax)
    
    if playerCount >= Server.MinPlayers then
        print(("^2[TX] OLRP Dropbox: ENOUGH players for dropbox (%d/%d). Next dropbox in %d minutes"):format(
            playerCount, Server.MinPlayers, firstDropTime
        ))
    else
        print(("^3[TX] OLRP Dropbox: NOT ENOUGH players for dropbox (%d/%d). Next dropbox in %d minutes"):format(
            playerCount, Server.MinPlayers, firstDropTime
        ))
    end
    
    -- Start the new timing system
    scheduleNextDrop()
    
    -- Wait a bit for everything to load, then sync all online players
    SetTimeout(5000, function()
        if GlobalState.OLRPDropboxActive and currentLoc and currentRarity then
            print("^3[SYNC] Resource started, syncing all online players...")
            local players = GetPlayers()
            for _, playerId in ipairs(players) do
                local src = tonumber(playerId)
                if src and GetPlayerName(src) then
                    print(("^3[SYNC] Syncing player %s"):format(GetPlayerName(src)))
                    TriggerClientEvent('olrp_dropbox:client:initHunt', src, currentLoc, currentRarity)
                end
            end
        else
            print("^3[SYNC] No active dropbox to sync on resource start")
        end
    end)
end)

AddEventHandler('onResourceStop', function(res)
    if GetCurrentResourceName() ~= res then return end

    -- Clean up timer
    if nextDropTimer then
        ClearTimeout(nextDropTimer)
        nextDropTimer = nil
    end

    if GlobalState.OLRPDropboxActive then
        -- Store entity for cleanup
        local entityToDelete = currentEntity
        
        -- Clean up state variables first
        currentEntity = nil
        currentLoc = nil 
        currentRot = nil
        currentRarity = nil
        isBeingCollected = false -- Reset collection lock
        
        -- Clean up clients first
        TriggerClientEvent('olrp_dropbox:client:cleanupHunt', -1)
        
        -- Wait a frame then delete entity
        Wait(100)
        if entityToDelete and DoesEntityExist(entityToDelete) then
            DeleteEntity(entityToDelete)
        end
    end
end)


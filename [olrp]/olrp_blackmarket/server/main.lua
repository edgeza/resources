-- Framework Detection
local Framework = nil
local QBCore = nil

-- Detect framework
if GetResourceState('qb-core') == 'started' then
    Framework = 'qb'
    QBCore = exports['qb-core']:GetCoreObject()
elseif GetResourceState('qbx_core') == 'started' then
    Framework = 'qbox'
    QBCore = exports['qbx_core']:GetCoreObject()
else
    print('[BLACKMARKET] Warning: No framework detected! Using qb-core as fallback.')
    Framework = 'qb'
    QBCore = exports['qb-core']:GetCoreObject()
end

-- Inventory Detection
local Inventory = nil
if GetResourceState('qs-inventory') == 'started' then
    Inventory = 'quasar'
elseif GetResourceState('ox_inventory') == 'started' then
    Inventory = 'ox'
elseif GetResourceState('qbx_inventory') == 'started' then
    Inventory = 'qbox'
else
    print('[BLACKMARKET] Warning: No inventory detected! Using qs-inventory as fallback.')
    Inventory = 'quasar'
end

print('[BLACKMARKET] Framework detected: ' .. Framework)
print('[BLACKMARKET] Inventory detected: ' .. Inventory)

-- Persistent State File
local StateFile = GetResourcePath(GetCurrentResourceName()) .. '/blackmarket_state.json'

-- Persistent State Management
local blackmarketState = {
    accessed = false,
    accessedBy = nil,
    accessedAt = nil,
    stashPopulated = false
}

-- Load state from file
local function LoadState()
    local file = io.open(StateFile, 'r')
    if file then
        local content = file:read('*all')
        file:close()
        if content and content ~= '' then
            local success, data = pcall(json.decode, content)
            if success and data then
                blackmarketState = data
                print('[BLACKMARKET] Loaded state: accessed=' .. tostring(blackmarketState.accessed))
                if blackmarketState.accessed then
                    print('[BLACKMARKET] Black Market has been accessed before and is now permanently disabled!')
                    print('[BLACKMARKET] Accessed by: ' .. tostring(blackmarketState.accessedBy))
                    print('[BLACKMARKET] Accessed at: ' .. tostring(blackmarketState.accessedAt))
                end
            end
        end
    end
end

-- Save state to file
local function SaveState()
    local file = io.open(StateFile, 'w')
    if file then
        file:write(json.encode(blackmarketState))
        file:close()
        print('[BLACKMARKET] State saved to file')
    else
        print('[BLACKMARKET] ERROR: Could not write state file!')
    end
end

-- Track unlocked doors (in memory only - resets on server restart)
local unlockedDoors = {}

-- Spam protection - track last access attempt per player
local lastAttemptTime = {}
local ATTEMPT_COOLDOWN = 2000 -- 2 seconds cooldown between attempts

-- Discord Webhook Functions
local function SendDiscordWebhook(color, title, description, fields)
    if not Config.DiscordWebhook.enabled then 
        print('[BLACKMARKET] Discord webhooks disabled in config')
        return 
    end
    
    print('[BLACKMARKET] Sending Discord webhook:', title)
    print('[BLACKMARKET] Webhook fields count:', fields and #fields or 0)
    
    local embed = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = description,
            ["fields"] = fields or {},
            ["footer"] = {
                ["text"] = "Black Market Security System • " .. os.date("%Y-%m-%d %H:%M:%S"),
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }
    
    PerformHttpRequest(Config.DiscordWebhook.url, function(err, text, headers) 
        if err ~= 200 and err ~= 204 then
            print('[BLACKMARKET] Discord webhook error:', err, text)
        end
    end, 'POST', json.encode({
        username = Config.DiscordWebhook.botName,
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

local function GetPlayerDetails(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return nil end
    
    local playerData = Player.PlayerData
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    
    -- Get all player identifiers
    local identifiers = GetPlayerIdentifiers(src)
    local discord = "Unknown"
    local steam = "Unknown"
    local license = "Unknown"
    local license2 = "Unknown"
    local xbl = "Unknown"
    local fivem = "Unknown"
    local ip = "Unknown"
    
    for _, identifier in ipairs(identifiers) do
        if string.sub(identifier, 1, 8) == "discord:" then
            discord = string.sub(identifier, 9)
        elseif string.sub(identifier, 1, 6) == "steam:" then
            steam = string.sub(identifier, 7)
        elseif string.sub(identifier, 1, 7) == "license:" then
            if license == "Unknown" then
                license = string.sub(identifier, 9)
            else
                license2 = string.sub(identifier, 9)
            end
        elseif string.sub(identifier, 1, 4) == "xbl:" then
            xbl = string.sub(identifier, 5)
        elseif string.sub(identifier, 1, 6) == "fivem:" then
            fivem = string.sub(identifier, 7)
        elseif string.sub(identifier, 1, 3) == "ip:" then
            ip = string.sub(identifier, 4)
        end
    end
    
    return {
        name = playerData.name,
        citizenid = playerData.citizenid,
        license = license,
        license2 = license2,
        source = src,
        job = playerData.job.name,
        jobGrade = playerData.job.grade.name,
        money = playerData.money,
        location = coords,
        -- All identifiers
        discord = discord,
        steam = steam,
        xbl = xbl,
        fivem = fivem,
        ip = ip,
        city = "Los Santos",
        time = os.date("%Y-%m-%d %H:%M:%S")
    }
end

local function FormatLootItems()
    local lootText = ""
    for i, reward in ipairs(Config.Rewards.items) do
        lootText = lootText .. string.format("• **%s** x%d\n", reward.label, reward.amount)
    end
    return lootText
end

-- Function to populate black market stash with rewards (ONLY ONCE)
function PopulateBlackMarketStash()
    if not Config.Rewards.enabled then 
        print('[BLACKMARKET] Rewards disabled in config')
        return 
    end
    
    -- Check if stash has already been populated
    if blackmarketState.stashPopulated then
        print('[BLACKMARKET] Stash has already been populated, skipping...')
        return
    end
    
    print('[BLACKMARKET] Starting to populate black market stash...')
    print('[BLACKMARKET] Number of reward items:', #Config.Rewards.items)
    
    if Inventory == 'quasar' then
        -- Quasar Inventory (qs-inventory)
        Citizen.Wait(100)
        local clearResult = exports['qs-inventory']:ClearOtherInventory('stash', 'blackmarket')
        print('[BLACKMARKET] Clear stash result:', clearResult)
        
        Citizen.Wait(200)
        
        -- Add all reward items to the stash
        for i, reward in ipairs(Config.Rewards.items) do
            print(string.format('[BLACKMARKET] Adding item %d/%d: %s x%d', i, #Config.Rewards.items, reward.item, reward.amount))
            
            local success = exports['qs-inventory']:AddItemIntoStash('blackmarket', reward.item, reward.amount, nil, nil, 50, 100000)
            if success then
                print(string.format('[BLACKMARKET] ✓ Successfully added %dx %s to black market stash', reward.amount, reward.item))
            else
                print(string.format('[BLACKMARKET] ✗ Failed to add %dx %s to black market stash', reward.amount, reward.item))
            end
        end
        
        -- Mark as populated
        blackmarketState.stashPopulated = true
        SaveState()
        
        -- Check what's actually in the stash
        local stashItems = exports['qs-inventory']:GetStashItems('blackmarket')
        if stashItems then
            local itemCount = 0
            for slot, item in pairs(stashItems) do
                itemCount = itemCount + 1
                print(string.format('[BLACKMARKET] Stash slot %s: %s x%d', slot, item.name, item.amount))
            end
            print(string.format('[BLACKMARKET] Total items in stash: %d', itemCount))
        else
            print('[BLACKMARKET] No items found in stash after population')
        end
    elseif Inventory == 'ox' then
        -- OX Inventory
        Citizen.Wait(100)
        
        -- Clear stash first
        exports.ox_inventory:ClearInventory('stash', 'blackmarket')
        
        Citizen.Wait(200)
        
        -- Add items to stash
        for i, reward in ipairs(Config.Rewards.items) do
            print(string.format('[BLACKMARKET] Adding item %d/%d: %s x%d', i, #Config.Rewards.items, reward.item, reward.amount))
            
            exports.ox_inventory:AddItem('stash', 'blackmarket', reward.item, reward.amount)
        end
        
        -- Mark as populated
        blackmarketState.stashPopulated = true
        SaveState()
        
        print('[BLACKMARKET] Black market stash population completed')
    elseif Inventory == 'qbox' then
        -- QBox Inventory
        Citizen.Wait(100)
        
        -- Clear stash first
        if exports.qbx_inventory then
            exports.qbx_inventory:ClearInventory('stash', 'blackmarket')
        end
        
        Citizen.Wait(200)
        
        -- Add items to stash
        for i, reward in ipairs(Config.Rewards.items) do
            print(string.format('[BLACKMARKET] Adding item %d/%d: %s x%d', i, #Config.Rewards.items, reward.item, reward.amount))
            
            if exports.qbx_inventory then
                exports.qbx_inventory:AddItem('stash', 'blackmarket', reward.item, reward.amount)
            end
        end
        
        -- Mark as populated
        blackmarketState.stashPopulated = true
        SaveState()
        
        print('[BLACKMARKET] Black market stash population completed')
    end
    
    print('[BLACKMARKET] Black market stash population completed')
end

-- Function to check if player has the black market key
local function PlayerHasKey(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    
    if Inventory == 'quasar' then
        local hasKey = Player.Functions.GetItemByName(Config.KeyItem)
        return hasKey ~= nil and hasKey.amount > 0
    elseif Inventory == 'ox' then
        local item = exports.ox_inventory:GetItem(source, Config.KeyItem, nil, true)
        return item and item.count and item.count > 0
    elseif Inventory == 'qbox' then
        local hasKey = Player.Functions.GetItemByName(Config.KeyItem)
        return hasKey ~= nil and hasKey.amount > 0
    else
        local hasKey = Player.Functions.GetItemByName(Config.KeyItem)
        return hasKey ~= nil and hasKey.amount > 0
    end
end

-- Function to consume the black market key
local function ConsumeKey(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    
    if Inventory == 'quasar' then
        local keyItem = Player.Functions.GetItemByName(Config.KeyItem)
        if not keyItem or keyItem.amount <= 0 then
            return false
        end
        
        local success = Player.Functions.RemoveItem(Config.KeyItem, 1)
        if success then
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.KeyItem], 'remove')
            return true
        end
    elseif Inventory == 'ox' then
        local removed = exports.ox_inventory:RemoveItem(source, Config.KeyItem, 1)
        return removed > 0
    elseif Inventory == 'qbox' then
        local keyItem = Player.Functions.GetItemByName(Config.KeyItem)
        if not keyItem or keyItem.amount <= 0 then
            return false
        end
        
        local success = Player.Functions.RemoveItem(Config.KeyItem, 1)
        if success then
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.KeyItem], 'remove')
            return true
        end
    else
        local keyItem = Player.Functions.GetItemByName(Config.KeyItem)
        if not keyItem or keyItem.amount <= 0 then
            return false
        end
        
        local success = Player.Functions.RemoveItem(Config.KeyItem, 1)
        if success then
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.KeyItem], 'remove')
            return true
        end
    end
    
    return false
end

-- Notification Helper
local function Notify(source, message, type)
    if exports.ox_lib then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Black Market',
            description = message,
            type = type or 'info',
            duration = 5000
        })
    elseif QBCore and QBCore.Functions then
        TriggerClientEvent('QBCore:Notify', source, message, type or 'primary')
    else
        print('[BLACKMARKET] ' .. message)
    end
end

-- Event to unlock door
RegisterNetEvent('blackmarket:server:unlockDoor', function(doorId)
    local src = source
    local currentTime = GetGameTimer()
    
    -- Check if black market has already been accessed (PERMANENTLY DISABLED)
    if blackmarketState.accessed then
        Notify(src, 'The Black Market has already been discovered and is now permanently locked!', 'error')
        return
    end
    
    -- Spam protection - check cooldown
    if lastAttemptTime[src] and (currentTime - lastAttemptTime[src]) < ATTEMPT_COOLDOWN then
        print(string.format('[BLACKMARKET] Player %s attempted to spam door access', src))
        return
    end
    lastAttemptTime[src] = currentTime
    
    local Player = QBCore.Functions.GetPlayer(src)
    
    print('[BLACKMARKET] Door unlock attempt - Player source:', src, 'Door ID:', doorId)
    
    if not Player then
        print('[BLACKMARKET] Player not found for source:', src)
        TriggerClientEvent('blackmarket:client:doorUnlocked', src, doorId, false, 'Player not found!')
        return
    end
    
    print('[BLACKMARKET] Player found:', Player.PlayerData.name)
    
    -- Check if door exists in config
    if not Config.DoorLocations[doorId] then
        TriggerClientEvent('blackmarket:client:doorUnlocked', src, doorId, false, 'Invalid door location!')
        return
    end
    
    -- Check if door is already unlocked
    if unlockedDoors[doorId] then
        -- Door is already unlocked, just open the stash (but don't repopulate)
        if Config.Rewards.enabled and blackmarketState.stashPopulated then
            Citizen.Wait(500)
            TriggerClientEvent('blackmarket:client:openStash', src)
        end
        Notify(src, 'Black Market is already unlocked!', 'info')
        return
    end
    
    -- SERVER-SIDE KEY VALIDATION (prevents spam exploit)
    if not PlayerHasKey(src) then
        print('[BLACKMARKET] Player does not have key, sending failed attempt webhook')
        -- Send failed attempt webhook
        local playerDetails = GetPlayerDetails(src)
        print('[BLACKMARKET] Player details retrieved:', json.encode(playerDetails))
        if playerDetails then
            print('[BLACKMARKET] Sending failed access webhook for player:', playerDetails.name)
            SendDiscordWebhook(
                Config.DiscordWebhook.colors.failed,
                "🚫 Black Market Access Denied",
                "Someone attempted to access the Black Market without the required key.",
                {
                    {
                        ["name"] = "Character Name",
                        ["value"] = playerDetails.name,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player ID",
                        ["value"] = tostring(playerDetails.source),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Identifier",
                        ["value"] = playerDetails.citizenid,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Steam",
                        ["value"] = playerDetails.steam,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Discord",
                        ["value"] = playerDetails.discord,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "License",
                        ["value"] = playerDetails.license,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "License2",
                        ["value"] = playerDetails.license2,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "XBL",
                        ["value"] = playerDetails.xbl,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "FiveM",
                        ["value"] = playerDetails.fivem,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "IP",
                        ["value"] = playerDetails.ip,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Job",
                        ["value"] = playerDetails.job .. " (" .. playerDetails.jobGrade .. ")",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Location",
                        ["value"] = string.format("X: %.1f, Y: %.1f, Z: %.1f", playerDetails.location.x, playerDetails.location.y, playerDetails.location.z),
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Time",
                        ["value"] = playerDetails.time,
                        ["inline"] = true
                    }
                }
            )
        end
        
        TriggerClientEvent('blackmarket:client:doorUnlocked', src, doorId, false, Config.Messages.keyNotFound)
        return
    end
    
    -- Mark door as unlocked in memory only
    unlockedDoors[doorId] = true
    
    -- Send door unlock webhook (before stash access)
    local playerDetails = GetPlayerDetails(src)
    if playerDetails then
        SendDiscordWebhook(
            Config.DiscordWebhook.colors.info,
            "🔑 Black Market Door Unlocked",
            "Someone has unlocked the Black Market door and is about to access the stash.",
            {
                {
                    ["name"] = "Character Name",
                    ["value"] = playerDetails.name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player ID",
                    ["value"] = tostring(playerDetails.source),
                    ["inline"] = true
                },
                {
                    ["name"] = "Identifier",
                    ["value"] = playerDetails.citizenid,
                    ["inline"] = true
                },
                {
                    ["name"] = "Steam",
                    ["value"] = playerDetails.steam,
                    ["inline"] = true
                },
                {
                    ["name"] = "Discord",
                    ["value"] = playerDetails.discord,
                    ["inline"] = true
                },
                {
                    ["name"] = "License",
                    ["value"] = playerDetails.license,
                    ["inline"] = true
                },
                {
                    ["name"] = "License2",
                    ["value"] = playerDetails.license2,
                    ["inline"] = true
                },
                {
                    ["name"] = "XBL",
                    ["value"] = playerDetails.xbl,
                    ["inline"] = true
                },
                {
                    ["name"] = "FiveM",
                    ["value"] = playerDetails.fivem,
                    ["inline"] = true
                },
                {
                    ["name"] = "IP",
                    ["value"] = playerDetails.ip,
                    ["inline"] = true
                },
                {
                    ["name"] = "Job",
                    ["value"] = playerDetails.job .. " (" .. playerDetails.jobGrade .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Location",
                    ["value"] = string.format("X: %.1f, Y: %.1f, Z: %.1f", playerDetails.location.x, playerDetails.location.y, playerDetails.location.z),
                    ["inline"] = false
                },
                {
                    ["name"] = "Time",
                    ["value"] = playerDetails.time,
                    ["inline"] = true
                }
            }
        )
    end
    
    -- Notify client
    TriggerClientEvent('blackmarket:client:doorUnlocked', src, doorId, true, Config.Messages.doorUnlocked)
    
    -- Notify about door unlock
    Notify(src, 'The door unlocks with a creak... The key glows faintly.', 'info')
    
    -- Populate stash ONLY ONCE (if not already populated) and open it
    if Config.Rewards.enabled then
        PopulateBlackMarketStash() -- This function now checks if already populated
        Citizen.Wait(1000)
        TriggerClientEvent('blackmarket:client:openStash', src)
    end
    
    -- Log the event
    print(string.format('[BLACKMARKET] Player %s (%s) unlocked door %d', Player.PlayerData.name, Player.PlayerData.citizenid, doorId))
end)

-- Command to give black market key (admin only)
QBCore.Commands.Add('giveblackmarketkey', 'Give Black Market Key to a player', {
    {name = 'id', help = 'Player ID'},
    {name = 'amount', help = 'Amount (default: 1)'}
}, true, function(source, args)
    local targetId = tonumber(args[1])
    local amount = tonumber(args[2]) or 1
    
    if not targetId then
        Notify(source, 'Invalid player ID!', 'error')
        return
    end
    
    local Player = QBCore.Functions.GetPlayer(targetId)
    if not Player then
        Notify(source, 'Player not found!', 'error')
        return
    end
    
    Player.Functions.AddItem(Config.KeyItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', targetId, QBCore.Shared.Items[Config.KeyItem], 'add')
    Notify(targetId, string.format('You received %dx %s', amount, Config.KeyLabel), 'success')
    Notify(source, string.format('Gave %dx %s to %s', amount, Config.KeyLabel, Player.PlayerData.name), 'success')
end, 'admin')

-- Command to reset black market (admin only) - WARNING: This permanently resets the black market
QBCore.Commands.Add('resetblackmarket', '⚠️ PERMANENTLY RESET Black Market (will delete state file)', {}, true, function(source, args)
    -- Reset state
    blackmarketState = {
        accessed = false,
        accessedBy = nil,
        accessedAt = nil,
        stashPopulated = false
    }
    unlockedDoors = {}
    SaveState()
    
    -- Clear stash
    if Inventory == 'quasar' then
        exports['qs-inventory']:ClearOtherInventory('stash', 'blackmarket')
    elseif Inventory == 'ox' then
        exports.ox_inventory:ClearInventory('stash', 'blackmarket')
    elseif Inventory == 'qbox' then
        if exports.qbx_inventory then
            exports.qbx_inventory:ClearInventory('stash', 'blackmarket')
        end
    end
    
    Notify(source, '⚠️ Black Market has been PERMANENTLY RESET!', 'success')
    print(string.format('[BLACKMARKET] Black Market reset by admin %s', GetPlayerName(source)))
end, 'admin')

-- Command to check door status (admin only)
QBCore.Commands.Add('checkblackmarketdoors', 'Check Black Market door status', {}, true, function(source, args)
    local unlockedCount = 0
    for doorId, _ in pairs(unlockedDoors) do
        unlockedCount = unlockedCount + 1
    end
    
    local statusMsg = string.format('Black Market Status:\n- Accessed: %s\n- Unlocked Doors: %d\n- Stash Populated: %s', 
        tostring(blackmarketState.accessed), 
        unlockedCount,
        tostring(blackmarketState.stashPopulated))
    
    if blackmarketState.accessed then
        statusMsg = statusMsg .. string.format('\n- Accessed By: %s\n- Accessed At: %s', 
            tostring(blackmarketState.accessedBy),
            tostring(blackmarketState.accessedAt))
    end
    
    TriggerClientEvent('chat:addMessage', source, {
        color = {255, 255, 0},
        multiline = true,
        args = {"Black Market", statusMsg}
    })
end, 'admin')

-- Event to populate stash and open it for player
RegisterNetEvent('blackmarket:server:populateAndOpenStash', function()
    local src = source
    
    -- Check if already accessed
    if blackmarketState.accessed then
        Notify(src, 'The Black Market has already been discovered!', 'error')
        return
    end
    
    print('[BLACKMARKET] Populating stash and opening for player:', src)
    
    -- Populate the stash with rewards (only once)
    PopulateBlackMarketStash()
    
    -- Wait longer for stash to be fully populated
    Citizen.Wait(1000)
    
    print('[BLACKMARKET] Triggering client event to open stash')
    
    -- Open the stash using the same method as teststash command
    TriggerClientEvent('blackmarket:client:openStash', src)
end)

-- Event to handle stash opening
RegisterNetEvent('inventory:server:OpenInventory', function(name, id, other)
    local src = source
    
    if name == 'stash' and id == 'blackmarket' then
        -- Check if already accessed
        if blackmarketState.accessed then
            Notify(src, 'The Black Market has already been discovered!', 'error')
            return
        end
        
        print('[BLACKMARKET] Player opening black market stash, source:', src)
        
        -- Always open the stash regardless of key status (but only if not accessed)
        if Inventory == 'ox' then
            exports.ox_inventory:forceOpenInventory(src, 'stash', 'blackmarket')
        else
            TriggerClientEvent('inventory:client:openStash', src, 'blackmarket')
        end
    end
end)

-- Event to handle when stash is closed (mark as accessed and consume key)
RegisterNetEvent('blackmarket:server:stashClosed', function()
    local src = source
    
    print('[BLACKMARKET] Stash closed for player:', src)
    
    -- Mark black market as accessed PERMANENTLY
    if not blackmarketState.accessed then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            blackmarketState.accessed = true
            blackmarketState.accessedBy = Player.PlayerData.citizenid
            blackmarketState.accessedAt = os.date("%Y-%m-%d %H:%M:%S")
            SaveState()
            
            print('[BLACKMARKET] Black Market marked as accessed PERMANENTLY by: ' .. Player.PlayerData.name)
            
            -- Consume the key when they close the stash (only if they still have it)
            if PlayerHasKey(src) then
                if ConsumeKey(src) then
                    print('[BLACKMARKET] Key consumed after stash closed for player:', src)
                    Notify(src, 'The ancient key crumbles to dust as you close the black market!', 'success')
                end
            end
            
            -- Send successful access webhook
            local playerDetails = GetPlayerDetails(src)
            if playerDetails then
                SendDiscordWebhook(
                    Config.DiscordWebhook.colors.success,
                    "🔓 Black Market Successfully Accessed - PERMANENTLY DISABLED",
                    "Someone has successfully accessed the Black Market and claimed the ancient treasures! The Black Market is now PERMANENTLY DISABLED.",
                    {
                        {
                            ["name"] = "Character Name",
                            ["value"] = playerDetails.name,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player ID",
                            ["value"] = tostring(playerDetails.source),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Identifier",
                            ["value"] = playerDetails.citizenid,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Steam",
                            ["value"] = playerDetails.steam,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Discord",
                            ["value"] = playerDetails.discord,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "License",
                            ["value"] = playerDetails.license,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "License2",
                            ["value"] = playerDetails.license2,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "XBL",
                            ["value"] = playerDetails.xbl,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "FiveM",
                            ["value"] = playerDetails.fivem,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "IP",
                            ["value"] = playerDetails.ip,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Job",
                            ["value"] = playerDetails.job .. " (" .. playerDetails.jobGrade .. ")",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Location",
                            ["value"] = string.format("X: %.1f, Y: %.1f, Z: %.1f", playerDetails.location.x, playerDetails.location.y, playerDetails.location.z),
                            ["inline"] = false
                        },
                        {
                            ["name"] = "Loot Available",
                            ["value"] = FormatLootItems(),
                            ["inline"] = false
                        },
                        {
                            ["name"] = "Time",
                            ["value"] = playerDetails.time,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "⚠️ WARNING",
                            ["value"] = "Black Market is now PERMANENTLY DISABLED",
                            ["inline"] = false
                        }
                    }
                )
            end
        end
    else
        print('[BLACKMARKET] Black Market already accessed, ignoring close event')
    end
end)

-- Event to give black market rewards to player (legacy - now using stash)
RegisterNetEvent('blackmarket:server:giveRewards', function()
    local src = source
    -- This is now handled by the stash system
    Notify(src, 'Black market stash is ready!', 'success')
end)

-- Export function for other scripts
exports('IsDoorUnlocked', function(doorId)
    return unlockedDoors[doorId] or false
end)

exports('IsBlackMarketAccessed', function()
    return blackmarketState.accessed or false
end)

-- Event to check access status (for clients)
RegisterNetEvent('blackmarket:server:checkAccessStatus', function()
    local src = source
    TriggerClientEvent('blackmarket:client:accessStatus', src, blackmarketState.accessed)
end)

-- Load state on resource start
LoadState()

-- Send startup webhook
CreateThread(function()
    Wait(5000) -- Wait 5 seconds after resource start
    if Config.DiscordWebhook.enabled then
        local status = blackmarketState.accessed and "🔴 PERMANENTLY DISABLED" or "🟢 Active"
        SendDiscordWebhook(
            Config.DiscordWebhook.colors.info,
            "🔓 Black Market System Online",
            "The Black Market security system has been initialized and is monitoring for activity.",
            {
                {
                    ["name"] = "Doors Monitored",
                    ["value"] = tostring(#Config.DoorLocations),
                    ["inline"] = true
                },
                {
                    ["name"] = "Rewards Available",
                    ["value"] = tostring(#Config.Rewards.items),
                    ["inline"] = true
                },
                {
                    ["name"] = "Framework",
                    ["value"] = Framework,
                    ["inline"] = true
                },
                {
                    ["name"] = "Inventory",
                    ["value"] = Inventory,
                    ["inline"] = true
                },
                {
                    ["name"] = "Status",
                    ["value"] = status,
                    ["inline"] = true
                },
                {
                    ["name"] = "Accessed",
                    ["value"] = tostring(blackmarketState.accessed),
                    ["inline"] = true
                }
            }
        )
    end
end)

-- Framework Detection
local Framework = nil
local QBCore = nil
local PlayerData = {}

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
elseif GetResourceState('qbx_inventory') == 'started' or GetResourceState('ox_inventory') == 'started' then
    Inventory = 'qbox'
else
    print('[BLACKMARKET] Warning: No inventory detected! Using qs-inventory as fallback.')
    Inventory = 'quasar'
end

local doorTargets = {}

-- Notification Helper
local function Notify(message, type)
    if exports.ox_lib then
        exports.ox_lib:notify({
            title = 'Black Market',
            description = message,
            type = type or 'info',
            duration = 5000
        })
    elseif QBCore and QBCore.Functions then
        QBCore.Functions.Notify(message, type or 'primary')
    else
        print('[BLACKMARKET] ' .. message)
    end
end

-- Initialize player data
if Framework == 'qb' then
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = QBCore.Functions.GetPlayerData()
        SetupDoorTargets()
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerData = {}
        RemoveDoorTargets()
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerData.job = JobInfo
    end)
elseif Framework == 'qbox' then
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = QBCore.Functions.GetPlayerData()
        SetupDoorTargets()
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerData = {}
        RemoveDoorTargets()
    end)
end

-- Function to check if player has the black market key
local function HasBlackMarketKey()
    if not PlayerData then
        print('[BLACKMARKET] PlayerData not loaded')
        return false
    end
    
    local hasKey = false
    
    if Inventory == 'quasar' then
        -- Quasar Inventory (qs-inventory)
        hasKey = exports['qs-inventory']:Search(Config.KeyItem)
        hasKey = hasKey and hasKey > 0
    elseif Inventory == 'qbox' then
        -- QBox Inventory or OX Inventory
        if GetResourceState('ox_inventory') == 'started' then
            -- OX Inventory - use Search for count
            local items = exports.ox_inventory:Search('count', Config.KeyItem)
            hasKey = items and items > 0
        elseif GetResourceState('qbx_inventory') == 'started' then
            -- QBox Inventory
            if exports.qbx_inventory and exports.qbx_inventory.Search then
                local items = exports.qbx_inventory:Search('count', Config.KeyItem)
                hasKey = items and items > 0
            else
                -- Fallback: check via framework
                if PlayerData.items then
                    for _, item in pairs(PlayerData.items) do
                        if item.name == Config.KeyItem and item.amount and item.amount > 0 then
                            hasKey = true
                            break
                        end
                    end
                end
            end
        else
            -- Fallback: check via framework
            if PlayerData.items then
                for _, item in pairs(PlayerData.items) do
                    if item.name == Config.KeyItem and item.amount and item.amount > 0 then
                        hasKey = true
                        break
                    end
                end
            end
        end
    end
    
    return hasKey
end

-- Function to setup door targets using ox_target
function SetupDoorTargets()
    RemoveDoorTargets() -- Clean up existing targets
    
    -- Check if black market has been accessed
    TriggerServerEvent('blackmarket:server:checkAccessStatus')
    
    for i, door in ipairs(Config.DoorLocations) do
        local targetId = 'blackmarket_door_' .. i
        
        local zoneId = exports.ox_target:addBoxZone({
            coords = door.coords,
            size = vec3(1.0, 1.0, 3.0),
            rotation = door.heading or 0,
            debug = false,
            options = {
                {
                    name = targetId .. '_unlock',
                    icon = door.icon or 'fas fa-key',
                    label = door.label or 'Black Market Access',
                    canInteract = function()
                        return HasBlackMarketKey()
                    end,
                    onSelect = function()
                        if HasBlackMarketKey() then
                            TriggerServerEvent('blackmarket:server:unlockDoor', i)
                        else
                            Notify(Config.Messages.noKey, 'error')
                        end
                    end
                },
                {
                    name = targetId .. '_locked',
                    icon = 'fas fa-lock',
                    label = 'Black Market Access (Locked)',
                    canInteract = function()
                        return not HasBlackMarketKey()
                    end,
                    onSelect = function()
                        Notify(Config.Messages.noKey, 'error')
                        TriggerServerEvent('blackmarket:server:unlockDoor', i)
                    end
                }
            },
            distance = door.distance or 2.0
        })
        
        doorTargets[targetId] = zoneId
    end
end

-- Event to handle black market access status
RegisterNetEvent('blackmarket:client:accessStatus', function(accessed)
    if accessed then
        -- Remove all targets if black market has been accessed
        RemoveDoorTargets()
        print('[BLACKMARKET] Black Market has been accessed - targets removed')
    end
end)

-- Function to remove door targets
function RemoveDoorTargets()
    for targetId, zoneId in pairs(doorTargets) do
        if zoneId then
            exports.ox_target:removeZone(zoneId)
        end
    end
    doorTargets = {}
end

-- Legacy event handlers for compatibility
RegisterNetEvent('blackmarket:client:checkDoor', function(data)
    local doorId = data and data.doorId or nil
    
    if not HasBlackMarketKey() then
        Notify(Config.Messages.noKey, 'error')
        return
    end
    
    -- Trigger server event to unlock door and consume key
    TriggerServerEvent('blackmarket:server:unlockDoor', doorId)
end)

RegisterNetEvent('blackmarket:client:checkDoorNoKey', function(data)
    local doorId = data and data.doorId or nil
    
    print('[BLACKMARKET] Player attempted access without key, doorId:', doorId)
    
    -- Show message that key is needed
    Notify(Config.Messages.noKey, 'error')
    
    -- Trigger server event to log the attempt and send webhook
    TriggerServerEvent('blackmarket:server:unlockDoor', doorId)
end)

-- Event to handle door unlock response
RegisterNetEvent('blackmarket:client:doorUnlocked', function(doorId, success, message)
    if success then
        Notify(message, 'success')
        
        -- Open black market inventory if rewards are enabled
        if Config.Rewards.enabled then
            Citizen.Wait(1000) -- Small delay to ensure door unlock message is seen
            OpenBlackMarketInventory()
        end
    else
        Notify(message, 'error')
    end
end)

-- Function to open black market inventory
function OpenBlackMarketInventory()
    if not Config.Rewards.enabled then return end
    
    Notify(Config.Messages.inventoryOpened, 'success')
    
    -- Request server to populate stash first, then open it
    TriggerServerEvent('blackmarket:server:populateAndOpenStash')
end

-- Event to refresh targets (called when inventory changes)
RegisterNetEvent('blackmarket:client:refreshTargets', function()
    if PlayerData then
        SetupDoorTargets()
    end
end)

-- Listen for inventory changes to refresh targets
RegisterNetEvent('inventory:client:ItemBox', function(itemData, amount)
    if itemData and itemData.name == Config.KeyItem then
        -- Refresh targets when key is added/removed
        Citizen.Wait(1000) -- Small delay to ensure inventory is updated
        TriggerEvent('blackmarket:client:refreshTargets')
    end
end)

-- Command to test key detection
RegisterCommand('testkey', function()
    local hasKey = HasBlackMarketKey()
    if hasKey then
        Notify('You have the Black Market Key!', 'success')
    else
        Notify('You do not have the Black Market Key!', 'error')
    end
end)

-- Command to test black market inventory
RegisterCommand('testblackmarket', function()
    OpenBlackMarketInventory()
end)

-- Command to test stash opening directly
RegisterCommand('teststash', function()
    if Inventory == 'quasar' then
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'blackmarket')
    else
        -- QBox/OX Inventory
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'blackmarket')
    end
end)

-- Track if stash is currently open
local stashOpen = false
local stashOpenTime = 0

-- Event to open stash after it's populated
RegisterNetEvent('blackmarket:client:openStash', function(stashId)
    print('[BLACKMARKET] Client received openStash event, stashId:', stashId)
    print('[BLACKMARKET] Opening stash using inventory system')
    
    -- Small delay to ensure stash is ready
    Citizen.Wait(500)
    
    stashOpen = true
    stashOpenTime = GetGameTimer()
    
    if Inventory == 'quasar' then
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'blackmarket')
    else
        -- QBox/OX Inventory
        if GetResourceState('ox_inventory') == 'started' then
            exports.ox_inventory:openInventory('stash', 'blackmarket')
        else
            TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'blackmarket')
        end
    end
    
    print('[BLACKMARKET] Stash open request sent to server')
    
    -- Wait a bit for stash to actually open
    Citizen.Wait(1000)
    
    -- Monitor when stash is closed (improved detection)
    CreateThread(function()
        local checkCount = 0
        local wasFocused = false
        local minOpenTime = 2000 -- Must be open for at least 2 seconds
        
        while stashOpen do
            Citizen.Wait(500) -- Check every 500ms
            
            local isFocused = IsNuiFocused()
            local timeOpen = GetGameTimer() - stashOpenTime
            
            -- Only start tracking after minimum open time to prevent false positives
            if timeOpen >= minOpenTime then
                if isFocused then
                    wasFocused = true
                elseif wasFocused and not isFocused then
                    -- Stash was open and now closed (confirmed closed)
                    print('[BLACKMARKET] Stash confirmed closed after being open')
                    stashOpen = false
                    TriggerServerEvent('blackmarket:server:stashClosed')
                    break
                end
            end
            
            checkCount = checkCount + 1
            -- Timeout after 5 minutes (prevent infinite loops)
            if checkCount > 600 then
                print('[BLACKMARKET] Stash monitoring timeout')
                stashOpen = false
                break
            end
        end
    end)
end)

-- Also listen for inventory close events (backup detection)
RegisterNetEvent('inventory:client:closeInventory', function()
    if stashOpen then
        Citizen.Wait(500) -- Small delay to ensure it's actually closed
        if not IsNuiFocused() then
            print('[BLACKMARKET] Stash closed via inventory close event')
            stashOpen = false
            TriggerServerEvent('blackmarket:server:stashClosed')
        end
    end
end)

-- Debug: Check if client event is registered
print('[BLACKMARKET] Framework detected: ' .. Framework)
print('[BLACKMARKET] Inventory detected: ' .. Inventory)
print('[BLACKMARKET] Client event blackmarket:client:openStash registered')

-- Initialize on resource start
CreateThread(function()
    local attempts = 0
    while attempts < 50 do
        if Framework == 'qb' then
            if LocalPlayer.state.isLoggedIn then
                PlayerData = QBCore.Functions.GetPlayerData()
                SetupDoorTargets()
                break
            end
        elseif Framework == 'qbox' then
            if LocalPlayer.state.isLoggedIn or LocalPlayer.state.isLoggedIn == nil then
                PlayerData = QBCore.Functions.GetPlayerData()
                SetupDoorTargets()
                break
            end
        end
        attempts = attempts + 1
        Citizen.Wait(100)
    end
end)
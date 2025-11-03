local QBCore = exports['qb-core']:GetCoreObject()

-- Inventory Detection
local Inventory = nil
if GetResourceState('qs-inventory') == 'started' then
    Inventory = 'quasar'
elseif GetResourceState('ox_inventory') == 'started' then
    Inventory = 'ox'
elseif GetResourceState('qbx_inventory') == 'started' then
    Inventory = 'qbox'
else
    print('[OLRP Tester] Warning: No inventory detected! Using qs-inventory as fallback.')
    Inventory = 'quasar'
end

-- Notification Helper
local function Notify(src, message, type)
    if exports.ox_lib then
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'OLRP Tester',
            description = message,
            type = type or 'info',
            duration = 5000
        })
    elseif QBCore and QBCore.Functions then
        QBCore.Functions.Notify(src, message, type or 'primary')
    else
        print('[OLRP Tester] ' .. message)
    end
end

-- Give item to player
RegisterNetEvent("olrp_tester:server:giveItem", function(itemName, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    -- Validate amount
    amount = tonumber(amount) or 1
    if amount <= 0 then
        Notify(src, "Invalid amount!", "error")
        return
    end
    
    if amount > Config.MaxAmount then
        Notify(src, "Maximum amount is " .. Config.MaxAmount, "error")
        return
    end
    
    -- Validate item exists in config
    local itemFound = false
    local itemLabel = itemName
    
    for _, category in pairs(Config.ItemCategories) do
        for _, item in pairs(category.items) do
            if item.name == itemName then
                itemFound = true
                itemLabel = item.label
                break
            end
        end
        if itemFound then break end
    end
    
    if not itemFound then
        Notify(src, "Item not found in tester!", "error")
        return
    end
    
    -- Give item based on inventory system
    local success = false
    local playerName = Player.PlayerData.name or "Unknown"
    
    if Inventory == 'quasar' then
        -- qs-inventory
        success = exports['qs-inventory']:AddItem(src, itemName, amount, nil)
    elseif Inventory == 'ox' then
        -- ox_inventory
        success = exports.ox_inventory:AddItem(src, itemName, amount)
    elseif Inventory == 'qbox' then
        -- qbx_inventory
        if exports.qbx_inventory then
            success = exports.qbx_inventory:AddItem(src, itemName, amount)
        else
            -- Fallback to QBCore method
            success = Player.Functions.AddItem(itemName, amount)
        end
    else
        -- Fallback to QBCore method
        success = Player.Functions.AddItem(itemName, amount)
    end
    
    if success then
        Notify(src, "You received " .. amount .. "x " .. itemLabel, "success")
        print(string.format("[OLRP Tester] %s (%s) received %dx %s", playerName, src, amount, itemLabel))
    else
        Notify(src, "Could not add item to inventory!", "error")
    end
end)

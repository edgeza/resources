---@diagnostic disable: duplicate-set-field
-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
-- JPR Inventory integration for Wasabi Bridge
local found = GetResourceState('jpr-inventory')
if found ~= 'started' and found ~= 'starting' then return end

WSB.inventory = {}
WSB.inventorySystem = 'jpr-inventory'

local registeredShops = {}

-- Register shop event handler
RegisterNetEvent('wasabi_bridge:registerShop', function(data)
    if source ~= '' or not GetInvokingResource() then return end
    
    -- Convert wasabi shop data to jpr-inventory format
    local shopItems = {}
    for _, item in pairs(data.inventory) do
        shopItems[#shopItems + 1] = {
            name = item.name,
            price = item.price,
            amount = item.amount or 999
        }
    end
    
    -- Create shop using jpr-inventory exports
    exports['jpr-inventory']:CreateShop({
        name = data.identifier,
        label = data.name,
        items = shopItems,
        requiredJob = data.groups
    })
    
    registeredShops[data.identifier] = true
end)

-- Open shop event handler
RegisterNetEvent('wasabi_bridge:openShop', function(data)
    if not data or not data.identifier or not registeredShops[data.identifier] then return end
    
    if data.groups and not WSB.hasGroup(source, data.groups) then return end
    
    local shopData = registeredShops[data.identifier]
    -- Use jpr-inventory exports
    exports['jpr-inventory']:OpenShop(source, data.identifier)
end)

-- Open stash event handler
RegisterNetEvent('wasabi_bridge:openStash', function(data)
    local src = source
    -- Use jpr-inventory exports
    exports['jpr-inventory']:OpenInventory(src, 'stash', data.name, {
        label = data.name,
        slots = data.slots,
        maxweight = data.maxWeight
    })
end)

-- Open player inventory event handler
RegisterNetEvent('wasabi_bridge:openPlayerInventory', function(targetId)
    local src = source
    -- Use jpr-inventory exports
    exports['jpr-inventory']:OpenInventoryById(src, targetId)
end)

-- Get item slot function
function WSB.inventory.getItemSlot(source, itemName)
    local player = WSB.getPlayer(source)
    if not player then return false end
    
    local item = exports['jpr-inventory']:GetItemByName(source, itemName)
    return item and item.slot or false
end

-- Get item slots function
function WSB.inventory.getItemSlots(source, itemName)
    local player = WSB.getPlayer(source)
    if not player then return {} end
    
    local items = exports['jpr-inventory']:GetItemsByName(source, itemName)
    local slots = {}
    for _, item in pairs(items) do
        slots[#slots + 1] = item.slot
    end
    return slots
end

-- Get item metadata function
function WSB.inventory.getItemMetadata(source, slot)
    local item = exports['jpr-inventory']:GetItemBySlot(source, slot)
    return item and item.info or {}
end

-- Set item metadata function
function WSB.inventory.setItemMetadata(source, slot, metadata)
    if not slot then return false end
    
    local item = exports['jpr-inventory']:GetItemBySlot(source, slot)
    if not item then return false end
    
    item.info = metadata
    exports['jpr-inventory']:SetItemData(source, slot, item)
    return true
end

-- Clear inventory function
function WSB.inventory.clearInventory(source, identifier, keepItems)
    exports['jpr-inventory']:ClearInventory(source, keepItems)
end

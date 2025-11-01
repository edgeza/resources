---@diagnostic disable: duplicate-set-field
-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
-- JPR Inventory client integration for Wasabi Bridge
local found = GetResourceState('jpr-inventory')
if found ~= 'started' and found ~= 'starting' then return end

WSB.inventorySystem = 'jpr-inventory'
WSB.inventory = {}

-- Open player inventory function
function WSB.inventory.openPlayerInventory(targetId)
    TriggerServerEvent('wasabi_bridge:openPlayerInventory', targetId)
end

-- Open stash function
function WSB.inventory.openStash(data)
    -- data = {name = name, unique = true, maxWeight = maxWeight, slots = slots}
    if data.unique then
        data.name = ('%s_%s'):format(data.name, WSB.getIdentifier())
    end
    
    TriggerServerEvent('wasabi_bridge:openStash', data)
end

-- Open shop function
function WSB.inventory.openShop(data)
    --[[
    data = {
        identifier = 'shop_identifier',
        name = 'Shop Name',
        inventory = {
            { name = 'item_name', price = 100 },
        }
    ]]
    TriggerServerEvent('wasabi_bridge:openShop', data)
end

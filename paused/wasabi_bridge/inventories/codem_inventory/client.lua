---@diagnostic disable: duplicate-set-field
-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
-- Use this file to add support for another inventory by simply copying the file and replacing the logic within the functions
local found = GetResourceState('codem-inventory')
if found ~= 'started' and found ~= 'starting' then return end

WSB.inventorySystem = 'codem-inventory'
WSB.inventory = {}

function WSB.inventory.openPlayerInventory(targetId)
    TriggerServerEvent('codem-inventory:server:robplayer', targetId)
end

function WSB.inventory.openStash(data)
    -- data = {name = name, unique = true, maxWeight = maxWeight, slots = slots}
    if data.unique then
        data.name = ('%s_%s'):format(data.name, WSB.getIdentifier())
    end

    TriggerServerEvent('inventory:server:OpenInventory', 'stash', data.name,
        { maxweight = data.maxWeight, slots = data.slots })
    TriggerEvent('inventory:client:SetCurrentStash', data.name)
end

function WSB.inventory.openShop(data)
    --[[
data = {
    identifier = 'shop_identifier',
    name = 'Shop Name',
    inventory = {
        { name = 'item_name', price = 100 },
    },
    locations = {
        vec3(0, 0, 0),
    }
]]
    print('^2[DEBUG] Shop data received:^7')
    print(json.encode(data, {indent = true}))
    
    local inventoryData = data.inventory or {}
    print('^2[DEBUG] Inventory data:^7')
    print(json.encode(inventoryData, {indent = true}))
    
    -- Pass the inventory array directly to codem-inventory
    TriggerEvent('codem-inventory:OpenPlayerShop', inventoryData)
end

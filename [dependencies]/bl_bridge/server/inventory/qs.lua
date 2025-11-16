local utils = require 'utils'
local retreiveExportsData = utils.retreiveExportsData
local overrideFunction = {}
local registeredInventories = {}
local inventoryName = GetFramework('inventory')
local inventory = exports[inventoryName]

overrideFunction.methods = retreiveExportsData(inventory, {
    addItem = {
        originalMethod = 'AddItem',
        modifier = {
            passSource = true,
            effect = function(originalFun, src, name, amount, metadata, slot)
                return originalFun(src, name, amount, slot, metadata)
            end
        }
    },
    removeItem = {
        originalMethod = 'RemoveItem',
        modifier = {
            passSource = true,
            effect = function(originalFun, src, name, amount, slot, metadata)
                return originalFun(src, name, amount, slot, metadata)
            end
        }
    },
    setMetaData = {
        originalMethod = 'SetItemMetadata',
        modifier = {
            passSource = true,
            effect = function(originalFun, src, slot, data)
                return originalFun(src, slot, data)
            end
        }
    },
    canCarryItem = {
        originalMethod = 'CanCarryItem',
        modifier = {
            passSource = true,
        }
    },
    getItem = {
        originalMethod = 'GetInventory',
        modifier = {
            passSource = true,
            effect = function(originalFun, src, itemName)
                local playerInventory = originalFun(src)
                if not playerInventory then
                    return false, 'Item not exist or you don\'t have it'
                end

                -- Search through inventory for the item
                for slot, itemData in pairs(playerInventory) do
                    if itemData.name == itemName then
                        return {
                            label = itemData.label or itemName,
                            name = itemData.name,
                            weight = itemData.weight or 0,
                            slot = tonumber(slot),
                            close = false,
                            stack = true,
                            metadata = itemData.info or {},
                            count = itemData.amount or 1
                        }
                    end
                end

                return false, 'Item not exist or you don\'t have it'
            end
        }
    },
})

local registeredItems = {}

-- Listen for qs-inventory item usage events
AddEventHandler('qs-inventory:server:itemUsed', function(source, itemName, slot, metadata)
    local itemEffect = registeredItems[itemName]
    if not itemEffect then return end
    itemEffect(source, slot, metadata)
end)

function overrideFunction.registerUsableItem(name, cb)
    registeredItems[name] = cb
    -- Register with qs-inventory if CreateUsableItem exists
    if inventory.CreateUsableItem then
        inventory:CreateUsableItem(name, function(source, item)
            local metadata = item.metadata or item.info or {}
            cb(source, item.slot, metadata)
        end)
    end
end

function overrideFunction.registerInventory(id, data)
    local type, name, items, slots, maxWeight in data

    registeredInventories[('%s-%s'):format(type, id)] = {
        label     = name,
        items     = items,
        slots     = slots or 50,
        maxweight = maxWeight or 1000
    }

    -- Register stash with qs-inventory
    if type == 'stash' and inventory.RegisterStash then
        inventory:RegisterStash(id, slots or 50, maxWeight or 1000)
    end
end

utils.register('bl_bridge:validInventory', function(src, invType, invId)
    local inventoryData = registeredInventories[('%s-%s'):format(invType, invId)]
    if not inventoryData then return end

    return inventoryData
end)

return overrideFunction



if isBridgeLoaded('Inventory', Inventory.ORIGEN) then
    Inventory.hasItem = function(client, item, amount)
        if amount == nil then
            amount = 1
        end

        return exports[Bridge.Inventory]:HasItem(client, item, amount)
    end

    Inventory.addItem = function(client, item, amount, data)
        exports[Bridge.Inventory]:AddItem(client, item, amount, nil, data, true)
        return true
    end

    Inventory.removeItem = function(client, item, amount, data)
        exports[Bridge.Inventory]:RemoveItem(client, item, amount)
        return true
    end

    Inventory.registerUsableItem = function(name, cb)
        if isBridgeLoaded('Framework', Framework.QBCore) then
            Framework.object.Functions.CreateUseableItem(name, function(source, item)
                cb(source, name)
            end)
        end

        if isBridgeLoaded('Framework', Framework.ESX) then
            Framework.object.RegisterUsableItem(name, function(source)
                cb(source, name)
            end)
        end
    end

    Inventory.createInventory = function(name, label, slots, maxWeight, owner)
        exports[Bridge.Inventory]:RegisterStash(name, {
            label = label,
            slots = slots,
            weight = maxWeight
        })
    end

    Inventory.getInventoryItems = function(name, owner)
        return exports[Bridge.Inventory]:GetStashItems(name)
    end

    Inventory.clearInventory = function(name)
        local invName = name:gsub(':', '')
        exports[Bridge.Inventory]:ClearInventory(invName)
    end

    Inventory.openInventory = function(client, name, type)
        local invName = name:gsub(':', '')
        exports[Bridge.Inventory]:OpenInventory(client, 'stash', invName)
    end
end

if isBridgeLoaded('Inventory', Inventory.MF) then
    if not isBridgeLoaded('Framework', Framework.ESX) then
        log.error('Inventory MF bridge requires Framework ESX to be loaded.')
        return
    end

    Inventory.hasItem = function(client, item, amount)
        if amount == nil then
            amount = 1
        end

        local identifier = Framework.getIdentifier(client)
        local item = exports[Inventory.MF]:getInventoryItem(identifier, item)

        return item and item.count >= amount
    end

    --- @return boolean success
    Inventory.addItem = function(client, item, amount, data)
        local identifier = Framework.getIdentifier(client)
        exports[Inventory.MF]:addInventoryItem(identifier, item, amount, client, nil, data)
        return true
    end

    Inventory.removeItem = function(client, item, amount, data)
        local identifier = Framework.getIdentifier(client)
        exports[Inventory.MF]:removeInventoryItem(identifier, item, amount, client, data, data)
        return true
    end

    Inventory.registerUsableItem = function(name, cb)
        Framework.object.RegisterUsableItem(name, cb)
    end

    Inventory.createInventory = function(name, label, slots, maxWeight, owner)
        return exports[Inventory.MF]:createInventory(name, 'inventory', 'xmas', label, maxWeight, slots, {})
    end

    Inventory.getInventoryItems = function(name, owner)
        return exports[Inventory.MF]:getInventoryItems(name)
    end

    Inventory.items = function()
        return Framework.object.Items
    end

    Inventory.clearInventory = function(name)
        return exports[Inventory.MF]:clearInventory(name)
    end

    AssetDeployer:registerDeploy('items', Inventory.MF, function(data)
        for _, item in ipairs(data) do
            MySQL.Sync.execute('INSERT INTO items (name, label, weight, rare, can_remove) VALUES (?, ?, ?, 0, 1)', {
                item.name,
                item.label,
                item.weight
            })
        end

        return true
    end, ESX_ITEMS_DEPLOY)
end

ESX_ITEMS_DEPLOY = {
    {
        name = 'xmas_gift',
        label = 'Unpacked',
        weight = 100,
    },
    {
        name = 'xmas_packed_gift',
        label = 'Packed Gift',
        weight = 250,
    },
    {
        name = 'xmas_tree',
        label = 'Christmas Tree',
        weight = 350,
    },
    {
        name = 'xmas_star',
        label = 'Christmas Star',
        weight = 50,
    },
    {
        name = 'xmas_decor',
        label = 'Christmas Decor',
        weight = 50,
    }
}

if (isBridgeLoaded('Inventory', Inventory.ESX) or isBridgeLoaded('Inventory', Inventory.QS)) and isBridgeLoaded('Framework', Framework.ESX) then
    if not isBridgeLoaded('Framework', Framework.ESX) then
        log.error(
            'ESX inventory is selected but ESX is not the framework resource. Please change the framework resource or the inventory type.')
        return
    end

    Inventory.hasItem = function(client, item)
        local player = Framework.object.GetPlayerFromId(client)
        if player == nil then return false end

        if player.hasItem ~= nil then
            return player.hasItem(item)
        end

        local itemInfo = player.getInventoryItem(item)
        return itemInfo ~= nil and itemInfo.count > 0
    end

    --- @return boolean success
    Inventory.addItem = function(client, item, amount, data)
        local player = Framework.object.GetPlayerFromId(client)
        if player == nil then return false end

        player.addInventoryItem(item, amount, data)
        return true
    end

    Inventory.removeItem = function(client, item, amount, data)
        local player = Framework.object.GetPlayerFromId(client)
        if player == nil then return false end

        player.removeInventoryItem(item, amount, data)
        return true
    end

    Inventory.registerUsableItem = function(item, cb)
        Framework.object.RegisterUsableItem(item, cb)
    end

    Inventory.items = function()
        return Framework.object.Items
    end

    if not isBridgeLoaded('Inventory', Inventory.QS) then
        Inventory.createInventory = function(name, label, slots, maxWeight)
            log.error('ESX Inventory does not support creating inventories or stashes.')
        end

        AssetDeployer:registerDeploy('items', Framework.ESX, function(data)
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
end

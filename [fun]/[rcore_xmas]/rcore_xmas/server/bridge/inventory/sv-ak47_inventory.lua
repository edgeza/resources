AK47_INVENTORY_ITEMS_DEPLOY = {
    {
        name = 'xmas_gift',
        label = 'Unpacked',
        weight = 1,
        stacksize = 1,
        close = true,
    },
    {
        name = 'xmas_packed_gift',
        label = 'Packed Gift',
        weight = 1,
        stacksize = 1,
        close = true,
    },
    {
        name = 'xmas_tree',
        label = 'Christmas Tree',
        weight = 1,
        stacksize = 1,
        close = true,
    },
    {
        name = 'xmas_star',
        label = 'Christmas Star',
        weight = 1,
        stacksize = 1,
        close = true,
    },
    {
        name = 'xmas_decor',
        label = 'Christmas Decor',
        weight = 1,
        stacksize = 1,
        close = true,
    }
}

if isBridgeLoaded('Inventory', Inventory.AK47) then
    Inventory.hasItem = function(client, item, amount)
        if amount == nil then
            amount = 1
        end

        local identifier = Framework.getIdentifier(client)
        local inventoryItems = exports[Bridge.Inventory]:GetInventoryItems(client)
        for _, itemObject in ipairs(inventoryItems) do
            if itemObject.name == item then
                if (itemObject.count == nil and itemObject.amount >= amount) or itemObject.count >= amount then
                    return true
                end
            end
        end

        return false
    end

    --- @return boolean success
    Inventory.addItem = function(client, item, amount, data)
        return exports[Bridge.Inventory]:AddItem(client, item, amount, nil, data)
    end

    Inventory.addMultipleItems = function(client, items)
        if not client then
            return
        end

        if not items then
            return
        end

        local p = promise.new()

        if next(items) then
            for i = 1, #items, 1 do
                local item = items[i]

                if item then
                    Inventory.addItem(client, item.name, item.count, item.metadata)
                end

                if i >= #items then
                    p:resolve(true)
                end
            end
        else
            p:resolve(false)
        end

        return Citizen.Await(p)
    end

    Inventory.removeItem = function(client, item, amount, data)
        return exports[Bridge.Inventory]:RemoveItem(client, item, amount)
    end

    Inventory.registerUsableItem = function(name, cb)
        AddEventHandler(string.format('rcore_xmas:ak47itemUsed:%s', name), function(playerId, itemName, slotId, metadata)
            if name == itemName then
                cb(playerId, itemName, slotId, metadata)
            end
        end)
    end

    Inventory.getInventoryItems = function(playerId)
        local inv = exports[Bridge.Inventory]:GetInventoryItems(playerId)
        local inventory, count = {}, 0

        for k, v in pairs(inv) do
            if v.name and v.count > 0 then
                count += 1
                inventory[count] = {
                    name = v.name,
                    count = v.count,
                    slot = k,
                    metadata = next(v.metadata) and v.metadata or nil
                }
            end
        end

        return inventory
    end

    Inventory.clearInventory = function(name)
        local invName = name:gsub(':', '')
        exports[Bridge.Inventory]:ClearInventory(invName)
        return true
    end

    Inventory.openInventory = function(client, name, type)
        local invName = name:gsub(':', '')
        exports[Bridge.Inventory]:OpenInventory(client, invName)
    end

    Inventory.createInventory = function(name, label, slots, maxWeight, owner)
        local invName = name:gsub(':', '')

        local exists = MySQL.Sync.fetchScalar('SELECT 1 FROM ak47_inventory WHERE identifier = @identifier', {
            ['@identifier'] = invName
        })
        if exists then return end

        return exports[Bridge.Inventory]:CreateInventory(invName, {
            label = label,
            slots = slots,
            maxWeight = maxWeight,
            type = 'stash',
        })
    end

    AssetDeployer:registerCopyFilesDeploy('items-images', Bridge.Inventory, 'assets/inventory_images',
        'web/images',
        function(data)
            local files = {}

            for _, item in ipairs(data) do
                table.insert(files, item .. '.png')
            end

            return files
        end,
        { 'xmas_gift', 'xmas_packed_gift', 'xmas_tree', 'xmas_star', 'xmas_decor' }
    )

    AssetDeployer:registerFileDeploy('items', Bridge.Inventory, 'data/items.lua', function(file, data)
        local itemTemplate = [[
    ['%s'] = {
        label = '%s',
        weight = %s,
        stacksize = %s,
        close = %s,
        server = {
            TriggerEvent = 'rcore_xmas:ak47itemUsed:%s'
        },
    },
            ]]


        for _, item in ipairs(data) do
            local formattedItem = nil

            formattedItem = itemTemplate:format(
                item.name,
                item.label,
                item.weight,
                item.stacksize,
                item.close,
                item.name
            )

            file = appendAfterReturn(file, formattedItem)
        end

        file = appendAfterReturn(file, ASSET_DEPLOYER_WATERMARK_PREFIX)

        return file
    end, AK47_INVENTORY_ITEMS_DEPLOY)
end

OX_INVENTORY_ITEMS_DEPLOY = {
    {
        name = 'xmas_gift',
        label = 'Unpacked',
        weight = 100,
        stack = false,
        close = true,
        consume = 0,
        export = 'rcore_xmas.xmas_gift'
    },
    {
        name = 'xmas_packed_gift',
        label = 'Packed Gift',
        weight = 250,
        stack = false,
        close = true,
        consume = 0,
        export = 'rcore_xmas.xmas_packed_gift'
    },
    {
        name = 'xmas_tree',
        label = 'Christmas Tree',
        weight = 350,
        stack = true,
        close = true,
        consume = 0,
        export = 'rcore_xmas.xmas_tree'
    },
    {
        name = 'xmas_star',
        label = 'Christmas Star',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        export = 'rcore_xmas.xmas_star'
    },
    {
        name = 'xmas_decor',
        label = 'Christmas Decor',
        weight = 50,
        stack = true,
        close = true,
        consume = 0,
        export = 'rcore_xmas.xmas_decor'
    }
}

if isBridgeLoaded('Inventory', Inventory.OX) then
    Inventory.hasItem = function(client, item, amount)
        if amount == nil then
            amount = 1
        end

        local item = exports[Inventory.OX]:GetItemCount(client, item)
        return item and item >= amount
    end

    --- @return boolean success
    Inventory.addItem = function(client, item, amount, data)
        return exports[Inventory.OX]:AddItem(client, item, amount, data)
    end

    Inventory.removeItem = function(client, item, amount, data)
        return exports[Inventory.OX]:RemoveItem(client, item, amount, data)
    end

    Inventory.registerUsableItem = function(name, cb)
        exports(name, function(event, item, inventory, slot)
            if event ~= 'usingItem' then return end

            cb(inventory.id, item.name, slot)
        end)
    end

    Inventory.createInventory = function(name, label, slots, maxWeight, owner)
        return exports[Inventory.OX]:RegisterStash(name, label, slots, maxWeight, owner)
    end

    Inventory.getInventoryItems = function(name, owner)
        return exports[Inventory.OX]:GetInventoryItems(name, owner)
    end

    Inventory.items = function()
        return exports[Inventory.OX]:Items()
    end

    Inventory.clearInventory = function(name)
        return exports[Inventory.OX]:ClearInventory(name)
    end

    exports('xmas_decor', function() end)
    exports('xmas_star', function() end)

    AssetDeployer:registerCopyFilesDeploy('items-images', Inventory.OX, 'assets/inventory_images', 'web/images',
        function(data)
            local files = {}
            for _, item in ipairs(data) do
                table.insert(files, item .. '.png')
            end

            return files
        end, { 'xmas_gift', 'xmas_packed_gift', 'xmas_tree', 'xmas_star', 'xmas_decor' }
    )

    AssetDeployer:registerFileDeploy('items', Inventory.OX, 'data/items.lua', function(file, data)
        file = file:strtrim():gsub('}$', '')
        file = append(file, ASSET_DEPLOYER_WATERMARK_PREFIX)

        local itemTemplate = [[
    ['%s'] = {
        label = '%s',
        weight = %s,
        stack = %s,
        close = %s,
        consume = %s,
        server = {
            export = '%s'
        },
        %s
    },
        ]]
        local items = {}
        for _, item in ipairs(data) do
            local buttons = ''
            if item.name == 'xmas_gift' then
                buttons = [[
buttons = {
            {
                label = 'Pack',
                action = function(slot)
                    TriggerEvent('rcore_xmas:gifts:packSlot', slot)
                end
            }
        }]]
            end
            local formattedItem = itemTemplate:format(
                item.name,
                item.label,
                item.weight,
                item.stack,
                item.close,
                item.consume,
                item.export,
                buttons
            )
            file = append(file, '', formattedItem)
        end

        file = append(file, '', ASSET_DEPLOYER_WATERMARK_SUFFIX, '}')
        return file
    end, OX_INVENTORY_ITEMS_DEPLOY)

    AssetDeployer:registerFileDeploy('container', Inventory.OX, 'modules/items/containers.lua', function(file, data)
        file = file:strtrim():gsub('return containers$', '')
        file = append(file, ASSET_DEPLOYER_WATERMARK_PREFIX)

        local container = [[
setContainerProperties('xmas_gift', {
    slots = %s,
    maxWeight = %s,
    blacklist = { 'xmas_gift', 'xmas_packed_gift' }
})]]

        local formattedContainer = container:format(
            Config.Gifts.Inventory.Slots,
            Config.Gifts.Inventory.MaxWeight
        )

        file = append(file, '', formattedContainer, ASSET_DEPLOYER_WATERMARK_SUFFIX, 'return containers')
        return file
    end, {})
end

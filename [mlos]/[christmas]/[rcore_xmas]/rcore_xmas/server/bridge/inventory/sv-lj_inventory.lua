if isBridgeLoaded('Inventory', Inventory.LJ) then
    Inventory.hasItem = function(client, item, amount)
        amount = amount or 1

        local itemByName = exports[Bridge.Inventory]:GetItemByName(client, item)
        if itemByName == nil then return false end

        if amount ~= nil then
            return itemByName.amount >= amount
        end

        return true
    end

    --- @return boolean success
    Inventory.addItem = function(client, item, amount, data)
        if item == 'cash' or item == 'money' then
            local player = Framework.object.Functions.GetPlayer(client)
            if player == nil then return false end

            return player.Functions.AddMoney('cash', amount)
        end

        if item == 'weapon_snowball' then
            local itemByName = exports[Bridge.Inventory]:GetItemByName(client, item)
            if itemByName ~= nil then
                local slot = itemByName.slot
                local currentAmount = itemByName.amount

                return exports[Bridge.Inventory]:AddItem(client, item, currentAmount + amount, slot)
            end
        end

        return exports[Bridge.Inventory]:AddItem(client, item, amount, nil, data)
    end

    Inventory.removeItem = function(client, item, amount, data)
        return exports[Bridge.Inventory]:RemoveItem(client, item, amount, nil, data)
    end

    Inventory.registerUsableItem = function(item, cb)
        Framework.object.Functions.CreateUseableItem(item, function(source, item)
            cb(source, item.name, item)
        end)
    end

    Inventory.createInventory = function(name, label, slots, maxWeight)
        return
    end

    Inventory.getInventoryItems = function(name, player)
        if player ~= nil then
            local playerId = tonumber(name)
            if playerId == nil then return {} end

            local player = Framework.object.Functions.GetPlayer(playerId)
            if player == nil then return {} end

            return player.PlayerData.items
        end

        return exports[Bridge.Inventory]:GetStashItems(name)
    end

    Inventory.clearInventory = function(name)
        exports[Bridge.Inventory]:SaveStashItems(name, {})
    end

    AssetDeployer:registerCopyFilesDeploy('items-images', Inventory.LJ, 'assets/inventory_images', 'html/images',
        function(data)
            local files = {}
            for _, item in ipairs(data) do
                table.insert(files, item .. '.png')
            end

            return files
        end, { 'xmas_gift', 'xmas_packed_gift', 'xmas_tree', 'xmas_star', 'xmas_decor' }
    )

    AssetDeployer:registerFileDeploy('items', Framework.QBCore, 'shared/items.lua',
        function(file, data)
            file = file:strtrim():gsub('}$', '')
            file = append(file, ASSET_DEPLOYER_WATERMARK_PREFIX)
            local itemTemplate = [[
    ['%s'] = {
        ['name'] = '%s',
        ['label'] = '%s',
        ['weight'] = %s,
        ['type'] = '%s',
        ['image'] = '%s.png',
        ['unique'] = %s,
        ['useable'] = %s,
        ['shouldClose'] = %s,
        ['combinable'] = nil,
    },
        ]]
            local items = {}
            for _, item in ipairs(data) do
                local formattedItem = itemTemplate:format(
                    item.name,
                    item.name,
                    item.label,
                    item.weight,
                    item.type,
                    item.name,
                    item.unique,
                    item.useable,
                    item.shouldClose
                )
                file = append(file, '', formattedItem)
            end

            file = append(file, '', ASSET_DEPLOYER_WATERMARK_SUFFIX, '}')
            return file
        end,
        QB_INVENTORY_ITEMS_DEPLOY
    )

    AssetDeployer:registerFileDeploy('exports', Inventory.LJ, 'server/main.lua', function(file, data)
        file = append(file, ASSET_DEPLOYER_WATERMARK_PREFIX)
        local exportsTemplate = [[
exports('%s', %s)
            ]]
        local exports = {}
        for _, export in ipairs(data) do
            local formattedExport = exportsTemplate:format(
                export,
                export
            )
            file = append(file, '', formattedExport)
        end

        file = append(file, '', ASSET_DEPLOYER_WATERMARK_SUFFIX)
        return file
    end, {
        'GetStashItems',
        'RemoveFromStash',
        'SaveStashItems'
    })

    Inventory.items = function()
        return Framework.object.Items
    end
end

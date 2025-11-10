if isBridgeLoaded('Inventory', Inventory.QS) then
    Inventory.createInventory = function(name, label, slots, maxWeight)
        return
    end

    Inventory.getInventoryItems = function(name, player)
        if player ~= nil then
            local playerId = tonumber(name)
            if playerId == nil then return {} end

            if isBridgeLoaded('Framework', Framework.QBCore) then
                local player = Framework.object.Functions.GetPlayer(playerId)
                if player == nil then return {} end

                return player.PlayerData.items
            end

            if isBridgeLoaded('Framework', Framework.ESX) then
                local player = Framework.object.GetPlayerFromId(playerId)
                if player == nil then return {} end

                return player.inventory
            end

            return {}
        end

        return exports[Inventory.QS]:GetStashItems(name)
    end

    Inventory.items = function()
        local qsItems = exports[Inventory.QS]:GetItemList()
        local items = {}
        for k, v in pairs(qsItems) do
            items[v.name] = {
                name = v.name,
                label = v.label,
                weight = v.weight,
                stack = v.unique,
                close = v.useable
            }
        end

        return items
    end

    Inventory.clearInventory = function(name)
        local items = Inventory.getInventoryItems(name)
        for _, item in ipairs(items) do
            exports['qs-inventory']:RemoveItemIntoStash(name, item.name, item.amount)
        end
    end

    AssetDeployer:registerFileDeploy('items',
        isBridgeLoaded('Framework', Framework.ESX) and Inventory.QS or Framework.QBCore, 'shared/items.lua',
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

    AssetDeployer:registerCopyFilesDeploy('items-images', Inventory.QS, 'assets/inventory_images', 'html/images',
        function(data)
            local files = {}
            for _, item in ipairs(data) do
                table.insert(files, item .. '.png')
            end

            return files
        end, { 'xmas_gift', 'xmas_packed_gift', 'xmas_tree', 'xmas_star', 'xmas_decor' }
    )
end

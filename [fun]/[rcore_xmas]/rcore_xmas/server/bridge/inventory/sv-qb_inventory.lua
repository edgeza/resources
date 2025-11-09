QB_INVENTORY_ITEMS_DEPLOY = {
    {
        name = 'xmas_gift',
        label = 'Unpacked',
        weight = 100,
        type = 'item',
        image = 'xmas_gift.png',
        unique = true,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'xmas_packed_gift',
        label = 'Packed Gift',
        weight = 250,
        type = 'item',
        image = 'xmas_packed_gift.png',
        unique = true,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'xmas_tree',
        label = 'Christmas Tree',
        weight = 350,
        type = 'item',
        image = 'xmas_tree.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'xmas_star',
        label = 'Christmas Star',
        weight = 50,
        type = 'item',
        image = 'xmas_star.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'xmas_decor',
        label = 'Christmas Decor',
        weight = 50,
        type = 'item',
        image = 'xmas_decor.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    }
}

if (isBridgeLoaded('Inventory', Inventory.QB) or isBridgeLoaded('Inventory', Inventory.QS)) and isBridgeLoaded('Framework', Framework.QBCore) then
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

        return exports[Bridge.Inventory]:AddItem(client, item, amount, false, data, 'rcore_xmas')
    end

    Inventory.removeItem = function(client, item, amount, data)
        return exports[Bridge.Inventory]:RemoveItem(client, item, amount, false, 'rcore_xmas')
    end

    Inventory.registerUsableItem = function(item, cb)
        Framework.object.Functions.CreateUseableItem(item, function(source, item)
            cb(source, item.name, item)
        end)
    end

    if not isBridgeLoaded('Inventory', Inventory.QS) then
        RegisterNetEvent('rcore_xmas:qb-inventory:open', function(type, name, slots, maxweight)
            local client = source
            Inventory.openInventory(client, name, type, {
                slots = slots,
                maxWeight = maxweight
            })
        end)

        local version = GetResourceMetadata(Bridge.Inventory, 'version', 0)

        Inventory.createInventory = function(name, label, slots, maxWeight)
        end

        Inventory.getInventoryItems = function(name, player)
            if player ~= nil then
                local playerId = tonumber(name)
                if playerId == nil then return {} end

                local player = Framework.object.Functions.GetPlayer(playerId)
                if player == nil then return {} end

                return player.PlayerData.items
            end

            if version < '2.0.0' then
                return exports[Inventory.QB]:GetStashItems(name)
            end

            local inventory = exports[Inventory.QB]:GetInventory(name)
            if inventory == nil then return {} end

            return inventory.items
        end

        Inventory.clearInventory = function(name)
            if version < '2.0.0' then
                exports[Inventory.QB]:SaveStashItems(name, {})
                return
            end

            exports[Inventory.QB]:ClearStash(name)
        end

        Inventory.openInventory = function(client, name, type, data)
            if version >= '2.0.0' then
                exports[Inventory.QB]:OpenInventory(client, name, {
                    slots = data.slots,
                    maxweight = data.maxWeight,
                    label = data.label,
                })
            end
        end

        AssetDeployer:registerCopyFilesDeploy('items-images', Inventory.QB, 'assets/inventory_images', 'html/images',
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

        if version < '2.0.0' then
            AssetDeployer:registerFileDeploy('exports', Inventory.QB, 'server/main.lua', function(file, data)
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
                'SaveStashItems'
            })
        end
    end


    Inventory.items = function()
        return Framework.object.Items
    end
end

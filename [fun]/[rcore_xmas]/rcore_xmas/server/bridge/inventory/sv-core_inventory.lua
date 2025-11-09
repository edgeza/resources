if isBridgeLoaded('Inventory', Inventory.CORE) then
    Inventory.hasItem = function(client, itemName, amount)
        if client == nil then return false end

        return exports[Bridge.Inventory]:hasItem(client, itemName, amount)
    end

    Inventory.addItem = function(client, item, amount, data)
        local items = exports[Bridge.Inventory]:addItem(client, item, amount, data)
        return true
    end

    Inventory.removeItem = function(client, item, amount, data)
        local removed = exports[Bridge.Inventory]:removeItem(client, item, amount)
        return true
    end

    Inventory.registerUsableItem = function(name, cb)
        if isBridgeLoaded('Framework', Framework.ESX) then
            Framework.object.RegisterUsableItem(name, function(source)
                cb(source, name)
            end)
        elseif isBridgeLoaded('Framework', Framework.QBCore) then
            Framework.object.Functions.CreateUseableItem(name, function(source, item)
                cb(source, item.name, item)
            end)
        end
    end

    Inventory.createInventory = function(name, label, slots, maxWeight, owner)
        exports[Bridge.Inventory]:openInventory(nil, name:gsub(':', ''), 'stash', nil, nil, false, nil, false)
        return
    end

    Inventory.getInventoryItems = function(name, player)
        if player then
            local playerId = tonumber(name)
            if playerId == nil then return {} end

            if esxLoaded then
                local player = Framework.object.GetPlayerFromId(playerId)
                if player == nil then return {} end

                return player.getInventory()
            elseif qbcoreLoaded then
                local player = Framework.object.Functions.GetPlayer(playerId)
                if player == nil then return {} end

                return player.PlayerData.items
            end

            return {}
        end

        return exports[Bridge.Inventory]:getInventory(name:gsub(':', ''))
    end

    Inventory.clearInventory = function(name)
        exports[Bridge.Inventory]:openInventory(nil, name:gsub(':', ''), 'stash', nil, nil, false, nil, false)

        local invName = name:gsub(':', '')
        local inv = exports[Bridge.Inventory]:getInventory()
        for _, item in ipairs(inv) do
            if item.amount then
                exports[Bridge.Inventory]:removeItem(invName, item.name, item.amount)
            else
                exports[Bridge.Inventory]:removeItemExact(invName, item.id)
            end
        end

        return true
    end

    Inventory.openInventory = function(client, name, type)
        exports[Bridge.Inventory]:openInventory(client, name:gsub(':', ''), type or 'stash', 300, 300, true, {})
    end
end

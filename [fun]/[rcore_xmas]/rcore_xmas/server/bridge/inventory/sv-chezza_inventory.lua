if isBridgeLoaded('Inventory', Inventory.CHEZZA) then
    if not isBridgeLoaded('Framework', Framework.ESX) then
        log.error(
            'CHEZZA inventory is selected but ESX is not the framework resource. Please change the framework resource or the inventory type.'
        )
        return
    end

    Inventory.hasItem = function(client, item, amount)
        local player = Framework.object.GetPlayerFromId(client)
        if player == nil then return false end

        if player.hasItem ~= nil then
            return player.hasItem(item)
        end

        local itemInfo = player.getInventoryItem(item)
        return itemInfo ~= nil and itemInfo.count >= amount
    end

    --- @return boolean success
    Inventory.addItem = function(client, item, amount, data)
        local player = Framework.object.GetPlayerFromId(client)
        if player == nil then
            return false
        end

        if item == 'cash' or item == 'money' then
            player.addMoney(amount)
            return true
        end

        if not player.canCarryItem(item, amount) then
            return false
        end

        local match = string.match(item, "^WEAPON_(.*)")

        if match then
            player.addWeapon(item:lower(), math.random(30, 120))
            return true
        end

        player.addInventoryItem(item, amount)

        return true
    end

    Inventory.removeItem = function(client, item, amount, data)
        local player = Framework.object.GetPlayerFromId(client)
        if player == nil then
            return false
        end

        if item == 'cash' or item == 'money' then
            player.removeMoney(amount)
            return true
        end

        local match = string.match(item, "^WEAPON_(.*)")

        if match then
            player.removeWeapon(item:lower(), math.random(30, 120))
            return true
        end

        player.removeInventoryItem(item, amount)

        return true
    end

    Inventory.registerUsableItem = function(name, cb)
        Framework.object.RegisterUsableItem(name, cb)
    end

    Inventory.createInventory = function(name, label, slots, maxWeight, owner)
        return false
    end

    Inventory.getInventoryItems = function(name, owner)
        return false
    end

    Inventory.items = function()
        return false
    end

    Inventory.clearInventory = function(name)
        return false
    end
end

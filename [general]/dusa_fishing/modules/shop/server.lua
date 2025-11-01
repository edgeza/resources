
if not rawget(_G, "lib") then include('ox_lib', 'init') end
if not lib then return end


Shop = {}
-- local Functions = require 'functions'

lib.callback.register('dusa_fishing:itemList', function(source)
    local items = Framework.Items
    local itemList = {}
    local fishList = {}

    for fish, value in pairs(config.fish) do
        table.insert(fishList, fish)
    end

    for k, v in pairs(items) do
        local hasItem = Framework.GetItem(source, v.name)
        if hasItem and lib.table.contains(fishList, v.name) then
            local img = ('nui://%s%s.png'):format(Bridge.InventoryImagePath, v.name)
            table.insert(itemList, {
                name = config.fish[v.name].label,
                description = config.fish[v.name].description,
                itemCode = v.name,
                count = Framework.GetItemCount(source, v.name),
                price = ServerConfig.Sell.Prices[v.name],
                type = config.fish[v.name].type,
                img = img
            })
        end
    end

    return itemList
end)

lib.callback.register('dusa_fishing:buyItem', function(source, cart, type)
    local total = 0
    local player = Framework.GetPlayer(source)

    local distant = SecureCheck(source, 'distance')
    if not distant then return end

    local identifier = player.Identifier
    local money = player.GetMoney(type)
    for k, v in pairs(cart) do
        if next(ServerConfig.Shop) then
            for _, item in pairs(ServerConfig.Shop) do
                if item.itemCode == v.itemCode then
                    if item.price ~= v.price then
                        lib.print.error(
                            '[CHEATER WARNING] player tried to buy item with different price (game id, name, rp name, identifier)',
                            source, player.Name,
                            player.Firstname .. ' ' .. player.Lastname,
                            identifier)
                        BanDropExploiter(source, '[CHEATER WARNING] Player tried to buy item with different price')
                        return
                    end
                end
            end
        end

        local price = v.count * v.price
        total = total + price
    end

    if money >= total then
        for k, v in pairs(cart) do
            if v.itemCode == 'rod_2' then
                local level = levels[identifier].level
                Framework.AddItem(source, 'rod_' .. tonumber(level), v.count)
            else
                -- check if item is valid on config
                if next(ServerConfig.Shop) then
                    for _, item in pairs(ServerConfig.Shop) do
                        if item.itemCode == v.itemCode then
                            Framework.AddItem(source, v.itemCode, v.count)
                        end
                    end
                else
                    warn('Couldnt fill serverconfig, this might cause exploits')
                    Framework.AddItem(source, v.itemCode, v.count)
                end
            end
        end

        player.RemoveMoney(type, total)

        -- Trigger successful purchase event
        TriggerEvent('dusa_fishing:handler:ItemPurchased', source, cart, type, {
            success = true,
            total = total,
            items = cart,
            message = 'Purchase successful'
        })

        TriggerClientEvent('dusa_fishing:ShowNotification', source, locale('items_bought', total))
    else
        -- Trigger failed purchase event
        TriggerEvent('dusa_fishing:handler:ItemPurchased', source, cart, type, {
            success = false,
            total = 0,
            items = {},
            message = 'Insufficient funds'
        })

        TriggerClientEvent('dusa_fishing:ShowNotification', source, locale('not_enought_money'))
    end
end)

lib.callback.register('dusa_fishing:sellItem', function(source, cart)
    local total = 0
    local player = Framework.GetPlayer(source)

    local distant = SecureCheck(source, 'distance')
    if not distant then return end

    for k, cart_data in pairs(cart) do
        -- Check price
        for fish, price in pairs(ServerConfig.Sell.Prices) do
            if cart_data.itemCode == fish then
                if cart_data.price ~= price then
                    lib.print.error(
                        '[CHEATER WARNING] player tried to sell fish with different price (game id, name, rp name, identifier)',
                        source, player.Name,
                        player.Firstname .. ' ' .. player.Lastname,
                        player.Identifier)
                    -- Trigger failed sale event for price manipulation
                    TriggerEvent('dusa_fishing:handler:ItemSold', source, cart, {
                        success = false,
                        total = 0,
                        items = {},
                        message = 'Price manipulation detected'
                    })
                    
                    BanDropExploiter(source, '[CHEATER WARNING] Player tried to sell fish with different price')
                    return
                end
            end
        end

        -- Check item count and cart item count
        local count = Framework.GetItemCount(source, cart_data.itemCode)
        if count < cart_data.count then
            lib.print.error(
                '[EXPLOITER WARNING] player tried to sell not existant fish (game id, name, rp name, identifier)',
                source, player.Name,
                player.Firstname .. ' ' .. player.Lastname,
                player.Identifier)
            -- Trigger failed sale event for non-existent items
            TriggerEvent('dusa_fishing:handler:ItemSold', source, cart, {
                success = false,
                total = 0,
                items = {},
                message = 'Attempted to sell non-existent items'
            })
            
            BanDropExploiter(source, '[EXPLOITER WARNING] Player tried to sell not existant fish')
            return
        end

        local price = cart_data.count * cart_data.price
        if count >= cart_data.count then
            Framework.RemoveItem(source, cart_data.itemCode, cart_data.count)
            total = total + price
        end
    end

    if total > ServerConfig.Sell.LimitMoney then
        lib.print.error(
            '[EXPLOITER WARNING] player tried to sell too much fish at once (game id, name, rp name, identifier)',
            source, player.Name,
            player.Firstname .. ' ' .. player.Lastname,
            player.Identifier)
        -- Trigger failed sale event for limit exceeded
        TriggerEvent('dusa_fishing:handler:ItemSold', source, cart, {
            success = false,
            total = 0,
            items = {},
            message = 'Sale limit exceeded'
        })
        
        DropPlayer(source, '[LIMIT EXCEED] Player tried to sell too much fish at once')
        return
    end


    -- Trigger successful sale event
    TriggerEvent('dusa_fishing:handler:ItemSold', source, cart, {
        success = true,
        total = total,
        items = cart,
        message = 'Sale successful'
    })

    TriggerClientEvent('dusa_fishing:ShowNotification', source, locale('sold_items', total))
    player.AddMoney('cash', total)
end)

return Shop

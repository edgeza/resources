----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = GetQBCoreObject and GetQBCoreObject() or (function()
    local success, result = pcall(function() return exports[CoreFolder]:GetCoreObject() end)
    if success and result then
        return result
    else
        error('Failed to initialize Core object - GetQBCoreObject not available')
    end
end)()
local MetaDataEvent = Config.CoreSettings.MetaDataEvent
local MetaDataName = Config.XP.MetaDataName
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- SELL ITEMS (JEWELLER / WAREHOUSE) --<!>--
RegisterServerEvent('boii-mining:sv:SellItems', function(args)
	local src = source
	local pData = Core.Functions.GetPlayer(src)
	if not pData or not args or type(args.item) ~= 'string' then return end
	local itemName = args.item
	local store = tostring(args.store or '')
	-- determine price from server config (do NOT trust client)
	local priceInfo
	if store == 'Jeweller' then
		priceInfo = (Config.Warehouse.Items.Gems and Config.Warehouse.Items.Gems[itemName])
			or (Config.Warehouse.Items.Bricks and Config.Warehouse.Items.Bricks[itemName])
			or (Config.Warehouse.Items.Coins and Config.Warehouse.Items.Coins[itemName])
			or (Config.Warehouse.Items.Apples and Config.Warehouse.Items.Apples[itemName])
			or (Config.Warehouse.Items.Skulls and Config.Warehouse.Items.Skulls[itemName])
	elseif store == 'Warehouse' then
		priceInfo = Config.Warehouse.Items.Ingots and Config.Warehouse.Items.Ingots[itemName]
	end
	if not priceInfo or not priceInfo.price then
		TriggerClientEvent('boii-mining:notify', src, 'This item cannot be sold here.', 'error')
		return
	end
	local inventoryItem = pData.Functions.GetItemByName(itemName)
	if not inventoryItem or (inventoryItem.amount or 0) <= 0 then
		TriggerClientEvent('boii-mining:notify', src, 'You do not have this item.', 'error')
		return
	end
	-- Sell full stack by default; allow optional args.amount override
	local requestedAmount = tonumber(args.amount)
	local sellAmount = (requestedAmount and requestedAmount > 0) and math.min(requestedAmount, inventoryItem.amount) or (inventoryItem.amount or 0)
	if sellAmount <= 0 then
		TriggerClientEvent('boii-mining:notify', src, 'You do not have enough of this item.', 'error')
		return
	end
	local unitPrice = tonumber(priceInfo.price) or 0
	if unitPrice <= 0 then
		TriggerClientEvent('boii-mining:notify', src, 'Invalid price for this item.', 'error')
		return
	end
	if pData.Functions.RemoveItem(itemName, sellAmount) then
		TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[itemName], 'remove', sellAmount)
		local sellMoney = (Config.Warehouse and Config.Warehouse.Money and Config.Warehouse.Money.Sell) or {}
		if sellMoney.UseItem and sellMoney.Item and sellMoney.Item.name then
			pData.Functions.AddItem(sellMoney.Item.name, unitPrice * sellAmount)
			TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[sellMoney.Item.name], 'add', unitPrice * sellAmount)
		else
			local moneytype = sellMoney.Type or 'cash'
			pData.Functions.AddMoney(moneytype, unitPrice * sellAmount, 'boii-mining-sell-'..itemName)
		end
		local soldLabel = (priceInfo.label or args.label or itemName)
		TriggerClientEvent('boii-mining:notify', src, ('Sold %sx %s for $%s'):format(sellAmount, soldLabel, unitPrice * sellAmount), 'success')
	else
		TriggerClientEvent('boii-mining:notify', src, 'Failed to remove item.', 'error')
	end
end)
--<!>-- SELL ITEMS (JEWELLER / WAREHOUSE) --<!>--

--<!>-- PURCHASE PERMIT --<!>--
RegisterServerEvent('boii-mining:sv:PurchasePermit', function(args)
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    local MiningXP = pData.PlayerData.metadata[MetaDataName]
    local moneytype = Config.Stores.Money.Type
    local qbmoney = pData.PlayerData.money[moneytype]
    if Config.XP.Use then
        if args.permit == 'Mining' then
            if MiningXP < 1250 then
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores.Permits['noxp'], 'error')
                TriggerClientEvent('boii-mining:cl:QuarryPermitsMenu', src)
                return
            end
        elseif args.permit == 'Caving' then
            if MiningXP < 2441 then
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores.Permits['noxp'], 'error')
                TriggerClientEvent('boii-mining:cl:QuarryPermitsMenu', src)
                return
            end
        end
    end
    if Config.Stores.Money.UseItem then
        if pData.Functions.GetItemByName(args.item) ~= nil then TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores['alreadyhaspermit'], 'error') return end
        if pData.Functions.GetItemByName(Config.Stores.Money.Item) ~= nil then 
            if pData.Functions.GetItemByName(Config.Stores.Money.Item).amount >= args.price then
                pData.Functions.RemoveItem(Config.Stores.Money.Item, args.price)
                pData.Functions.AddItem(args.item, 1)
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[Config.Stores.Money.Item], 'remove', args.price)
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[args.item], 'add', 1)
            else
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores['enoughmoney'], 'error')
            end
        else
            TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores['nomoney'], 'error')
        end
    else
        if qbmoney >= args.price then
            if pData.Functions.GetItemByName(args.item) ~= nil then TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores['alreadyhaspermit'], 'error') return end
            pData.Functions.RemoveMoney(moneytype, args.price, 'mining-store')
            pData.Functions.AddItem(args.item, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[args.item], 'add', 1)
        else
            TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores['enoughmoney'], 'error')
        end
    end
    TriggerClientEvent('boii-mining:cl:QuarryPermitsMenu', src)
end)
--<!>-- PURCHASE PERMIT --<!>--

--<!>-- PURCHASE EQUIPMENT --<!>--
RegisterServerEvent('boii-mining:sv:PurchaseEquipment', function(args)
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    local MiningXP = pData.PlayerData.metadata[MetaDataName]
    local moneytype = Config.Stores.Money.Type
    local qbmoney = pData.PlayerData.money[moneytype]
    if Config.XP.Use then
        if args.equipment == 'Jackhammer' then
            if MiningXP < 1250 then
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores.Equipment['noxp'], 'error')
                TriggerClientEvent('boii-mining:cl:QuarryEquipmentMenu', src)
                return
            end
        elseif args.equipment == 'Dynamite' then
            if MiningXP < 1250 then
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores.Equipment['noxp'], 'error')
                TriggerClientEvent('boii-mining:cl:QuarryEquipmentMenu', src)
                return
            end
        end
    end
    if Config.Stores.Money.UseItem then
        if pData.Functions.GetItemByName(Config.Stores.Money.Item) ~= nil then 
            if pData.Functions.GetItemByName(Config.Stores.Money.Item).amount >= args.price then
                pData.Functions.RemoveItem(Config.Stores.Money.Item, args.price)
                pData.Functions.AddItem(args.item, 1)
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[Config.Stores.Money.Item], 'remove', args.price)
                TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[args.item], 'add', 1)
            else
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores['enoughmoney'], 'error')
            end
        else
            TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores['nomoney'], 'error')
        end
    else
        if qbmoney >= args.price then
            pData.Functions.RemoveMoney(moneytype, args.price, 'mining-store')
            pData.Functions.AddItem(args.item, 1)
            TriggerClientEvent('inventory:client:ItemBox', source, Core.Shared.Items[args.item], 'add', 1)
        else
            TriggerClientEvent('boii-mining:notify', src, Language.Mining.Stores['enoughmoney'], 'error')
        end
    end
    -- Route back to the appropriate menu
    if args and args.equipment == 'DrillBit' then
        TriggerClientEvent('boii-mining:cl:DrillbitShop', src)
    else
        TriggerClientEvent('boii-mining:cl:QuarryEquipmentMenu', src)
    end
end)
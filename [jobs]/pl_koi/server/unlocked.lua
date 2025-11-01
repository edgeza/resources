local stock = {}
for category, items in pairs(Config.Shop.Storage.items) do
    for _, item in pairs(items) do
        stock[item.name] = item.amount
    end
end

RegisterNetEvent('pl_koi:Ingredientshop')
AddEventHandler('pl_koi:Ingredientshop', function(paymentMode,itemName,label, itemAmount, price)
    local src = source
    local Player = getPlayer(src)
    local Identifier = GetPlayerIdentifier(src)
    local PlayerName = getPlayerName(src)
    local TotalBill = price * itemAmount
    if not stock[itemName] or stock[itemName] < itemAmount then
        return ServerNotify(src, Locale("not_enough_stock"), 'error')
    end

    local accountType = (paymentMode == 'bank') and 'bank' or 'money'
    local hasMoney = false

    if paymentMode == 'society' then
        hasMoney = GetSocietyMoney(Config.Jobname) >= TotalBill
    else
        hasMoney = GetPlayerAccountMoney(src, accountType, TotalBill)
    end

    if not hasMoney then
        return ServerNotify(src, Locale("not_enough_money"), 'error')
    end

    if not PlayerCanCarryItems(src, itemName, itemAmount) then
        return ServerNotify(src, Locale("cannot_carry"), 'error')
    end
    -- Process Payment
    if paymentMode == 'society' then
        RemoveSocietyMoney(Config.Jobname, TotalBill)
    else
        RemovePlayerMoney(src, accountType, TotalBill)
    end
    -- Add Item and update stock
    if AddItem(src, itemName, itemAmount) then
        stock[itemName] = stock[itemName] - itemAmount

        local logMsg = ('**Name:** %s\n**Identifier:** %s\nBought x%d %s for $**%d** From Inventory')
        local log = logMsg:format(PlayerName, Identifier, itemAmount, itemName, TotalBill)

        if paymentMode == 'society' then
            log = log .. '\nRemaining Society Funds: ' .. GetSocietyMoney(Config.Jobname)
        end
        Log(log)
        ServerNotify(src, string.format(Locale("purchase_items"), itemAmount, label, TotalBill), 'success')
    end
end)

RegisterNetEvent('pl_koi:getStock')
AddEventHandler('pl_koi:getStock', function()
    local src = source
    local Identifier = GetPlayerIdentifier(src)
    local PlayerName = getPlayerName(src)
    local ped = GetPlayerPed(src)
    local distance = GetEntityCoords(ped)
    if #(distance - Location.TargetCoords.Fridge[1].coords) <= 5 then
        if GetJob(src) == Config.Jobname then
            TriggerClientEvent('pl_koi:returnStock', src, stock)
        else
            print('Tried to open the stock menu without having job. Most probably a Cheater '..Identifier..' ')
        end
    else
        print(('^1[Exploit Attempt]^0 %s (%s) tried to trigger event: pl_koi:getStock.'):format(PlayerName, Identifier))
    end
end)

lib.callback.register('pl_koi:getShopStatus', function(source)
    local result = MySQL.Sync.fetchScalar('SELECT state FROM pl_koi LIMIT 1')
    return result == 'open'
end)

RegisterNetEvent('pl_koi:toggleShopStatus', function(newState)
    local stateText = newState and 'open' or 'close'
    MySQL.Async.execute('UPDATE pl_koi SET state = ?', { stateText }, function(rowsChanged)end)
end)

function ServerNotify(src, msg, type)
  TriggerClientEvent("pl_koi:client:notify", src, msg, type)
end

function DebugPrint(...)
    if Config.Debug.Prints then
        print(...)
    end
end

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local SocietyResource = GetSociety()
        if SocietyResource == "esx_addonaccount" then
            TriggerEvent('esx_society:registerSociety', Config.Jobname, Config.Jobname, "society_"..Config.Jobname.."", "society_"..Config.Jobname.."", "society_"..Config.Jobname.."", {type = 'private'})
            TriggerEvent('society:registerSociety', Config.Jobname, Config.Jobname, "society_"..Config.Jobname.."", "society_"..Config.Jobname.."", "society_"..Config.Jobname.."", {type = 'private'})
        end
        if Config.Debug.Prints then
            print("^4[Framework]     → ^2" .. (GetFramework() or "^1none^2") .. "^7")
            print("^4[Text UI]       → ^2" .. (GetTextUI() or "^1none^2") .. "^7")
            print("^4[Boss Menu]     → ^2" .. (GetBossMenu() or "^1none^2") .. "^7")
            print("^4[Target System] → ^2" .. (GetTarget() or "^1none^2") .. "^7")
            print("^4[Notify System] → ^2" .. (GetNotify() or "^1none^2") .. "^7")
            print("^4[Billing Menu]  → ^2" .. (GetBillingMenu() or "^1none^2") .. "^7")
            print("^4[Clothing Menu] → ^2" .. (GetClothing() or "^1none^2") .. "^7")
            print("^4[Society Menu]  → ^2" .. (GetSociety() or "^1none^2") .. "^7")
        end
    end
end)


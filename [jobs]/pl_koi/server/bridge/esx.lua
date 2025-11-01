local Framework = GetFramework()
if Framework ~= 'esx' then return end

ESX = exports[Config.FrameworkResources.esx.resource][Config.FrameworkResources.esx.export]()

function getPlayer(target)
    local xPlayer = ESX.GetPlayerFromId(target)
    return xPlayer
end

function GetPlayerIdentifier(target)
    local xPlayer = ESX.GetPlayerFromId(target)
    return xPlayer.getIdentifier()
end

function getPlayerName(target)
    local xPlayer = ESX.GetPlayerFromId(target)
    return xPlayer.getName()
end

function GetJob(target)
    local xPlayer = ESX.GetPlayerFromId(target)
    return xPlayer.getJob().name
end

function RemovePlayerMoney(target,account,TotalBill)
    local Player = getPlayer(target)
    if account == 'bank' then
        Player.removeAccountMoney('bank', TotalBill)
    elseif account == 'money' then
        Player.removeAccountMoney('money', TotalBill)
    end
end

function AddPlayerMoney(target,account,TotalBill)
    local Player = getPlayer(target)
    if account == 'bank' then
        Player.addAccountMoney('bank', TotalBill)
    elseif account == 'money' then
        Player.addAccountMoney('money', TotalBill)
    end
end

function GetPlayerAccountMoney(target,account,TotalBill)
    local Player = getPlayer(target)
    if account == 'bank' then
        if Player.getAccount('bank').money >= TotalBill then
            return true
        else
            return false
        end
    elseif account == 'money' then
        if Player.getAccount('money').money >= TotalBill then
            return true
        else
            return false
        end
    end
    return false
end

function PlayerCanCarryItems(target,item, amount)
    local Player = getPlayer(target)
    if Config.CheckCanCarryItem then
        if Player.canCarryItem(item, amount) then
            return true
        else
            ServerNotify( source, locale("cannot_carry"), 'error')
            return false
        end
    else
        return true
    end
end


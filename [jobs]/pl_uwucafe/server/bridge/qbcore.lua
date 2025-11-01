local Framework = GetFramework()
if Framework ~= 'qb' then return end

local QBCore = exports[Config.FrameworkResources.qb.resource][Config.FrameworkResources.qb.export]()

function getPlayer(target)
    local xPlayer = QBCore.Functions.GetPlayer(target)
    return xPlayer
end

function GetPlayerIdentifier(target)
    local xPlayer = QBCore.Functions.GetPlayer(target)
    return xPlayer.PlayerData.citizenid
end

function getPlayerName(target)
    local xPlayer = QBCore.Functions.GetPlayer(target)

    return xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
end

function GetJob(target)
    local xPlayer = QBCore.Functions.GetPlayer(target)
    return xPlayer.PlayerData.job.name
end

function RemovePlayerMoney(target,account,TotalBill)
    local Player = getPlayer(target)
    if account == 'money' then
        Player.Functions.RemoveMoney('cash', TotalBill)
    elseif account == 'bank' then
        Player.Functions.RemoveMoney('bank', TotalBill)
    end
end

function AddPlayerMoney(target,account,TotalBill)
    local Player = getPlayer(target)
    if account == 'bank' then
        Player.Functions.AddMoney('bank', TotalBill)
    elseif account == 'money' then
        Player.Functions.AddMoney('cash', TotalBill)
    end
end

function GetPlayerAccountMoney(target,account,TotalBill)
    local Player = getPlayer(target)
    if account == 'bank' then
        if Player.PlayerData.money.bank >= TotalBill then
            return true
        else
            return false
        end
    elseif account == 'money' then
        if Player.PlayerData.money.cash >= TotalBill then
            return true
        else
            return false
        end
    end
    return false
end

function PlayerCanCarryItems(target,item, amount)
    --qbcore inventory does this check automatically
    return true
end
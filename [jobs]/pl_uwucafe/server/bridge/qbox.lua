local Framework = GetFramework()
if Framework ~= 'qbox' then return end

local QBCore = exports[Config.FrameworkResources.qb.resource][Config.FrameworkResources.qb.export]()

function getPlayer(target)
    local xPlayer = exports.qbx_core:GetPlayer(target)
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
    local xPlayer = exports.qbx_core:GetPlayer(target)
    if not xPlayer then return false end
    
    if account == 'money' then
        return xPlayer.Functions.RemoveMoney('cash', TotalBill, Config.Blip.BlipName)
    elseif account == 'bank' then
        return xPlayer.Functions.RemoveMoney('bank', TotalBill, Config.Blip.BlipName)
    end
    return false
end

function AddPlayerMoney(target,account,TotalBill)
    local xPlayer = exports.qbx_core:GetPlayer(target)
    if not xPlayer then return false end
    
    if account == 'bank' then
        return xPlayer.Functions.AddMoney('bank', TotalBill, Config.Blip.BlipName)
    elseif account == 'money' then
        return xPlayer.Functions.AddMoney('cash', TotalBill, Config.Blip.BlipName)
    end
    return false
end

function GetPlayerAccountMoney(target,account,TotalBill)
    local xPlayer = exports.qbx_core:GetPlayer(target)
    if not xPlayer then return false end

    if account == 'bank' then
        if xPlayer.Functions.GetMoney('bank') >= TotalBill then
            return true
        else
            return false
        end
    elseif account == 'money' then
        if xPlayer.Functions.GetMoney('cash') >= TotalBill then
            return true
        else
            return false
        end
    end
    return false
end

function PlayerCanCarryItems(target,item, amount)
    if exports.ox_inventory:CanCarryItem(target, item, amount) then
        return true
    end
    return false
end
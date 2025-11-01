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
    local player = QBCore.Functions.GetPlayer(target)
    if not player then return false end

    if account == 'money' then
        return player.Functions.RemoveMoney('cash', TotalBill, Config.Blip.BlipName)
    elseif account == 'bank' then
        return player.Functions.RemoveMoney('bank', TotalBill, Config.Blip.BlipName)
    end
end

function AddPlayerMoney(target,account,TotalBill)
    local player = QBCore.Functions.GetPlayer(target)
    if not player then return false end

    if account == 'bank' then
        return player.Functions.AddMoney('bank', TotalBill, Config.Blip.BlipName)
    elseif account == 'money' then
        return player.Functions.AddMoney('cash', TotalBill, Config.Blip.BlipName)
    end
end

function GetPlayerAccountMoney(target,account,TotalBill)

	local player = QBCore.Functions.GetPlayer(target)
	if not player then return false end

	if account == 'bank' then
		local balance = player.PlayerData and player.PlayerData.money and player.PlayerData.money.bank or 0
		return balance >= TotalBill
	elseif account == 'money' then
		local balance = player.PlayerData and player.PlayerData.money and player.PlayerData.money.cash or 0
		return balance >= TotalBill
	end
	return false
end

function PlayerCanCarryItems(target,item, amount)
    if exports.ox_inventory:CanCarryItem(target, item, amount) then
        return true
    end
    return false
end
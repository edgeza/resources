if GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()
local ox_inv = GetResourceState('ox_inventory') == 'started'

function GetPlayer(id)
    return QBCore.Functions.GetPlayer(id)
end

function GetPlyIdentifier(Player)
    return Player.PlayerData.citizenid
end

function DoNotification(src, text, nType)
    TriggerClientEvent('QBCore:Notify', src, text, nType)
end

function GetCharacterName(Player)
    return Player.PlayerData.charinfo.firstname.. ' ' ..Player.PlayerData.charinfo.lastname
end

function AddMoney(Player, moneyType, amount)
    Player.Functions.AddMoney(moneyType, amount)
end

function itemCount(Player, item)
    local count = 0
    if ox_inv then 
        count = exports.ox_inventory:GetItemCount(Player.PlayerData.source, item)
    else
        for slot, data in pairs(Player.PlayerData.items) do -- Apparently qb only counts the amount from the first slot so I gotta do this.
            if data.name == item then
                count += data.amount
            end
        end
    end
    return count
end

function AddItem(Player, item, amount)
    if ox_inv then
        exports.ox_inventory:AddItem(Player.PlayerData.source, item, amount)
    else
        Player.Functions.AddItem(item, amount, false)
        if QBCore and QBCore.Shared and QBCore.Shared.Items and QBCore.Shared.Items[item] then
            TriggerClientEvent("inventory:client:ItemBox", Player.PlayerData.source, QBCore.Shared.Items[item], "add", amount)
        end
    end
end

function AddWeapon(Player, weapon, amount)
    Player.Functions.AddItem(weapon, amount, false)
    if QBCore and QBCore.Shared and QBCore.Shared.Items and QBCore.Shared.Items[weapon] then
        TriggerClientEvent("inventory:client:ItemBox", Player.PlayerData.source, QBCore.Shared.Items[weapon], "add", amount)
    end
end

-- Use the correct QBCore event for player loading
AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    local src = Player.PlayerData.source
    print(("^3[SYNC] QBCore player %s loaded, scheduling sync..."):format(GetPlayerName(src)))
    PlayerHasLoaded(src)
end)
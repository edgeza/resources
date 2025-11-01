if Config.Framework ~= 'qb' then
    return
end

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    Debug('Loaded player:', src)
    CreateQuests(src)
end)

CreateThread(function()
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        if v then
            Debug('Loaded player:', v)
            CreateQuests(v)
        end
    end
end)

function RegisterServerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function GetPlayerFromId(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetPlayerSource(player)
    return player.PlayerData.source
end

function GetIdentifier(source)
    local player = GetPlayerFromId(source)
    if not player then
        print('Player not found. Source: ', source)
        return false
    end
    return player.PlayerData.citizenid
end

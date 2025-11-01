if Config.Framework ~= 'esx' then
    return
end

ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded', function(id, data)
    Wait(2000)
    Debug('Loaded player:', id)
    CreateQuests(id)
end)

CreateThread(function()
    for k, v in pairs(ESX.Players) do
        if v and v.source then
            Debug('Loaded player:', v.source)
            CreateQuests(v.source)
        end
    end
end)

function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetPlayerSource(player)
    return player.source
end

function GetIdentifier(source)
    local player = GetPlayerFromId(source)
    if not player then
        print('Player not found. Source: ', source)
        return false
    end
    return player.identifier
end

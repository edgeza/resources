if GetResourceState('es_extended') ~= 'started' then return end
ESX = exports['es_extended']:getSharedObject()
dusa = {}
dusa.framework, dusa.playerLoaded, dusa.playerData, dusa.inventory = 'esx', nil, {}, 'default'
local isDead

RegisterNetEvent('esx:playerLoaded', function(xPlayer, isNew, skin)
	while not ESX.IsPlayerLoaded() do
        Wait(100)
    end
	dusa.playerData = xPlayer
    dusa.playerLoaded = true
    TriggerServerEvent('dusa_guitarzero:sv:playerLoaded')
    TriggerServerEvent('dusa_guitarzero:sv:firstPlayer')
end)

AddEventHandler('esx:onPlayerSpawn', function()
    isDead = nil
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	dusa.playerData.job = response
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName or not ESX.PlayerLoaded then return end
    dusa.playerData = ESX.GetPlayerData()
    dusa.playerLoaded = true
    TriggerServerEvent('dusa_guitarzero:sv:playerLoaded')
end)

---@diagnostic disable: duplicate-set-field

function dusa.showNotification(text, type)
	SendNUIMessage({
        type = 'notification',
        action = type,
        text = text
    })
end

RegisterNetEvent('dusa_guitarzero:cl:notify', function(text, type)
    dusa.showNotification(text, type)
end)

function dusa.serverCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb,  ...)
end

function dusa.getClosestPlayer()
	return ESX.Game.GetClosestPlayer()
end

function dusa.getClosestObject(coords)
	return ESX.Game.GetClosestObject(coords)
end

function dusa.getPlayersInArea(coords, dist)
    return ESX.Game.GetPlayersInArea(coords, dist)
end

function dusa.textUI(label)
    return lib.showTextUI(label)
end

function dusa.hideUI()
    return lib.hideTextUI()
end

function dusa.isPlayerDead()
    return isDead
end
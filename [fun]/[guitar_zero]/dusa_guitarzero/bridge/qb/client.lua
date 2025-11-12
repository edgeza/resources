if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()
dusa = {}
dusa.framework, dusa.playerLoaded, dusa.playerData, dusa.inventory = 'qb', nil, {}, 'qb'

AddStateBagChangeHandler('isLoggedIn', '', function(_bagName, _key, value, _reserved, _replicated)
    if value then
        dusa.playerData = QBCore.Functions.GetPlayerData()
    else
        table.wipe(dusa.playerData)
    end
    dusa.playerLoaded = value
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName or not LocalPlayer.state.isLoggedIn then return end
    dusa.playerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('dusa_guitarzero:sv:playerLoaded')
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    dusa.playerData = QBCore.Functions.GetPlayerData()
    dusa.playerLoaded = true
    TriggerServerEvent('dusa_guitarzero:sv:playerLoaded')
    TriggerServerEvent('dusa_guitarzero:sv:firstPlayer')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    dusa.playerData.job = job
end)

---@diagnostic disable: duplicate-set-field

function dusa.showNotification(text, type)
	SendNUIMessage({
        type = 'notification',
        action = type,
        text = text
    })
end

RegisterNetEvent('dusa_pets:cl:notify', function(text, type)
    dusa.showNotification(text, type)
end)

function dusa.serverCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb,  ...)
end

function dusa.getClosestPlayer()
	return QBCore.Functions.GetClosestPlayer()
end

function dusa.getClosestObject(coords)
	return QBCore.Functions.GetClosestObject(coords)
end

function dusa.getPlayersInArea(coords, dist)
    return QBCore.Functions.GetPlayersFromCoords(coords, dist)
end

function dusa.textUI(label)
    return exports['qb-core']:DrawText(label, 'right')
end

function dusa.keyPressed()
    return exports['qb-core']:KeyPressed()
end

function dusa.hideUI()
    return exports['qb-core']:HideText()
end

function dusa.isPlayerDead()
    dusa.playerData = QBCore.Functions.GetPlayerData()
    return dusa.playerData.metadata.isdead
end
local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config

local stormState = {
    active = false,
    data = nil,
    blip = nil
}

local tabletState = {
    open = false
}

local probes = {}
local lastProbePrompt = 0

local function debugPrint(...)
    if not Config.Debug then return end
    print('[stormchaser]', ...)
end

local function removeStormBlip()
    if stormState.blip and DoesBlipExist(stormState.blip) then
        RemoveBlip(stormState.blip)
    end
    stormState.blip = nil
end

local function createStormBlip(coords)
    removeStormBlip()
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 618)
    SetBlipScale(blip, 1.15)
    SetBlipColour(blip, 40)
    SetBlipHighDetail(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Severe Storm Cell')
    EndTextCommandSetBlipName(blip)
    stormState.blip = blip
end

local function updateStormBlip(data)
    if not stormState.blip or not DoesBlipExist(stormState.blip) then
        createStormBlip(data.coords)
    else
        SetBlipCoords(stormState.blip, data.coords.x, data.coords.y, data.coords.z)
    end
end

local function sendStormToUI()
    if not tabletState.open then return end
    SendNUIMessage({
        action = 'stormUpdate',
        storm = stormState.data,
        mapBounds = {
            min = { x = Config.MapBounds.min.x, y = Config.MapBounds.min.y },
            max = { x = Config.MapBounds.max.x, y = Config.MapBounds.max.y }
        }
    })
end

local function sendProbesToUI()
    if not tabletState.open then return end
    local owned = {}
    local serverId = GetPlayerServerId(PlayerId())
    for probeId, probe in pairs(probes) do
        if probe.owner == serverId then
            owned[#owned + 1] = {
                id = probeId,
                coords = probe.coords,
                ready = probe.ready,
                quality = probe.quality
            }
        end
    end
    SendNUIMessage({
        action = 'probeUpdate',
        probes = owned,
        mapBounds = {
            min = { x = Config.MapBounds.min.x, y = Config.MapBounds.min.y },
            max = { x = Config.MapBounds.max.x, y = Config.MapBounds.max.y }
        }
    })
end

local function toggleTablet(state)
    if state and tabletState.open then return end
    tabletState.open = state
    SetNuiFocus(state, state)
    SendNUIMessage({
        action = 'tablet',
        show = state
    })
    if state then
        sendStormToUI()
        sendProbesToUI()
    end
end

local function handleProbePrompt()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local now = GetGameTimer()

    for probeId, entry in pairs(probes) do
        if entry.obj and DoesEntityExist(entry.obj) then
            local distance = #(pos - entry.coords)
            if distance < 25.0 then
                DrawMarker(20, entry.coords.x, entry.coords.y, entry.coords.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                    0.35, 0.35, 0.35, 50, 120, 255, 120, false, true, 2, false, nil, nil, false)
            end

            if distance <= 1.6 then
                if now - lastProbePrompt > 1000 then
                    local label = entry.ready and '[E] Retrieve probe data' or 'Probe collecting atmospheric data'
                    exports['qb-core']:DrawText(label, 'left')
                    lastProbePrompt = now
                end

                if entry.ready and IsControlJustReleased(0, 38) then -- E
                    TriggerServerEvent('stormchaser:server:collectProbe', probeId)
                    Wait(250)
                end
            elseif lastProbePrompt ~= 0 and now - lastProbePrompt > 1100 then
                exports['qb-core']:HideText()
                lastProbePrompt = 0
            end
        end
    end
end

CreateThread(function()
    while true do
        Wait(0)
        if next(probes) then
            handleProbePrompt()
        else
            Wait(500)
        end
    end
end)

RegisterNetEvent('stormchaser:client:updateStorm', function(data)
    stormState.data = data
    stormState.active = data ~= nil

    if not data then
        removeStormBlip()
        SendNUIMessage({
            action = 'stormUpdate',
            storm = nil
        })
        return
    end

    updateStormBlip(data)
    sendStormToUI()
end)

RegisterNetEvent('stormchaser:client:syncProbes', function(serverProbes)
    for id, entry in pairs(probes) do
        if entry.obj and DoesEntityExist(entry.obj) then
            DeleteObject(entry.obj)
        end
    end
    probes = {}

    for id, entry in pairs(serverProbes) do
        local obj = CreateObjectNoOffset(`prop_tool_box_04`, entry.coords.x, entry.coords.y, entry.coords.z - 1.0, false, false, false)
        if obj ~= 0 then
            SetEntityHeading(obj, entry.heading or 0.0)
            FreezeEntityPosition(obj, true)
        end
        probes[id] = {
            obj = obj,
            coords = entry.coords,
            ready = entry.ready,
            quality = entry.quality,
            owner = entry.owner
        }
    end
    sendProbesToUI()
end)

RegisterNetEvent('stormchaser:client:updateProbe', function(id, data)
    local entry = probes[id]
    if not entry then
        entry = {}
        probes[id] = entry
    end

    if data.removed then
        if entry.obj and DoesEntityExist(entry.obj) then
            DeleteObject(entry.obj)
        end
        probes[id] = nil
        sendProbesToUI()
        return
    end

    entry.coords = data.coords or entry.coords
    entry.ready = data.ready or entry.ready
    entry.quality = data.quality or entry.quality
    entry.owner = data.owner or entry.owner

    if not entry.obj or not DoesEntityExist(entry.obj) then
        local obj = CreateObjectNoOffset(`prop_tool_box_04`, entry.coords.x, entry.coords.y, entry.coords.z - 1.0, false, false, false)
        if obj ~= 0 then
            SetEntityHeading(obj, data.heading or 0.0)
            FreezeEntityPosition(obj, true)
        end
        entry.obj = obj
    end

    sendProbesToUI()
end)

RegisterNetEvent('stormchaser:client:deployProbe', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, true) then
        QBCore.Functions.Notify('Exit your vehicle to deploy the probe.', 'error')
        return
    end

    local coords = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)
    local dropCoords = coords + forward * 1.8
    dropCoords = vector3(dropCoords.x, dropCoords.y, dropCoords.z - 1.0)

    local ground, groundZ = GetGroundZFor_3dCoord(dropCoords.x, dropCoords.y, dropCoords.z, false)
    if ground then
        dropCoords = vector3(dropCoords.x, dropCoords.y, groundZ + 0.02)
    end

    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_HAMMERING', 0, true)
    local duration = math.random(3500, 4200)
    Wait(duration)
    ClearPedTasks(ped)

    TriggerServerEvent('stormchaser:server:deployProbe', dropCoords, GetEntityHeading(ped))
end)

RegisterNetEvent('stormchaser:client:toggleTablet', function()
    toggleTablet(true)
end)

RegisterNUICallback('close', function(_, cb)
    toggleTablet(false)
    if cb then cb('ok') end
end)

RegisterNUICallback('requestStorm', function(_, cb)
    sendStormToUI()
    if cb then cb('ok') end
end)

RegisterNUICallback('requestProbes', function(_, cb)
    sendProbesToUI()
    if cb then cb('ok') end
end)

AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() then return end
    removeStormBlip()
    if tabletState.open then
        toggleTablet(false)
    end
    for _, entry in pairs(probes) do
        if entry.obj and DoesEntityExist(entry.obj) then
            DeleteObject(entry.obj)
        end
    end
    exports['qb-core']:HideText()
end)

local function requestInitialState()
    debugPrint('Requesting initial storm state')
    TriggerServerEvent('stormchaser:server:requestSync')
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    requestInitialState()
end)

AddEventHandler('onClientResourceStart', function(res)
    if res ~= GetCurrentResourceName() then return end
    requestInitialState()

    if Config.NewsStation and Config.NewsStation.blip and Config.NewsStation.blip.enabled then
        local blip = AddBlipForCoord(Config.NewsStation.coords.x, Config.NewsStation.coords.y, Config.NewsStation.coords.z)
        SetBlipSprite(blip, Config.NewsStation.blip.sprite or 184)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.NewsStation.blip.scale or 0.8)
        SetBlipColour(blip, Config.NewsStation.blip.color or 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.NewsStation.blip.text or 'News Station')
        EndTextCommandSetBlipName(blip)
    end

    if Config.Tablet.enableKeybind then
        RegisterKeyMapping('stormtablet', 'Open Storm Tablet', 'keyboard', Config.Tablet.openKey or 'F1')
    end
end)

RegisterCommand('stormtablet', function()
    TriggerServerEvent('stormchaser:server:useTablet')
end, false)

RegisterNetEvent('stormchaser:client:notify', function(message, messageType)
    QBCore.Functions.Notify(message, messageType or 'primary')
end)

RegisterNetEvent('stormchaser:client:initiateSell', function()
    TriggerServerEvent('stormchaser:server:sellData')
end)


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
local probeModel = `prop_tool_box_04`
local tornadoState = {
    active = false,
    coords = nil,
    scale = 0.0,
    progress = 0.0,
    fx = nil,
    assetLoaded = false,
    lastSiren = 0,
    lastWind = 0
}
local function ensureProbeModelLoaded()
    if HasModelLoaded(probeModel) then return true end
    RequestModel(probeModel)
    local waited = 0
    while not HasModelLoaded(probeModel) do
        Wait(50)
        waited += 50
        if waited >= 5000 then
            QBCore.Functions.Notify('Probe hardware failed to initialize.', 'error')
            return false
        end
    end
    return true
end


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

local function loadTornadoAsset()
    if tornadoState.assetLoaded or not Config.Tornado or not Config.Tornado.enabled then
        return tornadoState.assetLoaded
    end
    local particle = Config.Tornado.particle or {}
    if not particle.asset then return false end
    RequestNamedPtfxAsset(particle.asset)
    local waited = 0
    while not HasNamedPtfxAssetLoaded(particle.asset) do
        Wait(50)
        waited += 50
        if waited >= 5000 then
            debugPrint('Failed to load tornado particle asset:', particle.asset)
            return false
        end
    end
    tornadoState.assetLoaded = true
    return true
end

local function stopTornadoFx()
    if tornadoState.fx then
        StopParticleFxLooped(tornadoState.fx, 0)
        tornadoState.fx = nil
    end
    tornadoState.active = false
    tornadoState.coords = nil
    tornadoState.scale = 0.0
    tornadoState.progress = 0.0
    tornadoState.lastSiren = 0
    tornadoState.lastWind = 0
end

local function playPositionalSound(sound, set, coords)
    if not sound or not set or not coords then return end
    local soundId = GetSoundId()
    PlaySoundFromCoord(soundId, sound, coords.x, coords.y, coords.z, set, false, 0, false)
    ReleaseSoundId(soundId)
end

local function handleTornadoAudio(coords)
    local audioCfg = Config.Tornado and Config.Tornado.audio
    if not audioCfg or not audioCfg.enabled or not coords then return end
    local now = GetGameTimer()

    if audioCfg.useInteractSound then
        if tornadoState.lastSiren == 0 or now - tornadoState.lastSiren >= (audioCfg.sirenInterval or 6000) then
            TriggerServerEvent('stormchaser:server:tornadoInteractSound', 'siren')
            tornadoState.lastSiren = now
        end
        if audioCfg.windInterval and (tornadoState.lastWind == 0 or now - tornadoState.lastWind >= audioCfg.windInterval) then
            TriggerServerEvent('stormchaser:server:tornadoInteractSound', 'wind')
            tornadoState.lastWind = now
        end
        return
    end

    local fallback = audioCfg.fallback or {}
    if audioCfg.sirenInterval and (tornadoState.lastSiren == 0 or now - tornadoState.lastSiren >= audioCfg.sirenInterval) then
        if fallback.siren then
            playPositionalSound(fallback.siren.sound, fallback.siren.set, coords)
        end
        tornadoState.lastSiren = now
    end
    if audioCfg.windInterval and (tornadoState.lastWind == 0 or now - tornadoState.lastWind >= audioCfg.windInterval) then
        if fallback.wind then
            playPositionalSound(fallback.wind.sound, fallback.wind.set, coords)
        end
        tornadoState.lastWind = now
    end
end

local function updateTornadoFx(coords, scale)
    if not Config.Tornado or not Config.Tornado.enabled then return end
    if not coords then
        stopTornadoFx()
        return
    end
    if not loadTornadoAsset() then return end

    local particle = Config.Tornado.particle or {}
    if tornadoState.fx then
        SetParticleFxLoopedScale(tornadoState.fx, scale)
        SetParticleFxLoopedCoords(tornadoState.fx, coords.x, coords.y, coords.z)
    else
        UseParticleFxAssetNextCall(particle.asset)
        tornadoState.fx = StartParticleFxLoopedAtCoord(
            particle.effect or 'ent_core_bz_tornado',
            coords.x, coords.y, coords.z,
            0.0, 0.0, 0.0,
            scale,
            false, false, false, false
        )
    end
end

local function updateTornadoState(tornadoData)
    if not Config.Tornado or not Config.Tornado.enabled then
        return
    end

    if not tornadoData then
        if tornadoState.active then
            stopTornadoFx()
        end
        return
    end

    tornadoState.active = true
    tornadoState.coords = vector3(tornadoData.coords.x, tornadoData.coords.y, tornadoData.coords.z)
    tornadoState.scale = tornadoData.scale or tornadoState.scale
    tornadoState.progress = tornadoData.progress or tornadoState.progress

    updateTornadoFx(tornadoState.coords, tornadoState.scale)
    handleTornadoAudio(tornadoState.coords)
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
        updateTornadoState(nil)
        return
    end

    updateStormBlip(data)
    sendStormToUI()
    updateTornadoState(data.tornado)
end)

RegisterNetEvent('stormchaser:client:syncProbes', function(serverProbes)
    for id, entry in pairs(probes) do
        if entry.obj and DoesEntityExist(entry.obj) then
            DeleteObject(entry.obj)
        end
    end
    probes = {}

    for id, entry in pairs(serverProbes) do
        if not ensureProbeModelLoaded() then
            return
        end
        local obj = CreateObjectNoOffset(probeModel, entry.coords.x, entry.coords.y, entry.coords.z - 1.0, false, false, false)
        if obj ~= 0 then
            SetEntityHeading(obj, entry.heading or 0.0)
            FreezeEntityPosition(obj, true)
            SetModelAsNoLongerNeeded(probeModel)
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
        if not ensureProbeModelLoaded() then
            return
        end
        local obj = CreateObjectNoOffset(probeModel, entry.coords.x, entry.coords.y, entry.coords.z - 1.0, false, false, false)
        if obj ~= 0 then
            SetEntityHeading(obj, data.heading or 0.0)
            FreezeEntityPosition(obj, true)
            SetModelAsNoLongerNeeded(probeModel)
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

    if not ensureProbeModelLoaded() then
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
    SetModelAsNoLongerNeeded(probeModel)
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
    stopTornadoFx()
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

CreateThread(function()
    while true do
        if tornadoState.active and tornadoState.coords then
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local center = tornadoState.coords
            local diff = center - pedCoords
            local distance = #(diff)

            handleTornadoAudio(center)

            local forceCfg = Config.Tornado.force or {}
            local radius = forceCfg.radius or 0.0

            if radius > 0 and distance <= radius then
                local factor = 1.0 - (distance / radius)
                local direction = vector3(0.0, 0.0, 0.0)
                local magnitude = #(diff)
                if magnitude > 0.0 then
                    direction = diff / magnitude
                end
                local push = (forceCfg.player or 30.0) * factor
                local vertical = (forceCfg.vertical or 8.0) * factor
                ApplyForceToEntity(ped, 1, direction.x * push, direction.y * push, vertical, 0.0, 0.0, 0.0, 0, false, true, true, true, false, true)
            end

            if IsPedInAnyVehicle(ped, false) then
                local veh = GetVehiclePedIsIn(ped, false)
                if veh and veh ~= 0 then
                    local vehCoords = GetEntityCoords(veh)
                    local vDiff = center - vehCoords
                    local vDist = #(vDiff)
                    if radius > 0 and vDist <= radius then
                        local factor = 1.0 - (vDist / radius)
                        local direction = vector3(0.0, 0.0, 0.0)
                        local magnitude = #(vDiff)
                        if magnitude > 0.0 then
                            direction = vDiff / magnitude
                        end
                        local push = (forceCfg.vehicle or 80.0) * factor
                        local vertical = (forceCfg.vertical or 8.0) * factor
                        ApplyForceToEntity(veh, 1, direction.x * push, direction.y * push, vertical, 0.0, 0.0, 0.0, 0, false, true, true, true, false, true)
                    end
                end
            end

            local shakeCfg = Config.Tornado.screenShake or {}
            if shakeCfg.radius and shakeCfg.radius > 0 and distance <= shakeCfg.radius then
                local factor = 1.0 - (distance / shakeCfg.radius)
                local intensity = (shakeCfg.min or 0.1) + ((shakeCfg.max or 0.3) - (shakeCfg.min or 0.1)) * factor
                ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', intensity)
            end

            Wait(250)
        else
            Wait(1000)
        end
    end
end)



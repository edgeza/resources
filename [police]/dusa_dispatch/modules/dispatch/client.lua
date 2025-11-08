if not rawget(_G, "lib") then include('ox_lib', 'init') end
if not lib then return end

Dispatch  = {}

local blips = {}
local radius2 = {}
local alertsMuted = false
local alertsDisabled = false
local waypointCooldown = false

inHuntingZone, inNoDispatchZone = false, false
huntingzone, nodispatchzone = nil, nil


RegisterNetEvent('dusa_dispatch:DispatchHandler', function(data)
    if not config.AlertOptions[data.codeName] then
        config.AlertOptions[data.codeName] = {
            radius = 0,
            sprite = 58,
            color = 1,
            scale = 1.5,
            length = 2,
            sound = 'Lose_1st',
            sound2 = 'GTAO_FM_Events_Soundset',
            offset = false,
            flash = false,
            takescreenshot = false
        }
    end
end)


local function randomOffset(baseX, baseY, offset)
    local randomX = baseX + math.random(-offset, offset)
    local randomY = baseY + math.random(-offset, offset)
    return randomX, randomY
end

local function setWaypoint()
    local data = lib.callback.await('dusa_dispatch:getLatestDispatch', false)
    if not data then return warn('no latest dispatch found') end
    print("DISPATCH DEBUG recipientJobs:", json.encode(data.recipientJobs))
    if not waypointCooldown and Functions.IsRecipient(data.recipientJobs) then
        SetNewWaypoint(data.coords.x, data.coords.y)
        Utils.Notify(locale('waypoint_set'), 'success')
        waypointCooldown = true
        SetTimeout(5000, function() waypointCooldown = false end)
    end
end

local function waypointAlert(coords)
    if not waypointCooldown then
        SetNewWaypoint(coords[2], coords[1])
        Utils.Notify(locale('waypoint_set'), 'success')
        waypointCooldown = true
        SetTimeout(5000, function() waypointCooldown = false end)
    end
end

RegisterNUICallback('setMapMarker', function(data, cb)
    waypointAlert(data)
    cb('ok')
end)


local function createBlipData(coords, radius, sprite, color, scale, flash)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    local radiusBlip = AddBlipForRadius(coords.x, coords.y, coords.z, radius)

    SetBlipFlashes(blip, flash)
    SetBlipSprite(blip, sprite or 161)
    SetBlipHighDetail(blip, true)
    SetBlipScale(blip, scale or 1.0)
    SetBlipColour(blip, color or 84)
    SetBlipAlpha(blip, 255)
    SetBlipAsShortRange(blip, false)
    SetBlipCategory(blip, 2)
    SetBlipColour(radiusBlip, color or 84)
    SetBlipAlpha(radiusBlip, 128)

    return blip, radiusBlip
end

local function createBlip(data, blipData)
    local sprite = blipData.sprite or 161
    local color = blipData.color or 84
    local scale = blipData.scale or 1.0
    local flash = blipData.flash or false
    local radiusAlpha = 128
    local blipWaitTime = ((blipData.length or 2) * 60000) / radiusAlpha

    
    local coords = data.coords
    if config.mistakeForAlerts and blipData.offset then
        coords = {
            x = select(1, randomOffset(data.coords.x, data.coords.y, config.MaxOffset)),
            y = select(2, randomOffset(data.coords.x, data.coords.y, config.MaxOffset)),
            z = data.coords.z
        }
    end

    local blip, radius = createBlipData(coords, blipData.radius or 0, sprite, color, scale, flash)
    blips[data.id] = blip
    radius2[data.id] = radius

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(data.id .. ' - ' .. data.title)
    EndTextCommandSetBlipName(blip)

    while radiusAlpha > 0 do
        Wait(blipWaitTime)
        radiusAlpha = math.max(0, radiusAlpha - 1)
        SetBlipAlpha(radius, radiusAlpha)
    end

    RemoveBlip(radius)
    RemoveBlip(blip)
end

local function addBlip(data, blipData)
    if not Functions.IsPolice(Framework.Player.Job.Name) then return end
    CreateThread(function()
        createBlip(data, blipData)
        if not alertsMuted and alertShown then
            if not blipData.sound or blipData.sound == "Lose_1st" then
                PlaySound(-1, blipData.sound or "Lose_1st", blipData.sound2 or "GTAO_FM_Events_Soundset", 0, 0, 1)
            else
                TriggerServerEvent("InteractSound_SV:PlayOnSource", blipData.sound, 0.25)
            end
        end
    end)
end



local function animateAlert()
    SendNUIMessage({ action = 'ALERT_ANIMATION', data = true })
    Wait(3500)
    SendNUIMessage({ action = 'ALERT_ANIMATION', data = false })
end

function createZones()
    if config.Locations['HuntingZones'][1] then
        for _, hunting in pairs(config.Locations['HuntingZones']) do
            huntingzone = lib.zones.sphere({
                coords = hunting.coords,
                radius = hunting.radius,
                debug = config.debug,
                onEnter = function() inHuntingZone = true end,
                onExit = function() inHuntingZone = false end
            })
        end
    end
    if config.Locations['NoDispatchZones'][1] then
        for _, nodispatch in pairs(config.Locations['NoDispatchZones']) do
            nodispatchzone = lib.zones.box({
                coords = nodispatch.coords,
                size = vec3(nodispatch.length, nodispatch.width, nodispatch.maxZ - nodispatch.minZ),
                rotation = nodispatch.heading,
                debug = config.debug,
                onEnter = function() inNoDispatchZone = true end,
                onExit = function() inNoDispatchZone = false end
            })
        end
    end
end

function removeZones()
    if huntingzone then huntingzone:remove() end
    if nodispatchzone then nodispatchzone:remove() end
end

-- Keybind
RespondToDispatch = lib.addKeybind({
    name = 'RespondToDispatch'..config.RespondKeybind,
    description = 'Set waypoint to last call location',
    defaultKey = config.RespondKeybind,
    disabled = true,
    onPressed = function (self)
        setWaypoint()
    end,
})

OpenDispatchMenu = lib.addKeybind({
    name = 'OpenDispatchMenu'..config.OpenDispatchSettings,
    description = 'Open Dispatch Settings',
    defaultKey = config.OpenDispatchSettings,
    disabled = true,
    onPressed = function (self)
        SetNuiFocus(true, true)
        SendNUIMessage({action = 'OPEN_DISPATCH_SETTINGS', data = true})
    end,
})

local function convertAlert(data)
    if data.icon and string.match(data.icon, "^fas%-fa") then
        data.icon = 'theft'
    end

    local alert = {
        id = data.id,
        event = data.event or data.message,
        title = data.title or data.message,
        description = data.description or data.message,
        code = data.code or '10-XX',
        codeName = data.codeName or 'custom',
        icon = data.icon or 'theft',
        priority = data.priority or 0,
        img = data.img or "",
        coords = data.coords or GetEntityCoords(cache.ped),
        gender = data.gender or 'unknown',
        recipientJobs = data.jobs or data.recipientJobs or { 'leo' },
        street = data.street or Functions.GetStreetAndZone(GetEntityCoords(cache.ped)),
        unitCount = 0,
        userList = {},
        time = Functions.GetCurrentTime(),
        responses = {},
        units = {}
    }

    return alert
end

function Dispatch.SendDispatch(data)
    if alertsDisabled then return end
    data = convertAlert(data)

    if not Functions.IsRecipient(data.recipientJobs) then return end

    data.unitCount = 0

    SendNUIMessage({
        action = 'NEW_ALERT',
        data = data,
    })

    if not config.AlertOptions[data.codeName] then
        config.AlertOptions[data.codeName] = {
            radius = 0,
            sprite = 58,
            color = 1,
            scale = 1.5,
            length = 2,
            sound = 'Lose_1st',
            sound2 = 'GTAO_FM_Events_Soundset',
            offset = false,
            flash = false,
            takescreenshot = false
        }
    end

    addBlip(data, config.AlertOptions[data.codeName]) 
    if data.priority > 0 then
        animateAlert()
    end
end

RegisterNetEvent('dusa_dispatch:client:SendDispatch', Dispatch.SendDispatch)

function Dispatch.RemoveDispatch(id)
    SendNUIMessage({
        action = 'REMOVE_ALERT',
        data = id,
    })
    RemoveBlip(blips[id])
    RemoveBlip(radius2[id])
end
RegisterNetEvent('dusa_dispatch:removeDispatch', Dispatch.RemoveDispatch)

function Dispatch.UpdateAlert(data)
    SendNUIMessage({
        action = 'UPDATE_ALERT',
        data = data,
    })
end
RegisterNetEvent('dusa_dispatch:UpdateAlerts', Dispatch.UpdateAlert)

RegisterNUICallback('joinDispatch', function (data, cb)
    if not data.dispatch then return end
    TriggerServerEvent('dusa_dispatch:sv:UpdateAlerts', data.dispatch, #data.dispatch.units)
    cb('ok')
end)

RegisterNUICallback('leaveDispatch', function (data, cb)
    TriggerServerEvent('dusa_dispatch:sv:UpdateAlerts', data.dispatch, #data.dispatch.units)
    cb('ok')
end)

RegisterNUICallback('muteAlerts', function (data, cb)
    alertsMuted = data.mute
    if alertsMuted then
        lib.notify({ description = locale('alerts_muted'), position = 'top', type = 'error' })
    else
        lib.notify({ description = locale('alerts_unmuted'), position = 'top', type = 'info' })
    end
    cb('ok')
end)

RegisterNUICallback('ignoreAlerts', function (data, cb)
    alertsDisabled = data.ignore
    if alertsDisabled then
        lib.notify({ description = locale('ignore_alert'), position = 'top', type = 'error' })
    else
        lib.notify({ description = locale('unignore_alert'), position = 'top', type = 'info' })
    end
    cb('ok')
end)

RegisterNUICallback("clearBlips", function(data, cb)
    lib.notify({ description = locale('blips_cleared'), position = 'top', type = 'success' })
    for k, v in pairs(blips) do
        RemoveBlip(v)
    end
    for k, v in pairs(radius2) do
        RemoveBlip(v)
    end
    cb("ok")
end)

function PhoneAnimation()
    lib.requestAnimDict("cellphone@in_car@ds", 500)

    if not IsEntityPlayingAnim(cache.ped, "cellphone@in_car@ds", "cellphone_call_listen_base", 3) then
        TaskPlayAnim(cache.ped, "cellphone@in_car@ds", "cellphone_call_listen_base", 3.0, 3.0, -1, 50, 0, false, false, false)
    end

    Wait(2500)
    StopEntityAnim(cache.ped, "cellphone_call_listen_base", "cellphone@in_car@ds", 3)
end

---@param message string
---@return boolean
function IsCallAllowed(message)
    local msgLength = string.len(message)
    if msgLength == 0 then return false end
    return true
end

function GetIsHandcuffed()
    return false
end

return Dispatch

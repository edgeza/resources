
if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end
if not config.enableBodycam then return end

Bodycam = {}
dp('bodycam load')

local lastCoords = nil


LocalPlayer.state.onBodycam     = false
LocalPlayer.state.watchBodycam  = false

local function getTheme()
    local job = Framework.Player.Job.Name
    for _, value in pairs(config.dispatchJobs) do
        if job == value then
            return value
        end
    end
    warn('Couldn\'t find theme variation for player job, returned blue', job)
    return "blue"
end

-- NUI Message List
---@param BODYCAM_LIST string
---@param UPDATE_BODYCAM string
---@param UPDATE_BODYCAM_CLOCK string
---@param UPDATE_BODYCAM_JOB string
function Bodycam.listBodycam()
    local data = lib.callback.await('bodycam:getBodycamList', false)

    if data then
        SendNUIMessage({action = 'BODYCAM_LIST', data = {data = data, source = GetPlayerServerId(PlayerId())}})
    else
        SendNUIMessage({action = 'BODYCAM_LIST', data = {}})
    end
end

function Bodycam.openBodycam()
    if not Framework.Player.Metadata.callsign then Framework.Player.Metadata.callsign = config.defaultCallsign end 
    SendNUIMessage({action = 'openBodycam', data = true})
    Bodycam.UpdateBodycam(true)
    local time  = Functions.GetCurrentTime()
    local theme = getTheme()
    SendNUIMessage({action = 'UPDATE_BODYCAM', data = {
        enable = true,
        name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname,
        code = Framework.Player.Metadata.callsign,
        callSign = string.upper(Framework.Player.Metadata.callsign),
        adress = "Los Angeles Police Department",
        clock = time,
        job = Framework.Player.Job.Name,
        rank = Framework.Player.Job.Grade.Name,
        theme = theme, -- blue, red, yellow
    }})
    LocalPlayer.state:set('onBodycam', true, true)
end
RegisterNetEvent('dusa_dispatch:openBodycam', Bodycam.openBodycam)
exports('openBodycam', Bodycam.openBodycam)

function Bodycam.closeBodycam()
    SendNUIMessage({action = 'openBodycam', data = false})
    LocalPlayer.state:set('onBodycam', false, true)
    isActive = false
    Bodycam.UpdateBodycam(false)
end
RegisterNetEvent('dusa_dispatch:closeBodycam', Bodycam.closeBodycam)
exports('closeBodycam', Bodycam.closeBodycam)
RegisterCommand('closebodycam', Bodycam.closeBodycam)

function Bodycam.hideBodycam()
    SendNUIMessage({action = 'openBodycam', data = false})
end

function Bodycam.toggleBodycam()
    if LocalPlayer.state.onBodycam then
        Bodycam.closeBodycam()
    else
        Bodycam.openBodycam()
    end
end
RegisterNetEvent('dusa_dispatch:toggleBodycam', Bodycam.toggleBodycam)
exports('toggleBodycam', Bodycam.toggleBodycam)

local isActive = false
function Bodycam.UpdateBodycam(bool)
    if bool then
        isActive = true
        Citizen.CreateThread(
            function ()
                while isActive do
                    Citizen.Wait(1000)
                    local time  = Functions.GetCurrentTime()
                    SendNUIMessage({action = 'UPDATE_BODYCAM_CLOCK', data = time })
                end
            end
        )
    else
        isActive = false
    end
end

local targetPed
local bodycamW = false
local cam = nil
local inCam = false
local pedHeading

function Bodycam.connectBodycam(target)
    client.closeDispatch()

    if not target then
        error('No target player id')
        return
    end

    local playerId = GetPlayerServerId(PlayerId())
    if playerId == target then
        return notify(locale('cant_watch_yourself'), 'error')
    end

    DoScreenFadeOut(1000)

    while not IsScreenFadedOut() do
        Wait(0)
    end

	local myPed         = PlayerPedId()
	local myCoords      = GetEntityCoords(myPed)
    lastCoords = myCoords
    -- local targetNetId   = lib.callback.await('bodycam:getBodycamPed', false, target)
    -- local targetEntity  = NetworkGetEntityFromNetworkId(targetNetId)

    SetEntityVisible(myPed, false)

    local coords = lib.callback.await('bodycam:getBodycamCoords', false, target)
    SetEntityCoords(myPed, coords.x, coords.y, coords.z - 50)
    FreezeEntityPosition(myPed, true)

    Wait(500)
    local targetPlayer  = GetPlayerFromServerId(target)
    targetPed     = GetPlayerPed(targetPlayer)
	SetTimecycleModifier("scanline_cam_cheap")
	SetTimecycleModifierStrength(2.0)
    -- CreateHeliCam()
	cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
	AttachCamToPedBone(cam, targetPed, 31086, 0.05, -0.025, 0.1, true)
	SetCamFov(cam, 80.0)
	RenderScriptCams(true, false, 0, 1, 0)

    LocalPlayer.state:set('watchBodycam', true, true)
    inCam = true
    bodycamW = true

    DoScreenFadeIn(1000)

	while true do
        if inCam then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(myCoords - targetCoords)
            if distance > 290 then
                SetEntityCoords(myPed, targetCoords.x, targetCoords.y, targetCoords.z - 50)
            end
        else
            break
        end
        Wait(500)
	end
end

RegisterCommand('connectBodycam', function ()
    local ped = cache.ped
    local pedCoords = GetEntityCoords(ped)
    local closestPlayer = lib.getClosestPlayer(pedCoords)
    Bodycam.connectBodycam(closestPlayer)
end)

function InstructionButton(ControlButton)
    ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
end

function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function CreateInstuctionScaleform(scaleform)
    scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage(locale('leave_bodycam'))
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

CreateThread(function()
    while true do
        local sleep = 1000
        if Framework.Player.Loaded then
            if inCam then
                sleep = 1
                if bodycamW then
                    pedHeading = GetEntityHeading(targetPed)
                    SetCamRot(cam, 0, 0, pedHeading, 2)
                end
                local instructions = CreateInstuctionScaleform("instructional_buttons")
                DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)

                if IsControlJustPressed(0, 194) then
                    exitCam()
                    inCam = false
                end
            else
                sleep = 1000
            end
        end
        Wait(sleep)
    end
end)

function CreateHeliCam()
    local scaleform = RequestScaleformMovie("HELI_CAM")
	while not HasScaleformMovieLoaded(scaleform) do
		Wait(0)
	end
end

function exitCam()
    local ped = PlayerPedId()
    cam = nil
    inCam = false
    bodycamW = false
    prepareCameraSelf(ped, false)
    RenderScriptCams(false, false, 0, 1, 0)
    Wait(100)
    SetTimecycleModifier("default")
    SetTimecycleModifierStrength(0.3)
    SetEntityCoords(ped, lastCoords.x, lastCoords.y, lastCoords.z)
end

function prepareCameraSelf(ped, activating)
	DetachEntity(ped, 1, 1)
	SetEntityCollision(ped, not activating, not activating)
	SetEntityInvincible(ped, activating)
	if activating then
	  	NetworkFadeOutEntity(ped, activating, false)
	else
	  	NetworkFadeInEntity(ped, 0, false)
	end
    SetEntityVisible(ped, true)
    FreezeEntityPosition(ped, false)
    if bodycamW then
        SetFocusEntity(ped)
        NetworkSetInSpectatorMode(0, ped)
    end
end



-- Delete everything when script stops
AddEventHandler("onResourceStop", function(resource)
    if (GetCurrentResourceName() ~= resource) then
        return
    end
    if LocalPlayer.state.watchBodycam or inCam then
        exitCam()
    end
    LocalPlayer.state.watchBodycam = false
    LocalPlayer.state.onBodycam = false
    inCam = false
    DeleteObject(obj)
    DestroyCam(cam, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
end)

--- NUI Callbacks
RegisterNUICallback('BODYCAM_CLOSE', function(_, cb)
    if inCam then
        exitCam()
    end
    cb("ok")
end)

---@param expected string : data.gameId (player id)
RegisterNUICallback('BODYCAM_WATCH', function(data, cb)
    if not data then
        return
    end

    Bodycam.connectBodycam(data.gameId)
    cb("ok")
end)

return Bodycam
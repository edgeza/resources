
if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Camera                 = {}

local LoadedProps      = {}
local LoadedNoPropCams = {}
local CurrentHashCam   = `prop_spycam`
local InHit            = false
local Canceled         = false
local InGetLock        = false
local spyCam
local CurrentCam
local CurrentCamID
local Active           = false
local InCam            = false
local CurrentPlayerCoordDistance
local CurrentJob
local CurrentType
local CurrentItem
local InSwitchingCam   = false
local Shown            = false
local CurrentWifiResau = 'green'

-- Tablet Anim
local InAnim           = false
local TabletDict       = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local TabletAnim       = "base"
local TabletProp       = `prop_cs_tablet`
local TabletObj
local TabletBone       = 60309
local TabletOffset     = vector3(0.03, 0.002, -0.0)
local TabletRot        = vector3(10.0, 160.0, 0.0)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    if not Framework.Player.Loaded then return end
    LoadingCameraObjects()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    ClearPedSecondaryTask(PlayerPedId())
    SetEntityAsMissionEntity(TabletObj)
    DetachEntity(TabletObj, true, false)
    DeleteObject(TabletObj)
    UnloadCameraObjects()
    Camera.ExitCamera()
end)

-- NUI Cb
RegisterNUICallback('createCamera', function(data, cb)
    client.closeDispatch()
    local coords = GetEntityCoords(cache.ped)
    local adress = Functions.GetStreetAndZone(coords)
    data.adress = adress
    data.position = coords
    Camera.CreateCamera(data)
    cb("ok")
end)

RegisterNUICallback('closeDispatch', function(data, cb)
    client.closeDispatch()
    cb("ok")
end)

RegisterNUICallback('deleteCamera', function(data, cb)
    if not data.id then
        return warn('Listed camera id not found')
    end

    TriggerServerEvent('dusa_dispatch:RemoveStaticCam', data.id, data.camid)
    cb("ok")
end)

RegisterNUICallback('pointCamera', function(data, cb)
    if not data.coords then
        return warn('Listed camera doesnt have any coords')
    end
    client.closeDispatch()

    if type(data.coords) == 'string' then
        data.coords = json.decode(data.coords)
    end

    local x, y = data.coords[2], data.coords[1]
    Utils.Notify(locale('waypoint_set_camera'), 'success')
    SetNewWaypoint(x, y)
    cb("ok")
end)

RegisterNUICallback('connectCamera', function(data, cb)
    if not data.id then
        return warn('Listed camera doesnt have any coords')
    end

    client.closeDispatch()
    lib.callback('dusa_dispatch:GetStaticCams', false, function(Result)
        if Result then
            for k, v in pairs(Result) do
                if v.id == data.id then
                    local Settings = json.decode(v.setting)
                    local Cam_ID   = data.index
                    local DataCams = Result
                    Camera.WatchCam(v.name, v.coords, v.rot, Settings, Cam_ID, DataCams, v.id)
                end
            end
        end
    end)
    cb("ok")
end)

function Camera.listCamera()
    local cameraList = {}
    lib.callback('dusa_dispatch:GetStaticCams', false, function(Result)
        if Result then
            for k, v in pairs(Result) do
                v.setting = json.decode(v.setting)
                v.coords = json.decode(v.coords)
                cameraList[#cameraList + 1] = {
                    id = v.id,
                    camId = v.camid,
                    name = v.name,
                    position = { v.coords.y, v.coords.x },
                    type = v.setting.Prop,
                    adress = v.setting.Street
                }
            end
            SendNUIMessage({ action = 'LIST_CAMERA', data = cameraList })
        end
    end)
end

-- silah sıkılınca kamera kırma
AddEventHandler('CEventGunShot', function(witnesses, ped, coords)
    if PlayerPedId() ~= ped then return end
    local Hit, Coords, Entity = Utils.RayCastGamePlayCamera(70.0)
    if Hit then
        if DoesEntityExist(Entity) then
            for k, v in pairs(LoadedProps) do
                if v.Prop == Entity then
                    local FirstPropCoords = GetEntityCoords(v.Prop)
                    local SecondPropCoords = GetEntityCoords(Entity)
                    local Dist = #(FirstPropCoords - SecondPropCoords)
                    if Dist <= 0.1 then
                        local BrokeCamera = BrokeCamera(v.Id)
                        if BrokeCamera == 'true' then
                            notify('You broke a camera', 'error', 5000)
                            TriggerServerEvent('dusa_dispatch:RemoveBrokenCam', v.camid)
                        end
                    end
                end
            end
        end
        for k, v in pairs(LoadedNoPropCams) do
            local NearDist = #(v.Coord - Coords)
            if NearDist <= 0.3 then
                local BrokeCamera = BrokeCamera(v.Id)
                if BrokeCamera == 'true' then
                    notify('You broke a camera', 'error', 5000)
                end
            end
        end
    end
end)

function LoadingCameraObjects()
    lib.callback('dusa_dispatch:GetStaticCams', false, function(Result)
        if Result then
            for k, v in pairs(Result) do
                local Settings = json.decode(v.setting)
                if tonumber(Settings.ShowProp) == 1 then
                    if tonumber(Settings.Broken) == 0 then
                        RequestModel(Settings.Prop)
                        while not HasModelLoaded(Settings.Prop) do Wait(0) end
                        local Coords = Settings.PropCoords.Coords
                        local Rot = Settings.PropCoords.Rotation
                        local CamProp = CreateObject(Settings.Prop, Coords.x, Coords.y, Coords.z, 0, false, false)
                        SetEntityCoordsNoOffset(CamProp, Coords.x, Coords.y, Coords.z, true, true, true)
                        SetEntityRotation(CamProp, Rot.x, Rot.y, Rot.z, 2, 1)
                        LoadedProps[#LoadedProps + 1] = {
                            Id = v.id,
                            camid = v.camid,
                            Prop = CamProp
                        }
                    end
                else
                    local Coords = Settings.PropCoords.Coords
                    LoadedNoPropCams[#LoadedNoPropCams + 1] = {
                        Id = v.id,
                        Coord = vector3(Coords.x, Coords.y, Coords.z)
                    }
                end
            end
        end
    end)
end

function UnloadCameraObjects()
    for _, object in pairs(LoadedProps) do
        DeleteObject(object.Prop)
    end
end

RegisterNetEvent('dusa_dispatch:LoadPropCamera', function(Prop, Coords, Rot, TheId, ShowProp, camid)
    if Framework.Player.Loaded then
        RequestModel(Prop)
        while not HasModelLoaded(Prop) do Wait(0) end
        local CamProp = CreateObject(Prop, Coords.x, Coords.y, Coords.z, 0, false, false)
        SetEntityCoordsNoOffset(CamProp, Coords.x, Coords.y, Coords.z, true, true, true)
        SetEntityRotation(CamProp, Rot.x, Rot.y, Rot.z, 2, 1)

        LoadedProps[#LoadedProps + 1] = {
            Id = TheId,
            camid = camid,
            Prop = CamProp
        }
    end
end)

RegisterNetEvent('dusa_dispatch:RemovePropCamera', function(TheId)
    if Framework.Player.Loaded then
        for k, v in pairs(LoadedProps) do
            if tonumber(v.Id) == TheId then
                DeleteObject(v.Prop)
                LoadedProps[k] = nil
                return
            end
        end
    end
end)


function notify(text, type, timer)
    if type == 'info' then type = 'inform' end
    lib.notify({ title = type:upper(), description = text, type = type, duration = timer or 3500 })
end

function Camera.CreateCamera(data)
    if Active then
        notify('You are active install camera', 'error', 3500)
        return
    end
    CurrentItem = 'camera'
    Active = true
    Camera.StartLineCreate(data)
end

RegisterNetEvent('dusa_dispatch:CreateNewCamera', Camera.CreateCamera)
-- RegisterCommand('placecam', Camera.CreateCamera, false)

function Camera.CrashCamera(id)
    if InCam then
        if CurrentCamID ~= nil and CurrentCam ~= nil then
            if CurrentCamID == id then
                Camera.ExitCamera()
                notify('Camera Crashed', 'error', 7000)
            end
        end
    end
end

RegisterNetEvent('dusa_dispatch:CrashCamera', Camera.CrashCamera)

RegisterNetEvent('dusa_dispatch:DisableInSwitchinCamActions', function()
    while InSwitchingCam do
        Utils.DisableActions()
        Wait(0)
    end
end)

local function TabletAnimation()
    if InAnim then return end
    InAnim = true
    -- Animation
    RequestAnimDict(TabletDict)
    while not HasAnimDictLoaded(TabletDict) do Wait(100) end
    -- Model
    RequestModel(TabletProp)
    while not HasModelLoaded(TabletProp) do Wait(100) end

    local plyPed = PlayerPedId()
    TabletObj = CreateObject(TabletProp, 0.0, 0.0, 0.0, true, true, false)
    local tabletBoneIndex = GetPedBoneIndex(plyPed, TabletBone)

    AttachEntityToEntity(TabletObj, plyPed, tabletBoneIndex, TabletOffset.x, TabletOffset.y, TabletOffset.z, TabletRot.x,
        TabletRot.y, TabletRot.z, true, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(TabletProp)

    CreateThread(function()
        while InAnim do
            Wait(0)
            if not IsEntityPlayingAnim(plyPed, TabletDict, TabletAnim, 3) then
                TaskPlayAnim(plyPed, TabletDict, TabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end


        ClearPedSecondaryTask(plyPed)
        Wait(250)
        DetachEntity(TabletObj, true, false)
        DeleteEntity(TabletObj)
    end)
end

RegisterNetEvent('dusa_dispatch:LiserFixCam', function(Prop, CamCoord, Time)
    local WaitTime = true
    local Color = { r = 255, g = 0, b = 0, a = 200 }
    local Colors = {
        Orange = { r = 255, g = 165, b = 0, a = 200 },
        Green = { r = 0, g = 255, b = 0, a = 200 }
    }
    SetTimeout(Time / 2.3, function() Color = Colors.Orange end)
    SetTimeout(Time / 1.5, function() Color = Colors.Green end)
    SetTimeout(Time, function() WaitTime = false end)
    while WaitTime do
        local EntityCoords = GetEntityCoords(Prop)
        DrawLine(EntityCoords.x, EntityCoords.y, EntityCoords.z, CamCoord.x, CamCoord.y, CamCoord.z, Color.r, Color.g,
            Color.b, Color.a)
        DrawMarker(28, CamCoord.x, CamCoord.y, CamCoord.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, Color.r,
            Color.g, Color.b, Color.a, false, true, 2, nil, nil, false)
        Wait(5)
    end
end)


function Camera.StartLineCreate(data)
    local coords = GetEntityCoords(PlayerPedId())
    local UIShowed = false
    local ThePropHash
    ThePropHash = config.cameraList[1]
    CurrentHashCam = ThePropHash
    RequestModel(ThePropHash)
    while not HasModelLoaded(ThePropHash) do Wait(0) end

    spyCam = CreateObject(ThePropHash, coords, 0, false, false)
    SetEntityCollision(spyCam, false)
    local CurrentProp = 1
    local DistanceCamCreate = 70.0

    local KeysTable = {
        { Text = 'Set Camera',   Key = 38 },
        { Text = 'Cancel',       Key = 194 },
        { Text = 'Right Camera', Key = 175 },
        { Text = 'Left Camera',  Key = 174 },
        { Text = 'UP Camera',    Key = 172 },
        { Text = 'Down Camera',  Key = 173 },
    }
    KeysTable[#KeysTable + 1] = { Text = 'Next Cam Prop', Key = 311 }
    KeysTable[#KeysTable + 1] = { Text = 'Back Cam Prop', Key = 182 }
    local InLoadingProp = false
    CreateThread(function()
        while Active do
            local hit, coords, entity = Utils.RayCastGamePlayCamera(DistanceCamCreate)
            local playerPed = PlayerPedId()
            local position = GetEntityCoords(playerPed)
            local color = { r = 255, g = 0, b = 0, a = 200 }
            if hit and #(position - vector3(coords.x, coords.y, coords.z)) <= DistanceCamCreate then
                InHit = true

                local instructions = CreateInstuctionScaleformCustom("instructional_buttons", KeysTable)
                DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)

                -- Outline Prop Camera
                SetEntityDrawOutline(spyCam, true)
                SetEntityDrawOutlineColor(color.r, color.g, color.b, color.a)

                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b,
                    color.a)

                if not UIShowed then
                    UIShowed = true
                    SetEntityVisible(spyCam, true, 0)
                end
                -- GET COORDS ENTITY
                local GetEntityRotation = GetEntityRotation(spyCam)

                -- SET OBJECT IN WALL
                SetEntityCoordsNoOffset(spyCam, coords.x, coords.y, coords.z, true, true, true)

                -- ROTATE UP
                if IsControlPressed(0, 172) then
                    SetEntityRotation(spyCam, GetEntityRotation.x - config.CameraSensivity.Up, GetEntityRotation.y,
                        GetEntityRotation.z, 2, 1)
                end

                -- ROTATE DOWN
                if IsControlPressed(0, 173) then
                    SetEntityRotation(spyCam, GetEntityRotation.x + config.CameraSensivity.Down, GetEntityRotation.y,
                        GetEntityRotation.z, 2, 1)
                end

                -- ROTATE LEFT
                if IsControlPressed(0, 174) then
                    SetEntityRotation(spyCam, GetEntityRotation.x, GetEntityRotation.y,
                        GetEntityRotation.z - config.CameraSensivity.Left, 2, 1)
                end

                -- ROTATE RIGHT
                if IsControlPressed(0, 175) then
                    SetEntityRotation(spyCam, GetEntityRotation.x, GetEntityRotation.y,
                        GetEntityRotation.z + config.CameraSensivity.Right, 2, 1)
                end

                -- To Add Camera
                if IsControlPressed(0, 38) then -- E
                    CurrentPlayerCoordDistance = GetEntityCoords(PlayerPedId())
                    Camera.PlaceCam(data)
                    return
                end
            else
                if UIShowed then
                    UIShowed = false
                    SetEntityVisible(spyCam, false, 0)
                end
                InHit = false
            end
            local PropSwitched = false

            -- BACK PROP
            if IsControlJustPressed(0, 182) then
                if not PropSwitched then
                    CurrentProp -= 1
                    if CurrentProp < 1 then
                        CurrentProp = #config.cameraList
                    end
                    PropSwitched = true
                end
            end

            -- NEXT PROP
            if IsControlJustPressed(0, 311) then
                if not PropSwitched then
                    CurrentProp += 1
                    if CurrentProp > #config.cameraList then
                        CurrentProp = 1
                    end
                    PropSwitched = true
                end
            end

            if PropSwitched and not InLoadingProp then
                InLoadingProp = true
                CurrentHashCam = config.cameraList[CurrentProp]
                DeleteEntity(spyCam)
                RequestModel(config.cameraList[CurrentProp])
                while not HasModelLoaded(config.cameraList[CurrentProp]) do Wait(0) end
                spyCam = CreateObject(config.cameraList[CurrentProp], coords, 0, false, false)
                SetEntityCollision(spyCam, false)
                PropSwitched = false
                InLoadingProp = false
            end
            Wait(0)
        end
    end)
end

function Camera.PlaceCam(Data)
    CreateThread(function()
        if Active and InHit then
            InGetLock = true
            Active = false
            SetEntityDrawOutline(spyCam, false)
            local coords = GetEntityCoords(spyCam)
            local PropCameraCoords = {
                Coords = coords,
                Rotation = GetEntityRotation(spyCam)
            }
            local LockCoords
            local KeysTabl = { { Text = 'Where You Want Camera Lock', Key = 47 }, { Text = 'To Cancel', Key = 194 } }
            while InGetLock do
                DrawScaleformMovieFullscreen(CreateInstuctionScaleformCustom("instructional_buttons", KeysTabl), 255, 255,
                    255, 255, 0)

                if Canceled then
                    Canceled = false
                    InGetLock = false
                    DeleteEntity(spyCam)
                    return
                end

                local Toch, Coords, Entity = Utils.RayCastGamePlayCamera(100.0)
                local pCoords = GetEntityCoords(PlayerPedId())
                local Color = { r = 0, g = 255, b = 0, a = 200 }
                if Toch then
                    DrawLine(pCoords.x, pCoords.y, pCoords.z, Coords.x, Coords.y, Coords.z, Color.r, Color.g, Color.b,
                        Color.a)
                    DrawMarker(28, Coords.x, Coords.y, Coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, Color.r,
                        Color.g, Color.b, Color.a, false, true, 2, nil, nil, false)
                    if IsDisabledControlJustPressed(0, 47) then -- G
                        LockCoords = Coords
                        InGetLock = false
                    end
                end
                Wait(0)
            end
            coords = vec3(coords.x + 1.0, coords.y, coords.z)
            local Camera = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", coords, 0.0, 0.0, 0.0, 0.0, true, 2)
            PointCamAtCoord(Camera, LockCoords.x, LockCoords.y, LockCoords.z)
            Wait(200)
            local cameraRotation = GetCamRot(Camera, 2)
            DestroyCam(Camera, false)

            local Setting = {
                Prop = CurrentHashCam,
                CanRemove = 1,
                ShowProp = 1,
                CanMove = 1,
                Type = 'Job',
                Job = Framework.Player.Job.Name,
                PropCoords = PropCameraCoords,
                Broken = 0,
                IP = GenerateRandomIPv4(),
                DistanceRemove = #(CurrentPlayerCoordDistance - coords),
                Street = Functions.GetStreetAndZone(coords)
            }
            DeleteEntity(spyCam)
            if not Data then
                Data.name = 'Camera'
            end
            TriggerServerEvent('dusa_dispatch:SaveNewCam', Data.camId, Data.name, json.encode(Setting),
                json.encode(coords), json.encode(cameraRotation), CurrentItem)
            client.openDispatch()
        end
    end)
end

function BrokeCamera(id)
    return lib.callback.await('dusa_dispatch:BrokeCamera', false, id)
end

function Camera.ExitCamera()
    if InCam and (CurrentCam ~= nil) then
        InCam = false
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do Wait(0) end
        ClearTimecycleModifier("scanline_cam_cheap")
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(CurrentCam, false)
        SetFocusEntity(PlayerPedId())
        ClearPedTasks(PlayerPedId())
        Wait(500)
        SendNUIMessage({
            type = "disablecam",
        })
        DoScreenFadeIn(500)
        while not IsScreenFadedIn() do Wait(0) end
        CurrentCam = nil
        LocalPlayer.state:set('inv_busy', false, false)
    elseif Active then
        Active = false
        DeleteEntity(spyCam)
    elseif InGetLock then
        Canceled = true
    end
end

RegisterKeyMapping("exitcamera", "Exit Camera", "keyboard", "BACK")
RegisterCommand('exitcamera', Camera.ExitCamera, false)

function Camera.WatchCam(Name, Coords, Rotation, Action, Cam_ID, DataCams, ID)
    if not InCam then
        LocalPlayer.state:set('inv_busy', true, false)
        CurrentCamID = ID
        local LoadingCams = {}
        local CuurentNumberCam
        CuurentNumberCam = Cam_ID


        for _, datacam in pairs(DataCams) do LoadingCams[_] = datacam end
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do Wait(0) end
        InCam = true
        local coords = json.decode(Coords)
        local rot = json.decode(Rotation)
        CurrentCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        local ForwardCoords = MoveCoordsForward(coords.x, coords.y, coords.z, rot.z, 0.2)
        SetCamCoord(CurrentCam, ForwardCoords.x, ForwardCoords.y, ForwardCoords.z)
        SetCamRot(CurrentCam, rot.x, rot.y, rot.z - 180, 2)
        SetFocusPosAndVel(ForwardCoords.x, ForwardCoords.y, ForwardCoords.z, 0, 0, 0)
        SetTimecycleModifier("scanline_cam_cheap")
        SetTimecycleModifierStrength(2.0)
        RenderScriptCams(true, false, 0, 1, 0)
        local s1, s2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local street = GetStreetNameFromHashKey(s1)
        if tonumber(Action.Broken) == 1 then Action.Broken = false else Action.Broken = true end
        -- SendNUIMessage({
        --     type = "enablecam",
        --     label = Name,
        --     id = Action.IP,
        --     connected = Action.Broken,
        --     address = street,
        --     time = GetCurrentTime(),
        -- })
        FreezeEntityPosition(PlayerPedId(), true)
        Wait(500)
        DoScreenFadeIn(500)
        local RighthingMove = 0
        local Clicked = false
        while InCam do
            local instructions = CreateInstuctionScaleform("instructional_buttons", Action.Type == 'Job')
            DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
            Utils.DisableActions()
            if tonumber(Action.CanMove) == 1 then
                local CamRot = GetCamRot(CurrentCam, 2)

                -- ROTATE UP
                if IsControlPressed(0, 32) then
                    if CamRot.x <= 0.0 then
                        SetCamRot(CurrentCam, CamRot.x + 0.7, 0.0, CamRot.z, 2)
                    end
                end

                -- ROTATE DOWN
                if IsControlPressed(0, 8) then
                    if CamRot.x >= -50.0 then
                        SetCamRot(CurrentCam, CamRot.x - 0.7, 0.0, CamRot.z, 2)
                    end
                end

                -- ROTATE LEFT
                if IsControlPressed(0, 34) then
                    if RighthingMove < 50.0 then
                        RighthingMove += 1
                        SetCamRot(CurrentCam, CamRot.x, 0.0, CamRot.z + 0.7, 2)
                    end
                end

                -- ROTATE RIGHT
                if IsControlPressed(0, 9) then
                    if RighthingMove > -50.0 then
                        RighthingMove -= 1
                        SetCamRot(CurrentCam, CamRot.x, 0.0, CamRot.z - 0.7, 2)
                    end
                end
            end

            -- NEXT CAM
            if IsControlJustPressed(0, 223) and (not IsControlPressed(0, 222)) then
                if not Clicked then
                    Clicked = true
                    CuurentNumberCam += 1
                    if CuurentNumberCam > #LoadingCams then CuurentNumberCam = 1 end
                end
            end

            -- BACK CAM
            if IsControlJustPressed(0, 222) and (not IsControlPressed(0, 223)) then
                if not Clicked then
                    Clicked = true
                    CuurentNumberCam -= 1
                    if CuurentNumberCam < 1 then CuurentNumberCam = #LoadingCams end
                end
            end

            if Clicked and not InSwitchingCam then
                InSwitchingCam = true
                if #LoadingCams > 1 then
                    TriggerEvent('dusa_dispatch:DisableInSwitchinCamActions')
                    DoScreenFadeOut(1000)
                    while not IsScreenFadedOut() do Wait(0) end
                    SendNUIMessage({
                        type = "disablecam",
                    })
                    ClearTimecycleModifier("scanline_cam_cheap")
                    RenderScriptCams(false, false, 0, 1, 0)
                    DestroyCam(CurrentCam, false)
                    CurrentCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
                    local DataCam = LoadingCams[CuurentNumberCam]
                    coords = json.decode(DataCam.coords)
                    rot = json.decode(DataCam.rot)
                    local Settings = json.decode(DataCam.setting)
                    CurrentCamID = DataCam.id
                    ForwardCoords = MoveCoordsForward(coords.x, coords.y, coords.z, rot.z, 0.2)
                    SetCamCoord(CurrentCam, ForwardCoords.x, ForwardCoords.y, ForwardCoords.z)
                    SetCamRot(CurrentCam, rot.x, rot.y, rot.z, 2)
                    SetFocusPosAndVel(ForwardCoords.x, ForwardCoords.y, ForwardCoords.z, 0, 0, 0)
                    SetTimecycleModifier("scanline_cam_cheap")
                    SetTimecycleModifierStrength(2.0)
                    RenderScriptCams(true, false, 0, 1, 0)
                    s1, s2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
                    street = GetStreetNameFromHashKey(s1)
                    if tonumber(Settings.Broken) == 1 then Settings.Broken = false else Settings.Broken = true end
                    Action.CanMove = Settings.CanMove
                    if Settings.Broken then
                        -- SendNUIMessage({
                        --     type = "enablecam",
                        --     label = DataCam.name,
                        --     id = Settings.IP,
                        --     connected = Settings.Broken,
                        --     address = street,
                        --     time = GetCurrentTime(),
                        -- })
                        DoScreenFadeIn(1000)
                    else
                        DoScreenFadeIn(1000)
                        -- SendNUIMessage({
                        --     type = "enablecam",
                        --     label = DataCam.name,
                        --     id = Settings.IP,
                        --     connected = Settings.Broken,
                        --     address = street,
                        --     time = GetCurrentTime(),
                        -- })
                    end
                    while not IsScreenFadedIn() do Wait(0) end
                    SetTimeout(500, function()
                        InSwitchingCam = false
                        Clicked = false
                    end)
                else
                    notify('No Cams To Swap', 'error', 3500)
                    SetTimeout(2000, function()
                        InSwitchingCam = false
                        Clicked = false
                    end)
                end
            end
            Wait(0)
        end
        FreezeEntityPosition(PlayerPedId(), false)
        Shown = false
        InAnim = false
    end
end

function GenerateRandomIPv4()
    local ip = {}
    for i = 1, 4 do
        table.insert(ip, math.random(0, 255))
    end

    local GeneratedIP = table.concat(ip, '.')

    -- Check If Generated IP Already Available
    local Result = lib.callback.await('dusa_dispatch:GetStaticCams', false)
    if Result then
        for k, v in pairs(Result) do
            local Settings = json.decode(v.setting)
            if Settings.IP == GeneratedIP then
                TriggerServerEvent('dusa_dispatch:ErrorSendAlert', 'Generate IP Already Available, Try Creating New One')
                return GenerateRandomIPv4()
            end
        end
    end

    return GeneratedIP
end

function GenerateRandomSignal(length)
    local characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    local signal = ""

    for i = 1, length do
        local randomIndex = math.random(1, #characters)
        local randomChar = characters:sub(randomIndex, randomIndex)
        signal = signal .. randomChar
    end

    -- Check If Generated Signal Already Available
    local Result = lib.callback.await('dusa_dispatch:GetStaticCams', false)
    if Result then
        for k, v in pairs(Result) do
            local Settings = json.decode(v.setting)
            if Settings.Type == 'Signal' then
                if Settings.Signal == signal then
                    TriggerServerEvent('dusa_dispatch:ErrorSendAlert',
                        'Generate Signale Already Available, Try Creating New One')
                    return GenerateRandomSignal(length)
                end
            end
        end
    end

    return signal
end

function MoveCoordsForward(x, y, z, heading, distance)
    -- Convert heading to radians
    local headingRad = math.rad(heading)

    -- Calculate the new coordinates
    local newX = x - distance * math.sin(headingRad)
    local newY = y + distance * math.cos(headingRad)

    return { x = newX, y = newY, z = z, w = heading }
end

function InstructionButton(ControlButton)
    ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
end

function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function InstructionalButton(controlButton, text)
    ScaleformMovieMethodAddParamPlayerNameString(controlButton)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function CreateInstuctionScaleform(scaleform, switch)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    ---------------------------------------------------------------------------------
    InstructionalButton(GetControlInstructionalButton(0, 194, 1), "Exit Camera")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    if switch then
        InstructionalButton(GetControlInstructionalButton(0, 25, 1), 'Back Cam')
        PopScaleformMovieFunctionVoid()
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(2)
        InstructionalButton(GetControlInstructionalButton(0, 24, 1), 'Next Cam')
        PopScaleformMovieFunctionVoid()
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(3)
    end
    ---------------------------------------------------------------------------------
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

function CreateInstuctionScaleformCustom(scaleform, keys)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    ---------------------------------------------------------------------------------
    for k, v in pairs(keys) do
        InstructionalButton(GetControlInstructionalButton(0, v.Key, 1), v.Text)
        PopScaleformMovieFunctionVoid()
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(k)
    end
    ---------------------------------------------------------------------------------
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    SetScaleformMovieAsNoLongerNeeded()
    return scaleform
end

return Camera

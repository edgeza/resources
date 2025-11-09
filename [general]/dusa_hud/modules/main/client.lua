pauseActive = false
alreadyInVehicle = false

hudSettings = {
    compassBehaviour = "playerlook",
    speedType = 'kmh',
    speedoRefreshRate = 500,
    speedoRefreshRateLevel = config.defaultRefreshRate,
    cinematicMode = false,
    streamerMode = false,
    currentStatus = config.DefaultStatus,
    currentSpeedo = config.DefaultSpeedometer,
    playMediaSongs = false,
    showMiniMap = config.DisableMinimapOption and true or config.mapWhileWalking
}

directions = {
    N = 360, 0,
    NE = 315,
    E = 270,
    SE = 225,
    S = 180,
    SW = 135,
    W = 90,
    NW = 45
}

function HideHud()
    dp('hide hud')
    nuiMessage('visibleHud', false)
end

CreateThread(function()
    nuiMessage('hideHud', true)

    -- disable vehicle keybinds
    local pPed = PlayerPedId()
    if not IsPedInAnyVehicle(pPed) then
        CruiseControl:disable(true)
        if config.EnableSeatbelt then
            SeatbeltControl:disable(true)
        end
        if config.EnableEngineControl then
            EngineControl:disable(true)
        end
    end
end)

function ShowHud()
    dp('show hud')
    nuiMessage('visibleHud', true)
end

function multipleSpeed()
    return hudSettings.speedType == 'kmh' and 3.6 or 2.23694
end

RegisterNetEvent("dusa_hud:hide")
RegisterNetEvent("dusa_hud:show")

AddEventHandler("dusa_hud:hide", HideHud)
AddEventHandler("dusa_hud:show", ShowHud)

exports('HideHud', HideHud)
exports('ShowHud', ShowHud)

CreateThread(function()
    while true do
        if IsPauseMenuActive() and not pauseActive then
            pauseActive = true
            HideHud()
        end
        if not IsPauseMenuActive() and pauseActive and not CinematicModeOn then
            pauseActive = false
            ShowHud()
        end
        Wait(500)
    end
end)

if config.EnableGTAUI then
    CreateThread(function()
        while true do
            if config.HideDefaultUI.vehicle_name then
                HideHudComponentThisFrame(6) -- VEHICLE_NAME
            end
            if config.HideDefaultUI.area_name then
                HideHudComponentThisFrame(7) -- AREA_NAME
            end
            if config.HideDefaultUI.vehicle_class then
                HideHudComponentThisFrame(8) -- VEHICLE_CLASS
            end
            if config.HideDefaultUI.street_name then
                HideHudComponentThisFrame(9) -- STREET_NAME
            end
            if config.HideDefaultUI.cash then
                HideHudComponentThisFrame(3) -- CASH
            end
            if config.HideDefaultUI.mp_cash then
                HideHudComponentThisFrame(4) -- MP_CASH
            end
            if config.HideDefaultUI.hud_components then
                HideHudComponentThisFrame(21) -- 21 : HUD_COMPONENTS
            end
            if config.HideDefaultUI.hud_weapons then
                HideHudComponentThisFrame(22) -- 22 : HUD_WEAPONS
            end
            if config.HideDefaultUI.ammo then
                DisplayAmmoThisFrame(false)
            end
            Wait(4)
        end
    end)
end

function DisableMouseControl()
    CreateThread(function()    
        while cursorEnabled do
            Wait(0)
            DisableControlAction(0, 0, true) -- disable V
            DisableControlAction(0, 1, true) -- disable mouse look
            DisableControlAction(0, 2, true) -- disable mouse look
            DisableControlAction(0, 3, true) -- disable mouse look
            DisableControlAction(0, 4, true) -- disable mouse look
            DisableControlAction(0, 5, true) -- disable mouse look
            DisableControlAction(0, 6, true) -- disable mouse look
            DisableControlAction(0, 199, true) -- map
            DisableControlAction(0, 200, true) -- map
            DisableControlAction(0, 75, true) -- F
            DisableControlAction(0, 200, true) -- ESC
            DisableControlAction(0, 202, true) -- BACKSPACE / ESC
            DisableControlAction(0, 177, true) -- BACKSPACE / ESC            
            HideHudComponentThisFrame(16)

        end
    end)
end

RegisterNUICallback('changeStatus', function(data, cb)
    hudSettings.currentStatus = data
    Wait(100)
    DisplayRadar(false)
    Wait(100)
    DisplayRadar(true)
    LoadRectMinimap()
    cb("ok")
end)

function LoadRectMinimap()
    dp('loadrect')
    local defaultAspectRatio = 1920/1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local statusType = tonumber(hudSettings.currentStatus)

    local aspectRatio = GetAspectRatio(0)
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)
    end
    RequestStreamedTextureDict("squaremap", false)
    if not HasStreamedTextureDictLoaded("squaremap") then
        Wait(150)
    end
    SetMinimapClipType(0)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
    -- 0.0 = nav symbol and icons left
    -- 0.1638 = nav symbol and icons stretched
    -- 0.216 = nav symbol and icons raised up
    -- SetMinimapComponentPosition("minimap", "L", "B", -0.09 + minimapOffset, -0.200, 0.3638, 0.183)
    -- icons within map
    -- -0.01 = map pulled left
    -- 0.025 = map raised up
    -- 0.262 = map stretched
    -- 0.315 = map shorten

    -- SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.197, 0.1638, 0.213) -- -0.197 oyuncunun ikonu
    -- SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.0173 + minimapOffset , -0.068, 0.308, 0.369) -- -0.068 yukarı aşağı konumlandır

    local mapX, mapY, mapWidth, mapHeight
    local maskX, maskY, maskWidth, maskHeight

    if statusType == 10 then
        mapWidth = 0.1638
        mapHeight = 0.203
        maskWidth = 0.128
        maskHeight = resolutionX > 1920 and resolutionX <= 2560 and 0.20 or 0.30

        if resolutionX > 1920 and resolutionX <= 2560 then
            mapX = -0.02 + minimapOffset
            mapY = -0.107
            maskX = 0.0 + minimapOffset
            maskY = 0.0
        else
            mapX = 0.0 + minimapOffset
            mapY = -0.137
            maskX = 0.0 + minimapOffset
            maskY = 0.0
        end
    else
        mapWidth = 0.1638
        mapHeight = resolutionX > 1920 and resolutionX <= 2560 and 0.153 or 0.213
        maskWidth = 0.128
        maskHeight = 0.20

        if resolutionX > 1920 and resolutionX <= 2560 then
            mapX = -0.02 + minimapOffset
            mapY = -0.057
            maskX = 0.0 + minimapOffset
            maskY = 0.0
        else
            mapX = 0.0 + minimapOffset
            mapY = -0.117
            maskX = 0.0 + minimapOffset
            maskY = 0.0
        end
    end

    SetMinimapComponentPosition("minimap", "L", "B", mapX, mapY, mapWidth, mapHeight)
    SetMinimapComponentPosition("minimap_mask", "L", "B", maskX, maskY, maskWidth, maskHeight)
    SetMinimapComponentPosition(
        "minimap_blur",
        "L",
        "B",
        mapX,
        mapY,
        mapWidth,
        mapHeight
    )
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetRadarBigmapEnabled(true, false)
    SetMinimapClipType(0)
    Wait(50)
    SetRadarBigmapEnabled(false, false)
end

if not config.CustomMinimap then
    CreateThread(function()
        while true do
            SetRadarZoom(1100)
            Wait(100)
        end
    end)
end

CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Citizen.InvokeNative(0xF6E48914C7A8694E, minimap, "SETUP_HEALTH_ARMOUR")
        Citizen.InvokeNative(0xC3D0841A0CC546A6, 3)
        Citizen.InvokeNative(0xC6796A8FFA375E53)
        Citizen.InvokeNative(0xC6796A8FFA375E53)
        Wait(1000)
    end
end)

CreateThread(function()
    while true do
        if IsBigmapActive() then
            SetRadarBigmapEnabled(false, false)
        end
        Wait(2000)
    end
end)

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num + 0.5 * mult)
end

local inPassengerSeat = false
CreateThread(function()
    if not config.DisableMinimapOption and not config.mapWhileWalking then
        DisplayRadar(false)
        nuiMessage('toggleMap', false)
    end
    while true do
        local pPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(pPed, false)
        -- dp('Cache Ped ->', pPed, IsPedInAnyVehicle(pPed), vehicle)
        if IsPedInAnyVehicle(pPed) then
            if not alreadyInVehicle then
                local type = GetVehicleType(vehicle)
                if not config.EnableRadio then
                    SetVehicleRadioEnabled(vehicle, false)
                    SetVehRadioStation(vehicle, "OFF")
                end

                nuiMessage('setCarType', type)

                if config.EnableSeatbelt then
                    SeatbeltControl:disable(false)
                end
                
                if GetPedInVehicleSeat(vehicle, -1) == pPed then
                    alreadyInVehicle = true 
                    inPassengerSeat = false
                    -- if config.EnableSeatbelt then
                    --     SeatbeltControl:disable(false)
                    -- end
                    CruiseControl:disable(false)
                    if config.EnableEngineControl then
                        EngineControl:disable(false)
                    end
                    nuiMessage('openSpeedo', true)
                else
                    if config.canPassengerSeeSpeedo then
                        nuiMessage('openSpeedo', true)
                    else
                        nuiMessage('openSpeedo', false)
                    end
                    inPassengerSeat = true
                end

                if hudSettings.showMiniMap then
                    nuiMessage('toggleMap', true)
                    DisplayRadar(true)
                else
                    DisplayRadar(false)
                    nuiMessage('toggleMap', false)
                end
            end
        else
            if alreadyInVehicle or inPassengerSeat then
                if not config.DisableMinimapOption and (not config.mapWhileWalking or not hudSettings.showMiniMap) then
                    DisplayRadar(false)
                    nuiMessage('toggleMap', false)
                end

                local playerSpeedo = GetPlayerSetting('speedometer')
                nuiMessage('clearSpeedoType', playerSpeedo)
                nuiMessage('openSpeedo', false)
                vehicleType = ""
                ManageMusic('destroy')
                CruiseControl:disable(true)
                if config.EnableSeatbelt then
                    SeatbeltControl:disable(true)
                end
                if config.EnableEngineControl then
                    EngineControl:disable(true)
                end
                alreadyInVehicle = false
                inPassengerSeat = false
            end
        end
        Wait(2000)
    end
end)

-- RegisterNetEvent('QBCore:Client:EnteredVehicle', function()
--     TickInterval()
-- end)

-- AddEventHandler('esx:enteredVehicle', function()
--     TickInterval()
-- end)

-- local looped = false

-- function TickInterval()
--     if looped == false then
--         looped = true
--         while true do
--             local sleep = 1000

--             local pPed = PlayerPedId()
--             local vehicle = GetVehiclePedIsIn(pPed, false)

--             if vehicle > 0 then
--                 sleep = hudSettings.speedoRefreshRate
--                 local speed = math.floor(GetEntitySpeed(vehicle) * multipleSpeed())
--                 local maxspeed = math.floor(GetVehicleEstimatedMaxSpeed(vehicle) * multipleSpeed())
--                 local heading = GetEntityHeading(pPed)
--                 local fuel = GetFuel(vehicle)
--                 local gear = GetVehicleCurrentGear(vehicle)
--                 local maxgear = GetVehicleHighGear(vehicle)
--                 local wind = GetWindSpeed()
--                 local engineHealth = GetVehicleEngineHealth(vehicle)
--                 local isDoorOpen = CheckOpenDoors(vehicle)
--                 nuiMessage('setSpeed', speed)
--                 nuiMessage("setMaxSpeed", maxspeed);
--                 nuiMessage('setGear', gear)
--                 nuiMessage('setHeading', heading)
--                 nuiMessage('setFuel', fuel)
--                 nuiMessage('setWind', wind)
--                 nuiMessage('setDoorOpen', isDoorOpen)
--                 if engineHealth < config.BrokenEngineThreshold then
--                     nuiMessage('setEngineBroken', true)
--                 else
--                     nuiMessage('setEngineBroken', false)
--                 end
--             end

--             if vehicle == 0 or not DoesEntityExist(vehicle) then
--                 looped = false
--                 break
--             end
--             Wait(sleep)
--         end
--     end
-- end

CreateThread(function ()
    while true do
        local sleep = 1000

        local pPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(pPed, false)

        if vehicle > 0 then
            sleep = hudSettings.speedoRefreshRate
            local speed = math.floor(GetEntitySpeed(vehicle) * multipleSpeed())
            local maxspeed = math.floor(GetVehicleEstimatedMaxSpeed(vehicle) * multipleSpeed())
            local heading = GetEntityHeading(pPed)
            local fuel = GetFuel(vehicle)
            local gear = GetVehicleCurrentGear(vehicle)
            local maxgear = GetVehicleHighGear(vehicle)
            local wind = GetWindSpeed()
            local engineHealth = GetVehicleEngineHealth(vehicle)
            local isDoorOpen = CheckOpenDoors(vehicle)
            nuiMessage('setSpeed', speed)
            nuiMessage("setMaxSpeed", maxspeed);
            nuiMessage('setGear', gear)
            nuiMessage('setHeading', heading)
            nuiMessage('setFuel', fuel)
            nuiMessage('setWind', wind)
            nuiMessage('setDoorOpen', isDoorOpen)
            if engineHealth < config.BrokenEngineThreshold then
                nuiMessage('setEngineBroken', true)
            else
                nuiMessage('setEngineBroken', false)
            end
        end
        
        Wait(sleep)
    end
end)

local lastZone = nil
CreateThread(function()
    while true do
        local pPed = PlayerPedId()
        local position = GetEntityCoords(pPed)
		local var1, var2 = GetStreetNameAtCoord(position.x, position.y, position.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
        local zone = GetNameOfZone(position.x, position.y, position.z);
		local zoneLabel = GetLabelText(zone);
		hash1 = GetStreetNameFromHashKey(var1);
		hash2 = GetStreetNameFromHashKey(var2);
        local street2;
		street2 = zoneLabel;
        local heading = GetEntityHeading(pPed);

        if hudSettings.compassBehaviour == "mouselook" then
            local camRot = GetGameplayCamRot(0)
			heading = tostring(round(360.0 - ((camRot.z + 360.0) % 360.0)))
        end
        for k, v in pairs(directions) do
            if (math.abs(heading - v) < 22.5) then
                heading = k;
                if (heading == 1) then
                    heading = 'N';
                    break;
                end

                break;
            end
        end
        nuiMessage('setCompassDirection', heading)
        nuiMessage('setStreet_1', hash1)
        nuiMessage('setStreet_2', street2)
        Wait(1500)
    end
end)

if config.EnableEngineControl then
    local engineRunning = true
    function ToggleEngine()
        local pPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(pPed, false)
        if not DoesEntityExist(vehicle) then  return end
        if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= pPed then return end
        if GetIsVehicleEngineRunning(vehicle) then
            notify(locale('engine_off'), "error")
        else
            notify(locale('engine_on'), "success")
        end
        engineRunning = not GetIsVehicleEngineRunning(vehicle)
        if config.ForceEngineOff then
            CreateThread(function()
                SetVehicleEngineOn(vehicle, engineRunning, false, true)

                while not engineRunning and DoesEntityExist(vehicle) do
                    SetVehicleEngineOn(vehicle, engineRunning, false, true)
                    Wait(100)
                end
            end)
        else
            SetVehicleEngineOn(vehicle, not GetIsVehicleEngineRunning(vehicle), false, true)
        end
    end

    EngineControl = lib.addKeybind({
        name = 'EngineControl',
        description = 'Toggle Engine',
        defaultKey = config.EngineKey,
        onPressed = function ()
            ToggleEngine()
        end,
    })

    RegisterCommand(config.EngineCommand, function()
        ToggleEngine()
    end)
end
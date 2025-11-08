if not rawget(_G, "lib") then include('ox_lib', 'init') end


if not lib then return end

Radar = {}

function Radar.OpenRadar()
    Radar.ToggleRadar()
end

CreateThread(function()
    while true do
        local sleep = 2000
        if Framework.Player.Loaded then
            local IsPolice        = Functions.IsPolice(Framework.Player.Job.Name)
            local vehicle         = cache.vehicle
            local class           = GetVehicleClass(vehicle)
            local isPoliceVehicle = class == 18 and true or false

            if not isPoliceVehicle and Functions.VehicleCanOpenRadar(vehicle) then
                isPoliceVehicle = true
            end

            if IsPolice and (vehicle and vehicle > 0 and isPoliceVehicle) then
                sleep = 0
                if IsControlPressed(0, Keys[config.RadarKeys.combinedkeys[1]]) and IsControlJustPressed(0, Keys[config.RadarKeys.combinedkeys[2]]) then
                    Radar.OpenRadar()
                end
            end
        end
        Wait(sleep)
    end
end)

function Radar.CloseRadar()
    SendNUIMessage({ action = 'route', data = '' })
end

RegisterCommand('closeRadar', Radar.CloseRadar)

function Radar.OpenRadarSettings()
    SetNuiFocus(true, true)
    SendNUIMessage({ action = 'route', data = 'radarSettings' })
end

RegisterNetEvent('dusa_dispatch:OpenRadarSettings', Radar.OpenRadarSettings)

function Radar.CloseRadarSettings()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'route', data = '' })
end

RegisterCommand('closeRadarSettings', Radar.CloseRadarSettings)

local function GetCamFromNum(relPos)
    if (relPos == 1) then
        return "front"
    elseif (relPos == -1) then
        return "rear"
    end
end

local directions = {
    N = 360,
    0,
    NE = 315,
    E = 270,
    SE = 225,
    S = 180,
    SW = 135,
    W = 90,
    NW = 45
}

local angles = { ["same"] = vector3(0.0, 50.0, 0.0), ["opp"] = vector3(-10.0, 50.0, 0.0) }
local frontXMIT, rearXMIT = true, true
local fwdMode, bwdMode = "same", "same"

local frontSpeedWarning = 50
local rearSpeedWarning = 50

local currentFrontVehicle, currentRearVehicle, lockedFrontVehicle, lockedRearVehicle, frontLockedSpeed, rearLockedSpeed, showFastActions, cursorEnabled, isPolVeh, isRadarOpen =
    false, false, false, false,
    false, false, false,
    false, false, false

local radarPower = true

RegisterNUICallback("radarAction", function(data, cb)
    local type = data.type
    local action = data.action
    if type == 'front_xmit' then
        frontXMIT = action
    elseif type == 'rear_xmit' then
        rearXMIT = action
    elseif type == 'lock' then
        for i = 1, -1, -2 do
            local cam = GetCamFromNum(i) -- relpos?
            if cam == "front" then
                lockedFrontVehicle = currentFrontVehicle
                frontLockedSpeed = Utils.Round(Utils.GetVehicleSpeed(lockedFrontVehicle), 0)
            elseif cam == "rear" then
                lockedRearVehicle = currentRearVehicle
                rearLockedSpeed = Utils.Round(Utils.GetVehicleSpeed(lockedRearVehicle), 0)
            end
        end
    elseif type == 'unlock' then
        local cam = GetCamFromNum(data.relPos)
        if cam == "front" then
            lockedFrontVehicle = nil
            frontLockedSpeed = nil
        elseif cam == "rear" then
            lockedRearVehicle = nil
            rearLockedSpeed = nil
        end
    elseif type == 'front_mode' then
        fwdMode = action
    elseif type == 'rear_mode' then
        bwdMode = action
    elseif type == 'speed_limit' then
        frontSpeedWarning = tonumber(action)
        speedlimit = tonumber(action)
    elseif type == 'toggle_radar' then
        radarPower = action
    end
    -- update nui

    cb("ok")
end)

local function UpdateNui()
    -- SendNUIMessage({
    --     action = "RADAR_UPDATE",
    --     data = {
    --         fwdMode            = fwdMode,
    --         bwdMode            = bwdMode,
    --         frontSpeedWarning  = speedlimit,
    --         rearSpeedWarning   = speedlimit,
    --         frontLockedSpeed   = frontLockedSpeed,
    --         rearLockedSpeed    = rearLockedSpeed,
    --         lockedFrontVehicle = lockedFrontVehicle,
    --         lockedRearVehicle  = lockedRearVehicle,
    --         radarPower         = radarPower,
    --         frontXMIT          = frontXMIT,
    --         rearXMIT           = rearXMIT,
    --     }
    -- })
end

-- Test
local function RadarLoop()
    local fPlate = ''
    local rPlate = ''
    CreateThread(function()
        while isRadarOpen do
            if radarPower then
                local Player = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(Player)
                if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == Player then
                    local vehicleSpeed = Utils.Round(Utils.GetVehicleSpeed(vehicle), 0)
                    local vehiclePos = GetEntityCoords(vehicle, true)
                    local h = Utils.Round(GetEntityHeading(vehicle), 0)
                    if frontXMIT then
                        local forwardPosition = GetOffsetFromEntityInWorldCoords(vehicle, angles[fwdMode])
                        local fwdPos = { x = forwardPosition.x, y = forwardPosition.y, z = forwardPosition.z }
                        local _, fwdZ = GetGroundZFor_3dCoord(fwdPos.x, fwdPos.y, fwdPos.z + 500.0)
                        if fwdPos.z < fwdZ and not (fwdZ > vehiclePos.z + 1.0) then
                            fwdPos.z = fwdZ + 0.5
                        end
                        local fwdVeh = Utils.GetVehicleInDirection(vehicle, vehiclePos, fwdPos)
                        fwdVeh = tonumber(fwdVeh)
                        if not DoesEntityExist(fwdVeh) then
                            fwdVeh = nil
                        end
                        if fwdVeh > 0 then
                            if (fwdVeh and fwdVeh > 0) and not lockedFrontVehicle and not DoesEntityExist(lockedFrontVehicle) then
                                if DoesEntityExist(fwdVeh) and IsEntityAVehicle(fwdVeh) then
                                    local fwdVehSpeed = Utils.Round(Utils.GetVehicleSpeed(fwdVeh), 0)
                                    local fwdVehHeading = GetEntityHeading(fwdVeh)
                                    local plate = GetVehicleNumberPlateText(fwdVeh)
                                    -- if currentFrontVehicle ~= fwdVeh then
                                    --     frontScannedVehicles = frontScannedVehicles + 1
                                    -- end
                                    currentFrontVehicle = fwdVeh
                                    local speed = frontLockedSpeed or fwdVehSpeed
                                    fPlate = plate
                                    SendNUIMessage({ action = "SET_FRONT_RADAR_PLATE", data = plate })
                                    SendNUIMessage({ action = "SET_FRONT_RADAR_SPEED", data = speed })
                                    -- nuiMessage("SET_FRONT_SCANNED_VEHICLES", frontScannedVehicles)
                                    if frontSpeedWarning and speed > frontSpeedWarning then
                                        PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                                    end
                                else
                                    if fPlate ~= '' then
                                        SendNUIMessage({ action = "SET_FRONT_RADAR_PLATE", data = '' })
                                        fPlate = ''
                                    end
                                end
                            else
                                if IsEntityAVehicle(lockedFrontVehicle) then
                                    local fwdVehSpeed = Utils.Round(Utils.GetVehicleSpeed(lockedFrontVehicle), 0)
                                    local fwdVehHeading = GetEntityHeading(lockedFrontVehicle)
                                    local plate = GetVehicleNumberPlateText(lockedFrontVehicle)

                                    currentFrontVehicle = lockedFrontVehicle
                                    local speed = frontLockedSpeed or fwdVehSpeed
                                    SendNUIMessage({ action = "SET_FRONT_RADAR_PLATE", data = plate })
                                    SendNUIMessage({ action = "SET_FRONT_RADAR_SPEED", data = speed })
                                    warn(frontSpeedWarning, speed, frontSpeedWarning)

                                    if frontSpeedWarning and speed > frontSpeedWarning then
                                        PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                                    end
                                end
                            end
                        end
                    end
                    if rearXMIT then
                        local backwardPosition = GetOffsetFromEntityInWorldCoords(vehicle, angles[bwdMode].x,
                            -angles[bwdMode].y, angles[bwdMode].z)
                        local bwdPos = { x = backwardPosition.x, y = backwardPosition.y, z = backwardPosition.z }
                        local _, bwdZ = GetGroundZFor_3dCoord(bwdPos.x, bwdPos.y, bwdPos.z + 500.0)
                        if bwdPos.z < bwdZ and not (bwdZ > vehiclePos.z + 1.0) then
                            bwdPos.z = bwdZ + 0.5
                        end
                        local bwdVeh = Utils.GetVehicleInDirection(vehicle, vehiclePos, bwdPos)
                        bwdVeh = tonumber(bwdVeh)
                        if bwdVeh > 0 then
                            if not lockedRearVehicle and not DoesEntityExist(lockedRearVehicle) then
                                if (bwdVeh and bwdVeh > 0) and DoesEntityExist(bwdVeh) and IsEntityAVehicle(bwdVeh) then
                                    local bwdVehSpeed = Utils.Round(Utils.GetVehicleSpeed(bwdVeh), 0)
                                    local bwdVehHeading = GetEntityHeading(bwdVeh)
                                    local plate = GetVehicleNumberPlateText(bwdVeh)
                                    -- if currentRearVehicle ~= bwdVeh then
                                    --     rearScannedVehicles = rearScannedVehicles + 1
                                    -- end
                                    currentRearVehicle = bwdVeh
                                    local speed = rearLockedSpeed or bwdVehSpeed
                                    rPlate = plate
                                    SendNUIMessage({ action = "SET_REAR_RADAR_PLATE", data = plate })
                                    SendNUIMessage({ action = "SET_REAR_RADAR_SPEED", data = speed })
                                    -- nuiMessage("SET_REAR_SCANNED_VEHICLES", rearScannedVehicles)

                                    if rearSpeedWarning and speed > rearSpeedWarning then
                                        PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                                    end
                                else
                                    if rPlate ~= '' then
                                        SendNUIMessage({ action = "SET_REAR_RADAR_PLATE", data = '' })
                                        rPlate = ''
                                    end
                                end
                            else
                                if IsEntityAVehicle(lockedRearVehicle) then
                                    local bwdVehSpeed = Utils.Round(Utils.GetVehicleSpeed(lockedRearVehicle), 0)
                                    local bwdVehHeading = GetEntityHeading(lockedRearVehicle)
                                    local plate = GetVehicleNumberPlateText(lockedRearVehicle)
                                    currentRearVehicle = lockedRearVehicle
                                    SendNUIMessage({ action = "SET_REAR_RADAR_PLATE", data = plate })
                                    local speed = rearLockedSpeed or bwdVehSpeed

                                    SendNUIMessage({ action = "SET_REAR_RADAR_SPEED", data = speed })
                                    if rearSpeedWarning and speed > rearSpeedWarning then
                                        PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
                                    end
                                end
                            end
                        end
                    end
                    SendNUIMessage({ action = "SET_PATROL_SPEED", data = vehicleSpeed })
                end
            end
            Wait(200)
        end
    end)
end

function Radar.ToggleRadar()
    local IsPolice = Functions.IsPolice(Framework.Player.Job.Name)
    isRadarOpen    = not isRadarOpen
    if isRadarOpen and IsPolice then
        SendNUIMessage({ action = "route", data = 'radar' })
        UpdateNui()
        RadarLoop()
    else
        SendNUIMessage({ action = "route", data = '' })
        -- Ensure NUI closes
        SetNuiFocus(false, false)
        UpdateNui()
    end
end

RegisterNetEvent('dusa_dispatch:ToggleRadar', Radar.ToggleRadar)

CreateThread(function()
    while true do
        local veh = cache.vehicle
        local class = GetVehicleClass(veh)
        isPolVeh = class == 18 and true or false

        if not isPolVeh and Functions.VehicleCanOpenRadar(veh) then
            isPolVeh = true
        end


        if not isPolVeh and isRadarOpen then
            isRadarOpen = false
            SendNUIMessage({ action = "route", data = '' })
        end
        Wait(2000)
    end
end)

return Radar

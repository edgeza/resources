--================================================================================================
--==            --    XenKnighT --        https://discord.gg/XUck63E                            ==
--================================================================================================
-- Credits to txAdmin for the list.
local isCarSpawned = false
VehClassNamesEnum = {
    [8] = "bike",
    [11] = "trailer",
    [13] = "bike",
    [14] = "boat",
    [15] = "heli",
    [16] = "plane",
    [21] = "train",
}

MismatchedTypes = {
    [`airtug`] = "automobile", -- trailer
    [`avisa`] = "submarine", -- boat
    [`blimp`] = "heli", -- plane
    [`blimp2`] = "heli", -- plane
    [`blimp3`] = "heli", -- plane
    [`caddy`] = "automobile", -- trailer
    [`caddy2`] = "automobile", -- trailer
    [`caddy3`] = "automobile", -- trailer
    [`chimera`] = "automobile", -- bike
    [`docktug`] = "automobile", -- trailer
    [`forklift`] = "automobile", -- trailer
    [`kosatka`] = "submarine", -- boat
    [`mower`] = "automobile", -- trailer
    [`policeb`] = "bike", -- automobile
    [`ripley`] = "automobile", -- trailer
    [`rrocket`] = "automobile", -- bike
    [`sadler`] = "automobile", -- trailer
    [`sadler2`] = "automobile", -- trailer
    [`scrap`] = "automobile", -- trailer
    [`slamtruck`] = "automobile", -- trailer
    [`Stryder`] = "automobile", -- bike
    [`submersible`] = "submarine", -- boat
    [`submersible2`] = "submarine", -- boat
    [`thruster`] = "heli", -- automobile
    [`towtruck`] = "automobile", -- trailer
    [`towtruck2`] = "automobile", -- trailer
    [`tractor`] = "automobile", -- trailer
    [`tractor2`] = "automobile", -- trailer
    [`tractor3`] = "automobile", -- trailer
    [`trailersmall2`] = "trailer", -- automobile
    [`utillitruck`] = "automobile", -- trailer
    [`utillitruck2`] = "automobile", -- trailer
    [`utillitruck3`] = "automobile", -- trailer
}


--- GKSPHONE VALET APP (client) ---
-- Made by GKSHOP  | https://discord.gg/XUck63E
-- Version: 2.0.0

local function LoadModel(model)
    model = type(model) == "number" and model or joaat(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    return model
end

local function BringCar(netId, vehicleData, pos, plate)
    Debugprint('BringCar Test', {netId, vehicleData, pos})
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local model = LoadModel(tonumber(vehicleData.hash))
    local createVeh = VehicleCreate(model, pos, vehicleData)
    if Config.JGGarages then
        TriggerServerEvent("jg-advancedgarages:server:register-vehicle-outside", plate, VehToNet(createVeh))
    elseif Config.loafGarages then
        if not DoesEntityExist(createVeh) then
            return
        end
        local vehState = Entity(createVeh)
        vehState.state:set('plate', plate, true)
    end
    SetVehicleNeedsToBeHotwired(createVeh, false)
    SetVehRadioStation(createVeh, "OFF")
    SetVehicleEngineOn(createVeh, true, true, true)

    local carBlip = AddBlipForEntity(createVeh)
    SetBlipSprite(carBlip, 225)--Blip Spawning.
    SetBlipFlashes(carBlip, true)
    SetBlipColour(carBlip, 0)
    SetBlipFlashes(carBlip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Valet")
    EndTextCommandSetBlipName(carBlip)

    if Config.ValeNPC then
        local valeNPCModel = LoadModel(Config.ValeNPCModel)
        local ValePed = CreatePedInsideVehicle(createVeh, 5, valeNPCModel, -1, true, false)
        Wait(1000)
        SetDriverAbility(ValePed, 1.0)
        SetDriverAggressiveness(ValePed, 0.0)
        TaskVehicleDriveToCoordLongrange(ValePed, createVeh, playerCoords.x + 5.0, playerCoords.y + 5.0, playerCoords.z, 15.0, 39, 7.0)
        while true do
            local pedCoords = GetEntityCoords(ValePed)
            local distance = #(playerCoords - pedCoords)
            if distance > 200.0 then
                SetPedCoordsKeepVehicle(ValePed, playerCoords.x + 5.0, playerCoords.y + 5.0, playerCoords.z)
            end
            if GetScriptTaskStatus(ValePed, 567490903) == 7 then
                TaskLeaveVehicle(ValePed, createVeh, 0)
                Wait(1000)
                TaskWanderStandard(ValePed, 10.0, 10)
                Wait(10000)
                DeleteEntity(ValePed)
                RemoveBlip(carBlip)
                break
            end
            if GetPedInVehicleSeat(createVeh, -1) == 0 then
                DeleteEntity(ValePed)
                RemoveBlip(carBlip)
                break
            end
            Wait(250)
        end
    else
        Wait(5000)
        RemoveBlip(carBlip)
    end
    isCarSpawned = false
end

function WaitTaskToEnd(ped, task)
	while GetScriptTaskStatus(ped, task) == 0 do
		Wait(250)
	end
	while GetScriptTaskStatus(ped, task) == 1 do
		Wait(250)
	end
end

RegisterNUICallback('gksphone:vale:getVehicles', function(data, cb)
    Debugprint('gksphone:vale:getVehicles', data)
    CallBackServerTrigger('gksphone:server:vale:getVehicles', function(vehicles)
        Debugprint('gksphone:server:vale:getVehicles', vehicles)
        if vehicles then
            for i = 1, #vehicles do
                local hash = vehicles[i].hash
                vehicles[i].speed = math.floor(GetVehicleModelEstimatedMaxSpeed(hash) * 3.6)
                if vehicles[i].name == nil then
                    local carModel = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                    if carModel == "NULL" then
                        carModel = string.upper(GetDisplayNameFromVehicleModel(hash))
                    end
                    vehicles[i].name = carModel
                    vehicles[i].model = string.lower(GetDisplayNameFromVehicleModel(hash))
                end
            end
        end
        cb(vehicles)
    end, data.app)
end)

RegisterNUICallback('gksphone:vale:track', function(data, cb)
    Debugprint('Car Point', data)
    CallBackServerTrigger('gksphone:server:vale:vehichlepoint', function(status, vehicleCoords)
        Debugprint('Car Point', {status, vehicleCoords})
        if status then
            SetNewWaypoint(vehicleCoords.x, vehicleCoords.y)
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_MARKED"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            -- Trigger the notification using the gksphone exports
            exports["gksphone"]:Notification(notify)
        else
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_TRACK_CARGARAGE"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            -- Trigger the notification using the gksphone exports
            exports["gksphone"]:Notification(notify)
        end
    end, data.plate)
    cb('ok')
end)

RegisterNUICallback('gksphone:vale:bring', function(data, cb)
    Debugprint('Car Spawn', data.plate, data.model, isCarSpawned)
    if isCarSpawned then return end
    isCarSpawned = true
    local blacklistCheck = false
    local model = type(data.model) == "string" and joaat(data.model) or data.model

    local modelType
    if MismatchedTypes[model] then
        modelType = MismatchedTypes[model]
    else
        local modelClassNumber = GetVehicleClassFromName(model)
        modelType = VehClassNamesEnum[modelClassNumber] or "automobile"
    end

    if Config.ValeBlaclistCars then
        for k, v in pairs(Config.ValeBlaclistCars) do
            if v then
                local blacklistModel = type(v) == "string" and GetHashKey(v) or v
                if model == blacklistModel then
                    blacklistCheck = true
                    break
                end
            end
        end
    end

    if blacklistCheck then
        local notify = {
            title = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
            message = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_CARBLACKLIST"), -- The message of the notification
            icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
        }
        exports["gksphone"]:Notification(notify)
        isCarSpawned = false
        return
    end

    local coords = GetEntityCoords(PlayerPedId())
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(coords.x + math.random(-Config.ValespawnRadius, Config.ValespawnRadius), coords.y + math.random(-Config.ValespawnRadius, Config.ValespawnRadius), coords.z, 0, 3, 0)
    local coordinates = {x = spawnPos.x, y = spawnPos.y, z = spawnPos.z, spawnHeading}
    CallBackServerTrigger('gksphone:server:vale:vehiclebring', function(netId, vehicleData)
        Debugprint('Car Spawn2', {netId, vehicleData})
        if netId == "nomoney" then
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_NOMONEY"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "carnotfound" then
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_CARNOTFOUND"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "carimpounded" then
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_CARIMPOUNDED"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "carnotingarage" then
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_NOTINGARAGE"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "carout" then
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_ERROR_BRING_CAROUTSIDE"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
        elseif netId == "spawned" then
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "ValeAPP.APP_VALE_SUCESS_BRING"), -- The message of the notification
                icon = "/html/img/icons/vale.png", -- The icon to be displayed with the notification
                duration = 20000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:Notification(notify)
            BringCar(netId, vehicleData, coordinates, data.plate)
        end
        isCarSpawned = false
    end, data.plate, coordinates, modelType)
    cb('ok')
end)


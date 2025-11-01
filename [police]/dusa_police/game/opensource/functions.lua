Functions = {}
Keybind = {}

if not rawget(_G, "lib") then include('ox_lib', 'init') end

Functions.IsLEO = function(job)
    for _, v in pairs(Config.PoliceJobs) do
        if v == job then
            return true
        end
    end
    return false
end

Functions.IsEMS = function(job)
    if job == 'ambulance'
        or job == 'doctor'
        or job == 'ems' then
        return true
    end
    return false
end

Functions.IsAuth = function(jobGrade)
    if jobGrade >= Config.AuthRank then
        return true
    end
    return false
end

Functions.Callsign = function()
    local callsign, _image = lib.callback.await('police:server:getOfficerProperties', false)
    -- if you using external callsign script, set it from here
    if not callsign then callsign = 'NO-SIGN' end
    return callsign
end

Functions.SetCallsign = function(callsign)
    
end

Functions.OnPlayerDeath = function()
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    onJobMenu = false
    TriggerEvent('police:handler:closeUI')
    sendK9()
    SendNUIMessage({
        action = "CLOSE_UI",
        data = {}
    })
end

Functions.GetJobSalary = function(job, grade)
    local job_data = Framework.GetJob(job)
    for k, v in pairs(job_data.grades) do
        if tostring(k) == tostring(grade) then
            return v.payment
        end
    end
end

-- NPC CREATION
function Functions.randomFromTable(t)
    local index = math.random(1, #t)
    return t[index], index
end

local scenarios = {
    'WORLD_HUMAN_AA_COFFEE',
    'WORLD_HUMAN_AA_SMOKE',
    'WORLD_HUMAN_SMOKING'
}

Functions.createPed = function(coords, model, options)
    local ped, id

    lib.points.new({
        coords = coords.xyz,
        distance = 20.0,
        debugPoly = true,
        onEnter = function()
            lib.requestModel(model)
            ped = CreatePed(4, model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
            SetEntityAlpha(ped, 0, false)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskStartScenarioInPlace(ped, Functions.randomFromTable(scenarios))

            -- Fade in ped model
            for i = 0, 255, 51 do
                SetEntityAlpha(ped, i, false)
                Wait(50)
            end
            SetEntityAlpha(ped, 255, false)
            if options then
                if #options == 0 then options = { options } end
                Target.AddEntity(ped, options)
            end
        end,
        onExit = function()
            if DoesEntityExist(ped) then
                for i = 255, 0, -51 do
                    SetEntityAlpha(ped, i, false)
                    Wait(50)
                end
            end
            DeleteEntity(ped)
            SetModelAsNoLongerNeeded(model)
            ped = nil

            if id then
                id = nil
            end
        end
    })
end

Functions.GetGpsColor = function(job)
    for k, v in pairs(Config.BlipColors) do
        if k == job then
            return v
        end
    end
    return 3
end

Functions.GetCurrentTime = function()
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    _, _, _, hours, minutes = GetLocalTime()


    if hours < 10 then
        hours = '0' .. hours
    end
    if minutes < 10 then
        minutes = '0' .. minutes
    end

    local formattedText = hours .. ':' .. minutes

    return formattedText
end

Functions.GetStreetAndZone = function(coords)
    local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    return street .. ", " .. zone
end

Functions.WearClothes = function(data)
    if data.code == 'default' then
        WearCivilAppearance()
        RemoveClothingProps()
        return
    end

    StoreCivilAppearance()
    RemoveClothingProps()

    local gender = Framework.Player.Gender == 'm' and 'male' or 'female'
    if data[gender] and data[gender].clothing and next(data[gender].clothing) then
        for _, clothing in pairs(data[gender].clothing) do
            SetPedComponentVariation(cache.ped, clothing.component, clothing.drawable, clothing.texture, 0)
        end
    end
    if data[gender] and data[gender].props and next(data[gender].props) then
        for _, prop in pairs(data[gender].props) do
            SetPedPropIndex(cache.ped, prop.component, prop.drawable, prop.texture, true)
        end
    end
end

-- THIS FUNCTION IS SERVER SIDED!
Functions.SetVehicleKey = function(source, vehicle, plate)
    local model = GetEntityModel(vehicle)

    if GetResourceState('dusa_vehiclekeys') == 'started' then
        exports["dusa_vehiclekeys"]:GiveKeys(source, plate)
    elseif GetResourceState('wasabi_carlock') == 'started' then
        exports.wasabi_carlock:GiveKey(source, plate)
    elseif GetResourceState('qb-vehiclekeys') == 'started' then
        exports['qb-vehiclekeys']:GiveKeys(source, plate)
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        exports['qs-vehiclekeys']:GiveServerKeys(source, plate, model)
    elseif GetResourceState('vehicles_keys') == 'started' then
        exports["vehicles_keys"]:giveVehicleKeysToPlayerId(source, plate)
    elseif GetResourceState('ak47_vehiclekeys') == 'started' then
        exports['ak47_vehiclekeys']:GiveKey(source, plate, false)
    end
end

Functions.RemoveVehicleKey = function(source, vehicle, plate)
    -- Integrate yours here ( for key system who using key as item )
end

t = function(table)
    local context = IsDuplicityVersion() and 'server' or 'client'
    if context == 'server' then
        TriggerClientEvent('table', -1, table)
    else
        TriggerEvent('table', table)
    end
end

-- cr: https://github.com/Qbox-project/qbx_core/blob/6d5c98e868c3273925ffec2fa431ad4e80213749/modules/lib.lua#L95
function Functions.SpawnVehicle(params)
    local model = params.model
    local source = params.spawnSource
    local sourceType = type(source)
    local warp = params.warp
    local ped = type(warp) == 'number' and warp or (sourceType == 'number' and warp and source or nil)
    local props = params.props
    -- local bucket = params.bucket or ped and GetEntityRoutingBucket(ped) or nil

    ---@type vector4
    local coords
    if sourceType == 'vector3' then
        coords = vec4(source.x, source.y, source.z, 0)
    elseif sourceType == 'vector4' then
        coords = source
    else
        local pedCoords = GetEntityCoords(source)
        coords = vec4(pedCoords.x, pedCoords.y, pedCoords.z, GetEntityHeading(source))
    end

    local tempVehicle = CreateVehicle(model, 0, 0, -200, 0, true, true)
    while not DoesEntityExist(tempVehicle) do Wait(0) end

    local vehicleType = GetVehicleType(tempVehicle)
    DeleteEntity(tempVehicle)

    local veh = CreateVehicleServerSetter(model, vehicleType, coords.x, coords.y, coords.z, coords.w)
    while not DoesEntityExist(veh) do Wait(0) end
    while GetVehicleNumberPlateText(veh) == '' do Wait(0) end

    -- if bucket and bucket > 0 then
    --     exports.qbx_core:SetEntityBucket(veh, bucket)
    -- end

    if ped then
        SetPedIntoVehicle(ped, veh, -1)
    end

    if not pcall(function()
            lib.waitFor(function()
                local owner = NetworkGetEntityOwner(veh)
                if ped then
                    --- the owner should be transferred to the driver
                    if owner == NetworkGetEntityOwner(ped) then return true end
                else
                    if owner ~= -1 then return true end
                end
            end, 'client never set as owner', 5000)
        end) then
        DeleteEntity(veh)
        error('Deleting vehicle which timed out finding an owner')
    end

    local state = Entity(veh).state
    state:set('initVehicle', true, true)

    if params.plate then
        SetVehicleNumberPlateText(veh, params.plate)
    end

    if props and type(props) == 'table' and props.plate then
        state:set('setVehicleProperties', props, true)
        if not pcall(function()
                lib.waitFor(function()
                    if Framework.Trim(GetVehicleNumberPlateText(veh)) == Framework.Trim(props.plate) then
                        return true
                    end
                end, 'Failed to set vehicle properties within 5 seconds', 5000)
            end) then
            DeleteEntity(veh)
            error('Deleting vehicle which timed out setting vehicle properties')
        end
    end

    local netId = NetworkGetNetworkIdFromEntity(veh)
    Entity(veh).state:set('persisted', true, true)
    return netId, veh
end

function Functions.playAudio(params)
    local audioName = params.audioName
    local audioRef = params.audioRef
    local returnSoundId = params.returnSoundId or false
    local source = params.audioSource
    local range = params.range or 5.0

    local soundId = GetSoundId()

    local sourceType = type(source)
    if sourceType == 'vector3' then
        local coords = source
        PlaySoundFromCoord(soundId, audioName, coords.x, coords.y, coords.z, audioRef, false, range, false)
    elseif sourceType == 'number' then
        PlaySoundFromEntity(soundId, audioName, source, audioRef, false, false)
    else
        PlaySoundFrontend(soundId, audioName, audioRef, true)
    end

    if returnSoundId then
        return soundId
    end

    ReleaseSoundId(soundId)
end

function createPlate()
    string = lib.string
    local plate = string.random('.1111', 4)
    plate = 'LEO' .. plate

    return plate
end
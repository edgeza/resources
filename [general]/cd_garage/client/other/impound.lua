RegisterNUICallback('impoundclose', function(data, cb)
    NUI_status = false
    GarageInfo = nil
    JobSpawn = false
    JobSpawn_Owned = false
    InProperty = false
    GangGarage = false
    ClearPedTasks(PlayerPedId())
    cb('ok')
end)

if not Config.Impound.ENABLE then return end

TriggerEvent('chat:addSuggestion', '/'..Config.Impound.chat_command, L('chatsuggestion_impound'))
RegisterCommand(Config.Impound.chat_command, function()
    if IsAllowed_Impound() then
        TriggerEvent('cd_garage:ImpoundVehicle')
    else
        Notif(3, 'no_permissions_impounding')
    end
end, false)

for c, d in pairs (Config.ImpoundLocations) do
    local blip = AddBlipForCoord(d.coords.x, d.coords.y, d.coords.z)
    SetBlipSprite (blip, d.blip.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, d.blip.scale)
    SetBlipColour (blip, d.blip.colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(d.blip.name)
    EndTextCommandSetBlipName(blip)
end

RegisterNetEvent('cd_garage:ImpoundVehicle:Direct')
AddEventHandler('cd_garage:ImpoundVehicle:Direct', function(data)
    local label = GetVehiclesData(data.props.model).name
    local adv_stats = GetAdvStats(data.plate, false)

    data.time = nil
    if not data.release_time then
        data.release_time = os.time() + 3600000
        print('cd_garage:ImpoundVehicle:Direct - release_time is nil, defaulting to 1 hour')
    end

    TriggerServerEvent('cd_garage:ImpoundVehicle', data.plate, data.impound, label, data.props, adv_stats, data.release_time, data.description, data.canretrive)
end)

function GetImpoundName(impound)
    for c, d in pairs (Config.ImpoundLocations) do
        if d.ImpoundID == impound then
            return d.blip.name
        end
    end
end

function CheckCorrectImpound(garage_type, impound)
    if string.find(impound, 'air') then
        if garage_type == 'air' then
            return true
        else
            return false
        end
    elseif string.find(impound, 'boat') then
        if garage_type == 'boat' then
            return true
        else
            return false
        end
    elseif string.find(impound, 'car') then
        if garage_type == 'car' then
            return true
        else
            return false
        end
    else
        return false
    end
end

function HideImpound_UI()
    NUI_status = false
    SendNUIMessage({action = 'hideimpound'})
end

function GetImpoundSpawnPoint(impoundId)
    for c, d in pairs (Config.ImpoundLocations) do
        if d.ImpoundID == impoundId then
            return d.spawnpoint
        end
    end
end

RegisterNetEvent('cd_garage:ImpoundVehicle')
AddEventHandler('cd_garage:ImpoundVehicle', function(chosen_vehicle)
    local ped = PlayerPedId()
    local vehicle
    if chosen_vehicle ~= nil and type(chosen_vehicle) == 'number' and DoesEntityExist(chosen_vehicle) then
        vehicle = chosen_vehicle
    else
        vehicle = GetClosestVehicle(5)
    end
    if not IsPedInAnyVehicle(ped, false) then
        if vehicle then
            if IsVehicleEmpty(vehicle) then
                TaskTurnPedToFaceEntity(ped, vehicle, 1000)
                Wait(1000)
                TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
                local garage_type = GetGarageType(vehicle)
                local impoundLocations = {}
                for c, d in pairs (Config.ImpoundLocations) do
                    if string.find(c, garage_type) then
                        impoundLocations[#impoundLocations+1] = {impound = c, name = d.blip.name, vehicle = vehicle}
                    end
                end
                SendNUIMessage({action = 'chooseimpound', values = impoundLocations})
                TriggerEvent('cd_garage:ToggleNUIFocus')
            else
                Notif(3, 'impound_vehicle_not_empty')
            end
        else
            Notif(3, 'no_vehicle_found')
        end
    else
        Notif(3, 'get_out_veh')
    end
end)

RegisterNUICallback('impoundchosen', function(data, cb)
    NUI_status = false
    local ped = PlayerPedId()
    local vehicle = tonumber(data.vehicle)
    local plate = GetPlate(vehicle)
    if not plate then
        NUI_status = false
        ClearPedTasks(ped)
        cb('ok')
        return
    end

    if not IsVehicleEmpty(vehicle) then
        Notif(3, 'impound_vehicle_not_empty')
        return
    end

    if not CheckCorrectImpound(GetGarageType(vehicle), data.impound) then
        Notif(3, 'wrong_garage_type')
        return
    end

    local impoundId = Config.ImpoundLocations[data.impound].ImpoundID
    local adv_stats = GetAdvStats(plate, false)
    local props = GetVehicleProperties(vehicle)
    local label = GetVehiclesData(props.model).name
    TriggerServerEvent('cd_garage:ImpoundVehicle', plate, impoundId, label, props, adv_stats, data.release_time, data.description, data.canretrieve)
    CD_DeleteVehicle(vehicle)
    ClearPedTasks(ped)
    cb('ok')
end)

RegisterNUICallback('impoundcreate', function(data, cb)
    NUI_status = false
    FakePlate = data.plate
    cb('ok')
end)

RegisterNetEvent('cd_garage:OpenImpound')
AddEventHandler('cd_garage:OpenImpound', function(impoundId)
    OpenImpound(impoundId)
end)

function OpenImpound(impoundId)
    local isAllowed = IsAllowed_Impound()
    local impoundData

    ExitLocation = GetImpoundSpawnPoint(impoundId)

    if isAllowed then
        impoundData = Callback('getallimpounddata', impoundId)
    else
        impoundData = Callback('getimpounddata', impoundId)
    end
    for c, d in pairs(impoundData) do
        d.canretrieve = d.canretrive
        d.canretrive = nil
    end

    SendNUIMessage({action = 'showimpound', values = impoundData, is_allowed = isAllowed})
    if #impoundData > 0 then
        TriggerEvent('cd_garage:ToggleNUIFocus')
    end
end

RegisterNUICallback('impoundspawn', function(data, cb)
    local veh = data.values
    local isAllowed = IsAllowed_Impound()
    local canRetrive, reason = Callback('cancivretrivevehicle', veh.plate, veh.price)

    if isAllowed or canRetrive then
        TriggerServerEvent('cd_garage:UnImpoundVehicle', veh.plate, veh.label)
        SpawnVehicle({plate = veh.plate, vehicle = veh.props, adv_stats = veh.adv_stats}, false, false, true)
        NUI_status = false
        cb('ok')
    elseif not canRetrive then
        cb(reason)
    end
end)

RegisterNUICallback('impoundreturn', function(data, cb)
    local isAllowed = IsAllowed_Impound()
    local canRetrive, reason = Callback('cancivretrivevehicle', data.plate, data.price)

    if isAllowed or canRetrive then
        TriggerServerEvent('cd_garage:UnImpoundVehicle', data.plate, data.label)
        cb('ok')
    elseif not canRetrive then
        cb(reason)
    end
end)

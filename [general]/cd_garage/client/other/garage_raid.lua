if not Config.GarageRaid.ENABLE then return end

function HasGarageRaidingPerms()
    local job = GetJob().name
    local jobGrade = GetJob_grade()
    for c, d in pairs(Config.GarageRaid.required_perms) do
        if job == c and jobGrade >= d then
            return true
        end
    end
    return false
end

function GetConfigLocationDataFromGarageId(garageId)
    for c, d in pairs(Config.Locations) do
        if d.Garage_ID == garageId then
            return {x = d.x_2, y = d.y_2, z = d.z_2, h = d.h_2}
        end
    end
    return nil
end

RegisterNetEvent('cd_garage:GarageRaid', function(garageId)
    if not HasGarageRaidingPerms() then return end
    SendNUIMessage({
        action = 'opengarageraid',
        data = garageId
    })
    TriggerEvent('cd_garage:ToggleNUIFocus')
end)

RegisterNuiCallback('startgarageraid', function(data, cb)
    local vehicle = Callback('search_vehicle_in_garage', data.garageId, data.plate)
    if not vehicle then cb(nil) return end
    if vehicle.label == nil then
        vehicle.label = GetVehicleLabel_model(vehicle.vehicle.model)
    end
    vehicle.spawnName = GetDisplayNameFromVehicleModel(vehicle.vehicle.model):lower()
    cb(vehicle)
end)

RegisterNuiCallback('completegarageraid', function(data, cb)
    if not Config.Impound.ENABLE or data.impound == 0 then
        data.vehicle = data.props
        local streetscheck = VehicleChecks('checkveh_onstreets', data.plate, data.in_garage, data.vehicle.model)
        if streetscheck.result == 'onstreets' then
            cb(streetscheck.message)
        elseif streetscheck.result == 'outbutnotonstreets' or streetscheck.result == 'canspawn' then
            ExitLocation = GetConfigLocationDataFromGarageId(data.garage_id)
            local vehicle = SpawnVehicle(data, false, false, false)
            TriggerEvent('cd_garage:SetVehicleLocked', vehicle)
            NUI_status = false
            cb('ok')
        end
    else
        cb(L('vehicle_is_in_the')..' <b>'..VehicleChecks('get_impoundname', data.impound)..'</b>')
    end
end)
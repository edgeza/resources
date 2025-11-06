function GetVehicleModelString(source, plate, model)
    if model then
        return Callback(source, 'getmodelstring', model)
    end

    local allVehicles = GetAllVehicles()
    local vehicleModelString = nil
    for cd = 1, #allVehicles, 1 do
        local vehicle = allVehicles[cd]
        if DoesEntityExist(vehicle) then
            local plate2 = GetCorrectPlateFormat(GetVehicleNumberPlateText(vehicle))
            if plate == plate2 then
                local model = GetEntityModel(vehicle)
                vehicleModelString = Callback(source, 'getmodelstring', model)
            end
        end
    end

    if not vehicleModelString then
        local Result = DatabaseQuery('SELECT '..FW.vehicle_props..' FROM '..FW.vehicle_table..' WHERE plate="'..plate..'"')
        if Result and Result[1] then
            local props = json.decode(Result[1][FW.vehicle_props])
            local model = props.model
            if model then
                vehicleModelString = Callback(source, 'getmodelstring', model)
            end
        end
    end
    return vehicleModelString
end

function GetVehicleLabel(source, plate, model)
    if model then
        return Callback(source, 'getvehiclelabel', model)
    end

    local allVehicles = GetAllVehicles()
    local vehicleLabel = nil
    for cd = 1, #allVehicles, 1 do
        local vehicle = allVehicles[cd]
        if DoesEntityExist(vehicle) then
            local plate2 = GetCorrectPlateFormat(GetVehicleNumberPlateText(vehicle))
            if plate == plate2 then
                local model = GetEntityModel(vehicle)
                vehicleLabel = Callback(source, 'getvehiclelabel', model)
            end
        end
    end

    if not vehicleLabel then
        local Result = DatabaseQuery('SELECT '..FW.vehicle_props..' FROM '..FW.vehicle_table..' WHERE plate="'..plate..'"')
        if Result and Result[1] then
            local props = json.decode(Result[1][FW.vehicle_props])
            local model = props.model
            if model then
                vehicleLabel = Callback(source, 'getvehiclelabel', model)
            end
        end
    end
    return vehicleLabel
end

function GetVehicleData(source, plate, model)
    if model then
        return Callback(source, 'getvehicledata', model)
    end

    local allVehicles = GetAllVehicles()
    local vehicleData = nil
    for cd = 1, #allVehicles, 1 do
        local vehicle = allVehicles[cd]
        if DoesEntityExist(vehicle) then
            local plate2 = GetCorrectPlateFormat(GetVehicleNumberPlateText(vehicle))
            if plate == plate2 then
                local model = GetEntityModel(vehicle)
                vehicleData = Callback(source, 'getvehicledata', model)
            end
        end
    end

    if not vehicleData then
        if Config.FakePlates.ENABLE then
            plate = GetOriginalPlateFromFakePlate(plate)
        end
        local Result = DatabaseQuery('SELECT '..FW.vehicle_props..' FROM '..FW.vehicle_table..' WHERE plate="'..plate..'"')
        if Result and Result[1] then
            local props = json.decode(Result[1][FW.vehicle_props])
            local model = props.model
            if model then
                vehicleData = Callback(source, 'getvehicledata', model)
            end
        end
    end
    return vehicleData
end

function IsPedInVehicle(source)
    local ped = GetPlayerPed(source)
    local inVehicle = GetVehiclePedIsIn(ped, false)
    if inVehicle then
        return true
    else
        return false
    end
end

function GetClosestVehicle(source, distance)
    local ped = GetPlayerPed(source)
    if IsPedInVehicle(source) then
        return GetVehiclePedIsIn(ped, false)
    else
        local result = false
        local ped_coords = GetEntityCoords(ped)
        local smallest_distance = 1000
        local vehicle = GetAllVehicles()
        for cd = 1, #vehicle, 1 do
            local vehcoords = GetEntityCoords(vehicle[cd])
            local dist = #(ped_coords-vehcoords)
            if dist < distance and dist < smallest_distance then
                smallest_distance = dist
                result = vehicle[cd]
            end
        end
        return result
    end
end

function HasVehicleAlreadySpawned(plate, persistant)
    local result = DatabaseQuery('UPDATE '..FW.vehicle_table..' SET in_garage = 0 WHERE in_garage = 1 AND plate = "'..plate..'";')
    if (result and result.affectedRows == 1) or persistant then
        return false
    else
        return true
    end
end
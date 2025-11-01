-- QBX Vehicle Keys Integration Helper
-- This file provides helper functions to integrate both qbx_vehiclekeys and dusa_vehiclekeys

local VehicleKeysIntegration = {}

--- Gives vehicle keys to a player through all available vehicle key systems
--- @param source number - Player ID
--- @param plate string - Vehicle plate
--- @param vehicle? number - Vehicle entity (optional, for qbx_vehiclekeys)
function VehicleKeysIntegration.GiveKeys(source, plate, vehicle)
    if not source or not plate then
        print("^3[QBX Vehicle Keys Integration] ^1ERROR: Missing source or plate parameter^0")
        return false
    end

    local success = false

    -- Give keys through qbx_vehiclekeys
    if GetResourceState('qbx_vehiclekeys') == 'started' then
        if vehicle and DoesEntityExist(vehicle) then
            exports.qbx_vehiclekeys:GiveKeys(source, vehicle)
            success = true
        else
            TriggerClientEvent('vehiclekeys:client:SetOwner', source, plate)
            success = true
        end
    end

    -- Give keys through dusa_vehiclekeys
    if GetResourceState('dusa_vehiclekeys') == 'started' then
        exports.dusa_vehiclekeys:GiveKeys(source, plate)
        success = true
    end

    -- Give keys through cd_garage if enabled
    if GetResourceState('cd_garage') == 'started' then
        TriggerEvent('cd_garage:AddKeysOwnedVehicle', plate, nil, source)
        success = true
    end

    return success
end

--- Removes vehicle keys from a player through all available vehicle key systems
--- @param source number - Player ID
--- @param plate string - Vehicle plate
function VehicleKeysIntegration.RemoveKeys(source, plate)
    if not source or not plate then
        print("^3[QBX Vehicle Keys Integration] ^1ERROR: Missing source or plate parameter^0")
        return false
    end

    local success = false

    -- Remove keys through qbx_vehiclekeys
    if GetResourceState('qbx_vehiclekeys') == 'started' then
        exports.qbx_vehiclekeys:RemoveKeys(source, plate)
        success = true
    end

    -- Remove keys through dusa_vehiclekeys
    if GetResourceState('dusa_vehiclekeys') == 'started' then
        exports.dusa_vehiclekeys:RemoveKeys(source, plate)
        success = true
    end

    -- Remove keys through cd_garage if enabled
    if GetResourceState('cd_garage') == 'started' then
        TriggerEvent('cd_garage:RemoveKeys', {plate = plate, reciever_identifier = source, type = 'temp'})
        success = true
    end

    return success
end

--- Checks if a player has keys to a vehicle through any available system
--- @param source number - Player ID
--- @param plate string - Vehicle plate
--- @return boolean
function VehicleKeysIntegration.HasKeys(source, plate)
    if not source or not plate then
        return false
    end

    -- Check through qbx_vehiclekeys
    if GetResourceState('qbx_vehiclekeys') == 'started' then
        if exports.qbx_vehiclekeys:HasKeys(source, plate) then
            return true
        end
    end

    -- Check through dusa_vehiclekeys
    if GetResourceState('dusa_vehiclekeys') == 'started' then
        if exports.dusa_vehiclekeys:HasKeys(source, plate) then
            return true
        end
    end

    return false
end

--- Client-side function to give keys through all available systems
--- @param plate string - Vehicle plate
function VehicleKeysIntegration.ClientGiveKeys(plate)
    if not plate then
        print("^3[QBX Vehicle Keys Integration] ^1ERROR: Missing plate parameter^0")
        return false
    end

    local success = false

    -- Give keys through qbx_vehiclekeys
    if GetResourceState('qbx_vehiclekeys') == 'started' then
        TriggerEvent('qb-vehiclekeys:client:AddKeys', plate)
        success = true
    end

    -- Give keys through dusa_vehiclekeys
    if GetResourceState('dusa_vehiclekeys') == 'started' then
        exports.dusa_vehiclekeys:GiveKeys(plate)
        success = true
    end

    return success
end

--- Client-side function to check if player has keys
--- @param plate string - Vehicle plate
--- @return boolean
function VehicleKeysIntegration.ClientHasKeys(plate)
    if not plate then
        return false
    end

    -- Check through qbx_vehiclekeys
    if GetResourceState('qbx_vehiclekeys') == 'started' then
        if exports.qbx_vehiclekeys:HasKeys(plate) then
            return true
        end
    end

    -- Check through dusa_vehiclekeys
    if GetResourceState('dusa_vehiclekeys') == 'started' then
        if exports.dusa_vehiclekeys:HasKeys(plate) then
            return true
        end
    end

    return false
end

return VehicleKeysIntegration

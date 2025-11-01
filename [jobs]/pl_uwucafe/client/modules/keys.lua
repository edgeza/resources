function GiveKeys(veh)
    local plate = GetVehicleNumberPlateText(veh)
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
    if GetResourceState('qb-vehiclekeys') == 'started' then
        TriggerEvent('vehiclekeys:client:SetOwner', plate)
    elseif GetResourceState('wasabi_carlock') == 'started' then
        exports.wasabi_carlock:GiveKey(plate)
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
    elseif GetResourceState('vehicles_keys') == 'started' then
        TriggerServerEvent("vehicles_keys:selfGiveVehicleKeys", plate)
    elseif GetResourceState('ak47_vehiclekeys') == 'started' then
        exports['ak47_vehiclekeys']:GiveKey(plate, false)
    else
        --Add your Custom Key System Here
    end
end
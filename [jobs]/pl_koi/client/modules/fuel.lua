
function Fuel(spawnedVehicle)
    if Config.Delivery.FuelEnable then
        if GetResourceState('LegacyFuel') == 'started' then
            exports['LegacyFuel']:SetFuel(spawnedVehicle, 100.0)
        elseif GetResourceState('cdn-fuel') == 'started' then
            exports['cdn-fuel']:SetFuel(spawnedVehicle, 100.0)
        elseif GetResourceState('okokGasStation') == 'started' then
            exports['okokGasStation']:SetFuel(spawnedVehicle, 100.0)
        elseif GetResourceState('rcore_fuel') == 'started' then
            exports['rcore_fuel']:AddVehicleFuelLiter(spawnedVehicle, 100.0)
        elseif GetResourceState('ox_fuel') == 'started' then
            Entity(spawnedVehicle).state.fuel = 100
        end
    end
end
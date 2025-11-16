local function setFuel(vehicle, fuelLevel)
    local fuelResources = {
        'LegacyFuel',
        'cc-fuel',
        'ox_fuel',
        'cdn-fuel'
    }
    
    for _, resource in ipairs(fuelResources) do
        if GetResourceState(resource) == 'started' then
            if resource == 'ox_fuel' then
                fuelLevel = fuelLevel + 0.0
                Entity(vehicle).state:set('fuel', fuelLevel, true)
                return
            end

            exports[resource]:SetFuel(vehicle, fuelLevel)
            return
        end
    end
    
    -- If no fuel resource is running, output a warning
    print('^3Warning: No compatible fuel resource found ^0')
end

local function spawnVeh(_id, _data)
    _data.coords = config.rentboat[_id].boat.spawnpoints
    local foundValidSpawn = false

    for i, spawnPoint in ipairs(_data.coords) do
        if not IsAnyVehicleNearPoint(spawnPoint.x, spawnPoint.y, spawnPoint.z, 2.0) then
            _data.coords = spawnPoint
            foundValidSpawn = true
            break
        end
    end

    if not foundValidSpawn then
        Framework.Notify(locale('no_empty_area'), 'error')
        return
    end

    local vehPlate = 'RENT'..lib.string.random('.')..lib.string.random('.')..lib.string.random('.')..lib.string.random('.')
    local netID = lib.callback.await("fishing:server:spawnBoat", false, _data, vehPlate)
    while not NetworkDoesNetworkIdExist(netID) do
        Wait(100)
    end
    local car = NetToVeh(netID)
    SetVehicleNumberPlateText(car, vehPlate)
    SetVehicleEngineOn(car, true, true)
    SetVehicleDirtLevel(car, 0.0)
    SetVehRadioStation(car, 'OFF')
    setFuel(car, 100)
    SetPedIntoVehicle(cache.ped, car, -1)
end

function RentalMenu(id, location)
    local display = GetDisplayNameFromVehicleModel(location.boat.model)
    local label = GetLabelText(display) == 'NULL' and display or GetLabelText(display)

    lib.registerContext({
        id = 'boat_rental',
        title = locale('title_boat_rental'),
        options = {
            {
                
                title = locale('rent_boat', label, location.price),
                description = locale('rent_boat_desc', label),
                image = "https://docs.fivem.net/vehicles/" .. location.boat.model .. ".webp",
                icon = 'ship',
                onSelect = function()
                    spawnVeh(id, location)
                end,
            },
            {
                title = locale('close'),
                icon = 'x',
                onSelect = function()
                    lib.hideContext('boat_rental')
                end
            }
        }
    })
    lib.showContext('boat_rental')
end
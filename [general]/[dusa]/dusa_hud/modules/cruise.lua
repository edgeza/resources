cruise = false
cruiseSpeedKM = false
cruiseSpeedMPH = false

local function ToggleCruise()
    local pPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(pPed, false)
    local cruiseSpeed = GetEntitySpeed(vehicle)
    local gear = GetVehicleCurrentGear(vehicle)
    if gear == 0 then return end
    cruise = not cruise
    cruiseSpeedKM = math.floor(cruiseSpeed * 3.6)
    cruiseSpeedMPH = math.floor(cruiseSpeed * 2.23694)

    if cruise then
        notify(locale('cruise_enabled', 'success'))
    else
        notify(locale('cruise_disabled', 'error'))
    end
    CreateThread(function()    
        while cruise do
            if IsVehicleOnAllWheels(vehicle) and GetEntitySpeed(vehicle) > (cruiseSpeed - 2.0) and not HasEntityCollidedWithAnything(vehicle) then
                SetVehicleForwardSpeed(vehicle, cruiseSpeed)
            else
                cruise = false
            end
            Wait(350)
        end
    end)
end

exports('ToggleCruise', ToggleCruise)

CreateThread(function()
    while true do
        if not alreadyInVehicle and cruise then
            cruise = false
        end
        Wait(1700)
    end
end)

CruiseControl = lib.addKeybind({
    name = 'CruiseControl',
    description = 'Cruise Control',
    defaultKey = config.CruiseControlKey,
    onPressed = function ()
        if alreadyInVehicle then
            ToggleCruise()
        end
    end,
})
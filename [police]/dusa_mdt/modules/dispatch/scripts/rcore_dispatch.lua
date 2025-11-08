local resourceName = 'rcore_dispatch'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    print('^3[dusa_mdt] ^2'..resourceName..' ^0detected, running')
    dispatch.script = resourceName
    function SendDispatch()
        local info = exports['rcore_dispatch']:GetPlayerData()
        local alert = {
            id = info.id or math.random(1, 1000),
            message = info.text or nil,
            alertTime = "Just Now",
            code = info.code or nil,
            coords = info.coords,
            vehicle = info.vehicle_label,
            plate = info.vehicle_plate,
            doorCount = nil,
            firstColor = info.vehicle_colour,
            street = info.street,
            gender = info.sex,
        }
        dispatch:add(alert)
    end
    exports('SendDispatch', SendDispatch)
end)
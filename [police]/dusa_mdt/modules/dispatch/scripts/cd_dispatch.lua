local resourceName = 'cd_dispatch'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    dispatch.script = resourceName
    print('^3[dusa_mdt] ^2'..resourceName..' ^0detected, running')
    RegisterNetEvent('cd_dispatch:AddNotification')
    AddEventHandler('cd_dispatch:AddNotification', function(data)
        local player = exports['cd_dispatch']:GetPlayerInfo()
        local plate = GetVehicleNumberPlateText(player.vehicle)
        local dispatchData = {
            id = nil,
            title = data.title,
            message = data.message,
            alertTime = data.alertTime or "Just Now",
            code = data.code,
            coords = player.coords,
            vehicle = player.vehicle_label or {},
            plate = plate or "Not defined",
            doorCount = "Not defined",
            firstColor = player.vehicle_colour,
            street = player.street_1,
            gender = player.sex
        }
        SendDispatch(dispatchData)
    end)

    function SendDispatch(alertData)
        dispatch:add(alertData)
    end
    exports('SendDispatch', SendDispatch)
end)
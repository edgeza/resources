local resourceName = 'dusa_dispatch'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    dispatch.script = resourceName
    print('^3[dusa_mdt] ^2'..resourceName..' ^0detected, running')
    if dispatch.script then
        RegisterNetEvent('dusa_dispatch:client:SendDispatch')
        AddEventHandler('dusa_dispatch:client:SendDispatch', function (data)
            SendDispatch(data)
        end)

        function SendDispatch(data)
            local info = data -- get alert info from here
            local alert = {
                id = info.id,
                message = info.title,
                img = info.img or "",
                alertTime = info.time or "Just Now",
                code = info.code,
                coords = info.coords,
                vehicle = info.vehicle,
                plate = info.plate,
                doorCount = info.doors,
                firstColor = info.color,
                street = info.street,
                gender = info.gender,
            }
            dispatch:add(alert)
        end
    end
end)
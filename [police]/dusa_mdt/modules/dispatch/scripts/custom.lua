local resourceName = nil

if not dispatch.script then return end

SetTimeout(0, function()
    dispatch.script = resourceName
    if dispatch.script then
        function SendDispatch()
            local info = {} -- get alert info from here
            local alert = {
                id = info.id,
                message = info.message,
                alertTime = info.alertTime or "Just Now",
                code = info.code,
                coords = info.coords,
                vehicle = info.vehicle,
                plate = info.plate,
                doorCount = info.doorCount,
                firstColor = info.firstColor,
                street = info.street,
                gender = info.gender,
            }
            dispatch:add(alert)
        end
    end
end)
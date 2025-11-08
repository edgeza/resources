local resourceName = 'ps-dispatch'

local resourceState = GetResourceState(resourceName)
local dispatchState = GetResourceState('dusa_dispatch')

if not resourceState:find('start') or dispatchState:find('start') then
    return
end

SetTimeout(0, function()
    print('^3[dusa_mdt] ^2'..resourceName..' ^0detected, running')
    dispatch.script = resourceName
    function SendDispatch(data)
        local info = data
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
    exports('SendDispatch', SendDispatch)
end)
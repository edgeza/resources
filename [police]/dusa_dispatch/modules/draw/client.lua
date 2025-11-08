if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Draw  = {}

function Draw.listDraws()
    SendNUIMessage({action = 'LIST_DRAWINGS', data = GlobalState.createdDraws})
end

RegisterNUICallback('createDraw', function (data, cb)
    if not data then
        return error('No data provided to create draw', 2)
    end
    TriggerServerEvent('dusa_dispatch:createDraw', data.created)
    cb("ok")
end)

RegisterNUICallback('updateDraw', function (data, cb)
    if not data then
        return error('No data provided to update draw', 2)
    end
    TriggerServerEvent('dusa_dispatch:updateDraw', data.updated)
    cb("ok")
end)

RegisterNUICallback('removeDraw', function (data, cb)
    if not data then
        return error('No data provided to remove draw', 2)
    end

    TriggerServerEvent('dusa_dispatch:removeDraw', data.removed)
    cb("ok")
end)

RegisterNetEvent('dusa_dispatch:UpdateDraws', function (list)
    SendNUIMessage({action = 'LIST_DRAWINGS', data = list})
end)

return Draw
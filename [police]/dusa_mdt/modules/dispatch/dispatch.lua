
local alertProperties = {}
function dispatch:add(alert)
    insertAlert(alertProperties, "Time", alert.alertTime, "fa-regular fa-clock")
    insertAlert(alertProperties, "Code", alert.code, "fa-solid fa-hashtag")
    insertAlert(alertProperties, "Vehicle", alert.vehicle, "fa-solid fa-car")
    insertAlert(alertProperties, "Plate", alert.plate, "fa-regular fa-9")
    insertAlert(alertProperties, "Door Count", alert.doorCount, "fa-solid fa-door-closed")
    insertAlert(alertProperties, "Vehicle Color", alert.firstColor, "fa-solid fa-palette")
    insertAlert(alertProperties, "Street", alert.street, "fa-solid fa-signs-post")
    insertAlert(alertProperties, "Gender", alert.gender, "fa-solid fa-venus-mars")

    local id = generateId()
    local data = {
        id = alert.id or id,
        gameId = "#"..alert.id or id,
        code = alert.code or alert.message or "10-XX",
        iconList = alertProperties,
        location = alert.coords,
        img = alert.img,
        message = alert.message
    }
    dispatch.alerts[#dispatch.alerts + 1] = data
    TriggerServerEvent('dusa_mdt:sync', 'dispatch', dispatch.alerts)
end

RegisterNUICallback('navigateDispatch', function(data, cb)
    local x, y = tonumber(data.x), tonumber(data.y)
    SetNewWaypoint(x, y)
    bridge.notify(locale('dispatch_marked'), 'success')
    mdt:close()
    cb("ok")
end)
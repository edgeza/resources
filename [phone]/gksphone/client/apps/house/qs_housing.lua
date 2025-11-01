if Config.HouseScript ~= "qs-housing" then return end

RegisterNuiCallback("gksphone:home:fetchHouseData", function (data, cb)
    local CallbackTrigger
    if Config.Framework == "qb" or Config.Framework == "qbx" then
        CallbackTrigger = Config.Core.Functions.TriggerCallback
    elseif Config.Framework == "esx" then
        CallbackTrigger = Config.Core.TriggerServerCallback
    end
    if CallbackTrigger then
        CallbackTrigger('qb-phone:server:GetPlayerHouses', function(result)
            Debugprint('get house qs-housing', result)
            for i = 1, #result do
                result[i].transfer = false
            end
            cb(result)
        end)
    end
end)

RegisterNUICallback('gksphone:home:fetchKeysData', function(data, cb)
    local CallbackTrigger
    if Config.Framework == "qb" or Config.Framework == "qbx" then
        CallbackTrigger = Config.Core.Functions.TriggerCallback
    elseif Config.Framework == "esx" then
        CallbackTrigger = Config.Core.TriggerServerCallback
    end
    CallbackTrigger('qb-phone:server:GetHouseKeys', function(result)
        Debugprint('get key qs-housing', result)
        cb(result)
    end)
end)

RegisterNUICallback('gksphone:home:transferHouse', function(data, cb)
    cb(false)
end)


RegisterNUICallback('gksphone:home:houseLocation', function(data, cb)
    SetNewWaypoint(data.HouseData.coords.enter.x, data.HouseData.coords.enter.y)
    local notify = {
        title = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
        message = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_SETGPS"), -- The message of the notification
        icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
    }

    -- Trigger the notification using the gksphone exports
    exports["gksphone"]:Notification(notify)
    Debugprint('Set waypoint for other house')
    cb('ok')
end)
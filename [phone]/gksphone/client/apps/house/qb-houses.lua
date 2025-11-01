if Config.HouseScript ~= "qb-houses" then return end

RegisterNuiCallback("gksphone:home:fetchHouseData", function (data, cb)
    Config.Core.Functions.TriggerCallback('qb-phone:server:GetPlayerHouses', function(result)
        Debugprint('qb-phone:server:GetPlayerHouses', result)
        cb(result)
    end)
end)

RegisterNUICallback('gksphone:home:fetchKeysData', function(data, cb)
    Config.Core.Functions.TriggerCallback('qb-phone:server:GetHouseKeys', function(result)
        Debugprint('qb-phone:server:GetHouseKeys', result)
        cb(result)
    end)
end)

RegisterNUICallback('gksphone:home:transferHouse', function(data, cb)
    Debugprint('qb-phone:server:TransferHouse', data)
    CallBackServerTrigger('gksphone:server:getCizitinIDSource', function(citizenid)
        Debugprint("TransferHouse Qb-Core",citizenid )
        if citizenid then
            local TransferedCid = citizenid
            CreateThread(function()
                Config.Core.Functions.TriggerCallback('qb-phone:server:TransferCid', function(transfer)
                    if transfer then
                        local notify = {
                            title = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
                            message = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOME_TRANSFERSUCCESS"), -- The message of the notification
                            icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
                        }
                        exports["gksphone"]:Notification(notify)
                    end
                end, TransferedCid, data.house)
            end)
        end
    end, data.phoneNumber)
    cb('ok')
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
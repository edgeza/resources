if Config.HouseScript ~= "loaf_housing" then return end

RegisterNuiCallback("gksphone:home:fetchHouseData", function (data, cb)
    local ownedHouses = exports.loaf_housing:GetOwnedHouses()
    Debugprint('loafHouse ownedHouses', ownedHouses)
    cb(ownedHouses)
end)

RegisterNUICallback('gksphone:home:fetchKeysData', function(data, cb)
    local keys = exports.loaf_keysystem:GetKeys()
    local properties = {}
    for _, v in pairs(keys) do
        local _, _, propertyId = v.key_id:find("housing_key_(.*)_")
        if propertyId then
            properties[tonumber(propertyId)] = {HouseData = {adress = v.key_data.name}, id = tonumber(propertyId)}
        end
    end
    Debugprint('loafHouse properties', properties)
    cb(properties)
end)

RegisterNUICallback('gksphone:home:transferHouse', function(data, cb)
    Debugprint('loafHouse transfer', data)
    TriggerServerEvent('gksphone:server:loafhouseTransfer', data.house, data.phoneNumber)
    cb('ok')
end)

RegisterNetEvent('gksphone:client:transferHouse', function (plyaerid, proptyid)
    Debugprint('gksphone:client:transferHouse', plyaerid, proptyid)
    exports.loaf_housing:TransferProperty(plyaerid, proptyid)
    local notify = {
        title = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
        message = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOME_TRANSFERSUCCESS"), -- The message of the notification
        icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
    }
    exports["gksphone"]:Notification(notify)
end)

RegisterNUICallback('gksphone:home:houseLocation', function(data, cb)
    exports.loaf_housing:MarkProperty(data.id)
    local notify = {
        title = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
        message = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_SETGPS"), -- The message of the notification
        icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
    }

    -- Trigger the notification using the gksphone exports
    exports["gksphone"]:Notification(notify)

    Debugprint('Set waypoint for LOAF House')
    cb('ok')
end)
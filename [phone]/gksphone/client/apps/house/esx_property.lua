if Config.HouseScript ~= "esx_property" then return end


RegisterNuiCallback("gksphone:home:fetchHouseData", function (data, cb)
    local GetHouses = exports["esx_property"]:GetProperties()
    Debugprint('esx_property GetHouses', GetHouses)
    Debugprint('esx_property identifier', PlayerData.identifier)
    local PlayerProperties = {}
    for i=1, #GetHouses do
        if GetHouses[i].Owned and GetHouses[i].Owner == PlayerData.identifier then
            GetHouses[i].id = i
            PlayerProperties[#PlayerProperties + 1] = GetHouses[i]
        end
    end
    Debugprint('esx_property PlayerProperties', PlayerProperties)
    cb(PlayerProperties)
end)

RegisterNUICallback('gksphone:home:fetchKeysData', function(data, cb)
    local GetHouses = exports["esx_property"]:GetProperties()
    Debugprint('esx_property GetHouses', GetHouses)
    Debugprint('esx_property identifier', PlayerData.identifier)
    local PlayerProperties = {}
    for i=1, #GetHouses do
        if GetHouses[i].Keys and GetHouses[i].Keys[PlayerData.identifier] then
            GetHouses[i].id = i
            GetHouses[i].label = GetHouses[i].Name
            PlayerProperties[#PlayerProperties + 1] = {HouseData = GetHouses[i]}
        end
    end
    Debugprint('esx_property PlayerProperties', PlayerProperties)
    cb(PlayerProperties)
end)

RegisterNUICallback('gksphone:home:transferHouse', function(data, cb)
    cb(false)
end)

RegisterNUICallback('gksphone:home:houseLocation', function(data, cb)
    SetNewWaypoint(data.HouseData.Entrance.x, data.HouseData.Entrance.y)
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
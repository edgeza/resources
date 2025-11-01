if Config.HouseScript ~= "bcs_housing" then return end

RegisterNuiCallback("gksphone:home:fetchHouseData", function (data, cb)
    local ownedHouses = exports.bcs_housing:GetOwnedHomes()
    Debugprint('bcs_housing ownedHouses', ownedHouses)
    cb(ownedHouses)
end)

RegisterNUICallback('gksphone:home:fetchKeysData', function(data, cb)
    local houses = exports.bcs_housing:GetOwnedHomeKeys()
    Debugprint('bcs_housing houses', houses)
    local keys = {}
    for i = 1, #houses do
        houses[i].label = houses[i].properties.name
        houses[i].name = houses[i].identifier
        houses[i].tier = 1
        houses[i].coords = houses[i].entry
        houses[i].keyholders = exports.bcs_housing:GetKeyHolders(houses[i].identifier)
        keys[#keys + 1] = {
            HouseData = houses[i]
        }
    end
    Debugprint('bcs_housing keys', keys)
    cb(keys)
end)

RegisterNUICallback('gksphone:home:transferHouse', function(data, cb)
    Debugprint('bcs_housing transfer', data)
    CallBackServerTrigger('gksphone:server:getCizitinIDSource', function(citizenid, source)
        if citizenid and source then
            local srcid = source
            TriggerServerEvent('Housing:server:TransferOwner', data.house.identifier, tonumber(srcid))
        end
    end, data.phoneNumber)
    cb('ok')
end)

RegisterNUICallback('gksphone:home:houseLocation', function(data, cb)
    exports.bcs_housing:SetWaypoint(data.HouseData.name)
    local notify = {
        title = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_TITLE"), -- The title of the notification
        message = _T(LastItemData?.info?.phoneLang, "HouseAPP.APP_HOUSE_SETGPS"), -- The message of the notification
        icon = "/html/img/icons/house.png", -- The icon to be displayed with the notification
    }

    -- Trigger the notification using the gksphone exports
    exports["gksphone"]:Notification(notify)
    Debugprint('Set waypoint for BCS House')
    cb('ok')
end)
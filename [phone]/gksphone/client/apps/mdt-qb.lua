-- MDT App for gks phone
-- Made by GkS | https://discord.gg/XUck63E
-- Version: 1.0.0




--- GKSPHONE v2.0.0 ----

RegisterNUICallback('gksphone:getWantedData', function(data, cb)
    CallBackServerTrigger('gksphone:server:wantedData', function(result)
        Debugprint('gksphone:server:wantedData cb', result)
        cb(result)
    end)
end)

RegisterNUICallback('gksphone:wantedDelete', function(data, cb)
    CallBackServerTrigger('gksphone:server:wantedDelete', function(result)
        Debugprint('gksphone:server:wantedDelete cb', result)
        cb(result)
    end, data.id)
end)

RegisterNUICallback('gksphone:personSearch', function(data, cb)
    CallBackServerTrigger('gksphone:server:personSearch', function(result)
        Debugprint('gksphone:server:personSearch cb', result)
        cb(result)
    end, data.search)
end)

RegisterNUICallback('gksphone:wantedAdd', function(data, cb)
    Debugprint("gksphone:wantedAdd", data)
    TriggerServerEvent('gksphone:server:wantedAdd', data.citizenid, data.reason, data.appearance, data.lastseen)
    cb('ok')
end)

RegisterNUICallback('gksphone:AppartGo', function(data, cb)
    Debugprint('gksphone:AppartGo', data)
    if Apartments == nil then
        return
    end
    local AppartData = data.apart
    local TypeData = Apartments.Locations[AppartData.type]
    if TypeData == nil then
        return
    end
    SetNewWaypoint(TypeData.coords.enter.x, TypeData.coords.enter.y)
    Debugprint('gksphone:AppartGo', TypeData.coords.enter.x, TypeData.coords.enter.y)
    local notify = {
        title = _T(LastItemData?.info?.phoneLang, "GpsAPP.APP_GPS_TITLE"), -- The title of the notification
        message = _T(LastItemData?.info?.phoneLang, "GpsAPP.APP_GPS_MARKETLOCATION"), -- The message of the notification
        icon = "/html/img/icons/gps.png", -- The icon to be displayed with the notification
      }

      -- Trigger the notification using the gksphone exports
      exports["gksphone"]:Notification(notify)
    cb('ok')
end)

RegisterNUICallback('gksphone:houseSearch', function(data, cb)
    Config.Core.Functions.TriggerCallback('qb-phone:server:MeosGetPlayerHouses', function(result)
        Debugprint('qb-phone:server:MeosGetPlayerHouses', result)
        cb(result)
    end, data.search)
end)

RegisterNUICallback('gksphone:platescanmdt', function(data, cb)
    local vehicle = Config.Core.Functions.GetClosestVehicle()
    local plate = Config.Core.Functions.GetPlate(vehicle)
    local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
    local denadwad = {}
    Debugprint('platescanmdt Vehicle: ', vehicle)
    Debugprint('platescanmdt Plate: ', plate)
    Debugprint('platescanmdt Vehicle Name: ', vehname)
    CallBackServerTrigger('gksphone:server:ScanPlate', function(result)
        Config.Core.Functions.TriggerCallback('police:IsPlateFlagged', function(flagged)
            result.isFlagged = flagged
            if Config.Core.Shared.Vehicles[vehname] ~= nil then
                result.label = Config.Core.Shared.Vehicles[vehname]['name']
            else
                result.label = 'Unknown brand..'
            end
            table.insert(denadwad, result)
            Debugprint('gksphone:platescanmdt : ', denadwad)
            cb(denadwad)
        end, plate)
    end, plate)
end)

RegisterNUICallback('gksphone:platesearchmdt', function(data, cb)
    Debugprint('gksphone:gkcs:mdtplatesearch', data)
    CallBackServerTrigger('gksphone:server:GetVehicleSearchResults', function(result)
        if result ~= nil then
            for k, v in pairs(result) do
                Config.Core.Functions.TriggerCallback('police:IsPlateFlagged', function(flagged)
                    Debugprint('IsPlateFlagged callback')
                    result[k].isFlagged = flagged
                end, result[k].plate)
                Wait(50)
            end
        end
        Debugprint('gksphone:gkcs:mdtplatesearch', result)
        cb(result)
    end, data.search)
end)
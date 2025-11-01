function GetPlayerSetting(stn)
    local settings = lib.callback.await('dusa_hud:getSettings', false)
    if type(settings) == 'string' then
        settings = json.decode(settings)
    end

    if stn == 'status' then
        if not settings or not next(settings) then return config.DefaultStatus end
        return settings[1].status.statusStyleType
    elseif stn == 'speedometer' then
        if not settings or not next(settings) then return config.DefaultSpeedometer end
        return settings[1].speedometers.speedometerType
    end
end

function OpenSettingsMenu()
    local settings = lib.callback.await('dusa_hud:getSettings', false)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    ToggleCursor(true)
    if type(settings) == 'string' then settings = json.decode(settings) end
    nuiMessage('openSettingsMenu', {settings = settings, isOpen = true, vehicleType = GetVehicleType(vehicle)})
end

exports('OpenSettingsMenu', OpenSettingsMenu)

RegisterNetEvent('dusa_hud:openSettings')
AddEventHandler('dusa_hud:openSettings', function()
    OpenSettingsMenu()
end)

RegisterNetEvent('dusa_hud:saveSettings', function()
    print('save')
    -- nuiMessage('saveSettings', {})
end)
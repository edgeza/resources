EASYTIME_SETTINGS = {
    hours = 12,
    mins = 0,
    weather = 'XMAS',
    instantweather = true,
    dynamic = false,
    freeze = true,
    instanttime = false,
    blackout = false
}

Citizen.CreateThread(function()
    if Config.XmasWeather then
        if isResourceLoaded('av_weather') then
            local zones = {
                'santos',
                'paleto',
                'sandy',
                'cayo'
            }

            for _, zone in ipairs(zones) do
                local success = exports['av_weather']:UpdateZone(zone, 'XMAS', true)
                if not success then
                    log.debug('av_weather: Failed to change weather in zone %s', zone)
                end
            end
        elseif isBridgeLoaded('Framework', Framework.QBCore) and isResourceLoaded('qb-weathersync') and not isResourceLoaded('cd_easytime') then
            local success = exports['qb-weathersync']:setWeather('XMAS')
            if not success then
                log.debug('Could not set the weather to XMAS in qb-weathersync!')
            end
        elseif isResourceLoaded('cd_easytime') then
            local file = LoadResourceFile('cd_easytime', 'configs/config.lua')
            local startIndex, endIndex = string.find(file, "Config.WeatherGroups%s*=%s*{")
            local endIndex = string.find(file, "}[^}]*$")
            local weatherGroupsText = string.sub(file, startIndex, endIndex)
            local status, result = pcall(function()
                load(weatherGroupsText)()
            end)
            if not status then
                log.debug('Failed to load weather groups from cd_easytime config!')
                return
            end

            RegisterCommand('xmas_easytime', function()
                local settingsFile = LoadResourceFile('cd_easytime', 'settings.txt')
                local settings = json.encode(EASYTIME_SETTINGS)
                SaveResourceFile('cd_easytime', 'settings.txt', settings, -1)
                log.info('XMAS settings.txt applied to cd_easytime!')
            end, false)

            local found = false
            for index, weatherTypes in pairs(Config.WeatherGroups) do
                for _, weatherType in ipairs(weatherTypes) do
                    if weatherType ~= 'XMAS' then
                        found = true
                        break
                    end
                end
            end

            if found then
                log.warn([[Found other weather groups in cd_easytime/configs/config.lua than XMAS. Replace it with:
---
^3Config.WeatherGroups = {
    [1] = { 'XMAS' ]
}
^7---
]])
            end

            log.warn(
                'Please run "xmas_easytime" to apply XMAS settings to settings.txt. Changes above are still required!')
        end
    end
end)

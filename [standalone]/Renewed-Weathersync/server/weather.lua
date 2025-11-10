local buildWeatherList = require 'server.weatherbuilder'

local Config = lib.load('config.weather')
local useScheduledWeather = Config.useScheduledWeather
local weatherList = buildWeatherList()

local overrideWeather = false

-- Snow weather types that should have visual snow particles
local snowFilter = {
    ['SNOW'] = true,
    ['SNOWLIGHT'] = true,
    ['BLIZZARD'] = true,
    ['XMAS'] = true,
}

-- Helper function to ensure hasSnow is set correctly for weather events
local function ensureSnowProperty(weatherEvent)
    if weatherEvent and Config.enableSnow and snowFilter[weatherEvent.weather] then
        weatherEvent.hasSnow = true
    elseif weatherEvent and (not Config.enableSnow or not snowFilter[weatherEvent.weather]) then
        weatherEvent.hasSnow = nil -- Remove hasSnow if snow is disabled or not a snow weather type
    end
    return weatherEvent
end

-- weatherList executor --
local function executeCurrentWeather()
    local weather = weatherList[1]

    if weather then
        ensureSnowProperty(weather) -- Ensure hasSnow is set correctly
        GlobalState.weather = weather
    end

    return weather
end

local function runWeatherList()
    local currentWeather = executeCurrentWeather()

    while not overrideWeather do

        if weatherList[1] then
            currentWeather.time -= 1

            if currentWeather.time <= 0 then
                table.remove(weatherList, 1)
                currentWeather = executeCurrentWeather()
            end
        else
            currentWeather = executeCurrentWeather()
        end
        Wait(60000)
    end
end

CreateThread(runWeatherList)

-- Admin related events --
RegisterNetEvent('Renewed-Weather:server:removeWeatherEvent', function(index)
    if IsPlayerAceAllowed(source, 'command.weather') and weatherList[index] then
        table.remove(weatherList, index)
    end
end)

lib.callback.register('Renewed-Weathersync:server:setWeatherType', function(source, index, weatherType)
    if IsPlayerAceAllowed(source, 'command.weather') and weatherList[index] then
        weatherList[index].weather = weatherType
        ensureSnowProperty(weatherList[index]) -- Ensure hasSnow is set correctly

        if index == 1 then
            local currentWeather = weatherList[1]
            currentWeather.weather = weatherType
            ensureSnowProperty(currentWeather) -- Ensure hasSnow is set correctly

            GlobalState.weather = currentWeather
        end

        return weatherType
    end

    return false
end)

lib.callback.register('Renewed-Weathersync:server:setEventTime', function(source, index, eventTime)
    local weatherEvent = weatherList[index]

    if IsPlayerAceAllowed(source, 'command.weather') and weatherEvent then
        weatherEvent.time = eventTime

        return eventTime
    end

    return false
end)

lib.addCommand('weather', {
    help = 'View and set the current weather forecast',
    restricted = 'group.admin',
}, function(source)
    TriggerClientEvent('Renewed-Weather:client:viewWeatherInfo', source, weatherList)
end)

-- Scheduled restart --
if useScheduledWeather then
    AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
        local secondsRemaining = eventData.secondsRemaining
        local weather = secondsRemaining == 900 and 'OVERCAST' or secondsRemaining == 600 and 'RAIN' or secondsRemaining == 300 and 'THUNDER'

        if weather then
            overrideWeather = true
            GlobalState.weather = {
                weather = weather,
                time = 9000000
            }
        end
    end)
end
CreateThread(function()
    Wait(2000) -- Wait for framework to load
end)

lib.callback.register("dusa_hud:updateSettings", function(source, settings)
    -- Safety check for GetIdentifier function
    if not GetIdentifier then 
        print('[ERROR] dusa_hud: GetIdentifier function not available. Framework may not be loaded.')
        return false
    end
    
    local citizenid = GetIdentifier(source)
    if not citizenid then
        print('[ERROR] dusa_hud: Could not get citizenid for source ' .. tostring(source))
        return false
    end

    local query = false

    local dataSettings = cache.get('settings-'..citizenid)

    if not dataSettings then
        query = true
        dataSettings = db.query("hud_settings", {"settings"}, "citizenid", citizenid)
    end

    if not dataSettings[1] and query then
        local playlist = {}
        dp('data not found, inserted new settings')
        settings[1].language = nil -- remove language from data
        db.insert("hud_settings", {'citizenid', 'stress', 'playlist', 'settings'}, {citizenid, 0, json.encode(playlist), json.encode(settings)})
        cache.set('settings-'..citizenid, settings)
    else
        dp('updated settings')
        settings[1].language = nil -- remove language from data
        if tonumber(settings[1].speedometers.speedometerType) == 11 or tonumber(settings[1].speedometers.speedometerType) == 12 or tonumber(settings[1].speedometers.speedometerType) == 13 then return true end
        db.save("hud_settings", "settings", "citizenid", json.encode(settings), citizenid)
        cache.set('settings-'..citizenid, settings)
    end

    return true
end)

lib.callback.register("dusa_hud:updatePositions", function(source, positions)
    -- Safety check for GetIdentifier function
    if not GetIdentifier then 
        print('[ERROR] dusa_hud: GetIdentifier function not available. Framework may not be loaded.')
        return false
    end
    
    local citizenid = GetIdentifier(source)
    if not citizenid then
        print('[ERROR] dusa_hud: Could not get citizenid for source ' .. tostring(source))
        return false
    end
    local dataSettings = cache.get('settings-'..citizenid)

    if not dataSettings then
        dataSettings = db.query("hud_settings", {"settings"}, "citizenid", citizenid)
        if dataSettings and dataSettings[1] then
            if type(dataSettings[1].settings) == 'string' then
                dataSettings = json.decode(dataSettings[1].settings)
            else
                dataSettings = dataSettings[1].settings
            end
        else
            return false
        end
    end

    -- Update positions in settings
    if dataSettings and dataSettings[1] then
        dataSettings[1].defaultPositions = positions
        dataSettings[1].language = nil -- remove language from data
        db.save("hud_settings", "settings", "citizenid", json.encode(dataSettings), citizenid)
        cache.set('settings-'..citizenid, dataSettings)
        dp('Updated positions for player '..citizenid)
        return true
    end

    return false
end)

lib.callback.register("dusa_hud:getSettings", function(source)
    -- Safety check for GetIdentifier function
    if not GetIdentifier then 
        print('[ERROR] dusa_hud: GetIdentifier function not available. Framework may not be loaded.')
        return {}
    end
    
    local citizenid = GetIdentifier(source)
    if not citizenid then
        print('[ERROR] dusa_hud: Could not get citizenid for source ' .. tostring(source))
        return {}
    end
    
    local data = cache.get('settings-'..citizenid)

    if not data then 
        local data = db.query("hud_settings", {"settings"}, "citizenid", citizenid)
        if not data or not next(data) then 
            dp('No settings found for player '..citizenid..' - Code 154')
            return {}
        end

        if type(data[1].settings) == 'string' then data[1].settings = json.decode(data[1].settings) end
        cache.set('settings-'..citizenid, data[1].settings) 

        return data[1].settings
    end

    return data
end)

-- AddEventHandler('txAdmin:events:serverShuttingDown', function ()
--     TriggerClientEvent('dusa_hud:saveSettings', -1)
-- end)

-- AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
--     if eventData.secondsRemaining ~= 60 then return end
--     TriggerClientEvent('dusa_hud:saveSettings', -1)
-- end)

-- AddEventHandler('onResourceStop', function(resource)
--     if resource ~= GetCurrentResourceName() then return end
--     print('Tetiklenmeli', CACHED_TABLE, json.encode(CACHED_TABLE))
-- end)
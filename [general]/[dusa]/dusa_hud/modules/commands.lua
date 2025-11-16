RegisterCommand('hud_cursor', function()
    ToggleCursor(true)
end)

ToggleCursorKey = lib.addKeybind({
    name = 'ToggleCursor',
    description = 'Toggle UI Cursor',
    defaultKey = config.CursorHotkey,
    onPressed = function ()
        ToggleCursor(true)
    end,
})

RegisterCommand(config.hudMenuCommand, function()
    OpenSettingsMenu()
end)

if config.enableHudKeyInteraction then
    OpenHudMenu = lib.addKeybind({
        name = 'OpenHud',
        description = 'Open Hud Menu',
        defaultKey = config.hudMenuKey,
        onPressed = function ()
            OpenSettingsMenu()
        end,
    })
end

RegisterNUICallback('changeSettings', function(data, cb)
    dp('changeSettings', json.encode(data))
    local update = lib.callback.await('dusa_hud:updateSettings', false, data)
    SetupInformations()
    cb("ok")
end)

RegisterNUICallback('saveLastSettings', function(data, cb)
    local save = lib.callback.await('dusa_hud:updateSettings', false, data)
    cb("ok")
end)

RegisterNUICallback('savePositions', function(data, cb)
    -- Save positions to player data/database
    local save = lib.callback.await('dusa_hud:updatePositions', false, data)
    cb("ok")
end)
-- saveSettings
-- SendNUIMessage({
--     type = 'saveSettings',
--     data = {}
-- })
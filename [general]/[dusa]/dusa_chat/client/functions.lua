if not rawget(_G, "lib") then include('ox_lib', 'init') end

function openChat()
    -- SetNuiFocus(true, true)
    local gameCommands = {}

    for game, gameData in pairs(Shared.Games) do
        game = string.lower(game)
        gameCommands[game] = gameData.command
    end
    SendNUIMessage({
        action = 'ON_OPEN',
        data = {
            forbiddenWords = Config.ForbiddenWords or {},
            gameCommands = gameCommands,
            filterGroups = Config.Filter
        }
    })
end
exports('OpenChat', openChat)

function closeChat()
    chatInputActive = false
    stopTypingAnimation()
    SendNUIMessage({
        action = 'CLOSE_CHAT'
    })
end
exports('CloseChat', closeChat)

local function announcement(message, duration)
    local announcementData = {
        message = message,
        duration = duration
    }
    SendNUIMessage({
        action = 'ON_ANNOUNCEMENT',
        data = announcementData
    })
end
RegisterNetEvent('dusa_chat:client:announcement', announcement)

local function refreshCommands()
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsAceAllowed(('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerEvent('chat:addSuggestions', suggestions)
    end
end

local function refreshThemes()
    local themes = {}

    for resIdx = 0, GetNumResources() - 1 do
        local resource = GetResourceByFindIndex(resIdx)

        if GetResourceState(resource) == 'started' then
            local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

            if numThemes > 0 then
                local themeName = GetResourceMetadata(resource, 'chat_theme')
                local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

                if themeName and themeData then
                    themeData.baseUrl = 'nui://' .. resource .. '/'
                    themes[themeName] = themeData
                end
            end
        end
    end

    -- SendNUIMessage({
    -- 	type = 'ON_UPDATE_THEMES',
    -- 	themes = themes
    -- })
end

AddEventHandler('onClientResourceStart', function(resName)
    Wait(500)

    refreshCommands()
    refreshThemes()
    lib.locale(Shared.Language)
    SendNUIMessage({
        action = 'SET_LANGUAGE',
        data = ui_locales
    })
end)

AddEventHandler('onClientResourceStop', function(resName)
    Wait(500)

    refreshCommands()
    refreshThemes()
end)

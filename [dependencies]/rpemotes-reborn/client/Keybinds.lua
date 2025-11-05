CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/e', Translate('play_emote'),
        { { name = "emotename",      help = Translate('help_command') },
            { name = "texturevariation", help = Translate('help_variation') } })
    TriggerEvent('chat:addSuggestion', '/emote', Translate('play_emote'),
        { { name = "emotename",      help = Translate('help_command') },
            { name = "texturevariation", help = Translate('help_variation') } })
    if Config.Keybinding then
        TriggerEvent('chat:addSuggestion', '/emotebind', Translate('link_emote_keybind'),
            { { name = "key",     help = "num4, num5, num6, num7. num8, num9. Numpad 4-9!" },
                { name = "emotename", help = Translate('help_command') } })
        TriggerEvent('chat:addSuggestion', '/emotebinds', Translate('show_emote_keybind'))
        TriggerEvent('chat:addSuggestion', '/emotedelete', Translate('remove_emote_keybind'),
            { { name = "key", help = "num4, num5, num6, num7. num8, num9. Numpad 4-9!" } })
    end
    TriggerEvent('chat:addSuggestion', '/emotemenu', Translate('open_menu_emote'))
    TriggerEvent('chat:addSuggestion', '/emotes', Translate('show_list_emote'))
    TriggerEvent('chat:addSuggestion', '/emotecancel', Translate('cancel_emote'))
end)

RegisterCommand('e', function(source, args, raw) EmoteCommandStart(args) end, false)
RegisterCommand('emote', function(source, args, raw) EmoteCommandStart(args) end, false)
RegisterCommand('emotecancel', function() EmoteCancel() end, false)

if Config.MenuKeybindEnabled then
    RegisterCommand('emoteui', function() OpenEmoteMenu() end, false)
    RegisterKeyMapping("emoteui", Translate('register_open_menu'), "keyboard", Config.MenuKeybind)
else
    RegisterCommand('emotemenu', function() OpenEmoteMenu() end, false)
end

if Config.EnableCancelKeybind then
    RegisterKeyMapping("emotecancel", Translate('register_cancel_emote'), "keyboard", Config.CancelEmoteKey)
end

-- BINDING EMOTES TO KEYS
if Config.Keybinding then
    RegisterCommand('emotebind', function(source, args, raw) EmoteBindStart(source, args, raw) end, false)
    RegisterCommand('emotebinds', function(source, args, raw) ListKeybinds() end, false)
    RegisterCommand('emotedelete', function(source, args) DeleteEmote(args) end, false)

    for i = 1, #Config.KeybindKeys do
    local cmd = string.format('emoteSelect%s', i)
    RegisterCommand(cmd, function()
        local emote = GetResourceKvpString(string.format('%s_emob%s', Config.keybindKVP, i))
        if emote and emote ~= "" then
            EmoteCommandStart({ emote, 0 })
        end
    end, false)
    RegisterKeyMapping(cmd, string.format('Emote bind %s', i), 'keyboard', Config.KeybindKeys[i])
    end

    function EmoteBindStart(source, args, raw)
        if #args < 2 then
            EmoteChatMessage("Usage: /emotebind [key] [emotename] - Example: /emotebind 4 sit")
            return
        end
        
        local numkey = tonumber(args[1])
        local emote = args[2] and string.lower(args[2]) or nil
        
        if not numkey then
            EmoteChatMessage("'" .. tostring(args[1]) .. "' " .. Translate('notvalidkey') .. " - Must be a number between 1-6")
            return
        end
        
        if numkey < 1 or numkey > #Config.KeybindKeys then
            EmoteChatMessage("Key must be between 1 and " .. #Config.KeybindKeys)
            return
        end
        
        if not emote or emote == "" then
            EmoteChatMessage("Invalid emote name")
            return
        end
        
        if EmoteData[emote] then
            SetResourceKvp(string.format('%s_emob%s', Config.keybindKVP, numkey), emote)
            EmoteChatMessage("Emote '" .. emote .. "' bound to key " .. numkey .. " (Numpad " .. Config.KeybindKeys[numkey] .. ")")
        else
            EmoteChatMessage("'" .. emote .. "' " .. Translate('notvalidemote') .. "")
        end
    end

    function ListKeybinds()
        for i = 1, #Config.KeybindKeys do
            local emote = GetResourceKvpString(string.format('%s_emob%s', Config.keybindKVP, i))
            if emote then
                EmoteChatMessage(string.format('Emote %s : %s',i, emote))
            end
        end
    end

    function DeleteEmote(args)
        if #args < 1 then
            EmoteChatMessage("Usage: /emotedelete [key] - Example: /emotedelete 4")
            return
        end
        
        local numkey = tonumber(args[1])
        if not numkey then
            EmoteChatMessage("'" .. tostring(args[1]) .. "' " .. Translate('notvalidkey') .. " - Must be a number between 1-6")
            return
        end
        
        if numkey < 1 or numkey > #Config.KeybindKeys then
            EmoteChatMessage("Key must be between 1 and " .. #Config.KeybindKeys)
            return
        end
        
        DeleteResourceKvp(string.format('%s_emob%s', Config.keybindKVP, numkey))
        EmoteChatMessage("Emote binding removed from key " .. numkey .. " (Numpad " .. Config.KeybindKeys[numkey] .. ")")
    end
end

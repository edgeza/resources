Config = {}

Config.HideNameOnMask = true -- If true, the name will be hidden if the player is wearing a mask
Config.ShowTypingDots = true -- If true, the typing dots will be shown on players head when the player is typing

Config.SettingsCommand = {
    command = "settings",
    label = "Settings",
    description = "Open chat settings menu",
}

Config.ClearCommand = {
    command = "clear",
    label = "Clear",
    description = "Clear chat",
}

Config.System = {
    --[[
        This section is used to manage system messages, warnings, and information messages
        You can customize the appearance of system messages based on their type, or disable them directly
    ]]
    
    Info = {
        Enable = false, -- Should information messages be added to chat?
        Command = "+system-info", -- Command prefix to be used for information messages
        Label = "INFO", -- Label to be used for information messages
        Color = "#00FF00", -- Color to be used for information messages
    },
}

-- If you want to disable it, set it directly to false. [e.g Config.ForbiddenWords = false]
Config.ForbiddenWords = { 
    -- "forbiddenword",
}


-- Filter button configurations on the left side of the chat input
Config.Filter = {
    {
        groupName = "Admin", -- Filter group name
        commands = {
            "/ac", -- Included command with this prefix
        }
    },
    {
        groupName = "System", -- Filter group name
        commands = {
            "/system", -- Included command with this prefix
        }
    },
    {   
        groupName = "PM", -- Filter group name
        commands = {
            "/pm", -- Included command with this prefix
        }       
    },
    {
        groupName = "Emote", -- Filter group name
        commands = {
            "/me", -- Included command with this prefix
            "/do", -- Included command with this prefix
            "/pme", -- Included command with this prefix
            "/pdo", -- Included command with this prefix
        }
    }
}

-- ## TODO, not available yet
-- Config.CustomMessageTemplates = {
--     --[[
--         You can add your own message templates in this section
--         You can use color codes like ^1, ^2, ^3, ^4, ^5, ^6, ^7, ^8, ^9 in your message templates
--         These color codes mean:
--         ^1: Red
--         ^2: Green 
--         ^3: Yellow
--         ^4: Blue
--         ^5: Purple
--         ^6: White
--         ^7: Gray
--         ^8: Red-Red
--         ^9: Red-White
--     --]]
--     announcement = {
--         message = "^1[ANNOUNCEMENT]^0",
--         color = "#FF0000",
--     },
-- }
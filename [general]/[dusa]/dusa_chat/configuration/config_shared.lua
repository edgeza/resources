Shared = {}

Shared.Language = 'en' -- 'en', 'de', 'es', 'fr', 'it', 'pl', 'pt', 'ru', 'tr'

Shared.RoleplayCommands = {
    ['me'] = {
        enable = true,
        command = "me", -- Registered command name
        color = "#f52892", -- Message list tag color
        label = "ME", -- Message list label
        description = "Perform an emote/action", -- Command description
        color3d = { r = 245, g = 40, b = 145, a = 255 }, -- 3D text colors
        distance = 15.0, -- Maximum distance in meters that players can see the text
        time = 5000, -- How long the 3D text remains visible
        parameters = {
            {
                name = "message", -- Do not change this value
                type = "string", -- Do not change this value
                description = "Your message",
            },
        },
    },
    ['do'] = {
        enable = true,
        command = "do", -- Registered command name
        color = "#84f528", -- Message list tag color
        label = "DO", -- Message list label
        description = "Perform an action", -- Command description
        color3d = { r = 132, g = 245, b = 40, a = 255 }, -- 3Dj text colors
        distance = 15.0, -- Maximum distance in meters that players can see the text
        time = 5000, -- How long the 3D text remains visible
        parameters = {
            {
                name = "message", -- Do not change this value
                type = "string", -- Do not change this value
                description = "Your message",
            },
        },
    },
    ['pme'] = {
        enable = true,
        command = "pme", -- Registered command name
        color = "#f52892", -- Message list tag color
        label = "PME", -- Message list label
        description = "Perform an emote/action to a specific player", -- Command description
        color3d = { r = 245, g = 40, b = 145, a = 255 }, -- 3D text colors
        distance = 15.0, -- Maximum distance in meters that players can see the text
        time = 5000, -- How long the 3D text remains visible
        parameters = {
            {
                name = "target", -- Do not change this value
                type = "playerId", -- Do not change this value
                description = "Target player id",
            },
            {
                name = "message", -- Do not change this value
                type = "string", -- Do not change this value
                description = "Your message",
            },
        },
    },
    ['pdo'] = {
        enable = true,
        command = "pdo", -- Registered command name
        color = "#84f528", -- Message list tag color
        label = "PDO", -- Message list label
        description = "Perform an action to a specific player", -- Command description
        color3d = { r = 132, g = 245, b = 40, a = 255 }, -- 3D text colors
        distance = 15.0, -- Maximum distance in meters that players can see the text
        time = 5000, -- How long the 3D text remains visible
        parameters = {
            {
                name = "target", -- Do not change this value
                type = "playerId", -- Do not change this value
                description = "Target player id",
            },
            {
                name = "message", -- Do not change this value
                type = "string", -- Do not change this value
                description = "Your message",
            },
        },
    },
    ['ooc'] = {
        enable = false,
        command = "ooc",
        color = "#cbd1c9",
        label = "OOC",
        description = "Out of character chat with nearby players",
        distance = 30.0, -- Sends message to players within 30 meters
        parameters = {
            {
                name = "message", -- Do not change this value
                type = "string", -- Do not change this value
                description = "Your message",
            },
        },
    },
    ['requestid'] = {
        enable = true,
        command = "requestid",
        color = "#50f522",
        label = "REQUESTID",
        description = "Request closest player ID",
    },
    ['tweet'] = {
        enable = false,
        command = "tweet",
        color = "#22b9f5",
        label = "TWEET",
        distance = false,
        description = "Send a tweet",
        parameters = {
            {
                name = "message", -- Do not change this value
                type = "string", -- Do not change this value
                description = "Your message",
            },
        },
    },
    ['anontweet'] = {
        enable = false,
        command = "anontweet",
        color = "#22b9f5",
        label = "ANONTWEET",
        distance = false,
        description = "Send an anonymous tweet",
        parameters = {
            {
                name = "message", -- Do not change this value
                type = "string", -- Do not change this value
                description = "Your message",
            },
        },
    },
}

Shared.Games = {
    --[[
        In this section you can manage chance games like dice rolling, rock paper scissors and try
    ]]
    dice = {
        enable = true, -- Is dice rolling game enabled?
        command = "dice", -- Command prefix to be used for dice rolling game
        label = "DICE", -- Label to be used for dice rolling game
        description = "Roll a dice", -- Description to be used for dice rolling game
        color = "#FF0000", -- Color to be used for dice rolling game
        distance = 15.0,
    },

    rps = {
        enable = true, -- Is rock paper scissors game enabled?
        command = "rps", -- Command prefix to be used for rock paper scissors game
        label = "RPS", -- Label to be used for rock paper scissors game
        description = "Rock Paper Scissors", -- Description to be used for rock paper scissors game
        color = "#00FF00", -- Color to be used for rock paper scissors game
        distance = 15.0,
    },

    try = {
        enable = true, -- Is try game enabled?
        command = "try", -- Command prefix to be used for try game
        label = "TRY", -- Label to be used for try game
        description = "Try something", -- Description to be used for try game
        color = "#0000FF", -- Color to be used for try game
        distance = 15.0,
    },
}
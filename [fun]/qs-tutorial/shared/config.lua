Config = {}

Config.Speed = 5000 -- Start tutorial ms

Config.Locations = { -- Locations, texts and images
    {
        coords = vector3(-647.00, -760.28, 284.39),
        heading =  263.50,
        image = "talk3.png",
        text = "Welcome to OneLife Roleplay, where reality distorts and shadows whisper secrets. Here, dreams and wakefulness intertwine... Are you ready to wake up?",
        button = 'Continue',
        vibrate = true
    },
    {
        coords = vec3(-529.81, -229.49, 43.72),
        heading = 31.29,
        image = "rose.png",
        text = "Here, between coffee-stained papers and empty stares, the most valuable thing is traded: time for money. If you need a job, this is your altar. Pray, sign, and prepare to sell your hours to the highest bidder.",
        button = 'Continue',
        vibrate = true
    },
    {
        coords = vec3(803.44, -1289.2, 26.36),
        heading = 269.62,
        image = "point.png",
        text = "The cathedral of law, where heroes and villains drink the same stale coffee. Here, fates are decided with a pen and a raised eyebrow. If you walk in on your own, you might leave. If they bring you in, pray it's just a fine.",
        button = 'Continue',
        vibrate = false
    },
    {
        coords = vector3(258.90, -598.08, 50.41),
        heading = 292.67,
        image = "talk3.png",
        text = "The butcher's temple, where white coats hide trembling hands and sharp scalpels. You enter broken and leave with more questions than answers. If you wake up with something extra or missing a kidney, it's best not to ask too many questions.",
        button = 'Continue',
        vibrate = true
    },
    {
        coords = vector3(33.53, -1348.26, 21.83),
        heading = 59.94,
        image = "talk2.png",
        text = "The 24/7 stores, neon-lit temples where insomnia and desperation meet in aisles of canned food. Here, you can buy anything: from a questionable snack to the perfect excuse for an improvised heist. Don’t ask about the clerk, he’s seen it all.",
        button = 'Continue',
        vibrate = false
    },
    {
        coords = vec3(-1495.94, -1484.54, 8.85),
        heading = 114.0,
        image = "talk2.png",
        text = "This is the Beach Club, where you can relax, have fun and even ride jetski's and boats if you wish. There is also a DJ Booth",
        button = 'Continue',
        vibrate = false
    },
}

Config.Commands = { -- Comand list
    StartTutorial = 'tutorial',
    ResetTutorial = 'resettutorial'
}

Config.Hud = { -- Hud configuration
    Enable = function()
        -- DisplayRadar(true) -- Enables radar display on HUD
        -- exports['qs-interface']:ToggleHud(true) -- Uncomment if using an external HUD
    end,
    Disable = function()
        -- DisplayRadar(false) -- Disables radar display on HUD
        -- exports['qs-interface']:ToggleHud(false) -- Uncomment if using an external HUD
    end
}

Config.Debug = false -- Debug Configuration, enables detailed print logs for debugging; leave off for production
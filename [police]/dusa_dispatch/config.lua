----------------------------------------------------------------
----                   DUSADEV.TEBEX.IO                     ----
----------------------------------------------------------------
config = {}
config.debug = false -- For debugging purposes
config.error = true -- For debugging purposes, if you had a problem set this to true and open ticket
config.framework = 'auto' -- auto / qb / esx
config.voip = 'pma' -- pma / mumble / saltychat
config.language = 'en' -- en

config.JobColors = {
    police = "#1FA2EC",
    sheriff = "#DFB038",
    bcso = "#DF6A38",
    highway = "#FC5FFF",
    fib = "#FC5FFF",
    sasp = "#6AC9FF",
    ranger = "#0EB809",
    ambulance = "#FF3939",
}


-- ██╗░░░██╗██████╗░██╗░░░░░░█████╗░░█████╗░██████╗░
-- ██║░░░██║██╔══██╗██║░░░░░██╔══██╗██╔══██╗██╔══██╗
-- ██║░░░██║██████╔╝██║░░░░░██║░░██║███████║██║░░██║
-- ██║░░░██║██╔═══╝░██║░░░░░██║░░██║██╔══██║██║░░██║
-- ╚██████╔╝██║░░░░░███████╗╚█████╔╝██║░░██║██████╔╝
-- ░╚═════╝░╚═╝░░░░░╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░

-- 𝗨𝗽𝗹𝗼𝗮𝗱 𝗮𝗽𝗶 𝗰𝗼𝗻𝗳𝗶𝗴𝘂𝗿𝗮𝘁𝗶𝗼𝗻 𝗺𝗼𝘃𝗲𝗱 𝘁𝗼 𝘀𝗲𝗿𝘃𝗲𝗿.𝗹𝘂𝗮
-- 𝗨𝗽𝗹𝗼𝗮𝗱 𝗮𝗽𝗶 𝗰𝗼𝗻𝗳𝗶𝗴𝘂𝗿𝗮𝘁𝗶𝗼𝗻 𝗺𝗼𝘃𝗲𝗱 𝘁𝗼 𝘀𝗲𝗿𝘃𝗲𝗿.𝗹𝘂𝗮
-- 𝗨𝗽𝗹𝗼𝗮𝗱 𝗮𝗽𝗶 𝗰𝗼𝗻𝗳𝗶𝗴𝘂𝗿𝗮𝘁𝗶𝗼𝗻 𝗺𝗼𝘃𝗲𝗱 𝘁𝗼 𝘀𝗲𝗿𝘃𝗲𝗿.𝗹𝘂𝗮
-- 𝗨𝗽𝗹𝗼𝗮𝗱 𝗮𝗽𝗶 𝗰𝗼𝗻𝗳𝗶𝗴𝘂𝗿𝗮𝘁𝗶𝗼𝗻 𝗺𝗼𝘃𝗲𝗱 𝘁𝗼 𝘀𝗲𝗿𝘃𝗲𝗿.𝗹𝘂𝗮
-- 𝗨𝗽𝗹𝗼𝗮𝗱 𝗮𝗽𝗶 𝗰𝗼𝗻𝗳𝗶𝗴𝘂𝗿𝗮𝘁𝗶𝗼𝗻 𝗺𝗼𝘃𝗲𝗱 𝘁𝗼 𝘀𝗲𝗿𝘃𝗲𝗿.𝗹𝘂𝗮
-- 𝗨𝗽𝗹𝗼𝗮𝗱 𝗮𝗽𝗶 𝗰𝗼𝗻𝗳𝗶𝗴𝘂𝗿𝗮𝘁𝗶𝗼𝗻 𝗺𝗼𝘃𝗲𝗱 𝘁𝗼 𝘀𝗲𝗿𝘃𝗲𝗿.𝗹𝘂𝗮


-- ██████▄░▄█████▄░▄█████░▄██████
-- ██░░░██░██░░░██░██░░░░░██░░░░░
-- ██░░░██░██░░░██░██░░░░░▀█████▄
-- ██░░░██░██░░░██░██░░░░░░░░░░██
-- ██████▀░▀█████▀░▀█████░██████▀
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
--- @param -- Check https://dusadev.gitbook.io/ for documentation
--- @param -- Check https://dusadev.gitbook.io/ for documentation
--- @param -- Check https://dusadev.gitbook.io/ for documentation
--- @param -- Check https://dusadev.gitbook.io/ for documentation





-- ▄██████░▄█████░██████▄░▄█████░█████▄░▄████▄░██░░░░
-- ██░░░░░░██░░░░░██░░░██░██░░░░░██░░██░██░░██░██░░░░
-- ██░░███░█████░░██░░░██░█████░░█████▀░██░░██░██░░░░
-- ██░░░██░██░░░░░██░░░██░██░░░░░██░░██░██████░██░░░░
-- ▀█████▀░▀█████░██░░░██░▀█████░██░░██░██░░██░██████
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

config.OnDutyOnly = true -- Set true if only on duty players can see the alert and open dispatch menu
config.enableBodycam = true
config.TimeFormat = '12h' -- 12h: Shows current time like 5:24 PM | 24h: Shows time like 17:24
config.TimeType = 'real' -- real: Shows real time | game: Shows game time
config.defaultCallsign = 'NO CALLSIGN'
config.IncludePolice = true -- Include police in shooting alerts







-- █████▄░▄█████░█████▄░▄██▄▄██▄░██████░▄██████░▄██████░██████░▄█████▄░██████▄░▄██████
-- ██░░██░██░░░░░██░░██░██░██░██░░░██░░░██░░░░░░██░░░░░░░░██░░░██░░░██░██░░░██░██░░░░░
-- █████▀░█████░░█████▀░██░██░██░░░██░░░▀█████▄░▀█████▄░░░██░░░██░░░██░██░░░██░▀█████▄
-- ██░░░░░██░░░░░██░░██░██░██░██░░░██░░░░░░░░██░░░░░░██░░░██░░░██░░░██░██░░░██░░░░░░██
-- ██░░░░░▀█████░██░░██░██░██░██░██████░██████▀░██████▀░██████░▀█████▀░██░░░██░██████▀
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

-- SET WHICH JOBS CAN ACCESS DISPATCH (DEFAULT 7, JUST CHANGE THE VALUES AT THE RIGHT)
config.dispatchJobs = {
    police = "police",
    sheriff = "sheriff",
    ambulance = "ambulance",
    sasp = "sasp",
    bcso = "bcso",
    ranger = "ranger",
    highway = "highway",
    fib = "fib"
}

config.emsJobs = {
    "ambulance",
    -- "doctor"
}

-- SET MINIMUM JOB GRADE TO ACCESS DISPATCH FULL AUTHORIZATION
config.accessManagement = {
    ["police"] = 4,
    ["sheriff"] = 3,
    ["ambulance"] = 3,
    ["state"] = 3,
    ["bcso"] = 3,
    ["fib"] = 4,
    ["ranger"] = 2,
    ["highway"] = 3,
}







-- ▄██████░█████▄░▄██████
-- ██░░░░░░██░░██░██░░░░░
-- ██░░███░█████▀░▀█████▄
-- ██░░░██░██░░░░░░░░░░██
-- ▀█████▀░██░░░░░██████▀
-- ░░░░░░░░░░░░░░░░░░░░░░
config.CategorizeBlips = true -- Categorize all blips to single category named "DISPATCH" | Image: https://imgur.com/fi8dVBM
config.DispatchBlipCategory = "DISPATCH" -- Category label for dispatch blips
config.enableGPS = true

config.dispatchBlipColors = { -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
    ["police"] = 38,
    ["sheriff"] = 16,
    ["ambulance"] = 1,
    ["sasp"] = 26,
    ["bcso"] = 47,
    ["ranger"] = 25,
    ["highway"] = 50,
    ["fib"] = 50,
}

config.gpsConfiguration = {
    [1] = {
        title = "Police GPS",
        job = "police",
        commonChannels = {
            {
                name = "GENERAL",
                code = "POL-1",
                channel = 1,
            },
            {
                name = "SHARED",
                code = "P-SHA-1",
                channel = 2,
            },
        },
    },
    [2] = {
        title = "Sheriff GPS",
        job = "sheriff",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                code = "SHE-1",
                channel = 3,
            },
            [2] = {
                name = "SHARED",
                code = "S-SHA-1",
                channel = 4,
            },
        },
    },
    [3] = {
        title = "State GPS",
        job = "sasp",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                code = "STA-1",
                channel = 5,
            },
            [2] = {
                name = "SHARED",
                code = "ST-SHA-1",
                channel = 6
            },
        },
    },
    [4] = {
        title = "BCSO GPS",
        job = "bcso",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                code = "BCSO-1",
                channel = 7,
            },
            [2] = {
                name = "SHARED",
                code = "B-SHA-1",
                channel = 8,
            },
        },
    },
    [5] = {
        title = "HIGHWAY GPS",
        job = "highway",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                code = "HP-1",
                channel = 9,
            },
            [2] = {
                name = "SHARED",
                code = "H-SHA-1",
                channel = 10,
            },
        },
    },
    [6] = {
        title = "RANGER GPS",
        job = "ranger",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                code = "RANG-1",
                channel = 11,
            },
            [2] = {
                name = "SHARED",
                code = "R-SHA-1",
                channel = 12,
            },
        },
    },
    [7] = {
        title = "EMS GPS",
        job = "ambulance",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                code = "EMS-1",
                channel = 13,
            },
            [2] = {
                name = "SHARED",
                code = "E-SHA-1",
                channel = 14,
            },
        },
    },
}







-- █████▄░▄████▄░██████▄░██████░▄█████▄
-- ██░░██░██░░██░██░░░██░░░██░░░██░░░██
-- █████▀░██░░██░██░░░██░░░██░░░██░░░██
-- ██░░██░██████░██░░░██░░░██░░░██░░░██
-- ██░░██░██░░██░██████▀░██████░▀█████▀
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
config.radioConfiguration = {
    [1] = {
        title = "Police Radio",
        job = "police",
        commonChannels = {
            {
                name = "GENERAL",
                frequency = 1, -- Radio channel frequency mHz
            },
            {
                name = "SHARED",
                frequency = 1.1, -- Radio channel frequency mHz
            },
        },
    },
    [2] = {
        title = "Sheriff Radio",
        job = "sheriff",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                frequency = 2, -- Radio channel frequency mHz
            },
            [2] = {
                name = "SHARED",
                frequency = 2.1,
            },
        },
    },
    [3] = {
        title = "State Radio",
        job = "sasp",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                frequency = 2, -- Radio channel frequency mHz
            },
            [2] = {
                name = "SHARED",
                frequency = 2.1,
            },
        },
    },
    [4] = {
        title = "BCSO Radio",
        job = "bcso",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                frequency = 3, -- Radio channel frequency mHz
            },
            [2] = {
                name = "SHARED",
                frequency = 3.1,
            },
        },
    },
    [5] = {
        title = "HIGHWAY Radio",
        job = "highway",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                frequency = 5, -- Radio channel frequency mHz
            },
            [2] = {
                name = "SHARED",
                frequency = 5.1,
            },
        },
    },
    [6] = {
        title = "RANGER Radio",
        job = "ranger",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                frequency = 6, -- Radio channel frequency mHz
            },
            [2] = {
                name = "SHARED",
                frequency = 6.1,
            },
        },
    },
    [7] = {
        title = "EMS Radio",
        job = "ambulance",
        commonChannels = {
            [1] = {
                name = "GENERAL",
                frequency = 4, -- Radio channel frequency mHz
            },
            [2] = {
                name = "SHARED",
                frequency = 4.1,
            },
        },
    },
}












-- ▄████▄░██░░░░░▄█████░█████▄░████████░▄██████
-- ██░░██░██░░░░░██░░░░░██░░██░░░░██░░░░██░░░░░
-- ██░░██░██░░░░░█████░░█████▀░░░░██░░░░▀█████▄
-- ██████░██░░░░░██░░░░░██░░██░░░░██░░░░░░░░░██
-- ██░░██░██████░▀█████░██░░██░░░░██░░░░██████▀
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

-- Keybinds
config.RespondKeybind = 'G' -- Keybind to respond to alerts, mark them as handled
config.OpenDispatchSettings = 'O' -- Keybind to open dispatch alert settings

config.DeleteOldAlerts = true -- Delete old alerts after a certain number of alerts
config.AlertLimit = 3
config.AlertTimeout = 10 -- Each alert will be removed after desired minute (default: 10 minutes)

config.mistakeForAlerts = false -- If true, the alerts will be offset by a random amount
config.MinOffset = 1 -- Minimum mistake offset for alerts
config.MaxOffset = 120 -- Maximum mistake offset for alerts

config.DefaultAlertsDelay = 5 -- Delay between each default alert, prevent spamming
config.DefaultAlerts = {
    Speeding = false,
    Shooting = true,
    Autotheft = true,
    Melee = false,
    PlayerDowned = true,
    Explosion = false
}

-- Specify hunting and zones that will not send alerts
config.Locations = {
    ["HuntingZones"] = {
        [1] = {label = "Hunting Zone", radius = 250.0, coords = vector3(-938.61, 4823.99, 313.92)},
    },
    ["NoDispatchZones"] = {
        [1] = {label = "Ammunation 1", coords = vector3(13.53, -1097.92, 29.8), length = 14.0, width = 5.0, heading = 70, minZ = 28.8, maxZ = 32.8},
        [2] = {label = "Ammunation 2", coords = vector3(821.96, -2163.09, 29.62), length = 14.0, width = 5.0, heading = 270, minZ = 28.62, maxZ = 32.62},
    },
}

-- Prevent weapons to be alerted
config.WeaponWhitelist = {
    'WEAPON_GRENADE',
    'WEAPON_BZGAS',
    'WEAPON_MOLOTOV',
    'WEAPON_STICKYBOMB',
    'WEAPON_PROXMINE',
    'WEAPON_SNOWBALL',
    'WEAPON_PIPEBOMB',
    'WEAPON_BALL',
    'WEAPON_SMOKEGRENADE',
    'WEAPON_FLARE',
    'WEAPON_PETROLCAN',
    'WEAPON_FIREEXTINGUISHER',
    'WEAPON_HAZARDCAN',
    'WEAPON_RAYCARBINE',
    'WEAPON_STUNGUN'
}

-- credit goes to ps-dispatch
config.AlertOptions = {
    ['vehicleshots'] = { -- Need to match the codeName in alerts.lua
        radius = 0,
        sprite = 119,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = false
    },
    ['shooting'] = {
        radius = 0,
        sprite = 110,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['speeding'] = {
        radius = 0,
        sprite = 326,
        color = 84,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = false
    },
    ['fight'] = {
        radius = 0,
        sprite = 685,
        color = 69,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = false
    },
    ['civdown'] = {
        radius = 0,
        sprite = 126,
        color = 3,
        scale = 1.5,
        length = 2,
        sound = 'dispatch',
        offset = false,
        flash = false,
        takescreenshot = false
    },
    ['civdead'] = {
        radius = 0,
        sprite = 126,
        color = 3,
        scale = 1.5,
        length = 2,
        sound = 'dispatch',
        offset = false,
        flash = false,
        takescreenshot = false
    },
    ['911call'] = {
        radius = 0,
        sprite = 480,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = false
    },
    ['311call'] = {
        radius = 0,
        sprite = 480,
        color = 3,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = false
    },
    ['officerdown'] = {
        radius = 15.0,
        sprite = 526,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'panicbutton',
        offset = false,
        flash = true,
        takescreenshot = true
    },
    ['officerbackup'] = {
        radius = 15.0,
        sprite = 526,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'panicbutton',
        offset = false,
        flash = true,
        takescreenshot = true
    },
    ['officerdistress'] = {
        radius = 15.0,
        sprite = 526,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'panicbutton',
        offset = false,
        flash = true,
        takescreenshot = true
    },
    ['emsdown'] = {
        radius = 15.0,
        sprite = 526,
        color = 3,
        scale = 1.5,
        length = 2,
        sound = 'panicbutton',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['hunting'] = {
        radius = 0,
        sprite = 141,
        color = 2,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['storerobbery'] = {
        radius = 0,
        sprite = 52,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['bankrobbery'] = {
        radius = 0,
        sprite = 500,
        color = 2,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['paletobankrobbery'] = {
        radius = 0,
        sprite = 500,
        color = 12,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['pacificbankrobbery'] = {
        radius = 0,
        sprite = 500,
        color = 5,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['prisonbreak'] = {
        radius = 0,
        sprite = 189,
        color = 59,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['vangelicorobbery'] = {
        radius = 0,
        sprite = 434,
        color = 5,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['houserobbery'] = {
        radius = 0,
        sprite = 40,
        color = 5,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['suspicioushandoff'] = {
        radius = 120.0,
        sprite = 469,
        color = 52,
        scale = 0,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = true,
        flash = false,
        takescreenshot = true
    },
    ['yachtheist'] = {
        radius = 0,
        sprite = 455,
        color = 60,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['vehicletheft'] = {
        radius = 0,
        sprite = 595,
        color = 60,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = false
    },
    ['signrobbery'] = {
        radius = 0,
        sprite = 358,
        color = 60,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['susactivity'] = {
        radius = 0,
        sprite = 66,
        color = 37,
        scale = 0.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = false
    },
    -- Rainmad Scripts
    ['artgalleryrobbery'] = {
        radius = 0,
        sprite = 269,
        color = 59,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['humanelabsrobbery'] = {
        radius = 0,
        sprite = 499,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['trainrobbery'] = {
        radius = 0,
        sprite = 667,
        color = 78,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['vanrobbery'] = {
        radius = 0,
        sprite = 67,
        color = 59,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['undergroundrobbery'] = {
        radius = 0,
        sprite = 486,
        color = 59,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['drugboatrobbery'] = {
        radius = 0,
        sprite = 427,
        color = 26,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['unionrobbery'] = {
        radius = 0,
        sprite = 500,
        color = 60,
        scale = 1.5,
        length = 2,
        sound = 'robberysound',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['carboosting'] = {
        radius = 0,
        sprite = 595,
        color = 60,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['carjack'] = {
        radius = 0,
        sprite = 595,
        color = 60,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = false,
        flash = false,
        takescreenshot = true
    },
    ['explosion'] = {
        radius = 75.0,
        sprite = 436,
        color = 1,
        scale = 1.5,
        length = 2,
        sound = 'Lose_1st',
        sound2 = 'GTAO_FM_Events_Soundset',
        offset = true,
        flash = false,
        takescreenshot = false
    }
}











-- █████▄░▄████▄░██████▄░▄████▄░█████▄
-- ██░░██░██░░██░██░░░██░██░░██░██░░██
-- █████▀░██░░██░██░░░██░██░░██░█████▀
-- ██░░██░██████░██░░░██░██████░██░░██
-- ██░░██░██░░██░██████▀░██░░██░██░░██
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

config.RadarKeys = {
    enabled = true, -- Enable or disable the radar key
    -- Keylist can be found at 'keylist.lua'
    combinedkeys = {'LEFTCTRL', 'E'}, -- Combined keys to open the radar | Default Ctrl + E
}

config.RadarVehicles = { -- Add your addon or normal vehicles to here to enable radar feature on them (police class vehicles are already included)
    'oracle2'
}




-- ▄█████░▄█████▄░▄██▄▄██▄░▄██▄▄██▄░▄████▄░██████▄░██████▄░▄██████
-- ██░░░░░██░░░██░██░██░██░██░██░██░██░░██░██░░░██░██░░░██░██░░░░░
-- ██░░░░░██░░░██░██░██░██░██░██░██░██░░██░██░░░██░██░░░██░▀█████▄
-- ██░░░░░██░░░██░██░██░██░██░██░██░██████░██░░░██░██░░░██░░░░░░██
-- ▀█████░▀█████▀░██░██░██░██░██░██░██░░██░██░░░██░██████▀░██████▀
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

-- Manage all commands for each feature

config.Commands = {
    ['dispatch'] = { -- Open dispatch menu
        enabled = true,
        command = 'dispatch',
        help = 'Open Dispatch Menu',
        event = 'dusa_dispatch:openDispatch'
    },
    ['alert'] = { -- Open alert GUI
        enabled = true,
        command = 'alert',
        help = 'Open alert GUI',
        event = 'dusa_dispatch:ToggleAlert'
    },
    ['radar'] = { -- Toggle radar (Can be opened with Ctrl+E combination too)
        enabled = true,
        command = 'radar',
        help = 'Toggle radar',
        event = 'dusa_dispatch:ToggleRadar'
    },
    ['radarsettings'] = { -- Open radar settings
        enabled = true,
        command = 'radarsettings',
        help = 'Open radar settings',
        event = 'dusa_dispatch:OpenRadarSettings'
    },
    ['bodycam'] = { -- Toggle bodycam
        enabled = true,
        command = 'bodycam',
        help = 'Toggle bodycam',
        event = 'dusa_dispatch:openBodycam'
    },
}








-- ▄█████░▄████▄░▄██▄▄██▄░▄█████░█████▄░▄████▄
-- ██░░░░░██░░██░██░██░██░██░░░░░██░░██░██░░██
-- ██░░░░░██░░██░██░██░██░█████░░█████▀░██░░██
-- ██░░░░░██████░██░██░██░██░░░░░██░░██░██████
-- ▀█████░██░░██░██░██░██░▀█████░██░░██░██░░██
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

-- Camera movement sensitivity
config.CameraSensivity = {
    Right = 1,
    Left = 1,
    Up = 1,
    Down = 1
}

-- Prop list of cameras
config.cameraList = {     
    [1] = 'prop_cctv_cam_06a',
    [2] = 'prop_cctv_cam_04a',
    [3] = 'prop_cctv_cam_05a',
    [4] = 'prop_cctv_cam_02a',
    [5] = 'prop_cctv_cam_01a',
    [6] = 'prop_cctv_cam_07a',
    [7] = 'prop_cctv_cam_01b',
    [8] = 'prop_cctv_cam_04b',
    [9] = 'prop_cctv_cam_03a',
    [10] = 'prop_cctv_cam_04c',
    [11] = 'prop_cs_cctv',
    [12] = 'hei_prop_bank_cctv_01',
    [13] = 'hei_prop_bank_cctv_02',
    [14] = 'p_cctv_s',
    [15] = 'prop_snow_cam_03a',
    [16] = 'prop_spycam'
}
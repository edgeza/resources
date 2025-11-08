------------------------------------------------------------------------------------
------------------------------- night_air_raid_sirens ------------------------------
------------------------------------------------------------------------------------
-------------------------------------- Config --------------------------------------
------------------------------------------------------------------------------------

Config = {

    Debug = false,

    --====================== Permissions ======================--
    
    EveryoneHasPermission = false,

    Enable_Night_DiscordApi_Permissions = false,    -- server/s_functions.lua
    Enable_Ace_Permissions = true,                 -- server/s_functions.lua
    Enable_ESX_Permissions = false,                 -- client/c_functions.lua & server/s_functions.lua
    Enable_QBCore_Permissions = {                   
        Check_By_Job = false,                       -- client/c_functions.lua & server/s_functions.lua
        Check_By_Permissions = false,               -- server/s_functions.lua
    },

    PermissionRoles = {     -- Fill in: Discord API Role Names / ESX Jobs / Ace group names / QB Jobs and/or Groups
        -- Discord API Examples
        "Manager",
        "Development_Team",
        "Senior_Admin",
        "Admin",
        "Essex_Police_Force",
        "British_Transport_Police",
        "Ambulance_Service",
        "Fire_Service",
        -- ESX or QB Job examples
        "police",
        "ambulance",
        "fire",
        -- Ace Permissions examples
        "Administrator",
        "Supporter",
        "Tester",
    },

    --====================== Commands ======================--
    Commands = {
        ToggleSirens = "togglears",             -- Toggles the Air Raid Sirens for the client. (Disables sound)
        OpenARSMenu = "arsmenu",                -- Opens the Air Raid Siren Menu
        DrawCoverage = "drawcoverage",          -- Test the coverage of your placed siren objects' soundreach. it enables markers in-air so you can float above the city and see the coverage. 
    },

    --====================== Hotkeys ======================--
    HotKeys = {
        OpenARSMenu = 121,                       -- INSERT by Default [https://docs.fivem.net/docs/game-references/controls/]
    },

    --====================== Sound Settings ======================--
    SirenSoundFileList = { -- Add .ogg files to your NUI/sounds/ folder.
        [1] = {SoundFile = "air-raid-siren", DisplayName = "Default Air Raid Sirens"},
        [2] = {SoundFile = "luchtsirene", DisplayName = "Dutch Air Raid Sirens"},
        -- [3] = {SoundFile = "luchtsirene", DisplayName = "Add more siren files to your sound folder and list them here!"},
        -- [4] = {SoundFile = "air-raid-siren", DisplayName = "Add more siren files to your sound folder and list them here!"},
    },
    SirenSoundReach = 1250.0,                   -- Change to your liking. Default = 1250 gta meters.
    SirenSoundVolume = 0.10,                    -- NOT RECOMMENDED above 0.5. You've only got 2 ears, if they function keep it that way :)
    OutOfRangeInterval = 2.5,                   -- Seconds. Interval to check whether you are in range of an Air Raid Siren.

    --====================== Notification settings ======================--
    NativeMessages = true,                      -- TRUE = native msg system | FALSE = Use your own created clientside function in c_functions.lua
    NativeServerMessages = true,                -- TRUE = native msg system | FALSE = Use your own created serverside function in s_functions.lua

    --====================== ARS Control Panel settings ======================--
    ARSControlPanelTitle = "ARS Control Panel",

    --====================== Blips ======================--
    AirRaidSirensBlipsEnabled = true,           -- Enable volume pulses as blips on the map when the sirens are activated for each siren object.
    AirRaidSirensBlipsData = {
        blipName = "Air Raid Sirens",
        blipID = 161,
        blipColour = 1,
        blipScale = 1.0,
    },

    --====================== Markers ======================--
    AirRaidSirensMarkersEnabled = false,        -- Enable or disable markers for the air raid siren objects. These will appear once the siren has been triggered.
    MarkerData = {
        ID = 28,                    -- Marker ID
        red = 255,                  -- Red
        green = 0,                  -- Green
        blue = 0,                   -- Blue
        alpha = 50,                 -- Alpha (Opacity)
        RX = 0,                     -- Roration X
        RY = 0,                     -- Roration Y
        RZ = 0,                     -- Roration Z
    },

    --====================== Siren Objects ======================--
    EnableObjects = true,                       -- Set to false to disable the objects from spawning and just use the sirens. [if true you should not restart the script in-game, it will crash due to objects]
    SirenObjectModelName = `neko_nw_ar_siren`,  -- Change this to something you think suits best. You can even edit props and make an actual tower which suits your country.
    SirenObjectLocations = {                    -- Enter coordinates you wish your objects to spawn from which the siren will sound.
        -- Paleto Bay
        [1] = {x = -138.31, y = 6363.59, z = 31.49, h = 132.15},
        [2] = {x = -434.79, y = 5982.44, z = 31.49, h = 316.18},
        [3] = {x = -198.83, y = 6520.91, z = 11.10, h = 31.40},
        [4] = {x = -510.68, y = 5225.77, z = 87.07, h = 48.14},
        -- Sandy Shores
        [5] = {x = 1691.21, y = 3775.83, z = 34.74, h = 212.69},
        [6] = {x = 319.92, y = 3387.17, z = 36.40, h = 18.63},
        [7] = {x = 238.03, y = 2599.82, z = 45.24, h = 42.84},
        -- Wind Farm
        [8] = {x = 2132.52, y = 1932.72, z = 93.81, h = 91.77},
        -- Grapeseed
        [9] = {x = 1729.83, y = 4823.10, z = 40.88, h = 98.01},
        -- Prison
        [10] = {x = 1848.21, y = 2617.71, z = 45.66, h = 265.07},
        -- Freeway EAST
        [11] = {x = 1512.82, y = 759.29, z = 77.71, h = 18.28},
        -- Los Santos
        [12] = {x = 472.60, y = -98.50, z = 123.70, h = 163.25},
        [13] = {x = 772.85, y = -1276.44, z = 47.10, h = 358.40},
        [14] = {x = -9.51, y = -794.73, z = 44.48, h = 248.98},
        [15] = {x = -1254.31, y = -270.26, z = 38.92, h = 294.42},
        [16] = {x = -791.19, y = -1463.49, z = 5.00, h = 107.82},
        [17] = {x = -350.36, y = -1346.16, z = 31.28, h = 175.32},
        [18] = {x = 349.89, y = -1593.86, z = 29.29, h = 316.72},
        [19] = {x = -831.52, y = -2057.83, z = 9.39, h = 49.64},
        [20] = {x = -1761.86, y = -2818.16, z = 13.94, h = 240.06}, 
        [21] = {x = -1203.09, y = 896.19, z = 194.91, h = 214.29}, 
        [22] = {x = -2303.20, y = 261.22, z = 194.60, h = 112.79},
        [23] = {x = -2508.95, y = 3006.78, z = 32.92, h = 204.69},
        [24] = {x = -486.18, y = -288.51, z = 35.46, h = 18.30},
        [25] = {x = -1646.07, y = -979.86, z = 7.52, h = 47.02},
        [26] = {x = 1274.75, y = -385.99, z = 69.06, h = 129.47},
        [27] = {x = 1157.60, y = -2215.11, z = 30.81, h = 84.40},
        [28] = {x = 587.00, y = -2869.86, z = 6.05, h = 263.65},
        [29] = {x = 150.95, y = -3339.16, z = 6.02, h = 178.38},
        [30] = {x = -1019.04, y = -2700.44, z = 13.75, h = 329.52},
        [31] = {x = -912.65, y = -3103.84, z = 13.94, h = 58.81},
        [32] = {x = -175.27, y = -2520.87, z = 6.02, h = 355.88},
        [33] = {x = 137.20, y = 774.10, z = 210.43, h = 45.94},
        -- Mountains
        [34] = {x = -949.49, y = 4840.91, z = 313.17, h = 68.70},  
        [35] = {x = 476.85, y = 5540.52, z = 785.40, h = 269.83},  
    },

    --====================== Discord Webhook ======================--
    DiscordNotificationsEnabled = true,  -- Enable or disable discord notifications.
    DiscordWebhook = nil,                -- DO NOT CHANGE HERE!! | Set this inside s_functions.lua on top of the script!! 
    DiscordMessageTitle = "AIR RAID SIRENS",
    DiscordMessageDescription = "Air Raid Sirens have been toggled!",
    DiscordMessageText = "The government advises you to stay indoors and stay sharp for any news. You will be informed as soon as possible of the ongoing emergency!",
    DiscordFooterText = "Nights Software © ",
    DiscordWebhookImage = "https://i.imgur.com/DqC7TB5.png",            
    DiscordWebhookFooterImage = "https://i.imgur.com/cHYaWf3.png",
    DiscordWebhookName = "Air Raid Sirens!",
    DiscordNameTitle = "**TOGGLED BY:**",
    DiscordAlertTitle = "**ALERT:**",

    --====================== Language Settings ======================--
    Messages = {
        ErrorSyntax = "^1ERROR ",
        StillCoolingDown = "🗙 ARS recently activated, try again in 2.5 seconds to turn them off.",
        JustActivated = "🗙 ARS on cooldown, wait 2.5 seconds.",
        IgnoreSirensCommandHelpText = 'Toggle to enable or disable sounds from the Air Raid Sirens.',
        OpenARSMenuHelpText = 'Opens Air Raid Sirens control panel.',
        DrawCoverageHelpText = 'Draws markers above the ground to reproduce sound reach of the Air Raid Sirens.',
        NoPermission = "You do not have the required permissions.",
        ToggledSirensOn = "You've toggled air raid sirens sound ~g~on~w~.",
        ToggledSirensOff = "You've toggled air raid sirens sound ~r~off~w~.",
        ToggledDrawCoverageOn = "You've toggled drawing coverage ~g~on~w~.",
        ToggledDrawCoverageOff = "You've toggled drawing coverage ~r~off~w~.",
    },
}

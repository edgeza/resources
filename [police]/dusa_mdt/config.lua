----------------------------------------------------------------
----                   DUSADEV.TEBEX.IO                     ----
----------------------------------------------------------------
config = {}
config.debug = false

--- @param -- Check https://dusadev.gitbook.io/dusa-all-scripts-documentation for documentation

------------------------GENERAL OPTIONS------------------------
---------------------------------------------------------------
config.separateMdt = true -- If true, MDT data will be separate for each job. If you want to set it shared between all jobs, set it to false
config.JobThemes = { -- red blue purple orange aqua green white black
    ['police'] = 'blue',
    ['state'] = 'aqua',
    ['sheriff'] = 'orange',
    ['bcso'] = 'red',
    ['highway'] = 'purple',
    ['ranger'] = 'green',
}
config.defaultlanguage = 'en' -- Default language for the MDT | en, de, es, fr, pt, tr, it, af, bg, da, el, et, fi, hu, lb, lt, pl, ro, ru, sr, sv, zh
config.billing = 'scriptname' -- dusabilling, quasarbilling, codestudiobilling, okokbilling, esxbilling, jimpayment, jaksam
config.jail = 'scriptname' -- pickle, esxjail, rcore, tkjail
config.communityservice = 'scriptname' -- esxcommunityservice, qbcommunityservice
config.Webhook = 'https://discordapp.com/api/webhooks/1212186619117838437/dXljYYvqkBpbmfW3vhrM_A1xp2286ix_WoQudx4fwWRn6jkZYavKURf6WtjXHJVfOqZm' -- Images will be uploaded here
config.alerttimeout = 2 * 60000 -- 2 minute default
config.excelLink = 'https://docs.google.com/document/d/1xYT1TaxQ_hmnPa2XXfkrBqQA_-7N0qrluI9VPWagdKI/edit?rm=minimal' -- Link to the excel sheet, this is used for the Excel tab 
config.policejobs = { -- list of jobs who can access the MDT
    "police",
    "bcso"
    -- "sheriff",
    -- "state"
}
config.Timeout = 3 -- Specifies the timeout between search operations | Default: 3 seconds
config.EnableDiscordLog = true
config.DiscordWebhook = {
    ['chat'] = "",
    ['wanted'] = "",
    ['wantedvehicles'] = "",
    ['incidents'] = "",
    ['fines'] = "",
    ['bolos'] = "",
    ['reports'] = "",
    ['evidence'] = "",
    ['givelicense'] = "",
    ['user_charge'] = "",
    ['forms'] = "",
    ['camera'] = "",
    ['livemap'] = "",
    ['commands'] = "",
    ['mugshot'] = "",
}

config.ConfigureLog = {
    name = "Dusa Police MDT Log",
    imageurl = "https://i.imgur.com/bRg4YAh.png"
}

------------------------------MDT------------------------------
---------------------------------------------------------------
config.mdtAsItem = false -- If true, players will need a MDT item to open the MDT
config.mdtItem = 'mdt' -- Item name
config.mdtCommand = 'mdt' -- If item set to false, this command will be used to open the MDT
config.requireGrade = false -- If true, players will need a job grade to access the MDT
config.minGradeToOpen = 2 -- Minimum job grade to access the MDT

------------------------EMERGENCY ALERT------------------------
---------------------------------------------------------------
config.EnableEmergencyCommands = true
config.EmergencyCommands = {
    leery = 'leery',
    danger = 'danger',
}

config.EnableEmergencyKeybind = true
config.EmergencyTimeout = 60 -- Timeout between per emergency alert (seconds)
config.EmergencyKeybinds = {
    leery = 'NUMPAD1',
    danger = 'NUMPAD2'
}

---------------------------PERMISSIONS-------------------------
-- Set permissions for each category
-- Number values meaning player job grade level, if you set it to 0, everyone can access it. If you set it to 1 or more, only players with that job grade level or higher can access it.
config.permissions = {
    ['incident'] = 0,
    ['fines'] = 0,
    ['evidence'] = 0,
    ['givelicense'] = 0,
    ['chargeuser'] = 0,
    ['commands'] = 0,
    ['forms'] = 0,
}

-- disable features from charges
-- true means it will be enabled
-- false means it will be disabled
config.enable = {
    ['communityservice'] = true,
    ['jail'] = true,
    ['fine'] = true,
}

---------------------------LICENSES----------------------------
---------------------------------------------------------------
config.licenses = {
    [1] = {id = 1, name = "Driver's License", type = "driver"}, -- default qb
    [2] = {id = 2, name = "Firearm License", type = "weapon"}, -- default qb
    
    -- example license types
    -- [3] = {id = 3, name = "Pilot License", type = "pilot"},
    -- [4] = {id = 4, name = "Boating License", type = "boating"},
    -- [5] = {id = 5, name = "Fishing License", type = "fishing"},
    -- [6] = {id = 6, name = "Hunting License", type = "hunting"},
    -- [7] = {id = 7, name = "Commercial Driver's License", type = "commercial"},
    -- [8] = {id = 8, name = "Motorcycle License", type = "motorcycle"},
    -- [9] = {id = 9, name = "Taxi License", type = "taxi"},
    -- [10] = {id = 10, name = "Gun License", type = "gun"},
}


-----------------------------CAMERAS---------------------------
---------------------------------------------------------------
config.cameraOptions = {
    isItem = false, -- If true, players will need a camera item to place cameras
    item = 'camera', -- Item name
    command = 'camera', -- Command name (only available if isItem set to false)
    removecommand = 'removecamera', -- Command name to remove cameras
    mingrade = 0, -- Minimum job rank to place cameras
    isHackItem = false, -- If true, players will need a hack item to hack cameras
    hackItem = 'hacktablet', -- Item name
    hackCommand = 'hack', -- Command name (only available if isHackItem set to false)
    repaircommand = 'repaircamera', -- Command name to repair hacked cameras
}

config.cameras = {
    [1] = {id = 1, title = "Camera 1", location = "Prison #1", coords = vector3(1768.84, 2530.96, 50.06), r = {x = -15.0, y = 0.0, z = 42.78}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/prison1.png'},
    [2] = {id = 2, title = "Camera 2", location = "Prison #2", coords = vector3(1616.35, 2522.01, 50.12), r = {x = -15.0, y = 0.0, z = 300.78}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/prison1.png'},
    [3] = {id = 3, title = "Camera 3", location = "Prison #3", coords = vector3(1694.99, 2529.18, 59.00), r = {x = -15.0, y = 0.0, z = 300.78}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/prison1.png'},
    [4] = {id = 4, title = "Camera 4", location = "Pacific Bank #1", coords = vector3(235.35, 227.76, 113.83), r = {x = -35.0, y = 0.0, z = 220.05}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/pacific1.png'},
    [5] = {id = 5, title = "Camera 5", location = "Pacific Bank #2", coords = vector3(232.64, 221.82, 108.47), r = {x = -25.0, y = 0.0, z = -140.91}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/pacific2.png'},
    [6] = {id = 6, title = "Camera 6", location = "Pacific Bank #3", coords = vector3(251.83, 225.38, 104.50), r = {x = -35.0, y = 0.0, z = -74.87}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/pacific3.png'},
    [7] = {id = 7, title = "Camera 7", location = "Jewelery #1", coords = vector3(-620.28, -224.15, 40.32), r = {x = -25.0, y = 0.0, z = 165.78}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/jewel1.png'},
    [8] = {id = 8, title = "Camera 8", location = "Jewelery #2", coords = vector3(-627.47, -239.98, 40.30), r = {x = -25.0, y = 0.0, z = -10.78}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/jewel2.png'},
    [9] = {id = 9, title = "Camera 9", location = "Paleto Bank #1", coords = vector3(-115.40, 6472.91, 33.00), r = {x = -25.0, y = 0.0, z = 200.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/paleto1.png'},
    [10] = {id = 10, title = "Camera 10", location = "Paleto Bank #2", coords = vector3(-108.02, 6462.61, 33.40), r = {x = -25.0, y = 0.0, z = 360.00}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/paleto2.png'},
    [11] = {id = 11, title = "Camera 11", location = "Paleto Bank #3", coords = vector3(-104.62, 6479.42, 33.38), r = {x = -25.0, y = 0.0, z = 182.00}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/paleto3.png'},
    [12] = {id = 12, title = "Camera 12", location = "Paleto Bank #4", coords = vector3(-107.89, 6468.54, 33.90), r = {x = -25.0, y = 0.0, z = 216.00}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/paleto4.png'},
    [13] = {id = 13, title = "Camera 13", location = "Fleeca Bank #1-1", coords = vector3(146.52, -1038.20, 30.72), r = {x = -25.0, y = 0.0, z = 250.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca11.png'},
    [14] = {id = 14, title = "Camera 14", location = "Fleeca Bank #1-2", coords = vector3(150.01, -1051.31, 31.10), r = {x = -25.0, y = 0.0, z = 25.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca12.png'},
    [15] = {id = 15, title = "Camera 15", location = "Fleeca Bank #2-1", coords = vector3(1179.08, 2705.60, 39.40), r = {x = -25.0, y = 0.0, z = 90.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca21.png'},
    [16] = {id = 16, title = "Camera 16", location = "Fleeca Bank #2-2", coords = vector3(1171.28, 2716.70, 39.82), r = {x = -25.0, y = 0.0, z = 225.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca22.png'},
    [17] = {id = 17, title = "Camera 17", location = "Fleeca Bank #3-1", coords = vector3(-1216.80, -331.46, 39.0), r = {x = -25.0, y = 0.0, z = 290.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca31.png'},
    [18] = {id = 18, title = "Camera 18", location = "Fleeca Bank #3-2", coords = vector3(-1204.83, -337.83, 39.51), r = {x = -25.0, y = 0.0, z = 80.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca32.png'},
    [19] = {id = 19, title = "Camera 19", location = "Fleeca Bank #4-1", coords = vector3(-2963.95, 478.96, 17.06), r = {x = -25.0, y = 0.0, z = 350.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca41.png'},
    [20] = {id = 20, title = "Camera 20", location = "Fleeca Bank #4-2", coords = vector3(-2952.67, 486.13, 17.47), r = {x = -25.0, y = 0.0, z = 140.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca42.png'},
    [21] = {id = 21, title = "Camera 21", location = "Fleeca Bank #5-1", coords = vector3(310.85, -276.56, 55.47), r = {x = -25.0, y = 0.0, z = 250.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca51.png'},
    [22] = {id = 22, title = "Camera 22", location = "Fleeca Bank #5-2", coords = vector3(314.34, -289.67, 56.23), r = {x = -25.0, y = 0.0, z = 25.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca52.png'},
    [23] = {id = 23, title = "Camera 23", location = "Fleeca Bank #6-1", coords = vector3(-354.35, -47.43, 50.69), r = {x = -25.0, y = 0.0, z = 250.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca61.png'},
    [24] = {id = 24, title = "Camera 24", location = "Fleeca Bank #6-2", coords = vector3(-350.62, -60.48, 50.76), r = {x = -25.0, y = 0.0, z = 25.1595}, img = 'https://dusacdn-65128.s3.eu-north-1.amazonaws.com/fleeca62.png'},
}

-----------------------------MUGSHOT---------------------------
---------------------------------------------------------------
config.mugshot = {
    locations = {
        vec3(436.8, -990.5, 30.6),
    },
    archiveLocations = {
        vec3(441.5, -996.0, 30.6),
    },
}

config.MugshotLocation = vector3(436.5, -993.4, 29.6) -- Location of the Suspect
config.MugshotSuspectHeading = 272.1 -- Direction Suspsect is facing
config.MugShotCamera = {
    x = 437.9,
    y = -993.2,
    z = 30.6,
    r = {x = 0.0, y = 0.0, z = 87.8} -- To change the rotation use the z. Others are if you want rotation on other axis
}

config.BoardHeader = "Los Santos Police Department" -- Header that appears on the board
config.WaitTime = 2000 -- Time before and after the photo is taken. Decreasing this value might result in some angles being skiped.
config.Photos = 4 -- Front, Back Side. Use 4 for both sides
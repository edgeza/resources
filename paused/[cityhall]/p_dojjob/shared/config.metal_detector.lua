Config.Metal_Detector = {}

Config.Metal_Detector.Points = {
    ['CH_1'] = {
        coords = vector3(-557.42, -199.36, 38.23),
        cooldown = 10, -- cooldown per player in seconds [to prevent spam]
    },
    ['CH_2'] = {
        coords = vector3(-557.63, -198.88, 38.23),
        cooldown = 10, -- cooldown per player in seconds [to prevent spam]
    },
    ['CH_3'] = {
        coords = vector3(-562.86, -202.0, 43.37),
        cooldown = 10, -- cooldown per player in seconds [to prevent spam]
    },
    ['CH_4'] = {
        coords = vector3(-562.76, -202.49, 43.37),
        cooldown = 10, -- cooldown per player in seconds [to prevent spam]
    },

    -- FM CITY HALL LS
    -- ['LS_1'] = {
    --     coords = vector3(-546.4811, -627.0413, 35.6031),
    --     cooldown = 10, -- cooldown per player in seconds [to prevent spam]
    -- },
    -- ['LS_2'] = {
    --     coords = vector3(-562.75, -202.19, 43.37),
    --     cooldown = 10, -- cooldown per player in seconds [to prevent spam]
    -- },
}

Config.Metal_Detector.Items = { -- which items will be detected
    ['weapon_'] = true, -- all weapons
    ['WEAPON_'] = true, -- all weapons
}
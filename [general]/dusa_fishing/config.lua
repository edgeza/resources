----------------------------------------------------------------
----                   DUSADEV.TEBEX.IO                     ----
----------------------------------------------------------------
config = {}
config.debug = false -- For debugging purposes
config.locale = 'en' -- en / de / tr / es / fr
--- @param -- Check https://dusadev.gitbook.io for documentation

config.HighlightFish = true -- Highlight fish ped [Yellow outline]
config.levelSystem = { -- Required XP for each level
    [1] = {
        level = 1,
        xp = 100,
        price = 1000
    },
    [2] = {
        level = 2,
        xp = 350,
        price = 2000
    },
    [3] = {
        level = 3,
        xp = 500,
        price = 3000
    },
    [4] = {
        level = 4,
        xp = 1050,
        price = 4000
    },
}

--[[
    You can add new items to the shop list here.
    The name option is used to determine the name of the item.
    The description option is used to determine the description of the item.
    The itemCode option is used to determine the item code of the item.
    The price option is used to determine the price of the item.
    The img option is used to determine the image of the item.
    The minLevel option is used to determine the level required to buy the item.
    The type option is used to determine the type of the item. (common, rare, epic, legendary)
]]
config.shop = {
    [1] = {
        name = 'Fishing Rod',
        description = 'Buy a rod that depends on your fishing level.',
        itemCode = 'rod_1', -- This one doesnt matter for rod, it will be changed by the system. It will automatically replace player rod with player's level rod.
        price = 100,
        img = 'rod_1',
        minLevel = 1,
        type = 'common'
    },
    [2] = {
        name = 'Worm',
        description = 'A basic worm to catch small fishes.',
        itemCode = 'worm',
        price = 100,
        img = 'worm',
        minLevel = 1,
        type = 'common'
    },
    [3] = {
        name = 'Shrimp Lure',
        description = 'A shrimp lure to catch better fishes',
        itemCode = 'shrimp_lure',
        price = 100,
        img = 'shrimplure',
        minLevel = 2, 
        type = 'legendary'
    },
    [4] = {
        name = 'Tackle Box',
        description = 'A tackle box to store your fishing gear',
        itemCode = 'tackle_box',
        price = 100,
        img = 'tackle_box',
        minLevel = 3, 
        type = 'epic'
    },
}

--[[
    You can add new fish species to the fish list here.
    The typeLabel option is used to determine the label of the fish. (COMMON, RARE, EPIC, LEGENDARY)
    The price option is used to determine the sale price of the fish.
    The chance option is used to determine the chance of catching the fish.
    The model option is used to determine the model of the fish.
    The difficulty option is used to determine the difficulty of catching the fish. (easy, medium, hard)
    The xpreward option is used to determine the experience reward for catching the fish.
    The requiredLevel option is used to determine the level required to catch the fish.
    The baits option is used to determine the bait required to catch the fish.
]]
config.fishlbs = false -- Enabling metadata for fish weight, more weight = more money. Disabling this completely removes the weight system. [W.I.P.] WILL BE ADDED WITH 1.2 UPDATE

--[[
    !IMPORTANT!
    !IMPORTANT!

    Fish prices moved to config_server.lua
]]
config.fish = {
    ['mullet'] = {
        name = 'mullet', -- do not change this value
        label = 'Mullet', -- edit this value for shown name at UI
        description = 'Mullet is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'common',
        typeLabel = 'COMMON',
        -- price = 50, -- Price configurations moved to server_config.lua
        chance = 70,
        model = 'prop_lm_fish2_medium',
        difficulty = 'easy',
        xpreward = 5,
        requiredLevel = 1,
        baits = { 'worm'} -- Fishing Level 1/4
    },
    ['perch'] = {
        name = 'perch', -- do not change this value
        label = 'Perch', -- edit this value for shown name at UI
        description = 'Perch is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'common',
        typeLabel = 'COMMON',
        -- price = 50,  -- Price configurations moved to server_config.lua
        chance = 70,
        model = 'prop_lm_fish2_small',
        difficulty = 'easy',
        xpreward = 5,
        requiredLevel = 1,
        baits = { 'worm'} -- Fishing Level 1/4
    },
    ['bass'] = {
        name = 'bass', -- do not change this value
        label = 'Bass', -- edit this value for shown name at UI
        description = 'Bass is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'rare',
        typeLabel = 'RARE',
        -- price = 50,  -- Price configurations moved to server_config.lua
        chance = 35,
        model = 'prop_lm_fish1_medium',
        difficulty = 'easy',
        xpreward = 5, -- easy / medium / hard
        requiredLevel = 2,
        baits = { 'worm'} -- Fishing Level 1/4
    },
    ['carp'] = {
        name = 'carp', -- do not change this value
        label = 'Carp', -- edit this value for shown name at UI
        description = 'Carp is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'rare',
        typeLabel = 'RARE',
        -- price = 50,  -- Price configurations moved to server_config.lua
        chance = 35,
        model = 'prop_lm_fish5_medium',
        difficulty = 'easy',
        xpreward = 5,
        requiredLevel = 2,
        baits = { 'worm'} -- Fishing Level 1/4
    },
    ['trout'] = {
        name = 'trout', -- do not change this value
        label = 'Trout', -- edit this value for shown name at UI
        description = 'Trout is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'rare',
        typeLabel = 'RARE',
        -- price = 50,  -- Price configurations moved to server_config.lua
        chance = 35,
        model = 'prop_lm_fish3_medium',
        difficulty = 'easy',
        xpreward = 5,
        requiredLevel = 2,
        baits = { 'worm'}
    },
    ['tuna'] = {
        name = 'tuna', -- do not change this value
        label = 'Tuna', -- edit this value for shown name at UI
        description = 'Tuna is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'epic',
        typeLabel = 'EPIC',
        -- price = 100,  -- Price configurations moved to server_config.lua
        chance = 15,
        model = 'prop_lm_fish4_medium',
        difficulty = 'hard',
        requiredLevel = 3,
        xpreward = 5,
        baits = { 'worm', 'shrimp_lure'}
    },
    ['crab'] = {
        name = 'crab', -- do not change this value
        label = 'Crab', -- edit this value for shown name at UI
        description = 'Crab is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'epic',
        typeLabel = 'EPIC',
        -- price = 100,  -- Price configurations moved to server_config.lua
        chance = 10,
        model = 'prop_lm_crab_medium',
        difficulty = 'hard',
        requiredLevel = 3,
        xpreward = 5,
        baits = { 'worm', 'shrimp_lure'}
    },
    ['lobster'] = {
        name = 'lobster', -- do not change this value
        label = 'Lobster', -- edit this value for shown name at UI
        description = 'Lobster is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'legendary',
        typeLabel = 'LEGENDARY',
        -- price = 100,  -- Price configurations moved to server_config.lua
        chance = 80,
        model = 'prop_lm_lobster_medium',
        difficulty = 'hard',
        xpreward = 5,
        requiredLevel = 4,
        baits = { 'worm', 'shrimp_lure'}
    },
    ['turtle'] = {
        name = 'turtle', -- do not change this value
        label = 'Turtle', -- edit this value for shown name at UI
        description = 'Turtle is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'legendary',
        typeLabel = 'LEGENDARY',
        -- price = 100,  -- Price configurations moved to server_config.lua
        chance = 5,
        model = 'prop_lm_turtle',
        difficulty = 'hard',
        xpreward = 5,
        requiredLevel = 4,
        baits = { 'illegalbait'}
    },
    ['octopus'] = {
        name = 'octopus', -- do not change this value
        label = 'Octopus', -- edit this value for shown name at UI
        description = 'Octopus is a lorem ipsum fish who likes to swim in the ocean.',
        type = 'legendary',
        typeLabel = 'LEGENDARY',
        -- price = 100,  -- Price configurations moved to server_config.lua
        chance = 2,
        model = 'prop_lm_octopus',
        difficulty = 'hard',
        xpreward = 5,
        requiredLevel = 4,
        baits = { 'illegalbait'}
    },
}

--[[
    prop_lm_fishing_rod1 -> red
    prop_lm_fishing_rod2 -> blue
    prop_lm_fishing_rod3 -> black
    prop_lm_fishing_rod4 -> yellow
]]
config.fishingRods = {
    { item = 'rod_1', model = 'prop_lm_fishing_rod2', minLevel = 1 },
    { item = 'rod_2', model = 'prop_lm_fishing_rod4', minLevel = 2 },
    { item = 'rod_3', model = 'prop_lm_fishing_rod3', minLevel = 3 },
    { item = 'rod_4', model = 'prop_lm_fishing_rod1', minLevel = 4 },
}

--[[
    You can add new baits to the bait list here.
    The price option is used to determine the price of the bait.
    The minLevel option is used to determine the level required to use the bait.
    The increase option is used to determine the increase in the chance of catching fish.
]]
config.baits = {
    ["worm"] = { item = 'worm', price = 500, minLevel = 1, increase = 0.5},
    ["shrimp_lure"] = { item = 'shrimp_lure', price = 1000, minLevel = 2, increase = 5.0 },
    ["illegalbait"] = { item = 'illegalbait', price = 5000, minLevel = 3, increase = 15.0 },
}

--[[
    You can add tasks to the task list here.
    The taskDetails option is used to determine the type of task and which fish type is required.
    The goal option is used to determine the number of fish to be caught.
    The current option is used to determine the number of fish caught. So dont change it, otherwise it will set all players current progress to another value.
    
    Adding New Task Type:
    If you want to add a new task type, follow this path: 'modules/task/customize.lua'. 
    Inside customize.lua, you will encounter an event triggered every time a fish is caught. 
    You can use these parameters to create new task types of your choice.
]]
config.taskList = {
    [1] = {
        taskTitle = 'Catch 5 Mullet',
        taskDescription = 'Catch 5 common fish',
        reward = 100, -- Experience reward
        taskDetails = {
            type = 'catch', -- Type of task
            fish = 'mullet' -- Fish type required for task
        },
        goal = 5, -- Number of fish required for task
        current = 0 -- Player current progress (DONT CHANGE IT)
    },
    [2] = {
        taskTitle = 'Catch 5 Bass',
        taskDescription = 'Catch 5 rare fish',
        reward = 100,
        taskDetails = {
            type = 'catch',
            fish = 'bass'
        },
        goal = 5,
        current = 0
    },
    [3] = {
        taskTitle = 'Catch 5 Tuna',
        taskDescription = 'Catch 5 epic fish',
        reward = 100,
        taskDetails = {
            type = 'catch',
            fish = 'tuna'
        },
        goal = 5,
        current = 0
    },
    [4] = {
        taskTitle = 'Catch 5 Lobster',
        taskDescription = 'Catch 5 legendary fish',
        reward = 100,
        taskDetails = {
            type = 'catch',
            fish = 'lobster'
        },
        goal = 5,
        current = 0
    }
}

--[[
    You determine the texts in the information tab located at the top right of the menu in this area.
]]
config.infoList = {
    [1] = {
        title = 'Bait Instructions',
        category = 'BAITS',
        description = 'Baits are used to attract fish. Each bait has a different effect on the fish. The better the bait, the better the fish you can catch.',
    },
    [2] = {
        title = 'Rod Instructions',
        category = 'RODS',
        description = 'Each rod has its own level and different species. Higher level of rod means better fish. And be careful, because the higher level, the higher the chance of difficulty for unique fishes.',
    },
    [3] = {
        title = 'How to upgrade rod?',
        category = 'RODS',
        description = 'Fishing rod levels are completely same with your fishing level. If you are level 2, you can use level 2 rod. And you can buy your rod from the shop. If you want to upgrade your rod, you need to increase your fishing level.',
    },
    [4] = {
        title = 'Why do we have tasks?',
        category = 'TASKS',
        description = 'Fishing tasks are challenges that you can complete to earn XP rewards.',
    },
    [5] = {
        title = 'How to complete tasks?',
        category = 'TASKS',
        description = 'To complete a task, you need to catch the required number of fish. You can track your progress in the task list. After you completed whole progress, you can click that task and get your XP reward.',
    },
    [6] = {
        title = 'What is Fishing Level?',
        category = 'LEVEL',
        description = 'The fishing level shows your progress as a fisher. The higher your level, the better fish you can catch and better rods.',
    },
    [7] = {
        title = 'How to level up?',
        category = 'LEVEL',
        description = 'If you have enough experience for next level, you can easily increase your level by clicking XP bar.',
    },
    [8] = {
        title = 'Learning About Zones',
        category = 'ZONES',
        description = 'Fishing zones are areas where you can catch fish. Each zone has different fish taskDetailss.',
    },
}

--[[
    Fishing Zones Configuration

    Each zone can have the following properties:

    • blip: Map blip settings (enabled, name, sprite, color, scale)
    • locations: Coordinates for the zone center(s) - use vec3(x, y, z)
    • radius: Zone radius in meters
    • minLevel: Minimum fishing level required to enter this zone
    • includeOutside: If true, fish from config.outside will also spawn here
    • message: Enter/exit notifications
    • fishList: Fish that spawn in this zone (can use simple or advanced format)

    Fish List Format:
    1. Simple: 'bass', 'crab', 'trout' - uses default settings from config.fish
    2. Advanced: { name = 'bass', minLevel = 3 } - override level requirement for this zone
]]
config.debugzone = false
config.fishingZones = {
    {
        blip = {
            enabled = true,
            name = 'Pier',
            sprite = 317,
            color = 56,
            scale = 0.6
        },
        locations = {
            vec3(-2051.69, -1391.38, -0.4),
        },
        radius = 400.0,
        minLevel = 1,
        includeOutside = true,
        message = { enter = 'You have entered the pier fishing zone.', exit = 'You have left the pier fishing zone.' },
        fishList = {
            -- Simple format (uses default level from config.fish):
            'bass', 'crab', 'trout', 'mullet',  

            -- Advanced format examples (uncomment to use):
            -- { name = 'bass', minLevel = 1 },   -- Override: bass requires level 1 here (level 2 normally)
        }
    },

    {
        blip = {
            enabled = true,
            name = 'Sandy Pier',
            sprite = 317,
            color = 24,
            scale = 0.6
        },
        locations = {
            vec3(1302.520, 4232.203, 33.910),
        },
        radius = 250.0,
        minLevel = 1,
        includeOutside = true,
        message = { enter = 'You have entered the sandy pier fishing zone.', exit = 'You have left the sandy pier fishing zone.' },
        fishList = { 'trout', 'tuna' }
    },

    {
        blip = {
            enabled = true,
            name = 'Illegal Fishing',
            sprite = 317,
            color = 56,
            scale = 0.6
        },
        locations = {
            vec3(3638.274, 5668.291, 9.017),
        },
        radius = 75.0,
        minLevel = 1,
        includeOutside = true,
        message = { enter = 'You have entered a illegal.', exit = 'You have left the illegal.' },
        fishList = { 'turtle', 'octopus' }
    },

    {
        blip = {
            enabled = true,
            name = 'Lobster Nest',
            sprite = 317,
            color = 56,
            scale = 0.6
        },
        locations = {
            vec3(4080.708, 5208.589, 1.557),
        },
        radius = 75.0,
        minLevel = 1,
        includeOutside = true,
        message = { enter = 'You have entered a Lobster Nest.', exit = 'You have left the Lobster Nest.' },
        fishList = { 'lobster' }
    },
}

--[[
    Fish species that can be caught outside of special zones (everywhere)

    You can define fish in two ways:

    1. Simple format (fish name only - uses default settings from config.fish):
       'mullet', 'perch'

    2. Advanced format (override specific settings for outside zones):
       { name = 'mullet', minLevel = 2 }

    The minLevel override is useful when you want different level requirements for the same fish in different areas.
    For example, bass might require level 2 in special zones but level 3 outside.

    Note: If you don't want these fish to appear in special zones, set `includeOutside = false` in that zone's config.
]]
config.outside = {
    fishList = {
        -- Simple format examples:
        -- 'mullet',
        -- 'perch',

        -- Advanced format examples (uncomment to use):
        { name = 'bass', minLevel = 3 },    -- Override: bass requires level 3 outside (level 2 in zones)
        -- { name = 'carp', minLevel = 2 },    -- Override: carp requires level 2 outside
    }
}

config.ped = {
    model = `s_m_y_dealer_01`, -- ped model
    buyAccount = 'money', -- accounts: money, bank
    sellAccount = 'money', -- accounts: money, bank
    blip = {
        name = 'Fishing Corp', -- blip name
        sprite = 356,
        color = 74,
        scale = 0.75
    },

    locations = {
        vector4(-1820.238, -1220.265, 13.017, 32.3)
    }
}

--[[
    NEW WITH VERSION 1.2.2
    BOAT RENTAL AREA
]]
config.rentboat = {
    ['pier'] = {
        price = 5000,
        moneyAccount = 'bank', -- 'cash' or 'bank'
        ped = {
            model = `s_m_y_dealer_01`,
            coords = vector4(-1799.678, -1224.796, 1.586, 141.289),
            blip = {
                enabled = true,
                name = 'Boat Rental',
                sprite = 356,
                color = 74,
                scale = 0.75
            },
        },
        boat = {
            model = 'tropic',
            spawnpoints = {
                vec4(-1800.557, -1238.119, 0.238, 232.283),
                vec4(-1797.240, -1233.935, 0.403, 230.976),
                vec4(-1794.684, -1230.809, 0.137, 226.676),
            }
        }
    },
}
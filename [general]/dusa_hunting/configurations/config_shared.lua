Shared = {}

Shared.TEST = false
Shared.Debug = false
Shared.EnableDUILaptop = true -- Enables environmental analysis with the laptop [NOTE: The FiveM DUI feature is outdated, so the image quality may not be very high. You can disable it here if you wish.]

-- System Enable/Disable Options
Shared.EnableTournamentSystem = true -- Enable/Disable Tournament System
Shared.EnableShopSystem = true -- Enable/Disable Shop System

-- Language Settings
Shared.Locale = 'en' -- Available: 'en', 'tr'

-- Inventory Image Extension Override
-- Set to 'png', 'webp', or nil to auto-detect
-- If set to 'png' or 'webp', it will force that extension
-- If set to nil, it will auto-detect (webp first, then png fallback)
Shared.InventoryImageExtension = nil -- Options: nil (auto-detect), 'png', 'webp'

-- Vehicle Rental Configuration
Shared.Rent = {
    vehicle = 'sandking',
    price = 1000,
    coords = vector3(-677.869, 5826.417, 17.331),
    heading = 134.575,
}

Shared.Keybinds = {
    CancelCarcassAction = {
        name = 'cancel_carcass_action',
        description = 'Cancel carcass collection or carrying',
        defaultKey = 'X',
    },
    tournamentLeaderboard = {
        name = 'tournament_leaderboard',
        description = 'Open tournament leaderboard',
        defaultKey = 'TAB',
    },
    toggleCursor = {
        name = 'toggle_cursor',
        description = 'Toggle DUI cursor',
        defaultKey = 'G',
    },
    Visor = {
        name = 'visor',
        description = 'Open visor',
        defaultKey = 'TAB',
    },
}

Shared.Shop = {
    Ped = { -- -29.419, 932.668, 232.174, 35.299
        target = false,
        model = 'a_m_m_hillbilly_01',
        icon = "fa-solid fa-store",
        distance = 3.5,
        coords = vec4(-675.868, 5839.285, 17.320, 134.746),
    },
    Tournament = {
        target = false,
        model = 'a_m_m_salton_01',
        icon = "fa-solid fa-trophy",
        distance = 3.5,
        coords = vec4(-680.180, 5840.854, 17.320, 201.007),
    },
    Blip = {
        Enabled = true,
        Sprite = 141,
        Color = 25,
        Scale = 0.8,
        Name = 'Hunting Shop',
        ShortRange = true,
        Coords = vec4(-675.868, 5839.285, 17.320, 134.746),
    },
    Butcher = {
        Enabled = true,
        Sprite = 273,
        Color = 25,
        Scale = 0.8,
        Name = 'Butchering Zone',
        ShortRange = true,
        Coords = vec4(-83.835, 6233.991, 31.091, 111.895),
    },
    Items = {
        {
            item = 'WEAPON_DHR31',
            price = 1000,
        },
        {
            item = 'ammo-heavysniper',
            price = 100,
        },
        {
            item = 'hunting_bait',
            price = 100,
        },
        {
            item = 'campfire',
            price = 50,
        },
        {
            item = 'primitive_grill',
            price = 100,
        },
        {
            item = 'advanced_grill',
            price = 500,
        },
        {
            item = 'binocular',
            price = 50,
        },
        {
            item = 'hunting_trap',
            price = 250,
        },
        {
            item = 'hunting_laptop',
            price = 250,
        },
        {
            item = 'hunting_license',
            price = 250,
        },
    },
    QualityMultipliers = {
        [1] = 1.0,    -- Kalite 1: Normal fiyat (100%)
        [2] = 1.5,    -- Kalite 2: %50 artış (150%)
        [3] = 2.0,    -- Kalite 3: %100 artış (200%)
    },
    Sell = {
        -- Deer items
        {
            item = 'deer_beef',
            name = 'Deer Beef',
            price = 45
        },
        {
            item = 'deer_rib',
            name = 'Deer Rib',
            price = 35
        },
        {
            item = 'deer_leg',
            name = 'Deer Leg',
            price = 40
        },
        -- Rabbit items
        {
            item = 'rabbit_body',
            name = 'Rabbit Body',
            price = 25
        },
        {
            item = 'rabbit_leg',
            name = 'Rabbit Leg',
            price = 20
        },
        {
            item = 'rabbit_beef',
            name = 'Rabbit Beef',
            price = 30
        },
        -- Bear items
        {
            item = 'bear_beef',
            name = 'Bear Beef',
            price = 60
        },
        {
            item = 'bear_rib',
            name = 'Bear Rib',
            price = 50
        },
        {
            item = 'bear_leg',
            name = 'Bear Leg',
            price = 55
        },
        -- Red Panda items
        {
            item = 'redpanda_body',
            name = 'Red Panda Body',
            price = 35
        },
        {
            item = 'redpanda_leg',
            name = 'Red Panda Leg',
            price = 30
        },
        {
            item = 'redpanda_beef',
            name = 'Red Panda Beef',
            price = 40
        },
        -- Boar items
        {
            item = 'boar_leg',
            name = 'Boar Leg',
            price = 45
        },
        {
            item = 'boar_beef',
            name = 'Boar Beef',
            price = 50
        },
        {
            item = 'boar_rib',
            name = 'Boar Rib',
            price = 40
        },
        -- Coyote items
        {
            item = 'coyote_beef',
            name = 'Coyote Beef',
            price = 35
        },
        {
            item = 'coyote_rib',
            name = 'Coyote Rib',
            price = 30
        },
        {
            item = 'coyote_leg',
            name = 'Coyote Leg',
            price = 35
        },
        -- Mountain Lion items
        {
            item = 'mtlion_beef',
            name = 'Mountain Lion Beef',
            price = 55
        },
        {
            item = 'mtlion_rib',
            name = 'Mountain Lion Rib',
            price = 45
        },
        {
            item = 'mtlion_leg',
            name = 'Mountain Lion Leg',
            price = 50
        },
        -- Lion items
        {
            item = 'lion_beef',
            name = 'Lion Beef',
            price = 70
        },
        {
            item = 'lion_rib',
            name = 'Lion Rib',
            price = 60
        },
        {
            item = 'lion_leg',
            name = 'Lion Leg',
            price = 65
        },
        {
            item = 'lion_body',
            name = 'Lion Body',
            price = 75
        },
        -- Oryx items
        {
            item = 'oryx_beef',
            name = 'Oryx Beef',
            price = 40
        },
        {
            item = 'oryx_rib',
            name = 'Oryx Rib',
            price = 35
        },
        {
            item = 'oryx_leg',
            name = 'Oryx Leg',
            price = 40
        },
        -- Antelope items
        {
            item = 'antelope_beef',
            name = 'Antelope Beef',
            price = 45
        },
        {
            item = 'antelope_rib',
            name = 'Antelope Rib',
            price = 40
        },
        {
            item = 'antelope_leg',
            name = 'Antelope Leg',
            price = 45
        },
        -- Hide (generic)
        {
            item = 'hide',
            name = 'Hide',
            price = 25
        },
    },
}

Shared.Species = { -- to keep track of player's hunting progress
    ['deer'] = {
        name = 'Deer',
        type = 'deer',
        model = 'a_c_deer',
        drag = {
            xPos = 0.0,
            yPos = 0.0,
            zPos = -0.25,
            xRot = -200.0,
            yRot = 0.0,
            zRot = 270.0
        }
    },
    ['rabbit'] = {
        name = 'Rabbit',
        type = 'rabbit',
        model = 'a_c_rabbit_01',
        drag = false,
    },
    ['bear'] = {
        name = 'Bear',
        type = 'bear',
        model = 'BrnBear',
        drag = {
            xPos = 0.0,
            yPos = 0.0,
            zPos = -0.25,
            xRot = -200.0,
            yRot = 0.0,
            zRot = 270.0
        }
    },
    ['redpanda'] = {
        name = 'Red Panda',
        type = 'redpanda',
        model = 'redpanda',
        drag = false
    },
    ['lion'] = {
        name = 'Lion',
        type = 'lion',
        model = 'ft-lion',
        drag = {
            xPos = 0.0,
            yPos = 0.0,
            zPos = -0.25,
            xRot = -200.0,
            yRot = 0.0,
            zRot = 270.0
        }
    },
    ['oryx'] = {
        name = 'Arabian Oryx',
        type = 'oryx',
        model = 'ft-araboryx',
        drag = {
            xPos = 0.0,
            yPos = 0.0,
            zPos = -0.25,
            xRot = -200.0,
            yRot = 0.0,
            zRot = 270.0
        }
    },
    ['antelope'] = {
        name = 'Antelope',
        type = 'antelope',
        model = 'pronghorn_antelope',
        drag = {
            xPos = 0.0,
            yPos = 0.0,
            zPos = -0.25,
            xRot = -200.0,
            yRot = 0.0,
            zRot = 270.0
        }
    },
    ['boar'] = {
        name = 'Boar',
        type = 'boar',
        model = 'a_c_boar',
        drag = {
            xPos = 0.0,
            yPos = 0.0,
            zPos = -0.25,
            xRot = -200.0,
            yRot = 0.0,
            zRot = 270.0
        }
    },
    ['coyote'] = {
        name = 'Coyote',
        type = 'coyote',
        model = 'a_c_coyote',
        drag = {
            xPos = 0.0,
            yPos = 0.0,
            zPos = -0.25,
            xRot = -200.0,
            yRot = 0.0,
            zRot = 270.0
        }
    },
    ['mtlion'] = {
        name = 'Mountain Lion',
        type = 'mtlion',
        model = 'a_c_mtlion',
        drag = {
            xPos = 0.0,
            yPos = 0.0,
            zPos = -0.25,
            xRot = -200.0,
            yRot = 0.0,
            zRot = 270.0
        }
    },
    ['pig'] = {
        name = 'Pig',
        type = 'pig',
        model = 'a_c_pig',
        drag = {
            xPos = 0.0,
            yPos = 0.0,
            zPos = -0.25,
            xRot = -200.0,
            yRot = 0.0,
            zRot = 270.0
        }
    },
}

Shared.Pet = {
    Enabled = false,
    Price = 7500,
    WhistleAnimation = true,
    Model = 'ft-btcoon',
    MaxDistance = 30.0,
    MinGrade = 3,
    Shortcuts = {
        Enabled = true,
        Attack = { "LEFTSHIFT", "G" },
    },
    Fixskin = {
        Enabled = true,
        Component = 0,
        Drawable = 0,
    },
    Quality = {
        Effect = 'decrease', -- none, decrease, increase / Pet quality effect on hunted animal meat quality
        Value = 1,           -- 1-5
    }
}

-- Quest System Configuration
Shared.Quests = {
    {
        id = 'daily_hunt_deer',
        name = 'Daily Deer Hunt',
        description = 'Hunt 1 deer today',
        type = 'hunt',
        target_animal = 'deer',
        target_count = 1,
        renewal_period = 'daily',
        rewards = {
            money = 1000,
            xp = 2
        }
    },
    {
        id = 'weekly_hunt_bear',
        name = 'Weekly Bear Hunt',
        description = 'Hunt 3 bears this week',
        type = 'hunt',
        target_animal = 'bear',
        target_count = 3,
        renewal_period = 'weekly',
        rewards = {
            money = 5000,
            xp = 10
        }
    },
    {
        id = 'threedays_trap_rabbit',
        name = 'Rabbit Trapping',
        description = 'Trap 10 rabbits',
        type = 'trap',
        target_animal = 'rabbit',
        target_count = 10,
        renewal_period = 'threedays',
        rewards = {
            money = 2000,
            xp = 5
        }
    },
    {
        id = 'threedays_trap_deer',
        name = 'Deer Trapping',
        description = 'Trap 2 deer',
        type = 'trap',
        target_animal = 'deer',
        target_count = 2,
        renewal_period = 'threedays',
        rewards = {
            money = 2000,
            xp = 5
        }
    },
    {
        id = 'daily_cook_meat',
        name = 'Daily Cooking',
        description = 'Cook 15 pieces of meat',
        type = 'cook',
        target_count = 15,
        renewal_period = 'daily',
        rewards = {
            xp = 2
        }
    },
    {
        id = 'weekly_hunt_lion',
        name = 'Lion Hunter',
        description = 'Hunt 2 lions this week',
        type = 'hunt',
        target_animal = 'lion',
        target_count = 2,
        renewal_period = 'weekly',
        rewards = {
            money = 8000,
            xp = 10
        }
    },
    {
        id = 'daily_hunt_boar',
        name = 'Daily Boar Hunt',
        description = 'Hunt 8 boars today',
        type = 'hunt',
        target_animal = 'boar',
        target_count = 8,
        renewal_period = 'daily',
        rewards = {
            money = 1500,
            xp = 2
        }
    },
}
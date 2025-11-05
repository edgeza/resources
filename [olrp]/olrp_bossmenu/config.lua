Config = {}

-- Banking System Selection
Config.BankingSystem = "renewed-banking"  -- Options: "qb-banking", "renewed-banking"

-- Target System Selection
Config.TargetSystem = "ox_target"  -- Options: "qb-target", "ox_target"

-- Job Application System Settings
Config.EnableApplicationSystem = true  -- Set to false to disable job application system

-- Management access locations
Config.Locations = {
    ["police"] = {
        label = "Police Department",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(837.28, -1307.94, 28.24), -- Main Police Station
                width = 1.0,
                length = 1.0,
                heading = 144,
                minZ = 27.0,
                maxZ = 29.0,
            },
            {
                coords = vector3(1853.82, 3689.82, 34.27), -- Sandy Shores Sheriff
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 34.0,
                maxZ = 35.0,
            }
        }
    },
    ["ambulance"] = {
        label = "EMS Department",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(334.8, -594.25, 43.28), -- Main Hospital
                width = 1.0,
                length = 1.0,
                heading = 123.06,
                minZ = 42.0,
                maxZ = 44.0,
            },
            {
                coords = vector3(1839.32, 3673.26, 34.28), -- Sandy Shores Hospital
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 34.0,
                maxZ = 35.0,
            }
        }
    },
    ["mechanic"] = {
        label = "Mechanic Shop",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(832.92, -909.54, 25.25), -- Mechanic Shop
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 25.0,
                maxZ = 26.0,
            }
        }
    },
    ["palmcoast"] = {
        label = "Palm Coast",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-2022.88, -498.65, 12.21), -- West Customs Mechanic Shop
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 25.0,
                maxZ = 26.0,
            }
        }
    },
    ["olrpmechanic"] = {
        label = "OneLife Mechanics",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-347.29, -133.0, 39.01), -- OneLife Mechanic Shop
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 38.0,
                maxZ = 40.0,
            }
        }
    },
    ["catcafe"] = {
        label = "Cat Cafe",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-577.56, -1067.55, 26.61), -- Cat Cafe
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 21.0,
                maxZ = 23.0,
            }
        }
    },
    ["skybar"] = {
        label = "Sky Bar",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-905.65, -448.82, 160.31), -- Sky Bar
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 159.0,
                maxZ = 161.0,
            }
        }
    },
    ["events"] = {
        label = "Events",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-1037.0, -2737.0, 20.17), -- Events Center
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 19.0,
                maxZ = 21.0,
            }
        }
    },
    ["towing"] = {
        label = "Towing",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(409.0, -1623.0, 29.29), -- Towing Yard (example location)
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 28.0,
                maxZ = 30.0,
            }
        }
    },
    ["koi"] = {
        label = "Koi",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-1053.76, -1441.69, -1.38), -- Koi Restaurant (example location)
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 4.0,
                maxZ = 6.0,
            }
        }
    },
    ["6str"] = {
        label = "6str Tunershop",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(124.66, -3014.24, 7.04), -- 6str Tunershop
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 6.0,
                maxZ = 8.0,
            }
        }
    },
    ["bennies"] = {
        label = "Benny's Motorworks",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-920.45, -2044.41, 14.45), -- Benny's Motorworks
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 13.0,
                maxZ = 15.0,
            }
        }
    },
    ["highnotes"] = {
        label = "High Notes",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-852.11, -241.12, 62.18), -- High Notes Weed Shop
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 61.0,
                maxZ = 63.0,
            }
        }
    }
    -- Add more jobs as needed
}

Config.ApplicationPoints = {
    ["police"] = {
        coords = vector3(441.53604, -980.1955, 30.795989),  -- Near the police station
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 30.0,
        maxZ = 31.0,
        label = "Police Application"
    },
    ["ambulance"] = {
        coords = vector3(310.45, -597.47, 43.28),  -- Near the hospital
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 43.0,
        maxZ = 44.0,
        label = "EMS Application"
    },
    ["bennies"] = {
        coords = vec3(-920.24, -2035.23, 9.42),  -- Near the mechanic shop
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 25.0,
        maxZ = 26.0,
        label = "Bennies Application"
    },
    ["olrpmechanic"] = {
        coords = vector3(-347.29, -133.0, 39.01),  -- Near OneLife Mechanic Shop
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 38.0,
        maxZ = 40.0,
        label = "OneLife Mechanic Application"
    },
    ["palmcoast"] = {
        coords = vector3(-2022.88, -498.65, 12.21),  -- Near Palm Coast Mechanic Shop
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 25.0,
        maxZ = 26.0,
        label = "Palm Coast Application"
    },
    ["6str"] = {
        coords = vector3(124.66, -3014.24, 7.04),  -- Near 6str Tunershop
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 6.0,
        maxZ = 8.0,
        label = "6str Tunershop Application"
    },
    ["doj"] = {
        coords = vector3(124.66, -3014.24, 7.04),  -- Near DOJ
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 6.0,
        maxZ = 8.0,
        label = "DOJ Application"
    },
    ["catcafe"] = {
        coords = vector3(-581.0, -1058.0, 22.34),  -- Near Cat Cafe
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 21.0,
        maxZ = 23.0,
        label = "Cat Cafe Application"
    },
    ["skybar"] = {
        coords = vector3(318.0, -927.0, 29.46),  -- Near Sky Bar
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 28.0,
        maxZ = 30.0,
        label = "Sky Bar Application"
    },
    ["events"] = {
        coords = vector3(-1034.0, -2734.0, 20.17),  -- Near Events Center
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 19.0,
        maxZ = 21.0,
        label = "Events Application"
    },
    ["towing"] = {
        coords = vector3(406.0, -1620.0, 29.29),  -- Near Towing Yard
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 28.0,
        maxZ = 30.0,
        label = "Towing Application"
    },
    ["koi"] = {
        coords = vector3(-1032.91, -1480.78, 4.58),  -- Near Koi Restaurant
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 4.0,
        maxZ = 6.0,
        label = "Koi Application"
    },
    ["highnotes"] = {
        coords = vector3(0.0, 0.0, 0.0),  -- Near High Notes Weed Shop (UPDATE COORDINATES)
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = -1.0,
        maxZ = 1.0,
        label = "High Notes Application"
    },
    -- Add more points as needed
}

-- Define application form questions (these will be shown in the application form)
Config.ApplicationQuestions = {
    ["police"] = {
        {
            question = "Why do you want to join the Police Department?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        },
        {
            question = "Do you have any previous law enforcement experience?",
            type = "select",
            options = {"Yes", "No"},
            required = true
        },
        {
            question = "How many years of experience do you have?",
            type = "number",
            required = false,
            min = 0,
            max = 50
        },
        {
            question = "How would you handle a high-stress situation?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["ambulance"] = {
        {
            question = "Why do you want to join the EMS Department?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["mechanic"] = {
        {
            question = "Why do you want to join the Mechanic Shop?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["palmcoast"] = {
        {
            question = "Why do you want to join the Palm Coast?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["6str"] = {
        {
            question = "Why do you want to join the 6str Tunershop?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["bennies"] = {
        {
            question = "Why do you want to join the Benny's Motorworks?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["highnotes"] = {
        {
            question = "Why do you want to join the High Notes?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["koi"] = {
        {
            question = "Why do you want to join the Koi?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["towing"] = {
        {
            question = "Why do you want to join the Towing?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["olrpmechanic"] = {
        {
            question = "Why do you want to join the OneLife Mechanics?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["catcafe"] = {
        {
            question = "Why do you want to join the Cat Cafe?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
    ["skybar"] = {
        {
            question = "Why do you want to join the Sky Bar?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        }
    },
}

-- Default settings
Config.DefaultSettings = {
    darkMode = true,
    showAnimations = true,
    compactView = false,
    notificationSound = "default",
    themeColor = "midnight-red",
    refreshInterval = 60,
    showPlaytime = true,
    showLocation = true
}

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
                coords = vector3(448.25, -973.38, 30.69), -- Main Police Station (from cs_bossmenu)
                width = 1.0,
                length = 1.0,
                heading = 144,
                minZ = 30.0,
                maxZ = 31.0,
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
                coords = vector3(446.29, -978.88, 30.69), -- Main Hospital (from cs_bossmenu)
                width = 1.0,
                length = 1.0,
                heading = 123.06,
                minZ = 30.0,
                maxZ = 31.0,
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
    ["mechanic3"] = {
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
    ["beanmachine"] = {
        label = "Bean Machine",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-635.0, -236.54, 38.08), -- Bean Machine Coffee Shop
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 37.0,
                maxZ = 39.0,
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
    ["upnatom"] = {
        label = "Up n Atom",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(92.0, 295.0, 110.21), -- Up n Atom Restaurant
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 109.0,
                maxZ = 111.0,
            }
        }
    },
    ["burgershot"] = {
        label = "BurgerShot",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-1192.0, -895.0, 13.99), -- BurgerShot Restaurant
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 13.0,
                maxZ = 15.0,
            }
        }
    },
    ["billiards"] = {
        label = "Billiards",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-1355.0, -1487.0, 4.42), -- Billiards Hall
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 3.0,
                maxZ = 5.0,
            }
        }
    },
    ["skybar"] = {
        label = "Sky Bar",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(315.0, -930.0, 29.46), -- Sky Bar
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 28.0,
                maxZ = 30.0,
            }
        }
    },
    ["bahamas"] = {
        label = "Bahamas",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-1387.0, -588.0, 30.32), -- Bahamas Bar
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 29.0,
                maxZ = 31.0,
            }
        }
    },
    ["skydive"] = {
        label = "Skydiving",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(-1145.0, -2864.0, 13.95), -- Skydiving Center
                width = 1.0,
                length = 1.0,
                heading = 0,
                minZ = 13.0,
                maxZ = 15.0,
            }
        }
    },
    ["lostmc"] = {
        label = "Lost MC",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(85.69, -1959.65, 21.12), -- Lost MC Clubhouse (from cs_bossmenu)
                width = 1.0,
                length = 1.0,
                heading = 223.76,
                minZ = 20.0,
                maxZ = 22.0,
            }
        }
    },
    ["ballas"] = {
        label = "Ballas",
        logoImage = "logo.png",
        locations = {
            {
                coords = vector3(83.83, -1955.18, 20.75), -- Ballas Territory (from cs_bossmenu)
                width = 1.0,
                length = 1.0,
                heading = 145,
                minZ = 20.0,
                maxZ = 22.0,
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
    ["mechanic"] = {
        coords = vector3(835.92, -912.54, 25.25),  -- Near the mechanic shop
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 25.0,
        maxZ = 26.0,
        label = "Mechanic Application"
    },
    ["mechanic3"] = {
        coords = vector3(-350.0, -130.0, 39.01),  -- Near OneLife Mechanic Shop
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 38.0,
        maxZ = 40.0,
        label = "OneLife Mechanic Application"
    },
    ["beanmachine"] = {
        coords = vector3(-632.0, -233.0, 38.08),  -- Near Bean Machine
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 37.0,
        maxZ = 39.0,
        label = "Bean Machine Application"
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
    ["upnatom"] = {
        coords = vector3(95.0, 298.0, 110.21),  -- Near Up n Atom
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 109.0,
        maxZ = 111.0,
        label = "Up n Atom Application"
    },
    ["burgershot"] = {
        coords = vector3(-1189.0, -892.0, 13.99),  -- Near BurgerShot
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 13.0,
        maxZ = 15.0,
        label = "BurgerShot Application"
    },
    ["billiards"] = {
        coords = vector3(-1352.0, -1484.0, 4.42),  -- Near Billiards Hall
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 3.0,
        maxZ = 5.0,
        label = "Billiards Application"
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
    ["bahamas"] = {
        coords = vector3(-1384.0, -585.0, 30.32),  -- Near Bahamas Bar
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 29.0,
        maxZ = 31.0,
        label = "Bahamas Application"
    },
    ["skydive"] = {
        coords = vector3(-1142.0, -2861.0, 13.95),  -- Near Skydiving Center
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 13.0,
        maxZ = 15.0,
        label = "Skydiving Application"
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
    }
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

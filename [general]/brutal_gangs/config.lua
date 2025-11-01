----------------------------------------------------------------------------------------------
-------------------------------------| BRUTAL GANGS :) |--------------------------------------
----------------------------------------------------------------------------------------------

--[[
Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com
--]]

Config = {
    Core = 'QBCORE',  -- 'ESX' / 'QBCORE' | Other core setting on the 'core' folder.
    Inventory = 'quasar_inventory', -- 'ox_inventory' / 'qb_inventory' / 'quasar_inventory' / 'chezza_inventory' / 'codem_inventory' / 'core_inventory' / 'origen_inventory' / 'ps-inventory' / 'tgiann-inventory' // Custom can be add in the cl_utils.lua!!!
    -- Wardrobe = 'default', -- 'default' / 'ak47_clothing' / 'codem_apperance' / 'fivem_appearance' / 'illenium_appearance' / 'qb_clothing' / 'raid_clothes' / 'rcore_clothes' / 'rcore_clothing' / 'sleek_clothestore' / 'tgiann_clothing' // Custom can be add in the cl_utils.lua!!!
    TextUI = 'ox_lib', -- false / 'brutal_textui' / 'ox_lib' / 'okokTextUI' / 'ESXTextUI' / 'QBDrawText' // Custom can be add in the cl_utils.lua!!!
    Target = 'qb-target', -- 'oxtarget' / 'qb-target' // if the TextUI is set to false target will step its place. | The Target cannot be false.
    BrutalNotify = true, -- Buy here: (4€+VAT) https://store.brutalscripts.com | Or set up your own notify >> cl_utils.lua
    -- BrutalKeys = true, -- Buy here: (15€+VAT) https://store.brutalscripts.com | Or set up your own if you're using a different vehicle key >> cl_utils.lua
    SteamName = false, -- true = Steam name | false = character name
    DateFormat = '%d/%m/%Y', -- Date format

    SaveLastGang = false, -- true / false || If true, it saves the player's last gang, and when they set their job back to that gang, they will regain their previous rank. (This will only work if they set their job back from a non gang job like a taxi job.)
    SetJobAfterCreate = true, -- true / false || if true, it sets the player's job/gang to the one created.
    NoneJob = {esx = "unemployed", qb = "none"},
    LockPick = {resourcename = "lockpick"}, -- You can change the name of the lockpick script if you're using one of the scripts with this name.
    EnableCayoPericoMap = false, -- If your server has the "cayo perico" dlc, turn this to "true" and you will see the island in the gangmenu map

    HQBlip = {use = true, sprite = 40, color = 32, size = 0.7},
    Marker = {marker = 20, bobUpAndDown = true, rotate = false, size = {0.3, 0.2, 0.2}, rgb = {15, 100, 210}},

    Commands = {
        GangMenu = {
            Command = 'gangmenu1', 
            Suggestion = 'To open the gang menu',
            Control = 'F11',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
        },

        GetGangVehicleBack = {
            Command = 'getgangvehicleback', --  /getgangvehicleback all | /getgangvehicleback DHR 432
            Suggestion = 'To get back your vehicle(s)',
        },

        CreateGraffiti = {
            Command = 'graffiti',
            Suggestion = 'To create a new graffiti',
            Item = "spraycan",
        },

        CleanGraffiti = {
            Command = 'cleangraffiti',
            Suggestion = 'To clean a graffiti',
            Item = "sprayremover",
        },

        -- Admin commands

        EditGangs = {
            AdminGroups = {'superadmin', 'admin', 'mod', 'god'},
            Command = 'editgangs', 
            Suggestion = 'To edit the gangs',
        },

        SetGangLeader = {
            AdminGroups = {'superadmin', 'admin', 'mod', 'god'},
            Command = 'setgangleader', 
            Suggestion = 'To set up the gang leader',
        },
    },

    Levels = {
        [0] = {
            maxMembersCount = 15,

            vehicles = {amount = 80, price = nil},
            stash = {size = 1400, price = nil},
            ranks = {amount = 3, price = nil},
            raid = {available = false, price = nil},
        },

        [1] = {
            price = {money = 50000, rep = 3750},
            maxMembersCount = 15,

            vehicles = {amount = 85, price = {money = 15000, rep = 525}},
            stash = {size = 2300, price = {money = 5000, rep = 175}},
            safe = {available = true, size = 1400, price = {money = 25000, rep = 875}},
            ranks = {amount = 6, price = {money = 0, rep = 650}},
            raid = {available = false, price = nil},
        },

        [2] = {
            price = {money = 150000, rep = 11250},
            maxMembersCount = 15,

            vehicles = {amount = 90, price = {money = 15000, rep = 525}},
            stash = {size = 4000, price = {money = 5000, rep = 175}},
            safe = {available = true, size = 2300, price = {money = 3000, rep = 105}},
            ranks = {amount = 9, price = {money = 0, rep = 650}},
            raid = {available = true, price = {money = 25000, rep = 875}},
        },

        [3] = {
            price = {money = 250000, rep = 18750},
            maxMembersCount = 15,

            vehicles = {amount = 100, price = {money = 15000, rep = 525}},
            stash = {size = 10000, price = {money = 5000, rep = 175}},
            safe = {available = true, size = 3200, price = {money = 3000, rep = 105}},
            ranks = {amount = 12, price = {money = 0, rep = 650}},
            raid = {available = true, price = {money = 25000, rep = 875}},
        },
    },

    HQS = {
        ["vagos"] = {
            MapPosition = {
                vector2(1435.29, -2059.26),
                vector2(1412.2, -2069.54),
                vector2(1360.82, -2113.07),
                vector2(1342.3, -2090.71),
                vector2(1347.61, -2070.18),
                vector2(1380.51, -2042.06),
                vector2(1394.28, -2033.78),
                vector2(1422.57, -2037.76),
                vector2(1433.57, -2051.05),
                vector2(1436.35, -2058.28),
            },

            MiddlePoint = vector3(1373.53, -2087.62, 48.22),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(652.51, 924.74, 252.6),
                },
    
                Stashes = {
                    vector3(1362.69, -2098.27, 47.21),
                },

                BalanceManages = {
                    vector3(1370.51, -2090.42, 48.22),
                },

                Garages = {
                    {
                        open = vector3(622.71, 916.32, 247.58),
                        spawn = vector4(626.86, 923.31, 247.58, 282.82)
                    },
                },
            },
        },

        ["triads"] = {
            MapPosition = {
                vector2(-847.9, -746.86),
                vector2(-801.27, -745.18),
                vector2(-816.92, -777.14),
                vector2(-817.92, -674.27),
            },

            MiddlePoint = vector3(-821.66, -710.76, 28.06),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(-815.79, -717.95, 28.06),
                },
    
                Stashes = {
                    vector3(-816.6, -701.78, 32.14),
                },

                BalanceManages = {
                    vector3(338.2400, -1979.8922, 24.2078),
                },

                Garages = {
                    {
                        open = vector3(-814.79, -725.82, 23.78),
                        spawn = vector4(-815.77, -734.35, 23.78, 169.82)
                    },
                },
            },
        },

        ["lostmc"] = {
            MapPosition = {
                vector2(938.94, -115.98),
                vector2(985.36, -155.64),
                vector2(1022.29, -119.89),
                vector2(981.21, -75.62),
            },

            MiddlePoint = vector3(973.94, -119.99, 74.97),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(971.9257, -98.7307, 74.8464),
                },
    
                Stashes = {
                    vector3(986.6417, -92.7903, 74.8459),
                },

                BalanceManages = {
                    vector3(976.9885, -103.8749, 74.8452),
                },

                Garages = {
                    {
                        open = vector3(996.79, -128.74, 74.46),
                        spawn = vector4(991.73, -143.48, 74.49, 53.6)
                    },
                },
            },
        },

        ["families"] = {
            MapPosition = {
                vector2(-2548.3, 1914.5),
                vector2(-2602.92, 1931.21),
                vector2(-2645.95, 1880.23),
                vector2(-2633.14, 1868.0),
                vector2(-2599.86, 1861.5),
                vector2(-2569.17, 1868.27),
                vector2(-2553.75, 1890.79),
            },
            
            MiddlePoint = vector3(-2595.39, 1898.7, 171.48),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(-2576.8, 1887.49, 167.31),
                },
    
                Stashes = {
                    vector3(-2591.92, 1878.57, 167.32),
                },

                BalanceManages = {
                    vector3(-2587.07, 1880.41, 167.32),
                },

                Garages = {
                    {
                        open = vector3(-2589.95, 1930.54, 167.29),
                        spawn = vector4(-2589.95, 1930.54, 167.29, 264.43)
                    },
                },
            },
        },

        ["mafia"] = {
            MapPosition = {
                vector2(-1455.06, 49.67),
                vector2(-1447.92, 9.42),
                vector2(-1493.87, 2.3),
                vector2(-1498.24, 46.5),
            },

            MiddlePoint = vector3(-1477.39, 26.56, 54.2),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(-1456.02, 18.19, 56.99),
                },
    
                Stashes = {
                    vector3(-1456.02, 18.19, 56.99),
                },

                BalanceManages = {
                    vector3(-1461.74, 15.8, 56.99),
                },

                Garages = {
                    {
                        open = vector3(-1490.71, 20.46, 54.72),
                        spawn = vector4(-1488.73, 32.24, 54.68, 352.14)
                    },
                },
            },
        },

        ["cartel"] = {
            MapPosition = {
                vector2(-2708.74, 1503.22),
                vector2(-2718.38, 1490.82),
                vector2(-2752.05, 1440.35),
                vector2(-2796.75, 1381.49),
                vector2(-2874.86, 1383.22),
                vector2(-2882.19, 1391.87),
                vector2(-2881.7, 1431.79),
                vector2(-2853.63, 1445.64),
                vector2(-2831.29, 1456.67),
                vector2(-2823.92, 1477.18),
                vector2(-2773.02, 1499.21),
                vector2(-2737.33, 1522.74),
                vector2(-2702.37, 1514.58),

            },
            
            MiddlePoint = vector3(-2808.97, 1429.24, 100.97),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(-2674.3, 1304.69, 152.01),
                },
    
                Stashes = {
                    vector3(-2674.1, 1316.4, 152.01),
                },

                BalanceManages = {
                    vector3(-2676.67, 1309.43, 152.99),
                },

                Garages = {
                    {
                        open = vector3(-2661.9, 1308.03, 147.12),
                        spawn = vector4(-2645.06, 1307.26, 145.95, 272.03)
                    },
                },
            },
        },

        ["aod"] = {
            MapPosition = {
                vector2(293.04, 6615.83),
                vector2(241.3, 6611.48),
                vector2(240.33, 6676.0),
                vector2(292.77, 6676.35),
            },

            MiddlePoint = vector3(260.31, 6615.97, 29.88),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(265.24, 6628.75, 29.91),
                },
    
                Stashes = {
                    vector3(267.28, 6617.82, 33.19),
                },

                BalanceManages = {
                    vector3(266.08, 6617.86, 33.19),
                },

                Garages = {
                    {
                        open = vector3(-1891.74, 2046.17, 140.85),
                        spawn = vector4(-1891.56, 2045.92, 140.86, 244.84)
                    },
                },
            },
        },

        ["ballas"] = {
             MapPosition = {
                vector2(-23.72, -1848.72),
                vector2(-41.15, -1869.67),
                vector2(-138.2, -1790.47),
                vector2(-120.58, -1770.02),
                vector2(-116.39, -1773.19),
                vector2(-114.59, -1771.04),
            },
            
            MiddlePoint = vector3(-91.17, -1811.66, 26.95),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(-98.41, -1791.64, 30.21)
                },
    
                Stashes = {
                    vector3(-108.22, -1807.92, 30.19),
                },

                BalanceManages = {
                    vector3(-110.93, -1804.59, 30.19)
                },

                Garages = {
                    {
                        open = vector3(-61.09, -1819.4, 27.07),
                        spawn = vector4(-65.47, -1822.69, 26.94, 224.25)
                    },
                },
            },
        },

        ["aztecas"] = {
             MapPosition = {
                vector2(973.98, -2478.5),
                vector2(974.21, -2526.06),
                vector2(999.88, -2530.48),
                vector2(1017.53, -2532.1),
                vector2(1019.61, -2508.29),
                vector2(1049.68, -2510.84),
                vector2(1050.51, -2509.33),
                vector2(1052.86, -2486.07),
            },
            
            MiddlePoint = vector3(1025.34, -2543.32, 32.29),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(1026.55, -2543.53, 28.29),
                },
    
                Stashes = {
                    vector3(1026.62, -2538.09, 28.29),
                },

                BalanceManages = {
                    vector3(1035.74, -2542.0, 32.29),
                },

                Garages = {
                    {
                        open = vector3(498.63, -1526.42, 29.29),
                        spawn = vector4(503.65, -1520.7, 29.29, 59.49)
                    },
                },
            },
        },

        ["yakuza"] = {
             MapPosition = {
                vector2(-629.35, 947.97),
                vector2(-689.21, 969.59),
                vector2(-668.67, 854.56),
                vector2(-456.18, 886.21),
                vector2(-764.37, 1008.53),
                vector2(-664.65, 1045.49),
                vector2(-542.59, 930.1),
                vector2(-553.16, 842.67),
            },
            
            MiddlePoint = vector3(-687.27, 968.84, 238.74),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(-636.89, 943.11, 243.97),
                },
    
                Stashes = {
                    vector3(-638.09, 949.24, 243.95),
                },

                BalanceManages = {
                    vector3(-642.25, 949.33, 243.95),
                },

                Garages = {
                    {
                        open = vector3(-686.72, 961.2, 238.74),
                        spawn = vector4(-686.76, 952.46, 238.74, 353.72)
                    },
                },
            },
        },

        ["disciples"] = {
             MapPosition = {
                vector2(-108.12, 856.64),
                vector2(-115.37, 835.96),
                vector2(-108.12, 817.19),
                vector2(-96.44, 812.34),
                vector2(-73.78, 797.63),
                vector2(-48.06, 775.81),
                vector2(-36.5, 787.84),
                vector2(-43.73, 809.79),
                vector2(-33.06, 821.99),
                vector2(-44.32, 834.56),
                vector2(-54.07, 861.06),
                vector2(-61.64, 880.95),
                vector2(-69.51, 878.87),
                vector2(-82.95, 849.48),
            },
            
            MiddlePoint = vector3(-72.27, 825.49, 235.71),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(2013.65, 3357.66, 51.6),
                },
    
                Stashes = {
                    vector3(-55.83, 837.46, 231.33),
                },

                BalanceManages = {
                    vector3(2020.5, 3366.75, 51.6),
                },

                Garages = {
                    {
                        open = vector3(-95.82, 824.77, 235.71),
                        spawn = vector4(-106.05, 826.15, 235.72, 12.75)
                    },
                },
            },
        },

        ["harbinger"] = {
             MapPosition = {
                vector2(88.44, 3597.0),
                vector2(88.33, 3649.31),
                vector2(117.08, 3649.49),
                vector2(117.41, 3597.07),
                
            },
            
            MiddlePoint = vector3(106.53, 3625.7, 40.01),
            HQCanBeCaptured = false,

            DefaultCoords = {
                Cloakrooms = {
                    vector3(106.53, 3625.7, 40.01),
                },
    
                Stashes = {
                    vector3(108.53, 3627.7, 40.01),
                },

                BalanceManages = {
                    vector3(110.53, 3629.7, 40.01),
                },

                Garages = {
                    {
                        open = vector3(112.53, 3631.7, 40.01),
                        spawn = vector4(114.53, 3633.7, 40.01, 0.0)
                    },
                },
            },
        },
    },

    Scout = {
        MaximumTime = 15, -- in minutes
        MinimumOnlineMembers = 3, -- minimum members online to start
    },

    Raid = {
        Price = {money = 50000, rep = 2000},
        MaximumTime = 30, -- in minutes
        MinimumOnlineMembers = 6, -- minimum members online to start
        CooldownAfterDeath = 45, -- in minutes
        WinReward = {use = true, money = 1000, rep = 100}, -- The reward given to the attacking gang if they win the raid.
        LossReward = {use = true, money =  300, rep = 50}, -- The reward given to the defending gang if they lose the defense.
        StashLooting = {use = true, time = 5}, -- use: true / false | time = 1 = 1min
        Limit = 72, -- in hours
    },

    Graffiti = {
        ShowDistance = 100.0,

        MinDistances = 10.0,
        MaxGraffitiPerGang = 25,

        LimitPerMember = 0, -- in minutes
        CleanLimitPerMember = 0, -- in minutes

        SmartPlacing = false, -- true / false

        PlaceReputation = 50,
        CleanReputation = 25,

        DisableControls = {24,257,25,263,32,34,31,30,45,22,44,37,23,288,289,170,167,73,199,59,71,72,36,47,264,257,140,141,142,143,75}, -- Disabled controls

        CleanGraffitiNotifyAlert = true,
        CleanGraffitiBlipAlert = {use = true, sprite = 161, color = 2, size = 0.8, time = 1}, -- use: true / false | time: 1 = 1min

        BlacklistedZones = {
            {coords = vector3(455.81, -997.04, 43.69), radius = 200.0}, -- Police
            {coords = vector3(324.76, -585.72, 59.15), radius = 100.0}, -- Hospital
            {coords = vector3(-376.73, -119.47, 40.73), radius = 100.0}, -- Mechanic
        },

        Icons = {
            {name = "None", prop = "", png = "None.png"}, -- this is the basic one, do not edit it.
            {name = "Vagos", prop = "sprays_vagos", png = "Vagos.png"},
            {name = "Lost MC", prop = "sprays_lost", png = "Lost_MC.png"},
            {name = "Families", prop = "sprays_families", png = "families.png"},
            {name = "Cartel", prop = "sprays_cartel", png = "CartelLogo.png"},
            {name = "Mafia", prop = "sprays_mafia", png = "MafiaWhite.png"},
            {name = "Triads", prop = "sprays_triads", png = "Triads.png"},
            {name = "Angels of Death", prop = "sprays_angels", png = "AOD_logo.png"},
            {name = "Ballas", prop = "sprays_ballas", png = "Ballas.png"},
            {name = "Aztecas", prop = "sprays_aztecas", png = "Aztecas.png"},
            {name = "Disciples", prop = "sprays_disciples", png = "Disciples.png"},
            {name = "Yakuza", prop = "sprays_yakuza", png = "Yakuza.png"},
            --{name = "The Mandnem", prop = "sprays_mandem", png = "The_Mandnem.png"},
            --{name = "The Guild", prop = "sprays_guild", png = "The_Guild.png"},
            --{name = "Street Team", prop = "sprays_st", png = "Street_Team.png"},
            --{name = "Seaside", prop = "sprays_seaside", png = "Seaside.png"},
            --{name = "SCU", prop = "sprays_scu", png = "SCU.png"},
            --{name = "Rust", prop = "sprays_rust", png = "Rust.png"},
            --{name = "Ron", prop = "sprays_ron", png = "Ron.png"},
            --{name = "Ramee", prop = "sprays_ramee", png = "Ramee.png"},
            --{name = "NBC", prop = "sprays_nbc", png = "NBC.png"},
            --{name = "Mayhem", prop = "sprays_mayhem", png = "Mayhem.png"},
            --{name = "Kingz", prop = "sprays_kingz", png = "Kingz.png"},
            --{name = "Hydra", prop = "sprays_hydra", png = "Hydra.png"},
            --{name = "Hoa", prop = "sprays_hoa", png = "Hoa.png"},
            --{name = "Gulag Gang", prop = "sprays_gg", png = "Gulag_Gang.png"},
            --{name = "GSF", prop = "sprays_gsf", png = "GSF.png"},
            --{name = "Chang Gang", prop = "sprays_cg", png = "Chang_Gang.png"},
            --{name = "Cerberus", prop = "sprays_cerberus", png = "Cerberus.png"},
            --{name = "BSK", prop = "sprays_bsk", png = "BSK.png"},
            --{name = "Bondi Boys MC", prop = "sprays_bcf", png = "Bondi_Boys_Mc.png"},
            --{name = "BCF", prop = "sprays_bcf", png = "BCF.png"},
            --{name = "Ballas", prop = "sprays_ballas", png = "Ballas.png"},
            --{name = "Angels", prop = "sprays_angels", png = "Angels.png"},
        },
    },

    Tasks = {
        ["drug"] = {
            Label = "NARCOTICS HEIST",
            Description = "In the Narcotics Heist, steal a drug shipment from a cartel and sell it before they catch you.",
            TimeToCompletion = 20, -- in minutes
            TimeToRestart = 360, -- in minutes
            Reward = {money = {min = 5000, max = 20000}, rep = {min = 250, max = 1000}},

            VanPosition = {
                {
                    Van = vector4(-463.3471, -63.0104, 44.2518, 218.4606),
                    Guards = {
                        {model = "g_m_y_korean_02", coords = vector4(-459.7697, -62.7800, 44.5134, 42.0405), weapon = "WEAPON_ASSAULTRIFLE"},
                        {model = "g_m_y_korean_01", coords = vector4(-468.8365, -62.5431, 44.5134, 345.1089), weapon = "WEAPON_ASSAULTRIFLE"},
                        {model = "g_m_y_mexgoon_03", coords = vector4(-459.6652, -56.9242, 44.5134, 75.7623), weapon = "WEAPON_ASSAULTRIFLE"},
                    },
                },

                {
                    Van = vector4(155.0316, -1233.0797, 28.9633, 254.9915),
                    Guards = {
                        {model = "g_m_y_korean_02", coords = vector4(149.0482, -1230.9833, 29.1985, 223.3919), weapon = "WEAPON_ASSAULTRIFLE"},
                        {model = "g_m_y_korean_01", coords = vector4(147.3018, -1232.9353, 29.1985, 250.9159), weapon = "WEAPON_ASSAULTRIFLE"},
                        {model = "g_m_y_mexgoon_03", coords = vector4(146.1674, -1235.1293, 29.1985, 255.9488), weapon = "WEAPON_ASSAULTRIFLE"},
                    },
                },
            },
            EndingPoint = {
                {
                    MainCoords = vector3(1162.4951, -1496.4705, 34.4312), 
                    CustomersVehicle = vector4(1158.1821, -1490.3347, 34.4314, 2.1476),
                    Customers = {
                        {model = "g_m_y_mexgoon_03", coords = vector4(1156.4387, -1493.8158, 33.6925, 239.6427)},
                        {model = "g_m_y_mexgang_01", coords = vector4(1159.7421, -1493.9291, 33.6925, 142.1639)},
                    },
                },

                {
                    MainCoords = vector3(676.3511, -2648.5149, 5.8198), 
                    CustomersVehicle = vector4(668.6371, -2655.3589, 5.8093, 152.9441),
                    Customers = {
                        {model = "g_m_y_mexgoon_03", coords = vector4(671.9014, -2653.2356, 5.0812, 15.0290)},
                        {model = "g_m_y_mexgang_01", coords = vector4(668.8821, -2651.4241, 5.0812, 286.6457)},
                    },
                },
            }
        },

        ["disposalofthebody"] = {
            Label = "BODY DISPOSAL",
            Description = "You must discreetly get rid of evidence by disposing of a body without leaving any trace for law enforcement.",
            TimeToCompletion = 20, -- in minutes
            TimeToRestart = 360, -- in minutes
            Reward = {money = {min = 10000, max = 15000}, rep = {min = 500, max = 800}},

            VanPosition = {
                {coords = vector4(679.8264, 68.4786, 83.2498, 182.2196)},
            },
            DeadBodyPosition = {
                {coords = vector3(-1077.0720, 712.9972, 163.4137), heading = 127.0},
            },
            EndingPoint = {
                {
                    MainCoords = vector3(67.0433, -2755.7847, 6.0046), 
                    Boat = {model = 'tropic', coords = vector4(8.6673, -2797.2100, 0.2756, 181.5510)},
                    ThrowPoint = vector3(-250.7096, -4219.0371, -3.2772),
                },
            }
        },

        ["homeless"] = {
            Label = "HOMELESS KIDNAPPING",
            Description = "You must abduct a target from the streets without drawing attention from bystanders or authorities.",
            TimeToCompletion = 20, -- in minutes
            TimeToRestart = 360, -- in minutes
            Reward = {money = {min = 6000, max = 12000}, rep = {min = 450, max = 1350}},

            HomelessPedPosition = {
                {coords = vector3(18.5995, -1228.6848, 28.4795), heading = 280.0},
                {coords = vector3(357.6796, -835.1513, 28.2916), heading = 176.0},
                {coords = vector3(-517.6873, -865.7912, 28.5060), heading = 280.0},
            },
            EndingPoint = {
                {
                    MainCoords = vector3(1377.6155, -747.5517, 66.47), 
                    CustomersVehicle = {model = 'dubsta2', coords = vector4(1386.2517, -742.9697, 67.2858, 339.2372)},
                    Customers = {
                        {model = "g_m_y_mexgang_01", coords = vector4(1387.3867, -745.9840, 66.1903, 90.7682)},
                        {model = "g_m_y_mexgoon_03", coords = vector4(1383.4774, -744.2767, 66.1852, 151.0328)},
                    },
                },

                {
                    MainCoords = vector3(-1157.2125, -1454.5078, 3.4823), 
                    CustomersVehicle = {model = 'dubsta2', coords = vector4(-1155.9701, -1462.3113, 4.3237, 125.4273)},
                    Customers = {
                        {model = "g_m_y_mexgoon_03", coords = vector4(-1151.7054, -1462.2007, 3.4187, 20.5159)},
                        {model = "g_m_y_mexgang_01", coords = vector4(-1156.8384, -1460.3912, 3.3861, 311.5188)},
                    },
                },
            }
        },

        ["assassination"] = {
            Label = "ASSASSINATION CONTRACT",
            Description = "You must eliminate a high-value target quickly and discreetly, leaving no witnesses behind.",
            TimeToCompletion = 20, -- in minutes
            TimeToRestart = 360, -- in minutes
            Reward = {money = {min = 7500, max = 30000}, rep = {min = 250, max = 1150}},

            TargetPedPosition = {
                {startcoords = vector3(-332.3789, -672.7446, 32.3814), finishcoords = vector3(304.8678, -740.3984, 29.3166)},
                {startcoords = vector3(553.8753, 152.7980, 99.2896), finishcoords = vector3(-239.1566, 244.2611, 92.0406)},
                {startcoords = vector3(-1274.0237, 315.4701, 65.5117), finishcoords = vector3(-1392.7247, -299.2366, 43.6122)},
            },
            EndingPoint = {
                {
                    MainCoords = vector3(265.9774, 3178.4739, 41.6437), 
                    Customers = {
                        {model = "g_m_y_mexgoon_03", coords = vector4(260.6587, 3178.2278, 41.7484, 283.4235)},
                    },
                },
                {
                    MainCoords = vector3(1534.0110, 6328.8813, 23.4418), 
                    Customers = {
                        {model = "g_m_y_mexgoon_03", coords = vector4(1538.7380, 6324.4023, 23.0684, 37.5559)},
                    },
                },
            }
        },
    },
   
    -----------------------------------------------------------
    -----------------------| TRANSLATE |-----------------------
    -----------------------------------------------------------

    MoneyForm = '$', -- Money form

    Locales = {
        CurrencyForm = "USD",
        ReputationForm = "REP",

        DefaultGradeName = "Member",

        MemberRankName = "Member",
        LeaderRankName = "Leader",

        Cloakrooms = "Cloakroom",
        Stashes = "Stash",
        BalanceManages = "Balance Manage",
        Garages = "Garage",
        Safe = "Safe",
        SafeDescription = "With this upgrade you get a safe that only special gang members can access.",
        SafeDescription2 = "This upgrade will increase the storage capacity of the safe.",
        

        Vehicles = "Vehicles",
        VehiclesDescription = "With this upgrade you can store more cars in the gang garage.",
        Stash = "Stash",
        StashDescription = "This upgrade will increase the storage capacity of the stash.",
        MaxRanks = "Max Ranks",
        MaxRanksDescription = "With this upgrade the gang leader can create more ranks.",
        Raid = "Raid",
        RaidDescription = "With this upgrade your gang will be able to start a raid against another gang.",

        CoordsEditingText = "~y~Press ~INPUT_CELLPHONE_SELECT~ to set the new coords.~w~\nPress ~INPUT_CELLPHONE_CANCEL~ to ~r~cancel~w~ the process.",
        GraffitiPlacingText = "~y~Press ~INPUT_CELLPHONE_SELECT~ to create the graffiti.~w~\nPress ~INPUT_CELLPHONE_CANCEL~ to ~r~cancel~w~ the process.",

        TaskStart = "Task Start",

        Blips = {
            HQ = "HQ",
            Safe = "Safe",
            Vehicle = "Vehicle",
            House = "House",
            Port = "Port",
            Boat = "Boat",
            Drop = "Drop",
            Company = "Company",
            DrugSelling = "Drug Selling",
            Money = "Get Money",
            Homeless = "Homeless",
            MeetingPoint = "Meeting point",
            Target = "Target",
        }
    },

    Texts = {
        [1] = {'[E] - Dress Menu', 38, 'Open the dress menu', 'fa-solid fa-person-half-dress'},
        [2] = {'[E] - Stash Menu', 38, 'Open the stash menu', 'fa-solid fa-box-open'}, 
        [3] = {'[E] - Garage Menu', 38, 'Open the garage menu', 'fa-solid fa-warehouse'}, 
        [4] = {'[E] - Vehicle storage', 38, 'To storage the vehicle', 'fa-solid fa-car'}, 
        [5] = {'[E] - Safe Menu', 38, 'Open the safe menu', 'fa-solid fa-shield'}, 
        [6] = {'[E] - Balance Manage', 38, 'Open the balance menu', 'fa-solid fa-coins'}, 
        [7] = {'[E] - Continue the task', 38},
        [8] = {'[E] - Start the task', 38},  
    },
    
    -- Notify function EDITABLE >> cl_utils.lua
    Notify = { 
        [1] = {"Gangs", "You're too far!", 5000, "error"},
        [2] = {"Gangs", "The job already exists!", 5000, "error"},
        [3] = {"Gangs", "You don't have permission to do this.", 5000, "error"},
        [4] = {"Gangs", "You've successfully invited a new member!", 5000, "success"},
        [5] = {"Gangs", "You've been successfully added to a gang!", 5000, "success"},
        [6] = {"Gangs", "You've kicked them out of the gang!", 5000, "success"},
        [7] = {"Gangs", "You've been kicked out of the gang!", 5000, "info"},
        [8] = {"Gangs", "Invalid Gang!", 5000, "error"},
        [9] = {"Gangs", "S/he is already a leader!", 5000, "error"},
        [10] = {"Gangs", "You have successfully added a new leader!", 5000, "success"},
        [11] = {"Gangs", "You're a gang leader now!", 5000, "info"},
        [12] = {"Gangs", "Invalid Player ID!", 5000, "error"},
        [13] = {"Gangs", "This rank already exists!", 5000, "error"},
        [14] = {"Gangs", "You've successfully created the new rank!", 5000, "success"},
        [15] = {"Gangs", "You've deleted the selected rank!", 5000, "success"},
        [16] = {"Gangs", "Before deleting make sure that nobody have this rank!", 5000, "error"},
        [17] = {"Gangs", "For example: /setgangleader [id] [job]", 5000, "error"},
        [18] = {"Gangs", "Successfully update!", 5000, "success"},
        [19] = {"Gangs", "There isn't enough money for that!", 5000, "error"},
        [20] = {"Gangs", "You can't turn this vehicle into a gang car because it's not yours!", 7000, "error"},
        [21] = {"Gangs", "The vehicle is not in the garage!", 5000, "error"},
        [22] = {"Gangs", "You've got it back:", 5000, "success"},
        [23] = {"Gangs", "No vehicle to get back!", 5000, "error"},
        [24] = {"Gangs", "Upgrade needed for this action!", 5000, "error"},
        [25] = {"Gangs", "Another vehicle occupies the space!", 5000, "error"},
        [26] = {"Gangs", "S/he is already a member of the group!", 5000, "error"},
        [27] = {"Gangs", "Fill in all the fields!", 5000, "error"},
        [28] = {"Gangs", "You cannot delete it!", 5000, "error"},
        [29] = {"Gangs", "You're too far from the middle of hq!", 5000, "error"},
        [30] = {"Gangs", "This HQ is already in use!", 5000, "error"},
        [31] = {"Gangs", "Invalid HQ! The hq isn't defined in the config!", 5000, "error"},
        [32] = {"Gangs", "Successful pin!", 5000, "success"},
        [33] = {"Gangs", "Your rank has been changed to:", 5000, "info"},
        [34] = {"Gangs", "The rank's name must be between 3-12 characters!", 5000, "error"},
        [35] = {"Gangs", "You have already reached today's limit!", 5000, "error"},
        [36] = {"Gangs", "You've successfully started!", 5000, "success"},
        [37] = {"Gangs", "You cannot start it right now, not enough members available for this!", 5000, "error"},
        [38] = {"Gangs", "New level of gang:", 5000, "success"},
        [39] = {"Gangs", "There isn't that much money available in the safe!", 5000, "error"},
        [40] = {"Gangs", "You don't have enough money!", 5000, "error"},
        [41] = {"Gangs", "Your gang is under attack!", 5000, "info"},
        [42] = {"Gangs", "You have successfully deleted the job!", 5000, "success"},
        [43] = {"Gangs", "You cannot put graffiti on this place.", 5000, "error"},
        [44] = {"Gangs", "Someone has already put graffiti nearby.", 5000, "error"},
        [45] = {"Gangs", "You have reached maximum graffiti in the team!", 5000, "error"},
        [46] = {"Gangs", "There is no near graffiti!", 5000, "error"},
        [47] = {"Gangs", "You do not have the necessary item!", 5000, "error"},
        [48] = {"Gangs", "You have to get out of the car!", 5000, "error"},
        [49] = {"Gangs", "You have to park your car here!", 5000, "error"},
        [50] = {"Gangs", "You failed!", 5000, "error"},
        [51] = {"Gangs", "For example: /setgangleader [player id]", 5000, "error"},
        [52] = {"Gangs", "No drugs on your hands!", 5000, "error"},
        [53] = {"Gangs", "The gang name and label must be at least 3 characters long!", 5000, "error"},
        [54] = {"Gangs", "You have successfully created the job!", 5000, "success"},
        [55] = {"Gangs", "You have successfully saved it!", 5000, "success"},
        [56] = {"Gangs", "The task has failed!", 5000, "error"},
        [57] = {"Gangs", "There is already a task in progress!", 5000, "error"},
        [58] = {"Gangs", "The selected task is already in use!", 5000, "error"},
        [59] = {"Gangs", "You have successfully completed the task!", 5000, "success"},
        [60] = {"Gangs", "You can only graffiti every 10 minutes! Try again later!", 5000, "error"},
        [61] = {"Gangs", "You can only clean graffiti every 10 minutes!", 5000, "error"},
        [62] = {"Gangs", "They all must die!", 5000, "error"},
        [63] = {"Gangs", "The vehicle must be empty!", 5000, "error"},
        [64] = {"Gangs", "There must be a vehicle near!", 5000, "error"},
        [65] = {"Gangs", "Catch the homeless man!", 5000, "info"},
        [66] = {"Gangs", "Already in progress!", 5000, "error"},
        [67] = {"Gangs", "No spaces in the gang name!", 5000, "error"},
        [68] = {"Gangs", "You are not able to open the menu!", 5000, "error"},
        [69] = {"Gangs", "The player must be a gang member first!", 5000, "error"},
        [70] = {"Gangs", "The gang icon must be selected in the menu!", 5000, "error"},
        [71] = {"Gangs", "Someone cleaned your gang's graffiti! Marked on the map!", 5000, "info"},
    },

    TaskMessages = {
        TaskStarted = "TASK STARTED",
        NextPart = "NEXT PART",
        TaskCompleted = "TASK COMPLETED",
        Warning = '<span style="color:red;">WARNING</span>',
        Success = '<span style="color:lightgreen;">SUCCESS</span>',
        Failed = '<span style="color:red;">FAILED</span>',
        Info = '<span style="color:lightblue;">INFORMATION</span>',

        Scout = "Watch your enemies to get information about them!",
        Scout2 = "You have successfully got the data on them!",
        Scout3 = "The task could not be completed in time!",

        Raid1 = "Stay on the enemy's HQ until time runs out!",
        Raid2 = "Defend your HQ and kill your enemies!",
        Raid3 = "You've lost the raid!",
        Raid4 = "You've won the raid!",

        StashLoot1 = "STASH LOOT",
        StashLoot2 = "Now you can loot out the enemy's stash",

        DriveTo = "Drive to the designated place!",

        BodyDisposal1 = "Break the car!",
        BodyDisposal2 = "Drive to the location and pick up the body!",
        BodyDisposal3 = "Put it in the car!",
        BodyDisposal4 = "Go to the port!",
        BodyDisposal5 = "Get the body bag out of the trunk!",
        BodyDisposal6 = "Put the body bag in the boat!",
        BodyDisposal7 = "Drop the body in the water at the designated place!",
        BodyDisposal8 = "Go back to the port!",
        BodyDisposal9 = "Let's go back to the starting point!",

        Drug1 = "Steal the van full of drugs!",
        Drug2 = "Go to your customers!",
        Drug3 = "Move the drugs to the other car.",
        Drug4 = "Pick up the money from the customer!",

        Homeless1 = "Catch and put the homeless man in the trunk!",
        Homeless2 = "Go to your customers!",
        Homeless3 = "Put the homeless man in the customer's trunk!",
        Homeless4 = "Pick up the money from the customer!",

        Assassination1 = "Kill the target without getting close!",
        Assassination2 = "Put the body on your shoulders!",
        Assassination3 = "Put the body in the trunk!",
        Assassination4 = "Go to your customers!",
        Assassination5 = "Drop the body!",
        Assassination6 = "Pick up the money from the customer!",
    },

    Webhooks = {
        Locale = {
            ['editGangDatas1'] = "⌛ Gang details updated...",
            ['gangCreation1'] = "🆕 New gang has been created...",
            ['gangDeleted1'] = "🆕 Gang has been deleted...",
            ['scout1'] = "🔍 They got the data from another gang...",
            ['raidStart1'] = "⚔️ Raid has started...",
            ['raidEnd1'] = "⚔️ Raid has ended...",

            ['editGangDatas2'] = "edited the gang's data.",
            ['gangCreation2'] = "created a new gang.",
            ['gangDeleted2'] = "deleted a gang.",
            ['scout2'] = "started the scouting...",
            ['raidStart2'] = "started a raid...",

            ['Identifier'] = "Identifier",
            ['GangName'] = "Gang Name",
            ['GangLabel'] = "Gang Label",
            ['Balance'] = "Balance",
            ['Reputation'] = "Reputation Points",
            ['Status'] = "Status 📈",
            ['Enemy'] = "Enemy 😈",
            ['TargetGang'] = "Target Gang",
            ['Table'] = "Table",
            ['Lost'] = "LOST",
            ['Won'] = "WON",

            ['Time'] = "Time ⏲️",
        },

        -- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html
        Colors = {
            ['editGangDatas1'] = 3093151, 
            ['gangCreation1'] = 3145375,
            ['gangDeleted1'] = 16121856,
            ['scout1'] = 3145375,
            ['raidStart1'] = 3145375,
            ['raidEnd1'] = 5845663,
        }
    },
}

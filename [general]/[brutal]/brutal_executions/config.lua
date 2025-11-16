----------------------------------------------------------------------------------------------
-----------------------------------| BRUTAL EXECUTIONS :) |-----------------------------------
----------------------------------------------------------------------------------------------

--[[
Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com
--]]

Config = {
    Core = 'QBCORE',  -- 'ESX' / 'QBCORE' | Other core setting on the 'core' folder.
    Inventory = 'quasar_inventory', -- 'ox_inventory' / 'qb_inventory' / 'quasar_inventory' / 'chezza_inventory' / 'codem_inventory' / 'core_inventory' // Custom can be add in the cl_utils.lua!!!
    TextUI = 'ox_lib', -- false / 'brutal_textui' / 'ox_lib' / 'okokTextUI' / 'ESXTextUI' / 'QBDrawText' // Custom can be add in the cl_utils.lua!!!
    Target = 'oxtarget', -- 'oxtarget' / 'qb-target' // if the TextUI is set to false target will step its place. | The Target cannot be false.
    BrutalNotify = false, -- Buy here: (4€+VAT) https://store.brutalscripts.com | Or set up your own notify >> cl_utils.lua
    SteamName = false, -- true = Steam name | false = character name
    DateFormat = '%d/%m/%Y', -- Date format
    ClosestDistanceIssue = false, -- DO NOT EDIT IT.

    BrutalGangs = true, -- Buy here: https://store.brutalscripts.com | Or set up your own notify >> cl_utils.lua

    ColorOf3DUI = "blue", -- "green" / "red" / "blue" / "yellow" / "orange"
    Marker = {use = true, marker = 20, bobUpAndDown = true, rotate = false, size = {0.3, 0.2, 0.2}, rgb = {15, 100, 210}},
    Marker2 = {use = true, marker = 21, bobUpAndDown = true, rotate = false, size = {1.0, 1.0, 0.5}, rgb = {15, 100, 210}},

    TimeForExecution = 30, -- in minutes
    ExecutionRepeatable = 24, -- in hours

    Executions = {
        train = {
            Label = "TRAIN HIT EXECUTION",
            Description = "Tie up the target and place them on the train tracks. Watch as the train takes care of the rest.",
            Price = 300, 

            ReputationAmount = 1000, -- that's how many reputation points the players get for executions

            TrainSpawnTime = {min = 60, max = 180},
            DisableControls = {24,257,25,263,32,34,31,30,45,22,44,37,23,288,289,170,167,73,199,59,71,72,36,47,264,257,140,141,142,143,75},
            Coords = {
                {
                    railway_line = vector3(2672.0593, 3028.9395, 41.4648),
                    train_spawn = vector4(2197.2969, 2621.8513, 51.2507, 295.4281)
                },

                {
                    railway_line = vector3(-441.3982, 4060.2012, 83.9167),
                    train_spawn = vector4(-80.5979, 3493.3359, 53.0143, 53.3956)
                },

                -- you can add more...
            },

            PreparationCoords = {
                vector4(1486.5265, 1131.6558, 114.3366, 358.6116),
                vector4(1724.5144, 4730.7954, 42.1503, 8.9653),
                vector4(-148.0149, 6154.1250, 31.2063, 220.8026),
                -- you can add more...
            }
        },

        carbomb = {
            Label = "CAR BOMB SETUP",
            Description = "Place the target inside a vehicle, rig it with explosives, and detonate the car remotely.",
            Price = 300, 

            ReputationAmount = 1000, -- that's how many reputation points the players get for executions

            BombTimer = 600, -- in second

            PreparationCoords = {
                {
                    coords = vector3(245.9660, -1967.7738, 21.9617),
                    npcs = {
                        {coords = vector4(245.3465, -1967.0980, 21.9617, 234.9360), model = "g_m_y_ballaorig_01"},
                        {coords = vector4(245.0044, -1968.1914, 21.9617, 287.7616), model = "g_m_y_ballaeast_01"},
                        {coords = vector4(246.2626, -1966.7537, 21.9617, 176.9413), model = "g_m_y_ballasout_01"}
                    }
                },
                {
                    coords = vector3(-3170.0278, 1095.6748, 20.8527),
                    npcs = {
                        {coords = vector4(-3170.8972, 1094.7461, 20.8514, 18.0011), model = "a_m_m_mexcntry_01"},
                        {coords = vector4(-3169.1001, 1094.8177, 20.8580, 53.7193), model = "a_m_m_eastsa_01"},
                    }
                },
                {
                    coords = vector3(11.4977, 3719.5894, 39.6051),
                    npcs = {
                        {coords = vector4(10.7669, 3720.1104, 39.5793, 255.0411), model = "a_f_m_tramp_01"},
                        {coords = vector4(12.3006, 3721.1213, 39.6176, 174.9053), model = "a_m_y_hippy_01"},
                        {coords = vector4(10.6935, 3718.6125, 39.5885, 296.7392), model = "a_m_o_acult_02"},
                    }
                },

                -- you can add more...
            }
        },

        boat = {
            Label = "THROWING OVERBOARD",
            Description = "Bind the target with ropes and throw them overboard. Watch as the water ensures they won’t resurface.",
            Price = 300, 

            ReputationAmount = 1000, -- that's how many reputation points the players get for executions

            Boat = "squalo",

            Coords = {
                {
                    boat_request = vector3(712.0440, 4110.3691, 31.2997),
                    boat_spawn = vector4(709.4126, 4108.8662, 29.6299, 177.4471),
                    throwing = vector3(890.5597, 3896.8210, 30.0630),
                },

                {
                    boat_request = vector3(1333.7085, 4270.0332, 31.5031),
                    boat_spawn = vector4(1334.2489, 4267.0742, 30.0842, 262.7690),
                    throwing = vector3(-490.7659, 4419.6660, 31.1839),
                },

                {
                    boat_request = vector3(3855.3518, 4459.7197, 1.8498),
                    boat_spawn = vector4(3857.1582, 4455.8145, 0.3242, 270.1419),
                    throwing = vector3(4511.4307, 5113.5596, 1.0208),
                },
                -- you can add more...
            },

            PreparationCoords = {
                {
                    coords = vector3(709.8527, 4109.4048, 31.4847),
                    boat_spawn = vector4(709.4126, 4108.8662, 29.6299, 177.4471)
                },

                {
                    coords = vector3(1334.2391, 4265.8994, 31.8422),
                    boat_spawn = vector4(1334.2489, 4267.0742, 30.0842, 262.7690)
                },

                {
                    coords = vector3(3857.1980, 4455.6729, 1.1651),
                    boat_spawn = vector4(3857.1582, 4455.8145, 0.3242, 270.1419)
                },
                -- you can add more...
            }
        },
    },

    Commands = {
        ExecutionsMenu = {
            Command = 'executions', 
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'To open the executions menu'
        },

        CutRope = {
            Command = 'cutrope', 
            Suggestion = 'To cut the rope',

            KnifeNeeded = true, -- true / false
            AcceptedKnifes = {'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_DAGGER'},
        },

        BombSetup = {
            Command = 'bombsetup', 
            Suggestion = 'To setup the bomb'
        },

        BombDetonator = {
            Command = 'bombdetonator', 
            Suggestion = 'To open the bomb detonator'
        },

        BombDeactivation = {
            Command = 'bombdeactivation', 
            Suggestion = 'To deactivate the bomb',
            
            ItemNeeded = true,
            Item = "pliers"
        },
    },

   
    -----------------------------------------------------------
    -----------------------| TRANSLATE |-----------------------
    -----------------------------------------------------------

    MoneyForm = '$', -- Money form

    Locales = {
        CurrencyForm = "USD",
        ReputationForm = "REP",

        Preparation = "Preparation",
        Execution = "Execution",

        Preparations = {
            train = "Go to the designated place where you have to steal the rope!",
            carbomb = "Go to the designated place where you have to talk to the bomb dealers!",
            boat = "Go to the designated place where you have to break the boat's lock!"
        },

        Executions = {
            train = "Take the player to the designated location and tie them to the tracks!",
            carbomb = "Install the bomb in a car using the /bombsetup command!",
            carbomb2 = "Use the /bombdetonator command to blow up the car!",
            boat = "Throw the player off the boat into the water while their hands are tied!",
        },

        SuccessExecution = "The execution was completed successfully!"
    },

    Texts = {
        [1] = {'[E] - Select Player', 38, 'Select Player', 'fa-solid fa-magnifying-glass'},
        [2] = {'[E] - Tying to the tracks', 38, 'Tying to the tracks', 'fa-solid fa-train'},
        [3] = {'[E] - Placing a bomb', 38, 'Placing a bomb', 'fa-solid fa-location-dot'},
        [4] = {'[E] - Retrieve boat', 38, 'Retrieve boat', 'fa-solid fa-sailboat'},
        [5] = {'[E] - To start the Task', 38, 'To start the Task', 'fa-solid fa-play'},
        [6] = {'[E] - Stopping the boat', 38, 'Stopping the boat', 'fa-solid fa-stop'},
        [7] = {'[E] - Toss player overboard', 38, 'Toss player overboard', 'fa-solid fa-skull-crossbones'},
    },
    
    -- Notify function EDITABLE >> cl_utils.lua
    Notify = { 
        [1] = {"Executions", "The player has to be free!", 5000, "error"},
        [2] = {"Executions", "You cannot start at the moment!", 5000, "error"},
        [3] = {"Executions", "You don't have enough money!", 5000, "error"},
        [4] = {"Executions", "The player is too far away!", 5000, "error"},
        [5] = {"Executions", "The bomb has been deactivated!", 5000, "info"},
        [6] = {"Executions", "You have successfully deactivated the bomb!", 5000, "success"},
        [7] = {"Executions", "You are under a time limit! You have to wait!", 5000, "error"},
        [8] = {"Executions", "The time is up! (You had 30 minutes!)", 5000, "error"},
        [9] = {"Executions", "You have successfully got the information and the tools you need!", 5000, "success"},
        [10] = {"Executions", "You failed!", 5000, "error"},
        [11] = {"Executions", "Successful theft! Leave the boat!", 5000, "success"},
        [12] = {"Executions", "Place the bomb on the car!", 5000, "info"},
        [13] = {"Executions", "Go to the designated place!", 5000, "info"},
        [14] = {"Executions", "Noone is near you!", 5000, "info"},
        [15] = {"Executions", "You must have a knife in your hand!", 5000, "error"},
        [16] = {"Executions", "There is no vehicle nearby!", 5000, "error"},
        [17] = {"Executions", "You can't be in the car!", 5000, "error"},
        [18] = {"Executions", "No bomb in the car!", 5000, "info"},
        [19] = {"Executions", "You've cut the rope!", 5000, "success"},
        [20] = {"Executions", "You have been successfully saved!", 5000, "success"},
        [21] = {"Executions", "The target cannot be in the vehicle!", 5000, "error"},
        [22] = {"Executions", "You do not have the necessary item! (Pliers)", 5000, "error"},
        [23] = {"Executions", "There is already one in progress!", 5000, "error"},
    },
    
    Webhooks = {
        Locale = {
            ['editGangDatas1'] = "⌛ Gang details updated...",

            ['editGangDatas2'] = "edited the gang's data.",

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

            ['Time'] = "Time ⏲️"
        },

        -- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html
        Colors = {
            ['editGangDatas1'] = 3093151, 
        }
    },
}

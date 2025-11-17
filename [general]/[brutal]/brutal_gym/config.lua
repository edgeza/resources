


----------------------------------------------------------------------------------------------
-----------------------------------| BRUTAL GYM SYSTEM :) |-----------------------------------
----------------------------------------------------------------------------------------------

--[[

Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com

--]]

-- You can add your own notify here >> [gym-cl_utils.lua]

Config = {
    DeveloperMode = false, -- Developer mode (for support)

    Core = 'QBCORE',  -- ESX / QBCORE  | Other core setting on the 'core' folder
    TextUI = 'ox_lib', -- false = DrawText3D / 'brutal_textui' / 'ox_lib' / 'okokTextUI' / 'ESXTextUI' / 'QBDrawText' // Custom can be add in the gym-cl_utils.lua!!!
    ProgressBar = '', -- 'progressBars' / 'pogressBar' / 'mythic_progbar' // Custom can be add in the gym-cl_utils.lua!!!
    BrutalNotify = true, -- Buy here: (4€+VAT) https://store.brutalscripts.com | Or set up your own notify >> gym-cl_utils.lua
    MINIGAME = false,  -- Download here: https://github.com/firestix77/taskbarskill   (You can edit in the [gym-cl_utils.lua])
    GYMDistance = 60,  -- This is the distance from which membership is broken
    PressKey = 38,  -- If you want to change: https://docs.fivem.net/docs/game-references/controls/

    DisableControls = {}, -- These controls will blocked during the exercises
    ShootWeponsBlackList = {'WEAPON_PETROLCAN'},

    GYMResting = {
        Use = false, -- Enable resting between workouts.
        RestDuration = 60, -- Rest duration in seconds. 
    },

    Skills = {
        SkillMenu = {Label = 'Brutal Skill Menu', Command = 'skillmenu', Control = 'DELETE'},  -- SETTINGS > KEYBINDINGS
        SkillNotifyTime = 5000, -- in milisec | 1000 = 1 sec
        SaveFrequency = 5, -- in minutes | Save in the SQL after that time
        RemoveTime = 40,  -- in munites | Remove one skill from player after that time

        SprintSpeedIncrease = 'MEDIUM', -- ('FAST', 'MEDIUM', 'SLOWLY') At what rate should you increase the run speed?
        SwimSpeedIncrease = 'MEDIUM', -- ('FAST', 'MEDIUM', 'SLOWLY') At what rate should you increase the swimming speed?
        StrengthIncrease = 'MEDIUM', -- ('HIGH', 'MEDIUM', 'LOW') At what rate should you increase strength?

        AllowOutsideTraining = false, -- If true, players can earn Stamina and Running points even when not in the gym.

        SkillTypes = {
            -- ⬇️ DO not edit this FIRST element! [You can edit the Skill Name with the Label]
            ['Stamina']  = {Use = true, Label = 'Stamina', Color = 'rgb(24, 191, 238)', Description = 'Affects ability to sprint, cycle and swim, Max stamina is unlimited stamina.'},
            ['Running']  = {Use = true, Label = 'Running', Color = 'rgb(24, 237, 148)', Description = 'Increases running speed. This brings a number of benefits.'},
            ['Driving']  = {Use = true, Label = 'Driving', Color = 'rgb(198, 237, 24)', Description = 'Increase vehicle handling, control wheelies better, increases control of veicle while in the air.'},
            ['Strength'] = {Use = true, Label = 'Strength', Color = 'rgb(237, 24, 24)', Description = 'Increases melee ability, increases speed on ladders/climbing, increases proficiency in sports, reduces demage taken.'},
            ['Swimming'] = {Use = true, Label = 'Swimming', Color = 'rgb(52, 24, 237)', Description = 'Increases the lung capacity, you can stay underwater longer.'},
            ['Shooting'] = {Use = true, Label = 'Shooting', Color = 'rgb(212, 24, 237)', Description = 'Increases accuracy, reduces recoil of guns, increases ammo capacity.'},
        }
    },

    Exersices = {
        -- Only use these [Stamina / Running / Driving / Strength / Swimming / Shooting] to the skill value.
        ['running'] = {label = "Running", anim = "running", time = 30, skill = 'Running'},
        ['pushups'] = {label = "Pushups", anim = "pushups", time = 30, skill = 'Strength'},
        ['situps'] = {label = "Situps", anim = "situps", time = 30, skill = 'Stamina'},
        ['weightlifting'] = {label = "Weightlifting", anim = "world_human_muscle_free_weights", time = 30, skill = 'Strength'},
        ['yoga'] = {label = "Yoga", anim = "world_human_yoga", time = 30, skill = 'Stamina'},
        ['pullup'] = {label = "Pullup", anim = "prop_human_muscle_chin_ups", time = 30, skill = 'Strength'},
        -- You can add more...
    },
    
    Gyms = {
        ['Beach GYM'] = {
            ItemRequired = {Use = false, Item = '', Time = 30, RemoveItem = false},
            Distances = {Marker = 10, Text = 1.0},
            GYMCoords = { x = -1200.3149, y = -1568.4581, z = 4.6123},
            Marker = { Distance = 15, Sprite = 30, Rotation = true, UpAndDown = false, Brightness = 100, r = 240, g = 221, b = 12, sizes = {x = 0.25, y = 0.3, z = 0.3}},  -- More sprites: https://docs.fivem.net/docs/game-references/markers/
            Blip = { Use = true, colour = 33, size = 1.1, sprite = 311 },
            Exersices = {
                [1]  = { type = 'weightlifting', x = -1197.0083, y = -1573.0277, z = 4.6125, heading = 29.5812},
                [2]  = { type = 'weightlifting', x = -1210.0604, y = -1561.3734, z = 4.6080, heading = 76.0602},
                [3]  = { type = 'pullup', x = -1204.6512, y = -1564.4742, z = 4.6096, heading = 36.2476},
                [4]  = { type = 'pullup', x = -1200.1077, y = -1570.9010, z = 4.6097, heading = 216.9520},
                [5]  = { type = 'yoga', x = -1204.6547, y = -1560.7797, z = 4.6143, heading = 35.4453},
                [6]  = { type = 'pushups', x = -1207.3629, y = -1565.8481, z = 4.6080, heading = 125.5502},
                [7]  = { type = 'situps', x = -1202.0811, y = -1567.2975, z = 4.6106,heading =  209.7822},
                -- You can add more...
            }
        },
        ['Patreon GYM'] = {
            ItemRequired = {Use = false, Item = '', Time = 30, RemoveItem = false},
            Distances = {Marker = 10, Text = 1.0},
            GYMCoords = { x = 366.71, y = -1606.99, z = 29.76},
            Marker = { Distance = 15, Sprite = 30, Rotation = true, UpAndDown = false, Brightness = 100, r = 37, g = 10, b = 242, sizes = {x = 0.25, y = 0.3, z = 0.3}},  -- More sprites: https://docs.fivem.net/docs/game-references/markers/
            Blip = { Use = false, colour = 33, size = 0.7, sprite = 311 },
            Exersices = {
                [1]  = { type = 'running', x = -2953.31, y = 635.91, z = 24.33, heading =  284.35},
                [2]  = { type = 'running', x = -2953.67, y = 637.60, z = 24.33, heading =  288.53},
                [3]  = { type = 'running', x = -2954.12, y = 639.33, z = 24.33, heading =  288.07},
                [4]  = { type = 'situps', x = -2955.00, y = 640.91, z = 24.18,  heading = 287.39},
            }
        },
        ['Police Gym'] = {
            ItemRequired = {Use = false, Item = '', Time = 30, RemoveItem = false},
            Distances = {Marker = 10, Text = 1.0},
            GYMCoords = { x = 870.57, y = -1320.03, z = 26.86},
            Marker = { Distance = 15, Sprite = 30, Rotation = true, UpAndDown = false, Brightness = 100, r = 37, g = 10, b = 242, sizes = {x = 0.25, y = 0.3, z = 0.3}},  -- More sprites: https://docs.fivem.net/docs/game-references/markers/
            Blip = { Use = false, colour = 33, size = 0.7, sprite = 311 },
            Exersices = {
                [1]  = { type = 'running', x = 861.78, y = -1319.41, z = 26.84, heading =  90.21}, 
                [2]  = { type = 'running', x = 861.64, y = -1318.03, z = 26.87, heading =  89.28}, 
                [3]  = { type = 'running', x = 861.72, y = -1316.64, z = 26.9, heading =  91.94}, 
                [4]  = { type = 'running', x = 861.83, y = -1315.33, z = 26.94, heading =  91.12},  
                [5]  = { type = 'weightlifting', x = 867.65, y = -1315.17, z = 26.97, heading = 4.05},
                [6]  = { type = 'weightlifting', x = 871.29, y = -1315.25, z = 27.02, heading = 3.39},
                [7]  = { type = 'weightlifting', x = 874.99, y = -1317.4, z = 27.04, heading = 270.35},
                [8]  = { type = 'weightlifting', x = 874.99, y = -1321.63, z = 26.92, heading = 268.11},  
                [9]  = { type = 'pullup', x = 870.95, y = -1321.44, z = 26.83, heading = 180.93},
                [10]  = { type = 'pullup', x = 868.27, y = -1321.58, z = 26.77, heading = 180.58},
                [11]  = { type = 'situps', x = 875.4, y = -1319.44, z = 26.99, heading =  87.12},
            }
        },
    },
    

    -----------------------------------------------------------
    -----------------------| TRANSLATE |-----------------------
    -----------------------------------------------------------

    Texts = {
        TextUI = {'[E] - Do some'}, 
        Text3D = {'To~r~', '~w~press ~w~[~g~E~w~]'}, 
    },    

    Notify = {
        [1] = {'Brutal GYM', "You don't have GYM card!", 5000, 'error'},
        [2] = {'Brutal GYM', "The time is up!", 5000, 'warning'},
        [3] = {'Brutal GYM', "You left the GYM!", 5000, 'warning'},
        [4] = {'Brutal GYM', "You can not do this in a vehicle!", 5000, 'error'},
        [5] = {'Brutal GYM', "You need to rest before starting another workout!", 5000, 'warning'},
        [6] = {'Brutal GYM', "You can now exercise again.", 5000, 'info'},
    }
}
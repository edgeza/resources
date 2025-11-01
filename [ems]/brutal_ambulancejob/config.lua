----------------------------------------------------------------------------------------------
----------------------------------| BRUTAL AMBULANCE JOB :) |---------------------------------
----------------------------------------------------------------------------------------------

--[[
Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com
--]]

Config = {
    Core = 'QBCORE',  -- 'ESX' / 'QBCORE' | Other core setting on the 'core' folder.
    Inventory = 'quasar_inventory', -- 'ox_inventory' / 'qb_inventory' / 'quasar_inventory' / 'chezza_inventory' / 'codem_inventory' / 'core_inventory' / 'origen_inventory' / 'ps-inventory' / 'tgiann-inventory' // Custom can be add in the cl_utils.lua!!!
    Billing = 'false', -- 'brutal_billing' / 'okokBilling' / 'esx_billing' / 'jaksam_billing' / 'codem_billing' / 'quasar_billing' | false = immediate deduction from the player's bank account
    TextUI = 'ox_lib', -- false / 'brutal_textui' / 'ox_lib' / 'okokTextUI' / 'ESXTextUI' / 'QBDrawText' // Custom can be add in the cl_utils.lua!!!
    Target = 'oxtarget', -- 'oxtarget' / 'qb-target' // if the TextUI is set to false target will step its place. | The Target cannot be false.
    ProgressBar = '', -- 'progressBars' / 'pogressBar' / 'mythic_progbar' // Custom can be add in the cl_utils.lua!!!
    BrutalNotify = true, -- Buy here: (4€+VAT) https://store.brutalscripts.com | Or set up your own notify >> cl_utils.lua
    BrutalKeys = false, -- Buy here: (15€+VAT) https://store.brutalscripts.com | Or set up your own if you're using a different vehicle key >> cl_utils.lua
    BrutalPaintball = false, -- If you use the Brutal Paintball, set it to true.
    SteamName = false, -- true = Steam name | false = character name
    DateFormat = '%d/%m/%Y', -- Date format
    CustomOutfitMenu = false, -- If it's true, it will open a custom outfit menu, what you can edit in the cl_utils.lua line 103.

    Bleeding = true,
    BleedNotify = true,
    InjuredWalk = true,

    UseDeathScreen = true,
    AutoRespawn = false, -- You can trun it off the auto respawn 
    DeathTime = 300, -- time til respawn is available
    WaitTime = 60,   -- time til the player bleeds out
    ReviveKey = 55,
    SaveDeathStatus = true,
    PlayerMedikitUsage = false, -- If you want to allow to the players to revive each other set it to true.
    DeathAnimation = {use = true, animDictionary = 'dead', animName = 'dead_a'},
    ReviveReward = 100, -- set to 0 if you don't want to use it. | This amount will be removed from the revived person 
    ClearInventory = false, -- true / false | Function editable: sv_utils.lua
    DisableControls = {170,168,24,257,25,263,32,34,31,30,45,22,44,37,23,288,289,170,167,73,199,59,71,72,36,47,264,257,140,141,142,143,75,249},
    ReviveCoords = {
        -- GABZ Hospital Coords
        vector4(313.1343, -583.4428, 43.2841, 332.1013),
        vector4(1839.4497, 3673.3372, 34.2767, 210.1900),

        -- QBCore Hospital Coords
        --vector4(349.5245, -591.6425, 43.3151, 344.9672),
    },

    MedicerItems = {
        Head = 'head_bandage',
        Arms = 'arm_wrap',
        Legs = 'leg_plaster',
        Body = 'body_bandage',
        Bandage = 'bandage',
        Medikit = 'medikit',
    },

    HealItems = {
        -- item = item name, value = heal points to add to the player's current health, anim use = true / false, animDictionary = anim dictionary, animName = anim name
        {item = 'small_heal', value = 20, anim = {use = false, animDictionary = 'anim@heists@narcotics@funding@gang_idle', animName = 'gang_chatting_idle01'}},
        {item = 'big_heal', value = 50, anim = {use = true, animDictionary = 'anim@heists@narcotics@funding@gang_idle', animName = 'gang_chatting_idle01'}},
        -- You can add more...
    },

    Elevators = {
        -- DISABLED: Using custom elevator system
    },

    NPCMenidersCount = -1, -- The NPC medic only usable If fewer (or equal) paramedics are available than this value.
    NPCMedicers = {}, -- Disabled: remove medical treatment interaction

    MedicItems = {
        ['ecg'] = {prop = 'prop_ld_purse_01', pos = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0}},
        ['bag'] = {prop = 'prop_ld_bomb', pos = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0}},
    },

    WheelchairVehicle = 'iak_wheelchair', -- DOWNLOAD FROM THE DOCS: https://docs.brutalscripts.com/
    Stretcher = {
        Vehicles = {
            {model = 'ambulance', xPos = 0.0, yPos = -3.0, zPos = 0.32, xRot = 0.0, yRot = 0.0, zRot = 90.0, offsetY = -6.0 },
            {model = 'fdnyambo', xPos = 0.0, yPos = -3.0, zPos = 0.7, xRot = 0.0, yRot = 0.0, zRot = 0.0, offsetY = -7.0 },
            {model = 'vdambulance', xPos = 0.0, yPos = -1.8, zPos = 0.3, xRot = 0.0, yRot = 0.0, zRot = 0.0, offsetY = -7.0 }, -- Purchase these vehicles at: https://voodoocustom.tebex.io/package/6390694
            {model = 'vdambulance2', xPos = 0.0, yPos = -1.8, zPos = 0.3, xRot = 0.0, yRot = 0.0, zRot = 0.0, offsetY = -7.0 },
            {model = 'vdambulance3', xPos = 0.0, yPos = -1.8, zPos = 0.3, xRot = 0.0, yRot = 0.0, zRot = 0.0, offsetY = -7.0 },
            {model = 'vdambulance4', xPos = 0.0, yPos = -1.8, zPos = 0.3, xRot = 0.0, yRot = 0.0, zRot = 0.0, offsetY = -7.0 },
            {model = 'vdambulance5', xPos = 0.0, yPos = -1.8, zPos = 0.3, xRot = 0.0, yRot = 0.0, zRot = 0.0, offsetY = -7.0 },
            {model = 'vdambulance6', xPos = 0.0, yPos = -1.8, zPos = 0.3, xRot = 0.0, yRot = 0.0, zRot = 0.0, offsetY = -7.0 },
            {model = 'vdambulance7', xPos = 0.0, yPos = -1.8, zPos = 0.3, xRot = 0.0, yRot = 0.0, zRot = 0.0, offsetY = -7.0 },
            {model = 'vdambulance8', xPos = 0.0, yPos = -1.8, zPos = 0.3, xRot = 0.0, yRot = 0.0, zRot = 0.0, offsetY = -7.0 },
        },
    },

    AmbulanceJobs = {
        ['Pillbox Hospital'] = {
            Job = 'ambulance', -- Job name

            Blip = {use = true, coords = vector3(303.8510, -586.7777, 43.2841), color = 2, sprite = 61, size = 0.75}, -- Job blip
            Marker = {use = true, type = 20, directions = {0.0,0.0,0.0}, rotations = {0.0,0.0,0.0}, scales = {0.3,0.2,0.2}, rgba = {233,88,69,255}, bobUpAndDown = true, faceCamera = true, rotate = false, textureDict = nil, textureName = false},
            
            Duty = vec3(311.97, -593.46, 43.44), -- Duty ON / OFF coords

            DutyBlips = { 
                use = true, -- With this the medicers can see the other medicers in the map.
                updatetime = 5000, -- Represents the time in milliseconds (1 second = 1000 milliseconds)
            },  

            Cloakrooms = {
                -- GABZ Hospital Coords
                vector3(301.5520, -599.3223, 43.2841),

                -- QBCore Hospital Coords
                --vector3(309.7783, -602.8839, 43.2918),

                
                -- You can add more...
            },

            Armorys = {
                -- GABZ Hospital Coords
                vector3(306.7001, -601.3186, 43.2841),

                -- QBCore Hospital Coords
                --vector3(298.6365, -599.4954, 43.2921),


                -- You can add more...
            },

            BossMenu = {
                grades = {3,4}, -- Grades allowed to access boss menu
                coords = {
                    -- Pillbox Hospital Coords
                    vector3(341.0698, -589.9628, 43.2841),

                    -- QBCore Hospital Coords
                    -- vector3(310.4246, -599.5806, 43.2918),

                
                    -- You can add more...
                },
            },

            Garages = {
                -- DISABLED: Using cd_garage instead
                -- You can add more...
            },

            Shop = {
                -- minGrade = The minimum grade to access to buy the item.
                {item = 'bandage', label = 'Bandage', price = 500, minGrade = 0},
                {item = 'medikit', label = 'Medikit', price = 500, minGrade = 0},
                {item = 'head_bandage', label = 'Head Bandage', price = 500, minGrade = 0},
                {item = 'arm_wrap', label = 'Arm Wrap', price = 500, minGrade = 0},
                {item = 'leg_plaster', label = 'Leg Plaster', price = 500, minGrade = 0},
                {item = 'body_bandage', label = 'Body Bandage', price = 500, minGrade = 0},
            },
        },
    },

    Commands = {
        Duty = {
            Use = true,
            Command = 'aduty', 
            Suggestion = 'Entering/Exiting duty'
        },

        JobMenu = {
            Command = 'emsjobmenu',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Open Job Menu'
        },

        MedicerMenu = {
            Command = 'medicmenu', 
            Suggestion = 'Open Medicer Menu'
        },

        MDT = {
            Use = true, -- if false here you can add your custom MDT >> cl_utils
            Command = 'emsmdt', 
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Open MDT Menu'
        },

        MedicCall = {
            Command = 'mediccall', 
            Suggestion = 'To get Medic help',
        },

        Bed = {
            Use = true,
            Command = 'bed', 
            Suggestion = 'To use the closest Bed',
            Objects = {'v_med_bed2', 'v_med_bed1', 'v_med_emptybed', -1519439119, -289946279}
        }
    },

    AdminCommands = {
        Revive = {Use = true, Command = 'revive', Suggestion = 'To revive a player', AdminGroups = {'superadmin', 'admin', 'mod', 'god'}}, -- /revive [me / all / PlayerID]
        Heal = {Use = false, Command = 'heal', Suggestion = 'To heal a player', AdminGroups = {'superadmin', 'admin', 'mod', 'god'}}, -- /heal [me / PlayerID]
        Kill = {Use = false, Command = 'kill', Suggestion = 'To kill a player', AdminGroups = {'superadmin', 'admin', 'mod', 'god'}}, -- /kill [me / PlayerID]
    },

    -----------------------------------------------------------
    -----------------------| TRANSLATE |-----------------------
    -----------------------------------------------------------

    MoneyForm = '$', -- Money form

    Locales = {
        CloakRoom = 'Cloak Room',
        GarageMenu = 'Garage Menu',

        Animations = 'Animations',
        Carry = 'Carry',
        Wheelchair = 'Wheelchair',
        Ecg = 'Ecg',
        Bag = 'Bag',
        Stretcher = 'Stretcher',
        Spawn = 'Spawn & Delete',
        PutOn = 'Put on/down',
        Bed = 'Put in/off Bed',
        Push = 'Push & Release',
        PutIn = 'Put in/out',
        MDT = 'MDT',
        MedicerMenu = 'Medic Menu',

        Colleague = 'Colleague',

        Hardmeele = 'Killed by hard meele',
        Bullet = 'Killed by a bullet',
        Knifes = 'Stabed to death',
        Bitten = 'Bitten by an animal',
        Fall = 'Fall from a high place',
        Explosive = 'Die in explosives',
        Gas = 'Gas',
        Fire = 'Burn in fire',
        Drown = 'Drown in water',
        Caraccident = 'Died in a car accident', 
        Unknown = 'The source of death is unknown',
        BlipName = 'Call #',
    },

    Progressbar = {
        DutyOFF = 'Duty OFF...',
        DutyON = 'Duty ON...',
    },

    Texts = {
        [1] = {'[E] - To open the dress menu', 38, 'Open the dress menu', 'fa-solid fa-person-half-dress'},
        [2] = {'[E] - To open the armory menu', 38, 'Open the armory menu', 'fa-solid fa-shield-halved'}, 
        [3] = {'[E] - To open the garage menu', 38, 'Open the garage menu', 'fa-solid fa-warehouse'},
        [4] = {'[E] - To deposit the vehicle', 38, 'Deposit the vehicle', 'fa-solid fa-car'},
        [5] = {'[E] - To open the boss menu', 38, 'Open the boss menu', 'fa-solid fa-users-gear'}, 
        [6] = {'[E] - To use the Elevator', 38, 'Use the Elevator', 'fa-solid fa-elevator'}, 
        [7] = {'[E] - To Duty ON', '[E] - To Duty OFF', 38, 'To Duty', 'fa-solid fa-newspaper'},
        [8] = {'[E] - To use the Bed', 38, 'Use the Bed', 'fa-solid fa-bed-pulse'}, 
        [9] = {'[X] - To leave the Bed', 73, 'Leave the Bed', 'fa-solid fa-person'}, 
        [10] = {'[E] - To get Medical treatment', 38, 'Medical treatment', 'fa-solid fa-kit-medical'}, 
    },
    
    -- Notify function EDITABLE >> cl_utils.lua
    Notify = { 
        [1] = {"Ambulance Job", "You don't have permission!", 5000, "error"},
        [2] = {"Ambulance Job", "No vehicle available for your rank.", 5000, "error"},
        [3] = {"Ambulance Job", "Something is in the way!", 5000, "error"},
        [4] = {"Ambulance Job", "Invalid ID!", 5000, "error"},
        [5] = {"Ambulance Job", "Duty: <b>ON", 5000, "info"},
        [6] = {"Ambulance Job", "Duty: <b>OFF", 5000, "info"},
        [7] = {"Ambulance Job", "Citizen Call <br>Street: ", 6000, "info"},
        [8] = {"Ambulance Job", "You have successfully submitted!", 6000, "success"},
        [9] = {"Ambulance Job", "Please DO NOT SPAM!", 8000, "error"},
        [10] = {"Ambulance Job", "You must be on duty!", 8000, "error"},
        [11] = {"Ambulance Job", "You have successfully created a fine!", 6000, "success"},
        [12] = {"Ambulance Job", "You don't have enough money!", 5000, "error"},
        [13] = {"Ambulance Job", "You don't have the item!", 5000, "error"},
        [14] = {"Ambulance Job", "No one is near.", 5000, "error"},
        [15] = {"Ambulance Job", "No bed near you!", 5000, "error"},
        [16] = {"Ambulance Job", "You have successfully used the Heal Item!", 5000, "success"},
        [17] = {"Ambulance Job", "You do not need it!", 5000, "info"},
        [18] = {"Ambulance Job", "Somebody is already pushing the Stretcher!", 5000, "error"},
        [19] = {"Ambulance Job", "You paid for medical treatment:", 5000, "info"},
        [20] = {"Ambulance Job", "There isn't any stretcher near you!", 5000, "error"},
        [21] = {"Ambulance Job", "The vehicle is too far from you!", 5000, "error"},
        [22] = {"Ambulance Job", "The stretcher is in the vehicle!", 5000, "error"},
        [23] = {"Ambulance Job", "There is available medicer(s)!", 5000, "error"},
        [24] = {"Ambulance Job", "Revive Reward:", 5000, "success"},
        [25] = {"Ambulance Job", "This vehicle is not usable.", 5000, "error"},
        [26] = {"Ambulance Job", "The stretcher is not free!", 5000, "error"},
        [27] = {"Ambulance Job", "The bed is not free!", 5000, "error"},
        [28] = {"Ambulance Job", "<br>You spent:<b>", 5000, "info"},
        [29] = {"Ambulance Job", "You got: ", 5000, "info"},
        [30] = {"Ambulance Job", "You have to wait to heal again!", 5000, "error"},
        [31] = {"Ambulance Job", "You started bleeding! Use a bandage and see a doctor!", 6000, "info"},
        [32] = {"Ambulance Job", "The closest player is alive!", 6000, "error"},
    },
    
    Webhooks = {
        Use = true, -- Use webhooks? true / false
        Locale = {
            ['ItemBought'] = 'Item Bought',
            ['CallOpen'] = 'Call - Open',
            ['CallClose'] = 'Call - Close',
            ['InvoiceCreated'] = 'Invoice Created',
            ['AdminCommand'] = 'Admin Command',

            ['PlayerName'] = 'Player Name',
            ['AdminName'] = 'Admin Name',
            ['Identifier'] = 'Identifier',
            ['Items'] = 'Items',
            ['Text'] = 'Text',
            ['Callid'] = 'Call ID',
            ['Coords'] = 'Coords',
            ['Assistant'] = 'Assistant',
            ['CloseReason'] = 'Close Reason',
            ['Receiver'] = 'Receiver',
            ['Amount'] = 'Amount',
            ['Job'] = 'Job',
            ['Reason'] = 'Reason',
            ['Street'] = 'Street',
            ['Coords'] = 'Coords',
            ['Command'] = 'Command',

            ['Time'] = 'Time ⏲️'
        },

        -- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html
        Colors = {
            ['ItemBought'] = 10155240,
            ['CallOpen'] = 3145631, 
            ['CallClose'] = 16711680,
            ['InvoiceCreated'] = 10155240,
            ['AdminCommand'] = 10155240,
        }
    },

    -----------------------------------------------------------
    -----------------------| UNIFORMS |------------------------
    -----------------------------------------------------------

    CitizenWear = {label = "Citizen Wear"},

    Uniforms = {
        {
            label = 'Ambulance Dress', -- Uniform Label
            jobs = {
                -- Job = job name, grades = grades
                {job = 'ambulance', grades = {0,1,2,3}},
                -- More jobs
            },
            male = {
                ['t-shirt'] = {item = 15, texture = 0},
                ['torso2'] = {item = 13, texture = 3},
                ['arms'] = {item = 92, texture = 0},
                ['pants'] = {item = 24, texture = 5},
                ['shoes'] = {item = 9, texture = 0},
                ['hat'] = {item = 8, texture = 0},
                ['accessory'] = {item = 0, texture = 0},
                ['ear'] = {item = -1, texture = 0},
                ['decals'] = {item = 0, texture = 0},
                ['mask'] = {item = 0, texture = 0}
            },
            female = {
                ['t-shirt'] = {item = 75, texture = 3},
                ['torso2'] = {item = 73, texture = 0},
                ['arms'] = {item = 14, texture = 0},
                ['pants'] = {item = 37, texture = 5},
                ['shoes'] = {item = 1, texture = 0},
                ['hat'] = {item = -1, texture = 0},
                ['accessory'] = {item = 0, texture = 0},
                ['ear'] = {item = -1, texture = 0},
                ['decals'] = {item = 0, texture = 0},
                ['mask'] = {item = 0, texture = 0}
            },
        },
    },
}
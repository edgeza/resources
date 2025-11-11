Config = {
    Language = "en", -- en, de, fr, es
    PoliceJobs = {
        'police',
        'bcso',
        'sheriff'
    },

    UseItem = true, -- Generally use item or commands / false to use commands
    UseTargetOnInteractions = true, -- Use target on interactions / false to disable target, everything goes from job menu
    TargetInteractions = {
        player = {
            {
                name = 'soft_cuff',
                label = "Soft Cuff",
                icon = "fa-solid fa-arrow-right",
                event = "police:client:CuffPlayerSoft",
            },
            {
                name = 'escort',
                label = "Escort",
                icon = "fa-solid fa-user-friends",
                event = "police:client:EscortPlayer",
            },
            {
                name = 'putinvehicle',
                label = "Put in Vehicle",
                icon = "fa-solid fa-car-side",
                event = "police:client:PutPlayerInVehicle",
            },
            {
                name = 'putoutvehicle',
                label = "Put out Vehicle",
                icon = "fa-solid fa-car-side",
                event = "police:client:SetPlayerOutVehicle",
            },
            {
                name = 'search',
                label = "Search",
                icon = "fa-solid fa-search",
                event = "police:client:SearchPlayer",
            },
        },
        vehicle = {
            {
                name = 'lockwheel',
                label = "Lock Wheel",
                icon = "fa-solid fa-lock",
                event = "police:client:toggleWheelLock",
            },
            {
                name = 'unlockwheel',
                label = "Unlock Door",
                icon = "fa-solid fa-lock",
                event = "police:client:UnlockDoor",
            },
            {
                name = 'trackvehicle',
                label = "Track Device",
                icon = "fa-solid fa-map-marker",
                event = "police:client:PlaceGps",
            },
            {
                name = 'impoundvehicle',
                label = "Impound Vehicle",
                icon = "fa-solid fa-truck-pickup",
                event = "police:client:ImpoundVehicle",
            },
        }
    },

    -- Dispatch
    SendDispatchWhenOfficerDead = true, -- OPTIONAL: Send dispatch when officer is dead (maybe this is already exists on your dispatch system, default false)
    
    -- Object Menu
    EnableObjectPlacement = true,
    AdminRemoveCommand = 'removeallobjects',
    LimitObjectPlacement = true,
    MaxObjectLimit = 30,

    -- Object List
    Objects = {
        PlacableObjects = {
            ['prop_roadcone02a'] = "Road Cone",
            ['prop_snow_sign_road_06g'] = "Sign",
            ['prop_gazebo_03'] = "Gazebo",
            ['prop_worklight_03b'] = "Light",
            ['prop_barrier_work06a'] = "Barrier",
            ['body_crime_1'] = "Body Chalk",
            ['body_crime_2'] = "Body Chalk 2",
            ['crime_tape_medium'] = "Medium Crime Tape",
            ['crime_tape_large'] = "Large Crime Tape",
            ['sign_crime'] = "Crime Sign",
        }
    },

    -- Wheel Lock
    EnableWheelLock = true,
    WheelLockItem = 'wheel_lock',
    RemoveLockItem = 'wrench',
    WheelLockCommand = 'attachlock',
    RemoveLockCommand = 'removelock',

    -- Handcuff Minigame
    EscapeFromCuff = true,
    CuffDifficulty = { "hard", "hard", "hard" },
    CuffMinigameKeys = { "w", "a", "s", "d" },
    CuffItem = 'handcuffs',
    CuffKeysItem = 'cuff_keys',

    -- Steal money option
    LeoCanUseMoneyBag = false,

    -- Gps
    EnableGPS = true,
    CategorizeBlips = false,               -- Categorize all blips to single category named "LEO" | Image: not available
    BlipCategory = "LEO",                  -- Category label for dispatch blips
    DistanceLimit = false,                 -- false to disable distance limit by default

    RemoveOnUse = true,                   -- Remove item after use
    GPSItem = 'gps',                       -- Item name to open GPS
    VehicleGPSItem = 'vehicle_gps',        -- Item name to Vehicle GPS
    VehicleGPSItemRemove = 'remove_gps',   -- Item name to remove Vehicle GPS

    GPSCommand = 'gps',                    -- Command to open GPS
    VehicleGPSCommand = 'placegps',        -- Command to open Vehicle GPS
    VehicleGPSCommandRemove = 'removegps', -- Command to open Vehicle GPS

    -- Default blip colors for
    BlipColors = { -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        ['police'] = 3,
        ['sheriff'] = 5,
        ['bcso'] = 5,
    },

    SettingColors = {
        { blip = 43, hex = "#00FFC2" },
        { blip = 3,  hex = "#00C4FF" },
        { blip = 38, hex = "#006EFF" },
        { blip = 27, hex = "#8A3FFC" },
        { blip = 48, hex = "#FF00C5" },
        { blip = 1,  hex = "#FF0000" },
        { blip = 47, hex = "#FF6E00" },
        { blip = 5,  hex = "#FFE633" },
        { blip = 62, hex = "#DDDDDD" },
    },

    AuthRank = 1, -- Min rank required to manage GPS users

    DefaultChannels = {
        {
            code = 1,
            name = 'LSPD GPS',
            restricted = true,
            job = { 'leo' },
        },
        {
            code = 2,
            name = 'LEO GPS',
            restricted = true,
            job = { 'leo' },
        },
        {
            code = 3,
            name = 'LSSD GPS',
            restricted = false,
            job = { 'all' }, -- not necessary if restricted is false
        },
    },


    -- Radio
    EnableRadio = false,
    RadioItem = 'radio',
    RadioCommand = 'radio',
    FrequencyStep = 0.01,
    MaximumFrequency = 1000,
    ShowMemberId = true, -- Show member server id in radio member list | true: [2] Dusa Lesimov, false: Dusa Lesimov

    RestrictedFrequencies = {
        [1] = 'police',
        [2] = {
            police = 2,
            bcso = 2,
        },
        [3] = 'bcso',
        [4] = {
            bcso = 1,
        },
    },

    CommonRadioChannels = {
        ['Police Shared'] = {
            frequency = 1,
            jobs = {
                police = 2,
            },
        }
    },


    -- Interactions
    Interactions = {
        Search = {
            Enabled = true,
            Command = 'search',
        },
        Seize = {
            Enabled = false,
            Command = 'seize',
        },
        Escort = {
            Enabled = true,
            Command = 'escort',
        },
        Kidnap = {
            Enabled = true,
            Command = 'kidnap',
        },
        Rob = {
            Enabled = false,
            Command = 'rob',
        },
        PutVehicle = {
            Enabled = true,
            Command = 'putinvehicle',
        },
        OutVehicle = {
            Enabled = true,
            Command = 'outvehicle',
        }
    },

    DisableControlsWhenHandcuffed = {
        21,  -- Sprint
        24,  -- Attack
        257, -- Attack 2
        25,  -- Aim
        263, -- Melee Attack 1
        45,  -- Reload
        22,  -- Jump
        44,  -- Cover
        37,  -- Select Weapon
        23,  -- Also 'enter'?
        288, -- Disable phone
        289, -- Inventory
        170, -- Animations
        167, -- Job
        26,  -- Disable looking behind
        73,  -- Disable clearing animation
        199, -- Disable pause screen
        59,  -- Disable steering in vehicle
        71,  -- Disable driving forward in vehicle
        72,  -- Disable reversing in vehicle
        36,  -- Disable going stealth
        264, -- Disable melee
        257, -- Disable melee
        140, -- Disable melee
        141, -- Disable melee
        142, -- Disable melee
        143, -- Disable melee
        75,   -- Disable exit vehicle
    },

    -----------------------------
    -- ADDED WITH UPDATE 0.9.6 --
    -----------------------------

    -- Station Blips
    Stations = { -- All blips https://docs.fivem.net/docs/game-references/blips/
        ['police'] = {
            enabled = true,
            label = 'Police Station',
            coords = vec3(839.92, -1297.44, 27.24),
            sprite = 60,
            color = 3,
            scale = 0.8,
        },
        -- ['sheriff'] = {
        --     enabled = true,
        --     label = 'Sheriff Station',
        --     coords = vec3(1859.2, 3689.5, 34.2),
        --     sprite = 60,
        --     color = 3,
        --     scale = 0.8,
        -- },
    },

    -----------------------------

    -- Lock Area
    EnableLockArea = true,
    LockCommand = 'lockarea', -- Command to lock area

    -- Billing / Fines
    Billing = 'default', -- default | dusa | pefcl | okok | qb | esx | custom (if custom, head into game/opensource/events.lua line:18)

    -- Boss Menu
    BossMenu = {
        Enabled = true,
        Account = 'cash', -- cash | bank - The account that amount will be added or removed to from boss menu
        Menus = {
            -- default mrpd
            ['police'] = {
                label = 'Police Boss Menu',
                grade = 4,
                coords = vec3(837.72, -1308.81, 27.99),
                target = {
                    enabled = true,
                    icon = 'fas fa-user-tie',
                    debug = false,
                    size = 0.9,
                },
                textui = {
                    enabled = false,
                    icon = 'fas fa-user-tie',
                    size = vec3(3.0, 3.0, 3.0),
                    debug = false,
                },
            },
        }
    },

    -- Armory
    Armory = {
        Enabled = true,
        Locations = {
            -- default mrpd
            ['police'] = {
                coords = vec4(816.28, -1295.9, 19.85, 0.32),
                ped = 's_m_y_cop_01',
                categories = {
                    {
                        type = 'weapon',
                        label = 'Weapons',
                    },
                    {
                        type = 'equipments',
                        label = 'Equipment',
                    },
                    {
                        type = 'evidence',
                        label = 'Evidence',
                    },
                    {
                        type = 'ammo',
                        label = 'Ammo',
                    },
                },
                products = {
                    --- WEAPONS
                    ['weapon_bar15'] = {
                        type = 'weapon',
                        name = 'PD AR 15',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_bscar'] = {
                        type = 'weapon',
                        name = 'PD ScarH',
                        price = 10,
                        grade = 3,
                        stock = 500,
                    },
                    ['weapon_lbtarp'] = {
                        type = 'weapon',
                        name = 'PD Tan ARP',
                        price = 10,
                        grade = 4,
                        stock = 500,
                    },
                    ['weapon_ram7'] = {
                        type = 'weapon',
                        name = 'PD RAM 7',
                        price = 10,
                        grade = 3,
                        stock = 500,
                    },
                    ['weapon_illglock17'] = {
                        type = 'weapon',
                        name = 'PD Glock 17',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_midasglock'] = {
                        type = 'weapon',
                        name = 'PD Midas Glock',
                        price = 10,
                        grade = 4,
                        stock = 500,
                    },
                    ['weapon_dmk18'] = {
                        type = 'weapon',
                        name = 'PD Desert MK18',
                        price = 10,
                        grade = 4,
                        stock = 500,
                    },
                    ['weapon_fn57'] = {
                        type = 'weapon',
                        name = 'PD Five-Seven',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_glock21'] = {
                        type = 'weapon',
                        name = 'PD GLOCK 21',
                        price = 10,
                        grade = 3,
                        stock = 500,
                    },
                    ['weapon_stungun'] = {
                        type = 'weapon',
                        name = 'PD Taser',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['mg_ammo'] = {
                        type = 'ammo',
                        name = 'PD Ammo',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    --- EQUIPMENTS
                    ['radio'] = {
                        type = 'equipments',
                        name = 'Radio',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['gps'] = {
                        type = 'equipments',
                        name = 'GPS',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['finger_scanner'] = {
                        type = 'equipments',
                        name = 'finger scanner',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['handcuffs'] = {
                        type = 'equipments',
                        name = 'Handcuffs',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_nightstick'] = {
                        type = 'equipments',
                        name = 'Baton',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['heavyarmor'] = {
                        type = 'equipments',
                        name = 'Heavy Armor',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['medikit'] = {
                        type = 'equipments',
                        name = 'MedKit',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_flashlight'] = {
                        type = 'equipments',
                        name = 'Flashlight',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },

                    -- Evidence
                    ['empty_evidence_bag'] = {
                        type = 'evidence',
                        name = 'Empty Bag',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['magnifying_glass'] = {
                        type = 'evidence',
                        name = 'magnifying glass',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['thermal_camera'] = {
                        type = 'evidence',
                        name = 'thermal camera',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['evidence_tablet'] = {
                        type = 'evidence',
                        name = 'evidence tablet',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },

                    --- OTHERS
                    ['police_stormram'] = {
                        type = 'equipments',
                        name = 'Stormram',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['wheel_lock'] = {
                        type = 'equipments',
                        name = 'Wheel Locker',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['wrench'] = {
                        type = 'equipments',
                        name = 'Wrench',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['vehicle_gps'] = {
                        type = 'equipments',
                        name = 'Vehicle GPS',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['remove_gps'] = {
                        type = 'equipments',
                        name = 'GPS Detacher',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['moneybag'] = {
                        type = 'other',
                        name = 'Money Bag',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['bandage'] = {
                        type = 'other',
                        name = 'Bandage',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    ['firstaid'] = {
                        type = 'other',
                        name = 'Medkit',
                        price = 1,
                        grade = 0,
                        stock = 500,
                    },
                    -- GGC Custom Weapons -- Lethals
                
                    -- GGC Custom Weapons -- Hand Guns
                    ['weapon_glock17'] = {
                        type = 'weapon',
                        name = 'Glock-17',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_glock18c'] = {
                        type = 'weapon',
                        name = 'Glock-18C',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_glock22'] = {
                        type = 'weapon',
                        name = 'Glock-22',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_deagle'] = {
                        type = 'weapon',
                        name = 'Desert Eagle',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_fnx45'] = {
                        type = 'weapon',
                        name = 'FN FNX-45',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_m1911'] = {
                        type = 'weapon',
                        name = 'M1911',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_glock20'] = {
                        type = 'weapon',
                        name = 'Glock-20',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_glock19gen4'] = {
                        type = 'weapon',
                        name = 'Glock-19 Gen 4',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_browning'] = {
                        type = 'weapon',
                        name = 'Browning',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    -- GGC Custom Weapons -- SMGs
                    ['weapon_pmxfm'] = {
                        type = 'weapon',
                        name = 'Beretta PMX',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    -- GGC Custom Weapons -- Rifles
                    ['weapon_m6ic'] = {
                        type = 'weapon',
                        name = 'LWRC M6IC',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_scarsc'] = {
                        type = 'weapon',
                        name = 'Scar SC',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_m4'] = {
                        type = 'weapon',
                        name = 'M4A1 Carbine',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                    ['weapon_groza'] = {
                        type = 'weapon',
                        name = 'OTs-14 Groza',
                        price = 10,
                        grade = 0,
                        stock = 500,
                    },
                }
            },
        }
    },

    -- Garages
    Garages = {
        Enabled = false,
        Locations = {
            -- default mrpd
            ['police'] = {
                {
                    name = 'police_garage_1', -- must be unique
                    label = 'Police Garage',
                    garageType = 'car',       -- car, boat, air
                    coords = vec4(458.238, -1024.105, 28.403, 91.266),
                    spawn = vec4(448.395, -1020.353, 28.475, 85.593),
                    previewVehicle = vec4(434.069, -1022.417, 28.709, 120.209),
                    size = vec3(4, 4, 4), -- size of the garage box zone
                    debug = false,        -- show debug zone

                    --[[
                        enableOwnedVehicle:
                        true = Shows player owned vehicles at garage and enables police vehicle shop
                        false = Shows only job vehicles listed below at garage, disables vehicle shop

                        disableGarage:
                        true = Disables garage, this is an option to use your own garage system
                        false = Enables garage that includes defaultly inside police job

                        garage:
                        If enableOwnedVehicle is true, it will show listed vehicles with defined prices at VEHICLE SHOP
                        If enableOwnedVehicle is false, it will show listed vehicles at GARAGE
                    ]]
                    enableOwnedVehicle = true,
                    disableGarage = true,
                    garage = {
                        { model = 'police',  label = 'Police Victoria', grade = 0, livery = 0, price = 0 },
                        { model = 'police3', label = 'Police Cruiser',  grade = 0, livery = 0, price = 0 },
                    },

                    interaction = {
                        position = 'right-center',    -- 'right-center' or 'left-center' or 'top-center' or 'bottom-center'
                        label = 'Vehicle Garage',     -- target label
                        vehicleshop = 'Vehicle Shop', -- target label
                        take = 'Take Vehicle',
                        store = 'Store Vehicle',
                        distance = 3.0,
                        garageicon = 'fas fa-warehouse',
                        vehicleshopicon = 'fas fa-shop',
                        ped = 's_f_y_cop_01',
                    },

                    blip = { -- https://docs.fivem.net/docs/game-references/blips/
                        enabled = false,
                        label = 'Police Garage',
                        sprite = 357,
                        color = 3,
                        scale = 0.8,
                    }
                },
                {
                    name = 'police_boat_1', -- must be unique
                    label = 'Police Boat Garage',
                    garageType = 'boat',
                    coords = vec4(-730.191, -1382.975, 1.595, 52.177),
                    spawn = vec4(-743.032, -1371.837, 0.557, 137.747),
                    previewVehicle = vec4(-743.032, -1371.837, 0.557, 137.715),
                    size = vec3(4, 4, 4), -- size of the garage box zone
                    debug = false,        -- show debug zone

                    --[[
                        enableOwnedVehicle:
                        true = Shows player owned vehicles at garage and enables police vehicle shop
                        false = Shows only job vehicles listed below at garage, disables vehicle shop

                        garage:
                        If enableOwnedVehicle is true, it will show listed vehicles with defined prices at VEHICLE SHOP
                        If enableOwnedVehicle is false, it will show listed vehicles at GARAGE
                    ]]
                    enableOwnedVehicle = false,
                    disableGarage = true,
                    garage = {
                        { model = 'predator', label = 'Police Boat', grade = 0, livery = 0 },
                    },

                    interaction = {
                        target = true,             -- if false it will show text ui
                        position = 'right-center', -- 'right-center' or 'left-center' or 'top-center' or 'bottom-center'
                        label = 'Boat Garage',
                        take = 'Take Boat',
                        store = 'Store Boat',
                        distance = 3.0,
                        icon = 'fas fa-car',
                        ped = 's_f_y_cop_01',
                    },

                    blip = { -- https://docs.fivem.net/docs/game-references/blips/
                        enabled = false,
                        label = 'Police Boat Garage',
                        sprite = 356,
                        color = 3,
                        scale = 0.8,
                    }
                },
            },
        }
    },

    -- Uniforms / Cloak room
    UseClothingMenu = false, -- true to use clothing menu, false to use default cloak room
    ClothingMenu = function()
        -- open your clothing menu ui from here
        -- qb-clothing
        TriggerEvent('qb-clothing:client:openMenu')

        -- illenium
        -- TriggerEvent('illenium-appearance:client:openClothingShop', false)

        -- fivem-appearance
        -- TriggerEvent('fivem-appearance:client:openClothingShop', false)
    end,

    DefaultClothes = {
        code = 'default',
        label = 'Default Clothes',
        detail = 'Your default clothes',
    },

    CloakRoom = {
        Enabled = false,
        Locations = {
            -- default mrpd
            ['police'] = {
                zone = {
                    coords = vec3(827.5, -1291.4, 18.85),
                    size = vec3(2, 2, 2),
                    debug = false,
                    icon = 'fas fa-shirt',
                },
                outfits = {
                    {
                        code = 'boss_uniform',   -- Uniform Code
                        label = 'Boss Dress',
                        detail = 'Boss Uniform', -- Uniform Detail
                        minGrade = 0,            -- Minimum grade required to wear this uniform
                        male = {
                            clothing = {
                                -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                                { component = 11, drawable = 55,  texture = 0 }, -- Torso
                                { component = 8,  drawable = 122, texture = 0 }, -- Shirt
                                { component = 4,  drawable = 13,  texture = 0 }, -- Pants
                                { component = 6,  drawable = 21,  texture = 0 }, -- Shoes
                                { component = 3,  drawable = 0,   texture = 0 }, -- Arms
                            },
                            props = {
                                -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets

                                -- { component = 0, drawable = 5, texture = 0 }, -- Hats
                            }
                        },
                        female = {
                            clothing = {
                                -- Components / 0: Face 1: Mask 2: Hair 3: Torso 4: Leg 5: Parachute / bag 6: Shoes 7: Accessory 8: Undershirt 9: Kevlar 10: Badge 11: Torso 2
                                { component = 11, drawable = 4,  texture = 0 }, -- Torso
                                { component = 8,  drawable = 15, texture = 0 }, -- Shirt
                                { component = 4,  drawable = 25, texture = 0 }, -- Pants
                                { component = 6,  drawable = 16, texture = 4 }, -- Shoes
                                { component = 3,  drawable = 4,  texture = 0 }, -- Arms
                            },
                            props = {
                                -- Components / 0: Hats 1: Glasses 2: Ears 6: Watches 7: Bracelets

                                --    { component = 0, drawable = 0, texture = 0 }, -- Hats
                            }
                        }
                    },
                }

            },
        }
    },

    -- Duty Paper

    -- IMPORTANT NOTE FOR ESX USERS
    -- || es_extended not supporting core based duty sistem inside it, so we suggest you to disable requiring duty system
    -- || for qb or qbox users, set this to true
    RequireDuty = true, -- require police to be on duty to perform all actions, false will disable whole duty system

    DutyPaper = {
        Locations = {
            -- default mrpd
            ['police'] = {
                target = {
                    coords = vec3(841.84, -1296.36, 28.24),
                    distance = 3.0,
                    icon = 'fas fa-file-alt', -- fa-solid fa-shield
                    label = 'Toggle Duty',
                    size = 0.8,
                    debug = false,
                },
                department = "Los Santos Police Department",
                description = "Duty Paper",
            },

            -- For other jobs example
            -- ['bcso'] = {
            --     target = {
            --         coords = vec3(442.871, -980.374, 31.205),
            --         distance = 3.0,
            --         icon = 'fas fa-file-alt', -- fa-solid fa-shield
            --         label = 'Toggle Duty',
            --         size = 0.8,
            --         debug = false,
            --     },
            --     department = "Los Santos Sheriff Department",
            --     description = "Duty Paper",
            -- },
        }
    },

    -- Badge
    DefaultImage =
    'https://i.ibb.co/M8HpjY9/yigitmisin-gta-5-los-santos-police-department-officer-avatar-9332aa68-d499-49a4-819c-a932ecc1c5b5.webp',
    BadgeProp = 'prop_fib_badge',
    Badges = {
        ['police'] = {      -- do not change the key values
            job = 'police', -- to change badge for job, change this
            title = 'Los Santos Police Department',
            description = 'Police Badge',
            claim = 'This badge claims the holder as a member of the LSPD',
        },
        ['sheriff'] = {   -- do not change the key values
            job = 'bcso', -- to change badge for job, change this
            title = 'Los Santos Sheriff Department',
            description = 'Sheriff Badge',
            claim = 'This badge claims the holder as a member of the LSSD',
        },
        ['state'] = {      -- do not change the key values
            job = 'state', -- to change badge for job, change this
            title = 'Los Santos State Police',
            description = 'State Badge',
            claim = 'This badge claims the holder as a member of the LSSP',
        },
        ['fire'] = {      -- do not change the key values
            job = 'lsfd', -- to change badge for job, change this
            title = 'Los Santos Fire Department',
            description = 'Firefighter Badge',
            claim = 'This badge claims the holder as a member of the LSFD',
        },
    },

    -- Stashes
    Stashes = {
        Enabled = true,
        List = {
            ['police'] = {
                personal = {
                    interaction = 'target', -- target : npc : textui
                    ped = 's_m_y_cop_01',
                    coords = vec4(833.2, -1299.52, 28.24, 147.71),
                    label = 'Personal Stash',
                    slots = 50,
                    weight = 100000,
                },
                evidence = {
                    interaction = 'npc', -- target : npc : textui
                    ped = 's_m_y_cop_01',
                    coords = vec4(831.74, -1304.12, 19.85, 1.7),
                    label = 'Evidence Stash',
                    slots = 500,
                    weight = 10000000,
                }
            },
        }
    },

    -- Jail Input
    Jail = {
        Enabled = true,
        Command = 'jail'
    },

    -- Fine Input
    Fine = {
        Enabled = true,
        Command = 'fine',
    },

    -- Public Service
    Service = {
        Enabled = true,
        Commands = {
            command = 'sendservice',
            release = 'removeservice',
        },
        TeleportWhenDone = true,
        StartLocation = vec3(157.16, -1003.98, 29.4),
        FinishLocation = vec3(427.223, -981.097, 30.710),
        MaxDistance = 50.0,   -- Prevent distance for flee'ing from the area
        ShouldPenalty = true, -- Add penalty for leaving the area
        Penalty = 5,          -- How many more sweep to be added to the player for fleeing
        ProgressDuration = 5, -- Seconds to complete the sweep
        SweepZones = {
            vec3(157.16, -1003.98, 29.42),
            vec3(164.76, -1007.33, 29.42),
            vec3(170.98, -991.98, 30.09),
            vec3(170.45, -984.16, 30.09),
            vec3(162.95, -982.23, 30.09),
            vec3(156.3, -983.69, 30.09),
            vec3(152.1, -990.83, 29.36),
            vec3(168.49, -998.22, 29.35),
            vec3(170.41, -1002.78, 29.34),
        }
    },

    -- Key binds
    Keybind = {
        JobMenu = { -- F6 Job Menu
            enabled = true,
            key = 'F6',
            description = 'Open Job Menu',
        },
    },

    -- Speed Radars
    Radar = {
        Enabled = true,
        Command = 'placeradar',
        MenuCommand = 'radarmenu',
        HelpText = 'Place a radar (LEO only)',
        SpeedUnit = 'kmh',     -- kmh or mph
        Object = 'h4_prop_h4_cctv_pole_04',
        TolerancePercent = 10, -- 10% tolerance for speed limitation
        AlertLEO = true,       -- Alert LEO when someone passes the speed limit
        MaxFineLimit = 2000,
        MaxZoneRadius = 150.0,
        LimitRadarPlacement = true,
        MaxRadarLimit = 4, -- total radar limit to prevent many radar
        GradeLevel = 12,    -- min grade to place a radar or remove
        Blip = {
            enabled = true,
            name = 'Speed Radar',
            sprite = 592,
            color = 1,
            scale = 0.6,
        },
    },

    -- K9
    K9 = {
        Enabled = true,
        WhistleAnimation = true,
        Model = 'dusa_doberman',
        MaxDistance = 30.0,
        MinGrade = 3,
        Shortcuts = {
            Enabled = true,
            Attack = { "LEFTSHIFT", "G" },
            Search = { "LEFTSHIFT", "H" },
        },
        IllegalItems = {
            'weed_pooch',
            'meth_pooch',
            'coke_pooch',
            'opium_pooch',
            'weed_bag',
            'meth_bag',
            'coke_bag',
            'opium_bag',
            'weed',
            'meth',
            'coke',
            'opium',
            'weed_package',
            'meth_package',
            'coke_package',
            'opium_package',
            'weed_brick',
            'meth_brick',
            'coke_brick',
            'opium_brick',
            'joint',
            'cokebaggy',
            'crack_baggy',
            'xtcbaggy',
            'coke_small_brick',
            'oxy',
            'weed_whitewidow',
            'weed_skunk',
            'weed_purplehaze',
            'weed_ogkush',
            'weed_amnesia',
            'weed_ak47',
            'weed_whitewidow_seed',
            'weed_skunk_seed',
            'weed_purplehaze_seed',
            'weed_ogkush_seed',
            'weed_amnesia_seed',
            'weed_ak47_seed',
            'cocain',
            'cocaine',
        }
    },

    -- Drag Wounded
    DragWounded = {
        Enabled = true,
        OnlyForLeo = true,
        Command = 'drag',            -- If you want to disable command, set this to false LIKE: Command = false
        Keys = { "LEFTSHIFT", "H" }, -- If you want to disable keys, set this to false LIKE: Keys = false
        Suggestion = 'Drag Wounded Player',
    },

    -- Tackling
    Tackle = { -- 0.01 ms resmon usage
        Enabled = true,
        Distance = 3.0,
        Keys = { "LEFTSHIFT", "E" },
        Timeout = 10, -- seconds, to prevent spamming
    },
}

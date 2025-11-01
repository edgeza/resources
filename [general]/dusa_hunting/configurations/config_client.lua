Config = {
    TEST = false,
    Currency = "$",
    CheckInterval = 1, -- minutes
    ObjectiveAlignment = "center-right", -- center-right, center-left, top-right, top-left, bottom-right, bottom-left
    OnlyHuntByHuntingWeapons = true,
    DisableHuntingRiflePVP = true, -- Disable hunting rifle can attack player
    HuntingWeapons = {
        'weapon_dhr31',
        -- 'WEAPON_MUSKET',
    },

    OnlyHunterCanCollect = true, -- if false, anyone can collect carcass
    RequireJob = false,          -- if true, player must have job to hunt
    JobName = 'hunter',          -- job name, only used if RequireJob is true

    UseTarget = false,            -- if true, uses Target system instead of dusa_bridge

    TrapDamage = 50, -- damage dealt to animal when trapped
    BaitChance = 30, -- chance to bait animal (default value 30, nerfing bait chance to make skills more useful)

    -- ## IMPORTANT: 
    -- Do not increase maxCount too much, it will burden model request for each animal again and again and cause performance issues
    HuntingZones = {
        ['HuntingZone1'] = {
            name = 'Deer Zone',
            type = 'deer',
            coords = vec3(-575.706, 5460.014, 60.558),
            range = 250.0,
            debug = false,
            animal = {
                model = 'a_c_deer',
                maxCount = 3,
                xp = 10,
                canAttack = false,
                isFleeing = false,
            }
        },
        ['HuntingZone2'] = {
            name = 'Rabbit Zone',
            type = 'rabbit',
            coords = vec3(-716.885, 5310.257, 72.257),
            range = 370.0,
            debug = false,
            animal = {
                model = 'a_c_rabbit_01',
                maxCount = 4,
                xp = 10,
                canAttack = false,
                isFleeing = false,
            }
        },
        ['HuntingZone3'] = {
            name = 'Bear Zone',
            type = 'bear',
            coords = vec3(-117.283, 1435.516, 294.283),
            range = 300.0,
            debug = false,
            animal = {
                model = 'BrnBear',
                maxCount = 2,
                xp = 10,
                canAttack = true,
                isFleeing = false,
            }
        },
        ['HuntingZone4'] = {
            name = 'Boar Zone',
            type = 'boar',
            coords = vec3(-299.741, 4806.736, 209.228),
            range = 300.0,
            debug = false,
            animal = {
                model = 'a_c_boar',
                maxCount = 3,
                xp = 10,
                canAttack = false,
                isFleeing = false,
            }
        },
        ['HuntingZone5'] = {
            name = 'Red Panda Zone',
            type = 'redpanda',
            coords = vec3(36.261, 2166.034, 127.783),
            range = 300.0,
            debug = false,
            animal = {
                model = 'redpanda',
                maxCount = 2,
                xp = 10,
                canAttack = false,
                isFleeing = false,
            }
        },
        ['HuntingZone6'] = {
            name = 'Coyote Zone',
            type = 'coyote',
            coords = vec3(1274.712, 3210.638, 38.3861),
            range = 300.0,
            debug = false,
            animal = {
                model = 'a_c_coyote',
                maxCount = 2,
                xp = 10,
                canAttack = false,
                isFleeing = false,
            }
        },
        ['HuntingZone7'] = {
            name = 'Pig Zone',
            type = 'pig',
            coords = vec3(-1683.242, 668.172, 179.754),
            range = 300.0,
            debug = false,
            animal = {
                model = 'a_c_pig',
                maxCount = 2,
                xp = 10,
                canAttack = false,
                isFleeing = false,
            }
        },
        ['HuntingZone8'] = {
            name = 'Mountain Lion Zone',
            type = 'mtlion',
            coords = vec3(568.443, 4329.971, 80.547),
            range = 150.0,
            debug = false,
            animal = {
                model = 'a_c_mtlion',
                maxCount = 2,
                xp = 10,
                canAttack = true,
                isFleeing = false,
            }
        },
        ['HuntingZone9'] = {
            name = 'Lion Zone',
            type = 'lion',
            coords = vec3(1268.962, 2920.288, 43.474),
            range = 100.0,
            debug = false,
            animal = {
                model = 'ft-lion',
                maxCount = 1,
                xp = 10,
                canAttack = true,
                isFleeing = false,
            }
        },
    },

    Wiki = {
        ['deer'] = {
            name = "Deer",
            info = "Get Information About",
            description = "A large, graceful herbivore found in forests and grasslands."
        },
        ['rabbit'] = {
            name = "Rabbit",
            info = "Get Information About",
            description = "A small, fast mammal known for its long ears and quick movements."
        },
        ['bear'] = {
            name = "Bear",
            info = "Get Information About",
            description = "A large, powerful mammal known for its strength and hibernation habits."
        },
        ['redpanda'] = {
            name = "Red Panda",
            info = "Get Information About",
            description = "A small, tree-dwelling mammal with reddish-brown fur and a bushy tail."
        },
        ['lion'] = {
            name = "Lion",
            info = "Get Information About",
            description = "A large, social cat known as the king of the jungle."
        },
        ['oryx'] = {
            name = "Arabian Oryx",
            info = "Get Information About",
            description = "A desert antelope with long, straight horns and a white coat."
        },
        ['antelope'] = {
            name = "Antelope",
            info = "Get Information About",
            description = "A swift herbivore with long legs and horns, found in open plains."
        },
        ['boar'] = {
            name = "Boar",
            info = "Get Information About",
            description = "A wild pig known for its tusks and tough nature."
        },
        ['coyote'] = {
            name = "Coyote",
            info = "Get Information About",
            description = "A clever, adaptable canine found throughout North America."
        },
        ['mtlion'] = {
            name = "Mountain Lion",
            info = "Get Information About",
            description = "A large, solitary cat also known as cougar or puma."
        },
        ['pig'] = {
            name = "Pig",
            info = "Get Information About",
            description = "A domesticated animal known for its intelligence and adaptability."
        },
    },
    
    Tournament = {
        AvailableSpecies = { -- List of available species can be found at config_shared.lua Shared.Species
            'deer',
            'bear',
            'oryx',
            'boar',
            'coyote',
            'mtlion',
            'redpanda',
            'lion',
            'pig',
            'rabbit',
            'antelope',
        },

        TournamentLimits = {
            RewardRange = {
                Minimum = 500,
                Maximum = 10000,
            },
            
            DurationRange = {
                Minimum = 5,
                Maximum = 60,
            },
            
            Settings = {
                MaxPlayers = 10,
                MinPlayers = 2,
            }
        }
    },

    Areas = {
        ['butchering'] = {
            machine = {
                coords = vec3(-89.120, 6234.354, 31.061),
            },
            -- Butchering reward mode: 'box' or 'parts'
            -- 'box': Drops a single box containing all parts (default)
            -- 'parts': Drops individual animal parts as separate objects
            rewardMode = 'parts'
        }
    },

    -- Vehicle Carcass Attach Settings (by animal type)
    CarcassVehicleAttach = {
        -- Default settings (used if animal type not found)
        default = {
            offset = vec3(0.0, 1.5, 1.0),
            rotation = vec3(0.0, 0.0, 0.0),
            alpha = 200,
        },

        -- Animal-specific settings
        deer = {
            offset = vec3(0.0, 1.5, 1.2),
            rotation = vec3(0.0, 0.0, 0.0),
            alpha = 200,
        },

        bear = {
            offset = vec3(0.0, 1.8, 1.3),
            rotation = vec3(0.0, 0.0, 0.0),
            alpha = 200,
        },

        boar = {
            offset = vec3(0.0, 1.4, 1.0),
            rotation = vec3(0.0, 0.0, 0.0),
            alpha = 200,
        },

        rabbit = {
            offset = vec3(0.0, 1.2, 0.8),
            rotation = vec3(0.0, 0.0, 0.0),
            alpha = 200,
        },

        coyote = {
            offset = vec3(0.0, 1.5, 1.0),
            rotation = vec3(0.0, 0.0, 0.0),
            alpha = 200,
        },

        mtlion = {
            offset = vec3(0.0, 1.6, 1.1),
            rotation = vec3(0.0, 0.0, 0.0),
            alpha = 200,
        },

        pig = {
            offset = vec3(0.0, 1.4, 1.0),
            rotation = vec3(0.0, 0.0, 0.0),
            alpha = 200,
        },
    }
}

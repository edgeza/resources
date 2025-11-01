-- ## Interior Configurations
Config = {
    Debug = false, -- Set to true to enable debug prints

    -- EntitySets define the interior configurations for various locations
    EntitySets = {
        {
            name = "Laundromat Dollar Pills Paleto Bay",
            coords = vector3(-44.39701, 6453.24756, 32.15056),
            ipl = "tstudio_laundromat_paleto",
            entitySets = {
                {name = "door_open", enable = true}, -- Enable the door_open entity set
                {name = "door_closed", enable = false} -- Disable the door_closed entity set
            }
        }, {
            name = "Laundromat Dollar Pills Davis",
            coords = vector3(62.1981468, -1604.00537, 30.2375851),
            ipl = "tstudio_laundromat_dollar_pills",
            entitySets = {
                {name = "door_open", enable = false}, -- Disable the door_open entity set
                {name = "door_closed", enable = true} -- Enable the door_closed entity set
            }
        }, {
            name = "Laundromat Dollar Pills Banyon Canyon",
            coords = vector3(-3062.18, 630.528, 8.03883),
            ipl = "tstudio_laundromat_bc",
            entitySets = {
                {name = "door_open", enable = true}, -- Enable the door_open entity set
                {name = "door_closed", enable = false} -- Disable the door_closed entity set
            }
        }, {
            name = "Jurassic Jackpot",
            coords = vector3(-247.246368, -919.344238, 40.5292854),
            ipl = "johanni_jurassic_jackpot_milo",
            entitySets = {
                {name = "casino_table_yes", enable = true}, -- Enable the casino_table_yes entity set
                {name = "casino_table_no", enable = false} -- Disable the casino_table_no entity set
            }
        }, {
            name = "VHotel Estate",
            coords = vector3(-1354.21887, -1071.3999, 9.128438),
            ipl = "johanni_vhotel_milo_",
            entitySets = {
                {name = "r16_casino_slots_on", enable = true}, -- Enable the casino slots entity set
                {name = "r2_r3_pool_tables_on", enable = true} -- Enable the pool tables entity set
            }
        }, {
            name = "Fleeca Bank Vinewood",
            coords = vector3(-355.435852, -48.5326, 48.1063843),
            ipl = "uniqx_flecca_l1_milo_",
            entitySets = {
                {name = "fleeca_vaultprops", enable = true}, -- Enable the casino slots entity set
            }
        }, {
            name = "Fleeca Bank Vinewood (Lower Level)",
            coords = vector3(309.74646, -277.644165, 53.2345963),
            ipl = "uniqx_flecca_l2_milo_",
            entitySets = {
                {name = "fleeca_vaultprops", enable = true}, -- Enable the casino slots entity set
            }
        }, {
            name = "Fleeca Bank Legion Square",
            coords = vector3(145.416824, -1039.277, 28.4378834),
            ipl = "uniqx_flecca_l3_milo_",
            entitySets = {
                {name = "fleeca_vaultprops", enable = true}, -- Enable the casino slots entity set
            }
        }, {
            name = "Fleeca Bank Movie Studio",
            coords = vector3(-1216.7616, -333.000763, 36.85084),
            ipl = "uniqx_flecca_l4_milo_",
            entitySets = {
                {name = "fleeca_vaultprops", enable = true}, -- Enable the casino slots entity set
            }
        }, {
            name = "Fleeca Bank East Highway",
            coords = vector3(-2962.59131, 478.238037, 14.7668953),
            ipl = "uniqx_flecca_l5_milo_",
            entitySets = {
                {name = "fleeca_vaultprops", enable = true}, -- Enable the casino slots entity set
            }
        }, {
            name = "Fleeca Bank Sandy Shores",
            coords = vector3(1179.74475, 2706.985, 37.15784),
            ipl = "uniqx_flecca_l6_milo_",
            entitySets = {
                {name = "fleeca_vaultprops", enable = true}, -- Enable the casino slots entity set
            }
        }
        -- Add more interior configs here
    },

    PrivacySwitch = {
        positions = {
            vector3(306.003, -568.511, 63.181), -- Office 1
            vector3(305.963, -568.432, 67.184), -- Office 2
            vector3(306.056, -568.902, 59.229) -- etc.
        },
        entitySetA = "r7_privacy_off",
        entitySetB = "r7_privacy_on",
        marker = {type = 6, r = 19, g = 87, b = 66, alpha = 100},
        range = 2
    },

    -- CompatibilityPatches define fixes for specific combinations of maps
    CompatibilityPatches = {
        {
            name = "Fix for Opium Nights & LSI Square",
            requiredMaps = {"tstudio_opium_nights", "tstudio_lsi_square"},
            fixResource = "tstudio_zpatch_opium_lsis" -- Resource to apply the fix
        }, {
            name = "Fix for Opium Nights & Bennys Racetrack",
            requiredMaps = {"tstudio_opium_nights", "tstudio_bennys_racetrack"},
            fixResource = "tstudio_zpatch_opium_racetrack" -- Resource to apply the fix
        }, {
            name = "Fix for Opium Nights, Bennys Racetrack & LSI Square",
            requiredMaps = {
                "tstudio_opium_nights", "tstudio_lsi_square",
                "tstudio_bennys_racetrack"
            },
            fixResource = "tstudio_zpatch_opium_racetrack_lsis" -- Resource to apply the fix
        }, {
            name = "Fix for Missionrowpark, Kebabking, Tropical Heights & Legion",
            requiredMaps = {
                "tstudio_missionrow_park", "tstudio_legionsquare",
                "tstudio_tropical_heights", "tstudio_kebabking"
            },
            fixResource = "tstudio_zpatch_mrpark_kebab_th_ls" -- Resource to apply the fix
        }, {
            name = "Fix for Missionrowpark, Kebabking & Tropical Heights",
            requiredMaps = {
                "tstudio_missionrow_park", "tstudio_kebabking",
                "tstudio_tropical_heights"
            },
            fixResource = "tstudio_zpatch_mrpark_kebab_th" -- Resource to apply the fix
        }, {
            name = "Fix for Missionrowpark & Tropical Heights",
            requiredMaps = {
                "tstudio_missionrow_park", "tstudio_tropical_heights"
            },
            fixResource = "tstudio_zpatch_mrpark_th" -- Resource to apply the fix
        }, {
            name = "Fix for Missionrowpark, Legion & Tropical Heights",
            requiredMaps = {
                "tstudio_missionrow_park", "tstudio_tropical_heights",
                "tstudio_legionsquare"
            },
            fixResource = "tstudio_zpatch_mrpark_th_ls" -- Resource to apply the fix
        }, {
            name = "Fix for Missionrowpark, Kebabking & Legion",
            requiredMaps = {
                "tstudio_missionrow_park", "tstudio_kebabking",
                "tstudio_legionsquare"
            },
            fixResource = "tstudio_zpatch_mrpark_kebab_ls" -- Resource to apply the fix
        }, {
            name = "Fix for Missionrowpark & Legion",
            requiredMaps = {"tstudio_missionrow_park", "tstudio_legionsquare"},
            fixResource = "tstudio_zpatch_mrpark_ls" -- Resource to apply the fix
        }, {
            name = "Fix for Missionrowpark & Reds Tuner",
            requiredMaps = {"tstudio_missionrow_park", "tstudio_redstuner"},
            fixResource = "tstudio_zpatch_mrpark_reds" -- Resource to apply the fix
        }, {
            name = "Fix for Missionrowpark, Kebabking",
            requiredMaps = {"tstudio_missionrow_park", "tstudio_kebabking"},
            fixResource = "tstudio_zpatch_mrpark_kebab" -- Resource to apply the fix
        }, {
            name = "Fix for Impound & Carrent",
            requiredMaps = {"tstudio_impound", "tstudio_carrent"},
            fixResource = "tstudio_zpatch_impound_carrent" -- Resource to apply the fix
        }, {
            name = "Fix for Missionrowpark & Impound",
            requiredMaps = {"tstudio_missionrow_park", "tstudio_impound"},
            fixResource = "tstudio_zpatch_mrpark_impound" -- Resource to apply the fix
        }, {
            name = "Fix for Legion Garage & Kebab",
            requiredMaps = {"tstudio_legionsquare_garage", "tstudio_kebabking"},
            fixResource = "tstudio_zpatch_garage_kebab" -- Resource to apply the fix
        }, {
            name = "Fix for Pillbox, Legion Garage & Kebab",
            requiredMaps = {
                "tstudio_pillbox_md", "tstudio_legionsquare_garage",
                "tstudio_kebabking"
            },
            fixResource = "tstudio_zpatch_pillbox_garage_kebab" -- Resource to apply the fix
        }, {
            name = "Fix for Pillbox & Legion Garage",
            requiredMaps = {"tstudio_pillbox_md", "tstudio_legionsquare_garage"},
            fixResource = "tstudio_zpatch_pillbox_garage" -- Resource to apply the fix
        }, {
            name = "Fix for Pillbox & Kebab",
            requiredMaps = {"tstudio_pillbox_md", "tstudio_kebabking"},
            fixResource = "tstudio_zpatch_pillbox_kebab" -- Resource to apply the fix
        }, {
            name = "Fix for Pillbox & Kebab",
            requiredMaps = {"tstudio_pillbox_md", "tstudio_kebabking"}, 
            fixResource = "tstudio_zpatch_pillbox_kebab" -- Resource to apply the fix
        },
        {
            name = "Fix for Mission Row Park & Jurassic Jackpot",
            requiredMaps = {"tstudio_jurassic_jackpot", "tstudio_missionrow_park"},
            fixResource = "tstudio_zpatch_mrpark_jj",
        },
        {
            name = "Fix for Aldente's & VHotel",
            requiredMaps = {"tstudio_aldentes", "tstudio_vhotel_estate"},
            fixResource = "tstudio_zpatch_aldentes_vhotel"
        },
        {
            name = "Fix for Paleto Bewo & Paleto Cardealer & Taxi",
            requiredMaps = {"tstudio_paleto_bewo", "tstudio_paleto_cardealer", "tstudio_taxi"},
            fixResource = "tstudio_zpatch_bw_cardealer_taxi",
        },
    },

    -- Section for automatic floor ipl loading configurations
    FloorConfigs = {
        pillbox = {
            resourceName = "tstudio_pillbox_md", -- Added name for debug purposes
            center = vector3(306.003, -568.511, 63.181), -- Center of the area for checking player position
            floors = {
                [0] = {height = 64.159, ipls = {"johanni_pillbox_e03_01_milo_"}},
                [1] = {height = 68.162, ipls = {"johanni_pillbox_e03_02_milo_"}},
                [2] = {height = 60.025, ipls = {"johanni_pillbox_e03_03_milo_"}}
            }
        },
        opium = {
            resourceName = "tstudio_opium_nights", -- Added name for debug purposes
            center = vector3(-720.0305, -2268.00635, 16.2695923), -- Center of the area for checking player position
            floors = {
                [0] = {
                    height = 28.00,
                    ipls = {
                        "johanni_opium_penthouse_e01_milo_",
                        "johanni_opium_hallway_e01_milo_",
                        "johanni_opium_hotel_e01_r01_milo_",
                        "johanni_opium_hotel_e01_r02_milo_",
                        "johanni_opium_hotel_e01_r03_milo_",
                        "johanni_opium_hotel_e01_r04_milo_",
                        "johanni_opium_hotel_e01_r05_milo_",
                        "johanni_opium_hotel_e01_r06_milo_",
                        "johanni_opium_hotel_e01_r07_milo_",
                        "johanni_opium_hotel_e01_r08_milo_",
                        "johanni_opium_hotel_e01_r09_milo_",
                        "johanni_opium_hotel_e01_r10_milo_",
                        "johanni_opium_hotel_e01_r11_milo_",
                        "johanni_opium_hotel_e01_r12_milo_"
                    }
                },
                [1] = {
                    height = 38.14,
                    ipls = {
                        "johanni_opium_penthouse_e02_milo_",
                        "johanni_opium_hallway_e02_milo_",
                        "johanni_opium_hotel_e02_r01_milo_",
                        "johanni_opium_hotel_e02_r02_milo_",
                        "johanni_opium_hotel_e02_r03_milo_",
                        "johanni_opium_hotel_e02_r04_milo_",
                        "johanni_opium_hotel_e02_r05_milo_",
                        "johanni_opium_hotel_e02_r06_milo_",
                        "johanni_opium_hotel_e02_r07_milo_",
                        "johanni_opium_hotel_e02_r08_milo_",
                        "johanni_opium_hotel_e02_r09_milo_",
                        "johanni_opium_hotel_e02_r10_milo_",
                        "johanni_opium_hotel_e02_r11_milo_",
                        "johanni_opium_hotel_e02_r12_milo_"
                    }
                },
                [2] = {
                    height = 47.04,
                    ipls = {
                        "johanni_opium_penthouse_e03_milo_",
                        "johanni_opium_hallway_e03_milo_",
                        "johanni_opium_hotel_e03_r01_milo_",
                        "johanni_opium_hotel_e03_r02_milo_",
                        "johanni_opium_hotel_e03_r03_milo_",
                        "johanni_opium_hotel_e03_r04_milo_",
                        "johanni_opium_hotel_e03_r05_milo_",
                        "johanni_opium_hotel_e03_r06_milo_",
                        "johanni_opium_hotel_e03_r07_milo_",
                        "johanni_opium_hotel_e03_r08_milo_",
                        "johanni_opium_hotel_e03_r09_milo_",
                        "johanni_opium_hotel_e03_r10_milo_",
                        "johanni_opium_hotel_e03_r11_milo_",
                        "johanni_opium_hotel_e03_r12_milo_"
                    }
                },
                [3] = {
                    height = 55.88,
                    ipls = {
                        "johanni_opium_penthouse_e04_milo_",
                        "johanni_opium_hallway_e04_milo_",
                        "johanni_opium_hotel_e04_r01_milo_",
                        "johanni_opium_hotel_e04_r02_milo_",
                        "johanni_opium_hotel_e04_r03_milo_",
                        "johanni_opium_hotel_e04_r04_milo_",
                        "johanni_opium_hotel_e04_r05_milo_",
                        "johanni_opium_hotel_e04_r06_milo_",
                        "johanni_opium_hotel_e04_r07_milo_",
                        "johanni_opium_hotel_e04_r08_milo_",
                        "johanni_opium_hotel_e04_r09_milo_",
                        "johanni_opium_hotel_e04_r10_milo_",
                        "johanni_opium_hotel_e04_r11_milo_",
                        "johanni_opium_hotel_e04_r12_milo_"
                    }
                },
                [4] = {
                    height = 64.55,
                    ipls = {
                        "johanni_opium_penthouse_e05_milo_",
                        "johanni_opium_hallway_e05_milo_",
                        "johanni_opium_hotel_e05_r01_milo_",
                        "johanni_opium_hotel_e05_r02_milo_",
                        "johanni_opium_hotel_e05_r03_milo_",
                        "johanni_opium_hotel_e05_r04_milo_",
                        "johanni_opium_hotel_e05_r05_milo_",
                        "johanni_opium_hotel_e05_r06_milo_",
                        "johanni_opium_hotel_e05_r07_milo_",
                        "johanni_opium_hotel_e05_r08_milo_",
                        "johanni_opium_hotel_e05_r09_milo_",
                        "johanni_opium_hotel_e05_r10_milo_",
                        "johanni_opium_hotel_e05_r11_milo_",
                        "johanni_opium_hotel_e05_r12_milo_"
                    }
                },
                [5] = {
                    height = 73.35,
                    ipls = {
                        "johanni_opium_penthouse_e06_milo_",
                        "johanni_opium_hallway_e06_milo_",
                        "johanni_opium_hotel_e06_r01_milo_",
                        "johanni_opium_hotel_e06_r02_milo_",
                        "johanni_opium_hotel_e06_r03_milo_",
                        "johanni_opium_hotel_e06_r04_milo_",
                        "johanni_opium_hotel_e06_r05_milo_",
                        "johanni_opium_hotel_e06_r06_milo_",
                        "johanni_opium_hotel_e06_r07_milo_",
                        "johanni_opium_hotel_e06_r08_milo_",
                        "johanni_opium_hotel_e06_r09_milo_",
                        "johanni_opium_hotel_e06_r10_milo_",
                        "johanni_opium_hotel_e06_r11_milo_",
                        "johanni_opium_hotel_e06_r12_milo_"
                    }
                }
            }
        }
    },

    -- Interior blocking configurations
    -- Each interior can be configured with the following properties:
    -- coords: The coordinates of the interior
    -- interiorName: The name of the interior to disable
    -- enabled: Whether this interior blocking is enabled
    -- resourceDependency: (Optional) Only disable this interior if the specified resource is started
    --                     This prevents breaking default interiors when custom resources aren't loaded
    Interiors = {
        -- Tattoo Shops
        {
            coords = vector3(-3171.2937, 1076.24451, 19.8303947),
            interiorName = 'v_tattoo',
            enabled = true,
            resourceDependency = 'tstudio_tattoo_studio' -- Only disable if this resource is started
        }, {
            coords = vector3(322.967865, 181.942917, 102.587761),
            interiorName = 'v_tattoo',
            enabled = true,
            resourceDependency = 'tstudio_tattoo_studio'
        }, {
            coords = vector3(1323.765, -1653.43164, 51.27684),
            interiorName = 'v_tattoo',
            enabled = true,
            resourceDependency = 'tstudio_tattoo_studio'
        }, {
            coords = vector3(-1153.18408, -1427.0127, 3.955685),
            interiorName = 'v_tattoo',
            enabled = true,
            resourceDependency = 'tstudio_tattoo_studio'
        }, 
        
        -- Ammu-Nation Locations
        {
            coords = vector3(821.144043, -2154.8916, 28.61892),
            interiorName = 'v_gun',
            enabled = true,
            resourceDependency = 'tstudio_ammunation' -- Only disable if this resource is started
        }, -- Cypress
        {
            coords = vector3(843.2987, -1028.10669, 27.1947746),
            interiorName = 'v_gun2',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        }, -- LaMesa
        {
            coords = vector3(10.9070005, -1105.65833, 28.7969322),
            interiorName = 'v_gun',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        }, -- Legion
        {
            coords = vector3(247.371582, -47.245163, 68.9409943),
            interiorName = 'v_gun2',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        }, -- Hawick
        {
            coords = vector3(-1310.87659, -392.009644, 35.6957169),
            interiorName = 'v_gun2',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        }, -- MorningWood
        {
            coords = vector3(-663.1717, -940.758057, 20.8291473),
            interiorName = 'v_gun2',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        }, -- Little Seoul
        {
            coords = vector3(-3167.29614, 1084.70984, 19.8386574),
            interiorName = 'v_gun2',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        }, -- Chumash
        {
            coords = vector3(2568.834, 299.788116, 107.734818),
            interiorName = 'v_gun2',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        }, -- East Highway
        {
            coords = vector3(1696.95251, 3755.445, 33.7052574),
            interiorName = 'v_gun2',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        }, -- Sandy Shores
        {
            coords = vector3(-327.1706, 6079.257, 30.4546967),
            interiorName = 'v_gun2',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        }, -- Paleto Bay
        {
            coords = vector3(-1114.84509, 2693.80957, 17.55406),
            interiorName = 'v_gun2',
            enabled = true,
            resourceDependency = 'tstudio_ammunation'
        } -- Route 68
    }
}

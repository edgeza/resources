CodeStudio = {}

CodeStudio.Debug = false

-- 'QB' = For QBCore Framework
-- 'ESX' = For ESX Framework

CodeStudio.ServerType = 'QB'  --'QB'|'ESX'


--SYNC SETTINGS--
CodeStudio.useInbuilt = false                --This will use inbuilt society money accounts 
CodeStudio.useQB_Banking = false            --Put true if you want to sync qb-banking
CodeStudio.useRenewed_Banking = true       --Put true if you want to sync Renewed-Banking
CodeStudio.useESX_Society = false           --Put true if you want to sync esx_society


CodeStudio.LocationSettings = {
    Enable = true,          --Enable/Disable Boss Menu Locations
    useTarget = {
        Enable = true,              --toggle target system
        Target = 'qb-target'        --qb-target/ox_target
    },
    useTextUI = {
        Enable = false,              --toggle textUi system requires(ox_lib)
        openKey = 38                --Key to open menu
    },
}

CodeStudio.DicordLogs = {
    Enable = true,
    WebHook = 'https://discord.com/api/webhooks/1247594719802953738/IsSucsSt6bDJTblTQK5Ke_E4DXJNsO34Sj1lc9adAtpcXgv6GCOKUtYo8196yut4lXnO'   --Enter Webhook to log boss menu actions on discord
}

CodeStudio.MenuSections = {
    BossInventory = true,       -- Hide/Show Boss Inventory Option
    BossOutfit = true,          -- Hide/Show Outfit Option
    ApplicationSystem = false    -- If you are using Job Application System Script https://codestudio.tebex.io/package/5756147
}

CodeStudio.HireNearbyPlayers = true            -- Toggle Between Recruit List Nearby Player or All Players

CodeStudio.No_Job = {           -- Default Job (Job to be given after FIRE)
    Job = 'unemployed',
    Grade = '0'  -- If you are on ESX put 0 not '0'
}



CodeStudio.Menu = {
    ['bossmenu'] = {
        ['police'] = {
            bossRank = 8,
            locations = {
                vector4(447.93, -990.34, 35.48, 85.31),
            }
        },
        ['bcso'] = {
            bossRank = 8,
            locations = {
                vector3(-455.97, 6016.81, 31.19),
            }
        },
        ['doj'] = {
            bossRank = 5,
            locations = {
                vector4(-588.36, -205.86, 38.23, 189.86),
		vector4(-528.43, -187.6, 43.37, 101.97),
            }
        },
        ['ambulance'] = {
            bossRank = 9,
            locations = {
                vector3(334.81, -594.44, 43.28),
            }
        },
        ['towing'] = {
            bossRank = 2,
            locations = {
                vector3(476.67, -1319.89, 29.21),
            }
        },
        ['mechanic'] = {
            bossRank = 4,
            locations = {
                vector3(887.81, -2099.35, 34.8),
            }
        },
        ['mechanic1'] = {
            bossRank = 4,
            locations = {
                vector4(-774.55, -2075.67, 8.99, 320.84),
                vector4(-921.81, -2044.65, 14.26, 47.89),
            }
        },
        ['mechanic2'] = {
            bossRank = 4,
            locations = {
                vector3(125.43, -3014.79, 6.86),
            }
        },
        ['mechanic3'] = {
            bossRank = 4,
            locations = {
                vector3(1157.73, -778.38, 57.41),
            }
        },
        -- ['aod'] = {
        --     bossRank = 4,
        --     locations = {
        --         vector3(265.56, 6619.02, 33.0),
        --     }
        -- },
        ['beanmachine'] = {
            bossRank = 3,
            locations = {
                vector3(120.45, -1042.06, 29.33),
            }
        },
        ['burgershot'] = {
            bossRank = 4,
            locations = {
                vector4(-1202.51, -895.34, 13.89, 302.45),
            }
        },
        ['billiards'] = {
            bossRank = 4,
            locations = {
                vector4(-1176.04, -1611.05, 5.77, 212.58),
            }
        },
        ['catcafe'] = {
            bossRank = 4,
            locations = {
                vector3(-578.35, -1066.98, 26.52),
            }
        },
        ['skybar'] = {
            bossRank = 4,
            locations = {
                vector4(-906.19, -448.99, 160.31, 59.79), --vector4(-906.19, -448.99, 160.31, 59.79)
            }
        },
        ['bahamas'] = {
            bossRank = 4,
            locations = {
                vector4(-1365.56, -623.03, 31.12, 26.92), --vector4(-1365.56, -623.03, 31.12, 26.92)
            }
        },
        ['newspaper'] = {
            bossRank = 4,
            locations = {
                vector4(-580.9, -936.5, 23.88, 114.99), --vector4(-1365.56, -623.03, 31.12, 26.92)
            }
        },
        ['dynasty'] = {
            bossRank = 4,
            locations = {
                vector3(-953.52, -286.76, 76.11),
            }
        },
        ['rea'] = {
            bossRank = 3,
            locations = {
                vector4(-126.08, -641.19, 168.82, 109.67), --vector4(-1365.56, -623.03, 31.12, 26.92)
            }
        },
        ['hennies'] = {
            bossRank = 2,
            locations = {
                vector4(-1835.72, -1179.2, 14.33, 142.92), --vector4(-1365.56, -623.03, 31.12, 26.92)
            }
        },
        ['upnatom'] = {
            bossRank = 4,
            locations = {
                vector3(80.8, 297.24, 109.98), --vector3(80.8, 297.24, 109.98)
            }
        },
        ['maclarens'] = {
            bossRank = 2,
            locations = {
                vector4(-440.22, -137.84, 36.43, 18.83), --vector4(-1365.56, -623.03, 31.12, 26.92)
            }
        }
    },



    -- Only Edit Below If you are using QB --
    ['gangmenu'] = {
        ['cartel'] = {
            bossRank = 3,
            locations = {
                vector4(-1528.54, 149.99, 60.8, 118.69),
            }
        },
        ['triads'] = {
            bossRank = 3,
            locations = {
                vector4(-145.59, 892.53, 233.46, 127.53),
            }
        },
        ['vagos'] = {
            bossRank = 3,
            locations = {
                vector4(1370.09, -2089.13, 48.22, 309.24),
            }
        },
        ['families'] = {
            bossRank = 3,
            locations = {
                vector4(-2586.54, 1879.66, 167.32, 168.77),
            }
        },
        ['lostmc'] = {
            bossRank = 3,
            locations = {
                vector4(989.08, -124.47, 79.94, 45.07)
            }
        }
    }
}


CodeStudio.QuickAction = {          -- Society Money Quick Actions
    ['deposit'] = { -- Dont Change Name this is money deposit buttons
        [1] = 500,      -- Button 1 
        [2] = 5000      -- Button 2
    },
    ['withdraw'] = {    -- This is money withdraw buttons
        [1] = 500,
        [2] = 5000
    },
}

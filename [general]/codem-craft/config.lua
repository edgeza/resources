Config = {}
Config.Framework = 'newqb' -- esx - oldqb - newqb
Config.NewESX = false -- true - false
Config.Mysql = 'oxmysql' -- mysql-async, ghmattimysql, oxmysql
Config.Webhook = true -- true enabled false disabled
Config.Discord = true
Config.Notification = true -- true enabled false disabled for notification
Config.MysqlTableName = 'codem_craft' -- MySQL Table Name
Config.InteractionHandler = 'ox_target' -- qb-target, ox_target or drawtext

Config.Categories = {
    {
        name = 'weapons',                 -- category name
        label = 'WEAPONS',                -- category label
        activebuttonpng = 'weaponactive', -- category click active image,
        shadow = '#80C4FF',
        backgroundimage = 'weaponsbg',
        enabled = true, -- true show --false hide


    },
    {
        name = 'ammo',    -- category name
        label = 'AMMO',-- category label
        activebuttonpng = 'ammoactive',-- category click active image
        shadow = '#3C301E',
        backgroundimage = 'ammobg',
        enabled = true, -- true show --false hide

    },
    {
        name = 'tools',-- category name
        label = 'TOOLS',-- category label
        activebuttonpng = 'toolsactive',-- category click active image
        shadow = '#1E2A3C',
        backgroundimage = 'toolsbg',
        enabled = true, -- true show --false hide

    },
}

Config.Draw = {
    ["enabled"]  =  false , -- true  show -- false hide
    ["textmarket"] = '[E] Craft',
}

Config.CraftNpc = {

    ------------------
    --AUTO PISTOL CRAFTING (Class 2)
    ------------------
    [1] = {
        ["name"] = "Craft",
        ["job"]  = "public",  -- mafia,police,ambulance, etc  -- "public" open to all (if you want use gang set public like ["job"]  = "public")
        ["gang"] = "none",  -- made for qbcore users 'lostmc','ballas','vagos' -- "none" open to all
        ["blip"] = {
            ['enabled'] = false, -- show/false hide blip
            ["sprite"] = 628,
            ["color"] = 3,
            ["size"] = 0.6,
        },
        ["ped"] = {
            ["model"] = 0xED0CE4C6,
            ["position"] = vector3(2760.7, 1548.76, 30.79),
            ["heading"] = 135.00,
            ["show"] = false, -- true show -- false hide
        },
        ["craftitems"] = {
            [1] = {
                ["itemname"] = "weapon_blueglocks",
                ["label"] = "Blue Glock",
                ["level"] = 6,
                ["rewardXp"] = 40,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 350,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 320,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 320,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 180,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 30,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
            [2] = {
                ["itemname"] = "weapon_revolver_mk2",
                ["label"] = "Revolver MK2",
                ["level"] = 4,
                ["rewardXp"] = 25,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 200,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 180,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 150,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 120,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 20,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
            [3] = {
                ["itemname"] = "weapon_doubleaction",
                ["label"] = "Double Action Revolver",
                ["level"] = 3,
                ["rewardXp"] = 20,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 180,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 160,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 140,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 100,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 20,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
            [4] = {
                ["itemname"] = "weapon_navyrevolver",
                ["label"] = "Navy Revolver",
                ["level"] = 5,
                ["rewardXp"] = 30,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 220,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 200,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 180,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 140,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 30,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
        },
    },
    ------------------
    --ARMOR CRAFTING
    ------------------
    [2] = {
        ["name"] = "Craft",
        ["job"]  = "public",  -- mafia,police,ambulance, etc  -- "public" open to all (if you want use gang set public like ["job"]  = "public")
        ["gang"] = "none",  -- made for qbcore users 'lostmc','ballas','vagos' -- "none" open to all
        ["blip"] = {
            ['enabled'] = false, -- show/false hide blip
            ["sprite"] = 628,
            ["color"] = 3,
            ["size"] = 0.6,
        },
        ["ped"] = {
            ["model"] = 0xED0CE4C6,
            ["position"] = vector3(-489.77, 5326.56, 80.59),
            ["heading"] = 135.00,
            ["show"] = false, -- true show -- false hide
        },
        ["craftitems"] = {
            -- [1] = {
            --     ["itemname"] = "armor",
            --     ["label"] = "Armor",
            --     ["level"] = 1,
            --     ["rewardXp"] = 15,
            --     ["time"] = 1, --- 5 minutes
            --     ["category"] = "tools",
            --     ["itemamount"] = 1, --  number of items to be given to the person
            --     ["requiredItems"] = {
            --         [1] = {
            --             ["name"] = "rubber",
            --             ["label"] = "Rubber",
            --             ["count"] = 200,
            --         },
            --         [2] = {
            --             ["name"] = "metalscrap",
            --             ["label"] = "Scrap Metal",
            --             ["count"] = 100,
            --         },
            --         [3] = {
            --             ["name"] = "plastic",
            --             ["label"] = "Plastic",
            --             ["count"] = 100,
            --         },
            --     },
            -- },
            [1] = {
                ["itemname"] = "heavyarmor",
                ["label"] = "Heavy Armor",
                ["level"] = 10,
                ["rewardXp"] = 10,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 100,
                    },
                    [2] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 50,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 100,
                    },
                },
            },
        },
    },
    ------------------
    --Electronics
    ------------------
    [3] = {
        ["name"] = "Craft",
        ["job"]  = "public",  -- mafia,police,ambulance, etc  -- "public" open to all (if you want use gang set public like ["job"]  = "public")
        ["gang"] = "none",  -- made for qbcore users 'lostmc','ballas','vagos' -- "none" open to all
        ["blip"] = {
            ['enabled'] = false, -- show/false hide blip
            ["sprite"] = 628,
            ["color"] = 3,
            ["size"] = 0.6,
        },
        ["ped"] = {
            ["model"] = 0xED0CE4C6,
            ["position"] = vector3(-229.82, -2009.5, 24.69),
            ["heading"] = 233.27,
            ["show"] = false, -- true show -- false hide
        },
        ["craftitems"] = {
            [1] = {
                ["itemname"] = "weapon_smokegrenade",
                ["label"] = "Smoke Grenade",
                ["level"] = 2,
                ["rewardXp"] = 10,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 30,
                    },
                    [2] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 60,
                    },
                    [3] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 50,
                    },
                    [4] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 20,
                    },
                    [5] = {
                        ["name"] = "gunpowder",
                        ["label"] = "Gunpowder",
                        ["count"] = 30,
                    },
                },
            },
            [2] = {
                ["itemname"] = "x_device",
                ["label"] = "X Device",
                ["level"] = 4,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 40,
                    },
                    [2] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 50,
                    },
                    [3] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 30,
                    },
                },
            },
            [3] = { --Heist New
                ["itemname"] = "decryptor",
                ["label"] = "Decrypter",
                ["level"] = 4,
                ["rewardXp"] = 10,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 40,
                    },
                    [2] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 50,
                    },
                },
            },
            [4] = {
                ["itemname"] = "x_phone",
                ["label"] = "X Phone",
                ["level"] = 6,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 60,
                    },
                    [2] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 60,
                    },
                },
            },
            [5] = {
                ["itemname"] = "x_harddrive",
                ["label"] = "X Harddrive",
                ["level"] = 6,
                ["rewardXp"] = 10,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 60,
                    },
                    [2] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 80,
                    },
                    [3] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 40,
                    },
                },
            },
            [6] = {
                ["itemname"] = "disruptor",
                ["label"] = "Disruptor",
                ["level"] = 6,
                ["rewardXp"] = 10,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 25,
                    },
                    [2] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 35,
                    },
                },
            },
            [7] = {
                ["itemname"] = "x_laptop",
                ["label"] = "X Laptop",
                ["level"] = 4,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 60,
                    },
                    [2] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 50,
                    },
                    [3] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 60,
                    },
                    [4] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 35,
                    },
                },
            },

            --Tier1 Heist Items
            [8] = {
                ["itemname"] = "blowtorch",
                ["label"] = "Blowtorch",
                ["level"] = 5,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 5,
                    },
                },
            },

            --Tier2 Heist Items
            [9] = {
                ["itemname"] = "fleecacard",
                ["label"] = "Fleeca Card",
                ["level"] = 7,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 10,
                    },
                },
            },
            [10] = {
                ["itemname"] = "paletocardtwo",
                ["label"] = "Paleto Card Two",
                ["level"] = 7,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 10,
                    },
                },
            },
            [11] = {
                ["itemname"] = "x_hammer",
                ["label"] = "X Hammer",
                ["level"] = 7,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 20, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 10,
                    },
                },
            },
            [12] = {
                ["itemname"] = "cashexchange2key",
                ["label"] = "Cash Exchange Key 2",
                ["level"] = 7,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 10,
                    }, 
                },
            },
            [13] = {
                ["itemname"] = "laundromatkey",
                ["label"] = "Laundromat Key",
                ["level"] = 7,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 10,
                    }, 
                },
            },

            --Tier3 Heist Items
            [14] = {
                ["itemname"] = "mazebankcard2",
                ["label"] = "Mazebank Card 2",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [15] = {
                ["itemname"] = "mazebankcard",
                ["label"] = "Mazebank Card",
                ["level"] = 7,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    },
                },
            },
            [16] = {
                ["itemname"] = "bobcatcard",
                ["label"] = "Bobcat Card",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [17] = {
                ["itemname"] = "bobcatcard2",
                ["label"] = "Bobcat Card 2",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [18] = {
                ["itemname"] = "pacificcard",
                ["label"] = "Pacific Bank Card",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [19] = {
                ["itemname"] = "oilrigcard",
                ["label"] = "Oilrig Card",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [20] = {
                ["itemname"] = "casinomanagercard",
                ["label"] = "Casino Manager Card",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [21] = {
                ["itemname"] = "casinovaultcard",
                ["label"] = "Casino Vault Card",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 2, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [22] = {
                ["itemname"] = "casinomaintenancecard",
                ["label"] = "Casino Maintenance Card",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [23] = {
                ["itemname"] = "x_moneysuitcase",
                ["label"] = "X Money Suitcase",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [24] = {
                ["itemname"] = "humanelabs_card",
                ["label"] = "Humane Labs Access Card",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [25] = {
                ["itemname"] = "union_card",
                ["label"] = "Union Bank Keycard",
                ["level"] = 10,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 20,
                    }, 
                },
            },
            [26] = {
                ["itemname"] = "weapon_stickybomb",
                ["label"] = "C4",
                ["level"] = 6,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 20,
                    },
                    [3] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 20,
                    },
                    [4] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 20,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 25,
                    },
                    [6] = {
                        ["name"] = "gunpowder",
                        ["label"] = "Gunpowder",
                        ["count"] = 40,
                    },
                },
            },
            [27] = {
                ["itemname"] = "nvg",
                ["label"] = "NVG",
                ["level"] = 6,
                ["rewardXp"] = 10,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 160,
                    },
                    [2] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 200,
                    },
                    [3] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 40,
                    },
                },
            },
            -- [28] = {
            --     ["itemname"] = "lockpick",
            --     ["label"] = "Lockpick",
            --     ["level"] = 1,
            --     ["rewardXp"] = 5,
            --     ["time"] = 1, --- 5 minutes
            --     ["category"] = "tools",
            --     ["itemamount"] = 1, --  number of items to be given to the person
            --     ["requiredItems"] = {
            --         [1] = {
            --             ["name"] = "plastic",
            --             ["label"] = "Plastic",
            --             ["count"] = 5,
            --         },
            --         [2] = {
            --             ["name"] = "steel",
            --             ["label"] = "Steel",
            --             ["count"] = 5,
            --         },
            --     },
            -- },
            [28] = {
                ["itemname"] = "hacking_device",
                ["label"] = "Yacht Hacking Device",
                ["level"] = 2,
                ["rewardXp"] = 10,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 20,
                    },
                    [3] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 10,
                    },
                },
            },
            -- [26] = {
            --     ["itemname"] = "yacht_drill",
            --     ["label"] = "Yacht Drill",
            --     ["level"] = 2,
            --     ["rewardXp"] = 15,
            --     ["time"] = 1, --- 5 minutes
            --     ["category"] = "tools",
            --     ["itemamount"] = 1, --  number of items to be given to the person
            --     ["requiredItems"] = {
            --         [1] = {
            --             ["name"] = "plastic",
            --             ["label"] = "Plastic",
            --             ["count"] = 25,
            --         },
            --         [2] = {
            --             ["name"] = "iron",
            --             ["label"] = "Iron",
            --             ["count"] = 30,
            --         },
            --     },
            -- },
            [29] = {
                ["itemname"] = "electronickit",
                ["label"] = "Electronic Kit",
                ["level"] = 1,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 20,
                    },
                },
            },
            [30] = {
                ["itemname"] = "trojan_usb",
                ["label"] = "Trojan USB",
                ["level"] = 1,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 20,
                    },
                },
            },
            [31] = {
                ["itemname"] = "x_device_pin",
                ["label"] = "X USB Pin",
                ["level"] = 1,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 20,
                    },
                },
            },
            [32] = {
                ["itemname"] = "thermite",
                ["label"] = "Thermite",
                ["level"] = 1,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 5,
                    },
                    [2] = {
                        ["name"] = "iron",
                        ["label"] = "Iron",
                        ["count"] = 10,
                    },
                    [3] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 5,
                    },
                },
            },
            [33] = { --Boosting
                ["itemname"] = "hackingdevice",
                ["label"] = "Boosting Hacking Device",
                ["level"] = 1,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 10,
                    },
                    [3] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 10,
                    },
                },
            },
            [34] = { --Boosting
                ["itemname"] = "gpshackingdevice",
                ["label"] = "Gps Hacking Device",
                ["level"] = 1,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 10,
                    },
                    [3] = {
                        ["name"] = "glass",
                        ["label"] = "Glass",
                        ["count"] = 10,
                    },
                },
            },
            [35] = { 
                ["itemname"] = "hackcard",
                ["label"] = "Hack Card",
                ["level"] = 2,
                ["rewardXp"] = 20,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 10,
                    },
                    [3] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 10,
                    },
                },
            },
            [36] = { 
                ["itemname"] = "laserdrill",
                ["label"] = "Laser Drill",
                ["level"] = 1,
                ["rewardXp"] = 20,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 20,
                    },
                    [3] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 10,
                    },
                    [4] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 20,
                    },
                },
            },
            [37] = { 
                ["itemname"] = "x_cratejammer",
                ["label"] = "Crate Jammer",
                ["level"] = 1,
                ["rewardXp"] = 20,
                ["time"] = 1, --- 5 minutes
                ["category"] = "tools",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 20,
                    },
                    [3] = {
                        ["name"] = "metalscrap",
                        ["label"] = "Scrap Metal",
                        ["count"] = 20,
                    },
                    [4] = {
                        ["name"] = "iron",
                        ["label"] = "Iron",
                        ["count"] = 10,
                    },
                },
            }
        },
    },
     ------------------
    --SMG CRAFTING (Class 3)
    ------------------
    [4] = {
        ["name"] = "Craft",
        ["job"]  = "public",  -- mafia,police,ambulance, etc  -- "public" open to all (if you want use gang set public like ["job"]  = "public")
        ["gang"] = "none",  -- made for qbcore users 'lostmc','ballas','vagos' -- "none" open to all
        ["blip"] = {
            ['enabled'] = false, -- show/false hide blip
            ["sprite"] = 628,
            ["color"] = 3,
            ["size"] = 0.6,
        },
        ["ped"] = {
            ["model"] = 0xED0CE4C6,
            ["position"] = vector3(-263.42, 4729.28, 138.34),
            ["heading"] = 223.96,
            ["show"] = false, -- true show -- false hide
        },
        ["craftitems"] = {
            [1] = {
                ["itemname"] = "weapon_tec9s",
                ["label"] = "TEC9s",
                ["level"] = 8,
                ["rewardXp"] = 40,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 360,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 350,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 360,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 200,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 40,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
            [2] = {
                ["itemname"] = "weapon_krissvector",
                ["label"] = "Krissvector",
                ["level"] = 8,
                ["rewardXp"] = 35,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 360,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 350,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 360,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 200,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 40,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
            [3] = {
                ["itemname"] = "weapon_uzi",
                ["label"] = "Uzi",
                ["level"] = 6,
                ["rewardXp"] = 35,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 300,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 280,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 300,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 180,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 40,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
            [4] = {
                ["itemname"] = "weapon_machinepistol",
                ["label"] = "Machine Pistol",
                ["level"] = 4,
                ["rewardXp"] = 25,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 250,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 230,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 250,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 140,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 30,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
            [5] = {
                ["itemname"] = "weapon_minismg",
                ["label"] = "Mini SMG",
                ["level"] = 3,
                ["rewardXp"] = 20,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 220,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 200,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 220,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 120,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 30,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
            [6] = {
                ["itemname"] = "weapon_microsmg",
                ["label"] = "Micro SMG",
                ["level"] = 2,
                ["rewardXp"] = 15,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 200,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 180,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 200,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 100,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 30,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
            [7] = {
                ["itemname"] = "weapon_smg_mk2",
                ["label"] = "SMG MK2",
                ["level"] = 7,
                ["rewardXp"] = 40,
                ["time"] = 1, --- 5 minutes
                ["category"] = "weapons",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "rubber",
                        ["label"] = "Rubber",
                        ["count"] = 320,
                    },
                    [2] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 300,
                    },
                    [3] = {
                        ["name"] = "plastic",
                        ["label"] = "Plastic",
                        ["count"] = 320,
                    },
                    [4] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 200,
                    },
                    [5] = {
                        ["name"] = "reinforced_steel",
                        ["label"] = "Reinforced Steel",
                        ["count"] = 40,
                    },
                    [6] = {
                        ["name"] = "onelife_token",
                        ["label"] = "OneLife Token",
                        ["count"] = 1,
                    },
                },
            },
        },
    },
     ------------------
    --ASSAULT CRAFTING (Class 4)
    ------------------
    [5] = {
        ["name"] = "Craft",
        ["job"]  = "public",
        ["gang"] = "none",
        ["blip"] = {
            ['enabled'] = false,
            ["sprite"] = 628,
            ["color"] = 3,
            ["size"] = 0.6,
        },
        ["ped"] = {
            ["model"] = 0xED0CE4C6,
            ["position"] = vector3(-1416.18, 7274.51, 15.04),
            ["heading"] = 223.96,
            ["show"] = false,
        },
        ["craftitems"] = {
            [1] = {
                ["itemname"] = "weapon_blackarp",
                ["label"] = "Black ARP",
                ["level"] = 10,
                ["rewardXp"] = 50,
                ["time"] = 1,
                ["category"] = "weapons",
                ["itemamount"] = 1,
                ["requiredItems"] = {
                    [1] = { ["name"] = "rubber", ["label"] = "Rubber", ["count"] = 250 },
                    [2] = { ["name"] = "steel", ["label"] = "Steel", ["count"] = 180 },
                    [3] = { ["name"] = "plastic", ["label"] = "Plastic", ["count"] = 180 },
                    [4] = { ["name"] = "aluminum", ["label"] = "Aluminum", ["count"] = 140 },
                    [5] = { ["name"] = "reinforced_steel", ["label"] = "Reinforced Steel", ["count"] = 50 },
                    [6] = { ["name"] = "onelife_token", ["label"] = "OneLife Token", ["count"] = 1 },
                },
            },
            [2] = {
                ["itemname"] = "weapon_redarp",
                ["label"] = "Red Drag ARP",
                ["level"] = 10,
                ["rewardXp"] = 50,
                ["time"] = 1,
                ["category"] = "weapons",
                ["itemamount"] = 1,
                ["requiredItems"] = {
                    [1] = { ["name"] = "rubber", ["label"] = "Rubber", ["count"] = 250 },
                    [2] = { ["name"] = "steel", ["label"] = "Steel", ["count"] = 180 },
                    [3] = { ["name"] = "plastic", ["label"] = "Plastic", ["count"] = 180 },
                    [4] = { ["name"] = "aluminum", ["label"] = "Aluminum", ["count"] = 140 },
                    [5] = { ["name"] = "reinforced_steel", ["label"] = "Reinforced Steel", ["count"] = 50 },
                    [6] = { ["name"] = "onelife_token", ["label"] = "OneLife Token", ["count"] = 1 },
                },
            },
            [3] = {
                ["itemname"] = "weapon_tarp",
                ["label"] = "Tan ARP",
                ["level"] = 10,
                ["rewardXp"] = 50,
                ["time"] = 1,
                ["category"] = "weapons",
                ["itemamount"] = 1,
                ["requiredItems"] = {
                    [1] = { ["name"] = "rubber", ["label"] = "Rubber", ["count"] = 250 },
                    [2] = { ["name"] = "steel", ["label"] = "Steel", ["count"] = 180 },
                    [3] = { ["name"] = "plastic", ["label"] = "Plastic", ["count"] = 180 },
                    [4] = { ["name"] = "aluminum", ["label"] = "Aluminum", ["count"] = 140 },
                    [5] = { ["name"] = "reinforced_steel", ["label"] = "Reinforced Steel", ["count"] = 50 },
                    [6] = { ["name"] = "onelife_token", ["label"] = "OneLife Token", ["count"] = 1 },
                },
            },
            [4] = {
                ["itemname"] = "weapon_woarp",
                ["label"] = "White Out ARP",
                ["level"] = 10,
                ["rewardXp"] = 50,
                ["time"] = 1,
                ["category"] = "weapons",
                ["itemamount"] = 1,
                ["requiredItems"] = {
                    [1] = { ["name"] = "rubber", ["label"] = "Rubber", ["count"] = 250 },
                    [2] = { ["name"] = "steel", ["label"] = "Steel", ["count"] = 180 },
                    [3] = { ["name"] = "plastic", ["label"] = "Plastic", ["count"] = 180 },
                    [4] = { ["name"] = "aluminum", ["label"] = "Aluminum", ["count"] = 140 },
                    [5] = { ["name"] = "reinforced_steel", ["label"] = "Reinforced Steel", ["count"] = 50 },
                    [6] = { ["name"] = "onelife_token", ["label"] = "OneLife Token", ["count"] = 1 },
                },
            },
            [5] = {
                ["itemname"] = "weapon_assaultrifle_mk2",
                ["label"] = "Assault Rifle MK2",
                ["level"] = 12,
                ["rewardXp"] = 60,
                ["time"] = 1,
                ["category"] = "weapons",
                ["itemamount"] = 1,
                ["requiredItems"] = {
                    [1] = { ["name"] = "rubber", ["label"] = "Rubber", ["count"] = 300 },
                    [2] = { ["name"] = "steel", ["label"] = "Steel", ["count"] = 250 },
                    [3] = { ["name"] = "plastic", ["label"] = "Plastic", ["count"] = 250 },
                    [4] = { ["name"] = "aluminum", ["label"] = "Aluminum", ["count"] = 200 },
                    [5] = { ["name"] = "reinforced_steel", ["label"] = "Reinforced Steel", ["count"] = 60 },
                    [6] = { ["name"] = "onelife_token", ["label"] = "OneLife Token", ["count"] = 1 },
                },
            },
            [6] = {
                ["itemname"] = "weapon_bullpuprifle_mk2",
                ["label"] = "Bullpup Rifle MK2",
                ["level"] = 11,
                ["rewardXp"] = 55,
                ["time"] = 1,
                ["category"] = "weapons",
                ["itemamount"] = 1,
                ["requiredItems"] = {
                    [1] = { ["name"] = "rubber", ["label"] = "Rubber", ["count"] = 280 },
                    [2] = { ["name"] = "steel", ["label"] = "Steel", ["count"] = 220 },
                    [3] = { ["name"] = "plastic", ["label"] = "Plastic", ["count"] = 220 },
                    [4] = { ["name"] = "aluminum", ["label"] = "Aluminum", ["count"] = 180 },
                    [5] = { ["name"] = "reinforced_steel", ["label"] = "Reinforced Steel", ["count"] = 55 },
                    [6] = { ["name"] = "onelife_token", ["label"] = "OneLife Token", ["count"] = 1 },
                },
            },
            [7] = {
                ["itemname"] = "weapon_famas",
                ["label"] = "FAMAS",
                ["level"] = 13,
                ["rewardXp"] = 65,
                ["time"] = 1,
                ["category"] = "weapons",
                ["itemamount"] = 1,
                ["requiredItems"] = {
                    [1] = { ["name"] = "rubber", ["label"] = "Rubber", ["count"] = 320 },
                    [2] = { ["name"] = "steel", ["label"] = "Steel", ["count"] = 280 },
                    [3] = { ["name"] = "plastic", ["label"] = "Plastic", ["count"] = 280 },
                    [4] = { ["name"] = "aluminum", ["label"] = "Aluminum", ["count"] = 220 },
                    [5] = { ["name"] = "reinforced_steel", ["label"] = "Reinforced Steel", ["count"] = 70 },
                    [6] = { ["name"] = "onelife_token", ["label"] = "OneLife Token", ["count"] = 1 },
                },
            },
        },
    },

    -----------------------
    --PISTOL AMMO CRAFTING
    -----------------------
    [6] = {
        ["name"] = "Craft",
        ["job"]  = "public",  -- mafia,police,ambulance, etc  -- "public" open to all (if you want use gang set public like ["job"]  = "public")
        ["gang"] = "none",  -- made for qbcore users 'lostmc','ballas','vagos' -- "none" open to all
        ["blip"] = {
            ['enabled'] = false, -- show/false hide blip
            ["sprite"] = 628,
            ["color"] = 3,
            ["size"] = 0.6,
        },
        ["ped"] = {
            ["model"] = 0xED0CE4C6,
            ["position"] = vector3(121.25, -2468.75, 6.1),
            ["heading"] = 135.00,
            ["show"] = false, -- true show -- false hide
        },
        ["craftitems"] = {
            [1] = {
                ["itemname"] = "pistol_ammo",
                ["label"] = "Pistol Ammo",
                ["level"] = 2,
                ["rewardXp"] = 5,
                ["time"] = 1, --- 5 minutes
                ["category"] = "ammo",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 20,
                    },
                    [3] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 10,
                    },
                    [4] = {
                        ["name"] = "gunpowder",
                        ["label"] = "Gunpowder",
                        ["count"] = 10,
                    },
                },
            },
        },
    },

    -----------------------
    --SMG AMMO CRAFTING
    -----------------------
    [7] = {
        ["name"] = "Craft",
        ["job"]  = "public",  -- mafia,police,ambulance, etc  -- "public" open to all (if you want use gang set public like ["job"]  = "public")
        ["gang"] = "none",  -- made for qbcore users 'lostmc','ballas','vagos' -- "none" open to all
        ["blip"] = {
            ['enabled'] = false, -- show/false hide blip
            ["sprite"] = 628,
            ["color"] = 3,
            ["size"] = 0.6,
        },
        ["ped"] = {
            ["model"] = 0xED0CE4C6,
            ["position"] = vector3(726.84, 4169.02, 40.71),
            ["heading"] = 135.00,
            ["show"] = false, -- true show -- false hide
        },
        ["craftitems"] = {
            [1] = {
                ["itemname"] = "smg_ammo",
                ["label"] = "SMG Ammo",
                ["level"] = 8,
                ["rewardXp"] = 5,
                ["time"] = 1, --- 5 minutes
                ["category"] = "ammo",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 20,
                    },
                    [2] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 20,
                    },
                    [3] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 20,
                    },
                    [4] = {
                        ["name"] = "gunpowder",
                        ["label"] = "Gunpowder",
                        ["count"] = 20,
                    },
                },
            },
        },
    },

    -----------------------
    --RIFLE AMMO CRAFTING
    -----------------------
    [8] = {
        ["name"] = "Craft",
        ["job"]  = "public",  -- mafia,police,ambulance, etc  -- "public" open to all (if you want use gang set public like ["job"]  = "public")
        ["gang"] = "none",  -- made for qbcore users 'lostmc','ballas','vagos' -- "none" open to all
        ["blip"] = {
            ['enabled'] = false, -- show/false hide blip
            ["sprite"] = 628,
            ["color"] = 3,
            ["size"] = 0.6,
        },
        ["ped"] = {
            ["model"] = 0xED0CE4C6,
            ["position"] = vector3(3584.59, 3696.06, 36.64),
            ["heading"] = 179.00,
            ["show"] = false, -- true show -- false hide
        },
        ["craftitems"] = {
            [1] = {
                ["itemname"] = "rifle_ammo",
                ["label"] = "Rifle Ammo",
                ["level"] = 10,
                ["rewardXp"] = 5,
                ["time"] = 1, --- 5 minutes
                ["category"] = "ammo",
                ["itemamount"] = 1, --  number of items to be given to the person
                ["requiredItems"] = {
                    [1] = {
                        ["name"] = "steel",
                        ["label"] = "Steel",
                        ["count"] = 30,
                    },
                    [2] = {
                        ["name"] = "aluminum",
                        ["label"] = "Aluminum",
                        ["count"] = 40,
                    },
                    [3] = {
                        ["name"] = "copper",
                        ["label"] = "Copper",
                        ["count"] = 30,
                    },
                    [4] = {
                        ["name"] = "gunpowder",
                        ["label"] = "Gunpowder",
                        ["count"] = 30,
                    },
                },
            },
        },
    },
}

Config.RequiredXP = {
    [1] = 1000,
    [2] = 1500,
    [3] = 2000,
    [4] = 2500,
    [5] = 3000,
    [6] = 3500,
    [7] = 4000,
    [8] = 4500,
    [9] = 5000,
    [10] = 5500,
    [11] = 6000,
    [12] = 6500,
    [13] = 7000,
    [14] = 7500,
    [15] = 8000,
    [16] = 8500,
    [17] = 9000,
    [18] = 9500,
    [19] = 10000,
    [20] = 10500,
    [21] = 11000,
    [22] = 11500,
    [23] = 12000,
    [24] = 12500,
    [25] = 13000,
    [26] = 13500,
    [27] = 14000,
    [28] = 14500,
    [29] = 15000,
    [30] = 15500,
    [31] = 16000,
    [32] = 16500,
    [33] = 17000,
    [34] = 17500,
    [35] = 18000,
    [36] = 18500,
    [37] = 19000,
    [38] = 19500,
    [39] = 20000,
    [40] = 20500,
    [41] = 21000,
    [42] = 21500,
    [43] = 22000,
    [44] = 22500,
    [45] = 23000,
    [46] = 23500,
    [47] = 24000,
    [48] = 24500,
    [49] = 25000,
    [50] = 25500,
}

Config.Locale ={
    ['weaponsbutton'] = 'WEAPONS',
    ['ammobuttons'] = 'AMMO',
    ['tools'] = 'TOOLS',
    ['craftcategories'] = 'Craft Categories',
    ['craft'] = 'craft',
    ['weaponsblueprint'] = 'Weapons Blueprint',
    ['ammoblueprint'] = 'Ammo Blueprint',
    ['toolsblueprint'] = 'Tools Blueprint',
    ['craftdetails'] = 'Craft Details',
    ['noitem'] = 'No Items Has Selected',
    ['CRAFTINGMIN'] = 'Minute Crafting Time',
    ['exitfrom'] = 'EXIT FROM',
    ['craftmenu'] = 'CRAFT MENU',
    ['craftbutton'] = 'CRAFT',
    ['readyclaim'] = 'Ready to claim!',
    ['minutesleft'] = 'minutes left'

}

Config.NotificationText = {
    ["NOT_ALLOWED"] = {
        text = 'You dont have access to Craft',
        type = 'error',
        timeout = 3000,
    },
}

Config.ClientNotification = function(message, type, length) -- You can change notification event here
    if Config.Notification then
        if Config.Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, type, length)
        end
    end
end

function GetGang()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == "esx" then
        return "none"
    else
        return frameworkObject.Functions.GetPlayerData().gang.name
    end
end

function GetJob()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == "esx" then
        return frameworkObject.PlayerData.job.name
    else
        return frameworkObject.Functions.GetPlayerData().job.name
    end
end

function GetIdentifier(source)
    if Config.Framework == "esx" then
        local xPlayer = frameworkObject.GetPlayerFromId(tonumber(source))

        if xPlayer then
            return xPlayer.getIdentifier()
        else
            return "0"
        end
    else
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.citizenid
        else
            return "0"
        end
    end
end


function GetName(source)
    if Config.Framework == "esx" then
        local xPlayer = frameworkObject.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getName()
        else
            return "0"
        end
    else
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        else
            return "0"
        end
    end
end
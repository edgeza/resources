Config = Config or {}
Loc = {}

Config.Debug = false        -- enable debug mode
Config.Lan = "en"           -- Language
Config.Target = "ox_target" -- choose the way to interact with the script
-- "qb-target" for qb-target
-- "ox_target" for ox-target
Config.interactions = { -- "target" | "drawtext" choose the target of each robbable object || nil if u don't want to rob a specific thing
    ["Registers"] = "target",
    ["SmallSafe"] = "target",
    ["Computer"] = "target",
    ["Safe"] = "target",
    ["Fridges"] = "target",
    ["Freezer"] = "target",
    ["Donut"] = "target",
    ["Shelfs"] = "target",
    ["ElectricBox"] = "target",
}

Config.Icons = {
    ["Registers"] = "fas fa-lock",
    ["SmallSafe"] = "fas fa-lock",
    ["Computer"] = "fas fa-lock",
    ["Fridges"] = "fas fa-hand",
    ["Freezer"] = "fas fa-hand",
    ["Donut"] = "fas fa-hand",
    ["Shelfs"] = "fas fa-hand",
    ["ElectricBox"] = "fas fa-hand",
    ["Safe_Cracking"] = "fas fa-lock",
    ["Safe_Drill"] = "fas fa-user-secret",
    ["Safe_Bomb"] = "fas fa-bomb",
}

Config.Framework = "qb" -- "qb" | "esx" | "other"

Config.Inventory = "qs" -- choose the inventory to use
-- "ox" for ox_inventory
-- "qb" for qb-core | qb-inventory, ps-inventory, qs-inventory
-- "esx" for esx framework | esx, qs-inventory

Config.Dispatch = "custom"
-- "ps" for ps-dispatch
-- "cd" for cd_dispatch
-- "qs" for qs-dispatch
-- "rcore" for rcore_dispatch
-- "custom" for custom dispatch

Config.RequiredPolice = 0       -- required police to initiate the robbery

Config.DiscordLogStatus = false -- Toggle built in discord logs for items and money earned (make sure to add your webhook down below search for Webhook in this file (ctrl + f Webhook))

Config.Minigame = {             -- choose the minigame to use for each step of the robbery
    ["Registers"] = "lockpick",
    ["SmallSafe"] = "pincode",
    ["Computer"] = "skillbar",
    ["Fridges"] = "skillcircle",
    ["Freezer"] = "skillcircle",
    ["Donut"] = "skillcircle",
    ["Shelfs"] = "skillcircle",
    ["ElectricBox"] = "wirecut",
}
-- "wirecut" | from boii_minigames
-- "pincode" | from boii_minigames
-- "skillcircle" | from boii_minigames
-- "skillbar" | from boii_minigames
-- "buttonmash" | from boii_minigames
-- "lockpick" | from baguscodestudio
-- nil | no minigame

Config.ProgressBarTime = {
    ["Register"] = 0.1,
    ["SmallSafe"] = 0.1,
    ["Computer"] = 0.1,
    ["Fridges"] = 0.1,
    ["Freezer"] = 0.1,
    ["Donut"] = 0.1,
    ["Shelfs"] = 0.1,
    ["ElectricBox"] = 0.1,
}

Config.RegisterOption = "both" -- "lockpick" | "hit" | "both" in which way you want the register to be robbed
Config.ItemRequired = {        -- choosed for each step of the robbery
    ["Register"] = { item = "advancedlockpick", breakChance = 50 },
    ["SmallSafe"] = { item = "trojan_usb", breakChance = 50 },
    ["Computer"] = { item = "trojan_usb", breakChance = 50 },
    ["Safe"] = { ["Cracking"] = { item = nil, breakChance = 50 }, ["Drill"] = { item = "drill", breakChance = 50 }, ["Bomb"] = { item = "thermite", breakChance = 50 } },
    ["Fridges"] = { item = nil, breakChance = 50 },
    ["Freezer"] = { item = nil, breakChance = 50 },
    ["Donut"] = { item = nil, breakChance = 50 },
    ["Shelfs"] = { item = nil, breakChance = 50 },
    ["ElectricBox"] = { item = nil, breakChance = 50 },
} -- nil | no item required

Config.SmallSafeSettings = {
    Electricution = true, -- electricute the SmallSafe
    Sound = {
        url = "https://youtu.be/TBLoL0eDrjY",
        volume = 0.6, -- 0.0 to 1.0
        distance = 5,
        time = 2000,  -- Time in miliseconds
    },
}

Config.SafeOptions = {
    ["Cracking"] = { toggle = true, Minigame = "safe_crack" }, -- Crack the safe to open it
    ["Drill"] = { toggle = true },                             -- Drill the safe to open it
    ["Bomb"] = { toggle = true, Minigame = "wirecut" },        -- Bomb the safe to open it
}
-- wirecut | from boii_minigames
-- skillcircle | from boii_minigames
-- skillbar | from boii_minigames
-- buttonmash | from boii_minigames
-- "lockpick" | from baguscodestudio
-- nil | no minigame

Config.Cooldown = {  -- Cooldown system of the stores
    type = "single", -- "single" | "global" cooldown on all the stores if u want to only rob one shop at a time
    duration = 10,   -- duration of the cooldown (in minutes)
}

Config.Stress = {
    Chance = 0, -- chance of stress on robbery
    Gain = 0.5, -- stress gain on robbery
}

Config.Skill = {
    RequiredLevel = nil, -- nil if u don't want to check skill
    Gain = 0.5,          -- skill gain on robbery
}

Config.Evidence = {
    toggle = false, -- toggle if you want to use evidence
    Chance = 50,    -- chance of leaving an evidence
}

Config.Reward = {
    ["247"] = {
        ["Register"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Safe"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["SmallSafe"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Computer"] = {
            DistributionTime = 1,          -- Time in minutes
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Shelfs"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "basicdecrypter", chance = 100, amount = { min = 1, max = 1 } },
                [2] = { item = "basicdrill", chance = 100, amount = { min = 1, max = 1 } },
                [3] = { item = "laptop_green", chance = 100, amount = { min = 1, max = 1 } },
            }
        },
        ["Fridges"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info

                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Freezer"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info

                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Donut"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info

                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
    },
    ["LTD"] = {
        ["Register"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Safe"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Computer"] = {
            DistributionTime = 1,          -- Time in minutes
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Shelfs"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "basicdecrypter", chance = 100, amount = { min = 1, max = 1 } },
                [2] = { item = "basicdrill", chance = 100, amount = { min = 1, max = 1 } },
                [3] = { item = "laptop_green", chance = 100, amount = { min = 1, max = 1 } },
            }
        },
        ["Fridges"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info

                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Freezer"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info

                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
        ["Donut"] = {
            Money = {
                Moneytype = "cash",        -- "cash" | "bank" | "item" | nil if u don't want to get money
                MoneyItem = "markedbills", --  -- The item u want to take as money (make sure to set the Moneytype to "item")
                ItemInfo = false,          -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info

                MoneyReward = {            -- Set the min and the max cash or bank reward
                    min = 200,
                    max = 400
                }
            },
            GetItem = true, -- Get Items
            Item = {
                [1] = { item = "diamond_ring", chance = 20, amount = { min = 1, max = 3 } },
                [2] = { item = "goldchain", chance = 20, amount = { min = 1, max = 3 } },
                [3] = { item = "goldring", chance = 20, amount = { min = 1, max = 3 } },
            }
        },
    }
}

Config.ShopsControl = { -- Select which shops you want to be robbable (coords are only added here to make it easy for you to tp to them)
    [1] = {
        enable = true,
        coords = vec3(-47.5, -1751.0, 29.0),
        Interactions = {
            ["Registers"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
        }
    },
    [2] = {
        enable = true,
        coords = vec3(-712.0, -910.0, 19.0),
        Interactions = {
            ["Registers"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
        }
    },
    [3] = {
        enable = true,
        coords = vec3(30.0, -1345.0, 29.0),
        Interactions = {
            ["Registers"] = true,
            ["SmallSafe"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
            ["ElectricBox"] = true,
        }
    },
    [4] = {
        enable = true,
        coords = vec3(1158.42, -320.1, 69.0),
        Interactions = {
            ["Registers"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
        }
    },
    [5] = {
        enable = true,
        coords = vec3(378.0, 327.0, 104.0),
        Interactions = {
            ["Registers"] = true,
            ["SmallSafe"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
            ["ElectricBox"] = true,
        }
    },
    [6] = {
        enable = true,
        coords = vec3(-1825.7, 792.71, 138.0),
        Interactions = {
            ["Registers"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
        }
    },
    [7] = {
        enable = true,
        coords = vec3(-3043.0, 589.0, 8.0),
        Interactions = {
            ["Registers"] = true,
            ["SmallSafe"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
            ["ElectricBox"] = true,
        }
    },
    [8] = {
        enable = true,
        coords = vec3(-3244.0, 1005.0, 13.0),
        Interactions = {
            ["Registers"] = true,
            ["SmallSafe"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
            ["ElectricBox"] = true,
        }
    },
    [9] = {
        enable = true,
        coords = vec3(544.0, 2668.0, 42.0),
        Interactions = {
            ["Registers"] = true,
            ["SmallSafe"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
            ["ElectricBox"] = true,
        }
    },
    [10] = {
        enable = true,
        coords = vec3(2679.0, 3285.0, 55.0),
        Interactions = {
            ["Registers"] = true,
            ["SmallSafe"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
            ["ElectricBox"] = true,
        }
    },
    [11] = {
        enable = true,
        coords = vec3(1964.0, 3745.0, 32.0),
        Interactions = {
            ["Registers"] = true,
            ["SmallSafe"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
            ["ElectricBox"] = true,
        }
    },
    [12] = {
        enable = true,
        coords = vec3(1734.0, 6415.0, 35.0),
        Interactions = {
            ["Registers"] = true,
            ["SmallSafe"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
            ["ElectricBox"] = true,
        }
    },
    [13] = {
        enable = true,
        coords = vec3(166.0, 6639.0, 32.0),
        Interactions = {
            ["Registers"] = true,
            ["SmallSafe"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
            ["ElectricBox"] = true,
        }
    },
    [14] = {
        enable = true,
        coords = vec3(2555.0, 386.0, 109.0),
        Interactions = {
            ["Registers"] = true,
            ["Computer"] = true,
            ["Safe"] = true,
            ["Fridges"] = true,
            ["Freezer"] = true,
            ["Donut"] = true,
            ["Shelfs"] = true,
        }
    },
}

Config.RobberySteps = { -- here you specify the steps of the robbery for each step u want to rob step by step (Check docs folder here for more info)
    ["Registers"] = {
        ["SmallSafe"] = false,
        ["Computer"] = false,
        ["Safe"] = false,
        ["ElectricBox"] = true,
        ["Fridges"] = false,
        ["Freezer"] = false,
        ["Donut"] = false,
        ["Shelfs"] = false,
    },
    ["SmallSafe"] = { -- For example if u want to open the SmallSafe you'll need to rob the register and the ElectricBox you can adjust the values just by changing it between true and false
        ["Registers"] = false,
        ["Fridges"] = false,
        ["Freezer"] = false,
        ["Donut"] = false,
        ["Shelf"] = false,
        ["ElectricBox"] = false,
    },
    ["Computer"] = {
        ["Registers"] = false,
        ["SmallSafe"] = false,
        ["Safe"] = false,
        ["Fridges"] = false,
        ["Freezer"] = false,
        ["Donut"] = false,
        ["Shelf"] = false,
        ["ElectricBox"] = false,
    },
    ["Safe"] = {
        ["Registers"] = false,
        ["SmallSafe"] = false,
        ["Computer"] = false,
        ["Fridges"] = false,
        ["Freezer"] = false,
        ["Donut"] = false,
        ["Shelf"] = false,
        ["ElectricBox"] = false,
    },
    ["Fridges"] = {
        ["Registers"] = false,
        ["SmallSafe"] = false,
        ["Computer"] = false,
        ["Safe"] = false,
        ["Freezer"] = false,
        ["Donut"] = false,
        ["Shelf"] = false,
        ["ElectricBox"] = false,
    },
    ["Freezer"] = {
        ["Registers"] = false,
        ["SmallSafe"] = false,
        ["Computer"] = false,
        ["Safe"] = false,
        ["Fridges"] = false,
        ["Donut"] = false,
        ["Shelf"] = false,
        ["ElectricBox"] = false,

    },
    ["Donut"] = {
        ["Registers"] = false,
        ["SmallSafe"] = false,
        ["Computer"] = false,
        ["Safe"] = false,
        ["Fridges"] = false,
        ["Freezer"] = false,
        ["Shelf"] = false,
        ["ElectricBox"] = false,
    },
    ["Shelfs"] = {
        ["Register"] = true,
        ["SmallSafe"] = false,
        ["Computer"] = false,
        ["Safe"] = false,
        ["Fridges"] = false,
        ["Freezer"] = false,
        ["Donut"] = false,
        ["ElectricBox"] = false,

    },
    ["ElectricBox"] = {
        ["Registers"] = false,
        ["SmallSafe"] = false,
        ["Computer"] = false,
        ["Safe"] = false,
        ["Fridges"] = false,
        ["Freezer"] = false,
        ["Donut"] = false,
        ["Shelfs"] = false,
    },
}

if IsDuplicityVersion() then
    local CORE


    if Config.Framework == "qb" then
        CORE = exports['qb-core']:GetCoreObject()
    elseif Config.Framework == "esx" then
        CORE = exports["es_extended"]:getSharedObject()
    end

    function Notify(data)
        TriggerClientEvent('ox_lib:notify', data.src, {
            title = "5Crime Store Robbery",
            description = data.description,
            type = data.type,
        })
    end

    function Inventory(data)
        if Config.Inventory == "ox" then
            if data.action == "has" then
                if not exports.ox_inventory:GetItem(data.src, data.item, nil, true) then return false end
                return exports.ox_inventory:GetItem(data.src, data.item, nil, true) > 0
            elseif data.action == "add" then
                exports.ox_inventory:AddItem(data.src, data.item, data.amount or 1)
            elseif data.action == "remove" then
                exports.ox_inventory:RemoveItem(data.src, data.item, data.amount or 1)
            end
        elseif Config.Inventory == "qb" then
            local player = CORE.Functions.GetPlayer(data.src)
            if data.action == "has" then
                local item = player.Functions.GetItemByName(data.item)
                return item and item.amount > 0
            elseif data.action == "add" then
                player.Functions.AddItem(data.item, data.amount or 1, false, data.info)
            elseif data.action == "remove" then
                player.Functions.RemoveItem(data.item, data.amount or 1)
            end
        elseif Config.Inventory == "esx" then
            if data.action == "has" then
                return CORE.GetPlayerFromId(data.src).hasItem(data.item) ~= nil
            elseif data.action == "add" then
                CORE.GetPlayerFromId(data.src).addInventoryItem(data.item, data.amount)
            elseif data.action == "remove" then
                CORE.GetPlayerFromId(data.src).removeInventoryItem(data.item, data.amount)
            end
        end
    end

    function PoliceNbEnough()
        local currentCops = 0
        if Config.Framework == "qb" then
            local jobs = { "police", "sherif", "fib" }
            local players = CORE.Functions.GetPlayers()
            for _, playerId in ipairs(players) do
                local player = CORE.Functions.GetPlayer(playerId)
                if player and player.PlayerData.job.name then
                    for _, job in ipairs(jobs) do
                        if player.PlayerData.job.name == job then
                            currentCops = currentCops + 1
                            break
                        end
                    end
                end
            end
        elseif Config.Framework == "esx" then
            local players = CORE.GetPlayers()
            for _, playerId in ipairs(players) do
                local xPlayer = CORE.GetPlayerFromId(playerId)
                if xPlayer and xPlayer.job.name == "police" then
                    currentCops = currentCops + 1
                end
            end
        end
        return currentCops >= Config.RequiredPolice
    end

    function EnoughSkill(src)
        if Config.Skill.RequiredLevel == nil then return true end
        return exports["pickle_xp"]:GetPlayerLevel(src, "theft") >= Config.Skill.RequiredLevel
    end

    function AddMoney(src, type, amount)
        if Config.Framework == "qb" then
            CORE.Functions.GetPlayer(src).Functions.AddMoney(type or "cash", amount)
        elseif Config.Framework == "esx" then
            local xPlayer = CORE.GetPlayerFromId(src)
            if type == "cash" then
                xPlayer.addMoney(amount)
            else
                xPlayer.addAccountMoney(type, amount)
            end
        end
    end

    function DiscordLogMoney(source, money)
        if Config.DiscordLogStatus then
            if Config.Framework == "qb" then
                local player = CORE.Functions.GetPlayer(source)
                DiscordLog("**Name:** **" ..
                    player.PlayerData.charinfo.firstname ..
                    "** **" ..
                    player.PlayerData.charinfo.lastname ..
                    "**" ..
                    "\n" ..
                    "**Server ID:** " ..
                    player.PlayerData.cid ..
                    "\n" ..
                    "**Citizen ID:** " ..
                    player.PlayerData.citizenid ..
                    "\n" .. "**License:** " .. player.PlayerData.license .. " \n \n" ..
                    "Log info: " .. " **+** **" .. money .. "**")
            elseif Config.Framework == "esx" then
                local player = CORE.GetPlayerFromId(source)
                DiscordLog(player.getName() ..
                    ' - ' .. player.getIdentifier() .. "\n" .. "Log info: " .. " **+** **" .. money .. "**")
            end
        end
    end

    function DiscordLogItem(source, item, amount)
        if Config.DiscordLogStatus then
            if Config.Framework == "qb" then
                local player = CORE.Functions.GetPlayer(source)
                DiscordLog("**Name:** **" ..
                    player.PlayerData.charinfo.firstname ..
                    "** **" ..
                    player.PlayerData.charinfo.lastname ..
                    "**" ..
                    "\n" ..
                    "**Server ID:** " ..
                    player.PlayerData.cid ..
                    "\n" ..
                    "**Citizen ID:** " ..
                    player.PlayerData.citizenid ..
                    "\n" ..
                    "**License:** " ..
                    player.PlayerData.license ..
                    " \n \n" .. "Log info: " .. " **+** **" .. amount .. "** **" .. item .. "**")
            elseif Config.Framework == "esx" then
                local player = CORE.GetPlayerFromId(source)
                DiscordLog(player.getName() ..
                    ' - ' ..
                    player.getIdentifier() .. "\n" .. "Log info: " .. " **+** **" .. amount .. "** **" .. item ..
                    "**")
            end
        end
    end

    lib.addCommand("RESETSHOP", {
        help = "Reset Nearest shop",
        restricted = 'group.admin'
    }, function(source, args, raw)
        TriggerEvent("store-fm:server:ResetCommand", source)
    end)
else
    local Zones = {}
    function Zone(name, coords, size, rotation, onEnter, onExit)
        Zones[#Zones + 1] = lib.zones.box({
            name = name,
            coords = coords,
            size = size,
            rotation = rotation,
            debug = Config.Debug,
            onEnter = onEnter,
            onExit = onExit
        })
    end

    function DeleteZone(name)
        for k, v in pairs(Zones) do
            if v.name == name then
                Zones[k]:remove()
                Zones[k] = nil
            end
        end
    end

    function AddCircleZone(name, coords, radius, action, icon, label, distance, options)
        if Config.Target == "qb-target" then
            exports["qb-target"]:AddCircleZone(name, coords, radius, {
                name = name,
                debugPoly = Config.Debug,
                useZ = true
            }, {
                options = options or { {
                    name = name,
                    type = "client",
                    action = action,
                    icon = icon,
                    label = label,
                    coords = coords
                } },
                distance = distance or 1.0
            })
            ShopsTargetTable[#ShopsTargetTable + 1] = { name = name, type = "Target" }
        elseif Config.Target == "ox_target" then
            if options then
                for k, v in pairs(options) do
                    options[k].onSelect = options[k].action
                    options[k].distance = distance or 1.5
                end
            end
            local zone = exports.ox_target:addSphereZone({
                coords = coords,
                debug = Config.Debug,
                radius = radius,
                options = options or {{
                    name = name,
                    label = label,
                    icon = icon,
                    distance = distance or 1.5,
                    onSelect = action,
                }}
            })
            ShopsTargetTable[#ShopsTargetTable + 1] = { name = zone, type = "Target" }
        end
    end

    function AddBoxZone(name, coords, length, width, minz, maxz, heading, event, icon, label)
        if Config.Target == "qb-target" then
            exports["qb-target"]:AddBoxZone(name, vector3(coords.x, coords.y, coords.z), length, width, {
                name = name,
                debugPoly = Config.Debug,
                heading = heading,
                minZ = minz,
                maxZ = maxz
            }, {
                options = { {
                    name = name,
                    type = "client",
                    action = event,
                    icon = icon,
                    label = label
                } },
                distance = 1.0
            })
            ShopsTargetTable[#ShopsTargetTable + 1] = { name = name, type = "Target" }
        elseif Config.Target == "ox_target" then
            local zone = exports.ox_target:addBoxZone({
                coords = vec3(coords.x, coords.y, coords.z - 0.3),
                size = { length, width, maxz - minz },
                rotation = heading,
                debug = Config.Debug,
                options = { {
                    name = name,
                    label = label,
                    icon = icon,
                    distance = 1.5,
                    onSelect = event,
                }}
            })
            ShopsTargetTable[#ShopsTargetTable + 1] = { name = zone, type = "Target" }
        end

    end

    function DeleteTarget(name)
        if Config.Target == "qb-target" then
            exports["qb-target"]:RemoveZone(name)
        elseif Config.Target == "ox_target" then
            exports.ox_target:removeZone(name)
        end
        name = nil
    end

    function Minigame(step)
        local p = promise.new()
        if step == "wirecut" then
            exports['boii_minigames']:wire_cut({
                style = 'default', -- Style template
                timer = 10000      -- Time allowed to complete game in (ms)
            }, function(success) p:resolve(success) end)
        elseif step == "pincode" then
            exports['boii_minigames']:pincode({
                style = 'default', -- Style template
                difficulty = 2,    -- Difficulty; increasing the value increases the amount of numbers in the pincode; level 1 = 4 numbers, level 2 = 5 numbers, and so on. The UI can comfortably fit up to 10 numbers (level 6).
                guesses = 10       -- Amount of guesses allowed before fail
            }, function(success) p:resolve(success) end)
        elseif step == "skillcircle" then
            exports['boii_minigames']:skill_circle({
                style = 'default',           -- Style template
                icon = 'fas fa-credit-card', -- Any font-awesome icon; will use template icon if none is provided
                area_size = 4,               -- Size of the target area in Math.PI / "value"
                speed = 0.02,                -- Speed the target area moves
            }, function(success) p:resolve(success == 'perfect' or success == 'success') end)
        elseif step == "skillbar" then
            exports['boii_minigames']:skill_bar({
                style = 'default',        -- Style template
                icon = 'fas fa-keyboard', -- Any font-awesome icon; will use template icon if none is provided
                orientation = 2,          -- Orientation of the bar; 1 = horizontal centre, 2 = vertical right.
                area_size = 20,           -- Size of the target area in %
                perfect_area_size = 5,    -- Size of the perfect area in %
                speed = 0.5,              -- Speed the target area moves
                moving_icon = true,       -- Toggle icon movement; true = icon will move randomly, false = icon will stay in a static position
                icon_speed = 3,           -- Speed to move the icon if icon movement enabled; this value is / 100 in the javascript side true value is 0.03
            }, function(success) p:resolve(success == 'perfect' or success == 'success') end)
        elseif step == "buttonmash" then
            exports['boii_minigames']:button_mash({
                style = 'default', -- Style template
                difficulty = 3     -- Difficulty; higher difficulty makes the game harder to complete
            }, function(success) p:resolve(success) end)
        elseif step == "safe_crack" then
            exports['boii_minigames']:safe_crack({
                style = 'default',     -- Style template
                difficulty = 2         -- Difficuly; This increases the amount of lock a player needs to unlock this scuffs out a little above 6 locks I would suggest to use levels 1 - 5 only.
            }, function(success) p:resolve(success) end)
        elseif step == "lockpick" then --lockpick minigame
            local result = exports['lockpick']:startLockpick()
            p:resolve(result)
        elseif step == "skillcheck" then --ox lib skill check
            local result = lib.skillCheck({ 'easy', 'easy', { areaSize = 60, speedMultiplier = 2 }, 'easy' },
                { 'w', 'a', 's', 'd' })
            p:resolve(result)
        else
            p:resolve(true)
        end
        return Citizen.Await(p)
    end

    function Notify(data)
        lib.notify({
            title = "5Crime Store Robbery",
            description = data.description,
            type = data.type,
        })
    end

    function Progressbar(name, label, duration, bool, success)
        if lib.progressCircle({
                duration = duration,
                label = label,
                useWhileDead = bool,
                canCancel = false,
                position = "bottom",
                disable = {
                    move = true,
                    combat = true,
                    sprint = true,
                    car = true
                },
                anim = {},
                prop = {}
            }) then
            success()
        end
    end

    function Dispatch()
        if Config.Dispatch == "ps" then
            exports['ps-dispatch']:StoreRobbery()
        elseif Config.Dispatch == "qs" then
            exports['qs-dispatch']:StoreRobbery()
        elseif Config.Dispatch == "cd" then
            local data = exports['cd_dispatch']:GetPlayerInfo()
            TriggerServerEvent('cd_dispatch:AddNotification', {
                job_table = { 'police' },
                coords = data.coords,
                title = '10-15 - Store Robbery',
                message = 'A ' .. data.sex .. ' robbing a store at ' .. data.street,
                flash = 0,
                unique_id = data.unique_id,
                sound = 1,
                blip = {
                    sprite = 431,
                    scale = 1.2,
                    colour = 3,
                    flashes = false,
                    text = '911 - Store Robbery',
                    time = 5,
                    radius = 0
                }
            })
        elseif Config.Dispatch == "rcore" then
            local PlayerData = exports['rcore_dispatch']:GetPlayerData()
            local data = {
                code = '10-64 - Shop robbery',
                default_priority = 'medium',
                coords = PlayerData.coords,
                job = 'police',
                text = 'Hello, they are robbing a store! Please come as fast as possible.',
                type = 'shop_robbery',
                blip_time = 5,
                blip = {
                    sprite = 431,
                    colour = 3,
                    scale = 1.2,
                    text = '911 - Store Robbery',
                    flashes = false,
                }
            }
            TriggerServerEvent('rcore_dispatch:server:sendAlert', data)
        else
            --------- Add your disptach script here if it's none of the above
        end
    end

    function Evidence(pos)
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
end

Config.MaleNoGloves = { -- Evidence
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [18] = true,
    [26] = true,
    [52] = true,
    [53] = true,
    [54] = true,
    [55] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [118] = true,
    [125] = true,
    [132] = true
}

Config.FemaleNoGloves = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [19] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true,
    [129] = true,
    [130] = true,
    [131] = true,
    [135] = true,
    [142] = true,
    [149] = true,
    [153] = true,
    [157] = true,
    [161] = true,
    [165] = true
}
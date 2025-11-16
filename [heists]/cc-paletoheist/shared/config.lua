Config = {}

Config.PoliceJobs = {"police", "sheriff", "trooper"}
Config.MinPolice = 0
Config.Cooldown = 120 -- Minutes before the bank can be robbed again.

Config.Alert = {

}

Config.Doorlock = "ox" -- qb / ox
Config.Inventory = "custom" -- qb / lj / ox / ps / custom (Add code in server/open.lua)

Config.AlertTiming = "safecracker" -- When should the police be alerted? Can be: office1, office2, office3 or safecracker

Config.CoreName = "qb-core" -- Change the name of the core, if you've renamed qb-core
Config.TargetName = "ox_target" -- Change the name of target, if you've renamed qb-target
Config.MenuName = "qb-menu" -- Change the name of the menu, if you've renamed qb-menu

Config.StickyNote = "stickynote"

Config.InkedLaundering = false -- Set this to true if you're using cc-laundering inkedbills (will add inkcreated = os.time() to item info)

Config.MiniGames = {
    ['scrambler'] = {
        type = "greek", -- (alphabet, numeric, alphanumeric, greek, braille, runes)
        time = 30, -- Seconds to solve
        mirrored = 0 -- (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
    },
    ['maze'] = {
        time = 20
    },
    ['memorygame-powerbox'] = {
        correctBlocks = 1, -- How many blocks to show
        incorrectBlocks = 3, -- Max wrong inputs before failing 
        timetoShow = 2, -- Seconds to show the correct blocks
        timetoLose = 10 -- How many seconds the player has, before losing
    },
    ['laptophack'] = {
        puzzleDuration = 12, 
        puzzleLength = 4, 
        puzzleAmount = 3,
    },
    ['varhack'] = {
        blocks = 2,
        speed = 2
    },
    ['safecracker'] = {
        combination = 1
    },
    ['lightout'] = { -- For the office hacks
        grid = 4, -- How big the grid will be (default 5x5)
        maxClicks = 100, -- Amount of clicks before fail
    },
}

Config.Doors = { -- If you for some reason want to change your door-ids, you can change them here
    ['office1'] = {
        ['id'] = "office1",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
    ['office2'] = {
        ['id'] = "office2",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
    ['office3'] = {
        ['id'] = "office3",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
    ['backhallway'] = {
        ['id'] = "backhallway",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
    ['sidehallway'] = {
        ['id'] = "sidehallway",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
    ['frontdesk'] = {
        ['id'] = "frontdesk",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
    ['vault'] = {
        ['id'] = "vault",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
    ['security-backdoor'] = {
        ['id'] = "security-backdoor",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
    ['hallway-backdoor'] = {
        ['id'] = "hallway-backdoor",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
    ['security-door'] = {
        ['id'] = "security-door",
        ['unlocked'] = false -- Used for syncing, don't touch
    },
}

Config.PaletoBank = {
    ['control-panel'] = {
        ['target'] = {
            ['coords'] = vector3(-92.85, 6463.77, 31.49),
            ['radius'] = 0.32
        }
    },
    ['office1-hack'] = {
        ['target'] = {
            ['coords'] = vector3(-103.78, 6460.39, 31.5),
            ['radius'] = 0.25
        },
        ['hackitem'] = {
            ['item'] = "advanceddecrypter",
            ['shouldremove'] = {
                ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                ['type'] = "fail", -- Can be "fail", "success" or "both". 
                ['chance'] = 50, -- Percentage chance it will be removed
            }
        },
    },
    ['camera-panel'] = {
        ['target'] = {
            ['coords'] = vector3(-91.78, 6464.89, 31.51),
            ['radius'] = 0.31
        }
    },
    ['boss-safe'] = {
        ['target'] = {
            ['coords'] = vector3(-105.22, 6480.68, 32.02),
            ['radius'] = 0.32
        }
    },
    ['security-backdoor'] = {
        ['target'] = {
            ['coords'] = vector3(-95.51, 6473.09, 31.93),
            ['radius'] = 0.12
        },
    },
    ['sh-backdoor'] = {
        ['target'] = {
            ['coords'] = vector3(-115.56, 6480.23, 31.93),
            ['radius'] = 0.12
        },
    },
    -- Required item for both back doors:
    ['backdoor-item'] = {
        ['hackitem'] = {
            ['item'] = "advanceddecrypter",
            ['shouldremove'] = {
                ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                ['type'] = "fail", -- Can be "fail", "success" or "both". 
                ['chance'] = 50, -- Percentage chance it will be removed
            }
        }
    },
    ['vault-access'] = {
        ['target'] = {
            ['coords'] = vector3(-101.92, 6462.89, 32.13),
            ['radius'] = 0.34
        },
        ['item'] = "laptop_blue",
        ['anim'] = vector4(-102.19, 6463.08, 31.23, 223.57)
    },
    ['electronic-panel'] = {
        ['target'] = {
            ['coords'] = vector3(-117.95, 6470.29, 32.23),
            ['radius'] = 0.51
        },
        ['hackitem'] = {
            ['item'] = "advanceddecrypter",
            ['shouldremove'] = {
                ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                ['type'] = "fail", -- Can be "fail", "success" or "both". 
                ['chance'] = 50, -- Percentage chance it will be removed
            }
        },
    },     
    ['pointlocations'] = {
        ['powerbox1'] = {
            ['minigame'] = "memorygame-powerbox",
            ['type'] = "subtraction",
            ['value'] = 2,
            ['target'] = {
                ['coords'] = vector3(-97.34, 6475.01, 31.61),
                ['radius'] = 0.45
            },
            ['hackitem'] = {
                ['item'] = "advanceddecrypter",
                ['shouldremove'] = {
                    ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                    ['type'] = "fail", -- Can be "fail", "success" or "both". 
                    ['chance'] = 50, -- Percentage chance it will be removed
                }
            },
        },
        ['powerbox2'] = {
            ['minigame'] = "memorygame-powerbox",
            ['type'] = "addition",
            ['value'] = 4,
            ['target'] = {
                ['coords'] = vector3(-109.43, 6483.24, 31.72),
                ['radius'] = 0.45
            },
            ['hackitem'] = {
                ['item'] = "advanceddecrypter",
                ['shouldremove'] = {
                    ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                    ['type'] = "fail", -- Can be "fail", "success" or "both". 
                    ['chance'] = 50, -- Percentage chance it will be removed
                }
            },
        },
        ['powerbox3'] = {
            ['minigame'] = "memorygame-powerbox",
            ['type'] = "addition",
            ['value'] = 8,
            ['target'] = {
                ['coords'] = vector3(-118.77, 6477.4, 31.7),
                ['radius'] = 0.45
            },
            ['hackitem'] = {
                ['item'] = "advanceddecrypter",
                ['shouldremove'] = {
                    ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                    ['type'] = "fail", -- Can be "fail", "success" or "both". 
                    ['chance'] = 50, -- Percentage chance it will be removed
                }
            },
        },
        ['powerbox4'] = {
            ['minigame'] = "memorygame-powerbox",
            ['type'] = "subtraction",
            ['value'] = 3,
            ['target'] = {
                ['coords'] = vector3(-103.07, 6451.77, 31.54),
                ['radius'] = 0.5
            },
            ['hackitem'] = {
                ['item'] = "advanceddecrypter",
                ['shouldremove'] = {
                    ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                    ['type'] = "fail", -- Can be "fail", "success" or "both". 
                    ['chance'] = 50, -- Percentage chance it will be removed
                }
            },
        },
        ['reception'] = {
            ['minigame'] = "varhack",
            ['type'] = "subtraction",
            ['value'] = 1,
            ['target'] = {
                ['coords'] = vector3(-106.42, 6473.76, 31.45),
                ['radius'] = 0.3
            },
            ['hackitem'] = {
                ['item'] = "advanceddecrypter",
                ['shouldremove'] = {
                    ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                    ['type'] = "fail", -- Can be "fail", "success" or "both". 
                    ['chance'] = 50, -- Percentage chance it will be removed
                }
            },
        },
    },
    ['officeloot'] = {
        ['office1'] = {
            ['target'] = {
                ['coords'] = vector3(-104.13, 6458.19, 31.16),
                ['radius'] = 0.53
            },
            ['rewards'] = {
                [1] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "markedbills", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 11, -- Minimum amount to recieve
                    ['max'] = 16, -- Maximum amount to recieve
                    ['info'] = {
                        worth = math.random(1000,2000)
                    }
                },
            }
        },
        ['office2'] = {
            ['target'] = {
                ['coords'] = vector3(-95.11, 6467.17, 31.13),
                ['radius'] = 0.51
            },
            ['rewards'] = {
                [1] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "markedbills", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 11, -- Minimum amount to recieve
                    ['max'] = 16, -- Maximum amount to recieve
                    ['info'] = {
                        worth = math.random(1000,2000)
                    }
                },
            }
        },
        ['office3'] = {
            ['target'] = {
                ['coords'] = vector3(-108.14, 6478.37, 31.16),
                ['radius'] = 0.53
            },
            ['rewards'] = {
                [1] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "markedbills", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 11, -- Minimum amount to recieve
                    ['max'] = 16, -- Maximum amount to recieve
                    ['info'] = {
                        worth = math.random(1000,2000)
                    }
                },
            }
        }, 
    },
    ['trollys'] = {
        [1] = {
            ['coords'] = vector4(-98.3, 6459.2, 30.63, 3.4),
            ['type'] = "money", -- Can be money, gold or diamond
            ['taken'] = false,
            ['rewards'] = {
                [1] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "hardeneddecrypter", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 1, -- Minimum amount to recieve
                    ['max'] = 1, -- Maximum amount to recieve
                },
                [2] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "hardeneddrill", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 1, -- Minimum amount to recieve
                    ['max'] = 1, -- Maximum amount to recieve
                },
                [3] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "laptop_blue", -- what item to give (only needed if type is item) - Tier 2 item
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 1, -- Minimum amount to recieve
                    ['max'] = 1, -- Maximum amount to recieve
                },
                [4] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "bag", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 1, -- Minimum amount to recieve
                    ['max'] = 2, -- Maximum amount to recieve
                },
                [2] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "markedbills", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 11, -- Minimum amount to recieve
                    ['max'] = 16, -- Maximum amount to recieve
                    ['info'] = {
                        worth = math.random(1000,2000)
                    }
                },
            }
        },
        [2] = {
            ['coords'] = vector4(-96.12, 6461.46, 30.63, 91.08),
            ['type'] = "money", -- Can be money, gold or diamond
            ['taken'] = false,
            ['rewards'] = {
                [1] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "hardeneddecrypter", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 1, -- Minimum amount to recieve
                    ['max'] = 1, -- Maximum amount to recieve
                },
                [2] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "hardeneddrill", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 1, -- Minimum amount to recieve
                    ['max'] = 1, -- Maximum amount to recieve
                },
                [3] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "laptop_blue", -- what item to give (only needed if type is item) - Tier 2 item
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 1, -- Minimum amount to recieve
                    ['max'] = 1, -- Maximum amount to recieve
                },
                [4] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "bag", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 1, -- Minimum amount to recieve
                    ['max'] = 2, -- Maximum amount to recieve
                },
                [2] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "markedbills", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 11, -- Minimum amount to recieve
                    ['max'] = 16, -- Maximum amount to recieve
                    ['info'] = {
                        worth = math.random(1000,2000)
                    }
                },
            }
        },
    },
    ['lockers'] = {
        [1] = {
            ['target'] = {
                ['coords'] = vector3(-100.34, 6460.07, 31.83),
                ['radius'] = 1.0,
            },
            ['drillitem'] = "advanceddrill",
            ['taken'] = false,
            ['rewards'] = {
                [1] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "markedbills", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 11, -- Minimum amount to recieve
                    ['max'] = 16, -- Maximum amount to recieve
                    ['info'] = {
                        worth = math.random(1000,2000)
                    }
                },
            }
        },
        [2] = {
            ['target'] = {
                ['coords'] = vector3(-96.34, 6459.57, 31.88),
                ['radius'] = 1.0,
            },
            ['drillitem'] = "advanceddrill",
            ['taken'] = false,
            ['rewards'] = {
                [1] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "markedbills", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 11, -- Minimum amount to recieve
                    ['max'] = 16, -- Maximum amount to recieve
                    ['info'] = {
                        worth = math.random(1000,2000)
                    }
                },
            }
        },
        [3] = {
            ['target'] = {
                ['coords'] = vector3(-96.86, 6463.38, 31.93),
                ['radius'] = 1.0,
            },
            ['drillitem'] = "advanceddrill",
            ['taken'] = false,
            ['rewards'] = {
                [1] = {
                    ['type'] = "item", -- cash or item
                    ['item'] = "markedbills", -- what item to give (only needed if type is item)
                    ['chance'] = 100, -- chance to even get anything
                    ['min'] = 11, -- Minimum amount to recieve
                    ['max'] = 16, -- Maximum amount to recieve
                    ['info'] = {
                        worth = math.random(1000,2000)
                    }
                },
            }
        },
    }
}

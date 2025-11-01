Config = {}

Config.PoliceJobs = {"police", "sheriff", "trooper"}
Config.MinPolice = 0
Config.VaultTimer = 3 -- Minutes before vault opens after hack
Config.FirstCooldown = 0 -- Minutes before a bank can be robbed, when the resource starts
Config.GeneralCooldown = 90 -- Minutes before any bank can be robbed again, after one has been robbed
Config.BankCooldown = 180 -- Minutes before the individual bank can be robbed again, after it has just been robbed (This is also the reset timer, so when timer is done, the bank gets reset) (Start when camera is hacked)

Config.Doorlock = "ox" -- qb / ox
Config.Inventory = "custom" -- qb / ox / lj / ps / custom (Add code in server/open.lua)

Config.CoreName = "qb-core" -- Change the name of the core, if you've renamed qb-core
Config.TargetName = "ox_target" -- Change the name of target, if you've renamed qb-target

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
        correctBlocks = 8, -- How many blocks to show
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
        blocks = 5,
        speed = 2
    }
}

Config.Banks = {
    ['pinkcage'] = {
        ['cooldown'] = false,
        ['powerbox'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(319.77, -315.89, 51.1),
                ['radius'] = 0.75
            },
        },
        ['camera'] = {
            ['hacked'] = false,
            ['coords'] = vector4(316.22442626953, -282.53121948242, 56.154560089111, 220.590194702148),
            ['rotation'] = {107.0, 38.0},
            ['securitysystem'] = vector3(310.47, -278.82, 54.61),
        },
        ['computers'] = {
            [1] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(311.46, -279.15, 54.41),
                    ['radius'] = 0.25,
                }
            },
            [2] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(312.76, -279.63, 54.41),
                    ['radius'] = 0.25,
                }
            },
            [3] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(314.03, -280.12, 54.41),
                    ['radius'] = 0.25,
                }
            },
            [4] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(315.33, -280.56, 54.41),
                    ['radius'] = 0.25,
                }
            },
        },
        ['vaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = "laptop_green",
            ['target'] = {
                ['coords'] = vector3(311.05, -284.68, 54.36),
                ['radius'] = 0.32
            },
            ['anim'] = vector4(310.79, -284.0, 54.0, 161.98)
        },
        ['vaultdoor'] = {
            ['coords'] = vector3(312.14807128906, -283.56530761719, 54.422710418701),
            ["object"] = `v_ilev_gb_vauldr`,
            ["heading"] = {
                closed = 250.0,
                open = 160.0
            },
        },
        ['insidevaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(312.79, -285.01, 54.36),
                ['radius'] = 0.36
            }
        },
        ['lockers'] = {
            [1] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(314.26, -282.97, 54.16),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(315.78, -285.06, 54.16),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [3] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(315.13, -288.47, 54.27),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [4] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(312.28, -289.4, 54.16),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [5] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(310.92, -286.85, 54.16),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
        },
        ['trolleys'] = {
            [1] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(311.49, -288.0, 53.16, 299.65),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(200,300)
                        }
                    },
                    [2] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddecrypter", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddrill", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [4] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "laptop_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(314.02, -288.91, 53.16, 20.74),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 8, -- Minimum amount to recieve
                        ['max'] = 13, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(200,300)
                        }
                    },
                }
            }
        },
        ['doorids'] = {
            ['counter'] = "pinkcage-reception",
            ['backdoor'] = "pinkcage-backdoor",
            ['insidevault'] = "pinkcage-gate",
        }
    },
    /*
    
██████╗░███████╗██╗░░░░░██████╗░███████╗██████╗░██████╗░░█████╗░
██╔══██╗██╔════╝██║░░░░░██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗
██║░░██║█████╗░░██║░░░░░██████╔╝█████╗░░██████╔╝██████╔╝██║░░██║
██║░░██║██╔══╝░░██║░░░░░██╔═══╝░██╔══╝░░██╔══██╗██╔══██╗██║░░██║
██████╔╝███████╗███████╗██║░░░░░███████╗██║░░██║██║░░██║╚█████╔╝
╚═════╝░╚══════╝╚══════╝╚═╝░░░░░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░
    */
    ['delperro'] = {
        ['cooldown'] = false,
        ['powerbox'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(-1231.52, -327.04, 37.4),
                ['radius'] = 0.75
            },
        },
        ['camera'] = {
            ['hacked'] = false,
            ['coords'] = vector4(-1208.7674560547, -331.72857666016, 39.812274932861, 280.80487060547),
            ['rotation'] = {107.0, 38.0},
            ['securitysystem'] = vector3(-1215.37, -333.24, 38.22),
        },
        ['computers'] = {
            [1] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-1214.51, -332.75, 38.01),
                    ['radius'] = 0.25,
                }
            },
            [2] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-1213.25, -332.14, 38.01),
                    ['radius'] = 0.25,
                }
            },
            [3] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-1212.05, -331.56, 38.03),
                    ['radius'] = 0.25,
                }
            },
            [4] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-1210.8, -330.91, 38.02),
                    ['radius'] = 0.25,
                }
            },
        },
        ['vaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = "laptop_green",
            ['target'] = {
                ['coords'] = vector3(-1210.68, -336.85, 37.98),
                ['radius'] = 0.32
            },
            ['anim'] = vector4(-1210.71, -336.88, 37.50, 198.78)
        },
        ['vaultdoor'] = {
            ['coords'] = vector3(-1211.01, -335.32, 37.94),
            ["object"] = `v_ilev_gb_vauldr`,
            ["heading"] = {
                closed = 296.863,
                open = 206.863
            },
        },
        ['insidevaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(-1209.31, -335.78, 37.98),
                ['radius'] = 0.36
            }
        },
        ['lockers'] = {
            [1] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-1209.78, -333.32, 38.08),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 18, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-1207.3, -333.68, 38.13),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 9, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [3] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-1205.3, -336.48, 38.13),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [4] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-1206.37, -339.05, 38.08),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [5] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-1209.21, -338.39, 38.18),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
        },
        ['trolleys'] = {
            [1] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(-1205.58, -337.65, 36.78, 74.23),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                    [2] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddecrypter", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddrill", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [4] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "laptop_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "usb_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 33, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(-1208.11, -338.96, 36.78, 344.06),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            }
        },
        ['doorids'] = {
            ['counter'] = "dperro-reception",
            ['backdoor'] = "dperro-backdoor",
            ['insidevault'] = "dperro-gate",
        }
    },
    /*
    
░██████╗░██████╗░███████╗░█████╗░████████╗  ░█████╗░░█████╗░███████╗░█████╗░███╗░░██╗
██╔════╝░██╔══██╗██╔════╝██╔══██╗╚══██╔══╝  ██╔══██╗██╔══██╗██╔════╝██╔══██╗████╗░██║
██║░░██╗░██████╔╝█████╗░░███████║░░░██║░░░  ██║░░██║██║░░╚═╝█████╗░░███████║██╔██╗██║
██║░░╚██╗██╔══██╗██╔══╝░░██╔══██║░░░██║░░░  ██║░░██║██║░░██╗██╔══╝░░██╔══██║██║╚████║
╚██████╔╝██║░░██║███████╗██║░░██║░░░██║░░░  ╚█████╔╝╚█████╔╝███████╗██║░░██║██║░╚███║
░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░  ░╚════╝░░╚════╝░╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝
    */
    ['greatocean'] = {
        ['cooldown'] = false,
        ['powerbox'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(-2947.99, 481.17, 15.81),
                ['radius'] = 0.75
            },
        },
        ['camera'] = {
            ['hacked'] = false,
            ['coords'] = vector4(-2959.8002929688, 485.81237792969, 17.727087020874, 333.08258056641),
            ['rotation'] = {180.0, -180.0},
            ['securitysystem'] = vector3(-2961.72, 479.34, 16.15),
        },
        ['computers'] = {
            [1] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2961.67, 480.32, 15.95),
                    ['radius'] = 0.25,
                }
            },
            [2] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2961.62, 481.71, 15.95),
                    ['radius'] = 0.25,
                }
            },
            [3] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2961.54, 483.03, 15.95),
                    ['radius'] = 0.25,
                }
            },
            [4] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2961.52, 484.46, 15.95),
                    ['radius'] = 0.25,
                }
            },
        },
        ['vaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = "laptop_green",
            ['target'] = {
                ['coords'] = vector3(-2956.28, 481.62, 15.9),
                ['radius'] = 0.32
            },
            ['anim'] = vector4(-2956.28, 481.52, 15.3, 270.6)
        },
        ['vaultdoor'] = {
            ['coords'] = vector3(-2957.9, 482.33, 16.26),
            ["object"] = `v_ilev_gb_vauldr`,
            ["heading"] = {
                closed = 357.542,
                open = 267.542
            },
        },
        ['insidevaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(-2956.47, 483.38, 15.89),
                ['radius'] = 0.36
            }
        },
        ['lockers'] = {
            [1] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2958.72, 484.11, 16.05),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2957.44, 486.12, 16.0),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [3] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2954.07, 486.57, 16.05),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [4] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2952.29, 484.38, 15.95),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [5] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2954.17, 482.16, 16.0),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
        },
        ['trolleys'] = {
            [1] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(-2953.19, 482.87, 14.7, 51.04),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 8, -- Minimum amount to recieve
                        ['max'] = 13, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(200,300)
                        }
                    },
                    [2] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddecrypter", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddrill", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [4] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "laptop_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "usb_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 33, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(-2953.03, 485.82, 14.7, 137.3),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            }
        },
        ['doorids'] = {
            ['counter'] = "ocean-reception",
            ['backdoor'] = "ocean-backdoor",
            ['insidevault'] = "ocean-gate",
        }
    },
    /*
    
██╗░░██╗░█████╗░██████╗░███╗░░░███╗░█████╗░███╗░░██╗██╗░░░██╗
██║░░██║██╔══██╗██╔══██╗████╗░████║██╔══██╗████╗░██║╚██╗░██╔╝
███████║███████║██████╔╝██╔████╔██║██║░░██║██╔██╗██║░╚████╔╝░
██╔══██║██╔══██║██╔══██╗██║╚██╔╝██║██║░░██║██║╚████║░░╚██╔╝░░
██║░░██║██║░░██║██║░░██║██║░╚═╝░██║╚█████╔╝██║░╚███║░░░██║░░░
╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚══╝░░░╚═╝░░░
    */
    ['harmony'] = {
        ['cooldown'] = false,
        ['powerbox'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(1158.11, 2708.96, 38.09),
                ['radius'] = 0.5
            },
        },
        ['camera'] = {
            ['hacked'] = false,
            ['coords'] = vector4(1172.12, 2709.45, 40.09, 71.27),
            ['rotation'] = {180.0, -180.0},
            ['securitysystem'] = vector3(1178.63, 2707.8, 38.54),
        },
        ['computers'] = {
            [1] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(1177.64, 2707.81, 38.31),
                    ['radius'] = 0.25,
                }
            },
            [2] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-2961.62, 481.71, 15.95),
                    ['radius'] = 0.25,
                }
            },
            [3] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(1174.89, 2707.8, 38.33),
                    ['radius'] = 0.25,
                }
            },
            [4] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(1173.48, 2707.82, 38.34),
                    ['radius'] = 0.25,
                }
            },
        },
        ['vaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = "laptop_green",
            ['target'] = {
                ['coords'] = vector3(1176.09, 2713.16, 38.29),
                ['radius'] = 0.32
            },
            ['anim'] = vector4(1175.87, 2713.20, 39.09, 352.83)
        },
        ['vaultdoor'] = {
            ['coords'] = vector3(1175.38, 2711.78, 38.31),
            ["object"] = `v_ilev_gb_vauldr`,
            ["heading"] = {
                closed = -370.542,
                open = -270.542
            },
        },
        ['insidevaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(1174.38, 2712.83, 38.31),
                ['radius'] = 0.36
            }
        },
        ['lockers'] = {
            [1] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(1173.68, 2710.53, 38.39),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(1171.58, 2711.81, 38.29),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [3] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(1171.16, 2715.22, 38.39),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [4] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(1173.26, 2716.96, 38.34),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [5] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(1175.49, 2715.25, 38.39),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
        },
        ['trolleys'] = {
            [1] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(1174.65, 2716.12, 37.09, 140.77),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                    [2] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddecrypter", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddrill", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [4] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "laptop_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "usb_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 33, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(1171.86, 2716.08, 37.09, 227.01),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            }
        },
        ['doorids'] = {
            ['counter'] = "harmony-reception",
            ['backdoor'] = "harmony-backdoor",
            ['insidevault'] = "harmony-gate",
        }
    },
    /*
    
██╗░░░░░███████╗░██████╗░██╗░█████╗░███╗░░██╗  ░██████╗░██████╗░██╗░░░██╗░█████╗░██████╗░███████╗
██║░░░░░██╔════╝██╔════╝░██║██╔══██╗████╗░██║  ██╔════╝██╔═══██╗██║░░░██║██╔══██╗██╔══██╗██╔════╝
██║░░░░░█████╗░░██║░░██╗░██║██║░░██║██╔██╗██║  ╚█████╗░██║██╗██║██║░░░██║███████║██████╔╝█████╗░░
██║░░░░░██╔══╝░░██║░░╚██╗██║██║░░██║██║╚████║  ░╚═══██╗╚██████╔╝██║░░░██║██╔══██║██╔══██╗██╔══╝░░
███████╗███████╗╚██████╔╝██║╚█████╔╝██║░╚███║  ██████╔╝░╚═██╔═╝░╚██████╔╝██║░░██║██║░░██║███████╗
╚══════╝╚══════╝░╚═════╝░╚═╝░╚════╝░╚═╝░░╚══╝  ╚═════╝░░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝
    */
    ['legionsquare'] = {
        ['cooldown'] = false,
        ['powerbox'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(135.59, -1046.45, 29.75),
                ['radius'] = 0.75
            },
        },
        ['camera'] = {
            ['hacked'] = false,
            ['coords'] = vector4(151.72, -1044.24, 31.37, 231.48),
            ['rotation'] = {180.0, -180.0},
            ['securitysystem'] = vector3(146.17, -1040.45, 29.83),
        },
        ['computers'] = {
            [1] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(147.14, -1040.78, 29.61),
                    ['radius'] = 0.25,
                }
            },
            [2] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(148.43, -1041.29, 29.6),
                    ['radius'] = 0.25,
                }
            },
            [3] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(149.68, -1041.7, 29.62),
                    ['radius'] = 0.25,
                }
            },
            [4] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(150.99, -1042.23, 29.61),
                    ['radius'] = 0.25,
                }
            },
        },
        ['vaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = "laptop_green",
            ['target'] = {
                ['coords'] = vector3(146.74, -1046.32, 29.59),
                ['radius'] = 0.32
            },
            ['anim'] = vector4(147.45, -1046.85, 30.0, 156.63) -- HER
        },
        ['vaultdoor'] = {
            ['coords'] = vector3(147.79, -1045.33, 29.53),
            ["object"] = `v_ilev_gb_vauldr`,
            ["heading"] = {
                closed = 250.0,
                open = 160.0
            },
        },
        ['insidevaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(148.47, -1046.58, 29.58),
                ['radius'] = 0.36
            }
        },
        ['lockers'] = {
            [1] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(149.9, -1044.71, 29.57),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(151.41, -1046.73, 29.62),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [3] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(150.76, -1049.96, 29.57),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [4] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(148.1, -1050.98, 29.62),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [5] = {
                ['busy'] = false,
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(146.6, -1048.47, 29.62),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
        },
        ['trolleys'] = {
            [1] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(147.14, -1049.59, 28.37, 295.85),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                    [2] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddecrypter", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddrill", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [4] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "laptop_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "usb_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 33, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(149.68, -1050.62, 28.37, 20.31),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            }
        },
        ['doorids'] = {
            ['counter'] = "legion-reception",
            ['backdoor'] = "legion-backdoor",
            ['insidevault'] = "legion-gate",
        }
    },
    /*
    
██╗░░██╗░█████╗░░██╗░░░░░░░██╗██╗░█████╗░██╗░░██╗
██║░░██║██╔══██╗░██║░░██╗░░██║██║██╔══██╗██║░██╔╝
███████║███████║░╚██╗████╗██╔╝██║██║░░╚═╝█████═╝░
██╔══██║██╔══██║░░████╔═████║░██║██║░░██╗██╔═██╗░
██║░░██║██║░░██║░░╚██╔╝░╚██╔╝░██║╚█████╔╝██║░╚██╗
╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝
    */
    ['hawick'] = {
        ['powerbox'] = {
            ['cooldown'] = false,
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(-355.8, -50.13, 54.48),
                ['radius'] = 0.5
            },
        },
        ['camera'] = {
            ['hacked'] = false,
            ['coords'] = vector4(-348.99, -53.39, 51.07, 234.76),
            ['rotation'] = {180.0, -180.0},
            ['securitysystem'] = vector3(-354.65, -49.69, 49.49),
        },
        ['computers'] = {
            [1] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-353.71, -50.02, 49.3),
                    ['radius'] = 0.25,
                }
            },
            [2] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-352.39, -50.51, 49.27),
                    ['radius'] = 0.25,
                }
            },
            [3] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-351.12, -50.93, 49.31),
                    ['radius'] = 0.25,
                }
            },
            [4] = {
                ['busy'] = false,
                ['hacked'] = false,
                ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['target'] = {
                    ['coords'] = vector3(-349.8, -51.39, 49.27),
                    ['radius'] = 0.25,
                }
            },
        },
        ['vaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = "laptop_green",
            ['target'] = {
                ['coords'] = vector3(-353.98, -55.49, 49.26),
                ['radius'] = 0.32
            },
            ['anim'] = vector4(-354.75, -55.40, 49.84, 159.44) -- HER
        },
        ['vaultdoor'] = {
            ['coords'] = vector3(-352.86, -54.39, 49.34),
            ["object"] = `v_ilev_gb_vauldr`,
            ["heading"] = {
                closed = 250.0,
                open = 160.0
            },
        },
        ['insidevaultpanel'] = {
            ['busy'] = false,
            ['hackitem'] = {
                    ['item'] = "basicdecrypter",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
            ['target'] = {
                ['coords'] = vector3(-352.27, -55.84, 49.19),
                ['radius'] = 0.36
            }
        },
        ['lockers'] = {
            [1] = {
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['busy'] = false,
                ['target'] = {
                    ['coords'] = vector3(-350.9, -53.83, 49.34),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [2] = {
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['busy'] = false,
                ['target'] = {
                    ['coords'] = vector3(-349.24, -55.81, 49.39),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
            [3] = {
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['busy'] = false,
                ['target'] = {
                    ['coords'] = vector3(-349.85, -59.13, 49.29),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(200,300)
                        }
                    },
                }
            },
            [4] = {
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['busy'] = false,
                ['target'] = {
                    ['coords'] = vector3(-352.64, -60.18, 49.34),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(200,300)
                        }
                    },
                }
            },
            [5] = {
                ['drillitem'] = {
                    ['item'] = "basicdrill",
                    ['shouldremove'] = {
                        ['remove'] = false, -- false = Don't remove item, all the options under don't matter when false
                        ['type'] = "fail", -- Can be "fail", "success" or "both". 
                        ['chance'] = 50, -- Percentage chance it will be removed
                    }
                },
                ['busy'] = false,
                ['target'] = {
                    ['coords'] = vector3(-354.15, -57.68, 49.29),
                    ['radius'] = 0.8
                },
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            },
        },
        ['trolleys'] = {
            [1] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(-353.69, -58.88, 48.04, 296.08),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 9, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(200,300)
                        }
                    },
                    [2] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddecrypter", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "advanceddrill", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [4] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "laptop_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                    [3] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "usb_blue", -- what item to give (only needed if type is item)
                        ['chance'] = 33, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 1, -- Maximum amount to recieve
                    },
                }
            },
            [2] = {
                ['busy'] = false,
                ['type'] = "money",
                ['coords'] = vector4(-350.93, -59.89, 48.04, 23.73),
                ['rewards'] = {
                    [1] = {
                        ['type'] = "item", -- cash or item
                        ['item'] = "markedbills", -- what item to give (only needed if type is item)
                        ['chance'] = 100, -- chance to even get anything
                        ['min'] = 1, -- Minimum amount to recieve
                        ['max'] = 8, -- Maximum amount to recieve
                        ['info'] = {
                            worth = math.random(100,200)
                        }
                    },
                }
            }
        },
        ['doorids'] = {
            ['counter'] = "hawick-reception",
            ['backdoor'] = "hawick-backdoor",
            ['insidevault'] = "hawick-gate",
        }
    }
}

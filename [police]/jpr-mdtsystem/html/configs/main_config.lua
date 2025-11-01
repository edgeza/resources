Config = {}
Config.CoreName = "qb-core"
Config.TitleName = "OneLife Police Department"
Config.Description = "Your best police database ever!"
Config.DiscordWebhook = "https://discord.com/api/webhooks/1350062689032077364/wR059P2xyiMboVppxhKp7EHaSL8fAf6Eay1RTNn4gBTjGv5aKBl9dopehUaTfZuUNmMx"

Config.DefaultKey = "K"
Config.AllowKeyMapping = true
Config.EnableSound = true
Config.UsingEMS = false -- Set true if you are using JPResources EMS MDT System

Config.MenuScript = "qb-menu"
Config.TargetScript = "ox-target"
Config.Currency = "$"
Config.PayFines = { -- https://docs.fivem.net/docs/game-references/blips/
    enable = false,
    targetScript = false,
    interactionText = "Show my fines",
    coords = vector3(243.22, 224.77, 106.29),
    blipInfos = {
        sprite = 276,
        color = 7,
        scale = 0.7,
        name = "Pay fines",
    }
}

Config.ImpoundedData = {
    column = "state",
    value = 2,
}

Config.VehiclePayments = {
    column = "paymentsleft",
    value = 0,
}

Config.Licenses = { -- if you want to add more, dont forget to add them to server_config, FormatUserData() function (if dont know how, dont touch)
    {type = "weapon", label = "Weapon License"},
    {type = "driver", label = "Drivers License"},
    {type = "business", label = "Business License"},
} 

Config.ScreenshotScript = "screenshot-basic"
Config.UploadSystem = {
    UseFiveManageSystem = false, -- recommended option
    FiveManageSystemTokenKey = "", -- your fivemanage TOKEN Key, follow: https://joaos-organization-3.gitbook.io/jpresources-documentation/installation/phone-system/installation-page/qbcore#using-fivemanage
    
    UseFivemerrSystem = true, -- recommended option too
    FivemerrSystemTokenKey = "83e30d58f4349355c3342c481302181e", -- your fivemerr TOKEN Key, follow: https://joaos-organization-3.gitbook.io/jpresources-documentation/installation/phone-system/installation-page/qbcore#using-fivemerr

    UseOtherUploadSystem = false, -- not recommended due to discord rules
    PhotoWebhook = "https://discord.com/api/webhooks/1013060271574622278/-i1aqLpOPUtvF5gLmCY6Exaki1jKSgVZKBP_BaP25QkxSnEPRUSHxklRjK2sUGMUyGMm",
}

Config.DisableDispatchAlertsCommand = "disableDispatch"

Config.DispatchAutoAlerts = {
    officerDown = false,
    fights = false,
    shooting = false,
    carjacking = false,
    car_robbery = false,
}

Config.RandomDispatchDescriptions = {
    ["firearm"] = {
        "Jesus, please help me, they are using guns and shooting many bullets here!!!",
        "There are gunshots, I'm so scared, please send help fast!",
        "I heard several shots outside my window, please do something!",
        "People are firing guns near my house, it's chaos here!",
        "Gunfire everywhere! This place is turning into a warzone!",
        "I'm hiding under my bed, there are so many shots being fired!"
    },
    ["fight"] = {
        "People started fighting here, this city is full of crazy people!",
        "There’s a wild brawl happening right in front of me, someone is gonna get hurt!",
        "Two guys just started throwing punches in the middle of the street!",
        "This fight is getting out of control; it looks really dangerous!",
        "They are wrestling on the ground now, screaming and breaking things!",
        "The situation is tense; punches are flying, and more people are joining the fight!"
    },
    ["carjacking"] = {
        "Oh my God! They're pulling the driver out of the car!",
        "Someone just stole a car at gunpoint! Please send help!",
        "They're smashing the car window and forcing the driver out!",
        "A person just got dragged out of their car and the thief sped off!",
        "I just witnessed a car being hijacked—this is terrifying!",
        "There’s a carjacking happening right in front of me! Call the police fast!"
    },
    ["car_robbery"] = {
        "They're breaking into a car and stealing everything inside!",
        "I just saw someone smashing a car window and grabbing stuff!",
        "A person is rummaging through a car they clearly don’t own!",
        "Someone is stealing valuables from a parked car, this is insane!",
        "They're emptying the car and running away with bags full of stuff!",
        "The thief just broke into the trunk and is stealing everything!"
    },  
    ["officerdown"] = {
        "An officer is down! Please send backup immediately!",
        "I just saw a cop get hurt! They need urgent help!",
        "The officer is lying on the ground, not moving—this is serious!",
        "There was a shootout, and an officer went down! Please hurry!",
        "A police officer has been injured, send medical assistance right now!",
        "The scene is chaotic; the officer is in critical condition!"
    },          
}

Config.BypassDispatchZones = { -- zones that will be ignored to dispatch, ex: hunting place
    {coords = vector3(-1099.69, 4906.36, 215.73), radius = 100},
}

Config.BypassDispatchJobs = {
    "police"
}

Config.DeleteChatMessagesWith7Days = true -- recommended
Config.DeleteMDTLogsWith7Days = true -- recommended

Config.JobsToDisplay = { -- boostrap colors or class name on color
    {
        jobName = "police",
        color = "primary",
        tag = "LSPD",
        receiveDispatchCalls = false,
        canOpenTablet = true,
    },
    {
        jobName = "ambulance",
        color = "danger",
        tag = "LSMD",
        receiveDispatchCalls = false,
        canOpenTablet = false,
    },
}

Config.ResetCamerasHealthCommand = "resetCameras" -- staff only
Config.ResetCamerasAfterMS = 1800000  -- = 30 min
Config.Cameras = {
    {
        name = "pacificbank",
        label = "Pacific Bank",
        cameras = {
            [1] = {
                label = "CAM#1", 
                coords = vector3(241.8, 214.79, 108.29), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 280.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = -1007354661,
            },
            [2] = {
                label = "CAM#2", 
                coords = vector3(255.7, 205.94, 108.29), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 0.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = -1007354661,
            },
            [3] = {
                label = "CAM#3", 
                coords = vector3(260.73, 220.27, 108.28), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 0.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = -1007354661,
            },
            [4] = {
                label = "CAM#4", 
                coords = vector3(269.32, 223.54, 112.28), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 80.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = -1007354661,
            },
            [5] = {
                label = "CAM#5", 
                coords = vector3(258.97, 204.28, 112.29), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = -80.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = -1007354661,
            },
            [6] = {
                label = "CAM#6", 
                coords = vector3(255.2, 205.58, 112.28), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 80.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = -1007354661,
            },
        }
    },
    {
        name = "legionbank",
        label = "Legion Bank",
        cameras = {
            [1] = {
                label = "CAM#1", 
                coords = vector3(153.09, -1042.04, 31.37), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 40.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
        }
    },
    {
        name = "altabank",
        label = "Alta Bank",
        cameras = {
            [1] = {
                label = "CAM#1", 
                coords = vector3(317.59, -280.47, 56.16), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 40.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
        }
    },
    {
        name = "burtonbank",
        label = "Burton Bank",
        cameras = {
            [1] = {
                label = "CAM#1", 
                coords = vector3(-347.53, -51.28, 51.04), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 40.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
        }
    },
    {
        name = "rocksfordbank",
        label = "Rockford Bank",
        cameras = {
            [1] = {
                label = "CAM#1", 
                coords = vector3(-1209.32, -329.19, 39.78), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 100.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
        }
    },
    {
        name = "banhambank",
        label = "Banham Bank",
        cameras = {
            [1] = {
                label = "CAM#1", 
                coords = vector3(-2962.25, 486.62, 17.7), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 150.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
        }
    },
    {
        name = "desertbank",
        label = "Desert Bank",
        cameras = {
            [1] = {
                label = "CAM#1", 
                coords = vector3(1171.36, 2706.92, 40.09), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 250.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
        }
    },
    {
        name = "paletobank",
        label = "Paleto Bank",
        cameras = {
            [1] = {
                label = "CAM#1", 
                coords = vector3(-115.34, 6472.32, 33.63), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 210.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
            [2] = {
                label = "CAM#2", 
                coords = vector3(-107.88, 6462.73, 33.57), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 10.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
            [3] = {
                label = "CAM#3", 
                coords = vector3(-104.05, 6466.82, 33.63), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 70.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
            [4] = {
                label = "CAM#4", 
                coords = vector3(-103.67, 6467.8, 33.63), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 30.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                modelHash = 168901740,
            },
        }
    },
}

Config.Locales = { -- rest of locales on HTML > JS > translate.js file
    ["1"] = "Open MDT System",
    ["2"] = "Unknown",
    ["3"] = "You cant open MDT now (photo mode)",
    ["4"] = "New bill received: ",
    ["5"] = "Unknown, report is still being created",
    ["6"] = "Active",
    ["7"] = "Disabled",
    ["8"] = "Close camera",
    ["9"] = "This camera have some problem",
    ["10"] = "Ahrr, this camera have no connection...",
    ["11"] = "Reset security cameras health",
    ["12"] = "You cant open MDT while using cameras..",
    ["13"] = "Citizen",
    ["14"] = "Vehicle",
    ["15"] = "House",
    ["16"] = "Shooting!",
    ["17"] = "Carjacking!",
    ["18"] = "Fight!",
    ["19"] = "Officer Down!",
    ["20"] = "Officer Requested Help!",
    ["21"] = "Im requesting backup, i need help!",
    ["22"] = "Dispatch alerts disabled with success!",
    ["23"] = "Dispatch alerts enabled with success!",
    ["24"] = "You dont have money to pay it!",
    ["25"] = "Paid with success!",
    ["26"] = "Close menu",
    ["27"] = "Name: ",
    ["28"] = "Identifier: ",
    ["29"] = "Log type: ",
    ["30"] = "Content: ",
}

Config.LogsLocales = {
    ["evidence-added"] = {text = "New evidence added to: ", color = "text-primary"},
    ["evidence-delete"] = {text = "New evidence deleted from: ", color = "text-danger"},
    ["report-new"] = {text = "New report created: ", color = "text-success"},
    ["report-edited"] = {text = "Report edited: ", color = "text-warning"},
    ["report-state"] = {text = "Report state modified (name and state): ", color = "text-primary"},
    ["fine-new"] = {text = "New fine created: ", color = "text-success"},
    ["fine-delete"] = {text = "Fine deleted: ", color = "text-danger"},
    ["fine-sent"] = {text = "Fine sent: ", color = "text-primary"},
    ["profile-changed"] = {text = "Profile modification (type, id): ", color = "text-primary"},
}

Config.RandomNPCs = {
    {
        name = "Antonio Variações",
        image = "https://files.fivemerr.com/images/21db4b20-03a8-41bb-a527-cdb859f63e0b.png",
        age = 25,
        gender = "M",
    },
    {
        name = "Adrewn Cabe",
        image = "https://files.fivemerr.com/images/23d9e895-5f4a-48b4-a468-6585e6217ecf.jpg",
        age = 45,
        gender = "M",
    },

    {
        name = "Harold Joseph",
        image = "https://files.fivemerr.com/images/bd065453-298e-493d-a92a-748980abec45.jpg",
        age = 45,
        gender = "M",
    },

    {
        name = "Molly Schultz",
        image = "https://files.fivemerr.com/images/cc3d009b-19a9-4a43-94ad-aaff9505e205.jpg",
        age = 28,
        gender = "F",
    },

    {
        name = "Eva Dominic",
        image = "https://files.fivemerr.com/images/148f5ca7-f5ea-4fec-ad62-925736afc4ab.jpg",
        age = 40,
        gender = "F",
    },

    {
        name = "Jesco White",
        image = "https://files.fivemerr.com/images/b356adcb-dcb6-4036-8e15-2cf78be1d212.jpg",
        age = 55,
        gender = "M",
    },

    {
        name = "Lamar Davis",
        image = "https://files.fivemerr.com/images/9d294ebe-289f-410b-a231-267608c5b2f2.jpg",
        age = 35,
        gender = "M",
    },
}

Config.ColorNames = {
    [0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steel",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "Hunter Green",
    [145] = "Metallic Purple",
    [146] = "Metaillic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
    [158] = "Unknown",
}

Config.InjuryList = { -- for ems MDT
    {
        name = "head",
        label = "Head",
        image = "./img/injuries/head.png",
        type = "Urgent",
    },
    {
        name = "left_arm",
        label = "Left Arm",
        image = "./img/injuries/left_arm.png",
        type = "Medium",
    },
    {
        name = "right_arm",
        label = "Right Arm",
        image = "./img/injuries/right_arm.png",
        type = "Medium",
    },
    {
        name = "left_hand",
        label = "Left Hand",
        image = "./img/injuries/left_hand.png",
        type = "normal",
    },
    {
        name = "right_hand",
        label = "Right Hand",
        image = "./img/injuries/right_hand.png",
        type = "normal",
    },
    {
        name = "torso",
        label = "Torso",
        image = "./img/injuries/torso.png",
        type = "Normal",
    },
    {
        name = "left_leg",
        label = "Left Leg",
        image = "./img/injuries/left_leg.png",
        type = "Normal",
    },
    {
        name = "right_leg",
        label = "Right Leg",
        image = "./img/injuries/right_leg.png",
        type = "Normal",
    },
    {
        name = "left_foot",
        label = "Left Foot",
        image = "./img/injuries/left_foot.png",
        type = "Normal",
    },
    {
        name = "right_foot",
        label = "Right Foot",
        image = "./img/injuries/right_foot.png",
        type = "Normal",
    },
}
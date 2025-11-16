Config = {}

Config.PoliceOpen = false -- Can Police open all stashes

Config.Stashes = {
    -- ["geminimansion"] = {
    --     stashName = "geminimansion",
    --     coords = vector3(-1730.5, 358.6, 88.73), 
    --     requirecid = true,
    --     jobrequired = false,
    --     gangrequired = false,
    --     gang = "",
    --     job = "",
    --     cid = {"MAH44286"},  
    --     stashSize = 1250000,
    --     stashSlots = 125, 
    -- },

    ["palmcoast_stash1"] = {
        stashName = "Perfomance Supplies",
        coords = vec3(-2054.57, -514.67, 12.1), 
        requirecid = false,
        jobrequired = true,
        gangrequired = false,
        gang = "",
        job = "palmcoast",
        -- cid = {"MAH44286"},  
        stashSize = 10000000,
        stashSlots = 60, 
    },
    ["palmcoast_stash2"] = {
        stashName = "Service Supplies",
        coords = vec3(-2076.12, -516.6, 12.1), 
        requirecid = false,
        jobrequired = true,
        gangrequired = false,
        gang = "",
        job = "palmcoast",
        -- cid = {"MAH44286"},  
        stashSize = 10000000,
        stashSlots = 60, 
    },
    ["aod_stash"] = {
        stashName = "Boss Stash",
        coords = vector3(267.31, 6617.6, 33.19), 
        requirecid = false,
        jobrequired = true,
        gangrequired = false,
        gang = "",
        job = "aod",
        grade = "4",
        -- cid = {"MAH44286"},  
        stashSize = 5000000,
        stashSlots = 50, 
    },
    ["aod_food_stash"] = {
        stashName = "Food Stash",
        coords = vector3(263.74, 6668.88, 29.96), 
        requirecid = false,
        jobrequired = true,
        gangrequired = false,
        gang = "",
        job = "aod",
        grade = "0",
        -- cid = {"MAH44286"},  
        stashSize = 5000000,
        stashSlots = 50, 
    },
    ["farm_stash1"] = {
        stashName = "Farm Stash 1",
        coords = vector3(427.31, 6458.38, 29.83), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "ZTN51594", -- Sakkie
            "NUQ17904", -- John
        },  
        stashSize = 10000000,
        stashSlots = 50, 
    },
    ["farm_stash2"] = {
        stashName = "Farm Stash 2",
        coords = vector3(437.37, 6463.2, 29.83), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "ZTN51594", -- Sakkie
            "NUQ17904", -- John
        },  
        stashSize = 10000000,
        stashSlots = 50, 
    },
    ["farm_stash3"] = {
        stashName = "Farm Stash 3",
        coords = vector3(414.62, 6470.46, 29.83), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "ZTN51594", -- Sakkie
            "NUQ17904", -- John
        },  
        stashSize = 10000000,
        stashSlots = 50, 
    },
    ["farm_stash4"] = {
        stashName = "Farm Stash 4",
        coords = vector3(418.83, 6452.94, 29.83), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "ZTN51594", -- Sakkie
            "NUQ17904", -- John
        },  
        stashSize = 10000000,
        stashSlots = 50, 
    },
    ["joe_dericks_patreon_stash"] = {
        stashName = "Main Stash",
        coords = vector3(-847.97, -21.99, 44.15), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "DNU96463", -- Joe
            "LDX65341",
        },  
        stashSize = 10000000,
        stashSlots = 50, 
    },
    ["eragon_pleysier_patreon_stash"] = {
        stashName = "Main Stash",
        coords = vector3(-532.54, -886.51, 25.19), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "QZA80609", -- Eragon
        },  
        stashSize = 10000000,
        stashSlots = 50, 
    },
    ["rjs_winchester_patreon_stash"] = { --- Tier 1 ----
        stashName = "Patreon Stash RJS Winchester",
        coords = vec3(59.76, 6500.81, 31.69), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "JAM24160", -- RJS Winchester
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },
    ["mason_claw_patreon_stash"] = { --- Tier 1 ----
        stashName = "Patreon Stash Mason Claw",
        coords = vector3(3426.21, 5174.69, 7.38), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "MTE49944", -- Mason Claw
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },
    ["feroz_mitoune_patreon_stash"] = { --- Tier 1 ----
        stashName = "Patreon Stash Feroz Mitoune",
        coords = vector3(3333.76, 5173.54, 18.34), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "XFF48101", -- Feroz Mitoune
        },
        stashSize = 50000000,
        stashSlots = 150, 
    }, 
    ["juan_sanchez_patreon_stash"] = { --- Tier 1 ----
        stashName = "Patreon Stash Juan Sanchez",
        coords = vector3(-18.5, -1016.34, 28.92), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "NST61835", -- Juan Sanchez
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },       
    ["bellamy_blake"] = { --- Tier 1 ----
        stashName = "Bellamy Blake Patreon Stash",
        coords = vector3(-28.64, 6664.74, 30.73), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "KAQ72612", -- Bellamy Blake
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },
    ["alex_jay_patreon_stash"] = {
        stashName = "Main Stash",
        coords = vector3(-696.18, 632.85, 159.19), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "RHG68672", -- Alex
            "LDX65341",
        },  
        stashSize = 10000000,
        stashSlots = 50, 
    },
    ["bruce_wayne_patreon_stash"] = {
        stashName = "Main Stash",
        coords = vector3(-40.39, -1751.67, 29.42), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "LDX65341",
            "PDD93552", --Bruce Wayne
        },  
        stashSize = 10000000,
        stashSlots = 50, 
    },
         ["sous_niekerk_patreon_stash"] = { --- Tier 3 ----
        stashName = "Patreon Stash Sous Niekerk",
        coords = vector3(82.93, -854.77, 30.77), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "HFS09201", -- Sous Niekerk
        },
        stashSize = 50000000,
        stashSlots = 500, 
    },
    ["pap_stash"] = {
        stashName = "Pap's Main Stash",
        coords = vector3(447.35, -984.44, 34.24), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "CYW76741", -- Test
            "LDX65341", -- Test
        },
        stashSize = 30000000,
        stashSlots = 1000, 
    },
    ["pap_stash_chief"] = {
        stashName = "HC Evidence",
        coords = vec3(834.36, -1302.79, 19.85), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "CYW76741", -- Pap
            "NSA85830", -- Jo Anne
            "LZJ64461", -- Marlien
        },
        stashSize = 30000000,
        stashSlots = 1000, 
    },
    ["pap_stash_chief2"] = {
        stashName = "HC Evidence 2",
        coords = vec3(828.54, -1303.35, 19.85), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "CYW76741", -- Pap
            "NSA85830", -- Jo Anne
            "LZJ64461", -- Marlien
        },
        stashSize = 30000000,
        stashSlots = 1000, 
    },
    ["pap_stash_chief3"] = {
        stashName = "HC Evidence 3",
        coords = vec3(827.02, -1301.25, 19.85), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "CYW76741", -- Pap
            "NSA85830", -- Jo Anne
            "LZJ64461", -- Marlien
        },
        stashSize = 30000000,
        stashSlots = 1000, 
    },
    ["pd_legal_weapons"] = {
        stashName = "Legal Weapons",
        coords = vec3(828.88, -1301.54, 28.24), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "CYW76741", -- Pap
            "ZOY50735", -- Clive
            "QIU05074", -- Koos
            "EIO37824", -- Dexter
            "NSA85830", -- Jo Anne
            "LZJ64461", -- Marlien
        },
        stashSize = 3000000,
        stashSlots = 200, 
    },
    ["evidence_stash"] = {
        stashName = "Evidence",
        coords = vec4(831.74, -1304.12, 19.85, 1.7),
        requirecid = false,
        jobrequired = true,
        gangrequired = false,
        gang = "",
        job = "police",
        grade = "", 
        stashSize = 100000000,
        stashSlots = 500, 
    },
    ["catcafe_extra"] = {
        stashName = "CatCafe Extra",
        coords = vector3(-585.98, -1056.66, 22.34), 
        requirecid = false,
        jobrequired = true,
        gangrequired = false,
        gang = "",
        job = "catcafe",
        grade = "", 
        stashSize = 100000000,
        stashSlots = 100, 
    },
    ["ems_stash"] = {
        stashName = "EMS Food Stash",
        coords = vector3(297.58, -592.59, 43.27), 
        requirecid = false,
        jobrequired = true,
        gangrequired = false,
        gang = "",
        job = "ambulance",
        grade = "", 
        stashSize = 1000000,
        stashSlots = 50, 
    },
    ["beanmahine_extra"] = {
        stashName = "Bean Machine Extra",
        coords = vector3(126.15, -1035.52, 29.28), 
        requirecid = false,
        jobrequired = true,
        gangrequired = false,
        gang = "",
        job = "beanmachine",
        grade = "", 
        stashSize = 100000000,
        stashSlots = 100, 
    },

    ---- NEW PATREON STASHES -----
    --- TIER 1
    ["patreon-tristan-botha"] = { --- Tier 1 ----
        stashName = "Patreon Stash Tristan Botha",
        coords = vector3(-184.74, -2509.34, 9.14), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "PWH37350", -- Tristan Botha
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-christiaan-rodregues"] = { --- Tier 1 ----
        stashName = "Patreon Stash Christiaan Rodregues",
        coords = vector3(8.49, -243.12, 47.66), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "SSP81159", -- christiaan-rodregues
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-clive-brooks"] = { --- Tier 1 ----
        stashName = "Patreon Stash Clive Brooks",
        coords = vector3(-1095.47, 353.92, 68.51), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "ZOY50735", -- Clive Brooks
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-koos-kruger"] = { --- Tier 1 ----
        stashName = "Patreon Stash Koos Kruger",
        coords = vector3(-950.6, -3057.14, 13.95), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "QIU05074", -- Koos Kruger
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-jackson-whittemore"] = { --- Tier 1 ----
        stashName = "Patreon Stash Jackson Whittemore",
        coords = vector3(1259.36, -1563.39, 54.55), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "OXQ03249", -- Jackson Whittemore
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-mike-oxmall"] = { --- Tier 1 ----
        stashName = "Patreon Stash Mike Oxmall",
        coords = vector3(-70.7, 359.58, 112.55), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "WOK77155", -- Mike Oxmall
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-zander-smit"] = { --- Tier 1 ----
        stashName = "Patreon Stash Zander Smit",
        coords = vector3(901.23, -1922.07, 30.64), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "ERI61571", -- Zander Smit
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-jan-vandermerwe"] = { --- Tier 1 ----
        stashName = "Patreon Stash Jan Vandermerwe",
        coords = vector3(-700.54, -1143.37, 10.81), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "EFX70410", -- Jan Vandermerwe
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-kai-blake"] = { --- Tier 1 ----
        stashName = "Patreon Stash Kai Blake",
        coords = vector3(495.54, -1340.83, 29.31), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "XQQ93862", -- Kai Blake
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-zenin-black"] = { --- Tier 1 ----
        stashName = "Patreon Stash Zenin Black",
        coords = vector3(2545.33, 2591.71, 37.96), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "JEA38734", -- Zenin Black
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-erwee-pretorius"] = { --- Tier 1 ----
        stashName = "Patreon Stash Erwee Pretorius",
        coords = vector3(83.49, -1973.78, 20.93), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "UPA36029", -- Erwee Pretorius
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-tobey-stoner"] = { --- Tier 1 ----
        stashName = "Patreon Stash Tobey Stoner",
        coords = vector3(-1137.69, -1625.05, 4.41), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "GYP92916", -- Tobey Stoner
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-xander-delport"] = { --- Tier 1 ----
        stashName = "Patreon Stash Xander Delport",
        coords = vector3(736.17, -1322.42, 26.31), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "BEW07543", -- Xander Delport
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-lexi-carter"] = { --- Tier 1 ----
        stashName = "Patreon Stash Lexi Carter",
        coords = vector3(471.52, -575.81, 28.5), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "GGI07657", -- Lexi Carter
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-jack-larkin"] = { --- Tier 1 ----
        stashName = "Patreon Stash Jack Larkin",
        coords = vector3(480.53, -1058.8, 29.21), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "YMU73990", -- Jack Larkin
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-cassidy-evans"] = { --- Tier 1 ----
        stashName = "Patreon Stash Cassidy Evans",
        coords = vector3(906.76, -1932.58, 30.62), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "OZF99240", -- Cassidy Evans
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-ricardo-sharkas"] = { --- Tier 1 ----
        stashName = "Patreon Stash Ricardo Sharkas",
        coords = vector3(907.28, -1691.83, 43.11), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "OFW86083", -- Ricardo Sharkas
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-felix-schaefchen"] = { --- Tier 1 ----
        stashName = "Patreon Stash Felix Schaefchen",
        coords = vector3(-206.54, -1341.66, 34.89), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "JOL81421", -- Felix Schaefchen
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-christo-smart"] = { --- Tier 1 ----
        stashName = "Patreon Stash Christo Smart",
        coords = vector3(-967.0, -2005.63, 13.19), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "IRT81371", -- Christo Smart
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-louis-van-zyl"] = { --- Tier 1 ----
        stashName = "Patreon Stash Louis Van Zyl",
        coords = vector3(155.37, -3164.76, 7.03),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "IQW61729", -- Louis Van Zyl
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-tom-shelby"] = { --- Tier 1 ----
        stashName = "Patreon Stash Tom Shelby",
        coords = vector3(-26.34, 6461.57, 31.45),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "WAA34440", -- Tom Shelby
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-dinkie-jones"] = { --- Tier 1 ----
        stashName = "Patreon Stash Dinkie Jones",
        coords = vector3(-689.81, -2506.14, 13.94),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "GHT45244", -- Dinkie Jones
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-marvin-armstrong"] = { --- Tier 1 ----
        stashName = "Patreon Stash Marvin Armstrong",
        coords = vector3(-214.66, -1366.35, 31.26),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "MSG29508", -- Marvin Armstrong
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-luke-brits"] = { --- Tier 1 ----
        stashName = "Patreon Stash Luke Brits",
        coords = vector3(1982.9, 3026.33, 47.91),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "JAV40538", -- Luke Brits
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-keagan-van-zyl"] = { --- Tier 1 ----
        stashName = "Patreon Stash Keagan van Zyl",
        coords = vector3(820.65, -2114.65, 29.38),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "FHI35254", -- Keagan van Zyl
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-clark-jvr"] = { --- Tier 1 ----
        stashName = "Patreon Stash Clark JVR",
        coords = vector3(-1594.90, -1009.58, 13.02),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "BGX77958", -- Clark JV
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    ["patreon-corne-vanzyl"] = { --- Tier 1 ----
        stashName = "Patreon Stash Corne VanZyl",
        coords = vector3(51.41, 6485.85, 31.43),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "TVL95771", -- Corne VanZyl
        },
        stashSize = 50000000,
        stashSlots = 150, 
    },

    --- TIER 2
    --- 
    ["patreon-jan-walters"] = { --- Tier 2 ----
        stashName = "Patreon Stash Jan Walters",
        coords = vector3(-1166.78, -2020.13, 13.16),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "ZVS14974", -- Jan Walters
        },
        stashSize = 100000000,
        stashSlots = 300, 
    },
    ["patreon-dean-winchester"] = { --- Tier 2 ----
        stashName = "Patreon Stash Dean Winchester",
        coords = vector3(7.8, 6469.53, 31.43),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "YLJ04801", -- Dean Winchester
        },
        stashSize = 100000000,
        stashSlots = 300, 
    },    
    ["patreon-dario-bico"] = { --- Tier 2 ----
        stashName = "Patreon Stash Dario Bico",
        coords = vector3(-67.31, -1199.68, 27.79),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "HMC41002", -- Dario Bico
        },
        stashSize = 100000000,
        stashSlots = 300, 
    },
    
    ["patreon-luna-pierce"] = { --- Tier 2 ----
        stashName = "Patreon Stash Luna Pierce",
        coords = vector3(-1306.27, -801.8, 17.57),
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "LSN04148", -- Luna Pierce
        },
        stashSize = 100000000,
        stashSlots = 300, 
    },

    --- TIER 3
    --- 
    ["patreon-allan-buckenham"] = { --- Tier 3 ----
        stashName = "Patreon Stash Buckenham",
        coords = vector3(-580.53, -1589.57, 26.75), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "QJP94363",
            "GII30391"
        },
        stashSize = 400000000,
        stashSlots = 500, 
    },

    ["patreon-jacques-smit"] = { --- Tier 3 ----
        stashName = "Patreon Stash Jacques Smit",
        coords = vector3(2040.87, 3379.38, 46.8), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "KSH50974", -- Jacques Smit
        },
        stashSize = 200000000,
        stashSlots = 500, 
    },

    ["patreon-frikkie-van-tonder"] = { --- Tier 3 ----
        stashName = "Patreon Stash Frikkie van Tonder",
        coords = vector3(516.12, -476.4, 24.76), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "FAN04528", -- Frikkie van Tonder
        },
        stashSize = 200000000,
        stashSlots = 500, 
    },

    ["patreon-tiana-lorrie"] = { --- Tier 3 ----
        stashName = "Patreon Stash Tiana Lorrie",
        coords = vector3(1162.84, -2995.06, 5.9), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "ADJ27872", -- Tiana Lorrie
        },
        stashSize = 200000000,
        stashSlots = 500, 
    },

    ["patreon-joshua-blake"] = { --- Tier 3 ----
        stashName = "Patreon Stash Joshua Blake",
        coords = vector3(-449.7, -2176.05, 11.47), 
        requirecid = true,
        jobrequired = false,
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "BRL06048", -- Joshua Blake
        },
        stashSize = 200000000,
        stashSlots = 500, 
    },
    ["patreon-ronald-white"] = { --- Tier 3 ----
        stashName = "Patreon Stash Ronald White",
        coords = vector3(-434.87, 1090.01, 332.54), 
        requirecid = true,
        jobrequired = false, 
        gangrequired = false,
        gang = "",
        job = "",
        grade = "",
        cid = {
            "BRE01557", -- Ronald White
        },
        stashSize = 200000000,
        stashSlots = 500, 
    },

    
}
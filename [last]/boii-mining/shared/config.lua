----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

Config = {}

Config.Debug = false -- enable debug messages

-- QBCore settings
Config.CoreSettings = {
    Core = 'qbx_core', -- The name of your core. Default; QBCore
    CoreFolder = 'qbx_core', -- The name of your core folder. Default; qb-core
    TargetName = 'ox_target', -- The name of your third eye targeting. Default; qb-target
    MenuName = 'qb-menu', -- The name of your menu. Default; qb-menu
    InputName = 'ox_lib', -- The name of your input menu for billing. Default; qb-input
}

-- MLO Settings
Config.MLO = {
    k4mb1_cave = true, -- Toggle use of k4mb1 mining cave mlo
}

-- XP settings
Config.XP = {
    Use = true, -- Toggles xp system on or off; true = on, false = off
    Command = true, -- Toggles xp command on or off; true = on, false = off
    MetaDataName = 'miningxp', -- The name of your xp if you edit this make sure to also edit the line included in readme this is also your /miningxp command
    Thresholds = { -- XP required to unlock tiers
        Quarry = 5000, -- Minimum XP required to drill at the quarry
        Cave = 16000 -- Minimum XP required to drill in the cave
    },
    Levels = { -- Change your xp requirements here to suit your server set these as high as you want preset xp increase = (xp / 0.8)
        4000,  -- level 2 
        6000,  -- level 3 
        8000,  -- level 4
        10000, -- level 5
        12000, -- level 6 
        14000, -- level 7
        16000, -- level 8
        23000, -- level 9
        30000, -- level 10
    }
}

-- Blip settings
Config.Blips = {
    {title = 'Quarry', colour = 5, id = 365, coords = vector3(2952.93, 2789.36, 41.48), scale = 0.7, useblip = true},
    {title = 'Mineshaft', colour = 5, id = 365, coords = vector3(-599.64, 2092.27, 131.4), scale = 0.7, useblip = true},
    {title = 'Foundry', colour = 47, id = 648, coords = vector3(2920.56, 2653.48, 43.18), scale = 0.7, useblip = true},
    {title = 'Foundry', colour = 47, id = 648, coords = vector3(1109.53, -2008.29, 31.05), scale = 0.7, useblip = true},
    {title = 'Builders Warehouse', colour = 5, id = 473, coords = vector3(1192.2, -1261.27, 35.18), scale = 0.6, useblip = true},
    {title = 'Jeweller', colour = 5, id = 617, coords = vector3(-458.67, -67.38, 41.29), scale = 0.6, useblip = true}
    ,{title = 'Gem Cutting', colour = 46, id = 617, coords = vector3(1077.67, -1987.68, 31.05), scale = 0.6, useblip = true}
}

-- Ped settings
Config.Peds = {
    {name = 'quarry_ped', coords = vector4(2944.44, 2742.84, 43.37, 10.35), model = 'csb_cletus', scenario = 'WORLD_HUMAN_CLIPBOARD', label = 'Speak to Quarry Worker', icon = 'fa-solid fa-gem', event = 'boii-mining:cl:QuarryMenu', distance = 2.0, useped = true},
    {name = 'mineshaft_ped', coords = vector4(-599.64, 2092.27, 131.4, 343.67), model = 'csb_cletus', scenario = 'WORLD_HUMAN_CLIPBOARD', label = 'Speak to Mineshaft Worker', icon = 'fa-solid fa-gem', event = 'boii-mining:cl:MineMenu', distance = 2.0, useped = true},
    {name = 'warehouse_ped', coords = vector4(1192.2, -1261.27, 35.18, 266.65), model = 's_m_y_dockwork_01', scenario = 'WORLD_HUMAN_CLIPBOARD', label = 'Speak to Warehouse Worker', icon = 'fa-solid fa-gem', event = 'boii-mining:cl:WarehouseMenu', distance = 2.0, useped = true},
    {name = 'jeweller_ped', coords = vector4(-458.67, -67.38, 41.29, 221.38), model = 's_f_y_shop_mid', scenario = 'WORLD_HUMAN_CLIPBOARD', label = 'Speak to Jeweller', icon = 'fa-solid fa-gem', event = 'boii-mining:cl:JewelleryMenu', distance = 2.0, useped = true}
    ,{name = 'drillbit_ped', coords = vector4(1076.44, -1992.11, 30.88, 325.0), model = 's_m_m_highsec_01', scenario = 'WORLD_HUMAN_CLIPBOARD', label = 'Buy Drill Bits', icon = 'fa-solid fa-screwdriver-wrench', event = 'boii-mining:cl:DrillbitShop', distance = 2.0, useped = true}
}

-- Paydirt
Config.Paydirt = {
    Dirt = {
        Coords = vector3(2952.93, 2789.36, 41.48), -- Location to spawn dirt piles
        Prop = {model = 'prop_pile_dirt_01', zheight = 1.18, amount = 20}, -- Prop model; -Z height; Amount to spawn
        Time = math.random(5, 8), -- Time in (s) to dig for paydirt
        BreakTool = true, -- Toggle whether tool should break on failure
        Chance = 15, -- Chance to break tool if enabled
        Required = { -- Items required to dig for paydirt
            [1] = {name = 'shovel', label = 'Shovel', price = 120},
            [2] = {name = 'emptysack', label = 'Sack', price = 25}
        },
        Return = {name = 'paydirt', label = 'Paydirt'} -- Item returned
    },
    Panning = {
        Time = math.random(3, 6), -- Time in (s) to pan for paydirt
        Chance = 75, -- Chance to successfully pan
        Required = {name = 'gold_pan', label = 'Gold Pan', price = 120}, -- Item required to pan paydirt
        Return = { -- Retrun items for panning; edit amounts in rewards_sv.lua
            Regular = {
                'aluminum_ore',
                'copper_ore',
                'tin_ore',
                'iron_ore',
                'coal',
                'amethyst',
                'citrine',
                'hematite',
                'kyanite',
                'onyx'
            },
            High = {
                'cobalt_ore',
                'gold_ore',
                'silver_ore',
                'uncut_diamond',
                'uncut_emerald',
                'uncut_ruby',
                'uncut_sapphire',
                'uncut_tanzanite'
            }
        }
    }
}

-- Quarry settings
Config.Quarry = {
    Mining = {
        Prop = {model = 'prop_target_oran_cross', amount = 7}, 
        Locations = {
            vector4(2944.03, 2849.68, 48.82, 28.68),
            vector4(2950.25, 2853.54, 49.3, 14.53),
            vector4(2956.82, 2851.86, 48.14, 344.62),
            vector4(2962.13, 2849.08, 47.49, 327.1),
            vector4(2970.05, 2846.54, 46.86, 332.01),
            vector4(2973.42, 2838.63, 45.9, 287.5),
            vector4(2978.34, 2831.42, 46.5, 292.81),
            vector4(2983.49, 2821.63, 45.69, 298.7),
            vector4(2987.67, 2812.58, 45.05, 274.09),
            vector4(2998.42, 2795.84, 44.96, 281.01),
            vector4(3004.68, 2783.62, 44.66, 296.72),
            vector4(3004.52, 2764.12, 43.59, 251.01),
            vector4(3000.95, 2754.5, 44.14, 238.64),
            vector4(2994.99, 2750.4, 44.06, 172.69),
            vector4(2989.23, 2751.64, 43.78, 152.68),
            vector4(2980.19, 2748.83, 43.43, 217.89),
            vector4(2977.28, 2741.35, 44.64, 237.05),
            vector4(2973.17, 2735.78, 46.42, 213.62),
            vector4(2946.7, 2725.01, 48.08, 140.71),
            vector4(2929.22, 2758.46, 45.16, 153.35),
            vector4(2923.68, 2769.59, 44.89, 125.42),
            vector4(2913.04, 2777.16, 44.87, 149.28),
            vector4(2907.0, 2788.48, 46.41, 88.04),
            vector4(2913.71, 2801.68, 44.49, 68.54),
            vector4(2917.86, 2811.79, 47.53, 55.66)
        },
        Lights = {
            {model = 'prop_worklight_02a', coords = vector4(2948.4, 2845.49, 47.21, 199.06)},
            {model = 'prop_worklight_02a', coords = vector4(2955.35, 2844.95, 46.53, 141.96)},
            {model = 'prop_worklight_02a', coords = vector4(2964.69, 2838.26, 45.01, 128.36)},
            {model = 'prop_worklight_02a', coords = vector4(2972.46, 2826.85, 44.14, 121.8)},
            {model = 'prop_worklight_02a', coords = vector4(2980.79, 2816.84, 44.33, 141.44)},
            {model = 'prop_worklight_02a', coords = vector4(2981.25, 2815.88, 44.28, 76.73)},
            {model = 'prop_worklight_02a', coords = vector4(2991.97, 2799.18, 43.91, 73.87)},
            {model = 'prop_worklight_02a', coords = vector4(2998.92, 2768.38, 42.76, 53.14)},
            {model = 'prop_worklight_02a', coords = vector4(2991.98, 2759.35, 42.68, 29.85)},
            {model = 'prop_worklight_02a', coords = vector4(2975.94, 2758.94, 42.94, 12.66)},
            {model = 'prop_worklight_02a', coords = vector4(2951.2, 2732.61, 44.79, 326.93)},
            {model = 'prop_worklight_02a', coords = vector4(2934.91, 2761.31, 44.73, 294.74)},
            {model = 'prop_worklight_02a', coords = vector4(2921.39, 2779.63, 43.61, 284.09)},
            {model = 'prop_worklight_02a', coords = vector4(2913.75, 2791.48, 44.41, 325.7)}
        }
    },
    Caving = {
        --<!>-- THIS IS ONLY USED IF CONFIG.MLOS.K4MB1_CAVE = TRUE --<!>--
        Prop = {model = 'prop_target_purp_cross', amount = 25}, 
        Locations = {
            vector4(2896.08, 2717.75, 44.76, 117.48),
            vector4(2909.7, 2717.72, 45.06, 304.82),
            vector4(2909.82, 2708.8, 44.23, 157.28),
            vector4(2912.54, 2701.22, 44.9, 78.15),
            vector4(2911.44, 2697.16, 45.43, 96.04),
            vector4(2908.67, 2695.02, 46.97, 93.41),
            vector4(2912.94, 2688.84, 48.06, 164.9),
            vector4(2924.63, 2703.56, 45.89, 315.35),
            vector4(2929.87, 2700.62, 46.57, 299.47),
            vector4(2930.84, 2694.62, 46.1, 255.1),
            vector4(2928.77, 2687.29, 44.58, 104.2),
            vector4(2928.9, 2683.63, 46.01, 209.89),
            vector4(2906.27, 2674.65, 44.74, 356.95),
            vector4(2890.36, 2670.28, 47.39, 110.02),
            vector4(2903.6, 2680.62, 46.95, 273.52),
            vector4(2902.05, 2685.0, 48.01, 344.03),
            vector4(2890.75, 2697.74, 48.1, 303.56),
            vector4(2890.55, 2703.56, 49.94, 337.86),
            vector4(2880.51, 2705.2, 48.74, 8.29),
            vector4(2871.38, 2702.87, 48.89, 47.64),
            vector4(2883.04, 2683.4, 47.56, 185.63),
            vector4(2872.64, 2684.31, 47.24, 153.78),
            vector4(2866.93, 2680.1, 47.55, 263.56),
            vector4(2862.42, 2673.4, 46.72, 207.84),
            vector4(2858.35, 2665.46, 45.33, 216.62),
            vector4(2856.11, 2657.47, 43.87, 226.68),
            vector4(2854.48, 2687.6, 46.78, 18.01),
            vector4(2852.15, 2683.4, 45.25, 95.71),
            vector4(2844.25, 2675.54, 41.49, 64.99),
            vector4(2841.75, 2663.79, 42.74, 101.26),
            vector4(2856.02, 2648.2, 39.42, 310.62),
            vector4(2864.29, 2643.3, 39.11, 313.84),
            vector4(2863.62, 2631.8, 39.31, 214.48),
            vector4(2855.15, 2627.24, 38.3, 174.91),
            vector4(2845.52, 2619.57, 37.08, 207.42),
            vector4(2830.37, 2620.93, 37.51, 96.97),
            vector4(2819.2, 2632.54, 40.82, 180.82),
            vector4(2810.22, 2633.99, 40.89, 154.07),
            vector4(2799.75, 2630.05, 40.89, 181.14),
            vector4(2792.95, 2631.22, 40.01, 97.58),
            vector4(2795.27, 2644.89, 40.94, 45.73),
            vector4(2809.97, 2651.3, 38.01, 352.12),
            vector4(2819.34, 2647.66, 39.62, 351.0),
            vector4(2835.17, 2601.36, 35.35, 214.24),
            vector4(2827.09, 2613.79, 38.46, 39.0),
            vector4(2821.12, 2607.43, 38.1, 61.51),
            vector4(2817.98, 2591.14, 32.79, 123.72),
            vector4(2824.22, 2588.58, 31.04, 246.26)
        },
        Lights = {
            {model = 'prop_worklight_02a', coords = vector4(2948.4, 2845.49, 47.21, 199.06)},
            {model = 'prop_worklight_02a', coords = vector4(2955.35, 2844.95, 46.53, 141.96)},
            {model = 'prop_worklight_02a', coords = vector4(2964.69, 2838.26, 45.01, 128.36)},
            {model = 'prop_worklight_02a', coords = vector4(2972.46, 2826.85, 44.14, 121.8)},
            {model = 'prop_worklight_02a', coords = vector4(2980.79, 2816.84, 44.33, 141.44)},
            {model = 'prop_worklight_02a', coords = vector4(2981.25, 2815.88, 44.28, 76.73)},
            {model = 'prop_worklight_02a', coords = vector4(2991.97, 2799.18, 43.91, 73.87)},
            {model = 'prop_worklight_02a', coords = vector4(2998.92, 2768.38, 42.76, 53.14)},
            {model = 'prop_worklight_02a', coords = vector4(2991.98, 2759.35, 42.68, 29.85)},
            {model = 'prop_worklight_02a', coords = vector4(2975.94, 2758.94, 42.94, 12.66)},
            {model = 'prop_worklight_02a', coords = vector4(2951.2, 2732.61, 44.79, 326.93)},
            {model = 'prop_worklight_02a', coords = vector4(2934.91, 2761.31, 44.73, 294.74)},
            {model = 'prop_worklight_02a', coords = vector4(2921.39, 2779.63, 43.61, 284.09)},
            {model = 'prop_worklight_02a', coords = vector4(2913.75, 2791.48, 44.41, 325.7)}
        },
    },
    Dynamite = {
        Delay = 5, -- Delay timer in (s) for dynamite to explode
        PlayerDamage = true, -- Toggle player damage for dynamite explosions
        Required = {name = 'dynamite', label = 'Dynamite', price = 150} -- Item required to drill rocks
    },
    Drilling = {
        Time = math.random(3, 6), -- Time in (s) to drill rocks
        BreakTool = true, -- Toggle whether tool should break on failure
        Chance = 30, -- Chance to break tool if enabled
        Required = {name = 'jackhammer', label = 'Jackhammer', price = 180}, -- Item required to drill rocks
        Return = { -- Retrun items for drilling; edit amounts in rewards_sv.lua
            Regular = {
                'aluminum_ore',
                'copper_ore',
                'tin_ore',
                'iron_ore',
                'coal',
                'amethyst',
                'citrine',
                'hematite',
                'kyanite',
                'onyx'
            },
            High = {
                'cobalt_ore',
                'gold_ore',
                'silver_ore',
                'uncut_diamond',
                'uncut_emerald',
                'uncut_ruby',
                'uncut_sapphire',
                'uncut_tanzanite'
            }
        }
    }
}

-- Mine settings
Config.Mine = {
    Coords = vector3(-542.48, 1981.84, 127.27), -- Coords of mine shaft used for distance check
    Caving = {
        Prop = {model = 'prop_target_red_cross', amount = 25}, 
        Locations = {
            vector4(-590.22, 2072.81, 131.29, 280.17),
            vector4(-590.69, 2060.82, 130.96, 93.72),
            vector4(-586.33, 2051.3, 130.0, 275.18),
            vector4(-581.39, 2038.96, 128.94, 304.4),
            vector4(-576.67, 2032.19, 128.28, 308.45),
            vector4(-576.65, 2032.2, 128.29, 301.06),
            vector4(-565.37, 2015.44, 127.53, 128.58),
            vector4(-554.12, 1998.87, 127.18, 121.71),
            vector4(-546.46, 1984.31, 127.15, 118.09),
            vector4(-541.68, 1974.77, 127.02, 307.67),
            vector4(-542.19, 1957.95, 126.59, 100.26),
            vector4(-540.86, 1950.33, 126.45, 109.69),
            vector4(-537.07, 1946.29, 125.97, 274.28),
            vector4(-538.36, 1941.38, 125.77, 100.14),
            vector4(-534.09, 1931.36, 124.91, 275.16),
            vector4(-534.1, 1920.51, 124.05, 278.64),
            vector4(-535.25, 1913.91, 123.58, 253.92),
            vector4(-529.7, 1901.85, 122.96, 321.57),
            vector4(-521.36, 1897.83, 122.36, 340.96),
            vector4(-504.81, 1892.01, 121.34, 189.93),
            vector4(-489.28, 1892.94, 120.36, 172.82),
            vector4(-485.32, 1896.07, 119.95, 7.49),
            vector4(-542.93, 1900.83, 123.06, 233.47),
            vector4(-554.9, 1890.32, 123.0, 208.59),
            vector4(-561.3, 1886.59, 123.03, 199.93),
            vector4(-562.84, 1888.89, 123.18, 13.37),
            vector4(-535.76, 1982.62, 127.02, 358.28),
            vector4(-532.15, 1979.25, 127.18, 183.9),
            vector4(-516.39, 1980.21, 126.46, 351.16),
            vector4(-510.29, 1980.35, 126.19, 9.35),
            vector4(-503.96, 1980.75, 126.0, 30.76),
            vector4(-501.08, 1978.44, 126.01, 191.98),
            vector4(-484.19, 1987.62, 124.19, 11.23),
            vector4(-476.39, 1990.14, 123.85, 16.66),
            vector4(-466.8, 1995.07, 123.56, 37.6),
            vector4(-458.94, 1998.36, 123.73, 225.11),
            vector4(-456.87, 2004.59, 123.5, 38.92),
            vector4(-445.46, 2011.98, 123.79, 238.58),
            vector4(-449.81, 2017.8, 123.55, 91.27),
            vector4(-452.45, 2030.39, 123.28, 93.04),
            vector4(-457.19, 2044.38, 122.66, 157.96),
            vector4(-451.48, 2054.09, 122.38, 217.39),
            vector4(-428.5, 2064.83, 120.63, 4.9),
            vector4(-426.67, 2065.48, 120.37, 18.67),
            vector4(-424.3, 2063.12, 120.3, 207.71),
            vector4(-432.89, 2061.06, 121.31, 185.89),
            vector4(-465.16, 2059.57, 121.26, 104.2),
            vector4(-467.17, 2064.02, 120.86, 96.65),
            vector4(-467.35, 2072.47, 120.68, 293.78),
            vector4(-471.93, 2079.44, 120.21, 112.1),
            vector4(-473.13, 2085.72, 120.1, 94.94)
        },
        Lights = {
            {model = 'prop_construcionlamp_01', coords = vector4(-594.0, 2086.29, 131.58, 283.33)},
            {model = 'prop_construcionlamp_01', coords = vector4(-590.8, 2074.27, 131.3, 284.96)},
            {model = 'prop_construcionlamp_01', coords = vector4(-587.77, 2060.85, 130.77, 70.79)},
            {model = 'prop_construcionlamp_01', coords = vector4(-585.96, 2049.07, 129.83, 265.9)},
            {model = 'prop_construcionlamp_01', coords = vector4(-583.95, 2038.81, 129.03, 112.67)},
            {model = 'prop_construcionlamp_01', coords = vector4(-575.87, 2031.02, 128.22, 309.65)},
            {model = 'prop_construcionlamp_01', coords = vector4(-567.44, 2018.12, 127.53, 136.2)},
            {model = 'prop_construcionlamp_01', coords = vector4(-557.48, 2005.16, 127.16, 116.64)},
            {model = 'prop_construcionlamp_01', coords = vector4(-550.64, 1997.98, 127.06, 275.49)},
            {model = 'prop_construcionlamp_01', coords = vector4(-542.96, 1986.23, 127.03, 229.15)},
            {model = 'prop_construcionlamp_01', coords = vector4(-546.12, 1982.98, 127.1, 154.35)},
            {model = 'prop_construcionlamp_01', coords = vector4(-542.61, 1982.46, 127.04, 34.93)},
            {model = 'prop_construcionlamp_01', coords = vector4(-531.62, 1981.83, 126.98, 268.39)},
            {model = 'prop_construcionlamp_01', coords = vector4(-518.18, 1980.39, 126.5, 272.15)},
            {model = 'prop_construcionlamp_01', coords = vector4(-500.75, 1978.9, 125.87, 278.72)},
            {model = 'prop_construcionlamp_01', coords = vector4(-486.45, 1986.76, 124.3, 287.26)},
            {model = 'prop_construcionlamp_01', coords = vector4(-475.71, 1987.91, 123.85, 282.84)},
            {model = 'prop_construcionlamp_01', coords = vector4(-468.21, 1994.17, 123.55, 316.68)},
            {model = 'prop_construcionlamp_01', coords = vector4(-459.56, 1998.02, 123.61, 309.57)},
            {model = 'prop_construcionlamp_01', coords = vector4(-452.76, 2009.73, 123.52, 50.55)},
            {model = 'prop_construcionlamp_01', coords = vector4(-447.0, 2014.17, 123.57, 235.84)},
            {model = 'prop_construcionlamp_01', coords = vector4(-451.4, 2026.23, 123.49, 22.3)},
            {model = 'prop_construcionlamp_01', coords = vector4(-456.25, 2043.26, 122.74, 72.94)},
            {model = 'prop_construcionlamp_01', coords = vector4(-458.51, 2053.24, 122.28, 170.2)},
            {model = 'prop_construcionlamp_01', coords = vector4(-467.95, 2066.39, 120.77, 19.92)},
            {model = 'prop_construcionlamp_01', coords = vector4(-472.23, 2081.05, 120.21, 24.18)},
            {model = 'prop_construcionlamp_01', coords = vector4(-471.45, 2088.89, 120.07, 11.07)},
            {model = 'prop_construcionlamp_01', coords = vector4(-473.44, 2087.66, 120.06, 204.0)},
            {model = 'prop_construcionlamp_01', coords = vector4(-446.18, 2057.29, 121.92, 291.66)},
            {model = 'prop_construcionlamp_01', coords = vector4(-426.09, 2065.47, 120.26, 292.5)},
            {model = 'prop_construcionlamp_01', coords = vector4(-457.25, 2049.89, 122.55, 116.63)},
            {model = 'prop_construcionlamp_01', coords = vector4(-540.7, 1966.36, 126.84, 13.4)},
            {model = 'prop_construcionlamp_01', coords = vector4(-542.29, 1957.21, 126.7, 2.4)},
            {model = 'prop_construcionlamp_01', coords = vector4(-535.79, 1941.96, 125.66, 204.73)},
            {model = 'prop_construcionlamp_01', coords = vector4(-536.54, 1931.16, 124.9, 168.64)},
            {model = 'prop_construcionlamp_01', coords = vector4(-533.87, 1923.65, 124.31, 83.75)},
            {model = 'prop_construcionlamp_01', coords = vector4(-535.65, 1912.53, 123.48, 61.86)},
            {model = 'prop_construcionlamp_01', coords = vector4(-544.57, 1902.81, 123.06, 193.52)},
            {model = 'prop_construcionlamp_01', coords = vector4(-553.81, 1891.28, 123.04, 45.31)},
            {model = 'prop_construcionlamp_01', coords = vector4(-563.05, 1885.87, 123.0, 356.43)},
            {model = 'prop_construcionlamp_01', coords = vector4(-538.04, 1907.51, 123.25, 63.09)},
            {model = 'prop_construcionlamp_01', coords = vector4(-528.87, 1898.53, 122.88, 348.26)},
            {model = 'prop_construcionlamp_01', coords = vector4(-519.62, 1897.19, 122.29, 154.72)},
            {model = 'prop_construcionlamp_01', coords = vector4(-506.34, 1892.21, 121.41, 356.91)},
            {model = 'prop_construcionlamp_01', coords = vector4(-490.5, 1893.17, 120.26, 355.28)},
            {model = 'prop_construcionlamp_01', coords = vector4(-481.53, 1893.91, 119.68, 91.48)},
            {model = 'prop_construcionlamp_01', coords = vector4(-483.5, 1896.13, 119.76, 165.28)},
        },
    },
    Dynamite = {
        Delay = 5, -- Delay timer in (s) for dynamite to explode
        PlayerDamage = true, -- Toggle player damage for dynamite explosions
        Required = {name = 'dynamite', label = 'Dynamite', price = 150} -- Item required to drill rocks
    },
    Drilling = {
        Time = math.random(3, 6), -- Time in (s) to drill rocks
        BreakTool = true, -- Toggle whether tool should break on failure
        Chance = 30, -- Chance to break tool if enabled
        Required = {name = 'jackhammer', label = 'Jackhammer', price = 180}, -- Item required to drill rocks
        Return = { -- Retrun items for drilling; edit amounts in rewards_sv.lua
            Regular = {
                'aluminum_ore',
                'copper_ore',
                'tin_ore',
                'iron_ore',
                'coal',
                'amethyst',
                'citrine',
                'hematite',
                'kyanite',
                'onyx'
            },
            High = {
                'cobalt_ore',
                'gold_ore',
                'silver_ore',
                'diamond_mining',
                'emerald',
                'ruby',
                'sapphire',
                'tanzanite'
            }
        }
    }
}

-- Smelting settings
Config.Smelting = {
    Locations = {
        Foundry = {{name = 'foundry_smelt', coords = vector3(1110.55, -2008.68, 31.75), radius = 1.2, debugPoly = false, useZ = true, distance = 1.5}},
        --<!>-- ONLY USED IF CONFIG.MLO.K4MB1_CAVE = TRUE --<!>--
        KambiCave = {{name = 'k4mb1_smelt', coords = vector3(2920.86, 2653.47, 43.18), radius = 0.8, debugPoly = false, useZ = true, distance = 1.5}}, 
    },
    Time = 1, -- Time in seconds to load furnace
    CanFail = false, -- Toggle whether smelting can fail
    Chance = 0, -- Chance for smelting to fail of CanFail = true
    Ingots = {
        Aluminum = {
            Time = math.random(1, 2), -- Time in seconds to smelt
            Required = {name = 'aluminum_ore', label = 'Aluminum Ore', amount = 10},
            Return = {name = 'aluminum_ingot', label = 'Aluminum Ingot', amount = 2}
        },
        Copper = {
            Time = math.random(1, 2), -- Time in seconds to smelt
            Required = {name = 'copper_ore', label = 'Copper Ore', amount = 10},
            Return = {name = 'copper_ingot', label = 'Copper Ingot', amount = 1}
        },
        Iron = {
            Time = math.random(1, 2), -- Time in seconds to smelt
            Required = {name = 'iron_ore', label = 'Iron Ore', amount = 10},
            Return = {name = 'iron_ingot', label = 'Iron Ingot', amount = 1}
        },
        Tin = {
            Time = math.random(1, 2), -- Time in seconds to smelt
            Required = {name = 'tin_ore', label = 'Tin Ore', amount = 12},
            Return = {name = 'tin_ingot', label = 'Tin Ingot', amount = 2}
        },
        Gold = {
            Time = math.random(3, 4), -- Time in seconds to smelt
            Required = {name = 'gold_ore', label = 'Gold Ore', amount = 13},
            Return = {name = 'gold_ingot', label = 'Gold Ingot', amount = 1}
        },
        Silver = {
            Time = math.random(3, 4), -- Time in seconds to smelt
            Required = {name = 'silver_ore', label = 'Silver Ore', amount = 12},
            Return = {name = 'silver_ingot', label = 'Silver Ingot', amount = 2}
        },
        Cobalt = {
            Time = math.random(3, 4), -- Time in seconds to smelt
            Required = {name = 'cobalt_ore', label = 'Cobalt Ore', amount = 11},
            Return = {name = 'cobalt_ingot', label = 'Cobalt Ingot', amount = 2}
        },
        Bronze = {
            Time = math.random(2, 3), -- Time in seconds to smelt
            Required = {
                [1] = {name = 'copper_ore', label = 'Copper Ore', amount = 13},
                [2] = {name = 'tin_ore', label = 'Tin Ore', amount = 15},
            },
            Return = {name = 'bronze_ingot', label = 'Bronze Ingot', amount = 2}
        },
        Steel = {
            Time = math.random(2, 3), -- Time in seconds to smelt
            Required = {
                [1] = {name = 'coal', label = 'Coal', amount = 10},
                [2] = {name = 'iron_ore', label = 'Iron Ore', amount = 5},
            },
            Return = {name = 'steel_ingot', label = 'Steel Ingot', amount = 2}
        }
    }
}

-- Store settings
Config.Stores = {
    Money = {
        UseItem = false, -- Toggle cash as item; true = Item, false = Type
        Item = 'cash', -- Name of your cash item in your city
        Type = 'cash' -- QB money type for purchasing; 'cash', 'bank', 'crypto' etc...
    },
    Permits = {
        Mining = {name = 'mining_permit', label = 'Mining Permit', price = 480},
        Caving = {name = 'caving_permit', label = 'Caving Permit', price = 600}
    },
    Quarry = {
        Times = {
            Use = false, -- Toggle time locks for store
            Open = 09, -- Store open time
            Close = 21 -- Store close time
        }
    },
    Mine = {
        Times = {
            Use = false, -- Toggle time locks for store
            Open = 09, -- Store open time
            Close = 21 -- Store close time
        }
    }
}

-- Warehouse settings
Config.Warehouse = {
    UseSQL = true, -- Toggle whether items sold can be stored into database to allow players to buy items from warehouse
    Builders = {
        Times = {
            Use = false, -- Toggle time locks for store
            Open = 08, -- Store open time
            Close = 21 -- Store close time
        }
    },
    Jewellers = {
        Times = {
            Use = false, -- Toggle time locks for store
            Open = 08, -- Store open time
            Close = 21 -- Store close time
        }
    },
    Money = {
        Buy = {
            UseItem = false, -- Toggle item as cash system
            Item = {name = 'cash', label = 'Cash'}, -- Item used if UseItem = true
            Type = 'cash',  -- Money type for payments if UseItem = false; 'cash', 'bank', 'crypto'
        },
        Sell = {
            UseItem = false, -- Toggle item as cash system
            Item = {name = 'cash', label = 'cash'}, -- Item used if UseItem = true
            Type = 'cash',  -- Money type for payments if UseItem = false; 'cash', 'bank', 'crypto'
        }
    },
    Items = {
        Ingots = {
            ['aluminum_ingot'] = {
                item = 'aluminum_ingot', -- Item name
                label = 'Aluminum Ingot', -- Item label
                price = 150, -- Sale price for items
                buymultiplier = 1 -- Return price multiplier; price*buymultiplier
            },
            ['copper_ingot'] = {
                item = 'copper_ingot', -- Item name
                label = 'Copper Ingot', -- Item label
                price = 140, -- Sale price for items
                buymultiplier = 1 -- Return price multiplier; price*buymultiplier
            },
            ['iron_ingot'] = {
                item = 'iron_ingot', -- Item name
                label = 'Iron Ingot', -- Item label
                price = 140, -- Sale price for items
                buymultiplier = 1 -- Return price multiplier; price*buymultiplier
            },
            ['tin_ingot'] = {
                item = 'tin_ingot', -- Item name
                label = 'Tin Ingot', -- Item label
                price = 135, -- Sale price for items
                buymultiplier = 1 -- Return price multiplier; price*buymultiplier
            },
            ['bronze_ingot'] = {
                item = 'bronze_ingot', -- Item name
                label = 'Bronze Ingot', -- Item label
                price = 250, -- Sale price for items
                buymultiplier = 1 -- Return price multiplier; price*buymultiplier
            },
            ['steel_ingot'] = {
                item = 'steel_ingot', -- Item name
                label = 'Steel Ingot', -- Item label
                price = 150, -- Sale price for items
                buymultiplier = 1 -- Return price multiplier; price*buymultiplier
            },
            ['cobalt_ingot'] = {
                item = 'cobalt_ingot', -- Item name
                label = 'Cobalt Ingot', -- Item label
                price = 1200, -- Sale price for items
                buymultiplier = 1 -- Return price multiplier; price*buymultiplier
            },
            ['gold_ingot'] = {
                item = 'gold_ingot', -- Item name
                label = 'Gold ingot', -- Item label
                price = 1500, -- Sale price for items
                buymultiplier = 1 -- Return price multiplier; price*buymultiplier
            },
            ['silver_ingot'] = {
                item = 'silver_ingot', -- Item name
                label = 'Silver Ingot', -- Item label
                price = 1000, -- Sale price for items
                buymultiplier = 1 -- Return price multiplier; price*buymultiplier
            }
        },
        Gems = {
            ['amethyst'] = { item = 'amethyst', label = 'Amethyst', price = 35, buymultiplier = 1 },
            ['citrine'] = { item = 'citrine', label = 'Citrine', price = 35, buymultiplier = 1 },
            ['hematite'] = { item = 'hematite', label = 'Hematite', price = 35, buymultiplier = 1 },
            ['kyanite'] = { item = 'kyanite', label = 'Kyanite', price = 40, buymultiplier = 1 },
            ['onyx'] = { item = 'onyx', label = 'Onyx', price = 40, buymultiplier = 1 },
            ['diamond'] = { item = 'diamond_mining', label = 'Diamond', price = 320, buymultiplier = 1 },
            ['emerald'] = { item = 'emerald', label = 'Emerald', price = 650, buymultiplier = 1 },
            ['ruby'] = { item = 'ruby', label = 'Ruby', price = 360, buymultiplier = 1 },
            ['sapphire'] = { item = 'sapphire', label = 'Sapphire', price = 420, buymultiplier = 1 },
            ['tanzanite'] = { item = 'tanzanite', label = 'Tanzanite', price = 300, buymultiplier = 1 },
        },
        Jewellery = nil
        ,Bricks = {
            ['gold_building_brick'] = { item = 'gold_building_brick', label = 'Gold Building Brick', price = 1800, buymultiplier = 1 },
            ['diamond_building_brick'] = { item = 'diamond_building_brick', label = 'Diamond Building Brick', price = 2600, buymultiplier = 1 },
            ['emerald_building_brick'] = { item = 'emerald_building_brick', label = 'Emerald Building Brick', price = 3000, buymultiplier = 1 },
            ['ruby_building_brick'] = { item = 'ruby_building_brick', label = 'Ruby Building Brick', price = 2800, buymultiplier = 1 },
            ['sapphire_building_brick'] = { item = 'sapphire_building_brick', label = 'Sapphire Building Brick', price = 2900, buymultiplier = 1 },
            ['tanzanite_building_brick'] = { item = 'tanzanite_building_brick', label = 'Tanzanite Building Brick', price = 2700, buymultiplier = 1 },
            ['the_prism_brick'] = { item = 'the_prism_brick', label = 'The Prism Brick', price = 12000, buymultiplier = 1 },
        }
        ,Coins = {
            ['gold_coin_mining'] = { item = 'gold_coin_mining', label = 'Gold Coin', price = 3600, buymultiplier = 1 },
            ['diamond_coin'] = { item = 'diamond_coin', label = 'Diamond Coin', price = 5000, buymultiplier = 1 },
            ['emerald_coin'] = { item = 'emerald_coin', label = 'Emerald Coin', price = 5600, buymultiplier = 1 },
            ['ruby_coin'] = { item = 'ruby_coin', label = 'Ruby Coin', price = 5400, buymultiplier = 1 },
            ['sapphire_coin'] = { item = 'sapphire_coin', label = 'Sapphire Coin', price = 5500, buymultiplier = 1 },
            ['tanzanite_coin'] = { item = 'tanzanite_coin', label = 'Tanzanite Coin', price = 5000, buymultiplier = 1 },
            ['multi_coin'] = { item = 'multi_coin', label = 'Multi Gem Coin', price = 12000, buymultiplier = 1 },
        }
        ,Apples = {
            ['gold_apple'] = { item = 'gold_apple', label = 'Gold Apple', price = 5200, buymultiplier = 1 },
            ['diamond_apple'] = { item = 'diamond_apple', label = 'Diamond Apple', price = 7200, buymultiplier = 1 },
            ['emerald_apple'] = { item = 'emerald_apple', label = 'Emerald Apple', price = 7800, buymultiplier = 1 },
            ['ruby_apple'] = { item = 'ruby_apple', label = 'Ruby Apple', price = 7500, buymultiplier = 1 },
            ['sapphire_apple'] = { item = 'sapphire_apple', label = 'Sapphire Apple', price = 7600, buymultiplier = 1 },
            ['tanzanite_apple'] = { item = 'tanzanite_apple', label = 'Tanzanite Apple', price = 7200, buymultiplier = 1 },
            ['jewel_of_eden'] = { item = 'jewel_of_eden', label = 'Jewel of Eden', price = 16000, buymultiplier = 1 },
        }
        ,Skulls = {
            ['gold_skull'] = { item = 'gold_skull', label = 'Gold Skull', price = 7000, buymultiplier = 1 },
            ['diamond_skull'] = { item = 'diamond_skull', label = 'Diamond Skull', price = 9500, buymultiplier = 1 },
            ['emerald_skull'] = { item = 'emerald_skull', label = 'Emerald Skull', price = 10200, buymultiplier = 1 },
            ['ruby_skull'] = { item = 'ruby_skull', label = 'Ruby Skull', price = 9800, buymultiplier = 1 },
            ['sapphire_skull'] = { item = 'sapphire_skull', label = 'Sapphire Skull', price = 9900, buymultiplier = 1 },
            ['tanzanite_skull'] = { item = 'tanzanite_skull', label = 'Tanzanite Skull', price = 9200, buymultiplier = 1 },
            ['the_oracle_of_gems'] = { item = 'the_oracle_of_gems', label = 'The Oracle of Gems', price = 28000, buymultiplier = 1 },
        }
    }
}

-- Jewel cutting bench settings
Config.JewelCutting = {
    Locations = {
        {name = 'jewelcut_bench_1', coords = vector3(1077.37, -1985.08, 31.01), heading = 0.0, radius = 1.2, debugPoly = false, useZ = true, distance = 1.5},
        {name = 'jewelcut_bench_2', coords = vector3(1074.27, -1986.19, 30.92), heading = 45.0, radius = 1.2, debugPoly = false, useZ = true, distance = 1.5},
        {name = 'jewelcut_bench_3', coords = vector3(1073.34, -1988.98, 30.9), heading = 0.0, radius = 1.2, debugPoly = false, useZ = true, distance = 1.5},
    },
    Prop = {model = 'gr_prop_gr_speeddrill_01c'},
    Time = math.random(4, 7) -- Time in (s) to cut/craft at bench
}

-- Additional tools
Config.Tools = {
    DrillBit = {name = 'drillbit', label = 'Drill Bit', price = 150}
}

-- Animation settings
Config.Animations = {
    Paydirt = {
        Dig = {
            Dict = 'anim@amb@drug_field_workers@rake@male_a@base',
            Anim = 'base',
            Flags = 9
        },
        Panning = {
            Dict = 'amb@world_human_bum_wash@male@high@base',
            Anim = 'base',
            Flags = 9
        }
    },
    Dynamite = {
        Place = {
            Dict = 'misstrevor2ig_7',
            Anim = 'plant_bomb',
            Flags = 9
        }
    },
    Drilling = {
        Dict = 'amb@world_human_const_drill@male@drill@base',
        Anim = 'base',
        Flags = 9
    },
    Smelting = {
        Prep = {
            Dict = 'amb@prop_human_parking_meter@female@base', 
                Anim = 'base_female',
                Flags = 9,
        },
        Wait = {
            Dict = 'anim@amb@board_room@supervising@',
            Anim = 'think_01_hi_amy_skater_01',
            Flags = 49
        }
    },
}

-- Crafting (client menus read categories, server validates here)
-- Provide icon either as FontAwesome class (e.g. 'fa-solid fa-gem') or a PNG path relative to boii-mining/html/images/items (e.g. 'items/diamond.png').
Config.Crafting = {
    GemCut = {
        -- Keep gem cutting as before: 2 uncut -> 2 cut
        { reward = { name = 'diamond_mining', amount = 2 }, required = { ['uncut_diamond'] = 2 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'emerald', amount = 2 }, required = { ['uncut_emerald'] = 2 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'ruby', amount = 2 }, required = { ['uncut_ruby'] = 2 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'sapphire', amount = 2 }, required = { ['uncut_sapphire'] = 2 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'tanzanite', amount = 2 }, required = { ['uncut_tanzanite'] = 2 }, icon = 'fa-solid fa-gem' },
    },
    -- New categories
    Apple = {
        { reward = { name = 'gold_apple', amount = 1 }, required = { ['gold_ingot'] = 3 }, icon = 'fa-solid fa-apple-whole' },
        { reward = { name = 'diamond_apple', amount = 1 }, required = { ['gold_apple'] = 3, ['diamond_mining'] = 3 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'ruby_apple', amount = 1 }, required = { ['gold_apple'] = 3, ['ruby'] = 3 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'emerald_apple', amount = 1 }, required = { ['gold_apple'] = 3, ['emerald'] = 3 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'sapphire_apple', amount = 1 }, required = { ['gold_apple'] = 3, ['sapphire'] = 3 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'tanzanite_apple', amount = 1 }, required = { ['gold_apple'] = 3, ['tanzanite'] = 3 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'jewel_of_eden', amount = 1 }, required = { ['gold_apple'] = 3, ['diamond_mining'] = 3, ['emerald'] = 3, ['ruby'] = 3, ['sapphire'] = 3, ['tanzanite'] = 3 }, icon = 'fa-solid fa-apple-whole' },
    },
    Coin = {
        { reward = { name = 'gold_coin_mining', amount = 1 }, required = { ['gold_ingot'] = 2 }, icon = 'fa-solid fa-coins' },
        { reward = { name = 'diamond_coin', amount = 1 }, required = { ['gold_coin_mining'] = 2, ['diamond_mining'] = 2 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'emerald_coin', amount = 1 }, required = { ['gold_coin_mining'] = 2, ['emerald'] = 2 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'ruby_coin', amount = 1 }, required = { ['gold_coin_mining'] = 2, ['ruby'] = 2 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'sapphire_coin', amount = 1 }, required = { ['gold_coin_mining'] = 2, ['sapphire'] = 2 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'tanzanite_coin', amount = 1 }, required = { ['gold_coin_mining'] = 2, ['tanzanite'] = 2 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'multi_coin', amount = 1 }, required = { ['gold_coin_mining'] = 2, ['diamond_mining'] = 2, ['emerald'] = 2, ['ruby'] = 2, ['sapphire'] = 2, ['tanzanite'] = 2 }, icon = 'fa-solid fa-coins' },
    },
    Skull = {
        { reward = { name = 'gold_skull', amount = 1 }, required = { ['gold_ingot'] = 4 }, icon = 'fa-solid fa-skull' },
        { reward = { name = 'diamond_skull', amount = 1 }, required = { ['gold_skull'] = 4, ['diamond_mining'] = 4 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'emerald_skull', amount = 1 }, required = { ['gold_skull'] = 4, ['emerald'] = 4 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'ruby_skull', amount = 1 }, required = { ['gold_skull'] = 4, ['ruby'] = 4 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'sapphire_skull', amount = 1 }, required = { ['gold_skull'] = 4, ['sapphire'] = 4 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'tanzanite_skull', amount = 1 }, required = { ['gold_skull'] = 4, ['tanzanite'] = 4 }, icon = 'fa-solid fa-gem' },
        { reward = { name = 'the_oracle_of_gems', amount = 1 }, required = { ['gold_skull'] = 4, ['diamond_mining'] = 4, ['emerald'] = 4, ['ruby'] = 4, ['sapphire'] = 4, ['tanzanite'] = 4 }, icon = 'fa-solid fa-skull' },
    },
    Bricks = {
        -- Base gold building brick
        { reward = { name = 'gold_building_brick', amount = 1 }, required = { ['gold_ingot'] = 1 }, icon = 'fa-solid fa-cube' },
        -- Gem-infused building bricks (require 1 gold_building_brick + 1 corresponding gem)
        { reward = { name = 'diamond_building_brick', amount = 1 }, required = { ['gold_building_brick'] = 1, ['diamond_mining'] = 1 }, icon = 'fa-solid fa-cube' },
        { reward = { name = 'emerald_building_brick', amount = 1 }, required = { ['gold_building_brick'] = 1, ['emerald'] = 1 }, icon = 'fa-solid fa-cube' },
        { reward = { name = 'ruby_building_brick', amount = 1 }, required = { ['gold_building_brick'] = 1, ['ruby'] = 1 }, icon = 'fa-solid fa-cube' },
        { reward = { name = 'sapphire_building_brick', amount = 1 }, required = { ['gold_building_brick'] = 1, ['sapphire'] = 1 }, icon = 'fa-solid fa-cube' },
        { reward = { name = 'tanzanite_building_brick', amount = 1 }, required = { ['gold_building_brick'] = 1, ['tanzanite'] = 1 }, icon = 'fa-solid fa-cube' },
        -- Ultimate: Holey Brick requires 1 of each gem + 1 gold_building_brick
        { reward = { name = 'the_prism_brick', amount = 1 }, required = { ['gold_building_brick'] = 1, ['diamond_mining'] = 1, ['emerald'] = 1, ['ruby'] = 1, ['sapphire'] = 1, ['tanzanite'] = 1 }, icon = 'fa-solid fa-cubes' },
    },
}
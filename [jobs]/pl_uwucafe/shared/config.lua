
--==============================================--
-- 💬  JOIN OUR DISCORD COMMUNITY               
--                                             
-- 🔧  Script Support                         
-- 🛠️   Devlogs & Sneak Peeks                  
-- 🔔  Updates & Announcements                 
--                                             
-- 🔗  Recommended: https://discord.gg/c6gXmtEf3H  
--==============================================--

Location = {}
Config = {}

Config.Framework = 'autodetect' -- 'autodetect' or "esx" ,"qb", "qbox"'

Config.FrameworkResources = {
    esx = {
        resource = 'es_extended',
        export = 'getSharedObject'
    },
    qb = {
        resource = 'qb-core',
        export = 'GetCoreObject'
    }
}
-- Enable auto SQL install on resource start
Config.AutoInstallSQL = true

Config.Locale = 'en' -- 'en', 'fr', 'de', 'es', 'it', 'pt', 'tr' -- Language
Config.Debug = {
    PolyZone = false, --Shows Red Boxes for Target
    DrawSprite = true, --Show White Circles above the target locations
    Prints = true, --Prints debug messages in console
}
--gabz: https://fivem.gabzv.com/

Config.location = "gabz" --'gabz' -- Location of the shop

Config.TextUI = 'autodetect' --'autodetect' or 'ox_lib', 'qb-core', 'jg-textui', 'lation_ui', 'esx_textui', 'cd_drawtextui', 'brutal_textui'
Config.BossMenu = 'autodetect' --'autodetect' or 'esx_society', 'qb-management', 'qbx_management', 'vms_bossmenu'
Config.Target = 'autodetect' --'autodetect' or 'ox_target', 'qb-target'
Config.Notify = 'autodetect' --'autodetect' or 'ox_lib', 'esx_notify', 'okokNotify','lation_ui', 'wasabi_notify', 'brutal_notify', 'mythic_notify'
Config.Progressbar = 'ox_lib' -- 'qb', 'ox_lib', 'ox_lib_circle', 'lation_ui'
Config.InputDialog = 'ox_lib' -- 'ox_lib', 'lation_ui'
Config.BillingMenu = 'builtin' --'builtin' or 'autodetect' or 'esx_billing','s1n_billing','okokBilling', 'codem-billing','qb-phone'
Config.ContextMenu = 'ox_lib' -- 'ox_lib', 'lation_ui'
Config.Clothing = 'autodetect' --'autodetect' or 'esx_skin', 'illenium-appearance', 'fivem-appearance', 'qb-clothing', 'tgiann-clothing'
Config.Society = {
    enable  = true,
    resourcename = 'autodetect', --'autodetect' or 'esx_addonaccount', 'qb-management', 'qb-banking', 'okokBanking', 'Renewed-Banking'
}

Config.Logging = {
    LogEnable = true, -- It will send logs.
    --'discord' for discord webhook. Edit the Log.lua file to add the webook
    --'fivemanage'
    --'fivemerr'
    LogType = 'discord'
}

Config.CheckVersion = true

local locationBlips = {
    gabz = vector3(-588.8, -1058.26, 22.36),
}

local blipcoords = locationBlips[Config.location]

Config.Blip = {
    BlipName = "Uwu Cafe", -- Blip Name
    Enable = true,
    Coords = blipcoords,
    Options = {
        Sprite = 621,
        Color = 34,
        Scale = 0.8,
        Display = 4
    }
}
-- If you want to change the white marker that appears on item processing edit this
Config.MarkerSettings = {
    type = 21, -- Marker type
    width = 0.3, -- Marker width
    height = 0.3, -- Marker height
    color = { r = 255, g = 255, b = 255, a = 120 }, -- Marker color
    distance = 10, -- Distance to show the marker
    Interact = 1, -- Distance to interact with the marker

}

Config.EnableSocietyPayment = false -- If enable you can pay from society for the fridge items
Config.Jobname = 'catcafe' -- Job Name

Config.StashInventory = {
    --Stash
    StashSlot = 60,
    StashWeight = 80000,
    --Table
    TableSlot = 10,
    TableWeight = 20000,
    --Counter
    CounterSlot = 10,
    CounterWeight = 20000,
    --TrashCan
    TrashCanSlot = 10,
    TrashCanWeight = 20000,
}

Config.MaxStock = 100

Config.IceMachine = {
    ice_itemname = 'cc_icecubes',
    water_itemname = 'cc_waterbottle',
    WaitTime = 560,
    MaxIce = 10
}

Config.MaxBillAmount = 1000
Config.Commission = 5 -- Commission percentage for bill payments
Config.Uniforms = {
    clothes = {
		male = {
			tshirt_1 = 0,  tshirt_2 = 0,
			torso_1 = 0,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 0,   pants_2 = 0,
			shoes_1 = 0,   shoes_2 = 0,
			helmet_1 = 0,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		},
		female = {
			tshirt_1 = 0,  tshirt_2 = 0,
			torso_1 = 0,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 0,   pants_2 = 0,
			shoes_1 = 0,   shoes_2 = 0,
			helmet_1 = 0,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 0,     ears_2 = 0
		}
	},
}

Config.Delivery = {
    Enable = true,
    FuelEnable = true, -- Enable or disable fuel consumption
    Ped = {
        model='s_m_m_trucker_01'
    },
    VehicleSpawn = {
        model='burrito'
    },
    OrderDelay = 60, -- Time in seconds between orders
    MaxOrders = 2, -- Maximum number of active orders
}

Config.SkillCheck = {
    Use = 'ox_lib', -- 'ox_lib' or 'lation_ui'
    Enable = true,
    Difficulty = { 'easy' }, -- For ox_lib: single difficulty or array
    Keys = { 'w', 'a', 's', 'd' }, -- For ox_lib
    Lation = { -- For lation_ui
        Title = 'Crafting',
        Difficulties = { 'easy', 'easy', 'easy', 'easy' },
        Keys = { 'W', 'A', 'S', 'D' }
    }
}

Config.UseDJItems = false -- This is will use Custom DJ items will Props | https://djscollections.com/package/6011288
Config.UseBzzzItems = false --This is will use Bzzz items will Props | https://bzzz.tebex.io/package/6271356
Config.CheckCanCarryItem = false

Config.Shop = {
    Storage = {
		label = "Fridge",
		items = {
            Drinks = {
                { name= "cc_black_tapioca_pearls", label= "Black Tapioca Pearls", price =50, amount = 50},
                { name = "cc_brewed_black_tea", label="Brewed Black Tea", price = 50, amount = 50},
                { name = "cc_mixedberries", label="Mixed Berries",price=50,amount=50},
                { name = "cc_milk", label="Milk", price = 50, amount = 50},
                { name = "cc_sugar", label="Sugar", price = 50, amount = 50},
                { name = "cc_vanilla_icecream", label="Vanilla Icecream", price = 50, amount = 50},
                { name = "cc_chocolate_syrup", label="Chocolate Syrup ", price = 50, amount = 50},
                { name = "cc_strawberries", label="Strawberries", price = 50, amount = 50},
                { name = "cc_ripebanana", label="Ripe Banana", price = 50, amount = 50},
                { name = "cc_yogurtcup", label="Yogurt Cup", price = 50, amount = 50},
                { name = "cc_cuporangejuice", label="Cup of Orange Juice", price = 50, amount = 50},
                { name = "cc_pineapple_chunks", label="Pineapple Chunks", price = 50, amount = 50},
                { name = "cc_mango_chunks", label="Mango Chunks", price = 50, amount = 50},  
                { name = "cc_coconut_milk", label="Coconut Milk", price = 50, amount = 50},
                { name = "cc_emptycup", label="Empty Cup", price = 50, amount = 50},  
                { name = "cc_waterbottle", label="Water Bottle", price = 50, amount = 50},  
            },
            Ramen = {
                {name = "cc_wheat_noodles",label="Wheat Noodles", price = 50, amount = 50},
                { name = "cc_green_onions", label="Green Onions", price = 50, amount = 50},
                { name = "cc_chashu_pork", label="Chashu Pork", price = 50, amount = 50},
                { name = "cc_miso_broth", label="Miso Broth", price = 50, amount = 50},
                { name = "cc_butter", label="Butter", price = 50, amount = 50},
                { name = "cc_spinach", label="Spinach", price = 50, amount = 50},
                { name = "cc_soft_boiled_egg", label="Soft Boiled Egg", price = 50, amount = 50},
            },
            Coffee = {
                { name = "cc_milk",label="Milk", price = 50, amount = 50},
                { name = "cc_sugar", label="Sugar", price = 50, amount = 50},
                { name = "cc_chocolate_syrup", label="Chocolate Syrup", price = 50, amount = 50},
                { name = "cc_cocao_powder", label="Cocoa Powder", price = 50, amount = 50},
            },
            Icecream = {
                { name = 'cc_milk',label="Milk", price = 50, amount = 50},
                { name = "cc_heavy_cream", label="Heavy Cream", price = 50, amount = 50},
                { name = "cc_pure_vanilla", label="Pure Vanilla", price = 50, amount = 50},
                { name = "cc_chocolate_cookies", label="Chocolate Cookies", price = 50, amount = 50},
                { name = "cc_chocolate_chips", label="Chocolate Chips", price = 50, amount = 50},
                { name = "cc_strawberries", label="Strawberries", price = 50, amount = 50},
                { name = "cc_coffee_powder", label="Coffee Powder", price = 50, amount = 50},
            },
            Sandwich = {
                {name = 'cc_bacon_strips',label="Bacon Strips", price = 5, amount = 50},
                {name = 'cc_slices_of_bread',label="Slices of Bread", price = 5, amount = 50},
                {name = 'cc_lettuce',label="Lettuce", price = 5, amount = 50},
                {name = 'cc_butter',label="Butter", price = 5, amount = 50},
                {name = 'cc_turkey_slices',label="Turkey Slices", price = 5, amount = 50},
                {name = 'cc_mozzarella_cheese',label="Mozzarella Cheese", price = 5, amount = 50},
                {name = 'cc_avocado',label="Avocado", price = 5, amount = 50},
                {name = 'cc_cheddar_cheese',label="Cheddar Cheese", price = 5, amount = 50},
            },
        }
	},
}

Config.Emotes = {
    Coffee = {
        prop = `prop_food_bs_juice01`,
        dict = 'mp_ped_interaction',
        anim = 'handshake_guy_a',
        bone = 28422,
        offset = vec3(0.02, 0.0, -0.10),
        rotation = vec3(0.0, 0.0, -0.50)
    },
    Drinks = {
        prop = `prop_food_bs_juice01`,
        dict = 'mp_ped_interaction',
        anim = 'handshake_guy_a',
        bone = 28422,
        offset = vec3(0.02, 0.0, -0.10),
        rotation = vec3(0.0, 0.0, -0.50)
    },
    Milkshakes = {
        prop = `prop_food_bs_juice01`,
        dict = 'mp_ped_interaction',
        anim = 'handshake_guy_a',
        bone = 28422,
        offset = vec3(0.02, 0.0, -0.10),
        rotation = vec3(0.0, 0.0, -0.50)
    },
    Crepes = {
        prop = `prop_food_bs_juice01`,
        dict = 'mp_ped_interaction',
        anim = 'handshake_guy_a',
        bone = 28422,
        offset = vec3(0.02, 0.0, -0.10),
        rotation = vec3(0.0, 0.0, -0.50)
    }
}

Config.DeliveryFood = {
    {
        items = {
            { name = "cc_bubbletea", label = "Bubble Tea", quantity = 1 },
            { name = "cc_fukuoka_hakata_ramen", label = "Fukuoka Hakata Ramen", quantity = 1 },
            { name = "cc_vanilla_icecream", label = "Vanilla Icecream", quantity = 1 }, 
        },
        total = 100
    },
    {
        items = {
            { name = "cc_chocolatemilkshake", label = "Chocolate Milkshake", quantity = 1 },
            { name = "cc_miso_ramen", label = "Miso Ramen", quantity = 1 },
            { name = "cc_chocolate_icecream", label = "Chocolate Icecream", quantity = 1 },
        },
        total = 90
    },
    {
        items = {
            { name = "cc_strawberrysmoothie", label = "Strawberry Smoothie", quantity = 1 },
            { name = "cc_nagoya_taiwan_ramen", label = "Nagoya Taiwan Ramen", quantity = 1 },
            { name = "cc_strawberry_icecream", label = "Strawberry Icecream", quantity = 1 },
        },
        total = 110
    } 
}

Config.Cats = {
    {
        coords = vector3(-585.04, -1066.52, 21.34),
        heading = 269.91,
        model = 'a_c_cat_01',
        stationary = false
    },
    {
        coords = vector3(-577.1, -1065.79, 21.34),
        heading = 5.2,
        model = 'a_c_cat_01',
        stationary = false
    },
    {
        coords = vector3(-582.07, -1056.03, 21.43),
        heading = 15.78,
        model = 'a_c_cat_01',
        stationary = true,
        anim = {
            dict = "creatures@cat@amb@world_cat_sleeping_ground@base",
            name = "base"
        }
    }
}

Config.Toys = {
    plush_01a = 'sum_prop_sum_arcade_plush_01a',
    plush_02a = 'sum_prop_sum_arcade_plush_02a',
    plush_03a = 'sum_prop_sum_arcade_plush_03a',
    plush_04a = 'sum_prop_sum_arcade_plush_04a',
    plush_05a = 'sum_prop_sum_arcade_plush_05a',
    plush_06a = 'sum_prop_sum_arcade_plush_06a',
    plush_07a = 'sum_prop_sum_arcade_plush_07a',
    plush_08a = 'sum_prop_sum_arcade_plush_08a',
}

-- Reward system
Config.RewardItems = { "plush_01a", "plush_02a", "plush_03a", "plush_04a", "plush_05a", "plush_06a", "plush_07a", "plush_08a"}
Config.RewardChance = 40
Config.StressRelief = 15
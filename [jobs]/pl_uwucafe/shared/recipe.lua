local ItemDefinitions = {}

WorkingCoords = {
    gabz = {
        Drinks = vector3(-590.502, -1064.224, 22.344),
        Ramen = vector3(-590.4062, -1056.7002, 22.3562),
        Coffee = vector3(-586.325, -1061.834, 22.344),
        Icecream = vector3(-590.504, -1062.122, 22.356),
        Sandwich = vector3(-590.596, -1060.819, 22.344),
    }
}

ItemDefinitions.original = {
    categories = {
         Drinks = { --Donot Change
            label = "Drinks", --Donot Change
            icon = "fa-solid fa-wine-glass",
            workingcoords = WorkingCoords[Config.location].Drinks, -- Use the working coordinates based on the location
            items = {
                cc_bubbletea = {
                    label = "Bubble Tea",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_black_tapioca_pearls', label = "Black Tapioca Pearls", quantity = 10 },
                        { item = 'cc_brewed_black_tea', label = "Brewed Black Tea", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                        { item = "cc_icecubes",label="Ice Cubes", quantity = 10},
                    },
                },
                cc_chocolatemilkshake = {
                    label = "Chocolate Milkshake",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_vanilla_icecream', label = "Vanilla Icecream", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_chocolate_syrup', label = "Chocolate Syrup", quantity = 10 },
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                        { item = "cc_icecubes",label="Ice Cubes", quantity = 10},
                    },
                },
                cc_strawberrysmoothie = {
                    label = "Strawberry Smoothie",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_strawberries', label = "Strawberries", quantity = 10 },
                        { item = 'cc_ripebanana', label = "Ripe Banana", quantity = 10 },
                        { item = 'cc_yogurtcup', label = "Yogurt Cup", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                        { item = "cc_icecubes",label="Ice Cubes", quantity = 10},
                    },
                },
                cc_berryblastsmoothie = {
                    label = "Berry Blast Smoothie",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_mixedberries', label = "Mixed Berries", quantity = 10 },
                        { item = 'cc_ripebanana', label = "Ripe Banana", quantity = 10 },
                        { item = 'cc_yogurtcup', label = "Yogurt Cup", quantity = 10 },
                        { item = 'cc_cuporangejuice', label = "Cup of Orange Juice", quantity = 10 },
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                        { item = "cc_icecubes",label="Ice Cubes", quantity = 10},
                    },
                },
                cc_tropicalparadisesmoothie = {
                    label = "Tropical Paradise Smoothie",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_pineapple_chunks', label = "Pineapple Chunks", quantity = 10 },
                        { item = 'cc_mango_chunks', label = "Mango Chunks", quantity = 10 },
                        { item = 'cc_ripebanana', label = "Ripe Banana", quantity = 10 },
                        { item = 'cc_coconut_milk', label = "Coconut Milk", quantity = 10 },
                        { item = 'cc_cuporangejuice', label = "Cup of Orange Juice", quantity = 10 },
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                        { item = "cc_icecubes",label="Ice Cubes", quantity = 10},
                    },
                },
            }
        },

        Ramen = { 
            label = "Ramen", 
            icon = "fa-solid fa-utensils",
            workingcoords = WorkingCoords[Config.location].Ramen,
            items = {
                cc_fukuoka_hakata_ramen = {
                    label = "Fukuoka Hakata Ramen",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_wheat_noodles', label = "Wheat Noodles", quantity = 10},
                        {item = 'cc_green_onions', label = "Green Onions", quantity = 10},
                        {item = 'cc_chashu_pork', label = "Chashu Pork", quantity = 10},
                    },
                },
                cc_miso_ramen = {
                    label = "Miso Ramen",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_wheat_noodles', label = "Wheat Noodles", quantity = 10},
                        {item = 'cc_miso_broth', label = "Miso Broth", quantity = 10},
                        {item = 'cc_butter', label = "Butter", quantity = 10},
                    },
                },
                cc_nagoya_taiwan_ramen = {
                    label = "Nagoya Taiwan Ramen",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_wheat_noodles', label = "Wheat Noodles", quantity = 10},
                        {item = 'cc_chashu_pork', label = "Chashu Pork", quantity = 10},
                    },
                },
                cc_osaka_shio_ramen = {
                    label = "Osaka Shio Ramen",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_wheat_noodles', label = "Wheat Noodles", quantity = 10},
                        {item = 'cc_spinach', label = "Spinach", quantity = 10},
                    },
                },
                cc_shoyu_ramen = {
                    label = "Shoyu Ramen",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_wheat_noodles', label = "Wheat Noodles", quantity = 10},
                        {item = 'cc_soft_boiled_egg', label = "Soft Boiled Egg", quantity = 10},
                    },
                },
                cc_tonkotsu_ramen = {
                    label = "Tonkotsu Ramen",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_wheat_noodles', label = "Wheat Noodles", quantity = 10},
                        {item = 'cc_chashu_pork', label = "Chashu Pork", quantity = 10},
                    },
                },
                cc_iekei_ramen = {
                    label = "Iekei Ramen",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_wheat_noodles', label = "Wheat Noodles", quantity = 10},
                        {item = 'cc_spinach', label = "Spinach", quantity = 10},
                    },
                }, 
                cc_black_garlic_ramen = {
                    label = "Black Garlic Ramen",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_wheat_noodles', label = "Wheat Noodles", quantity = 10},
                        {item = 'cc_soft_boiled_egg', label = "Soft Boiled Egg", quantity = 10},
                    },
                },
            }
        },
        Coffee = { 
            label = "Coffee", 
            icon = "fa-solid fa-mug-saucer",
            workingcoords = WorkingCoords[Config.location].Coffee,
            items = {
                cc_espresso = {
                    label = "Espresso",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_sugar', label = "Sugar", quantity = 10},
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                    },
                },
                cc_cappuccino = {
                    label = "Cappuccino",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_espresso', label = "Espresso", quantity = 10},
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_sugar', label = "Sugar", quantity = 10},
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                    },
                },
                cc_latte = {
                    label = "Latte",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_espresso', label = "Espresso", quantity = 10},
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_sugar', label = "Sugar", quantity = 10},
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                    },
                },
                cc_mocha = {
                    label = "Mocha",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_espresso', label = "Espresso", quantity = 10},
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_chocolate_syrup', label = "Chocolate Syrup", quantity = 10},
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                    },
                },
                cc_hotchocolate = {
                    label = "Hot Chocolate",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_cocao_powder', label = "Cocoa Powder", quantity = 10},
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_sugar', label = "Sugar", quantity = 10},
                        { item = 'cc_emptycup',label="Empty Cup", quantity = 10 },
                    },
                },
            },
        },
        Icecream = { 
            label = "Icecream", 
            icon = "fa-solid fa-ice-cream",
            workingcoords = WorkingCoords[Config.location].Icecream,
            items = {
                cc_vanilla_icecream = {
                    label = "Vanilla Icecream",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_heavy_cream', label = "Heavy Cream", quantity = 10},
                        {item = 'cc_pure_vanilla', label = "Pure Vanilla", quantity = 10},
                    },
                },
                cc_chocolate_icecream = {
                    label = "Chocolate Icecream",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_chocolate_cookies', label = "Chocolate Cookies", quantity = 10},
                        {item = 'cc_chocolate_chips', label = "Chocolate Chips", quantity = 10},
                    },
                },
                cc_strawberry_icecream = {
                    label = "Strawberry Icecream",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_heavy_cream', label = "Heavy Cream", quantity = 10},
                        {item = 'cc_strawberries', label = "Strawberries", quantity = 10},
                    },
                },
                cc_mintchoco_icecream = {
                    label = "Mintchoco Icecream",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_heavy_cream', label = "Heavy Cream", quantity = 10},
                        {item = 'cc_pure_vanilla', label = "Pure Vanilla", quantity = 10},
                    },
                },
                cc_coffee_icecream = {
                    label = "Coffee Icecream",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_milk', label = "Milk", quantity = 10},
                        {item = 'cc_heavy_cream', label = "Heavy Cream", quantity = 10},
                        {item = 'cc_coffee_powder', label = "Coffee Powder", quantity = 10},
                    },
                },
            },
        },
        Sandwich = { 
            label = "Sandwich", 
            icon = "fa-solid fa-burger",
            workingcoords = WorkingCoords[Config.location].Sandwich,
            items = {
                cc_classic_blt_sandwich = {
                    label = "Classic Sandwich",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_bacon_strips', label = "Bacon Strips", quantity = 10},
                        {item = 'cc_slices_of_bread', label = "Slices of Bread", quantity = 10},
                        {item = 'cc_lettuce', label = "Lettuce", quantity = 10},
                    },
                },
                cc_cheese_sandwich = {
                    label = "Cheese Sandwich",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_slices_of_bread', label = "Slices of Bread", quantity = 10},
                        {item = 'cc_cheddar_cheese', label = "Cheddar Cheese", quantity = 10},
                        {item = 'cc_butter', label = "Butter", quantity = 10},
                    },
                },
                cc_turkey_sandwich = {
                    label = "Turkey Sandwich",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_turkey_slices', label = "Turkey Slices", quantity = 10},
                        {item = 'cc_slices_of_bread', label = "Slices of Bread", quantity = 10},
                        {item = 'cc_lettuce', label = "Lettuce", quantity = 10},
                        {item = 'cc_bacon_strips', label = "Bacon Strips", quantity = 10},
                    },
                },
                cc_caprese_sandwich = {
                    label = "Caprese Sandwich",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_mozzarella_cheese', label = "Mozzarella Cheese", quantity = 10},
                        {item = 'cc_slices_of_bread', label = "Slices of Bread", quantity = 10},
                        {item = 'cc_lettuce', label = "Lettuce", quantity = 10},
                    },
                },
                cc_avocado_sandwich = {
                    label = "Avocado Sandwich",
                    price = 50, 
                    reward = 10,
                    duration = 10000, 
                    required = {  
                        {item = 'cc_slices_of_bread', label = "Slices of Bread", quantity = 10},
                        {item = 'cc_lettuce', label = "Lettuce", quantity = 10},
                        {item = 'cc_avocado', label = "Avocado", quantity = 10},
                    },
                },
            },
        },
    },
}

ItemDefinitions.dj = {
    categories = {
        Drinks = {
            label = "Drinks",
            icon = "fa-solid fa-wine-glass",
            workingcoords = WorkingCoords[Config.location].Drinks,
            items = {
                djs_bobatea_chai = {
                    label = "Chai Boba Tea",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_brewed_black_tea', label = "Brewed Black Tea", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                        { item = "cc_icecubes", label = "Ice Cubes", quantity = 10 },
                    },
                },
                djs_bobatea_chocolate = {
                    label = "Chocolate Boba Tea",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_chocolate_syrup', label = "Chocolate Syrup", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                        { item = "cc_icecubes", label = "Ice Cubes", quantity = 10 },
                    },
                },
                djs_bobatea_honeydew = {
                    label = "Honeydew Boba Tea",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                        { item = "cc_icecubes", label = "Ice Cubes", quantity = 10 },
                    },
                },
                djs_glass_greentea = {
                    label = "Green Tea",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                djs_glass_icetea = {
                    label = "Iced Tea",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = "cc_icecubes", label = "Ice Cubes", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                djs_soda_green = {
                    label = "Green Soda",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                djs_soda_pink = {
                    label = "Pink Soda",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                djs_soda_yellow = {
                    label = "Yellow Soda",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
            },
        },

        Milkshakes = {
            label = "Milkshakes",
            icon = "fa-solid fa-blender",
            workingcoords = WorkingCoords[Config.location].Drinks,
            items = {
                djs_milkshake_chocolatepretzel = {
                    label = "Chocolate Pretzel Milkshake",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_chocolate_syrup', label = "Chocolate Syrup", quantity = 10 },
                        { item = 'cc_vanilla_icecream', label = "Vanilla Icecream", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                djs_milkshake_cookiemonster = {
                    label = "Cookie Monster Milkshake",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_chocolate_cookies', label = "Chocolate Cookies", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_vanilla_icecream', label = "Vanilla Icecream", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                djs_milkshake_gummybear = {
                    label = "Gummy Bear Milkshake",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_vanilla_icecream', label = "Vanilla Icecream", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                djs_milkshake_strawberryshortcake = {
                    label = "Strawberry Shortcake Milkshake",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_strawberries', label = "Strawberries", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_vanilla_icecream', label = "Vanilla Icecream", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
            },
        },

        Crepes = {
            label = "Crepes",
            icon = "fa-solid fa-pancakes",
            workingcoords = WorkingCoords[Config.location].Sandwich,
            items = {
                djs_kiwicrepe_chocolate = {
                    label = "Kiwi Crepe (Chocolate)",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_chocolate_syrup', label = "Chocolate Syrup", quantity = 10 },
                    },
                },
                djs_kiwicrepe_strawberry = {
                    label = "Kiwi Crepe (Strawberry)",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_strawberries', label = "Strawberries", quantity = 10 },
                    },
                },
                djs_kiwicrepe_vanilla = {
                    label = "Kiwi Crepe (Vanilla)",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_pure_vanilla', label = "Pure Vanilla", quantity = 10 },
                    },
                },
                djs_strawberrycrepe_chocolate = {
                    label = "Strawberry Crepe (Chocolate)",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_strawberries', label = "Strawberries", quantity = 10 },
                        { item = 'cc_chocolate_syrup', label = "Chocolate Syrup", quantity = 10 },
                    },
                },
                djs_strawberrycrepe_strawberry = {
                    label = "Strawberry Crepe",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_strawberries', label = "Strawberries", quantity = 10 },
                    },
                },
                djs_strawberrycrepe_vanilla = {
                    label = "Strawberry Crepe (Vanilla)",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_strawberries', label = "Strawberries", quantity = 10 },
                        { item = 'cc_pure_vanilla', label = "Pure Vanilla", quantity = 10 },
                    },
                },
            },
        },

        Desserts = {
            label = "Desserts",
            icon = "fa-solid fa-cookie-bite",
            workingcoords = WorkingCoords[Config.location].Icecream,
            items = {
                djs_macaron_brown = { label = "Brown Macaron", price = 50, reward = 10, duration = 10000, required = {} },
                djs_macaron_green = { label = "Green Macaron", price = 50, reward = 10, duration = 10000, required = {} },
                djs_macaron_lightbrown = { label = "Light Brown Macaron", price = 50, reward = 10, duration = 10000, required = {} },
                djs_macaron_lightpink = { label = "Light Pink Macaron", price = 50, reward = 10, duration = 10000, required = {} },
                djs_macaron_pink = { label = "Pink Macaron", price = 50, reward = 10, duration = 10000, required = {} },
                djs_macaron_yellow = { label = "Yellow Macaron", price = 50, reward = 10, duration = 10000, required = {} },
                djs_plate_bearwaffles = { label = "Bear Waffles", price = 50, reward = 10, duration = 10000, required = {} },
                djs_plate_pandawaffle = { label = "Panda Waffle", price = 50, reward = 10, duration = 10000, required = {} },
            },
        },

        Meals = {
            label = "Meals",
            icon = "fa-solid fa-bowl-rice",
            workingcoords = WorkingCoords[Config.location].Sandwich,
            items = {
                djs_bowl_beefbibimbap = {
                    label = "Beef Bibimbap",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_spinach', label = "Spinach", quantity = 10 },
                        { item = 'cc_soft_boiled_egg', label = "Soft Boiled Egg", quantity = 10 },
                    },
                },
                djs_bowl_veggiebibimbap = {
                    label = "Veggie Bibimbap",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_spinach', label = "Spinach", quantity = 10 },
                    },
                },
                djs_bentobox_heart = { label = "Heart Bento Box", price = 50, reward = 10, duration = 10000, required = {} },
                djs_bentobox_heart2 = { label = "Heart Bento Box 2", price = 50, reward = 10, duration = 10000, required = {} },
                djs_bentobox_kidsmeal = { label = "Kids Bento Meal", price = 50, reward = 10, duration = 10000, required = {} },
                djs_japanese_omelette = {
                    label = "Japanese Omelette",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_soft_boiled_egg', label = "Soft Boiled Egg", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                    },
                },
            },
        },
    }
}
ItemDefinitions.bzzz = {
    categories = {
        Drinks = {
            label = "Drinks",
            icon = "fa-solid fa-wine-glass",
            workingcoords = WorkingCoords[Config.location].Drinks,
            items = {
                bzzz_uwuprops_cappuccino_a = {
                    label = "Cappuccino UwU",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_espresso', label = "Espresso", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                bzzz_uwuprops_coffee_a = {
                    label = "Coffee UwU",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_espresso', label = "Espresso", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                bzzz_uwuprops_drink_a = {
                    label = "Fizzy Drink A",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_cuporangejuice', label = "Cup of Orange Juice", quantity = 10 },
                        { item = 'cc_icecubes', label = "Ice Cubes", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                bzzz_uwuprops_drink_b = {
                    label = "Fizzy Drink B",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_cuporangejuice', label = "Cup of Orange Juice", quantity = 10 },
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                bzzz_uwuprops_drink_c = {
                    label = "Fizzy Drink C",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_cuporangejuice', label = "Cup of Orange Juice", quantity = 10 },
                        { item = 'cc_icecubes', label = "Ice Cubes", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
                bzzz_uwuprops_drink_d = {
                    label = "Fizzy Drink D",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_cuporangejuice', label = "Cup of Orange Juice", quantity = 10 },
                        { item = 'cc_emptycup', label = "Empty Cup", quantity = 10 },
                    },
                },
            },
        },

        Icecream = {
            label = "Icecream",
            icon = "fa-solid fa-ice-cream",
            workingcoords = WorkingCoords[Config.location].Icecream,
            items = {
                bzzz_uwuprops_icecream_a = {
                    label = "Ice Cream UwU",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_heavy_cream', label = "Heavy Cream", quantity = 10 },
                        { item = 'cc_pure_vanilla', label = "Pure Vanilla", quantity = 10 },
                    },
                },
                bzzz_uwuprops_icecone_a = {
                    label = "Cone A",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_heavy_cream', label = "Heavy Cream", quantity = 10 },
                    },
                },
                bzzz_uwuprops_icecone_b = {
                    label = "Cone B",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_heavy_cream', label = "Heavy Cream", quantity = 10 },
                    },
                },
                bzzz_uwuprops_icecone_c = {
                    label = "Cone C",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_heavy_cream', label = "Heavy Cream", quantity = 10 },
                    },
                },
                bzzz_uwuprops_icecone_d = {
                    label = "Cone D",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                        { item = 'cc_heavy_cream', label = "Heavy Cream", quantity = 10 },
                    },
                },
                bzzz_uwuprops_popsicle_a = {
                    label = "Popsicle UwU",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_strawberries', label = "Strawberries", quantity = 10 },
                        { item = 'cc_cuporangejuice', label = "Cup of Orange Juice", quantity = 10 },
                    },
                },
            },
        },

        Bakery = {
            label = "Bakery",
            icon = "fa-solid fa-bread-slice",
            workingcoords = WorkingCoords[Config.location].Sandwich, -- Reusing a station for simplicity
            items = {
                bzzz_uwuprops_cookie_a = {
                    label = "Cookie UwU",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_chocolate_chips', label = "Chocolate Chips", quantity = 10 },
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                    },
                },
                bzzz_uwuprops_cake_a = {
                    label = "Cake UwU",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                        { item = 'cc_milk', label = "Milk", quantity = 10 },
                    },
                },
                bzzz_uwuprops_wafer_a = {
                    label = "Wafer UwU",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_chocolate_chips', label = "Chocolate Chips", quantity = 10 },
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                    },
                },
                bzzz_uwuprops_lollipop_a = {
                    label = "Lollipop UwU",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'cc_sugar', label = "Sugar", quantity = 10 },
                    },
                },
            },
        },
    },
}


if Config.UseDJItems then
    ItemDefinitions = ItemDefinitions.dj
elseif Config.UseBzzzItems then
    ItemDefinitions = ItemDefinitions.bzzz
else
    ItemDefinitions = ItemDefinitions.original
end

return ItemDefinitions



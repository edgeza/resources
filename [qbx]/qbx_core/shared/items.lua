--[[
    Guide for adding items:

    Note: This file works with ESX. If you're using qb-core, move this file to `qb-core/shared`
    and rename the main function accordingly.

    1. Basic Item Declaration:
       - **name**: Unique ID for the item.
       - **label**: Visible name in the inventory.
       - **weight**: Weight in kg.
       - **type**: Item type (`item` or `weapon`).
       - **image**: Image file name in `html/images/`.
       - **unique**: `true` if the item is not stackable; `false` if it can stack.
       - **useable**: `true` if the item can be used.
       - **shouldClose**: `true` to close the inventory upon use.
       - **description**: Short description of the item.

    2. Consumables:
       - **thirst/hunger**: Affects thirst or hunger status.
       - **usetime**: Usage duration in ms.
       - **anim**: Animation dictionary and clip.
       - **prop**: Item model and coordinates during animation.
       - **disable**: Disables events (movement, combat, etc.).
       - **removeAfterUse**: `true` to delete the item after use.

    3. Decay (Wear and Tear):
       - **decay**: Decay rate; the higher the number, the faster it breaks.
       - **delete**: `true` to remove the item once broken.

    4. Throwable Object:
       - **object**: Throwable model. If not set, defaults to a bag.

    5. Item Rarity:
       - **rare**: Sets item rarity (`common`, `epic`, `legendary`), which changes only the item color in the inventory.

    You can find some default examples, such as in the "tosti" or "water_bottle" item.
]]

ItemList = {

    ['cc_sugar'] = {['name'] = 'cc_sugar', ['label'] = 'Sugar', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_sugar.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_espresso'] = {['name'] = 'cc_espresso', ['label'] = 'Espresso', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_espresso.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_cappuccino'] = {['name'] = 'cc_cappuccino', ['label'] = 'Cappuccino', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_cappuccino.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_milk'] = {['name'] = 'cc_milk', ['label'] = 'Milk', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_milk.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_cocao_powder'] = {['name'] = 'cc_cocao_powder', ['label'] = 'Cocao Powder', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_cocao_powder.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_latte'] = {['name'] = 'cc_latte', ['label'] = 'Latte', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_latte.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_mocha'] = {['name'] = 'cc_mocha', ['label'] = 'Mocha', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_mocha.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_chocolate_syrup'] = {['name'] = 'cc_chocolate_syrup', ['label'] = 'Chocolate Syrup', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_chocolate_syrup.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_hotchocolate'] = {['name'] = 'cc_hotchocolate', ['label'] = 'Hot Chocolate', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_hotchocolate.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_bubbletea'] = {['name'] = 'cc_bubbletea', ['label'] = 'Bubble Tea', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_bubbletea.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_chocolatemilkshake'] = {['name'] = 'cc_chocolatemilkshake', ['label'] = 'Chocolate Milkshake', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_chocolatemilkshake.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_strawberrysmoothie'] = {['name'] = 'cc_strawberrysmoothie', ['label'] = 'Strawberry Smoothie', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_strawberrysmoothie.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_berryblastsmoothie'] = {['name'] = 'cc_berryblastsmoothie', ['label'] = 'Berry Blast Smoothie', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_berryblastsmoothie.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_tropicalparadisesmoothie'] = {['name'] = 'cc_tropicalparadisesmoothie', ['label'] = 'Tropical Paradise Smoothie', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_tropicalparadisesmoothie.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_mixedberries'] = {['name'] = 'cc_mixedberries', ['label'] = 'Cup of Mixed Berries', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_mixedberries.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_yogurtcup'] = {['name'] = 'cc_yogurtcup', ['label'] = 'Yogurt Cup', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_yogurtcup.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_cuporangejuice'] = {['name'] = 'cc_cuporangejuice', ['label'] = 'Yogurt Cup', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cup_orange_juice.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_ripebanana'] = {['name'] = 'cc_ripebanana', ['label'] = 'Ripe Banana', ['weight'] = 10, ['type'] = 'item', ['image'] = 'ripe_banana.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_coconut_milk'] = {['name'] = 'cc_coconut_milk', ['label'] = 'Coconut Milk', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_coconut_milk.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_pineapple_chunks'] = {['name'] = 'cc_pineapple_chunks', ['label'] = 'Pineapple Chunks', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_pineapple_chunks.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_mango_chunks'] = {['name'] = 'cc_mango_chunks', ['label'] = 'Mango Chunks', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_pineapple_chunks.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_black_tapioca_pearls'] = {['name'] = 'cc_black_tapioca_pearls', ['label'] = 'Black Tapioca Pearls', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_black_tapioca_pearls.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_brewed_black_tea'] = {['name'] = 'cc_brewed_black_tea', ['label'] = 'Brewed Black Tea', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_brewed_black_tea.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_vanilla_icecream'] = {['name'] = 'cc_vanilla_icecream', ['label'] = 'Vanilla Icecream', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_vanilla_icecream.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_strawberries'] = {['name'] = 'cc_strawberries', ['label'] = 'Strawberries', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_strawberries.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_fukuoka_hakata_ramen'] = {['name'] = 'cc_fukuoka_hakata_ramen', ['label'] = 'Fukuoka Hakata Ramen', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_fukuoka_hakata_ramen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_miso_ramen'] = {['name'] = 'cc_miso_ramen', ['label'] = 'Miso Ramen', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_miso_ramen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_nagoya_taiwan_ramen'] = {['name'] = 'cc_nagoya_taiwan_ramen', ['label'] = 'Nagoya Taiwan Ramen', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_nagoya_taiwan_ramen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_osaka_shio_ramen'] = {['name'] = 'cc_osaka_shio_ramen', ['label'] = 'Osaka Shio Ramen', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_osaka_shio_ramen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_shoyu_ramen'] = {['name'] = 'cc_shoyu_ramen', ['label'] = 'Shoyu Ramen', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_shoyu_ramen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_tonkotsu_ramen'] = {['name'] = 'cc_tonkotsu_ramen', ['label'] = 'Tonkotsu Ramen', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_tonkotsu_ramen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_iekei_ramen'] = {['name'] = 'cc_iekei_ramen', ['label'] = 'Iekei Ramen', ['weight'] = 10, ['type'] = 'item', ['image'] = 'Iekei_ramen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
    ['cc_black_garlic_ramen'] = { ['name'] = 'cc_black_garlic_ramen', ['label'] = 'Black Garlic Ramen', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_black_garlic_ramen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_wheat_noodles'] = { ['name'] = 'cc_wheat_noodles', ['label'] = 'Wheat Noodles', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_wheat_noodles.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_green_onions'] = { ['name'] = 'green_onions', ['label'] = 'Green Onions', ['weight'] = 10, ['type'] = 'item', ['image'] = 'green_onions.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_chashu_pork'] = { ['name'] = 'cc_chashu_pork', ['label'] = 'Chashu Pork', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_chashu_pork.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_miso_broth'] = { ['name'] = 'cc_miso_broth', ['label'] = 'Miso Broth', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_miso_broth.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_butter'] = { ['name'] = 'cc_butter', ['label'] = 'Butter', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_butter.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_spinach'] = { ['name'] = 'cc_spinach', ['label'] = 'Spinach', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_spinach.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_soft_boiled_egg'] = { ['name'] = 'cc_soft_boiled_egg', ['label'] = 'Soft Boiled Eggs', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_soft_boiled_egg.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_pure_vanilla'] = { ['name'] = 'cc_pure_vanilla', ['label'] = 'Pure Vanilla', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_pure_vanilla.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_heavy_cream'] = { ['name'] = 'cc_heavy_cream', ['label'] = 'Cup of Heavy Cream', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_heavy_cream.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_chocolate_chips'] = { ['name'] = 'cc_chocolate_chips', ['label'] = 'Chocolate Chips', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_chocolate_chips.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_coffee_powder'] = { ['name'] = 'cc_coffee_powder', ['label'] = 'Coffee Powder', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_coffee_powder.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_chocolate_cookies'] = { ['name'] = 'cc_chocolate_cookies', ['label'] = 'Chocolate Cookies', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_chocolate_cookies.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_chocolate_icecream'] = { ['name'] = 'cc_chocolate_icecream', ['label'] = 'Chocolate IceCream', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_chocolate_icecream.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_strawberry_icecream'] = { ['name'] = 'cc_strawberry_icecream', ['label'] = 'Strawberry IceCream', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_strawberry_icecream.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_mintchoco_icecream'] = { ['name'] = 'cc_mintchoco_icecream', ['label'] = 'Mint Chocolate Chip Ice Cream', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_mintchoco_icecream.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_coffee_icecream'] = { ['name'] = 'cc_coffee_icecream', ['label'] = 'Coffee Ice Cream', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_coffee_icecream.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_classic_blt_sandwich'] = { ['name'] = 'cc_classic_blt_sandwich', ['label'] = 'Classic BLT Sandwich', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_classic_blt_sandwich.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_bacon_strips'] = { ['name'] = 'cc_bacon_strips', ['label'] = 'Bacon strips', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_bacon_strips.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_slices_of_bread'] = { ['name'] = 'cc_slices_of_bread', ['label'] = 'Slices of Bread', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_slices_of_bread.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_lettuce'] = { ['name'] = 'cc_lettuce', ['label'] = 'Lettuce', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_lettuce.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_cheese_sandwich'] = { ['name'] = 'cc_cheese_sandwich', ['label'] = 'Cheese Sandwich', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_cheese_sandwich.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_cheddar_cheese'] = { ['name'] = 'cc_cheddar_cheese', ['label'] = 'Cheddar Cheese', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_cheddar_cheese.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_turkey_sandwich'] = { ['name'] = 'cc_turkey_sandwich', ['label'] = 'Turkey Club Sandwich', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_turkey_sandwich.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_turkey_slices'] = { ['name'] = 'cc_turkey_slices', ['label'] = 'Turkey Slices', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_turkey_slices.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_caprese_sandwich'] = { ['name'] = 'cc_caprese_sandwich', ['label'] = 'Caprese Sandwich', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_caprese_sandwich.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_mozzarella_cheese'] = { ['name'] = 'cc_mozzarella_cheese', ['label'] = 'Fresh mozzarella cheese', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_mozzarella_cheese.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_avocado_sandwich'] = { ['name'] = 'cc_avocado_sandwich', ['label'] = 'Chicken Avocado Sandwich', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_avocado_sandwich.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_avocado'] = { ['name'] = 'cc_avocado', ['label'] = 'Avocado', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_avocado.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_icecubes'] = { ['name'] = 'cc_icecubes', ['label'] = 'Ice Cubes', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_icecubes.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_waterbottle'] = { ['name'] = 'cc_waterbottle', ['label'] = 'Water Bottle', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_waterbottle.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['cc_emptycup'] = { ['name'] = 'cc_emptycup', ['label'] = 'Empty Cup', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cc_emptycup.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    --toys
    ['plush_01a'] = {['name'] = 'plush_01a', ['label'] = 'Plush Toy 01', ['weight'] = 100, ['type'] = 'item', ['image'] = 'plush_01a.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true},
    ['plush_02a'] = {['name'] = 'plush_02a', ['label'] = 'Plush Toy 02', ['weight'] = 100, ['type'] = 'item', ['image'] = 'plush_02a.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true},
    ['plush_03a'] = {['name'] = 'plush_03a', ['label'] = 'Plush Toy 03', ['weight'] = 100, ['type'] = 'item', ['image'] = 'plush_03a.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true},
    ['plush_04a'] = {['name'] = 'plush_04a', ['label'] = 'Plush Toy 04', ['weight'] = 100, ['type'] = 'item', ['image'] = 'plush_04a.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true},
    ['plush_05a'] = {['name'] = 'plush_05a', ['label'] = 'Plush Toy 05', ['weight'] = 100, ['type'] = 'item', ['image'] = 'plush_05a.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true},
    ['plush_06a'] = {['name'] = 'plush_06a', ['label'] = 'Plush Toy 06', ['weight'] = 100, ['type'] = 'item', ['image'] = 'plush_06a.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true},
    ['plush_07a'] = {['name'] = 'plush_07a', ['label'] = 'Plush Toy 07', ['weight'] = 100, ['type'] = 'item', ['image'] = 'plush_07a.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true},
    ['plush_08a'] = {['name'] = 'plush_08a', ['label'] = 'Plush Toy 08', ['weight'] = 100, ['type'] = 'item', ['image'] = 'plush_08a.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true},
    
    ['weapon_unarmed']                  = {
        ['name'] = 'weapon_unarmed',
        ['label'] = 'Fists',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'placeholder.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'Fisticuffs'
    },
    ['exhaust_system'] = {
        ['name'] = 'exhaust_system', 			  	
        ['label'] = 'Exhaust System', 				
        ['weight'] = 100, 		
        ['type'] = 'item', 		
        ['image'] = 'exhaust_system.png', 		
        ['unique'] = true, 	
        ['useable'] = false, 	
        ['shouldClose'] = true,	   
        ['combinable'] = true,   
        ['description'] = 'Exhaust System to change the sound of the car'
    },
    ['smallbackpack'] = {
        ['name'] = 'smallbackpack', 			  	
        ['label'] = 'Small Backpack', 				
        ['weight'] = 5000, 		
        ['type'] = 'item', 		
        ['image'] = 'smallbackpack.png', 		
        ['unique'] = true, 	
        ['useable'] = true, 	
        ['shouldClose'] = true,	   
        ['combinable'] = nil,   
        ['description'] = 'Small backpack'
    },
    ['mediumbackpack'] = {
        ['name'] = 'mediumbackpack', 			  	
        ['label'] = 'Medium Backpack', 				
        ['weight'] = 6000, 		
        ['type'] = 'item', 		
        ['image'] = 'mediumbackpack.png', 		
        ['unique'] = true, 	
        ['useable'] = true, 	
        ['shouldClose'] = true,	   
        ['combinable'] = nil,   
        ['description'] = 'Medium backpack'
    },
    ['reinforcedbackpack'] = {
        ['name'] = 'reinforcedbackpack', 			
        ['label'] = 'Reinforced Backpack', 				
        ['weight'] = 7000, 		
        ['type'] = 'item', 		
        ['image'] = 'reinforcedbackpack.png', 		
        ['unique'] = true, 	
        ['useable'] = true, 	
        ['shouldClose'] = true,	   
        ['combinable'] = nil,   
        ['description'] = 'Reinforced backpack'
    },
    ['bigbackpack'] 				 = {
        ['name'] = 'bigbackpack', 			  	  	
        ['label'] = 'Big Backpack', 				
        ['weight'] = 8000, 		
        ['type'] = 'item', 		
        ['image'] = 'bigbackpack.png', 		
        ['unique'] = true, 	
        ['useable'] = true, 	
        ['shouldClose'] = true,	   
        ['combinable'] = nil,   
        ['description'] = 'Big backpack'
    },
    ['gunpowder'] = {
    	['name'] = 'gunpowder',
    	['label'] = 'Gun Powder',
    	['weight'] = 100,
    	['type'] = 'item',
    	['image'] = 'gunpowder.png',
    	['unique'] = false,
    	['combinable'] = true,
    	['description'] = 'Very important powder required for crafting ammo.'
    },
    ['reinforced_steel'] = {
    	['name'] = 'reinforced_steel',
    	['label'] = 'Reinforced Steel',
    	['weight'] = 100,
    	['type'] = 'item',
    	['image'] = 'reinforced_steel.png',
    	['unique'] = false,
    	['combinable'] = true,
    	['description'] = 'Extremely strong steel used for crafting weapons.'
    },
    ['blackmarketkey']                  = {
    	['name'] = 'blackmarketkey',
    	['label'] = 'Black Market Key',
    	['weight'] = 100,
    	['type'] = 'item',
    	['image'] = 'blackmarketkey.png',
    	['unique'] = true,
    	['useable'] = false,
    	['shouldClose'] = true,
    	['combinable'] = nil,
    	['decay'] = 0.6, -- Decays in exactly 7 days
    	['delete'] = true, -- Evaporates when it breaks
    	['object'] = 'prop_cs_key_01', -- Visible object when dropped
    	['objectRotation'] = vec3(0.0, 0.0, 0.0), -- Rotation when dropped
    	['disableThrow'] = false, -- Can be thrown (optional)
    	['rare'] = 'legendary', -- Legendary rarity (golden color)
    	['description'] = 'An ancient, fragile key that grants access to the Black Market. This mysterious key is very old and brittle - it will decay and evaporate in exactly 7 days. Use it quickly before it crumbles to dust!'
    },
    ['ladder']                          = {
        ['name'] = 'ladder',
        ['label'] = 'Ladder',
        ['weight'] = 2000,
        ['type'] = 'item',
        ['image'] = 'ladder.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A portable ladder for climbing'
    },
    ['drillbit']                        = {
        ['name'] = 'drillbit',
        ['label'] = 'Drill Bit',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'drillbits.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Hardened bit for cutting and crafting jewellery'
    },
    ['weapon_dagger']                   = {
        ['name'] = 'weapon_dagger',
        ['label'] = 'Dagger',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_dagger.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A short knife with a pointed and edged blade, used as a weapon'
    },
    ['weapon_bat']                      = {
        ['name'] = 'weapon_bat',
        ['label'] = 'Bat',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_bat.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Used for hitting a ball in sports (or other things)'
    },
    ['weapon_bottle']                   = {
        ['name'] = 'weapon_bottle',
        ['label'] = 'Broken Bottle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_bottle.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A broken bottle'
    },
    ['weapon_crowbar']                  = {
        ['name'] = 'weapon_crowbar',
        ['label'] = 'Crowbar',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_crowbar.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'An iron bar with a flattened end, used as a lever'
    },
    ['weapon_flashlight']               = {
        ['name'] = 'weapon_flashlight',
        ['label'] = 'Flashlight',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_flashlight.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A battery-operated portable light'
    },
    ['weapon_golfclub']                 = {
        ['name'] = 'weapon_golfclub',
        ['label'] = 'Golfclub',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_golfclub.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A club used to hit the ball in golf'
    },
    ['weapon_hammer']                   = {
        ['name'] = 'weapon_hammer',
        ['label'] = 'Hammer',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_hammer.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Used for jobs such as breaking things (legs) and driving in nails'
    },
    ['weapon_hatchet']                  = {
        ['name'] = 'weapon_hatchet',
        ['label'] = 'Hatchet',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_hatchet.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A small axe with a short handle for use in one hand'
    },
    ['weapon_knuckle']                  = {
        ['name'] = 'weapon_knuckle',
        ['label'] = 'Knuckle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_knuckle.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] =
        'A metal guard worn over the knuckles in fighting, especially to increase the effect of the blows'
    },
    ['weapon_knife']                    = {
        ['name'] = 'weapon_knife',
        ['label'] = 'Knife',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_knife.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'An instrument composed of a blade fixed into a handle, used for cutting or as a weapon'
    },
    ['weapon_machete']                  = {
        ['name'] = 'weapon_machete',
        ['label'] = 'Machete',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_machete.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'A broad, heavy knife used as a weapon'
    },
    ['weapon_switchblade']              = {
        ['name'] = 'weapon_switchblade',
        ['label'] = 'Switchblade',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_switchblade.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A knife with a blade that springs out from the handle when a button is pressed'
    },
    ['weapon_nightstick']               = {
        ['name'] = 'weapon_nightstick',
        ['label'] = 'Nightstick',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_nightstick.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = "A police officer's club or billy"
    },
    ['weapon_wrench']                   = {
        ['name'] = 'weapon_wrench',
        ['label'] = 'Wrench',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_wrench.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'A tool used for gripping and turning nuts, bolts, pipes, etc'
    },
    ['weapon_battleaxe']                = {
        ['name'] = 'weapon_battleaxe',
        ['label'] = 'Battle Axe',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_battleaxe.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'A large broad-bladed axe used in ancient warfare'
    },
    ['weapon_poolcue']                  = {
        ['name'] = 'weapon_poolcue',
        ['label'] = 'Poolcue',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_poolcue.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A stick used to strike a ball, usually the cue ball (or other things)'
    },
    ['weapon_briefcase']                = {
        ['name'] = 'weapon_briefcase',
        ['label'] = 'Briefcase',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_briefcase.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'A briefcase for storing important documents'
    },
    ['weapon_briefcase_02']             = {
        ['name'] = 'weapon_briefcase_02',
        ['label'] = 'Suitcase',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_briefcase2.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'Wonderfull for nice vacation to Liberty City'
    },
    ['weapon_garbagebag']               = {
        ['name'] = 'weapon_garbagebag',
        ['label'] = 'Garbage Bag',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_garbagebag.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'A garbage bag'
    },
    ['weapon_handcuffs']                = {
        ['name'] = 'weapon_handcuffs',
        ['label'] = 'Handcuffs',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_handcuffs.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = "A pair of lockable linked metal rings for securing a prisoner's wrists"
    },
    ['weapon_bread']                    = {
        ['name'] = 'weapon_bread',
        ['label'] = 'Baquette',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'baquette.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'Bread...?'
    },
    ['weapon_stone_hatchet']            = {
        ['name'] = 'weapon_stone_hatchet',
        ['label'] = 'Stone Hatchet',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_stone_hatchet.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Stone ax'
    },

    -- Lumberjack shop tools
    ['old_axe']                         = {
        ['name'] = 'old_axe',
        ['label'] = 'Old Axe',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'old_axe.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A weathered axe that still gets the job done'
    },
    ['medieval_axe']                    = {
        ['name'] = 'medieval_axe',
        ['label'] = 'Medieval Axe',
        ['weight'] = 1600,
        ['type'] = 'item',
        ['image'] = 'medieval_axe.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Sturdy iron axe with medieval craftsmanship'
    },
    ['modern_axe']                      = {
        ['name'] = 'modern_axe',
        ['label'] = 'Modern Axe',
        ['weight'] = 1400,
        ['type'] = 'item',
        ['image'] = 'modern_axe.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Lightweight, sharp, and durable'
    },
    ['future_axe']                      = {
        ['name'] = 'future_axe',
        ['label'] = 'Future Axe',
        ['weight'] = 1300,
        ['type'] = 'item',
        ['image'] = 'future_axe.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'High-tech axe with advanced materials'
    },
    ['old_chainsaw']                    = {
        ['name'] = 'old_chainsaw',
        ['label'] = 'Old Chainsaw',
        ['weight'] = 3200,
        ['type'] = 'item',
        ['image'] = 'old_chainsaw.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A heavy, noisy chainsaw from yesteryear'
    },
    ['steam_chainsaw']                  = {
        ['name'] = 'steam_chainsaw',
        ['label'] = 'Steam Chainsaw',
        ['weight'] = 3500,
        ['type'] = 'item',
        ['image'] = 'steam_chainsaw.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Industrial-era steam-powered monster'
    },
    ['modern_chainsaw']                 = {
        ['name'] = 'modern_chainsaw',
        ['label'] = 'Modern Chainsaw',
        ['weight'] = 3000,
        ['type'] = 'item',
        ['image'] = 'modern_chainsaw.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Reliable and efficient cutting power'
    },
    ['future_chainsaw']                 = {
        ['name'] = 'future_chainsaw',
        ['label'] = 'Future Chainsaw',
        ['weight'] = 2900,
        ['type'] = 'item',
        ['image'] = 'future_chainsaw.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Next-gen chainsaw with cutting-edge tech'
    },

    --CSGO KNIVES
    ['weapon_karambit_forest']          = {
        ['name'] = 'weapon_karambit_forest',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_FOREST.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Forest'
    },
    ['weapon_karambit_safarimesh']      = {
        ['name'] = 'weapon_karambit_safarimesh',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_SAFARIMESH.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Safarimesh'
    },
    ['weapon_karambit_borealforest']    = {
        ['name'] = 'weapon_karambit_borealforest',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_BOREALFOREST.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Borealforest'
    },
    ['weapon_karambit_scorched']        = {
        ['name'] = 'weapon_karambit_scorched',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_SCORCHED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Scorched'
    },
    ['weapon_karambit_urbanmasked']     = {
        ['name'] = 'weapon_karambit_urbanmasked',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_URBANMASKED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Urbanmasked'
    },
    ['weapon_karambit_rustcoat']        = {
        ['name'] = 'weapon_karambit_rustcoat',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_RUSTCOAT.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Rustcoat'
    },
    ['weapon_karambit_night']           = {
        ['name'] = 'weapon_karambit_night',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_NIGHT.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Night'
    },
    ['weapon_karambit_stained']         = {
        ['name'] = 'weapon_karambit_stained',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_STAINED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Stained'
    },
    ['weapon_karambit_ultraviolet']     = {
        ['name'] = 'weapon_karambit_ultraviolet',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_ULTRAVIOLET.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Ultraviolet'
    },
    ['weapon_karambit_brightwater']     = {
        ['name'] = 'weapon_karambit_brightwater',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'Melee',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_BRIGHTWATER.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Brightwater'
    },
    ['weapon_karambit_crimsonweb']      = {
        ['name'] = 'weapon_karambit_crimsonweb',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_CRIMSONWEB.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Crimsonweb'
    },
    ['weapon_karambit_freehand']        = {
        ['name'] = 'weapon_karambit_freehand',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_FREEHAND.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Freehand'
    },
    ['weapon_karambit_damascussteel']   = {
        ['name'] = 'weapon_karambit_damascussteel',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_DAMASCUSSTEEL.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Damascussteel'
    },
    ['weapon_karambit_casehardend']     = {
        ['name'] = 'weapon_karambit_casehardend',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_CASEHARDENED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Casehardend'
    },
    ['weapon_karambit_bluesteel']       = {
        ['name'] = 'weapon_karambit_bluesteel',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_BLUESTEEL.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Bluesteel'
    },
    ['weapon_karambit_lore']            = {
        ['name'] = 'weapon_karambit_lore',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_LORE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Lore'
    },
    ['weapon_karambit_blacklaminated']  = {
        ['name'] = 'weapon_karambit_blacklaminated',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_BLACKLAMINATE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Blacklaminated'
    },
    ['weapon_karambit_slaughter']       = {
        ['name'] = 'weapon_karambit_slaughter',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_SLAUGTHER.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Slaughter'
    },
    ['weapon_karambit_tigertooth']      = {
        ['name'] = 'weapon_karambit_tigertooth',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_TIGERTOOTH.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Tigertooth'
    },
    ['weapon_karambit_dopplerphase1']   = {
        ['name'] = 'weapon_karambit_dopplerphase1',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_DOPPLERPHASE1.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Dopplerphase1'
    },
    ['weapon_karambit_dopplerphase3']   = {
        ['name'] = 'weapon_karambit_dopplerphase3',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_DOPPLERPHASE3.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Dopplerphase3'
    },
    ['weapon_karambit_autotronic']      = {
        ['name'] = 'weapon_karambit_autotronic',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_AUTOTRONIC.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Autotronic'
    },
    ['weapon_karambit_marblefade']      = {
        ['name'] = 'weapon_karambit_marblefade',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_MARBLEFADE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Marblefade'
    },
    ['weapon_karambit_dopplerphase2']   = {
        ['name'] = 'weapon_karambit_dopplerphase2',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_DOPPLERPHASE2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Dopplerphase2'
    },
    ['weapon_karambit_dopplerphase4']   = {
        ['name'] = 'weapon_karambit_dopplerphase4',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_DOPPLERPHASE4.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Dopplerphase4'
    },
    ['weapon_karambit_gdp1']            = {
        ['name'] = 'weapon_karambit_gdp1',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_GDP1.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Gdp1'
    },
    ['weapon_karambit_gdp3']            = {
        ['name'] = 'weapon_karambit_gdp3',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_GDP3.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Gdp3'
    },
    ['weapon_karambit_gdp4']            = {
        ['name'] = 'weapon_karambit_gdp4',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_GDP4.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Gdp4'
    },
    ['weapon_karambit_fade']            = {
        ['name'] = 'weapon_karambit_fade',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_FADE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Fade'
    },
    ['weapon_karambit_gdp2']            = {
        ['name'] = 'weapon_karambit_gdp2',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_GDP2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Gdp2'
    },
    ['weapon_karambit_blackpearl']      = {
        ['name'] = 'weapon_karambit_blackpearl',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_BLACKPEARL.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Blackpearl'
    },
    ['weapon_karambit_dopplerruby']     = {
        ['name'] = 'weapon_karambit_dopplerruby',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_DOPPLERRUBY.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Dopplerruby'
    },
    ['weapon_karambit_gdemerald']       = {
        ['name'] = 'weapon_karambit_gdemerald',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_GDEMERALD.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Gdemerald'
    },
    ['weapon_karambit_dopplersapphire'] = {
        ['name'] = 'weapon_karambit_dopplersapphire',
        ['label'] = 'Karambit',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_KARAMBIT_DOPPLERSAPPHIRE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Karambit Dopplersapphire'
    },
    ['weapon_bf_scorched']              = {
        ['name'] = 'weapon_bf_scorched',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_SCORCHED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Scorched'
    },
    ['weapon_bf_safarimesh']            = {
        ['name'] = 'weapon_bf_safarimesh',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_SAFARIMESH.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Safarimesh'
    },
    ['weapon_bf_urbanmasked']           = {
        ['name'] = 'weapon_bf_urbanmasked',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_URBANMASKED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Urbanmasked'
    },
    ['weapon_bf_forest']                = {
        ['name'] = 'weapon_bf_forest',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_FOREST.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Forest'
    },
    ['weapon_bf_borealforest']          = {
        ['name'] = 'weapon_bf_borealforest',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_BOREALFOREST.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Borealforest'
    },
    ['weapon_bf_ultraviolet']           = {
        ['name'] = 'weapon_bf_ultraviolet',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_ULTRAVIOLET.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Ultraviolet'
    },
    ['weapon_bf_night']                 = {
        ['name'] = 'weapon_bf_night',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_NIGHT.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Night'
    },
    ['weapon_bf_stained']               = {
        ['name'] = 'weapon_bf_stained',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_STAINED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Stained'
    },
    ['weapon_bf_rustcoat']              = {
        ['name'] = 'weapon_bf_rustcoat',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_RUSTCOAT.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Rustcoat'
    },
    ['weapon_bf_casehardend']           = {
        ['name'] = 'weapon_bf_casehardend',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_CASEHARDENED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Casehardend'
    },
    ['weapon_bf_bluesteel']             = {
        ['name'] = 'weapon_bf_bluesteel',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_BLUESTEEL.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Bluesteel'
    },
    ['weapon_bf_crimsonweb']            = {
        ['name'] = 'weapon_bf_crimsonweb',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_CRIMSONWEB.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Crimsonweb'
    },
    ['weapon_bf_damascussteel']         = {
        ['name'] = 'weapon_bf_damascussteel',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_DAMASCUSSTEEL.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Damascussteel'
    },
    ['weapon_bf_slaughter']             = {
        ['name'] = 'weapon_bf_slaughter',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_SLAUGTHER.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Slaughter'
    },
    ['weapon_bf_tigertooth']            = {
        ['name'] = 'weapon_bf_tigertooth',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_TIGERTOOTH.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Tigertooth'
    },
    ['weapon_bf_dopplerphase3']         = {
        ['name'] = 'weapon_bf_dopplerphase3',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_DOPPLERPHASE3.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Dopplerphase3'
    },
    ['weapon_bf_dopplerphase1']         = {
        ['name'] = 'weapon_bf_dopplerphase1',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_DOPPLERPHASE1.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Dopplerphase1'
    },
    ['weapon_bf_dopplerphase2']         = {
        ['name'] = 'weapon_bf_dopplerphase2',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_DOPPLERPHASE2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Dopplerphase2'
    },
    ['weapon_bf_fade']                  = {
        ['name'] = 'weapon_bf_fade',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_FADE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Fade'
    },
    ['weapon_bf_dopplerphase4']         = {
        ['name'] = 'weapon_bf_dopplerphase4',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_DOPPLERPHASE4.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Dopplerphase4'
    },
    ['weapon_bf_dopplerblackpearl']     = {
        ['name'] = 'weapon_bf_dopplerblackpearl',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_DOPPLERBLACKPEARL.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Dopplerblackpearl'
    },
    ['weapon_bf_dopplerruby']           = {
        ['name'] = 'weapon_bf_dopplerruby',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_DOPPLERRUBY.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Dopplerruby'
    },
    ['weapon_bf_dopplersapphire']       = {
        ['name'] = 'weapon_bf_dopplersapphire',
        ['label'] = 'bf',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_BF_DOPPLERSAPPHIRE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Bf Dopplersapphire'
    },
    ['weapon_m9_safarimesh']            = {
        ['name'] = 'weapon_m9_safarimesh',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_SAFARIMESH.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Safarimesh'
    },
    ['weapon_m9_urbanmasked']           = {
        ['name'] = 'weapon_m9_urbanmasked',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_URBANMASKED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Urbanmasked'
    },
    ['weapon_m9_scorched']              = {
        ['name'] = 'weapon_m9_scorched',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_SCORCHED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Scorched'
    },
    ['weapon_m9_stained']               = {
        ['name'] = 'weapon_m9_stained',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_STAINED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Stained'
    },
    ['weapon_m9_ultraviolet']           = {
        ['name'] = 'weapon_m9_ultraviolet',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_ULTRAVIOLET.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Ultraviolet'
    },
    ['weapon_m9_brightwater']           = {
        ['name'] = 'weapon_m9_brightwater',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_BRIGHTWATER.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Brightwater'
    },
    ['weapon_m9_crimsonweb']            = {
        ['name'] = 'weapon_m9_crimsonweb',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_CRIMSONWEB.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Crimsonweb'
    },
    ['weapon_m9_freehand']              = {
        ['name'] = 'weapon_m9_freehand',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_FREEHAND.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Freehand'
    },
    ['weapon_m9_damascussteel']         = {
        ['name'] = 'weapon_m9_damascussteel',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_DAMASCUSSTEEL.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Damascussteel'
    },
    ['weapon_m9_casehardend']           = {
        ['name'] = 'weapon_m9_casehardend',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_CASEHARDENED.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Casehardened'
    },
    ['weapon_m9_bluesteel']             = {
        ['name'] = 'weapon_m9_bluesteel',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_BLUESTEEL.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Bluesteel'
    },
    ['weapon_m9_lore']                  = {
        ['name'] = 'weapon_m9_lore',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_LORE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Lore'
    },
    ['weapon_m9_blacklaminate']         = {
        ['name'] = 'weapon_m9_blacklaminate',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_BLACKLAMINATE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Blacklaminate'
    },
    ['weapon_m9_slaughter']             = {
        ['name'] = 'weapon_m9_slaughter',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_SLAUGTHER.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Slaughter'
    },
    ['weapon_m9_tigertooth']            = {
        ['name'] = 'weapon_m9_tigertooth',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_TIGERTOOTH.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Tigertooth'
    },
    ['weapon_m9_doppler1']              = {
        ['name'] = 'weapon_m9_doppler1',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_DOPPLERP1.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Doppler1'
    },
    ['weapon_m9_doppler3']              = {
        ['name'] = 'weapon_m9_doppler3',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_DOPPLERP3.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Doppler3'
    },
    ['weapon_m9_autotronic']            = {
        ['name'] = 'weapon_m9_autotronic',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_AUTOTRONIC.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Autotronic'
    },
    ['weapon_m9_marblefade']            = {
        ['name'] = 'weapon_m9_marblefade',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_MARBLEFADE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Marblefade'
    },
    ['weapon_m9_doppler2']              = {
        ['name'] = 'weapon_m9_doppler2',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_DOPPLERP2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Doper2'
    },
    ['weapon_m9_doppler4']              = {
        ['name'] = 'weapon_m9_doppler4',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_DOPPLERP4.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Doppler4'
    },
    ['weapon_m9_gdp1']                  = {
        ['name'] = 'weapon_m9_gdp1',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_GDP1.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Gdp1'
    },
    ['weapon_m9_gdp3']                  = {
        ['name'] = 'weapon_m9_gdp3',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_GDP3.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Gdp3'
    },
    ['weapon_m9_gdp4']                  = {
        ['name'] = 'weapon_m9_gdp4',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_GDP4.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Gdp4'
    },
    ['weapon_m9_fade']                  = {
        ['name'] = 'weapon_m9_fade',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_FADE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Fade'
    },
    ['weapon_m9_gdp2']                  = {
        ['name'] = 'weapon_m9_gdp2',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_GDP2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 gdp2'
    },
    ['weapon_m9_dopplerblackpearl']     = {
        ['name'] = 'weapon_m9_dopplerblackpearl',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_DOPPLERBLACKPEARL.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Dopplerblackpearl'
    },
    ['weapon_m9_dopplerruby']           = {
        ['name'] = 'weapon_m9_dopplerruby',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_DOPPLERRUBY.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Dopplerruby'
    },
    ['weapon_m9_gdemerald']             = {
        ['name'] = 'weapon_m9_gdemerald',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_GDEMERALD.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Gdemerald'
    },
    ['waeapon_m9_dopplersapphire']      = {
        ['name'] = 'waeapon_m9_dopplersapphire',
        ['label'] = 'M9',
        ['weight'] = 300,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'WEAPON_M9_DOPPLERSAPPHIRE.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'M9 Dopplersapphire'
    },

    -- Handguns
    ['weapon_pistol']                   = {
        ['name'] = 'weapon_pistol',
        ['label'] = 'Walther P99',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_pistol.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A small firearm designed to be held in one hand'
    },
    ['weapon_pistol_mk2']               = {
        ['name'] = 'weapon_pistol_mk2',
        ['label'] = 'Pistol Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_pistol_mk2.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'An upgraded small firearm designed to be held in one hand'
    },
    ['weapon_combatpistol']             = {
        ['name'] = 'weapon_combatpistol',
        ['label'] = 'Combat Pistol',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_combatpistol.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A combat version small firearm designed to be held in one hand'
    },
    ['weapon_appistol']                 = {
        ['name'] = 'weapon_appistol',
        ['label'] = 'AP Pistol',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_appistol.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A small firearm designed to be held in one hand that is automatic'
    },
    ['weapon_stungun']                  = {
        ['name'] = 'weapon_stungun',
        ['label'] = 'Taser',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_stungun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A weapon firing barbs attached by wires to batteries, causing temporary paralysis'
    },
    ['weapon_pistol50']                 = {
        ['name'] = 'weapon_pistol50',
        ['label'] = 'Pistol .50',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_pistol50.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A .50 caliber firearm designed to be held with both hands'
    },
    ['weapon_snspistol']                = {
        ['name'] = 'weapon_snspistol',
        ['label'] = 'SNS Pistol',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_snspistol.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A very small firearm designed to be easily concealed'
    },
    ['weapon_heavypistol']              = {
        ['name'] = 'weapon_heavypistol',
        ['label'] = 'Heavy Pistol',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_heavypistol.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A hefty firearm designed to be held in one hand (or attempted)'
    },
    ['weapon_paintball']                = {
        ['name'] = 'weapon_paintball',
        ['label'] = 'Painball Weapon',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'WEAPON_PAINTBALL.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A hefty firearm designed to be held in one hand (or attempted)'
    },
    ['weapon_vintagepistol']            = {
        ['name'] = 'weapon_vintagepistol',
        ['label'] = 'Vintage Pistol',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_vintagepistol.png',
        ['unique'] = true,
        ['useable'] = false,
        ['legendary'] = 'epic', -- epic, legendary, common
        ['description'] = 'An antique firearm designed to be held in one hand'
    },
    ['weapon_flaregun']                 = {
        ['name'] = 'weapon_flaregun',
        ['label'] = 'Flare Gun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_FLARE',
        ['image'] = 'weapon_flaregun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A handgun for firing signal rockets'
    },
    ['weapon_marksmanpistol']           = {
        ['name'] = 'weapon_marksmanpistol',
        ['label'] = 'Marksman Pistol',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_marksmanpistol.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A very accurate small firearm designed to be held in one hand'
    },
    ['weapon_revolver']                 = {
        ['name'] = 'weapon_revolver',
        ['label'] = 'Revolver',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_revolver.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A pistol with revolving chambers enabling several shots to be fired without reloading'
    },
    ['weapon_revolver_mk2']             = {
        ['name'] = 'weapon_revolver_mk2',
        ['label'] = 'Violence',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_revolver_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'da Violence'
    },
    ['weapon_doubleaction']             = {
        ['name'] = 'weapon_doubleaction',
        ['label'] = 'Double Action Revolver',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_doubleaction.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Double Action Revolver'
    },
    ['weapon_snspistol_mk2']            = {
        ['name'] = 'weapon_snspistol_mk2',
        ['label'] = 'SNS Pistol Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_snspistol_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'SNS Pistol MK2'
    },
    ['weapon_raypistol']                = {
        ['name'] = 'weapon_raypistol',
        ['label'] = 'Up-n-Atomizer',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_raypistol.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Weapon Raypistol'
    },
    ['weapon_ceramicpistol']            = {
        ['name'] = 'weapon_ceramicpistol',
        ['label'] = 'Ceramic Pistol',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_ceramicpistol.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Weapon Ceramicpistol'
    },
    ['weapon_navyrevolver']             = {
        ['name'] = 'weapon_navyrevolver',
        ['label'] = 'Navy Revolver',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_navyrevolver.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Weapon Navyrevolver'
    },
    ['weapon_gadgetpistol']             = {
        ['name'] = 'weapon_gadgetpistol',
        ['label'] = 'Perico Pistol',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_gadgetpistol.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Weapon Gadgetpistol'
    },

    -- Submachine Guns
    ['weapon_microsmg']                 = {
        ['name'] = 'weapon_microsmg',
        ['label'] = 'Micro SMG',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SMG',
        ['image'] = 'weapon_microsmg.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A handheld lightweight machine gun'
    },
    ['weapon_smg']                      = {
        ['name'] = 'weapon_smg',
        ['label'] = 'SMG',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_smg.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A handheld lightweight machine gun'
    },
    ['weapon_smg_mk2']                  = {
        ['name'] = 'weapon_smg_mk2',
        ['label'] = 'SMG Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SMG',
        ['image'] = 'weapon_smg_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'SMG MK2'
    },
    ['weapon_assaultsmg']               = {
        ['name'] = 'weapon_assaultsmg',
        ['label'] = 'Assault SMG',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SMG',
        ['image'] = 'weapon_assaultsmg.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'An assault version of a handheld lightweight machine gun'
    },
    ['weapon_combatpdw']                = {
        ['name'] = 'weapon_combatpdw',
        ['label'] = 'Combat PDW',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_combatpdw.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A combat version of a handheld lightweight machine gun'
    },
    ['weapon_machinepistol']            = {
        ['name'] = 'weapon_machinepistol',
        ['label'] = 'Tec-9',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_machinepistol.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A self-loading pistol capable of burst or fully automatic fire'
    },
    ['weapon_minismg']                  = {
        ['name'] = 'weapon_minismg',
        ['label'] = 'Mini SMG',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SMG',
        ['image'] = 'weapon_minismg.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A mini handheld lightweight machine gun'
    },
    ['weapon_raycarbine']               = {
        ['name'] = 'weapon_raycarbine',
        ['label'] = 'Unholy Hellbringer',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SMG',
        ['image'] = 'weapon_raycarbine.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Weapon Raycarbine'
    },

    -- Shotguns
    ['weapon_pumpshotgun']              = {
        ['name'] = 'weapon_pumpshotgun',
        ['label'] = 'Pump Shotgun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_pumpshotgun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A pump-action smoothbore gun for firing small shot at short range'
    },
    ['weapon_sawnoffshotgun']           = {
        ['name'] = 'weapon_sawnoffshotgun',
        ['label'] = 'Sawn-off Shotgun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_sawnoffshotgun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A sawn-off smoothbore gun for firing small shot at short range'
    },
    ['weapon_assaultshotgun']           = {
        ['name'] = 'weapon_assaultshotgun',
        ['label'] = 'Assault Shotgun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_assaultshotgun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'An assault version of asmoothbore gun for firing small shot at short range'
    },
    ['weapon_bullpupshotgun']           = {
        ['name'] = 'weapon_bullpupshotgun',
        ['label'] = 'Bullpup Shotgun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_bullpupshotgun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A compact smoothbore gun for firing small shot at short range'
    },
    ['weapon_musket']                   = {
        ['name'] = 'weapon_musket',
        ['label'] = 'Musket',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_musket.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] =
        "An infantryman's light gun with a long barrel, typically smooth-bored, muzzleloading, and fired from the shoulder"
    },
    ['weapon_heavyshotgun']             = {
        ['name'] = 'weapon_heavyshotgun',
        ['label'] = 'Heavy Shotgun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_heavyshotgun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A large smoothbore gun for firing small shot at short range'
    },
    ['weapon_dbshotgun']                = {
        ['name'] = 'weapon_dbshotgun',
        ['label'] = 'Double-barrel Shotgun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_dbshotgun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] =
        'A shotgun with two parallel barrels, allowing two single shots to be fired in quick succession'
    },
    ['weapon_autoshotgun']              = {
        ['name'] = 'weapon_autoshotgun',
        ['label'] = 'Auto Shotgun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_autoshotgun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A shotgun capable of rapid continous fire'
    },
    ['weapon_pumpshotgun_mk2']          = {
        ['name'] = 'weapon_pumpshotgun_mk2',
        ['label'] = 'Pumpshotgun Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_pumpshotgun_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Pumpshotgun MK2'
    },
    ['weapon_combatshotgun']            = {
        ['name'] = 'weapon_combatshotgun',
        ['label'] = 'Combat Shotgun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_combatshotgun.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Weapon Combatshotgun'
    },

    -- Assault Rifles
    ['weapon_assaultrifle']             = {
        ['name'] = 'weapon_assaultrifle',
        ['label'] = 'Assault Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_assaultrifle.png',
        ['unique'] = true,
        ['job'] = { 'police', 'bcso' },
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A rapid-fire, magazine-fed automatic rifle designed for infantry use'
    },
    ['weapon_assaultrifle_mk2']         = {
        ['name'] = 'weapon_assaultrifle_mk2',
        ['label'] = 'Assault Rifle Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_assaultrifle_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Assault Rifle MK2'
    },
    ['weapon_carbinerifle']             = {
        ['name'] = 'weapon_carbinerifle',
        ['label'] = 'Carbine Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_carbinerifle.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A lightweight automatic rifle'
    },
    ['weapon_carbinerifle_mk2']         = {
        ['name'] = 'weapon_carbinerifle_mk2',
        ['label'] = 'Carbine Rifle Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_carbinerifle_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Carbine Rifle MK2'
    },
    ['weapon_advancedrifle']            = {
        ['name'] = 'weapon_advancedrifle',
        ['label'] = 'Advanced Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_advancedrifle.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'An assault version of a rapid-fire, magazine-fed automatic rifle designed for infantry use'
    },
    ['weapon_specialcarbine']           = {
        ['name'] = 'weapon_specialcarbine',
        ['label'] = 'Special Carbine',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_specialcarbine.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'An extremely versatile assault rifle for any combat situation'
    },
    ['weapon_bullpuprifle']             = {
        ['name'] = 'weapon_bullpuprifle',
        ['label'] = 'Bullpup Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_bullpuprifle.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A compact automatic assault rifle'
    },
    ['weapon_compactrifle']             = {
        ['name'] = 'weapon_compactrifle',
        ['label'] = 'Compact Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_compactrifle.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A compact version of an assault rifle'
    },
    ['weapon_specialcarbine_mk2']       = {
        ['name'] = 'weapon_specialcarbine_mk2',
        ['label'] = 'Special Carbine Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_specialcarbine_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Weapon Wpecialcarbine MK2'
    },
    ['weapon_bullpuprifle_mk2']         = {
        ['name'] = 'weapon_bullpuprifle_mk2',
        ['label'] = 'Bullpup Rifle Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_bullpuprifle_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Bull Puprifle MK2'
    },
    ['weapon_militaryrifle']            = {
        ['name'] = 'weapon_militaryrifle',
        ['label'] = 'Military Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_militaryrifle.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Weapon Militaryrifle'
    },
    ['weapon_tacticalrifle']            = {
        ['name'] = 'weapon_tacticalrifle',
        ['label'] = 'Service Carbine',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_carbinerifle.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Weapon Tactical Rifle'
    },

    -- Light Machine Guns
    ['weapon_mg']                       = {
        ['name'] = 'weapon_mg',
        ['label'] = 'Machinegun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_mg.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'An automatic gun that fires bullets in rapid succession for as long as the trigger is pressed'
    },
    ['weapon_combatmg']                 = {
        ['name'] = 'weapon_combatmg',
        ['label'] = 'Combat MG',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_combatmg.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] =
        'A combat version of an automatic gun that fires bullets in rapid succession for as long as the trigger is pressed'
    },
    ['weapon_gusenberg']                = {
        ['name'] = 'weapon_gusenberg',
        ['label'] = 'Thompson SMG',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_gusenberg.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'An automatic rifle commonly referred to as a tommy gun'
    },
    ['weapon_combatmg_mk2']             = {
        ['name'] = 'weapon_combatmg_mk2',
        ['label'] = 'Combat MG Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_combatmg_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Weapon Combatmg MK2'
    },

    -- Sniper Rifles
    ['weapon_sniperrifle']              = {
        ['name'] = 'weapon_sniperrifle',
        ['label'] = 'Sniper Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_sniperrifle.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A high-precision, long-range rifle'
    },
    ['weapon_heavysniper']              = {
        ['name'] = 'weapon_heavysniper',
        ['label'] = 'Heavy Sniper',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_heavysniper.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'An upgraded high-precision, long-range rifle'
    },
    ['weapon_marksmanrifle']            = {
        ['name'] = 'weapon_marksmanrifle',
        ['label'] = 'Marksman Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_marksmanrifle.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A very accurate single-fire rifle'
    },
    ['weapon_remotesniper']             = {
        ['name'] = 'weapon_remotesniper',
        ['label'] = 'Remote Sniper',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER_REMOTE',
        ['image'] = 'weapon_remotesniper.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A portable high-precision, long-range rifle'
    },
    ['weapon_heavysniper_mk2']          = {
        ['name'] = 'weapon_heavysniper_mk2',
        ['label'] = 'Heavy Sniper Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_heavysniper_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Weapon Heavysniper MK2'
    },
    ['weapon_marksmanrifle_mk2']        = {
        ['name'] = 'weapon_marksmanrifle_mk2',
        ['label'] = 'Marksman Rifle Mk II',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_marksmanrifle_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Weapon Marksmanrifle MK2'
    },
    ['weapon_precisionrifle']           = {
        ['name'] = 'weapon_precisionrifle',
        ['label'] = 'Precision Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_marksmanrifle_mk2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Weapon Precision Rifle'
    },

    -- Heavy Weapons
    ['weapon_rpg']                      = {
        ['name'] = 'weapon_rpg',
        ['label'] = 'RPG',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RPG',
        ['image'] = 'weapon_rpg.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A rocket-propelled grenade launcher'
    },
    ['weapon_grenadelauncher']          = {
        ['name'] = 'weapon_grenadelauncher',
        ['label'] = 'Grenade Launcher',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_GRENADELAUNCHER',
        ['image'] = 'weapon_grenadelauncher.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] =
        'A weapon that fires a specially-designed large-caliber projectile, often with an explosive, smoke or gas warhead'
    },
    ['weapon_grenadelauncher_smoke']    = {
        ['name'] = 'weapon_grenadelauncher_smoke',
        ['label'] = 'Smoke Grenade Launcher',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_GRENADELAUNCHER',
        ['image'] = 'weapon_smokegrenade.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A bomb that produces a lot of smoke when it explodes'
    },
    ['weapon_minigun']                  = {
        ['name'] = 'weapon_minigun',
        ['label'] = 'Minigun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MINIGUN',
        ['image'] = 'weapon_minigun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] =
        'A portable machine gun consisting of a rotating cluster of six barrels and capable of variable rates of fire of up to 6,000 rounds per minute'
    },
    ['weapon_firework']                 = {
        ['name'] = 'weapon_firework',
        ['label'] = 'Firework Launcher',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_firework.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] =
        'A device containing gunpowder and other combustible chemicals that causes a spectacular explosion when ignited'
    },
    ['weapon_railgun']                  = {
        ['name'] = 'weapon_railgun',
        ['label'] = 'Railgun',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_railgun.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A weapon that uses electromagnetic force to launch high velocity projectiles'
    },
    ['weapon_hominglauncher']           = {
        ['name'] = 'weapon_hominglauncher',
        ['label'] = 'Homing Launcher',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_STINGER',
        ['image'] = 'weapon_hominglauncher.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A weapon fitted with an electronic device that enables it to find and hit a target'
    },
    ['weapon_compactlauncher']          = {
        ['name'] = 'weapon_compactlauncher',
        ['label'] = 'Compact Launcher',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_compactlauncher.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A compact grenade launcher'
    },
    ['weapon_rayminigun']               = {
        ['name'] = 'weapon_rayminigun',
        ['label'] = 'Widowmaker',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MINIGUN',
        ['image'] = 'weapon_rayminigun.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Weapon Rayminigun'
    },

    -- Throwables
    ['weapon_grenade']                  = {
        ['name'] = 'weapon_grenade',
        ['label'] = 'Grenade',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_grenade.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A handheld throwable bomb'
    },
    ['weapon_bzgas']                    = {
        ['name'] = 'weapon_bzgas',
        ['label'] = 'BZ Gas',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_bzgas.png',
        ['unique'] = false,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A cannister of gas that causes extreme pain'
    },
    ['weapon_molotov']                  = {
        ['name'] = 'weapon_molotov',
        ['label'] = 'Molotov',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_molotov.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] =
        'A crude bomb made of a bottle filled with a flammable liquid and fitted with a wick for lighting'
    },
    ['weapon_stickybomb']               = {
        ['name'] = 'weapon_stickybomb',
        ['label'] = 'C4',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_stickybomb.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] =
        'An explosive charge covered with an adhesive that when thrown against an object sticks until it explodes'
    },
    ['weapon_proxmine']                 = {
        ['name'] = 'weapon_proxmine',
        ['label'] = 'Proxmine Grenade',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_proximitymine.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'A bomb placed on the ground that detonates when going within its proximity'
    },
    ['weapon_snowball']                 = {
        ['name'] = 'weapon_snowball',
        ['label'] = 'Snowball',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_snowball.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A ball of packed snow, especially one made for throwing at other people for fun'
    },
    ['weapon_pipebomb']                 = {
        ['name'] = 'weapon_pipebomb',
        ['label'] = 'Pipe Bomb',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_pipebomb.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A homemade bomb, the components of which are contained in a pipe'
    },
    ['weapon_ball']                     = {
        ['name'] = 'weapon_ball',
        ['label'] = 'Ball',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_BALL',
        ['image'] = 'weapon_ball.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'A solid or hollow spherical or egg-shaped object that is kicked, thrown, or hit in a game'
    },
    ['weapon_smokegrenade']             = {
        ['name'] = 'weapon_smokegrenade',
        ['label'] = 'Smoke Grenade',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_c4.png',
        ['unique'] = true,
        ['useable'] = false,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'An explosive charge that can be remotely detonated'
    },
    ['weapon_flare']                    = {
        ['name'] = 'weapon_flare',
        ['label'] = 'Flare pistol',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_FLARE',
        ['image'] = 'weapon_flare.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'A small pyrotechnic devices used for illumination and signalling'
    },

    -- Miscellaneous
    ['weapon_petrolcan']                = {
        ['name'] = 'weapon_petrolcan',
        ['label'] = 'Petrol Can',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PETROLCAN',
        ['image'] = 'weapon_petrolcan.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] = 'A robust liquid container made from pressed steel'
    },
    ['weapon_fireextinguisher']         = {
        ['name'] = 'weapon_fireextinguisher',
        ['label'] = 'Fire Extinguisher',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = nil,
        ['image'] = 'weapon_fireextinguisher.png',
        ['unique'] = true,
        ['useable'] = false,
        ['description'] =
        'A portable device that discharges a jet of water, foam, gas, or other material to extinguish a fire'
    },
    ['weapon_hazardcan']                = {
        ['name'] = 'weapon_hazardcan',
        ['label'] = 'Hazardous Jerry Can',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PETROLCAN',
        ['image'] = 'weapon_hazardcan.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Weapon Hazardcan'
    },
    ['weapon_metaldetector']            = {
        ['name'] = 'weapon_metaldetector',
        ['label'] = 'Metal Detector',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'nil',
        ['image'] = 'placeholder.png',
        ['unique'] = true,
        ['useable'] = true,
        ['description'] = 'Weapon Metal Detector'
    },

    -- PISTOL ATTACHMENTS
    ['pistol_defaultclip']              = {
        ['name'] = 'pistol_defaultclip',
        ['label'] = 'Pistol Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'defaultclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Pistol Default Clip'
    },
    ['pistol_extendedclip']             = {
        ['name'] = 'pistol_extendedclip',
        ['label'] = 'Pistol EXT Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'extendedclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Pistol Extended Clip'
    },
    ['pistol_flashlight']               = {
        ['name'] = 'pistol_flashlight',
        ['label'] = 'Pistol Flashlight',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'flashlight_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Pistol Flashlight Attachment'
    },
    ['pistol_suppressor']               = {
        ['name'] = 'pistol_suppressor',
        ['label'] = 'Pistol Suppressor',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'suppressor_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Pistol Suppressor Attachment'
    },
    ['pistol_holoscope']                = {
        ['name'] = 'pistol_holoscope',
        ['label'] = 'Pistol Holoscope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'holoscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Pistol Holographic Scope Attachment'
    },
    ['pistol_smallscope']               = {
        ['name'] = 'pistol_smallscope',
        ['label'] = 'Pistol Scope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'smallscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Pistol Scope Attachment'
    },
    ['pistol_compensator']              = {
        ['name'] = 'pistol_compensator',
        ['label'] = 'Pistol Compensator',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'comp_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Pistol Compensator Attachment'
    },

    -- SMG ATTACHMENTS
    ['smg_defaultclip']                 = {
        ['name'] = 'smg_defaultclip',
        ['label'] = 'SMG Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'defaultclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'SMG Default Clip'
    },
    ['smg_extendedclip']                = {
        ['name'] = 'smg_extendedclip',
        ['label'] = 'SMG EXT Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'extendedclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'SMG Extended Clip'
    },
    ['smg_suppressor']                  = {
        ['name'] = 'smg_suppressor',
        ['label'] = 'SMG Suppressor',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'suppressor_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'SMG Suppressor'
    },
    ['smg_drum']                        = {
        ['name'] = 'smg_drum',
        ['label'] = 'SMG Drum',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'drum_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'SMG Drum'
    },
    ['smg_scope']                       = {
        ['name'] = 'smg_scope',
        ['label'] = 'SMG Scope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'smallscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'SMG Scope Attachment'
    },
    ['smg_grip']                        = {
        ['name'] = 'smg_grip',
        ['label'] = 'SMG Grip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'grip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'SMG Grip Attachment'
    },
    ['smg_barrel']                      = {
        ['name'] = 'smg_barrel',
        ['label'] = 'SMG Grip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'barrel_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'SMG Barrel Attachment'
    },
    ['smg_holoscope']                   = {
        ['name'] = 'smg_holoscope',
        ['label'] = 'SMG Holoscope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'holoscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'SMG Holographic Scope Attachment'
    },

    -- SHOTGUN ATTACHMENTS
    ['shotgun_flashlight']              = {
        ['name'] = 'shotgun_flashlight',
        ['label'] = 'Shotgun Flashlight',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'flashlight_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Shotgun Flashlight Attachment'
    },
    ['shotgun_suppressor']              = {
        ['name'] = 'shotgun_suppressor',
        ['label'] = 'Shotgun Suppressor',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'suppressor_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Shotgun Suppressor Attachment'
    },
    ['shotgun_grip']                    = {
        ['name'] = 'shotgun_grip',
        ['label'] = 'Shotgun Grip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'grip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Shotgun Grip Attachment'
    },
    ['shotgun_defaultclip']             = {
        ['name'] = 'shotgun_defaultclip',
        ['label'] = 'Shotgun Default Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'defaultclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Shotgun Default Clip'
    },
    ['shotgun_extendedclip']            = {
        ['name'] = 'shotgun_extendedclip',
        ['label'] = 'Shotgun Extended Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'extendedclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Shotgun Extended Clip'
    },
    ['shotgun_drum']                    = {
        ['name'] = 'shotgun_drum',
        ['label'] = 'Shotgun Drum',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'drum_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Shotgun Drum Attachment'
    },
    ['shotgun_squaredmuzzle']           = {
        ['name'] = 'shotgun_squaredmuzzle',
        ['label'] = 'Shotgun Squared Muzzle',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'squared-muzzle-brake_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Shotgun Muzzle Brake Attachment'
    },
    ['shotgun_holoscope']               = {
        ['name'] = 'shotgun_holoscope',
        ['label'] = 'Shotgun Heavy Barrel',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'holoscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Shotgun Holographic Scope Attachment'
    },
    ['shotgun_smallscope']              = {
        ['name'] = 'shotgun_smallscope',
        ['label'] = 'Shotgun Scope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'smallscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Shotgun Scope Attachment'
    },

    -- RIFLE ATTACHMENTS
    ['rifle_defaultclip']               = {
        ['name'] = 'rifle_defaultclip',
        ['label'] = 'Rifle Default Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'defaultclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Rifle Default Clip'
    },
    ['rifle_extendedclip']              = {
        ['name'] = 'rifle_extendedclip',
        ['label'] = 'Rifle Extended Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'extendedclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Rifle Extended Clip'
    },
    ['rifle_drum']                      = {
        ['name'] = 'rifle_drum',
        ['label'] = 'Rifle Drum Magazine',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'drum_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Rifle Drum Magazine'
    },
    ['rifle_flashlight']                = {
        ['name'] = 'rifle_flashlight',
        ['label'] = 'Rifle Flashlight',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'flashlight_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Rifle Flashlight Attachment'
    },
    ['rifle_holoscope']                 = {
        ['name'] = 'rifle_holoscope',
        ['label'] = 'Rifle Holographic Sight',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'holoscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Rifle Holographic Sight'
    },
    ['rifle_smallscope']                = {
        ['name'] = 'rifle_smallscope',
        ['label'] = 'Rifle Small Scope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'smallscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Rifle Small Scope'
    },
    ['rifle_largescope']                = {
        ['name'] = 'rifle_largescope',
        ['label'] = 'Rifle Large Scope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'largescope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Rifle Large Scope'
    },
    ['rifle_suppressor']                = {
        ['name'] = 'rifle_suppressor',
        ['label'] = 'Rifle Suppressor',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'suppressor_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Rifle Suppressor Attachment'
    },
    ['rifle_grip']                      = {
        ['name'] = 'rifle_grip',
        ['label'] = 'Rifle Grip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'grip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Rifle Grip Attachment'
    },


    -- SNIPER ATTACHMENTS
    ['sniper_defaultclip']          = {
        ['name'] = 'sniper_defaultclip',
        ['label'] = 'Sniper Default Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'defaultclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Sniper Default Clip Attachment'
    },
    ['sniper_extendedclip']         = {
        ['name'] = 'sniper_extendedclip',
        ['label'] = 'Sniper Extended Clip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'extendedclip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Sniper Extended Clip Attachment'
    },
    ['sniper_flashlight']           = {
        ['name'] = 'sniper_flashlight',
        ['label'] = 'Sniper Flashlight',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'flashlight_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Sniper Flashlight Attachment'
    },
    ['sniper_scope']                = {
        ['name'] = 'sniper_scope',
        ['label'] = 'Sniper Scope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'smallscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Sniper Scope Attachment'
    },
    ['sniper_smallscope']           = {
        ['name'] = 'sniper_smallscope',
        ['label'] = 'Sniper Small Scope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'smallscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Sniper Small Scope Attachment'
    },
    ['sniper_largescope']           = {
        ['name'] = 'sniper_largescope',
        ['label'] = 'Sniper Large Scope',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'largescope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Sniper Large Scope Attachment'
    },
    ['sniper_suppressor']           = {
        ['name'] = 'sniper_suppressor',
        ['label'] = 'Sniper Suppressor',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'suppressor_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Sniper Suppressor Attachment'
    },
    ['sniper_holoscope']            = {
        ['name'] = 'sniper_holoscope',
        ['label'] = 'Sniper Holographic Sight',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'holoscope_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Sniper Holographic Sight Attachment'
    },
    ['sniper_squaredmuzzle']        = {
        ['name'] = 'sniper_squaredmuzzle',
        ['label'] = 'Sniper Squared Muzzle',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'squared-muzzle-brake_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Sniper Squared Muzzle Attachment'
    },
    ['sniper_barrel']               = {
        ['name'] = 'sniper_barrel',
        ['label'] = 'Sniper Heavy Barrel',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'barrel_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Sniper Heavy Barrel Attachment'
    },
    ['sniper_grip']                 = {
        ['name'] = 'sniper_grip',
        ['label'] = 'Sniper Grip',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'grip_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Sniper Grip Attachment'
    },

    -- Weapon Tints
    ['black_weapontint']            = {
        ['name'] = 'black_weapontint',
        ['label'] = 'Black Tint',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'black_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['object'] = 'prop_cs_spray_can',
        ['description'] = 'Default/Black Weapon Tint'
    },
    ['green_weapontint']            = {
        ['name'] = 'green_weapontint',
        ['label'] = 'Green Tint',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'green_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['object'] = 'prop_cs_spray_can',
        ['description'] = 'Green Weapon Tint'
    },
    ['gold_weapontint']             = {
        ['name'] = 'gold_weapontint',
        ['label'] = 'Gold Tint',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'gold_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['object'] = 'prop_cs_spray_can',
        ['description'] = 'Gold Weapon Tint'
    },
    ['pink_weapontint']             = {
        ['name'] = 'pink_weapontint',
        ['label'] = 'Pink Tint',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'pink_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['object'] = 'prop_cs_spray_can',
        ['description'] = 'Pink Weapon Tint'
    },
    ['army_weapontint']             = {
        ['name'] = 'army_weapontint',
        ['label'] = 'Army Tint',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'army_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['object'] = 'prop_cs_spray_can',
        ['description'] = 'Army Weapon Tint'
    },
    ['lspd_weapontint']             = {
        ['name'] = 'lspd_weapontint',
        ['label'] = 'LSPD Tint',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'lspd_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['object'] = 'prop_cs_spray_can',
        ['description'] = 'LSPD Weapon Tint'
    },
    ['orange_weapontint']           = {
        ['name'] = 'orange_weapontint',
        ['label'] = 'Orange Tint',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'orange_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['object'] = 'prop_cs_spray_can',
        ['description'] = 'Orange Weapon Tint'
    },
    ['plat_weapontint']             = {
        ['name'] = 'plat_weapontint',
        ['label'] = 'Platinum Tint',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'plat_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['object'] = 'prop_cs_spray_can',
        ['description'] = 'Platinum Weapon Tint'
    },
    ['weapontint_url']              = {
        ['name'] = 'weapontint_url',
        ['label'] = 'URL Tint',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'url_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['object'] = 'ng_proc_spraycan01a',
        ['description'] = 'Luxury Finish Tint'
    },
    ['luxuryfinish_weapontint']     = {
        ['name'] = 'luxuryfinish_weapontint',
        ['label'] = 'Luxury Finish',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'luxuryfinish_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['object'] = 'ng_proc_spraycan01a',
        ['description'] = 'Luxury Finish Tint'
    },
    ['digital_weapontint']          = {
        ['name'] = 'digital_weapontint',
        ['label'] = 'Digital Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'digicamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Digital Camo Tint'
    },
    ['brushstroke_weapontint']      = {
        ['name'] = 'brushstroke_weapontint',
        ['label'] = 'Brushstroke Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'brushcamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Brushstroke Camo Tint'
    },
    ['woodland_weapontint']         = {
        ['name'] = 'woodland_weapontint',
        ['label'] = 'Woodland Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'woodcamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Woodland Camo Tint'
    },
    ['skull_weapontint']            = {
        ['name'] = 'skull_weapontint',
        ['label'] = 'Skull Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'skullcamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Skull Camo Tint'
    },
    ['sessanta_weapontint']         = {
        ['name'] = 'sessanta_weapontint',
        ['label'] = 'Sessanta Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'sessantacamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Sessanta Camo Tint'
    },
    ['perseus_weapontint']          = {
        ['name'] = 'perseus_weapontint',
        ['label'] = 'Perseus Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'perseuscamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Perseus Camo Tint'
    },
    ['leopard_weapontint']          = {
        ['name'] = 'leopard_weapontint',
        ['label'] = 'Leopard Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'leopardcamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Leopard Camo Tint'
    },
    ['zebra_weapontint']            = {
        ['name'] = 'zebra_weapontint',
        ['label'] = 'Zebra Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'zebracamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Zebra Camo Tint'
    },
    ['geometric_weapontint']        = {
        ['name'] = 'geometric_weapontint',
        ['label'] = 'Geometric Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'geocamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Geometric Camo Tint'
    },
    ['boom_weapontint']             = {
        ['name'] = 'boom_weapontint',
        ['label'] = 'Boom! Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'boomcamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Boom! Camo Tint'
    },
    ['patriot_weapontint']          = {
        ['name'] = 'patriot_weapontint',
        ['label'] = 'Patriotic Camo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'patriotcamo_attachment.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['object'] = 'prop_paint_spray01b',
        ['description'] = 'Patriotic Camo Tint'
    },

    -- ITEMS
    -- Ammo ITEMS
    ['pistol_ammo']                 = {
        ['name'] = 'pistol_ammo',
        ['label'] = 'Pistol ammo',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'pistol_ammo.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_ld_ammo_pack_01',
        ['description'] = 'Ammo for Pistols'
    },
    ['rifle_ammo']                  = {
        ['name'] = 'rifle_ammo',
        ['label'] = 'Rifle ammo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'rifle_ammo.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_ld_ammo_pack_02',
        ['description'] = 'Ammo for Rifles'
    },
    ['smg_ammo']                    = {
        ['name'] = 'smg_ammo',
        ['label'] = 'SMG ammo',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'smg_ammo.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_ld_ammo_pack_02',
        ['description'] = 'Ammo for Sub Machine Guns'
    },
    ['shotgun_ammo']                = {
        ['name'] = 'shotgun_ammo',
        ['label'] = 'Gun Club Ammo',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'pistol_ammo.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_ld_ammo_pack_03',
        ['description'] = 'Ammo for Class 1'
    },
    ['mg_ammo']                     = {
        ['name'] = 'mg_ammo',
        ['label'] = 'PD Ammo',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'ammo_box_pd.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_box_ammo07a',
        ['description'] = 'Ammo for Machine Guns'
    },
    ['snp_ammo']                    = {
        ['name'] = 'snp_ammo',
        ['label'] = 'Sniper ammo',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'rifle_ammo.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_box_ammo07a',
        ['description'] = 'Ammo for Sniper Rifles'
    },
    ['emp_ammo']                    = {
        ['name'] = 'emp_ammo',
        ['label'] = 'EMP Ammo',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'rifle_ammo.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_ld_ammo_pack_03',
        ['description'] = 'Ammo for EMP Launcher'
    },
    ['rpg_ammo']                    = {
        ['name'] = 'rpg_ammo',
        ['label'] = 'RPG Ammo',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'rifle_ammo.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_ld_ammo_pack_03',
        ['description'] = 'Ammo for EMP Launcher'
    },

    -- Card ITEMS
    ['id_card']                     = {
        ['name'] = 'id_card',
        ['label'] = 'ID Card',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'id_card.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'p_ld_id_card_01',
        ['description'] = 'A card containing all your information to identify yourself'
    },
    ['driver_license']              = {
        ['name'] = 'driver_license',
        ['label'] = 'Drivers License',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'driver_license.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_cs_business_card',
        ['description'] = 'Permit to show you can drive a vehicle'
    },
    ['boater_card']                 = {
        ['name'] = 'boater_card',
        ['label'] = 'Boat License',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'driver_license.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_cs_business_card',
        ['description'] = 'Permit to show you can drive a boat'
    },
    ['pilot_license']               = {
        ['name'] = 'pilot_license',
        ['label'] = 'Pilot License',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'driver_license.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_cs_business_card',
        ['description'] = 'Permit to show you can fly'
    },
    ['lawyerpass']                  = {
        ['name'] = 'lawyerpass',
        ['label'] = 'Lawyer Pass',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'lawyerpass.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_ld_contact_card',
        ['description'] = 'Pass exclusive to lawyers to show they can represent a suspect'
    },
    ['weaponlicense']               = {
        ['name'] = 'weaponlicense',
        ['label'] = 'Weapon License',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'weapon_license.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_cs_swipe_card',
        ['description'] = 'Weapon License'
    },
    ['creditcard']                  = {
        ['name'] = 'creditcard',
        ['label'] = 'Credit Card',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'bank_card.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['description'] = 'Visa card, can be used via ATM',
        client = { export = 'qs-banking.CreateCard' }
    },
    ['licenseplate']                = {
        ['name'] = 'licenseplate',
        ['label'] = 'License Plate',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'licenseplate.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_ld_contact_card',
        ['description'] = 'Pass exclusive to lawyers to show they can represent a suspect'
    },
    ['visa']                        = {
        ['name'] = 'visa',
        ['label'] = 'Visa Card',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'visa.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_cs_credit_card',
        ['description'] = 'Visa can be used via ATM'
    },
    ['mastercard']                  = {
        ['name'] = 'mastercard',
        ['label'] = 'Master Card',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'mastercard.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_cs_credit_card',
        ['description'] = 'MasterCard can be used via ATM'
    },
    ['security_card_01']            = {
        ['name'] = 'security_card_01',
        ['label'] = 'Security Card A',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'security_card_01.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'hei_prop_heist_card_hack',
        ['description'] = 'A security card... I wonder what it goes to',
        ['client'] = {
            export = 'jpr-inventory.test'
        },
    },
    ['security_card_02']            = {
        ['name'] = 'security_card_02',
        ['label'] = 'Security Card B',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'security_card_02.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'hei_prop_heist_card_hack',
        ['description'] = 'A security card... I wonder what it goes to'
    },

    -- Eat ITEMS
    ['tosti']                       = {
        ['name'] = 'tosti',
        ['label'] = 'Grilled Cheese Sandwich',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'tosti.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Nice to eat',
        ['created'] = nil,
        ['delete'] = false,
        ['object'] = 'prop_sandwich_01',
        ['client'] = {
            status = {
                hunger = 200000,
            },
            usetime = 2500,
            anim = {
                dict = 'mp_player_inteat@burger',
                clip = 'mp_player_int_eat_burger_fp'
            },
            prop = {
                model = 'prop_cs_burger_01',
                pos = vec3(0.02, 0.02, -0.02),
                rot = vec3(0.0, 0.0, 0.0)
            },
            disable = {
                move = true,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },
    ['twerks_candy']                = {
        ['name'] = 'twerks_candy',
        ['label'] = 'Twerks',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'twerks_candy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.15,
        ['delete'] = false,
        ['object'] = 'prop_choc_ego',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Some delicious candy :O',
        ['client'] = {
            status = {
                hunger = 200000,
            },
            usetime = 2500,
            anim = {
                dict = 'mp_player_inteat@burger',
                clip = 'mp_player_int_eat_burger'
            },
            prop = {
                model = 'prop_choc_ego',
                bone = 60309,
                pos = vec3(0.000000, 0.000000, 0.000000),
                rot = vec3(0.000000, 0.000000, 0.000000)
            },
            disable = {
                move = true,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },
    ['snikkel_candy']               = {
        ['name'] = 'snikkel_candy',
        ['label'] = 'Snikkel',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'snikkel_candy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.15,
        ['delete'] = false,
        ['object'] = 'prop_candy_pqs',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Some delicious candy :O'
    },
    ['sandwich']                    = {
        ['name'] = 'sandwich',
        ['label'] = 'Sandwich',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'sandwich.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.07,
        ['delete'] = false,
        ['object'] = 'prop_sandwich_01',
        ['description'] = 'Nice bread for your stomach',
        ['client'] = {
            status = {
                hunger = 200000,
            },
            usetime = 2500,
            anim = {
                dict = 'mp_player_inteat@burger',
                clip = 'mp_player_int_eat_burger'
            },
            prop = {
                model = 'prop_sandwich_01',
                bone = 18905,
                pos = vector3(0.130000, 0.050000, 0.020000),
                rot = vector3(-50.000000, 16.000000, 60.000000),
            },
            disable = {
                move = false,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },

    -- Drink ITEMS
    ['water_bottle']                = {
        ['name'] = 'water_bottle',
        ['label'] = 'Bottle of Water',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'water_bottle.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'For all the thirsty out there',
        ['created'] = nil,
        --['decay'] = 0.10,
        ['delete'] = false,
        ['object'] = 'prop_ld_flow_bottle',
        ['client'] = {
            status = {
                thirst = 200000,
            },
            usetime = 2500,
            anim = {
                dict = 'mp_player_intdrink',
                clip = 'loop_bottle'
            },
            prop = {
                model = 'prop_ld_flow_bottle',
                pos = vec3(0.02, 0.02, -0.02),
                rot = vec3(0.0, 0.0, 0.0)
            },
            disable = {
                move = true,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },
    ['coffee']                      = {
        ['name'] = 'coffee',
        ['label'] = 'Coffee',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'coffee.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.05,
        ['delete'] = false,
        ['object'] = 'p_amb_coffeecup_01',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Pump 4 Caffeine',
        ['client'] = {
            status = {
                thirst = 150000,
            },
            usetime = 2500,
            anim = {
                dict = 'amb@world_human_drinking@coffee@male@idle_a',
                clip = 'idle_c'
            },
            prop = {
                model = 'p_amb_coffeecup_01',
                bone = 28422,
                pos = vec3(0.000000, 0.000000, 0.000000),
                rot = vec3(0.000000, 0.000000, 0.000000)
            },
            disable = {
                move = false,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },
    ['kurkakola']                   = {
        ['name'] = 'kurkakola',
        ['label'] = 'Cola',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'cola.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.15,
        ['delete'] = false,
        ['object'] = 'prop_ecola_can',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'For all the thirsty out there',
        ['client'] = {
            status = {
                thirst = 150000,
            },
            usetime = 2500,
            anim = {
                dict = 'mp_player_intdrink',
                clip = 'loop_bottle'
            },
            prop = {
                model = 'prop_ecola_can',
                bone = 18905,
                pos = vec3(0.120000, 0.008000, 0.030000),
                rot = vec3(240.000000, -60.000000, 0.000000)
            },
            disable = {
                move = false,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },

    -- Alcohol
    ['beer']                        = {
        ['name'] = 'beer',
        ['label'] = 'Beer',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'beer.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.10,
        ['delete'] = false,
        ['object'] = 'prop_beer_am',
        ['description'] = 'Nothing like a good cold beer!',
        ['client'] = {
            status = {
                thirst = 50000,
            },
            usetime = 5000,
            anim = {
                dict = 'amb@world_human_drinking@beer@male@idle_a',
                clip = 'idle_c'
            },
            prop = {
                model = 'prop_amb_beer_bottle',
                bone = 28422,
                pos = vec3(0.000000, 0.000000, 0.060000),
                rot = vec3(0.000000, 15.000000, 0.000000)
            },
            disable = {
                move = false,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },
    ['whiskey']                     = {
        ['name'] = 'whiskey',
        ['label'] = 'Whiskey',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'whiskey.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.10,
        ['delete'] = false,
        ['object'] = 'p_whiskey_bottle_s',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'For all the thirsty out there',
        ['client'] = {
            status = {
                thirst = 50000,
            },
            usetime = 5000,
            anim = {
                dict = 'mp_player_intdrink',
                clip = 'loop_bottle'
            },
            prop = {
                model = 'prop_cs_whiskey_bottle',
                bone = 60309,
                pos = vec3(0.000000, 0.000000, 0.000000),
                rot = vec3(0.000000, 0.000000, 0.000000)
            },
            disable = {
                move = false,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },
    ['vodka']                       = {
        ['name'] = 'vodka',
        ['label'] = 'Vodka',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'vodka.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 3.0,
        ['delete'] = false,
        ['object'] = 'prop_vodka_bottle',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'For all the thirsty out there',
        ['client'] = {
            status = {
                thirst = 50000,
            },
            usetime = 5000,
            anim = {
                dict = 'mp_player_intdrink',
                clip = 'loop_bottle'
            },
            prop = {
                model = 'prop_vodka_bottle',
                bone = 18905,
                pos = vec3(0.000000, -0.260000, 0.100000),
                rot = vec3(240.000000, -60.000000, 0.000000)
            },
            disable = {
                move = false,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },
    ['grape']                       = {
        ['name'] = 'grape',
        ['label'] = 'Grape',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'grape.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.08,
        ['delete'] = false,
        ['object'] = 'prop_wine_rose',
        ['description'] = 'Mmmmh yummie, grapes'
    },
    ['wine']                        = {
        ['name'] = 'wine',
        ['label'] = 'Wine',
        ['weight'] = 300,
        ['type'] = 'item',
        ['image'] = 'wine.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.15,
        ['delete'] = false,
        ['object'] = 'prop_wine_red',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Some good wine to drink on a fine evening',
        ['client'] = {
            status = {
                thirst = 50000,
            },
            usetime = 5000,
            anim = {
                dict = 'mp_player_intdrink',
                clip = 'loop_bottle'
            },
            prop = {
                model = 'prop_wine_red',
                bone = 18905,
                pos = vec3(0.000000, -0.260000, 0.100000),
                rot = vec3(240.000000, -60.000000, 0.000000)
            },
            disable = {
                move = false,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },
    ['grapejuice']                  = {
        ['name'] = 'grapejuice',
        ['label'] = 'Grape Juice',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'grapejuice.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.05,
        ['delete'] = false,
        ['object'] = 'prop_drink_redwine',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Grape juice is said to be healthy'
    },

    -- Drugs
    ['joint']                       = {
        ['name'] = 'joint',
        ['label'] = 'Joint',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'joint.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['created'] = nil,
        ['decay'] = 0.10,
        ['delete'] = false,
        ['object'] = 'p_amb_joint_01',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Sidney would be very proud at you',
        ['client'] = {
            usetime = 7500,
            anim = {
                dict = 'amb@world_human_smoking@male@male_a@enter',
                clip = 'enter'
            },
            prop = {
                model = 'p_cs_joint_02',
                bone = 47419,
                pos = vec3(0.015000, -0.009000, 0.003000),
                rot = vec3(55.000000, 0.000000, 110.000000)
            },
            disable = {
                move = false,
                car = true,
                mouse = false,
                combat = true,
            },
            removeAfterUse = true
        }
    },
    ['cokebaggy']                   = {
        ['name'] = 'cokebaggy',
        ['label'] = 'Bag of Coke',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'cokebaggy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'bkr_prop_coke_doll',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'To get happy real quick'
    },
    ['crack_baggy']                 = {
        ['name'] = 'crack_baggy',
        ['label'] = 'Bag of Crack',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'crack_baggy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'bkr_prop_coke_cutblock_01',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'To get happy faster'
    },
    ['xtcbaggy']                    = {
        ['name'] = 'xtcbaggy',
        ['label'] = 'Bag of XTC',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'xtcbaggy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'bkr_prop_coke_doll',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Pop those pills baby'
    },
    ['weed_brick']                  = {
        ['name'] = 'weed_brick',
        ['label'] = 'Weed Brick',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'weed_brick.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'bkr_prop_weed_bigbag_01a',
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = '1KG Weed Brick to sell to large customers.'
    },
    ['coke_brick']                  = {
        ['name'] = 'coke_brick',
        ['label'] = 'Coke Brick',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'coke_brick.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'bkr_prop_coke_cut_02',
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Heavy package of cocaine, mostly used for deals and takes a lot of space'
    },
    ['coke_small_brick']            = {
        ['name'] = 'coke_small_brick',
        ['label'] = 'Coke Package',
        ['weight'] = 350,
        ['type'] = 'item',
        ['image'] = 'coke_small_brick.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'bkr_prop_coke_cutblock_01',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Small package of cocaine, mostly used for deals and takes a lot of space'
    },

    ['rolling_paper']               = {
        ['name'] = 'rolling_paper',
        ['label'] = 'Rolling Paper',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'rolling_paper.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['object'] = 'p_cs_papers_02',
        ['combinable'] = {
            accept = { 'weed_white-widow', 'weed_skunk', 'weed_purple-haze', 'weed_og-kush', 'weed_amnesia', 'weed_ak47' },
            reward = 'joint',
            anim = {
                ['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@',
                ['lib'] = 'weed_inspecting_high_base_inspector',
                ['text'] = 'Rolling joint',
                ['timeOut'] = 5000
            }
        },
        ['description'] = 'Paper made specifically for encasing and smoking tobacco or cannabis.'
    },

    -- Seed And Weed
    ['weed_whitewidow']             = {
        ['name'] = 'weed_whitewidow',
        ['label'] = 'White Widow 2g',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'weed_baggy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_weed_block_01',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A weed bag with 2g White Widow'
    },
    ['weed_skunk']                  = {
        ['name'] = 'weed_skunk',
        ['label'] = 'Skunk 2g',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'weed_baggy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_weed_block_01',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A weed bag with 2g Skunk'
    },
    ['weed_purplehaze']             = {
        ['name'] = 'weed_purplehaze',
        ['label'] = 'Purple Haze 2g',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'weed_baggy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_weed_block_01',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A weed bag with 2g Purple Haze'
    },
    ['weed_ogkush']                 = {
        ['name'] = 'weed_ogkush',
        ['label'] = 'OGKush 2g',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'weed_baggy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_weed_block_01',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A weed bag with 2g OG Kush'
    },
    ['weed_amnesia']                = {
        ['name'] = 'weed_amnesia',
        ['label'] = 'Amnesia 2g',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'weed_baggy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_weed_block_01',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A weed bag with 2g Amnesia'
    },
    ['weed_ak47']                   = {
        ['name'] = 'weed_ak47',
        ['label'] = 'AK47 2g',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'weed_baggy.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_weed_block_01',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A weed bag with 2g AK47'
    },
    ['weed_whitewidow_seed']        = {
        ['name'] = 'weed_whitewidow_seed',
        ['label'] = 'White Widow Seed',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'weed_seed.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A weed seed of White Widow'
    },
    ['weed_skunk_seed']             = {
        ['name'] = 'weed_skunk_seed',
        ['label'] = 'Skunk Seed',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'weed_seed.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A weed seed of Skunk'
    },
    ['weed_purplehaze_seed']        = {
        ['name'] = 'weed_purplehaze_seed',
        ['label'] = 'Purple Haze Seed',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'weed_seed.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A weed seed of Purple Haze'
    },
    ['weed_ogkush_seed']            = {
        ['name'] = 'weed_ogkush_seed',
        ['label'] = 'OGKush Seed',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'weed_seed.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A weed seed of OG Kush'
    },
    ['weed_amnesia_seed']           = {
        ['name'] = 'weed_amnesia_seed',
        ['label'] = 'Amnesia Seed',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'weed_seed.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A weed seed of Amnesia'
    },
    ['weed_ak47_seed']              = {
        ['name'] = 'weed_ak47_seed',
        ['label'] = 'AK47 Seed',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'weed_seed.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A weed seed of AK47'
    },
    ['empty_weed_bag']              = {
        ['name'] = 'empty_weed_bag',
        ['label'] = 'Empty Weed Bag',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'weed_baggy_empty.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A small empty bag'
    },
    ['weed_nutrition']              = {
        ['name'] = 'weed_nutrition',
        ['label'] = 'Plant Fertilizer',
        ['weight'] = 2000,
        ['type'] = 'item',
        ['image'] = 'weed_nutrition.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'ng_proc_oilcan01a',
        ['description'] = 'Plant nutrition'
    },

    -- Material
    ['plastic']                     = {
        ['name'] = 'plastic',
        ['label'] = 'Plastic',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'plastic.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'RECYCLE! - Greta Thunberg 2019'
    },
    ['metalscrap']                  = {
        ['name'] = 'metalscrap',
        ['label'] = 'Metal Scrap',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'metalscrap.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'You can probably make something nice out of this'
    },
    ['copper']                      = {
        ['name'] = 'copper',
        ['label'] = 'Copper',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'copper.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Nice piece of metal that you can probably use for something'
    },
    ['aluminum']                    = {
        ['name'] = 'aluminum',
        ['label'] = 'Aluminium',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'aluminum.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Nice piece of metal that you can probably use for something'
    },
    ['aluminumoxide']               = {
        ['name'] = 'aluminumoxide',
        ['label'] = 'Aluminium Powder',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'aluminumoxide.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Some powder to mix with'
    },
    ['iron']                        = {
        ['name'] = 'iron',
        ['label'] = 'Iron',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'iron.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Handy piece of metal that you can probably use for something'
    },
    ['ironoxide']                   = {
        ['name'] = 'ironoxide',
        ['label'] = 'Iron Powder',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'ironoxide.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['rare'] = 'epic', -- epic, legendary, common
        ['combinable'] = {
            accept = { 'aluminumoxide' },
            reward = 'thermite',
            anim = {
                ['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@',
                ['lib'] = 'weed_inspecting_high_base_inspector',
                ['text'] = 'Mixing powder..',
                ['timeOut'] = 10000
            }
        },
        ['description'] = 'Some powder to mix with.'
    },
    ['steel']                       = {
        ['name'] = 'steel',
        ['label'] = 'Steel',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'steel.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Nice piece of metal that you can probably use for something'
    },
    ['rubber']                      = {
        ['name'] = 'rubber',
        ['label'] = 'Rubber',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'rubber.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Rubber, I believe you can make your own rubber ducky with it :D'
    },
    ['glass']                       = {
        ['name'] = 'glass',
        ['label'] = 'Glass',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'glass.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'It is very fragile, watch out'
    },
    ['motelkey']                    = {
        ['name'] = 'motelkey',
        ['label'] = 'Motel Key',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'motelkey.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Damn you lost your key again?'
    },
    ['chain']                       = {
        ['name'] = 'chain',
        ['label'] = 'Chain',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'goldchain.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'It is very fragile, watch out'
    },
    ['watch']                       = {
        ['name'] = 'watch',
        ['label'] = 'Watch',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'rolex.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'It is very fragile, watch out'
    },
    ['bottle']                      = {
        ['name'] = 'bottle',
        ['label'] = 'Empty Bottle',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'bottle.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = ''
    },
    ['can']                         = {
        ['name'] = 'can',
        ['label'] = 'Empty Can',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'can.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = ''
    },
    ['recyclablematerial']          = {
        ['name'] = 'recyclablematerial',
        ['label'] = 'Recycling Box',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'recyclablematerial.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = ''
    },

    -- Tools
    ['lockpick']                    = {
        ['name'] = 'lockpick',
        ['label'] = 'Lockpick',
        ['weight'] = 300,
        ['type'] = 'item',
        ['image'] = 'lockpick.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['rare'] = 'common', -- epic, legendary, common
        ['combinable'] = {
            accept = { 'screwdriverset' },
            reward = 'advancedlockpick',
            anim = {
                ['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@',
                ['lib'] = 'weed_inspecting_high_base_inspector',
                ['text'] = 'Crafting lockpick',
                ['timeOut'] = 7500
            }
        },
        ['description'] = 'Very useful if you lose your keys a lot.. or if you want to use it for something else...'
    },
    ['advancedlockpick']            = {
        ['name'] = 'advancedlockpick',
        ['label'] = 'Advanced Lockpick',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'advancedlockpick.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'If you lose your keys a lot this is very useful... Also useful to open your beers'
    },
    ['electronickit']               = {
        ['name'] = 'electronickit',
        ['label'] = 'Electronic Kit',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'electronickit.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['rare'] = 'epic', -- epic, legendary, common
        ['combinable'] = { accept = { 'gatecrack' }, reward = 'trojan_usb', anim = nil },
        ['description'] =
        "If you've always wanted to build a robot you can maybe start here. Maybe you'll be the new Elon Musk?"
    },
    ['gatecrack']                   = {
        ['name'] = 'gatecrack',
        ['label'] = 'Gatecrack',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'usb_device.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Handy software to tear down some fences'
    },
    ['thermite']                    = {
        ['name'] = 'thermite',
        ['label'] = 'Thermite',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'thermite.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = "Sometimes you'd wish for everything to burn"
    },
    ['trojan_usb']                  = {
        ['name'] = 'trojan_usb',
        ['label'] = 'Trojan USB',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'usb_device.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Handy software to shut down some systems'
    },
    ['screwdriverset']              = {
        ['name'] = 'screwdriverset',
        ['label'] = 'Toolkit',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'screwdriverset.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Very useful to screw... screws...'
    },
    ['drill']                       = {
        ['name'] = 'drill',
        ['label'] = 'Drill',
        ['weight'] = 20000,
        ['type'] = 'item',
        ['image'] = 'drill.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'The real deal...'
    },
    ['phone_dongle']                = {
        ['name'] = 'phone_dongle',
        ['label'] = 'Phone Dongle',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'phone_dongle.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Telephone key to make a bypass, maybe...'
    },
    ['powerbank']                   = {
        ['name'] = 'powerbank',
        ['label'] = 'Power Bank',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'powerbank.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['description'] = 'Portable charger for high-end phones'
    },

    -- Vehicle Tools
    ['nitrous']                     = {
        ['name'] = 'nitrous',
        ['label'] = 'Nitrous',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'nitrous.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Speed up, gas pedal! :D'
    },
    ['repairkit']                   = {
        ['name'] = 'repairkit',
        ['label'] = 'Repairkit',
        ['weight'] = 2500,
        ['type'] = 'item',
        ['image'] = 'repairkit.png',
        ['job'] = { 'mechanic', 'mechanic1', 'mechanic2', 'mechanic3' },
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice toolbox with stuff to repair your vehicle'
    },
    ['advancedrepairkit']           = {
        ['name'] = 'advancedrepairkit',
        ['label'] = 'Advanced Repairkit',
        ['weight'] = 4000,
        ['type'] = 'item',
        ['image'] = 'advancedkit.png',
        ['job'] = { 'mechanic', 'mechanic1', 'mechanic2', 'mechanic3' },
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A nice toolbox with stuff to repair your vehicle'
    },
    ['weapon_repairkit']            = {
        ['name'] = 'weapon_repairkit',
        ['label'] = 'Weapon Repairkit',
        ['weight'] = 4000,
        ['type'] = 'item',
        ['image'] = 'advancedkit.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A nice toolbox with stuff to repair your weapon'
    },
    ['cleaningkit']                 = {
        ['name'] = 'cleaningkit',
        ['label'] = 'Cleaning Kit',
        ['weight'] = 250,
        ['type'] = 'item',
        ['image'] = 'cleaningkit.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A microfiber cloth with some soap will let your car sparkle again!'
    },
    ['harness']                     = {
        ['name'] = 'harness',
        ['label'] = 'Race Harness',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'harness.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Racing Harness so no matter what you stay in the car'
    },
    ['jerry_can']                   = {
        ['name'] = 'jerry_can',
        ['label'] = 'Jerrycan 20L',
        ['weight'] = 20000,
        ['type'] = 'item',
        ['image'] = 'jerry_can.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A can full of Fuel'
    },
    ['tirerepairkit']               = {
        ['name'] = 'tirerepairkit',
        ['label'] = 'Tire Repair Kit',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'tirerepairkit.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A can full of Fuel'
    },

    -- Medication
    ['firstaid']                    = {
        ['name'] = 'firstaid',
        ['label'] = 'First Aid',
        ['weight'] = 2500,
        ['type'] = 'item',
        ['image'] = 'firstaid.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'You can use this First Aid kit to get people back on their feet'
    },
    ['bandage']                     = {
        ['name'] = 'bandage',
        ['label'] = 'Bandage',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'bandage.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A bandage works every time'
    },
    ['ifaks']                       = {
        ['name'] = 'ifaks',
        ['label'] = 'ifaks',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'ifaks.png',
        ['unique'] = false,
        ['job'] = { 'police', 'bcso' },
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'ifaks for healing and a complete stress remover.'
    },
    ['painkillers']                 = {
        ['name'] = 'painkillers',
        ['label'] = 'Painkillers',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'painkillers.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = "For pain you can't stand anymore, take this pill that'd make you feel great again"
    },
    ['walkstick']                   = {
        ['name'] = 'walkstick',
        ['label'] = 'Walking Stick',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'walkstick.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = "Walking stick for ya'll grannies out there.. HAHA"
    },

    -- Communication
    ['phone']                       = {
        ['name'] = 'phone',
        ['label'] = 'Classic Phone',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'phone.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_amb_phone',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'They say that Quasar Smartphone is the same as an iPhone, what do you think?'
    },
    ['black_phone']                 = {
        ['name'] = 'black_phone',
        ['label'] = 'Black Phone',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'black_phone.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_amb_phone',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'They say that Quasar Smartphone is the same as an iPhone, what do you think?'
    },
    ['yellow_phone']                = {
        ['name'] = 'yellow_phone',
        ['label'] = 'Yellow Phone',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'yellow_phone.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_amb_phone',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'They say that Quasar Smartphone is the same as an iPhone, what do you think?'
    },
    ['red_phone']                   = {
        ['name'] = 'red_phone',
        ['label'] = 'Red Phone',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'red_phone.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_amb_phone',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'They say that Quasar Smartphone is the same as an iPhone, what do you think?'
    },
    ['green_phone']                 = {
        ['name'] = 'green_phone',
        ['label'] = 'Green Phone',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'green_phone.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_amb_phone',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'They say that Quasar Smartphone is the same as an iPhone, what do you think?'
    },
    ['white_phone']                 = {
        ['name'] = 'white_phone',
        ['label'] = 'White Phone',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'white_phone.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_amb_phone',
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'They say that Quasar Smartphone is the same as an iPhone, what do you think?'
    },
    ['radio']                       = {
        ['name'] = 'radio',
        ['label'] = 'Radio',
        ['weight'] = 2000,
        ['type'] = 'item',
        ['image'] = 'radio.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_cs_hand_radio',
        ['description'] = 'You can communicate with this through a signal'
    },
    ['laptop']                      = {
        ['name'] = 'laptop',
        ['label'] = 'Laptop',
        ['weight'] = 4000,
        ['type'] = 'item',
        ['image'] = 'laptop.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'bkr_prop_clubhouse_laptop_01a',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Expensive laptop'
    },
    ['tablet']                      = {
        ['name'] = 'tablet',
        ['label'] = 'Tablet',
        ['weight'] = 2000,
        ['type'] = 'item',
        ['image'] = 'tablet.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'prop_cs_tablet',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Expensive tablet'
    },
    ['radioscanner']                = {
        ['name'] = 'radioscanner',
        ['label'] = 'Radio Scanner',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'radioscanner.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'With this you can get some police alerts. Not 100% effective however'
    },
    ['pinger']                      = {
        ['name'] = 'pinger',
        ['label'] = 'Pinger',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'pinger.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'With a pinger and your phone you can send out your location'
    },
    ['fitbit']                      = {
        ['name'] = 'fitbit',
        ['label'] = 'Fitbit',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'fitbit.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = ''
    },
    -- Theft and Jewelry
    ['rolex']                       = {
        ['name'] = 'rolex',
        ['label'] = 'Golden Watch',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'rolex.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'A golden watch seems like the jackpot to me!'
    },
    ['diamond_ring']                = {
        ['name'] = 'diamond_ring',
        ['label'] = 'Diamond Ring',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'diamond_ring.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A diamond ring seems like the jackpot to me!'
    },
    ['diamond_ring_mining']         = {
        ['name'] = 'diamond_ring_mining',
        ['label'] = 'Diamond Ring (Gold)',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'diamond_ring_mining.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A crafted diamond ring (mining)'
    },
    ['diamond_necklace']            = {
        ['name'] = 'diamond_necklace',
        ['label'] = 'Diamond Necklace',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'diamond_necklace.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A diamond necklace seems like the jackpot to me!'
    },
    ['emerald_ring']                = {
        ['name'] = 'emerald_ring',
        ['label'] = 'Emerald Ring (Gold)',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'emerald_ring.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'An emerald ring seems like the jackpot to me!'
    },
    ['emerald_necklace']            = {
        ['name'] = 'emerald_necklace',
        ['label'] = 'Emerald Necklace (Gold)',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'emerald_necklace.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'An emerald necklace seems like the jackpot to me!'
    },
    ['ruby_ring']                   = {
        ['name'] = 'ruby_ring',
        ['label'] = 'Ruby Ring (Gold)',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'ruby_ring.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A ruby ring seems like the jackpot to me!'
    },
    ['ruby_necklace']               = {
        ['name'] = 'ruby_necklace',
        ['label'] = 'Ruby Necklace (Gold)',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'ruby_necklace.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A ruby necklace seems like the jackpot to me!'
    },
    ['sapphire_ring']               = {
        ['name'] = 'sapphire_ring',
        ['label'] = 'Sapphire Ring (Gold)',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'sapphire_ring.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A sapphire ring seems like the jackpot to me!'
    },
    ['sapphire_necklace']           = {
        ['name'] = 'sapphire_necklace',
        ['label'] = 'Sapphire Necklace (Gold)',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'sapphire_necklace.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A sapphire necklace seems like the jackpot to me!'
    },
    ['tanzanite_ring']              = {
        ['name'] = 'tanzanite_ring',
        ['label'] = 'Tanzanite Ring (Gold)',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'tanzanite_ring.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A tanzanite ring seems like the jackpot to me!'
    },
    ['tanzanite_necklace']          = {
        ['name'] = 'tanzanite_necklace',
        ['label'] = 'Tanzanite Necklace (Gold)',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'tanzanite_necklace.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A tanzanite necklace seems like the jackpot to me!'
    },
    ['celestial_gemfall_necklace']  = {
        ['name'] = 'celestial_gemfall_necklace',
        ['label'] = 'Celestial Gemfall Necklace',
        ['weight'] = 2000,
        ['type'] = 'item',
        ['image'] = 'celestial_gemfall_necklace.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A masterwork necklace set with many precious gems.'
    },
    ['diamond']                     = {
        ['name'] = 'diamond',
        ['label'] = 'Diamond',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'diamond.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'A diamond seems like the jackpot to me!'
    },
    ['diamond_mining']              = {
        ['name'] = 'diamond_mining',
        ['label'] = 'Diamond',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'diamond_mining.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'A diamond seems like the jackpot to me!'
    },
    ['goldchain']                   = {
        ['name'] = 'goldchain',
        ['label'] = 'Golden Chain',
        ['weight'] = 1500,
        ['type'] = 'item',
        ['image'] = 'goldchain.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'A golden chain seems like the jackpot to me!'
    },
    ['gold_ring']                   = {
        ['name'] = 'gold_ring',
        ['label'] = 'Gold Ring',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'gold_ring.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['description'] = 'A handcrafted gold ring.'
    },
    ['tenkgoldchain']               = {
        ['name'] = 'tenkgoldchain',
        ['label'] = '10k Gold Chain',
        ['weight'] = 2000,
        ['type'] = 'item',
        ['image'] = '10kgoldchain.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = '10 carat golden chain'
    },
    ['goldbar']                     = {
        ['name'] = 'goldbar',
        ['label'] = 'Gold Bar',
        ['weight'] = 300,
        ['type'] = 'item',
        ['image'] = 'goldbar.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Looks pretty expensive to me'
    },
    ['small_tv']                    = {
        ['name'] = 'small_tv',
        ['label'] = 'Small TV',
        ['weight'] = 30000,
        ['type'] = 'item',
        ['image'] = 'placeholder.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'TV'
    },
    ['toaster']                     = {
        ['name'] = 'toaster',
        ['label'] = 'Toaster',
        ['weight'] = 18000,
        ['type'] = 'item',
        ['image'] = 'placeholder.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Toast'
    },
    ['microwave']                   = {
        ['name'] = 'microwave',
        ['label'] = 'Microwave',
        ['weight'] = 46000,
        ['type'] = 'item',
        ['image'] = 'placeholder.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Microwave'
    },

    -- Cops Tools
    ['armor']                       = {
        ['name'] = 'armor',
        ['label'] = 'PD Armor',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'armor.png',
        ['unique'] = false,
        ['job'] = { 'police', 'bcso' },
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = "Only For PD Woohaa"
    },
    ['heavyarmor']                  = {
        ['name'] = 'heavyarmor',
        ['label'] = 'Heavy Armor',
        ['weight'] = 3000,
        ['type'] = 'item',
        ['image'] = 'armor.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = "Some protection won't hurt... right?"
    },
    ['handcuffs']                   = {
        ['name'] = 'handcuffs',
        ['label'] = 'Handcuffs',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'handcuffs.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Comes in handy when people misbehave. Maybe it can be used for something else?'
    },
    ['police_stormram']             = {
        ['name'] = 'police_stormram',
        ['label'] = 'Stormram',
        ['weight'] = 18000,
        ['type'] = 'item',
        ['image'] = 'police_stormram.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'A nice tool to break into doors'
    },
    ['empty_evidence_bag']          = {
        ['name'] = 'empty_evidence_bag',
        ['label'] = 'Empty Evidence Bag',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'evidence.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_paper_bag_01',
        ['description'] = 'Used a lot to keep DNA from blood, bullet shells and more'
    },
    ['filled_evidence_bag']         = {
        ['name'] = 'filled_evidence_bag',
        ['label'] = 'Evidence Bag',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'evidence.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['object'] = 'prop_paper_bag_01',
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A filled evidence bag to see who committed the crime >:('
    },

    -- Firework Tools
    ['firework1']                   = {
        ['name'] = 'firework1',
        ['label'] = '2Brothers',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'firework1.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'ind_prop_firework_01',
        ['description'] = 'Fireworks'
    },
    ['firework2']                   = {
        ['name'] = 'firework2',
        ['label'] = 'Poppelers',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'firework2.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'ind_prop_firework_01',
        ['description'] = 'Fireworks'
    },
    ['firework3']                   = {
        ['name'] = 'firework3',
        ['label'] = 'WipeOut',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'firework3.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'ind_prop_firework_01',
        ['description'] = 'Fireworks'
    },
    ['firework4']                   = {
        ['name'] = 'firework4',
        ['label'] = 'Weeping Willow',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'firework4.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = 'ind_prop_firework_01',
        ['description'] = 'Fireworks'
    },

    -- Sea Tools
    ['dendrogyra_coral']            = {
        ['name'] = 'dendrogyra_coral',
        ['label'] = 'Dendrogyra',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'dendrogyra_coral.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'Its also known as pillar coral'
    },
    ['antipatharia_coral']          = {
        ['name'] = 'antipatharia_coral',
        ['label'] = 'Antipatharia',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'antipatharia_coral.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Its also known as black corals or thorn corals'
    },
    ['diving_gear']                 = {
        ['name'] = 'diving_gear',
        ['label'] = 'Diving Gear',
        ['weight'] = 30000,
        ['type'] = 'item',
        ['image'] = 'diving_gear.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'An oxygen tank and a rebreather'
    },
    ['diving_fill']                 = {
        ['name'] = 'diving_fill',
        ['label'] = 'Diving Tube',
        ['weight'] = 3000,
        ['type'] = 'item',
        ['image'] = 'diving_fill.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'An oxygen tube and a rebreather'
    },

    -- Other Tools
    ['cash']                        = {
        ['name'] = 'cash',
        ['label'] = 'Cash',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'cash.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Cash'
    },
    ['black_money']                 = {
        ['name'] = 'black_money',
        ['label'] = 'Black Money',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'markedbills.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Black Money'
    },
    ['casinochips']                 = {
        ['name'] = 'casinochips',
        ['label'] = 'Casino Chips',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'casinochips.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['description'] = 'Chips For Casino Gambling'
    },
    ['stickynote']                  = {
        ['name'] = 'stickynote',
        ['label'] = 'Sticky note',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'stickynote.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['description'] = 'Sometimes handy to remember something :)'
    },
    ['moneybag']                    = {
        ['name'] = 'moneybag',
        ['label'] = 'Bag', 
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'moneybag.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] = 'A bag with cash'
    },
    ['parachute']                   = {
        ['name'] = 'parachute',
        ['label'] = 'Parachute',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'parachute.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['description'] = 'A standard parachute to ensure a safe landing.',
    },
    ['binoculars']                  = {
        ['name'] = 'binoculars',
        ['label'] = 'Binoculars',
        ['weight'] = 600,
        ['type'] = 'item',
        ['image'] = 'binoculars.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Sneaky Breaky...'
    },
    ['cigarettebox']                = {
        ['name'] = 'cigarettebox',
        ['label'] = 'Cigarette Box',
        ['weight'] = 5,
        ['type'] = 'item',
        ['image'] = 'cigarettebox.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Open it, there will be 20 cigarettes inside'
    },
    ['cigarette']                   = {
        ['name'] = 'cigarette',
        ['label'] = 'Cigarette',
        ['weight'] = 1,
        ['type'] = 'item',
        ['image'] = 'cigarette.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['description'] = 'A cigar, a simple cigarette...'
    },
    ['lighter']                     = {
        ['name'] = 'lighter',
        ['label'] = 'Lighter',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'lighter.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'On new years eve a nice fire to stand next to'
    },
    ['certificate']                 = {
        ['name'] = 'certificate',
        ['label'] = 'Certificate',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'certificate.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Certificate that proves you own certain stuff'
    },
    ['markedbills']                 = {
        ['name'] = 'markedbills',
        ['label'] = 'Marked Money',
        ['weight'] = 1000,
        ['type'] = 'item',
        ['image'] = 'markedbills.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'epic', -- epic, legendary, common
        ['description'] = 'Money?'
    },
    ['labkey']                      = {
        ['name'] = 'labkey',
        ['label'] = 'Key',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'labkey.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['rare'] = 'legendary', -- epic, legendary, common
        ['description'] = 'Key for a lock...?'
    },
    ['printerdocument']             = {
        ['name'] = 'printerdocument',
        ['label'] = 'Document',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'printerdocument.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice document'
    },

    -- Backpack
    ['backpack']                    = {
        ['name'] = 'backpack',
        ['label'] = 'Backpack',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'backpack1.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'No have'
    },
    ['backpack2']                   = {
        ['name'] = 'backpack2',
        ['label'] = 'backpack2',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'backpack2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'No have'
    },
    ['briefcase']                   = {
        ['name'] = 'briefcase',
        ['label'] = 'briefcase',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'weapon_briefcase.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'No have'
    },
    ['paramedicbag']                = {
        ['name'] = 'paramedicbag',
        ['label'] = 'paramedicbag',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'veh_toolbox.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'No have'
    },

    -- Coal Items
    ['coal_ore']                    = {
        ['name'] = 'coal_ore',
        ['label'] = 'Coal Ore',
        ['weight'] = 250,
        ['type'] = 'item',
        ['image'] = 'coal_ore.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A piece of coal ore.'
    },
    ['flint']                       = {
        ['name'] = 'flint',
        ['label'] = 'Flint',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'flint.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A sharp piece of flint.'
    },
    ['sulfur_chunk']                = {
        ['name'] = 'sulfur_chunk',
        ['label'] = 'Sulfur Chunk',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'sulfur_chunk.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A chunk of sulfur.'
    },

    -- Gold Items
    ['gold_nugget']                 = {
        ['name'] = 'gold_nugget',
        ['label'] = 'Gold Nugget',
        ['weight'] = 250,
        ['type'] = 'item',
        ['image'] = 'gold_nugget.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A small nugget of gold.'
    },
    ['gold_dust']                   = {
        ['name'] = 'gold_dust',
        ['label'] = 'Gold Dust',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'gold_dust.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A pinch of gold dust.'
    },
    ['quartz_crystal']              = {
        ['name'] = 'quartz_crystal',
        ['label'] = 'Quartz Crystal',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'quartz_crystal.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A clear quartz crystal.'
    },
    -- Emerald Items
    ['emerald_crystal']             = {
        ['name'] = 'emerald_crystal',
        ['label'] = 'Emerald Crystal',
        ['weight'] = 250,
        ['type'] = 'item',
        ['image'] = 'emerald_crystal.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A radiant emerald crystal.'
    },
    ['beryl_chunk']                 = {
        ['name'] = 'beryl_chunk',
        ['label'] = 'Beryl Chunk',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'beryl_chunk.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A chunk of beryl.'
    },
    ['green_garnet']                = {
        ['name'] = 'green_garnet',
        ['label'] = 'Green Garnet',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'green_garnet.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A precious green garnet.'
    },

    -- Ruby Items
    ['ruby_crystal']                = {
        ['name'] = 'ruby_crystal',
        ['label'] = 'Ruby Crystal',
        ['weight'] = 250,
        ['type'] = 'item',
        ['image'] = 'ruby_crystal.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A brilliant ruby crystal.'
    },
    ['corundum_chunk']              = {
        ['name'] = 'corundum_chunk',
        ['label'] = 'Corundum Chunk',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'corundum_chunk.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A chunk of corundum.'
    },
    ['pink_sapphire']               = {
        ['name'] = 'pink_sapphire',
        ['label'] = 'Pink Sapphire',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'pink_sapphire.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A delicate pink sapphire.'
    },

    -- Amethyst Items
    ['amethyst_geode']              = {
        ['name'] = 'amethyst_geode',
        ['label'] = 'Amethyst Geode',
        ['weight'] = 250,
        ['type'] = 'item',
        ['image'] = 'amethyst_geode.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A beautiful amethyst geode.'
    },
    ['purple_quartz']               = {
        ['name'] = 'purple_quartz',
        ['label'] = 'Purple Quartz',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'purple_quartz.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A piece of purple quartz.'
    },
    ['clear_crystal']               = {
        ['name'] = 'clear_crystal',
        ['label'] = 'Clear Crystal',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'clear_crystal.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A clear and pristine crystal.'
    },

    -- Diamond Items
    ['diamond_crystal']             = {
        ['name'] = 'diamond_crystal',
        ['label'] = 'Diamond Crystal',
        ['weight'] = 250,
        ['type'] = 'item',
        ['image'] = 'diamond_crystal.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'An exquisite diamond crystal.'
    },
    ['graphite_chunk']              = {
        ['name'] = 'graphite_chunk',
        ['label'] = 'Graphite Chunk',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'graphite_chunk.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A chunk of graphite.'
    },
    ['blue_diamond']                = {
        ['name'] = 'blue_diamond',
        ['label'] = 'Blue Diamond',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'blue_diamond.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A rare and valuable blue diamond.'
    },

    -- Clothes
    ['tshirt']                      = {
        ['name'] = 'tshirt',
        ['label'] = 'T-shirt',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'tshirt.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },
    ['torso']                       = {
        ['name'] = 'torso',
        ['label'] = 'Torso',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'torso.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },
    ['arms']                        = {
        ['name'] = 'arms',
        ['label'] = 'Arms',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'arms.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },
    ['jeans']                       = {
        ['name'] = 'jeans',
        ['label'] = 'Jeans',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'jeans.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },
    ['shoes']                       = {
        ['name'] = 'shoes',
        ['label'] = 'Shoes',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'shoes.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },
    ['mask']                        = {
        ['name'] = 'mask',
        ['label'] = 'Mask',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'mask.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },
    ['ears']                        = {
        ['name'] = 'ears',
        ['label'] = 'Ears',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'ears.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },
    ['glasses']                     = {
        ['name'] = 'glasses',
        ['label'] = 'Glasses',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'glasses.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },
    ['helmet']                      = {
        ['name'] = 'helmet',
        ['label'] = 'Helmet',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'helmet.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },
    ['bag']                         = {
        ['name'] = 'bag',
        ['label'] = 'Bag',
        ['weight'] = 0,
        ['type'] = 'item',
        ['image'] = 'bag.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A nice piece of clothing'
    },

    -- Trading Cards
    ['tradingcard_psa']             = {
        ['name'] = 'tradingcard_psa',
        ['label'] = 'Card Psa',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'tradingcard_psa.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Letter verified with PSA, lets wait for your qualification!'
    },
    ['tradingcard_stash']           = {
        ['name'] = 'tradingcard_stash',
        ['label'] = 'Card Book',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'tradingcard_stash.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Album for collectible cards!'
    },
    ['tradingcard_basic']           = {
        ['name'] = 'tradingcard_basic',
        ['label'] = 'Card Basic',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'tradingcard_basic.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Basic letter, it will serve for your collection'
    },
    ['tradingcard_rare']            = {
        ['name'] = 'tradingcard_rare',
        ['label'] = 'Card Rare',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'tradingcard_rare.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'This letter is strange, how crazy...'
    },
    ['tradingcard_legendary']       = {
        ['name'] = 'tradingcard_legendary',
        ['label'] = 'Card Legendary',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'tradingcard_legendary.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A card of peculiar rarity, I would say legendary!'
    },
    ['tradingcard_booster_pack']    = {
        ['name'] = 'tradingcard_booster_pack',
        ['label'] = 'Card Booster Pack',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'tradingcard_booster_pack.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Pack with random TCG cards'
    },
    ['tradingcard_booster_legends'] = {
        ['name'] = 'tradingcard_booster_legends',
        ['label'] = 'Card Booster Legends',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'tradingcard_booster_legends.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Pack with random TCG cards'
    },

    -- Drugs
    ['weed']                        = {
        ['name'] = 'weed',
        ['label'] = 'Marijuana',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'weed.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Hey brother, I think this is so natural...'
    },

    ['weed_packaged']               = {
        ['name'] = 'weed_packaged',
        ['label'] = 'Packaged Marijuana',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'weed_packaged.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Hey brother, I think this is so natural...'
    },

    ['cocaine']                     = {
        ['name'] = 'cocaine',
        ['label'] = 'Cocaine',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'cocaine.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'The powder of love, who would have thought it would be so addictive?'
    },

    ['cocaine_cut']                 = {
        ['name'] = 'cocaine_cut',
        ['label'] = 'Cut Cocaine',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'cocaine_cut.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'The powder of love, who would have thought it would be so addictive?'
    },

    ['cocaine_packaged']            = {
        ['name'] = 'cocaine_packaged',
        ['label'] = 'Packaged Cocaine',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'cocaine_packaged.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'The powder of love, who would have thought it would be so addictive?'
    },

    ['meth']                        = {
        ['name'] = 'meth',
        ['label'] = 'Methamphetamine',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'meth.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = "Oh shit brother, that's hard, very hard."
    },

    ['chemicals']                   = {
        ['name'] = 'chemicals',
        ['label'] = 'Chemicals',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'chemicals.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = "Oh shit brother, that's hard, very hard."
    },

    ['meth_packaged']               = {
        ['name'] = 'meth_packaged',
        ['label'] = 'Packaged Methamphetamine',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'meth_packaged.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = "Oh shit brother, that's hard, very hard."
    },

    ['sorted_money']                = {
        ['name'] = 'sorted_money',
        ['label'] = 'Sorted Money',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'sorted_money.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = "Oh shit brother, that's hard, very hard."
    },

    ['package_money']               = {
        ['name'] = 'package_money',
        ['label'] = 'Packaged Money',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'package_money.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = "Oh shit brother, that's hard, very hard."
    },
    -- idcards
    ['documents']                   = {
        ['name'] = 'documents',
        ['label'] = 'documents',
        ['weight'] = 1,
        ['type'] = 'item',
        ['image'] = 'id-card.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Documenti.'
    },
    ['drive']                       = {
        ['name'] = 'drive',
        ['label'] = 'drive',
        ['weight'] = 1,
        ['type'] = 'item',
        ['image'] = 'drive.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Documenti.'
    },
    ['weapons']                     = {
        ['name'] = 'weapons',
        ['label'] = 'weapons',
        ['weight'] = 1,
        ['type'] = 'item',
        ['image'] = 'weapons.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Weapon License'
    },

    ['cryptostick']                 = {
        ['name'] = 'cryptostick',
        ['label'] = 'cryptostick',
        ['weight'] = 1,
        ['type'] = 'item',
        ['image'] = 'cryptostick.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Special item.'
    },

    ['hacking_device']              = { ['name'] = 'hacking_device', ['label'] = 'Hacking Device', ['weight'] = 1, ['type'] = 'item', ['image'] = 'hacking_device.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['yacht_drill']                 = { ['name'] = 'yacht_drill', ['label'] = 'Yacht Drill', ['weight'] = 1, ['type'] = 'item', ['image'] = 'yacht_drill.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['laptop']                      = { ['name'] = 'laptop', ['label'] = 'Laptop', ['weight'] = 1, ['type'] = 'item', ['image'] = 'laptop.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['gold_award']                  = { ['name'] = 'gold_award', ['label'] = 'Gold Award', ['weight'] = 1, ['type'] = 'item', ['image'] = 'gold_award.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['drug_pack']                   = { ['name'] = 'drug_pack', ['label'] = 'Drug', ['weight'] = 1, ['type'] = 'item', ['image'] = 'drug_pack.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['whiskey']                     = { ['name'] = 'whiskey', ['label'] = 'Whiskey', ['weight'] = 1, ['type'] = 'item', ['image'] = 'whiskey.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['painting']                    = { ['name'] = 'painting', ['label'] = 'Painting', ['weight'] = 1, ['type'] = 'item', ['image'] = 'painting.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },

    -- Servicing Items
    engine_oil                      = { name = 'engine_oil', label = 'Engine Oil', weight = 1000, type = 'item', image = 'engine_oil.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    tyre_replacement                = { name = 'tyre_replacement', label = 'Tyre Replacement', weight = 1000, type = 'item', image = 'tyre_replacement.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    clutch_replacement              = { name = 'clutch_replacement', label = 'Clutch Replacement', weight = 1000, type = 'item', image = 'clutch_replacement.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    air_filter                      = { name = 'air_filter', label = 'Air Filter', weight = 1000, type = 'item', image = 'air_filter.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    spark_plug                      = { name = 'spark_plug', label = 'Spark Plug', weight = 1000, type = 'item', image = 'spark_plug.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    suspension_parts                = { name = 'suspension_parts', label = 'Suspension Parts', weight = 1000, type = 'item', image = 'suspension_parts.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    brakepad_replacement            = { name = 'brakepad_replacement', label = 'Brakepad Replacement', weight = 1000, type = 'item', image = 'brakepad_replacement.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    -- Engine Items
    i4_engine                       = { name = 'i4_engine', label = 'I4 Engine', weight = 1000, type = 'item', image = 'i4_engine.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    v6_engine                       = { name = 'v6_engine', label = 'V6 Engine', weight = 1000, type = 'item', image = 'v6_engine.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    v8_engine                       = { name = 'v8_engine', label = 'V8 Engine', weight = 1000, type = 'item', image = 'v8_engine.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    v12_engine                      = { name = 'v12_engine', label = 'V12 Engine', weight = 1000, type = 'item', image = 'v12_engine.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    v10_engine                      = { name = 'v10_engine', label = 'V10 Engine', weight = 1000, type = 'item', image = 'v10_engine.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    inline6_engine                  = { name = 'inline6_engine', label = '6-Cylinder Inline Engine', weight = 1000, type = 'item', image = 'inline6_engine.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    ['4stroke_engine']              = { name = '4stroke_engine', label = '4-Stroke Engine', weight = 1000, type = 'item', image = '4stroke_engine.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    ['5stroke_engine']              = { name = '5stroke_engine', label = '5-Stroke Engine', weight = 1000, type = 'item', image = '5stroke_engine.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    turbocharger                    = { name = 'turbocharger', label = 'Turbo', weight = 1000, type = 'item', image = 'turbocharger.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    -- Electric Engines
    ev_motor                        = { name = 'ev_motor', label = 'EV Motor', weight = 1000, type = 'item', image = 'ev_motor.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    ev_battery                      = { name = 'ev_battery', label = 'EV Battery', weight = 1000, type = 'item', image = 'ev_battery.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    ev_coolant                      = { name = 'ev_coolant', label = 'EV Coolant', weight = 1000, type = 'item', image = 'ev_coolant.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    -- Drivetrain Items
    awd_drivetrain                  = { name = 'awd_drivetrain', label = 'AWD Drivetrain', weight = 1000, type = 'item', image = 'awd_drivetrain.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    rwd_drivetrain                  = { name = 'rwd_drivetrain', label = 'RWD Drivetrain', weight = 1000, type = 'item', image = 'rwd_drivetrain.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    fwd_drivetrain                  = { name = 'fwd_drivetrain', label = 'FWD Drivetrain', weight = 1000, type = 'item', image = 'fwd_drivetrain.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    -- Tuning Items
    slick_tyres                     = { name = 'slick_tyres', label = 'Slick Tyres', weight = 1000, type = 'item', image = 'slick_tyres.png', unique = false, useable = false, shouldClose = true, combinable = true, description = nil },
    semi_slick_tyres                = { name = 'semi_slick_tyres', label = 'Semi Slick Tyres', weight = 1000, type = 'item', image = 'semi_slick_tyres.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    offroad_tyres                   = { name = 'offroad_tyres', label = 'Offroad Tyres', weight = 1000, type = 'item', image = 'offroad_tyres.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    ceramic_brakes                  = { name = 'ceramic_brakes', label = 'Ceramic Brakes', weight = 1000, type = 'item', image = 'ceramic_brakes.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    drift_tuning_kit                = { name = 'drift_tuning_kit', label = 'Drift Tuning Kit', weight = 1000, type = 'item', image = 'drift_tuning_kit.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    drag_tuning_kit                 = { name = 'drag_tuning_kit', label = 'Drag Tuning Kit', weight = 1000, type = 'item', image = 'drag_tuning_kit.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    street_race_tuning_kit          = { name = 'street_race_tuning_kit', label = 'Street Race Tuning Kit', weight = 1000, type = 'item', image = 'street_race_tuning_kit.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    cruise_tuning_kit               = { name = 'cruise_tuning_kit', label = 'Cruise Tuning Kit', weight = 1000, type = 'item', image = 'cruise_tuning_kit.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    quick_ratio_steering            = { name = 'quick_ratio_steering', label = 'Quick Ratio Steering', weight = 1000, type = 'item', image = 'quick_ratio_steering.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    standard_steering               = { name = 'standard_steering', label = 'Standard Steering', weight = 1000, type = 'item', image = 'standard_steering.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    slow_ratio_steering             = { name = 'slow_ratio_steering', label = 'Slow Ratio Steering', weight = 1000, type = 'item', image = 'slow_ratio_steering.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    race_steering                   = { name = 'race_steering', label = 'Race Steering', weight = 1000, type = 'item', image = 'race_steering.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    -- Suspension Tuning
    street_suspension               = { name = 'street_suspension', label = 'Street Suspension', weight = 1000, type = 'item', image = 'street_suspension.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    sport_suspension                = { name = 'sport_suspension', label = 'Sport Suspension', weight = 1000, type = 'item', image = 'sport_suspension.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    race_suspension                 = { name = 'race_suspension', label = 'Race Suspension', weight = 1000, type = 'item', image = 'race_suspension.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    -- Weight Reduction
    lightweight_parts               = { name = 'lightweight_parts', label = 'Lightweight Parts', weight = 1000, type = 'item', image = 'lightweight_parts.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    carbon_fiber_body               = { name = 'carbon_fiber_body', label = 'Carbon Fiber Body', weight = 1000, type = 'item', image = 'carbon_fiber_body.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    -- Aerodynamics
    street_spoiler                  = { name = 'street_spoiler', label = 'Street Spoiler', weight = 1000, type = 'item', image = 'street_spoiler.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    race_wing                       = { name = 'race_wing', label = 'Race Wing', weight = 1000, type = 'item', image = 'race_wing.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    -- Transmission Tuning
    ['6speed_manual']               = { name = '6speed_manual', label = '6-Speed Manual', weight = 1000, type = 'item', image = '6speed_manual.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    ['8speed_auto']                 = { name = '8speed_auto', label = '8-Speed Automatic', weight = 1000, type = 'item', image = '8speed_auto.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    -- Differential Tuning
    lsd_differential                = { name = 'lsd_differential', label = 'Limited Slip Differential', weight = 1000, type = 'item', image = 'lsd_differential.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    race_differential               = { name = 'race_differential', label = 'Race Differential', weight = 1000, type = 'item', image = 'race_differential.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    -- ECU Tuning
    stage1_ecu                      = { name = 'stage1_ecu', label = 'Stage 1 ECU', weight = 1000, type = 'item', image = 'stage1_ecu.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    stage2_ecu                      = { name = 'stage2_ecu', label = 'Stage 2 ECU', weight = 1000, type = 'item', image = 'stage2_ecu.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    -- Cooling Systems
    performance_radiator            = { name = 'performance_radiator', label = 'Performance Radiator', weight = 1000, type = 'item', image = 'performance_radiator.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    race_intercooler                = { name = 'race_intercooler', label = 'Race Intercooler', weight = 1000, type = 'item', image = 'race_intercooler.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    -- Cosmetic Items
    lighting_controller             = { name = 'lighting_controller', label = 'Lighting Controller', weight = 100, type = 'item', image = 'lighting_controller.png', unique = false, useable = true, shouldClose = true, combinable = true, description = nil },
    stancing_kit                    = { name = 'stancing_kit', label = 'Stance Kit', weight = 100, type = 'item', image = 'stancing_kit.png', unique = false, useable = true, shouldClose = true, combinable = true, description = nil },
    cosmetic_part                   = { name = 'cosmetic_part', label = 'Body Kit', weight = 1000, type = 'item', image = 'cosmetic_part.png', unique = false, useable = false, shouldClose = false, combinable = true, description = nil },
    respray_kit                     = { name = 'respray_kit', label = 'Respray Kit', weight = 1000, type = 'item', image = 'respray_kit.png', unique = false, useable = false, shouldClose = false, combinable = true, description = nil },
    vehicle_wheels                  = { name = 'vehicle_wheels', label = 'Vehicle Wheels Set', weight = 1000, type = 'item', image = 'vehicle_wheels.png', unique = false, useable = false, shouldClose = false, combinable = true, description = nil },
    tyre_smoke_kit                  = { name = 'tyre_smoke_kit', label = 'Tyre Smoke Kit', weight = 1000, type = 'item', image = 'tyre_smoke_kit.png', unique = false, useable = false, shouldClose = false, combinable = true, description = nil },
    bulletproof_tyres               = { name = 'bulletproof_tyres', label = 'Bulletproof Tyres', weight = 1000, type = 'item', image = 'bulletproof_tyres.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = nil },
    extras_kit                      = { name = 'extras_kit', label = 'Extras Kit', weight = 100, type = 'item', image = 'extras_kit.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = nil },
    -- Nitrous
    nitrous_bottle                  = { name = 'nitrous_bottle', label = 'Nitrous Bottle', weight = 1000, type = 'item', image = 'nitrous_bottle.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = nil },
    empty_nitrous_bottle            = { name = 'empty_nitrous_bottle', label = 'Empty Nitrous Bottle', weight = 1000, type = 'item', image = 'empty_nitrous_bottle.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    nitrous_install_kit             = { name = 'nitrous_install_kit', label = 'Nitrous Install Kit', weight = 1000, type = 'item', image = 'nitrous_install_kit.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = nil },
    -- Repair & Cleaning Items
    cleaning_kit                    = { name = 'cleaning_kit', label = 'Cleaning Kit', weight = 1000, type = 'item', image = 'cleaning_kit.png', unique = false, useable = true, shouldClose = true, combinable = true, description = nil },
    repair_kit                      = { name = 'repair_kit', label = 'Vehicle Repair Kit', weight = 1000, type = 'item', job = { 'mechanic', 'mechanic1', 'mechanic2', 'mechanic3' }, image = 'repair_kit.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = nil },
    duct_tape                       = { name = 'duct_tape', label = 'Duct Tape', weight = 100, type = 'item', image = 'duct_tape.png', unique = false, useable = true, shouldClose = true, combinable = true, description = nil },
    -- Performance
    performance_part                = { name = 'performance_part', label = 'Performance Part', weight = 1000, type = 'item', image = 'performance_part.png', unique = false, useable = false, shouldClose = false, combinable = true, description = nil },
    -- Mechanic Tablet
    mechanic_tablet                 = { name = 'mechanic_tablet', label = 'Mechanic Tablet', weight = 1000, type = 'item', image = 'mechanic_tablet.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = nil },
    manual_gearbox                  = { name = 'manual_gearbox', label = 'Manual Gearbox', weight = 1000, type = 'item', image = 'manual_gearbox.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = nil },


    -- Farming
    coffee_beans              = { ["name"] = "coffee_beans", ["label"] = "Coffee Beans", ["weight"] = 100, ["type"] = "item", ["image"] = "coffee_beans.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    tea_leaves                = { ["name"] = "tea_leaves", ["label"] = "Tea Leaves", ["weight"] = 100, ["type"] = "item", ["image"] = "tea_leaves.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    wheat                     = { ["name"] = "wheat", ["label"] = "Wheat", ["weight"] = 100, ["type"] = "item", ["image"] = "wheat.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    flour                     = { ["name"] = "flour", ["label"] = "Flour", ["weight"] = 100, ["type"] = "item", ["image"] = "flour.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    lemon                     = { ["name"] = "lemon", ["label"] = "Lemon", ["weight"] = 100, ["type"] = "item", ["image"] = "lemon.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    strawberry                = { ["name"] = "strawberry", ["label"] = "Strawberry", ["weight"] = 100, ["type"] = "item", ["image"] = "strawberry.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    cocao                     = { ["name"] = "cocao", ["label"] = "Cocoa", ["weight"] = 100, ["type"] = "item", ["image"] = "cocao.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    cream                     = { ["name"] = "cream", ["label"] = "Cream", ["weight"] = 100, ["type"] = "item", ["image"] = "cream.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    milk                      = { ["name"] = "milk", ["label"] = "Milk", ["weight"] = 100, ["type"] = "item", ["image"] = "milk.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    cherry                    = { ["name"] = "cherry", ["label"] = "Cherry", ["weight"] = 100, ["type"] = "item", ["image"] = "cherry.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    pecan                     = { ["name"] = "pecan", ["label"] = "Pecan", ["weight"] = 100, ["type"] = "item", ["image"] = "pecan.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    carrot                    = { ["name"] = "carrot", ["label"] = "Carrot", ["weight"] = 100, ["type"] = "item", ["image"] = "carrot.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    onion                     = { ["name"] = "onion", ["label"] = "Onion", ["weight"] = 100, ["type"] = "item", ["image"] = "onion.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    potato                    = { ["name"] = "potato", ["label"] = "Potato", ["weight"] = 100, ["type"] = "item", ["image"] = "potato.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },

    ['ammonium_nitrate']      = { ['name'] = 'ammonium_nitrate', ['label'] = 'Ammonium nitrate', ['weight'] = 500, ['type'] = 'item', ['image'] = 'ammonium_nitrate.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['carbon']                = { ['name'] = 'carbon', ['label'] = 'Carbon', ['weight'] = 500, ['type'] = 'item', ['image'] = 'carbon.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['codeine']               = { ['name'] = 'codeine', ['label'] = 'Codeine', ['weight'] = 500, ['type'] = 'item', ['image'] = 'codeine.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['drink_sprite']          = { ['name'] = 'drink_sprite', ['label'] = 'Sprite', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drink_sprite.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['drug_ecstasy']          = { ['name'] = 'drug_ecstasy', ['label'] = 'Ecstasy', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drug_ecstasy.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['drug_lean']             = { ['name'] = 'drug_lean', ['label'] = 'Lean', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drug_lean.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['drug_lsd']              = { ['name'] = 'drug_lsd', ['label'] = 'LSD', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drug_lsd.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['drug_meth']             = { ['name'] = 'drug_meth', ['label'] = 'Meth', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drug_meth.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['hydrogen']              = { ['name'] = 'hydrogen', ['label'] = 'Hydrogen', ['weight'] = 500, ['type'] = 'item', ['image'] = 'hydrogen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['ice']                   = { ['name'] = 'ice', ['label'] = 'Ice', ['weight'] = 500, ['type'] = 'item', ['image'] = 'ice.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['jolly_ranchers']        = { ['name'] = 'jolly_ranchers', ['label'] = 'Jolly Ranchers', ['weight'] = 500, ['type'] = 'item', ['image'] = 'jolly_ranchers.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['liquid_sulfur']         = { ['name'] = 'liquid_sulfur', ['label'] = 'Liquid Sulfur', ['weight'] = 500, ['type'] = 'item', ['image'] = 'liquid_sulfur.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['muriatic_acid']         = { ['name'] = 'muriatic_acid', ['label'] = 'Muriatic Acid', ['weight'] = 500, ['type'] = 'item', ['image'] = 'muriatic_acid.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['nitrogen']              = { ['name'] = 'nitrogen', ['label'] = 'Nitrogen', ['weight'] = 500, ['type'] = 'item', ['image'] = 'nitrogen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['oxygen']                = { ['name'] = 'oxygen', ['label'] = 'Oxygen', ['weight'] = 500, ['type'] = 'item', ['image'] = 'oxygen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['pseudoefedrine']        = { ['name'] = 'pseudoefedrine', ['label'] = 'Pseudoefedrine', ['weight'] = 500, ['type'] = 'item', ['image'] = 'pseudoefedrine.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['red_sulfur']            = { ['name'] = 'red_sulfur', ['label'] = 'Red Sulfur', ['weight'] = 500, ['type'] = 'item', ['image'] = 'red_sulfur.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['sodium_hydroxide']      = { ['name'] = 'sodium_hydroxide', ['label'] = 'Sodium hydroxide', ['weight'] = 500, ['type'] = 'item', ['image'] = 'sodium_hydroxide.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['water']                 = { ['name'] = 'water', ['label'] = 'Water', ['weight'] = 500, ['type'] = 'item', ['image'] = 'water.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['cannabis']              = { ['name'] = 'cannabis', ['label'] = 'Cannabis', ['weight'] = 500, ['type'] = 'item', ['image'] = 'cannabis.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['green_gelato_cannabis'] = { ['name'] = 'green_gelato_cannabis', ['label'] = 'Green Gelato Cannabis', ['weight'] = 500, ['type'] = 'item', ['image'] = 'green_gelato_cannabis.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['opium']                 = { ['name'] = 'opium', ['label'] = 'Opium', ['weight'] = 500, ['type'] = 'item', ['image'] = 'opium.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },
    ['cocaine']               = { ['name'] = 'cocaine', ['label'] = 'Cocaine', ['weight'] = 500, ['type'] = 'item', ['image'] = 'cocaine.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil },

    ['head_bandage']          = { ['name'] = 'head_bandage', ['label'] = 'Head Bandage', ['weight'] = 1, ['type'] = 'item', ['image'] = 'head_bandage.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['arm_wrap']              = { ['name'] = 'arm_wrap', ['label'] = 'Arm Wrap', ['weight'] = 1, ['type'] = 'item', ['image'] = 'arm_wrap.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['leg_plaster']           = { ['name'] = 'leg_plaster', ['label'] = 'Leg Plaster', ['weight'] = 1, ['type'] = 'item', ['image'] = 'leg_plaster.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['body_bandage']          = { ['name'] = 'body_bandage', ['label'] = 'Body Bandage', ['weight'] = 1, ['type'] = 'item', ['image'] = 'body_bandage.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['bandage']               = { ['name'] = 'bandage', ['label'] = 'Bandage', ['weight'] = 1, ['type'] = 'item', ['image'] = 'bandage.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['medikit']               = { ['name'] = 'medikit', ['label'] = 'Medikit', ['weight'] = 1, ['type'] = 'item', ['image'] = 'medikit.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['small_heal']            = { ['name'] = 'small_heal', ['label'] = 'Small Heal', ['weight'] = 1, ['type'] = 'item', ['image'] = 'bandage.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['big_heal']              = { ['name'] = 'big_heal', ['label'] = 'Big Heal', ['weight'] = 1, ['type'] = 'item', ['image'] = 'medikit.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },

    --['WEAPON_PAINTBALL'] = { ['name'] = 'WEAPON_PAINTBALL', ['label'] = 'PaintBall Weapon', ['weight'] = 1000, ['type'] = 'weapon', ['ammotype'] = 'AMMO_PISTOL', ['image'] = 'WEAPON_PAINTBALL.png', ['unique'] = true, ['useable'] = false, ['description'] = '' },


    ['vape'] = { ['name'] = 'vape', ['label'] = 'Vape', ['weight'] = 500, ['type'] = 'item', ['image'] = 'vape.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Blow clouds' },
    ['alien_skunk']             = {['name'] = 'alien_skunk',        ['label'] = 'Alien Skunk',           ['weight'] = 500,         ['type'] = 'item',         ['image'] = 'alien.png',            ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'Vape Flavour'},
    ['hydro_lemonade']          = {['name'] = 'hydro_lemonade',     ['label'] = 'Hydro Lemonade',        ['weight'] = 500,         ['type'] = 'item',         ['image'] = 'hydrolem.png',         ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'Vape Flavour'},
    ['strawnana']               = {['name'] = 'strawnana',          ['label'] = 'Strawnana',             ['weight'] = 500,         ['type'] = 'item',         ['image'] = 'strawnana.png',        ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'Vape Flavour'},
    ['chubby']                  = {['name'] = 'chubby',             ['label'] = 'Chubby',                ['weight'] = 500,         ['type'] = 'item',         ['image'] = 'chubby.png',           ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'Vape Flavour'},
    ['puff_strawberry']         = {['name'] = 'puff_strawberry',    ['label'] = 'Strawberry',            ['weight'] = 500,         ['type'] = 'item',         ['image'] = 'puffstrawberry.png',   ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'Vape Flavour'},
    ['puff_blueberry']          = {['name'] = 'puff_blueberry',     ['label'] = 'Blueberry',             ['weight'] = 500,         ['type'] = 'item',         ['image'] = 'puffblueberry.png',    ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'Vape Flavour'},
    ['puff_mango']              = {['name'] = 'puff_mango',         ['label'] = 'Mango',                 ['weight'] = 500,         ['type'] = 'item',         ['image'] = 'puffmango.png',        ['unique'] = true,         ['useable'] = true,     ['shouldClose'] = true,       ['combinable'] = nil,   ['description'] = 'Vape Flavour'},


    ["alive_chicken"]        = { ["name"] = "alive_chicken", ["label"] = "Alive chicken", ["weight"] = 100, ["type"] = "item", ["image"] = "alive_chicken.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Alive Chicken" },
    ["slaughtered_chicken"]  = { ["name"] = "slaughtered_chicken", ["label"] = "Slaughtered chicken", ["weight"] = 100, ["type"] = "item", ["image"] = "slaughteredchicken.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Slaughtered Chicken" },
    ["packagedchicken"]      = { ["name"] = "packagedchicken", ["label"] = "Packaged chicken", ["weight"] = 100, ["type"] = "item", ["image"] = "packaged_chicken.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Packaged Chicken" },

    ['skytracker']           = { ['name'] = 'skytracker', ['label'] = 'Skydiving Tracker', ['weight'] = 500, ['type'] = 'item', ['image'] = 'fitbit.png', ['unique'] = true, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Gives skydiving team radar' },

    ['weapon_newspaper']     = { ['name'] = 'weapon_newspaper', ['label'] = 'Newspaper', ['weight'] = 500, ['type'] = 'weapon', ['image'] = 'weapon_newspaper.png', ['unique'] = true, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ["finger_scanner"]       = { ["name"] = "finger_scanner", ["label"] = "Finger Scanner", ["weight"] = 10, ["type"] = "item", ["image"] = "finger_scanner.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    ['police_bulletproof']   = { ['name'] = 'police_bulletproof', ['label'] = 'Police Bulletproof', ['weight'] = 1, ['type'] = 'item', ['image'] = 'police_bulletproof.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },
    ['sheriff_bulletproof']  = { ['name'] = 'sheriff_bulletproof', ['label'] = 'Sheriff Bulletproof', ['weight'] = 1, ['type'] = 'item', ['image'] = 'sheriff_bulletproof.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = '' },

    ["advanceddecrypter"]    = { ["name"] = "advanceddecrypter", ["label"] = "Advanced Decrypter", ["weight"] = 1000, ["type"] = "item", ["image"] = "advanceddecrypter.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    ["advanceddrill"]        = { ["name"] = "advanceddrill", ["label"] = "Advanced Drill", ["weight"] = 1000, ["type"] = "item", ["image"] = "advanceddrill.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    ["laptop_blue"]          = { ["name"] = "laptop_blue", ["label"] = "Laptop", ["weight"] = 2500, ["type"] = "item", ["image"] = "laptop_blue.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },

    ["hardeneddecrypter"]    = { ["name"] = "hardeneddecrypter", ["label"] = "Hardened Decrypter", ["weight"] = 1000, ["type"] = "item", ["image"] = "hardeneddecrypter.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    ["hardeneddrill"]        = { ["name"] = "hardeneddrill", ["label"] = "Hardened Drill", ["weight"] = 1000, ["type"] = "item", ["image"] = "hardeneddrill.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    ["disruptor"]            = { ["name"] = "disruptor", ["label"] = "Disruptor", ["weight"] = 1000, ["type"] = "item", ["image"] = "disruptor.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Small disruptor device to shut off systems" },
    ["laptop_red"]           = { ["name"] = "laptop_red", ["label"] = "Laptop", ["weight"] = 2500, ["type"] = "item", ["image"] = "laptop_red.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    ['c4']                   = { ['name'] = 'c4', ['label'] = 'C4 Explosive', ['weight'] = 1000, ['type'] = 'item', ['ammotype'] = nil, ['image'] = 'weapon_stickybomb.png', ['unique'] = true, ['useable'] = false, ['description'] = 'A high-yield, timed explosive device' },
    ["nvg"]                  = { ["name"] = "nvg", ["label"] = "NVG", ["weight"] = 5000, ["type"] = "item", ["image"] = "nvg.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "These allow you to see in the dark" },

    boostingtablet           = { name = 'boostingtablet', label = 'Boosting tablet', weight = 1000, type = 'item', image = 'boostingtablet.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = "Seems like something's installed on this." },
    hackingdevice            = { name = 'hackingdevice', label = 'Hacking device', weight = 1000, type = 'item', image = 'hackingdevice.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'Will allow you to bypass vehicle security systems.' },
    gpshackingdevice         = { name = 'gpshackingdevice', label = 'GPS hacking device', weight = 1000, type = 'item', image = 'gpshackingdevice.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'If you wish to disable vehicle GPS systems.' },
    racingtablet             = { name = 'racingtablet', label = 'Racing tablet', weight = 1000, type = 'item', image = 'racingtablet.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'Seems like something to do with cars.' },

    ["dslrcamera"]           = { ["name"] = "dslrcamera", ["label"] = "PD Camera", ["weight"] = 1000, ["type"] = "item", ["image"] = "dslrcamera.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "DSLR Camera, with cloud uplink.. cool right?" },

    -- Food
    ["tripleburger"]         = { ["name"] = "tripleburger", ["label"] = "The Triple Burger", ["weight"] = 100, ["type"] = "item", ["image"] = "tripleburger.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["baconcheesemelt"]      = { ["name"] = "baconcheesemelt", ["label"] = "Bacon-Triple Cheese Melt", ["weight"] = 100, ["type"] = "item", ["image"] = "baconcheesemelt.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["chillidog"]            = { ["name"] = "chillidog", ["label"] = "Footlong Chili Dog", ["weight"] = 100, ["type"] = "item", ["image"] = "chillidog.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["atomfries"]            = { ["name"] = "atomfries", ["label"] = "Atom Fries", ["weight"] = 100, ["type"] = "item", ["image"] = "atomfries.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },

    ["chickenfillet"]        = { ["name"] = "chickenfillet", ["label"] = "Chicken Fillets", ["weight"] = 100, ["type"] = "item", ["image"] = "chickenbreasts.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["chickenhorn"]          = { ["name"] = "chickenhorn", ["label"] = "Chicken Hornstars", ["weight"] = 100, ["type"] = "item", ["image"] = "chickhornstars.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["grilledchicken"]       = { ["name"] = "grilledchicken", ["label"] = "Chicken Sandwich", ["weight"] = 100, ["type"] = "item", ["image"] = "chickensandwich.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["chickensalad"]         = { ["name"] = "chickensalad", ["label"] = "Chicken Salad", ["weight"] = 100, ["type"] = "item", ["image"] = "chickensalad.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["hunksohen"]            = { ["name"] = "hunksohen", ["label"] = "Hunk o' Hen", ["weight"] = 100, ["type"] = "item", ["image"] = "chickenthighs.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },

    ["chickentaco"]          = { ["name"] = "chickentaco", ["label"] = "Chicken Taco", ["weight"] = 100, ["type"] = "item", ["image"] = "chickentaco.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["enchiladas"]           = { ["name"] = "enchiladas", ["label"] = "Breakfast Enchiladas", ["weight"] = 100, ["type"] = "item", ["image"] = "enchi.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["gazpacho"]             = { ["name"] = "gazpacho", ["label"] = "Guzpacho", ["weight"] = 100, ["type"] = "item", ["image"] = "gazpacho.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },

    ["hornbreakfast"]        = { ["name"] = "hornbreakfast", ["label"] = "Horny's Breakfast", ["weight"] = 100, ["type"] = "item", ["image"] = "bangers.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["eggsbenedict"]         = { ["name"] = "eggsbenedict", ["label"] = "Eggs Benedict", ["weight"] = 100, ["type"] = "item", ["image"] = "eggbene.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["hashbrowns"]           = { ["name"] = "hashbrowns", ["label"] = "Hash Browns", ["weight"] = 100, ["type"] = "item", ["image"] = "hashbrown.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["sausages"]             = { ["name"] = "sausages", ["label"] = "Sausages", ["weight"] = 100, ["type"] = "item", ["image"] = "sausage.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["baconroll"]            = { ["name"] = "baconroll", ["label"] = "Bacon Roll", ["weight"] = 100, ["type"] = "item", ["image"] = "baconroll.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["baconeggtoast"]        = { ["name"] = "baconeggtoast", ["label"] = "Bacon & Egg on Toast", ["weight"] = 100, ["type"] = "item", ["image"] = "baconegg.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["frenchtoast"]          = { ["name"] = "frenchtoast", ["label"] = "French Toast", ["weight"] = 100, ["type"] = "item", ["image"] = "frenchtoast.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["frenchtoastbacon"]     = { ["name"] = "frenchtoastbacon", ["label"] = "French Toast Bacon", ["weight"] = 100, ["type"] = "item", ["image"] = "frenchbacon.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },

    ["hornburger"]           = { ["name"] = "hornburger", ["label"] = "HornBurger", ["weight"] = 100, ["type"] = "item", ["image"] = "hornburger.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["dblhornburger"]        = { ["name"] = "dblhornburger", ["label"] = "DBL HornBurger", ["weight"] = 100, ["type"] = "item", ["image"] = "dblhornburger.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["baconhornburger"]      = { ["name"] = "baconhornburger", ["label"] = "HornBurger Bacon", ["weight"] = 100, ["type"] = "item", ["image"] = "baconburger.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["picklehornburger"]     = { ["name"] = "picklehornburger", ["label"] = "HornBurger Pickle", ["weight"] = 100, ["type"] = "item", ["image"] = "pickleburger.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["chickenhornburger"]    = { ["name"] = "chickenhornburger", ["label"] = "Chicken HornBurger", ["weight"] = 100, ["type"] = "item", ["image"] = "chickenburger.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["dblchickenhornburger"] = { ["name"] = "dblchickenhornburger", ["label"] = "DBL Chicken HornBurger", ["weight"] = 100, ["type"] = "item", ["image"] = "dblchickenburger.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },

    ["icecone"]              = { ["name"] = "icecone", ["label"] = "Ice Cone", ["weight"] = 100, ["type"] = "item", ["image"] = "cone.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["icenugget"]            = { ["name"] = "icenugget", ["label"] = "Ice Nugget", ["weight"] = 100, ["type"] = "item", ["image"] = "icenugget.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["icecake"]              = { ["name"] = "icecake", ["label"] = "Ice Cream Cake", ["weight"] = 100, ["type"] = "item", ["image"] = "icecake.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },

    ["junkdrink"]            = { ["name"] = "junkdrink", ["label"] = "Junk", ["weight"] = 100, ["type"] = "item", ["image"] = "junkdrink.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "Questionable junk drink"},
    ["orangotang"]           = { ["name"] = "orangotang", ["label"] = "Bacon", ["weight"] = 100, ["type"] = "item", ["image"] = "orangotang.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "Mystery bacon can"},
    ["raine"]                = { ["name"] = "raine", ["label"] = "Raine", ["weight"] = 100, ["type"] = "item", ["image"] = "raine.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "Refreshing Raine beverage"},

    -- Desert
    ["creamyshake"]          = { ["name"] = "creamyshake", ["label"] = "Extra Creamy Jumbo Shake", ["weight"] = 100, ["type"] = "item", ["image"] = "atomshake.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(20, 30) },
    -- Drinks
    ["atomsoda"]             = { ["name"] = "atomsoda", ["label"] = "Atom Soda", ["weight"] = 100, ["type"] = "item", ["image"] = "atomsoda.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["orange_soda"]          = { ["name"] = "orange_soda", ["label"] = "Orange Soda", ["weight"] = 100, ["type"] = "item", ["image"] = "orange_soda.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["lemon_pop"]            = { ["name"] = "lemon_pop", ["label"] = "Lemon pop", ["weight"] = 100, ["type"] = "item", ["image"] = "lemon_pop.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["rocket_soda"]          = { ["name"] = "rocket_soda", ["label"] = "Rocket Soda", ["weight"] = 100, ["type"] = "item", ["image"] = "rocket_soda.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['thirst'] = math.random(20, 30) },

    -- Ingredients
    ["burgerpatty"]          = { ["name"] = "burgerpatty", ["label"] = "Patty", ["weight"] = 100, ["type"] = "item", ["image"] = "burgerpatty.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["breadslice"]           = { ["name"] = "breadslice", ["label"] = "Slice of Bread", ["weight"] = 100, ["type"] = "item", ["image"] = "breadslice.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "", ['hunger'] = math.random(10, 20) },
    ["cheddar"]              = { ["name"] = "cheddar", ["label"] = "Cheese", ["weight"] = 100, ["type"] = "item", ["image"] = "cheddar.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["lettuce"]              = { ["name"] = "lettuce", ["label"] = "Lettuce", ["weight"] = 100, ["type"] = "item", ["image"] = "lettuce.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["tomato"]               = { ["name"] = "tomato", ["label"] = "Tomato", ["weight"] = 100, ["type"] = "item", ["image"] = "tomato.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["burgerbun"]            = { ["name"] = "burgerbun", ["label"] = "Burger Bun", ["weight"] = 100, ["type"] = "item", ["image"] = "burgerbun.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["hotdogbun"]            = { ["name"] = "hotdogbun", ["label"] = "Hotdog Bun", ["weight"] = 100, ["type"] = "item", ["image"] = "hotdogbun.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["chillimince"]          = { ["name"] = "chillimince", ["label"] = "Chillimince", ["weight"] = 100, ["type"] = "item", ["image"] = "chillimince.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["butter"]               = { ["name"] = "butter", ["label"] = "Butter", ["weight"] = 100, ["type"] = "item", ["image"] = "farming_butter.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["milk"]                 = { ["name"] = "milk", ["label"] = "Milk", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-milk.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["cream"]                = { ["name"] = "cream", ["label"] = "Cream", ["weight"] = 100, ["type"] = "item", ["image"] = "cream.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["burgermeat"]           = { ["name"] = "burgermeat", ["label"] = "Burger Meat", ["weight"] = 100, ["type"] = "item", ["image"] = "burgermeat.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["hotdogmeat"]           = { ["name"] = "hotdogmeat", ["label"] = "Hotdog Meat", ["weight"] = 100, ["type"] = "item", ["image"] = "hotdogmeat.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["slicedtomato"]         = { ["name"] = "slicedtomato", ["label"] = "Sliced Tomato", ["weight"] = 100, ["type"] = "item", ["image"] = "slicedtomato.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["slicedpotato"]         = { ["name"] = "slicedpotato", ["label"] = "Sliced Potato", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-slicedpotato.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["rawhotdog"]            = { ["name"] = "rawhotdog", ["label"] = "Raw Hotdog", ["weight"] = 100, ["type"] = "item", ["image"] = "rawhotdog.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["potato"]               = { ["name"] = "potato", ["label"] = "Potato", ["weight"] = 100, ["type"] = "item", ["image"] = "potato.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["egg"]                  = { ["name"] = "egg", ["label"] = "Egg", ["weight"] = 100, ["type"] = "item", ["image"] = "farming_egg.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "" },
    ["bacon"]                = { ["name"] = "bacon", ["label"] = "Bacon", ["weight"] = 100, ["type"] = "item", ["image"] = "bacon.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["rawbacon"]             = { ["name"] = "rawbacon", ["label"] = "Raw Bacon", ["weight"] = 100, ["type"] = "item", ["image"] = "rawbacon.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
    ["rawsausage"]           = { ["name"] = "rawsausage", ["label"] = "Raw Sausages", ["weight"] = 100, ["type"] = "item", ["image"] = "rawsausage.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["description"] = "", },
	["pickle"]               = { ["name"] = "pickle", ["label"] = "Pickle", ["weight"] = 100, ["type"] = "item", ["image"] = "pickle.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A jar of Pickles", ['hunger'] = math.random(40, 50) },

	-- Beekeeping items (OLRP Beekeeping)
	["beehive_box"]        = { ["name"] = "beehive_box",        ["label"] = "Beehive Box",     ["weight"] = 2000, ["type"] = "item", ["image"] = "beehive_box.png",        ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "A portable hive box." },
	["basic_queen"]        = { ["name"] = "basic_queen",        ["label"] = "Queen Bee",       ["weight"] = 100,  ["type"] = "item", ["image"] = "basic_queen.png",        ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "A queen bee for your hive." },
	["basic_bees"]         = { ["name"] = "basic_bees",         ["label"] = "Worker Bees",     ["weight"] = 100,  ["type"] = "item", ["image"] = "basic_bees.png",         ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "A jar of worker bees." },
	["basic_hornet_queen"] = { ["name"] = "basic_hornet_queen", ["label"] = "Wasp Queen",      ["weight"] = 100,  ["type"] = "item", ["image"] = "basic_hornet_queen.png", ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "A wasp queen (dangerous)." },
	["basic_hornets"]      = { ["name"] = "basic_hornets",      ["label"] = "Worker Wasps",    ["weight"] = 100,  ["type"] = "item", ["image"] = "basic_hornets.png",      ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "A jar of worker wasps." },
	["empty_bee_jar"]      = { ["name"] = "empty_bee_jar",      ["label"] = "Empty Bee Jar",   ["weight"] = 100,  ["type"] = "item", ["image"] = "empty_bee_jar.png",      ["unique"] = false, ["useable"] = false, ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "An empty jar for bees/queens." },
	["honey"]              = { ["name"] = "honey",              ["label"] = "Honey",           ["weight"] = 250,  ["type"] = "item", ["image"] = "honey.png",              ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "Jar of honey." },
	["honey2"]             = { ["name"] = "honey2",             ["label"] = "Manuka Honey",    ["weight"] = 250,  ["type"] = "item", ["image"] = "honey2.png",             ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "Premium honey." },
	["torch_smoker"]       = { ["name"] = "torch_smoker",       ["label"] = "Bee Smoker",      ["weight"] = 500,  ["type"] = "item", ["image"] = "torch_smoker.png",       ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "Calms bees." },
	["bug_net"]            = { ["name"] = "bug_net",            ["label"] = "Bug Net",         ["weight"] = 300,  ["type"] = "item", ["image"] = "bug_net.png",            ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "Catch insects." },
	["wateringcan_empty"]  = { ["name"] = "wateringcan_empty",  ["label"] = "Watering Can",    ["weight"] = 300,  ["type"] = "item", ["image"] = "wateringcan_empty.png",  ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "For watering hives." },
	["wheat"]              = { ["name"] = "wheat",              ["label"] = "Wheat",           ["weight"] = 50,   ["type"] = "item", ["image"] = "wheat.png",              ["unique"] = false, ["useable"] = true,  ["shouldClose"] = true,  ["combinable"] = nil, ["description"] = "For cleaning hives." },

    ["chickenbreast"]        = { ["name"] = "chickenbreast", ["label"] = "Raw Chicken Breast", ["weight"] = 100, ["type"] = "item", ["image"] = "farming_chickenbreast.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["description"] = "" },

    ["sprunklight"]          = { ["name"] = "sprunklight", ["label"] = "Sprunk Light", ["weight"] = 100, ["type"] = "item", ["image"] = "sprunklight.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["ecola"]                = { ["name"] = "ecola", ["label"] = "eCola", ["weight"] = 100, ["type"] = "item", ["image"] = "ecola.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["ecolalight"]           = { ["name"] = "ecolalight", ["label"] = "eCola Light", ["weight"] = 100, ["type"] = "item", ["image"] = "ecolalight.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },

    --Jim-BeanMachine
    ["beancoffee"]           = { ["name"] = "beancoffee", ["label"] = "Coffe Beans", ["weight"] = 100, ["type"] = "item", ["image"] = "beancoffee.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["beandonut"]            = { ["name"] = "beandonut", ["label"] = "Donut", ["weight"] = 100, ["type"] = "item", ["image"] = "popdonut.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["rhinohorn"]            = { ["name"] = "rhinohorn", ["label"] = "Rhino Horn", ["weight"] = 100, ["type"] = "item", ["image"] = "rhinohorn.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    ["oystershell"]          = { ["name"] = "oystershell", ["label"] = "Oyster Shell", ["weight"] = 100, ["type"] = "item", ["image"] = "oyster.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },
    ["watermelon"]           = { ["name"] = "watermelon", ["label"] = "WaterMelon Slice", ["weight"] = 100, ["type"] = "item", ["image"] = "watermelon.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['hunger'] = math.random(20, 30), ['thirst'] = math.random(20, 30) },

    ["bigfruit"]             = { ["name"] = "bigfruit", ["label"] = "The Big Fruit", ["weight"] = 100, ["type"] = "item", ["image"] = "bigfruit.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["highnoon"]             = { ["name"] = "highnoon", ["label"] = "Highnoon", ["weight"] = 100, ["type"] = "item", ["image"] = "highnoon.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["speedball"]            = { ["name"] = "speedball", ["label"] = "The SpeedBall", ["weight"] = 100, ["type"] = "item", ["image"] = "speedball.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["gunkaccino"]           = { ["name"] = "gunkaccino", ["label"] = "The Gunkaccino", ["weight"] = 100, ["type"] = "item", ["image"] = "gunkaccino.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["bratte"]               = { ["name"] = "bratte", ["label"] = "The Bratte", ["weight"] = 100, ["type"] = "item", ["image"] = "bratte.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["flusher"]              = { ["name"] = "flusher", ["label"] = "The Flusher", ["weight"] = 100, ["type"] = "item", ["image"] = "flusher.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["ecocoffee"]            = { ["name"] = "ecocoffee", ["label"] = "The Eco-ffee", ["weight"] = 100, ["type"] = "item", ["image"] = "ecoffee.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["caffeagra"]            = { ["name"] = "caffeagra", ["label"] = "Caffeagra", ["weight"] = 100, ["type"] = "item", ["image"] = "caffeagra.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },

    ["chocolate"]            = { ["name"] = "chocolate", ["label"] = "Chocolate", ["weight"] = 100, ["type"] = "item", ["image"] = "chocolate.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Chocolate Bar", ['hunger'] = math.random(10, 20) },
    ["cheesecake"]           = { ["name"] = "cheesecake", ["label"] = "Cheese Cake", ["weight"] = 100, ["type"] = "item", ["image"] = "cheesecake.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["crisps"]               = { ["name"] = "crisps", ["label"] = "Crisps", ["weight"] = 100, ["type"] = "item", ["image"] = "chips.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['hunger'] = math.random(20, 30) },
    ["sugar"]                = { ["name"] = "sugar", ["label"] = "Sugar", ["weight"] = 100, ["type"] = "item", ["image"] = "sugar.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "", ['hunger'] = math.random(10, 20) },
    ["orange"]               = { ["name"] = "orange", ["label"] = "Orange", ["weight"] = 100, ["type"] = "item", ["image"] = "orange.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "An Orange." },

    --BurgerShot
    ["potato"]               = { ["name"] = "potato", ["label"] = "Potatoes", ["weight"] = 100, ["type"] = "item", ["image"] = "potatoes.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bag of Potatos" },
    ["slicedpotato"]         = { ["name"] = "slicedpotato", ["label"] = "Sliced Potatoes", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-slicedpotato.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sliced Potato" },
    ["slicedonion"]          = { ["name"] = "slicedonion", ["label"] = "Sliced Onions", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-slicedonion.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Sliced Onion" },
    ["icecream"]             = { ["name"] = "icecream", ["label"] = "Ice Cream", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-icecream.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Ice Cream." },
    ["milk"]                 = { ["name"] = "milk", ["label"] = "Milk", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-milk.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Carton of Milk", ['thirst'] = math.random(35, 54) },
    ["lettuce"]              = { ["name"] = "lettuce", ["label"] = "Lettuce", ["weight"] = 100, ["type"] = "item", ["image"] = "lettuce.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Some big taco brother" },
    ["onion"]                = { ["name"] = "onion", ["label"] = "Onion", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-onion.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "An onion" },
    ["frozennugget"]         = { ["name"] = "frozennugget", ["label"] = "Frozen Nuggets", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-frozennugget.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Bag of Frozen Nuggets" },
    ["cheddar"]              = { ["name"] = "cheddar", ["label"] = "Cheddar Slice", ["weight"] = 100, ["type"] = "item", ["image"] = "cheddar.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Slice of Cheese" },
    ["burgerbun"]            = { ["name"] = "burgerbun", ["label"] = "Burger Bun", ["weight"] = 100, ["type"] = "item", ["image"] = "burgerbun.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Some big burger brother" },
    ["burgerpatty"]          = { ["name"] = "burgerpatty", ["label"] = "Burger Patty", ["weight"] = 100, ["type"] = "item", ["image"] = "burgerpatty.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Raw Patty" },
    ["burgermeat"]           = { ["name"] = "burgermeat", ["label"] = "Burger Meat", ["weight"] = 100, ["type"] = "item", ["image"] = "burgermeat.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Cooked Burger Meat" },
    ["milkshake"]            = { ["name"] = "milkshake", ["label"] = "Milkshake", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-milkshake.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "BurgerShot Milkshake", ['thirst'] = math.random(35, 54) },
    ["shotnuggets"]          = { ["name"] = "shotnuggets", ["label"] = "Shot Nuggets", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-shotnuggets.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Burgershot Nuggets", ['hunger'] = math.random(40, 50) },
    ["shotrings"]            = { ["name"] = "shotrings", ["label"] = "Ring Shots", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-shotrings.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Burgershot Onion Rings", ['hunger'] = math.random(40, 50) },
    ["heartstopper"]         = { ["name"] = "heartstopper", ["label"] = "HeartStopper", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-heartstopper.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Heartstopper", ['hunger'] = math.random(50, 60) },
    ["shotfries"]            = { ["name"] = "shotfries", ["label"] = "Shot Fries", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-fries.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Shot Fries", ['hunger'] = math.random(40, 50) },
    ["moneyshot"]            = { ["name"] = "moneyshot", ["label"] = "Money Shot", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-moneyshot.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Money Shot", ['hunger'] = math.random(40, 50) },
    ["meatfree"]             = { ["name"] = "meatfree", ["label"] = "Meat Free", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-meatfree.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Meat Free", ['hunger'] = math.random(40, 50) },
    ["bleeder"]              = { ["name"] = "bleeder", ["label"] = "The Bleeder", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-bleeder.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "The Bleeder", ['hunger'] = math.random(40, 50) },
    ["bscoffee"]             = { ["name"] = "bscoffee", ["label"] = "BurgerShot Coffee", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-coffee.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "BurgerShot Coffee", ['thirst'] = math.random(35, 54) },
    ["bscoke"]               = { ["name"] = "bscoke", ["label"] = "BurgerShot Coke", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-softdrink.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "BurgerShot Cola", ['thirst'] = math.random(35, 54) },
    ["torpedo"]              = { ["name"] = "torpedo", ["label"] = "Torpedo", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-torpedo.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "BurgerShot Torpedo", ['hunger'] = math.random(40, 50) },
    ["rimjob"]               = { ["name"] = "rimjob", ["label"] = "Rim Job", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-rimjob.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "BurgerShot Donut", ['hunger'] = math.random(40, 50) },
    ["creampie"]             = { ["name"] = "creampie", ["label"] = "Creampie", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-creampie.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "BurgerShot Apple Pie", ['hunger'] = math.random(40, 50) },
    ["cheesewrap"]           = { ["name"] = "cheesewrap", ["label"] = "BS Cheese Wrap", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-chickenwrap.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "BurgerShot Cheese Wrap", ['hunger'] = math.random(40, 50) },
    ["chickenwrap"]          = { ["name"] = "chickenwrap", ["label"] = "BS Goat Cheese Wrap", ["weight"] = 100, ["type"] = "item", ["image"] = "burger-goatwrap.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "BurgerShot Goat Cheese Wrap", ['hunger'] = math.random(40, 50) },
    ["murderbag"]            = { ["name"] = "murderbag", ["label"] = "Murder Bag", ["weight"] = 5000, ["type"] = "item", ["image"] = "burgerbag.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Grab a Murder Bag of Burgers", },
    ["doggybag"]             = { ["name"] = "doggybag", ["label"] = "Doggy Bag", ["weight"] = 5000, ["type"] = "item", ["image"] = "doggybag.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A take-home Doggy Bag." },

    -- JIM-CATCAFE ITEMS --

    -- Mochi Treats
    ["bmochi"]               = { name = "bmochi", label = "Blue Mochi", weight = 100, type = "item", image = "mochiblue.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "A soft blue mochi treat" },
    ["pmochi"]               = { name = "pmochi", label = "Pink Mochi", weight = 100, type = "item", image = "mochipink.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "A soft pink mochi treat" },
    ["gmochi"]               = { name = "gmochi", label = "Green Mochi", weight = 100, type = "item", image = "mochigreen.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "A soft green mochi treat" },
    ["omochi"]               = { name = "omochi", label = "Orange Mochi", weight = 100, type = "item", image = "mochiorange.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "A soft orange mochi treat" },

    -- Drinks
    ["bobatea"]              = { name = "bobatea", label = "Boba Tea", weight = 100, type = "item", image = "bubbletea.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Classic boba tea with chewy tapioca" },
    ["bbobatea"]             = { name = "bbobatea", label = "Blue Boba Tea", weight = 100, type = "item", image = "bubbleteablue.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Boba tea with a blue fruity twist" },
    ["gbobatea"]             = { name = "gbobatea", label = "Green Boba Tea", weight = 100, type = "item", image = "bubbleteagreen.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Green tea flavored boba" },
    ["pbobatea"]             = { name = "pbobatea", label = "Pink Boba Tea", weight = 100, type = "item", image = "bubbleteapink.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Strawberry pink boba tea" },
    ["obobatea"]             = { name = "obobatea", label = "Orange Boba Tea", weight = 100, type = "item", image = "bubbleteaorange.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Citrus-flavored orange boba" },

    -- Specialty Drinks
    ["nekolatte"]            = { name = "nekolatte", label = "Neko Latte", weight = 100, type = "item", image = "latte.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Creamy latte with cat art" },
    ["catcoffee"]            = { name = "catcoffee", label = "Cat Coffee", weight = 100, type = "item", image = "catcoffee.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Coffee served with a smiley cat" },
    ["sake"]                 = { name = "sake", label = "Sake", weight = 100, type = "item", image = "sake.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Traditional Japanese rice wine" },

    -- Foods
    ["miso"]                 = { name = "miso", label = "Miso Soup", weight = 100, type = "item", image = "miso.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Warm bowl of miso soup" },
    ["cake"]                 = { name = "cake", label = "Strawberry Cake", weight = 100, type = "item", image = "cake.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Strawberry frosted cake slice" },
    ["bento"]                = { name = "bento", label = "Bento Box", weight = 500, type = "item", image = "bento.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Boxed meal with rice and sides" },
    ["riceball"]             = { name = "riceball", label = "Neko Onigiri", weight = 100, type = "item", image = "catrice.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Rice ball shaped like a cat" },
    ["nekocookie"]           = { name = "nekocookie", label = "Neko Cookie", weight = 100, type = "item", image = "catcookie.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Sweet cookie shaped like a cat" },
    ["nekodonut"]            = { name = "nekodonut", label = "Neko Donut", weight = 100, type = "item", image = "catdonut.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Cat-themed donut" },

    -- Ingredients
    ["boba"]                 = { name = "boba", label = "Boba", weight = 100, type = "item", image = "boba.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Tapioca pearls for bubble tea" },
    ["rice"]                 = { name = "rice", label = "Bowl of Rice", weight = 100, type = "item", image = "rice.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Plain white rice" },
    ["nori"]                 = { name = "nori", label = "Nori", weight = 100, type = "item", image = "nori.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Dried seaweed sheet" },
    ["blueberry"]            = { name = "blueberry", label = "Blueberry", weight = 100, type = "item", image = "blueberry.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "A handful of blueberries" },
    ["mint"]                 = { name = "mint", label = "Matcha", weight = 100, type = "item", image = "matcha.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Finely ground green tea" },
    ["tofu"]                 = { name = "tofu", label = "Tofu", weight = 100, type = "item", image = "tofu.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Soft block of tofu" },

    -- Extras
    ["mocha"]                = { name = "mocha", label = "Mocha Meow", weight = 100, type = "item", image = "mochameow.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Chocolate coffee delight" },
    ["cakepop"]              = { name = "cakepop", label = "Cat Cake-Pop", weight = 100, type = "item", image = "cakepop.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Small cake on a stick" },
    ["pancake"]              = { name = "pancake", label = "PawCake", weight = 100, type = "item", image = "pawcakes.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Paw-print shaped pancake" },
    ["pizza"]                = { name = "pizza", label = "Kitty Pizza", weight = 100, type = "item", image = "catpizza.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Cheesy pizza with a cute design" },
    ["purrito"]              = { name = "purrito", label = "Purrito", weight = 100, type = "item", image = "purrito.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Burrito with feline charm" },
    ["noodlebowl"]           = { name = "noodlebowl", label = "Bowl of Noodles", weight = 100, type = "item", image = "noodlebowl.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Hot bowl of noodles" },
    ["noodles"]              = { name = "noodles", label = "Instant Noodles", weight = 100, type = "item", image = "noodles.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "Uncooked packet of noodles" },
    ["ramen"]                = { name = "ramen", label = "Bowl of Ramen", weight = 100, type = "item", image = "ramen.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "Savory ramen bowl" },

    -- Baits
    bread                               = { name = 'bread', label = 'Bread', weight = 100, type = 'item', image = 'bread.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Bread' },
    earthworm                           = { name = 'earthworm', label = 'Earthworm', weight = 100, type = 'item', image = 'earthworm.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Earthworm' },
    dough                               = { name = 'dough', label = 'Dough', weight = 100, type = 'item', image = 'dough.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Dough' },
    grub                                = { name = 'grub', label = 'Grub', weight = 100, type = 'item', image = 'grub.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Grub' },
    caddis_fly                          = { name = 'caddis_fly', label = 'Caddis Fly', weight = 100, type = 'item', image = 'caddis_fly.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Caddis Fly' },
    cheese                              = { name = 'cheese', label = 'Cheese', weight = 100, type = 'item', image = 'cheese.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Cheese' },
    fly                                 = { name = 'fly', label = 'Fly', weight = 100, type = 'item', image = 'fly.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Fly' },
    dragonfly                           = { name = 'dragonfly', label = 'Dragonfly', weight = 100, type = 'item', image = 'dragonfly.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Dragonfly' },
    grasshoper                          = { name = 'grasshoper', label = 'Grasshoper', weight = 100, type = 'item', image = 'grasshoper.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Grasshoper' },
    shrimp                              = { name = 'shrimp', label = 'Shrimp', weight = 100, type = 'item', image = 'shrimp.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Shrimp' },
    leech                               = { name = 'leech', label = 'Leech', weight = 100, type = 'item', image = 'leech.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Leech' },
    snail                               = { name = 'snail', label = 'Snail', weight = 100, type = 'item', image = 'snail.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Snail' },
    liver                               = { name = 'liver', label = 'Liver', weight = 100, type = 'item', image = 'liver.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Liver' },

    -- Lines
    express_fishing_super_line          = { name = 'express_fishing_super_line', label = 'Express Super Line 0.1mm', weight = 700, type = 'item', image = 'express_fishing_super_line.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Express Super Line 0.1mm' },
    syberia_indiana_green               = { name = 'syberia_indiana_green', label = 'Indiana Green 0.14mm', weight = 700, type = 'item', image = 'syberia_indiana_green.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Indiana Green 0.14mm' },
    syberia_indiana_white               = { name = 'syberia_indiana_white', label = 'Indiana White 0.18mm', weight = 700, type = 'item', image = 'syberia_indiana_white.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Indiana White 0.18mm' },
    simmons_mono_original               = { name = 'simmons_mono_original', label = 'Simmons Original 0.25mm', weight = 700, type = 'item', image = 'simmons_mono_original.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Simmons Original 0.25mm' },
    simmons_mono_ss                     = { name = 'simmons_mono_ss', label = 'Simmons SS 0.28mm', weight = 700, type = 'item', image = 'simmons_mono_ss.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Simmons SS 0.28mm' },
    syberia_indiana_green_2             = { name = 'syberia_indiana_green_2', label = 'Indiana Green 0.32mm', weight = 700, type = 'item', image = 'syberia_indiana_green_2.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Indiana Green 0.32mm' },
    syberia_indiana_white_2             = { name = 'syberia_indiana_white_2', label = 'Indiana White 0.36mm', weight = 700, type = 'item', image = 'syberia_indiana_white_2.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Indiana White 0.36mm' },
    snake_power_line_clr                = { name = 'snake_power_line_clr', label = 'Snake Power Line 0.41mm', weight = 700, type = 'item', image = 'snake_power_line_clr.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Snake Power Line 0.41mm' },
    simmons_mono_original_2             = { name = 'simmons_mono_original_2', label = 'Simmons Original 0.48mm', weight = 700, type = 'item', image = 'simmons_mono_original_2.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Simmons Original 0.48mm' },
    simmons_mono_ss_2                   = { name = 'simmons_mono_ss_2', label = 'Simmons SS 0.52mm', weight = 700, type = 'item', image = 'simmons_mono_ss_2.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Simmons SS 0.52mm' },
    snake_power_line_clr_2              = { name = 'snake_power_line_clr_2', label = 'Snake Power Line 0.65mm', weight = 700, type = 'item', image = 'snake_power_line_clr_2.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Snake Power Line 0.65mm' },
    solid_hipower_nylon                 = { name = 'solid_hipower_nylon', label = 'HiPower Nylon 0.8mm', weight = 700, type = 'item', image = 'solid_hipower_nylon.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'HiPower Nylon 0.8mm' },
    solid_hipower_nylon_lime            = { name = 'solid_hipower_nylon_lime', label = 'HiPower Nylon L 0.85mm', weight = 700, type = 'item', image = 'solid_hipower_nylon_lime.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'HiPower Nylon L 0.85mm' },
    solid_hipower_nylon_orange          = { name = 'solid_hipower_nylon_orange', label = 'HiPower Nylon O 0.9mm', weight = 700, type = 'item', image = 'solid_hipower_nylon_orange.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'HiPower Nylon O 0.9mm' },
    solid_hipower_nylon_2               = { name = 'solid_hipower_nylon_2', label = 'HiPower Nylon 1.05mm', weight = 700, type = 'item', image = 'solid_hipower_nylon_2.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'HiPower Nylon 1.05mm' },
    solid_hipower_nylon_lime_2          = { name = 'solid_hipower_nylon_lime_2', label = 'HiPower Nylon L 1.15mm', weight = 700, type = 'item', image = 'solid_hipower_nylon_lime_2.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'HiPower Nylon L 1.15mm' },
    solid_hipower_nylon_orange_2        = { name = 'solid_hipower_nylon_orange_2', label = 'HiPower Nylon O 1.25mm', weight = 700, type = 'item', image = 'solid_hipower_nylon_orange_2.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'HiPower Nylon O 1.25mm' },

    -- Rods
    ufe_telerod_370                     = { name = 'ufe_telerod_370', label = 'UFE Telerod 370', weight = 1500, type = 'item', image = 'ufe_telerod_370.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Telerod 370' },
    carptack_feeder_master_250          = { name = 'carptack_feeder_master_250', label = 'Carptack Feeder Master 250', weight = 1500, type = 'item', image = 'carptack_feeder_master_250.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Carptack Feeder Master 250' },
    sakura_tsubarea_tsa_552_xul         = { name = 'sakura_tsubarea_tsa_552_xul', label = 'Sakura Tsubarea TSA 552 XUL', weight = 1500, type = 'item', image = 'sakura_tsubarea_tsa_552_xul.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Tsubarea TSA 552 XUL' },
    carpex_hybid_carp_270               = { name = 'carpex_hybid_carp_270', label = 'Carpex Hybid Carp 270', weight = 1500, type = 'item', image = 'carpex_hybid_carp_270.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Carpex Hybid Carp 270' },
    ufe_float_x5_300                    = { name = 'ufe_float_x5_300', label = 'UFE Float X5 300', weight = 1500, type = 'item', image = 'ufe_float_x5_300.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Float X5 300' },
    predatek_fast_perch_210             = { name = 'predatek_fast_perch_210', label = 'Predatek Fast Perch 210', weight = 1500, type = 'item', image = 'predatek_fast_perch_210.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Predatek Fast Perch 210' },
    sakura_ionizer_bass_insb_701_ml     = { name = 'sakura_ionizer_bass_insb_701_ml', label = 'Sakura Ionizer Bass INSB 701', weight = 1500, type = 'item', image = 'sakura_ionizer_bass_insb_701_ml.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Ionizer Bass INSB 701' },
    sakura_redbird_rds_602_l            = { name = 'sakura_redbird_rds_602_l', label = 'Sakura Redbird RDS 602 L', weight = 1500, type = 'item', image = 'sakura_redbird_rds_602_l.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Redbird RDS 602 L' },
    carpex_cobalt_carp_360              = { name = 'carpex_cobalt_carp_360', label = 'Carpex Cobalt Carp 360', weight = 1500, type = 'item', image = 'carpex_cobalt_carp_360.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Carpex Cobalt Carp 360' },
    sakura_salt_sniper_salss_611_mj1    = { name = 'sakura_salt_sniper_salss_611_mj1', label = 'Sakura Salt Sniper SALSS 611', weight = 1500, type = 'item', image = 'sakura_salt_sniper_salss_611_mj1.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Salt Sniper SALSS 611' },
    sakura_speciz_spes_light_602_zander = { name = 'sakura_speciz_spes_light_602_zander', label = 'Sakura Speciz Spes Light 602', weight = 1500, type = 'item', image = 'sakura_speciz_spes_light_602_zander.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Speciz Spes Light 602' },
    sakura_redbird_rds_662              = { name = 'sakura_redbird_rds_662', label = 'Sakura Redbird RDS 662', weight = 1500, type = 'item', image = 'sakura_redbird_rds_662.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Redbird RDS 662' },
    sakura_salt_sniper_salss_902_h      = { name = 'sakura_salt_sniper_salss_902_h', label = 'Sakura Salt Sniper SALSS 902', weight = 1500, type = 'item', image = 'sakura_salt_sniper_salss_902_h.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Salt Sniper SALSS 902' },
    predatek_seahunter_230              = { name = 'predatek_seahunter_230', label = 'Predatek Seahunter 230', weight = 1500, type = 'item', image = 'predatek_seahunter_230.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Predatek Seahunter 230' },
    sakura_shukan_shuc_661_lj           = { name = 'sakura_shukan_shuc_661_lj', label = 'Sakura Shukan Shuc 661 LJ', weight = 1500, type = 'item', image = 'sakura_shukan_shuc_661_lj.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Shukan Shuc 661 LJ' },
    ufe_powercatch_270                  = { name = 'ufe_powercatch_270', label = 'UFE Powercatch 270', weight = 1500, type = 'item', image = 'ufe_powercatch_270.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Powercatch 270' },
    predatek_pilk_200                   = { name = 'predatek_pilk_200', label = 'Predatek Pilk 200', weight = 1500, type = 'item', image = 'predatek_pilk_200.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Predatek Pilk 200' },
    robinson_carbonic_nordic_pilk_300   = { name = 'robinson_carbonic_nordic_pilk_300', label = 'Robinson Carbonic Nordic Pilk', weight = 1500, type = 'item', image = 'robinson_carbonic_nordic_pilk_300.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Robinson Carbonic Nordic Pilk' },
    carptack_bottom_cast_360            = { name = 'carptack_bottom_cast_360', label = 'Carptack Bottom Cast 360', weight = 1500, type = 'item', image = 'carptack_bottom_cast_360.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Carptack Bottom Cast 360' },
    seax_salfighter_170                 = { name = 'seax_salfighter_170', label = 'Seax Salfighter 170', weight = 1500, type = 'item', image = 'seax_salfighter_170.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Seax Salfighter 170' },

    -- Reels
    ufe_canta_1000                      = { name = 'ufe_canta_1000', label = 'UFE Canta 1000', weight = 1000, type = 'item', image = 'ufe_canta_1000.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Canta 1000' },
    ufe_barracuda_2000bt                = { name = 'ufe_barracuda_2000bt', label = 'UFE Barracuda 2000BT', weight = 1000, type = 'item', image = 'ufe_barracuda_2000bt.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Barracuda 2000BT' },
    sakura_alpax_4508                   = { name = 'sakura_alpax_4508', label = 'Sakura Alpax 4508', weight = 1000, type = 'item', image = 'sakura_alpax_4508.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Alpax 4508' },
    sakura_alpax_8508                   = { name = 'sakura_alpax_8508', label = 'Sakura Alpax 8508', weight = 1000, type = 'item', image = 'sakura_alpax_8508.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Sakura Alpax 8508' },
    ufe_belona_4000                     = { name = 'ufe_belona_4000', label = 'UFE Belona 4000', weight = 1000, type = 'item', image = 'ufe_belona_4000.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Belona 4000' },
    ufe_bigspin_8000b                   = { name = 'ufe_bigspin_8000b', label = 'UFE Bigspin 8000B', weight = 1000, type = 'item', image = 'ufe_bigspin_8000b.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Bigspin 8000B' },
    ufe_batara_8000g                    = { name = 'ufe_batara_8000g', label = 'UFE Batara 8000G', weight = 1000, type = 'item', image = 'ufe_batara_8000g.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Batara 8000G' },
    ufe_batara_1000r                    = { name = 'ufe_batara_1000r', label = 'UFE Batara 1000R', weight = 1000, type = 'item', image = 'ufe_batara_1000r.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Batara 1000R' },
    robinson_big_runner_807qd           = { name = 'robinson_big_runner_807qd', label = 'Robinson Big Runner 807QD', weight = 1000, type = 'item', image = 'robinson_big_runner_807qd.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Robinson Big Runner 807QD' },
    spooler_catchpro_4000fd             = { name = 'spooler_catchpro_4000fd', label = 'Spooler Catchpro 4000FD', weight = 1000, type = 'item', image = 'spooler_catchpro_4000fd.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Spooler Catchpro 4000FD' },
    ufe_opensea_8000_x                  = { name = 'ufe_opensea_8000_x', label = 'UFE Opensea 8000-X', weight = 1000, type = 'item', image = 'ufe_opensea_8000_x.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFE Opensea 8000-X' },
    spooler_catchpro_8000fd             = { name = 'spooler_catchpro_8000fd', label = 'Spooler Catchpro 8000FD', weight = 1000, type = 'item', image = 'spooler_catchpro_8000fd.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Spooler Catchpro 8000FD' },
    spooler_catchpro_14000fd            = { name = 'spooler_catchpro_14000fd', label = 'Spooler Catchpro 14000FD', weight = 1000, type = 'item', image = 'spooler_catchpro_14000fd.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Spooler Catchpro 14000FD' },

    -- Hook
    ufa_bait_hook                       = { name = 'ufa_bait_hook', label = 'UFA Bait', weight = 400, type = 'item', image = 'ufa_bait_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFA Bait' },
    ufa_sproat_hook                     = { name = 'ufa_sproat_hook', label = 'UFA Sproat', weight = 400, type = 'item', image = 'ufa_sproat_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFA Sproat' },
    captack_claw_xl_hook                = { name = 'captack_claw_xl_hook', label = 'Captack Claw XL', weight = 400, type = 'item', image = 'captack_claw_xl_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Captack Claw XL' },
    ufa_sproat_g_hook                   = { name = 'ufa_sproat_g_hook', label = 'UFA Sproat-G', weight = 400, type = 'item', image = 'ufa_sproat_g_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFA Sproat-G' },
    carptack_carp_ss_hook               = { name = 'carptack_carp_ss_hook', label = 'Carptack Carp S&S', weight = 400, type = 'item', image = 'carptack_carp_ss_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Carptack Carp S&S' },
    ufa_wide_gap_bl_hook                = { name = 'ufa_wide_gap_bl_hook', label = 'UFA Wide Gap BL', weight = 400, type = 'item', image = 'ufa_wide_gap_bl_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFA Wide Gap BL' },
    ufa_aberdeen_hook                   = { name = 'ufa_aberdeen_hook', label = 'UFA Aberdeen', weight = 400, type = 'item', image = 'ufa_aberdeen_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFA Aberdeen' },
    ufa_octopus_bl_hook                 = { name = 'ufa_octopus_bl_hook', label = 'UFA Octopus BL', weight = 400, type = 'item', image = 'ufa_octopus_bl_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFA Octopus BL' },
    ufa_livebait_hook                   = { name = 'ufa_livebait_hook', label = 'UFA Livebait', weight = 400, type = 'item', image = 'ufa_livebait_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFA Livebait' },
    carptack_micro_barb_hook            = { name = 'carptack_micro_barb_hook', label = 'Carptack Micro Barb', weight = 400, type = 'item', image = 'carptack_micro_barb_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Carptack Micro Barb' },
    carptack_carp_hook                  = { name = 'carptack_carp_hook', label = 'Carptack Carp', weight = 400, type = 'item', image = 'carptack_carp_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Carptack Carp' },
    ufa_fusion_bl_hook                  = { name = 'ufa_fusion_bl_hook', label = 'UFA Fusion BL', weight = 400, type = 'item', image = 'ufa_fusion_bl_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'UFA Fusion BL' },
    predatek_octopus_hook               = { name = 'predatek_octopus_hook', label = 'Predatek Octopus', weight = 400, type = 'item', image = 'predatek_octopus_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Predatek Octopus' },
    predatek_fusion_hook                = { name = 'predatek_fusion_hook', label = 'Predatek Fusion', weight = 400, type = 'item', image = 'predatek_fusion_hook.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Predatek Fusion' },

    -- Others
    scuba                               = { name = 'scuba', label = 'Scuba gear', weight = 3000, type = 'item', image = 'scuba.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Scuba gear' },
    antique_compass                     = { name = 'antique_compass', label = 'Antique Compass', weight = 400, type = 'item', image = 'antique_compass.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Antique Compass.' },
    rare_spices                         = { name = 'rare_spices', label = 'Rare Spices', weight = 200, type = 'item', image = 'rare_spices.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'Collection of Rare Spices.' },
    ancient_artifact                    = { name = 'ancient_artifact', label = 'Ancient Artifact', weight = 200, type = 'item', image = 'ancient_artifact.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Ancient Artifact!' },
    enchanted_jewel                     = { name = 'enchanted_jewel', label = 'Enchanted Jewel', weight = 150, type = 'item', image = 'enchanted_jewel.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Enchanted Jewel.' },
    meteorite_ore                       = { name = 'meteorite_ore', label = 'Meteorite Ore', weight = 400, type = 'item', image = 'meteorite_ore.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'Meteorite Ore.' },
    phantom_amulet                      = { name = 'phantom_amulet', label = 'Phantom Amulet', weight = 150, type = 'item', image = 'phantom_amulet.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Phantom Amulet.' },
    luxury_watch                        = { name = 'luxury_watch', label = 'Luxury Watch', weight = 200, type = 'item', image = 'luxury_watch.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Expensive Watch.' },
    mystic_crystal                      = { name = 'mystic_crystal', label = 'Mystic Crystal', weight = 300, type = 'item', image = 'mystic_crystal.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Mystic Crystal.' },
    precious_pearls                     = { name = 'precious_pearls', label = 'Precious Pearls', weight = 500, type = 'item', image = 'precious_pearls.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'Handfull of Precious Pearls' },
    spy_gadget                          = { name = 'spy_gadget', label = 'Spy Gadget', weight = 400, type = 'item', image = 'spy_gadget.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Spy Gadget.' },
    fishing_gear                        = { name = 'fishing_gear', label = 'Fishing Gear', weight = 300, type = 'item', image = 'fishing_gear.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'Essential gear for fishing.' },
    research_kit                        = { name = 'research_kit', label = 'Research Kit', weight = 300, type = 'item', image = 'research_kit.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A kit useful for conducting field research.' },

    -- Fishes
    alligator_gar                       = { name = 'alligator_gar', label = 'Alligator Gar', weight = 5500, type = 'item', image = 'alligator_gar.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An alligator gar fish.' },
    amur_pike                           = { name = 'amur_pike', label = 'Amur Pike', weight = 7500, type = 'item', image = 'amur_pike.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Amur Pike fish.' },
    atlantic_cod                        = { name = 'atlantic_cod', label = 'Atlantic Cod', weight = 3000, type = 'item', image = 'atlantic_cod.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Atlantic Cod fish.' },
    atlantic_salmon                     = { name = 'atlantic_salmon', label = 'Atlantic Salmon', weight = 5000, type = 'item', image = 'atlantic_salmon.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Atlantic Salmon fish.' },
    barbel                              = { name = 'barbel', label = 'Barbel', weight = 6000, type = 'item', image = 'barbel.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Barbel fish.' },
    beluga_sturgeon                     = { name = 'beluga_sturgeon', label = 'Beluga Sturgeon', weight = 2640, type = 'item', image = 'beluga_sturgeon.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Beluga Sturgeon fish.' },
    black_grayling                      = { name = 'black_grayling', label = 'Black Grayling', weight = 1200, type = 'item', image = 'black_grayling.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Black Grayling fish.' },
    blacktip_reef_shark                 = { name = 'blacktip_reef_shark', label = 'Blacktip Reef Shark', weight = 15000, type = 'item', image = 'blacktip_reef_shark.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Blacktip Reef Shark.' },
    blue_marlin                         = { name = 'blue_marlin', label = 'Blue Marlin', weight = 2000, type = 'item', image = 'blue_marlin.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Blue Marlin fish.' },
    bluefin_tuna                        = { name = 'bluefin_tuna', label = 'Bluefin Tuna', weight = 2700, type = 'item', image = 'bluefin_tuna.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Bluefin Tuna fish.' },
    bluegill                            = { name = 'bluegill', label = 'Bluegill', weight = 1200, type = 'item', image = 'bluegill.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Bluegill fish.' },
    brook_trout                         = { name = 'brook_trout', label = 'Brook Trout', weight = 7000, type = 'item', image = 'brook_trout.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Brook Trout fish.' },
    brown_trout                         = { name = 'brown_trout', label = 'Brown Trout', weight = 2300, type = 'item', image = 'brown_trout.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Brown Trout fish.' },
    bull_trout                          = { name = 'bull_trout', label = 'Bull Trout', weight = 2000, type = 'item', image = 'bull_trout.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Bull Trout fish.' },
    chub                                = { name = 'chub', label = 'Chub', weight = 1500, type = 'item', image = 'chub.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Chub fish.' },
    chum_salmon                         = { name = 'chum_salmon', label = 'Chum Salmon', weight = 6000, type = 'item', image = 'chum_salmon.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Chum Salmon fish.' },
    coho_salmon                         = { name = 'coho_salmon', label = 'Coho Salmon', weight = 5000, type = 'item', image = 'coho_salmon.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Coho Salmon fish.' },
    common_bleak                        = { name = 'common_bleak', label = 'Common Bleak', weight = 100, type = 'item', image = 'common_bleak.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Common Bleak fish.' },
    common_bream                        = { name = 'common_bream', label = 'Common Bream', weight = 4000, type = 'item', image = 'common_bream.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Common Bream fish.' },
    common_carp                         = { name = 'common_carp', label = 'Common Carp', weight = 7000, type = 'item', image = 'common_carp.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Common Carp fish.' },
    crucian_carp                        = { name = 'crucian_carp', label = 'Crucian Carp', weight = 1400, type = 'item', image = 'crucian_carp.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Crucian Carp fish.' },
    european_bass                       = { name = 'european_bass', label = 'European Bass', weight = 2500, type = 'item', image = 'european_bass.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A European Bass fish.' },
    european_eel                        = { name = 'european_eel', label = 'European Eel', weight = 3000, type = 'item', image = 'european_eel.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A European Eel fish.' },
    european_flounder                   = { name = 'european_flounder', label = 'European Flounder', weight = 1700, type = 'item', image = 'european_flounder.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A European Flounder fish.' },
    european_perch                      = { name = 'european_perch', label = 'European Perch', weight = 5000, type = 'item', image = 'european_perch.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A European Perch fish.' },
    european_sea_sturgeon               = { name = 'european_sea_sturgeon', label = 'European Sea Sturgeon', weight = 20000, type = 'item', image = 'european_sea_sturgeon.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A European Sea Sturgeon.' },
    electric_eel                        = { name = 'electric_eel', label = 'Electric Eel', weight = 15000, type = 'item', image = 'electric_eel.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Electric Eel.' },
    garfish                             = { name = 'garfish', label = 'Garfish', weight = 500, type = 'item', image = 'garfish.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Garfish.' },
    giant_freshwater_stingray           = { name = 'giant_freshwater_stingray', label = 'Giant Freshwater Stingray', weight = 3500, type = 'item', image = 'giant_freshwater_stingray.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Giant Freshwater Stingray.' },
    giant_grouper                       = { name = 'giant_grouper', label = 'Giant Grouper', weight = 2600, type = 'item', image = 'giant_grouper.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Giant Grouper fish.' },
    giant_squid                         = { name = 'giant_squid', label = 'Giant Squid', weight = 20000, type = 'item', image = 'giant_squid.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Giant Squid.' },
    giant_trevally                      = { name = 'giant_trevally', label = 'Giant Trevally', weight = 2000, type = 'item', image = 'giant_trevally.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Giant Trevally fish.' },
    golden_trout                        = { name = 'golden_trout', label = 'Golden Trout', weight = 400, type = 'item', image = 'golden_trout.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Golden Trout fish.' },
    grass_carp                          = { name = 'grass_carp', label = 'Grass Carp', weight = 1200, type = 'item', image = 'grass_carp.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Grass Carp fish.' },
    grass_pickerel                      = { name = 'grass_pickerel', label = 'Grass Pickerel', weight = 900, type = 'item', image = 'grass_pickerel.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Grass Pickerel fish.' },
    grayling                            = { name = 'grayling', label = 'Grayling', weight = 800, type = 'item', image = 'grayling.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Grayling fish.' },
    great_barracuda                     = { name = 'great_barracuda', label = 'Great Barracuda', weight = 9000, type = 'item', image = 'great_barracuda.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Great Barracuda fish.' },
    grey_snapper                        = { name = 'grey_snapper', label = 'Grey Snapper', weight = 4000, type = 'item', image = 'grey_snapper.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Grey Snapper fish.' },
    huchen                              = { name = 'huchen', label = 'Huchen', weight = 15000, type = 'item', image = 'huchen.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Huchen fish.' },
    ide                                 = { name = 'ide', label = 'Ide', weight = 1000, type = 'item', image = 'ide.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Ide fish.' },
    indian_threadfish                   = { name = 'indian_threadfish', label = 'Indian Threadfish', weight = 2500, type = 'item', image = 'indian_threadfish.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'An Indian Threadfish.' },
    lake_sturgeon                       = { name = 'lake_sturgeon', label = 'Lake Sturgeon', weight = 16000, type = 'item', image = 'lake_sturgeon.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Lake Sturgeon fish.' },
    largemouth_bass                     = { name = 'largemouth_bass', label = 'Largemouth Bass', weight = 1000, type = 'item', image = 'largemouth_bass.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Largemouth Bass fish.' },
    mahi_mahi                           = { name = 'mahi_mahi', label = 'Mahi-Mahi', weight = 10000, type = 'item', image = 'mahi_mahi.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Mahi-Mahi fish.' },
    malabar_grouper                     = { name = 'malabar_grouper', label = 'Malabar Grouper', weight = 15000, type = 'item', image = 'malabar_grouper.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Malabar Grouper fish.' },
    mirror_carp                         = { name = 'mirror_carp', label = 'Mirror Carp', weight = 7000, type = 'item', image = 'mirror_carp.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Mirror Carp fish.' },
    northern_pike                       = { name = 'northern_pike', label = 'Northern Pike', weight = 5000, type = 'item', image = 'northern_pike.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Northern Pike fish.' },
    pink_river_dolphin                  = { name = 'pink_river_dolphin', label = 'Pink River Dolphin', weight = 15500, type = 'item', image = 'pink_river_dolphin.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Pink River Dolphin.' },
    pink_salmon                         = { name = 'pink_salmon', label = 'Pink Salmon', weight = 2000, type = 'item', image = 'pink_salmon.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Pink Salmon fish.' },
    prussian_carp                       = { name = 'prussian_carp', label = 'Prussian Carp', weight = 900, type = 'item', image = 'prussian_carp.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Prussian Carp fish.' },
    pufferfish                          = { name = 'pufferfish', label = 'Pufferfish', weight = 1500, type = 'item', image = 'pufferfish.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Pufferfish.' },
    pumpkinseed                         = { name = 'pumpkinseed', label = 'Pumpkinseed', weight = 400, type = 'item', image = 'pumpkinseed.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Pumpkinseed fish.' },
    rainbow_trout                       = { name = 'rainbow_trout', label = 'Rainbow Trout', weight = 1000, type = 'item', image = 'rainbow_trout.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Rainbow Trout fish.' },
    red_lionfish                        = { name = 'red_lionfish', label = 'Red Lionfish', weight = 1000, type = 'item', image = 'red_lionfish.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Red Lionfish.' },
    redeye_piranha                      = { name = 'redeye_piranha', label = 'Redeye Piranha', weight = 1200, type = 'item', image = 'redeye_piranha.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Redeye Piranha.' },
    redfin_pickerel                     = { name = 'redfin_pickerel', label = 'Redfin Pickerel', weight = 400, type = 'item', image = 'redfin_pickerel.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Redfin Pickerel fish.' },
    roach                               = { name = 'roach', label = 'Roach', weight = 500, type = 'item', image = 'roach.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Roach fish.' },
    sea_trout                           = { name = 'sea_trout', label = 'Sea Trout', weight = 2000, type = 'item', image = 'sea_trout.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Sea Trout fish.' },
    silver_carp                         = { name = 'silver_carp', label = 'Silver Carp', weight = 10000, type = 'item', image = 'silver_carp.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Silver Carp fish.' },
    skeleton                            = { name = 'skeleton', label = 'Skeleton', weight = 100, type = 'item', image = 'skeleton.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Skeleton.' },
    smallmouth_bass                     = { name = 'smallmouth_bass', label = 'Smallmouth Bass', weight = 1500, type = 'item', image = 'smallmouth_bass.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Smallmouth Bass fish.' },
    sockeye_salmon                      = { name = 'sockeye_salmon', label = 'Sockeye Salmon', weight = 3000, type = 'item', image = 'sockeye_salmon.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Sockeye Salmon fish.' },
    south_sea_pearl_oyster              = { name = 'south_sea_pearl_oyster', label = 'South Sea Pearl Oyster', weight = 100, type = 'item', image = 'south_sea_pearl_oyster.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A South Sea Pearl Oyster.' },
    tench                               = { name = 'tench', label = 'Tench', weight = 2500, type = 'item', image = 'tench.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Tench fish.' },
    tiger_shark                         = { name = 'tiger_shark', label = 'Tiger Shark', weight = 55000, type = 'item', image = 'tiger_shark.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Tiger Shark.' },
    wels_catfish                        = { name = 'wels_catfish', label = 'Wels Catfish', weight = 4000, type = 'item', image = 'wels_catfish.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Wels Catfish fish.' },
    white_sturgeon                      = { name = 'white_sturgeon', label = 'White Sturgeon', weight = 8000, type = 'item', image = 'white_sturgeon.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A White Sturgeon fish.' },
    yellow_perch                        = { name = 'yellow_perch', label = 'Yellow Perch', weight = 400, type = 'item', image = 'yellow_perch.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Yellow Perch fish.' },
    yellowfin_tuna                      = { name = 'yellowfin_tuna', label = 'Yellowfin Tuna', weight = 9000, type = 'item', image = 'yellowfin_tuna.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Yellowfin Tuna fish.' },
    yellowtail_barracuda                = { name = 'yellowtail_barracuda', label = 'Yellowtail Barracuda', weight = 1100, type = 'item', image = 'yellowtail_barracuda.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Yellowtail Barracuda.' },
    zander                              = { name = 'zander', label = 'Zander', weight = 2000, type = 'item', image = 'zander.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A Zander fish.' },
    paddlefish                          = { name = 'paddlefish', label = 'Paddle Fish', weight = 10000, type = 'item', image = 'paddlefish.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A rare and illegal Paddle Fish.' },
    sawfish                             = { name = 'sawfish', label = 'Saw Fish', weight = 10000, type = 'item', image = 'sawfish.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A rare and illegal Saw Fish.' },
    eel                                 = { name = 'eel', label = 'Eel', weight = 10000, type = 'item', image = 'eel.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A rare and illegal Eel.' },
    hammerheadshark                     = { name = 'hammerheadshark', label = 'Hammer Head Shark', weight = 25000, type = 'item', image = 'hammerheadshark.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A rare and illegal Hammer Head Shark.' },
    seaturtle                           = { name = 'seaturtle', label = 'Sea Turtle', weight = 25000, type = 'item', image = 'seaturtle.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A rare and illegal Sea Turtle.' },
    leopardshark                        = { name = 'leopardshark', label = 'Leopard Shark', weight = 25000, type = 'item', image = 'leopardshark.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A rare and illegal Leopard Shark.' },
    blueshark                           = { name = 'blueshark', label = 'Blue Shark', weight = 40000, type = 'item', image = 'blueshark.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A legendary and illegal Blue Shark.' },
    greatwhiteshark                     = { name = 'greatwhiteshark', label = 'Great White Shark', weight = 100000, type = 'item', image = 'greatwhiteshark.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = 'A mythic and illegal Great White Shark.' },

    -- m-Lumberjack
    runrepairkit                        = { name = "runrepairkit", label = "Run Repairkit", weight = 25, type = "item", image = "repairkit.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },

    wood                                = { name = "wood", label = "Wood", weight = 25, type = "item", image = "wood.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },
    wood_packaged                       = { name = "wood_packaged", label = "Wood Packaged", weight = 25, type = "item", image = "wood_packaged.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },
    resin                               = { name = "resin", label = "Resin", weight = 25, type = "item", image = "resin.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },
    resin_packaged                      = { name = "resin_packaged", label = "Resin Packaged", weight = 25, type = "item", image = "resin_packaged.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },
    leaf                                = { name = "leaf", label = "Leaf", weight = 25, type = "item", image = "leaf.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },

    axelevel1                           = { name = "axelevel1", label = "Axe Level 1", weight = 25, type = "item", image = "axelevel1.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },
    axelevel2                           = { name = "axelevel2", label = "Axe Level 2", weight = 25, type = "item", image = "axelevel2.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },
    axelevel3                           = { name = "axelevel3", label = "Axe Level 3", weight = 25, type = "item", image = "axelevel3.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },
    axelevel4                           = { name = "axelevel4", label = "Axe Level 4", weight = 25, type = "item", image = "axelevel4.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },
    axelevel5                           = { name = "axelevel5", label = "Axe Level 5", weight = 25, type = "item", image = "axelevel5.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },

    lumberjack_ticket                   = { name = "lumberjack_ticket", label = "Lumberjack Ticket", weight = 25, type = "item", image = "lumberjack_ticket.png", unique = false, useable = true, shouldClose = true, combinable = nil, description = "" },

    --Kyros Weapon Pack V5
    weapon_bar15                        = { name = 'weapon_bar15', label = 'PD AR-15', weight = 2000, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_BAR15.png', unique = true, useable = false, description = '' },
    weapon_blackarp                     = { name = 'weapon_blackarp', label = 'BLACK ARP', weight = 5500, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_BLACKARP.png', unique = true, useable = false, description = '' },
    weapon_bscar                        = { name = 'weapon_bscar', label = 'BLACK SCAR', weight = 5500, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_BSCAR.png', unique = true, useable = false, description = '' },
    weapon_thompson                     = { name = 'weapon_thompson', label = 'BLACK THOMPSON', weight = 6000, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_THOMPSON.png', unique = true, useable = false, description = '' },
    weapon_dmk18                        = { name = 'weapon_dmk18', label = 'PD DESERET MK18', weight = 2000, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_DMK18.png', unique = true, useable = false, description = '' },
    weapon_lbtarp                       = { name = 'weapon_lbtarp', label = 'PD LB TAN ARP', weight = 2000, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_LBTARP.png', unique = true, useable = false, description = '' },
    weapon_ram7                         = { name = 'weapon_ram7', label = 'RAM-7', weight = 5200, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_RAM7.png', unique = true, useable = false, description = '' },
    weapon_redarp                       = { name = 'weapon_redarp', label = 'RED DRAG ARP', weight = 4500, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_REDARP.png', unique = true, useable = false, description = '' },
    weapon_redm4a1                      = { name = 'weapon_redm4a1', label = 'RED DRAG M4A1', weight = 6200, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_REDM4A1.png', unique = true, useable = false, description = '' },
    weapon_tarp                         = { name = 'weapon_tarp', label = 'TAN ARP', weight = 4600, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_TARP.png', unique = true, useable = false, description = '' },
    weapon_woarp                        = { name = 'weapon_woarp', label = 'WHITE OUT ARP', weight = 4500, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_WOARP.png', unique = true, useable = false, description = '' },
    weapon_blueglocks                   = { name = 'weapon_blueglocks', label = 'BLUE GLOCK SWITCH', weight = 2000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_BLUEGLOCKS.png', unique = true, useable = false, description = '' },
    weapon_fn57                         = { name = 'weapon_fn57', label = 'PD FN Five-seveN', weight = 1000, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_FN57.png', unique = true, useable = false, description = '' },
    weapon_glock21                      = { name = 'weapon_glock21', label = 'PD GLOCK 21', weight = 1000, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_GLOCK21.png', unique = true, useable = false, description = '' },
    weapon_glock41                      = { name = 'weapon_glock41', label = 'GLOCK 41', weight = 1700, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_GLOCK41.png', unique = true, useable = false, description = '' },
    weapon_glockbeams                   = { name = 'weapon_glockbeams', label = 'GLOCK BEAM SWITCH', weight = 2000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_GLOCKBEAMS.png', unique = true, useable = false, description = '' },
    weapon_p30l                         = { name = 'weapon_p30l', label = 'H&K P30L', weight = 1900, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_P30L.png', unique = true, useable = false, description = '' },
    weapon_illglock17                   = { name = 'weapon_illglock17', label = 'PD GLOCK 17', weight = 1000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_ILLGLOCK17.png', unique = true, useable = false, description = '' },
    weapon_mgglock                      = { name = 'weapon_mgglock', label = 'MG GLOCK', weight = 2000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_MGGLOCK.png', unique = true, useable = false, description = '' },
    weapon_midasglock                   = { name = 'weapon_midasglock', label = 'MIDAS GLOCK', weight = 1000, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_MIDASGLOCK.png', unique = true, useable = false, description = '' },
    weapon_p210                         = { name = 'weapon_p210', label = 'P210 CARRY', weight = 1800, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_P210.png', unique = true, useable = false, description = '' },
    weapon_sr40                         = { name = 'weapon_sr40', label = 'RUGER SR40', weight = 1400, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_SR40.png', unique = true, useable = false, description = '' },
    weapon_t1911                        = { name = 'weapon_t1911', label = 'TAN 1911', weight = 2000, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_T1911.png', unique = true, useable = false, description = '' },
    weapon_tglock19                     = { name = 'weapon_tglock19', label = 'TAN G19', weight = 2100, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_TGLOCK19.png', unique = true, useable = false, description = '' },
    weapon_axe                          = { name = 'weapon_axe', label = 'AXE', weight = 2000, type = 'weapon', ammotype = nil, image = 'WEAPON_AXE.png', unique = true, useable = false, description = '' },
    weapon_chair                        = { name = 'weapon_chair', label = 'BRAWL CHAIR', weight = 3000, type = 'weapon', ammotype = nil, image = 'WEAPON_CHAIR.png', unique = true, useable = false, description = '' },
    weapon_krissvector                  = { name = 'weapon_krissvector', label = 'KRISS VECTOR', weight = 3900, type = 'weapon', ammotype = 'AMMO_SMG', image = 'WEAPON_KRISSVECTOR.png', unique = true, useable = false, description = '' },
    weapon_tec9s                        = { name = 'weapon_tec9s', label = 'TEC 9 W STRAP', weight = 2900, type = 'weapon', ammotype = 'AMMO_SMG', image = 'WEAPON_TEC9S.png', unique = true, useable = false, description = '' },
    weapon_m500                         = { name = 'weapon_m500', label = 'MOSSBERG 500', weight = 4500, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_M500.png', unique = true, useable = false, description = '' },
    weapon_r590                         = { name = 'weapon_r590', label = 'REMINGTON 590', weight = 3100, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_R590.png', unique = true, useable = false, description = '' },

    -- Assets Weapons Pack
    -- Assault Rifles
    weapon_assaultrifle                 = { name = 'weapon_assaultrifle', label = 'Assault Rifle', weight = 3500, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_ASSAULTRIFLE.png', unique = true, useable = false, description = 'Standard assault rifle' },
    weapon_carbinerifle                 = { name = 'weapon_carbinerifle', label = 'Carbine Rifle', weight = 3600, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_CARBINERIFLE.png', unique = true, useable = false, description = 'Military carbine rifle' },
    weapon_advancedrifle                = { name = 'weapon_advancedrifle', label = 'Advanced Rifle', weight = 3800, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_ADVANCEDRIFLE.png', unique = true, useable = false, description = 'Advanced assault rifle' },
    weapon_specialcarbine               = { name = 'weapon_specialcarbine', label = 'Special Carbine', weight = 3700, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_SPECIALCARBINE.png', unique = true, useable = false, description = 'Special forces carbine' },
    weapon_bullpuprifle                 = { name = 'weapon_bullpuprifle', label = 'Bullpup Rifle', weight = 3600, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_BULLPUPRIFLE.png', unique = true, useable = false, description = 'Bullpup assault rifle' },
    weapon_compactrifle                 = { name = 'weapon_compactrifle', label = 'Compact Rifle', weight = 3200, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_COMPACTRIFLE.png', unique = true, useable = false, description = 'Compact assault rifle' },
    weapon_ak47                         = { name = 'weapon_ak47', label = 'AK-47', weight = 4000, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_AK47.png', unique = true, useable = false, description = 'Classic assault rifle' },
    weapon_ak47m2                       = { name = 'weapon_ak47m2', label = 'AK-47 M2', weight = 4000, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_AK47M2.png', unique = true, useable = false, description = 'Modernized AK-47' },
    weapon_ak74                         = { name = 'weapon_ak74', label = 'AK-74', weight = 3800, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_AK74.png', unique = true, useable = false, description = 'Soviet assault rifle' },
    weapon_aks74                        = { name = 'weapon_aks74', label = 'AKS-74', weight = 3600, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_AKS74.png', unique = true, useable = false, description = 'Folding stock AK-74' },
    weapon_ar15                         = { name = 'weapon_ar15', label = 'AR-15', weight = 3500, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_AR15.png', unique = true, useable = false, description = 'American assault rifle' },
    weapon_ar16                         = { name = 'weapon_ar16', label = 'AR-16', weight = 3600, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_AR16.png', unique = true, useable = false, description = 'Advanced assault rifle' },
    weapon_fnfal                        = { name = 'weapon_fnfal', label = 'FN FAL', weight = 4500, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_FNFAL.png', unique = true, useable = false, description = 'Battle rifle' },
    weapon_scarh                        = { name = 'weapon_scarh', label = 'SCAR-H', weight = 4200, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_SCARH.png', unique = true, useable = false, description = 'Heavy assault rifle' },
    weapon_tar21                        = { name = 'weapon_tar21', label = 'TAR-21', weight = 3800, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_TAR21.png', unique = true, useable = false, description = 'Bullpup assault rifle' },
    weapon_pdm4a1                       = { name = 'weapon_pdm4a1', label = 'PDM M4A1', weight = 3500, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_PDM4A1.png', unique = true, useable = false, description = 'Police M4A1' },

	-- Skins
	weapon_ar15hw                       = { name = 'weapon_ar15hw', label = 'AR-15 Halloween', weight = 3500, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_AR15HW.png', unique = true, useable = false, description = 'Halloween themed AR-15' },
	weapon_toym16                       = { name = 'weapon_toym16', label = 'TOYM16', weight = 3500, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'WEAPON_TOYM16.png', unique = true, useable = false, description = 'Toy M16 assault rifle' },
	weapon_saiga9                       = { name = 'weapon_saiga9', label = 'Saiga-9', weight = 3500, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_SAIGA9.png', unique = true, useable = false, description = 'Custom Saiga-9 shotgun' },
	weapon_patchday_pistol             = { name = 'weapon_patchday_pistol', label = 'Patchday Combat Pistol', weight = 1500, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_PATCHDAY_PISTOL.png', unique = true, useable = false, description = 'Custom patchday combat pistol' },

    -- Pistols
    weapon_de                           = { name = 'weapon_de', label = 'Desert Eagle', weight = 2000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_DE.png', unique = true, useable = false, description = 'Powerful handgun' },
    weapon_browning                      = { name = 'weapon_browning', label = 'Browning', weight = 1200, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_BROWNING.png', unique = true, useable = false, description = 'Classic pistol' },
    weapon_dp9                          = { name = 'weapon_dp9', label = 'DP9', weight = 1000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_DP9.png', unique = true, useable = false, description = 'Compact pistol' },
    weapon_fnfnx45                       = { name = 'weapon_fnfnx45', label = 'FN FNX-45', weight = 1500, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_FNFNX45.png', unique = true, useable = false, description = 'Tactical pistol' },
    weapon_glock17                       = { name = 'weapon_glock17', label = 'Glock 17', weight = 1200, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_GLOCK17.png', unique = true, useable = false, description = 'Reliable pistol' },
    weapon_glock20                       = { name = 'weapon_glock20', label = 'Glock 20', weight = 1300, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_GLOCK20.png', unique = true, useable = false, description = '10mm pistol' },
    weapon_glock22                       = { name = 'weapon_glock22', label = 'Glock 22', weight = 1200, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_GLOCK22.png', unique = true, useable = false, description = 'Police pistol' },
    weapon_m9a3                         = { name = 'weapon_m9a3', label = 'M9A3', weight = 1400, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_M9A3.png', unique = true, useable = false, description = 'Military pistol' },
    weapon_m45a1                        = { name = 'weapon_m45a1', label = 'M45A1', weight = 1500, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_M45A1.png', unique = true, useable = false, description = 'Marine pistol' },
    weapon_manurhin                      = { name = 'weapon_manurhin', label = 'Manurhin', weight = 1300, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_MANURHIN.png', unique = true, useable = false, description = 'French pistol' },
    weapon_python                        = { name = 'weapon_python', label = 'Python', weight = 1800, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_PYTHON.png', unique = true, useable = false, description = 'Revolver' },
    weapon_ragingbull                    = { name = 'weapon_ragingbull', label = 'Raging Bull', weight = 2000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_RAGINGBULL.png', unique = true, useable = false, description = 'Powerful revolver' },

    -- Submachine Guns
    weapon_draco                        = { name = 'weapon_draco', label = 'Draco', weight = 2500, type = 'weapon', ammotype = 'AMMO_SMG', image = 'WEAPON_DRACO.png', unique = true, useable = false, description = 'Compact SMG' },
    weapon_mp9                          = { name = 'weapon_mp9', label = 'MP9', weight = 2200, type = 'weapon', ammotype = 'AMMO_SMG', image = 'WEAPON_MP9.png', unique = true, useable = false, description = 'Tactical SMG' },

    -- Shotguns
    weapon_aa12                         = { name = 'weapon_aa12', label = 'AA-12', weight = 5000, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_AA12.png', unique = true, useable = false, description = 'Automatic shotgun' },
    weapon_komrad12                     = { name = 'weapon_komrad12', label = 'Komrad 12', weight = 4500, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_KOMRAD12.png', unique = true, useable = false, description = 'Tactical shotgun' },
    weapon_mossberg500                   = { name = 'weapon_mossberg500', label = 'Mossberg 500', weight = 4000, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_MOSSBERG500.png', unique = true, useable = false, description = 'Pump shotgun' },
    weapon_remington870                 = { name = 'weapon_remington870', label = 'Remington 870', weight = 3800, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_REMINGTON870.png', unique = true, useable = false, description = 'Classic shotgun' },
    weapon_saiga12g                     = { name = 'weapon_saiga12g', label = 'Saiga 12G', weight = 4200, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_SAIGA12G.png', unique = true, useable = false, description = 'Semi-auto shotgun' },
    weapon_spas12                       = { name = 'weapon_spas12', label = 'SPAS-12', weight = 4500, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'WEAPON_SPAS12.png', unique = true, useable = false, description = 'Dual-mode shotgun' },

    -- Machine Guns
    weapon_m249                         = { name = 'weapon_m249', label = 'M249', weight = 8000, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_M249.png', unique = true, useable = false, description = 'Light machine gun' },
    weapon_m249_mk2                     = { name = 'weapon_m249_mk2', label = 'M249 MK2', weight = 8200, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_M249_MK2.png', unique = true, useable = false, description = 'Upgraded LMG' },
    weapon_pkm                          = { name = 'weapon_pkm', label = 'PKM', weight = 9000, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_PKM.png', unique = true, useable = false, description = 'Russian LMG' },
    weapon_rpd                          = { name = 'weapon_rpd', label = 'RPD', weight = 8500, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_RPD.png', unique = true, useable = false, description = 'Drum-fed LMG' },
    weapon_rpd2                         = { name = 'weapon_rpd2', label = 'RPD2', weight = 8600, type = 'weapon', ammotype = 'AMMO_MG', image = 'WEAPON_RPD2.png', unique = true, useable = false, description = 'Modern RPD' },

    -- Sniper Rifles
    weapon_m110                         = { name = 'weapon_m110', label = 'M110', weight = 6000, type = 'weapon', ammotype = 'AMMO_SNIPER', image = 'WEAPON_M110.png', unique = true, useable = false, description = 'Semi-auto sniper' },
    weapon_mk14                         = { name = 'weapon_mk14', label = 'MK14', weight = 5500, type = 'weapon', ammotype = 'AMMO_SNIPER', image = 'WEAPON_MK14.png', unique = true, useable = false, description = 'Battle rifle sniper' },

    -- Melee Weapons
    weapon_katana                       = { name = 'weapon_katana', label = 'Katana', weight = 1500, type = 'weapon', ammotype = nil, image = 'WEAPON_KATANA.png', unique = true, useable = false, description = 'Japanese sword' },
    weapon_keyboard                     = { name = 'weapon_keyboard', label = 'Keyboard', weight = 800, type = 'weapon', ammotype = nil, image = 'WEAPON_KEYBOARD.png', unique = true, useable = false, description = 'Office weapon' },
    weapon_khukuri                      = { name = 'weapon_khukuri', label = 'Khukuri', weight = 1200, type = 'weapon', ammotype = nil, image = 'WEAPON_KHUKURI.png', unique = true, useable = false, description = 'Nepalese knife' },
    weapon_krambit                      = { name = 'weapon_krambit', label = 'Krambit', weight = 600, type = 'weapon', ammotype = nil, image = 'WEAPON_KRAMBIT.png', unique = true, useable = false, description = 'Curved blade' },
    weapon_penetrator                   = { name = 'weapon_penetrator', label = 'Penetrator', weight = 1000, type = 'weapon', ammotype = nil, image = 'WEAPON_PENETRATOR.png', unique = true, useable = false, description = 'Sharp weapon' },
    weapon_pick                         = { name = 'weapon_pick', label = 'Pickaxe', weight = 3000, type = 'weapon', ammotype = nil, image = 'WEAPON_PICK.png', unique = true, useable = false, description = 'Mining tool' },
    weapon_riftedge                     = { name = 'weapon_riftedge', label = 'Rift Edge', weight = 1800, type = 'weapon', ammotype = nil, image = 'WEAPON_RIFTEDGE.png', unique = true, useable = false, description = 'Mystical blade' },
    weapon_shiv                         = { name = 'weapon_shiv', label = 'Shiv', weight = 300, type = 'weapon', ammotype = nil, image = 'WEAPON_SHIV.png', unique = true, useable = false, description = 'Prison weapon' },
    weapon_sledgehammer                 = { name = 'weapon_sledgehammer', label = 'Sledgehammer', weight = 5000, type = 'weapon', ammotype = nil, image = 'WEAPON_SLEDGEHAMMER.png', unique = true, useable = false, description = 'Heavy hammer' },
    weapon_steel_mace                   = { name = 'weapon_steel_mace', label = 'Steel Mace', weight = 2500, type = 'weapon', ammotype = nil, image = 'WEAPON_STEEL_MACE.png', unique = true, useable = false, description = 'Medieval weapon' },
    weapon_sword                        = { name = 'weapon_sword', label = 'Sword', weight = 2000, type = 'weapon', ammotype = nil, image = 'WEAPON_SWORD.png', unique = true, useable = false, description = 'Classic sword' },
    weapon_berserker                    = { name = 'weapon_berserker', label = 'Berserker', weight = 4000, type = 'weapon', ammotype = nil, image = 'WEAPON_BERSERKER.png', unique = true, useable = false, description = 'Fierce weapon' },
    weapon_dildo                        = { name = 'weapon_dildo', label = 'Dildo', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_DILDO.png', unique = true, useable = false, description = 'Unconventional weapon' },

    -- Grenades
    weapon_m67                          = { name = 'weapon_m67', label = 'M67 Grenade', weight = 400, type = 'weapon', ammotype = nil, image = 'WEAPON_M67.png', unique = true, useable = false, description = 'Fragmentation grenade' },
    weapon_flashbang                    = { name = 'weapon_flashbang', label = 'Flashbang', weight = 300, type = 'weapon', ammotype = nil, image = 'WEAPON_FLASHBANG.png', unique = true, useable = false, description = 'Stun grenade' },

    -- Special
    weapon_bdhg                         = { name = 'weapon_bdhg', label = 'BDHG', weight = 1000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'WEAPON_BDHG.png', unique = true, useable = false, description = 'Special weapon' },

    -- CS:GO Knives Pack (Heist Knives) - M9 Bayonet Variants
    weapon_m9_autotronic                = { name = 'weapon_m9_autotronic', label = 'M9 Bayonet Autotronic', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_AUTOTRONIC.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_blacklaminate             = { name = 'weapon_m9_blacklaminate', label = 'M9 Bayonet Black Laminate', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_BLACKLAMINATE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_bluesteel                 = { name = 'weapon_m9_bluesteel', label = 'M9 Bayonet Blue Steel', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_BLUESTEEL.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_brightwater               = { name = 'weapon_m9_brightwater', label = 'M9 Bayonet Bright Water', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_BRIGHTWATER.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_casehardened              = { name = 'weapon_m9_casehardened', label = 'M9 Bayonet Case Hardened', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_CASEHARDENED.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_crimsonweb                = { name = 'weapon_m9_crimsonweb', label = 'M9 Bayonet Crimson Web', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_CRIMSONWEB.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_damascussteel              = { name = 'weapon_m9_damascussteel', label = 'M9 Bayonet Damascus Steel', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_DAMASCUSSTEEL.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_dopplerblackpearl         = { name = 'weapon_m9_dopplerblackpearl', label = 'M9 Bayonet Doppler Black Pearl', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_DOPPLERBLACKPEARL.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_dopplerp1                 = { name = 'weapon_m9_dopplerp1', label = 'M9 Bayonet Doppler Phase 1', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_DOPPLERP1.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_dopplerp2                 = { name = 'weapon_m9_dopplerp2', label = 'M9 Bayonet Doppler Phase 2', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_DOPPLERP2.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_dopplerp3                 = { name = 'weapon_m9_dopplerp3', label = 'M9 Bayonet Doppler Phase 3', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_DOPPLERP3.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_dopplerp4                 = { name = 'weapon_m9_dopplerp4', label = 'M9 Bayonet Doppler Phase 4', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_DOPPLERP4.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_dopplerruby               = { name = 'weapon_m9_dopplerruby', label = 'M9 Bayonet Doppler Ruby', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_DOPPLERRUBY.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_dopplersapphire           = { name = 'weapon_m9_dopplersapphire', label = 'M9 Bayonet Doppler Sapphire', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_DOPPLERSAPPHIRE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_gdemerald                 = { name = 'weapon_m9_gdemerald', label = 'M9 Bayonet Emerald', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_GDEMERALD.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_fade                      = { name = 'weapon_m9_fade', label = 'M9 Bayonet Fade', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_FADE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_freehand                  = { name = 'weapon_m9_freehand', label = 'M9 Bayonet Free Hand', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_FREEHAND.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_gdp1                      = { name = 'weapon_m9_gdp1', label = 'M9 Bayonet Gamma Doppler Phase 1', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_GDP1.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_gdp2                      = { name = 'weapon_m9_gdp2', label = 'M9 Bayonet Gamma Doppler Phase 2', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_GDP2.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_gdp3                      = { name = 'weapon_m9_gdp3', label = 'M9 Bayonet Gamma Doppler Phase 3', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_GDP3.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_gdp4                      = { name = 'weapon_m9_gdp4', label = 'M9 Bayonet Gamma Doppler Phase 4', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_GDP4.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_lore                      = { name = 'weapon_m9_lore', label = 'M9 Bayonet Lore', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_LORE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_marblefade                = { name = 'weapon_m9_marblefade', label = 'M9 Bayonet Marble Fade', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_MARBLEFADE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_safarimesh                = { name = 'weapon_m9_safarimesh', label = 'M9 Bayonet Safari Mesh', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_SAFARIMESH.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_scorched                  = { name = 'weapon_m9_scorched', label = 'M9 Bayonet Scorched', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_SCORCHED.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_slaugther                 = { name = 'weapon_m9_slaugther', label = 'M9 Bayonet Slaugther', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_SLAUGTHER.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_stained                   = { name = 'weapon_m9_stained', label = 'M9 Bayonet Stained', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_STAINED.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_tigertooth                = { name = 'weapon_m9_tigertooth', label = 'M9 Bayonet Tiger Tooth', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_TIGERTOOTH.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_ultraviolet               = { name = 'weapon_m9_ultraviolet', label = 'M9 Bayonet Ultra Violet', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_ULTRAVIOLET.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_m9_urbanmasked               = { name = 'weapon_m9_urbanmasked', label = 'M9 Bayonet Urban Masked', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_M9_URBANMASKED.png', unique = true, useable = false, description = 'CS:GO Knife' },

    -- CS:GO Knives Pack - Butterfly Knife Variants
    weapon_bf_bluesteel                 = { name = 'weapon_bf_bluesteel', label = 'Butterfly Blue Steel', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_BLUESTEEL.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_borealforest              = { name = 'weapon_bf_borealforest', label = 'Butterfly Boreal Forest', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_BOREALFOREST.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_casehardened              = { name = 'weapon_bf_casehardened', label = 'Butterfly Case Hardened', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_CASEHARDENED.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_crimsonweb                = { name = 'weapon_bf_crimsonweb', label = 'Butterfly Crimson Web', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_CRIMSONWEB.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_damascussteel              = { name = 'weapon_bf_damascussteel', label = 'Butterfly Damascus Steel', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_DAMASCUSSTEEL.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_dopplerblackpearl         = { name = 'weapon_bf_dopplerblackpearl', label = 'Butterfly Doppler Black Pearl', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_DOPPLERBLACKPEARL.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_dopplerphase1             = { name = 'weapon_bf_dopplerphase1', label = 'Butterfly Doppler Phase 1', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_DOPPLERPHASE1.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_dopplerphase2             = { name = 'weapon_bf_dopplerphase2', label = 'Butterfly Doppler Phase 2', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_DOPPLERPHASE2.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_dopplerphase3             = { name = 'weapon_bf_dopplerphase3', label = 'Butterfly Doppler Phase 3', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_DOPPLERPHASE3.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_dopplerphase4             = { name = 'weapon_bf_dopplerphase4', label = 'Butterfly Doppler Phase 4', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_DOPPLERPHASE4.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_dopplerruby               = { name = 'weapon_bf_dopplerruby', label = 'Butterfly Doppler Ruby', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_DOPPLERRUBY.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_dopplersapphire           = { name = 'weapon_bf_dopplersapphire', label = 'Butterfly Doppler Sapphire', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_DOPPLERSAPPHIRE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_fade                      = { name = 'weapon_bf_fade', label = 'Butterfly Fade', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_FADE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_forest                    = { name = 'weapon_bf_forest', label = 'Butterfly Forest', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_FOREST.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_night                     = { name = 'weapon_bf_night', label = 'Butterfly Night', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_NIGHT.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_rustcoat                  = { name = 'weapon_bf_rustcoat', label = 'Butterfly Rust Coat', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_RUSTCOAT.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_safarimesh                = { name = 'weapon_bf_safarimesh', label = 'Butterfly Safari Mesh', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_SAFARIMESH.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_scorched                  = { name = 'weapon_bf_scorched', label = 'Butterfly Scorched', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_SCORCHED.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_slaugther                 = { name = 'weapon_bf_slaugther', label = 'Butterfly Slaugther', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_SLAUGTHER.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_stained                   = { name = 'weapon_bf_stained', label = 'Butterfly Stained', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_STAINED.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_tigertooth                = { name = 'weapon_bf_tigertooth', label = 'Butterfly Tiger Tooth', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_TIGERTOOTH.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_ultraviolet               = { name = 'weapon_bf_ultraviolet', label = 'Butterfly Ultra Violet', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_ULTRAVIOLET.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_bf_urbanmasked               = { name = 'weapon_bf_urbanmasked', label = 'Butterfly Urban Masked', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_BF_URBANMASKED.png', unique = true, useable = false, description = 'CS:GO Knife' },

    -- CS:GO Knives Pack - Karambit Variants
    weapon_karambit_autotronic          = { name = 'weapon_karambit_autotronic', label = 'Karambit Autotronic', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_AUTOTRONIC.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_blacklaminate       = { name = 'weapon_karambit_blacklaminate', label = 'Karambit Black Laminate', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_BLACKLAMINATE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_bluesteel           = { name = 'weapon_karambit_bluesteel', label = 'Karambit Blue Steel', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_BLUESTEEL.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_borealforest        = { name = 'weapon_karambit_borealforest', label = 'Karambit Boreal Forest', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_BOREALFOREST.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_brightwater         = { name = 'weapon_karambit_brightwater', label = 'Karambit Bright Water', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_BRIGHTWATER.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_casehardened        = { name = 'weapon_karambit_casehardened', label = 'Karambit Case Hardened', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_CASEHARDENED.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_crimsonweb          = { name = 'weapon_karambit_crimsonweb', label = 'Karambit Crimson Web', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_CRIMSONWEB.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_damascussteel       = { name = 'weapon_karambit_damascussteel', label = 'Karambit Damascus Steel', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_DAMASCUSSTEEL.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_dopplerblackpearl   = { name = 'weapon_karambit_dopplerblackpearl', label = 'Karambit Doppler BlackPearl', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_DOPPLERBLACKPEARL.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_dopplerphase1       = { name = 'weapon_karambit_dopplerphase1', label = 'Karambit Doppler Phase 1', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_DOPPLERPHASE1.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_dopplerphase2       = { name = 'weapon_karambit_dopplerphase2', label = 'Karambit Doppler Phase 2', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_DOPPLERPHASE2.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_dopplerphase3       = { name = 'weapon_karambit_dopplerphase3', label = 'Karambit Doppler Phase 3', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_DOPPLERPHASE3.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_dopplerphase4       = { name = 'weapon_karambit_dopplerphase4', label = 'Karambit Doppler Phase 4', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_DOPPLERPHASE4.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_dopplerruby         = { name = 'weapon_karambit_dopplerruby', label = 'Karambit Doppler Ruby', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_DOPPLERRUBY.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_dopplersapphire     = { name = 'weapon_karambit_dopplersapphire', label = 'Karambit Doppler Sapphire', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_DOPPLERSAPPHIRE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_fade                = { name = 'weapon_karambit_fade', label = 'Karambit Fade', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_FADE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_forest              = { name = 'weapon_karambit_forest', label = 'Karambit Forest', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_FOREST.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_freehand            = { name = 'weapon_karambit_freehand', label = 'Karambit Free Hand', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_FREEHAND.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_gdemerald           = { name = 'weapon_karambit_gdemerald', label = 'Karambit Gamma Doppler Emerald', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_GDEMERALD.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_gdp1                = { name = 'weapon_karambit_gdp1', label = 'Karambit Gamma Doppler Phase 1', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_GDP1.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_gdp2                = { name = 'weapon_karambit_gdp2', label = 'Karambit Gamma Doppler Phase 2', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_GDP2.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_gdp3                = { name = 'weapon_karambit_gdp3', label = 'Karambit Gamma Doppler Phase 3', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_GDP3.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_gdp4                = { name = 'weapon_karambit_gdp4', label = 'Karambit Gamma Doppler Phase 4', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_GDP4.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_lore                = { name = 'weapon_karambit_lore', label = 'Karambit Lore', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_LORE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_marblefade          = { name = 'weapon_karambit_marblefade', label = 'Karambit Marble Fade', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_MARBLEFADE.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_night               = { name = 'weapon_karambit_night', label = 'Karambit Night', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_NIGHT.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_rustcoat            = { name = 'weapon_karambit_rustcoat', label = 'Karambit Rust Coat', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_RUSTCOAT.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_safarimesh          = { name = 'weapon_karambit_safarimesh', label = 'Karambit Safari Mesh', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_SAFARIMESH.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_scorched            = { name = 'weapon_karambit_scorched', label = 'Karambit Scorched', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_SCORCHED.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_slaugther           = { name = 'weapon_karambit_slaugther', label = 'Karambit Slaugther', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_SLAUGTHER.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_stained             = { name = 'weapon_karambit_stained', label = 'Karambit Stained', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_STAINED.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_tigertooth          = { name = 'weapon_karambit_tigertooth', label = 'Karambit Tiger Tooth', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_TIGERTOOTH.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_ultraviolet         = { name = 'weapon_karambit_ultraviolet', label = 'Karambit Ultra Violet', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_ULTRAVIOLET.png', unique = true, useable = false, description = 'CS:GO Knife' },
    weapon_karambit_urbanmasked         = { name = 'weapon_karambit_urbanmasked', label = 'Karambit Urban Masked', weight = 500, type = 'weapon', ammotype = nil, image = 'WEAPON_KARAMBIT_URBANMASKED.png', unique = true, useable = false, description = 'CS:GO Knife' },

    -- Extra Attachments | if using v4 make sure to replace this section BELOW!!
    at_clip_100_pistol                  = { name = 'at_clip_100_pistol', label = '100 Round Mag', weight = 2000, type = 'item', image = 'at_clip_100_pistol.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A 100 Round Mag' },
    at_clip_drum_pistol                 = { name = 'at_clip_drum_pistol', label = '50 Round Drum', weight = 1250, type = 'item', image = 'at_clip_drum_pistol.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A 50 Round Drum' },
    at_clip_clear                       = { name = 'at_clip_clear', label = 'Clear Round Mag', weight = 1000, type = 'item', image = 'at_clip_clear.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Clear Weapon Mag' },

    ['vehicle_manual']                  = { ['name'] = 'vehicle_manual', ['label'] = 'Vehicle manual', ['weight'] = 50, ['type'] = 'item', ['image'] = 'vehicle_manual.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Manual from vehicle' },
    ['fuel_pump']                       = { ['name'] = 'fuel_pump', ['label'] = 'Fuel pumper', ['weight'] = 10000, ['type'] = 'item', ['image'] = 'fuel_pump.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'will pump out all the fuel from the car' },
    ['window_cleaner']                  = { ['name'] = 'window_cleaner', ['label'] = 'windows cleaner', ['weight'] = 50, ['type'] = 'item', ['image'] = 'window_cleaner.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'will clean car windows' },

    --Cocktails
    ["b52"]                             = { ["name"] = "b52", ["label"] = "B-52", ["weight"] = 100, ["type"] = "item", ["image"] = "b52.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "B-52 Cocktail", ['thirst'] = math.random(20, 30) },
    ["brussian"]                        = { ["name"] = "brussian", ["label"] = "Black Russian", ["weight"] = 100, ["type"] = "item", ["image"] = "brussian.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Black Russian Cocktail", ['thirst'] = math.random(20, 30) },
    ["bkamikaze"]                       = { ["name"] = "bkamikaze", ["label"] = "Blue Kamikaze", ["weight"] = 100, ["type"] = "item", ["image"] = "bkamikaze.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Blue Kamikaze Cocktail", ['thirst'] = math.random(20, 30) },
    ["cappucc"]                         = { ["name"] = "cappucc", ["label"] = "Cappuccinotini", ["weight"] = 100, ["type"] = "item", ["image"] = "cappucc.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Cappuccinotini Cocktail", ['thirst'] = math.random(20, 30) },
    ["ccookie"]                         = { ["name"] = "ccookie", ["label"] = "Cranberry Cookie", ["weight"] = 100, ["type"] = "item", ["image"] = "ccookie.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Cranberry Cookie Cocktail", ['thirst'] = math.random(20, 30) },
    ["iflag"]                           = { ["name"] = "iflag", ["label"] = "Irish Flag", ["weight"] = 100, ["type"] = "item", ["image"] = "iflag.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Irish Flag Cocktail", ['thirst'] = math.random(20, 30) },
    ["kamikaze"]                        = { ["name"] = "kamikaze", ["label"] = "Kamikaze", ["weight"] = 100, ["type"] = "item", ["image"] = "kamikaze.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Kamikase Cocktail", ['thirst'] = math.random(20, 30) },
    ["sbullet"]                         = { ["name"] = "sbullet", ["label"] = "Silver Bullet", ["weight"] = 100, ["type"] = "item", ["image"] = "sbullet.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Silver Bullet Cocktail", ['thirst'] = math.random(20, 30) },
    ["voodoo"]                          = { ["name"] = "voodoo", ["label"] = "Voodoo", ["weight"] = 100, ["type"] = "item", ["image"] = "voodoo.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Voodoo Cocktail", ['thirst'] = math.random(20, 30) },
    ["woowoo"]                          = { ["name"] = "woowoo", ["label"] = "Woo Woo", ["weight"] = 100, ["type"] = "item", ["image"] = "woowoo.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Woowoo Cocktail", ['thirst'] = math.random(20, 30) },

    --Drink Ingredients
    ["lime"]                            = { ["name"] = "lime", ["label"] = "Lime", ["weight"] = 100, ["type"] = "item", ["image"] = "lime.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "A Lime." },
    -- ["chocolate"] 				 	= {["name"] = "chocolate",  		     	["label"] = "Chocolate",	 			["weight"] = 100, 		["type"] = "item", 		["image"] = "chocolate.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   	["combinable"] = nil,   ["description"] = "Chocolate Bar", ['hunger'] = math.random(20, 30) },

    ["cranberry"]                       = { ["name"] = "cranberry", ["label"] = "Cranberry Juice", ["weight"] = 100, ["type"] = "item", ["image"] = "cranberry.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Cranberry Juice", ['thirst'] = math.random(20, 30) },
    ["schnapps"]                        = { ["name"] = "schnapps", ["label"] = "Peach Schnapps", ["weight"] = 100, ["type"] = "item", ["image"] = "schnapps.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bottle of Peach Schnapps", ['thirst'] = math.random(20, 30) },
    ["gin"]                             = { ["name"] = "gin", ["label"] = "Gin", ["weight"] = 100, ["type"] = "item", ["image"] = "gin.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bottle of Gin", ['thirst'] = math.random(20, 30) },
    ["scotch"]                          = { ["name"] = "scotch", ["label"] = "Scotch", ["weight"] = 100, ["type"] = "item", ["image"] = "scotch.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bottle of Scotch", ['thirst'] = math.random(20, 30) },
    ["rum"]                             = { ["name"] = "rum", ["label"] = "Rum", ["weight"] = 100, ["type"] = "item", ["image"] = "rum.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bottle of Rum", ['thirst'] = math.random(20, 30) },
    ["icream"]                          = { ["name"] = "icream", ["label"] = "Irish Cream", ["weight"] = 100, ["type"] = "item", ["image"] = "icream.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bottle of Irish Cream Liquer", ['thirst'] = math.random(20, 30) },
    ["amaretto"]                        = { ["name"] = "amaretto", ["label"] = "Amaretto", ["weight"] = 100, ["type"] = "item", ["image"] = "amaretto.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bottle of Amaretto", ['thirst'] = math.random(20, 30) },
    ["curaco"]                          = { ["name"] = "curaco", ["label"] = "Curaco", ["weight"] = 100, ["type"] = "item", ["image"] = "curaco.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bottle of Curaco", ['thirst'] = math.random(20, 30) },

    --BEERS
    ["ambeer"]                          = { ["name"] = "ambeer", ["label"] = "AM Beer", ["weight"] = 100, ["type"] = "item", ["image"] = "ambeer.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(40, 50) },
    ["dusche"]                          = { ["name"] = "dusche", ["label"] = "Dusche Gold", ["weight"] = 100, ["type"] = "item", ["image"] = "dusche.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(40, 50) },
    ["logger"]                          = { ["name"] = "logger", ["label"] = "Logger Beer", ["weight"] = 100, ["type"] = "item", ["image"] = "logger.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(40, 50) },
    ["pisswasser"]                      = { ["name"] = "pisswasser", ["label"] = "Pi wasser", ["weight"] = 100, ["type"] = "item", ["image"] = "pisswaser1.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(40, 50) },
    ["pisswasser2"]                     = { ["name"] = "pisswasser2", ["label"] = "Pi wasser Stout", ["weight"] = 100, ["type"] = "item", ["image"] = "pisswaser2.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(40, 50) },
    ["pisswasser3"]                     = { ["name"] = "pisswasser3", ["label"] = "Pi wasser Pale Ale", ["weight"] = 100, ["type"] = "item", ["image"] = "pisswaser3.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(40, 50) },

    --SODA
    ["ecola"]                           = { ["name"] = "ecola", ["label"] = "eCola", ["weight"] = 100, ["type"] = "item", ["image"] = "ecola.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },
    ["ecolalight"]                      = { ["name"] = "ecolalight", ["label"] = "eCola Light", ["weight"] = 100, ["type"] = "item", ["image"] = "ecolalight.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(20, 30) },

    ["crisps"]                          = { ["name"] = "crisps", ["label"] = "Crisps", ["weight"] = 100, ["type"] = "item", ["image"] = "chips.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['hunger'] = math.random(20, 30) },

    ['sprunk']                          = {
        name = 'sprunk',
        label = 'Sprunk',
        weight = 100,
        type = 'item',
        image = 'sprunk.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['sludgie']                         = {
        name = 'sludgie',
        label = 'Sludgie',
        weight = 100,
        type = 'item',
        image = 'sludgie.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['ecola_light']                     = {
        name = 'ecola_light',
        label = 'Ecola light',
        weight = 100,
        type = 'item',
        image = 'ecola_light.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['ecola']                           = {
        name = 'ecola',
        label = 'Ecola',
        weight = 100,
        type = 'item',
        image = 'ecola.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['coffee']                          = {
        name = 'coffee',
        label = 'Coffee',
        weight = 100,
        type = 'item',
        image = 'coffee.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['water']                           = {
        name = 'water',
        label = 'Water',
        weight = 100,
        type = 'item',
        image = 'water.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['fries']                           = {
        name = 'fries',
        label = 'Fries',
        weight = 100,
        type = 'item',
        image = 'fries.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['pizza_ham']                       = {
        name = 'pizza_ham',
        label = 'Pizza Ham',
        weight = 100,
        type = 'item',
        image = 'pizza_ham.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['chips']                           = {
        name = 'chips',
        label = 'Chips',
        weight = 100,
        type = 'item',
        image = 'chips.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['donut']                           = {
        name = 'donut',
        label = 'Donut',
        weight = 100,
        type = 'item',
        image = 'donut.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['cigarrete']                       = {
        name = 'cigarrete',
        label = 'Cigarrete',
        weight = 100,
        type = 'item',
        image = 'cigarrete.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['wire_cutter']                     = {
        name = 'wire_cutter',
        label = 'Wire cutter',
        weight = 100,
        type = 'item',
        image = 'wire_cutter.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    ['prison_tablet']                   = {
        name = 'prison_tablet',
        label = 'Prison Tablet',
        weight = 100,
        type = 'item',
        image = 'prison_tablet.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },

    ['powerbank']                       = { ['name'] = 'powerbank', ['label'] = 'Power Bank', ['weight'] = 500, ['type'] = 'item', ['image'] = 'powerbank.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'You can use it to charge phone' },

    ["clothing_bag"]                    = { ["name"] = "clothing_bag", ["label"] = "Clothing Bag", ["weight"] = 100, ["type"] = "item", ["image"] = "clothing_bag.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "" },

    --- ps-weedplanting
    weedplant_seedm                     = { name = 'weedplant_seedm', label = 'Male Weed Seed', weight = 0, type = 'item', image = 'weedplant_seed.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Male Weed Seed' },
    weedplant_seedf                     = { name = 'weedplant_seedf', label = 'Female Weed Seed', weight = 0, type = 'item', image = 'weedplant_seed.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Female Weed Seed' },
    weedplant_branch                    = { name = 'weedplant_branch', label = 'Weed Branch', weight = 10000, type = 'item', image = 'weedplant_branch.png', unique = true, useable = false, shouldClose = false, combinable = nil, description = 'Weed plant' },
    weedplant_weed                      = { name = 'weedplant_weed', label = 'Dried Weed', weight = 100, type = 'item', image = 'weedplant_weed.png', unique = false, useable = false, shouldClose = false, combinable = nil, description = 'Weed ready for packaging' },
    weedplant_packedweed                = { name = 'weedplant_packedweed', label = 'Packed Weed', weight = 100, type = 'item', image = 'weedplant_weed.png', unique = true, useable = false, shouldClose = false, combinable = nil, description = 'Weed ready for sale' },
    weedplant_package                   = { name = 'weedplant_package', label = 'Suspicious Package', weight = 10000, type = 'item', image = 'weedplant_package.png', unique = true, useable = false, shouldClose = false, combinable = nil, description = 'Suspicious Package' },

    recvoucher                          = { name = "recvoucher", label = "Recycling Voucher", weight = 1, type = "item", image = "recvoucher.png", unique = false, useable = false, shouldClose = true, combinable = nil, description = "" },

    --brutal_gangs
    spraycan                            = { name = 'spraycan', label = 'Spray Can', weight = 1, type = 'item', image = 'spraycan.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = '' },
    sprayremover                        = { name = 'sprayremover', label = 'Spray Remover', weight = 1, type = 'item', image = 'sprayremover.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = '' },

    --brutal_executions
    pliers                              = { name = 'pliers', label = 'Pliers', weight = 1, type = 'item', image = 'pliers.png', unique = false, useable = false, shouldClose = true, combinable = nil, description = '' },



    --<!>-- MINING --<!>--
    -- Permits
    ['mining_permit']         = { ['name'] = 'mining_permit', ['label'] = 'Mining Permit', ['weight'] = 100, ['type'] = 'item', ['image'] = 'mining_permit.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A mining permit. This grants access to mining!' },
    ['caving_permit']         = { ['name'] = 'caving_permit', ['label'] = 'Caving Permit', ['weight'] = 100, ['type'] = 'item', ['image'] = 'caving_permit.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A caving permit. This grants access to cave mining!' },

    -- Tools
    ['miningguide']           = { ['name'] = 'miningguide', ['label'] = 'Mining Handbook', ['weight'] = 100, ['type'] = 'item', ['image'] = 'miningguide.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'Learn all about mining with this handbook!' },
    ['shovel']                = { ['name'] = 'shovel', ['label'] = 'Shovel', ['weight'] = 1500, ['type'] = 'item', ['image'] = 'shovel.png', ['unique'] = true, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shovel used for digging things!' },
    ['emptysack']             = { ['name'] = 'emptysack', ['label'] = 'Sack', ['weight'] = 100, ['type'] = 'item', ['image'] = 'emptysack.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A empty sack for storing things!' },
    ['gold_pan']              = { ['name'] = 'gold_pan', ['label'] = 'Gold Pan', ['weight'] = 1500, ['type'] = 'item', ['image'] = 'gold_pan.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A pan for washing dirt or gravel. Will you find gold?' },
    ['jackhammer']            = { ['name'] = 'jackhammer', ['label'] = 'Jackhammer', ['weight'] = 1500, ['type'] = 'item', ['image'] = 'jackhammer.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A high quality jack hammer for breaking rocks.' },
    ['dynamite']              = { ['name'] = 'dynamite', ['label'] = 'Dynamite', ['weight'] = 500, ['type'] = 'item', ['image'] = 'dynamite.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A stick of dynamite.' },

    -- Paydirt
    ['paydirt']               = { ['name'] = 'paydirt', ['label'] = 'Paydirt', ['weight'] = 2500, ['type'] = 'item', ['image'] = 'paydirt.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A sack of paydirt!' },

    -- Ores
    ['aluminum_ore']          = { ['name'] = 'aluminum_ore', ['label'] = 'Aluminum Ore', ['weight'] = 10, ['type'] = 'item', ['image'] = 'aluminum_ore.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A piece of Aluminum Ore!' },
    ['copper_ore']            = { ['name'] = 'copper_ore', ['label'] = 'Copper Ore', ['weight'] = 10, ['type'] = 'item', ['image'] = 'copper_ore.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A piece of Copper Ore!' },
    ['tin_ore']               = { ['name'] = 'tin_ore', ['label'] = 'Tin Ore', ['weight'] = 10, ['type'] = 'item', ['image'] = 'tin_ore.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A piece of Tin Ore!' },
    ['iron_ore']              = { ['name'] = 'iron_ore', ['label'] = 'Iron Ore', ['weight'] = 10, ['type'] = 'item', ['image'] = 'iron_ore.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A piece of Iron Ore!' },
    ['coal']                  = { ['name'] = 'coal', ['label'] = 'Coal', ['weight'] = 10, ['type'] = 'item', ['image'] = 'coal.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A piece of Coal!' },
    ['gold_ore']              = { ['name'] = 'gold_ore', ['label'] = 'Gold Ore', ['weight'] = 10, ['type'] = 'item', ['image'] = 'gold_ore.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A piece of Gold Ore!' },
    ['silver_ore']            = { ['name'] = 'silver_ore', ['label'] = 'Silver Ore', ['weight'] = 10, ['type'] = 'item', ['image'] = 'silver_ore.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A piece of Silver Ore!' },
    ['cobalt_ore']            = { ['name'] = 'cobalt_ore', ['label'] = 'Colbalt Ore', ['weight'] = 10, ['type'] = 'item', ['image'] = 'cobalt_ore.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A piece of Cobalt Ore!' },

    -- Ingots
    ['aluminum_ingot']        = { ['name'] = 'aluminum_ingot', ['label'] = 'Aluminum Ingot', ['weight'] = 200, ['type'] = 'item', ['image'] = 'aluminum_ingot.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Aluminum Ingot!' },
    ['copper_ingot']          = { ['name'] = 'copper_ingot', ['label'] = 'Copper Ingot', ['weight'] = 200, ['type'] = 'item', ['image'] = 'copper_ingot.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Copper Ingot!' },
    ['tin_ingot']             = { ['name'] = 'tin_ingot', ['label'] = 'Copper Tin', ['weight'] = 200, ['type'] = 'item', ['image'] = 'tin_ingot.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Tin Ingot!' },
    ['iron_ingot']            = { ['name'] = 'iron_ingot', ['label'] = 'Iron Ingot', ['weight'] = 200, ['type'] = 'item', ['image'] = 'iron_ingot.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Iron Ingot!' },
    ['gold_ingot']            = { ['name'] = 'gold_ingot', ['label'] = 'Gold Ingot', ['weight'] = 200, ['type'] = 'item', ['image'] = 'gold_ingot.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Gold Ingot!' },
    ['silver_ingot']          = { ['name'] = 'silver_ingot', ['label'] = 'Silver Ingot', ['weight'] = 200, ['type'] = 'item', ['image'] = 'silver_ingot.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Silver Ingot!' },
    ['bronze_ingot']          = { ['name'] = 'bronze_ingot', ['label'] = 'Bronze Ingot', ['weight'] = 200, ['type'] = 'item', ['image'] = 'gold_ingot.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Bronze Ingot!' },
    ['steel_ingot']           = { ['name'] = 'steel_ingot', ['label'] = 'Steel Ingot', ['weight'] = 200, ['type'] = 'item', ['image'] = 'steel_ingot.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Steel Ingot!' },
    ['cobalt_ingot']          = { ['name'] = 'cobalt_ingot', ['label'] = 'Cobalt Ingot', ['weight'] = 200, ['type'] = 'item', ['image'] = 'cobalt_ingot.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Cobalt Ingot!' },

    -- Gems
    ['amethyst']              = { ['name'] = 'amethyst', ['label'] = 'Amethyst', ['weight'] = 1, ['type'] = 'item', ['image'] = 'amethyst.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Amethyst gemstone!' },
    ['citrine']               = { ['name'] = 'citrine', ['label'] = 'Citrine', ['weight'] = 1, ['type'] = 'item', ['image'] = 'citrine.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Citrine gemstone!' },
    ['hematite']              = { ['name'] = 'hematite', ['label'] = 'Hematite', ['weight'] = 1, ['type'] = 'item', ['image'] = 'hematite.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Hematite gemstone!' },
    ['kyanite']               = { ['name'] = 'kyanite', ['label'] = 'Kyanite', ['weight'] = 1, ['type'] = 'item', ['image'] = 'kyanite.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Kyanite gemstone!' },
    ['onyx']                  = { ['name'] = 'onyx', ['label'] = 'onyx', ['weight'] = 1, ['type'] = 'item', ['image'] = 'onyx.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Onyx gemstone!' },
    ['diamond']               = { ['name'] = 'diamond', ['label'] = 'Diamond', ['weight'] = 1, ['type'] = 'item', ['image'] = 'diamond.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Diamond gemstone!' },
    ['emerald']               = { ['name'] = 'emerald', ['label'] = 'Emerald', ['weight'] = 1, ['type'] = 'item', ['image'] = 'emerald.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Emerald gemstone!' },
    ['ruby']                  = { ['name'] = 'ruby', ['label'] = 'Ruby', ['weight'] = 1, ['type'] = 'item', ['image'] = 'ruby.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Ruby gemstone!' },
    ['sapphire']              = { ['name'] = 'sapphire', ['label'] = 'Sapphire', ['weight'] = 1, ['type'] = 'item', ['image'] = 'sapphire.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Sapphire gemstone!' },
    ['tanzanite']             = { ['name'] = 'tanzanite', ['label'] = 'Tanzanite', ['weight'] = 1, ['type'] = 'item', ['image'] = 'onyx.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny Tanzanite gemstone!' },

    -- Building Bricks
    ['gold_building_brick']         = { ['name'] = 'gold_building_brick', ['label'] = 'Gold Building Brick', ['weight'] = 50, ['type'] = 'item', ['image'] = 'gold_building_brick.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A gold brick for building.' },
    ['diamond_building_brick']      = { ['name'] = 'diamond_building_brick', ['label'] = 'Diamond Building Brick', ['weight'] = 50, ['type'] = 'item', ['image'] = 'diamond_building_brick.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A diamond-infused building brick.' },
    ['emerald_building_brick']      = { ['name'] = 'emerald_building_brick', ['label'] = 'Emerald Building Brick', ['weight'] = 50, ['type'] = 'item', ['image'] = 'emerald_building_brick.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An emerald-infused building brick.' },
    ['ruby_building_brick']         = { ['name'] = 'ruby_building_brick', ['label'] = 'Ruby Building Brick', ['weight'] = 50, ['type'] = 'item', ['image'] = 'ruby_building_brick.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A ruby-infused building brick.' },
    ['sapphire_building_brick']     = { ['name'] = 'sapphire_building_brick', ['label'] = 'Sapphire Building Brick', ['weight'] = 50, ['type'] = 'item', ['image'] = 'sapphire_building_brick.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A sapphire-infused building brick.' },
    ['tanzanite_building_brick']    = { ['name'] = 'tanzanite_building_brick', ['label'] = 'Tanzanite Building Brick', ['weight'] = 50, ['type'] = 'item', ['image'] = 'tanzanite_building_brick.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A tanzanite-infused building brick.' },
    ['the_prism_brick']             = { ['name'] = 'the_prism_brick', ['label'] = 'The Prism Brick', ['weight'] = 50, ['type'] = 'item', ['image'] = 'the_prism_brick.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A special brick made with all gems.' },

    -- Uncut Gems
    ['uncut_diamond']         = { ['name'] = 'uncut_diamond', ['label'] = 'Uncut Diamond', ['weight'] = 1, ['type'] = 'item', ['image'] = 'uncut_diamond.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An uncut diamond ready to be processed.' },
    ['uncut_emerald']         = { ['name'] = 'uncut_emerald', ['label'] = 'Uncut Emerald', ['weight'] = 1, ['type'] = 'item', ['image'] = 'uncut_emerald.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An uncut emerald ready to be processed.' },
    ['uncut_ruby']            = { ['name'] = 'uncut_ruby', ['label'] = 'Uncut Ruby', ['weight'] = 1, ['type'] = 'item', ['image'] = 'uncut_ruby.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An uncut ruby ready to be processed.' },
    ['uncut_sapphire']        = { ['name'] = 'uncut_sapphire', ['label'] = 'Uncut Sapphire', ['weight'] = 1, ['type'] = 'item', ['image'] = 'uncut_sapphire.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An uncut sapphire ready to be processed.' },
    ['uncut_tanzanite']       = { ['name'] = 'uncut_tanzanite', ['label'] = 'Uncut Tanzanite', ['weight'] = 1, ['type'] = 'item', ['image'] = 'uncut_tanzanite.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An uncut tanzanite ready to be processed.' },

    -- Coins
    ['gold_coin_mining']           = { ['name'] = 'gold_coin_mining', ['label'] = 'Gold Coin', ['weight'] = 10, ['type'] = 'item', ['image'] = 'gold_coin_mining.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A minted gold coin.' },
    ['diamond_coin']               = { ['name'] = 'diamond_coin', ['label'] = 'Diamond Coin', ['weight'] = 10, ['type'] = 'item', ['image'] = 'diamond_coin.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A coin adorned with diamond.' },
    ['emerald_coin']               = { ['name'] = 'emerald_coin', ['label'] = 'Emerald Coin', ['weight'] = 10, ['type'] = 'item', ['image'] = 'emerald_coin.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A coin adorned with emerald.' },
    ['ruby_coin']                  = { ['name'] = 'ruby_coin', ['label'] = 'Ruby Coin', ['weight'] = 10, ['type'] = 'item', ['image'] = 'ruby_coin.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A coin adorned with ruby.' },
    ['sapphire_coin']              = { ['name'] = 'sapphire_coin', ['label'] = 'Sapphire Coin', ['weight'] = 10, ['type'] = 'item', ['image'] = 'sapphire_coin.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A coin adorned with sapphire.' },
    ['tanzanite_coin']             = { ['name'] = 'tanzanite_coin', ['label'] = 'Tanzanite Coin', ['weight'] = 10, ['type'] = 'item', ['image'] = 'tanzanite_coin.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A coin adorned with tanzanite.' },
    ['multi_coin']                 = { ['name'] = 'multi_coin', ['label'] = 'Multi Gem Coin', ['weight'] = 10, ['type'] = 'item', ['image'] = 'multi_coin.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A coin adorned with multiple gems.' },

    -- Apples
    ['gold_apple']                 = { ['name'] = 'gold_apple', ['label'] = 'Gold Apple', ['weight'] = 50, ['type'] = 'item', ['image'] = 'gold_apple.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A shiny golden apple.' },
    ['diamond_apple']              = { ['name'] = 'diamond_apple', ['label'] = 'Diamond Apple', ['weight'] = 50, ['type'] = 'item', ['image'] = 'diamond_apple.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An apple adorned with diamond.' },
    ['emerald_apple']              = { ['name'] = 'emerald_apple', ['label'] = 'Emerald Apple', ['weight'] = 50, ['type'] = 'item', ['image'] = 'emerald_apple.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An apple adorned with emerald.' },
    ['ruby_apple']                 = { ['name'] = 'ruby_apple', ['label'] = 'Ruby Apple', ['weight'] = 50, ['type'] = 'item', ['image'] = 'ruby_apple.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An apple adorned with ruby.' },
    ['sapphire_apple']             = { ['name'] = 'sapphire_apple', ['label'] = 'Sapphire Apple', ['weight'] = 50, ['type'] = 'item', ['image'] = 'sapphire_apple.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An apple adorned with sapphire.' },
    ['tanzanite_apple']            = { ['name'] = 'tanzanite_apple', ['label'] = 'Tanzanite Apple', ['weight'] = 50, ['type'] = 'item', ['image'] = 'tanzanite_apple.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'An apple adorned with tanzanite.' },
    ['jewel_of_eden']              = { ['name'] = 'jewel_of_eden', ['label'] = 'Jewel of Eden', ['weight'] = 50, ['type'] = 'item', ['image'] = 'jewel_of_eden.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A mythical gem apple.' },

    -- Skulls
    ['gold_skull']                 = { ['name'] = 'gold_skull', ['label'] = 'Gold Skull', ['weight'] = 400, ['type'] = 'item', ['image'] = 'gold_skull.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A gilded skull.' },
    ['diamond_skull']              = { ['name'] = 'diamond_skull', ['label'] = 'Diamond Skull', ['weight'] = 420, ['type'] = 'item', ['image'] = 'diamond_skull.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A skull adorned with diamond.' },
    ['emerald_skull']              = { ['name'] = 'emerald_skull', ['label'] = 'Emerald Skull', ['weight'] = 420, ['type'] = 'item', ['image'] = 'emerald_skull.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A skull adorned with emerald.' },
    ['ruby_skull']                 = { ['name'] = 'ruby_skull', ['label'] = 'Ruby Skull', ['weight'] = 420, ['type'] = 'item', ['image'] = 'ruby_skull.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A skull adorned with ruby.' },
    ['sapphire_skull']             = { ['name'] = 'sapphire_skull', ['label'] = 'Sapphire Skull', ['weight'] = 420, ['type'] = 'item', ['image'] = 'sapphire_skull.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A skull adorned with sapphire.' },
    ['tanzanite_skull']            = { ['name'] = 'tanzanite_skull', ['label'] = 'Tanzanite Skull', ['weight'] = 420, ['type'] = 'item', ['image'] = 'tanzanite_skull.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A skull adorned with tanzanite.' },
    ['the_oracle_of_gems']         = { ['name'] = 'the_oracle_of_gems', ['label'] = 'The Oracle of Gems', ['weight'] = 450, ['type'] = 'item', ['image'] = 'the_oracle_of_gems.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A legendary skull made of all gems.' },

    --CC Fleeca Heist
    ['money-bag']                  = { name = 'money-bag', label = 'money-bag', weight = 2, type = 'item', image = 'money-bag.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Used To take some Moolah' }, 
    ['laptop_green']               = { name = 'laptop_green', label = ' green laptop', weight = 2, type = 'item', image = 'laptop_green.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Used to hack into some system' },
    ['basicdrill']                 = { name = 'basicdrill', label = 'basicdrill', weight = 2, type = 'item', image = 'basicdrill.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Used to drill into things' },
    ['basicdecrypter']             = { name = 'basicdecrypter', label = 'basicdecrypter', weight = 2, type = 'item', image = 'basicdecrypter.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Used to decrypt things' },

    --Atm Robbery
    ['atm_drill']             = { ['name'] = 'atm_drill', ['label'] = 'Atm Drill', ['weight'] = 150, ['type'] = 'item', ['image'] = 'drill_grey.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A Drill for a valuable type of heist ' },

    -- HumaneLabs Heist Items
    ['humanelabs_card']       = { ['name'] = 'humanelabs_card', ['label'] = 'Humane Labs Access Card', ['weight'] = 25, ['type'] = 'item', ['image'] = 'humanelabs_card.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Security card for Fleeca Bank' },

    -- Union Heist Items
    ['union_card']            = { ['name'] = 'union_card', ['label'] = 'Union Bank Keycard', ['weight'] = 25, ['type'] = 'item', ['image'] = 'union_card.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A Security card for Fleeca Bank' },


    ['pokertable']               = { ['name'] = 'pokertable', ['label'] = 'Poker Table', ['weight'] = 1, ['type'] = 'item', ['image'] = 'pokertable.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = true, ['description'] = 'Unique poker table' },

    --Drugs
    ["coke_box"]                 = { ["name"] = "coke_box", ["label"] = "Box with Coke", ["weight"] = 2000, ["type"] = "item", ["image"] = "coke_box.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Be careful not to spill it on the ground" },
    ["trowel"]                   = { ["name"] = "trowel", ["label"] = "Trowel", ["weight"] = 250, ["type"] = "item", ["image"] = "trowel.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Perfect for your garden or for Coca plant" },
    ["coke_leaf"]                = { ["name"] = "coke_leaf", ["label"] = "Coca leaves", ["weight"] = 15, ["type"] = "item", ["image"] = "coca_leaf.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Leaf from amazing plant" },
    ["coke_access"]              = { ["name"] = "coke_access", ["label"] = "Access card", ["weight"] = 50, ["type"] = "item", ["image"] = "coke_access.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Access Card for Coke Lab" },
    ["coke_raw"]                 = { ["name"] = "coke_raw", ["label"] = "Raw Coke", ["weight"] = 50, ["type"] = "item", ["image"] = "coke_raw.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Coke with some dirty particles" },
    ["coke_pure"]                = { ["name"] = "coke_pure", ["label"] = "Pure Coke", ["weight"] = 70, ["type"] = "item", ["image"] = "coke_pure.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Coke without any dirty particles" },
    ["coke_figure"]              = { ["name"] = "coke_figure", ["label"] = "Action Figure", ["weight"] = 150, ["type"] = "item", ["image"] = "coke_figure.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Action Figure of the cartoon superhero Impotent Rage" },
    ["coke_figureempty"]         = { ["name"] = "coke_figureempty", ["label"] = "Action Figure", ["weight"] = 150, ["type"] = "item", ["image"] = "coke_figureempty.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Action Figure of the cartoon superhero Impotent Rage" },
    ["coke_figurebroken"]        = { ["name"] = "coke_figurebroken", ["label"] = "Pieces of Action Figure", ["weight"] = 100, ["type"] = "item", ["image"] = "coke_figurebroken.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "You can throw this away or try to repair with glue" },
    ["meth_amoniak"]             = { ["name"] = "meth_amoniak", ["label"] = "Ammonia", ["weight"] = 1000, ["type"] = "item", ["image"] = "meth_amoniak.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Warning! Dangerous Chemicals!" },
    ["meth_pipe"]                = { ["name"] = "meth_pipe", ["label"] = "Meth Pipe", ["weight"] = 880, ["type"] = "item", ["image"] = "meth_pipe.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Enjoy your new crystal clear stuff!" },
    ["crack_pipe"]               = { ["name"] = "crack_pipe", ["label"] = "Crack Pipe", ["weight"] = 550, ["type"] = "item", ["image"] = "crack_pipe.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Enjoy your Crack!" },
    ["syringe"]                  = { ["name"] = "syringe", ["label"] = "Syringe", ["weight"] = 300, ["type"] = "item", ["image"] = "syringe.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Enjoy your new crystal clear stuff!" },
    ["meth_syringe"]             = { ["name"] = "meth_syringe", ["label"] = "Syringe", ["weight"] = 320, ["type"] = "item", ["image"] = "meth_syringe.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Enjoy your new crystal clear stuff!" },
    ["heroin_syringe"]           = { ["name"] = "heroin_syringe", ["label"] = "Syringe", ["weight"] = 320, ["type"] = "item", ["image"] = "heroin_syringe.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Enjoy your new crystal clear stuff!" },
    ["meth_sacid"]               = { ["name"] = "meth_sacid", ["label"] = "Sodium Benzoate Canister", ["weight"] = 5000, ["type"] = "item", ["image"] = "meth_sacid.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Warning! Dangerous Chemicals!" },
    ["meth_emptysacid"]          = { ["name"] = "meth_emptysacid", ["label"] = "Empty Canister", ["weight"] = 2000, ["type"] = "item", ["image"] = "meth_emptysacid.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Material: Plastic, Good for Sodium Benzoate" },
    ["meth_access"]              = { ["name"] = "meth_access", ["label"] = "Access Card", ["weight"] = 50, ["type"] = "item", ["image"] = "meth_access.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Access Card for Meth Lab" },
    ["meth_glass"]               = { ["name"] = "meth_glass", ["label"] = "Tray with meth", ["weight"] = 1000, ["type"] = "item", ["image"] = "meth_glass.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Needs to be smashed with hammer" },
    ["meth_sharp"]               = { ["name"] = "meth_sharp", ["label"] = "Tray with smashed meth", ["weight"] = 1000, ["type"] = "item", ["image"] = "meth_sharp.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Can be packed" },
    ["meth_bag"]                 = { ["name"] = "meth_bag", ["label"] = "Meth Bag", ["weight"] = 1000, ["type"] = "item", ["image"] = "meth_bag.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Plastic bag with magic stuff!" },
    ["weed_package"]             = { ["name"] = "weed_package", ["label"] = "Weed Bag", ["weight"] = 500, ["type"] = "item", ["image"] = "weed_package.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Plastic bag with magic stuff!" },
    ["weed_access"]              = { ["name"] = "weed_access", ["label"] = "Access Card", ["weight"] = 50, ["type"] = "item", ["image"] = "weed_access.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Access Card for Weed Lab" },
    ["weed_bud"]                 = { ["name"] = "weed_bud", ["label"] = "Weed Bud", ["weight"] = 40, ["type"] = "item", ["image"] = "weed_bud.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Needs to be clean at the table" },
    ["weed_blunt"]               = { ["name"] = "weed_blunt", ["label"] = "Blunt", ["weight"] = 90, ["type"] = "item", ["image"] = "weed_blunt.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Enjoy your weed!" },
    ["weed_wrap"]                = { ["name"] = "weed_wrap", ["label"] = "Blunt Wraps", ["weight"] = 75, ["type"] = "item", ["image"] = "weed_wrap.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Get Weed Bag and roll blunt!" },
    ["weed_papers"]              = { ["name"] = "weed_papers", ["label"] = "Weed Papers", ["weight"] = 15, ["type"] = "item", ["image"] = "weed_papers.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Get Weed Bag and roll joint!" },
    ["weed_joint"]               = { ["name"] = "weed_joint", ["label"] = "Joint", ["weight"] = 50, ["type"] = "item", ["image"] = "weed_joint.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Enjoy your weed!" },
    ["weed_budclean"]            = { ["name"] = "weed_budclean", ["label"] = "Weed Bud", ["weight"] = 35, ["type"] = "item", ["image"] = "weed_budclean.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "You can pack this at the table" },
    ["plastic_bag"]              = { ["name"] = "plastic_bag", ["label"] = "Plastic Bag", ["weight"] = 8, ["type"] = "item", ["image"] = "plastic_bag.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "You can pack a lot of stuff here!" },
    ["scissors"]                 = { ["name"] = "scissors", ["label"] = "Scissors", ["weight"] = 40, ["type"] = "item", ["image"] = "scissors.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "To help you with collecting" },
    ["ecstasy1"]                 = { ["name"] = "ecstasy1", ["label"] = "Ectasy", ["weight"] = 10, ["type"] = "item", ["image"] = "ecstasy1.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["ecstasy2"]                 = { ["name"] = "ecstasy2", ["label"] = "Ectasy", ["weight"] = 10, ["type"] = "item", ["image"] = "ecstasy2.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["ecstasy3"]                 = { ["name"] = "ecstasy3", ["label"] = "Ectasy", ["weight"] = 10, ["type"] = "item", ["image"] = "ecstasy3.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["ecstasy4"]                 = { ["name"] = "ecstasy4", ["label"] = "Ectasy", ["weight"] = 10, ["type"] = "item", ["image"] = "ecstasy4.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["ecstasy5"]                 = { ["name"] = "ecstasy5", ["label"] = "Ectasy", ["weight"] = 10, ["type"] = "item", ["image"] = "ecstasy5.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["lsd1"]                     = { ["name"] = "lsd1", ["label"] = "LSD", ["weight"] = 10, ["type"] = "item", ["image"] = "lsd1.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["lsd2"]                     = { ["name"] = "lsd2", ["label"] = "LSD", ["weight"] = 10, ["type"] = "item", ["image"] = "lsd2.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["lsd3"]                     = { ["name"] = "lsd3", ["label"] = "LSD", ["weight"] = 10, ["type"] = "item", ["image"] = "lsd3.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["lsd4"]                     = { ["name"] = "lsd4", ["label"] = "LSD", ["weight"] = 10, ["type"] = "item", ["image"] = "lsd4.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["lsd5"]                     = { ["name"] = "lsd5", ["label"] = "LSD", ["weight"] = 10, ["type"] = "item", ["image"] = "lsd5.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["magicmushroom"]            = { ["name"] = "magicmushroom", ["label"] = "Magic Mushroom", ["weight"] = 30, ["type"] = "item", ["image"] = "magicmushroom.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["peyote"]                   = { ["name"] = "peyote", ["label"] = "Peyote", ["weight"] = 30, ["type"] = "item", ["image"] = "peyote.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["xanaxpack"]                = { ["name"] = "xanaxpack", ["label"] = "Xanax Pack", ["weight"] = 130, ["type"] = "item", ["image"] = "xanaxpack.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["xanaxplate"]               = { ["name"] = "xanaxplate", ["label"] = "Xanax Plate", ["weight"] = 30, ["type"] = "item", ["image"] = "xanaxplate.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["xanaxpill"]                = { ["name"] = "xanaxpill", ["label"] = "Xanax Pill", ["weight"] = 10, ["type"] = "item", ["image"] = "xanaxpill.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["glue"]                     = { ["name"] = "glue", ["label"] = "Glue", ["weight"] = 30, ["type"] = "item", ["image"] = "glue.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Good for repairing things!" },
    ["hammer"]                   = { ["name"] = "hammer", ["label"] = "Hammer", ["weight"] = 500, ["type"] = "item", ["image"] = "hammer.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Good for smashing things!" },
    ["poppyplant"]               = { ["name"] = "poppyplant", ["label"] = "Poppy Plant", ["weight"] = 30, ["type"] = "item", ["image"] = "poppyplant.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Very nice plant!" },
    ["heroin"]                   = { ["name"] = "heroin", ["label"] = "Heroin", ["weight"] = 30, ["type"] = "item", ["image"] = "heroin.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["crack"]                    = { ["name"] = "crack", ["label"] = "Crack", ["weight"] = 30, ["type"] = "item", ["image"] = "crack.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Explore a new universe!" },
    ["baking_soda"]              = { ["name"] = "baking_soda", ["label"] = "Baking Soda", ["weight"] = 30, ["type"] = "item", ["image"] = "baking_soda.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false, ["combinable"] = nil, ["description"] = "Baking Bad!" },

    ["casino_beer"]              = {
        ["name"] = "casino_beer",
        ["label"] = "Casino Beer",
        ["weight"] = 0,
        ["type"] = "item",
        ['image'] = 'casino_beer.png',
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Beer"
    },
    ["casino_burger"]            = {
        ["name"] = "casino_burger",
        ["label"] = "Casino Burger",
        ["weight"] = 0,
        ["type"] = "item",
        ['image'] = 'casino_burger.png',
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Burger"
    },
    ["casino_chips"]             = {
        ["name"] = "casino_chips",
        ["label"] = "Casino Chips",
        ["weight"] = 0,
        ["type"] = "item",
        ['image'] = 'casino_chips.png',
        ["unique"] = false,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Chips"
    },
    ["casino_coffee"]            = {
        ["name"] = "casino_coffee",
        ["label"] = "Casino Coffee",
        ["weight"] = 0,
        ["type"] = "item",
        ['image'] = 'casino_coffee.png',
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Coffee"
    },
    ["casino_coke"]              = {
        ["name"] = "casino_coke",
        ["label"] = "Casino Kofola",
        ["weight"] = 0,
        ["type"] = "item",
        ['image'] = 'casino_coke.png',
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Kofola"
    },
    ["casino_donut"]             = {
        ["name"] = "casino_donut",
        ["label"] = "Casino Donut",
        ["weight"] = 0,
        ["type"] = "item",
        ["image"] = "casino_donut.png",
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Donut"
    },
    ["casino_ego_chaser"]        = {
        ["name"] = "casino_ego_chaser",
        ["label"] = "Casino Ego Chaser",
        ["weight"] = 0,
        ["type"] = "item",
        ["image"] = "casino_ego_chaser.png",
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Ego Chaser"
    },
    ["casino_luckypotion"]       = {
        ["name"] = "casino_luckypotion",
        ["label"] = "Casino Lucky Potion",
        ["weight"] = 0,
        ["type"] = "item",
        ["image"] = "casino_luckypotion.png",
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Lucky Potion"
    },
    ["casino_psqs"]              = {
        ["name"] = "casino_psqs",
        ["label"] = "Casino Ps & Qs",
        ["weight"] = 0,
        ["type"] = "item",
        ["image"] = "casino_psqs.png",
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Ps & Qs"
    },
    ["casino_sandwitch"]         = {
        ["name"] = "casino_sandwitch",
        ["label"] = "Casino Sandwitch",
        ["weight"] = 0,
        ["type"] = "item",
        ["image"] = "casino_sandwitch.png",
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Sandwitch"
    },
    ["casino_sprite"]            = {
        ["name"] = "casino_sprite",
        ["label"] = "Casino Sprite",
        ["weight"] = 0,
        ["type"] = "item",
        ["image"] = "casino_sprite.png",
        ["unique"] = true,
        ["useable"] = false,
        ["shouldClose"] = false,
        ["combinable"] = nil,
        ["description"] = "Casino Sprite"
    },

    ['laundrycard']              = {
        ['name'] = 'laundrycard',
        ['label'] = 'Laundry Card',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'laundrycard.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Your description here'
    },

    -- GG Hunting Weapons

    ['weapon_huntingrifle']      = {
        ['name'] = 'weapon_huntingrifle',
        ['label'] = 'Hunting Rifle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_huntingrifle.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] =
        'A high-velocity rifle designed for precise, long-range shots at game. Ideal for hunters seeking to take down large prey from a distance.'
    },
    ['weapon_crossbow']          = {
        ['name'] = 'weapon_crossbow',
        ['label'] = 'Hunting Crossbow',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_crossbow.png',
        ['unique'] = true,
        ['useable'] = true,
        ['rare'] = 'common', -- epic, legendary, common
        ['description'] =
        'A precision weapon favored by skilled hunters. Fires arrows with remarkable accuracy, ideal for hunters who value skill and control over brute force.'
    },

    -- GG hunting Ammo
    ['gg_hunting_arrowammo']     = {
        ['name'] = 'gg_hunting_arrowammo',
        ['label'] = 'Arrow Ammo',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_arrowammo.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] =
        'Specially crafted arrows designed for use with the hunting crossbow. Built for precision and power, ideal for taking down animals quietly.'
    },

    ['gg_hunting_rifleammo']     = {
        ['name'] = 'gg_hunting_rifleammo',
        ['label'] = 'Hunting Rifle Ammo',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_rifleammo.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] =
        'High-powered ammunition for the hunting rifle. Designed for long-range accuracy and the ability to pierce through tough animal hides.'
    },

    -- GG Hunting Items
    ['gg_hunting_animaltracker'] = {
        ['name'] = 'gg_hunting_animaltracker',
        ['label'] = 'Advanced Animal Tracker',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_animaltracker.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] =
        'A sophisticated device used to track animal movements across the terrain, aiding hunters in locating their prey.'
    },

    ['gg_hunting_animaltrap']    = {
        ['name'] = 'gg_hunting_animaltrap',
        ['label'] = 'Heavy-Duty Animal Trap',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_animaltrap.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'epic',
        ['description'] = 'A durable trap designed to capture animals alive for easier transportation or use as bait.'
    },

    ['gg_hunting_campfire']      = {
        ['name'] = 'gg_hunting_campfire',
        ['label'] = 'Portable Campfire',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_campfire.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] =
        'A compact campfire setup for warming up, cooking, and providing light during long hunting expeditions.'
    },

    ['gg_hunting_meat']          = {
        ['name'] = 'gg_hunting_meat',
        ['label'] = 'Fresh Animal Meat',
        ['weight'] = 5,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_meat.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'Freshly harvested meat from a hunt, ideal for cooking or trade.'
    },

    ['gg_hunting_cookedmeat']    = {
        ['name'] = 'gg_hunting_cookedmeat',
        ['label'] = 'Cooked Game Meat',
        ['weight'] = 5,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_cookedmeat.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'Deliciously cooked meat, perfect for a meal during your hunting adventure.'
    },

    ['gg_hunting_knife_01']      = {
        ['name'] = 'gg_hunting_knife_01',
        ['label'] = 'Basic Hunting Knife',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_knife_01.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'A reliable, entry-level hunting knife ideal for basic butchering tasks.'
    },

    ['gg_hunting_knife_02']      = {
        ['name'] = 'gg_hunting_knife_02',
        ['label'] = 'Intermediate Hunting Knife',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_knife_02.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'epic',
        ['description'] = 'A well-crafted hunting knife offering improved precision for more efficient butchering.'
    },

    ['gg_hunting_knife_03']      = {
        ['name'] = 'gg_hunting_knife_03',
        ['label'] = 'Premium Hunting Knife',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'gg_hunting_knife_03.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] =
        'A top-tier hunting knife, designed for expert hunters, providing unmatched sharpness and durability for butchering.'
    },

    ['gg_deer_hide_01']          = {
        ['name'] = 'gg_deer_hide_01',
        ['label'] = 'Rough Deer Hide',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_deer_hide_01.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'A basic, coarse deer hide with minimal value.'
    },

    ['gg_deer_hide_02']          = {
        ['name'] = 'gg_deer_hide_02',
        ['label'] = 'Sturdy Deer Hide',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_deer_hide_02.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'epic',
        ['description'] = 'A good-quality deer hide, suitable for crafting or trade.'
    },

    ['gg_deer_hide_03']          = {
        ['name'] = 'gg_deer_hide_03',
        ['label'] = 'Pristine Deer Hide',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_deer_hide_03.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A high-quality, flawless deer hide highly valued by traders.'
    },

    ['gg_boar_tusk_01']          = {
        ['name'] = 'gg_boar_tusk_01',
        ['label'] = 'Rough Boar Tusk',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_boar_tusk_01.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'A basic, crude boar tusk with minimal value.'
    },

    ['gg_boar_tusk_02']          = {
        ['name'] = 'gg_boar_tusk_02',
        ['label'] = 'Sturdy Boar Tusk',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_boar_tusk_02.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'epic',
        ['description'] = 'A sturdy boar tusk with a moderate value, suitable for crafting or trade.'
    },

    ['gg_boar_tusk_03']          = {
        ['name'] = 'gg_boar_tusk_03',
        ['label'] = 'Pristine Boar Tusk',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_boar_tusk_03.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A high-quality boar tusk, highly valued by craftsmen and traders.'
    },

    ['gg_rabbit_pelt_01']        = {
        ['name'] = 'gg_rabbit_pelt_01',
        ['label'] = 'Rough Rabbit Pelt',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_rabbit_pelt_01.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'A basic rabbit pelt with minimal value.'
    },
    ['gg_rabbit_pelt_02']        = {
        ['name'] = 'gg_rabbit_pelt_02',
        ['label'] = 'Sturdy Rabbit Pelt',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_rabbit_pelt_02.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'epic',
        ['description'] = 'A decent-quality rabbit pelt, suitable for crafting or trade.'
    },
    ['gg_rabbit_pelt_03']        = {
        ['name'] = 'gg_rabbit_pelt_03',
        ['label'] = 'Pristine Rabbit Pelt',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_rabbit_pelt_03.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A high-quality rabbit pelt, highly valued by traders and craftsmen.'
    },
    ['gg_cougar_claw_01']        = {
        ['name'] = 'gg_cougar_claw_01',
        ['label'] = 'Rough Cougar Claw',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_cougar_claw_01.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'A basic cougar claw with minimal value.'
    },
    ['gg_cougar_claw_02']        = {
        ['name'] = 'gg_cougar_claw_02',
        ['label'] = 'Sturdy Cougar Claw',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_cougar_claw_02.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'epic',
        ['description'] = 'A sturdy cougar claw, suitable for crafting or trade.'
    },
    ['gg_cougar_claw_03']        = {
        ['name'] = 'gg_cougar_claw_03',
        ['label'] = 'Pristine Cougar Claw',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_cougar_claw_03.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A high-quality cougar claw, highly valued by traders and craftsmen.'
    },
    ['gg_coyote_fangs_01']       = {
        ['name'] = 'gg_coyote_fangs_01',
        ['label'] = 'Rough Coyote Fang',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_coyote_fangs_01.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'A basic coyote fang with minimal value.'
    },
    ['gg_coyote_fangs_02']       = {
        ['name'] = 'gg_coyote_fangs_02',
        ['label'] = 'Sturdy Coyote Fang',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_coyote_fangs_02.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'epic',
        ['description'] = 'A sturdy coyote fang, suitable for crafting or trade.'
    },
    ['gg_coyote_fangs_03']       = {
        ['name'] = 'gg_coyote_fangs_03',
        ['label'] = 'Pristine Coyote Fang',
        ['weight'] = 20,
        ['type'] = 'item',
        ['image'] = 'gg_coyote_fangs_03.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A high-quality coyote fang, highly valued by traders and craftsmen.'
    },

    ['gg_salt_block_01']         = {
        ['name'] = 'gg_salt_block_01',
        ['label'] = 'Basic Salt Block',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'gg_salt_block_01.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'A simple salt block used to attract animals.'
    },
    ['gg_salt_block_02']         = {
        ['name'] = 'gg_salt_block_02',
        ['label'] = 'Enhanced Salt Block',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'gg_salt_block_02.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'epic',
        ['description'] = 'A refined salt block that draws in more animals.'
    },
    ['gg_salt_block_03']         = {
        ['name'] = 'gg_salt_block_03',
        ['label'] = 'Premium Salt Block',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'gg_salt_block_03.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A high-quality salt block, highly effective at attracting animals.'
    },
    ['gg_pug_bait_01']           = {
        ['name'] = 'gg_pug_bait_01',
        ['label'] = 'Basic Pug Bait',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'gg_pug_bait_01.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = 'A simple and crude bait for attracting pugs.'
    },
    ['gg_pug_bait_02']           = {
        ['name'] = 'gg_pug_bait_02',
        ['label'] = 'Advanced Pug Bait',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'gg_pug_bait_02.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'epic',
        ['description'] = 'A more effective bait to lure in pugs, with a stronger scent.'
    },
    ['gg_pug_bait_03']           = {
        ['name'] = 'gg_pug_bait_03',
        ['label'] = 'Specialized Pug Bait',
        ['weight'] = 10,
        ['type'] = 'item',
        ['image'] = 'gg_pug_bait_03.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A premium bait crafted to attract the rarest of pugs.'
    },
    ['gg_captured_rabbit']       = {
        ['name'] = 'gg_captured_rabbit',
        ['label'] = 'Captured Rabbit',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'gg_captured_rabbit.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A captured rabbit, perfect for luring carnivores as high-quality bait.'
    },
    ['gg_captured_hen']          = {
        ['name'] = 'gg_captured_hen',
        ['label'] = 'Captured Hen',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'gg_captured_hen.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A captured hen, a tempting bait for larger predators seeking prey.'
    },
    ['gg_captured_chickenhawk']  = {
        ['name'] = 'gg_captured_chickenhawk',
        ['label'] = 'Captured Chickenhawk',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'gg_captured_chickenhawk.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'legendary',
        ['description'] = 'A captured chickenhawk, a rare and enticing bait that attracts powerful predators.'
    },

    ['wheelchair']               = {
        ['name'] = 'wheelchair',
        ['label'] = 'Wheelchair',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'wheelchair.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = ''
    },
    ['crutch']                   = {
        ['name'] = 'crutch',
        ['label'] = 'Crutch',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'crutch.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['object'] = nil,
        ['rare'] = 'common',
        ['description'] = ''
    },
    --Hair Spray
    ["hairspray"]                = {
        ["name"] = "hairspray",
        ["label"] = "Hairspray",
        ["weight"] = 10,
        ["type"] = "item",
        ["image"] = "hairspray.png",
        ["unique"] = false,
        ["useable"] = true,
        ["shouldClose"] = true,
        ["combinable"] = true,
        ["description"] = "A can of hairspray to restyle your hair"
    },

    bobby_pin                    = { name = 'bobby_pin', label = 'Bobby Pin', weight = 2500, type = 'item', image = 'bobby_pin.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Can be used as a makeshift tool for picking locks' },
    tracking_bracelet            = { name = 'tracking_bracelet', label = 'Tracking Bracelet', weight = 2500, type = 'item', image = 'tracking_bracelet.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'Can be used for tracking a suspect' },

    newspaper                    = { name = 'newspaper', label = 'Newspaper', weight = 150, type = 'item', image = 'newspaper.png', unique = false, useable = true, shouldClose = true, description = '' },
    empty_newspaper              = { name = 'empty_newspaper', label = 'Empty Newspapers', weight = 150, type = 'item', image = 'empty_newspaper.png', unique = false, useable = true, shouldClose = true, description = '' },
    newspaperbox                 = { name = 'newspaperbox', label = 'Printed Newspapers', weight = 150, type = 'item', image = 'newspaperbox.png', unique = false, useable = true, shouldClose = true, description = '' },

    -- Hennies
    jagermeister                 = { ["name"] = "jagermeister", ["label"] = "J germeister", ["weight"] = 100, ["type"] = "item", ["image"] = "jagermeister.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(5, 10) },
    black_label                  = { ["name"] = "black_label", ["label"] = "Black Label", ["weight"] = 100, ["type"] = "item", ["image"] = "black_label.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(5, 10) },
    castle                       = { ["name"] = "castle", ["label"] = "Castle Lager", ["weight"] = 100, ["type"] = "item", ["image"] = "castle.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(5, 10) },
    corona                       = { ["name"] = "corona", ["label"] = "Corona", ["weight"] = 100, ["type"] = "item", ["image"] = "corona.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(5, 10) },
    heineken                     = { ["name"] = "heineken", ["label"] = "Heineken", ["weight"] = 100, ["type"] = "item", ["image"] = "heineken.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(5, 10) },
    jackdaniels                  = { ["name"] = "jackdaniels", ["label"] = "Jack Daniels", ["weight"] = 100, ["type"] = "item", ["image"] = "jackdaniels.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(5, 10) },
    jamjar                       = { ["name"] = "jamjar", ["label"] = "Jam Jar", ["weight"] = 100, ["type"] = "item", ["image"] = "jamjar.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(5, 10) },
    kwv                          = { ["name"] = "kwv", ["label"] = "KWV", ["weight"] = 100, ["type"] = "item", ["image"] = "kwv.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['thirst'] = math.random(5, 10) },
    pie                          = { ["name"] = "pie", ["label"] = "Pie", ["weight"] = 100, ["type"] = "item", ["image"] = "pie.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "", ['hunger'] = math.random(50, 60) },

    ["nplate"]                   = { ["name"] = "nplate", ["label"] = "Nachos Plate", ["weight"] = 100, ["type"] = "item", ["image"] = "nplate.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A plate of nachos and cheese", ['hunger'] = math.random(40, 50) },
    ["vusliders"]                = { ["name"] = "vusliders", ["label"] = "Sliders", ["weight"] = 100, ["type"] = "item", ["image"] = "sliders.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Sliders", ['hunger'] = math.random(40, 50) },
    ["vutacos"]                  = { ["name"] = "vutacos", ["label"] = "Tacos", ["weight"] = 100, ["type"] = "item", ["image"] = "tacos.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Tacos", ['hunger'] = math.random(40, 50) },
    ["meat"]                     = { ["name"] = "meat", ["label"] = "Meat", ["weight"] = 100, ["type"] = "item", ["image"] = "meat.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A slab of Meat", ['hunger'] = math.random(40, 50) },
    ["nachos"]                   = { ["name"] = "nachos", ["label"] = "Nachos", ["weight"] = 100, ["type"] = "item", ["image"] = "nachos.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A bag of Nachos", ['hunger'] = math.random(40, 50) },

    medbag                       = { name = 'medbag', label = 'Medical Bag', weight = 2500, type = 'item', image = 'medbag.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A bag of medic tools' },
    tweezers                     = { name = 'tweezers', label = 'Tweezers', weight = 50, type = 'item', image = 'tweezers.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'For picking out bullets' },
    suturekit                    = { name = 'suturekit', label = 'Suture Kit', weight = 60, type = 'item', image = 'suturekit.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'For stitching your patients' },
    icepack                      = { name = 'icepack', label = 'Ice Pack', weight = 110, type = 'item', image = 'icepack.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'To help reduce swelling' },
    burncream                    = { name = 'burncream', label = 'Burn Cream', weight = 125, type = 'item', image = 'burncream.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'To help with burns' },
    defib                        = { name = 'defib', label = 'Defibrillator', weight = 1120, type = 'item', image = 'defib.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Used to revive patients' },
    sedative                     = { name = 'sedative', label = 'Sedative', weight = 20, type = 'item', image = 'sedative.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'If needed, this will sedate patient' },
    morphine30                   = { name = 'morphine30', label = 'Morphine 30MG', weight = 2, type = 'item', image = 'morphine30.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'A controlled substance to control pain' },
    morphine15                   = { name = 'morphine15', label = 'Morphine 15MG', weight = 2, type = 'item', image = 'morphine15.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'A controlled substance to control pain' },
    perc30                       = { name = 'perc30', label = 'Percocet 30MG', weight = 2, type = 'item', image = 'perc30.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'A controlled substance to control pain' },
    perc10                       = { name = 'perc10', label = 'Percocet 10MG', weight = 2, type = 'item', image = 'perc10.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'A controlled substance to control pain' },
    perc5                        = { name = 'perc5', label = 'Percocet 5MG', weight = 2, type = 'item', image = 'perc5.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'A controlled substance to control pain' },
    vic10                        = { name = 'vic10', label = 'Vicodin 10MG', weight = 2, type = 'item', image = 'vic10.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'A controlled substance to control pain' },
    vic5                         = { name = 'vic5', label = 'Vicodin 5MG', weight = 2, type = 'item', image = 'vic5.png', unique = false, useable = true, shouldClose = true, combinable = true, description = 'A controlled substance to control pain' },

    weapon_beanbag               = { name = 'weapon_beanbag', label = 'PD Bean Bag Shotgun', weight = 1000, type = 'weapon', ammotype = 'AMMO_BEANBAG', image = 'weapon_beanbag.png', unique = true, useable = true, description = 'Bean Bag' },
    beanbag_ammo                 = { name = 'beanbag_ammo', label = 'Bean Bag', weight = 500, type = 'item', image = 'beanbag_ammo.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Ammo for BeanBag Shotguns' },

    --Gas Mask
    ['gasmask']                  = {
        ['name'] = 'gasmask',
        ['label'] = 'Gas Mask',
        ['weight'] = 450,
        ['type'] = 'item',
        ['image'] = 'gasmask.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = "Something for gas"
    },

    ['nightvision']              = {
        ['name'] = 'nightvision',
        ['label'] = 'Nightvision Goggles',
        ['weight'] = 450,
        ['type'] = 'item',
        ['image'] = 'nightvision.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = "Somthing for the night!"
    },

    ['printer_document']         = {
        name = 'printer_document',
        label = 'Document',
        weight = 10,
        unique = true,
        shouldClose = true,
        useable = true
    },

    ['torque_wrench']            = {
        ['name'] = 'torque_wrench',
        ['label'] = 'Torque Wrench',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'torque_wrench.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A torque wrench'
    },

    ['wheel']                    = {
        ['name'] = 'wheel',
        ['label'] = 'Wheel',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'wheel.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A wheel'
    },

    --- OneLife Token
    ['onelife_token']            = {
        ['name'] = 'onelife_token',
        ['label'] = 'OneLife Token',
        ['weight'] = 1,
        ['type'] = 'item',
        ['image'] = 'onelife_token.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = true,
        ['description'] = 'Loyalty pays off....'
    },

    --- Medical Card
    ['medical_card'] = {
        ['name'] = 'medical_card',
        ['label'] = 'OneLife Medical Card',
        ['weight'] = 1,
        ['type'] = 'item',
        ['image'] = 'Medical_Card.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = false,
        ['combinable'] = nil,
        ['decay'] = 7.0,
        ['delete'] = true,
        ['object'] = 'prop_cs_business_card',
        ['description'] = 'Healthy Mind Healthy Body'
    },

    ------Food Bags
    ---
    ["doggybag"]             = { ["name"] = "doggybag", ["label"] = "Doggy Bag", ["weight"] = 5000, ["type"] = "item", ["image"] = "doggybag.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Grab a Doggy Bag of Goodies", },
    ["atomicbag"]            = { ["name"] = "atomicbag", ["label"] = "Atomic Bag", ["weight"] = 5000, ["type"] = "item", ["image"] = "atomicbag.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Grab a Atomic Bag of Goodies", },
    ["coffeepot"]            = { ["name"] = "coffeepot", ["label"] = "Coffee Pot", ["weight"] = 5000, ["type"] = "item", ["image"] = "coffeepot.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Grab a Nice Big Coffee Pot", },

    ---- PD Parcels
    --- 
    ["pd_blankets"]           = { ["name"] = "pd_blankets", ["label"] = "PD Blankets", ["weight"] = 100, ["type"] = "item", ["image"] = "PD_Blanket.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = true, ["description"] = "PD's Way Of Gaining Trust From Locals.....", },
    ["pd_parcels"]            = { ["name"] = "pd_parcels", ["label"] = "PD Parcels",  ["weight"] = 100, ["type"] = "item", ["image"] = "PD_Package.png", ["unique"] = false, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = true, ["description"] = "PD's Way Of Gaining Trust From Locals.....", },

    -- assets_weapons
    ['weapon_de']                     = {
        ['name'] = 'weapon_de',
        ['label'] = 'Desert Eagle',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_de.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A powerful semi-automatic pistol known for its stopping power'
    },
    ['weapon_ak47m2']                 = {
        ['name'] = 'weapon_ak47m2',
        ['label'] = 'AK-47 M2',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_ak47m2.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A modernized version of the legendary AK-47 assault rifle'
    },
    ['weapon_hk416']                  = {
        ['name'] = 'weapon_hk416',
        ['label'] = 'HK416',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_hk416.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A modern assault rifle known for its reliability and accuracy'
    },
    ['weapon_mp5']                    = {
        ['name'] = 'weapon_mp5',
        ['label'] = 'MP5',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SMG',
        ['image'] = 'weapon_mp5.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A reliable submachine gun used by military and law enforcement'
    },
    ['weapon_mp5_diamond']            = {
        ['name'] = 'weapon_mp5_diamond',
        ['label'] = 'MP5 (Diamond)',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SMG',
        ['image'] = 'weapon_mp5_diamond.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Custom MP5 with diamond skin'
    },
    ['weapon_m1911']                  = {
        ['name'] = 'weapon_m1911',
        ['label'] = 'M1911',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_PISTOL',
        ['image'] = 'weapon_m1911.png',
        ['unique'] = true,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A classic semi-automatic pistol with proven reliability'
    },
    ['weapon_aa12']                   = {
        ['name'] = 'weapon_aa12',
        ['label'] = 'AA-12',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_aa12.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A fully automatic shotgun with high rate of fire'
    },
    ['weapon_spas12']                 = {
        ['name'] = 'weapon_spas12',
        ['label'] = 'SPAS-12',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SHOTGUN',
        ['image'] = 'weapon_spas12.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A versatile combat shotgun with dual-mode operation'
    },
    ['weapon_m110']                   = {
        ['name'] = 'weapon_m110',
        ['label'] = 'M110',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_m110.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A semi-automatic sniper rifle used by military forces'
    },
    ['weapon_mk14']                   = {
        ['name'] = 'weapon_mk14',
        ['label'] = 'MK14',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SNIPER',
        ['image'] = 'weapon_mk14.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A battle rifle with sniper capabilities'
    },
    ['weapon_famas']                  = {
        ['name'] = 'weapon_famas',
        ['label'] = 'FAMAS',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_RIFLE',
        ['image'] = 'weapon_famas.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A French assault rifle with bullpup design'
    },
    ['weapon_uzi']                    = {
        ['name'] = 'weapon_uzi',
        ['label'] = 'UZI',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SMG',
        ['image'] = 'weapon_uzi.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A compact submachine gun with distinctive design'
    },
    ['weapon_mac10']                  = {
        ['name'] = 'weapon_mac10',
        ['label'] = 'MAC-10',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_SMG',
        ['image'] = 'weapon_mac10.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A compact submachine gun with high rate of fire'
    },
    ['weapon_m249']                   = {
        ['name'] = 'weapon_m249',
        ['label'] = 'M249',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_m249.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A light machine gun with high rate of fire'
    },
    ['weapon_pkm']                    = {
        ['name'] = 'weapon_pkm',
        ['label'] = 'PKM',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_pkm.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A general-purpose machine gun with belt-fed ammunition'
    },
    ['weapon_rpd']                    = {
        ['name'] = 'weapon_rpd',
        ['label'] = 'RPD',
        ['weight'] = 1000,
        ['type'] = 'weapon',
        ['ammotype'] = 'AMMO_MG',
        ['image'] = 'weapon_rpd.png',
        ['unique'] = true,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A light machine gun with drum-fed ammunition'
    },

    -- BEEKEEPING ITEMS
    ['beehive_box'] = {
        ['name'] = 'beehive_box',
        ['label'] = 'Beehive Box',
        ['weight'] = 2000,
        ['type'] = 'item',
        ['image'] = 'beehive_box.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A box containing a beehive structure'
    },
    ['basic_queen'] = {
        ['name'] = 'basic_queen',
        ['label'] = 'Bee Queen',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'basic_queen.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A bee queen for your hive'
    },
    ['basic_bees'] = {
        ['name'] = 'basic_bees',
        ['label'] = 'Bees',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'basic_bees.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A jar of bees'
    },
    ['basic_hornet_queen'] = {
        ['name'] = 'basic_hornet_queen',
        ['label'] = 'Hornet Queen',
        ['weight'] = 60,
        ['type'] = 'item',
        ['image'] = 'basic_hornet_queen.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A hornet queen for your hive'
    },
    ['basic_hornets'] = {
        ['name'] = 'basic_hornets',
        ['label'] = 'Hornets',
        ['weight'] = 120,
        ['type'] = 'item',
        ['image'] = 'basic_hornets.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A jar of hornets'
    },
    ['honey'] = {
        ['name'] = 'honey',
        ['label'] = 'Honey',
        ['weight'] = 200,
        ['type'] = 'item',
        ['image'] = 'honey.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Fresh honey from your beehive'
    },
    ['honey2'] = {
        ['name'] = 'honey2',
        ['label'] = 'Manuka Honey',
        ['weight'] = 250,
        ['type'] = 'item',
        ['image'] = 'honey2.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Premium Manuka honey from hornets'
    },
    ['empty_bee_jar'] = {
        ['name'] = 'empty_bee_jar',
        ['label'] = 'Empty Bee Jar',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'empty_bee_jar.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'An empty jar for collecting bees or honey'
    },
    ['torch_smoker'] = {
        ['name'] = 'torch_smoker',
        ['label'] = 'Bee Smoker',
        ['weight'] = 800,
        ['type'] = 'item',
        ['image'] = 'torch_smoker.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A smoker to calm bees while working'
    },
    ['bug_net'] = {
        ['name'] = 'bug_net',
        ['label'] = 'Bug Net',
        ['weight'] = 300,
        ['type'] = 'item',
        ['image'] = 'bug_net.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A net for catching bees and insects'
    },
    ['wateringcan_empty'] = {
        ['name'] = 'wateringcan_empty',
        ['label'] = 'Empty Watering Can',
        ['weight'] = 500,
        ['type'] = 'item',
        ['image'] = 'wateringcan_empty.png',
        ['unique'] = false,
        ['useable'] = false,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'An empty watering can'
    },
    ['sugar'] = {
        ['name'] = 'sugar',
        ['label'] = 'Sugar',
        ['weight'] = 100,
        ['type'] = 'item',
        ['image'] = 'sugar.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Sweet sugar for feeding bees'
    },
    ['wheat'] = {
        ['name'] = 'wheat',
        ['label'] = 'Wheat',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'wheat.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'Wheat for cleaning beehives'
    },
    ['potato'] = {
        ['name'] = 'potato',
        ['label'] = 'Potato',
        ['weight'] = 150,
        ['type'] = 'item',
        ['image'] = 'potato.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A potato for healing bees'
    },
    ['bandage'] = {
        ['name'] = 'bandage',
        ['label'] = 'Bandage',
        ['weight'] = 50,
        ['type'] = 'item',
        ['image'] = 'bandage.png',
        ['unique'] = false,
        ['useable'] = true,
        ['shouldClose'] = true,
        ['combinable'] = nil,
        ['description'] = 'A bandage for treating bee sickness'
    },
    ---Dusa Hunting---
        -- ### Dusa Hunting ###
        
        weapon_dhr31 = { name = 'weapon_dhr31', label = "Hunting Rifle", weight = 100, type = 'weapon', ammotype = 'AMMO_SNIPER', image = 'WEAPON_DHR31.png', unique = true, useable = true, description = "" },
    
        campfire = { name = 'campfire', label = "Campfire", weight = 100, type = 'item', ammotype = nil, image = 'campfire.png', unique = true, useable = true, description = "" },
    
        primitive_grill = { name = 'primitive_grill', label = "Primitive Grill", weight = 100, type = 'item', ammotype = nil, image = 'primitive_grill.png', unique = true, useable = true, description = "" },
    
        advanced_grill = { name = 'advanced_grill', label = "Advanced Grill", weight = 100, type = 'item', ammotype = nil, image = 'advanced_grill.png', unique = true, useable = true, description = "" },
    
        hunting_bait = { name = 'hunting_bait', label = "Hunting Bait", weight = 100, type = 'item', ammotype = nil, image = 'hunting_bait.png', unique = true, useable = true, description = "" },
    
        hunting_license = { name = 'hunting_license', label = 'Hunting License', weight = 100, type = 'item', ammotype = nil, image = 'hunting_license.png', unique = true, useable = true, description = "" },
    
        -- ### Dusa Hunting Animal Parts ###
        deer_beef = { name = 'deer_beef', label = 'Deer Beef', weight = 100, type = 'item', ammotype = nil, image = 'deer_beef.png', unique = true, useable = true, description = "" },
        deer_rib = { name = 'deer_rib', label = 'Deer Rib', weight = 100, type = 'item', ammotype = nil, image = 'deer_rib.png', unique = true, useable = true, description = "" },
        deer_leg = { name = 'deer_leg', label = 'Deer Leg', weight = 100, type = 'item', ammotype = nil, image = 'deer_leg.png', unique = true, useable = true, description = "" },
        rabbit_body = { name = 'rabbit_body', label = 'Rabbit Body', weight = 100, type = 'item', ammotype = nil, image = 'rabbit_body.png', unique = true, useable = true, description = "" },
        rabbit_leg = { name = 'rabbit_leg', label = 'Rabbit Leg', weight = 100, type = 'item', ammotype = nil, image = 'rabbit_leg.png', unique = true, useable = true, description = "" },
        rabbit_beef = { name = 'rabbit_beef', label = 'Rabbit Beef', weight = 100, type = 'item', ammotype = nil, image = 'rabbit_beef.png', unique = true, useable = true, description = "" },
        bear_beef = { name = 'bear_beef', label = 'Bear Beef', weight = 100, type = 'item', ammotype = nil, image = 'bear_beef.png', unique = true, useable = true, description = "" },
        bear_rib = { name = 'bear_rib', label = 'Bear Rib', weight = 100, type = 'item', ammotype = nil, image = 'bear_rib.png', unique = true, useable = true, description = "" },
        bear_leg = { name = 'bear_leg', label = 'Bear Leg', weight = 100, type = 'item', ammotype = nil, image = 'bear_leg.png', unique = true, useable = true, description = "" },
        redpanda_body = { name = 'redpanda_body', label = 'Red Panda Body', weight = 100, type = 'item', ammotype = nil, image = 'redpanda_body.png', unique = true, useable = true, description = "" },
        redpanda_leg = { name = 'redpanda_leg', label = 'Red Panda Leg', weight = 100, type = 'item', ammotype = nil, image = 'redpanda_leg.png', unique = true, useable = true, description = "" },
        redpanda_beef = { name = 'redpanda_beef', label = 'Red Panda Beef', weight = 100, type = 'item', ammotype = nil, image = 'redpanda_beef.png', unique = true, useable = true, description = "" },
        boar_leg = { name = 'boar_leg', label = 'Boar Leg', weight = 100, type = 'item', ammotype = nil, image = 'boar_leg.png', unique = true, useable = true, description = "" },
        boar_beef = { name = 'boar_beef', label = 'Boar Beef', weight = 100, type = 'item', ammotype = nil, image = 'boar_beef.png', unique = true, useable = true, description = "" },
        boar_rib = { name = 'boar_rib', label = 'Boar Rib', weight = 100, type = 'item', ammotype = nil, image = 'boar_rib.png', unique = true, useable = true, description = "" },
        coyote_beef = { name = 'coyote_beef', label = 'Coyote Beef', weight = 100, type = 'item', ammotype = nil, image = 'coyote_beef.png', unique = true, useable = true, description = "" },
        coyote_rib = { name = 'coyote_rib', label = 'Coyote Rib', weight = 100, type = 'item', ammotype = nil, image = 'coyote_rib.png', unique = true, useable = true, description = "" },
        coyote_leg = { name = 'coyote_leg', label = 'Coyote Leg', weight = 100, type = 'item', ammotype = nil, image = 'coyote_leg.png', unique = true, useable = true, description = "" },
        mtlion_beef = { name = 'mtlion_beef', label = 'Mountain Lion Beef', weight = 100, type = 'item', ammotype = nil, image = 'mtlion_beef.png', unique = true, useable = true, description = "" },
        mtlion_rib = { name = 'mtlion_rib', label = 'Mountain Lion Rib', weight = 100, type = 'item', ammotype = nil, image = 'mtlion_rib.png', unique = true, useable = true, description = "" },
        mtlion_leg = { name = 'mtlion_leg', label = 'Mountain Lion Leg', weight = 100, type = 'item', ammotype = nil, image = 'mtlion_leg.png', unique = true, useable = true, description = "" },
        lion_beef = { name = 'lion_beef', label = 'Lion Beef', weight = 100, type = 'item', ammotype = nil, image = 'lion_beef.png', unique = true, useable = true, description = "" },
        lion_rib = { name = 'lion_rib', label = 'Lion Rib', weight = 100, type = 'item', ammotype = nil, image = 'lion_rib.png', unique = true, useable = true, description = "" },
        lion_leg = { name = 'lion_leg', label = 'Lion Leg', weight = 100, type = 'item', ammotype = nil, image = 'lion_leg.png', unique = true, useable = true, description = "" },
        lion_body = { name = 'lion_body', label = 'Lion Body', weight = 100, type = 'item', ammotype = nil, image = 'lion_body.png', unique = true, useable = true, description = "" },
        oryx_beef = { name = 'oryx_beef', label = 'Oryx Beef', weight = 100, type = 'item', ammotype = nil, image = 'oryx_beef.png', unique = true, useable = true, description = "" },
        oryx_rib = { name = 'oryx_rib', label = 'Oryx Rib', weight = 100, type = 'item', ammotype = nil, image = 'oryx_rib.png', unique = true, useable = true, description = "" },
        oryx_leg = { name = 'oryx_leg', label = 'Oryx Leg', weight = 100, type = 'item', ammotype = nil, image = 'oryx_leg.png', unique = true, useable = true, description = "" },
        antelope_beef = { name = 'antelope_beef', label = 'Antelope Beef', weight = 100, type = 'item', ammotype = nil, image = 'antelope_beef.png', unique = true, useable = true, description = "" },
        antelope_rib = { name = 'antelope_rib', label = 'Antelope Rib', weight = 100, type = 'item', ammotype = nil, image = 'antelope_rib.png', unique = true, useable = true, description = "" },
        antelope_leg = { name = 'antelope_leg', label = 'Antelope Leg', weight = 100, type = 'item', ammotype = nil, image = 'antelope_leg.png', unique = true, useable = true, description = "" },
    
        -- Cooked Items
        deer_beef_cooked = { name = 'deer_beef_cooked', label = 'Cooked Deer Beef', weight = 100, type = 'item', ammotype = nil, image = 'deer_beef_cooked.png', unique = true, useable = true, description = "" },
        deer_rib_cooked = { name = 'deer_rib_cooked', label = 'Cooked Deer Rib', weight = 100, type = 'item', ammotype = nil, image = 'deer_rib_cooked.png', unique = true, useable = true, description = "" },
        deer_leg_cooked = { name = 'deer_leg_cooked', label = 'Cooked Deer Leg', weight = 100, type = 'item', ammotype = nil, image = 'deer_leg_cooked.png', unique = true, useable = true, description = "" },
        rabbit_body_cooked = { name = 'rabbit_body_cooked', label = 'Cooked Rabbit Body', weight = 100, type = 'item', ammotype = nil, image = 'rabbit_body_cooked.png', unique = true, useable = true, description = "" },
        rabbit_leg_cooked = { name = 'rabbit_leg_cooked', label = 'Cooked Rabbit Leg', weight = 100, type = 'item', ammotype = nil, image = 'rabbit_leg_cooked.png', unique = true, useable = true, description = "" },
        rabbit_beef_cooked = { name = 'rabbit_beef_cooked', label = 'Cooked Rabbit Beef', weight = 100, type = 'item', ammotype = nil, image = 'rabbit_beef_cooked.png', unique = true, useable = true, description = "" },
        bear_beef_cooked = { name = 'bear_beef_cooked', label = 'Cooked Bear Beef', weight = 100, type = 'item', ammotype = nil, image = 'bear_beef_cooked.png', unique = true, useable = true, description = "" },
        bear_rib_cooked = { name = 'bear_rib_cooked', label = 'Cooked Bear Rib', weight = 100, type = 'item', ammotype = nil, image = 'bear_rib_cooked.png', unique = true, useable = true, description = "" },
        bear_leg_cooked = { name = 'bear_leg_cooked', label = 'Cooked Bear Leg', weight = 100, type = 'item', ammotype = nil, image = 'bear_leg_cooked.png', unique = true, useable = true, description = "" },
        redpanda_body_cooked = { name = 'redpanda_body_cooked', label = 'Cooked Red Panda Body', weight = 100, type = 'item', ammotype = nil, image = 'redpanda_body_cooked.png', unique = true, useable = true, description = "" },
        redpanda_leg_cooked = { name = 'redpanda_leg_cooked', label = 'Cooked Red Panda Leg', weight = 100, type = 'item', ammotype = nil, image = 'redpanda_leg_cooked.png', unique = true, useable = true, description = "" },
        redpanda_beef_cooked = { name = 'redpanda_beef_cooked', label = 'Cooked Red Panda Beef', weight = 100, type = 'item', ammotype = nil, image = 'redpanda_beef_cooked.png', unique = true, useable = true, description = "" },
        boar_leg_cooked = { name = 'boar_leg_cooked', label = 'Cooked Boar Leg', weight = 100, type = 'item', ammotype = nil, image = 'boar_leg_cooked.png', unique = true, useable = true, description = "" },
        boar_beef_cooked = { name = 'boar_beef_cooked', label = 'Cooked Boar Beef', weight = 100, type = 'item', ammotype = nil, image = 'boar_beef_cooked.png', unique = true, useable = true, description = "" },
        boar_rib_cooked = { name = 'boar_rib_cooked', label = 'Cooked Boar Rib', weight = 100, type = 'item', ammotype = nil, image = 'boar_rib_cooked.png', unique = true, useable = true, description = "" },
        coyote_beef_cooked = { name = 'coyote_beef_cooked', label = 'Cooked Coyote Beef', weight = 100, type = 'item', ammotype = nil, image = 'coyote_beef_cooked.png', unique = true, useable = true, description = "" },
        coyote_rib_cooked = { name = 'coyote_rib_cooked', label = 'Cooked Coyote Rib', weight = 100, type = 'item', ammotype = nil, image = 'coyote_rib_cooked.png', unique = true, useable = true, description = "" },
        coyote_leg_cooked = { name = 'coyote_leg_cooked', label = 'Cooked Coyote Leg', weight = 100, type = 'item', ammotype = nil, image = 'coyote_leg_cooked.png', unique = true, useable = true, description = "" },
        mtlion_beef_cooked = { name = 'mtlion_beef_cooked', label = 'Cooked Mountain Lion Beef', weight = 100, type = 'item', ammotype = nil, image = 'mtlion_beef_cooked.png', unique = true, useable = true, description = "" },
        mtlion_rib_cooked = { name = 'mtlion_rib_cooked', label = 'Cooked Mountain Lion Rib', weight = 100, type = 'item', ammotype = nil, image = 'mtlion_rib_cooked.png', unique = true, useable = true, description = "" },
        mtlion_leg_cooked = { name = 'mtlion_leg_cooked', label = 'Cooked Mountain Lion Leg', weight = 100, type = 'item', ammotype = nil, image = 'mtlion_leg_cooked.png', unique = true, useable = true, description = "" },
        lion_beef_cooked = { name = 'lion_beef_cooked', label = 'Cooked Lion Beef', weight = 100, type = 'item', ammotype = nil, image = 'lion_beef_cooked.png', unique = true, useable = true, description = "" },
        lion_rib_cooked = { name = 'lion_rib_cooked', label = 'Cooked Lion Rib', weight = 100, type = 'item', ammotype = nil, image = 'lion_rib_cooked.png', unique = true, useable = true, description = "" },
        lion_leg_cooked = { name = 'lion_leg_cooked', label = 'Cooked Lion Leg', weight = 100, type = 'item', ammotype = nil, image = 'lion_leg_cooked.png', unique = true, useable = true, description = "" },
        lion_body_cooked = { name = 'lion_body_cooked', label = 'Cooked Lion Body', weight = 100, type = 'item', ammotype = nil, image = 'lion_body_cooked.png', unique = true, useable = true, description = "" },
        oryx_beef_cooked = { name = 'oryx_beef_cooked', label = 'Cooked Oryx Beef', weight = 100, type = 'item', ammotype = nil, image = 'oryx_beef_cooked.png', unique = true, useable = true, description = "" },
        oryx_rib_cooked = { name = 'oryx_rib_cooked', label = 'Cooked Oryx Rib', weight = 100, type = 'item', ammotype = nil, image = 'oryx_rib_cooked.png', unique = true, useable = true, description = "" },
        oryx_leg_cooked = { name = 'oryx_leg_cooked', label = 'Cooked Oryx Leg', weight = 100, type = 'item', ammotype = nil, image = 'oryx_leg_cooked.png', unique = true, useable = true, description = "" },
        antelope_beef_cooked = { name = 'antelope_beef_cooked', label = 'Cooked Antelope Beef', weight = 100, type = 'item', ammotype = nil, image = 'antelope_beef_cooked.png', unique = true, useable = true, description = "" },
        antelope_rib_cooked = { name = 'antelope_rib_cooked', label = 'Cooked Antelope Rib', weight = 100, type = 'item', ammotype = nil, image = 'antelope_rib_cooked.png', unique = true, useable = true, description = "" },
        antelope_leg_cooked = { name = 'antelope_leg_cooked', label = 'Cooked Antelope Leg', weight = 100, type = 'item', ammotype = nil, image = 'antelope_leg_cooked.png', unique = true, useable = true, description = "" },
    
        hide = { name = 'hide', label = "Hide", weight = 100, type = 'item', ammotype = nil, image = 'hide.png', unique = true, useable = true, description = "" },
    
        binocular = { name = 'binocular', label = 'Binocular', weight = 100, type = 'item', ammotype = nil, image = 'binocular.png', unique = true, useable = true, description = "" },
    
        hunting_trap = { name = 'hunting_trap', label = 'Hunting Trap', weight = 100, type = 'item', ammotype = nil, image = 'hunting_trap.png', unique = true, useable = true, description = "" },
    
        hunting_laptop = { name = 'hunting_laptop', label = 'Hunting Laptop', weight = 100, type = 'item', ammotype = nil, image = 'hunting_laptop.png', unique = true, useable = true, description = "" },

        ["bass"]				 	 = {["name"] = "bass", 						["label"] = "Bass", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "bass.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["carp"]				 	 = {["name"] = "carp", 						["label"] = "Carp", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "carp.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["crab"]				 	 = {["name"] = "crab", 						["label"] = "crab", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "crab.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["lobster"]				 	 = {["name"] = "lobster", 						["label"] = "Lobster", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "lobster.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["mullet"]				 	 = {["name"] = "mullet", 						["label"] = "Mullet", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "mullet.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["perch"]				 	 = {["name"] = "perch", 						["label"] = "Perch", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "perch.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["trout"]				 	 = {["name"] = "trout", 						["label"] = "Trout", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "trout.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["tuna"]				 	 = {["name"] = "tuna", 						    ["label"] = "Tuna", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "tuna.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},

["turtle"]				 	 = {["name"] = "turtle", 						    ["label"] = "turtle", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "turtle.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["octopus"]				 	 = {["name"] = "octopus", 						    ["label"] = "Octopus", 				["weight"] = 100, 	["type"] = "item", 		["image"] = "octopus.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},

["rod_1"]				 	 = {["name"] = "rod_1", 						["label"] = "Rod Lv.1", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "rod_1.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["rod_2"]				 	 = {["name"] = "rod_2", 						["label"] = "Rod Lv.2", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "rod_2.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["rod_3"]				 	 = {["name"] = "rod_3", 						["label"] = "Rod Lv.3", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "rod_3.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["rod_4"]				 	 = {["name"] = "rod_4", 						["label"] = "Rod Lv.4", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "rod_4.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},

["worm"]				 	 = {["name"] = "worm", 						    ["label"] = "Worm", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "worm.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["shrimp_lure"]				 = {["name"] = "shrimp_lure", 					["label"] = "Shrimp Lure", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "shrimp_lure.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},
["illegalbait"]				 = {["name"] = "illegalbait", 					["label"] = "Illegal Bait", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "illegalbait.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},

["tackle_box"]				 = {["name"] = "tackle_box", 					["label"] = "Tackle Box", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "tackle_box.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = ""},

wheel_lock                  = { name = 'wheel_lock', label = 'Wheel Locker', weight = 100, type = 'item', image = 'wheel_lock.png', unique = false, useable = true, shouldClose = true, description = '' },
wrench                  = { name = 'wrench', label = 'Wrench', weight = 100, type = 'item', image = 'wrench.png', unique = false, useable = true, shouldClose = true, description = '' },
gps                  = { name = 'gps', label = 'GPS', weight = 100, type = 'item', image = 'gps.png', unique = false, useable = true, shouldClose = true, description = '' },
vehicle_gps                  = { name = 'vehicle_gps', label = 'Vehicle GPS', weight = 100, type = 'item', image = 'vehicle_gps.png', unique = false, useable = true, shouldClose = true, description = '' },
remove_gps                  = { name = 'remove_gps', label = 'GPS Detacher', weight = 100, type = 'item', image = 'remove_gps.png', unique = false, useable = true, shouldClose = true, description = '' },
radio                  = { name = 'radio', label = 'Radio', weight = 100, type = 'item', image = 'radio.png', unique = false, useable = true, shouldClose = true, description = '' },
handcuffs                  = { name = 'handcuffs', label = 'Handcuffs', weight = 100, type = 'item', image = 'handcuffs.png', unique = false, useable = true, shouldClose = true, description = '' },
cuff_keys                  = { name = 'moneybag', label = 'Cuff Keys', weight = 100, type = 'item', image = 'cuff_keys.png', unique = false, useable = true, shouldClose = true, description = '' },
moneybag                  = { name = 'moneybag', label = 'Money bag', weight = 100, type = 'item', image = 'moneybag.png', unique = false, useable = true, shouldClose = true, description = '' },

["magnifying_glass"]				 = {["name"] = "magnifying_glass", 					["label"] = "Magnifying Glass", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "magnifying_glass.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Check for fingerprints on vehicle"},
["thermal_camera"]				 = {["name"] = "thermal_camera", 					["label"] = "Thermal Camera", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "thermal_camera.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Analyze scene"},
["evidence_tablet"]				 = {["name"] = "evidence_tablet", 					["label"] = "Evidence Tablet", 			["weight"] = 100, 	["type"] = "item", 		["image"] = "evidence_tablet.png", 			["unique"] = true, 		["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Manage all evidence reports, analyze"},

["invisibility_vape"] = {["name"] = "invisibility_vape", ["label"] = "Invisibility Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "invisibility_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Grants temporary invisibility."},
["speed_vape"] = {["name"] = "speed_vape", ["label"] = "Speed Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "speed_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Boosts your running speed."},
["superjump_vape"] = {["name"] = "superjump_vape", ["label"] = "Super Jump Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "superjump_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Enables super high jumps."},
["teleport_vape"] = {["name"] = "teleport_vape", ["label"] = "Teleport Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "teleport_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Teleports you to your waypoint."},
["invincibility_vape"] = {["name"] = "invincibility_vape", ["label"] = "Invincibility Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "invincibility_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Makes you invincible for a short time."},
["transform_vape"] = {["name"] = "transform_vape", ["label"] = "Transform Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "transform_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Transforms you into a random animal."},
["freeze_vape"] = {["name"] = "freeze_vape", ["label"] = "Freeze Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "freeze_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Freezes you in place."},
["gravity_vape"] = {["name"] = "gravity_vape", ["label"] = "Gravity Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "gravity_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Reduces gravity for floating movement."},
["health_vape"] = {["name"] = "health_vape", ["label"] = "Health Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "health_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Restores your health to maximum."},
["armor_vape"] = {["name"] = "armor_vape", ["label"] = "Armor Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "armor_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Fully restores your armor."},
["random_vape"] = {["name"] = "random_vape", ["label"] = "Random Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "random_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Applies a random special vape effect."},
["carspeed_vape"] = {["name"] = "carspeed_vape", ["label"] = "Car Speed Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "carspeed_vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "Boosts vehicle speed when used inside one."},
["vape"] = {["name"] = "vape", ["label"] = "Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A standard vape for casual use."},
["vape_watermelon"] = {["name"] = "vape_watermelon", ["label"] = "Watermelon Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_watermelon.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A watermelon-flavored vape."},
["vape_mango"] = {["name"] = "vape_mango", ["label"] = "Mango Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_mango.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A mango-flavored vape."},
["vape_blueberry"] = {["name"] = "vape_blueberry", ["label"] = "Blueberry Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_blueberry.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A blueberry-flavored vape."},
["vape_strawberry"] = {["name"] = "vape_strawberry", ["label"] = "Strawberry Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_strawberry.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A strawberry-flavored vape."},
["vape_pineapple"] = {["name"] = "vape_pineapple", ["label"] = "Pineapple Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_pineapple.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A pineapple-flavored vape."},
["vape_grape"] = {["name"] = "vape_grape", ["label"] = "Grape Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_grape.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A grape-flavored vape."},
["vape_cherry"] = {["name"] = "vape_cherry", ["label"] = "Cherry Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_cherry.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A cherry-flavored vape."},
["vape_lime"] = {["name"] = "vape_lime", ["label"] = "Lime Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_lime.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A lime-flavored vape."},
["vape_coconut"] = {["name"] = "vape_coconut", ["label"] = "Coconut Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_coconut.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A coconut-flavored vape."},
["vape_raspberry"] = {["name"] = "vape_raspberry", ["label"] = "Raspberry Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_raspberry.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A raspberry-flavored vape."},
["vape_peach"] = {["name"] = "vape_peach", ["label"] = "Peach Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_peach.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A peach-flavored vape."},
["vape_mint"] = {["name"] = "vape_mint", ["label"] = "Mint Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_mint.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A mint-flavored vape."},
["vape_vanilla"] = {["name"] = "vape_vanilla", ["label"] = "Vanilla Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_vanilla.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A vanilla-flavored vape."},
["vape_lemon"] = {["name"] = "vape_lemon", ["label"] = "Lemon Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_lemon.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A lemon-flavored vape."},
["vape_banana"] = {["name"] = "vape_banana", ["label"] = "Banana Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_banana.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A banana-flavored vape."},
["vape_apple"] = {["name"] = "vape_apple", ["label"] = "Apple Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_apple.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "An apple-flavored vape."},
["vape_kiwi"] = {["name"] = "vape_kiwi", ["label"] = "Kiwi Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_kiwi.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A kiwi-flavored vape."},
["vape_caramel"] = {["name"] = "vape_caramel", ["label"] = "Caramel Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_caramel.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A caramel-flavored vape."},
["vape_cinnamon"] = {["name"] = "vape_cinnamon", ["label"] = "Cinnamon Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_cinnamon.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A cinnamon-flavored vape."},
["vape_honey"] = {["name"] = "vape_honey", ["label"] = "Honey Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_honey.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A honey-flavored vape."},
["vape_pear"] = {["name"] = "vape_pear", ["label"] = "Pear Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_pear.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A pear-flavored vape."},
["vape_cranberry"] = {["name"] = "vape_cranberry", ["label"] = "Cranberry Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_cranberry.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A cranberry-flavored vape."},
["vape_coffee"] = {["name"] = "vape_coffee", ["label"] = "Coffee Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_coffee.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A coffee-flavored vape."},
["vape_pomegranate"] = {["name"] = "vape_pomegranate", ["label"] = "Pomegranate Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_pomegranate.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A pomegranate-flavored vape."},
["vape_tangerine"] = {["name"] = "vape_tangerine", ["label"] = "Tangerine Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_tangerine.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A tangerine-flavored vape."},
["vape_chocolate"] = {["name"] = "vape_chocolate", ["label"] = "Chocolate Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_chocolate.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A chocolate-flavored vape."},
["vape_guava"] = {["name"] = "vape_guava", ["label"] = "Guava Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_guava.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A guava-flavored vape."},
["vape_toffee"] = {["name"] = "vape_toffee", ["label"] = "Toffee Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_toffee.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A toffee-flavored vape."},
["vape_blackberry"] = {["name"] = "vape_blackberry", ["label"] = "Blackberry Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_blackberry.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A blackberry-flavored vape."},
["vape_apricot"] = {["name"] = "vape_apricot", ["label"] = "Apricot Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_apricot.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "An apricot-flavored vape."},
["vape_plum"] = {["name"] = "vape_plum", ["label"] = "Plum Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_plum.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A plum-flavored vape."},
["vape_passionfruit"] = {["name"] = "vape_passionfruit", ["label"] = "Passionfruit Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_passionfruit.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A passionfruit-flavored vape."},
["vape_lychee"] = {["name"] = "vape_lychee", ["label"] = "Lychee Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_lychee.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A lychee-flavored vape."},
["vape_dragonfruit"] = {["name"] = "vape_dragonfruit", ["label"] = "Dragonfruit Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_dragonfruit.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A dragonfruit-flavored vape."},
["vape_paella"] = {["name"] = "vape_paella", ["label"] = "Paella Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_paella.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A paella-flavored vape."},
["vape_cucumber"] = {["name"] = "vape_cucumber", ["label"] = "Cucumber Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_cucumber.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A cucumber-flavored vape."},
["vape_berrymix"] = {["name"] = "vape_berrymix", ["label"] = "Berry Mix Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_berrymix.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A berry mix-flavored vape."},
["vape_hazelnut"] = {["name"] = "vape_hazelnut", ["label"] = "Hazelnut Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_hazelnut.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A hazelnut-flavored vape."},
["vape_melon"] = {["name"] = "vape_melon", ["label"] = "Melon Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_melon.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A melon-flavored vape."},
["vape_ginger"] = {["name"] = "vape_ginger", ["label"] = "Ginger Vape", ["weight"] = 1, ["type"] = "item", ["image"] = "vape_ginger.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = "A ginger-flavored vape."},

['ammonium_nitrate'] = {['name'] = 'ammonium_nitrate', ['label'] = 'Ammonium nitrate', ['weight'] = 500, ['type'] = 'item', ['image'] = 'ammonium_nitrate.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['carbon'] = {['name'] = 'carbon', ['label'] = 'Carbon', ['weight'] = 500, ['type'] = 'item', ['image'] = 'carbon.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['codeine'] = {['name'] = 'codeine', ['label'] = 'Codeine', ['weight'] = 500, ['type'] = 'item', ['image'] = 'codeine.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['drink_sprite'] = {['name'] = 'drink_sprite', ['label'] = 'Sprite', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drink_sprite.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['drug_ecstasy'] = {['name'] = 'drug_ecstasy', ['label'] = 'Ecstasy', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drug_ecstasy.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['drug_lean'] = {['name'] = 'drug_lean', ['label'] = 'Lean', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drug_lean.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['drug_lsd'] = {['name'] = 'drug_lsd', ['label'] = 'LSD', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drug_lsd.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['drug_meth'] = {['name'] = 'drug_meth', ['label'] = 'Meth', ['weight'] = 500, ['type'] = 'item', ['image'] = 'drug_meth.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['hydrogen'] = {['name'] = 'hydrogen', ['label'] = 'Hydrogen', ['weight'] = 500, ['type'] = 'item', ['image'] = 'hydrogen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['ice'] = {['name'] = 'ice', ['label'] = 'Ice', ['weight'] = 500, ['type'] = 'item', ['image'] = 'ice.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['jolly_ranchers'] = {['name'] = 'jolly_ranchers', ['label'] = 'Jolly Ranchers', ['weight'] = 500, ['type'] = 'item', ['image'] = 'jolly_ranchers.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['liquid_sulfur'] = {['name'] = 'liquid_sulfur', ['label'] = 'Liquid Sulfur', ['weight'] = 500, ['type'] = 'item', ['image'] = 'liquid_sulfur.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['muriatic_acid'] = {['name'] = 'muriatic_acid', ['label'] = 'Muriatic Acid', ['weight'] = 500, ['type'] = 'item', ['image'] = 'muriatic_acid.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['nitrogen'] = {['name'] = 'nitrogen', ['label'] = 'Nitrogen', ['weight'] = 500, ['type'] = 'item', ['image'] = 'nitrogen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['oxygen'] = {['name'] = 'oxygen', ['label'] = 'Oxygen', ['weight'] = 500, ['type'] = 'item', ['image'] = 'oxygen.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['pseudoefedrine'] = {['name'] = 'pseudoefedrine', ['label'] = 'Pseudoefedrine', ['weight'] = 500, ['type'] = 'item', ['image'] = 'pseudoefedrine.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['red_sulfur'] = {['name'] = 'red_sulfur', ['label'] = 'Red Sulfur', ['weight'] = 500, ['type'] = 'item', ['image'] = 'red_sulfur.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['sodium_hydroxide'] = {['name'] = 'sodium_hydroxide', ['label'] = 'Sodium hydroxide', ['weight'] = 500, ['type'] = 'item', ['image'] = 'sodium_hydroxide.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['water'] = {['name'] = 'water', ['label'] = 'Water', ['weight'] = 500, ['type'] = 'item', ['image'] = 'water.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['cannabis'] = {['name'] = 'cannabis', ['label'] = 'Cannabis', ['weight'] = 500, ['type'] = 'item', ['image'] = 'cannabis.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['green_gelato_cannabis'] = {['name'] = 'green_gelato_cannabis', ['label'] = 'Green Gelato Cannabis', ['weight'] = 500, ['type'] = 'item', ['image'] = 'green_gelato_cannabis.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['opium'] = {['name'] = 'opium', ['label'] = 'Opium', ['weight'] = 500, ['type'] = 'item', ['image'] = 'opium.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},
['cocaine'] = {['name'] = 'cocaine', ['label'] = 'Cocaine', ['weight'] = 500, ['type'] = 'item', ['image'] = 'cocaine.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = false, ['combinable'] = nil},

["pot"] = {
    ["name"] = "pot",
    ["label"] = "Pot",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "pot.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["potting_soil"] = {
    ["name"] = "potting_soil",
    ["label"] = "Potting Soil",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "potting_soil.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["drug_lamp"] = {
    ["name"] = "drug_lamp",
    ["label"] = "Lamp",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "drug_lamp.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["drug_table"] = {
    ["name"] = "drug_table",
    ["label"] = "Table",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "drug_table.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["drying_rack"] = {
    ["name"] = "drying_rack",
    ["label"] = "Drying Rack",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "drying_rack.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["drug_oven"] = {
    ["name"] = "drug_oven",
    ["label"] = "Oven",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "drug_oven.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["fertilizer"] = {
    ["name"] = "fertilizer",
    ["label"] = "Fertilizer",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "fertilizer.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["weed_seed"] = {
    ["name"] = "weed_seed",
    ["label"] = "Weed Seed",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "weed_seed.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["wet_weed"] = {
    ["name"] = "wet_weed",
    ["label"] = "Wet Weed",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "wet_weed.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["coca_seed"] = {
    ["name"] = "coca_seed",
    ["label"] = "Coca Seed",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "coca_seed.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["coca_leaf"] = {
    ["name"] = "coca_leaf",
    ["label"] = "Coca Leaf",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "coca_leaf.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["dried_coca_leaf"] = {
    ["name"] = "dried_coca_leaf",
    ["label"] = "Dried Coca Leaf",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "dried_coca_leaf.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["dried_weed"] = {
    ["name"] = "dried_weed",
    ["label"] = "Dried Wet Weed",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "dried_weed.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["baggie"] = {
    ["name"] = "baggie",
    ["label"] = "Baggie",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "baggie.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["packaged_weed"] = {
    ["name"] = "packaged_weed",
    ["label"] = "Packaged Weed",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "packaged_weed.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["acetone"] = {
    ["name"] = "acetone",
    ["label"] = "Acetone",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "acetone.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["cooking_pot"] = {
    ["name"] = "cooking_pot",
    ["label"] = "Cooking Pot",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "cooking_pot.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["cocaine"] = {
    ["name"] = "cocaine",
    ["label"] = "Cocaine",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "cocaine.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["plastic_wrap"] = {
    ["name"] = "plastic_wrap",
    ["label"] = "Plastic Wrap",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "plastic_wrap.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["cocaine_press"] = {
    ["name"] = "cocaine_press",
    ["label"] = "Cocaine Press",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "cocaine_press.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["cocaine_brick"] = {
    ["name"] = "cocaine_brick",
    ["label"] = "Cocaine Brick",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "cocaine_brick.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["ephedrine"] = {
    ["name"] = "ephedrine",
    ["label"] = "Ephedrine",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "ephedrine.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["sodium"] = {
    ["name"] = "sodium",
    ["label"] = "Sodium",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "sodium.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["lithium"] = {
    ["name"] = "lithium",
    ["label"] = "Lithium",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "lithium.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["hydrochloric_acid"] = {
    ["name"] = "hydrochloric_acid",
    ["label"] = "Hydrochloric Acid",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "hydrochloric_acid.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["bunsen_burner"] = {
    ["name"] = "bunsen_burner",
    ["label"] = "Bunsen Burner",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "bunsen_burner.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["uncooked_meth"] = {
    ["name"] = "uncooked_meth",
    ["label"] = "Uncooked Meth",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "uncooked_meth.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["hammer"] = {
    ["name"] = "hammer",
    ["label"] = "Hammer",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "hammer.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["meth_pure"] = {
    ["name"] = "meth_pure",
    ["label"] = "Meth Pure",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "meth_pure.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["meth"] = {
    ["name"] = "meth",
    ["label"] = "Meth",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "meth.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["lsd"] = {
    ["name"] = "lsd",
    ["label"] = "LSD",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "lsd.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["heroin"] = {
    ["name"] = "heroin",
    ["label"] = "Heroin",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "heroin.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["joint"] = {
    ["name"] = "joint",
    ["label"] = "Joint",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "joint.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},
["rolling_paper"] = {
    ["name"] = "rolling_paper",
    ["label"] = "Rolling Paper",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "rolling_paper.png",
    ["unique"] = false,
    ["useable"] = false,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = "Not have"
},

["basicdecrypter"] = {["name"] = "basicdecrypter", ["label"] = "Basic Decrypter", ["weight"] = 10, ["type"] = "item", ["image"] = "basicdecrypter.png", ["unique"] = true,     ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""},
["basicdrill"] = {["name"] = "basicdrill", ["label"] = "Basic Drill", ["weight"] = 10, ["type"] = "item", ["image"] = "basicdrill.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""},
["laptop_green"] = {["name"] = "laptop_green", ["label"] = "Laptop", ["weight"] = 25, ["type"] = "item", ["image"] = "laptop_green.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""},
['inkedbills'] = {['name'] = 'inkedbills', ['label'] = 'Inked Money Bag', ['weight'] = 20, ['type'] = 'item', ['image'] = 'money-bag.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A bag full of inked bills'},

['common_case'] = {['name'] = 'common_case', ['label'] = 'Common Case', ['weight'] = 50, ['type'] = 'item', ['image'] = 'common_case.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A common loot case containing basic items and small rewards'},
['uncommon_case'] = {['name'] = 'uncommon_case', ['label'] = 'Uncommon Case', ['weight'] = 50, ['type'] = 'item', ['image'] = 'uncommon_case.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'An uncommon loot case with better rewards and improved chances'},
['rare_case'] = {['name'] = 'rare_case', ['label'] = 'Rare Case', ['weight'] = 50, ['type'] = 'item', ['image'] = 'diamond_case.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A rare loot case containing premium rewards and rare items'},
['epic_case'] = {['name'] = 'epic_case', ['label'] = 'Epic Case', ['weight'] = 50, ['type'] = 'item', ['image'] = 'epic_case.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'An epic loot case with high-tier rewards and epic weapons'},
['legendary_case'] = {['name'] = 'legendary_case', ['label'] = 'Legendary Case', ['weight'] = 50, ['type'] = 'item', ['image'] = 'legendary_case.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A legendary loot case containing ultimate rewards and legendary weapons'},
['diamond_case'] = {['name'] = 'diamond_case', ['label'] = 'Diamond Case', ['weight'] = 50, ['type'] = 'item', ['image'] = 'diamond_case.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A diamond loot case containing ultimate premium rewards and exclusive items'},

---Police Gun Pack---

    -- GGC Custom Weapons -- Melees
    ['weapon_katana'] 				 = {['name'] = 'weapon_katana', 	 		  	['label'] = 'Katana', 					['weight'] = 2000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_katana.png', 			['unique'] = true, 		['useable'] = false,	['description'] = 'A single-edged sword that is the longer of a pair worn by the Japanese samurai.'},
    ['weapon_shiv'] 				 = {['name'] = 'weapon_shiv', 	 		  		['label'] = 'Shiv', 					['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_shiv.png', 				['unique'] = true, 		['useable'] = false,	['description'] = 'An instrument composed of a blade fixed into a handle, used for cutting or as a weapon.'},
    ['weapon_sledgehammer'] 		 = {['name'] = 'weapon_sledgehammer', 	 		['label'] = 'Sledge Hammer', 			['weight'] = 9000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_sledgehammer.png', 		['unique'] = true, 		['useable'] = false,	['description'] = 'A Sledge Hammer to destroy peoples heads... jk... unless...'},
    ['weapon_karambit'] 			 = {['name'] = 'weapon_karambit', 			 	['label'] = 'Karambit', 				['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = nil,						['image'] = 'weapon_karambit.png', 		    ['unique'] = true, 		['useable'] = false,	['description'] = 'A short knife with a pointed and edged blade, used as a weapon'},
    ['weapon_keyboard'] 			 = {['name'] = 'weapon_keyboard', 				['label'] = 'Keyboard', 				['weight'] = 3000, 		['type'] = 'weapon', 	['ammotype'] = nil,			    	['image'] = 'weapon_keyboard.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'YOU CAN USE THIS TO HIT YOUR SON xD'},
    -- GGC Custom Weapons -- Lethals
	['weapon_beanbag'] 			     = {['name'] = 'weapon_beanbag', 	 	  		['label'] = 'Bean Bag', 				['weight'] = 10000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_SHOTGUN',			['image'] = 'weapon_beanbag.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'A shotgun? no!'},
	-- GGC Custom Weapons -- Hand Guns
	['weapon_glock17'] 				 = {['name'] = 'weapon_glock17', 				['label'] = 'Glock-17', 				['weight'] = 7000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_glock17.png', 			['unique'] = true, 		['useable'] = false,	['description'] = 'The Glock 17 is the original 9×19mm Parabellum model, with a standard magazine capacity of 17 rounds.'},
	['weapon_glock18c'] 			 = {['name'] = 'weapon_glock18c', 				['label'] = 'Glock-18C', 				['weight'] = 7000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_glock18c.png', 			['unique'] = true, 		['useable'] = false,	['description'] = 'The Glock 18C is a selective-fire variant of the Glock 17.'},
	['weapon_glock22'] 			     = {['name'] = 'weapon_glock22', 				['label'] = 'Glock-22', 				['weight'] = 7000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_glock22.png', 			['unique'] = true, 		['useable'] = false,	['description'] = 'The Glock 22 is a .40 S&W version of the full-sized Glock 17.'},
	['weapon_deagle'] 					 = {['name'] = 'weapon_deagle', 			['label'] = 'Desert Eagle',			    ['weight'] = 8000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_deagle.png', 			['unique'] = true, 		['useable'] = false,	['description'] = 'The Desert Eagle is a gas-operated, semi-automatic pistol known for chambering the .50 Action Express, the largest centerfire cartridge of any magazine-fed, self-loading pistol.'},
	['weapon_fnx45'] 				 = {['name'] = 'weapon_fnx45', 	 				['label'] = 'FN FNX-45', 				['weight'] = 7000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_fnx45.png', 			['unique'] = true, 		['useable'] = false,	['description'] = 'The FN FNX pistol is a series of semi-automatic, the pistol is chambered for the 9×19mm Parabellum, .40 S&W, and .45 ACP cartridges.'},
	['weapon_m1911'] 				 = {['name'] = 'weapon_m1911', 	 			  	['label'] = 'M1911', 					['weight'] = 7000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_m1911.png',  			['unique'] = true, 		['useable'] = false,	['description'] = 'The M1911 (Colt 1911 or Colt Government) is a single-action, recoil-operated, semi-automatic pistol chambered for the .45 ACP cartridge.'},
    ['weapon_glock20'] 				 = {['name'] = 'weapon_glock20', 	 			['label'] = 'Glock-20', 				['weight'] = 7000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_glock20.png',  			['unique'] = true, 		['useable'] = false,	['description'] = 'An ambidextrous, reversible magazine latch makes the GLOCK 20 an ideal handgun for right- and left-handed shooters.'},
    ['weapon_glock19gen4'] 			 = {['name'] = 'weapon_glock19gen4', 	 		['label'] = 'Glock-19 Gen 4', 			['weight'] = 7000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_glock19gen4.png',  		['unique'] = true, 		['useable'] = false,	['description'] = 'The GLOCK 19 Gen4 pistol in 9 mm Luger offers great firepower while allowing to shoot quick and accurately.'},
    ['weapon_browning'] 		     = {['name'] = 'weapon_browning', 				['label'] = 'Browning', 				['weight'] = 5000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_browning.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'The Browning 9-mm pistol is a personal protection weapon used mainly in close-quarter combat.'},
    -- GGC Custom Weapons -- SMGs
    ['weapon_pmxfm'] 				 = {['name'] = 'weapon_pmxfm', 	 			  	['label'] = 'Beretta PMX', 				['weight'] = 11000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'weapon_pmxfm.png',  			['unique'] = true, 		['useable'] = false,	['description'] = 'The Beretta PMX is a 9x19mm Parabellum caliber submachine gun, designed and manufactured by the Italian company Beretta.'},
    ['weapon_mac10'] 				 = {['name'] = 'weapon_mac10', 			 		['label'] = 'MAC-10', 					['weight'] = 10000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',				['image'] = 'weapon_mac10.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'The Military Armament Corporation Model 10, commonly known as the MAC 10 and also known as the M10 or MAC-10.'},
    -- GGC Custom Weapons -- Rifles
    ['weapon_mk47fm'] 				 = {['name'] = 'weapon_mk47fm', 	 			['label'] = 'MK47 Mutant', 				['weight'] = 16000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_mk47fm.png',  			['unique'] = true, 		['useable'] = false,	['description'] = 'The Mk47 Mutant is an American-made semi-automatic rifle chambered in 7.62×39mm caliber.'},
    ['weapon_m6ic'] 				 = {['name'] = 'weapon_m6ic', 	 			  	['label'] = 'LWRC M6IC', 				['weight'] = 14000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_m6ic.png',  			['unique'] = true, 		['useable'] = false,	['description'] = 'The LWRC M6IC is an AR-15 direct impingement rifle made by LWRC and was created for the US Military.'},
    ['weapon_scarsc'] 				 = {['name'] = 'weapon_scarsc', 	 			['label'] = 'Scar SC', 					['weight'] = 14000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_scarsc.png',  			['unique'] = true, 		['useable'] = false,	['description'] = 'The FN SCAR-SC is offered in the U.S. as select-fire only with a non-reciprocating charging handle and telescoping buttstock.'},
    ['weapon_m4'] 					 = {['name'] = 'weapon_m4', 	 			  	['label'] = 'M4A1 Carbine', 			['weight'] = 13000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_m4.png',			 	['unique'] = true, 		['useable'] = false,	['description'] = 'The M4 carbine is a 5.56×45mm NATO, gas-operated, magazine-fed carbine developed in the United States during the 1980s.'},
    ['weapon_ak47'] 		 		 = {['name'] = 'weapon_ak47', 	 			  	['label'] = 'AK-47', 					['weight'] = 13000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_ak47.png', 				['unique'] = true, 		['useable'] = false,	['description'] = 'The AK-47, officially known as the Avtomat Kalashnikova, is a gas-operated assault rifle that is chambered for the 7.62×39mm cartridge.'},
    ['weapon_ak74'] 		 		 = {['name'] = 'weapon_ak74', 	 			  	['label'] = 'AK-74', 					['weight'] = 13000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_ak74.png', 				['unique'] = true, 		['useable'] = false,	['description'] = 'The AK-74 or Kalashnikov automatic rifle model 1974 is a 5.45mm assault rifle developed in the early 1970s in the Soviet Union.'},
    ['weapon_aks74'] 		 		 = {['name'] = 'weapon_aks74', 	 			  	['label'] = 'AKS-74', 					['weight'] = 13000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_aks74.png', 			['unique'] = true, 		['useable'] = false,	['description'] = 'The AKS-74U Short Assault Rifle is a shortened version of the AKS-74 Assault Rifle released in 1979.'},
    ['weapon_groza'] 				 = {['name'] = 'weapon_groza', 			 		['label'] = 'OTs-14 Groza', 			['weight'] = 15000, 	['type'] = 'weapon', 	['ammotype'] = 'AMMO_MG',			['image'] = 'weapon_groza.png', 			['unique'] = true, 		['useable'] = false, 	['description'] = 'The OTs-14 Groza is a Russian selective fire bullpup assault rifle chambered for the 7.62×39 round and the 9×39mm subsonic round.'},


    ["rope"] = {
    ["name"] = "rope",
    ["label"] = "Rope",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "rope.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = ""
},
["drill"] = {
    ["name"] = "drill",
    ["label"] = "Drill",
    ["weight"] = 10,
    ["type"] = "item",
    ["image"] = "drill.png",
    ["unique"] = false,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = ""
},

['rose'] = {
    ['name'] = 'rose',                       
    ['label'] = 'Rose',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'rose.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = 'Rose for pet'
},
['controller'] = {
    ['name'] = 'controller',                       
    ['label'] = 'Controller',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'controller.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['hat'] = {
    ['name'] = 'hat',                       
    ['label'] = 'Pet Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'hat.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['hat2'] = {
    ['name'] = 'hat2',                       
    ['label'] = 'Pet Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'hat2.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['teddybear'] = {
    ['name'] = 'teddybear',                       
    ['label'] = 'Teddybear',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'teddybear.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['glasses'] = {
    ['name'] = 'glasses',                       
    ['label'] = 'Pet Glasses',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'glasses.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['glasses2'] = {
    ['name'] = 'glasses2',                       
    ['label'] = 'Pet Glasses',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'glasses2.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['coolglasses'] = {
    ['name'] = 'coolglasses',                       
    ['label'] = 'Pet Glasses',              
    ['weight'] = 0,      
    ['type'] = 'item',         
    ['image'] = 'coolglasses.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['collar'] = {
    ['name'] = 'collar',
    ['label'] = 'Pet Collar',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'collar.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['collar2'] = {
    ['name'] = 'collar2',                       
    ['label'] = 'Pet Collar',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'collar2.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['collar3'] = {
    ['name'] = 'collar3',                       
    ['label'] = 'Pet Collar',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'collar3.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['collar4'] = {
    ['name'] = 'collar4',                       
    ['label'] = 'Pet Collar',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'collar4.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['collar5'] = {
    ['name'] = 'collar5',                       
    ['label'] = 'Pet Collar',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'collar5.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['collar6'] = {
    ['name'] = 'collar6',                       
    ['label'] = 'Pet Collar',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'collar6.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['collar7'] = {
    ['name'] = 'collar7',                       
    ['label'] = 'Pet Collar',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'collar7.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['bluebandana'] = {
    ['name'] = 'bluebandana',                       
    ['label'] = 'Blue Bandana',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'bluebandana.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['blackbandana'] = {
    ['name'] = 'blackbandana',                       
    ['label'] = 'Black Bandana',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'blackbandana.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['unihorn'] = {
    ['name'] = 'unihorn',                       
    ['label'] = 'Unicorn Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'unihorn.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['unihorn2'] = {
    ['name'] = 'unihorn2',                       
    ['label'] = 'Unicorn Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'unihorn2.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['unihorn3'] = {
    ['name'] = 'unihorn3',                       
    ['label'] = 'Unicorn Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'unihorn3.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['unihorn4'] = {
    ['name'] = 'unihorn4',                       
    ['label'] = 'Unicorn Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'unihorn4.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['unihorn5'] = {
    ['name'] = 'unihorn5',                       
    ['label'] = 'Unicorn Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'unihorn5.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['unihorn6'] = {
    ['name'] = 'unihorn6',                       
    ['label'] = 'Unicorn Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'unihorn6.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['unihorn7'] = {
    ['name'] = 'unihorn7',                       
    ['label'] = 'Unicorn Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'unihorn7.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['unihorn8'] = {
    ['name'] = 'unihorn8',                       
    ['label'] = 'Unicorn Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'unihorn8.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['unihorn9'] = {
    ['name'] = 'unihorn9',                       
    ['label'] = 'Unicorn Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'unihorn9.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat'] = {
    ['name'] = 'tinyhat',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat2'] = {
    ['name'] = 'tinyhat2',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat2.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat3'] = {
    ['name'] = 'tinyhat3',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat3.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat4'] = {
    ['name'] = 'tinyhat4',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat4.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat5'] = {
    ['name'] = 'tinyhat5',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat5.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat6'] = {
    ['name'] = 'tinyhat6',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat6.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat7'] = {
    ['name'] = 'tinyhat7',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat7.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat8'] = {
    ['name'] = 'tinyhat8',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat8.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat9'] = {
    ['name'] = 'tinyhat9',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat9.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat10'] = {
    ['name'] = 'tinyhat10',                       
    ['label'] = 'Tiny Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tinyhat10.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},

-- New Clothes (Update v1.5)
['beewings'] = {
    ['name'] = 'beewings',                       
    ['label'] = 'Bee Wings',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'beewings.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['batmanvest'] = {
    ['name'] = 'batmanvest',                       
    ['label'] = 'Batman Vest',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'batmanvest.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['redvest'] = {
    ['name'] = 'redvest',                       
    ['label'] = 'Red Vest',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'redvest.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['blackvest'] = {
    ['name'] = 'blackvest',                       
    ['label'] = 'Black Vest',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'blackvest.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['bowtie'] = {
    ['name'] = 'bowtie',                       
    ['label'] = 'Bowtie',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'bowtie.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['tinyhat10'] = {
    ['name'] = 'daisyvest',                       
    ['label'] = 'Daisy Vest',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'daisyvest.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['petchef'] = {
    ['name'] = 'petchef',                       
    ['label'] = 'Chef Hat',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'petchef.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['daisycrown'] = {
    ['name'] = 'daisycrown',                       
    ['label'] = 'Daisy Crown',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'daisycrown.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['petdeer'] = {
    ['name'] = 'petdeer',                       
    ['label'] = 'Deer Horn',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'petdeer.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['petchain'] = {
    ['name'] = 'petchain',                       
    ['label'] = 'Chain',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'petchain.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['partyglasses'] = {
    ['name'] = 'partyglasses',                       
    ['label'] = 'Party Glasses',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'partyglasses.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['beetail'] = {
    ['name'] = 'beetail',                       
    ['label'] = 'Bee Tail',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'beetail.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['beadnecklace'] = {
    ['name'] = 'beadnecklace',                       
    ['label'] = 'Bead Necklace',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'beadnecklace.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['pinksweater'] = {
    ['name'] = 'pinksweater',                       
    ['label'] = 'Pink Sweater',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'pinksweater.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['xmasvest'] = {
    ['name'] = 'xmasvest',                       
    ['label'] = 'XMas Vest',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'xmasvest.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['brownshoes'] = {
    ['name'] = 'brownshoes',                       
    ['label'] = 'Brown Shoes',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'brownshoes.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['fairyvest'] = {
    ['name'] = 'fairyvest',                       
    ['label'] = 'Fairy Vest',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'fairyvest.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['k9vest'] = {
    ['name'] = 'k9vest',                       
    ['label'] = 'K9 Vest',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'k9vest.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},


-- MEDICAL SUPPLIES
['treatmentkit'] = {
    ['name'] = 'treatmentkit',                       
    ['label'] = 'Pet Treatment Kit',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'treatmentkit.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['revivekit'] = {
    ['name'] = 'revivekit',                       
    ['label'] = 'Pet Revive Kit',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'revivekit.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['treatmentpills'] = {
    ['name'] = 'treatmentpills',                       
    ['label'] = 'Pet Treatment Pills',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'treatmentpills.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},

-- CONSUMABLES
['tennisball'] = {
    ['name'] = 'tennisball',                       
    ['label'] = 'Tennis Ball',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'tennisball.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['petbowl'] = {
    ['name'] = 'petbowl',                       
    ['label'] = 'Pet Feed Bowl',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'petbowl.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['petbed'] = {
    ['name'] = 'petbed',                       
    ['label'] = 'Pet Bed',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'petbed.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['petbed2'] = {
    ['name'] = 'petbed2',                       
    ['label'] = 'Pet Bed',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'petbed2.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = ''
},
['nametag'] = {
    ['name'] = 'nametag',                       
    ['label'] = 'Name Tag',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'nametag.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = 'Rename your pet'
},

-- Leashes (Update v1.5)
['leash'] = {
    ['name'] = 'leash',                       
    ['label'] = 'Pet Leash',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'leash.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = 'Handle your pet'
},
['leash2'] = {
    ['name'] = 'leash2',                       
    ['label'] = 'Pet Leash',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'leash2.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = 'Handle your pet'
},
['leash3'] = {
    ['name'] = 'leash3',                       
    ['label'] = 'Pet Leash',              
    ['weight'] = 0,            
    ['type'] = 'item',         
    ['image'] = 'leash3.png',             
    ['unique'] = false,         
    ['useable'] = true,     
    ['shouldClose'] = false,    
    ['combinable'] = nil,   
    ['description'] = 'Handle your pet'
},
}
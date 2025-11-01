-- qb-smallresources->config.lua

--If using old qb-smallresources
Config.ConsumablesDrink = {
    ['cc_bubbletea'] = math.random(35, 54),
    ['cc_chocolatemilkshake'] = math.random(35, 54),
    ['cc_strawberrysmoothie'] = math.random(35, 54),
    ['cc_berryblastsmoothie'] = math.random(35, 54),
    ['cc_tropicalparadisesmoothie'] = math.random(35, 54),
    ['cc_espresso'] = math.random(35, 54),
    ['cc_cappuccino'] = math.random(35, 54),
    ['cc_latte'] = math.random(35, 54),
    ['cc_mocha'] = math.random(35, 54),
    ['cc_hotchocolate'] = math.random(35, 54),
}

Config.ConsumablesEat = {
    ['cc_fukuoka_hakata_ramen'] = math.random(35, 54),
    ['cc_miso_ramen'] = math.random(35, 54),
    ['cc_nagoya_taiwan_ramen'] = math.random(35, 54),
    ['cc_osaka_shio_ramen'] = math.random(35, 54),
    ['cc_shoyu_ramen'] = math.random(35, 54),
    ['cc_tonkotsu_ramen'] = math.random(35, 54),
    ['cc_iekei_ramen'] = math.random(35, 54),
    ['cc_black_garlic_ramen'] = math.random(35, 54),
    ['cc_vanilla_icecream'] = math.random(35, 54),
    ['cc_chocolate_icecream'] = math.random(35, 54),
    ['cc_strawberry_icecream'] = math.random(35, 54),
    ['cc_mintchoco_icecream'] = math.random(35, 54),
    ['cc_coffee_icecream'] = math.random(35, 54),
    ['cc_classic_blt_sandwich'] = math.random(35, 54),
    ['cc_cheese_sandwich'] = math.random(35, 54),
    ['cc_turkey_sandwich'] = math.random(35, 54),
    ['cc_caprese_sandwich'] = math.random(35, 54),
    ['cc_avocado_sandwich'] = math.random(35, 54),
}

--If using new qb-smallresources
Config.Consumables = {
    eat = {
        ['cc_fukuoka_hakata_ramen'] = math.random(35, 54),
        ['cc_miso_ramen'] = math.random(35, 54),
        ['cc_nagoya_taiwan_ramen'] = math.random(35, 54),
        ['cc_osaka_shio_ramen'] = math.random(35, 54),
        ['cc_shoyu_ramen'] = math.random(35, 54),
        ['cc_tonkotsu_ramen'] = math.random(35, 54),
        ['cc_iekei_ramen'] = math.random(35, 54),
        ['cc_black_garlic_ramen'] = math.random(35, 54),

        ['cc_vanilla_icecream'] = math.random(35, 54),
        ['cc_chocolate_icecream'] = math.random(35, 54),
        ['cc_strawberry_icecream'] = math.random(35, 54),
        ['cc_mintchoco_icecream'] = math.random(35, 54),
        ['cc_coffee_icecream'] = math.random(35, 54),

        ['cc_classic_blt_sandwich'] = math.random(35, 54),
        ['cc_cheese_sandwich'] = math.random(35, 54),
        ['cc_turkey_sandwich'] = math.random(35, 54),
        ['cc_caprese_sandwich'] = math.random(35, 54),
        ['cc_avocado_sandwich'] = math.random(35, 54),
    },
    drink = {
        ['cc_bubbletea'] = math.random(35, 54),
        ['cc_chocolatemilkshake'] = math.random(35, 54),
        ['cc_strawberrysmoothie'] = math.random(35, 54),
        ['cc_berryblastsmoothie'] = math.random(35, 54),
        ['cc_tropicalparadisesmoothie'] = math.random(35, 54),

        ['cc_espresso'] = math.random(35, 54),
        ['cc_cappuccino'] = math.random(35, 54),
        ['cc_latte'] = math.random(35, 54),
        ['cc_mocha'] = math.random(35, 54),
        ['cc_hotchocolate'] = math.random(35, 54),
    },
}

--jim-consumables/shared/consumables.lua

cc_fukuoka_hakata_ramen = { emote = "uwuramen", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
cc_miso_ramen = { emote = "uwuramen", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
cc_nagoya_taiwan_ramen = { emote = "uwuramen", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
cc_osaka_shio_ramen = { emote = "uwuramen", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
cc_shoyu_ramen = { emote = "uwuramen", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
cc_tonkotsu_ramen = { emote = "uwuramen", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
cc_iekei_ramen = { emote = "uwuramen", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
cc_black_garlic_ramen = { emote = "uwuramen", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},

cc_vanilla_icecream = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
cc_chocolate_icecream = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
cc_strawberry_icecream = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
cc_mintchoco_icecream = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
cc_coffee_icecream = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},

cc_classic_blt_sandwich = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
cc_cheese_sandwich = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
cc_turkey_sandwich = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
cc_caprese_sandwich = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},
cc_avocado_sandwich = {emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,20), }},

cc_bubbletea = {emote = "uwudrink", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
cc_chocolatemilkshake = {emote = "uwudrink", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
cc_strawberrysmoothie = {emote = "uwudrink", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
cc_berryblastsmoothie = {emote = "uwudrink", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},
cc_tropicalparadisesmoothie = {emote = "uwudrink", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,20), }},

cc_espresso = {emote = "coffee", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { effect = "stamina", time = 10000, thirst = math.random(10,20), }},
cc_cappuccino = {emote = "coffee", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { effect = "stamina", time = 10000, thirst = math.random(10,20), }},
cc_latte = {emote = "coffee", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { effect = "stamina", time = 10000, thirst = math.random(10,20), }},
cc_mocha = {emote = "coffee", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { effect = "stamina", time = 10000, thirst = math.random(10,20), }},
cc_hotchocolate = {emote = "coffee", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { effect = "stamina", time = 10000, thirst = math.random(10,20), }},

--jim-consumables/shared/emotes.lua
uwudrink = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Drink", AnimationOptions ={ Prop = "prop_cs_paper_cup", PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},EmoteMoving = true, EmoteLoop = true, }},
uwuramen = {"anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", "base_idle", "Ramen", AnimationOptions ={ Prop = "prop_cs_bowl_01b", PropBone = 60309, PropPlacement = {0.0, 0.0300, 0.0100, 0.0, 0.0, 0.0},EmoteMoving = true, EmoteLoop = true, }},
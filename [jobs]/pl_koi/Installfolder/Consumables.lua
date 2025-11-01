-- qb-smallresources->config.lua

--If using old qb-smallresources
Config.ConsumablesDrink = {
    ['koi_mojito'] = math.random(35, 54),
    ['koi_pina_colada'] = math.random(35, 54),
    ['koi_margarita'] = math.random(35, 54),
    ['koi_espresso_martini'] = math.random(35, 54),
    ['koi_arnold_palmer'] = math.random(35, 54),
}

Config.ConsumablesEat = {
    ['koi_grilled_salmon'] = math.random(35, 54),
    ['koi_lobster_tail'] = math.random(35, 54),
    ['koi_shrimp_scampi'] = math.random(35, 54),
    ['koi_seared_scallops'] = math.random(35, 54),
    ['koi_crab_cakes'] = math.random(35, 54),
    ['koi_ribeye_steak'] = math.random(35, 54),
    ['koi_filet_mignon'] = math.random(35, 54),
    ['koi_t_bone_steak'] = math.random(35, 54),
    ['koi_tomahawk_steak'] = math.random(35, 54),
    ['koi_new_york_strip'] = math.random(35, 54),
    ['koi_tiramisu'] = math.random(35, 54),
    ['koi_cheesecake'] = math.random(35, 54),
    ['koi_chocolate_lava_cake'] = math.random(35, 54),
    ['koi_creme_brulee'] = math.random(35, 54),
    ['koi_key_lime_pie'] = math.random(35, 54),
}

--If using new qb-smallresources
Config.Consumables = {
    eat = {
        ['koi_grilled_salmon'] = math.random(35, 54),
        ['koi_lobster_tail'] = math.random(35, 54),
        ['koi_shrimp_scampi'] = math.random(35, 54),
        ['koi_seared_scallops'] = math.random(35, 54),
        ['koi_crab_cakes'] = math.random(35, 54),
        ['koi_ribeye_steak'] = math.random(35, 54),
        ['koi_filet_mignon'] = math.random(35, 54),
        ['koi_t_bone_steak'] = math.random(35, 54),
        ['koi_tomahawk_steak'] = math.random(35, 54),
        ['koi_new_york_strip'] = math.random(35, 54),
        ['koi_tiramisu'] = math.random(35, 54),
        ['koi_cheesecake'] = math.random(35, 54),
        ['koi_chocolate_lava_cake'] = math.random(35, 54),
        ['koi_creme_brulee'] = math.random(35, 54),
        ['koi_key_lime_pie'] = math.random(35, 54),
    },
    drink = {
        ['koi_mojito'] = math.random(35, 54),
        ['koi_pina_colada'] = math.random(35, 54),
        ['koi_margarita'] = math.random(35, 54),
        ['koi_espresso_martini'] = math.random(35, 54),
        ['koi_arnold_palmer'] = math.random(35, 54),
    },
}

--jim-consumables/shared/consumables.lua
koi_grilled_salmon = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_lobster_tail = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_shrimp_scampi = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_seared_scallops = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_crab_cakes = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_ribeye_steak = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_filet_mignon = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_t_bone_steak = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_tomahawk_steak = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_new_york_strip = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_tiramisu = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_cheesecake = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_chocolate_lava_cake = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_creme_brulee = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_key_lime_pie = { emote = "burger", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},

koi_mojito = { emote = "drink", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_pina_colada = { emote = "drink", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_margarita = { emote = "drink", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_espresso_martini = { emote = "drink", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},
koi_arnold_palmer = { emote = "drink", canRun = false, time = math.random(5000, 6000), stress = math.random(1, 2), heal = 0, armor = 0, type = "food",stats = { hunger = math.random(10,20), }},

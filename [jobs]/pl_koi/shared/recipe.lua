local ItemDefinitions = {}

WorkingCoords = {
    gabz = {
        Seafoods = vec3(-1072.92, -1443.27, -1.42),
        Drinks = vec3(-1074.5, -1448.76, -1.42),
        Steaks = vec3(-1071.92, -1445.68, -1.42),
        Desserts = vec3(-1075.86, -1449.69, -1.42),
    }
}

ItemDefinitions.original = {
    categories = {
         Seafoods = { 
            label = "Seafoods", --Donot Change
            icon = "fas fa-pizza-slice",
            workingcoords = WorkingCoords[Config.location].Seafoods, -- Use the working coordinates based on the location
            items = {
                koi_grilled_salmon = {
                    label="Koi Grilled Salmon",
                    price = 50, --For Starting Price
                    reward = 1, --item reward on completing
                    duration = 10000,
                    required = {  -- required items for crafting
					{item = 'koi_salt', label="Salt", quantity = 10},
                    {item = 'koi_dill_butter', label="Dill Butter", quantity = 10},
				    },
                },
                koi_lobster_tail = {
                    label="Koi Lobster Tail",
                    price = 50, --For Starting Price
                    reward = 1, --item reward on completing
                    duration = 10000,
                    required = {  -- required items for crafting
					{item = 'koi_salt', label="Salt", quantity = 10},
                    {item = 'koi_clarified_butter', label="Clarified Butter", quantity = 10},
				    },
                },
                koi_shrimp_scampi = {
                    label="Koi Shrimp Scampi",
                    price = 50, --For Starting Price
                    reward = 1, --item reward on completing
                    duration = 10000,
                    required = {  -- required items for crafting
					{item = 'koi_salt', label="Salt", quantity = 10},
                    {item = 'koi_white_wine', label="White Wine", quantity = 10},
				    },
                },
                koi_seared_scallops = {
                    label="Koi Seared Scallops",
                    price = 50, --For Starting Price
                    reward = 1, --item reward on completing
                    duration = 10000,
                    required = {  -- required items for crafting
					{item = 'koi_salt', label="Salt", quantity = 10},
                    {item = 'koi_truffle_oil', label="Truffle Oil", quantity = 10},
				    },
                },
                koi_crab_cakes = {
                    label="Koi Crab Cakes",
                    price = 50, --For Starting Price
                    reward = 1, --item reward on completing
                    duration = 10000,
                    required = {  -- required items for crafting
					{item = 'koi_salt', label="Salt", quantity = 10},
                    {item = 'koi_old_bay_seasoning', label="Old Bay Seasoning", quantity = 10},
				    },
                },

            }
        },
        -- Drinks
        Drinks= { 
            label = "Drinks", --Donot Change
            icon = "fas fa-utensils",
            workingcoords = WorkingCoords[Config.location].Drinks,
            items = {
                koi_mojito = {
                    label = "Koi Mojito",
                    price = 50,
                    reward = 10,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_fresh_mint_leaves', label = "Fresh Mint Leaves", quantity = 10 },
                        { item = 'koi_emptycup', label = "Koi Empty Cup", quantity = 10 },
                        { item = 'koi_icecubes', label = "Koi Ice Cubes", quantity = 10 },
                    },
                },
                koi_pina_colada = {
                    label = "Koi Pina Colada",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_coconut_cream', label = "Coconut Cream", quantity = 10 },
                        { item = 'koi_emptycup', label = "Koi Empty Cup", quantity = 10 },
                        { item = 'koi_icecubes', label = "Koi Ice Cubes", quantity = 10 },
                    },
                },
                koi_margarita = {
                    label = "Koi Margarita",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_triple_sec', label = "Triple Sec", quantity = 10 },
                        { item = 'koi_emptycup', label = "Koi Empty Cup", quantity = 10 },
                        { item = 'koi_icecubes', label = "Koi Ice Cubes", quantity = 10 },
                    },
                },
                koi_espresso_martini = {
                    label = "Koi Espresso Martini",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_coffee_liquor_kahlua', label = "Coffee Liquor", quantity = 10 },
                        { item = 'koi_emptycup', label = "Koi Empty Cup", quantity = 10 },
                        { item = 'koi_icecubes', label = "Koi Ice Cubes", quantity = 10 },
                    },
                },
                koi_arnold_palmer = {
                    label = "Koi Arnold Palmer",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_fresh_lemonade', label = "Fresh Lemonade", quantity = 10 },
                        { item = 'koi_emptycup', label = "Koi Empty Cup", quantity = 10 },
                        { item = 'koi_icecubes', label = "Koi Ice Cubes", quantity = 10 },
                    },
                },
            }
        },
        Steaks = { 
            label = "Steaks", --Donot Change
            icon = "fas fa-seedling",
            workingcoords = WorkingCoords[Config.location].Steaks,
            items = {
                koi_ribeye_steak = {
                    label = "Koi Ribeye Steak",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_herb_butter', label = "Herb Butter", quantity = 10 },
                    },
                },
                koi_filet_mignon = {
                    label = "Koi Filet Mignon",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_bearnaise_sauce', label = "Béarnaise Sauce", quantity = 10 },
                    },
                },
                koi_t_bone_steak = {
                    label = "Koi T-Bone Steak",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_steakhouse_dry_rub', label = "Steakhouse Dry Rub", quantity = 10 },
                    },
                },
                koi_tomahawk_steak = {
                    label = "Koi Tomahawk Steak",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_smoked_sea_salt', label = "Smoked Sea Salt", quantity = 10 },
                    },
                },
                koi_new_york_strip = {
                    label = "Koi New York Strip",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_red_wine_reduction', label = "Red Wine Reduction", quantity = 10 },
                    },
                },
            },
        },
        Desserts = {
            label = "Desserts", -- Do not change
            icon = "fas fa-bowl-food",
            workingcoords = WorkingCoords[Config.location].Desserts,
            items = {
                koi_tiramisu = {
                    label = "Koi Tiramisu",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_mascarpone_cheese', label = "Mascarpone Cheese", quantity = 10 },
                    },
                },
                koi_cheesecake = {
                    label = "Koi Cheesecake",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_graham_cracker_crust', label = "Graham Cracker Crust", quantity = 10 },
                    },
                },
                koi_chocolate_lava_cake = {
                    label = "Koi Chocolate Lava Cake",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_molten_ganache_filling', label = "Molten Ganache Filling", quantity = 10 },
                    },
                },
                koi_creme_brulee = {
                    label = "Koi Creme Brulee",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_caramelized_sugar_topping', label = "Caramelized Sugar Topping", quantity = 10 },
                    },
                },
                koi_key_lime_pie = {
                    label = "Koi Key Lime Pie",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_key_lime_juice', label = "Key Lime Juice", quantity = 10 },
                    },
                },
            },
        },
    },
}

ItemDefinitions.dj = {
    categories = {
        Chicken = {
            label = "Chicken",
            icon = "fas fa-drumstick-bite",
            workingcoords = WorkingCoords[Config.location].Seafoods,
            items = {
                djs_togo_blackpepperchicken = {
                    label = "DJ Black Pepper Chicken",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
                djs_togo_kungpaochicken = {
                    label = "DJ Kung Pao Chicken",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                    },
                },
                djs_togo_mushroomchicken = {
                    label = "DJ Mushroom Chicken",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
                djs_togo_sweetfirechicken = {
                    label = "DJ Sweetfire Chicken",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
                djs_togo_teriyakichicken = {
                    label = "DJ Teriyaki Chicken",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                    },
                },
                djs_togocontainer_chicken = {
                    label = "DJ Chicken To-Go Container",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
            },
        },
        Beef = {
            label = "Beef",
            icon = "fas fa-bacon",
            workingcoords = WorkingCoords[Config.location].Steaks,
            items = {
                djs_togo_beijingbeef = {
                    label = "DJ Beijing Beef",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                    },
                },
                djs_togo_blackpepperangussteak = {
                    label = "DJ Black Pepper Angus Steak",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                    },
                },
                djs_togo_broccolibeef = {
                    label = "DJ Broccoli Beef",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_black_pepper', label = "Black Pepper", quantity = 10 },
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
            },
        },
        Seafood = {
            label = "Seafood",
            icon = "fas fa-fish",
            workingcoords = WorkingCoords[Config.location].Seafood,
            items = {
                djs_togo_honeywalnutshrimp = {
                    label = "DJ Honey Walnut Shrimp",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                    },
                },
                djs_togo_chveggieeggroll = {
                    label = "DJ Veggie Egg Roll",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
                djs_togo_eggroll = {
                    label = "DJ Egg Roll",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
                djs_togo_supergreens = {
                    label = "DJ Super Greens",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
            },
        },
        RiceNoodles = {
            label = "Rice & Noodles",
            icon = "fas fa-bowl-rice",
            workingcoords = WorkingCoords[Config.location].Steaks,
            items = {
                djs_togocontainer_mangorice = {
                    label = "DJ Mango Rice Container",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_sugar', label = "Sugar", quantity = 10 },
                    },
                },
                djs_togocontainer_noodles = {
                    label = "DJ Noodles Container",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
                djs_togocontainer_whiterice = {
                    label = "DJ White Rice Container",
                    price = 50,
                    reward = 1,
                    duration = 10000,
                    required = {
                        { item = 'koi_salt', label = "Salt", quantity = 10 },
                    },
                },
            },
        },
        PremadeBoxes = {
            label = "Premade Meals",
            icon = "fas fa-box",
            workingcoords = WorkingCoords[Config.location].Steaks,
            items = {
                djs_togopremade_bigbox = { label="DJ Big Box 1", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bigbox2 = { label="DJ Big Box 2", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bigbox3 = { label="DJ Big Box 3", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bigbox4 = { label="DJ Big Box 4", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bigbox5 = { label="DJ Big Box 5", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bigbox6 = { label="DJ Big Box 6", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },

                djs_togopremade_bowl = { label="DJ Bowl 1", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bowl2 = { label="DJ Bowl 2", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bowl3 = { label="DJ Bowl 3", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bowl4 = { label="DJ Bowl 4", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bowl5 = { label="DJ Bowl 5", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bowl6 = { label="DJ Bowl 6", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bowl7 = { label="DJ Bowl 7", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bowl8 = { label="DJ Bowl 8", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bowl9 = { label="DJ Bowl 9", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_bowl10 = { label="DJ Bowl 10", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },

                djs_togopremade_box = { label="DJ Box 1", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_box2 = { label="DJ Box 2", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_box3 = { label="DJ Box 3", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_box4 = { label="DJ Box 4", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_box5 = { label="DJ Box 5", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
                djs_togopremade_box6 = { label="DJ Box 6", price=50, reward=1, duration=10000, required={{item='koi_salt',label="Salt",quantity=1}}, },
            },
        },
    },
}



if Config.UseDJItems then
    ItemDefinitions = ItemDefinitions.dj
else
    ItemDefinitions = ItemDefinitions.original
end

return ItemDefinitions



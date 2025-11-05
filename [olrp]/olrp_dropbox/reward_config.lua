-- OLRP Dropbox Reward Configuration

return {
    -- Reward Categories with percentage-based drops
    -- Total percentages should add up to 100 for best results
    RewardCategories = {
        {
            name = "Common",
            chance = 50, -- 50% chance
            color = "~w~", -- White color for notifications
            rewards = {
                {type = "item", item = "markedbills", min = 2, max = 5, label = "Cash"},
                {type = "item", item = "meth_bag", min = 10, max = 20, label = "Meth"},
                {type = "item", item = "crack", min = 10, max = 20, label = "Crack"},
                {type = "item", item = "coke_pure", min = 10, max = 20, label = "Coke"},
                {type = "item", item = "pistol_ammo", min = 10, max = 20, label = "Pistol Ammo"},
                {type = "item", item = "smg_ammo", min = 10, max = 20, label = "SMG Ammo"},
                {type = "item", item = "rifle_ammo", min = 10, max = 20, label = "Rifle Ammo"},
                {type = "item", item = "heavyarmor", min = 10, max = 20, label = "Body Armor"},
                {type = "weapon", item = "weapon_blueglocks", min = 1, max = 2, label = "Pistol"},
                {type = "weapon", item = "weapon_bf_night", min = 1, max = 2, label = "Knife"},
                {type = "weapon", item = "weapon_m9_tigertooth", min = 1, max = 2, label = "Knife"},
                {type = "weapon", item = "weapon_ceramicpistol", min = 1, max = 2, label = "Pistol"},
            }
        },
        {
            name = "Uncommon", 
            chance = 25, -- 25% chance
            color = "~g~", -- Green color for notifications 
            rewards = {
                {type = "item", item = "markedbills", min = 5, max = 10, label = "Cash"},
                {type = "item", item = "meth_bag", min = 20, max = 30, label = "Meth"},
                {type = "item", item = "crack", min = 20, max = 30, label = "Crack"},
                {type = "item", item = "coke_pure", min = 20, max = 30, label = "Coke"},
                {type = "item", item = "pistol_ammo", min = 20, max = 30, label = "Pistol Ammo"},
                {type = "item", item = "smg_ammo", min = 20, max = 30, label = "SMG Ammo"},
                {type = "item", item = "rifle_ammo", min = 20, max = 30, label = "Rifle Ammo"},
                {type = "item", item = "heavyarmor", min = 20, max = 30, label = "Body Armor"},
                {type = "weapon", item = "weapon_krissvector", min = 1, max = 2, label = "SMG"},
                {type = "weapon", item = "weapon_m9_brightwater", min = 1, max = 2, label = "Knife"},
                {type = "weapon", item = "weapon_m9_lore", min = 1, max = 2, label = "Knife"},
                {type = "item", item = "laundromatkey", min = 1, max = 1, label = "Laundromat Key"},
            }
        },
        {
            name = "Rare",
            chance = 15, -- 15% chance  
            color = "~b~", -- Blue color for notifications
            rewards = {
                {type = "item", item = "markedbills", min = 10, max = 12, label = "Cash"},
                {type = "item", item = "meth_bag", min = 30, max = 40, label = "Meth"},
                {type = "item", item = "crack", min = 30, max = 40, label = "Crack"},
                {type = "item", item = "coke_pure", min = 30, max = 40, label = "Coke"},
                {type = "item", item = "pistol_ammo", min = 30, max = 40, label = "Pistol Ammo"},
                {type = "item", item = "smg_ammo", min = 30, max = 40, label = "SMG Ammo"},
                {type = "item", item = "rifle_ammo", min = 30, max = 40, label = "Rifle Ammo"},
                {type = "item", item = "heavyarmor", min = 30, max = 40, label = "Body Armor"},
                {type = "weapon", item = "weapon_redarp", min = 1, max = 2, label = "Lockpick"},
                {type = "weapon", item = "weapon_karambit_lore", min = 1, max = 2, label = "Knife"},
                {type = "weapon", item = "weapon_m9_brightwater", min = 1, max = 2, label = "Knife"},
                {type = "item", item = "bobcatcard2", min = 1, max = 1, label = "Bobcat Card"},
            }
        },
        {
            name = "Epic",
            chance = 8, -- 8% chance
            color = "~p~", -- Purple color for notifications
            rewards = {
                {type = "item", item = "markedbills", min = 12, max = 18, label = "Cash"},
                {type = "item", item = "meth_bag", min = 40, max = 50, label = "Meth"},
                {type = "item", item = "crack", min = 40, max = 50, label = "Crack"},
                {type = "item", item = "coke_pure", min = 40, max = 50, label = "Coke"},
                {type = "item", item = "pistol_ammo", min = 40, max = 50, label = "Pistol Ammo"},
                {type = "item", item = "smg_ammo", min = 40, max = 50, label = "SMG Ammo"},
                {type = "item", item = "rifle_ammo", min = 40, max = 50, label = "Rifle Ammo"},
                {type = "item", item = "heavyarmor", min = 40, max = 50, label = "Heavy Armor"},
                {type = "weapon", item = "weapon_de", min = 1, max = 2, label = "Desert Eagle"},
                {type = "item", item = "bobcatcard", min = 1, max = 2, label = "bobcatcard"},
                {type = "weapon", item = "weapon_compactrifle", min = 1, max = 2, label = "SMG"},
                {type = "weapon", item = "weapon_assaultrifle_mk2", min = 1, max = 2, label = "Assault Rifle Mk2"},
                {type = "weapon", item = "weapon_carbinerifle_mk2", min = 1, max = 1, label = "Carbine Rifle Mk2"},
                {type = "weapon", item = "weapon_ak47m2", min = 1, max = 1, label = "AK-47 M2"},
            }
        },
        {
            name = "Legendary",
            chance = 2, -- 2% chance
            color = "~r~", -- Red color for notifications
            rewards = {
                {type = "item", item = "markedbills", min = 18, max = 24, label = "Cash"},
                {type = "item", item = "meth_bag", min = 50, max = 60, label = "Meth"},
                {type = "item", item = "crack", min = 50, max = 60, label = "Crack"},
                {type = "item", item = "coke_pure", min = 50, max = 60, label = "Coke"},
                {type = "item", item = "pistol_ammo", min = 50, max = 60, label = "Pistol Ammo"},
                {type = "item", item = "smg_ammo", min = 50, max = 60, label = "SMG Ammo"},
                {type = "item", item = "rifle_ammo", min = 50, max = 60, label = "Rifle Ammo"},
                {type = "item", item = "heavyarmor", min = 50, max = 60, label = "Heavy Armor"},
		        {type = "weapon", item = "weapon_de", min = 1, max = 2, label = "Desert Eagle"},
                {type = "weapon", item = "weapon_krissvector", min = 1, max = 2, label = "SMG"},
                {type = "weapon", item = "weapon_redarp", min = 1, max = 2, label = "Lockpick"},
                {type = "weapon", item = "weapon_assaultrifle", min = 1, max = 2, label = "Assault Rifle"},
                {type = "weapon", item = "weapon_carbinerifle_mk2", min = 1, max = 2, label = "Carbine Rifle Mk2"},
                {type = "weapon", item = "weapon_ak47m2", min = 1, max = 2, label = "AK-47 M2"},
            }
        }
    },
    
    -- Configuration for reward selection (all rewards are given)
    Config = {
        -- All rewards from the selected category are given
        -- Amounts are randomized between min and max values
    },
    
    -- Color mapping for dropbox rarity tiers
    RarityColors = {
        Common = {
            blipColor = 0, -- White
            radiusColor = 0, -- White (radius)
            radiusAlpha = 150,
            textColor = "~w~" -- White
        },
        Uncommon = {
            blipColor = 2, -- Green
            radiusColor = 2, -- Green (radius)
            radiusAlpha = 150,
            textColor = "~g~" -- Green
        },
        Rare = {
            blipColor = 3, -- Blue
            radiusColor = 3, -- Blue (radius)
            radiusAlpha = 150,
            textColor = "~b~" -- Blue
        },
        Epic = {
            blipColor = 27, -- Purple (icon)
            radiusColor = 7, -- Purple-ish for radius (more widely supported)
            radiusAlpha = 150,
            textColor = "~p~" -- Purple
        },
        Legendary = {
            blipColor = 17, -- Orange (icon)
            radiusColor = 17, -- Orange (radius)
            radiusAlpha = 200, -- Brighter for legendary
            textColor = "~o~" -- Orange
        }
    }
}

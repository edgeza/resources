CFG = {}

--[[
    DROP RATE SYSTEM (CSGO-Style)
    This system works like CSGO case openings:
    1. Each case contains items with different rarities
    2. Lower numbers = higher drop chance, higher numbers = rarer
    3. Within each case, items are weighted by their rarity
    4. The item selected is what the player receives
    
    Example with current values:
    - Common items: 60 weight (most common)
    - Uncommon items: 25 weight
    - Rare items: 10 weight  
    - Epic items: 4 weight
    - Legendary items: 1 weight (rarest)
    
    Total weight = 100, so:
    - Common drop chance = 60/100 = 60%
    - Uncommon = 25%
    - Rare = 10%
    - Epic = 4%
    - Legendary = 1%
]]

CFG.RarityChance = {
    ["Common"] = 60,
    ["Uncommon"] = 25,
    ["Rare"] = 10,
    ["Epic"] = 4,
    ["Legendary"] = 1,
}

-- Case configurations with proper images and rewards
CFG.CaseList = {
    ["common_case"] = {
        title = "Common Case",
        description = "Contains basic items and small rewards",
        color = "#808080",
        image = "images/common_case.png",
        items = {
            -- Common (60% chance)
            {name = "Bandage", item = "bandage", amount = 10, rarity = "Common", image = "bandage.png"},
            {name = "Water Bottle", item = "water_bottle", amount = 5, rarity = "Common", image = "water_bottle.png"},
            {name = "Lockpick", item = "lockpick", amount = 3, rarity = "Common", image = "lockpick.png"},
            {name = "Pistol Ammo", item = "pistol_ammo", amount = 25, rarity = "Common", image = "pistol_ammo.png"},
            -- Uncommon (25% chance)
            {name = "Advanced Lockpick", item = "advancedlockpick", amount = 2, rarity = "Uncommon", image = "advancedlockpick.png"},
            {name = "Phone", item = "phone", amount = 1, rarity = "Uncommon", image = "phone.png"},
            {name = "Pistol Ammo", item = "pistol_ammo", amount = 50, rarity = "Uncommon", image = "pistol_ammo.png"},
            -- Rare (10% chance)
            {name = "Basic Drill", item = "basicdrill", amount = 1, rarity = "Rare", image = "basicdrill.png"},
            {name = "Basic Decrypter", item = "basicdecrypter", amount = 1, rarity = "Rare", image = "basicdecrypter.png"},
            -- Epic (4% chance)
            {name = "Pistol", item = "weapon_pistol", amount = 1, rarity = "Epic", image = "weapon_pistol.png"},
            -- Legendary (1% chance)
            {name = "Combat Pistol", item = "weapon_combatpistol", amount = 1, rarity = "Legendary", image = "weapon_combatpistol.png"},
        }
    },
    ["uncommon_case"] = {
        title = "Uncommon Case",
        description = "Better rewards with improved chances",
        color = "#00ff00",
        image = "images/uncommon_case.png",
        items = {
            -- Common (60% chance)
            {name = "Advanced Lockpick", item = "advancedlockpick", amount = 5, rarity = "Common", image = "advancedlockpick.png"},
            {name = "Pistol Ammo", item = "pistol_ammo", amount = 50, rarity = "Common", image = "pistol_ammo.png"},
            {name = "SMG Ammo", item = "smg_ammo", amount = 30, rarity = "Common", image = "smg_ammo.png"},
            -- Uncommon (25% chance)
            {name = "Basic Drill", item = "basicdrill", amount = 2, rarity = "Uncommon", image = "basicdrill.png"},
            {name = "Basic Decrypter", item = "basicdecrypter", amount = 2, rarity = "Uncommon", image = "basicdecrypter.png"},
            {name = "Phone", item = "phone", amount = 2, rarity = "Uncommon", image = "phone.png"},
            -- Rare (10% chance)
            {name = "Pistol", item = "weapon_pistol", amount = 1, rarity = "Rare", image = "weapon_pistol.png"},
            {name = "Heavy Pistol", item = "weapon_heavypistol", amount = 1, rarity = "Rare", image = "weapon_heavypistol.png"},
            -- Epic (4% chance)
            {name = "Micro SMG", item = "weapon_microsmg", amount = 1, rarity = "Epic", image = "weapon_microsmg.png"},
            {name = "Laptop Green", item = "laptop_green", amount = 1, rarity = "Epic", image = "laptop_green.png"},
            -- Legendary (1% chance)
            {name = "Combat Pistol", item = "weapon_combatpistol", amount = 1, rarity = "Legendary", image = "weapon_combatpistol.png"},
        }
    },
    ["rare_case"] = {
        title = "Rare Case",
        description = "Premium rewards with rare items",
        color = "#0080ff",
        image = "images/diamond_case.png",
        items = {
            -- Common (60% chance)
            {name = "Advanced Lockpick", item = "advancedlockpick", amount = 10, rarity = "Common", image = "advancedlockpick.png"},
            {name = "Pistol Ammo", item = "pistol_ammo", amount = 75, rarity = "Common", image = "pistol_ammo.png"},
            {name = "SMG Ammo", item = "smg_ammo", amount = 50, rarity = "Common", image = "smg_ammo.png"},
            -- Uncommon (25% chance)
            {name = "Advanced Drill", item = "advanceddrill", amount = 1, rarity = "Uncommon", image = "advanceddrill.png"},
            {name = "Advanced Decrypter", item = "advanceddecrypter", amount = 1, rarity = "Uncommon", image = "advanceddecrypter.png"},
            {name = "Heavy Armor", item = "heavyarmor", amount = 2, rarity = "Uncommon", image = "heavyarmor.png"},
            -- Rare (10% chance)
            {name = "Micro SMG", item = "weapon_microsmg", amount = 1, rarity = "Rare", image = "weapon_microsmg.png"},
            {name = "SMG", item = "weapon_smg", amount = 1, rarity = "Rare", image = "weapon_smg.png"},
            {name = "Laptop Green", item = "laptop_green", amount = 1, rarity = "Rare", image = "laptop_green.png"},
            -- Epic (4% chance)
            {name = "Assault SMG", item = "weapon_assaultsmg", amount = 1, rarity = "Epic", image = "weapon_assaultsmg.png"},
            {name = "Pump Shotgun", item = "weapon_pumpshotgun", amount = 1, rarity = "Epic", image = "weapon_pumpshotgun.png"},
            -- Legendary (1% chance)
            {name = "Laptop Blue", item = "laptop_blue", amount = 1, rarity = "Legendary", image = "laptop_blue.png"},
        }
    },
    ["epic_case"] = {
        title = "Epic Case",
        description = "High-tier rewards with epic weapons",
        color = "#8000ff",
        image = "images/epic_case.png",
        items = {
            -- Common (60% chance)
            {name = "SMG Ammo", item = "smg_ammo", amount = 75, rarity = "Common", image = "smg_ammo.png"},
            {name = "Rifle Ammo", item = "rifle_ammo", amount = 50, rarity = "Common", image = "rifle_ammo.png"},
            {name = "Heavy Armor", item = "heavyarmor", amount = 5, rarity = "Common", image = "heavyarmor.png"},
            -- Uncommon (25% chance)
            {name = "Advanced Drill", item = "advanceddrill", amount = 2, rarity = "Uncommon", image = "advanceddrill.png"},
            {name = "Advanced Decrypter", item = "advanceddecrypter", amount = 2, rarity = "Uncommon", image = "advanceddecrypter.png"},
            {name = "Jammer", item = "jammer", amount = 1, rarity = "Uncommon", image = "jammer.png"},
            -- Rare (10% chance)
            {name = "Assault SMG", item = "weapon_assaultsmg", amount = 1, rarity = "Rare", image = "weapon_assaultsmg.png"},
            {name = "Pump Shotgun Mk2", item = "weapon_pumpshotgun_mk2", amount = 1, rarity = "Rare", image = "weapon_pumpshotgun_mk2.png"},
            {name = "Laptop Blue", item = "laptop_blue", amount = 1, rarity = "Rare", image = "laptop_blue.png"},
            -- Epic (4% chance)
            {name = "Assault Rifle", item = "weapon_assaultrifle", amount = 1, rarity = "Epic", image = "weapon_assaultrifle.png"},
            {name = "AK-47", item = "weapon_ak47", amount = 1, rarity = "Epic", image = "weapon_ak47.png"},
            -- Legendary (1% chance)
            {name = "Hardened Drill", item = "hardeneddrill", amount = 1, rarity = "Legendary", image = "hardeneddrill.png"},
        }
    },
    ["legendary_case"] = {
        title = "Legendary Case",
        description = "Ultimate rewards with legendary weapons",
        color = "#ff8000",
        image = "images/legendary_case.png",
        items = {
            -- Common (60% chance)
            {name = "Rifle Ammo", item = "rifle_ammo", amount = 100, rarity = "Common", image = "rifle_ammo.png"},
            {name = "Heavy Armor", item = "heavyarmor", amount = 10, rarity = "Common", image = "heavyarmor.png"},
            {name = "Jammer", item = "jammer", amount = 2, rarity = "Common", image = "jammer.png"},
            -- Uncommon (25% chance)
            {name = "Hardened Drill", item = "hardeneddrill", amount = 1, rarity = "Uncommon", image = "hardeneddrill.png"},
            {name = "Hardened Decrypter", item = "hardeneddecrypter", amount = 1, rarity = "Uncommon", image = "hardeneddecrypter.png"},
            {name = "Disruptor", item = "disruptor", amount = 1, rarity = "Uncommon", image = "disruptor.png"},
            -- Rare (10% chance)
            {name = "Assault Rifle", item = "weapon_assaultrifle", amount = 1, rarity = "Rare", image = "weapon_assaultrifle.png"},
            {name = "AK-47", item = "weapon_ak47", amount = 1, rarity = "Rare", image = "weapon_ak47.png"},
            {name = "Bullpup Rifle", item = "weapon_bullpuprifle", amount = 1, rarity = "Rare", image = "weapon_bullpuprifle.png"},
            -- Epic (4% chance)
            {name = "Assault Rifle Mk2", item = "weapon_assaultrifle_mk2", amount = 1, rarity = "Epic", image = "weapon_assaultrifle_mk2.png"},
            {name = "Military Rifle", item = "weapon_militaryrifle", amount = 1, rarity = "Epic", image = "weapon_militaryrifle.png"},
            {name = "Laptop Red", item = "laptop_red", amount = 1, rarity = "Epic", image = "laptop_red.png"},
            -- Legendary (1% chance)
            {name = "Heavy Rifle", item = "weapon_heavyrifle", amount = 1, rarity = "Legendary", image = "weapon_heavyrifle.png"},
        }
    },
    ["diamond_case"] = {
        title = "Diamond Case",
        description = "Ultimate premium rewards with exclusive items",
        color = "#00ffff",
        image = "images/diamond_case.png",
        items = {
            -- Common (60% chance)
            {name = "Rifle Ammo", item = "rifle_ammo", amount = 150, rarity = "Common", image = "rifle_ammo.png"},
            {name = "Heavy Armor", item = "heavyarmor", amount = 15, rarity = "Common", image = "heavyarmor.png"},
            {name = "Jammer", item = "jammer", amount = 3, rarity = "Common", image = "jammer.png"},
            -- Uncommon (25% chance)
            {name = "Hardened Drill", item = "hardeneddrill", amount = 2, rarity = "Uncommon", image = "hardeneddrill.png"},
            {name = "Hardened Decrypter", item = "hardeneddecrypter", amount = 2, rarity = "Uncommon", image = "hardeneddecrypter.png"},
            {name = "Disruptor", item = "disruptor", amount = 2, rarity = "Uncommon", image = "disruptor.png"},
            -- Rare (10% chance)
            {name = "Assault Rifle Mk2", item = "weapon_assaultrifle_mk2", amount = 1, rarity = "Rare", image = "weapon_assaultrifle_mk2.png"},
            {name = "Bullpup Rifle Mk2", item = "weapon_bullpuprifle_mk2", amount = 1, rarity = "Rare", image = "weapon_bullpuprifle_mk2.png"},
            {name = "Laptop Red", item = "laptop_red", amount = 1, rarity = "Rare", image = "laptop_red.png"},
            -- Epic (4% chance)
            {name = "Military Rifle", item = "weapon_militaryrifle", amount = 1, rarity = "Epic", image = "weapon_militaryrifle.png"},
            {name = "Heavy Rifle", item = "weapon_heavyrifle", amount = 1, rarity = "Epic", image = "weapon_heavyrifle.png"},
            {name = "Tactical Rifle", item = "weapon_tacticalrifle", amount = 1, rarity = "Epic", image = "weapon_tacticalrifle.png"},
            -- Legendary (1% chance)
            {name = "AR-15", item = "weapon_ar15", amount = 1, rarity = "Legendary", image = "weapon_ar15.png"},
        }
    },
    ["knife_case"] = {
        title = "Knife Case",
        description = "A case containing various rare and exclusive CS:GO knives (Karambit, M9 Bayonet, Butterfly)",
        color = "#ff6b00",
        image = "images/knife_case.png",
        items = {
            -- Common Knives (40% chance total) - Basic/Common skins across all knife types
            {name = "Karambit Forest", item = "weapon_karambit_forest", amount = 1, rarity = "Common", image = "WEAPON_KARAMBIT_FOREST.png"},
            {name = "Karambit Urban Masked", item = "weapon_karambit_urbanmasked", amount = 1, rarity = "Common", image = "WEAPON_KARAMBIT_URBANMASKED.png"},
            {name = "Karambit Safari Mesh", item = "weapon_karambit_safarimesh", amount = 1, rarity = "Common", image = "WEAPON_KARAMBIT_SAFARIMESH.png"},
            {name = "Karambit Scorched", item = "weapon_karambit_scorched", amount = 1, rarity = "Common", image = "WEAPON_KARAMBIT_SCORCHED.png"},
            {name = "Karambit Stained", item = "weapon_karambit_stained", amount = 1, rarity = "Common", image = "WEAPON_KARAMBIT_STAINED.png"},
            {name = "Karambit Rust Coat", item = "weapon_karambit_rustcoat", amount = 1, rarity = "Common", image = "WEAPON_KARAMBIT_RUSTCOAT.png"},
            {name = "M9 Bayonet Safari Mesh", item = "weapon_m9_safarimesh", amount = 1, rarity = "Common", image = "WEAPON_M9_SAFARIMESH.png"},
            {name = "M9 Bayonet Scorched", item = "weapon_m9_scorched", amount = 1, rarity = "Common", image = "WEAPON_M9_SCORCHED.png"},
            {name = "M9 Bayonet Stained", item = "weapon_m9_stained", amount = 1, rarity = "Common", image = "WEAPON_M9_STAINED.png"},
            {name = "M9 Bayonet Urban Masked", item = "weapon_m9_urbanmasked", amount = 1, rarity = "Common", image = "WEAPON_M9_URBANMASKED.png"},
            {name = "Butterfly Forest", item = "weapon_bf_forest", amount = 1, rarity = "Common", image = "WEAPON_BF_FOREST.png"},
            {name = "Butterfly Safari Mesh", item = "weapon_bf_safarimesh", amount = 1, rarity = "Common", image = "WEAPON_BF_SAFARIMESH.png"},
            {name = "Butterfly Scorched", item = "weapon_bf_scorched", amount = 1, rarity = "Common", image = "WEAPON_BF_SCORCHED.png"},
            {name = "Butterfly Stained", item = "weapon_bf_stained", amount = 1, rarity = "Common", image = "WEAPON_BF_STAINED.png"},
            {name = "Butterfly Urban Masked", item = "weapon_bf_urbanmasked", amount = 1, rarity = "Common", image = "WEAPON_BF_URBANMASKED.png"},
            {name = "Butterfly Rust Coat", item = "weapon_bf_rustcoat", amount = 1, rarity = "Common", image = "WEAPON_BF_RUSTCOAT.png"},
            
            -- Uncommon Knives (30% chance total) - Mid-tier skins based on CS:GO market pricing
            {name = "Karambit Boreal Forest", item = "weapon_karambit_borealforest", amount = 1, rarity = "Uncommon", image = "WEAPON_KARAMBIT_BOREALFOREST.png"},
            {name = "Karambit Night", item = "weapon_karambit_night", amount = 1, rarity = "Uncommon", image = "WEAPON_KARAMBIT_NIGHT.png"},
            {name = "Karambit Blue Steel", item = "weapon_karambit_bluesteel", amount = 1, rarity = "Uncommon", image = "WEAPON_KARAMBIT_BLUESTEEL.png"},
            {name = "Karambit Black Laminate", item = "weapon_karambit_blacklaminate", amount = 1, rarity = "Uncommon", image = "WEAPON_KARAMBIT_BLACKLAMINATE.png"},
            {name = "Karambit Damascus Steel", item = "weapon_karambit_damascussteel", amount = 1, rarity = "Uncommon", image = "WEAPON_KARAMBIT_DAMASCUSSTEEL.png"},
            {name = "M9 Bayonet Boreal Forest", item = "weapon_m9_borealforest", amount = 1, rarity = "Uncommon", image = "WEAPON_KARAMBIT_BOREALFOREST.png"},
            {name = "M9 Bayonet Night", item = "weapon_m9_night", amount = 1, rarity = "Uncommon", image = "WEAPON_KARAMBIT_NIGHT.png"},
            {name = "M9 Bayonet Blue Steel", item = "weapon_m9_bluesteel", amount = 1, rarity = "Uncommon", image = "WEAPON_M9_BLUESTEEL.png"},
            {name = "M9 Bayonet Black Laminate", item = "weapon_m9_blacklaminate", amount = 1, rarity = "Uncommon", image = "WEAPON_M9_BLACKLAMINATE.png"},
            {name = "M9 Bayonet Damascus Steel", item = "weapon_m9_damascussteel", amount = 1, rarity = "Uncommon", image = "WEAPON_M9_DAMASCUSSTEEL.png"},
            {name = "Butterfly Boreal Forest", item = "weapon_bf_borealforest", amount = 1, rarity = "Uncommon", image = "WEAPON_BF_BOREALFOREST.png"},
            {name = "Butterfly Night", item = "weapon_bf_night", amount = 1, rarity = "Uncommon", image = "WEAPON_BF_NIGHT.png"},
            {name = "Butterfly Blue Steel", item = "weapon_bf_bluesteel", amount = 1, rarity = "Uncommon", image = "WEAPON_BF_BLUESTEEL.png"},
            {name = "Butterfly Black Laminate", item = "weapon_bf_blacklaminate", amount = 1, rarity = "Uncommon", image = "WEAPON_KARAMBIT_BLACKLAMINATE.png"},
            {name = "Butterfly Damascus Steel", item = "weapon_bf_damascussteel", amount = 1, rarity = "Uncommon", image = "WEAPON_BF_DAMASCUSSTEEL.png"},
            
            -- Rare Knives (20% chance total) - Higher tier skins (mid-high value)
            {name = "Karambit Crimson Web", item = "weapon_karambit_crimsonweb", amount = 1, rarity = "Rare", image = "WEAPON_KARAMBIT_CRIMSONWEB.png"},
            {name = "Karambit Case Hardened", item = "weapon_karambit_casehardened", amount = 1, rarity = "Rare", image = "WEAPON_KARAMBIT_CASEHARDENED.png"},
            {name = "Karambit Autotronic", item = "weapon_karambit_autotronic", amount = 1, rarity = "Rare", image = "WEAPON_KARAMBIT_AUTOTRONIC.png"},
            {name = "Karambit Bright Water", item = "weapon_karambit_brightwater", amount = 1, rarity = "Rare", image = "WEAPON_KARAMBIT_BRIGHTWATER.png"},
            {name = "Karambit Ultra Violet", item = "weapon_karambit_ultraviolet", amount = 1, rarity = "Rare", image = "WEAPON_KARAMBIT_ULTRAVIOLET.png"},
            {name = "M9 Bayonet Crimson Web", item = "weapon_m9_crimsonweb", amount = 1, rarity = "Rare", image = "WEAPON_M9_CRIMSONWEB.png"},
            {name = "M9 Bayonet Case Hardened", item = "weapon_m9_casehardened", amount = 1, rarity = "Rare", image = "WEAPON_M9_CASEHARDENED.png"},
            {name = "M9 Bayonet Autotronic", item = "weapon_m9_autotronic", amount = 1, rarity = "Rare", image = "WEAPON_M9_AUTOTRONIC.png"},
            {name = "M9 Bayonet Bright Water", item = "weapon_m9_brightwater", amount = 1, rarity = "Rare", image = "WEAPON_M9_BRIGHTWATER.png"},
            {name = "M9 Bayonet Ultra Violet", item = "weapon_m9_ultraviolet", amount = 1, rarity = "Rare", image = "WEAPON_M9_ULTRAVIOLET.png"},
            {name = "Butterfly Crimson Web", item = "weapon_bf_crimsonweb", amount = 1, rarity = "Rare", image = "WEAPON_BF_CRIMSONWEB.png"},
            {name = "Butterfly Case Hardened", item = "weapon_bf_casehardened", amount = 1, rarity = "Rare", image = "WEAPON_BF_CASEHARDENED.png"},
            {name = "Butterfly Autotronic", item = "weapon_bf_autotronic", amount = 1, rarity = "Rare", image = "WEAPON_KARAMBIT_AUTOTRONIC.png"},
            {name = "Butterfly Bright Water", item = "weapon_bf_brightwater", amount = 1, rarity = "Rare", image = "WEAPON_BF_BRIGHTWATER.png"},
            {name = "Butterfly Ultra Violet", item = "weapon_bf_ultraviolet", amount = 1, rarity = "Rare", image = "WEAPON_BF_ULTRAVIOLET.png"},
            
            -- Epic Knives (7% chance total) - Very rare and expensive skins
            {name = "Karambit Slaughter", item = "weapon_karambit_slaugther", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_SLAUGTHER.png"},
            {name = "Karambit Free Hand", item = "weapon_karambit_freehand", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_FREEHAND.png"},
            {name = "Karambit Tiger Tooth", item = "weapon_karambit_tigertooth", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_TIGERTOOTH.png"},
            {name = "Karambit Doppler Phase 1", item = "weapon_karambit_dopplerphase1", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_DOPPLERPHASE1.png"},
            {name = "Karambit Doppler Phase 2", item = "weapon_karambit_dopplerphase2", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_DOPPLERPHASE2.png"},
            {name = "Karambit Doppler Phase 3", item = "weapon_karambit_dopplerphase3", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_DOPPLERPHASE3.png"},
            {name = "Karambit Doppler Phase 4", item = "weapon_karambit_dopplerphase4", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_DOPPLERPHASE4.png"},
            {name = "Karambit Marble Fade", item = "weapon_karambit_marblefade", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_MARBLEFADE.png"},
            {name = "Karambit Fade", item = "weapon_karambit_fade", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_FADE.png"},
            {name = "Karambit Lore", item = "weapon_karambit_lore", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_LORE.png"},
            {name = "Karambit Gamma Doppler Phase 1", item = "weapon_karambit_gdp1", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_GDP1.png"},
            {name = "Karambit Gamma Doppler Phase 2", item = "weapon_karambit_gdp2", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_GDP2.png"},
            {name = "Karambit Gamma Doppler Phase 3", item = "weapon_karambit_gdp3", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_GDP3.png"},
            {name = "Karambit Gamma Doppler Phase 4", item = "weapon_karambit_gdp4", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_GDP4.png"},
            {name = "M9 Bayonet Slaughter", item = "weapon_m9_slaugther", amount = 1, rarity = "Epic", image = "WEAPON_M9_SLAUGTHER.png"},
            {name = "M9 Bayonet Free Hand", item = "weapon_m9_freehand", amount = 1, rarity = "Epic", image = "WEAPON_M9_FREEHAND.png"},
            {name = "M9 Bayonet Tiger Tooth", item = "weapon_m9_tigertooth", amount = 1, rarity = "Epic", image = "WEAPON_M9_TIGERTOOTH.png"},
            {name = "M9 Bayonet Doppler Phase 1", item = "weapon_m9_dopplerp1", amount = 1, rarity = "Epic", image = "WEAPON_M9_DOPPLERP1.png"},
            {name = "M9 Bayonet Doppler Phase 2", item = "weapon_m9_dopplerp2", amount = 1, rarity = "Epic", image = "WEAPON_M9_DOPPLERP2.png"},
            {name = "M9 Bayonet Doppler Phase 3", item = "weapon_m9_dopplerp3", amount = 1, rarity = "Epic", image = "WEAPON_M9_DOPPLERP3.png"},
            {name = "M9 Bayonet Doppler Phase 4", item = "weapon_m9_dopplerp4", amount = 1, rarity = "Epic", image = "WEAPON_M9_DOPPLERP4.png"},
            {name = "M9 Bayonet Marble Fade", item = "weapon_m9_marblefade", amount = 1, rarity = "Epic", image = "WEAPON_M9_MARBLEFADE.png"},
            {name = "M9 Bayonet Fade", item = "weapon_m9_fade", amount = 1, rarity = "Epic", image = "WEAPON_M9_FADE.png"},
            {name = "M9 Bayonet Lore", item = "weapon_m9_lore", amount = 1, rarity = "Epic", image = "WEAPON_M9_LORE.png"},
            {name = "M9 Bayonet Gamma Doppler Phase 1", item = "weapon_m9_gdp1", amount = 1, rarity = "Epic", image = "WEAPON_M9_GDP1.png"},
            {name = "M9 Bayonet Gamma Doppler Phase 2", item = "weapon_m9_gdp2", amount = 1, rarity = "Epic", image = "WEAPON_M9_GDP2.png"},
            {name = "M9 Bayonet Gamma Doppler Phase 3", item = "weapon_m9_gdp3", amount = 1, rarity = "Epic", image = "WEAPON_M9_GDP3.png"},
            {name = "M9 Bayonet Gamma Doppler Phase 4", item = "weapon_m9_gdp4", amount = 1, rarity = "Epic", image = "WEAPON_M9_GDP4.png"},
            {name = "Butterfly Slaughter", item = "weapon_bf_slaugther", amount = 1, rarity = "Epic", image = "WEAPON_BF_SLAUGTHER.png"},
            {name = "Butterfly Free Hand", item = "weapon_bf_freehand", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_FREEHAND.png"},
            {name = "Butterfly Tiger Tooth", item = "weapon_bf_tigertooth", amount = 1, rarity = "Epic", image = "WEAPON_BF_TIGERTOOTH.png"},
            {name = "Butterfly Doppler Phase 1", item = "weapon_bf_dopplerphase1", amount = 1, rarity = "Epic", image = "WEAPON_BF_DOPPLERPHASE1.png"},
            {name = "Butterfly Doppler Phase 2", item = "weapon_bf_dopplerphase2", amount = 1, rarity = "Epic", image = "WEAPON_BF_DOPPLERPHASE2.png"},
            {name = "Butterfly Doppler Phase 3", item = "weapon_bf_dopplerphase3", amount = 1, rarity = "Epic", image = "WEAPON_BF_DOPPLERPHASE3.png"},
            {name = "Butterfly Doppler Phase 4", item = "weapon_bf_dopplerphase4", amount = 1, rarity = "Epic", image = "WEAPON_BF_DOPPLERPHASE4.png"},
            {name = "Butterfly Marble Fade", item = "weapon_bf_marblefade", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_MARBLEFADE.png"},
            {name = "Butterfly Fade", item = "weapon_bf_fade", amount = 1, rarity = "Epic", image = "WEAPON_BF_FADE.png"},
            {name = "Butterfly Lore", item = "weapon_bf_lore", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_LORE.png"},
            {name = "Butterfly Gamma Doppler Phase 1", item = "weapon_bf_gdp1", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_GDP1.png"},
            {name = "Butterfly Gamma Doppler Phase 2", item = "weapon_bf_gdp2", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_GDP2.png"},
            {name = "Butterfly Gamma Doppler Phase 3", item = "weapon_bf_gdp3", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_GDP3.png"},
            {name = "Butterfly Gamma Doppler Phase 4", item = "weapon_bf_gdp4", amount = 1, rarity = "Epic", image = "WEAPON_KARAMBIT_GDP4.png"},
            
            -- Legendary Knives (3% chance total) - Ultra rare gem finishes (Ruby, Sapphire, Emerald, Black Pearl)
            {name = "Karambit Doppler BlackPearl", item = "weapon_karambit_dopplerblackpearl", amount = 1, rarity = "Legendary", image = "WEAPON_KARAMBIT_BLACKPEARL.png"},
            {name = "Karambit Doppler Ruby", item = "weapon_karambit_dopplerruby", amount = 1, rarity = "Legendary", image = "WEAPON_KARAMBIT_DOPPLERRUBY.png"},
            {name = "Karambit Doppler Sapphire", item = "weapon_karambit_dopplersapphire", amount = 1, rarity = "Legendary", image = "WEAPON_KARAMBIT_DOPPLERSAPPHIRE.png"},
            {name = "Karambit Gamma Doppler Emerald", item = "weapon_karambit_gdemerald", amount = 1, rarity = "Legendary", image = "WEAPON_KARAMBIT_GDEMERALD.png"},
            {name = "M9 Bayonet Doppler BlackPearl", item = "weapon_m9_dopplerblackpearl", amount = 1, rarity = "Legendary", image = "WEAPON_M9_DOPPLERBLACKPEARL.png"},
            {name = "M9 Bayonet Doppler Ruby", item = "weapon_m9_dopplerruby", amount = 1, rarity = "Legendary", image = "WEAPON_M9_DOPPLERRUBY.png"},
            {name = "M9 Bayonet Doppler Sapphire", item = "weapon_m9_dopplersapphire", amount = 1, rarity = "Legendary", image = "WEAPON_M9_DOPPLERSAPPHIRE.png"},
            {name = "M9 Bayonet Gamma Doppler Emerald", item = "weapon_m9_gdemerald", amount = 1, rarity = "Legendary", image = "WEAPON_M9_GDEMERALD.png"},
            {name = "Butterfly Doppler BlackPearl", item = "weapon_bf_dopplerblackpearl", amount = 1, rarity = "Legendary", image = "WEAPON_BF_DOPPLERBLACKPEARL.png"},
            {name = "Butterfly Doppler Ruby", item = "weapon_bf_dopplerruby", amount = 1, rarity = "Legendary", image = "WEAPON_BF_DOPPLERRUBY.png"},
            {name = "Butterfly Doppler Sapphire", item = "weapon_bf_dopplersapphire", amount = 1, rarity = "Legendary", image = "WEAPON_BF_DOPPLERSAPPHIRE.png"},
            {name = "Butterfly Gamma Doppler Emerald", item = "weapon_bf_gdemerald", amount = 1, rarity = "Legendary", image = "WEAPON_KARAMBIT_GDEMERALD.png"},
        }
    }
}

-- Notification function
function CFG.ChatNotify(message)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="background: linear-gradient(45deg, #ff6b6b, #4ecdc4); padding: 10px; border-radius: 8px; margin: 5px 0; box-shadow: 0 4px 8px rgba(0,0,0,0.3);"><b style="color: white; text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">🎁 OLRP Loot Cases</b><br><span style="color: white; text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">{0}</span></div>',
        args = {message}
    })
end

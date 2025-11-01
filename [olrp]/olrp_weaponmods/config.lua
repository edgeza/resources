-- Stitch Weapon Mods Configuration
-- Comprehensive weapon damage control system for FiveM
-- https://docs.fivem.net/natives/?_0x4757F00BC6323CFE

Config = {}

-- Damage modifier values:
-- 0.0 = No damage (weapon disabled)
-- 0.1 = Very low damage (10% of original)
-- 0.5 = Half damage (50% of original)
-- 1.0 = Normal damage (100% of original)
-- 2.0 = Double damage (200% of original)

-- Critical hit settings:
-- true = Disable critical hits for this weapon
-- false = Allow critical hits for this weapon

Config.Weapons = {
    -- =============================================
    -- MELEE WEAPONS
    -- =============================================
    [`weapon_unarmed`] = {model = `weapon_unarmed`, modifier = 1.0, disableCritical = true},
    [`weapon_dagger`] = {model = `weapon_dagger`, modifier = 1.0, disableCritical = false},
    [`weapon_bat`] = {model = `weapon_bat`, modifier = 1.0, disableCritical = true},
    [`weapon_bottle`] = {model = `weapon_bottle`, modifier = 1.0, disableCritical = false},
    [`weapon_crowbar`] = {model = `weapon_crowbar`, modifier = 1.0, disableCritical = true},
    [`weapon_flashlight`] = {model = `weapon_flashlight`, modifier = 1.0, disableCritical = true},
    [`weapon_golfclub`] = {model = `weapon_golfclub`, modifier = 1.0, disableCritical = true},
    [`weapon_hammer`] = {model = `weapon_hammer`, modifier = 1.0, disableCritical = true},
    [`weapon_hatchet`] = {model = `weapon_hatchet`, modifier = 1.0, disableCritical = false},
    [`weapon_knuckle`] = {model = `weapon_knuckle`, modifier = 1.0, disableCritical = true},
    [`weapon_knife`] = {model = `weapon_knife`, modifier = 1.0, disableCritical = false},
    [`weapon_machete`] = {model = `weapon_machete`, modifier = 1.0, disableCritical = false},
    [`weapon_switchblade`] = {model = `weapon_switchblade`, modifier = 1.0, disableCritical = false},
    [`weapon_nightstick`] = {model = `weapon_nightstick`, modifier = 1.0, disableCritical = true},
    [`weapon_wrench`] = {model = `weapon_wrench`, modifier = 1.0, disableCritical = true},
    [`weapon_battleaxe`] = {model = `weapon_battleaxe`, modifier = 1.0, disableCritical = false},
    [`weapon_poolcue`] = {model = `weapon_poolcue`, modifier = 1.0, disableCritical = true},
    [`weapon_briefcase`] = {model = `weapon_briefcase`, modifier = 1.0, disableCritical = true},
    [`weapon_briefcase_02`] = {model = `weapon_briefcase_02`, modifier = 1.0, disableCritical = true},
    [`weapon_garbagebag`] = {model = `weapon_garbagebag`, modifier = 1.0, disableCritical = true},
    [`weapon_handcuffs`] = {model = `weapon_handcuffs`, modifier = 0.0, disableCritical = true},
    [`weapon_bread`] = {model = `weapon_bread`, modifier = 1.0, disableCritical = true},
    [`weapon_stone_hatchet`] = {model = `weapon_stone_hatchet`, modifier = 1.0, disableCritical = false},
    [`weapon_candycane`] = {model = `weapon_candycane`, modifier = 1.0, disableCritical = true},
    [`weapon_axe`] = {model = `weapon_axe`, modifier = 1.0, disableCritical = false},
    [`weapon_chair`] = {model = `weapon_chair`, modifier = 1.0, disableCritical = true},

    -- CS:GO Knives - Karambit
    [`weapon_karambit_forest`] = {model = `weapon_karambit_forest`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_safarimesh`] = {model = `weapon_karambit_safarimesh`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_borealforest`] = {model = `weapon_karambit_borealforest`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_scorched`] = {model = `weapon_karambit_scorched`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_urbanmasked`] = {model = `weapon_karambit_urbanmasked`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_rustcoat`] = {model = `weapon_karambit_rustcoat`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_night`] = {model = `weapon_karambit_night`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_stained`] = {model = `weapon_karambit_stained`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_ultraviolet`] = {model = `weapon_karambit_ultraviolet`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_brightwater`] = {model = `weapon_karambit_brightwater`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_crimsonweb`] = {model = `weapon_karambit_crimsonweb`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_freehand`] = {model = `weapon_karambit_freehand`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_damascussteel`] = {model = `weapon_karambit_damascussteel`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_casehardend`] = {model = `weapon_karambit_casehardend`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_bluesteel`] = {model = `weapon_karambit_bluesteel`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_lore`] = {model = `weapon_karambit_lore`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_blacklaminated`] = {model = `weapon_karambit_blacklaminated`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_slaughter`] = {model = `weapon_karambit_slaughter`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_tigertooth`] = {model = `weapon_karambit_tigertooth`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_dopplerphase1`] = {model = `weapon_karambit_dopplerphase1`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_dopplerphase3`] = {model = `weapon_karambit_dopplerphase3`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_autotronic`] = {model = `weapon_karambit_autotronic`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_marblefade`] = {model = `weapon_karambit_marblefade`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_dopplerphase2`] = {model = `weapon_karambit_dopplerphase2`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_dopplerphase4`] = {model = `weapon_karambit_dopplerphase4`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_gdp1`] = {model = `weapon_karambit_gdp1`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_gdp3`] = {model = `weapon_karambit_gdp3`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_gdp4`] = {model = `weapon_karambit_gdp4`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_fade`] = {model = `weapon_karambit_fade`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_gdp2`] = {model = `weapon_karambit_gdp2`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_blackpearl`] = {model = `weapon_karambit_blackpearl`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_dopplerruby`] = {model = `weapon_karambit_dopplerruby`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_gdemerald`] = {model = `weapon_karambit_gdemerald`, modifier = 1.0, disableCritical = false},
    [`weapon_karambit_dopplersapphire`] = {model = `weapon_karambit_dopplersapphire`, modifier = 1.0, disableCritical = false},

    -- CS:GO Knives - Butterfly
    [`weapon_bf_scorched`] = {model = `weapon_bf_scorched`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_safarimesh`] = {model = `weapon_bf_safarimesh`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_urbanmasked`] = {model = `weapon_bf_urbanmasked`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_forest`] = {model = `weapon_bf_forest`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_borealforest`] = {model = `weapon_bf_borealforest`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_ultraviolet`] = {model = `weapon_bf_ultraviolet`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_night`] = {model = `weapon_bf_night`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_stained`] = {model = `weapon_bf_stained`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_rustcoat`] = {model = `weapon_bf_rustcoat`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_casehardend`] = {model = `weapon_bf_casehardend`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_bluesteel`] = {model = `weapon_bf_bluesteel`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_crimsonweb`] = {model = `weapon_bf_crimsonweb`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_damascussteel`] = {model = `weapon_bf_damascussteel`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_slaughter`] = {model = `weapon_bf_slaughter`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_tigertooth`] = {model = `weapon_bf_tigertooth`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_dopplerphase3`] = {model = `weapon_bf_dopplerphase3`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_dopplerphase1`] = {model = `weapon_bf_dopplerphase1`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_dopplerphase2`] = {model = `weapon_bf_dopplerphase2`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_fade`] = {model = `weapon_bf_fade`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_dopplerphase4`] = {model = `weapon_bf_dopplerphase4`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_dopplerblackpearl`] = {model = `weapon_bf_dopplerblackpearl`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_dopplerruby`] = {model = `weapon_bf_dopplerruby`, modifier = 1.0, disableCritical = false},
    [`weapon_bf_dopplersapphire`] = {model = `weapon_bf_dopplersapphire`, modifier = 1.0, disableCritical = false},

    -- CS:GO Knives - Bayonet
    [`weapon_m9_safarimesh`] = {model = `weapon_m9_safarimesh`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_urbanmasked`] = {model = `weapon_m9_urbanmasked`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_scorched`] = {model = `weapon_m9_scorched`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_stained`] = {model = `weapon_m9_stained`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_ultraviolet`] = {model = `weapon_m9_ultraviolet`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_brightwater`] = {model = `weapon_m9_brightwater`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_crimsonweb`] = {model = `weapon_m9_crimsonweb`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_freehand`] = {model = `weapon_m9_freehand`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_damascussteel`] = {model = `weapon_m9_damascussteel`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_casehardend`] = {model = `weapon_m9_casehardend`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_bluesteel`] = {model = `weapon_m9_bluesteel`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_lore`] = {model = `weapon_m9_lore`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_blacklaminate`] = {model = `weapon_m9_blacklaminate`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_slaughter`] = {model = `weapon_m9_slaughter`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_tigertooth`] = {model = `weapon_m9_tigertooth`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_doppler1`] = {model = `weapon_m9_doppler1`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_doppler3`] = {model = `weapon_m9_doppler3`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_autotronic`] = {model = `weapon_m9_autotronic`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_marblefade`] = {model = `weapon_m9_marblefade`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_doppler2`] = {model = `weapon_m9_doppler2`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_doppler4`] = {model = `weapon_m9_doppler4`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_gdp1`] = {model = `weapon_m9_gdp1`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_gdp3`] = {model = `weapon_m9_gdp3`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_gdp4`] = {model = `weapon_m9_gdp4`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_fade`] = {model = `weapon_m9_fade`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_gdp2`] = {model = `weapon_m9_gdp2`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_dopplerblackpearl`] = {model = `weapon_m9_dopplerblackpearl`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_dopplerruby`] = {model = `weapon_m9_dopplerruby`, modifier = 1.0, disableCritical = false},
    [`weapon_m9_gdemerald`] = {model = `weapon_m9_gdemerald`, modifier = 1.0, disableCritical = false},
    [`waeapon_m9_dopplersapphire`] = {model = `waeapon_m9_dopplersapphire`, modifier = 1.0, disableCritical = false},

    -- =============================================
    -- PISTOLS
    -- =============================================
    [`weapon_pistol`] = {model = `weapon_pistol`, modifier = 1.0, disableCritical = false},
    [`weapon_pistol_mk2`] = {model = `weapon_pistol_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_combatpistol`] = {model = `weapon_combatpistol`, modifier = 1.0, disableCritical = false},
    [`weapon_appistol`] = {model = `weapon_appistol`, modifier = 1.0, disableCritical = false},
    [`weapon_stungun`] = {model = `weapon_stungun`, modifier = 0.0, disableCritical = true},
    [`weapon_pistol50`] = {model = `weapon_pistol50`, modifier = 1.0, disableCritical = false},
    [`weapon_snspistol`] = {model = `weapon_snspistol`, modifier = 1.0, disableCritical = false},
    [`weapon_snspistol_mk2`] = {model = `weapon_snspistol_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_heavypistol`] = {model = `weapon_heavypistol`, modifier = 1.0, disableCritical = false},
    [`weapon_vintagepistol`] = {model = `weapon_vintagepistol`, modifier = 1.0, disableCritical = false},
    [`weapon_flaregun`] = {model = `weapon_flaregun`, modifier = 1.0, disableCritical = true},
    [`weapon_marksmanpistol`] = {model = `weapon_marksmanpistol`, modifier = 1.0, disableCritical = false},
    [`weapon_revolver`] = {model = `weapon_revolver`, modifier = 0.5, disableCritical = false},
    [`weapon_revolver_mk2`] = {model = `weapon_revolver_mk2`, modifier = 0.5, disableCritical = false},
    [`weapon_doubleaction`] = {model = `weapon_doubleaction`, modifier = 0.5, disableCritical = false},
    [`weapon_raypistol`] = {model = `weapon_raypistol`, modifier = 1.0, disableCritical = false},
    [`weapon_ceramicpistol`] = {model = `weapon_ceramicpistol`, modifier = 1.0, disableCritical = false},
    [`weapon_navyrevolver`] = {model = `weapon_navyrevolver`, modifier = 0.5, disableCritical = false},
    [`weapon_gadgetpistol`] = {model = `weapon_gadgetpistol`, modifier = 1.0, disableCritical = false},
    [`weapon_stungun_mp`] = {model = `weapon_stungun_mp`, modifier = 0.0, disableCritical = true},
    [`weapon_pistolxm3`] = {model = `weapon_pistolxm3`, modifier = 1.0, disableCritical = false},
    [`weapon_paintball`] = {model = `weapon_paintball`, modifier = 0.0, disableCritical = true},
    [`weapon_de`] = {model = `weapon_de`, modifier = 1.0, disableCritical = false},
    [`weapon_m1911`] = {model = `weapon_m1911`, modifier = 1.0, disableCritical = false},

    -- Kyros Weapon Pack Pistols
    [`weapon_blueglocks`] = {model = `weapon_blueglocks`, modifier = 1.0, disableCritical = false},
    [`weapon_fn57`] = {model = `weapon_fn57`, modifier = 1.0, disableCritical = false},
    [`weapon_glock21`] = {model = `weapon_glock21`, modifier = 1.0, disableCritical = false},
    [`weapon_glock41`] = {model = `weapon_glock41`, modifier = 1.0, disableCritical = false},
    [`weapon_glockbeams`] = {model = `weapon_glockbeams`, modifier = 1.0, disableCritical = false},
    [`weapon_p30l`] = {model = `weapon_p30l`, modifier = 1.0, disableCritical = false},
    [`weapon_illglock17`] = {model = `weapon_illglock17`, modifier = 1.0, disableCritical = false},
    [`weapon_mgglock`] = {model = `weapon_mgglock`, modifier = 1.0, disableCritical = false},
    [`weapon_midasglock`] = {model = `weapon_midasglock`, modifier = 1.0, disableCritical = false},
    [`weapon_p210`] = {model = `weapon_p210`, modifier = 1.0, disableCritical = false},
    [`weapon_sr40`] = {model = `weapon_sr40`, modifier = 1.0, disableCritical = false},
    [`weapon_t1911`] = {model = `weapon_t1911`, modifier = 1.0, disableCritical = false},
    [`weapon_tglock19`] = {model = `weapon_tglock19`, modifier = 1.0, disableCritical = false},

    -- =============================================
    -- SUBMACHINE GUNS
    -- =============================================
    [`weapon_microsmg`] = {model = `weapon_microsmg`, modifier = 1.0, disableCritical = false},
    [`weapon_smg`] = {model = `weapon_smg`, modifier = 1.0, disableCritical = false},
    [`weapon_smg_mk2`] = {model = `weapon_smg_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_assaultsmg`] = {model = `weapon_assaultsmg`, modifier = 1.0, disableCritical = false},
    [`weapon_combatpdw`] = {model = `weapon_combatpdw`, modifier = 1.0, disableCritical = false},
    [`weapon_machinepistol`] = {model = `weapon_machinepistol`, modifier = 1.0, disableCritical = false},
    [`weapon_minismg`] = {model = `weapon_minismg`, modifier = 1.0, disableCritical = false},
    [`weapon_raycarbine`] = {model = `weapon_raycarbine`, modifier = 1.0, disableCritical = false},
    [`weapon_mac10`] = {model = `weapon_mac10`, modifier = 1.0, disableCritical = false},
    [`weapon_mp5`] = {model = `weapon_mp5`, modifier = 1.0, disableCritical = false},
    [`weapon_uzi`] = {model = `weapon_uzi`, modifier = 1.0, disableCritical = false},
    [`weapon_krissvector`] = {model = `weapon_krissvector`, modifier = 1.0, disableCritical = false},
    [`weapon_tec9s`] = {model = `weapon_tec9s`, modifier = 1.0, disableCritical = false},

    -- =============================================
    -- SHOTGUNS
    -- =============================================
    [`weapon_pumpshotgun`] = {model = `weapon_pumpshotgun`, modifier = 1.0, disableCritical = false},
    [`weapon_pumpshotgun_mk2`] = {model = `weapon_pumpshotgun_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_sawnoffshotgun`] = {model = `weapon_sawnoffshotgun`, modifier = 1.0, disableCritical = false},
    [`weapon_assaultshotgun`] = {model = `weapon_assaultshotgun`, modifier = 1.0, disableCritical = false},
    [`weapon_bullpupshotgun`] = {model = `weapon_bullpupshotgun`, modifier = 1.0, disableCritical = false},
    [`weapon_musket`] = {model = `weapon_musket`, modifier = 1.0, disableCritical = false},
    [`weapon_heavyshotgun`] = {model = `weapon_heavyshotgun`, modifier = 1.0, disableCritical = false},
    [`weapon_dbshotgun`] = {model = `weapon_dbshotgun`, modifier = 1.0, disableCritical = false},
    [`weapon_autoshotgun`] = {model = `weapon_autoshotgun`, modifier = 1.0, disableCritical = false},
    [`weapon_combatshotgun`] = {model = `weapon_combatshotgun`, modifier = 1.0, disableCritical = false},
    [`weapon_beanbag`] = {model = `weapon_beanbag`, modifier = 0.0, disableCritical = true},
    [`weapon_m500`] = {model = `weapon_m500`, modifier = 1.0, disableCritical = false},
    [`weapon_r590`] = {model = `weapon_r590`, modifier = 1.0, disableCritical = false},

    -- =============================================
    -- ASSAULT RIFLES
    -- =============================================
    [`weapon_assaultrifle`] = {model = `weapon_assaultrifle`, modifier = 1.0, disableCritical = false},
    [`weapon_assaultrifle_mk2`] = {model = `weapon_assaultrifle_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_carbinerifle`] = {model = `weapon_carbinerifle`, modifier = 1.0, disableCritical = false},
    [`weapon_carbinerifle_mk2`] = {model = `weapon_carbinerifle_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_advancedrifle`] = {model = `weapon_advancedrifle`, modifier = 1.0, disableCritical = false},
    [`weapon_specialcarbine`] = {model = `weapon_specialcarbine`, modifier = 1.0, disableCritical = false},
    [`weapon_specialcarbine_mk2`] = {model = `weapon_specialcarbine_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_bullpuprifle`] = {model = `weapon_bullpuprifle`, modifier = 1.0, disableCritical = false},
    [`weapon_bullpuprifle_mk2`] = {model = `weapon_bullpuprifle_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_compactrifle`] = {model = `weapon_compactrifle`, modifier = 1.0, disableCritical = false},
    [`weapon_militaryrifle`] = {model = `weapon_militaryrifle`, modifier = 1.0, disableCritical = false},
    [`weapon_heavyrifle`] = {model = `weapon_heavyrifle`, modifier = 1.0, disableCritical = false},
    [`weapon_ak47m2`] = {model = `weapon_ak47m2`, modifier = 1.0, disableCritical = false},
    [`weapon_famas`] = {model = `weapon_famas`, modifier = 1.0, disableCritical = false},
    [`weapon_hk416`] = {model = `weapon_hk416`, modifier = 1.0, disableCritical = false},

    -- Kyros Weapon Pack Assault Rifles
    [`weapon_bar15`] = {model = `weapon_bar15`, modifier = 1.0, disableCritical = false},
    [`weapon_blackarp`] = {model = `weapon_blackarp`, modifier = 1.0, disableCritical = false},
    [`weapon_bscar`] = {model = `weapon_bscar`, modifier = 1.0, disableCritical = false},
    [`weapon_thompson`] = {model = `weapon_thompson`, modifier = 1.0, disableCritical = false},
    [`weapon_dmk18`] = {model = `weapon_dmk18`, modifier = 1.0, disableCritical = false},
    [`weapon_lbtarp`] = {model = `weapon_lbtarp`, modifier = 1.0, disableCritical = false},
    [`weapon_ram7`] = {model = `weapon_ram7`, modifier = 1.0, disableCritical = false},
    [`weapon_redarp`] = {model = `weapon_redarp`, modifier = 1.0, disableCritical = false},
    [`weapon_redm4a1`] = {model = `weapon_redm4a1`, modifier = 1.0, disableCritical = false},
    [`weapon_tarp`] = {model = `weapon_tarp`, modifier = 1.0, disableCritical = false},
    [`weapon_woarp`] = {model = `weapon_woarp`, modifier = 1.0, disableCritical = false},

    -- =============================================
    -- LIGHT MACHINE GUNS
    -- =============================================
    [`weapon_mg`] = {model = `weapon_mg`, modifier = 1.0, disableCritical = false},
    [`weapon_combatmg`] = {model = `weapon_combatmg`, modifier = 1.0, disableCritical = false},
    [`weapon_combatmg_mk2`] = {model = `weapon_combatmg_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_gusenberg`] = {model = `weapon_gusenberg`, modifier = 1.0, disableCritical = false},

    -- =============================================
    -- SNIPER RIFLES
    -- =============================================
    [`weapon_sniperrifle`] = {model = `weapon_sniperrifle`, modifier = 1.0, disableCritical = false},
    [`weapon_heavysniper`] = {model = `weapon_heavysniper`, modifier = 1.0, disableCritical = false},
    [`weapon_heavysniper_mk2`] = {model = `weapon_heavysniper_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_marksmanrifle`] = {model = `weapon_marksmanrifle`, modifier = 1.0, disableCritical = false},
    [`weapon_marksmanrifle_mk2`] = {model = `weapon_marksmanrifle_mk2`, modifier = 1.0, disableCritical = false},
    [`weapon_remotesniper`] = {model = `weapon_remotesniper`, modifier = 1.0, disableCritical = false},
    [`weapon_huntingrifle`] = {model = `weapon_huntingrifle`, modifier = 1.0, disableCritical = false},
    [`weapon_crossbow`] = {model = `weapon_crossbow`, modifier = 1.0, disableCritical = false},

    -- =============================================
    -- HEAVY WEAPONS
    -- =============================================
    [`weapon_rpg`] = {model = `weapon_rpg`, modifier = 1.0, disableCritical = false},
    [`weapon_grenadelauncher`] = {model = `weapon_grenadelauncher`, modifier = 1.0, disableCritical = false},
    [`weapon_grenadelauncher_smoke`] = {model = `weapon_grenadelauncher_smoke`, modifier = 0.0, disableCritical = true},
    [`weapon_minigun`] = {model = `weapon_minigun`, modifier = 1.0, disableCritical = false},
    [`weapon_firework`] = {model = `weapon_firework`, modifier = 1.0, disableCritical = true},
    [`weapon_railgun`] = {model = `weapon_railgun`, modifier = 1.0, disableCritical = false},
    [`weapon_railgunxm3`] = {model = `weapon_railgunxm3`, modifier = 1.0, disableCritical = false},
    [`weapon_hominglauncher`] = {model = `weapon_hominglauncher`, modifier = 1.0, disableCritical = false},
    [`weapon_compactlauncher`] = {model = `weapon_compactlauncher`, modifier = 1.0, disableCritical = false},
    [`weapon_rayminigun`] = {model = `weapon_rayminigun`, modifier = 1.0, disableCritical = false},
    [`weapon_emplauncher`] = {model = `weapon_emplauncher`, modifier = 0.0, disableCritical = true},

    -- =============================================
    -- THROWABLES
    -- =============================================
    [`weapon_grenade`] = {model = `weapon_grenade`, modifier = 1.0, disableCritical = false},
    [`weapon_bzgas`] = {model = `weapon_bzgas`, modifier = 0.0, disableCritical = true},
    [`weapon_molotov`] = {model = `weapon_molotov`, modifier = 1.0, disableCritical = false},
    [`weapon_stickybomb`] = {model = `weapon_stickybomb`, modifier = 1.0, disableCritical = false},
    [`weapon_proxmine`] = {model = `weapon_proxmine`, modifier = 1.0, disableCritical = false},
    [`weapon_snowball`] = {model = `weapon_snowball`, modifier = 0.0, disableCritical = true},
    [`weapon_pipebomb`] = {model = `weapon_pipebomb`, modifier = 1.0, disableCritical = false},
    [`weapon_ball`] = {model = `weapon_ball`, modifier = 0.0, disableCritical = true},
    [`weapon_smokegrenade`] = {model = `weapon_smokegrenade`, modifier = 0.0, disableCritical = true},
    [`weapon_flare`] = {model = `weapon_flare`, modifier = 0.0, disableCritical = true},

    -- =============================================
    -- MISCELLANEOUS
    -- =============================================
    [`weapon_petrolcan`] = {model = `weapon_petrolcan`, modifier = 0.0, disableCritical = true},
    [`gadget_parachute`] = {model = `gadget_parachute`, modifier = 0.0, disableCritical = true},
    [`weapon_fireextinguisher`] = {model = `weapon_fireextinguisher`, modifier = 0.0, disableCritical = true},
    [`weapon_hazardcan`] = {model = `weapon_hazardcan`, modifier = 0.0, disableCritical = true},
    [`weapon_fertilizercan`] = {model = `weapon_fertilizercan`, modifier = 0.0, disableCritical = true},
    [`weapon_barbed_wire`] = {model = `weapon_barbed_wire`, modifier = 0.0, disableCritical = true},
    [`weapon_drowning`] = {model = `weapon_drowning`, modifier = 1.0, disableCritical = true},
    [`weapon_drowning_in_vehicle`] = {model = `weapon_drowning_in_vehicle`, modifier = 1.0, disableCritical = true},
    [`weapon_bleeding`] = {model = `weapon_bleeding`, modifier = 1.0, disableCritical = true},
    [`weapon_electric_fence`] = {model = `weapon_electric_fence`, modifier = 1.0, disableCritical = true},
    [`weapon_explosion`] = {model = `weapon_explosion`, modifier = 1.0, disableCritical = true},
    [`weapon_fall`] = {model = `weapon_fall`, modifier = 1.0, disableCritical = true},
    [`weapon_exhaustion`] = {model = `weapon_exhaustion`, modifier = 1.0, disableCritical = true},
    [`weapon_hit_by_water_cannon`] = {model = `weapon_hit_by_water_cannon`, modifier = 1.0, disableCritical = true},
    [`weapon_rammed_by_car`] = {model = `weapon_rammed_by_car`, modifier = 1.0, disableCritical = true},
    [`weapon_run_over_by_car`] = {model = `weapon_run_over_by_car`, modifier = 1.0, disableCritical = true},
    [`weapon_heli_crash`] = {model = `weapon_heli_crash`, modifier = 1.0, disableCritical = true},
    [`weapon_fire`] = {model = `weapon_fire`, modifier = 1.0, disableCritical = true},

    -- =============================================
    -- ANIMALS
    -- =============================================
    [`weapon_animal`] = {model = `weapon_animal`, modifier = 1.0, disableCritical = true},
    [`weapon_cougar`] = {model = `weapon_cougar`, modifier = 1.0, disableCritical = true},
}

-- =============================================
-- CONFIGURATION OPTIONS
-- =============================================

-- Enable/disable the weapon damage system
Config.Enabled = true

-- Debug mode (prints weapon changes to console)
Config.Debug = false

-- Update frequency in milliseconds (lower = more responsive, higher = better performance)
-- Recommended: 200ms for 100+ players, 100ms for smaller servers
Config.UpdateFrequency = 200

-- Enable weapon category logging
Config.LogWeaponChanges = false

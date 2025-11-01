Config = {}

Config.ValidWeapons = {
    [`WEAPON_STUNGUN`] = true,
    [`WEAPON_STUNGUN_MP`] = true,
    [`WEAPON_ELECTRIC_FENCE`] = true,
    [`WEAPON_STUNROD`] = true,
    [`WEAPON_BEANBAG`] = true,
}

-- Due to how this is set up it usually won't effect the player ped the first time the get stunned.
Config.MinGroundTime = 20000 -- The minimum time in milliseconds that players will lay on the ground after getting tazed
Config.MaxGroundTime = 35000 -- The maximum time in milliseconds that players will lay on the ground after getting tazed

Config.PlayerStayInVehicle = false -- If players should stay in the vehicle when they get stunned (defualt gta kicks them out)

Config.TimecycleStrength = 0.35
Config.Timecycle = "dont_tazeme_bro" -- Other timecycles can for example be: hud_def_desat_Trevor, dont_tazeme_bro_b, drug_wobbly etc.
Config.TimecycleTransitionDuration = 8.0 -- How long the transition back to no timecycle should last "Appears to be half-seconds (?)": https://docs.fivem.net/natives/?_0x3BCF567485E1971C

Config.CameraShake = true -- If we should shake the camera on beeing stunned
Config.CameraShakeName = "FAMILY5_DRUG_TRIP_SHAKE"
Config.CameraShakeIntensity = 3.0

Config.DisableNPCWrithe = true -- Disabled writhe for NPC when getting stunned. This will also make it so npc's won't do go into writhe even after they are done beeing stunned. (This ONLY effects stunned peds)
Config.NPCDropWeapon = true -- Makes NPC's drop their weapon when they get stunned

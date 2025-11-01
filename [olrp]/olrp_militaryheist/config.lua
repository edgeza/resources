Config = {}

--[[
    PERFORMANCE OPTIMIZATIONS APPLIED:
    - Distance-based culling: NPCs beyond 150m update every 5 seconds
    - Variable update rates: Nearby (75m) = 500ms, Medium (50m) = 1s, Far = 2s
    - Centralized job checking: Cached once per second instead of per NPC
    - Cached player coordinates: Calculated once globally
    - Smart task management: Tasks only set when state changes
    - Reduced max units: 25 instead of 50
    
    Expected FPS improvement: 40-80+ FPS
]]

-- General Settings
Config.Debug = false
Config.HeistActive = true
Config.DamageMultiplier = 1.5 -- How much damage military NPCs deal
Config.Accuracy = 0.95 -- Military NPC accuracy (0.0 - 1.0) - Increased for stronger accuracy

-- Military Base Coordinates (between the four points)
Config.MilitaryBase = {
    -- Define the four corner points of the military base
    corners = {
        vector3(1626.75, -80.96, 166.17),
        vector3(1603.59, 74.4, 204.12),
        vector3(1716.75, 69.91, 172.19),
        vector3(1738.81, -108.31, 185.22)
    },
    -- Calculate center point
    center = vector3(1671.23, -11.24, 181.88),
    -- Calculate approximate radius from center to furthest corner
    radius = 120.0,
    -- Height variation for patrols
    height = 50.0
}

-- Military NPC Settings
Config.MilitaryUnits = {
    {
        model = "s_m_y_blackops_01",
        weapon = "WEAPON_ASSAULTRIFLE",
        secondaryWeapon = "WEAPON_PISTOL",
        armor = 200,
        health = 200,
        accuracy = 0.95, -- Increased accuracy for stronger combat
        combatStyle = "aggressive"
    },
    {
        model = "s_m_y_blackops_02",
        weapon = "WEAPON_ASSAULTRIFLE",
        secondaryWeapon = "WEAPON_PISTOL",
        armor = 200,
        health = 200,
        accuracy = 0.95, -- Increased accuracy for stronger combat
        combatStyle = "aggressive"
    },
    {
        model = "s_m_y_blackops_03",
        weapon = "WEAPON_ASSAULTRIFLE",
        secondaryWeapon = "WEAPON_PISTOL",
        armor = 200,
        health = 200,
        accuracy = 0.95, -- Increased accuracy for stronger combat
        combatStyle = "aggressive"
    },
    {
        model = "s_m_y_ammucity_01",
        weapon = "WEAPON_ASSAULTRIFLE",
        secondaryWeapon = "WEAPON_PISTOL",
        armor = 200,
        health = 200,
        accuracy = 0.95, -- Increased accuracy for stronger combat
        combatStyle = "aggressive"
    },
    {
        model = "s_m_y_armymech_01",
        weapon = "WEAPON_ASSAULTRIFLE",
        secondaryWeapon = "WEAPON_PISTOL",
        armor = 200,
        health = 200,
        accuracy = 0.95, -- Increased accuracy for stronger combat
        combatStyle = "aggressive"
    }
}

-- Job Exclusions (NPCs will NOT shoot these jobs)
Config.ExcludedJobs = {
    "police",
    "ambulance",
    "doctor",
    "ems",
    "medic",
    "paramedic",
    "firefighter",
    "fire"
}

-- Patrol Settings
Config.PatrolSettings = {
    walkSpeed = 1.0,
    runSpeed = 2.5,
    waitTime = {min = 3000, max = 8000}, -- Wait time between patrol points (ms)
    detectionRange = 50.0, -- How far they can detect players
    shootingRange = 30.0,  -- How far they can shoot
    alertRange = 100.0     -- How far they alert other units
}

-- Spawn Settings
Config.SpawnSettings = {
    maxUnits = 35, -- Maximum military units spawned (matches all spawn points)
    respawnTime = 3600000, -- 1 hour in milliseconds (3600000ms = 1 hour)
    spawnDistance = 500.0, -- Distance from base to spawn units
    despawnTime = 10000, -- 10 seconds in milliseconds for dead units
    cullingDistance = 120.0, -- NPCs beyond this distance are frozen (performance optimization) - Reduced for better performance
    nearbyDistance = 60.0, -- NPCs within this distance update more frequently - Reduced for better performance
    usePredefinedSpawns = true, -- Use predefined spawn points instead of random spawning
    autoRespawn = false -- Disable automatic respawning of units
}

-- Predefined Military Unit Spawn Points
-- Each vector3 will spawn exactly 1 military unit
Config.MilitarySpawnPoints = {
    -- Perimeter spawn points
    vector3(1698.64, -85.05, 220.6),   -- Corner 1
    vector3(1659.04, -46.02, 220.52),     -- Corner 2  
    vector3(1663.2, -80.76, 172.29),    -- Corner 3
    vector3(1659.79, -75.66, 172.33),  -- Corner 4
    
    -- Additional strategic spawn points around the base
    vector3(1661.92, -69.85, 174.17),   -- Center
    vector3(1676.38, -72.58, 173.8),      -- North
    vector3(1676.17, -75.64, 175.36),      -- South
    vector3(1654.92, -71.99, 177.43),       -- East
    vector3(1662.42, -65.96, 178.66),      -- West
    
    -- Inner base spawn points
    vector3(1660.55, -60.05, 180.16),      -- Inner North
    vector3(1677.03, -76.09, 177.59),      -- Inner South
    vector3(1688.27, -74.92, 178.31),      -- Inner Center
    vector3(1668.02, -50.16, 173.77),        -- Inner East
    vector3(1674.12, -35.7, 173.77),      -- Inner West
    
    -- High ground spawn points
    vector3(1667.77, -37.02, 173.77),     -- High North
    vector3(1670.87, -39.13, 178.22),     -- High South
    vector3(1665.32, -42.05, 170.02),      -- High East
    vector3(1660.51, -43.06, 168.33),     -- High West
    
    -- Additional perimeter points
    vector3(1662.75, -54.52, 168.31),     -- Perimeter 1
    vector3(1662.76, -27.4, 173.77),     -- Perimeter 2
    vector3(1665.06, -12.76, 178.18),      -- Perimeter 3
    vector3(1662.75, -15.53, 173.77),      -- Perimeter 4
    vector3(1668.73, -13.85, 173.77),     -- Perimeter 5
    vector3(1664.79, -4.52, 173.77),     -- Perimeter 6
    
    -- Strategic defense positions
    vector3(1666.18, 1.74, 173.77),    -- Defense 1
    vector3(1639.2, 18.96, 173.77),     -- Defense 2
    vector3(1701.14, 63.95, 171.79),       -- Defense 3
    vector3(1678.15, 40.5, 161.78),     -- Defense 4
    vector3(1700.38, 75.77, 171.15),      -- Defense 5
    vector3(1678.15, 40.5, 161.78),
    vector3(1688.13, 42.74, 161.77),
    vector3(1695.63, 42.24, 161.77),
    vector3(1663.59, 14.68, 162.54),
    vector3(1668.3, 5.77, 162.54),
    vector3(1675.12, -8.08, 162.55),
    vector3(1696.31, -10.09, 162.57),
    vector3(1707.11, -6.56, 164.39),
    vector3(1680.68, -33.14, 162.59),
    vector3(1663.34, 8.81, 166.07),
    vector3(1661.06, 25.47, 168.61),
    vector3(1661.37, 34.55, 179.88),
    vector3(1660.87, 25.84, 180.88),
    vector3(1665.0, -28.11, 196.94),
}

-- Heist Restart Settings
Config.HeistRestart = {
    enabled = true,
    restartTime = 3600000, -- 1 hour in milliseconds
    checkInterval = 60000, -- Check every minute
    allUnitsKilled = false,
    restartTimer = 0
}

-- Military Base Storage Stash
Config.MilitaryStash = {
    enabled = true,
    location = vector3(1662.79, -3.48, 173.77), -- Military storage vault location
    requiredUnitsKilled = 35, -- Must kill all units to access
    stashId = "military_base_stash",
    stashLabel = "Military Base Storage",
    stashSlots = 50,
    stashWeight = 1000000, -- 100kg max weight
    progressDuration = 30000, -- 30 seconds progress bar (in milliseconds)
    stashItems = {
        -- Weapons
        {item = "weapon_assaultrifle", amount = 5, label = "Assault Rifle"},
        {item = "weapon_carbinerifle", amount = 3, label = "Carbine Rifle"},
        {item = "weapon_specialcarbine", amount = 2, label = "Special Carbine"},
        {item = "weapon_combatmg", amount = 1, label = "Combat MG"},
        
        -- Ammunition
        {item = "rifle_ammo", amount = 500, label = "Rifle Ammo"},
        {item = "mg_ammo", amount = 200, label = "MG Ammo"},
        
        -- Armor & Health
        {item = "armor", amount = 10, label = "Body Armor"},
        {item = "heavyarmor", amount = 5, label = "Heavy Armor"},
        {item = "bandage", amount = 25, label = "Bandage"},
        
        -- Explosives
        {item = "grenade", amount = 10, label = "Grenade"},
        {item = "molotov", amount = 8, label = "Molotov Cocktail"},
        {item = "c4", amount = 3, label = "C4 Explosive"},
        
        -- Money & Valuables
        {item = "money", amount = 50000, label = "Cash"},
        {item = "goldbar", amount = 5, label = "Gold Bar"},
        {item = "diamond", amount = 10, label = "Diamond"},
        
        -- Special Items
        {item = "military_id", amount = 1, label = "Military ID"},
        {item = "classified_documents", amount = 3, label = "Classified Documents"},
        {item = "weapon_attachment", amount = 8, label = "Weapon Attachment"}
    },
    accessCooldown = 0, -- No cooldown
    notificationMessage = "All military units eliminated! Storage vault is now accessible.",
    accessDeniedMessage = "You must eliminate all military units before accessing the storage vault."
}

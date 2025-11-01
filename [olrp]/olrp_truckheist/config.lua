--[[
    OLRP CIT Heist Configuration
    ===========================
    
    This script provides a realistic armored truck heist system with:
    - Dynamic truck spawning and routing
    - AI guards with realistic combat behavior
    - Explosive mechanics and looting system
    - Police dispatch integration
    - Configurable rewards and cooldowns
    
    Version: 1.0.0
    Author: OLRP Development
]]

Config = {}

-- Framework Configuration
-- ======================
Config.Framework = "qb-core" -- Framework to use: "qb-core" or "esx"
Config.Notification = "qb-core" -- Notification system: "qb-core" or "ox_lib"

-- General Settings
-- ================
Config.CooldownTime = 60 -- Cooldown time in minutes between heists per player
Config.HeistDuration = false -- Maximum heist duration in minutes before auto-fail
Config.MaxDistance = false -- Maximum distance truck can travel before mission fails
Config.RequireItem = true -- Set to true to require an item to start heist
Config.ItemRemove = true -- Remove required item after starting heist (only if RequireItem is true)
Config.ShareWithNearby = true -- Set to true to share heist with nearby players
Config.NearbyDistance = 100.0 -- Distance to share heist with nearby players (in meters)

-- Police Requirement Settings
-- ==========================
Config.RequirePolice = false -- Set to true to require police officers on duty
Config.MinPoliceCount = 3 -- Minimum number of police officers required on duty
Config.PoliceJobs = {
    ["police"] = true, 
    ["bcso"] = true, 
    ["sheriff"] = true,
    ["lspd"] = true,
    ["sasp"] = true,
    ["sahp"] = true,
    ["sast"] = true,
    ["davispd"] = true,
    ["ranger"] = true,
    ["trooper"] = true,
    ["statepolice"] = true,
} -- Police job names to count

-- Required Item Settings (only used if RequireItem is true)
-- ======================================================
Config.RequiredItem = "laptop_green" -- Item needed to start heist (Tier 1 item - required to hack/plan truck route)

-- NPC Settings
-- ============
Config.NPCs = {
    {
        model = "u_m_m_willyfist", -- NPC model
        coords = vector4(-1392.83, -1326.67, 4.15, 76.88), -- x, y, z, heading
    },
    -- Add more NPCs as needed
    -- {
    --     model = "s_m_m_prisguard_01",
    --     coords = vector4(100.0, 200.0, 30.0, 180.0),
    -- },
}

-- Info Ped Settings (intermediate location before truck spawn)
-- ===========================================================
Config.InfoPed = {
    model = "a_m_m_prolhost_01", -- Info ped model (you can change this)
    coords = vector4(706.12, -964.9, 30.4, 0.0), -- Info ped location with heading
}

-- Truck Spawn Locations (Bank/Financial Institution Locations)
-- ==========================================================
Config.TruckSpawnLocations = {
    vector4(-2958.72, 493.05, 15.31, 89.11), -- Great Ocean Highway Bank
    vector4(784.52, -3103.21, 5.8, 341.01), -- Docks Area
    vector4(143.13, -1062.75, 29.19, 65.45), -- Legion Bank
    vector4(1952.38, 3736.85, 32.34, 220.29), -- Sandy Shores Bank
    vector4(-132.03, 6466.75, 31.38, 136.79), -- Paleto Bank
}

-- Vehicle Settings
-- ===============
Config.TruckModel = "stockade3" -- Armored truck model to spawn

-- Escort Vehicle Settings
-- =======================
Config.EscortVehicle = {
    enabled = false, -- Enable escort vehicle
    model = "insurgent", -- Escort vehicle model (try: insurgent, mesa, fbi2, sheriff2, riot, stockade)
    guardCount = 4, -- Number of guards in escort (1 driver + 3 passengers)
    followDistance = 15.0, -- Distance escort stays behind truck
}

-- Guard Settings
-- =============
Config.Guards = {
    count = 4, -- Number of guards in the main truck
    model = "s_m_m_prisguard_01", -- Guard model
    weapons = { -- Weapons guards will use
        "weapon_carbinerifle",
        "weapon_specialcarbine",
        "weapon_advancedrifle"
    },
    armor = 200, -- Guard armor level (0-100)
}

-- Explosive Settings
-- =================
Config.Explosive = {
    requireItem = true, -- Set to true to require explosive item
    requiredItem = "c4", -- Item needed to plant explosive (Tier 1 item from store robbery)
    countdown = 30, -- Countdown time in seconds before explosion
    damageThreshold = 500, -- Truck damage needed to make guards exit
    explosionRadius = 10.0, -- Explosion radius
    explosionDamage = 1000, -- Explosion damage
}

-- Loot Settings
-- ============
Config.Loot = {
    requiredExplosion = true, -- Must explode truck before looting
    interactionDistance = 3.0, -- Distance to interact with truck
    lootingTime = 10000, -- Time to loot in milliseconds
}

-- Tracker Settings
-- ===============
Config.Tracker = {
    updateInterval = 5000, -- How often tracker updates (milliseconds) - increased for better performance on high player count servers
    movementThreshold = 5.0, -- How far truck must move before updating blip
    activateDistance = 50.0, -- How close player must be to activate tracker
}

-- Blip Settings
-- ============
Config.Blips = {
    truck = {
        sprite = 477, -- Truck blip sprite
        color = 1, -- Truck blip color (1 = Red)
        scale = 1.0, -- Blip scale
        name = "CIT Truck" -- Blip name
    },
    delivery = {
        sprite = 500, -- Delivery blip sprite
        color = 2, -- Delivery blip color (2 = Green)
        scale = 0.8, -- Blip scale
        name = "Delivery Point" -- Blip name
    }
}

-- Reward Settings
-- ==============
Config.Rewards = {
    minMoney = 5000, -- Minimum money reward
    maxMoney = 15000, -- Maximum money reward
    items = { -- Items to give as rewards (Tier 2 items for progression to Tier 3)
        {item = "markedbills", amount = {min = 1, max = 2}}, -- Cash reward
        {item = "advanceddecrypter", amount = {min = 1, max = 1}}, -- Tier 2 item - guaranteed
        {item = "advanceddrill", amount = {min = 1, max = 1}}, -- Tier 2 item - guaranteed
        {item = "laptop_blue", amount = {min = 1, max = 1}}, -- Tier 2 item - guaranteed
    }
}

-- Text Messages
-- ============
Config.Messages = {
    infoPrompt = "Press [E] to get information about a truck",
    noItem = "You need a laptop to hack the truck's route information",
    heistStarted = "A truck has been found! The tracker is live and active. Get there first - it's fully stocked!",
    trackerReceived = "You received a ping with the tracker's location",
    truckApproached = "You've found the CIT truck. Deal with the guards and get the loot!",
    deliveryApproached = "You've reached the delivery location. Mission complete!",
    heistActive = "A heist is already active. Wait for it to finish.",
    onCooldown = "You're on cooldown. Wait %d minutes before starting another heist.",
    truckEscaped = "The truck has escaped. Heist failed.",
    heistCompleted = "Heist completed successfully! You earned $%d",
    guardsExited = "Guards have exited the vehicle to defend!",
    plantExplosive = "Press [E] to plant explosive on the truck",
    needExplosive = "You need an explosive to plant on the truck",
    explosivePlanted = "Explosive planted! Get away from the truck!",
    explosionCountdown = "Explosion in %d seconds!",
    truckExploded = "The truck has been destroyed! You can now loot it.",
    lootTruck = "Press [E] to loot the destroyed truck",
    looting = "Looting truck...",
    lootCompleted = "Looting completed!",
}

-- Dispatch Settings (Police Alert Integration)
-- ===========================================
Config.Dispatch = {
    enabled = true, -- Enable police dispatch alerts
    code = "10-90", -- Police radio code
    message = "CIT Truck Robbery in Progress", -- Dispatch message
    sprite = 477, -- Dispatch blip sprite
    color = 1, -- Dispatch blip color
    scale = 1.0, -- Dispatch blip scale
    length = 1, -- Dispatch blip length
    sound = 1, -- Dispatch sound
    offset = "false", -- Dispatch offset
    radius = 0, -- Dispatch radius
}

-- Discord Webhook Settings
-- ========================
Config.Discord = {
    enabled = true, -- Enable discord logging
    webhook = "", -- YOUR DISCORD WEBHOOK URL HERE
    color = 15158332, -- Embed color (default: red)
    botName = "CIT Heist System", -- Bot name for discord messages
    botAvatar = "", -- Bot avatar URL (optional)
}

--[[
    Installation Notes:
    ==================
    
    1. Ensure you have qb-core or ESX framework installed
    2. Install ox_lib if using ox_lib notifications
    3. Install ps-dispatch if using police dispatch integration
    4. Configure the framework setting above
    5. Adjust spawn locations and rewards as needed
    6. Test the script in a development environment first
    
    Troubleshooting:
    ===============
    
    - If guards don't spawn: Check the guard model exists in your server
    - If truck doesn't spawn: Verify truck model is available
    - If notifications don't work: Check framework configuration
    - If dispatch doesn't work: Ensure ps-dispatch is installed and configured
    
    Support:
    =======
    
    For support, please contact OLRP Development or check the documentation.
]]
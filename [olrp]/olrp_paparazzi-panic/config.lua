Config = {}

-- Framework Settings
Config.Framework = 'qbox' -- 'qb-core', 'qbox', or 'esx'
Config.CoreName = 'qbx-core' -- Resource name of your core ('qb-core', 'qbx-core', or 'es_extended')

-- Debug Settings
Config.DebugMode = true -- Set to true to bypass permission checks for testing

-- Event Settings
Config.EventDuration = 600000 -- Duration in milliseconds (10 minutes)
Config.EventCooldown = 1800000 -- Cooldown between events (30 minutes)
Config.MinPlayers = 2 -- Minimum players online to trigger event
Config.AutoStart = false -- Automatically start events randomly
Config.AutoStartInterval = {min = 30, max = 60} -- Minutes between auto-events

-- Celebrity NPC Settings
Config.CelebrityModels = {
    'a_f_y_beach_01',
    'a_f_y_bevhills_01',
    'a_f_y_bevhills_02',
    'a_f_y_hipster_01',
    'a_m_y_bevhills_01',
    'a_m_y_bevhills_02',
    'a_m_y_hipster_01',
    'a_m_y_business_01'
}

Config.CelebrityNames = {
    'Brad Pitt',
    'Scarlett Johnson',
    'Leonardo DaVinci',
    'Jennifer Lopez',
    'Tom Cruise',
    'Angelina Jones',
    'Johnny Deep',
    'Will Smith',
    'John Jameson',
    'Chuck Lorrie',
    'Michael Jackson',
    'Tiana Lorrie',
    'Dexter Morgan',
    'Jack Larkin',
    'Chicken Little'
}

Config.SpawnLocations = {
    --vector4(213.82, -810.44, 30.73, 340.13), -- Legion Square
    --vector4(-1037.58, -2738.23, 20.17, 329.83), -- Airport
    vector4(-1174.07, -1575.51, 4.42, 125.31), -- Beach
    --vector4(113.87, -1307.66, 29.26, 295.26), -- Vanilla Unicorn area
    --vector4(1206.35, -470.57, 66.21, 347.02), -- Mirror Park
    --vector4(-1540.27, -415.42, 35.44, 318.07), -- Bahama Mamas
    --vector4(-252.13, 6336.15, 32.43, 315.44) -- Paleto Bay
}

-- Paparazzi Settings
Config.MaxPaparazzi = 15 -- Maximum paparazzi NPCs
Config.PaparazziModels = {
    'a_m_m_paparazzi_01',
    'a_m_y_hipster_02',
    'a_f_y_hipster_02',
    'a_m_y_hipster_01'
}

Config.PaparazziSpawnRadius = 50.0 -- Spawn radius around celebrity
Config.PaparazziFollowDistance = 3.0 -- How close they follow
Config.PaparazziSpawnInterval = 10000 -- Spawn new paparazzi every X ms

-- Police Settings
Config.PoliceJobs = {'police'} -- Job names for police
Config.PoliceCrowdControlReward = 500 -- Money for controlling crowd

-- Kidnapping Settings
Config.KidnapEnabled = true
Config.KidnapDistance = 2.0 -- Distance to kidnap
Config.KidnapTime = 10000 -- Time to kidnap in ms
Config.RansomAmount = {min = 50000, max = 150000} -- Random ransom amount
Config.RansomTimer = 300000 -- Time to pay ransom (5 minutes)
Config.KidnapSuccessReward = 75000 -- Reward for successful kidnap
Config.RescueReward = 15000 -- Police reward for rescue

-- Notification Settings
Config.NotifyRadius = 500.0 -- Radius for location-based notifications

-- Blip Settings
Config.CelebrityBlip = {
    sprite = 280,
    color = 5,
    scale = 1.2,
    flash = true,
    name = '⭐ Celebrity Spotted!'
}

Config.KidnapBlip = {
    sprite = 237,
    color = 1,
    scale = 1.0,
    flash = true,
    name = '🚨 Celebrity Kidnapped!'
}

-- Interaction Settings
Config.UseTarget = false -- Set to true if using qb-target/ox_target
Config.TargetResource = 'ox_target' -- 'qb-target' or 'ox_target'

-- Interaction Keys
Config.Controls = {
    Photo = 38,     -- E key - Take Photo
    Kidnap = 74     -- H key - Kidnap (Hold)
}

-- Control Labels for Display
Config.ControlLabels = {
    Photo = '[E]',      -- E key
    Kidnap = '[H]'      -- H key
}

-- Reward Settings
Config.PhotoReward = 100 -- Money for taking photo near celebrity
Config.PhotoCooldown = 30000 -- Cooldown for photo reward


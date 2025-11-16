Config = Config or {}

-- General Settings
Config.blipsShow = true -- Enable/disable all blips
Config.Debug = true -- Enable debug prints
Config.WaitForFramework = false -- Wait for framework to be ready (set to true if you need framework integration)
Config.LoadDelay = 1000 -- Delay in ms before creating blips (allows other resources to load)
Config.StoreBlipIds = false -- Store blip IDs for later removal (useful for dynamic blips)

-- Default Blip Settings (used when location doesn't specify)
Config.DefaultSprite = 1
Config.DefaultScale = 0.8
Config.DefaultColor = 1
Config.DefaultShortRange = true

-- Blip Locations
-- You can add as many locations as you want
-- Required: vector (vector3), text (string)
-- Optional: sprite (number), scale (number), color (number), shortRange (boolean), category (number)
Config.Locations = {
    [1] = {
        vector = vec3(-1505.18, -1488.05, 4.74), 
        text = "Beach Club", 
        color = 48, 
        sprite = 858, 
        scale = 1.0,
        shortRange = true,
    },
    [2] = {
        vector = vector3(-778.01, 4965.29, 209.68), 
        text = "Hunting Zone", 
        color = 5, 
        sprite = 51, 
        scale = 0.8,
        shortRange = true,
    },
}
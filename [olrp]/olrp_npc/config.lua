-- ==============================================
-- OLRP NPC DENSITY - CONFIGURATION
-- ==============================================
-- Dynamic NPC density system that adjusts based on player count
-- ==============================================

Config = {}

-- Enable/Disable the system
Config.Enabled = true

-- Player count thresholds
-- When player count is <= 10, density will be 0.75
-- When player count is >= 100, density will be 0.25
-- Between 10 and 100, density will interpolate linearly
Config.LowPlayerThreshold = 10   -- 1-10 players: use high density (0.75)
Config.HighPlayerThreshold = 100  -- 100+ players: use low density (0.25)

-- Density values
Config.HighDensity = 0.0  -- Density when few players (1-10 players)
Config.LowDensity = 0.00   -- Density when many players (100+ players)

-- Update interval (milliseconds) - How often to check player count and update density
Config.UpdateInterval = 60000    -- Check every 5 seconds

-- Debug mode - Print density changes to console
Config.Debug = false

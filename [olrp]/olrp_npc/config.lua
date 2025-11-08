-- ==============================================
-- OLRP NPC DENSITY - CONFIGURATION
-- ==============================================
-- Dynamic NPC density system that adjusts based on player count
-- IMPORTANT: Density is applied EVERY FRAME to ensure it works correctly
-- Set Config.Enabled = false to completely disable all NPCs (density = 0.0)
-- ==============================================

Config = {}

-- Enable/Disable the system
-- When false, ALL NPCs and vehicles will be disabled (density = 0.0)
-- When true, density will adjust based on player count
Config.Enabled = true

-- Player count thresholds
-- When player count is <= LowPlayerThreshold, density will be Config.HighDensity
-- When player count is >= HighPlayerThreshold, density will be Config.LowDensity
-- Between thresholds, density will interpolate linearly
Config.LowPlayerThreshold = 10   -- 1-10 players: use high density
Config.HighPlayerThreshold = 100  -- 100+ players: use low density

-- Density values (0.0 = no NPCs, 1.0 = full GTA Online density)
-- These values are clamped between 0.0 and 1.0
Config.HighDensity = 0.2  -- Density when few players (1-10 players)
Config.LowDensity = 0.05   -- Density when many players (100+ players)

-- Update interval (milliseconds) - How often to check player count and update target density
-- Note: Density is applied every frame, this only updates the target value
Config.UpdateInterval = 60000    -- Check every 60 seconds (1 minute)

-- Debug mode - Print density changes to console (F8 console)
Config.Debug = false

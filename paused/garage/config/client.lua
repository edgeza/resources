-- Dusa Garage Management System - Client Configuration
-- Version: 1.0.0
Config = Config or {}
-- Client-specific configuration
Config.Client = Config.Client or {}

-- UI settings
Config.Client.UI = {
    EnableSounds = true,           -- Enable UI sounds
    AnimationSpeed = 300,          -- UI animation speed in milliseconds
    ShowNotifications = true,      -- Show system notifications
    NotificationDuration = 5000,   -- Notification duration in milliseconds
}

-- Vehicle settings
Config.Client.Vehicle = {
    PreviewEnabled = true,         -- Enable vehicle preview in garage
    PreviewDistance = 10.0,        -- Distance for vehicle preview
    SpawnInVehicle = false,        -- Spawn player inside vehicle
    DeleteOnFarDistance = 200.0,   -- Delete vehicle if player goes too far
}

-- Visual effects
Config.Client.Effects = {
    ShowBlips = true,              -- Show garage blips on map
    BlipSprite = 357,              -- Garage blip sprite
    BlipColor = 3,                 -- Garage blip color
    BlipScale = 0.8,               -- Garage blip scale
    ShowMarkers = true,            -- Show interaction markers
    MarkerType = 36,               -- Marker type
    MarkerSize = {1.5, 1.5, 1.0},  -- Marker size {x, y, z}
    MarkerColor = {0, 255, 0, 100}, -- Marker color {r, g, b, a}
    
    -- Blip grouping configuration
    BlipGrouping = {
        -- Blip display mode:
        -- "category" = Show category names (Garages, Boat Garages, Aircraft Garages)
        -- "individual" = Show individual garage names
        Mode = "individual", -- "category" or "individual"
        
        -- Category grouping style (applies to both modes):
        -- "grouped" = All blips grouped under single category (uses SetBlipCategory native)
        -- "all_separate" = Each garage shown separately without grouping
        CategoryStyle = "grouped", -- "grouped" or "all_separate"
        
        -- Category names for each vehicle type (used when Mode = "category")
        Categories = {
            car = "Garages",
            boat = "Boat Garages",
            aircraft = "Aircraft Garages"
        }
    }
}

-- Performance settings
Config.Client.Performance = {
    UpdateInterval = 1000,         -- Update interval for distance checks (ms)
    RenderDistance = 50.0,         -- Render distance for garage elements
    MaxVisibleVehicles = 20,       -- Maximum vehicles to render in preview
}

-- Controls
Config.Client.Controls = {
    DisableControlsInUI = {        -- Controls to disable when UI is open
        1, 2, 142, 18, 322, 106    -- Look LR, Look UD, Attack, Enter, ESC, VehicleMouseControlOverride
    }
}
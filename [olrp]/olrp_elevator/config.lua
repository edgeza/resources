Config = {}

-- Portal System Configuration
Config.Portals = {
    -- Example: Floor 1 to Floor 2
    {
        name = "Skyclub Entrance",
        portal1 = {
            coords = vector3(-906.05, -451.46, 39.61),
            heading = 0.0,
            label = "Floor 1 Portal",
            description = "Teleport to Floor 2"
        },
        portal2 = {
            coords = vector3(-910.21, -440.69, 160.31),
            heading = 0.0,
            label = "Skyclub Floor", 
            description = "Teleport to Floor 1"
        }
    },
    {
        name = "Elevator to Helipad",
        portal1 = {
            coords = vec3(332.43, -595.65, 42.28),
            heading = 0.0,
            label = "Portal To Helipad",
            description = "Elevator down to Ground"
        },
        portal2 = {
            coords = vec3(338.54, -583.92, 73.16),
            heading = 0.0,
            label = "Hospital Roof", 
            description = "Go to Ground Floor"
        }
    },
    -- Add more portal pairs here as needed
}

-- Multi-Floor Buildings Configuration
Config.MultiFloorBuildings = {
    {
        name = "Triads Gang House",
        buildingId = "triads_house",
        floors = {
            {
                name = "Ground Floor",
                coords = {
                    vector3(-817.59, -709.15, 28.06),
                    vector3(-817.88, -705.42, 28.06),
                    vector3(-817.79, -705.32, 23.78)
                },
                heading = 0.0,
                label = "Ground Floor",
                description = "Ground Floor Access"
            },
            {
                name = "First Floor", 
                coords = {
                    vector3(-816.81, -709.64, 28.06),
                    vector3(-817.32, -705.39, 28.06)
                },
                heading = 0.0,
                label = "First Floor",
                description = "First Floor Access"
            },
            {
                name = "Second Floor",
                coords = {
                    vector3(-817.39, -705.59, 32.34),
                    vector3(-818.13, -709.67, 32.34)
                },
                heading = 0.0,
                label = "Second Floor", 
                description = "Second Floor Access"
            }
        }
    }
    
    -- Add more multi-floor buildings here as needed
}

-- General Settings
Config.Settings = {
    -- Detection distance for portals
    detectionDistance = 5.0,
    
    -- Marker settings
    marker = {
        type = 1,           -- Marker type (1 = cylinder)
        size = {2.0, 2.0, 1.0},  -- {x, y, z} size
        color = {0, 255, 0, 100}, -- {r, g, b, a} color
        bobUpAndDown = false,
        faceCamera = false,
        rotate = true
    },
    
    -- Teleport settings
    teleport = {
        fadeTime = 1000,    -- Fade in/out time in ms
        waitTime = 500,     -- Wait time between fade out and in
        showNotification = true,
        notificationText = "You have been teleported!"
    },
    
    -- Debug settings
    debug = {
        enabled = false,    -- Enable debug prints
        showPortalNames = true, -- Show portal names in markers
        showCoordinates = false -- Show coordinates in debug
    }
}

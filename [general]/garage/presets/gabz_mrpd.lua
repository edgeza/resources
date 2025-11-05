-- Gabz MRPD Police Department Garage Presets
-- Mission Row Police Department
-- These coordinates are optimized for the Gabz MRPD MLO

return {
    name = "Gabz MRPD",
    description = "Mission Row Police Department garages for Gabz MLO",
    icon = "building-shield",
    garages = {
        {
            name = "MRPD - Main Garage",
            job = "police",
            vehicleType = "car",
            coords = { x = 439.79, y = -1018.28, z = 28.66, w = 90.0 },
            radius = 10.0,
            spawnPoints = {
                { x = 441.18, y = -1024.15, z = 28.48, heading = 357.75 },
                { x = 437.86, y = -1024.36, z = 28.49, heading = 358.33 },
                { x = 434.47, y = -1024.42, z = 28.50, heading = 358.25 },
                { x = 431.11, y = -1024.63, z = 28.50, heading = 358.74 }
            }
        },
        {
            name = "MRPD - Rear Parking",
            job = "police",
            vehicleType = "car",
            coords = { x = 463.93, y = -1011.85, z = 28.11, w = 90.0 },
            radius = 8.0,
            spawnPoints = {
                { x = 464.24, y = -1008.58, z = 26.27, heading = 91.49 },
                { x = 464.38, y = -1003.18, z = 25.91, heading = 90.29 },
                { x = 464.30, y = -997.86, z = 25.55, heading = 88.93 }
            }
        },
        {
            name = "MRPD - Helicopter Pad",
            job = "police",
            vehicleType = "aircraft",
            coords = { x = 449.08, y = -981.22, z = 43.69, w = 180.0 },
            radius = 15.0,
            spawnPoints = {
                { x = 449.70, y = -981.21, z = 43.69, heading = 2.08 }
            }
        },
        {
            name = "MRPD - Underground Garage",
            job = "police",
            vehicleType = "car",
            coords = { x = 424.64, y = -1027.66, z = 28.25, w = 270.0 },
            radius = 12.0,
            spawnPoints = {
                { x = 434.70, y = -1016.15, z = 28.21, heading = 270.93 },
                { x = 434.83, y = -1020.84, z = 28.21, heading = 270.68 },
                { x = 434.84, y = -1025.50, z = 28.21, heading = 270.68 },
                { x = 434.66, y = -1030.14, z = 28.21, heading = 270.24 }
            }
        }
    }
}

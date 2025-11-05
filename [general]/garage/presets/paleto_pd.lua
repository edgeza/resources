-- Paleto Bay Police Department Garage Presets
-- Paleto Bay Sheriff's Office

return {
    name = "Paleto PD",
    description = "Paleto Bay Sheriff Station garages",
    icon = "building-shield",
    garages = {
        {
            name = "Paleto PD - Main Garage",
            job = "police",
            vehicleType = "car",
            coords = { x = -475.09, y = 6027.54, z = 31.34, w = 315.0 },
            radius = 7.0,
            spawnPoints = {
                { x = -472.72, y = 6024.97, z = 31.34, heading = 314.82 },
                { x = -469.81, y = 6027.90, z = 31.34, heading = 314.65 },
                { x = -466.91, y = 6030.83, z = 31.34, heading = 314.29 }
            }
        },
        {
            name = "Paleto PD - Helicopter Pad",
            job = "police",
            vehicleType = "aircraft",
            coords = { x = -475.40, y = 5988.47, z = 31.34, w = 315.0 },
            radius = 15.0,
            spawnPoints = {
                { x = -475.40, y = 5988.47, z = 31.34, heading = 315.12 }
            }
        }
    }
}

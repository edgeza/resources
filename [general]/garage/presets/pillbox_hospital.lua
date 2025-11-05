-- Pillbox Hospital Garage Presets
-- Pillbox Hill Medical Center
-- Optimized for ambulance and medical response vehicles

return {
    name = "Pillbox Hospital",
    description = "Pillbox Hill Medical Center garages",
    icon = "hospital",
    garages = {
        {
            name = "Pillbox - Main Ambulance Bay",
            job = "ambulance",
            vehicleType = "car",
            coords = { x = 327.85, y = -580.34, z = 28.80, w = 340.0 },
            radius = 8.0,
            spawnPoints = {
                { x = 330.32, y = -576.48, z = 28.80, heading = 339.56 },
                { x = 326.72, y = -574.39, z = 28.80, heading = 340.12 },
                { x = 323.18, y = -572.23, z = 28.80, heading = 339.89 }
            }
        },
        {
            name = "Pillbox - Emergency Parking",
            job = "ambulance",
            vehicleType = "car",
            coords = { x = 338.46, y = -589.30, z = 28.80, w = 250.0 },
            radius = 7.0,
            spawnPoints = {
                { x = 339.68, y = -585.08, z = 28.80, heading = 249.87 },
                { x = 342.02, y = -587.12, z = 28.80, heading = 249.32 }
            }
        },
        {
            name = "Pillbox - Helicopter Pad",
            job = "ambulance",
            vehicleType = "aircraft",
            coords = { x = 351.53, y = -587.85, z = 74.16, w = 250.0 },
            radius = 20.0,
            spawnPoints = {
                { x = 351.53, y = -587.85, z = 74.16, heading = 250.18 }
            }
        }
    }
}

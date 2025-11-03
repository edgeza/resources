-- Sandy Shores Sheriff Station Garage Presets
-- Blaine County Sheriff's Office

return {
    name = "Sandy Shores Sheriff",
    description = "Sandy Shores Sheriff Station garages",
    icon = "badge-sheriff",
    garages = {
        {
            name = "Sandy Sheriff - Main Garage",
            job = "police",
            vehicleType = "car",
            coords = { x = 1854.04, y = 3689.99, z = 34.27, w = 210.0 },
            radius = 8.0,
            spawnPoints = {
                { x = 1854.97, y = 3692.84, z = 33.81, heading = 210.44 },
                { x = 1858.07, y = 3690.66, z = 33.81, heading = 210.08 },
                { x = 1861.20, y = 3688.46, z = 33.81, heading = 209.74 }
            }
        },
        {
            name = "Sandy Sheriff - Helicopter Pad",
            job = "police",
            vehicleType = "aircraft",
            coords = { x = 1853.27, y = 3706.56, z = 34.52, w = 30.0 },
            radius = 15.0,
            spawnPoints = {
                { x = 1853.27, y = 3706.56, z = 34.52, heading = 30.15 }
            }
        }
    }
}

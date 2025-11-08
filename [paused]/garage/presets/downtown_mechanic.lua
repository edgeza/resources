-- Downtown Mechanic Garage Presets
-- Los Santos Customs and nearby mechanic garages

return {
    name = "Downtown Mechanic",
    description = "Downtown mechanic shop garages",
    icon = "wrench",
    garages = {
        {
            name = "LS Customs - Main Garage",
            job = "mechanic",
            vehicleType = "car",
            coords = { x = -347.45, y = -133.69, z = 39.01, w = 250.0 },
            radius = 8.0,
            spawnPoints = {
                { x = -345.12, y = -129.87, z = 39.01, heading = 249.88 },
                { x = -342.23, y = -127.45, z = 39.01, heading = 250.32 },
                { x = -339.34, y = -125.03, z = 39.01, heading = 249.76 }
            }
        },
        {
            name = "LS Customs - Tow Truck Bay",
            job = "mechanic",
            vehicleType = "car",
            coords = { x = -356.89, y = -142.17, z = 38.25, w = 70.0 },
            radius = 6.0,
            spawnPoints = {
                { x = -355.18, y = -138.92, z = 38.25, heading = 70.45 },
                { x = -357.92, y = -141.32, z = 38.25, heading = 70.12 }
            }
        }
    }
}

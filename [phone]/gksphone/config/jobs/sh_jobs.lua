GKSJobs = GKSJobs or {}

GKSJobs.Jobs = {
    ["sanitation"] = {
        ["Name"] = "sanitation",
        ["Label"] = "Los Santos Department of Sanitation",
        ["Description"] = "We're looking for heroes to help clean up our beautiful city! You can immediately help clean the city and start earning money.",
        ["Icon"] = "recycling",
        ["IconColor"] = "green",
        ["Rating"] = 2,
        ["Money"] = math.random(300, 1000),
        ["MimWorkers"] = 1,
        ["MaxWorkers"] = 2,
        ["Location"] = vector4(-352.17, -1545.7, 26.72, 269.89),
        ["RequiredItem"] = false,
        ["IsActive"] = true
    },
    ["carthief"] = {
        ["Name"] = "carthief",
        ["Label"] = "Car Thief",
        ["Description"] = "We need someone with magic hands. Is that you? Let's see!",
        ["Icon"] = "directions_car",
        ["IconColor"] = "red",
        ["Rating"] = 4,
        ["Money"] = math.random(100, 1000),
        ["MimWorkers"] = 1,
        ["MaxWorkers"] = 1,
        ["Location"] = false,
        ["RequiredItem"] = true,
        ["ItemRequired"] = "lockpick",
        ["IsActive"] = true
    }
}
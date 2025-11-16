local blacklist = {}

-- vehicle model names that can't be used.
blacklist.vehicleModels = {
    `limo`,
    `limo2`
}

-- setting to true will blacklist a vehicle class.
blacklist.vehicleClasses = {
    ["Compacts"] = false,
    ["Sedans"] = false,
    ["SUVs"] = false,
    ["Coupes"] = false,
    ["Muscle"] = false,
    ["Sports Classics"] = false,
    ["Sports"] = false,
    ["Super"] = false,
    ["Motorcycles"] = true,
    ["Off-road"] = false,
    ["Industrial"] = true,
    ["Utility"] = true,
    ["Vans"] = false,
    ["Cycles"] = true,
    ["Boats"] = true,
    ["Helicopters"] = true,
    ["Planes"] = true,
    ["Service"] = true,
    ["Emergency"] = true,
    ["Military"] = true,
    ["Commercial"] = true,
    ["Trains"] = true,
    ["Open Wheel"] = true
}

return blacklist

Config = {}

Config.Debug = false

Config.Localization = {
    use_controls = 'Use flatbed controls',
    load_vehicle = 'Load nearby vehicle',
    unload_vehicle = 'Unload vehicle',
    vehicle_locked = "You can't tow a locked vehicle!",
    steep_angle = 'Vehicle needs to be somewhat aligned.',
    no_vehicle_found = 'There is no vehicle in reach.',
    vehicle_blacklist = "You can't tow this vehicle.",
    loading_vehicle = 'Vehicle is being loaded...',
    unloading_vehicle = 'Vehicle is being unloaded...',
    loading_canceled = 'Loading cancelled.',
    unloading_canceled = 'Unloading cancelled.',
    vehicle_loaded = 'Vehicle loaded onto the flatbed.',
    vehicle_unloaded = 'Vehicle unloaded.',
    truck_occupied = 'Flatbed controls are being used by someone else.',
    door_opening = 'Force opening the vehicle...',
    door_opened = 'Vehicle unlocked.',
    door_open_canceled = 'You stopped opening the vehicle.',
    open_vehicle = 'Force open the vehicle',
    not_further = "Can't move further in this direction!",
    unhooked = 'Vehicle detached!',
    engine_required = 'Engine needs to be running.',
    no_permission = 'You are not on duty for towing.',
    no_vehicle_loaded = 'No vehicle loaded.',
    already_loaded = 'Flatbed already has a vehicle loaded.',
    key_front_back = 'Forwards / Backwards',
    key_up_down = 'Raise / Lower',
    key_tilt = 'Tilt front/back',
    key_cancel = 'Cancel',
    key_dismiss = 'Dismiss help',
    fix_bug = 'Fix towing bug (detach)'
}

Config.Target = {
    name = 'custom_flatbed:controls',
    icon = 'fa-solid fa-truck-ramp',
    loadLabel = Config.Localization.load_vehicle,
    unloadLabel = Config.Localization.unload_vehicle,
    controlLabel = Config.Localization.use_controls,
    distance = 2.0
}

Config.JobRestriction = {
    enabled = false,
    hasAccess = function()
        return true
    end
}

Config.RequireEngineOn = true
Config.MaxVehicleDistance = 7.0

Config.Align = {
    durationLoad = 5000,
    durationUnload = 3000,
    maxTilt = 15.0,
    maxOffset = 1.2,
    step = 0.05,
    tiltStep = 0.5
}

Config.Flatbeds = {
    {
        model = `flatbed`,
        bone = 'chassis',
        controlOffset = vec3(206.32, -829.41, 30.8),
        attachOffset = vector3(0.0, -2.6, 1.05),
        unloadOffset = vector3(0.25, -7.5, 0.1),
        initialTilt = 0.0
    },
    {
        model = `slamtruck`,
        bone = 'chassis',
        controlOffset = vector3(-1.6, -1.4, 0.1),
        attachOffset = vector3(0.0, -1.9, 1.0),
        unloadOffset = vector3(0.1, -6.5, 0.2),
        initialTilt = 7.0
    }
}

Config.BlacklistedClasses = {
    [10] = true,
    [11] = true,
    [14] = true,
    [15] = true,
    [16] = true,
    [20] = true,
    [21] = true
}

Config.ControlKeys = {
    up = 172,
    down = 173,
    left = 174,
    right = 175,
    tiltUp = 44,
    tiltDown = 38,
    cancel = 177,
    dismissHelp = 73,
    unhook = 74
}

Config.ControlSettings = {
    distance = 1.5,
    holdToUnhook = 700,
    alignmentStep = 0.05,
    tiltStep = 0.5
}

Config.VehicleOptions = {
    requireUnlocked = true,
    allowDoorUnlock = true,
    doorUnlockTime = 5000,
    doorUnlockDistance = 1.0
}

Config.Progress = {
    enabled = true,
    labelLoading = Config.Localization.loading_vehicle,
    labelUnloading = Config.Localization.unloading_vehicle,
    labelUnlock = Config.Localization.door_opening
}

Config.Notifications = {
    success = function(message)
        lib.notify({
            title = 'Flatbed',
            description = message,
            type = 'success'
        })
    end,
    info = function(message)
        lib.notify({
            title = 'Flatbed',
            description = message,
            type = 'inform'
        })
    end,
    error = function(message)
        lib.notify({
            title = 'Flatbed',
            description = message,
            type = 'error'
        })
    end
}


Config = Config or {}

Config.Debug = false

Config.TabletItem = 'storm_tablet'
Config.ProbeItem = 'storm_probe'
Config.DataItem = 'storm_data'

Config.MaxConcurrentStorms = 1
Config.StormSpawnIntervalMinutes = { min = 20, max = 35 }
Config.StormLifetimeMinutes = 12
Config.StormUpdateIntervalSeconds = 15

Config.StormRadius = { inner = 120.0, outer = 220.0 }
Config.StormSpeed = { min = 8.0, max = 18.0 } -- meters per second
Config.RandomDrift = 6.0

Config.DataCaptureRadius = 180.0
Config.MaxProbePerPlayer = 3
Config.ProbeDespawnMinutes = 45

Config.BasePayout = 450 -- base dollars per valid probe capture
Config.QualityMultiplier = {
    close = 1.75,
    medium = 1.25,
    far = 0.75
}

Config.NewsStation = {
    coords = vector3(-582.58, -932.16, 23.86),
    heading = 90.0,
    blip = {
        enabled = true,
        sprite = 184,
        color = 17,
        scale = 0.85,
        text = 'Weazel Storm Desk'
    }
}

Config.Tablet = {
    openKey = 'F1',
    enableKeybind = true
}

Config.WeatherTrigger = {
    enabled = true,
    weatherTypes = {
        RAIN = true,
        THUNDER = true,
        OVERCAST = true
    },
    despawnOnMismatch = false
}

Config.MapBounds = {
    min = vector2(-3700.0, -4200.0),
    max = vector2(4400.0, 800.0)
}

return Config


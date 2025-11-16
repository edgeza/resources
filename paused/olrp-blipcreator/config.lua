Config = Config or {}

Config.Defaults = {
    sprite = 280,
    color = 3,
    scale = 0.9,
    short_range = true
}

Config.SpriteAliases = {
    radar_police = 41,
    radar_gun_van = 844,
    radar_stash_house = 845
}

Config.Blips = {
    {
        coords = vector3(441.6, -982.0, 30.7),
        label = "Police Department",
        sprite = "radar_police",
        color = 38,
        scale = 0.9,
        short_range = true
    },
    {
        coords = vector3(25.7, -1347.3, 29.5),
        label = "24/7 Store",
        sprite = 52,
        color = 5,
        scale = 0.8
    },
    {
        coords = vector3(-47.6, -1115.5, 26.4),
        label = "Premium Deluxe Motorsports",
        sprite = 326,
        color = 27,
        scale = 0.85,
        short_range = false
    }
}


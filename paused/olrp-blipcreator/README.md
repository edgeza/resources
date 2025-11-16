# OLRP Blip Creator

Config-driven blip definitions for FiveM servers—no chat commands required.

## Features

- Define every blip in `config.lua`; restart the resource to apply changes.
- Supports sprite aliases for easier use of the [FiveM blip reference](https://docs.fivem.net/docs/game-references/blips/).
- Shared defaults for sprite, color, scale, and short-range behavior.
- Client syncs automatically on join or resource restart.

## Installation

1. Copy the `olrp-blipcreator` directory into your FiveM resources folder.
2. Add `ensure olrp-blipcreator` to your `server.cfg`.
3. Restart your server.

## Configuration

Adjust `config.lua` to control default values, aliases, and the list of blips:

```9:15:olrp-blipcreator/config.lua
Config.Defaults = {
    sprite = 280,
    color = 3,
    scale = 0.9,
    short_range = true
}
```

```16:20:olrp-blipcreator/config.lua
Config.SpriteAliases = {
    radar_police = 41,
    radar_gun_van = 844,
    radar_stash_house = 845
}
```

```20:38:olrp-blipcreator/config.lua
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
    }
}
```

Each entry supports:

- `coords`: `vector3` or `{ x, y, z }` for the location.
- `label`: blip name (max 60 characters).
- `sprite`: numeric ID or alias from `Config.SpriteAliases`.
- `color`: numeric blip color.
- `scale`: floating-point size modifier.
- `short_range`: optional boolean (defaults to `Config.Defaults.short_range`).

## Notes

- After editing `config.lua`, run `ensure olrp-blipcreator` (or restart the server) to refresh blips.
- Expand `Config.SpriteAliases` with any other sprite names you need from the [FiveM blip reference](https://docs.fivem.net/docs/game-references/blips/).


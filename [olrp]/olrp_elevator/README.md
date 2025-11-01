# OLRP Portal Teleport System v2.0

A configurable FiveM script that creates multiple interactive portal pairs allowing players to teleport between various locations.

## Features

- **Multiple Portal Pairs**: Configure unlimited portal pairs in config.lua
- **Bidirectional Teleportation**: Each portal pair allows teleportation in both directions
- **No Job Restrictions**: Available to all players
- **Visual Markers**: Green markers indicate portal locations
- **Smooth Transitions**: Fade in/out effects during teleportation
- **Interactive Prompts**: Press E to use portals
- **Admin Commands**: Full admin control over portal management
- **Debug Mode**: Built-in debugging system
- **Runtime Configuration**: Add/remove portals without restart

## Installation

1. **Download/Clone** this resource to your server's resources folder
2. **Add to server.cfg**: Add `ensure OLRP_teleport` to your server.cfg
3. **Configure**: Edit `config.lua` to add your portal pairs
4. **Restart** your server or use `refresh` and `start OLRP_teleport` commands

## Configuration

### Portal Pairs Setup

Edit `config.lua` to add your portal pairs:

```lua
Config.Portals = {
    {
        name = "Building Floors",
        portal1 = {
            coords = vector3(-906.05, -451.46, 39.61),
            heading = 0.0,
            label = "Floor 1 Portal",
            description = "Teleport to Floor 2"
        },
        portal2 = {
            coords = vector3(-910.21, -440.69, 160.31),
            heading = 0.0,
            label = "Floor 2 Portal", 
            description = "Teleport to Floor 1"
        }
    },
    -- Add more portal pairs here
}
```

### Settings Configuration

```lua
Config.Settings = {
    detectionDistance = 3.0,  -- How close you need to be to portal
    marker = {
        type = 1,             -- Marker type
        size = {2.0, 2.0, 1.0}, -- Marker size
        color = {0, 255, 0, 100}, -- Marker color (RGBA)
    },
    teleport = {
        fadeTime = 1000,      -- Fade transition time
        showNotification = true,
    }
}
```

## Usage

### For Players

1. **Approach a Portal**: Walk near any configured portal location
2. **See the Marker**: A green marker will appear on the ground
3. **Press E**: When prompted, press E to teleport to the paired location
4. **Enjoy**: You'll be teleported with a smooth fade effect

### Portal Behavior

- **Detection Range**: Configurable distance (default 3.0 units)
- **Bidirectional**: Each portal pair works both ways
- **No Cooldown**: Can be used repeatedly
- **Visual Feedback**: Green markers and help text

## Commands

### Player Commands

- `/listportals` - List all available portals with distances
- `/tpportal [pair] [portal]` - Teleport to specific portal (e.g., `/tpportal 1 1`)
- `/portaldebug` - Toggle debug mode (shows portal names)
- `/portalinfo` - Display system information

### Admin Commands

- `/reloadportals` - Reload portal configuration
- `/portalstats` - Show portal statistics
- `/addportal "name" "label1" "label2" x1 y1 z1 h1 x2 y2 z2 h2` - Add new portal pair
- `/removeportal [pair_index]` - Remove portal pair

## Example Portal Configurations

### Building Floors
```lua
{
    name = "Building Floors",
    portal1 = {
        coords = vector3(-906.05, -451.46, 39.61),
        heading = 0.0,
        label = "Floor 1 Portal",
        description = "Teleport to Floor 2"
    },
    portal2 = {
        coords = vector3(-910.21, -440.69, 160.31),
        heading = 0.0,
        label = "Floor 2 Portal", 
        description = "Teleport to Floor 1"
    }
}
```

### City to Airport
```lua
{
    name = "City Airport",
    portal1 = {
        coords = vector3(-1037.0, -2737.0, 20.0),
        heading = 240.0,
        label = "City Portal",
        description = "Teleport to Airport"
    },
    portal2 = {
        coords = vector3(-1336.0, -3044.0, 13.9),
        heading = 60.0,
        label = "Airport Portal",
        description = "Teleport to City"
    }
}
```

### Hospital to Police Station
```lua
{
    name = "Emergency Services",
    portal1 = {
        coords = vector3(298.0, -584.0, 43.0),
        heading = 70.0,
        label = "Hospital Portal",
        description = "Teleport to Police Station"
    },
    portal2 = {
        coords = vector3(428.0, -984.0, 30.0),
        heading = 90.0,
        label = "Police Portal",
        description = "Teleport to Hospital"
    }
}
```

## Advanced Features

### Debug Mode

Enable debug mode to see:
- Portal names above markers
- Console logs for teleportation
- Coordinate information

```lua
Config.Settings.debug = {
    enabled = true,
    showPortalNames = true,
    showCoordinates = true
}
```

### Custom Markers

Customize marker appearance:

```lua
Config.Settings.marker = {
    type = 1,                    -- Marker type (1 = cylinder)
    size = {2.0, 2.0, 1.0},     -- {x, y, z} size
    color = {0, 255, 0, 100},   -- {r, g, b, a} color
    bobUpAndDown = false,        -- Bob animation
    faceCamera = false,          -- Face camera
    rotate = true               -- Rotate animation
}
```

### Runtime Portal Management

Add portals without restarting:

```
/addportal "New Portal" "Start" "End" 100 200 30 0 300 400 50 180
```

Remove portals:

```
/removeportal 1
```

## Files

- `fxmanifest.lua` - Resource manifest
- `config.lua` - Portal configuration and settings
- `client.lua` - Client-side portal detection and teleportation
- `server.lua` - Server-side logging and admin commands
- `README.md` - This file

## Troubleshooting

### Portal not working?
1. Check if the resource is started: `start OLRP_teleport`
2. Verify you're within detection distance of the portal
3. Check server console for error messages
4. Ensure QBCore is properly loaded
5. Verify portal coordinates in config.lua

### Can't see markers?
- Check detection distance setting
- Verify portal coordinates are correct
- Enable debug mode to see portal names
- Ensure no other scripts are interfering

### Admin commands not working?
- Verify you have admin permissions
- Check if QBCore job system is working
- Ensure you're using the correct command syntax

## Performance

- **Optimized**: Only checks nearby portals
- **Configurable**: Adjust detection distance for performance
- **Efficient**: Uses proper sleep timers
- **Scalable**: Supports unlimited portal pairs

## Support

For issues or questions:
1. Check server console for error messages
2. Verify QBCore is working correctly
3. Test with debug mode enabled
4. Check portal coordinates are valid
5. Ensure proper resource loading order

## Changelog

### v2.0.0
- Complete rewrite with configurable system
- Multiple portal pairs support
- Admin commands for runtime management
- Debug mode
- Improved performance
- Better error handling

### v1.0.0
- Basic portal system
- Single portal pair
- Job restrictions (removed in v2.0)

## License

This script is provided as-is for OLRP server use.
# OLRP Speed Limit

A highly efficient and performance-friendly vehicle speed limiter for FiveM servers. This script limits vehicle speeds to a configurable maximum (default: 320 km/h) while maintaining excellent server performance.

## Features

- **Efficient Performance**: Frame-based checking system that scales well with high player counts
- **Configurable Speed Limit**: Set to 320 km/h by default, fully customizable
- **Direct Speed Limiting**: Uses SetVehicleMaxSpeed for reliable speed control
- **Emergency Vehicle Support**: Allow emergency vehicles to exceed limits
- **Admin Commands**: Full admin control over speed limiting
- **Violation Logging**: Track and log speed violations
- **Zone-Based Limits**: Different speed limits for different areas (optional)
- **Player Bypass**: Allow specific players to bypass speed limits
- **Clean Production Code**: No debug or test features for optimal performance

## Installation

1. Place the `olrp_speedlimit` folder in your server's resources directory
2. Add `ensure olrp_speedlimit` to your server.cfg
3. Configure the settings in `config.lua`
4. Restart your server

## Configuration

### Basic Settings

```lua
Config.Enabled = true                    -- Enable/disable the speed limiter
Config.MaxSpeed = 320.0                 -- Maximum speed in km/h
Config.CheckInterval = 500              -- Check interval in milliseconds
Config.EnforcementMethod = "maxspeed"   -- Uses SetVehicleMaxSpeed for direct limiting
```

### Performance Settings

```lua
Config.UseFrameBasedChecking = false    -- Not needed with SetVehicleMaxSpeed approach
Config.MaxVehiclesPerFrame = 5          -- Not needed with SetVehicleMaxSpeed approach
Config.SmoothnessFactor = 1.0           -- Not used with SetVehicleMaxSpeed approach
```

### Emergency Vehicles

```lua
Config.AllowEmergencyVehicles = true    -- Allow emergency vehicles to exceed limits
Config.EmergencyVehicleClasses = {18, 19}  -- Emergency vehicle classes
Config.EmergencyVehicleModels = {"police", "ambulance", "firetruk"}  -- Emergency models
```

## Admin Commands

- `/speedlimit [on/off/toggle/status/logs/save]` - Control speed limiting
- `/speedlimitplayer [playerid] [on/off]` - Control speed limiting for specific player

## Exports

```lua
-- Get current speed limit status
local status = exports['olrp_speedlimit']:getSpeedLimitStatus()

-- Toggle speed limit
local newStatus = exports['olrp_speedlimit']:toggleSpeedLimit(true)

-- Get violation logs
local logs = exports['olrp_speedlimit']:getViolationLogs()
```

## Performance Features

1. **Frame-Based Checking**: Only checks a limited number of vehicles per frame
2. **Efficient Loops**: Optimized checking intervals and conditions
3. **Memory Management**: Automatic cleanup of old violation logs
4. **Smart Notifications**: Prevents notification spam
5. **Conditional Enforcement**: Only applies limits when necessary

## Dependencies

- `ox_lib` (optional, for enhanced notifications)
- FiveM server with Lua 5.4 support

## Compatibility

- Compatible with all major frameworks (ESX, QBCore, vRP, etc.)
- Works with all vehicle types and modifications
- Supports custom vehicle models
- Compatible with other vehicle-related scripts

## Support

For support and updates, contact the OLRP development team.

## License

This script is protected by Tebex escrow system. Unauthorized distribution is prohibited.

# OLRP Speed Limit - Installation Guide

## Quick Installation

1. **Download and Extract**
   - Download the `olrp_speedlimit` resource
   - Extract it to your server's `resources` directory

2. **Add to Server Configuration**
   - Open your `server.cfg` file
   - Add the following line:
   ```
   ensure olrp_speedlimit
   ```

3. **Configure Settings**
   - Open `config.lua` in the `olrp_speedlimit` folder
   - Adjust settings according to your server needs
   - Default speed limit is set to 320 km/h

4. **Restart Server**
   - Restart your FiveM server
   - The script will automatically start

## Configuration Examples

### Basic Setup (320 km/h limit)
```lua
Config.Enabled = true
Config.MaxSpeed = 320.0
Config.EnforcementMethod = "hybrid"
```

### High Performance Setup
```lua
Config.CheckInterval = 100
Config.UseFrameBasedChecking = true
Config.MaxVehiclesPerFrame = 3
Config.SmoothnessFactor = 0.5
```

### Emergency Server Setup
```lua
Config.AllowEmergencyVehicles = true
Config.EmergencyVehicleModels = {
    "police", "police2", "police3", "police4",
    "ambulance", "firetruk", "lguard", "sheriff"
}
```

## Testing

1. **Join your server**
2. **Get in a vehicle**
3. **Try to exceed 320 km/h**
4. **You should see speed limiting in action**

## Admin Commands

- `/speedlimit status` - Check current status
- `/speedlimit on` - Enable speed limiting
- `/speedlimit off` - Disable speed limiting
- `/speedlimit logs` - View recent violations

## Troubleshooting

### Script Not Working
- Check that the resource is started: `restart olrp_speedlimit`
- Verify configuration in `config.lua`
- Check server console for errors

### Performance Issues
- Increase `Config.CheckInterval` to 100 or higher
- Reduce `Config.MaxVehiclesPerFrame` to 3 or lower
- Enable `Config.UseFrameBasedChecking`

### Speed Limit Not Applied
- Check if `Config.Enabled = true`
- Verify vehicle is not in excluded list
- Check if player has bypass permissions

## Support

For technical support, contact the OLRP development team.

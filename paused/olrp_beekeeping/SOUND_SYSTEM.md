# 🐝 Beehive Sound System Documentation

## Overview
The beekeeping script now includes immersive ambient sounds for both **placed beehives** and **wild beehives**, creating a more realistic and engaging experience for players.

---

## 🎵 Features

### Placed Beehive Sounds
- **Automatic Sound Management**: Sounds automatically play when a hive contains bees or queens
- **Dynamic Updates**: Sounds start/stop based on hive population
- **Proper Cleanup**: All sounds are cleaned up when hives are removed or player disconnects
- **3D Positional Audio**: Sounds are played at hive location with radius falloff

### Wild Beehive Sounds
- **Ambient Nature Sounds**: Wild hives emit buzzing/nature sounds
- **Persistent**: Sounds play continuously while wild hives are spawned
- **Auto-Respawn**: New hives automatically get sounds when they spawn
- **Performance Optimized**: Sounds use proper cleanup to prevent memory leaks

---

## ⚙️ Configuration

### Config Settings (`config.lua`)

#### Placed Beehive Sounds
```lua
Config.UseHiveSounds = true                              -- Enable/disable placed hive sounds
Config.HiveSoundName = "BEEHIVE_AMBIENT"                 -- Sound name from GTA sound bank
Config.HiveSoundBank = "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS" -- Sound bank to use
Config.HiveSoundVolume = 1.0                             -- Volume (0.0 to 1.0)
Config.HiveSoundRadius = 15.0                            -- Distance in meters where sound can be heard
```

#### Wild Beehive Sounds
```lua
Config.UseWildHiveSounds = true                          -- Enable/disable wild hive sounds
Config.WildHiveSoundName = "BIRDS_02"                    -- Buzzing/nature sound for wild hives
Config.WildHiveSoundBank = "ANIMALS_INSECT_LOCUSTS"     -- Sound bank
Config.WildHiveSoundRadius = 20.0                        -- Distance in meters where sound can be heard
```

---

## 🎮 Admin Commands

### Testing & Debugging

#### Placed Beehives
- `/togglehivesounds` - Toggle placed beehive sounds on/off
- `/listhivesounds` - List all active placed hive sounds (check F8 console)

#### Wild Beehives
- `/togglewildhivesounds` - Toggle wild hive sounds on/off
- `/listwildhivesounds` - List all active wild hive sounds (check F8 console)

---

## 🔧 Technical Details

### Sound Management System

#### Placed Beehives (`client.lua`)
```lua
-- Sound tracking
HiveSounds = {} -- Stores sound IDs for each hive

-- Function: ManageHiveSound(HiveID, Data)
-- Automatically manages sound playback based on hive population
-- Only plays if hive has bees or queens
```

#### Wild Beehives (`menu_events.lua`)
```lua
-- Sound tracking
WildHiveSounds = {} -- Stores sound IDs for wild hives

-- Functions:
-- StartWildHiveSound(hiveId, coords)  - Start sound at hive location
-- StopWildHiveSound(hiveId)           - Stop and cleanup sound
```

### Sound Cleanup
All sounds are properly cleaned up in the following scenarios:
- ✅ When a hive is removed/deleted
- ✅ When player disconnects
- ✅ When all hives are cleared
- ✅ When wild hives despawn/rotate
- ✅ When sounds are toggled off

---

## 🎨 Customization

### Using Different Sounds

You can change the sounds by modifying the config. Here are some alternatives:

#### For Placed Hives (Buzzing/Mechanical)
```lua
-- Option 1: Electrical buzz
Config.HiveSoundName = "MORSE_CODE_LOOP"
Config.HiveSoundBank = "HINT_CAM_SOUNDS"

-- Option 2: Mechanical hum
Config.HiveSoundName = "Idle"
Config.HiveSoundBank = "DLC_Dmod_Prop_Editor_Sounds"
```

#### For Wild Hives (Nature/Ambient)
```lua
-- Option 1: Birds chirping
Config.WildHiveSoundName = "BIRDS_01"
Config.WildHiveSoundBank = "ANIMALS_INSECT_LOCUSTS"

-- Option 2: General insects
Config.WildHiveSoundName = "BIRDS_02"
Config.WildHiveSoundBank = "ANIMALS_INSECT_LOCUSTS"
```

### Finding More Sounds
Browse GTA V native sounds here:
- [GTA V Sound References](https://altv.stuyk.com/docs/articles/tables/sound-names.html)
- Test sounds in-game using audio testing scripts

---

## 🐛 Troubleshooting

### Sounds Not Playing?

1. **Check Config**
   ```lua
   Config.UseHiveSounds = true        -- Make sure this is true
   Config.UseWildHiveSounds = true    -- For wild hives
   ```

2. **Verify Sound Banks**
   - Sound banks must exist in GTA V
   - Use `/listhivesounds` to check active sounds

3. **Check Population**
   - Placed hives only play sounds when they have bees/queens
   - Use F8 console to verify hive data

4. **Test Sound System**
   ```
   /togglehivesounds       -- Toggle and check console
   /listhivesounds         -- See active sounds
   ```

### Sounds Stuck/Not Stopping?

1. **Manual Cleanup**
   ```
   /togglehivesounds       -- Toggle off
   /togglewildhivesounds   -- Toggle off
   ```

2. **Restart Resource**
   ```
   restart olrp_beekeeping
   ```

3. **Check for Errors**
   - Open F8 console
   - Look for red error messages
   - Report issues with console logs

---

## 📊 Performance

### Optimization Features
- ✅ Sound IDs are properly tracked and cleaned up
- ✅ Uses `ReleaseSoundId()` to prevent memory leaks
- ✅ 3D positional audio with radius falloff
- ✅ Sounds only play when hives are active
- ✅ Automatic cleanup on player disconnect

### Expected Performance Impact
- **Minimal CPU usage** - Sounds are handled by game engine
- **Low memory footprint** - Proper cleanup prevents leaks
- **No network traffic** - Sounds are client-side only

---

## 🚀 Future Enhancements

Potential additions:
- [ ] Different sounds for bees vs wasps
- [ ] Volume adjustment based on hive population
- [ ] Intensity variation (calm vs angry bees)
- [ ] Weather-based sound effects
- [ ] Player proximity-based volume

---

## 📝 Notes

- Sounds are **client-side only** - no server performance impact
- Sounds respect **distance/radius** - fade out naturally
- **3D positional** - direction and distance matter
- Works with **any QBCore server**

---

## 🙏 Credits

Sound system developed for OneLifeRP beekeeping script
- Ambient sound integration
- Proper cleanup and optimization
- Admin commands for testing

---

**Last Updated**: October 2025
**Version**: 1.0.0


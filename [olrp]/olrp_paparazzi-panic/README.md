# 🎬 Paparazzi Panic - Celebrity Chaos Event

A dynamic and chaotic public event script for FiveM where random NPCs become celebrities, creating mayhem in the city!

## 📋 Features

- **🌟 Random Celebrity Events**: NPCs randomly become famous for 10 minutes
- **📸 Paparazzi NPCs**: Up to 15 AI paparazzi spawn and chase the celebrity
- **💰 Photo Rewards**: Players can take photos of the celebrity for money
- **🚔 Police Involvement**: PD must control crowds and handle kidnappings
- **😈 Kidnapping System**: Criminals can kidnap the celebrity for ransom
- **📍 Real-time Tracking**: Blips show celebrity location on map
- **⚡ Fully Configurable**: Customize all aspects via config.lua
- **📦 QBox Compatible**: Built for QBox (qbx-core), QB-Core, and ESX

## 📦 Installation

1. **Download & Extract**
   - Place `paparazzi-panic` folder in your `resources/[Fun]/` directory

2. **Add to server.cfg**
   ```cfg
   ensure paparazzi-panic
   ```

3. **Configure**
   - Edit `config.lua` to customize settings
   - Set your framework name if different from 'qb-core'

4. **Restart Server**
   ```
   restart paparazzi-panic
   ```

## 🎮 How to Play

### For Players
- **Take Photos**: Press `[E]` near the celebrity to take photos and earn money
- **Kidnap Celebrity**: Hold `[H]` near the celebrity to kidnap them (criminals)
- **Track Celebrity**: Follow the blip on your map

### For Police
- **Crowd Control**: Use `/crowdcontrol` to get paid for managing the crowd
- **Rescue Celebrity**: Use `/rescuecelebrity` near a kidnapped celebrity to save them
- **Monitor Situation**: Respond to kidnapping alerts

### For Administrators
- **Start Event**: `/startcelebrity` - Manually start a celebrity event
- **End Event**: `/endcelebrity` - Manually end the current event

## ⚙️ Configuration

### Framework Settings
```lua
Config.Framework = 'qbox'            -- 'qb-core', 'qbox', or 'esx'
Config.CoreName = 'qbx-core'         -- Resource name of your core
```

### Event Settings
```lua
Config.EventDuration = 600000        -- 10 minutes
Config.EventCooldown = 1800000       -- 30 minutes between events
Config.MinPlayers = 5                -- Minimum players to auto-start
Config.AutoStart = true              -- Auto-start events randomly
```

### Paparazzi Settings
```lua
Config.MaxPaparazzi = 15             -- Maximum paparazzi NPCs
Config.PaparazziFollowDistance = 3.0 -- How close they follow
Config.PaparazziSpawnInterval = 10000 -- Spawn frequency
```

### Kidnapping Settings
```lua
Config.KidnapEnabled = true
Config.KidnapDistance = 2.0
Config.KidnapTime = 10000            -- Time to kidnap (10 sec)
Config.RansomAmount = {min = 50000, max = 150000}
Config.RansomTimer = 300000          -- 5 minutes to pay
```

### Rewards
```lua
Config.PhotoReward = 100             -- Money per photo
Config.PoliceReward = 500            -- Crowd control bonus
Config.KidnapSuccessReward = 75000   -- Successful kidnap reward
Config.RescueReward = 15000          -- Police rescue reward
```

## 🎯 Spawn Locations

Default spawn locations include:
- Legion Square
- Airport
- Beach
- Mirror Park
- Paleto Bay
- Bahama Mamas
- Vanilla Unicorn area

Add more locations in `config.lua`:
```lua
Config.SpawnLocations = {
    vector4(x, y, z, heading),
    -- Add more locations...
}
```

## 🎭 Celebrity & Paparazzi Models

Customize NPC models in `config.lua`:
```lua
Config.CelebrityModels = {
    'a_f_y_bevhills_01',
    'a_m_y_business_01',
    -- Add more models...
}

Config.PaparazziModels = {
    'a_m_m_paparazzi_01',
    -- Add more models...
}
```

## 📱 Events (For Developers)

### Server-Side Events
```lua
-- Check if event is active
local isActive = exports['paparazzi-panic']:IsEventActive()

-- Get celebrity data
local celebData = exports['paparazzi-panic']:GetCelebrityData()

-- Start event manually
exports['paparazzi-panic']:StartEvent()

-- End event manually
exports['paparazzi-panic']:EndEvent()
```

### Client-Side Events
```lua
-- Listen for event start
RegisterNetEvent('paparazzi-panic:client:StartEvent')

-- Listen for event end
RegisterNetEvent('paparazzi-panic:client:EndEvent')

-- Listen for kidnap
RegisterNetEvent('paparazzi-panic:client:KidnapComplete')
```

## 🔧 Dependencies

- **QBox (qbx-core)** or **QBCore (qb-core)** or **ESX** framework
- Optional: **qb-target** or **ox_target** (set Config.UseTarget = true)

### Supported Frameworks
- ✅ **QBox** (qbx-core) - Fully Supported
- ✅ **QBCore** (qb-core) - Fully Supported  
- ⚠️ **ESX** - Configured but may need adjustments

## 🐛 Troubleshooting

### Event Won't Start
- Check minimum players requirement in config
- Verify cooldown has passed
- Check console for errors

### NPCs Not Spawning
- Ensure models exist in game files
- Check Config.MaxPaparazzi setting
- Verify spawn locations are valid

### Kidnapping Not Working
- Ensure Config.KidnapEnabled = true
- Check player is close enough (Config.KidnapDistance)
- Verify progressbar is working

## 📝 Commands & Controls

### Chat Commands
| Command | Permission | Description |
|---------|-----------|-------------|
| `/startcelebrity` | Admin | Manually start celebrity event |
| `/endcelebrity` | Admin | Manually end celebrity event |
| `/rescuecelebrity` | Police | Rescue kidnapped celebrity |
| `/crowdcontrol` | Police | Claim crowd control reward |

### In-Game Controls
| Key | Action | Notes |
|-----|--------|-------|
| **E** | Take Photo | Earn $100, 30 sec cooldown |
| **H** | Kidnap Celebrity | Hold for 10 seconds |

## 🎨 Customization Tips

1. **Change Event Frequency**: Adjust `Config.AutoStartInterval`
2. **More Chaos**: Increase `Config.MaxPaparazzi`
3. **Harder Kidnaps**: Increase `Config.KidnapTime`
4. **Better Rewards**: Adjust reward values in config
5. **Different Locations**: Add your custom spawn points

## 📊 Gameplay Balance

- **Photo Reward**: $100 (30 sec cooldown)
- **Kidnap Reward**: $75,000 (if successful)
- **Ransom Range**: $50,000 - $150,000
- **Police Rescue**: $15,000
- **Crowd Control**: $500

## 🔒 Police Features

Police officers can:
- Track celebrity and kidnappers via blips
- Rescue kidnapped celebrities
- Earn money for crowd control
- Receive priority alerts for kidnappings

## 💡 Tips for Server Owners

1. **Balance Rewards**: Adjust based on your economy
2. **Event Timing**: Set intervals based on player activity
3. **Spawn Locations**: Use high-traffic areas for more chaos
4. **Police Response**: Encourage PD participation with good rewards
5. **Discord Integration**: Add webhook logging (code included, commented)

## 📜 License

Created for OneLifeRP Development  
Version 1.0.0 - QBox/QBCore Compatible  
Free to use and modify for your server

## 🤝 Support

For issues or questions:
- Check config.lua for all settings
- Review console for error messages
- Test with minimum requirements met

## 🎬 Enjoy the Chaos!

Watch as your city descends into madness when celebrities appear! Perfect for:
- Creating dynamic public events
- Encouraging player interaction
- Generating criminal/police RP scenarios
- Adding spontaneous chaos to your server

**Have fun and may the best paparazzo win!** 📸⭐


# 🐝 Custom Bee Sounds - Setup Complete!

## ✅ What's Installed

Your beekeeping script now uses **TWO different real bee buzzing sounds**!

### Features
- 🎵 **Custom bee buzzing audio** - Different sounds for placed vs wild hives
- 📊 **Distance-based volume** - closer = louder, farther = quieter
- 🌍 **Server-side wild hive spawning** - All players see the same wild hives
- 🔄 **Automatic playback** every 5-6 seconds when near hives
- 🎚️ **Configurable** - adjust volume, radius, and frequency

### Sound Files
- **Placed Hives**: `bee_buzzing.mp3` (1.3MB, 40 seconds) - Placed hive buzzing sound
- **Wild Hives**: `wild_bee_buzzing.mp3` (438KB, 22 seconds) - Wild bee buzzing sound
- **Bee Sting**: `bee_sting.mp3` (15KB) - "Ouch!" sound when failing minigame

---

## 🎮 How It Works

### Placed Beehives
- When you're within **15 meters** of a hive with bees
- Plays **`bee_buzzing.mp3`** (40 seconds long) every **40 seconds**
- Volume increases as you get closer
- **Client-side**: Each player hears their own hives

### Wild Beehives  
- **SERVER-SIDE SPAWNING**: All players see the same wild hives!
- When you're within **20 meters** of a wild hive
- Plays **`wild_bee_buzzing.mp3`** (22 seconds long) every **22 seconds**
- Slightly quieter than placed hives (80% base volume)
- When collected, server removes it and spawns a new one for all players

### Bee Sting Effect
- **Fail the minigame** → Get stung by bees!
- Plays **`bee_sting.mp3`** ("Ouch!" sound effect)
- Triggers when you fail to catch wild bees
- Includes: Camera shake, health damage, ragdoll, screen effect

---

## ⚙️ Configuration

Edit `config.lua` to customize:

```lua
-- Placed Beehives
Config.UseHiveSounds = true              -- Enable/disable
Config.HiveSoundRadius = 15.0            -- Hearing distance (meters)
Config.HiveSoundCooldown = 40000         -- Play every 40 seconds (matches sound length)
Config.HiveSoundVolume = 1.0             -- Volume (0.0 to 1.0)

-- Wild Beehives
Config.UseWildHiveSounds = true          -- Enable/disable
Config.WildHiveSoundRadius = 20.0        -- Hearing distance (meters)
Config.WildHiveSoundCooldown = 22000     -- Play every 22 seconds (matches sound length)
Config.WildHiveSoundVolume = 0.8         -- Volume (80%)
```

### Customization Options

**Play sounds more often:**
```lua
Config.HiveSoundCooldown = 3000  -- Every 3 seconds
```

**Make them quieter:**
```lua
Config.HiveSoundVolume = 0.5  -- 50% volume
```

**Increase hearing range:**
```lua
Config.HiveSoundRadius = 25.0  -- Hear from 25 meters away
```

---

## 📁 File Structure

```
olrp_beekeeping/
├── html/
│   ├── index.html                ← Audio player HTML (3 audio elements)
│   ├── sound.js                  ← Sound control script
│   └── sounds/
│       ├── bee_buzzing.mp3       ← Placed hive sound (40s)
│       ├── wild_bee_buzzing.mp3  ← Wild hive sound (22s)
│       └── bee_sting.mp3         ← Bee sting sound effect (ouch!)
├── client/
│   ├── client.lua                ← Sound system for placed hives
│   └── menu_events.lua           ← Wild hives + bee sting effects
├── server/
│   └── server.lua                ← Server-side wild hive spawning
├── config.lua                    ← Sound settings
└── fxmanifest.lua                ← Resource config (includes UI + sounds)
```

---

## 🔧 Testing

1. **Restart the resource:**
   ```
   restart olrp_beekeeping
   ```

2. **Place a beehive and add bees**

3. **Stand next to it** - you should hear your custom bee buzzing sound!

4. **Check F8 console** for debug messages:
   ```
   [MMS-Beekeeper] Playing custom bee sound near hive X | Distance: Xm | Volume: 0.XX
   ```

---

## 🎵 Replacing Sounds

### Replace Placed Hive Sound:
1. Get your new sound file (MP3 format)
2. Replace: `olrp_beekeeping/html/sounds/bee_buzzing.mp3`
3. Restart: `restart olrp_beekeeping`

### Replace Wild Hive Sound:
1. Get your new sound file (MP3 format)
2. Replace: `olrp_beekeeping/html/sounds/wild_bee_buzzing.mp3`
3. Restart: `restart olrp_beekeeping`

**Important:** Keep the filenames or update `html/index.html` to reference new names.

---

## 🎚️ Volume Control

The volume automatically adjusts based on distance:

- **0 meters** (at hive) = 100% volume
- **7.5 meters** (half radius) = ~50% volume
- **15 meters** (max radius) = 10% volume (minimum)

This creates realistic 3D audio where sounds get quieter as you walk away!

---

## 🔍 Troubleshooting

### No Sound Playing?

1. **Check console (F8)** - look for:
   ```
   [MMS-Beekeeper] Hive X marked for sound
   ```

2. **Make sure hive has bees:**
   - Placed hives only play sound if they have bees/queens
   - Check hive menu to verify

3. **Check distance:**
   - Stand closer than 15 meters to the hive

4. **Verify file exists:**
   ```
   olrp_beekeeping/html/sounds/bee_buzzing.mp3
   ```

5. **Browser volume:**
   - Check in-game browser/NUI volume isn't muted

### Sound Too Loud/Quiet?

Adjust in `config.lua`:
```lua
Config.HiveSoundVolume = 0.3  -- Lower = quieter
```

### Sound Playing Too Often?

Increase cooldown:
```lua
Config.HiveSoundCooldown = 10000  -- Every 10 seconds
```

---

## 🎮 Commands

Debug commands for testing:

```
/togglehivesounds       - Toggle placed hive sounds on/off
/togglewildhivesounds   - Toggle wild hive sounds on/off
/listhivesounds         - List active hive sounds
/testbeep              - Test basic sound system
```

---

## 💡 How It Works Technically

1. **HTML5 Audio Player** (`html/index.html`)
   - Loads your MP3 file
   - Plays on command from Lua

2. **JavaScript Controller** (`html/sound.js`)
   - Receives messages from client
   - Controls playback and volume

3. **Lua Client Scripts**
   - Monitor player distance to hives
   - Send play commands to HTML UI
   - Adjust volume based on distance

4. **NUI Communication**
   - `SendNUIMessage()` triggers sound playback
   - Volume calculated in real-time

---

## 📝 Notes

- **No server impact** - sounds are client-side only
- **No external dependencies** - uses FiveM's built-in NUI system
- **MP3 format recommended** - best compatibility
- **File size** - your sound is 1.2MB (perfectly fine)
- **Performance** - minimal impact, plays from memory

---

## 🌍 Server-Side Wild Hives

### New Feature: Synchronized Wild Hives!

**Benefits:**
- ✅ All players see wild hives in the **same locations**
- ✅ Wild hives spawn on **server startup** (not per-player)
- ✅ When one player collects, hive despawns for **everyone**
- ✅ Server handles rotation every 30 minutes for **all players**
- ✅ No desync issues - everyone hears sounds at the same spots

### Admin Commands:
```
/spawnallwildhivesserver  - Spawn ALL wild hive locations (for testing)
/clearwildhivesserver     - Remove all wild hives from server
```

### How It Works:
1. Server spawns wild hives on startup
2. Server stores hive locations in memory
3. All clients receive and spawn the same hives
4. Sounds play client-side at server-synced locations
5. When collected, server notifies all clients to despawn

---

## 🎉 Enjoy!

Your beehives now have realistic custom bee sounds with server-side synchronization! 

**Created:** October 2025  
**Placed Hive Sound:** `bee_buzzing.mp3` (1.3MB, 40 seconds)  
**Wild Hive Sound:** `wild_bee_buzzing.mp3` (438KB, 22 seconds)  
**Bee Sting Sound:** `bee_sting.mp3` (15KB - ouch-sound-effect-30-11844.mp3)  
**Status:** ✅ Fully Operational with Server Sync + Custom Sting Sound!


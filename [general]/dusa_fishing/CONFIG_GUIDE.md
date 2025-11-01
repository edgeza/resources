# Fishing Configuration Guide

## 🎣 Fish Level System

This guide explains the new flexible fish level configuration system that allows you to customize level requirements per zone or globally.

---

## 📋 Fish List Formats

You can define fish in **two ways** throughout the configuration:

### 1. **Simple Format** (String)
Uses the default settings from `config.fish`:
```lua
fishList = {
    'mullet',
    'perch',
    'bass'
}
```

### 2. **Advanced Format** (Table)
Override specific settings (like `minLevel`) for specific zones:
```lua
fishList = {
    'mullet',  -- Simple format
    { name = 'bass', minLevel = 3 },  -- Advanced format with level override
    { name = 'tuna', minLevel = 2 }   -- Advanced format with level override
}
```

---

## 🌍 Outside Zones Configuration

The `config.outside` defines fish that can be caught **everywhere** (outside of special zones).

### Example Configuration:

```lua
config.outside = {
    fishList = {
        -- Simple format (uses default level from config.fish):
        'mullet',      -- Requires level 1 (from config.fish)
        'perch',       -- Requires level 1 (from config.fish)

        -- Advanced format (override level requirement):
        { name = 'bass', minLevel = 3 },  -- Requires level 3 outside (but level 2 in special zones)
        { name = 'carp', minLevel = 2 },  -- Requires level 2 outside
        { name = 'trout', minLevel = 2 }, -- Requires level 2 outside
        { name = 'tuna', minLevel = 4 },  -- Requires level 4 outside (harder to catch)
    }
}
```

### Use Cases:

#### ✅ **Scenario 1**: Allow all fish everywhere with default levels
```lua
config.outside = {
    fishList = {
        'mullet', 'perch', 'bass', 'carp', 'trout',
        'tuna', 'crab', 'lobster', 'turtle', 'octopus'
    }
}
```

#### ✅ **Scenario 2**: Make rare fish harder to catch outside zones
```lua
config.outside = {
    fishList = {
        'mullet',  -- Level 1
        'perch',   -- Level 1
        { name = 'bass', minLevel = 3 },    -- Level 3 outside (normally level 2)
        { name = 'tuna', minLevel = 4 },    -- Level 4 outside (normally level 3)
        { name = 'lobster', minLevel = 5 }, -- Level 5 outside (normally level 4)
    }
}
```

#### ✅ **Scenario 3**: Only common fish outside, rare fish in zones
```lua
config.outside = {
    fishList = {
        'mullet',
        'perch',
    }
}
```

---

## 🗺️ Fishing Zones Configuration

Special fishing zones can have their own fish lists with custom level requirements.

### Example Zone:

```lua
{
    blip = {
        enabled = true,
        name = 'Premium Fishing Spot',
        sprite = 317,
        color = 56,
        scale = 0.6
    },
    locations = {
        vec3(-1825.590, -1213.868, 13.017),
    },
    radius = 60.0,
    minLevel = 2,  -- Minimum level to enter this zone
    includeOutside = true,  -- Include fish from config.outside
    message = {
        enter = 'You have entered the premium fishing zone.',
        exit = 'You have left the premium fishing zone.'
    },
    fishList = {
        -- Simple format:
        'bass', 'crab', 'trout',

        -- Advanced format (override level for this zone):
        { name = 'tuna', minLevel = 2 },    -- Easier in this zone (normally level 3)
        { name = 'lobster', minLevel = 3 }, -- Easier in this zone (normally level 4)
    }
}
```

### Zone Options Explained:

| Option | Type | Description |
|--------|------|-------------|
| `minLevel` | number | Minimum fishing level required to enter the zone |
| `includeOutside` | boolean | If `true`, fish from `config.outside` will also spawn here |
| `fishList` | table | Fish that spawn in this zone (simple or advanced format) |

---

## 🎯 Common Configurations

### 1. **Beginner-Friendly Setup**
All fish available everywhere, no level restrictions:
```lua
config.outside = {
    fishList = {
        { name = 'mullet', minLevel = 1 },
        { name = 'perch', minLevel = 1 },
        { name = 'bass', minLevel = 1 },
        { name = 'carp', minLevel = 1 },
        { name = 'trout', minLevel = 1 },
        { name = 'tuna', minLevel = 1 },
        { name = 'crab', minLevel = 1 },
        { name = 'lobster', minLevel = 1 },
    }
}
```

### 2. **Zone-Focused Setup**
Only common fish outside, rare fish in special zones:
```lua
config.outside = {
    fishList = {
        'mullet',
        'perch',
    }
}

-- Then in your zones, add rare fish with custom levels
```

### 3. **Progressive Difficulty**
Make fish progressively harder outside of zones:
```lua
config.outside = {
    fishList = {
        'mullet',                           -- Level 1
        'perch',                            -- Level 1
        { name = 'bass', minLevel = 3 },    -- Level 3 (normally 2)
        { name = 'carp', minLevel = 3 },    -- Level 3 (normally 2)
        { name = 'trout', minLevel = 3 },   -- Level 3 (normally 2)
        { name = 'tuna', minLevel = 4 },    -- Level 4 (normally 3)
        { name = 'crab', minLevel = 4 },    -- Level 4 (normally 3)
    }
}
```

---

## 💡 Tips

1. **Backwards Compatible**: Old configurations (simple string format) still work perfectly
2. **Mix & Match**: You can mix simple and advanced format in the same list
3. **Zone Priority**: Level overrides in zones take priority over `config.fish` defaults
4. **Outside Priority**: Level overrides in `config.outside` take priority over `config.fish` defaults
5. **Testing**: Use `config.debug = true` to see which fish are available at your level

---

## 🐛 Troubleshooting

**Q: Fish not appearing even though I added them?**
A: Check the player's fishing level. They must meet the `minLevel` requirement.

**Q: Can I make fish easier in certain zones?**
A: Yes! Use advanced format: `{ name = 'tuna', minLevel = 2 }` in the zone's `fishList`.

**Q: How do I allow all fish everywhere?**
A: Add all fish names to `config.outside.fishList` using simple format, and set `includeOutside = true` in all zones.

---

## 📝 Version History

- **v1.2.5+**: Added advanced fish list format with per-zone level overrides
- **v1.2.0**: Original simple string format

---

*For more help, visit: https://dusadev.gitbook.io*

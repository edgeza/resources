# Enhanced Patreon Vehicle Management System

## Overview
This system ensures that Patreon vehicles are properly managed based on player tier levels. It automatically removes vehicles when players derank or lose access, and prevents unauthorized access to vehicles. **NEW**: It also automatically removes vehicles that are no longer in the Patreon configuration from ALL players' garages. **🆕 VEHICLE TYPE SYSTEM**: Vehicles are now categorized by type (car, boat, air) and stored in appropriate garages.

## Key Features

### 1. Automatic Vehicle Removal
- **Tier 0**: All Patreon vehicles are automatically removed
- **Deranking**: Vehicles from higher tiers are removed when players drop to lower tiers
- **Real-time Sync**: Changes take effect immediately when tier is modified
- **🆕 Config Cleanup**: Vehicles removed from `patreon.lua` are automatically removed from ALL players
- **🆕 Vehicle Type System**: Vehicles are stored in appropriate garages based on their type

### 2. Enhanced Security
- Vehicles are completely hidden from the garage UI when players lack access
- No more "Patreon Locked" state - vehicles simply don't appear
- Automatic cleanup of garage keys when vehicles are removed
- **🆕 Automatic cleanup when vehicles are removed from configuration**
- **🆕 Type-specific garage storage**: Cars, boats, and air vehicles stored in appropriate garages

### 3. Admin Commands

#### `setpatreontier [playerid] [tier]`
- Sets a player's Patreon tier (0-4)
- Automatically syncs vehicles (grants new ones, removes disallowed ones)
- **ADMIN ONLY**: Can be used by admins to set their own tier or others' tiers

#### `cleanuppatreon [playerid]`
- Manually triggers cleanup for a specific player or all online players
- **🆕 Also cleans up vehicles that are no longer in the Patreon configuration**
- Useful for maintenance or fixing inconsistencies
- Admin-only command

#### `cleanupremovedpatreon`
- **🆕 NEW**: Manually triggers cleanup of vehicles that are no longer in the Patreon configuration
- Removes these vehicles from ALL players' garages
- Admin-only command

#### `anchorpatreon [playerid]`
- **🆕 ENHANCED**: Moves all Patreon vehicles to appropriate garages based on vehicle type
- Cars → Patreon Hub, Boats → Patreon Harbor, Air → Patreon Airfield
- Useful for organizing vehicles by type

## How It Works

### Vehicle Granting
1. When a player's tier is set, the system checks what vehicles they should have access to
2. **🆕 NEW**: Vehicles are categorized by type (car, boat, air)
3. **🆕 NEW**: Vehicles are stored in appropriate garages based on their type
4. Missing vehicles are automatically created and placed in the correct garage
5. Vehicles are only granted if tier > 0

### Vehicle Removal
1. System identifies all Patreon vehicles owned by the player
2. Compares against current tier access level
3. Removes vehicles that are no longer allowed
4. Cleans up associated garage keys
5. Notifies player about removed vehicles

### 🆕 Configuration-Based Cleanup
1. **Automatic**: Runs every time the resource starts
2. **Manual**: Can be triggered with `/cleanupremovedpatreon`
3. **Comprehensive**: Checks ALL players' garages for removed vehicles
4. **Safe**: Only removes vehicles marked as Patreon (all garage types)
5. **🆕 Type-aware**: Handles vehicles in all Patreon garage types

### 🆕 Vehicle Type System
1. **Cars**: Stored in "Patreon Hub" garage
2. **Boats**: Stored in "Patreon Harbor" garage  
3. **Air Vehicles**: Stored in "Patreon Airfield" garage
4. **Automatic Detection**: System automatically determines vehicle type
5. **Proper Storage**: Vehicles can only be stored in garages of the correct type

### Access Control
1. Vehicles are completely hidden from garage UI when access is denied
2. No "locked" state - vehicles simply don't appear
3. Automatic filtering based on current tier
4. **🆕 Type-specific access**: Players can only access vehicles in appropriate garage types

## Configuration

### Patreon Tiers (`configs/patreon.lua`)
```lua
Config.PatreonTiers = {
    ENABLE = true,
    DEBUG = true,
    lookup_mode = 'metadata', -- 'metadata', 'job', or 'group'
    metadata_key = 'patreon_tier',
    default_tier = 0,
    inherit = true, -- tier N includes all tiers < N
    
    -- 🆕 NEW: Vehicles are now categorized by type
    tiers = {
        [1] = { 
            cars = { 'pd1', '23rnr' },
            boats = {},
            air = {}
        },
        [2] = { 
            cars = { '22m4rb', '2138p' },
            boats = {},
            air = {}
        },
        [3] = { 
            cars = { 'mclarenpd', 'gtrbb' },
            boats = {},
            air = {}
        },
        [4] = { 
            cars = { 'flatbed99', 'sf90' },
            boats = {},
            air = { 'frogger' }  -- 🚁 Air vehicles stored in Patreon Airfield
        },
    },
}
```

**Important**: 
- When you remove a vehicle from this configuration, it will be automatically removed from ALL players' garages
- **🆕 NEW**: Vehicles are automatically stored in appropriate garages based on their type
- **🆕 NEW**: Air vehicles like 'frogger' can only be stored at air garages

## Database Tables Affected

### `player_vehicles`
- Vehicles are added/removed based on tier changes
- **🆕 NEW**: Patreon vehicles are stored in type-specific garages:
  - Cars: `garage_id = 'Patreon Hub'`, `garage_type = 'car'`
  - Boats: `garage_id = 'Patreon Harbor'`, `garage_type = 'boat'`
  - Air: `garage_id = 'Patreon Airfield'`, `garage_type = 'air'`
- **🆕 NEW**: Vehicles no longer in config are automatically removed from ALL garage types

### `cd_garage_keys`
- Associated keys are automatically cleaned up when vehicles are removed

## Debugging

When `Config.PatreonTiers.DEBUG = true`, the system logs:
- Tier lookups and resolutions
- Vehicle granting operations
- Vehicle removal operations
- Player notifications
- Database operations
- **🆕 Configuration cleanup operations**
- **🆕 Vehicle type detection and garage assignment**

## Usage Examples

### Setting a player to tier 0 (removes all Patreon vehicles)
```
/setpatreontier 1 0
```

### Setting a player to tier 2 (grants tier 1 and 2 vehicles)
```
/setpatreontier 1 2
```

### Cleanup all players' Patreon vehicles + removed config vehicles
```
/cleanuppatreon
```

### Cleanup specific player
```
/cleanuppatreon 1
```

### 🆕 Cleanup vehicles that are no longer in Patreon config
```
/cleanupremovedpatreon
```

### 🆕 Anchor vehicles to appropriate garages by type
```
/anchorpatreon 1
```

## 🆕 New: Vehicle Type Management

### Vehicle Type Categories
The system automatically detects and categorizes vehicles:

- **Cars**: All ground vehicles (default)
- **Boats**: Watercraft like dinghy, jetmax, marquis, etc.
- **Air**: Helicopters and planes like frogger, maverick, buzzard, etc.

### Garage Storage
- **Patreon Hub**: Stores all car-type vehicles
- **Patreon Harbor**: Stores all boat-type vehicles  
- **Patreon Airfield**: Stores all air-type vehicles

### Benefits of Type System
1. **Proper Storage**: Vehicles can only be stored in garages of the correct type
2. **No More Errors**: Air vehicles like 'frogger' won't cause storage issues
3. **Better Organization**: Players can easily find vehicles by type
4. **Garage Compatibility**: Follows the same rules as the main garage system

## 🆕 New: Configuration Management

### Removing Vehicles from Patreon Config
When you remove a vehicle spawncode from `configs/patreon.lua`:

1. **Automatic Cleanup**: The vehicle will be automatically removed from ALL players' garages on resource restart
2. **Manual Cleanup**: Use `/cleanupremovedpatreon` to immediately remove them
3. **Safe Operation**: Only affects vehicles marked as Patreon (all garage types)
4. **🆕 Type-aware**: Handles vehicles in all Patreon garage types

### Example Scenario
```lua
-- Before: Tier 4 has 'frogger' helicopter in air category
[4] = { 
    cars = { 'flatbed99', 'sf90' },
    boats = {},
    air = { 'frogger' }
}

-- After: Remove 'frogger' from config
[4] = { 
    cars = { 'flatbed99', 'sf90' },
    boats = {},
    air = {}
}
```

**Result**: All `frogger` helicopters will be automatically removed from ALL players' garages, regardless of their tier.

## Troubleshooting

### Vehicles not being removed
1. Check if `Config.PatreonTiers.ENABLE = true`
2. Verify tier is actually set to 0 or lower tier
3. Run `/cleanuppatreon [playerid]` to force cleanup
4. Check debug logs for errors

### Vehicles still showing in garage
1. Ensure the vehicle is properly configured in the tiers table
2. Check if the vehicle has the correct `garage_id` and `garage_type`
3. Verify player tier is correct
4. Run cleanup command

### 🆕 Vehicles removed from config still showing
1. Run `/cleanupremovedpatreon` to force immediate cleanup
2. Restart the resource to trigger automatic cleanup
3. Check debug logs for cleanup operations
4. Verify the vehicle was actually removed from `patreon.lua`

### 🆕 Vehicle type issues
1. Check if vehicle is in the correct category (cars, boats, air)
2. Verify the vehicle is stored in the appropriate garage
3. Ensure the garage type matches the vehicle type
4. Use `/anchorpatreon` to fix garage assignments

### Performance considerations
- Vehicle operations are batched for efficiency
- Database queries are optimized with proper indexing
- Cleanup operations run asynchronously
- **🆕 Configuration cleanup runs once per resource start**
- **🆕 Vehicle type detection is cached for performance**

## Security Notes

- All admin commands require proper permissions
- Vehicle removal is permanent - ensure backups before testing
- System validates all inputs and prevents SQL injection
- Player notifications inform them of vehicle changes
- **🆕 Configuration changes automatically propagate to all players**
- **🆕 Vehicle type system prevents storage in wrong garage types**

## Future Enhancements

- Backup system for removed vehicles
- Gradual vehicle removal (warning system)
- Vehicle transfer between players
- Audit logging for all operations
- **🆕 Configuration change notifications for admins**
- **🆕 Custom vehicle type definitions**
- **🆕 Garage type validation and error reporting**

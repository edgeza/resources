# Mileage Tracking Module

**Version**: 1.0.0
**Status**: Active
**Dependencies**: oxmysql, dusa_bridge

## Overview

Self-contained module for tracking vehicle mileage in the Dusa Garage Management System. Tracks distance traveled by players' vehicles and stores cumulative mileage in the database.

## Features

- ✅ Real-time distance tracking using vector calculations
- ✅ Periodic server synchronization (every 5 minutes or on vehicle exit)
- ✅ Speed-based filtering (only tracks when moving > 5 km/h)
- ✅ Configurable unit system (kilometers or miles)
- ✅ Optional odometer UI with multiple display modes
- ✅ Framework-agnostic (works with ESX, QBCore, QBox)
- ✅ Performance-optimized (< 0.02ms resmon target)

## Configuration

Edit `modules/mileage/config.lua` to customize behavior:

```lua
MileageConfig = {
    enabled = true,  -- Master switch

    tracking = {
        updateInterval = 1000,        -- Position check interval (ms)
        serverSyncInterval = 300000,  -- Database sync interval (5 min)
        minSpeed = 5.0,               -- Minimum speed to track (km/h)
        excludedVehicleClasses = {13, 14, 15, 16, 17, 21}
    },

    ui = {
        enabled = true,               -- Show odometer
        displayMode = "show_on_enter", -- Display mode
        unit = "kilometers"           -- Unit system
    }
}
```

### Display Modes

- **show_on_enter**: Show odometer for 10 seconds when entering vehicle, then fade out
- **always**: Always visible while driving
- **first_person**: Only visible in first-person camera mode

### Unit System

- **kilometers**: Display and track in kilometers (default)
- **miles**: Display in miles (database stores kilometers, converts for display)

## Database Schema

Requires `dusa_vehicle_metadata` table with `mileage` column:

```sql
CREATE TABLE IF NOT EXISTS `dusa_vehicle_metadata` (
    `plate` VARCHAR(15) PRIMARY KEY,
    `mileage` FLOAT DEFAULT 0.0 COMMENT 'Total distance traveled in kilometers',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_mileage` (`mileage`)
);
```

## API

### Server Export

```lua
-- Get vehicle mileage by plate
local mileage = exports['dusa_garage']:GetVehicleMileage('ABC123')
```

### Server Events

- `dusa-garage:server:updateMileage` - Internal event for client-to-server sync

## Architecture

- **Client** (`client.lua`): Tracks player movement, calculates distance, manages UI updates
- **Server** (`server.lua`): Handles database synchronization, validation, rate limiting
- **Config** (`config.lua`): Centralized configuration

## Disabling the Module

To disable mileage tracking:

1. Set `MileageConfig.enabled = false` in `config.lua`
2. Restart resource

No code changes required.

## Performance

- Target: < 0.02ms resmon impact
- Updates position every 1 second (only when moving)
- Batches database writes (every 5 minutes + vehicle exit)
- Early exit patterns for minimal overhead

## Future Extensibility

This module provides foundation for:
- Fuel consumption tracking
- Vehicle maintenance scheduling
- Wear and tear simulation
- Insurance/service reminders

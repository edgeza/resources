# Military Heist - Military Base

A QBCore/QBox compatible military heist script that creates a restricted military area at a custom military base location with patrolling military units that will engage unauthorized personnel.

## Features

- **Military NPCs**: Spawns heavily armed and armored military units with high accuracy
- **Job-Based Targeting**: Military units will NOT shoot players with police or ambulance jobs
- **Patrol System**: Units patrol designated routes around the military base area
- **Dynamic Spawning**: Units spawn when players enter the restricted area
- **Real-time UI**: Shows military status, unit count, and player authorization status
- **Configurable**: Fully customizable through config.lua

## Installation

1. Place the `olrp_militaryheist` folder in your `resources/[Stitch_Scripts]` directory
2. Add `ensure olrp_militaryheist` to your server.cfg
3. Restart your server

## Configuration

Edit `config.lua` to customize:

- **Military Base Location**: Four corner points defining the restricted zone
- **Military Units**: Weapon types, armor, health, accuracy
- **Patrol Routes**: Different patrol patterns (perimeter, inner, structure)
- **Detection Ranges**: How far units can detect and engage players
- **Excluded Jobs**: Jobs that won't be targeted (police, ambulance, doctor)
- **Spawn Settings**: Maximum units, respawn time, spawn distance

## Commands

- `/militaryheist_start` - Start the heist (Admin only)
- `/militaryheist_stop` - Stop the heist (Admin only)
- `/militaryheist_status` - Check heist status (Admin only)

## How It Works

1. **Area Detection**: When players enter the military base area (defined by four corner points), the system activates
2. **Unit Spawning**: Military units spawn around the base with different weapon types
3. **Patrol Behavior**: Units follow designated patrol routes when not engaged
4. **Job Checking**: System checks player jobs - police and ambulance are safe
5. **Combat Engagement**: Units engage unauthorized players with high accuracy
6. **Dynamic Response**: Units alert each other and coordinate attacks

## Military Unit Types

- **Black Ops 01**: Assault Rifle + Pistol, 200 armor/health, 85% accuracy
- **Black Ops 02**: Assault Rifle + Pistol, 200 armor/health, 85% accuracy  
- **Black Ops 03**: Assault Rifle + Pistol, 200 armor/health, 85% accuracy
- **Ammunition Specialist**: Assault Rifle + Pistol, 200 armor/health, 85% accuracy
- **Army Mechanic**: Assault Rifle + Pistol, 200 armor/health, 85% accuracy

### Military Weapons:
- **Primary Weapon**: Assault Rifle (all units) - MUST be used for shooting trespassers
- **Secondary Weapon**: Pistol (backup weapon for extreme close range only)
- **Combat Style**: Aggressive military combat with long-range engagement
- **Armor**: Heavy military armor (200 points)
- **Accuracy**: High accuracy (85%) with military training
- **Total Units**: 50 military units patrolling the area
- **Weapon Priority**: Assault rifles are ALWAYS used when engaging enemies

## Patrol Routes

- **Perimeter**: Outer boundary patrol around the military base
- **Inner**: Closer to base structures
- **Structure**: Direct base access points

## Heist Restart System

- **50 Military Units**: Total units patrolling the military base
- **All Units Must Be Killed**: Players must eliminate all 50 units to complete the heist
- **1 Hour Restart Timer**: After all units are killed, the heist restarts in 1 hour
- **Automatic Respawn**: New units spawn after the restart timer expires
- **Despawn Timer**: Dead units despawn after 10 seconds

## Safety Features

- Police and ambulance jobs are completely safe
- Units won't spawn if no players are in the area
- Automatic cleanup of dead units
- Configurable respawn timers

## Dependencies

- qb-core
- oxmysql

## Support

For issues or questions, contact the OneLifeRP Development team.

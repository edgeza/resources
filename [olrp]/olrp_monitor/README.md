# OLRP Economy Monitor

**by OLRP**

An advanced economy monitoring system for FiveM servers with a beautiful glass morphism UI and comprehensive abuse detection.

## Features

### 🎨 Modern UI/UX
- **Glass Morphism Design** - Beautiful frosted glass effects with dark mode
- **Sidebar Navigation** - Easy access to all monitoring features
- **Responsive Layout** - Optimized for all screen sizes
- **Smooth Animations** - Polished transitions and hover effects

### 📊 Dashboard
- Real-time economy statistics
- Total economy value tracking
- Cryptocurrency monitoring
- Vehicle count across all players
- Average networth calculations
- Top 10 richest players display
- Wealth distribution visualization

### 👥 Player Management
- Complete player economy data
- Cash, Bank, and Crypto tracking
- Vehicle count per player
- Item count per player
- Networth calculations
- Advanced search and filtering
- Sortable columns
- Pagination support

### ⚠️ Abuse Detection
- Automatic flagging of suspicious players
- High cash threshold detection
- High bank threshold detection
- Excessive vehicle detection
- Extreme networth detection
- Suspicious item count detection
- Detailed abuse flags per player

### 📈 Statistics
- Cash distribution analysis
- Bank distribution analysis
- Vehicle statistics
- Networth analysis
- Median and average calculations
- Top 1% wealth tracking

## Installation

1. Place the `olrp_monitor` folder in your server's `resources` directory
2. Add `ensure olrp_monitor` to your `server.cfg`
3. Configure the settings in `config.lua`
4. Restart your server

## Configuration

Edit `config.lua` to customize:

- **AllowedGroups** - Groups that can use the monitor
- **AbuseThresholds** - Thresholds for flagging suspicious activity
- **VehicleBaseValue** - Base value for vehicle networth calculations
- **DatabaseTables** - Your database table names
- **Texts** - All UI text labels

## Commands

- `/olrpmonitor` - Open the economy monitor interface
- `/richestplayers` - Legacy command (still supported)

## Requirements

- **ox_lib** - For notifications and UI components
- **oxmysql** - For database queries
- **qbx_core** - For permission checking (or modify for your framework)

## Database Structure

The script expects the following database structure:

- `players` table with:
  - `citizenid` (string)
  - `charinfo` (JSON)
  - `money` (JSON)

- `player_vehicles` table with:
  - `citizenid` (string)

- Inventory system (supports multiple):
  - `ox_inventory` table
  - `player_inventories` table
  - `items` column in `players` table (JSON)

## Features Breakdown

### Dashboard Page
- Overview of server economy
- Key statistics at a glance
- Top players leaderboard
- Wealth distribution tiers

### Players Page
- Complete player list with all economy data
- Search by name or citizenid
- Filter by: All, Suspicious, Top 100
- Sort by: Networth, Cash, Bank, Crypto, Vehicles, Items
- Pagination for large datasets
- Click player row to view details

### Abuse Detection Page
- Flagged players overview
- Breakdown by abuse type
- Quick access to suspicious players
- Detailed flag information

### Statistics Page
- Comprehensive analytics
- Distribution analysis
- Median and average calculations
- Vehicle value tracking

## Player Details Modal

Click any player in the table to view:
- Full player information
- All economy metrics
- Abuse flags (if any)
- Detailed breakdown

## Export Functionality

Export all economy data as JSON:
- Click "Export Data" button
- Downloads complete dataset
- Includes timestamp and all player data

## Customization

### Themes
The UI uses CSS variables for easy theming. Modify `:root` in `style.css` to change colors.

### Abuse Thresholds
Adjust thresholds in `config.lua`:
```lua
Config.AbuseThresholds = {
    maxCash = 10000000,
    maxBank = 50000000,
    maxVehicles = 50,
    maxNetworth = 100000000,
    suspiciousItemCount = 1000
}
```

## Support

For issues or questions, contact OLRP support.

## License

This resource is provided by OLRP.

---

**Version:** 2.0.0  
**Author:** OLRP  
**Framework:** QBX/QB Compatible

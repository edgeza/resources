# OLRP Boss Menu

A modern, midnight red-themed boss management system for FiveM servers using QB-Core/QBox framework.

## Features

- 🎨 **Modern Midnight Red UI** - Sleek, dark theme with red accents
- 👥 **Employee Management** - Hire, fire, and manage employee ranks
- 💰 **Society Banking** - Deposit, withdraw, and transfer funds
- 📋 **Job Applications** - Review and manage job applications
- 🔐 **Permission System** - Granular access control for employees
- 📊 **Analytics Dashboard** - Employee statistics and activity charts
- ⚙️ **Customizable Settings** - Dark mode, themes, and preferences

## Installation

### 1. Database Setup

Import the SQL file into your database:
```sql
-- Simply copy and paste the entire bossmenusql.sql file into your database management tool
-- The file contains clean, ready-to-use SQL statements with proper comments
```

This creates the following tables:
- `job_applications` - Stores job applications
- `job_employee_permissions` - Employee permission settings
- `job_manager_settings` - User interface settings
- `job_playtime` - Employee playtime tracking
- `society` - Society bank accounts
- `society_transactions` - Transaction history

### 2. Resource Installation

1. Place the `OLRP-bossmenu` folder in your `resources` directory
2. Add `ensure OLRP-bossmenu` to your `server.cfg`
3. Restart your server

### 3. Dependencies

Make sure you have these resources installed:
- `qb-core` or `qbx_core`
- `oxmysql`
- `qb-target` or `ox_target`

## Configuration

### Job Ranks and Salaries

Configure job ranks and salaries in `qb-core/shared/jobs.lua`:

```lua
['police'] = {
    label = 'Law Enforcement',
    grades = {
        [0] = {
            name = 'Cadet',
            payment = 2000
        },
        [1] = {
            name = 'Officer',
            payment = 2500
        },
        [9] = {
            name = 'Assistant Chief',
            isboss = true,        -- Gives boss menu access
            payment = 6000
        },
        [10] = {
            name = 'Chief',
            isboss = true,        -- Gives boss menu access
            payment = 8000
        },
    },
},
```

**Key Points:**
- `payment` = Salary amount
- `isboss = true` = Gives access to boss menu
- `bankAuth = true` = Gives access to society banking

### Boss Menu Access Locations

Configure access points in `config.lua`. The system includes locations for all major jobs:

```lua
Config.Locations = {
    ["police"] = {
        label = "Police Department",
        logoImage = "police.png",
        locations = {
            {
                coords = vector3(448.25, -973.38, 30.69), -- Main Police Station
                width = 1.0,
                length = 1.0,
                heading = 144,
                minZ = 30.0,
                maxZ = 31.0,
            },
        }
    },
    ["ambulance"] = {
        label = "EMS Department",
        logoImage = "ems.png",
        locations = {
            {
                coords = vector3(446.29, -978.88, 30.69), -- Main Hospital
                width = 1.0,
                length = 1.0,
                heading = 123.06,
                minZ = 30.0,
                maxZ = 31.0,
            },
        }
    },
    -- ... and many more jobs
}
```

**Included Jobs:**
- **Police** - Law enforcement with multiple stations
- **Ambulance** - EMS with hospital locations  
- **Mechanic** - Vehicle repair services
- **Mechanic3** - OneLife Mechanics
- **Bean Machine** - Coffee shop chain
- **Cat Cafe** - Cat-themed cafe
- **Up n Atom** - Restaurant chain
- **BurgerShot** - Fast food restaurant
- **Billiards** - Pool hall
- **Sky Bar** - High-end bar
- **Bahamas** - Nightclub
- **Skydiving** - Adventure sports
- **Lost MC** - Motorcycle club
- **Ballas** - Gang territory
- **Events** - Event management

### Adding New Jobs

1. **Add job configuration:**
```lua
["yourjob"] = {
    label = "Your Job Name",
    logoImage = "yourjob.png",
    locations = {
        {
            coords = vector3(x, y, z), -- Your coordinates
            width = 1.0,
            length = 1.0,
            heading = 0,
            minZ = z - 1.0,
            maxZ = z + 1.0,
        }
    }
},
```

2. **Add logo image** to `html/images/yourjob.png` (120x120px recommended)

3. **Configure job in qb-core/shared/jobs.lua** with boss grades

### Application System

Configure job applications in `config.lua`:

```lua
Config.ApplicationPoints = {
    ["police"] = {
        coords = vector3(441.53604, -980.1955, 30.795989),
        width = 1.0,
        length = 1.0,
        heading = 0,
        minZ = 30.0,
        maxZ = 31.0,
        label = "Police Application"
    },
}

Config.ApplicationQuestions = {
    ["police"] = {
        {
            question = "Why do you want to join the Police Department?",
            type = "text",
            required = true,
            min = 1,
            max = 1024
        },
        {
            question = "Do you have any previous law enforcement experience?",
            type = "select",
            options = {"Yes", "No"},
            required = true
        },
    }
}
```

## Usage

### For Bosses

1. **Access the boss menu** at configured locations
2. **Manage employees** - hire, fire, change ranks
3. **Handle society finances** - deposits, withdrawals, transfers
4. **Review applications** - accept/reject job applications
5. **Set permissions** - control employee access levels

### For Employees

1. **Submit applications** at application points
2. **Check application status** through the system
3. **Access granted features** based on permissions

## Customization

### UI Themes

The system supports multiple themes:
- **Midnight Red** (default) - Dark theme with red accents
- **Blue** - Classic blue theme
- **Purple** - Purple accent theme
- **Green** - Green accent theme
- **Orange** - Orange accent theme

### Settings

Users can customize:
- Dark/Light mode
- Theme colors
- Animation preferences
- Display options
- Notification sounds
- Refresh intervals

## Banking System Support

The system supports multiple banking systems:
- `qb-banking` (default)
- `olrp-banking`
- `renewed-banking`

Configure in `config.lua`:
```lua
Config.BankingSystem = "qb-banking"
```

## Target System Support

Supports both target systems:
- `qb-target` (default)
- `ox_target`

Configure in `config.lua`:
```lua
Config.TargetSystem = "qb-target"
```

## Troubleshooting

### Common Issues

1. **Boss menu not opening:**
   - Check if player has `isboss = true` in their job grade
   - Verify coordinates in `Config.Locations`
   - Ensure target system is working

2. **Society banking not working:**
   - Check banking system configuration
   - Verify society account exists in database
   - Ensure player has `bankAuth = true`

3. **Applications not showing:**
   - Check application points configuration
   - Verify questions are properly configured
   - Ensure application system is enabled

### Database Issues

If you encounter database errors:
1. Ensure all tables are created properly
2. Check MySQL connection
3. Verify table permissions

## Support

For support and updates, contact the OLRP development team.

## Credits

- Original script adapted by OLRP
- Adapted for OLRP with midnight red theme
- QB-Core/QBox framework integration

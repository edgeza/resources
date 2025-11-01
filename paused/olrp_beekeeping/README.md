# 🐝 MMS Beekeeping Script - QBCore Integration

## Complete Advanced Beekeeping System for QBCore

This is a fully converted and enhanced version of the MMS Beekeeping script, originally designed for VORP Core, now fully integrated with QBCore framework.

## ✨ Features

### 🏠 **Beehive Management**
- Place and manage your own beehives
- Add queen bees and worker bees
- Collect honey from your hives
- Delete hives when no longer needed
- Auto-destroy inactive hives

### 🌿 **Bee Care System**
- **Feeding**: Feed bees with sugar
- **Watering**: Water bees with water bottles
- **Cleaning**: Clean hives with wheat
- **Healing**: Heal sick bees with potatoes
- **Health Monitoring**: Track bee health and happiness

### 🦠 **Advanced Systems**
- **Sickness System**: Bees can get sick and need medicine
- **Happiness System**: Happy bees produce more honey
- **Death System**: Bees can die if not properly cared for
- **Helper System**: Assign helpers to manage your hives

### 🌲 **Wild Beehives**
- Find and interact with wild beehives
- Collect bees, queens, and honey from wild sources
- Use specialized tools (smoker, bug net)
- Risk getting stung by wild bees

### 🛠️ **Tools & Items**
- Beehive boxes for placement
- Queen bees and worker bees
- Bee smokers and bug nets
- Empty jars for collection
- Various food and medicine items

## 🚀 Installation

### 1. Database Setup
Run the following SQL in your database:

```sql
CREATE TABLE `mms_beekeeper` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`ident` VARCHAR(50) NULL DEFAULT NULL COLLATE 'armscii8_general_ci',
	`charident` VARCHAR(50) NULL DEFAULT NULL COLLATE 'armscii8_general_ci',
	`coords` LONGTEXT NULL DEFAULT '{"x":0,"y":0,"z":0}' COLLATE 'utf8mb3_general_ci',
	`heading` FLOAT NULL DEFAULT 0,
	`data` LONGTEXT NULL DEFAULT '{}' COLLATE 'utf8mb3_general_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='armscii8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;
```

### 2. Server Configuration
Add to your `server.cfg`:
```
ensure mms-beekeeper
```

### 3. Dependencies
Make sure you have these resources installed:
- `qb-core`
- `oxmysql`
- `qb-menu` (for the interaction menu)
- `qb-input` (for input dialogs)

## 🎮 How to Use

### Getting Started
1. Use `/getbeehive` to get a beehive box
2. Use `/getbeeitems` to get all necessary items
3. Use the beehive box to place a hive
4. Add queen bees and worker bees to your hive
5. Maintain your hive by feeding, watering, and cleaning

### Commands
- `/getbeehive` - Get a beehive box
- `/getbeeitems` - Get all bee-related items

### Basic Workflow
1. **Place Hive**: Use beehive box item
2. **Add Queen**: Use queen bee item on hive
3. **Add Bees**: Use bee jars on hive
4. **Maintain**: Feed, water, and clean regularly
5. **Collect**: Harvest honey when ready
6. **Monitor**: Check bee health and happiness

## 🔧 Configuration

### Key Config Settings
- `Config.MaxBeehivesPerPlayer` - Maximum hives per player
- `Config.MaxBeesPerHive` - Maximum bees per hive
- `Config.UpdateTimer` - How often the system updates (minutes)
- `Config.WildBeehiveSpawn` - Enable/disable wild beehives
- `Config.BeesCanBeHappy` - Enable happiness system
- `Config.BeesCanDie` - Enable bee death system
- `Config.BeesCanBeSick` - Enable sickness system

### Bee Types
The script supports multiple bee types:
- **Basic Bees**: Standard honey production
- **Hornets**: Produce premium Manuka honey

## 📊 Systems Explained

### Honey Production
- Bees produce honey based on their happiness
- Happy bees (well-fed, watered, clean) produce more honey
- Unhappy bees produce less honey
- 60 product units = 1 jar of honey

### Bee Health
- Bees need food, water, and cleanliness
- Low health affects honey production
- Bees can die if not properly maintained
- Use potatoes to heal sick bees

### Sickness System
- Bees can randomly get sick
- Different sicknesses require different medicines
- Sickness intensity increases over time
- At 100% intensity, bees die
- Use bandages to cure sickness

### Wild Beehives
- Spawn at predetermined locations
- Can be interacted with to collect resources
- Use smoker to calm bees before collecting
- Risk getting stung (configurable damage)

## 🎯 Advanced Features

### Helper System
- Assign other players as helpers
- Helpers can manage your hives
- Useful for larger beekeeping operations

### Auto-Destroy System
- Inactive hives (no bees/queens) slowly deteriorate
- Prevents abandoned hives from cluttering the world
- Configurable damage rate and threshold

### Multiple Bee Types
- Different bee species with unique properties
- Varying honey production rates
- Different queen and bee items

## 🐛 Troubleshooting

### Common Issues
1. **Menu not opening**: Make sure `qb-menu` is installed
2. **Items not working**: Check that all items are added to `items.lua`
3. **Database errors**: Verify the SQL table is created correctly
4. **Wild hives not spawning**: Check `Config.WildBeehiveSpawn` is true

### Debug Mode
Enable `Config.Debug = true` in the config for console output and debugging information.

## 📝 Item List

### Required Items (Added to QBCore)
- `beehive_box` - Main beehive item
- `basic_queen` - Queen bee
- `basic_bees` - Worker bees
- `basic_hornet_queen` - Hornet queen
- `basic_hornets` - Hornet workers
- `honey` - Basic honey
- `honey2` - Manuka honey
- `empty_bee_jar` - Collection jar
- `torch_smoker` - Bee smoker
- `bug_net` - Bug catching net
- `wateringcan_empty` - Empty watering can
- `sugar` - Bee food
- `wheat` - Cleaning material
- `potato` - Healing item
- `bandage` - Medicine for sickness

## 🎨 Customization

### Adding New Bee Types
Edit `Config.BeeTypes` in the config file to add new bee species with different properties.

### Modifying Wild Hive Locations
Edit `Config.WildBeehives` to add or modify wild beehive spawn locations.

### Adjusting Production Rates
Modify `ProductHappy` and `ProductNormal` values in bee type configurations.

## 📄 License

This script is converted from the original MMS Beekeeping script. Please respect the original author's work and any licensing terms.

## 🤝 Support

For issues or questions:
1. Check the configuration settings
2. Verify all dependencies are installed
3. Check the console for error messages
4. Ensure the database is set up correctly

---

**Enjoy your beekeeping adventure! 🐝🍯**

----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

# BOII | DEVELOPMENT - ACTIVITY: MINING

Here we have an indepth mining activity for your citizens to enjoy!
Includes a tiered xp system if enabled through config.
Start by digging & panning paydirt, then progress into quarry blasting, and finally progress into cave blasting.
A full selling system with togglable buy back system is included.
K4MB1 Cave MLO compatible.
Enjoy!

### INSTALL

1. Customise `shared/config.lua` & `shared/language.lua` to your liking. XP rates adjusted in server side scripts if using XP system
2. Edit `html/guide.html` to your liking. Remove the noted pages if not using k4mb1 cave mlo
3. Drag and drop `boii-mining` into your server resources ensuring your load order is correct
4. Insert `sql.sql` provided into your server database if your want to use the buyback system.
5. Copy the line under **QB-CORE/SERVER/PLAYER.LUA** into your `qb-core/server/player.lua` in order for your XP system to work correctly if enabled
6. Copy items provided under **QB-CORE/SHARED.ITEMS.LUA** into your `qb-core/shared/items.lua`
7. Copy images from `html/images` into your inventory images
8. Copy the `k4mb1_cave.lua` from `doorlocks/k4mb1_cave.lua` into your `qb-doorlock/configs` if you are using k4mb1 cave mlo in order for cave entrance to be locked
9. Restart your server

### QB-CORE/SERVER/PLAYER.LUA ###
-- Insert this line into your `qb-core/server/player.lua` like the screenshot below. **IF YOU CHANGE YOUR METADATA NAME IN CONFIG ALSO CHANGE THIS LINE!!**

PlayerData.metadata['miningxp'] = PlayerData.metadata['miningxp'] or 0 -- Added for mining xp

Screenshot example; https://imgur.com/KwpF9mv

### QB-CORE/SHARED.ITEMS.LUA ###

	--<!>-- MINING --<!>--
	-- Permits
	['mining_permit']       		= {['name'] = 'mining_permit',          		['label'] = 'Mining Permit',        	['weight'] = 100,      	['type'] = 'item',      ['image'] = 'mining_permit.png',      			['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A mining permit. This grants access to mining!'},
	['caving_permit']       		= {['name'] = 'caving_permit',          		['label'] = 'Caving Permit',        	['weight'] = 100,      	['type'] = 'item',      ['image'] = 'caving_permit.png',      			['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A caving permit. This grants access to cave mining!'},

	-- Tools
	['miningguide']       		= {['name'] = 'miningguide',          		['label'] = 'Mining Handbook',        	['weight'] = 100,      	['type'] = 'item',      ['image'] = 'miningguide.png',      			['unique'] = false,     ['useable'] = true,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'Learn all about mining with this handbook!'},
	['shovel']       		= {['name'] = 'shovel',          		['label'] = 'Shovel',        	['weight'] = 1500,      	['type'] = 'item',      ['image'] = 'shovel.png',      			['unique'] = true,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shovel used for digging things!'},
	['emptysack']       		= {['name'] = 'emptysack',          		['label'] = 'Sack',        				['weight'] = 100,      	['type'] = 'item',      ['image'] = 'emptysack.png',      			['unique'] = false,     ['useable'] = false,    ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A empty sack for storing things!'},
	['gold_pan']       		= {['name'] = 'gold_pan',          		['label'] = 'Gold Pan',        	['weight'] = 1500,      	['type'] = 'item',      ['image'] = 'gold_pan.png',      			['unique'] = true,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A pan for washing dirt or gravel. Will you find gold?'},
	['jackhammer']       		= {['name'] = 'jackhammer',          		['label'] = 'Jackhammer',        	['weight'] = 1500,      	['type'] = 'item',      ['image'] = 'jackhammer.png',      			['unique'] = true,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A high quality jack hammer for breaking rocks.'},
	['dynamite']       		= {['name'] = 'dynamite',          		['label'] = 'Dynamite',        	['weight'] = 1500,      	['type'] = 'item',      ['image'] = 'dynamite.png',      			['unique'] = true,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A stick of dynamite.'},

	-- Paydirt
	['paydirt']       		= {['name'] = 'paydirt',          		['label'] = 'Paydirt',        	['weight'] = 2500,      	['type'] = 'item',      ['image'] = 'paydirt.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A sack of paydirt!'},
	
	-- Ores
	['aluminum_ore']       		= {['name'] = 'aluminum_ore',          		['label'] = 'Aluminum Ore',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'aluminum_ore.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A piece of Aluminum Ore!'},
	['copper_ore']       		= {['name'] = 'copper_ore',          		['label'] = 'Copper Ore',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'copper_ore.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A piece of Copper Ore!'},
	['tin_ore']       		= {['name'] = 'tin_ore',          		['label'] = 'Tin Ore',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'tin_ore.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A piece of Tin Ore!'},
	['iron_ore']       		= {['name'] = 'iron_ore',          		['label'] = 'Iron Ore',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'iron_ore.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A piece of Iron Ore!'},
	['coal']       		= {['name'] = 'coal',          		['label'] = 'Coal',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'coal.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A piece of Coal!'},
	['gold_ore']       		= {['name'] = 'gold_ore',          		['label'] = 'Gold Ore',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'gold_ore.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A piece of Gold Ore!'},
	['silver_ore']       		= {['name'] = 'silver_ore',          		['label'] = 'Silver Ore',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'silver_ore.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A piece of Silver Ore!'},

	-- Ingots
	['aluminum_ingot']       		= {['name'] = 'aluminum_ingot',          		['label'] = 'Aluminum Ingot',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'aluminum_ingot.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A Aluminum Ingot!'},
	['copper_ingot']       		= {['name'] = 'copper_ingot',          		['label'] = 'Copper Ingot',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'copper_ingot.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A Copper Ingot!'},
	['tin_ingot']       		= {['name'] = 'tin_ingot',          		['label'] = 'Copper Tin',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'tin_ingot.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A Tin Ingot!'},
	['iron_ingot']       		= {['name'] = 'iron_ingot',          		['label'] = 'Iron Ingot',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'iron_ingot.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A Iron Ingot!'},
	['gold_ingot']       		= {['name'] = 'gold_ingot',          		['label'] = 'Gold Ingot',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'gold_ingot.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A Gold Ingot!'},
	['silver_ingot']       		= {['name'] = 'silver_ingot',          		['label'] = 'Silver Ingot',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'silver_ingot.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A Silver Ingot!'},
	['bronze_ingot']       		= {['name'] = 'bronze_ingot',          		['label'] = 'Bronze Ingot',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'gold_ingot.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A Bronze Ingot!'},
	['steel_ingot']       		= {['name'] = 'steel_ingot',          		['label'] = 'Steel Ingot',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'steel_ingot.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A Steel Ingot!'},
	['cobalt_ingot']       		= {['name'] = 'cobalt_ingot',          		['label'] = 'Cobalt Ingot',        	['weight'] = 1000,      	['type'] = 'item',      ['image'] = 'cobalt_ingot.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A Cobalt Ingot!'},

	-- Gems
	['amethyst']       		= {['name'] = 'amethyst',          		['label'] = 'Amethyst',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'amethyst.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Amethyst gemstone!'},
	['citrine']       		= {['name'] = 'citrine',          		['label'] = 'Citrine',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'citrine.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Citrine gemstone!'},
	['hematite']       		= {['name'] = 'hematite',          		['label'] = 'Hematite',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'hematite.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Hematite gemstone!'},
	['kyanite']       		= {['name'] = 'kyanite',          		['label'] = 'Kyanite',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'kyanite.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Kyanite gemstone!'},
	['onyx']       			= {['name'] = 'onyx',          		['label'] = 'onyx',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'onyx.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Onyx gemstone!'},
	['diamond']       		= {['name'] = 'diamond',          		['label'] = 'Diamond',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'diamond.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Diamond gemstone!'},
	['emerald']       		= {['name'] = 'emerald',          		['label'] = 'Emerald',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'emerald.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Emerald gemstone!'},
	['ruby']       			= {['name'] = 'ruby',          		['label'] = 'Ruby',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'ruby.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Ruby gemstone!'},
	['sapphire']       		= {['name'] = 'sapphire',          		['label'] = 'Sapphire',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'sapphire.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Sapphire gemstone!'},
	['tanzanite']       	= {['name'] = 'tanzanite',          		['label'] = 'Tanzanite',        	['weight'] = 150,      	['type'] = 'item',      ['image'] = 'onyx.png',      			['unique'] = false,     ['useable'] = false,     ['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A shiny Tanzanite gemstone!'},

### PREVIEW
https://www.youtube.com/watch?v=YOUBy13vq4c
### SUPPORT
https://discord.gg/MUckUyS5Kq
# CC Fleeca Heist (cc-fleecaheist)
* Tebex: https://ccdev.tebex.io/
* Discord: https://discord.gg/N5ut9BYkSK

# Dependencies
* [ps-ui by Project Sloth](https://github.com/Project-Sloth/ps-ui/tree/main)
* [casinohack by JoeSzymkowicz](https://github.com/JoeSzymkowiczFiveM/casinohack)
* [memorygame by pushkart2](https://github.com/pushkart2/memorygame)
* [hacking by Jesper-Hustad](https://github.com/Jesper-Hustad/NoPixel-minigame/tree/main/fivem-script)
* [qb-target by BerkieBb](https://github.com/BerkieBb/qb-target)

# Installation
* **Add the items to qb-core/shared/items.lua**
* **Add the item info for the laptop to the giveitem command**
* **Download ps-ui from the dependencies list to your resources**
* **Drag all dependencies from MINIGAMES to your resources**
* **Add the doorlock config to qb-doorlock/configs**
* **Locate all "room04_cashtrolley" in cfx-gabz-mapdata/gabz_entityset_mods1.lua and set to false**
* **Locate all "room05_cashtrolley" in cfx-gabz-mapdata/gabz_entityset_mods1.lua and set to false**
* **Run the SQL file (pc_codes.sql) in your server database**
* **Configure the script to your liking in the config.lua**

# Items for shared/items.lua
```lua
["basicdecrypter"] = {["name"] = "basicdecrypter", ["label"] = "Basic Decrypter", ["weight"] = 1000, ["type"] = "item", ["image"] = "basicdecrypter.png", ["unique"] = true, 	["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""},
["basicdrill"] = {["name"] = "basicdrill", ["label"] = "Basic Drill", ["weight"] = 1000, ["type"] = "item", ["image"] = "basicdrill.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""},
["laptop_green"] = {["name"] = "laptop_green", ["label"] = "Laptop", ["weight"] = 2500, ["type"] = "item", ["image"] = "laptop_green.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""},
['inkedbills'] = {['name'] = 'inkedbills', ['label'] = 'Inked Money Bag', ['weight'] = 2000, ['type'] = 'item', ['image'] = 'money-bag.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A bag full of inked bills'},
```

# Add the item info to qb-inventory/server/main.lua under the giveitem command. Not needed for ox_inventory
```lua
elseif itemData["name"] == "laptop_green" then
	info.uses = 3
```

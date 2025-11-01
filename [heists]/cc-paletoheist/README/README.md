# CC Paleto Heist (cc-paletoheist)
* Tebex: https://ccdev.tebex.io/
* Discord: https://discord.gg/N5ut9BYkSK

# Dependencies
* [ps-ui by Project Sloth](https://github.com/Project-Sloth/ps-ui/tree/main)
* [casinohack by JoeSzymkowicz](https://github.com/JoeSzymkowiczFiveM/casinohack)
* [memorygame by pushkart2](https://github.com/pushkart2/memorygame)
* [hacking by Jesper-Hustad](https://github.com/Jesper-Hustad/NoPixel-minigame/tree/main/fivem-script)
* [lightsout by Kylend](https://github.com/dnelyk/Hacking_Minigames/tree/main/lightsout)
* [pd-safe by VHall1](https://github.com/VHall1/pd-safe)
* [qb-target by BerkieBb](https://github.com/BerkieBb/qb-target)

# Installation
* **Add the items to qb-core/shared/items.lua**
* **Add the item info for the laptop to the giveitem command**
* **Download ps-ui from the dependencies list to your resources**
* **Drag all dependencies from MINIGAMES to your resources**
* **Add the doorlock config to qb-doorlock/configs**
* **Locate "palbank_vault_trolleys" in cfx-gabz-mapdata/gabz_entityset_mods1.lua and set to false**
* **Configure the script to your liking in the config.lua**

# Items for shared/items.lua
```lua
["advanceddecrypter"] = {["name"] = "advanceddecrypter", ["label"] = "Advanced Decrypter", ["weight"] = 1000, ["type"] = "item", ["image"] = "advanceddecrypter.png", ["unique"] = true, 	["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""},
["advanceddrill"] = {["name"] = "advanceddrill", ["label"] = "Advanced Drill", ["weight"] = 1000, ["type"] = "item", ["image"] = "advanceddrill.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""},
["laptop_blue"] = {["name"] = "laptop_blue", ["label"] = "Laptop", ["weight"] = 2500, ["type"] = "item", ["image"] = "laptop_blue.png", ["unique"] = true, ["useable"] = true, ["shouldClose"] = true, ["combinable"] = nil, ["description"] = ""},
['inkedbills'] = {['name'] = 'inkedbills', ['label'] = 'Inked Money Bag', ['weight'] = 2000, ['type'] = 'item', ['image'] = 'money-bag.png', ['unique'] = false, ['useable'] = false, ['shouldClose'] = false, ['combinable'] = nil, ['description'] = 'A bag full of inked bills'},
```

# Add the item info to qb-inventory/server/main.lua under the giveitem command. Not needed for ox_inventory
```lua
elseif itemData["name"] == "laptop_blue" then
	info.uses = 3
```

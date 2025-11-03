Config = {}

-- Spawn location for the tester zone (best vector location)
-- Popular locations:
-- Airport: vector3(-1037.0, -2737.0, 20.17)
-- Legion Square: vector3(195.0, -933.0, 30.69)
-- Maze Bank Tower: vector3(-75.0, -818.0, 326.18)
-- You can change this to any location you prefer
Config.Location = vector3(-1037.0, -2737.0, 20.17) -- Default: Airport area

-- Item Categories
Config.ItemCategories = {
    {
        name = "Lockpicks & Tools",
        icon = "lock",
        items = {
            {name = "lockpick", label = "Lockpick", icon = "lockpick"},
            {name = "advancedlockpick", label = "Advanced Lockpick", icon = "advancedlockpick"},
            {name = "screwdriverset", label = "Toolkit", icon = "screwdriverset"},
            {name = "phone_dongle", label = "Phone Dongle", icon = "phone_dongle"},
        }
    },
    {
        name = "Heist Items",
        icon = "warehouse",
        items = {
            {name = "drill", label = "Drill", icon = "drill"},
            {name = "advanceddrill", label = "Advanced Drill", icon = "advanceddrill"},
            {name = "hardeneddrill", label = "Hardened Drill", icon = "hardeneddrill"},
            {name = "basicdrill", label = "Basic Drill", icon = "basicdrill"},
            {name = "yacht_drill", label = "Yacht Drill", icon = "yacht_drill"},
            {name = "atm_drill", label = "ATM Drill", icon = "drill_grey"},
            {name = "thermite", label = "Thermite", icon = "thermite"},
            {name = "electronickit", label = "Electronic Kit", icon = "electronickit"},
            {name = "gatecrack", label = "Gatecrack", icon = "usb_device"},
            {name = "trojan_usb", label = "Trojan USB", icon = "usb_device"},
            {name = "laptop", label = "Laptop", icon = "laptop"},
        }
    },
    {
        name = "Crafting Materials",
        icon = "hammer",
        items = {
            {name = "recyclablematerial", label = "Recyclable Material", icon = "recyclablematerial"},
            {name = "iron", label = "Iron", icon = "iron"},
            {name = "steel", label = "Steel", icon = "steel"},
            {name = "copper", label = "Copper", icon = "copper"},
            {name = "aluminum", label = "Aluminum", icon = "aluminum"},
            {name = "rubber", label = "Rubber", icon = "rubber"},
            {name = "plastic", label = "Plastic", icon = "plastic"},
            {name = "glass", label = "Glass", icon = "glass"},
            {name = "leather", label = "Leather", icon = "leather"},
            {name = "fabric", label = "Fabric", icon = "fabric"},
            {name = "drillbit", label = "Drill Bit", icon = "drillbits"},
        }
    },
    {
        name = "Weapon Components",
        icon = "crosshairs",
        items = {
            {name = "pistol_extendedclip", label = "Pistol Extended Clip", icon = "extendedclip_attachment"},
            {name = "pistol_flashlight", label = "Pistol Flashlight", icon = "flashlight_attachment"},
            {name = "pistol_suppressor", label = "Pistol Suppressor", icon = "suppressor_attachment"},
            {name = "pistol_holoscope", label = "Pistol Holographic Scope", icon = "holoscope_attachment"},
            {name = "pistol_scope", label = "Pistol Scope", icon = "smallscope_attachment"},
            {name = "pistol_comp", label = "Pistol Compensator", icon = "comp_attachment"},
            {name = "smg_extendedclip", label = "SMG Extended Clip", icon = "extendedclip_attachment"},
            {name = "smg_suppressor", label = "SMG Suppressor", icon = "suppressor_attachment"},
            {name = "smg_drum", label = "SMG Drum Magazine", icon = "drum_attachment"},
            {name = "smg_scope", label = "SMG Scope", icon = "smallscope_attachment"},
            {name = "smg_grip", label = "SMG Grip", icon = "grip_attachment"},
            {name = "smg_barrel", label = "SMG Barrel", icon = "barrel_attachment"},
            {name = "smg_holoscope", label = "SMG Holographic Scope", icon = "holoscope_attachment"},
            {name = "rifle_extendedclip", label = "Rifle Extended Clip", icon = "extendedclip_attachment"},
            {name = "rifle_drum", label = "Rifle Drum Magazine", icon = "drum_attachment"},
            {name = "rifle_suppressor", label = "Rifle Suppressor", icon = "suppressor_attachment"},
            {name = "rifle_scope", label = "Rifle Scope", icon = "smallscope_attachment"},
            {name = "rifle_grip", label = "Rifle Grip", icon = "grip_attachment"},
            {name = "rifle_flashlight", label = "Rifle Flashlight", icon = "flashlight_attachment"},
            {name = "weapon_repairkit", label = "Weapon Repair Kit", icon = "advancedkit"},
        }
    },
    {
        name = "Mechanic Items",
        icon = "wrench",
        items = {
            {name = "repairkit", label = "Repair Kit", icon = "repairkit"},
            {name = "advancedrepairkit", label = "Advanced Repair Kit", icon = "advancedkit"},
            {name = "tirerepairkit", label = "Tire Repair Kit", icon = "tirerepairkit"},
            {name = "cleaningkit", label = "Cleaning Kit", icon = "cleaningkit"},
            {name = "nitrous", label = "Nitrous", icon = "nitrous"},
            {name = "engine_oil", label = "Engine Oil", icon = "engine_oil"},
            {name = "suspension_parts", label = "Suspension Parts", icon = "suspension_parts"},
            {name = "brakepad_replacement", label = "Brakepad Replacement", icon = "brakepad_replacement"},
            {name = "i4_engine", label = "I4 Engine", icon = "i4_engine"},
            {name = "v6_engine", label = "V6 Engine", icon = "v6_engine"},
            {name = "v8_engine", label = "V8 Engine", icon = "v8_engine"},
            {name = "v10_engine", label = "V10 Engine", icon = "v10_engine"},
            {name = "v12_engine", label = "V12 Engine", icon = "v12_engine"},
            {name = "inline6_engine", label = "6-Cylinder Inline Engine", icon = "inline6_engine"},
            {name = "turbocharger", label = "Turbo", icon = "turbocharger"},
        }
    },
    {
        name = "Electronics",
        icon = "microchip",
        items = {
            {name = "laptop", label = "Laptop", icon = "laptop"},
            {name = "radio", label = "Radio", icon = "radio"},
            {name = "powerbank", label = "Power Bank", icon = "powerbank"},
        }
    },
    {
        name = "Valuables",
        icon = "gem",
        items = {
            {name = "rolex", label = "Rolex", icon = "rolex"},
            {name = "diamond_ring", label = "Diamond Ring", icon = "diamond_ring"},
            {name = "diamond_ring_mining", label = "Diamond Ring (Gold)", icon = "diamond_ring_mining"},
            {name = "diamond_necklace", label = "Diamond Necklace", icon = "diamond_necklace"},
            {name = "goldbar", label = "Gold Bar", icon = "goldbar"},
        }
    },
    {
        name = "Misc Items",
        icon = "box",
        items = {
            {name = "ziptie", label = "Zip Tie", icon = "ziptie"},
            {name = "duct_tape", label = "Duct Tape", icon = "duct_tape"},
            {name = "rope", label = "Rope", icon = "rope"},
            {name = "binoculars", label = "Binoculars", icon = "binoculars"},
            {name = "research_kit", label = "Research Kit", icon = "research_kit"},
        }
    }
}

-- Menu Settings
Config.MenuTitle = "OLRP Tester - Item Spawner"
Config.MaxAmount = 100 -- Maximum amount players can request at once


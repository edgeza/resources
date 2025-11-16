--RAINMAD SCRIPTS - discord.gg/rccvdkmA5X - rainmad.com
Config = {}

Config['OilRigHeist'] = {
    ['framework'] = {
        name = 'QB', -- Only ESX or QB.
        scriptName = 'qb-core', -- Framework script name work framework exports. (Example: qb-core or es_extended)
        eventName = 'esx:getSharedObject', -- If your framework using trigger event for shared object, you can set in here.
        targetScript = 'ox_target' -- Target script name (qtarget or qb-target or ox_target)
    },
    ["dispatch"] = "cd_dispatch", -- cd_dispatch | qs-dispatch | ps-dispatch | rcore_dispatch | default
    ['requiredPoliceCount'] = 0, -- required police count for start heist
    ['dispatchJobs'] = {'police', 'sheriff'},
    ['requiredItems'] = { -- Add this items to database or shared. Don't change the order, you can change the item names.
        'hardeneddecrypter',
        'hardeneddrill',
        'laptop_red',
    },
    ['nextRob'] = 7200, -- Seconds for next heist
    ['startHeist'] ={ -- Heist start coords
        pos = vector3(346.798, 3405.46, 36.8516),
        peds = {
            {pos = vector3(346.798, 3405.46, 36.8516), heading = 21.85, ped = 's_m_m_highsec_01'},
            {pos = vector3(347.701, 3406.21, 36.4559), heading = 111.78, ped = 's_m_m_highsec_02'},
            {pos = vector3(345.771, 3405.33, 36.4573), heading = 292.42, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['requiredPlayersForHeist'] = 1, -- Required players for start heist.
    ['crateSettings'] = {
        ['crateCount'] = 6, -- Crate with items count for every heist. (Max 10)
        ['crateItems'] = { -- Items for every crate.
            -- Money and Materials (Less Common - Weapons are priority)
            {itemName = 'markedbills', itemCount = function() return math.random(3, 5) end, chance = 60, itemInfo = function() return {worth = math.random(2000, 2500)} end}, -- Money reward (reduced chance, weapons are main reward)
            {itemName = 'scrap',   itemCount = function() return math.random(1, 5) end, chance = 90},
            {itemName = 'scrap2',  itemCount = function() return math.random(1, 5) end, chance = 80},
            {itemName = 'scrap3',  itemCount = function() return math.random(1, 5) end, chance = 70},
            
            -- Crafting Materials (Always)
            {itemName = 'steel', itemCount = function() return math.random(50, 100) end, chance = 100},
            {itemName = 'aluminum', itemCount = function() return math.random(30, 60) end, chance = 100},
            {itemName = 'reinforced_steel', itemCount = function() return math.random(5, 15) end, chance = 100},
            
            -- Ammunition (Common)
            {itemName = 'pistol_ammo', itemCount = function() return math.random(45, 75) end, chance = 75},
            {itemName = 'smg_ammo', itemCount = function() return math.random(35, 65) end, chance = 65},
            {itemName = 'rifle_ammo', itemCount = function() return math.random(25, 55) end, chance = 55},
            
            -- Armor (Uncommon)
            {itemName = 'heavyarmor', itemCount = function() return math.random(2, 4) end, chance = 60},
            
            -- Tools (Rare)
            {itemName = 'hardeneddecrypter', itemCount = function() return 1 end, chance = 40},
            {itemName = 'hardeneddrill', itemCount = function() return 1 end, chance = 35},
            {itemName = 'disruptor', itemCount = function() return 1 end, chance = 30},
            
            -- Jammers (Guaranteed 1, 25% chance for second)
            {itemName = 'jammer', itemCount = function() return 1 end, chance = 100}, -- Guaranteed 1 jammer
            {itemName = 'jammer', itemCount = function() return 1 end, chance = 25}, -- 25% chance for second jammer
            
            -- Class 4 Weapons (Assault Rifles) - Very Rare (15% chance)
            {itemName = 'weapon_assaultrifle', itemCount = function() return 1 end, chance = 15},
            {itemName = 'weapon_ak47', itemCount = function() return 1 end, chance = 15},
            {itemName = 'weapon_bullpuprifle', itemCount = function() return 1 end, chance = 15},
            
            -- Class 4 Weapons (Rare Variants) - Ultra Rare (5% chance)
            {itemName = 'weapon_assaultrifle_mk2', itemCount = function() return 1 end, chance = 5},
            {itemName = 'weapon_militaryrifle', itemCount = function() return 1 end, chance = 5},
            {itemName = 'weapon_heavyrifle', itemCount = function() return 1 end, chance = 5},
        },
        ['lootTime'] = 5, -- Seconds
    }
}

Config['OilRigSetup'] = {
    ['middleArea'] = vector3(-2736.2, 6597.84, 29.1568),
    ['guards'] = { 
        ['peds'] = {-- These coords are for guard peds, you can add new guard peds.
            {coords = vector3(-2734.17, 6595.27, 50.38),  heading = 354.93, model = 'hc_gunman'}, -- vec3(-2734.17, 6595.27, 50.38)
            {coords = vector3(-2735.12, 6595.94, 38.84),  heading = 354.93, model = 'hc_gunman'}, -- vec3(-2735.12, 6595.94, 38.84)
            {coords = vector3(-2738.21, 6598.35, 38.84),  heading = 354.93, model = 'hc_gunman'}, -- vec3(-2738.21, 6598.35, 38.84)
            {coords = vector3(-2729.8, 6597.79, 29.6301),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2729.8, 6597.79, 29.6301),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2729.8, 6597.79, 29.6301),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2739.37, 6624.06, 26.07),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2725.32, 6618.39, 26.07),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2729.83, 6601.11, 24.98),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2723.66, 6589.61, 24.37),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2723.75, 6604.32, 24.37),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2713.24, 6613.34, 21.75),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2726.83, 6605.1, 21.75),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2741.51, 6609.71, 21.75),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2741.46, 6592.88, 24.97),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2736.28, 6581.15, 21.75),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2724.6, 6582.83, 25.96),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2713.6, 6584.08, 28.83),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2724.19, 6575.15, 28.83),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2734.6, 6583.73, 29.66),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2723.3, 6598.29, 29.66),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2720.39, 6583.09, 21.75),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2716.22, 6583.71, 15.05),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2728.1, 6592.13, 12.45),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2728.36, 6598.67, 12.51),  heading = 354.93, model = 'hc_gunman'},
            {coords = vector3(-2716.25, 6611.27, 15.13),  heading = 354.93, model = 'hc_gunman'},
        },
        ['weapons'] = {'WEAPON_ASSAULTRIFLE'} -- You can change this.
    },
    ['crates'] = {
        {coords = vector3(-2739.6, 6608.67, 15.0348), heading = 59.0},
        {coords = vector3(-2717.7, 6610.90, 21.7323), heading = 0.0},
        {coords = vector3(-2722.3, 6611.42, 21.7416), heading = 90.0},
        {coords = vector3(-2723.6, 6614.66, 21.7416), heading = 90.0},
        {coords = vector3(-2728.0, 6599.0,  21.7416), heading = 0.0},
        {coords = vector3(-2724.9, 6595.0,  21.7416), heading = 0.0},
        {coords = vector3(-2724.9, 6590.67, 21.9416), heading = 90.0},
        {coords = vector3(-2739.1, 6609.55, 21.7416), heading = 90.0},
        {coords = vector3(-2730.4, 6615.08, 25.9878), heading = 0.0},
        {coords = vector3(-2728.3, 6615.11, 25.9878), heading = 0.0},
    },
    ['laptop'] = {coords = vector3(-2732.5, 6621.41, 25.4206), heading = 0.0}
}

policeAlert = function(coords)
    if Config['OilRigHeist']["dispatch"] == "default" then
        TriggerServerEvent('oilrig:server:policeAlert', coords)
    elseif Config['OilRigHeist']["dispatch"] == "cd_dispatch" then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = Config["OilRigHeist"]['dispatchJobs'], 
            coords = coords,
            title = 'Oil Rig Robbery',
            message = 'A '..data.sex..' robbing a Oil Rig at '..data.street, 
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431, 
                scale = 1.2, 
                colour = 3,
                flashes = false, 
                text = '911 - Oil Rig Robbery',
                time = 5,
                radius = 0,
            }
        })
    elseif Config['OilRigHeist']["dispatch"] == "qs-dispatch" then
        local playerData = exports['qs-dispatch']:GetPlayerInfo()
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = Config["OilRigHeist"]['dispatchJobs'],
            callLocation = coords,
            message = " street_1: ".. playerData.street_1.. " street_2: ".. playerData.street_2.. " sex: ".. playerData.sex,
            flashes = false,
            image = image or nil,
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = 'Oil Rig Robbery',
                time = (20 * 1000),     --20 secs
            }
        })
    elseif Config['OilRigHeist']["dispatch"] == "ps-dispatch" then
        local dispatchData = {
            message = "Oil Rig Robbery",
            codeName = 'oilrig',
            code = '10-90',
            icon = 'fas fa-store',
            priority = 2,
            coords = coords,
            gender = IsPedMale(PlayerPedId()) and 'Male' or 'Female',
            street = "Oil Rig",
            camId = nil,
            jobs = Config["OilRigHeist"]['dispatchJobs'],
        }
        TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
    elseif Config['OilRigHeist']["dispatch"] == "rcore_dispatch" then
        local data = {
            code = '10-64', -- string -> The alert code, can be for example '10-64' or a little bit longer sentence like '10-64 - Shop robbery'
            default_priority = 'high', -- 'low' | 'medium' | 'high' -> The alert priority
            coords = coords, -- vector3 -> The coords of the alert
            job = Config["OilRigHeist"]['dispatchJobs'], -- string | table -> The job, for example 'police' or a table {'police', 'ambulance'}
            text = 'Oil Rig Robbery', -- string -> The alert text
            type = 'alerts', -- alerts | shop_robbery | car_robbery | bank_robbery -> The alert type to track stats
            blip_time = 5, -- number (optional) -> The time until the blip fades
            blip = { -- Blip table (optional)
                sprite = 431, -- number -> The blip sprite: Find them here (https://docs.fivem.net/docs/game-references/blips/#blips)
                colour = 3, -- number -> The blip colour: Find them here (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
                scale = 1.2, -- number -> The blip scale
                text = 'Oil Rig Robbery', -- number (optional) -> The blip text
                flashes = false, -- boolean (optional) -> Make the blip flash
                radius = 0, -- number (optional) -> Create a radius blip instead of a normal one
            }
        }
        TriggerServerEvent('rcore_dispatch:server:sendAlert', data)
    end
end

Strings = {
    ['wait_nextrob'] = 'You have to wait this long to undress again',
    ['minute'] = 'minute.',
    ['need_this'] = 'You need this: ',
    ['need_police'] = 'Not enough police in the city.',
    ['total_money'] = 'You got this: ',
    ['police_alert'] = 'Oil rig robbery alert! Check your gps.',
    ['not_cop'] = 'You are not cop!',
    ['need_people'] = 'Count of people required for heist: ',
    ['oilrig_blip'] = 'Oil Rig',
    ['heist_info'] = 'Go to the location marked on the GPS with your crew. Take plenty of weapons and armor.',
    ['hack_info'] = 'Full boxes marked on GPS.',
    ['looting'] = 'LOOTING',

    --Target labels
    ['t_heist'] = 'Oil Rig Heist',
    ['t_search'] = 'Search Crate',
    ['t_laptop'] = 'Hack Laptop',

    --For minigame
    ['confirm'] = 'Confirm',
    ['change'] = 'Change vertical',
    ['change_slice'] = 'Change slice',
    ['exit'] = 'Exit',
}
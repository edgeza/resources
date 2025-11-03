----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--
local Core = exports['qb-core']:GetCoreObject()
local MenuName = Config.CoreSettings.MenuName
--<!>-- DO NOT CHANGE ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--

-- Main menu
local MainMenu = {
    {
        title = Language.Mining.Quarry.Ped.Menu.Main['header'],
        description = Language.Mining.Quarry.Ped.Menu.Main['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Main['icon'],
        isMenuHeader = true
    },
    {
        title = Language.Mining.Quarry.Ped.Menu.Guide['header'],
        description = Language.Mining.Quarry.Ped.Menu.Guide['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Guide['icon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:TakeGuide')
        end
    },
    {
        title = Language.Mining.Quarry.Ped.Menu.Permits['header'],
        description = Language.Mining.Quarry.Ped.Menu.Permits['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Permits['icon'],
        onSelect = function()
            TriggerEvent('boii-mining:cl:QuarryPermitsMenu')
        end
    },
    {
        title = Language.Mining.Quarry.Ped.Menu.Equipment['header'],
        description = Language.Mining.Quarry.Ped.Menu.Equipment['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['icon'],
        onSelect = function()
            TriggerEvent('boii-mining:cl:QuarryEquipmentMenu')
        end
    },
    {
        title = 'Check Mining Level / XP',
        description = 'View your mining level and XP progress',
        icon = 'fa-solid fa-chart-line',
        onSelect = function()
            TriggerEvent('boii-mining:cl:ShowMyXP')
        end
    },
    {
        title = 'Global Mining Leaderboard',
        description = 'Top miners on the server',
        icon = 'fa-solid fa-trophy',
        onSelect = function()
            TriggerEvent('boii-mining:cl:ShowScoreboard')
        end
    },
    {
        title = Language.Shared['exitmenu'],
        icon = Language.Shared['exitmenuicon'],
        onSelect = function()
            TriggerEvent('boii-mining:cl:StopMenu')
        end
    }
}

-- Permits menu
local Permits = {
    {
        title = Language.Mining.Quarry.Ped.Menu.Permits['header'],
        description = Language.Mining.Quarry.Ped.Menu.Permits['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Permits['icon'],
        isMenuHeader = true
    },
    {
        title = Language.Mining.Quarry.Ped.Menu.Permits['miningheader'],
        description = Language.Mining.Quarry.Ped.Menu.Permits['miningtext'],
        icon = Language.Mining.Quarry.Ped.Menu.Permits['miningicon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:PurchasePermit', {
                permit = 'Mining',
                item = Config.Stores.Permits.Mining.name,
                price = Config.Stores.Permits.Mining.price
            })
        end
    },
    {
        title = Language.Mining.Quarry.Ped.Menu.Permits['cavingheader'],
        description = Language.Mining.Quarry.Ped.Menu.Permits['cavingtext'],
        icon = Language.Mining.Quarry.Ped.Menu.Permits['cavingicon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:PurchasePermit', {
                permit = 'Caving',
                item = Config.Stores.Permits.Caving.name,
                price = Config.Stores.Permits.Caving.price
            })
        end
    },
    {
        title = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        onSelect = function()
            TriggerEvent('boii-mining:cl:QuarryMenu')
        end
    }
}

local Equipment = {
    {
        title = Language.Mining.Quarry.Ped.Menu.Equipment['header'],
        description = Language.Mining.Quarry.Ped.Menu.Equipment['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['icon'],
        isMenuHeader = true
    },
    {
        title = Config.Paydirt.Dirt.Required[1].label,
        description = 'Price: $'..Config.Paydirt.Dirt.Required[1].price,
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['shovelicon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:PurchaseEquipment', {
                equipment = '',
                item = Config.Paydirt.Dirt.Required[1].name,
                price = Config.Paydirt.Dirt.Required[1].price
            })
        end
    },
    {
        title = Config.Paydirt.Dirt.Required[2].label,
        description = 'Price: $'..Config.Paydirt.Dirt.Required[2].price,
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['sackicon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:PurchaseEquipment', {
                equipment = '',
                item = Config.Paydirt.Dirt.Required[2].name,
                price = Config.Paydirt.Dirt.Required[2].price
            })
        end
    },
    {
        title = Config.Paydirt.Panning.Required.label,
        description = 'Price: $'..Config.Paydirt.Panning.Required.price,
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['sackicon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:PurchaseEquipment', {
                equipment = '',
                item = Config.Paydirt.Panning.Required.name,
                price = Config.Paydirt.Panning.Required.price
            })
        end
    },
    {
        title = Language.Mining.Quarry.Ped.Menu.Equipment['jackhammerheader'],
        description = Language.Mining.Quarry.Ped.Menu.Equipment['jackhammertext'],
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['jackhammericon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:PurchaseEquipment', {
                equipment = 'Jackhammer',
                item = Config.Quarry.Drilling.Required.name,
                price = Config.Quarry.Drilling.Required.price
            })
        end
    },
    {
        title = Language.Mining.Quarry.Ped.Menu.Equipment['dynamiteheader'],
        description = Language.Mining.Quarry.Ped.Menu.Equipment['dynamitetext'],
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['dynamiteicon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:PurchaseEquipment', {
                equipment = 'Dynamite',
                item = Config.Quarry.Dynamite.Required.name,
                price = Config.Quarry.Dynamite.Required.price
            })
        end
    },
    {
        title = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        onSelect = function()
            TriggerEvent('boii-mining:cl:QuarryMenu')
        end
    }
}

-- Menu event
RegisterNetEvent('boii-mining:cl:QuarryMenu', function()
    if Config.Stores.Quarry.Times.Use then
        if GetClockHours() >= Config.Stores.Quarry.Times.Open and GetClockHours() <= Config.Stores.Quarry.Times.Close then
            lib.registerContext({
                id = 'quarry_main_menu',
                title = 'Quarry Worker',
                options = MainMenu
            })
            lib.showContext('quarry_main_menu')
        else 
            TriggerEvent('boii-mining:notify', Language.Mining.Quarry.Ped['timer'], 'error')
        end
    else
        lib.registerContext({
            id = 'quarry_main_menu',
            title = 'Quarry Worker',
            options = MainMenu
        })
        lib.showContext('quarry_main_menu')
    end 
end)

-- Sub menus events
RegisterNetEvent('boii-mining:cl:QuarryPermitsMenu', function()
    lib.registerContext({
        id = 'quarry_permits_menu',
        title = 'Permits',
        options = Permits
    })
    lib.showContext('quarry_permits_menu')
end)

RegisterNetEvent('boii-mining:cl:QuarryEquipmentMenu', function()
    lib.registerContext({
        id = 'quarry_equipment_menu',
        title = 'Equipment',
        options = Equipment
    })
    lib.showContext('quarry_equipment_menu')
end)

-- Dedicated Drillbit Shop (for drillbit ped)
RegisterNetEvent('boii-mining:cl:DrillbitShop', function()
    local items = {
        {
            title = 'Drill Bits',
            description = 'Consumable bits required for cutting',
            icon = Language.Mining.Quarry.Ped.Menu.Equipment['jackhammericon'],
            isMenuHeader = true
        },
        {
            title = Config.Tools.DrillBit.label,
            description = 'Price: $'..Config.Tools.DrillBit.price,
            onSelect = function()
                TriggerServerEvent('boii-mining:sv:PurchaseEquipment', { 
                    equipment = 'DrillBit', 
                    item = Config.Tools.DrillBit.name, 
                    price = Config.Tools.DrillBit.price 
                })
            end
        },
        {
            title = Language.Shared['exitmenu'],
            icon = Language.Shared['exitmenuicon'],
            onSelect = function()
                TriggerEvent('boii-mining:cl:StopMenu')
            end
        }
    }
    lib.registerContext({
        id = 'drillbit_shop_menu',
        title = 'Drill Bits',
        options = items
    })
    lib.showContext('drillbit_shop_menu')
end)

-- Personal XP/Level display menu
RegisterNetEvent('boii-mining:cl:OpenMyXPMenu', function(data)
    local level = data and data.level or 1
    local total = data and data.total or 0
    local into = data and data.intoLevel or 0
    local nextReq = data and data.nextReq or 0
    local items = {
        { title = 'Your Mining Progress', description = '', icon = 'fa-solid fa-chart-line', isMenuHeader = true },
        { title = ('Level: %d'):format(level), description = ('Total XP: %d'):format(total), icon = 'fa-solid fa-person-digging' },
    }
    if nextReq and nextReq > 0 then
        items[#items+1] = { title = ('XP this level: %d/%d'):format(into, nextReq), description = '', icon = 'fa-solid fa-bars-progress' }
    else
        items[#items+1] = { title = 'MAX Level', description = ('Total XP: %d'):format(total), icon = 'fa-solid fa-crown' }
    end
    items[#items+1] = { title = Language.Shared['returnmenu'], icon = Language.Shared['returnmenuicon'], onSelect = function() TriggerEvent('boii-mining:cl:QuarryMenu') end }
    
    lib.registerContext({
        id = 'mining_xp_menu',
        title = 'Mining Progress',
        options = items
    })
    lib.showContext('mining_xp_menu')
end)

-- Global leaderboard display
RegisterNetEvent('boii-mining:cl:OpenScoreboardMenu', function(rows)
    local items = {
        { title = 'Mining Leaderboard', description = 'Sorted highest level to lowest', icon = 'fa-solid fa-trophy', isMenuHeader = true }
    }
    if type(rows) == 'table' then
        for i, entry in ipairs(rows) do
            local name = entry.name or ('Unknown #'..i)
            local prefix, icon
            if i == 1 then
                prefix = '🥇 '
                icon = 'fa-solid fa-crown'
                name = '【'..name..'】'
            elseif i == 2 then
                prefix = '🥈 '
                icon = 'fa-regular fa-star'
                name = '【'..name..'】'
            elseif i == 3 then
                prefix = '🥉 '
                icon = 'fa-solid fa-star'
                name = '【'..name..'】'
            else
                prefix = ''
                icon = 'fa-regular fa-user'
            end
            items[#items+1] = {
                title = prefix .. name,
                description = ('Level %d | XP %d'):format(entry.level or 1, entry.total or 0),
                icon = icon
            }
        end
    end
    items[#items+1] = { title = Language.Shared['returnmenu'], icon = Language.Shared['returnmenuicon'], onSelect = function() TriggerEvent('boii-mining:cl:QuarryMenu') end }
    
    lib.registerContext({
        id = 'mining_scoreboard_menu',
        title = 'Mining Leaderboard',
        options = items
    })
    lib.showContext('mining_scoreboard_menu')
end)

-- Client request wrappers to avoid qb-menu server call issues
RegisterNetEvent('boii-mining:cl:ShowMyXP', function()
    TriggerServerEvent('boii-mining:sv:GetMyMiningXP')
end)

RegisterNetEvent('boii-mining:cl:ShowScoreboard', function()
    TriggerServerEvent('boii-mining:sv:GetMiningScoreboard')
end)
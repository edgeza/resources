----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = (function()
    local success, result = pcall(function() return exports[CoreFolder]:GetCoreObject() end)
    if success and result then
        return result
    end
    -- QBX fallback: use QBX exports directly
    local qbx = exports.qbx_core
    if qbx then
        return {
            Functions = {
                GetPlayerData = function() return qbx:GetPlayerData() end,
                Notify = function(msg, type, length) qbx:Notify(msg, type, length) end,
                Progressbar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
                    qbx:Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
                end,
                HasItem = function(item, amount) return qbx:HasItem(item, amount) end,
            },
            Shared = {
                Items = {}
            }
        }
    end
    error('Failed to initialize Core - QBX/QBCore not found')
end)()
local MenuName = Config.CoreSettings.MenuName
--<!>-- DO NOT CHANGE ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--

-- Main menu
local MainMenu = {
    {
        header = Language.Mining.Quarry.Ped.Menu.Main['header'],
        txt = Language.Mining.Quarry.Ped.Menu.Main['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Main['icon'],
        isMenuHeader = true
    },
    {
        header = Language.Mining.Quarry.Ped.Menu.Guide['header'],
        txt = Language.Mining.Quarry.Ped.Menu.Guide['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Guide['icon'],
        params = {
            event = 'boii-mining:sv:TakeGuide',
            isServer = true
        }
    },
    {
        header = Language.Mining.Quarry.Ped.Menu.Permits['header'],
        txt = Language.Mining.Quarry.Ped.Menu.Permits['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Permits['icon'],
        params = {
            event = 'boii-mining:cl:QuarryPermitsMenu',
        }
    },
    {
        header = Language.Mining.Quarry.Ped.Menu.Equipment['header'],
        txt = Language.Mining.Quarry.Ped.Menu.Equipment['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['icon'],
        params = {
            event = 'boii-mining:cl:QuarryEquipmentMenu',
        }
    },
    {
        header = 'Check Mining Level / XP',
        txt = 'View your mining level and XP progress',
        icon = 'fa-solid fa-chart-line',
        params = { event = 'boii-mining:cl:ShowMyXP' }
    },
    {
        header = 'Global Mining Leaderboard',
        txt = 'Top miners on the server',
        icon = 'fa-solid fa-trophy',
        params = { event = 'boii-mining:cl:ShowScoreboard' }
    },
    {
        header = Language.Shared['exitmenu'],
        icon = Language.Shared['exitmenuicon'],
        params = {
            event = 'boii-mining:cl:StopMenu'
        }
    }
}

-- Permits menu
local Permits = {
    {
        header = Language.Mining.Quarry.Ped.Menu.Permits['header'],
        txt = Language.Mining.Quarry.Ped.Menu.Permits['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Permits['icon'],
        isMenuHeader = true
    },
    {
        header = Language.Mining.Quarry.Ped.Menu.Permits['miningheader'],
        txt = Language.Mining.Quarry.Ped.Menu.Permits['miningtext'],
        icon = Language.Mining.Quarry.Ped.Menu.Permits['miningicon'],
        params = {
            event = 'boii-mining:sv:PurchasePermit',
            isServer = true,
            args = {
                permit = 'Mining',
                item = Config.Stores.Permits.Mining.name,
                price = Config.Stores.Permits.Mining.price
            }
        }
    },
    {
        header = Language.Mining.Quarry.Ped.Menu.Permits['cavingheader'],
        txt = Language.Mining.Quarry.Ped.Menu.Permits['cavingtext'],
        icon = Language.Mining.Quarry.Ped.Menu.Permits['cavingicon'],
        params = {
            event = 'boii-mining:sv:PurchasePermit',
            isServer = true,
            args = {
                permit = 'Caving',
                item = Config.Stores.Permits.Caving.name,
                price = Config.Stores.Permits.Caving.price
            }
        }
    },
    {
        header = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        params = {
            event = 'boii-mining:cl:QuarryMenu'
        }
    }
}

local Equipment = {
    {
        header = Language.Mining.Quarry.Ped.Menu.Equipment['header'],
        txt = Language.Mining.Quarry.Ped.Menu.Equipment['text'],
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['icon'],
        isMenuHeader = true
    },
    {
        header = Config.Paydirt.Dirt.Required[1].label,
        txt = 'Price: $'..Config.Paydirt.Dirt.Required[1].price,
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['shovelicon'],
        params = {
            event = 'boii-mining:sv:PurchaseEquipment',
            isServer = true,
            args = {
                equipment = '',
                item = Config.Paydirt.Dirt.Required[1].name,
                price = Config.Paydirt.Dirt.Required[1].price
            }
        }
    },
    {
        header = Config.Paydirt.Dirt.Required[2].label,
        txt = 'Price: $'..Config.Paydirt.Dirt.Required[2].price,
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['sackicon'],
        params = {
            event = 'boii-mining:sv:PurchaseEquipment',
            isServer = true,
            args = {
                equipment = '',
                item = Config.Paydirt.Dirt.Required[2].name,
                price = Config.Paydirt.Dirt.Required[2].price
            }
        }
    },
    {
        header = Config.Paydirt.Panning.Required.label,
        txt = 'Price: $'..Config.Paydirt.Panning.Required.price,
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['sackicon'],
        params = {
            event = 'boii-mining:sv:PurchaseEquipment',
            isServer = true,
            args = {
                equipment = '',
                item = Config.Paydirt.Panning.Required.name,
                price = Config.Paydirt.Panning.Required.price
            }
        }
    },
    {
        header = Language.Mining.Quarry.Ped.Menu.Equipment['jackhammerheader'],
        txt = Language.Mining.Quarry.Ped.Menu.Equipment['jackhammertext'],
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['jackhammericon'],
        params = {
            event = 'boii-mining:sv:PurchaseEquipment',
            isServer = true,
            args = {
                equipment = 'Jackhammer',
                item = Config.Quarry.Drilling.Required.name,
                price = Config.Quarry.Drilling.Required.price
            }
        }
    },
    {
        header = Language.Mining.Quarry.Ped.Menu.Equipment['dynamiteheader'],
        txt = Language.Mining.Quarry.Ped.Menu.Equipment['dynamitetext'],
        icon = Language.Mining.Quarry.Ped.Menu.Equipment['dynamiteicon'],
        params = {
            event = 'boii-mining:sv:PurchaseEquipment',
            isServer = true,
            args = {
                equipment = 'Dynamite',
                item = Config.Quarry.Dynamite.Required.name,
                price = Config.Quarry.Dynamite.Required.price
            }
        }
    },
    {
        header = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        params = {
            event = 'boii-mining:cl:QuarryMenu'
        }
    }
}

-- Menu event
RegisterNetEvent('boii-mining:cl:QuarryMenu', function()
    if Config.Stores.Quarry.Times.Use then
        if GetClockHours() >= Config.Stores.Quarry.Times.Open and GetClockHours() <= Config.Stores.Quarry.Times.Close then
            exports[MenuName]:openMenu(MainMenu)
        else 
            TriggerEvent('boii-mining:notify', Language.Mining.Quarry.Ped['timer'], 'error')
        end
    else
        exports[MenuName]:openMenu(MainMenu)
    end 
end)

-- Sub menus events
RegisterNetEvent('boii-mining:cl:QuarryPermitsMenu', function()
    exports[MenuName]:openMenu(Permits)
end)

RegisterNetEvent('boii-mining:cl:QuarryEquipmentMenu', function()
    exports[MenuName]:openMenu(Equipment)
end)

-- Dedicated Drillbit Shop (for drillbit ped)
RegisterNetEvent('boii-mining:cl:DrillbitShop', function()
    local items = {
        {
            header = 'Drill Bits',
            txt = 'Consumable bits required for cutting',
            icon = Language.Mining.Quarry.Ped.Menu.Equipment['jackhammericon'],
            isMenuHeader = true
        },
        {
            header = Config.Tools.DrillBit.label,
            txt = 'Price: $'..Config.Tools.DrillBit.price,
            params = {
                event = 'boii-mining:sv:PurchaseEquipment',
                isServer = true,
                args = { equipment = 'DrillBit', item = Config.Tools.DrillBit.name, price = Config.Tools.DrillBit.price }
            }
        },
        {
            header = Language.Shared['exitmenu'],
            icon = Language.Shared['exitmenuicon'],
            params = { event = 'boii-mining:cl:StopMenu' }
        }
    }
    exports[MenuName]:openMenu(items)
end)

-- Personal XP/Level display menu
RegisterNetEvent('boii-mining:cl:OpenMyXPMenu', function(data)
    local level = data and data.level or 1
    local total = data and data.total or 0
    local into = data and data.intoLevel or 0
    local nextReq = data and data.nextReq or 0
    local items = {
        { header = 'Your Mining Progress', txt = '', icon = 'fa-solid fa-chart-line', isMenuHeader = true },
        { header = ('Level: %d'):format(level), txt = ('Total XP: %d'):format(total), icon = 'fa-solid fa-person-digging' },
    }
    if nextReq and nextReq > 0 then
        items[#items+1] = { header = ('XP this level: %d/%d'):format(into, nextReq), txt = '', icon = 'fa-solid fa-bars-progress' }
    else
        items[#items+1] = { header = 'MAX Level', txt = ('Total XP: %d'):format(total), icon = 'fa-solid fa-crown' }
    end
    items[#items+1] = { header = Language.Shared['returnmenu'], icon = Language.Shared['returnmenuicon'], params = { event = 'boii-mining:cl:QuarryMenu' } }
    exports[MenuName]:openMenu(items)
end)

-- Global leaderboard display
RegisterNetEvent('boii-mining:cl:OpenScoreboardMenu', function(rows)
    local items = {
        { header = 'Mining Leaderboard', txt = 'Sorted highest level to lowest', icon = 'fa-solid fa-trophy', isMenuHeader = true }
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
                header = prefix .. name,
                txt = ('Level %d | XP %d'):format(entry.level or 1, entry.total or 0),
                icon = icon
            }
        end
    end
    items[#items+1] = { header = Language.Shared['returnmenu'], icon = Language.Shared['returnmenuicon'], params = { event = 'boii-mining:cl:QuarryMenu' } }
    exports[MenuName]:openMenu(items)
end)

-- Client request wrappers to avoid qb-menu server call issues
RegisterNetEvent('boii-mining:cl:ShowMyXP', function()
    TriggerServerEvent('boii-mining:sv:GetMyMiningXP')
end)

RegisterNetEvent('boii-mining:cl:ShowScoreboard', function()
    TriggerServerEvent('boii-mining:sv:GetMiningScoreboard')
end)
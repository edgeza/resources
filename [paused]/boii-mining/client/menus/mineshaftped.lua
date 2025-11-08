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
        title = Language.Mining.Mine.Ped.Menu.Main['header'],
        description = Language.Mining.Mine.Ped.Menu.Main['text'],
        icon = Language.Mining.Mine.Ped.Menu.Main['icon'],
        isMenuHeader = true
    },
    {
        title = Language.Mining.Mine.Ped.Menu.Guide['header'],
        description = Language.Mining.Mine.Ped.Menu.Guide['text'],
        icon = Language.Mining.Mine.Ped.Menu.Guide['icon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:TakeGuide')
        end
    },
    {
        title = Language.Mining.Mine.Ped.Menu.Permits['header'],
        description = Language.Mining.Mine.Ped.Menu.Permits['text'],
        icon = Language.Mining.Mine.Ped.Menu.Permits['icon'],
        onSelect = function()
            TriggerEvent('boii-mining:cl:MinePermitsMenu')
        end
    },
    {
        title = Language.Mining.Mine.Ped.Menu.Equipment['header'],
        description = Language.Mining.Mine.Ped.Menu.Equipment['text'],
        icon = Language.Mining.Mine.Ped.Menu.Equipment['icon'],
        onSelect = function()
            TriggerEvent('boii-mining:cl:MineEquipmentMenu')
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
        title = Language.Mining.Mine.Ped.Menu.Permits['header'],
        description = Language.Mining.Mine.Ped.Menu.Permits['text'],
        icon = Language.Mining.Mine.Ped.Menu.Permits['icon'],
        isMenuHeader = true
    },
    {
        title = Language.Mining.Mine.Ped.Menu.Permits['cavingheader'],
        description = Language.Mining.Mine.Ped.Menu.Permits['cavingtext'],
        icon = Language.Mining.Mine.Ped.Menu.Permits['cavingicon'],
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
            TriggerEvent('boii-mining:cl:MineMenu')
        end
    }
}

local Equipment = {
    {
        title = Language.Mining.Mine.Ped.Menu.Equipment['header'],
        description = Language.Mining.Mine.Ped.Menu.Equipment['text'],
        icon = Language.Mining.Mine.Ped.Menu.Equipment['icon'],
        isMenuHeader = true
    },
    {
        title = Language.Mining.Mine.Ped.Menu.Equipment['jackhammerheader'],
        description = Language.Mining.Mine.Ped.Menu.Equipment['jackhammertext'],
        icon = Language.Mining.Mine.Ped.Menu.Equipment['jackhammericon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:PurchaseEquipment', {
                equipment = 'Jackhammer',
                item = Config.Mine.Drilling.Required.name,
                price = Config.Mine.Drilling.Required.price
            })
        end
    },
    {
        title = Language.Mining.Mine.Ped.Menu.Equipment['dynamiteheader'],
        description = Language.Mining.Mine.Ped.Menu.Equipment['dynamitetext'],
        icon = Language.Mining.Mine.Ped.Menu.Equipment['dynamiteicon'],
        onSelect = function()
            TriggerServerEvent('boii-mining:sv:PurchaseEquipment', {
                equipment = 'Dynamite',
                item = Config.Mine.Dynamite.Required.name,
                price = Config.Mine.Dynamite.Required.price
            })
        end
    },
    {
        title = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        onSelect = function()
            TriggerEvent('boii-mining:cl:MineMenu')
        end
    }
}

-- Menu event
RegisterNetEvent('boii-mining:cl:MineMenu', function()
    if Config.Stores.Mine.Times.Use then
        if GetClockHours() >= Config.Stores.Mine.Times.Open and GetClockHours() <= Config.Stores.Mine.Times.Close then
            lib.registerContext({
                id = 'mine_main_menu',
                title = 'Mine Worker',
                options = MainMenu
            })
            lib.showContext('mine_main_menu')
        else 
            TriggerEvent('boii-mining:notify', Language.Mining.Mine.Ped['timer'], 'error')
        end
    else
        lib.registerContext({
            id = 'mine_main_menu',
            title = 'Mine Worker',
            options = MainMenu
        })
        lib.showContext('mine_main_menu')
    end 
end)

-- Sub menus events
RegisterNetEvent('boii-mining:cl:MinePermitsMenu', function()
    lib.registerContext({
        id = 'mine_permits_menu',
        title = 'Permits',
        options = Permits
    })
    lib.showContext('mine_permits_menu')
end)

RegisterNetEvent('boii-mining:cl:MineEquipmentMenu', function()
    lib.registerContext({
        id = 'mine_equipment_menu',
        title = 'Equipment',
        options = Equipment
    })
    lib.showContext('mine_equipment_menu')
end)
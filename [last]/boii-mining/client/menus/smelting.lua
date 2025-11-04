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
    else
        -- QBX compatibility: return the exports table directly
        return exports[CoreFolder]
    end
end)()
local MenuName = Config.CoreSettings.MenuName
--<!>-- DO NOT CHANGE ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--

-- Main menu
local MainMenu = {
    {
        header = Language.Mining.Smelting.Menu.Main['header'],
        txt = Language.Mining.Smelting.Menu.Main['text'],
        icon = Language.Mining.Smelting.Menu.Main['icon'],
        isMenuHeader = true
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Main['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Main['text'],
        icon = Language.Mining.Smelting.Menu.Ingots.Main['icon'],
        params = {
            event = 'boii-mining:cl:SmeltingIngotsMenu'
        }
    },
    {
        header = Language.Shared['exitmenu'],
        icon = Language.Shared['exitmenuicon'],
        params = {
            event = 'boii-mining:cl:StopMenu'
        }
    }
}

-- Ingots
local Ingots = {
    {
        header = Language.Mining.Smelting.Menu.Ingots.Main['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Main['text'],
        icon = Language.Mining.Smelting.Menu.Ingots.Main['icon'],
        isMenuHeader = true
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Aluminum['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Aluminum['text'],
        icon = 'nui://qs-inventory/html/images/'..Config.Smelting.Ingots.Aluminum.Return.name..'.png',
        params = {
            event = 'boii-mining:cl:Smelt',
            args = {
                timer = Config.Smelting.Ingots.Aluminum.Time,
                x2items = false, -- Toggle use of 2 items to smelt; refer to bronze/steel for example
                req = Config.Smelting.Ingots.Aluminum.Required.name,
                reqamount = Config.Smelting.Ingots.Aluminum.Required.amount,
                req2 = '', -- Not required unless using 2 items; refer to bronze/steel for example
                reqamount2 = '', -- Not required unless using 2 items; refer to bronze/steel for example
                reward = Config.Smelting.Ingots.Aluminum.Return.name,
                rewardamount = Config.Smelting.Ingots.Aluminum.Return.amount
            }
        }
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Copper['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Copper['text'],
        icon = 'nui://qs-inventory/html/images/'..Config.Smelting.Ingots.Copper.Return.name..'.png',
        params = {
            event = 'boii-mining:cl:Smelt',
            args = {
                timer = Config.Smelting.Ingots.Copper.Time,
                x2items = false,
                req = Config.Smelting.Ingots.Copper.Required.name,
                reqamount = Config.Smelting.Ingots.Copper.Required.amount,
                req2 = '',
                reqamount2 = '',
                reward = Config.Smelting.Ingots.Copper.Return.name,
                rewardamount = Config.Smelting.Ingots.Copper.Return.amount
            }
        }
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Iron['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Iron['text'],
        icon = 'nui://qs-inventory/html/images/'..Config.Smelting.Ingots.Iron.Return.name..'.png',
        params = {
            event = 'boii-mining:cl:Smelt',
            args = {
                timer = Config.Smelting.Ingots.Iron.Time,
                x2items = false,
                req = Config.Smelting.Ingots.Iron.Required.name,
                reqamount = Config.Smelting.Ingots.Iron.Required.amount,
                req2 = '',
                reqamount2 = '',
                reward = Config.Smelting.Ingots.Iron.Return.name,
                rewardamount = Config.Smelting.Ingots.Iron.Return.amount
            }
        }
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Tin['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Tin['text'],
        icon = 'nui://qs-inventory/html/images/'..Config.Smelting.Ingots.Tin.Return.name..'.png',
        params = {
            event = 'boii-mining:cl:Smelt',
            args = {
                timer = Config.Smelting.Ingots.Tin.Time,
                x2items = false,
                req = Config.Smelting.Ingots.Tin.Required.name,
                reqamount = Config.Smelting.Ingots.Tin.Required.amount,
                req2 = '',
                reqamount2 = '',
                reward = Config.Smelting.Ingots.Tin.Return.name,
                rewardamount = Config.Smelting.Ingots.Tin.Return.amount
            }
        }
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Gold['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Gold['text'],
        icon = 'nui://qs-inventory/html/images/'..Config.Smelting.Ingots.Gold.Return.name..'.png',
        params = {
            event = 'boii-mining:cl:Smelt',
            args = {
                timer = Config.Smelting.Ingots.Gold.Time,
                x2items = false,
                req = Config.Smelting.Ingots.Gold.Required.name,
                reqamount = Config.Smelting.Ingots.Gold.Required.amount,
                req2 = '',
                reqamount2 = '',
                reward = Config.Smelting.Ingots.Gold.Return.name,
                rewardamount = Config.Smelting.Ingots.Gold.Return.amount
            }
        }
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Silver['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Silver['text'],
        icon = 'nui://qs-inventory/html/images/'..Config.Smelting.Ingots.Silver.Return.name..'.png',
        params = {
            event = 'boii-mining:cl:Smelt',
            args = {
                timer = Config.Smelting.Ingots.Silver.Time,
                x2items = false,
                req = Config.Smelting.Ingots.Silver.Required.name,
                reqamount = Config.Smelting.Ingots.Silver.Required.amount,
                req2 = '',
                reqamount2 = '',
                reward = Config.Smelting.Ingots.Silver.Return.name,
                rewardamount = Config.Smelting.Ingots.Silver.Return.amount
            }
        }
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Cobalt['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Cobalt['text'],
        icon = 'nui://qs-inventory/html/images/'..Config.Smelting.Ingots.Cobalt.Return.name..'.png',
        params = {
            event = 'boii-mining:cl:Smelt',
            args = {
                timer = Config.Smelting.Ingots.Cobalt.Time,
                x2items = false,
                req = Config.Smelting.Ingots.Cobalt.Required.name,
                reqamount = Config.Smelting.Ingots.Cobalt.Required.amount,
                req2 = '',
                reqamount2 = '',
                reward = Config.Smelting.Ingots.Cobalt.Return.name,
                rewardamount = Config.Smelting.Ingots.Cobalt.Return.amount
            }
        }
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Bronze['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Bronze['text'],
        icon = 'nui://qs-inventory/html/images/'..Config.Smelting.Ingots.Bronze.Return.name..'.png',
        params = {
            event = 'boii-mining:cl:Smelt',
            args = {
                timer = Config.Smelting.Ingots.Bronze.Time,
                x2items = true,
                req = Config.Smelting.Ingots.Bronze.Required[1].name,
                reqamount = Config.Smelting.Ingots.Bronze.Required[1].amount,
                req2 = Config.Smelting.Ingots.Bronze.Required[2].name,
                reqamount2 = Config.Smelting.Ingots.Bronze.Required[2].amount,
                reward = Config.Smelting.Ingots.Bronze.Return.name,
                rewardamount = Config.Smelting.Ingots.Bronze.Return.amount
            }
        }
    },
    {
        header = Language.Mining.Smelting.Menu.Ingots.Steel['header'],
        txt = Language.Mining.Smelting.Menu.Ingots.Steel['text'],
        icon = 'nui://qs-inventory/html/images/'..Config.Smelting.Ingots.Steel.Return.name..'.png',
        params = {
            event = 'boii-mining:cl:Smelt',
            args = {
                timer = Config.Smelting.Ingots.Steel.Time,
                x2items = true,
                req = Config.Smelting.Ingots.Steel.Required[1].name,
                reqamount = Config.Smelting.Ingots.Steel.Required[1].amount,
                req2 = Config.Smelting.Ingots.Steel.Required[2].name,
                reqamount2 = Config.Smelting.Ingots.Steel.Required[2].amount,
                reward = Config.Smelting.Ingots.Steel.Return.name,
                rewardamount = Config.Smelting.Ingots.Steel.Return.amount
            }
        }
    },
    {
        header = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        params = {
            event = 'boii-mining:cl:SmeltingMenu'
        }
    }
}

-- Build ingots menu with disabled entries when missing required materials
local function buildIngotsMenuWithDisabled()
    local built = {}
    for _, entry in ipairs(Ingots) do
        local item = {}
        for k, v in pairs(entry) do item[k] = v end
        if not entry.isMenuHeader and entry.params and entry.params.args then
            local args = entry.params.args
            local hasAll = false
            if args.x2items then
                hasAll = Core.Functions.HasItem(args.req, args.reqamount) and Core.Functions.HasItem(args.req2, args.reqamount2)
            else
                hasAll = Core.Functions.HasItem(args.req, args.reqamount)
            end
            item.disabled = not hasAll
        end
        built[#built+1] = item
    end
    return built
end

-- Event
RegisterNetEvent('boii-mining:cl:SmeltingMenu', function()
    exports[MenuName]:openMenu(MainMenu)
end)

-- Sub menu events
RegisterNetEvent('boii-mining:cl:SmeltingIngotsMenu', function()
    exports[MenuName]:openMenu(buildIngotsMenuWithDisabled())
end)

-- Smelt action with animation and item checks
RegisterNetEvent('boii-mining:cl:Smelt', function(args)
    if not args then return end
    -- validate items client-side first
    if args.x2items then
        if not Core.Functions.HasItem(args.req, args.reqamount) or not Core.Functions.HasItem(args.req2, args.reqamount2) then
            TriggerEvent('boii-mining:notify', Language.Mining.Smelting['wrongitems'], 'error')
            return
        end
    else
        if not Core.Functions.HasItem(args.req, args.reqamount) then
            TriggerEvent('boii-mining:notify', Language.Mining.Smelting['wrongitems'], 'error')
            return
        end
    end
    -- Play prep animation, wait, then server smelt
    local ped = PlayerPedId()
    local prep = Config.Animations and Config.Animations.Smelting and Config.Animations.Smelting.Prep
    local wait = Config.Animations and Config.Animations.Smelting and Config.Animations.Smelting.Wait
    local loadDur = (Config.Smelting.Time or 3) * 1000
    if prep and prep.Dict and prep.Anim then
        RequestAnimDict(prep.Dict)
        while not HasAnimDictLoaded(prep.Dict) do Wait(0) end
        TaskPlayAnim(ped, prep.Dict, prep.Anim, 8.0, -8.0, loadDur, (prep.Flags or 49), 0, false, false, false)
        Wait(loadDur)
        StopAnimTask(ped, prep.Dict, prep.Anim, 1.0)
    else
        Wait(loadDur)
    end
    local smeltDur = (args.timer or 5) * 1000
    if Core and Core.Functions and Core.Functions.Progressbar then
        Core.Functions.Progressbar('boii_mining_smelt', 'Smelting...', smeltDur, false, true,
            { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true },
            {}, {}, {}, function() end, function() end)
    end
    if wait and wait.Dict and wait.Anim then
        RequestAnimDict(wait.Dict)
        while not HasAnimDictLoaded(wait.Dict) do Wait(0) end
        TaskPlayAnim(ped, wait.Dict, wait.Anim, 8.0, -8.0, smeltDur, (wait.Flags or 49), 0, false, false, false)
        Wait(smeltDur)
        StopAnimTask(ped, wait.Dict, wait.Anim, 1.0)
    else
        Wait(smeltDur)
    end
    -- trigger server smelt; server handles removals and rewards
    TriggerServerEvent('boii-mining:sv:Smelt', args.reward, args.rewardamount)
    -- reopen ingot menu for quick consecutive smelts
    SetTimeout(500, function()
        exports[MenuName]:openMenu(buildIngotsMenuWithDisabled())
    end)
end)
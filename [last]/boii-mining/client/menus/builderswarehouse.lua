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
        header = Language.Mining.Warehouse.Menu.Builders.Main['header'],
        txt = Language.Mining.Warehouse.Menu.Builders.Main['text'],
        icon = Language.Mining.Warehouse.Menu.Builders.Main['icon'],
        isMenuHeader = true
    },
    {
        header = Language.Mining.Warehouse.Menu.Sell.Main['header'],
        txt = Language.Mining.Warehouse.Menu.Sell.Main['text'],
        icon = Language.Mining.Warehouse.Menu.Sell.Main['icon'],
        params = {
            event = 'boii-mining:cl:WarehouseSellMenu',
        }
    },
    {
        header = Language.Shared['exitmenu'],
        icon = Language.Shared['exitmenuicon'],
        params = {
            event = 'boii-mining:cl:StopMenu'
        }
    },
}

-- Main menu sql
local MainMenuSQL = {
    {
        header = Language.Mining.Warehouse.Menu.Builders.Main['header'],
        txt = Language.Mining.Warehouse.Menu.Builders.Main['text'],
        icon = Language.Mining.Warehouse.Menu.Builders.Main['icon'],
        isMenuHeader = true
    },
    {
        header = Language.Mining.Warehouse.Menu.Sell.Main['header'],
        txt = Language.Mining.Warehouse.Menu.Sell.Main['text'],
        icon = Language.Mining.Warehouse.Menu.Sell.Main['icon'],
        params = {
            event = 'boii-mining:cl:WarehouseSellMenu',
        }
    },
    --{
    --    header = Language.Mining.Warehouse.Menu.Buy.Main['header'],
    --    txt = Language.Mining.Warehouse.Menu.Buy.Main['text'],
    --    icon = Language.Mining.Warehouse.Menu.Buy.Main['icon'],
    --    params = {
    --        event = 'boii-mining:cl:WarehouseBuyMenu',
    --    }
    --},
    {
        header = Language.Shared['exitmenu'],
        icon = Language.Shared['exitmenuicon'],
        params = {
            event = 'boii-mining:cl:StopMenu'
        }
    },
}

-- Selling menu
local Sell = {
    {
        header = Language.Mining.Warehouse.Menu.Sell.Main['header'],
        txt = Language.Mining.Warehouse.Menu.Sell.Main['text'],
        icon = Language.Mining.Warehouse.Menu.Sell.Main['icon'],
        isMenuHeader = true
    },
    {
        header = Language.Mining.Warehouse.Menu.Sell.Ingots['header'],
        txt = Language.Mining.Warehouse.Menu.Sell.Ingots['text'],
        icon = Language.Mining.Warehouse.Menu.Sell.Ingots['icon'],
        params = {
            event = 'boii-mining:cl:WarehouseSellIngots',
        }
    },
    {
        header = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        params = {
            event = 'boii-mining:cl:WarehouseMenu'
        }
    }
}

-- Sell ingots
local SellIngots = {
    {
        header = Language.Mining.Warehouse.Menu.Sell.Ingots['header'],
        txt = Language.Mining.Warehouse.Menu.Sell.Ingots['text'],
        icon = Language.Mining.Warehouse.Menu.Sell.Ingots['icon'],
        isMenuHeader = true
    },
    {
        header = Config.Warehouse.Items.Ingots['aluminum_ingot'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Ingots['aluminum_ingot'].price,
        icon = 'nui://qs-inventory/html/images/'..Config.Warehouse.Items.Ingots['aluminum_ingot'].item..'.png',
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Warehouse',
                item = Config.Warehouse.Items.Ingots['aluminum_ingot'].item,
                label = Config.Warehouse.Items.Ingots['aluminum_ingot'].label,
                price = Config.Warehouse.Items.Ingots['aluminum_ingot'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Ingots['copper_ingot'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Ingots['copper_ingot'].price,
        icon = 'nui://qs-inventory/html/images/'..Config.Warehouse.Items.Ingots['copper_ingot'].item..'.png',
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Warehouse',
                item = Config.Warehouse.Items.Ingots['copper_ingot'].item,
                label = Config.Warehouse.Items.Ingots['copper_ingot'].label,
                price = Config.Warehouse.Items.Ingots['copper_ingot'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Ingots['iron_ingot'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Ingots['iron_ingot'].price,
        icon = 'nui://qs-inventory/html/images/'..Config.Warehouse.Items.Ingots['iron_ingot'].item..'.png',
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Warehouse',
                item = Config.Warehouse.Items.Ingots['iron_ingot'].item,
                label = Config.Warehouse.Items.Ingots['iron_ingot'].label,
                price = Config.Warehouse.Items.Ingots['iron_ingot'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Ingots['tin_ingot'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Ingots['tin_ingot'].price,
        icon = 'nui://qs-inventory/html/images/'..Config.Warehouse.Items.Ingots['tin_ingot'].item..'.png',
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Warehouse',
                item = Config.Warehouse.Items.Ingots['tin_ingot'].item,
                label = Config.Warehouse.Items.Ingots['tin_ingot'].label,
                price = Config.Warehouse.Items.Ingots['tin_ingot'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Ingots['bronze_ingot'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Ingots['bronze_ingot'].price,
        icon = 'nui://qs-inventory/html/images/'..Config.Warehouse.Items.Ingots['bronze_ingot'].item..'.png',
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Warehouse',
                item = Config.Warehouse.Items.Ingots['bronze_ingot'].item,
                label = Config.Warehouse.Items.Ingots['bronze_ingot'].label,
                price = Config.Warehouse.Items.Ingots['bronze_ingot'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Ingots['steel_ingot'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Ingots['steel_ingot'].price,
        icon = 'nui://qs-inventory/html/images/'..Config.Warehouse.Items.Ingots['steel_ingot'].item..'.png',
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Warehouse',
                item = Config.Warehouse.Items.Ingots['steel_ingot'].item,
                label = Config.Warehouse.Items.Ingots['steel_ingot'].label,
                price = Config.Warehouse.Items.Ingots['steel_ingot'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Ingots['cobalt_ingot'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Ingots['cobalt_ingot'].price,
        icon = 'nui://qs-inventory/html/images/'..Config.Warehouse.Items.Ingots['cobalt_ingot'].item..'.png',
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Warehouse',
                item = Config.Warehouse.Items.Ingots['cobalt_ingot'].item,
                label = Config.Warehouse.Items.Ingots['cobalt_ingot'].label,
                price = Config.Warehouse.Items.Ingots['cobalt_ingot'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Ingots['gold_ingot'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Ingots['gold_ingot'].price,
        icon = 'nui://qs-inventory/html/images/'..Config.Warehouse.Items.Ingots['gold_ingot'].item..'.png',
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Warehouse',
                item = Config.Warehouse.Items.Ingots['gold_ingot'].item,
                label = Config.Warehouse.Items.Ingots['gold_ingot'].label,
                price = Config.Warehouse.Items.Ingots['gold_ingot'].price
            }
        }
    },
    -- Heist gold bar removed
    {
        header = Config.Warehouse.Items.Ingots['silver_ingot'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Ingots['silver_ingot'].price,
        icon = 'nui://qs-inventory/html/images/'..Config.Warehouse.Items.Ingots['silver_ingot'].item..'.png',
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Warehouse',
                item = Config.Warehouse.Items.Ingots['silver_ingot'].item,
                label = Config.Warehouse.Items.Ingots['silver_ingot'].label,
                price = Config.Warehouse.Items.Ingots['silver_ingot'].price
            }
        }
    },
    {
        header = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        params = {
            event = 'boii-mining:cl:WarehouseMenu'
        }
    }
}

-- Build selling ingots menu with disabled entries when player lacks the item
local function buildSellIngotsMenuWithDisabled()
    local built = {}
    for _, entry in ipairs(SellIngots) do
        local item = {}
        for k, v in pairs(entry) do item[k] = v end
        if not entry.isMenuHeader and entry.params and entry.params.args and entry.params.args.item then
            local hasItem = Core.Functions.HasItem(entry.params.args.item, 1)
            item.disabled = not hasItem
        end
        built[#built+1] = item
    end
    return built
end

--local Buy = {
--    {
--        header = Language.Mining.Warehouse.Menu.Buy.Main['header'],
--        txt = Language.Mining.Warehouse.Menu.Buy.Main['text'],
--        icon = Language.Mining.Warehouse.Menu.Buy.Main['icon'],
--        isMenuHeader = true
--    },
--    {
--        header = Language.Mining.Warehouse.Menu.Buy.Ingots['header'],
--        txt = Language.Mining.Warehouse.Menu.Buy.Ingots['text'],
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:WarehouseBuyIngots',
--        }
--    },
--    {
--        header = Language.Shared['returnmenu'],
--        icon = Language.Shared['returnmenuicon'],
--        params = {
--            event = 'boii-mining:cl:WarehouseMenu'
--        }
--    }
--}
--
---- Buy ingots
--local BuyIngots = {
--    {
--        header = Language.Mining.Warehouse.Menu.Buy.Ingots['header'],
--        txt = Language.Mining.Warehouse.Menu.Buy.Ingots['text'],
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        isMenuHeader = true
--    },
--    {
--        header = Config.Warehouse.Items.Ingots['aluminum_ingot'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Ingots['aluminum_ingot'].price*Config.Warehouse.Items.Ingots['aluminum_ingot'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Warehouse',
--                item = Config.Warehouse.Items.Ingots['aluminum_ingot'].item,
--                label = Config.Warehouse.Items.Ingots['aluminum_ingot'].label,
--                price = Config.Warehouse.Items.Ingots['aluminum_ingot'].price,
--                buymultiplier = Config.Warehouse.Items.Ingots['aluminum_ingot'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Ingots['copper_ingot'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Ingots['copper_ingot'].price*Config.Warehouse.Items.Ingots['copper_ingot'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Warehouse',
--                item = Config.Warehouse.Items.Ingots['copper_ingot'].item,
--                label = Config.Warehouse.Items.Ingots['copper_ingot'].label,
--                price = Config.Warehouse.Items.Ingots['copper_ingot'].price,
--                buymultiplier = Config.Warehouse.Items.Ingots['copper_ingot'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Ingots['iron_ingot'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Ingots['iron_ingot'].price*Config.Warehouse.Items.Ingots['iron_ingot'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Warehouse',
--                item = Config.Warehouse.Items.Ingots['iron_ingot'].item,
--                label = Config.Warehouse.Items.Ingots['iron_ingot'].label,
--                price = Config.Warehouse.Items.Ingots['iron_ingot'].price,
--                buymultiplier = Config.Warehouse.Items.Ingots['iron_ingot'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Ingots['tin_ingot'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Ingots['tin_ingot'].price*Config.Warehouse.Items.Ingots['tin_ingot'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Warehouse',
--                item = Config.Warehouse.Items.Ingots['tin_ingot'].item,
--                label = Config.Warehouse.Items.Ingots['tin_ingot'].label,
--                price = Config.Warehouse.Items.Ingots['tin_ingot'].price,
--                buymultiplier = Config.Warehouse.Items.Ingots['tin_ingot'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Ingots['bronze_ingot'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Ingots['bronze_ingot'].price*Config.Warehouse.Items.Ingots['bronze_ingot'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Warehouse',
--                item = Config.Warehouse.Items.Ingots['bronze_ingot'].item,
--                label = Config.Warehouse.Items.Ingots['bronze_ingot'].label,
--                price = Config.Warehouse.Items.Ingots['bronze_ingot'].price,
--                buymultiplier = Config.Warehouse.Items.Ingots['bronze_ingot'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Ingots['steel_ingot'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Ingots['steel_ingot'].price*Config.Warehouse.Items.Ingots['steel_ingot'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Warehouse',
--                item = Config.Warehouse.Items.Ingots['steel_ingot'].item,
--                label = Config.Warehouse.Items.Ingots['steel_ingot'].label,
--                price = Config.Warehouse.Items.Ingots['steel_ingot'].price,
--                buymultiplier = Config.Warehouse.Items.Ingots['steel_ingot'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Ingots['cobalt_ingot'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Ingots['cobalt_ingot'].price*Config.Warehouse.Items.Ingots['cobalt_ingot'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Warehouse',
--                item = Config.Warehouse.Items.Ingots['cobalt_ingot'].item,
--                label = Config.Warehouse.Items.Ingots['cobalt_ingot'].label,
--                price = Config.Warehouse.Items.Ingots['cobalt_ingot'].price,
--                buymultiplier = Config.Warehouse.Items.Ingots['cobalt_ingot'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Ingots['gold_ingot'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Ingots['gold_ingot'].price*Config.Warehouse.Items.Ingots['gold_ingot'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Warehouse',
--                item = Config.Warehouse.Items.Ingots['gold_ingot'].item,
--                label = Config.Warehouse.Items.Ingots['gold_ingot'].label,
--                price = Config.Warehouse.Items.Ingots['gold_ingot'].price,
--                buymultiplier = Config.Warehouse.Items.Ingots['gold_ingot'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Ingots['silver_ingot'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Ingots['silver_ingot'].price*Config.Warehouse.Items.Ingots['silver_ingot'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Ingots['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Warehouse',
--                item = Config.Warehouse.Items.Ingots['silver_ingot'].item,
--                label = Config.Warehouse.Items.Ingots['silver_ingot'].label,
--                price = Config.Warehouse.Items.Ingots['silver_ingot'].price,
--                buymultiplier = Config.Warehouse.Items.Ingots['silver_ingot'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Language.Shared['returnmenu'],
--        icon = Language.Shared['returnmenuicon'],
--        params = {
--            event = 'boii-mining:cl:WarehouseMenu'
--        }
--    }
--}

-- Menu event
RegisterNetEvent('boii-mining:cl:WarehouseMenu', function()
    if Config.Warehouse.Builders.Times.Use then
        if GetClockHours() >= Config.Warehouse.Builders.Times.Open and GetClockHours() <= Config.Warehouse.Builders.Times.Close then
            if Config.Warehouse.UseSQL then
                exports[MenuName]:openMenu(MainMenuSQL)
            else
                exports[MenuName]:openMenu(MainMenu)
            end
        else 
            TriggerEvent('boii-mining:notify', Language.Mining.Warehouse.Menu.Builders['timer'], 'error')
        end
    else
        if Config.Warehouse.UseSQL then
            exports[MenuName]:openMenu(MainMenuSQL)
        else
            exports[MenuName]:openMenu(MainMenu)
        end
    end 
end)


-- Submenu events
RegisterNetEvent('boii-mining:cl:WarehouseSellMenu', function()
    exports[MenuName]:openMenu(Sell)
end)

RegisterNetEvent('boii-mining:cl:WarehouseSellIngots', function()
    exports[MenuName]:openMenu(buildSellIngotsMenuWithDisabled())
end)

RegisterNetEvent('boii-mining:cl:WarehouseBuyMenu', function()
    exports[MenuName]:openMenu(Buy)
end)

RegisterNetEvent('boii-mining:cl:WarehouseBuyIngots', function()
    exports[MenuName]:openMenu(BuyIngots)
end)
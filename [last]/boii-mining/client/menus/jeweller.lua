-- removed debug click handler
----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--
local Core = exports['qb-core']:GetCoreObject()
local MenuName = Config.CoreSettings.MenuName
--<!>-- DO NOT CHANGE ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--

-- Progress bar helper
local function showProgress(label, durationMs)
    local name = 'boii_mining_'..tostring(math.random(1000,9999))
    -- Prefer Jim Bridge's on-screen GTA progress bar (renders reliably during scenes)
    local ok = pcall(function()
        CreateThread(function()
            exports['jim_bridge']:gtaProgressBar({
                label = label or 'Working...',
                time = durationMs,
                disableMovement = true,
                disableCombat = true,
                cancel = false,
            })
        end)
    end)
    if ok then return end
    -- QBCore helper
    if Core and Core.Functions and Core.Functions.Progressbar then
        ok = pcall(function()
            Core.Functions.Progressbar(name, label or 'Working...', durationMs, false, true,
                { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true },
                {}, {}, {},
                function() end,
                function() end
            )
        end)
        if ok then return end
    end
    -- Jim Bridge export fallback
    pcall(function()
        CreateThread(function()
            exports['jim_bridge']:progressBar({
                label = label or 'Working...',
                time = durationMs,
                cancel = false,
                disableMovement = true,
                disableCombat = true,
            })
        end)
    end)
    -- Jim Bridge global fallback
    if type(progressBar) == 'function' then
        CreateThread(function()
            pcall(function()
                progressBar({
                    label = label or 'Working...',
                    time = durationMs,
                    cancel = false,
                    disableMovement = true,
                    disableCombat = true,
                })
            end)
        end)
        return
    end
    -- ox_lib fallback
    if lib and (lib.progressBar or lib.progressCircle) then
        CreateThread(function()
            pcall(function()
                if lib.progressBar then
                    lib.progressBar({ duration = durationMs, label = label or 'Working...' })
                else
                    lib.progressCircle({ duration = durationMs, position = 'bottom', label = label or 'Working...' })
                end
            end)
        end)
        return
    end
    -- Common progressbar resources
    ok = pcall(function()
        exports['progressbar']:Progress({ name = name, label = label or 'Working...', duration = durationMs, useWhileDead = false, canCancel = false,
            controlDisables = { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true } }, function(_) end)
    end)
    if ok then return end
    pcall(function()
        exports['qb-progressbar']:Progress({ name = name, label = label or 'Working...', duration = durationMs, useWhileDead = false, canCancel = false,
            controlDisables = { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true } }, function(_) end)
    end)
end

----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--
-- (duplicate header removed)
--<!>-- DO NOT CHANGE ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--

-- Main menu
local MainMenu = {
    {
        header = Language.Mining.Warehouse.Menu.Builders.Main['header'],
        txt = Language.Mining.Warehouse.Menu.Builders.Main['text'],
        icon = Language.Mining.Warehouse.Menu.Builders.Main['icon'],
        isMenuHeader = true
    },
    -- Crafting moved to JewelCut benches
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
        header = Language.Mining.Warehouse.Menu.Jewellers.Main['header'],
        txt = Language.Mining.Warehouse.Menu.Jewellers.Main['text'],
        icon = Language.Mining.Warehouse.Menu.Jewellers.Main['icon'],
        isMenuHeader = true
    },
    -- Crafting moved to JewelCut benches
    {
        header = Language.Mining.Warehouse.Menu.Sell.Main['header'],
        txt = Language.Mining.Warehouse.Menu.Sell.Main['text'],
        icon = Language.Mining.Warehouse.Menu.Sell.Main['icon'],
        params = {
            event = 'boii-mining:cl:JewellerySellMenu',
        }
    },
    --{
    --    header = Language.Mining.Warehouse.Menu.Buy.Main['header'],
    --    txt = Language.Mining.Warehouse.Menu.Buy.Main['text'],
    --    icon = Language.Mining.Warehouse.Menu.Buy.Main['icon'],
    --    params = {
    --        event = 'boii-mining:cl:JewelleryBuyMenu',
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
        header = Language.Mining.Warehouse.Menu.Sell.Gems['header'],
        txt = Language.Mining.Warehouse.Menu.Sell.Gems['text'],
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:cl:JewellerySellGems',
        }
    },
    -- Jewellery removed from sales
    { header = 'Sell Bricks', txt = 'Sell building bricks', icon = 'fa-solid fa-cubes', params = { event = 'boii-mining:cl:JewellerySellBricks' } },
    { header = 'Sell Coins', txt = 'Sell crafted coins', icon = 'fa-solid fa-coins', params = { event = 'boii-mining:cl:JewellerySellCoins' } },
    { header = 'Sell Apples', txt = 'Sell crafted apples', icon = 'fa-solid fa-apple-whole', params = { event = 'boii-mining:cl:JewellerySellApples' } },
    { header = 'Sell Skulls', txt = 'Sell crafted skulls', icon = 'fa-solid fa-skull', params = { event = 'boii-mining:cl:JewellerySellSkulls' } },
    {
        header = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        params = {
            event = 'boii-mining:cl:StopMenu'
        }
    }
}

-- Crafting menu
local Craft = {
    {
        header = Language.Mining.Warehouse.Menu.Craft.Main['header'],
        txt = Language.Mining.Warehouse.Menu.Craft.Main['text'],
        icon = Language.Mining.Warehouse.Menu.Craft.Main['icon'],
        isMenuHeader = true
    },
    {
        header = Language.Mining.Warehouse.Menu.Craft.GemCut['header'],
        txt = Language.Mining.Warehouse.Menu.Craft.GemCut['text'],
        icon = Language.Mining.Warehouse.Menu.Craft.GemCut['icon'],
        params = {
            event = 'boii-mining:cl:OpenCraft',
            args = { craft = 'GemCut' }
        }
    },
    {
        header = 'Apple Crafting',
        txt = 'Craft apples',
        icon = 'fa-solid fa-apple-whole',
        params = { event = 'boii-mining:cl:OpenCraft', args = { craft = 'Apple' } }
    },
    {
        header = 'Coin Crafting',
        txt = 'Craft coins',
        icon = 'fa-solid fa-coins',
        params = { event = 'boii-mining:cl:OpenCraft', args = { craft = 'Coin' } }
    },
    {
        header = 'Skull Crafting',
        txt = 'Craft skulls',
        icon = 'fa-solid fa-skull',
        params = { event = 'boii-mining:cl:OpenCraft', args = { craft = 'Skull' } }
    },
    {
        header = 'Building Bricks Crafting',
        txt = 'Craft building bricks',
        icon = 'fa-solid fa-cubes',
        params = { event = 'boii-mining:cl:OpenCraft', args = { craft = 'Bricks' } }
    }
}

-- Selling gems menu
local SellGems = {
    {
        header = Language.Mining.Warehouse.Menu.Sell.Gems['header'],
        txt = Language.Mining.Warehouse.Menu.Sell.Gems['text'],
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        isMenuHeader = true
    },
    {
        header = Config.Warehouse.Items.Gems['amethyst'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['amethyst'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['amethyst'].item,
                label = Config.Warehouse.Items.Gems['amethyst'].label,
                price = Config.Warehouse.Items.Gems['amethyst'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Gems['citrine'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['citrine'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['citrine'].item,
                label = Config.Warehouse.Items.Gems['citrine'].label,
                price = Config.Warehouse.Items.Gems['citrine'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Gems['hematite'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['hematite'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['hematite'].item,
                label = Config.Warehouse.Items.Gems['hematite'].label,
                price = Config.Warehouse.Items.Gems['hematite'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Gems['kyanite'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['kyanite'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['kyanite'].item,
                label = Config.Warehouse.Items.Gems['kyanite'].label,
                price = Config.Warehouse.Items.Gems['kyanite'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Gems['onyx'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['onyx'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['onyx'].item,
                label = Config.Warehouse.Items.Gems['onyx'].label,
                price = Config.Warehouse.Items.Gems['onyx'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Gems['diamond'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['diamond'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['diamond'].item,
                label = Config.Warehouse.Items.Gems['diamond'].label,
                price = Config.Warehouse.Items.Gems['diamond'].price
           }
        }
    },
    {
        header = Config.Warehouse.Items.Gems['emerald'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['emerald'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['emerald'].item,
                label = Config.Warehouse.Items.Gems['emerald'].label,
                price = Config.Warehouse.Items.Gems['emerald'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Gems['ruby'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['ruby'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['ruby'].item,
                label = Config.Warehouse.Items.Gems['ruby'].label,
                price = Config.Warehouse.Items.Gems['ruby'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Gems['sapphire'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['sapphire'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['sapphire'].item,
                label = Config.Warehouse.Items.Gems['sapphire'].label,
                price = Config.Warehouse.Items.Gems['sapphire'].price
            }
        }
    },
    {
        header = Config.Warehouse.Items.Gems['tanzanite'].label,
        txt = 'Price: $'..Config.Warehouse.Items.Gems['tanzanite'].price,
        icon = Language.Mining.Warehouse.Menu.Sell.Gems['icon'],
        params = {
            event = 'boii-mining:sv:SellItems',
            isServer = true,
            args = {
                store = 'Jeweller',
                item = Config.Warehouse.Items.Gems['tanzanite'].item,
                label = Config.Warehouse.Items.Gems['tanzanite'].label,
                price = Config.Warehouse.Items.Gems['tanzanite'].price
            }
        }
    },
    {
        header = Language.Shared['returnmenu'],
        icon = Language.Shared['returnmenuicon'],
        params = {
            event = 'boii-mining:cl:JewellerySellMenu'
        }
    }
}

-- Build sell menus with disabled entries when player lacks the item
local function buildDisabledList(list, getItem)
    local built = {}
    for _, entry in ipairs(list) do
        local item = {}
        for k, v in pairs(entry) do item[k] = v end
        if not entry.isMenuHeader and entry.params and entry.params.args and entry.params.args.item then
            local need = entry.params.args.item
            local hasItem = Core.Functions.HasItem(need, 1)
            item.disabled = not hasItem
        end
        built[#built+1] = item
    end
    return built
end

-- Selling jewellery menu (rings/necklaces)
local SellJewellery = {
    {
        header = 'Sell Jewellery',
        txt = 'Sell crafted rings and necklaces',
        icon = Language.Mining.Warehouse.Menu.Sell.Main['icon'],
        isMenuHeader = true
    },
    -- Jewellery removed
    { header = Language.Shared['returnmenu'], icon = Language.Shared['returnmenuicon'], params = { event = 'boii-mining:cl:JewellerySellMenu' }},
}

-- Selling bricks menu
local SellBricks = {
    { header = 'Sell Bricks', txt = 'Sell building bricks', icon = 'fa-solid fa-cubes', isMenuHeader = true },
    { header = Config.Warehouse.Items.Bricks['gold_building_brick'].label, txt = 'Price: $'..Config.Warehouse.Items.Bricks['gold_building_brick'].price, icon = 'fa-solid fa-cubes', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Bricks['gold_building_brick'].item, label = Config.Warehouse.Items.Bricks['gold_building_brick'].label, price = Config.Warehouse.Items.Bricks['gold_building_brick'].price } } },
    { header = Config.Warehouse.Items.Bricks['diamond_building_brick'].label, txt = 'Price: $'..Config.Warehouse.Items.Bricks['diamond_building_brick'].price, icon = 'fa-solid fa-cubes', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Bricks['diamond_building_brick'].item, label = Config.Warehouse.Items.Bricks['diamond_building_brick'].label, price = Config.Warehouse.Items.Bricks['diamond_building_brick'].price } } },
    { header = Config.Warehouse.Items.Bricks['emerald_building_brick'].label, txt = 'Price: $'..Config.Warehouse.Items.Bricks['emerald_building_brick'].price, icon = 'fa-solid fa-cubes', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Bricks['emerald_building_brick'].item, label = Config.Warehouse.Items.Bricks['emerald_building_brick'].label, price = Config.Warehouse.Items.Bricks['emerald_building_brick'].price } } },
    { header = Config.Warehouse.Items.Bricks['ruby_building_brick'].label, txt = 'Price: $'..Config.Warehouse.Items.Bricks['ruby_building_brick'].price, icon = 'fa-solid fa-cubes', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Bricks['ruby_building_brick'].item, label = Config.Warehouse.Items.Bricks['ruby_building_brick'].label, price = Config.Warehouse.Items.Bricks['ruby_building_brick'].price } } },
    { header = Config.Warehouse.Items.Bricks['sapphire_building_brick'].label, txt = 'Price: $'..Config.Warehouse.Items.Bricks['sapphire_building_brick'].price, icon = 'fa-solid fa-cubes', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Bricks['sapphire_building_brick'].item, label = Config.Warehouse.Items.Bricks['sapphire_building_brick'].label, price = Config.Warehouse.Items.Bricks['sapphire_building_brick'].price } } },
    { header = Config.Warehouse.Items.Bricks['tanzanite_building_brick'].label, txt = 'Price: $'..Config.Warehouse.Items.Bricks['tanzanite_building_brick'].price, icon = 'fa-solid fa-cubes', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Bricks['tanzanite_building_brick'].item, label = Config.Warehouse.Items.Bricks['tanzanite_building_brick'].label, price = Config.Warehouse.Items.Bricks['tanzanite_building_brick'].price } } },
    { header = Config.Warehouse.Items.Bricks['the_prism_brick'].label, txt = 'Price: $'..Config.Warehouse.Items.Bricks['the_prism_brick'].price, icon = 'fa-solid fa-cubes', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Bricks['the_prism_brick'].item, label = Config.Warehouse.Items.Bricks['the_prism_brick'].label, price = Config.Warehouse.Items.Bricks['the_prism_brick'].price } } },
    { header = Language.Shared['returnmenu'], icon = Language.Shared['returnmenuicon'], params = { event = 'boii-mining:cl:JewellerySellMenu' }},
}

-- Selling coins menu
local SellCoins = {
    { header = 'Sell Coins', txt = 'Sell crafted coins', icon = 'fa-solid fa-coins', isMenuHeader = true },
    { header = Config.Warehouse.Items.Coins['gold_coin_mining'].label, txt = 'Price: $'..Config.Warehouse.Items.Coins['gold_coin_mining'].price, icon = 'fa-solid fa-coins', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Coins['gold_coin_mining'].item, label = Config.Warehouse.Items.Coins['gold_coin_mining'].label, price = Config.Warehouse.Items.Coins['gold_coin_mining'].price } } },
    { header = Config.Warehouse.Items.Coins['diamond_coin'].label, txt = 'Price: $'..Config.Warehouse.Items.Coins['diamond_coin'].price, icon = 'fa-solid fa-coins', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Coins['diamond_coin'].item, label = Config.Warehouse.Items.Coins['diamond_coin'].label, price = Config.Warehouse.Items.Coins['diamond_coin'].price } } },
    { header = Config.Warehouse.Items.Coins['emerald_coin'].label, txt = 'Price: $'..Config.Warehouse.Items.Coins['emerald_coin'].price, icon = 'fa-solid fa-coins', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Coins['emerald_coin'].item, label = Config.Warehouse.Items.Coins['emerald_coin'].label, price = Config.Warehouse.Items.Coins['emerald_coin'].price } } },
    { header = Config.Warehouse.Items.Coins['ruby_coin'].label, txt = 'Price: $'..Config.Warehouse.Items.Coins['ruby_coin'].price, icon = 'fa-solid fa-coins', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Coins['ruby_coin'].item, label = Config.Warehouse.Items.Coins['ruby_coin'].label, price = Config.Warehouse.Items.Coins['ruby_coin'].price } } },
    { header = Config.Warehouse.Items.Coins['sapphire_coin'].label, txt = 'Price: $'..Config.Warehouse.Items.Coins['sapphire_coin'].price, icon = 'fa-solid fa-coins', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Coins['sapphire_coin'].item, label = Config.Warehouse.Items.Coins['sapphire_coin'].label, price = Config.Warehouse.Items.Coins['sapphire_coin'].price } } },
    { header = Config.Warehouse.Items.Coins['tanzanite_coin'].label, txt = 'Price: $'..Config.Warehouse.Items.Coins['tanzanite_coin'].price, icon = 'fa-solid fa-coins', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Coins['tanzanite_coin'].item, label = Config.Warehouse.Items.Coins['tanzanite_coin'].label, price = Config.Warehouse.Items.Coins['tanzanite_coin'].price } } },
    { header = Config.Warehouse.Items.Coins['multi_coin'].label, txt = 'Price: $'..Config.Warehouse.Items.Coins['multi_coin'].price, icon = 'fa-solid fa-coins', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Coins['multi_coin'].item, label = Config.Warehouse.Items.Coins['multi_coin'].label, price = Config.Warehouse.Items.Coins['multi_coin'].price } } },
    { header = Language.Shared['returnmenu'], icon = Language.Shared['returnmenuicon'], params = { event = 'boii-mining:cl:JewellerySellMenu' }},
}

-- Selling apples menu
local SellApples = {
    { header = 'Sell Apples', txt = 'Sell crafted apples', icon = 'fa-solid fa-apple-whole', isMenuHeader = true },
    { header = Config.Warehouse.Items.Apples['gold_apple'].label, txt = 'Price: $'..Config.Warehouse.Items.Apples['gold_apple'].price, icon = 'fa-solid fa-apple-whole', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Apples['gold_apple'].item, label = Config.Warehouse.Items.Apples['gold_apple'].label, price = Config.Warehouse.Items.Apples['gold_apple'].price } } },
    { header = Config.Warehouse.Items.Apples['diamond_apple'].label, txt = 'Price: $'..Config.Warehouse.Items.Apples['diamond_apple'].price, icon = 'fa-solid fa-apple-whole', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Apples['diamond_apple'].item, label = Config.Warehouse.Items.Apples['diamond_apple'].label, price = Config.Warehouse.Items.Apples['diamond_apple'].price } } },
    { header = Config.Warehouse.Items.Apples['emerald_apple'].label, txt = 'Price: $'..Config.Warehouse.Items.Apples['emerald_apple'].price, icon = 'fa-solid fa-apple-whole', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Apples['emerald_apple'].item, label = Config.Warehouse.Items.Apples['emerald_apple'].label, price = Config.Warehouse.Items.Apples['emerald_apple'].price } } },
    { header = Config.Warehouse.Items.Apples['ruby_apple'].label, txt = 'Price: $'..Config.Warehouse.Items.Apples['ruby_apple'].price, icon = 'fa-solid fa-apple-whole', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Apples['ruby_apple'].item, label = Config.Warehouse.Items.Apples['ruby_apple'].label, price = Config.Warehouse.Items.Apples['ruby_apple'].price } } },
    { header = Config.Warehouse.Items.Apples['sapphire_apple'].label, txt = 'Price: $'..Config.Warehouse.Items.Apples['sapphire_apple'].price, icon = 'fa-solid fa-apple-whole', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Apples['sapphire_apple'].item, label = Config.Warehouse.Items.Apples['sapphire_apple'].label, price = Config.Warehouse.Items.Apples['sapphire_apple'].price } } },
    { header = Config.Warehouse.Items.Apples['tanzanite_apple'].label, txt = 'Price: $'..Config.Warehouse.Items.Apples['tanzanite_apple'].price, icon = 'fa-solid fa-apple-whole', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Apples['tanzanite_apple'].item, label = Config.Warehouse.Items.Apples['tanzanite_apple'].label, price = Config.Warehouse.Items.Apples['tanzanite_apple'].price } } },
    { header = Config.Warehouse.Items.Apples['jewel_of_eden'].label, txt = 'Price: $'..Config.Warehouse.Items.Apples['jewel_of_eden'].price, icon = 'fa-solid fa-apple-whole', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Apples['jewel_of_eden'].item, label = Config.Warehouse.Items.Apples['jewel_of_eden'].label, price = Config.Warehouse.Items.Apples['jewel_of_eden'].price } } },
    { header = Language.Shared['returnmenu'], icon = Language.Shared['returnmenuicon'], params = { event = 'boii-mining:cl:JewellerySellMenu' }},
}

-- Selling skulls menu
local SellSkulls = {
    { header = 'Sell Skulls', txt = 'Sell crafted skulls', icon = 'fa-solid fa-skull', isMenuHeader = true },
    { header = Config.Warehouse.Items.Skulls['gold_skull'].label, txt = 'Price: $'..Config.Warehouse.Items.Skulls['gold_skull'].price, icon = 'fa-solid fa-skull', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Skulls['gold_skull'].item, label = Config.Warehouse.Items.Skulls['gold_skull'].label, price = Config.Warehouse.Items.Skulls['gold_skull'].price } } },
    { header = Config.Warehouse.Items.Skulls['diamond_skull'].label, txt = 'Price: $'..Config.Warehouse.Items.Skulls['diamond_skull'].price, icon = 'fa-solid fa-skull', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Skulls['diamond_skull'].item, label = Config.Warehouse.Items.Skulls['diamond_skull'].label, price = Config.Warehouse.Items.Skulls['diamond_skull'].price } } },
    { header = Config.Warehouse.Items.Skulls['emerald_skull'].label, txt = 'Price: $'..Config.Warehouse.Items.Skulls['emerald_skull'].price, icon = 'fa-solid fa-skull', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Skulls['emerald_skull'].item, label = Config.Warehouse.Items.Skulls['emerald_skull'].label, price = Config.Warehouse.Items.Skulls['emerald_skull'].price } } },
    { header = Config.Warehouse.Items.Skulls['ruby_skull'].label, txt = 'Price: $'..Config.Warehouse.Items.Skulls['ruby_skull'].price, icon = 'fa-solid fa-skull', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Skulls['ruby_skull'].item, label = Config.Warehouse.Items.Skulls['ruby_skull'].label, price = Config.Warehouse.Items.Skulls['ruby_skull'].price } } },
    { header = Config.Warehouse.Items.Skulls['sapphire_skull'].label, txt = 'Price: $'..Config.Warehouse.Items.Skulls['sapphire_skull'].price, icon = 'fa-solid fa-skull', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Skulls['sapphire_skull'].item, label = Config.Warehouse.Items.Skulls['sapphire_skull'].label, price = Config.Warehouse.Items.Skulls['sapphire_skull'].price } } },
    { header = Config.Warehouse.Items.Skulls['tanzanite_skull'].label, txt = 'Price: $'..Config.Warehouse.Items.Skulls['tanzanite_skull'].price, icon = 'fa-solid fa-skull', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Skulls['tanzanite_skull'].item, label = Config.Warehouse.Items.Skulls['tanzanite_skull'].label, price = Config.Warehouse.Items.Skulls['tanzanite_skull'].price } } },
    { header = Config.Warehouse.Items.Skulls['the_oracle_of_gems'].label, txt = 'Price: $'..Config.Warehouse.Items.Skulls['the_oracle_of_gems'].price, icon = 'fa-solid fa-skull', params = { event = 'boii-mining:sv:SellItems', isServer = true, args = { store = 'Jeweller', item = Config.Warehouse.Items.Skulls['the_oracle_of_gems'].item, label = Config.Warehouse.Items.Skulls['the_oracle_of_gems'].label, price = Config.Warehouse.Items.Skulls['the_oracle_of_gems'].price } } },
    { header = Language.Shared['returnmenu'], icon = Language.Shared['returnmenuicon'], params = { event = 'boii-mining:cl:JewellerySellMenu' }},
}

-- Buying menu
--local Buy = {
--    {
--        header = Language.Mining.Warehouse.Menu.Buy.Main['header'],
--        txt = Language.Mining.Warehouse.Menu.Buy.Main['text'],
--        icon = Language.Mining.Warehouse.Menu.Buy.Main['icon'],
--        isMenuHeader = true
--    },
--    {
--        header = Language.Mining.Warehouse.Menu.Buy.Gems['header'],
--        txt = Language.Mining.Warehouse.Menu.Buy.Gems['text'],
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:JewelleryBuyGems',
--        }
--    },
--    {
--        header = Language.Shared['returnmenu'],
--        icon = Language.Shared['returnmenuicon'],
--        params = {
--            event = 'boii-mining:cl:JewelleryMenu'
--        }
--    }
--}
--
---- Buy gems menu
--local BuyGems = {
--    {
--        header = Language.Mining.Warehouse.Menu.Buy.Gems['header'],
--        txt = Language.Mining.Warehouse.Menu.Buy.Gems['text'],
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        isMenuHeader = true
--    },
--    {
--        header = Config.Warehouse.Items.Gems['amethyst'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['amethyst'].price*Config.Warehouse.Items.Gems['amethyst'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['amethyst'].item,
--                label = Config.Warehouse.Items.Gems['amethyst'].label,
--                price = Config.Warehouse.Items.Gems['amethyst'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['amethyst'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Gems['citrine'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['citrine'].price*Config.Warehouse.Items.Gems['citrine'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['citrine'].item,
--                label = Config.Warehouse.Items.Gems['citrine'].label,
--                price = Config.Warehouse.Items.Gems['citrine'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['citrine'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Gems['hematite'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['hematite'].price*Config.Warehouse.Items.Gems['hematite'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['hematite'].item,
--                label = Config.Warehouse.Items.Gems['hematite'].label,
--                price = Config.Warehouse.Items.Gems['hematite'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['hematite'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Gems['kyanite'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['kyanite'].price*Config.Warehouse.Items.Gems['kyanite'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['kyanite'].item,
--                label = Config.Warehouse.Items.Gems['kyanite'].label,
--                price = Config.Warehouse.Items.Gems['kyanite'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['kyanite'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Gems['onyx'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['onyx'].price*Config.Warehouse.Items.Gems['onyx'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['onyx'].item,
--                label = Config.Warehouse.Items.Gems['onyx'].label,
--                price = Config.Warehouse.Items.Gems['onyx'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['onyx'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Gems['diamond'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['diamond'].price*Config.Warehouse.Items.Gems['diamond'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['diamond'].item,
--                label = Config.Warehouse.Items.Gems['diamond'].label,
--                price = Config.Warehouse.Items.Gems['diamond'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['diamond'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Gems['emerald'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['emerald'].price*Config.Warehouse.Items.Gems['emerald'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['emerald'].item,
--                label = Config.Warehouse.Items.Gems['emerald'].label,
--                price = Config.Warehouse.Items.Gems['emerald'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['emerald'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Gems['ruby'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['ruby'].price*Config.Warehouse.Items.Gems['ruby'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['ruby'].item,
--                label = Config.Warehouse.Items.Gems['ruby'].label,
--                price = Config.Warehouse.Items.Gems['ruby'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['ruby'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Gems['sapphire'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['sapphire'].price*Config.Warehouse.Items.Gems['sapphire'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['sapphire'].item,
--                label = Config.Warehouse.Items.Gems['sapphire'].label,
--                price = Config.Warehouse.Items.Gems['sapphire'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['sapphire'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Config.Warehouse.Items.Gems['tanzanite'].label,
--        txt = 'Price: $'..math.ceil(Config.Warehouse.Items.Gems['tanzanite'].price*Config.Warehouse.Items.Gems['tanzanite'].buymultiplier),
--        icon = Language.Mining.Warehouse.Menu.Buy.Gems['icon'],
--        params = {
--            event = 'boii-mining:cl:BuyItems',
--            args = {
--                store = 'Jeweller',
--                item = Config.Warehouse.Items.Gems['tanzanite'].item,
--                label = Config.Warehouse.Items.Gems['tanzanite'].label,
--                price = Config.Warehouse.Items.Gems['tanzanite'].price,
--                buymultiplier = Config.Warehouse.Items.Gems['tanzanite'].buymultiplier
--            }
--        }
--    },
--    {
--        header = Language.Shared['returnmenu'],
--        icon = Language.Shared['returnmenuicon'],
--        params = {
--            event = 'boii-mining:cl:JewelleryBuyMenu'
--        }
--    }
--}

-- Menu event
RegisterNetEvent('boii-mining:cl:JewelleryMenu', function()
    if Config.Warehouse.Jewellers.Times.Use then
        if GetClockHours() >= Config.Warehouse.Jewellers.Times.Open and GetClockHours() <= Config.Warehouse.Jewellers.Times.Close then
            if Config.Warehouse.UseSQL then
                exports[MenuName]:openMenu(MainMenuSQL)
            else
                exports[MenuName]:openMenu(MainMenu)
            end
        else 
            TriggerEvent('boii-mining:notify', Language.Mining.Warehouse.Menu.Jewellers['timer'], 'error')
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
RegisterNetEvent('boii-mining:cl:JewellerySellMenu', function()
    exports[MenuName]:openMenu(Sell)
end)

RegisterNetEvent('boii-mining:cl:JewellerySellGems', function()
    exports[MenuName]:openMenu(buildDisabledList(SellGems))
end)

RegisterNetEvent('boii-mining:cl:JewellerySellJewellery', function()
    exports[MenuName]:openMenu(SellJewellery)
end)

RegisterNetEvent('boii-mining:cl:JewellerySellBricks', function()
    exports[MenuName]:openMenu(buildDisabledList(SellBricks))
end)

RegisterNetEvent('boii-mining:cl:JewellerySellCoins', function()
    exports[MenuName]:openMenu(buildDisabledList(SellCoins))
end)

RegisterNetEvent('boii-mining:cl:JewellerySellApples', function()
    exports[MenuName]:openMenu(buildDisabledList(SellApples))
end)

RegisterNetEvent('boii-mining:cl:JewellerySellSkulls', function()
    exports[MenuName]:openMenu(buildDisabledList(SellSkulls))
end)

RegisterNetEvent('boii-mining:cl:JewelleryBuyMenu', function()
    exports[MenuName]:openMenu(Buy)
end)

RegisterNetEvent('boii-mining:cl:JewelleryBuyGems', function()
    exports[MenuName]:openMenu(BuyGems)
end)

-- Crafting events
RegisterNetEvent('boii-mining:cl:JewelleryCraftMenu', function()
    exports[MenuName]:openMenu(Craft)
end)

RegisterNetEvent('boii-mining:cl:OpenCraft', function(data)
    -- Open the selected craft category without animation
    TriggerServerEvent('boii-mining:sv:OpenCraft', data.craft)
end)

-- Jewel bench animation + open craft category
RegisterNetEvent('boii-mining:cl:JewelBenchAnim', function(data)
    local bench
    local ped = PlayerPedId()
    for obj in EnumerateObjects() do
        if GetEntityModel(obj) == GetHashKey(Config.JewelCutting.Prop.model) and #(GetEntityCoords(obj) - GetEntityCoords(ped)) < 4.0 then
            bench = obj
            break
        end
    end
    local dict = 'anim@amb@machinery@speed_drill@'
    local anim = 'operate_02_hi_amy_skater_01'
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    local scene
    if bench then
        local pos = GetEntityCoords(bench)
        local rot = GetEntityRotation(bench)
        scene = NetworkCreateSynchronisedScene(pos, rot, 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, scene, dict, anim, 0, 0, 0, 16, 1148846080, 0)
        NetworkStartSynchronisedScene(scene)
        -- sound + dust
        RequestAmbientAudioBank('DLC_HEIST_FLEECA_SOUNDSET', 0)
        local sid = GetSoundId()
        PlaySoundFromEntity(sid, 'Drill', bench, 'DLC_HEIST_FLEECA_SOUNDSET', 1, 0)
        UseParticleFxAssetNextCall('core')
        RequestNamedPtfxAsset('core')
        while not HasNamedPtfxAssetLoaded('core') do Wait(0) end
        local start = GetGameTimer()
        showProgress('Crafting...', (Config.JewelCutting.Time * 1000))
        while GetGameTimer() - start < (Config.JewelCutting.Time * 1000) do
            UseParticleFxAssetNextCall('core')
            StartNetworkedParticleFxNonLoopedAtCoord('glass_side_window', pos.x, pos.y, pos.z + 1.1, 0.0, 0.0, GetEntityHeading(ped) + math.random(0,359), 0.2, 0.0, 0.0, 0.0)
            Wait(120)
        end
        StopSound(sid)
        ReleaseAmbientAudioBank('DLC_HEIST_FLEECA_SOUNDSET')
        NetworkStopSynchronisedScene(scene)
    else
        TaskPlayAnim(ped, dict, anim, 8.0, -8.0, Config.JewelCutting.Time * 1000, 49, 0, false, false, false)
        Wait(Config.JewelCutting.Time * 1000)
        StopAnimTask(ped, dict, anim, 1.0)
    end
    TriggerServerEvent('boii-mining:sv:OpenCraft', data.category)
end)

-- helpers
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, {__gc = function(e)
            if e.destructor and e.handle then e.destructor(e.handle) end
            e.destructor, e.handle = nil, nil
        end})
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

local function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

-- Play animation then request server craft
RegisterNetEvent('boii-mining:cl:DoJewelCraft', function(data)
    if LocalPlayer.state.jewel_crafting_busy then return end
    LocalPlayer.state:set('jewel_crafting_busy', true, true)
    -- close menu to avoid double clicks
    if MenuName then pcall(function() exports[MenuName]:closeMenu() end) end
    local rewardName = data and (data.rewardName or (data.reward and data.reward.name)) or 'unknown'
    if Config.Debug then print(('^6[boii-mining]^7 sending craft for %s'):format(tostring(rewardName))) end
    TriggerEvent('boii-mining:notify', 'Preparing craft: '..tostring(rewardName), 'primary')
    -- Server validates items, but do a quick client check to avoid playing animation if missing items or drill bit
    if data and data.required then
        for item, amount in pairs(data.required) do
            local has = Core.Functions.HasItem(item, amount)
            if not has then
                TriggerEvent('boii-mining:notify', "You don't have the required materials.", 'error')
                LocalPlayer.state:set('jewel_crafting_busy', false, true)
                return
            end
        end
    end
    if data and data.needBit then
        local hasBit = Core.Functions.HasItem(Config.Tools.DrillBit.name, 1)
        if not hasBit then
            TriggerEvent('boii-mining:notify', 'You need a '..Config.Tools.DrillBit.label..' to craft here.', 'error')
            LocalPlayer.state:set('jewel_crafting_busy', false, true)
            return
        end
    end
    -- Only animate for gem cuts, rings, necklaces, earrings (all jeweller crafts)
    local ped = PlayerPedId()
    local bench
    do
        local pedPos = GetEntityCoords(ped)
        local closest = 9999.0
        for obj in EnumerateObjects() do
            if GetEntityModel(obj) == GetHashKey(Config.JewelCutting.Prop.model) then
                local dist = #(GetEntityCoords(obj) - pedPos)
                if dist < closest and dist < 6.0 then
                    closest = dist
                    bench = obj
                end
            end
        end
    end
    local dict = 'anim@amb@machinery@speed_drill@'
    local anim = 'operate_02_hi_amy_skater_01'
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    local scene
    if bench then
        local pos = GetEntityCoords(bench)
        local rot = GetEntityRotation(bench)
        scene = NetworkCreateSynchronisedScene(pos, rot, 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, scene, dict, anim, 0, 0, 0, 16, 1148846080, 0)
        NetworkStartSynchronisedScene(scene)
        RequestAmbientAudioBank('DLC_HEIST_FLEECA_SOUNDSET', 0)
        local sid = GetSoundId()
        PlaySoundFromEntity(sid, 'Drill', bench, 'DLC_HEIST_FLEECA_SOUNDSET', 0.5, 0)
        RequestNamedPtfxAsset('core')
        while not HasNamedPtfxAssetLoaded('core') do Wait(0) end
        local start = GetGameTimer()
        showProgress('Crafting...', (Config.JewelCutting.Time * 1000))
        while GetGameTimer() - start < (Config.JewelCutting.Time * 1000) do
            UseParticleFxAssetNextCall('core')
            StartNetworkedParticleFxNonLoopedAtCoord('glass_side_window', pos.x, pos.y, pos.z + 1.1, 0.0, 0.0, GetEntityHeading(ped) + math.random(0,359), 0.2, 0.0, 0.0, 0.0)
            Wait(120)
        end
        StopSound(sid)
        ReleaseAmbientAudioBank('DLC_HEIST_FLEECA_SOUNDSET')
        NetworkStopSynchronisedScene(scene)
    else
        showProgress('Crafting...', (Config.JewelCutting.Time * 1000))
        TaskPlayAnim(ped, dict, anim, 8.0, -8.0, Config.JewelCutting.Time * 1000, 49, 0, false, false, false)
        Wait(Config.JewelCutting.Time * 1000)
        StopAnimTask(ped, dict, anim, 1.0)
    end
    data = { rewardName = rewardName }
    data.requestId = (GetGameTimer and GetGameTimer() or math.random(1, 2^31-1)) .. '-' .. tostring(math.random(100000,999999))
    TriggerServerEvent('boii-mining:sv:CraftItem', data)
    SetTimeout(2000, function() LocalPlayer.state:set('jewel_crafting_busy', false, true) end)
end)
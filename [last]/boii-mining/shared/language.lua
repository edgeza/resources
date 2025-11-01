----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

Language = {
    XP = {
        ['chat_suggestion'] = 'Displays your current mining xp.', -- Command text
        ['notif'] = 'Mining:', -- Notification
    },
    Mining = {
        Quarry = {
            Ped = {
                Menu = {
                    Main = {
                        ['header'] = 'Quarry Worker', -- Menu header
                        ['text'] = 'So your interesting in mining?', -- Menu text
                        ['icon'] = 'fa-solid fa-gem' -- Menu icon
                    },
                    Guide = {
                        ['header'] = 'Handbook!', -- Menu header   
                        ['text'] = 'Pickup a mining handbook here!', -- Menu text
                        ['icon'] = 'fa-solid fa-circle-info' -- Menu header icon
                    },
                    Permits = { 
                        ['header'] = 'Permits!', -- Menu header    
                        ['text'] = 'Purchase permits required for mining here!', -- Menu text 
                        ['icon'] = 'fa-solid fa-clipboard-check', -- Menu header icon
                        ['miningheader'] = 'Mining Permit', -- Menu header
                        ['miningtext'] = 'Price: $'..Config.Stores.Permits.Mining.price, -- Menu header 
                        ['miningicon'] = 'fa-solid fa-ticket', -- Menu header icon
                        ['cavingheader'] = 'Caving Permit', -- Menu header
                        ['cavingtext'] = 'Price: $'..Config.Stores.Permits.Caving.price, -- Menu header 
                        ['cavingicon'] = 'fa-solid fa-ticket' -- Menu header icon
                    },
                    Equipment = {
                        ['header'] = 'Equipment!', -- Menu header   
                        ['text'] = 'Purchase equipment required for mining here!', -- Menu text
                        ['icon'] = 'fa-solid fa-basket-shopping', -- Menu header icon
                        ['shovelheader'] = 'Shovel', -- Menu header  
                        ['shoveltext'] = 'Price: $'..Config.Paydirt.Dirt.Required[1].price, -- Menu header 
                        ['shovelicon'] = 'fa-solid fa-toolbox', -- Menu header icon
                        ['sackheader'] = 'Sack', -- Menu header 
                        ['sacktext'] = 'Price: $'..Config.Paydirt.Dirt.Required[2].price, -- Menu header 
                        ['sackicon'] = 'fa-solid fa-toolbox', -- Menu header icon 
                        ['jackhammerheader'] = 'Jackhammer', -- Menu header  
                        ['jackhammertext'] = 'Price: $'..Config.Quarry.Drilling.Required.price, -- Menu header 
                        ['jackhammericon'] = 'fa-solid fa-toolbox', -- Menu header icon
                        ['dynamiteheader'] = 'Dynamite', -- Menu header  
                        ['dynamitetext'] = 'Price: $'..Config.Quarry.Dynamite.Required.price, -- Menu header 
                        ['dynamiteicon'] = 'fa-solid fa-toolbox' -- Menu header icon
                    },
                },
                ['timer'] = 'My shift starts at '..Config.Stores.Quarry.Times.Open..' until '..Config.Stores.Quarry.Times.Close..' please come back later..', -- Notification
                ['guide'] = 'You received a Mining Handbook!', -- Notification
                ['hasguide'] = 'You already have a Mining Handbook..' -- Notification
            },
            Paydirt = {
                Digging = {
                    Target = {
                        ['icon'] = 'fa-solid fa-person-digging', -- Target icon
                        ['label'] = 'Dig Paydirt', -- Target label
                    },
                    ['busy'] = 'You are already digging..', -- Notification
                    ['notool'] = 'You cant dig without a '..Config.Paydirt.Dirt.Required[1].label..'..', -- Notification
                    ['notool2'] = 'You need a '..Config.Paydirt.Dirt.Required[2].label..' to store your paydirt..', -- Notification
                    ['success'] = 'You successfully dug up some paydirt!', -- Notification
                    ['successxp'] = 'You successfully dug up some paydirt, and earned a little experience in the process!', -- Notification
                    ['fail'] = 'Your '..Config.Paydirt.Dirt.Required[1].label..' broke!', -- Notification
                    ['progressbar'] = 'Digging For Paydirt..', -- Progressbar text
                },
                Panning = {
                    ['busy'] = 'You are already panning..', -- Notification
                    ['nowater'] = 'You need to be in water to pan '..Config.Paydirt.Dirt.Return.label..'..', -- Notification
                    ['nopaydirt'] = 'You cant pan without '..Config.Paydirt.Dirt.Return.label..'..', -- Notification
                    ['success'] = 'You successfully panned some paydirt!', -- Notification
                    ['successxp'] = 'You successfully panned some paydirt, and earned a little experience in the process!', -- Notification
                    ['fail'] = 'You didnt find anything useful..', -- Notification
                    ['progressbar'] = 'Panning Paydirt..', -- Progressbar text
                }
            },
            Dynamite = {
                Target = { 
                    ['icon'] = 'fa-solid fa-bomb', -- Target icon
                    ['label'] = 'Place Dynamite', -- Target label
                },
                ['nodynamite'] = 'You dont have any '..Config.Quarry.Dynamite.Required.label..' with you..', -- Notification
                ['delay'] = 'Dynamite will explode in {'..Config.Quarry.Dynamite.Delay..'} seconds. Move away!', -- Notification
            },
            Drilling = {
                Target = {
                    ['icon'] = 'fa-solid fa-person-digging', -- Target icon 
                    ['label'] = 'Drill Rock', -- Target label
                },
                ['nodrill'] = 'You dont have a '..Config.Quarry.Drilling.Required.label..'..', -- Notification
                ['success'] = 'You successfully drilled a rock!', -- Notification
                ['successxp'] = 'You successfully drilled a rock, and earned a little experience in the process!', -- Notification
                ['fail'] = 'You didnt find anything useful..', -- Notification
                ['failbreak'] = 'Your '..Config.Quarry.Drilling.Required.label..' broke!', -- Notification
                ['progressbar'] = 'Drilling Rock..', -- Progressbar text
            },
            Permits = {
                Mining = {
                    ['nopermit'] = 'You need a '..Config.Stores.Permits.Mining.label..' to place dynamite here..', -- Notification
                },
                Caving = {
                    ['nopermit'] = 'You need a '..Config.Stores.Permits.Caving.label..' to place dynamite here..', -- Notification
                }
            }
        },
        Mine = {
            Ped = {
                Menu = {
                    Main = {
                        ['header'] = 'Mine Worker', -- Menu header
                        ['text'] = 'So your interesting in mining?', -- Menu text
                        ['icon'] = 'fa-solid fa-gem' -- Menu icon
                    },
                    Guide = {
                        ['header'] = 'Handbook!', -- Menu header   
                        ['text'] = 'Pickup a mining handbook here!', -- Menu text
                        ['icon'] = 'fa-solid fa-circle-info' -- Menu header icon
                    },
                    Permits = { 
                        ['header'] = 'Permits!', -- Menu header    
                        ['text'] = 'Purchase permits required for caving here!', -- Menu text 
                        ['icon'] = 'fa-solid fa-clipboard-check', -- Menu header icon
                        ['cavingheader'] = 'Caving Permit', -- Menu header
                        ['cavingtext'] = 'Price: $'..Config.Stores.Permits.Caving.price, -- Menu header 
                        ['cavingicon'] = 'fa-solid fa-ticket' -- Menu header icon
                    },
                    Equipment = {
                        ['header'] = 'Equipment!', -- Menu header   
                        ['text'] = 'Purchase equipment required for caving here!', -- Menu text
                        ['icon'] = 'fa-solid fa-basket-shopping', -- Menu header icon
                    },
                },
                ['timer'] = 'My shift starts at '..Config.Stores.Mine.Times.Open..' until '..Config.Stores.Mine.Times.Close..' please come back later..', -- Notification
                ['guide'] = 'You received a Mining Handbook!', -- Notification
                ['hasguide'] = 'You already have a Mining Handbook..' -- Notification
            },
            Dynamite = {
                Target = { 
                    ['icon'] = 'fa-solid fa-bomb', -- Target icon
                    ['label'] = 'Place Dynamite', -- Target label
                },
                ['nodynamite'] = 'You dont have any '..Config.Mine.Dynamite.Required.label..' with you..', -- Notification
                ['delay'] = 'Dynamite will explode in {'..Config.Mine.Dynamite.Delay..'} seconds. Move away!', -- Notification
            },
            Drilling = {
                Target = {
                    ['icon'] = 'fa-solid fa-person-digging', -- Target icon 
                    ['label'] = 'Drill Rock', -- Target label
                },
                ['nodrill'] = 'You dont have a '..Config.Mine.Drilling.Required.label..'..', -- Notification
                ['success'] = 'You successfully drilled a rock!', -- Notification
                ['successxp'] = 'You successfully drilled a rock, and earned a little experience in the process!', -- Notification
                ['fail'] = 'You didnt find anything useful..', -- Notification
                ['failbreak'] = 'Your '..Config.Mine.Drilling.Required.label..' broke!', -- Notification
                ['progressbar'] = 'Drilling Rock..', -- Progressbar text
            },
            Permits = {
                Caving = {
                    ['nopermit'] = 'You need a '..Config.Stores.Permits.Caving.label..' to place dynamite here..', -- Notification
                }
            }
        },
        Smelting = {
            Target = {
                ['icon'] = 'fa-solid fa-fire', -- Target icon
                ['label'] = 'Smelt Ore', -- Target label
            },
            Menu = {
                Main = {
                    ['header'] = 'Furnace', -- Menu header
                    ['text'] = 'You can smelt mining materials here!', -- Menu text
                    ['icon'] = 'fa-solid fa-fire' -- Menu icon
                },
                Ingots = {
                    Main = {
                        ['header'] = 'Ingots', -- Menu header
                        ['text'] = 'Smelt your ores into ingots here!', -- Menu text
                        ['icon'] = 'fa-solid fa-fire' -- Menu icon
                    },
                    Aluminum = {
                        ['header'] = Config.Smelting.Ingots.Aluminum.Return.label, -- Menu header
                        ['text'] = 'Required:</p>'..Config.Smelting.Ingots.Aluminum.Required.amount..'x '..Config.Smelting.Ingots.Aluminum.Required.label, -- Menu text
                        ['icon'] = 'fa-solid fa-bars-progress' -- Menu icon
                    },
                    Copper = {
                        ['header'] = Config.Smelting.Ingots.Copper.Return.label, -- Menu header
                        ['text'] = 'Required:</p>'..Config.Smelting.Ingots.Copper.Required.amount..'x '..Config.Smelting.Ingots.Copper.Required.label, -- Menu text
                        ['icon'] = 'fa-solid fa-bars-progress' -- Menu icon
                    },
                    Iron = {
                        ['header'] = Config.Smelting.Ingots.Iron.Return.label, -- Menu header 
                        ['text'] = 'Required:</p>'..Config.Smelting.Ingots.Iron.Required.amount..'x '..Config.Smelting.Ingots.Iron.Required.label, -- Menu text
                        ['icon'] = 'fa-solid fa-bars-progress' -- Menu icon
                    },
                    Tin = {
                        ['header'] = Config.Smelting.Ingots.Tin.Return.label, -- Menu header
                        ['text'] = 'Required:</p>'..Config.Smelting.Ingots.Tin.Required.amount..'x '..Config.Smelting.Ingots.Tin.Required.label, -- Menu text
                        ['icon'] = 'fa-solid fa-bars-progress' -- Menu icon 
                    },
                    Gold = {
                        ['header'] = Config.Smelting.Ingots.Gold.Return.label, -- Menu header 
                        ['text'] = 'Required:</p>'..Config.Smelting.Ingots.Gold.Required.amount..'x '..Config.Smelting.Ingots.Gold.Required.label, -- Menu text
                        ['icon'] = 'fa-solid fa-bars-progress' -- Menu icon
                    },
                    Silver = {
                        ['header'] = Config.Smelting.Ingots.Silver.Return.label, -- Menu header
                        ['text'] = 'Required:</p>'..Config.Smelting.Ingots.Silver.Required.amount..'x '..Config.Smelting.Ingots.Silver.Required.label, -- Menu text
                        ['icon'] = 'fa-solid fa-bars-progress' -- Menu icon 
                    },
                    Cobalt = {
                        ['header'] = Config.Smelting.Ingots.Cobalt.Return.label, -- Menu header
                        ['text'] = 'Required:</p>'..Config.Smelting.Ingots.Cobalt.Required.amount..'x '..Config.Smelting.Ingots.Cobalt.Required.label, -- Menu text
                        ['icon'] = 'fa-solid fa-bars-progress' -- Menu icon 
                    },
                    Bronze = {
                        ['header'] = Config.Smelting.Ingots.Bronze.Return.label, -- Menu header
                        ['text'] = 'Required:</p>'..Config.Smelting.Ingots.Bronze.Required[1].amount..'x '..Config.Smelting.Ingots.Bronze.Required[1].label..'</p>'..Config.Smelting.Ingots.Bronze.Required[2].amount..'x '..Config.Smelting.Ingots.Bronze.Required[2].label, -- Menu text
                        ['icon'] = 'fa-solid fa-bars-progress' -- Menu icon 
                    },
                    Steel = {
                        ['header'] = Config.Smelting.Ingots.Steel.Return.label, -- Menu header
                        ['text'] = 'Required:</p>'..Config.Smelting.Ingots.Steel.Required[1].amount..'x '..Config.Smelting.Ingots.Steel.Required[1].label..'</p>'..Config.Smelting.Ingots.Steel.Required[2].amount..'x '..Config.Smelting.Ingots.Steel.Required[2].label, -- Menu text
                        ['icon'] = 'fa-solid fa-bars-progress' -- Menu icon 
                    },
                }
            },
            ['busy'] = 'You are already using the furnace..', -- Notification
            ['wrongitems'] = 'You cant smelt air.. Come back with the correct materials and amount..', -- Notification
            ['success'] = 'You successfully smelted some ingots!', -- Notification
            ['successxp'] = 'You successfully smelted some ingots, and earned a little experience in the process!', -- Notification
            ['fail'] = 'You failed to smelt the ingots..', -- Notification
            ['failxp'] = 'You failed to smelt the ingots and lost a little experience in the process..', -- Notification
            ['progressbar'] = 'Adding Materials..', -- Progressbar
            ['progressbar2'] = 'Waiting For Ingots..', -- Progressbar
        },
        Stores = {
            Permits = {
                ['noxp'] = 'You are too inexperienced to purchase this permit..', -- Notification
            },
            Equipment = {
                ['noxp'] = 'You are too inexperienced to purchase this piece of equipment..', -- Notification
            },
            ['alreadyhaspermit'] = 'Looks like you already have this permit..', -- Notification
            ['enoughmoney'] = 'Looks like you dont have enough money..', -- Notification
            ['nomoney'] = 'Looks like you dont have any money..', -- Notification
        },
        Warehouse = {
            Menu = {
                Builders = {
                    Main = {
                        ['header'] = 'Builders Warehouse', -- Menu header
                        ['text'] = 'Sell your mining goods here!', -- Menu text
                        ['icon'] = 'fa-solid fa-briefcase' -- Menu icon
                    },
                    ['timer'] = 'My shift starts at '..Config.Warehouse.Builders.Times.Open..' until '..Config.Warehouse.Builders.Times.Close..' please come back later..', -- Notification
                },
                Craft = {
                    Main = {
                        ['header'] = 'Jewellery Crafting', -- Menu header
                        ['text'] = 'Cut gems and craft jewellery.', -- Menu text
                        ['icon'] = 'fa-solid fa-gem' -- Menu icon
                    },
                    GemCut = {
                        ['header'] = 'Cut Gems', -- Menu header
                        ['text'] = 'Cut uncut gems into polished gems', -- Menu text
                        ['icon'] = 'fa-solid fa-gem' -- Menu icon
                    },
                    Rings = {
                        ['header'] = 'Craft Rings', -- Menu header
                        ['text'] = 'Use ingots and gems to craft rings', -- Menu text
                        ['icon'] = 'fa-solid fa-ring' -- Menu icon
                    },
                    Neck = {
                        ['header'] = 'Craft Necklaces', -- Menu header
                        ['text'] = 'Use chains and gems to craft necklaces', -- Menu text
                        ['icon'] = 'fa-solid fa-necklace' -- Menu icon (fallback ok)
                    },
                    Ear = {
                        ['header'] = 'Craft Earrings', -- Menu header
                        ['text'] = 'Use earrings and gems to craft earrings', -- Menu text
                        ['icon'] = 'fa-solid fa-ear-listen' -- Menu icon (fallback ok)
                    }
                },
                Jewellers = {
                    Main = {
                        ['header'] = 'Jewellers', -- Menu header
                        ['text'] = 'Sell your gems here!', -- Menu text
                        ['icon'] = 'fa-solid fa-briefcase' -- Menu icon
                    },
                    ['timer'] = 'My shift starts at '..Config.Warehouse.Jewellers.Times.Open..' until '..Config.Warehouse.Jewellers.Times.Close..' please come back later..', -- Notification
                },
                --Buy = {
                --    Main = {
                --        ['header'] = 'Buy Items', -- Menu header
                --        ['text'] = 'Buy items here!', -- Menu text
                --        ['icon'] = 'fa-solid fa-briefcase' -- Menu icon
                --    },
                --    Ingots = {
                --        ['header'] = 'Buy Ingots!', -- Menu header   
                --        ['text'] = 'Buy your ingots here!', -- Menu header
                --        ['icon'] = 'fa-solid fa-boxes-stacked' -- Menu header icon
                --    },
                --    Gems = {
                --        ['header'] = 'Buy Gems!', -- Menu header   
                --        ['text'] = 'Buy your gems here!', -- Menu header
                --        ['icon'] = 'fa-solid fa-gem' -- Menu header icon
                --    }
                --},
                Sell = {
                    Main = {
                        ['header'] = 'Sell Items!', -- Menu header   
                        ['text'] = 'Sell your items here!', -- Menu text
                        ['icon'] = 'fa-solid fa-sack-dollar', -- Menu icon
                    },
                    Ingots = {
                        ['header'] = 'Sell Ingots!', -- Menu header   
                        ['text'] = 'Sell your ingots here!', -- Menu header
                        ['icon'] = 'fa-solid fa-boxes-stacked' -- Menu header icon
                    },
                    Gems = {
                        ['header'] = 'Sell Gems!', -- Menu header   
                        ['text'] = 'Sell your gems here!', -- Menu header
                        ['icon'] = 'fa-solid fa-gem' -- Menu header icon
                    }
                }
            },
            ['sold'] = 'You sold some items for $', -- Notification
            ['nosell'] = 'You dont have any items to sell..', -- Notification
            ['noitem'] = 'We dont have any in stock..', -- Notification
            ['nomoney'] = 'Looks like you dont have any money..', -- Notification
            ['enoughmoney'] = 'You dont have enough money..', -- Notification
            ['nostock'] = 'We dont have enough in stock. Amount:', -- Notification 
        }
    },
    Shared = {
        ['returnmenu'] = 'Return', -- Menu header
		['returnmenuicon'] = 'fa-solid fa-backward', -- Menu header icon
        ['exitmenu'] = 'Exit', -- Menu header
		['exitmenuicon'] = 'fa-solid fa-circle-xmark', -- Menu header icon
        ['cancelled'] = 'Action cancelled..', -- Notification
        ['noinvent'] = 'Looks like your pockets are full..', -- Notification
        ['outrange'] = 'Looks like you are too far away..', -- Notification
        ['isbusy'] = 'You are already doing something..', -- Notification
    }
}
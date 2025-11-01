local ResourceTarget = GetTarget()
if ResourceTarget ~= "qb-target" then return end

local Targets = {}

CreateThread(function ()
    
    --Chairs
    for k, v in pairs(Location.Chairs) do
        Targets[Config.Blip.BlipName..' Chair '..k] =
        exports['qb-target']:AddBoxZone(Config.Blip.BlipName..' Chair '..k, v.coords.xyz, v.h, v.w, 
        { name=Config.Blip.BlipName..' Chair '..k, 
        heading = v.coords.w, 
        debugPoly=Config.Debug.PolyZone, 
        minZ = v.minZ,
        maxZ = v.maxZ
    },
    { options = { 
            {   action = function(entity, distance)
                    HandleChairInteraction({
                        loc = v.coords,
                        stand = v.stand
                    })
                end, 
                icon = "fas fa-chair", 
                label = Config.Blip.BlipName..' Chair '..k, 
            }, 
        },
        distance = 2.2
    })
    end

    --Billing Counters
    for k, v in pairs(Location.Billing) do
        Targets[v.name] = 
        exports["qb-target"]:AddBoxZone(v.name, v.coords, v.h, v.w, { 
            name        = v.name, 
            heading     = v.heading, 
            debugPoly   = Config.Debug.PolyZone, 
            minZ        = v.minZ, 
            maxZ        = v.maxZ 
        }, { 
            options = { 
                {
                    action = function()
                        OpenBillingMenu()
                    end,
                    icon        = "fas fa-clipboard", 
                    label       = v.name,
                    billing     = v.name,
                    job = Config.Jobname,
                },
            },
            distance = 2.0 
        })
    end
    --Counters
    for k, v in pairs(Location.Counter) do
        Targets[v.name] = 
        exports["qb-target"]:AddBoxZone(v.name, v.coords, v.h, v.w, { 
            name        = v.name, 
            heading     = v.heading, 
            debugPoly   = Config.Debug.PolyZone, 
            minZ        = v.minZ, 
            maxZ        = v.maxZ 
        }, { 
            options = { 
                {
                    action = function()
                        OpenStash(v.name)
                    end, 
                    icon =         "far fa-clipboard",
                    label       = v.name,
                    inventory     = v.name,
                },
            },
            distance = 2.0 
        })
    end
    --Table
    for k, v in pairs(Location.Tables) do
        Targets[v.name] = 
        exports["qb-target"]:AddBoxZone(v.name, vector3(v.coords.x, v.coords.y, v.coords.z + 0.2), v.h, v.w, { 
            name        = v.name, 
            heading     = v.heading, 
            debugPoly   = Config.Debug.PolyZone, 
            minZ        = v.minZ, 
            maxZ        = v.maxZ 
        }, { 
            options = { 
                {
                    action = function()
                        OpenStash(v.name)
                    end, 
                    icon        = "fas fa-box", 
                    label       = v.name,
                    inventory   = v.name,
                },
            },
            distance = 2.0 
        })
    end
    --TrashCan
    for k, v in pairs(Location.TrashCan) do
        Targets[v.name] = 
        exports["qb-target"]:AddBoxZone(v.name, vector3(v.coords.x, v.coords.y, v.coords.z + 0.2), v.h, v.w, { 
            name        = v.name, 
            heading     = v.heading, 
            debugPoly   = Config.Debug.PolyZone, 
            minZ        = v.minZ, 
            maxZ        = v.maxZ 
        }, { 
            options = { 
                {
                    action = function()
                        OpenStash(v.name)
                    end, 
                    icon        = "fas fa-box", 
                    label       = v.name,
                    inventory   = v.name,
                },
            },
            distance = 2.0 
        })
    end

    Targets[Location.TargetCoords.Fridge[1].name] = 
    exports["qb-target"]:AddBoxZone(Location.TargetCoords.Fridge[1].name, Location.TargetCoords.Fridge[1].coords, Location.TargetCoords.Fridge[1].h, Location.TargetCoords.Fridge[1].w, { 
        name        = Location.TargetCoords.Fridge[1].name, 
        heading     = Location.TargetCoords.Fridge[1].heading, 
        debugPoly   = Config.Debug.PolyZone, 
        minZ        = Location.TargetCoords.Fridge[1].minZ, 
        maxZ        = Location.TargetCoords.Fridge[1].maxZ 
    }, { 
        options = { 
            {
                type        = "server", 
                event       = "pl_koi:getStock", 
                icon =         "far fa-clipboard",
                label       = 'Fridge',
                job = Config.Jobname,
            },
        },
        distance = 2.0 
    })
    Targets[Location.TargetCoords.Management[1].name] = 
    exports["qb-target"]:AddBoxZone(Location.TargetCoords.Management[1].name, Location.TargetCoords.Management[1].coords, Location.TargetCoords.Management[1].h, Location.TargetCoords.Management[1].w, { 
        name        = Location.TargetCoords.Management[1].name, 
        heading     = Location.TargetCoords.Management[1].heading, 
        debugPoly   = Config.Debug.PolyZone, 
        minZ        = Location.TargetCoords.Management[1].minZ, 
        maxZ        = Location.TargetCoords.Management[1].maxZ
    }, { 
        options = { 
            {
                action =  function()
                    CategoryManage()
                end, 
                icon =         "far fa-clipboard",
                label       = 'Management',
                job = Config.Jobname,
            },
        },
        distance = 2.0 
    })
    Targets[Location.TargetCoords.Process[1].name] = 
    exports["qb-target"]:AddBoxZone(Location.TargetCoords.Process[1].name, Location.TargetCoords.Process[1].coords, Location.TargetCoords.Process[1].h, Location.TargetCoords.Process[1].w, { 
        name        = Location.TargetCoords.Process[1].name, 
        heading     = Location.TargetCoords.Process[1].heading, 
        debugPoly   = Config.Debug.PolyZone, 
        minZ        = Location.TargetCoords.Process[1].minZ, 
        maxZ        = Location.TargetCoords.Process[1].maxZ 
    }, { 
        options = { 
            {
                action =  function()
                    MakeCategoryMenu()
                end, 
                icon =         "far fa-clipboard",
                label       = 'Process',
                job = Config.Jobname,
            },
        },
        distance = 2.0 
    })
    Targets[Location.TargetCoords.Stash[1].name] = 
    exports["qb-target"]:AddBoxZone(Location.TargetCoords.Stash[1].name, Location.TargetCoords.Stash[1].coords, Location.TargetCoords.Stash[1].h, Location.TargetCoords.Stash[1].w, { 
        name        = Location.TargetCoords.Stash[1].name, 
        heading     = Location.TargetCoords.Stash[1].heading, 
        debugPoly   = Config.Debug.PolyZone, 
        minZ        = Location.TargetCoords.Stash[1].minZ, 
        maxZ        = Location.TargetCoords.Stash[1].maxZ 
    }, { 
        options = { 
            {
                action =  function()
                    StashStorage()
                end, 
                icon =         "far fa-clipboard",
                label       = 'Stash',
                job = Config.Jobname,
            },
        },
        distance = 2.0 
    })
    Targets[Location.TargetCoords.BossMenu[1].name] = 
    exports["qb-target"]:AddBoxZone(Location.TargetCoords.BossMenu[1].name, Location.TargetCoords.BossMenu[1].coords, Location.TargetCoords.BossMenu[1].h, Location.TargetCoords.BossMenu[1].w, { 
        name        = Location.TargetCoords.BossMenu[1].name, 
        heading     = Location.TargetCoords.BossMenu[1].heading, 
        debugPoly   = Config.Debug.PolyZone, 
        minZ        = Location.TargetCoords.BossMenu[1].minZ, 
        maxZ        = Location.TargetCoords.BossMenu[1].maxZ 
    }, { 
        options = { 
            {
                action =  function()
                    ShopBossMenu()
                end, 
                icon =         "far fa-clipboard",
                label       = 'BossMenu',
                job = Config.Jobname,
            },
        },
        distance = 2.0 
    })
    Targets[Location.TargetCoords.Clothing[1].name] = 
    exports["qb-target"]:AddBoxZone(Location.TargetCoords.Clothing[1].name, Location.TargetCoords.Clothing[1].coords, Location.TargetCoords.Clothing[1].h, Location.TargetCoords.Clothing[1].w, { 
        name        = Location.TargetCoords.Clothing[1].name, 
        heading     = Location.TargetCoords.Clothing[1].heading, 
        debugPoly   = Config.Debug.PolyZone, 
        minZ        = Location.TargetCoords.Clothing[1].minZ, 
        maxZ        = Location.TargetCoords.Clothing[1].maxZ 
    }, { 
        options = { 
            {
                action =  function()
                    ClothMenu()
                end, 
                icon =         "far fa-clipboard",
                label       = 'Clothing',
                job = Config.Jobname,
            },
        },
        distance = 2.0 
    })
    Targets[Location.TargetCoords.Duty[1].name] = 
    exports["qb-target"]:AddBoxZone(Location.TargetCoords.Duty[1].name, Location.TargetCoords.Duty[1].coords, Location.TargetCoords.Duty[1].h, Location.TargetCoords.Duty[1].w, { 
        name        = Location.TargetCoords.Duty[1].name, 
        heading     = Location.TargetCoords.Duty[1].heading, 
        debugPoly   = Config.Debug.PolyZone, 
        minZ        = Location.TargetCoords.Duty[1].minZ, 
        maxZ        = Location.TargetCoords.Duty[1].maxZ 
    }, { 
        options = { 
            {
                action =  function()
                    Duty()
                end, 
                icon =         "far fa-clipboard",
                label       = 'Duty',
                job = Config.Jobname,
            },
        },
        distance = 2.0 
    })
    Targets[Location.TargetCoords.HandWash[1].name] = 
    exports["qb-target"]:AddBoxZone(Location.TargetCoords.HandWash[1].name, Location.TargetCoords.HandWash[1].coords, Location.TargetCoords.HandWash[1].h, Location.TargetCoords.HandWash[1].w, { 
        name        = Location.TargetCoords.HandWash[1].name, 
        heading     = Location.TargetCoords.HandWash[1].heading, 
        debugPoly   = Config.Debug.PolyZone, 
        minZ        = Location.TargetCoords.HandWash[1].minZ, 
        maxZ        = Location.TargetCoords.HandWash[1].maxZ 
    }, { 
        options = { 
            {
                action =  function(entity, distance)
                    HandWash({
                        coords = Location.TargetCoords.HandWash[1].coords,
                    })
                end, 
                icon =         "fa-solid fa-hands-bubbles",
                label       = 'HandWash',
                job = Config.Jobname,
            },
        },
        distance = 2.0 
    })
    Targets[Location.TargetCoords.IceMachine[1].name] = 
    exports["qb-target"]:AddBoxZone(Location.TargetCoords.IceMachine[1].name, Location.TargetCoords.IceMachine[1].coords, Location.TargetCoords.IceMachine[1].h, Location.TargetCoords.IceMachine[1].w, { 
        name        = Location.TargetCoords.IceMachine[1].name, 
        heading     = Location.TargetCoords.IceMachine[1].heading, 
        debugPoly   = Config.Debug.PolyZone, 
        minZ        = Location.TargetCoords.IceMachine[1].minZ, 
        maxZ        = Location.TargetCoords.IceMachine[1].maxZ 
    }, { 
        options = { 
            {
                action =  function()
                    OpenIcecreamMenu()
                end, 
                icon =         "fa-solid fa-ice-cream",
                label       = 'IceMachine',
                job = Config.Jobname,
            },
        },
        distance = 2.0 
    })
end)


AddEventHandler('onResourceStop', function(resource) 
    if resource ~= GetCurrentResourceName() then return end
	for k in pairs(Targets) do exports["qb-target"]:RemoveZone(k) end
end)
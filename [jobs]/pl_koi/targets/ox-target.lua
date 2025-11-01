local ResourceTarget = GetTarget()
if ResourceTarget ~= "ox_target" then return end

local Targets = {}

CreateThread(function()

    --Chairs
    for k, v in pairs(Location.Chairs) do
        Targets[Config.Blip.BlipName..' Chair '..k] = 
        exports.ox_target:addBoxZone({
            coords = vec3(v.coords.x, v.coords.y, v.coords.z-0.5),
            size = vec3(v.w, v.h, v.height),
            rotation = v.heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = Config.Blip.BlipName..k,
                    onSelect = function(data)
                        HandleChairInteraction(data)
                    end, 
                    icon        = "fas fa-chair",
                    label       = "Sit Down",
                    loc         = v.coords,
					stand       = v.stand,
                    distance    = 2.2,
                }
            }
        })
    end

    --Billing Counters
    for k, v in pairs(Location.Billing) do
        Targets[v.name] = 
        exports.ox_target:addBoxZone({
            coords = vec3(v.coords.x, v.coords.y, v.coords.z),
            size = vec3(v.w, v.h, v.height),
            rotation = v.heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = v.name,
                    onSelect =  function()
                            OpenBillingMenu()
                    end, 
                    icon        = "fas fa-clipboard",
                    label       = v.name,
                    billing     = v.name,
                    groups = {[Config.Jobname] = 0},
                    distance    = 1.0,
                }
            }
        })
    end
    --Counters
    for k, v in pairs(Location.Counter) do
        Targets[v.name] = 
        exports.ox_target:addBoxZone({
            coords = vec3(v.coords.x, v.coords.y, v.coords.z),
            size = vec3(v.w, v.h, v.height),
            rotation = v.heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = v.name,
                    onSelect =  function()
                                OpenStash(v.name)
                    end, 
                    icon        = "fas fa-clipboard",
                    label       = v.name,
                    distance    = 1.5,
                }
            }
        })
    end
    --Table
    for k, v in pairs(Location.Tables) do
        Targets[v.name] = 
        exports.ox_target:addBoxZone({
            coords = vec3(v.coords.x, v.coords.y, v.coords.z+0.2),
            size = vec3(v.w, v.h, v.height),
            rotation = v.heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = v.name,
                    onSelect =  function()
                            OpenStash(v.name)
                    end, 
                    icon        = "fas fa-box", 
                    label       = v.name,
                    distance    = 2.0,
                }
            }
        })
    end
    --Trash Can
    for k, v in pairs(Location.TrashCan) do
        Targets[v.name] = 
        exports.ox_target:addBoxZone({
            coords = v.coords,
            size = vec3(v.w,v.h,v.height),
            rotation = v.heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = v.name,
                    onSelect =  function()
                        OpenStash(v.name)
                    end, 
                    icon        = "fa-solid fa-trash",
                    label       = 'TrashCan',
                    distance    = 1.0,
                }
            }
        })
    end
        
        Targets[Location.TargetCoords.Fridge[1].name] = 
        exports.ox_target:addBoxZone({
            coords = vec3(Location.TargetCoords.Fridge[1].coords.x,Location.TargetCoords.Fridge[1].coords.y,Location.TargetCoords.Fridge[1].coords.z),
            size = vec3(Location.TargetCoords.Fridge[1].w,Location.TargetCoords.Fridge[1].h,Location.TargetCoords.Fridge[1].height),
            rotation = Location.TargetCoords.Fridge[1].heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = Location.TargetCoords.Fridge[1].name,
                    serverEvent  = "pl_koi:getStock", 
                    icon        = "fas fa-clipboard",
                    label       = 'Fridge',
                    groups = {[Config.Jobname] = 0},
                    distance    = 1.0,
                }
            }
        })
        Targets[Location.TargetCoords.Management[1].name] = 
        exports.ox_target:addBoxZone({
            coords = Location.TargetCoords.Management[1].coords,
            size = vec3(Location.TargetCoords.Management[1].w,Location.TargetCoords.Management[1].h,Location.TargetCoords.Management[1].height),
            rotation = Location.TargetCoords.Management[1].heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = Location.TargetCoords.Management[1].name,
                    onSelect =  function()
                        CategoryManage()
                    end, 
                    icon        = "fas fa-clipboard",
                    label       = 'Management',
                    groups = {[Config.Jobname] = 0},
                    distance    = 1.0,
                }
            }
        })
        Targets[Location.TargetCoords.Process[1].name] = 
        exports.ox_target:addBoxZone({
            coords = Location.TargetCoords.Process[1].coords,
            size = vec3(Location.TargetCoords.Process[1].w,Location.TargetCoords.Process[1].h,Location.TargetCoords.Process[1].height),
            rotation = Location.TargetCoords.Process[1].heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = Location.TargetCoords.Process[1].name,
                    onSelect =  function()
                        MakeCategoryMenu()
                    end, 
                    icon        = "fas fa-clipboard",
                    label       = 'Process',
                    groups = {[Config.Jobname] = 0},
                    distance    = 1.0,
                }
            }
        })
        --Stash
        Targets[Location.TargetCoords.Stash[1].name] = 
        exports.ox_target:addBoxZone({
            coords = Location.TargetCoords.Stash[1].coords,
            size = vec3(Location.TargetCoords.Stash[1].w,Location.TargetCoords.Stash[1].h,Location.TargetCoords.Stash[1].height),
            rotation = Location.TargetCoords.Stash[1].heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = Location.TargetCoords.Stash[1].name,
                    onSelect =  function()
                                StashStorage()
                    end,
                    icon        = "fas fa-clipboard",
                    label       = 'Stash',
                    groups = {[Config.Jobname] = 0},
                    distance    = 1.0,
                }
            }
        })
        Targets[Location.TargetCoords.BossMenu[1].name] = 
        exports.ox_target:addBoxZone({
            coords = Location.TargetCoords.BossMenu[1].coords,
            size = vec3(Location.TargetCoords.BossMenu[1].w,Location.TargetCoords.BossMenu[1].h,Location.TargetCoords.BossMenu[1].height),
            rotation = Location.TargetCoords.BossMenu[1].heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = Location.TargetCoords.BossMenu[1].name,
                    onSelect =  function()
                            ShopBossMenu()
                    end, 
                    icon        = "fas fa-clipboard",
                    label       = 'BossMenu',
                    groups = {[Config.Jobname] = 4},
                    distance    = 1.0,
                }
            }
        })
        Targets[Location.TargetCoords.Clothing[1].name] = 
        exports.ox_target:addBoxZone({
            coords = Location.TargetCoords.Clothing[1].coords,
            size = vec3(Location.TargetCoords.Clothing[1].w,Location.TargetCoords.Clothing[1].h,Location.TargetCoords.Clothing[1].height),
            rotation = Location.TargetCoords.Clothing[1].heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = Location.TargetCoords.Clothing[1].name,
                    onSelect =  function()
                            ClothMenu()
                    end, 
                    icon        = "fas fa-clipboard",
                    label       = 'Clothing',
                    groups = {[Config.Jobname] = 0},
                    distance    = 1.0,
                }
            }
        })
        if GetResourceState('es_extended') ~= 'started' then
            Targets[Location.TargetCoords.Duty[1].name] = 
            exports.ox_target:addBoxZone({
                coords = Location.TargetCoords.Duty[1].coords,
                size = vec3(Location.TargetCoords.Duty[1].w,Location.TargetCoords.Duty[1].h,Location.TargetCoords.Duty[1].height),
                rotation = Location.TargetCoords.Duty[1].heading,
                debug = Config.Debug.PolyZone,
                drawSprite = Config.Debug.DrawSprite,
                options = {
                    {
                        name        = Location.TargetCoords.Duty[1].name,
                        onSelect =  function()
                                Duty()
                        end,  
                        icon        = "fas fa-clipboard",
                        label       = 'Duty',
                        groups = {[Config.Jobname] = 0},
                        distance    = 1.0,
                    }
                }
            })
        end
        Targets[Location.TargetCoords.HandWash[1].name] = 
        exports.ox_target:addBoxZone({
            coords = Location.TargetCoords.HandWash[1].coords,
            size = vec3(Location.TargetCoords.HandWash[1].w,Location.TargetCoords.HandWash[1].h,Location.TargetCoords.HandWash[1].height),
            rotation = Location.TargetCoords.HandWash[1].heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = Location.TargetCoords.HandWash[1].name,
                    onSelect = function(data)
                            HandWash(data)
                    end, 
                    icon        = "fa-solid fa-hands-bubbles",
                    label       = 'HandWash',
                    groups = {[Config.Jobname] = 0},
                    coords = Location.TargetCoords.HandWash[1].coords,
                    distance    = 1.0,
                }
            }
        })
        Targets[Location.TargetCoords.IceMachine[1].name] = 
        exports.ox_target:addBoxZone({
            coords = Location.TargetCoords.IceMachine[1].coords,
            size = vec3(Location.TargetCoords.IceMachine[1].w,Location.TargetCoords.IceMachine[1].h,Location.TargetCoords.IceMachine[1].height),
            rotation = Location.TargetCoords.IceMachine[1].heading,
            debug = Config.Debug.PolyZone,
            drawSprite = Config.Debug.DrawSprite,
            options = {
                {
                    name        = Location.TargetCoords.IceMachine[1].name,
                    onSelect =  function()
                            OpenIcecreamMenu()
                    end,
                    icon        = "fa-solid fa-ice-cream",
                    label       = 'IceMachine',
                    groups = {[Config.Jobname] = 0},
                    coords = Location.TargetCoords.IceMachine[1].coords,
                    distance    = 1.0,
                }
            }
        })
        
end)

AddEventHandler('onResourceStop', function(resource) 
    if resource ~= GetCurrentResourceName() then return end
	for k, v in pairs(Targets) do exports.ox_target:removeZone(v) end
end)
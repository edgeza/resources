----------------------------------------------------------------
----                   DUSADEV.TEBEX.IO                     ----
----------------------------------------------------------------
config = {}
config.debug = false -- For debugging purposes
config.error = true -- For debugging purposes, if you had a problem set this to true and open ticket

--- @param -- Check https://dusa.gitbook.io/ for documentation


------------------------GENERAL OPTIONS------------------------
---------------------------------------------------------------
config.enableHudKeyInteraction = false -- If you set this true, it will open menu when desired key pushed. If you set false, it will only open menu when you type /hud
config.Voice = 'pma' -- mumble / pma / saltychat
config.defaultRefreshRate = "High" -- Default refresh rate for NUI Low / Medium / High / Real Time
config.mapWhileWalking = true -- Enable / disable show map while walking
config.canPassengerSeeSpeedo = true -- Enable / disable passenger can see speedometer
config.CustomMinimap = false -- Set this true if you using custom minimap

config.DefaultStatus = 5 -- Default status (1-10)
config.DefaultSpeedometer = 9 -- Default speedometer (1-10)
config.EnableInformations = true -- Enable top right corner player + server informations as default
config.DisableMinimapOption = false -- Disable minimap option from settings menu

-- In-game hour display
config.TimeFormat = '24h' -- 12h: Shows current time like 5:24 PM | 24h: Shows time like 17:24
config.TimeType = 'real' -- real: Shows real time | game: Shows game time


--------------------------HUD MENU-----------------------------
---------------------------------------------------------------
config.hudMenuCommand = 'hud'
config.hudMenuKey = 'I'
config.CursorHotkey = 'CAPITAL' -- Key list -> (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/)
config.CursorKeyLabel = 'CAPS'

config.MenuTabs = { -- If you want to disable any of the tabs, set to false
    ['media'] = true,
    ['vehicle'] = true,
    ['map'] = true,
}

----------------------------MONEY------------------------------
---------------------------------------------------------------
-- config.HideBlackMoney = false -- Hide black money from informations as default
-- config.HideCoin = false -- Hide special coin from informations as default


----------------------SERVER INFORMATIONS----------------------
---------------------------------------------------------------
config.Logo = "https://www.oneliferp.org/logo.png" -- Logo URL [Has to be 1x1 ratio, or it will cause stretching]
config.ServerName = "OneLife RP" -- Server Name
config.Link = "" -- Server Link
config.EnableServerInfoOptions = {
    black_money = false,
    coin = false,
    user_money = true,
    server_logo = true,
    quick_info = true,
    cash_money = true,
}


-----------------------VEHICLE OPTIONS-------------------------
---------------------------------------------------------------
config.EnableRadio = true -- Enable / disable default GTA V car radio
config.CruiseControlCommand = ''
config.CruiseControlKey = ""

-- Engine control
config.EnableEngineControl = true -- Enable / disable engine control
config.ForceEngineOff = true -- Force engine off when player exit the vehicle
config.EngineCommand = '' -- Command to toggle engine
config.EngineKey = '' -- Key to toggle engine
config.BrokenEngineThreshold = 985.0 -- Vehicle engine health threshold to mark as damaged at hud



----------------------GTA UI Management------------------------
---------------------------------------------------------------
-- Enabling this will increase resmon value by 0.03 - 0.05
config.EnableGTAUI = false -- Enable / disable default GTA V UI
config.HideDefaultUI = {
    vehicle_name = true, 
    area_name = true, 
    vehicle_class = true,
    street_name = true,
    cash = true,
    mp_cash = true,
    hud_components = true, 
    hud_weapons = true, 
    ammo = true,
}

---------------------------SEATBELT----------------------------
---------------------------------------------------------------
config.EnableSeatbelt = true
config.SeatbeltCommand = 'seatbelt'

-- Ejection Physics Configuration
config.EjectionPhysics = { ---Dont change unless you understand the logic of this function 
    -- Impact and force settings
    impactForceMultiplier = 0.3, -- Further reduced from 0.5 to make ejections much less violent
    maxImpactForce = 20.0, -- Further reduced from 30.0
    ejectionDistanceMultiplier = 1.0, -- Further reduced from 1.5
    maxEjectionDistance = 8.0, -- Further reduced from 10.0
    upwardForceMultiplier = 0.5, -- Further reduced from 0.8
    maxUpwardForce = 3.0, -- Further reduced from 5.0
    velocityRetention = 0.1, -- Further reduced from 0.2
    
    -- Ragdoll settings
    ragdollTimeMultiplier = 0.2, -- Further reduced from 0.3
    maxRagdollTime = 3000, -- Further reduced from 5000
    minRagdollTime = 1000, -- Further reduced from 1500
    allowRagdollBreakout = true,
    ragdollBreakoutKey = 22, -- SPACE key
    
    -- Damage settings
    damageMultiplier = 0.2, -- Further reduced from 0.3
    maxDamage = 30, -- Further reduced from 40
    enableLethalCrashes = false,
    
    -- Speed thresholds
    crashDetectionSensitivity = 0.3, -- Much less sensitive - further reduced from 0.5
    speedDropThreshold = 200.0, -- Much higher threshold for crash detection - increased from 150.0
    lethalSpeedThreshold = 400.0, -- Much higher lethal threshold - increased from 350.0
    instantDeathSpeed = 999.0, -- Disabled - no instant death from speed
    
    -- Windshield ejection for high-speed crashes
    windshieldEjection = {
        enabled = false, -- Disabled to prevent unrealistic ejections
        windshieldOffset = 3.0,
        forwardDistanceMultiplier = 1.5,
        downwardVelocity = -2.0,
        forwardVelocityMultiplier = 1.8,
        heightOffset = 0.5
    }
}
config.SeatbeltKey = "B"
config.SeatbeltWarning = true
config.SeatbeltWarningSoundVolume = 0.5 -- Reduced from 1.0 to avoid annoying players
config.SeatbeltMinimumWarningSpeed = 60 -- Increased from 50 to reduce false warnings
config.SeatbeltEjectSpeed = 350 -- Further increased from 300 - Speed to eject player from vehicle (KMH) - seatbelt protection limit
config.HarnessEjectSpeed = 450 -- Further increased from 400 - Speed to eject player from vehicle (KMH) - harness protection limit


-------------------------STRESS SYSTEM-------------------------
---------------------------------------------------------------
config.EnableStress = true
config.StressWhitelistJobs = { -- Add jobs you want to disable stress
    'police', 'ambulance'
}

config.WhitelistedWeaponStress = {
    `weapon_petrolcan`,
    `weapon_hazardcan`,
    `weapon_fireextinguisher`
}

config.RemoveStress = {
    ["eat"] = {
        min = 5,
        max = 10,
        enable = true,
        func = function()
            RegisterNetEvent('devcore_needs:client:StartEat')
            AddEventHandler('devcore_needs:client:StartEat', function()
                local val = math.random(config.RemoveStress["eat"].min, config.RemoveStress["eat"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end)
            RegisterNetEvent('esx_basicneeds:onEat')
            AddEventHandler('esx_basicneeds:onEat', function()
                local val = math.random(config.RemoveStress["eat"].min, config.RemoveStress["eat"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end) 
            RegisterNetEvent('consumables:client:Eat')
            AddEventHandler('consumables:client:Eat', function()
                local val = math.random(config.RemoveStress["eat"].min, config.RemoveStress["eat"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end) 
            RegisterNetEvent("esx_basicneeds:onUse")
            AddEventHandler("esx_basicneeds:onUse", function(type)
                if type == 'food' then
                    local val = math.random(config.RemoveStress["eat"].min, config.RemoveStress["eat"].max)
                    TriggerServerEvent('hud:server:RelieveStress', val)
                end
            end)
        end
    },
    ["drink"] = {
        min = 5,
        max = 10,
        enable = true,
        func = function()
            RegisterNetEvent('consumables:client:Drink')
            AddEventHandler('consumables:client:Drink', function()
                local val = math.random(config.RemoveStress["drink"].min, config.RemoveStress["drink"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end)
            RegisterNetEvent('consumables:client:DrinkAlcohol')
            AddEventHandler('consumables:client:DrinkAlcohol', function()
                local val = math.random(config.RemoveStress["drink"].min, config.RemoveStress["drink"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end) 
            RegisterNetEvent('devcore_needs:client:DrinkShot')
            AddEventHandler('devcore_needs:client:DrinkShot', function()
                local val = math.random(config.RemoveStress["drink"].min, config.RemoveStress["drink"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end) 
            RegisterNetEvent('devcore_needs:client:StartDrink')
            AddEventHandler('devcore_needs:client:StartDrink', function()
                local val = math.random(config.RemoveStress["drink"].min, config.RemoveStress["drink"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end) 
            RegisterNetEvent('esx_optionalneeds:onDrink')
            AddEventHandler('esx_optionalneeds:onDrink', function()
                local val = math.random(config.RemoveStress["drink"].min, config.RemoveStress["drink"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end) 
            RegisterNetEvent('esx_basicneeds:onDrink')
            AddEventHandler('esx_basicneeds:onDrink', function()
                local val = math.random(config.RemoveStress["drink"].min, config.RemoveStress["drink"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end) 
            RegisterNetEvent("esx_basicneeds:onUse")
            AddEventHandler("esx_basicneeds:onUse", function(type)
                if type == 'drink' then
                    local val = math.random(config.RemoveStress["drink"].min, config.RemoveStress["drink"].max)
                    TriggerServerEvent('hud:server:RelieveStress', val)
                end
            end)
        end
    },
    ["vape"] = {
        min = 5,
        max = 10,
        enable = true,
        func = function()
            -- Common vape event patterns
            RegisterNetEvent('mic_vape:client:Vape')
            AddEventHandler('mic_vape:client:Vape', function()
                local val = math.random(config.RemoveStress["vape"].min, config.RemoveStress["vape"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end)
            RegisterNetEvent('mic_vape:client:UseVape')
            AddEventHandler('mic_vape:client:UseVape', function()
                local val = math.random(config.RemoveStress["vape"].min, config.RemoveStress["vape"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end)
            RegisterNetEvent('consumables:client:Vape')
            AddEventHandler('consumables:client:Vape', function()
                local val = math.random(config.RemoveStress["vape"].min, config.RemoveStress["vape"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end)
            RegisterNetEvent('vape:client:Use')
            AddEventHandler('vape:client:Use', function()
                local val = math.random(config.RemoveStress["vape"].min, config.RemoveStress["vape"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end)
            RegisterNetEvent('vape:use')
            AddEventHandler('vape:use', function()
                local val = math.random(config.RemoveStress["vape"].min, config.RemoveStress["vape"].max)
                TriggerServerEvent('hud:server:RelieveStress', val)
            end)
        end
    },
    ["death"] = {
        enable = true,
        func = function()
            AddEventHandler('esx:onPlayerDeath', function() 
                TriggerServerEvent('hud:server:RelieveStress', 100)
            end)
            
            RegisterNetEvent('hospital:client:RespawnAtHospital')
            AddEventHandler('hospital:client:RespawnAtHospital', function() 
                TriggerServerEvent('hud:server:RelieveStress', 100)
            end)
        end
    },
    ["swim"] = {
        min = 2, -- Reduced from 5
        max = 5, -- Reduced from 10
        enable = true,
        func = function()
            CreateThread(function()
                while true do
                    local ped = PlayerPedId()
                    if IsPedSwimming(ped) then
                        -- Only reduce stress 50% of the time to slow it down
                        if math.random() < 0.50 then
                            local val = math.random(config.RemoveStress["swim"].min, config.RemoveStress["swim"].max)
                            TriggerServerEvent('hud:server:RelieveStress', val)
                        end
                    end
                    Wait(15000) -- Increased from 10000 to 15000 (check every 15 seconds instead of 10)

                end
            end)
        end
    },
    ["run"] = {
        min = 2, -- Reduced from 5
        max = 5, -- Reduced from 10
        enable = false,    
        func = function()
            CreateThread(function()
                while true do
                    local ped = PlayerPedId()
                    if IsPedRunning(ped) then
                        -- Only reduce stress 50% of the time to slow it down
                        if math.random() < 0.50 then
                            local val = math.random(config.RemoveStress["run"].min, config.RemoveStress["run"].max)
                            TriggerServerEvent('hud:server:RelieveStress', val)
                        end
                    end
                    Wait(15000) -- Increased from 10000 to 15000 (check every 15 seconds instead of 10)
                end
            end)
        end
    }
}

config.AddStress = {
    ["shoot"] = {
        min = 1, -- minimum amount to add stress
        max = 2, -- maximum amount to add stress (reduced from 3)
        enable = true,
        func = function()
            CreateThread(function()            
                while true do
                    local ped = PlayerPedId()
                    local weapon = GetSelectedPedWeapon(ped)
                    if weapon ~= `WEAPON_UNARMED` then
                        if IsPedShooting(ped) then
                            -- Reduced probability from 15% to 5% and added cooldown mechanism
                            if math.random() < 0.05 and not IsWhitelistedWeaponStress(weapon) then
                                TriggerServerEvent('hud:server:GainStress', math.random(config.AddStress["shoot"].min, config.AddStress["shoot"].max))
                                Wait(2000) -- Cooldown after gaining stress to prevent rapid accumulation
                            end
                        end
                    else
                        Wait(1000)
                    end
                    Wait(100) -- Increased from 20ms to 100ms to reduce check frequency
                end
            end)
        end
    },
    ["drive_fast"] = {
        min = 1, -- minimum amount to add stress
        max = 2, -- maximum amount to add stress (balanced for moderate accumulation)
        enable = true,
        func = function()
            CreateThread(function()            
                while true do
                    local ped = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    if IsPedInAnyVehicle(ped, false) then
                        local speed = GetEntitySpeed(vehicle) * 3.6
                        local stressSpeed = 200 -- KMH value (balanced threshold - stress at reasonable speeds)
                        if speed >= stressSpeed then
                            -- 50% chance to add stress when driving fast (balanced frequency)
                            if math.random() < 0.50 then
                                TriggerServerEvent('hud:server:GainStress', math.random(config.AddStress["drive_fast"].min, config.AddStress["drive_fast"].max))
                            end
                        end
                    end
                    Wait(15000) -- Check every 15 seconds (balanced interval)
                end
            end)
        end
    },
}
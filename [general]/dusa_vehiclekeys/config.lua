----------------------------------------------------------------
----                   DUSADEV.TEBEX.IO                     ----
----------------------------------------------------------------
Config = {}

--- @param -- Check https://dusadev.gitbook.io/ for documentation

----------------------------------------------------------------
----                       GENERAL                          ----
----------------------------------------------------------------
Config.LockNPCDrivingCars = true                             -- Lock driven NPC cars | true = locked | false = unlocked
Config.LockNPCParkedCars = true                              -- Lock parked NPC cars | true = locked | false = unlocked]

Config.RemoveLockpickNormal = 0.0                            -- Chance to remove lockpick on fail
Config.RemoveLockpickAdvanced = 0.0                          -- Chance to remove advanced lockpick on fail
Config.LockPickDoorEvent = function()
    -- Use qbx_lockpick instead of dusa_lockpick
    TriggerEvent('qb-lockpick:client:openLockpick', function(success)
        LockpickFinishCallback(success)
    end)
end

Config.PoliceJobs = { 'police' }
Config.HotwireCamera = true -- Enable Disable camera when hotwiring minigame

----------------------------------------------------------------
----                       COMMANDS                         ----
----------------------------------------------------------------
Config.Commands = {
    GiveKey = { -- Hand over the keys to someone. If no ID, gives to closest person or everyone in the vehicle.
        command = 'givekeys',
        description = 'Give vehicle key to closest or defined player',
        params = {
            { help = 'Player ID' },
        },
    },
    AddKeyOfVehicle = { -- Adds keys to a vehicle for someone.
        command = 'addkeys',
        description = 'Give key for defined plate to player',
        params = {
            { help = 'Player ID' },
            { help = 'Plate' },
        },
    },
    RemoveKeyOfVehicle = { -- Remove key for defined plate to player
        command = 'removekeys',
        description = 'Remove key with defined plate from player',
        params = {
            { help = 'Player ID' },
            { help = 'Plate' },
        },
    },
}

----------------------------------------------------------------
----                 ALERT OWNER SCENARIO                   ----
----------------------------------------------------------------
Config.AlertOwner = true -- Will spawn NPC to save his own vehicle when lockpick failed
Config.AlertChance = 50  -- Alert NPC vehicle owner chance
Config.PedTypes = {      -- If you want to add new NPC model, you can add from here
    `a_f_m_bodybuild_01`,
    `a_m_m_mexcntry_01`,
    `s_m_m_hairdress_01`,
    `csb_cletus`,
    `csb_anton`,
    `a_m_y_hipster_03`,
    `a_m_m_beach_01`,
}

----------------------------------------------------------------
----                       KEY FOB                          ----
----------------------------------------------------------------
Config.EnableKeyFob = false            -- Enable disable key fob
Config.FobKeybind = 'K'                -- Keybind key
Config.FobDescription = 'Open Key Fob' -- Keybind desc

Config.ToggleLockKey = 'L'             -- Toggle lock default keybind
Config.EngineKey = 'G'                -- On / Off engine default keybind - set false to disable engine keybind (e.g Config.EngineKey = false)
                                    -- On / Off engine default keybind - set false to disable engine keybind (e.g Config.EngineKey = false)

-- For a list of FiveM vehicle classes, refer to:
-- https://docs.fivem.net/natives/?_0x29439776AAA00A62
Config.Classes = { -- Classes that will show luxury key fob UI
    1, 2, 3, 4, 5, 6, 7
}

----------------------------------------------------------------
----                       HOTWIRE                          ----
----------------------------------------------------------------
Config.EnableHotwire = false       -- Enable/disable hotwiring system | true = normal hotwiring | false = everyone has keys to all vehicles
Config.HotwireChance = 50         -- Hotwiring chance (For hotwire minigame)
Config.TimeBetweenHotwires = 5000 -- Place a delay between hotwire attempts
Config.minHotwireTime = 1000      -- Define time in ms for min-max hotwire progressbar length
Config.maxHotwireTime = 5000

----------------------------------------------------------------
----                       CARJACKING                       ----
----------------------------------------------------------------
Config.CarJackEnable = true           -- Can players jack vehicles when a NPC inside? true or false
Config.CarjackingTime = 2500          -- Car Jack Progressbar Length
Config.DelayBetweenCarjackings = 5000 -- Place a Delay between jacking another car
Config.CarjackChance = {              -- Ped will flee depends on this chances
    ['2685387236'] = 0.0,             -- melee
    ['416676503'] = 0.99,             -- handguns
    ['-957766203'] = 0.99,            -- SMG
    ['860033945'] = 0.90,             -- shotgun
    ['970310034'] = 0.90,             -- assault
    ['1159398588'] = 0.99,            -- LMG
    ['3082541095'] = 0.99,            -- sniper
    ['2725924767'] = 0.99,            -- heavy
    ['1548507267'] = 0.0,             -- throwable
    ['4257178988'] = 0.0,             -- misc
}

----------------------------------------------------------------
----                       POLICE ALERT                     ----
----------------------------------------------------------------

Config.AlertCooldown = 10000         -- Will send alert defined ms later
Config.PoliceAlertChance = 0.75      -- Chance of alerting police at daytime
Config.PoliceNightAlertChance = 0.50 -- Chance of alerting police at night (times:01-06)

--- @param -- For customized dispatch, edit  AlertPolice function below here.
function AlertPolice(type, vehicle)
    if not Config.EnableHotwire then return end
    if not AlertSend then
        local chance = Config.PoliceAlertChance
        if GetClockHours() >= 1 and GetClockHours() <= 6 then
            chance = Config.PoliceNightAlertChance
        end
        if math.random() <= chance then
            -- If you want to trigger dispatch from client, use here 
            if GetResourceState('ps-dispatch') == 'started' then
                exports['ps-dispatch']:VehicleTheft(vehicle)
                return
            end

            -- Default
            local plateChance = math.random()
            local properties = lib.getVehicleProperties(vehicle)
            local plate = properties.plate
            if plateChance <= 0.7 then
                plate = 'UNKNOWN'
            end

            local vehicleInfo = {
                plate = plate,
                model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
                color = (Config.Colors and Config.Colors[tostring(properties.color1)]) or tostring(properties.color1),
            }

            local coords = GetEntityCoords(vehicle)
            local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
            local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
            local location = {
                street = street .. ", " .. zone,
                coords = coords
            }
            TriggerServerEvent('dusa_vehiclekeys:server:policeAlert', vehicle, vehicleInfo, location)
            -- Custom dispatches can be edited at server/open_server.lua
        end
        AlertSend = true
        SetTimeout(Config.AlertCooldown, function()
            AlertSend = false
        end)
    end
end

----------------------------------------------------------------
----                       JOB VEHICLES                     ----
----------------------------------------------------------------
Config.SharedKeys = { -- Share keys amongst employees. Employees can lock/unlock any job-listed vehicle
    ['police'] = {    -- Job name
        vehicles = {
            -- 'police', -- Vehicle model
            -- 'police2',
            -- 'police3',
        }
    },
    ['mechanic'] = {
        vehicles = {
            'towtruck',
        }
    }
}

----------------------------------------------------------------
----                   MINOR ADJUSTMENTS                    ----
----------------------------------------------------------------

Config.ImmuneVehicles = { -- Defined vehicles will be protected for car jacking (May be useful for your car heist scripts)
    'hauler2',
    'stockade'
}

Config.NoLockVehicles = { -- This vehicles can not be locked
    --'vehiclename',
}

Config.NoCarjackWeapons = { -- Blacklist weapons for car jacking
    "WEAPON_UNARMED",
    "WEAPON_Knife",
    "WEAPON_Nightstick",
    "WEAPON_HAMMER",
    "WEAPON_Bat",
    "WEAPON_Crowbar",
    "WEAPON_Golfclub",
    "WEAPON_Bottle",
    "WEAPON_Dagger",
    "WEAPON_Hatchet",
    "WEAPON_KnuckleDuster",
    "WEAPON_Machete",
    "WEAPON_Flashlight",
    "WEAPON_SwitchBlade",
    "WEAPON_Poolcue",
    "WEAPON_Wrench",
    "WEAPON_Battleaxe",
    "WEAPON_Grenade",
    "WEAPON_StickyBomb",
    "WEAPON_ProximityMine",
    "WEAPON_BZGas",
    "WEAPON_Molotov",
    "WEAPON_FireExtinguisher",
    "WEAPON_PetrolCan",
    "WEAPON_Flare",
    "WEAPON_Ball",
    "WEAPON_Snowball",
    "WEAPON_SmokeGrenade",
}

----------------------------------------------------------------
----                       TRANSLATION                      ----
----------------------------------------------------------------
Config.Language = {
    ['notify'] = {
        ydhk = "You don't have the keys to this vehicle!",
        nonear = 'There is no one nearby to give the keys to!',
        vlock = 'Vehicle locked!',
        vunlock = 'Vehicle unlocked!',
        vlockpick = 'You unlocked the door!',
        fvlockpick = 'You fail to find the keys and get frustrated.',
        vgkeys = 'You handed over the vehicle keys.',
        vgetkeys = 'You received the vehicle keys!',
        fpid = "Enter the plate and player ID.",
        cjackfail = 'Carjacking failed!',
        vehclose = 'There is no vehicle nearby!',
        alertowner = 'Leave my car alone, you son of a b****!',
        removedkey = 'Key successfully removed!',
        car_theft = 'Car Theft',
    },
    ['progress'] = {
        takekeys = 'Taking keys from the body...',
        hskeys = 'Searching for keys...',
        acjack = 'Carjacking in progress...',
        stelingkeys = 'Stealing the keys...',
        hotwiring = 'Hotwiring the vehicle...',
    },
    ['info'] = {
        skeys = '[H] - Hotwire',
        tlock = 'Toggle Vehicle Locks',
        palert = 'Vehicle Theft. Type: ',
        engine = 'Toggle Engine',
    },
    ['addcom'] = {
        givekeys = 'Hand over the keys to someone. If no ID, gives to closest person or everyone in the vehicle.',
        givekeys_id = 'id',
        givekeys_id_help = 'Player ID',
        addkeys = 'Adds keys to a vehicle for someone.',
        addkeys_id = 'id',
        addkeys_id_help = 'Player ID',
        addkeys_plate = 'plate',
        addkeys_plate_help = 'Plate',
        rkeys = 'Remove keys to a vehicle for someone.',
        rkeys_id = 'id',
        rkeys_id_help = 'Player ID',
        rkeys_plate = 'plate',
        rkeys_plate_help = 'Plate',
    }
}

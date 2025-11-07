Config = {}    

Config.Target = 'ox'               -- 'qb' for qb-target, 'ox' for ox-target
Config.JobRestriction = false
Config.JobList = { ["towing"] = 0}          -- Jobs that can use the flatbed the number is equal to the lowest job rank that can use the flatbed

Config.ClassBlacklist =  {10, 11, 14, 15, 16, 20, 21}       -- Vehicle classes that should not be loadable onto the flatbed https://docs.fivem.net/natives/?_0x29439776AAA00A62

Config.ControlDistance = 1.5                                -- From how far away the tow truck should be controlable
Config.FlatbedAnimDict = 'amb@prop_human_atm@male@idle_a'   -- Animation directory for using the flatbed controls 
Config.FlatbedAnimClip = 'idle_b'                           -- Animation clip for using the flatbed controls
Config.MaxDistance = 2.0            -- How far away the vehicle to be towed can be from the flatbed's unload position.
Config.MotorOn = false              -- If the engine of the flatbed truck must be running to use it
Config.CheckSpace = false            -- How much space must be behind the tow truck to unload. Set it to false to not check for space (will delete the colliding entities). 
Config.AdjustmentSteps = 0.05       -- How fast or precisely you want to align the vehicle on the flatbed
Config.AlignmentDivergence = 20     -- How far off the angle of the vehicle to be towed can be (in degrees 0 to 180)
Config.LoadingTime = 5              -- How long it should take to load/unload a vehicle (in seconds)
Config.MaxTilt = 15                 -- The maximum tilt degree the player can set while loading the vehicle onto the flatbed.
Config.MaxOffset = 1.0              -- The maximum Y and Z offset (in GTA units) the player can set while loading the vehicle onto the flatbed.
Config.CarelessUnhook = true        -- If the vehicle that's towed can be unhooked from the drivers seat. (Keep in mind there is no job restriction for this all players can, when on the drivers seat of the tow truck, unhock the vehicle)
Config.HoldTime = 0.7               -- How long you need to hold down the unhook button before it actually unhooks (in seconds)
Config.UnhookWithForce = 12         -- The force that is applied to the vehicle after unhooking it. If you don't want to apply any force set this to false. If you want to have some fun set this to numbers > 100 :D


-- Controls                         -- https://docs.fivem.net/docs/game-references/controls/
Config.up           = 172           -- Arrow up
Config.down         = 173           -- Arrow down
Config.forwards     = 174           -- Arrow left
Config.backwards    = 175           -- Arrow right
Config.tiltfront    = 38            -- Q
Config.tiltback     = 44            -- E
Config.cancel       = 177           -- Backspace
Config.UnhookKey    = 74            -- H (only enabled while Config.CarlessUnhook = true)
Config.dismiss      = 73            -- X Press to dismiss help-message


-- Door options
Config.VehicleOpen = false           -- If the vehicle must be unlocked to be towed
Config.DoorOpening = true           -- If you want to give wrecker driver the ability to unlock cars
Config.DoorOpeningTime = 15         -- How long the opening of a locked vehicle takes (in seconds)
Config.UnlockDistance = 0.7         -- How close you need to be to the vehicle to unlock it
Config.UnlockAnimDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@'  -- Animation directory for opening vehicle doors
Config.UnlockAnimClip = 'machinic_loop_mechandplayer'               -- Animation clip for opening vehicle doors

-- Sounds | Progess Bar
Config.Volume = 0.8                 -- The volume of the sounds done by this script
Config.SoundRange = 7.0             -- How far the sounds should be heard
Config.ProgressBar = true           -- Wether you want to use the progress bar
Config.HideBarAfter = 5             -- After how many seconds without interaction the progressbar should be hidden.
Config.ProgressColor = '#4eb3de'    -- Here you can edit the progress color to your likings. https://g.co/kgs/qpnR1M
Config.FinishedColor = '#4ede83'    -- Here you can edit the finished color to your likings. https://g.co/kgs/qpnR1M
Config.InfoColor = '#ede174'        -- Here you can edit the color for the wax notification to your likings. https://g.co/kgs/qpnR1M
Config.WrongColor = '#eb584d'       -- Here you can edit the color for the wrong action to your likings. https://g.co/kgs/qpnR1M

--// For your convenience I have made an "offset" command. It will print you the offset to the vehicle you are looking at. 
-- Usage /offset
-- Example result: "The offset to the SLAMTRUCK is vec3(-1.59, -1.62, -0.14)""

Config.TruckList = {
    {   
        model = 'flatbed',                          -- The model of the towtruck or trailer
        trailer = false,                            -- If true overrides Config.MotorOn because trailers dont have engines
        extraBlacklist = {},                        -- If there should be any Vehicle classes that cant be loaded whit this flatbed/trailer
        controlPos = vec3(-1.6141937,-1.978680,-0.079155),  -- The offset of the vehicle from where the flatbed should be controlled
        attachPos = vec3(0.132239, -2.432629, 1.424534),        -- The inital position of the vehicle on the flatbed
        unloadPos = vec3(-0.267122, -6.514886, -0.104604), -- The position where the car will be placed after unloading it
        initialTilt = 0.0,                          -- The initial tilt when the vehicle ist first brought up on the flatbed
        bone = 'chassis_dummy',                         -- The vehicle bone from where the offset will be calculated
    },

    {   
        model = 'slamtruck',                        -- The model of the towtruck or trailer
        trailer = false,                            -- If true overrides Config.MotorOn because trailers dont have engines
        extraBlacklist = {},                        -- If there should be any Vehicle classes that cant be loaded whit this flatbed/trailer
        controlPos = vector3(-1.59, 0.0, -0.14),    -- The offset of the vehicle from where the flatbed should be controlled
        attachPos = vector3(0.0, -2.0, 1.0),        -- The inital position of the vehicle on the flatbed
        unloadPos = vector3(0.015, -7.368, 0.235),  -- The position where the car will be placed after unloading it
        initialTilt = 7.0,                          -- The initial tilt when the vehicle ist first brought up on the flatbed
        bone = 'chassis_dummy',                         -- The vehicle bone from where the offset will be calculated
    },

    {   
        model = 'armytrailer',                          -- The model of the towtruck or trailer
        trailer = true,                                 -- If true overrides Config.MotorOn because trailers dont have engines
        extraBlacklist = {},                            -- If there should be any Vehicle classes that cant be loaded whit this flatbed/trailer
        controlPos = vector3(-2.017, 2.502, -1.998),    -- The offset of the vehicle from where the flatbed should be controlled
        attachPos = vector3(0.0, -0.50, -0.25),         -- The inital position of the vehicle on the flatbed
        unloadPos = vector3(0.015, -12.368, -1.657),    -- The position where the car will be placed after unloading it
        initialTilt = 0.0,                              -- The initial tilt when the vehicle ist first brought up on the flatbed
        bone = 'bodyshell',                             -- The vehicle bone from where the offset will be calculated
    },

    {   
        model = 'boattrailer',                          -- The model of the towtruck or trailer
        trailer = true,                                 -- If true overrides Config.MotorOn because trailers dont have engines
        extraBlacklist = {},                        -- If there should be any Vehicle classes that cant be loaded whit this flatbed/trailer
        controlPos = vector3(-1.528358, -1.325503, -0.067686),    -- The offset of the vehicle from where the flatbed should be controlled
        attachPos = vector3(0.0, -0.50, -0.25),         -- The inital position of the vehicle on the flatbed
        unloadPos = vector3(0.056693, -7.394105, -0.180481),    -- The position where the car will be placed after unloading it
        initialTilt = 0.0,                              -- The initial tilt when the vehicle ist first brought up on the flatbed
        bone = 'chassis_dummy',                             -- The vehicle bone from where the offset will be calculated
    },

    { 
        model = 'tug',
        trailer = false,
        extraBlacklist = {},                        -- If there should be any Vehicle classes that cant be loaded whit this flatbed/trailer
        controlPos = vector3(-3.494603, -4.775561, 1.347670),
        attachPos = vector3(0.088949, -13.823239, 2.205670),
        unloadPos = vector3(0.136916, -23.707413, 0.232996),
        initialTilt = 0.0,
        bone = 'chassis_dummy',
    },
    --[[ {
    model = 'flatbedm2',                            --Config for the Flatbed M2 Crew Cab Addon Vehicle (https://de.gta5-mods.com/vehicles/freightliner-m2-crew-cab-flatbed-add-on-script-beta)
    trailer = false,
    extraBlacklist = {},                        -- If there should be any Vehicle classes that cant be loaded whit this flatbed/trailer
    controlPos = vector3(-1.93, 1.12, 0.24), 
    attachPos = vector3(-0.004, -2.37, 0.775),
    unloadPos = vector3(0.15, -11.21, 0.24),
    initialTilt = 0.0,
    bone = 'chassis_dummy', 
    }, ]]
}


-- // English Locales

Config.use_controls = "Use flatbed controls"
Config.unload_vehicle = "Unload a vehicle"
Config.load_vehicle = "Load a vehicle"
Config.vehicle_locked = "You can't tow a locked vehicle!"
Config.steep_angle = "Vehicle needs to be somewhat aligned."
Config.no_vehicle_found = "There is no vehicle in reach."
Config.vehicle_blacklist = "You can't tow this vehicle."
Config.space_occupied = "Theres something in the way. You can't unload here."
Config.unloading_vehicle = "The vehicle is being unloaded..."
Config.vehicle_unloaded = "The vehicle has been unloaded."
Config.loading_vehicle = "The vehicle is being loaded..."
Config.loading_canceled = "You have canceled the process!"
Config.vehicle_loaded = "The vehicle has been loaded."
Config.truck_occupied = "This truck is currently used by someone else."
Config.open_vehicle = "Force open the vehicle"
Config.opening_vehicle = "Force opening the vehicle..."
Config.opened_vehicle = "You opened the vehicle."
Config.opening_canceled = "You stopped opening the vehicle!"
Config.not_further = "Can't move this any further in this direction!"
Config.unhooked = "You unhooked the vehicle!"
Config.KeyFrontBack = "Forwards/Backwards"
Config.KeyUpDown = "Up/Down"
Config.KeyTilt = "Tilt front/back"
Config.KeyCancel = "Cancel"
Config.KeyDismiss = "Dismiss"
Config.dismissHelp = "Help text hidden for this session."
Config.fix_bug = "Fix towing bug (detatch)"



-- // German Locales

--[[ 
Config.use_controls = "Steuerung des Abschleppers"
Config.unload_vehicle = "Ein Fahrzeug abladen"
Config.load_vehicle = "Ein Fahrzeug aufladen"
Config.vehicle_locked = "Du kannst kein verschlossenes Fahrzeug abschleppen"
Config.steep_angle = "Fahrzeug muss einigermaßen ausgerichtet sein"
Config.no_vehicle_found = "Es ist kein Fahrzeug in Reichweite"
Config.vehicle_blacklist = "Dieses Fahrzeug kannst du nicht abschleppen"
Config.space_occupied = "Es ist etwas im weg. Du kannst hier nicht abladen"
Config.unloading_vehicle = "Das Fahrzeug wird abgeladen"
Config.vehicle_unloaded = "Das Fahrzeug wurde abgeladen"
Config.loading_vehicle = "Das Fahrzeug wird aufgeladen"
Config.loading_canceled = "Du hast den Prozess abgebrochen"
Config.vehicle_loaded = "Das Fahrzeug wurde aufgeladen"
Config.truck_occupied = "Die Steuerung wird bereits genutzt"
Config.open_vehicle = "Fahrzeug aufknacken"
Config.opening_vehicle = "Knacke das Fahrzeug"
Config.opened_vehicle = "Fahrzeug wurde entriegelt"
Config.opening_canceled = "Öffnen wurde abgebrochen"
Config.not_further = "Weiter kannst du das Fahrzeug nicht bewegen"
Config.unhooked = "Du hast das Fahrzeug ausgeklinkt!" 
Config.KeyFrontBack = "Nach vorne/hinten"
Config.KeyUpDown = "Nach oben/unten"
Config.KeyTilt = "Nach vorne/hinten"
Config.KeyDismiss = "Nicht anzeigen"
Config.dismissHelp = "Hilfe-Text wird nicht mehr angezeigt."
Config.fix_bug = "Abschlepper Bug beheben (trennen)"
]]
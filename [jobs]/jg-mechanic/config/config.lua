Config = {}

-- Integrations (recommended to leave as "auto")
Config.Framework = "Qbox" -- or "QBCore", "Qbox", "ESX"
Config.Inventory = "qs-inventory" -- or "ox_inventory", "jpr-inventory", "esx_inventory", "codem-inventory", "jpr-inventory"
Config.Notifications = "other" -- or "default", "ox_lib", "lation_ui", "ps-ui", "okokNotify", "nox_notify"
Config.ProgressBar = "ox-circle" -- or "ox-circle", "ox-bar", "lation_ui", "qb"
Config.SkillCheck = "auto" -- or "ox", "qb", "lation_ui"
Config.DrawText = "auto" -- or "jg-textui", "ox_lib", "okokTextUI", "ps-ui", "lation_ui", "qb"
Config.SocietyBanking = "Renewed-Banking" -- or "okokBanking", "fd_banking", "Renewed-Banking", "tgg-banking", "qb-banking", "qb-management", "esx_addonaccount"
Config.Menus = "ox" -- or "ox", "lation_ui"

-- Localisation
Config.Locale = "en"
Config.NumberAndDateFormat = "en-US"
Config.Currency = "ZAR"

-- Set to false to use built-in job system
Config.UseFrameworkJobs = true

-- Mechanic Tablet
Config.UseTabletCommand = false-- set to false to disable command
Config.TabletConnectionMaxDistance = 4.0

-- Shops
Config.Target = "qb-target" -- (shops/stashes only) "qb-target" or "ox_target"
Config.UseSocietyFund = true -- set to false to use player balance
Config.PlayerBalance = "bank" -- or "bank" or "cash"

-- Skill Bars
Config.UseSkillbars = false -- set to false to use progress bars instead of skill bars for installations
Config.ProgressBarDuration = 10000 -- if not using skill bars, this is the progress bar duration in ms (10000 = 10 seconds)
Config.MaximumSkillCheckAttempts = 3 -- How many times the player can attempt a skill check before the skill check fails
Config.SkillCheckDifficulty = { "easy", "easy", "easy", "easy", "easy" } -- for ox only
Config.SkillCheckInputs = { "w", "a", "s", "d" } -- for ox only

-- Servicing
Config.EnableVehicleServicing = true
Config.ServiceRequiredThreshold = 20 -- [%] if any of the servicable parts hit this %, it will flag that the vehicle needs servicing 
Config.ServicingBlacklist = {
  "police", "bcso", "ambulance" -- Vehicles that are excluded from servicing damage
}

-- Nitrous
Config.NitrousScreenEffects = true
Config.NitrousRearLightTrails = true -- Only really visible at night
Config.NitrousPowerIncreaseMult = 2.0
Config.NitrousDefaultKeyMapping = "RMENU"
Config.NitrousMaxBottlesPerVehicle = 2 -- The UI can't really handle more than 7, more than that would be unrealistic anyway
Config.NitrousBottleDuration = 5 -- [in seconds] How long a nitrous tank lasts
Config.NitrousBottleCooldown = 20 -- [in seconds] How long until player can start using the next bottle
Config.NitrousPurgeDrainRate = 0.1 -- purging drains bottle only 10% as fast as actually boosting - set to 1 to drain at the same rate 

-- Stancing
Config.StanceMinSuspensionHeight = -0.3
Config.StanceMaxSuspensionHeight = 0.3
Config.StanceMinCamber = 0.0
Config.StanceMaxCamber = 0.5
Config.StanceMinTrackWidth = 0.5
Config.StanceMaxTrackWidth = 1.25
Config.StanceNearbyVehiclesFreqMs = 500

-- Repairs
Config.AllowFixingAtOwnedMechanicsIfNoOneOnDuty = false
Config.DuctTapeMinimumEngineHealth = 100.0
Config.DuctTapeEngineHealthIncrease = 150.0

-- Tuning
Config.TuningGiveInstalledItemBackOnRemoval = true

-- Locations
Config.UseCarLiftPrompt = "[E] Use car lift"
Config.UseCarLiftKey = 38
Config.CustomiseVehiclePrompt = "[E] Customise vehicle"
Config.CustomiseVehicleKey = 38

-- Update vehicle props whenever they are changed [probably should not touch]
-- You can set to false to leave saving any usual props vehicle changes such as
-- GTA performance, cosmetic, colours, wheels, etc to the garage or other scripts
-- that persist the props data to the database. Additional data from this script,
-- such as engine swaps, servicing etc is not affected as it's saved differently
Config.UpdatePropsOnChange = true

-- Stops vehicles from immediately going to redline, for a slightly more realistic feel and
-- reduced liklihood of wheelspin. Can make vehicle launch (slightly) slower.
-- No effect on electric vehicles!
-- May not work immediately for all vehicles; see: https://docs.jgscripts.com/mechanic/manual-transmissions-and-smooth-first-gear#smooth-first-gear
Config.SmoothFirstGear = false

-- If using a manual gearbox, show a notification with key binds when high RPMs 
-- have been detected for too long
Config.ManualHighRPMNotifications = true

-- Misc
Config.UniqueBlips = true
Config.ModsPricesAsPercentageOfVehicleValue = false -- Enable pricing tuning items as % of vehicle value - it tries jg-dealerships, then QBShared, then the vehicles meta file automagically for pricing data
Config.AdminsHaveEmployeePermissions = true -- admins can use tablet & interact with mechanics like an owner
Config.MechanicEmployeesCanSelfServiceMods = false -- set to true to allow mechanic employees to bypass the "place order" system at their own mechanic
Config.FullRepairAdminCommand = "vfix"
Config.MechanicAdminCommand = "mechanicadmin"
Config.ChangePlateDuringPreview = false
Config.RequireManagementForOrderDeletion = false 
Config.UseCustomNamesInTuningMenu = true
Config.DisableNoPaymentOptionForEmployees = false

-- Mechanic Locations
Config.MechanicLocations = {
  palmcoast = {
    type = "owned",
    job = "palmcoast",
    jobManagementRanks = {4, 5}, -- Only grades 4 and 5 can access management
    logo = "Palmcoast.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vec3(-2044.35, -484.72, 12.19),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vec3(-2051.97, -478.34, 12.19),
        size = 2.0,
        showBlip = true,
      },
      {
        coords = vec3(-2061.32, -471.04, 12.19),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vec3(-2069.15, -464.31, 12.19),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vec3(-2076.12, -472.47, 12.1),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vec3(-2068.17, -479.28, 12.1),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vec3(-2059.48, -486.95, 12.1),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vec3(-2060.44, -522.38, 12.13),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vec3(-2064.71, -526.85, 12.13),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vec3(-2068.72, -531.47, 12.13),
        size = 2.0,
        showBlip = false,
      },

      {--- Chopper Repairs
        coords = vec3(-2069.63, -444.3, 11.69),
        size = 3.0,
        showBlip = false,
      },
    },
    blip = {
      id = 446,
      color = 36,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 1500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 3750, percentVehVal = 0.01, priceMult = 0.1,},
      cosmetics        = { enabled = true, price = 1100, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 375, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 1250, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 1500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 1500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 2250, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 1250, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 250, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 1100, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps      = { enabled = true, requiresItem = true },
      engineSounds     = { enabled = true, requiresItem = true },
      drivetrains      = { enabled = true, requiresItem = true },
      turbocharging    = { enabled = true, requiresItem = true },
      tyres            = { enabled = true, requiresItem = true },
      brakes           = { enabled = true, requiresItem = true },
      driftTuning      = { enabled = true, requiresItem = true },
      gearboxes        = { enabled = true, requiresItem = true },
      raceTuning       = { enabled = true, requiresItem = true },
      steeringRack     = { enabled = true, requiresItem = true },
      suspension       = { enabled = true, requiresItem = true },
      weightReduction  = { enabled = true, requiresItem = true },
      aerodynamics     = { enabled = true, requiresItem = true },
      transmissions    = { enabled = true, requiresItem = true },
      differentials    = { enabled = true, requiresItem = true },
      ecuTuning        = { enabled = true, requiresItem = true },
      cooling          = { enabled = true, requiresItem = true },
    },
    carLifts = { -- only usable by employees
        -- vector4(-359.08, -90.53, 38.99, 340),
        -- vector4(-368.52, -87.26, 38.99, 340)
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vec3(-2026.05, -502.44, 12.21),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 230, b = 0, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil",          label = "Engine Oil",           price = 25 },
          { name = "tyre_replacement",    label = "Tyre Replacement",     price = 100 },
          { name = "clutch_replacement",  label = "Clutch Replacement",   price = 100 },
          { name = "air_filter",          label = "Air Filter",           price = 25 },
          { name = "spark_plug",          label = "Spark Plug",           price = 25 },
          { name = "suspension_parts",    label = "Suspension Parts",     price = 100 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 50 },
          { name = "repair_kit",          label = "Repair Kit",           price = 100 },
          { name = "cleaning_kit",        label = "Cleaning Kit",         price = 25 },
          { name = "mechanic_tablet",     label = "Mechanic Tablet",      price = 100 },
          { name = "ev_motor",            label = "EV Motor",             price = 375 },
          { name = "ev_battery",          label = "EV Battery",           price = 1000 },
          { name = "ev_coolant",          label = "EV Coolant",           price = 250 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vec3(-2029.13, -506.08, 12.21),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 230, b = 0, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "harness",             label = "Racing Harness",      price = 100 },
          { name = "ceramic_brakes",      label = "Ceramic Brakes",      price = 22500 },
          { name = "cosmetic_part",       label = "Body Kit",            price = 250 },
          { name = "performance_part",    label = "Performance Part",    price = 1000 },
          { name = "respray_kit",         label = "Respray Kit",         price = 250 },
          { name = "lighting_controller", label = "Lighting Controller", price = 75 },
          { name = "stancing_kit",        label = "Stance Kit",          price = 75 },
          { name = "vehicle_wheels",      label = "Vehicle Wheels Set",  price = 75 },
          { name = "tyre_smoke_kit",      label = "Tyre Smoke Kit",      price = 25 },
          { name = "extras_kit",          label = "Extras Kit",          price = 50 },
          { name = "nitrous_bottle",      label = "Nitrous Bottle",      price = 1000 },
          { name = "nitrous_install_kit", label = "Nitrous Install Kit", price = 4000 },
          { name = "slick_tyres",         label = "Slick Tyres",         price = 12500 },
          { name = "semi_slick_tyres",    label = "Semi Slick Tyres",    price = 12500 },
          { name = "offroad_tyres",       label = "Offroad Tyres",       price = 12500 },
          { name = "drift_tuning_kit",    label = "Drift Tuning Kit",    price = 30000 },
          { name = "i4_engine",           label = "I4 Engine",           price = 3750 },
          { name = "v6_engine",           label = "V6 Engine",           price = 27500 },
          { name = "v8_engine",           label = "V8 Engine",           price = 32500 },
          { name = "v12_engine",          label = "V12 Engine",          price = 50000 },
          { name = "turbocharger",        label = "Turbo",               price = 27500 },
          { name = "ev_motor",            label = "EV Motor",            price = 1000 },
          { name = "ev_battery",          label = "EV Battery",          price = 100 },
          { name = "ev_coolant",          label = "EV Coolant",          price = 100 },
          { name = "awd_drivetrain",      label = "AWD Drivetrain",      price = 25000 },
          { name = "rwd_drivetrain",      label = "RWD Drivetrain",      price = 25000 },
          { name = "fwd_drivetrain",      label = "FWD Drivetrain",      price = 25000 },
          { name = "manual_gearbox",      label = "Manual Gearbox",      price = 10000 },
          { name = "drag_tuning_kit",     label = "Drag Tuning Kit",     price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",   label = "Cruise Tuning Kit",   price = 12500 },
          { name = "quick_ratio_steering", label = "Quick Ratio Steering", price = 9000 },
          { name = "standard_steering",   label = "Standard Steering",   price = 6000 },
          { name = "slow_ratio_steering", label = "Slow Ratio Steering", price = 7500 },
          { name = "race_steering",       label = "Race Steering",       price = 12500 },
          { name = "4stroke_engine",      label = "4-Stroke Engine",     price = 7500 },
          { name = "5stroke_engine",      label = "5-Stroke Engine",     price = 12500 },
          { name = "inline6_engine",      label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v10_engine",          label = "V10 Engine",          price = 42500 },
          { name = "street_suspension",   label = "Street Suspension",   price = 7500 },
          { name = "sport_suspension",    label = "Sport Suspension",    price = 12500 },
          { name = "race_suspension",     label = "Race Suspension",     price = 17500 },
          { name = "lightweight_parts",   label = "Lightweight Parts",   price = 10000 },
          { name = "carbon_fiber_body",   label = "Carbon Fiber Body",   price = 22500 },
          { name = "street_spoiler",      label = "Street Spoiler",      price = 6000 },
          { name = "race_wing",           label = "Race Wing",           price = 12500 },
          { name = "6speed_manual",       label = "6-Speed Manual",      price = 9000 },
          { name = "8speed_auto",         label = "8-Speed Automatic",   price = 11000 },
          { name = "lsd_differential",    label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",   label = "Race Differential",   price = 17500 },
          { name = "stage1_ecu",          label = "Stage 1 ECU",         price = 7500 },
          { name = "stage2_ecu",          label = "Stage 2 ECU",         price = 12500 },
          { name = "performance_radiator", label = "Performance Radiator", price = 4000 },
          { name = "race_intercooler",    label = "Race Intercooler",    price = 7500 },
          { name = "exhaust_system",       label = "Exhaust System",        price = 3750 },
        },
      }
    },
    stashes = {
      {
        name = "Parts Bin 1",
        coords = vec3(-2047.29, -485.61, 12.21),
        job = 'palmcoast',
        grade = '0',
        size = 1.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 230, b = 0, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 50,
        weight = 100000,
        items = {
          -- Engine Parts
          { name = "4stroke_engine",       label = "4-Stroke Engine",       price = 3750 },
          { name = "5stroke_engine",       label = "5-Stroke Engine",       price = 12500 },
          { name = "v6_engine",            label = "V6 Engine",             price = 27500 },
          { name = "inline6_engine",       label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v8_engine",            label = "V8 Engine",             price = 32500 },
          { name = "v10_engine",           label = "V10 Engine",            price = 42500 },
          { name = "v12_engine",           label = "V12 Engine",            price = 12500 },
          { name = "turbocharger",         label = "Turbo",                 price = 27500 },
          -- Drivetrain Parts
          { name = "awd_drivetrain",       label = "AWD Drivetrain",        price = 12500 },
          { name = "rwd_drivetrain",       label = "RWD Drivetrain",        price = 12500 },
          { name = "fwd_drivetrain",       label = "FWD Drivetrain",        price = 12500 },
          -- Tyres
          { name = "slick_tyres",          label = "Slick Tyres",           price = 12500 },
          { name = "semi_slick_tyres",     label = "Semi Slick Tyres",      price = 12500 },
          { name = "offroad_tyres",        label = "Offroad Tyres",         price = 12500 },
          -- Brakes
          { name = "ceramic_brakes",       label = "Ceramic Brakes",        price = 22500 },
          -- Tuning Kits
          { name = "drift_tuning_kit",     label = "Drift Tuning Kit",      price = 15000 },
          { name = "drag_tuning_kit",      label = "Drag Tuning Kit",       price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",    label = "Cruise Tuning Kit",     price = 12500 },
          -- Steering
          { name = "quick_ratio_steering", label = "Quick Ratio Steering",  price = 18000 },
          { name = "standard_steering",    label = "Standard Steering",     price = 12000 },
          { name = "slow_ratio_steering",  label = "Slow Ratio Steering",   price = 3750 },
          { name = "race_steering",        label = "Race Steering",         price = 12500 },
          -- Suspension
          { name = "street_suspension",    label = "Street Suspension",     price = 3750 },
          { name = "sport_suspension",     label = "Sport Suspension",      price = 12500 },
          { name = "race_suspension",      label = "Race Suspension",       price = 35000 },
          -- Weight Reduction
          { name = "lightweight_parts",    label = "Lightweight Parts",     price = 10000 },
          { name = "carbon_fiber_body",    label = "Carbon Fiber Body",     price = 22500 },
          -- Aerodynamics
          { name = "street_spoiler",       label = "Street Spoiler",        price = 12000 },
          { name = "race_wing",            label = "Race Wing",             price = 12500 },
          -- Transmission
          { name = "manual_gearbox",       label = "Manual Gearbox",        price = 1250 },
          { name = "6speed_manual",        label = "6-Speed Manual",        price = 18000 },
          { name = "8speed_auto",          label = "8-Speed Automatic",     price = 11000 },
          -- Differential
          { name = "lsd_differential",     label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",    label = "Race Differential",     price = 35000 },
          -- ECU Tuning
          { name = "stage1_ecu",           label = "Stage 1 ECU",           price = 3750 },
          { name = "stage2_ecu",           label = "Stage 2 ECU",           price = 12500 },
          -- Cooling Systems
          { name = "performance_radiator", label = "Performance Radiator",  price = 8000 },
          { name = "race_intercooler",     label = "Race Intercooler",      price = 3750 },
        },
      },
      {
        name = "Parts Bin 2",
        coords = vec3(-2055.03, -478.89, 12.1),
        job = 'palmcoast',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 230, b = 0, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Basic Parts
          { name = "engine_oil",            label = "Engine Oil",            price = 25 },
          { name = "tyre_replacement",      label = "Tyre Replacement",      price = 100 },
          { name = "clutch_replacement",    label = "Clutch Replacement",    price = 100 },
          { name = "air_filter",            label = "Air Filter",            price = 25 },
          { name = "spark_plug",            label = "Spark Plug",            price = 25 },
          { name = "suspension_parts",      label = "Suspension Parts",      price = 100 },
          { name = "brakepad_replacement",  label = "Brakepad Replacement",  price = 50 },
          { name = "repair_kit",            label = "Repair Kit",            price = 100 },
          { name = "cleaning_kit",          label = "Cleaning Kit",          price = 25 },
          { name = "mechanic_tablet",       label = "Mechanic Tablet",       price = 100 },
        },
      },
      {
        name = "Parts Bin 3",
        coords = vec3(-2063.84, -471.7, 12.22),
        job = 'palmcoast',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 230, b = 0, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Cosmetic Parts
          { name = "harness",               label = "Racing Harness",        price = 100 },
          { name = "cosmetic_part",         label = "Body Kit",              price = 250 },
          { name = "performance_part",      label = "Performance Part",      price = 1000 },
          { name = "respray_kit",           label = "Respray Kit",           price = 250 },
          { name = "lighting_controller",   label = "Lighting Controller",   price = 75 },
          { name = "stancing_kit",          label = "Stance Kit",            price = 75 },
          { name = "vehicle_wheels",        label = "Vehicle Wheels Set",    price = 75 },
          { name = "tyre_smoke_kit",        label = "Tyre Smoke Kit",        price = 25 },
          { name = "extras_kit",            label = "Extras Kit",            price = 50 },
        },
      },
      {
        name = "Parts Bin 4",
        coords = vec3(-2071.7, -464.93, 12.22),
        job = 'palmcoast',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 230, b = 0, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Nitrous Systems
          { name = "nitrous_bottle",        label = "Nitrous Bottle",        price = 250 },
          { name = "nitrous_install_kit",   label = "Nitrous Install Kit",   price = 100 },
          { name = "empty_nitrous_bottle",  label = "Empty Nitrous Bottle",  price = 25 },
          -- EV Parts
          { name = "ev_motor",              label = "EV Motor",              price = 80000 },
          { name = "ev_battery",            label = "EV Battery",            price = 15000 },
          { name = "ev_coolant",            label = "EV Coolant",            price = 50 },
          -- Duct Tape
          { name = "duct_tape",             label = "Duct Tape",             price = 25 },
        },
      },
    }
  },

  bennys = {
    type = "owned",
    job = "bennies",
    jobManagementRanks = {4, 5}, -- Only grades 4 and 5 can access management
    logo = "bennys.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      --Car Repairs At Main Shop
      {
        coords = vector3(-974.38, -2046.65, 8.8),
        size = 3.0,
        showBlip = false,
      },
      {
        coords = vector3(-969.57, -2041.67, 8.8),
        size = 3.0,
        showBlip = false,
      },
      {
        coords = vector3(-964.67, -2036.71, 8.8),
        size = 3.0,
        showBlip = false,
      },
      {
        coords = vector3(-955.1, -2027.97, 8.82),
        size = 3.0,
        showBlip = false,
      },
      {
        coords = vector3(-950.24, -2033.24, 8.8),
        size = 3.0,
        showBlip = true,
      },
      {
        coords = vector3(-937.33, -2056.99, 8.8),
        size = 3.0,
        showBlip = false,
      },
      {
        coords = vector3(-932.39, -2051.98, 8.8),
        size = 3.0,
        showBlip = false,
      },
      {
        coords = vector3(-943.71, -2062.54, 8.75),
        size = 3.0,
        showBlip = false,
      },

      --Heli Repairs
      {
        coords = vector3(-940.9, -2010.79, 9.51),
        size = 3.0,
        showBlip = false,
      },
      
      
      --Car Repairs At Track
      {
        coords = vector3(-765.23, -2092.23, 9.18),
        size = 3.0,
        showBlip = true,
      },
      {
        coords = vector3(-759.29, -2086.46, 9.18),
        size = 3.0,
        showBlip = false,
      },
      {
        coords = vector3(-753.32, -2080.6, 9.18),
        size = 3.0,
        showBlip = false,
      },
    },
    blip = {
      id = 446,
      color = 30,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 1500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 1500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 1100, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 375, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 1250, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 1500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 1500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 2250, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 1250, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 250, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 1100, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps      = { enabled = true, requiresItem = true },
      engineSounds     = { enabled = true, requiresItem = true },
      drivetrains      = { enabled = true, requiresItem = true },
      turbocharging    = { enabled = true, requiresItem = true },
      tyres            = { enabled = true, requiresItem = true },
      brakes           = { enabled = true, requiresItem = true },
      driftTuning      = { enabled = true, requiresItem = true },
      gearboxes        = { enabled = true, requiresItem = true },
      raceTuning       = { enabled = true, requiresItem = true },
      steeringRack     = { enabled = true, requiresItem = true },
      suspension       = { enabled = true, requiresItem = true },
      weightReduction  = { enabled = true, requiresItem = true },
      aerodynamics     = { enabled = true, requiresItem = true },
      transmissions    = { enabled = true, requiresItem = true },
      differentials    = { enabled = true, requiresItem = true },
      ecuTuning        = { enabled = true, requiresItem = true },
      cooling          = { enabled = true, requiresItem = true },
    },
    carLifts = { -- only usable by employees
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(-771.62, -2072.74, 8.99),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil", label = "Engine Oil", price = 25 },
          { name = "tyre_replacement", label = "Tyre Replacement", price = 100 },
          { name = "clutch_replacement", label = "Clutch Replacement", price = 100 },
          { name = "air_filter", label = "Air Filter", price = 25 },
          { name = "spark_plug", label = "Spark Plug", price = 25 },
          { name = "suspension_parts", label = "Suspension Parts", price = 100 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 50 },
          { name = "repair_kit", label = "Repair Kit", price = 100 },
          { name = "cleaning_kit", label = "Cleaning Kit", price = 25 },
          { name = "mechanic_tablet", label = "Mechanic Tablet", price = 100 },
          { name = "exhaust_system", label = "Exaust System", price = 1250 },
        },
      },

      {
        name = "Servicing Supplies 2",
        coords = vector3(-921.72, -2046.09, 14.45),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil", label = "Engine Oil", price = 25 },
          { name = "tyre_replacement", label = "Tyre Replacement", price = 100 },
          { name = "clutch_replacement", label = "Clutch Replacement", price = 100 },
          { name = "air_filter", label = "Air Filter", price = 25 },
          { name = "spark_plug", label = "Spark Plug", price = 25 },
          { name = "suspension_parts", label = "Suspension Parts", price = 100 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 50 },
          { name = "repair_kit", label = "Repair Kit", price = 100 },
          { name = "cleaning_kit", label = "Cleaning Kit", price = 25 },
          { name = "mechanic_tablet", label = "Mechanic Tablet", price = 100 },
          { name = "exhaust_system", label = "Exaust System", price = 1250 },
        },
      },

      {
        name = "Advanced Upgrades",
        coords = vector3(-776.64, -2074.43, 8.99),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "harness",             label = "Racing Harness",      price = 100 },
          { name = "ceramic_brakes",      label = "Ceramic Brakes",      price = 22500 },
          { name = "cosmetic_part",       label = "Body Kit",            price = 250 },
          { name = "performance_part",    label = "Performance Part",    price = 1000 },
          { name = "respray_kit",         label = "Respray Kit",         price = 250 },
          { name = "lighting_controller", label = "Lighting Controller", price = 75 },
          { name = "stancing_kit",        label = "Stance Kit",          price = 75 },
          { name = "vehicle_wheels",      label = "Vehicle Wheels Set",  price = 75 },
          { name = "tyre_smoke_kit",      label = "Tyre Smoke Kit",      price = 25 },
          { name = "extras_kit",          label = "Extras Kit",          price = 50 },
          { name = "nitrous_bottle",      label = "Nitrous Bottle",      price = 1000 },
          { name = "nitrous_install_kit", label = "Nitrous Install Kit", price = 4000 },
          { name = "slick_tyres",         label = "Slick Tyres",         price = 12500 },
          { name = "semi_slick_tyres",    label = "Semi Slick Tyres",    price = 12500 },
          { name = "offroad_tyres",       label = "Offroad Tyres",       price = 12500 },
          { name = "drift_tuning_kit",    label = "Drift Tuning Kit",    price = 30000 },
          { name = "i4_engine",           label = "I4 Engine",           price = 3750 },
          { name = "v6_engine",           label = "V6 Engine",           price = 27500 },
          { name = "v8_engine",           label = "V8 Engine",           price = 32500 },
          { name = "v12_engine",          label = "V12 Engine",          price = 50000 },
          { name = "turbocharger",        label = "Turbo",               price = 27500 },
          { name = "ev_motor",            label = "EV Motor",            price = 1000 },
          { name = "ev_battery",          label = "EV Battery",          price = 100 },
          { name = "ev_coolant",          label = "EV Coolant",          price = 100 },
          { name = "awd_drivetrain",      label = "AWD Drivetrain",      price = 25000 },
          { name = "rwd_drivetrain",      label = "RWD Drivetrain",      price = 25000 },
          { name = "fwd_drivetrain",      label = "FWD Drivetrain",      price = 25000 },
          { name = "manual_gearbox",      label = "Manual Gearbox",      price = 10000 },
          { name = "drag_tuning_kit",     label = "Drag Tuning Kit",     price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",   label = "Cruise Tuning Kit",   price = 12500 },
          { name = "quick_ratio_steering", label = "Quick Ratio Steering", price = 9000 },
          { name = "standard_steering",   label = "Standard Steering",   price = 6000 },
          { name = "slow_ratio_steering", label = "Slow Ratio Steering", price = 7500 },
          { name = "race_steering",       label = "Race Steering",       price = 12500 },
          { name = "4stroke_engine",      label = "4-Stroke Engine",     price = 7500 },
          { name = "5stroke_engine",      label = "5-Stroke Engine",     price = 12500 },
          { name = "inline6_engine",      label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v10_engine",          label = "V10 Engine",          price = 42500 },
          { name = "street_suspension",   label = "Street Suspension",   price = 7500 },
          { name = "sport_suspension",    label = "Sport Suspension",    price = 12500 },
          { name = "race_suspension",     label = "Race Suspension",     price = 17500 },
          { name = "lightweight_parts",   label = "Lightweight Parts",   price = 10000 },
          { name = "carbon_fiber_body",   label = "Carbon Fiber Body",   price = 22500 },
          { name = "street_spoiler",      label = "Street Spoiler",      price = 6000 },
          { name = "race_wing",           label = "Race Wing",           price = 12500 },
          { name = "6speed_manual",       label = "6-Speed Manual",      price = 9000 },
          { name = "8speed_auto",         label = "8-Speed Automatic",   price = 11000 },
          { name = "lsd_differential",    label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",   label = "Race Differential",   price = 17500 },
          { name = "stage1_ecu",          label = "Stage 1 ECU",         price = 7500 },
          { name = "stage2_ecu",          label = "Stage 2 ECU",         price = 12500 },
          { name = "performance_radiator", label = "Performance Radiator", price = 4000 },
          { name = "race_intercooler",    label = "Race Intercooler",    price = 7500 },
        },
      },

      {
        name = "Advanced Upgrades 2",
        coords = vector3(-925.5, -2041.7, 14.45),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "harness",             label = "Racing Harness",      price = 100 },
          { name = "ceramic_brakes",      label = "Ceramic Brakes",      price = 22500 },
          { name = "cosmetic_part",       label = "Body Kit",            price = 250 },
          { name = "performance_part",    label = "Performance Part",    price = 1000 },
          { name = "respray_kit",         label = "Respray Kit",         price = 250 },
          { name = "lighting_controller", label = "Lighting Controller", price = 75 },
          { name = "stancing_kit",        label = "Stance Kit",          price = 75 },
          { name = "vehicle_wheels",      label = "Vehicle Wheels Set",  price = 75 },
          { name = "tyre_smoke_kit",      label = "Tyre Smoke Kit",      price = 25 },
          { name = "extras_kit",          label = "Extras Kit",          price = 50 },
          { name = "nitrous_bottle",      label = "Nitrous Bottle",      price = 1000 },
          { name = "nitrous_install_kit", label = "Nitrous Install Kit", price = 4000 },
          { name = "slick_tyres",         label = "Slick Tyres",         price = 12500 },
          { name = "semi_slick_tyres",    label = "Semi Slick Tyres",    price = 12500 },
          { name = "offroad_tyres",       label = "Offroad Tyres",       price = 12500 },
          { name = "drift_tuning_kit",    label = "Drift Tuning Kit",    price = 30000 },
          { name = "i4_engine",           label = "I4 Engine",           price = 3750 },
          { name = "v6_engine",           label = "V6 Engine",           price = 27500 },
          { name = "v8_engine",           label = "V8 Engine",           price = 32500 },
          { name = "v12_engine",          label = "V12 Engine",          price = 50000 },
          { name = "turbocharger",        label = "Turbo",               price = 27500 },
          { name = "ev_motor",            label = "EV Motor",            price = 1000 },
          { name = "ev_battery",          label = "EV Battery",          price = 100 },
          { name = "ev_coolant",          label = "EV Coolant",          price = 100 },
          { name = "awd_drivetrain",      label = "AWD Drivetrain",      price = 25000 },
          { name = "rwd_drivetrain",      label = "RWD Drivetrain",      price = 25000 },
          { name = "fwd_drivetrain",      label = "FWD Drivetrain",      price = 25000 },
          { name = "manual_gearbox",      label = "Manual Gearbox",      price = 10000 },
          { name = "drag_tuning_kit",     label = "Drag Tuning Kit",     price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",   label = "Cruise Tuning Kit",   price = 12500 },
          { name = "quick_ratio_steering", label = "Quick Ratio Steering", price = 9000 },
          { name = "standard_steering",   label = "Standard Steering",   price = 6000 },
          { name = "slow_ratio_steering", label = "Slow Ratio Steering", price = 7500 },
          { name = "race_steering",       label = "Race Steering",       price = 12500 },
          { name = "4stroke_engine",      label = "4-Stroke Engine",     price = 7500 },
          { name = "5stroke_engine",      label = "5-Stroke Engine",     price = 12500 },
          { name = "inline6_engine",      label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v10_engine",          label = "V10 Engine",          price = 42500 },
          { name = "street_suspension",   label = "Street Suspension",   price = 7500 },
          { name = "sport_suspension",    label = "Sport Suspension",    price = 12500 },
          { name = "race_suspension",     label = "Race Suspension",     price = 17500 },
          { name = "lightweight_parts",   label = "Lightweight Parts",   price = 10000 },
          { name = "carbon_fiber_body",   label = "Carbon Fiber Body",   price = 22500 },
          { name = "street_spoiler",      label = "Street Spoiler",      price = 6000 },
          { name = "race_wing",           label = "Race Wing",           price = 12500 },
          { name = "6speed_manual",       label = "6-Speed Manual",      price = 9000 },
          { name = "8speed_auto",         label = "8-Speed Automatic",   price = 11000 },
          { name = "lsd_differential",    label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",   label = "Race Differential",   price = 17500 },
          { name = "stage1_ecu",          label = "Stage 1 ECU",         price = 7500 },
          { name = "stage2_ecu",          label = "Stage 2 ECU",         price = 12500 },
          { name = "performance_radiator", label = "Performance Radiator", price = 4000 },
          { name = "race_intercooler",    label = "Race Intercooler",    price = 7500 },
        },
      }
    },
    stashes = {
      {
        name = "Parts Bin",
        coords = vector3(-754.4, -2082.7, 9.18),
        job = 'bennies',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 100000,
        items = {
          -- Engine Parts
          { name = "4stroke_engine",       label = "4-Stroke Engine",       price = 3750 },
          { name = "5stroke_engine",       label = "5-Stroke Engine",       price = 12500 },
          { name = "v6_engine",            label = "V6 Engine",             price = 27500 },
          { name = "inline6_engine",       label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v8_engine",            label = "V8 Engine",             price = 32500 },
          { name = "v10_engine",           label = "V10 Engine",            price = 42500 },
          { name = "v12_engine",           label = "V12 Engine",            price = 12500 },
          { name = "turbocharger",         label = "Turbo",                 price = 27500 },
          { name = "i4_engine",            label = "I4 Engine",             price = 3750 },
        },
      },
      {
        name = "Parts Bin 2",
        coords = vector3(-767.3, -2093.51, 9.18),
        job = 'bennies',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 100000,
        items = {
          -- Drivetrain & Transmission
          { name = "awd_drivetrain",       label = "AWD Drivetrain",        price = 12500 },
          { name = "rwd_drivetrain",       label = "RWD Drivetrain",        price = 12500 },
          { name = "fwd_drivetrain",       label = "FWD Drivetrain",        price = 12500 },
          { name = "manual_gearbox",       label = "Manual Gearbox",        price = 1250 },
          { name = "6speed_manual",        label = "6-Speed Manual",        price = 18000 },
          { name = "8speed_auto",          label = "8-Speed Automatic",     price = 11000 },
          { name = "lsd_differential",     label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",    label = "Race Differential",     price = 35000 },
        },
      },
      {
        name = "Parts Bin 3",
        coords = vector3(-929.71, -2050.9, 9.05),
        job = 'bennies',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 100000,
        items = {
          -- Tuning Kits & Steering
          { name = "drift_tuning_kit",     label = "Drift Tuning Kit",      price = 15000 },
          { name = "drag_tuning_kit",      label = "Drag Tuning Kit",       price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",    label = "Cruise Tuning Kit",     price = 12500 },
          { name = "quick_ratio_steering", label = "Quick Ratio Steering",  price = 18000 },
          { name = "standard_steering",    label = "Standard Steering",     price = 12000 },
          { name = "slow_ratio_steering",  label = "Slow Ratio Steering",   price = 3750 },
          { name = "race_steering",        label = "Race Steering",         price = 12500 },
        },
      },
      {
        name = "Parts Bin 4",
        coords = vector3(-939.03, -2058.61, 9.05),
        job = 'bennies',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 100000,
        items = {
          -- Suspension & Performance
          { name = "street_suspension",    label = "Street Suspension",     price = 3750 },
          { name = "sport_suspension",     label = "Sport Suspension",      price = 12500 },
          { name = "race_suspension",      label = "Race Suspension",       price = 35000 },
          { name = "lightweight_parts",    label = "Lightweight Parts",     price = 10000 },
          { name = "carbon_fiber_body",    label = "Carbon Fiber Body",     price = 22500 },
          { name = "street_spoiler",       label = "Street Spoiler",        price = 12000 },
          { name = "race_wing",            label = "Race Wing",             price = 12500 },
          { name = "stage1_ecu",           label = "Stage 1 ECU",           price = 3750 },
          { name = "stage2_ecu",           label = "Stage 2 ECU",           price = 12500 },
        },
      },
      {
        name = "Parts Bin 5",
        coords = vector3(-951.27, -2030.35, 9.05),
        job = 'bennies',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 100000,
        items = {
          -- Tyres & Brakes
          { name = "slick_tyres",          label = "Slick Tyres",           price = 12500 },
          { name = "semi_slick_tyres",     label = "Semi Slick Tyres",      price = 12500 },
          { name = "offroad_tyres",        label = "Offroad Tyres",         price = 12500 },
          { name = "ceramic_brakes",       label = "Ceramic Brakes",        price = 22500 },
          { name = "performance_radiator", label = "Performance Radiator",  price = 8000 },
          { name = "race_intercooler",     label = "Race Intercooler",      price = 3750 },
          { name = "exhaust_system",       label = "Exhaust System",        price = 3750 },
          { name = "ev_motor",             label = "EV Motor",              price = 80000 },
          { name = "ev_battery",           label = "EV Battery",            price = 15000 },
        },
      },
      {
        name = "Parts Bin 6",
        coords = vector3(-956.65, -2025.79, 9.05),
        job = 'bennies',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 100000,
        items = {
          -- Basic Parts & Tools
          { name = "engine_oil",            label = "Engine Oil",            price = 25 },
          { name = "tyre_replacement",      label = "Tyre Replacement",      price = 100 },
          { name = "clutch_replacement",    label = "Clutch Replacement",    price = 100 },
          { name = "air_filter",            label = "Air Filter",            price = 25 },
          { name = "spark_plug",            label = "Spark Plug",            price = 25 },
          { name = "suspension_parts",      label = "Suspension Parts",      price = 100 },
          { name = "brakepad_replacement",  label = "Brakepad Replacement",  price = 50 },
          { name = "repair_kit",            label = "Repair Kit",            price = 100 },
          { name = "cleaning_kit",          label = "Cleaning Kit",          price = 25 },
          { name = "mechanic_tablet",       label = "Mechanic Tablet",       price = 100 },
        },
      },
      {
        name = "Parts Bin 7",
        coords = vector3(-962.16, -2035.21, 9.05),
        job = 'bennies',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 100000,
        items = {
          -- Cosmetic & Special Parts
          { name = "harness",               label = "Racing Harness",        price = 100 },
          { name = "cosmetic_part",         label = "Body Kit",              price = 250 },
          { name = "performance_part",      label = "Performance Part",      price = 1000 },
          { name = "respray_kit",           label = "Respray Kit",           price = 250 },
          { name = "lighting_controller",   label = "Lighting Controller",   price = 75 },
          { name = "stancing_kit",          label = "Stance Kit",            price = 75 },
          { name = "vehicle_wheels",        label = "Vehicle Wheels Set",    price = 75 },
          { name = "tyre_smoke_kit",        label = "Tyre Smoke Kit",        price = 25 },
          { name = "extras_kit",            label = "Extras Kit",            price = 50 },
          { name = "nitrous_bottle",        label = "Nitrous Bottle",        price = 250 },
        },
      },
      {
        name = "Parts Bin 8",
        coords = vector3(-971.13, -2043.88, 9.05),
        job = 'bennies',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 100000,
        items = {
          -- Nitrous & EV Parts
          { name = "nitrous_install_kit",   label = "Nitrous Install Kit",   price = 100 },
          { name = "empty_nitrous_bottle",  label = "Empty Nitrous Bottle",  price = 25 },
          { name = "ev_coolant",            label = "EV Coolant",            price = 50 },
          { name = "duct_tape",             label = "Duct Tape",             price = 25 },
          { name = "exhaust_system",        label = "Exhaust System",        price = 3750 },
          { name = "slick_tyres",           label = "Slick Tyres",           price = 12500 },
          { name = "semi_slick_tyres",      label = "Semi Slick Tyres",      price = 12500 },
          { name = "offroad_tyres",         label = "Offroad Tyres",         price = 12500 },
          { name = "ceramic_brakes",        label = "Ceramic Brakes",        price = 22500 },
        },
      },
      {
        name = "Parts Bin 9",
        coords = vector3(-976.45, -2048.07, 9.05),
        job = 'bennies',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 100000,
        items = {
          -- Additional Performance Parts
          { name = "performance_radiator",  label = "Performance Radiator",  price = 8000 },
          { name = "race_intercooler",      label = "Race Intercooler",      price = 3750 },
          { name = "stage1_ecu",            label = "Stage 1 ECU",           price = 3750 },
          { name = "stage2_ecu",            label = "Stage 2 ECU",           price = 12500 },
          { name = "lightweight_parts",     label = "Lightweight Parts",     price = 10000 },
          { name = "carbon_fiber_body",     label = "Carbon Fiber Body",     price = 22500 },
          { name = "street_spoiler",        label = "Street Spoiler",        price = 12000 },
          { name = "race_wing",             label = "Race Wing",             price = 12500 },
          { name = "street_suspension",     label = "Street Suspension",     price = 3750 },
          { name = "sport_suspension",      label = "Sport Suspension",      price = 12500 },
        },
      },

      
    }
  },
  -- aod = {
  --   type = "owned",
  --   job = "aod",
  --   jobManagementRanks = {4},
  --   logo = "ls_customs.png",
  --   commission = 10, -- %, 10 = 10%
  --   locations = {
  --     {
  --       coords = vector3(278.11, 6667.86, 29.59),
  --       size = 3.0,
  --       showBlip = false,
  --     },
  --     {
  --       coords = vector3(273.07, 6667.91, 29.59),
  --       size = 3.0,
  --       showBlip = true,
  --     },
  --     {
  --       coords = vector3(259.75, 6663.1, 29.6),
  --       size = 3.0,
  --       showBlip = false,
  --     },

  --     -- TWO BAYS ON THE OUTSIDE
  --     {
  --       coords = vector3(262.31, 6635.04, 29.51),
  --       size = 3.0,
  --       showBlip = false,
  --     },
  --     {
  --       coords = vector3(266.36, 6634.96, 29.51),
  --       size = 3.0,
  --       showBlip = false,
  --     },

      
  --   },
  --   blip = {
  --     id = 446,
  --     color = 47,
  --     scale = 0.7
  --   },
  --   mods = {
  --     repair           = { enabled = true, price = 300, percentVehVal = 0.01 },
  --     performance      = { enabled = true, price = 1500, percentVehVal = 0.01, priceMult = 0.1 },
  --     cosmetics        = { enabled = true, price = 800, percentVehVal = 0.01, priceMult = 0.1 },
  --     stance           = { enabled = true, price = 300, percentVehVal = 0.01 },
  --     respray          = { enabled = true, price = 600, percentVehVal = 0.01 },
  --     wheels           = { enabled = true, price = 300, percentVehVal = 0.01, priceMult = 0.1 },
  --     neonLights       = { enabled = true, price = 300, percentVehVal = 0.01 },
  --     headlights       = { enabled = true, price = 300, percentVehVal = 0.01 },
  --     tyreSmoke        = { enabled = true, price = 50, percentVehVal = 0.01 },
  --     bulletproofTyres = { enabled = false, price = 250, percentVehVal = 0.01 },
  --     extras           = { enabled = true, price = 100, percentVehVal = 0.01 }
  --   },
  --   tuning = {
  --     engineSwaps      = { enabled = true, requiresItem = true },
  --     drivetrains      = { enabled = true, requiresItem = true },
  --     turbocharging    = { enabled = true, requiresItem = true },
  --     tyres            = { enabled = true, requiresItem = true },
  --     brakes           = { enabled = true, requiresItem = true },
  --     driftTuning      = { enabled = true, requiresItem = true },
  --     gearboxes        = { enabled = true, requiresItem = true },
  --   },
  --   shops = {
  --     {
  --       name = "Servicing Supplies",
  --       coords = vector3(261.49, 6671.11, 33.32),
  --       size = 2.0,
  --       usePed = false,
  --       pedModel = "s_m_m_lathandy_01",
  --       marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
  --       items = {
  --         { name = "engine_oil",          label = "Engine Oil",           price = 25 },
  --         { name = "tyre_replacement",    label = "Tyre Replacement",     price = 100 },
  --         { name = "clutch_replacement",  label = "Clutch Replacement",   price = 100 },
  --         { name = "air_filter",          label = "Air Filter",           price = 25 },
  --         { name = "spark_plug",          label = "Spark Plug",           price = 25 },
  --         { name = "suspension_parts",    label = "Suspension Parts",     price = 100 },
  --         { name = "brakepad_replacement", label = "Brakepad Replacement", price = 50 },
  --         { name = "repair_kit",          label = "Repair Kit",           price = 100 },
  --         { name = "cleaning_kit",        label = "Cleaning Kit",         price = 25 },
  --         { name = "mechanic_tablet",     label = "Mechanic Tablet",      price = 100 },
  --         { name = "ev_motor",            label = "EV Motor",             price = 375 },
  --         { name = "ev_battery",          label = "EV Battery",           price = 1000 },
  --         { name = "ev_coolant",          label = "EV Coolant",           price = 250 },
  --       },
  --     },
  --     {
  --       name = "Advanced Upgrades",
  --       coords = vector3(263.61, 6668.1, 33.32),
  --       size = 2.0,
  --       usePed = false,
  --       pedModel = "s_m_m_lathandy_01",
  --       marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
  --       items = {
  --         { name = "harness",             label = "Racing Harness",      price = 100 },
  --         { name = "ceramic_brakes",      label = "Ceramic Brakes",      price = 1000 },
  --         { name = "cosmetic_part",       label = "Body Kit",            price = 250 },
  --         { name = "performance_part",    label = "Performance Part",    price = 1000 },
  --         { name = "respray_kit",         label = "Respray Kit",         price = 250 },
  --         { name = "lighting_controller", label = "Lighting Controller", price = 75 },
  --         { name = "stancing_kit",        label = "Stance Kit",          price = 75 },
  --         { name = "vehicle_wheels",      label = "Vehicle Wheels Set",  price = 75 },
  --         { name = "tyre_smoke_kit",      label = "Tyre Smoke Kit",      price = 25 },
  --         { name = "extras_kit",          label = "Extras Kit",          price = 50 },
  --         { name = "nitrous_bottle",      label = "Nitrous Bottle",      price = 1000 },
  --         { name = "nitrous_install_kit", label = "Nitrous Install Kit", price = 4000 },
  --         { name = "slick_tyres",         label = "Slick Tyres",         price = 250 },
  --         { name = "semi_slick_tyres",    label = "Semi Slick Tyres",    price = 250 },
  --         { name = "offroad_tyres",       label = "Offroad Tyres",       price = 250 },
  --         { name = "drift_tuning_kit",    label = "Drift Tuning Kit",    price = 1000 },
  --         { name = "i4_engine",           label = "I4 Engine",           price = 3750 },
  --         { name = "v6_engine",           label = "V6 Engine",           price = 3750 },
  --         { name = "v8_engine",           label = "V8 Engine",           price = 3750 },
  --         { name = "v12_engine",          label = "V12 Engine",          price = 3750 },
  --         { name = "turbocharger",        label = "Turbo",               price = 1000 },
  --         { name = "ev_motor",            label = "EV Motor",            price = 1000 },
  --         { name = "ev_battery",          label = "EV Battery",          price = 100 },
  --         { name = "ev_coolant",          label = "EV Coolant",          price = 100 },
  --         { name = "awd_drivetrain",      label = "AWD Drivetrain",      price = 1000 },
  --         { name = "rwd_drivetrain",      label = "RWD Drivetrain",      price = 1000 },
  --         { name = "fwd_drivetrain",      label = "FWD Drivetrain",      price = 1000 },
  --         { name = "manual_gearbox",      label = "Manual Gearbox",      price = 10000 },
  --       },
  --     },
  --   },
  --   stashes = {
  --     {
  --       name = "Parts Bin",
  --       coords = vector3(266.65, 6669.22, 29.96),
  --       size = 1.0,
  --       usePed = false,
  --       pedModel = "s_m_m_lathandy_01",
  --       marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
  --       slots = 20,
  --       weight = 100000,
  --     },
  --     {
  --       name = "Perfomance",
  --       coords = vector3(280.92, 6668.75, 29.96),
  --       size = 1.0,
  --       usePed = false,
  --       pedModel = "s_m_m_lathandy_01",
  --       marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
  --       slots = 20,
  --       weight = 100000,
  --     },
  --     {
  --       name = "Body Parts",
  --       coords = vector3(279.04, 6671.24, 29.96),
  --       size = 2.0,
  --       usePed = false,
  --       pedModel = "s_m_m_lathandy_01",
  --       marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
  --       slots = 20,
  --       weight = 50000,
  --     },
  --     {
  --       name = "Body Parts 2",
  --       coords = vector3(264.55, 6632.69, 29.88),
  --       size = 2.0,
  --       usePed = false,
  --       pedModel = "s_m_m_lathandy_01",
  --       marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
  --       slots = 20,
  --       weight = 50000,
  --     },
  --   }
  -- },

  tunershop = {
    label = "6Street Tuner Shop",
    type = "owned",
    job = "6str",
    jobManagementRanks = {4, 5}, -- Only grades 4 and 5 can access management
    logo = "tunershop.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(144.97, -3030.17, 6.62),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vector3(135.87, -3030.08, 6.62),
        size = 2.0,
        showBlip = true,
      },
      {
        coords = vector3(125.12, -3047.23, 6.62),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vector3(125.2, -3041.32, 6.62),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vector3(125.21, -3035.03, 6.74),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vector3(125.4, -3023.15, 6.62),
        size = 2.0,
        showBlip = false,
      },
      

      {--- Chopper Repairs
        coords = vector3(166.82, -3009.15, 5.84),
        size = 3.0,
        showBlip = false,
      },
    },
    blip = {
      id = 446,
      color = 75,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 1500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 3750, percentVehVal = 0.01, priceMult = 0.1,},
      cosmetics        = { enabled = true, price = 1100, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 375, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 1250, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 1500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 1500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 2250, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 1250, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 250, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 1100, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps      = { enabled = true, requiresItem = true },
      engineSounds     = { enabled = true, requiresItem = true },
      drivetrains      = { enabled = true, requiresItem = true },
      turbocharging    = { enabled = true, requiresItem = true },
      tyres            = { enabled = true, requiresItem = true },
      brakes           = { enabled = true, requiresItem = true },
      driftTuning      = { enabled = true, requiresItem = true },
      gearboxes        = { enabled = true, requiresItem = true },
      raceTuning       = { enabled = true, requiresItem = true },
      steeringRack     = { enabled = true, requiresItem = true },
      suspension       = { enabled = true, requiresItem = true },
      weightReduction  = { enabled = true, requiresItem = true },
      aerodynamics     = { enabled = true, requiresItem = true },
      transmissions    = { enabled = true, requiresItem = true },
      differentials    = { enabled = true, requiresItem = true },
      ecuTuning        = { enabled = true, requiresItem = true },
      cooling          = { enabled = true, requiresItem = true },
    },
    carLifts = { -- only usable by employees
        -- vector4(-359.08, -90.53, 38.99, 340),
        -- vector4(-368.52, -87.26, 38.99, 340)
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(128.72, -3009.19, 7.04),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 229, g = 5, b = 5, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil",          label = "Engine Oil",           price = 25 },
          { name = "tyre_replacement",    label = "Tyre Replacement",     price = 100 },
          { name = "clutch_replacement",  label = "Clutch Replacement",   price = 100 },
          { name = "air_filter",          label = "Air Filter",           price = 25 },
          { name = "spark_plug",          label = "Spark Plug",           price = 25 },
          { name = "suspension_parts",    label = "Suspension Parts",     price = 100 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 50 },
          { name = "repair_kit",          label = "Repair Kit",           price = 100 },
          { name = "cleaning_kit",        label = "Cleaning Kit",         price = 25 },
          { name = "mechanic_tablet",     label = "Mechanic Tablet",      price = 100 },
          { name = "ev_motor",            label = "EV Motor",             price = 375 },
          { name = "ev_battery",          label = "EV Battery",           price = 1000 },
          { name = "ev_coolant",          label = "EV Coolant",           price = 250 },
          { name = "exhaust_system",      label = "Exaust System",        price = 1250 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(128.45, -3013.5, 7.04),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 229, g = 5, b = 5, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "harness",             label = "Racing Harness",      price = 100 },
          { name = "ceramic_brakes",      label = "Ceramic Brakes",      price = 22500 },
          { name = "cosmetic_part",       label = "Body Kit",            price = 250 },
          { name = "performance_part",    label = "Performance Part",    price = 1000 },
          { name = "respray_kit",         label = "Respray Kit",         price = 250 },
          { name = "lighting_controller", label = "Lighting Controller", price = 75 },
          { name = "stancing_kit",        label = "Stance Kit",          price = 75 },
          { name = "vehicle_wheels",      label = "Vehicle Wheels Set",  price = 75 },
          { name = "tyre_smoke_kit",      label = "Tyre Smoke Kit",      price = 25 },
          { name = "extras_kit",          label = "Extras Kit",          price = 50 },
          { name = "nitrous_bottle",      label = "Nitrous Bottle",      price = 1000 },
          { name = "nitrous_install_kit", label = "Nitrous Install Kit", price = 4000 },
          { name = "slick_tyres",         label = "Slick Tyres",         price = 12500 },
          { name = "semi_slick_tyres",    label = "Semi Slick Tyres",    price = 12500 },
          { name = "offroad_tyres",       label = "Offroad Tyres",       price = 12500 },
          { name = "drift_tuning_kit",    label = "Drift Tuning Kit",    price = 30000 },
          { name = "i4_engine",           label = "I4 Engine",           price = 3750 },
          { name = "v6_engine",           label = "V6 Engine",           price = 27500 },
          { name = "v8_engine",           label = "V8 Engine",           price = 32500 },
          { name = "v12_engine",          label = "V12 Engine",          price = 50000 },
          { name = "turbocharger",        label = "Turbo",               price = 27500 },
          { name = "ev_motor",            label = "EV Motor",            price = 1000 },
          { name = "ev_battery",          label = "EV Battery",          price = 100 },
          { name = "ev_coolant",          label = "EV Coolant",          price = 100 },
          { name = "awd_drivetrain",      label = "AWD Drivetrain",      price = 25000 },
          { name = "rwd_drivetrain",      label = "RWD Drivetrain",      price = 25000 },
          { name = "fwd_drivetrain",      label = "FWD Drivetrain",      price = 25000 },
          { name = "manual_gearbox",      label = "Manual Gearbox",      price = 10000 },
          { name = "drag_tuning_kit",     label = "Drag Tuning Kit",     price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",   label = "Cruise Tuning Kit",   price = 12500 },
          { name = "quick_ratio_steering", label = "Quick Ratio Steering", price = 9000 },
          { name = "standard_steering",   label = "Standard Steering",   price = 6000 },
          { name = "slow_ratio_steering", label = "Slow Ratio Steering", price = 7500 },
          { name = "race_steering",       label = "Race Steering",       price = 12500 },
          { name = "4stroke_engine",      label = "4-Stroke Engine",     price = 7500 },
          { name = "5stroke_engine",      label = "5-Stroke Engine",     price = 12500 },
          { name = "inline6_engine",      label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v10_engine",          label = "V10 Engine",          price = 42500 },
          { name = "street_suspension",   label = "Street Suspension",   price = 7500 },
          { name = "sport_suspension",    label = "Sport Suspension",    price = 12500 },
          { name = "race_suspension",     label = "Race Suspension",     price = 17500 },
          { name = "lightweight_parts",   label = "Lightweight Parts",   price = 10000 },
          { name = "carbon_fiber_body",   label = "Carbon Fiber Body",   price = 22500 },
          { name = "street_spoiler",      label = "Street Spoiler",      price = 6000 },
          { name = "race_wing",           label = "Race Wing",           price = 12500 },
          { name = "6speed_manual",       label = "6-Speed Manual",      price = 9000 },
          { name = "8speed_auto",         label = "8-Speed Automatic",   price = 11000 },
          { name = "lsd_differential",    label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",   label = "Race Differential",   price = 17500 },
          { name = "stage1_ecu",          label = "Stage 1 ECU",         price = 7500 },
          { name = "stage2_ecu",          label = "Stage 2 ECU",         price = 12500 },
          { name = "performance_radiator", label = "Performance Radiator", price = 4000 },
          { name = "race_intercooler",    label = "Race Intercooler",    price = 7500 },
        },
      }
    },
    stashes = {
      {
        name = "6STR Parts Bin 1",
        coords = vector3(122.01, -3024.77, 7.04),
        job = '6str',
        grade = '0',
        size = 1.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 229, g = 5, b = 5, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 50,
        weight = 100000,
        items = {
          -- High-End Engine Parts
          { name = "v10_engine",           label = "V10 Engine",            price = 42500 },
          { name = "v12_engine",           label = "V12 Engine",            price = 12500 },
          { name = "turbocharger",         label = "Turbo",                 price = 27500 },
          { name = "inline6_engine",       label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v8_engine",            label = "V8 Engine",             price = 32500 },
          { name = "v6_engine",            label = "V6 Engine",             price = 27500 },
          { name = "5stroke_engine",       label = "5-Stroke Engine",       price = 12500 },
          { name = "4stroke_engine",       label = "4-Stroke Engine",       price = 3750 },
          { name = "i4_engine",            label = "I4 Engine",             price = 3750 },
          -- Drivetrain
          { name = "awd_drivetrain",       label = "AWD Drivetrain",        price = 12500 },
          { name = "rwd_drivetrain",       label = "RWD Drivetrain",        price = 12500 },
          { name = "fwd_drivetrain",       label = "FWD Drivetrain",        price = 12500 },
          -- Transmission
          { name = "manual_gearbox",       label = "Manual Gearbox",        price = 1250 },
          { name = "6speed_manual",        label = "6-Speed Manual",        price = 18000 },
          { name = "8speed_auto",          label = "8-Speed Automatic",     price = 11000 },
          -- Differential
          { name = "lsd_differential",     label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",    label = "Race Differential",     price = 35000 },
          -- ECU Tuning
          { name = "stage1_ecu",           label = "Stage 1 ECU",           price = 3750 },
          { name = "stage2_ecu",           label = "Stage 2 ECU",           price = 12500 },
          -- Cooling Systems
          { name = "performance_radiator", label = "Performance Radiator",  price = 8000 },
          { name = "race_intercooler",     label = "Race Intercooler",      price = 3750 },
          -- Exhaust Systems
          { name = "exhaust_system",       label = "Exhaust System",        price = 3750 },
        },
      },
      {
        name = "6STR Parts Bin 2",
        coords = vector3(130.26, -3031.69, 7.08),
        job = '6str',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 229, g = 5, b = 5, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Tuning Kits
          { name = "drift_tuning_kit",     label = "Drift Tuning Kit",      price = 15000 },
          { name = "drag_tuning_kit",      label = "Drag Tuning Kit",       price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",    label = "Cruise Tuning Kit",     price = 12500 },
          -- Steering
          { name = "quick_ratio_steering", label = "Quick Ratio Steering",  price = 18000 },
          { name = "standard_steering",    label = "Standard Steering",     price = 12000 },
          { name = "slow_ratio_steering",  label = "Slow Ratio Steering",   price = 3750 },
          { name = "race_steering",        label = "Race Steering",         price = 12500 },
          -- Suspension
          { name = "street_suspension",    label = "Street Suspension",     price = 3750 },
          { name = "sport_suspension",     label = "Sport Suspension",      price = 12500 },
        },
      },
      {
        name = "6STR Parts Bin 3",
        coords = vector3(128.65, -3050.65, 7.04),
        job = '6str',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 229, g = 5, b = 5, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Race Suspension & Performance
          { name = "race_suspension",      label = "Race Suspension",       price = 35000 },
          { name = "lightweight_parts",    label = "Lightweight Parts",     price = 10000 },
          { name = "carbon_fiber_body",    label = "Carbon Fiber Body",     price = 22500 },
          { name = "street_spoiler",       label = "Street Spoiler",        price = 12000 },
          { name = "race_wing",            label = "Race Wing",             price = 12500 },
          -- Tyres & Brakes
          { name = "slick_tyres",          label = "Slick Tyres",           price = 12500 },
          { name = "semi_slick_tyres",     label = "Semi Slick Tyres",      price = 12500 },
          { name = "offroad_tyres",        label = "Offroad Tyres",         price = 12500 },
          { name = "ceramic_brakes",       label = "Ceramic Brakes",        price = 22500 },
        },
      },
      {
        name = "6STR Parts Bin 4",
        coords = vector3(148.18, -3050.57, 7.04),
        job = '6str',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 229, g = 5, b = 5, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Basic Parts & Tools
          { name = "engine_oil",            label = "Engine Oil",            price = 25 },
          { name = "tyre_replacement",      label = "Tyre Replacement",      price = 100 },
          { name = "clutch_replacement",    label = "Clutch Replacement",    price = 100 },
          { name = "air_filter",            label = "Air Filter",            price = 25 },
          { name = "spark_plug",            label = "Spark Plug",            price = 25 },
          { name = "suspension_parts",      label = "Suspension Parts",      price = 100 },
          { name = "brakepad_replacement",  label = "Brakepad Replacement",  price = 50 },
          { name = "repair_kit",            label = "Repair Kit",            price = 100 },
          { name = "cleaning_kit",          label = "Cleaning Kit",          price = 25 },
          { name = "mechanic_tablet",       label = "Mechanic Tablet",       price = 100 },
        },
      },
      {
        name = "6STR Parts Bin 5",
        coords = vector3(126.97, -3008.4, 10.7),
        job = '6str',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 229, g = 5, b = 5, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Cosmetic & Special Parts
          { name = "harness",               label = "Racing Harness",        price = 100 },
          { name = "cosmetic_part",         label = "Body Kit",              price = 250 },
          { name = "performance_part",      label = "Performance Part",      price = 1000 },
          { name = "respray_kit",           label = "Respray Kit",           price = 250 },
          { name = "lighting_controller",   label = "Lighting Controller",   price = 75 },
          { name = "stancing_kit",          label = "Stance Kit",            price = 75 },
          { name = "vehicle_wheels",        label = "Vehicle Wheels Set",    price = 75 },
          { name = "tyre_smoke_kit",        label = "Tyre Smoke Kit",        price = 25 },
          { name = "extras_kit",            label = "Extras Kit",            price = 50 },
          { name = "nitrous_bottle",        label = "Nitrous Bottle",        price = 250 },
        },
      },
      {
        name = "6STR Parts Bin 6",
        coords = vector3(153.13, -3012.74, 10.7),
        job = '6str',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 229, g = 5, b = 5, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Nitrous & EV Parts
          { name = "nitrous_install_kit",   label = "Nitrous Install Kit",   price = 100 },
          { name = "empty_nitrous_bottle",  label = "Empty Nitrous Bottle",  price = 25 },
          { name = "ev_motor",              label = "EV Motor",              price = 80000 },
          { name = "ev_battery",            label = "EV Battery",            price = 15000 },
          { name = "ev_coolant",            label = "EV Coolant",            price = 50 },
          { name = "duct_tape",             label = "Duct Tape",             price = 25 },
          { name = "exhaust_system",        label = "Exhaust System",        price = 3750 },
          { name = "performance_radiator",  label = "Performance Radiator",  price = 8000 },
          { name = "race_intercooler",      label = "Race Intercooler",      price = 3750 },
        },
      },
    }
  },

  onelifemechanics = {
    type = "owned",
    job = "olrpmechanic",
    jobManagementRanks = {4, 5}, -- Only grades 4 and 5 can access management
    logo = "onelife_mechanics.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(1138.67, -781.45, 57.18),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vector3(1143.67, -781.88, 57.18),
        size = 2.0,
        showBlip = true,
      },
      {
        coords = vector3(1149.55, -781.86, 57.17),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vector3(1130.09, -784.99, 57.23),
        size = 2.0,
        showBlip = false,
      },
      {
        coords = vector3(1149.87, -792.47, 57.18),
        size = 2.0,
        showBlip = false,
      },
    },
    blip = {
      id = 446,
      color = 57,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 1500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 3750, percentVehVal = 0.01, priceMult = 0.1,},
      cosmetics        = { enabled = true, price = 1100, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 375, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 1250, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 1500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 1500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 2250, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 1250, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 250, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 1100, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps      = { enabled = true, requiresItem = true },
      engineSounds     = { enabled = true, requiresItem = true },
      drivetrains      = { enabled = true, requiresItem = true },
      turbocharging    = { enabled = true, requiresItem = true },
      tyres            = { enabled = true, requiresItem = true },
      brakes           = { enabled = true, requiresItem = true },
      driftTuning      = { enabled = true, requiresItem = true },
      gearboxes        = { enabled = true, requiresItem = true },
      raceTuning       = { enabled = true, requiresItem = true },
      steeringRack     = { enabled = true, requiresItem = true },
      suspension       = { enabled = true, requiresItem = true },
      weightReduction  = { enabled = true, requiresItem = true },
      aerodynamics     = { enabled = true, requiresItem = true },
      transmissions    = { enabled = true, requiresItem = true },
      differentials    = { enabled = true, requiresItem = true },
      ecuTuning        = { enabled = true, requiresItem = true },
      cooling          = { enabled = true, requiresItem = true },
    },
    carLifts = { -- only usable by employees
        -- vector4(-359.08, -90.53, 38.99, 340),
        -- vector4(-368.52, -87.26, 38.99, 340)
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(1156.08, -781.2, 57.61),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 113, g = 182, b = 227, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil",          label = "Engine Oil",           price = 25 },
          { name = "tyre_replacement",    label = "Tyre Replacement",     price = 100 },
          { name = "clutch_replacement",  label = "Clutch Replacement",   price = 100 },
          { name = "air_filter",          label = "Air Filter",           price = 25 },
          { name = "spark_plug",          label = "Spark Plug",           price = 25 },
          { name = "suspension_parts",    label = "Suspension Parts",     price = 100 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 50 },
          { name = "repair_kit",          label = "Repair Kit",           price = 100 },
          { name = "cleaning_kit",        label = "Cleaning Kit",         price = 25 },
          { name = "mechanic_tablet",     label = "Mechanic Tablet",      price = 100 },
          { name = "ev_motor",            label = "EV Motor",             price = 375 },
          { name = "ev_battery",          label = "EV Battery",           price = 1000 },
          { name = "ev_coolant",          label = "EV Coolant",           price = 250 },
          { name = "exhaust_system",      label = "Exaust System",        price = 1250 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(1160.28, -782.4, 57.61),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 113, g = 182, b = 227, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "harness",             label = "Racing Harness",      price = 100 },
          { name = "ceramic_brakes",      label = "Ceramic Brakes",      price = 22500 },
          { name = "cosmetic_part",       label = "Body Kit",            price = 250 },
          { name = "performance_part",    label = "Performance Part",    price = 1000 },
          { name = "respray_kit",         label = "Respray Kit",         price = 250 },
          { name = "lighting_controller", label = "Lighting Controller", price = 75 },
          { name = "stancing_kit",        label = "Stance Kit",          price = 75 },
          { name = "vehicle_wheels",      label = "Vehicle Wheels Set",  price = 75 },
          { name = "tyre_smoke_kit",      label = "Tyre Smoke Kit",      price = 25 },
          { name = "extras_kit",          label = "Extras Kit",          price = 50 },
          { name = "nitrous_bottle",      label = "Nitrous Bottle",      price = 1000 },
          { name = "nitrous_install_kit", label = "Nitrous Install Kit", price = 4000 },
          { name = "slick_tyres",         label = "Slick Tyres",         price = 12500 },
          { name = "semi_slick_tyres",    label = "Semi Slick Tyres",    price = 12500 },
          { name = "offroad_tyres",       label = "Offroad Tyres",       price = 12500 },
          { name = "drift_tuning_kit",    label = "Drift Tuning Kit",    price = 30000 },
          { name = "i4_engine",           label = "I4 Engine",           price = 3750 },
          { name = "v6_engine",           label = "V6 Engine",           price = 27500 },
          { name = "v8_engine",           label = "V8 Engine",           price = 32500 },
          { name = "v12_engine",          label = "V12 Engine",          price = 50000 },
          { name = "turbocharger",        label = "Turbo",               price = 27500 },
          { name = "ev_motor",            label = "EV Motor",            price = 1000 },
          { name = "ev_battery",          label = "EV Battery",          price = 100 },
          { name = "ev_coolant",          label = "EV Coolant",          price = 100 },
          { name = "awd_drivetrain",      label = "AWD Drivetrain",      price = 25000 },
          { name = "rwd_drivetrain",      label = "RWD Drivetrain",      price = 25000 },
          { name = "fwd_drivetrain",      label = "FWD Drivetrain",      price = 25000 },
          { name = "manual_gearbox",      label = "Manual Gearbox",      price = 10000 },
          { name = "drag_tuning_kit",     label = "Drag Tuning Kit",     price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",   label = "Cruise Tuning Kit",   price = 12500 },
          { name = "quick_ratio_steering", label = "Quick Ratio Steering", price = 9000 },
          { name = "standard_steering",   label = "Standard Steering",   price = 6000 },
          { name = "slow_ratio_steering", label = "Slow Ratio Steering", price = 7500 },
          { name = "race_steering",       label = "Race Steering",       price = 12500 },
          { name = "4stroke_engine",      label = "4-Stroke Engine",     price = 7500 },
          { name = "5stroke_engine",      label = "5-Stroke Engine",     price = 12500 },
          { name = "inline6_engine",      label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v10_engine",          label = "V10 Engine",          price = 42500 },
          { name = "street_suspension",   label = "Street Suspension",   price = 7500 },
          { name = "sport_suspension",    label = "Sport Suspension",    price = 12500 },
          { name = "race_suspension",     label = "Race Suspension",     price = 17500 },
          { name = "lightweight_parts",   label = "Lightweight Parts",   price = 10000 },
          { name = "carbon_fiber_body",   label = "Carbon Fiber Body",   price = 22500 },
          { name = "street_spoiler",      label = "Street Spoiler",      price = 6000 },
          { name = "race_wing",           label = "Race Wing",           price = 12500 },
          { name = "6speed_manual",       label = "6-Speed Manual",      price = 9000 },
          { name = "8speed_auto",         label = "8-Speed Automatic",   price = 11000 },
          { name = "lsd_differential",    label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",   label = "Race Differential",   price = 17500 },
          { name = "stage1_ecu",          label = "Stage 1 ECU",         price = 7500 },
          { name = "stage2_ecu",          label = "Stage 2 ECU",         price = 12500 },
          { name = "performance_radiator", label = "Performance Radiator", price = 4000 },
          { name = "race_intercooler",    label = "Race Intercooler",    price = 7500 },
        },
      }
    },
    stashes = {
      {
        name = "OneLife Mech Parts Bin 1",
        coords = vector3(1148.23, -785.56, 57.6),
        job = 'olrpmechanic',
        grade = '0',
        size = 1.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 113, g = 182, b = 227, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 50,
        weight = 100000,
        items = {
          -- Complete Engine Collection
          { name = "4stroke_engine",       label = "4-Stroke Engine",       price = 3750 },
          { name = "5stroke_engine",       label = "5-Stroke Engine",       price = 12500 },
          { name = "i4_engine",            label = "I4 Engine",             price = 3750 },
          { name = "v6_engine",            label = "V6 Engine",             price = 27500 },
          { name = "inline6_engine",       label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v8_engine",            label = "V8 Engine",             price = 32500 },
          { name = "v10_engine",           label = "V10 Engine",            price = 42500 },
          { name = "v12_engine",           label = "V12 Engine",            price = 12500 },
          { name = "turbocharger",         label = "Turbo",                 price = 27500 },
          -- Complete Drivetrain Collection
          { name = "awd_drivetrain",       label = "AWD Drivetrain",        price = 12500 },
          { name = "rwd_drivetrain",       label = "RWD Drivetrain",        price = 12500 },
          { name = "fwd_drivetrain",       label = "FWD Drivetrain",        price = 12500 },
          -- Complete Transmission Collection
          { name = "manual_gearbox",       label = "Manual Gearbox",        price = 1250 },
          { name = "6speed_manual",        label = "6-Speed Manual",        price = 18000 },
          { name = "8speed_auto",          label = "8-Speed Automatic",     price = 11000 },
          -- Complete Differential Collection
          { name = "lsd_differential",     label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",    label = "Race Differential",     price = 35000 },
          -- Complete ECU Collection
          { name = "stage1_ecu",           label = "Stage 1 ECU",           price = 3750 },
          { name = "stage2_ecu",           label = "Stage 2 ECU",           price = 12500 },
          -- Complete Cooling Collection
          { name = "performance_radiator", label = "Performance Radiator",  price = 8000 },
          { name = "race_intercooler",     label = "Race Intercooler",      price = 3750 },
          -- Complete Exhaust Collection
          { name = "exhaust_system",       label = "Exhaust System",        price = 3750 },
        },
      },
      {
        name = "OneLife Mech Parts Bin 2",
        coords = vector3(1153.75, -780.84, 57.6),
        job = 'olrpmechanic',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 113, g = 182, b = 227, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Complete Tuning Kits Collection
          { name = "drift_tuning_kit",     label = "Drift Tuning Kit",      price = 15000 },
          { name = "drag_tuning_kit",      label = "Drag Tuning Kit",       price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",    label = "Cruise Tuning Kit",     price = 12500 },
          -- Complete Steering Collection
          { name = "quick_ratio_steering", label = "Quick Ratio Steering",  price = 18000 },
          { name = "standard_steering",    label = "Standard Steering",     price = 12000 },
          { name = "slow_ratio_steering",  label = "Slow Ratio Steering",   price = 3750 },
          { name = "race_steering",        label = "Race Steering",         price = 12500 },
          -- Complete Suspension Collection
          { name = "street_suspension",    label = "Street Suspension",     price = 3750 },
          { name = "sport_suspension",     label = "Sport Suspension",      price = 12500 },
        },
      },
      {
        name = "OneLife Mech Parts Bin 3",
        coords = vector3(1148.99, -794.73, 57.61),
        job = 'olrpmechanic',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 113, g = 182, b = 227, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Complete Performance Collection
          { name = "race_suspension",      label = "Race Suspension",       price = 35000 },
          { name = "lightweight_parts",    label = "Lightweight Parts",     price = 10000 },
          { name = "carbon_fiber_body",    label = "Carbon Fiber Body",     price = 22500 },
          { name = "street_spoiler",       label = "Street Spoiler",        price = 12000 },
          { name = "race_wing",            label = "Race Wing",             price = 12500 },
          -- Complete Tyres Collection
          { name = "slick_tyres",          label = "Slick Tyres",           price = 12500 },
          { name = "semi_slick_tyres",     label = "Semi Slick Tyres",      price = 12500 },
          { name = "offroad_tyres",        label = "Offroad Tyres",         price = 12500 },
          { name = "ceramic_brakes",       label = "Ceramic Brakes",        price = 22500 },
        },
      },
      {
        name = "OneLife Mech Parts Bin 4",
        coords = vector3(1126.05, -787.22, 57.6),
        job = 'olrpmechanic',
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 113, g = 182, b = 227, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Complete Basic Parts Collection
          { name = "engine_oil",            label = "Engine Oil",            price = 25 },
          { name = "tyre_replacement",      label = "Tyre Replacement",      price = 100 },
          { name = "clutch_replacement",    label = "Clutch Replacement",    price = 100 },
          { name = "air_filter",            label = "Air Filter",            price = 25 },
          { name = "spark_plug",            label = "Spark Plug",            price = 25 },
          { name = "suspension_parts",      label = "Suspension Parts",      price = 100 },
          { name = "brakepad_replacement",  label = "Brakepad Replacement",  price = 50 },
          { name = "repair_kit",            label = "Repair Kit",            price = 100 },
          { name = "cleaning_kit",          label = "Cleaning Kit",          price = 25 },
          { name = "mechanic_tablet",       label = "Mechanic Tablet",       price = 100 },
        },
      },
    }
  },

  police = {
    type = "public",
    job = "police",
    jobManagementRanks = {0},
    logo = "ls_customs.png",
    commission = 0, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(458.92, -1020.1, 24.5),
        size = 3.0,
        showBlip = false,
      },
      {
        coords = vector3(278.22, 6667.82, 29.59),
        size = 3.0,
        showBlip = false,
      },
      {
        coords = vector3(259.75, 6663.1, 29.6),
        size = 3.0,
        showBlip = false,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 1500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 1500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 1100, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 375, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 1250, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 1500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 1500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 2250, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 1250, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 250, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 1100, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps      = { enabled = true, requiresItem = true },
      engineSounds     = { enabled = true, requiresItem = true },
      drivetrains      = { enabled = true, requiresItem = true },
      turbocharging    = { enabled = true, requiresItem = true },
      tyres            = { enabled = true, requiresItem = true },
      brakes           = { enabled = true, requiresItem = true },
      driftTuning      = { enabled = true, requiresItem = true },
      gearboxes        = { enabled = true, requiresItem = true },
      raceTuning       = { enabled = true, requiresItem = true },
      steeringRack     = { enabled = true, requiresItem = true },
      suspension       = { enabled = true, requiresItem = true },
      weightReduction  = { enabled = true, requiresItem = true },
      aerodynamics     = { enabled = true, requiresItem = true },
      transmissions    = { enabled = true, requiresItem = true },
      differentials    = { enabled = true, requiresItem = true },
      ecuTuning        = { enabled = true, requiresItem = true },
      cooling          = { enabled = true, requiresItem = true },
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(261.49, 6671.11, 33.32),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil",          label = "Engine Oil",           price = 25 },
          { name = "tyre_replacement",    label = "Tyre Replacement",     price = 100 },
          { name = "clutch_replacement",  label = "Clutch Replacement",   price = 100 },
          { name = "air_filter",          label = "Air Filter",           price = 25 },
          { name = "spark_plug",          label = "Spark Plug",           price = 25 },
          { name = "suspension_parts",    label = "Suspension Parts",     price = 100 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 50 },
          { name = "repair_kit",          label = "Repair Kit",           price = 100 },
          { name = "cleaning_kit",        label = "Cleaning Kit",         price = 25 },
          { name = "mechanic_tablet",     label = "Mechanic Tablet",      price = 100 },
          { name = "ev_motor",            label = "EV Motor",             price = 375 },
          { name = "ev_battery",          label = "EV Battery",           price = 1000 },
          { name = "ev_coolant",          label = "EV Coolant",           price = 250 },
          { name = "exhaust_system",      label = "Exaust System",        price = 1250 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(263.61, 6668.1, 33.32),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "harness",             label = "Racing Harness",      price = 100 },
          { name = "ceramic_brakes",      label = "Ceramic Brakes",      price = 22500 },
          { name = "cosmetic_part",       label = "Body Kit",            price = 250 },
          { name = "performance_part",    label = "Performance Part",    price = 1000 },
          { name = "respray_kit",         label = "Respray Kit",         price = 250 },
          { name = "lighting_controller", label = "Lighting Controller", price = 75 },
          { name = "stancing_kit",        label = "Stance Kit",          price = 75 },
          { name = "vehicle_wheels",      label = "Vehicle Wheels Set",  price = 75 },
          { name = "tyre_smoke_kit",      label = "Tyre Smoke Kit",      price = 25 },
          { name = "extras_kit",          label = "Extras Kit",          price = 50 },
          { name = "nitrous_bottle",      label = "Nitrous Bottle",      price = 1000 },
          { name = "nitrous_install_kit", label = "Nitrous Install Kit", price = 4000 },
          { name = "slick_tyres",         label = "Slick Tyres",         price = 12500 },
          { name = "semi_slick_tyres",    label = "Semi Slick Tyres",    price = 12500 },
          { name = "offroad_tyres",       label = "Offroad Tyres",       price = 12500 },
          { name = "drift_tuning_kit",    label = "Drift Tuning Kit",    price = 30000 },
          { name = "i4_engine",           label = "I4 Engine",           price = 3750 },
          { name = "v6_engine",           label = "V6 Engine",           price = 27500 },
          { name = "v8_engine",           label = "V8 Engine",           price = 32500 },
          { name = "v12_engine",          label = "V12 Engine",          price = 50000 },
          { name = "turbocharger",        label = "Turbo",               price = 27500 },
          { name = "ev_motor",            label = "EV Motor",            price = 1000 },
          { name = "ev_battery",          label = "EV Battery",          price = 100 },
          { name = "ev_coolant",          label = "EV Coolant",          price = 100 },
          { name = "awd_drivetrain",      label = "AWD Drivetrain",      price = 25000 },
          { name = "rwd_drivetrain",      label = "RWD Drivetrain",      price = 25000 },
          { name = "fwd_drivetrain",      label = "FWD Drivetrain",      price = 25000 },
          { name = "manual_gearbox",      label = "Manual Gearbox",      price = 10000 },
          { name = "drag_tuning_kit",     label = "Drag Tuning Kit",     price = 22500 },
          { name = "street_race_tuning_kit", label = "Street Race Tuning Kit", price = 10000 },
          { name = "cruise_tuning_kit",   label = "Cruise Tuning Kit",   price = 12500 },
          { name = "quick_ratio_steering", label = "Quick Ratio Steering", price = 9000 },
          { name = "standard_steering",   label = "Standard Steering",   price = 6000 },
          { name = "slow_ratio_steering", label = "Slow Ratio Steering", price = 7500 },
          { name = "race_steering",       label = "Race Steering",       price = 12500 },
          { name = "4stroke_engine",      label = "4-Stroke Engine",     price = 7500 },
          { name = "5stroke_engine",      label = "5-Stroke Engine",     price = 12500 },
          { name = "inline6_engine",      label = "6-Cylinder Inline Engine", price = 10000 },
          { name = "v10_engine",          label = "V10 Engine",          price = 42500 },
          { name = "street_suspension",   label = "Street Suspension",   price = 7500 },
          { name = "sport_suspension",    label = "Sport Suspension",    price = 12500 },
          { name = "race_suspension",     label = "Race Suspension",     price = 17500 },
          { name = "lightweight_parts",   label = "Lightweight Parts",   price = 10000 },
          { name = "carbon_fiber_body",   label = "Carbon Fiber Body",   price = 22500 },
          { name = "street_spoiler",      label = "Street Spoiler",      price = 6000 },
          { name = "race_wing",           label = "Race Wing",           price = 12500 },
          { name = "6speed_manual",       label = "6-Speed Manual",      price = 9000 },
          { name = "8speed_auto",         label = "8-Speed Automatic",   price = 11000 },
          { name = "lsd_differential",    label = "Limited Slip Differential", price = 10000 },
          { name = "race_differential",   label = "Race Differential",   price = 17500 },
          { name = "stage1_ecu",          label = "Stage 1 ECU",         price = 7500 },
          { name = "stage2_ecu",          label = "Stage 2 ECU",         price = 12500 },
          { name = "performance_radiator", label = "Performance Radiator", price = 4000 },
          { name = "race_intercooler",    label = "Race Intercooler",    price = 7500 },
        },
      }
    },
    stashes = {
      {
        name = "Parts Bin",
        coords = vector3(266.65, 6669.22, 29.96),
        size = 1.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 20,
        weight = 100000,
        items = {
          -- Police Basic Parts
          { name = "engine_oil",            label = "Engine Oil",            price = 25 },
          { name = "tyre_replacement",      label = "Tyre Replacement",      price = 100 },
          { name = "clutch_replacement",    label = "Clutch Replacement",    price = 100 },
          { name = "air_filter",            label = "Air Filter",            price = 25 },
          { name = "spark_plug",            label = "Spark Plug",            price = 25 },
          { name = "suspension_parts",      label = "Suspension Parts",      price = 100 },
          { name = "brakepad_replacement",  label = "Brakepad Replacement",  price = 50 },
          { name = "repair_kit",            label = "Repair Kit",            price = 100 },
          { name = "cleaning_kit",          label = "Cleaning Kit",          price = 25 },
          { name = "mechanic_tablet",       label = "Mechanic Tablet",       price = 100 },
          { name = "ev_motor",              label = "EV Motor",              price = 375 },
          { name = "ev_battery",            label = "EV Battery",            price = 1000 },
          { name = "ev_coolant",            label = "EV Coolant",            price = 250 },
          { name = "exhaust_system",        label = "Exhaust System",        price = 1250 },
          { name = "harness",               label = "Racing Harness",        price = 100 },
          { name = "ceramic_brakes",        label = "Ceramic Brakes",        price = 1000 },
          { name = "cosmetic_part",         label = "Body Kit",              price = 250 },
          { name = "performance_part",      label = "Performance Part",      price = 1000 },
          { name = "respray_kit",           label = "Respray Kit",           price = 250 },
          { name = "lighting_controller",   label = "Lighting Controller",   price = 75 },
        },
      },
      {
        name = "Perfomance",
        coords = vector3(280.92, 6668.75, 29.96),
        size = 1.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 20,
        weight = 100000,
        items = {
          -- Police Performance Parts
          { name = "stancing_kit",          label = "Stance Kit",            price = 75 },
          { name = "vehicle_wheels",        label = "Vehicle Wheels Set",    price = 75 },
          { name = "tyre_smoke_kit",        label = "Tyre Smoke Kit",        price = 25 },
          { name = "extras_kit",            label = "Extras Kit",            price = 50 },
          { name = "nitrous_bottle",        label = "Nitrous Bottle",        price = 1000 },
          { name = "nitrous_install_kit",   label = "Nitrous Install Kit",   price = 4000 },
          { name = "slick_tyres",           label = "Slick Tyres",           price = 250 },
          { name = "semi_slick_tyres",      label = "Semi Slick Tyres",      price = 250 },
          { name = "offroad_tyres",         label = "Offroad Tyres",         price = 250 },
          { name = "drift_tuning_kit",      label = "Drift Tuning Kit",      price = 1000 },
          { name = "turbocharger",          label = "Turbo",                 price = 1000 },
          { name = "awd_drivetrain",        label = "AWD Drivetrain",        price = 1000 },
          { name = "rwd_drivetrain",        label = "RWD Drivetrain",        price = 1000 },
          { name = "fwd_drivetrain",        label = "FWD Drivetrain",        price = 1000 },
          { name = "manual_gearbox",        label = "Manual Gearbox",        price = 10000 },
          { name = "4stroke_engine",        label = "4-Stroke Engine",       price = 3750 },
          { name = "5stroke_engine",        label = "5-Stroke Engine",       price = 12500 },
          { name = "v6_engine",             label = "V6 Engine",             price = 27500 },
          { name = "v8_engine",             label = "V8 Engine",             price = 32500 },
          { name = "v12_engine",            label = "V12 Engine",            price = 12500 },
        },
      },
      {
        name = "Body Parts",
        coords = vector3(279.04, 6671.24, 29.96),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 10,
        weight = 50000,
        items = {
          -- Police Body Parts
          { name = "cosmetic_part",         label = "Body Kit",              price = 250 },
          { name = "performance_part",      label = "Performance Part",      price = 1000 },
          { name = "respray_kit",           label = "Respray Kit",           price = 250 },
          { name = "lighting_controller",   label = "Lighting Controller",   price = 75 },
          { name = "stancing_kit",          label = "Stance Kit",            price = 75 },
          { name = "vehicle_wheels",        label = "Vehicle Wheels Set",    price = 75 },
          { name = "tyre_smoke_kit",        label = "Tyre Smoke Kit",        price = 25 },
          { name = "extras_kit",            label = "Extras Kit",            price = 50 },
          { name = "nitrous_bottle",        label = "Nitrous Bottle",        price = 1000 },
          { name = "nitrous_install_kit",   label = "Nitrous Install Kit",   price = 4000 },
        },
      },
    }
  },
  
}

-- Add electric vehicles to disable combustion engine features
-----------------------------------------------------------------------
-- PLEASE NOTE: In b3258 (Bottom Dollar Bounties) and newer, electric
-- vehicles are detected automatically, so this list is not used! 
Config.ElectricVehicles = {
  "Airtug",     "buffalo5",   "caddy",
  "Caddy2",     "caddy3",     "coureur",
  "cyclone",    "cyclone2",   "imorgon",
  "inductor",   "iwagen",     "khamelion",
  "metrotrain", "minitank",   "neon",
  "omnisegt",   "powersurge", "raiden",
  "rcbandito",  "surge",      "tezeract",
  "virtue",     "vivanite",   "voltic",
  "voltic2",
}

-- Nerd options
Config.DisableSound = false
Config.AutoRunSQL = true
Config.Debug = false
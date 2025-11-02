-- Dusa Garage Management System - Shared Configuration
-- Version: 1.0.0

Config = Config or {}

-- Debug system configuration
Config.Debug = {
    -- Master debug enable/disable
    Enabled = true,

    -- Minimum log level to display (ERROR, WARN, INFO, DEBUG)
    MinLevel = "DEBUG",

    -- Default enabled topics for development
    DefaultTopics = {
        ["garage-creation"] = false,    -- New garage creation features (current focus)
        ["user-management"] = true,   -- User access control
        ["vehicle-operations"] = true, -- Vehicle park/spawn operations
        ["bridge-integration"] = true, -- Framework integration
        ["database"] = true,          -- Database operations
        ["ui-interactions"] = true,   -- NUI callbacks
        ["zone-management"] = true,   -- Garage zones
        ["api"] = true,              -- Server API endpoints
        ["validation"] = true,       -- Input validation
        ["system"] = true,             -- Core system operations
        ["job-vehicles"] = true,       -- Job vehicles
        ["presets"] = true,             -- Presets debugging
        ["garage-deletion"] = true,     -- Garage deletion
        ["garage-edit"] = true,         -- Garage edit
        ["mileage-tracking"] = true,    -- Mileage tracking
        ["vehicle-transfer"] = true,    -- Vehicle transfer operations (Story 2.1)
        ["repair-system"] = true,       -- Repair & Refuel system (Car Repair Service)
        ["garage-debug"] = true,        -- Garage debug
        ["vehicle-colors"] = true,      -- Vehicle colors
        ["impound"] = true,             -- Impound
        ["admin-editor"] = true,        -- Admin editor
        ["vehicle-hover"] = true,       -- Vehicle hover and raycast system (Story 2.3)
    }
}

-- Resource information
Config.ResourceName = GetCurrentResourceName()
Config.Version = "1.0.0"

-- Default garage settings
Config.DefaultSettings = {
    MaxVehicles = 50,   -- Maximum vehicles per garage (for display purposes)
}

-- Pricing configuration (Story 2.1)
Config.Prices = Config.Prices or {}

-- Vehicle Transfer Pricing (Story 2.1, extensible for Story 2.2)
Config.Prices.vehicleTransfer = {
    enabled = true,              -- Enable/disable transfer feature
    feeType = "flat",            -- "flat" or "distance" (distance for Story 2.2)
    flatFee = 5000,              -- Flat transfer fee (currency units)
    accountType = "bank",        -- "bank" or "cash" - where to deduct from

    -- Future enhancement (Story 2.2):
    -- distanceBaseFee = 1000,      -- Base fee for distance-based pricing
    -- distancePerMeter = 0.5,      -- Additional cost per meter distance
}

-- Vehicle Repair & Refuel Configuration (Car Repair Service)
Config.Prices.repair = {
    enabled = true,              -- Enable/disable repair feature
    accountType = "bank",        -- "bank" or "cash" - where to deduct from

    -- Part-based repair pricing (extensible for future per-part repairs)
    parts = {
        engine = {
            cost = 500,          -- Base cost for engine repair
            bone = "engine",     -- Vehicle bone name for 3D tracking
            displayName = "Engine"
        },
        tires = {
            cost = 300,          -- Base cost for tire repair
            bones = {"wheel_lf", "wheel_rf", "wheel_lr", "wheel_rr"}, -- All wheel bones
            displayName = "Tires"
        },
        body = {
            cost = 400,          -- Base cost for body repair
            bone = "bodyshell",  -- Vehicle body bone
            displayName = "Car Body"
        }
    },

    -- Pricing calculation method
    -- "fixed" = Fixed price regardless of damage
    -- "percentage" = Price based on damage percentage (damage% * baseCost)
    pricingMethod = "percentage",

    -- Full repair discount (if repairing all parts at once)
    fullRepairDiscount = 0.0,    -- 0% discount for now (can be 0.1 for 10% discount)
}

-- Fuel refill configuration
Config.Prices.fuel = {
    enabled = true,              -- Enable/disable fuel refill feature
    accountType = "bank",        -- "bank" or "cash" - where to deduct from
    pricePerLiter = 2,           -- Price per liter of fuel

    -- Supported fuel resources (auto-detection)
    supportedResources = {
        "ox_fuel",
        "LegacyFuel",
        "cc-fuel"
    }
}

-- Repair Showroom Configuration
Config.RepairShowroom = {
    -- Showroom spawn location (PLACEHOLDER - Set by user)
    -- This is where the vehicle will be spawned for repair inspection
    spawnCoords = vector4(228.534, -990.986, -99.424, 179.967), -- x, y, z, heading (USER MUST SET THIS)

    -- Camera settings
    camera = {
        defaultOffset = vector3(5.0, 5.0, 2.0),  -- Camera offset from vehicle (x, y, z)
        minZoom = 3.0,           -- Minimum zoom distance
        maxZoom = 15.0,          -- Maximum zoom distance
        zoomSpeed = 0.5,         -- Zoom speed multiplier
        rotationSpeed = 0.125,   -- Rotation speed multiplier (reduced by 4x)
        smoothness = 0.1,        -- Camera interpolation smoothness (lower = smoother)
        fov = 50.0,              -- Field of view
    },

    -- Part visibility settings
    partVisibility = {
        hideAngle = 90.0,        -- Hide callout when camera angle > this (degrees)
        updateInterval = 16,     -- Update interval for position tracking (ms) - ~60fps
        throttleInterval = 500,  -- Broadcast throttle when camera not moving (ms)
    },

    -- Vehicle range calculation (for fuel range estimation)
    -- Average range per full tank in km (can be vehicle-class based in future)
    defaultVehicleRange = 400,   -- 400km per full tank average
}

-- Vehicle metadata tracking
Config.VehicleTracking = {
    Enabled = true,
    MileageCalculation = true,
    HealthTracking = true,
    UpdateInterval = 30000, -- Update interval in milliseconds (30 seconds)
}

-- Job Vehicle Hot Reload Configuration
Config.JobVehicleHotReload = {
    Enabled = true,             -- Enable hot-reload functionality
    ValidateOnReload = true,    -- Validate configuration on reload
    AdminOnly = true,           -- Only admins can reload config
    NotifyPlayers = true,       -- Notify players when config is reloaded
}

-- Job Vehicle Validation Configuration
Config.JobVehicleValidation = {
    RequiredFields = {"vehicle", "displayName", "minGrade", "category", "description"},
    FieldTypes = {
        vehicle = "string",
        displayName = "string",
        minGrade = "number",
        category = "string",
        description = "string"
    },
    Constraints = {
        minGrade = {
            min = 0,
            max = 10
        }
    }
}

-- Job Vehicle Limits Configuration
Config.JobVehicleLimits = {
    MaxVehiclesPerPlayer = 3,       -- Maximum job vehicles per player
    CleanupInterval = 300000,       -- Cleanup interval in milliseconds (5 minutes)
    AbandonTimeout = 1800000,       -- Vehicle abandon timeout in milliseconds (30 minutes)
}

-- UI Settings
Config.UI = {
    DefaultLocale = "en",
    Theme = "dark",
}

-- Distance settings
Config.Distance = {
    Interaction = 3.0,  -- Distance to interact with garage
    Spawn = 5.0,        -- Distance from spawn point to place vehicle
    Parking = 2.5,      -- Distance to park vehicle
}

-- Keybinds
Config.Keys = {
    Interact = 38,      -- E key
    Cancel = 177,       -- BACKSPACE key
}

-- Real Estate Management
Config.RealEstate = {
    -- Enable real estate management features
    Enabled = true,

    -- Real estate job names and minimum grades
    Jobs = {
        ["realestate"] = { minGrade = 0 },  -- Real estate job, any grade
        ["property"] = { minGrade = 1 },    -- Property management job, grade 1+
        ["emlak"] = { minGrade = 0 },       -- Turkish real estate job
    },

    -- Real estate permissions
    Permissions = {
        -- Can create garages anywhere
        CreateGarages = true,
        -- Can edit any garage (not just owned ones)
        EditAllGarages = true,
        -- Can delete any garage
        DeleteAllGarages = true,
        -- Can manage access for any garage
        ManageAllAccess = true,
        -- Can see all garages in property management tab
        ViewAllGarages = true,
    }
}

-- Vehicle Impound System Configuration
Config.Impound = {
    -- Enable impound system
    Enabled = true,

    -- Jobs allowed to impound vehicles
    AllowedJobs = {
        "police",
        "sheriff",
        "tow",
        "towtruck",
        "mechanic"
    },

    -- Default impound settings
    DefaultDuration = 24,  -- Default hours for temporary impounds
    MaxDuration = 720,     -- Maximum hours (30 days)
    MinDuration = 1,       -- Minimum hours
}
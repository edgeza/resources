-- Dusa Garage Management System - Mileage Tracking Module Configuration
-- Version: 1.0.0
-- Configurable settings for mileage tracking system

MileageConfig = {
    enabled = true,  -- Master switch for entire module

    -- Tracking settings
    tracking = {
        updateInterval = 1000,        -- Position check interval (ms)
        serverSyncInterval = 300000,  -- Database sync interval (5 minutes)
        minSpeed = 5.0,               -- Minimum speed (km/h) to track
        excludedVehicleClasses = {13, 14, 15, 16, 17, 21}  -- Bikes, boats, helicopters, planes, trains
    },

    -- UI settings (optional)
    ui = {
        enabled = true,               -- Show odometer UI
        displayMode = "first_person", -- "show_on_enter" | "always" | "first_person"
        showDuration = 10000,         -- Duration for "show_on_enter" mode (ms)
        unit = "kilometers",          -- "kilometers" | "miles"
        position = "bottom-right"     -- UI position
    }
}

-- Unit conversion constants
MileageConfig.CONVERSION = {
    KM_TO_MILES = 0.621371,   -- 1 km = 0.621371 miles
    MILES_TO_KM = 1.60934     -- 1 mile = 1.60934 km
}

return MileageConfig

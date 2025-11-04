-- Dusa Garage Management System - Server Configuration
-- Version: 1.0.0
Config = Config or {}
-- Server-specific configuration
Config.Server = Config.Server or {}

-- Database settings
Config.Server.Database = {
    AutoMigrate = true,        -- Automatically run database migrations
    BackupOnStart = false,     -- Create backup on resource start
    CleanupInterval = 3600000, -- Cleanup expired car meets every hour (ms)
}

-- Performance settings
Config.Server.Performance = {
    MaxConcurrentQueries = 10,     -- Maximum concurrent database queries
    QueryTimeout = 5000,           -- Query timeout in milliseconds
    CacheVehicleData = true,       -- Cache vehicle metadata for performance
    CacheExpiry = 300000,          -- Cache expiry time in milliseconds (5 minutes)
}

-- Car meet settings
Config.Server.CarMeets = {
    MaxActiveMeets = 10,           -- Maximum number of active car meets
    DefaultDuration = 7200,        -- Default duration in seconds (2 hours)
    MaxDuration = 28800,           -- Maximum duration in seconds (8 hours)
    CleanupExpired = true,         -- Automatically cleanup expired meets
}

-- Security settings
Config.Server.Security = {
    ValidateVehicleOwnership = true,  -- Validate vehicle ownership before operations
    LogTransactions = true,           -- Log all vehicle transactions
    RateLimiting = {
        Enabled = true,
        MaxRequests = 10,             -- Max requests per player per interval
        Interval = 60000,             -- Rate limit interval in milliseconds (1 minute)
    }
}

-- Webhook settings (optional)
Config.Server.Webhooks = {
    Enabled = false,
    VehicleTransfer = "",          -- Webhook URL for vehicle transfers
    CarMeetCreated = "",           -- Webhook URL for car meet creation
    SecurityAlert = "",            -- Webhook URL for security alerts
}
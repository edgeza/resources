-- Finances Optimization Configuration
-- This file contains settings for the optimized finances system

Config.Finances = {
    -- Pagination settings
    DefaultPageSize = 20,           -- Number of accounts to load per page
    MaxPageSize = 50,               -- Maximum accounts per page to prevent abuse
    MaxTransactionsPerPlayer = 50,  -- Maximum transactions to load per player
    
    -- Caching settings
    CacheExpiry = 3600000,         -- Cache expiry time in milliseconds (1 hour)
    AutoClearCache = true,          -- Automatically clear cache every hour
    ClearCacheOnUpdate = true,      -- Clear cache when accounts are updated
    
    -- Performance settings
    EnablePagination = true,        -- Enable pagination to reduce load
    EnableCaching = true,           -- Enable caching to improve performance
    EnableTransactionLimits = true, -- Limit transactions per player
    
    -- Debug settings
    EnableDebugLogs = true,         -- Enable debug logging
    LogCacheHits = true,           -- Log when cache is used
    LogPerformanceMetrics = true,   -- Log performance metrics
    
    -- UI settings
    ShowLoadingIndicator = true,    -- Show loading indicator during data fetch
    ShowPaginationControls = true,  -- Show pagination controls in UI
    ShowRefreshButton = true,       -- Show refresh button in UI
}

-- Function to get configuration value with fallback
function Config.Finances.get(key, defaultValue)
    return Config.Finances[key] or defaultValue
end

-- Function to check if optimization is enabled
function Config.Finances.isOptimized()
    return Config.Finances.EnablePagination and Config.Finances.EnableCaching
end

print('[p_dojmdt] Debug: Finances configuration loaded') 
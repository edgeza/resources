-- ==============================================
-- OLRP NPC DENSITY - CLIENT SIDE
-- ==============================================
-- Dynamic NPC density system that adjusts based on player count
-- Uses native functions directly for immediate effect
-- ==============================================

local currentDensity = nil
local lastPlayerCount = nil
local isInitialized = false
local targetDensity = 0.0

-- Calculate density based on player count
-- Returns density value between Config.LowDensity and Config.HighDensity
local function CalculateDensity(playerCount)
    -- If disabled, return 0 to completely disable NPCs
    if not Config.Enabled then
        return 0.0
    end
    
    -- Ensure player count is valid
    playerCount = math.max(0, playerCount or 0)
    
    -- 1-10 players: use high density
    if playerCount <= Config.LowPlayerThreshold then
        return Config.HighDensity
    -- 100+ players: use low density
    elseif playerCount >= Config.HighPlayerThreshold then
        return Config.LowDensity
    else
        -- Between 10 and 100: linear interpolation
        local range = Config.HighPlayerThreshold - Config.LowPlayerThreshold
        local progress = (playerCount - Config.LowPlayerThreshold) / range
        local densityRange = Config.HighDensity - Config.LowDensity
        local density = Config.HighDensity - (progress * densityRange)
        
        -- Ensure density is within valid bounds (0.0 to 1.0)
        return math.max(Config.LowDensity, math.min(Config.HighDensity, density))
    end
end

-- Update target density based on player count (called periodically)
local function UpdateTargetDensity()
    if not Config.Enabled then
        -- Immediately set to 0 when disabled
        targetDensity = 0.0
        currentDensity = 0.0
        if Config.Debug then
            print('[OLRP NPC] System disabled - density set to 0.0')
        end
        return
    end
    
    -- Get current player count from GlobalState
    local playerCount = GlobalState.PlayerCount or 0
    local newDensity = CalculateDensity(playerCount)
    
    -- Only update if density changed or player count changed
    if targetDensity ~= newDensity or lastPlayerCount ~= playerCount then
        targetDensity = newDensity
        lastPlayerCount = playerCount
        currentDensity = newDensity
        
        if Config.Debug then
            print(string.format('[OLRP NPC] Updated target density to %.2f for %d players', newDensity, playerCount))
        end
    end
end

-- Main thread that applies density every frame (CRITICAL for NPC control)
-- This must run every frame to override any other scripts
CreateThread(function()
    -- Wait for qbx_core to be ready and GlobalState to initialize
    Wait(2000)
    
    -- Initial check
    local playerCount = GlobalState.PlayerCount or 0
    UpdateTargetDensity()
    isInitialized = true
    
    if Config.Debug then
        print(string.format('[OLRP NPC] System initialized with %d players, density: %.2f', playerCount, targetDensity))
    end
    
    -- Apply density every frame - THIS IS CRITICAL
    -- This loop runs every frame to ensure our density settings override any other scripts
    while true do
        -- Check if disabled first (priority check)
        if not Config.Enabled then
            targetDensity = 0.0
        end
        
        -- Clamp density to valid range (0.0 to 1.0)
        local density = math.max(0.0, math.min(1.0, targetDensity))
        
        -- Apply density multipliers every frame
        -- These must be set every frame to override other scripts (including qbx_density)
        -- IMPORTANT: These native functions must be called every frame to work
        SetPedDensityMultiplierThisFrame(density)
        SetScenarioPedDensityMultiplierThisFrame(density, density)
        SetVehicleDensityMultiplierThisFrame(density)
        SetRandomVehicleDensityMultiplierThisFrame(density)
        SetParkedVehicleDensityMultiplierThisFrame(density)
        
        -- Also update qbx_density if available (for compatibility and to keep it in sync)
        -- This ensures qbx_density's internal values match our settings
        if GetResourceState('qbx_density') == 'started' then
            exports.qbx_density:SetDensity('peds', density)
            exports.qbx_density:SetDensity('scenario', density)
            exports.qbx_density:SetDensity('vehicle', density)
            exports.qbx_density:SetDensity('randomvehicles', density)
            exports.qbx_density:SetDensity('parked', density)
        end
        
        -- Wait 0ms = every frame (most responsive)
        -- This ensures our density settings are applied continuously
        Wait(0)
    end
end)

-- Thread to monitor player count and update target density periodically
CreateThread(function()
    Wait(2000) -- Wait for initialization
    
    -- Continuous monitoring
    while true do
        UpdateTargetDensity()
        -- Check player count every update interval
        Wait(Config.UpdateInterval)
    end
end)

-- Listen for player count changes via state bag (real-time updates)
AddStateBagChangeHandler('PlayerCount', '', function(bagName, key, value)
    if value and isInitialized then
        UpdateTargetDensity()
    end
end)

-- Resource start event - initialize when resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        -- Initialize density on resource start
        Wait(1000) -- Give qbx_core time to initialize
        UpdateTargetDensity()
        isInitialized = true
        
        if Config.Debug then
            local playerCount = GlobalState.PlayerCount or 0
            print(string.format('[OLRP NPC] Resource started. Initial player count: %d, density: %.2f', playerCount, targetDensity))
        end
    end
end)

-- Export function for external use
exports('GetCurrentDensity', function()
    return currentDensity or targetDensity
end)

exports('GetCurrentPlayerCount', function()
    return lastPlayerCount or (GlobalState.PlayerCount or 0)
end)

-- Export to manually set density (override player count calculation)
exports('SetDensity', function(density)
    if type(density) == 'number' and density >= 0.0 and density <= 1.0 then
        targetDensity = density
        currentDensity = density
        if Config.Debug then
            print(string.format('[OLRP NPC] Density manually set to %.2f', density))
        end
    end
end)

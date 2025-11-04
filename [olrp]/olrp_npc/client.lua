-- ==============================================
-- OLRP NPC DENSITY - CLIENT SIDE
-- ==============================================
-- Dynamic NPC density system that adjusts based on player count
-- ==============================================

local currentDensity = nil
local lastPlayerCount = nil
local isInitialized = false

-- Calculate density based on player count
-- Returns density value between Config.LowDensity and Config.HighDensity
local function CalculateDensity(playerCount)
    -- If disabled, return nil to skip updates
    if not Config.Enabled then
        return nil
    end
    
    -- Ensure player count is valid
    playerCount = math.max(0, playerCount or 0)
    
    -- 1-10 players: use high density (0.75)
    if playerCount <= Config.LowPlayerThreshold then
        return Config.HighDensity
    -- 100+ players: use low density (0.25)
    elseif playerCount >= Config.HighPlayerThreshold then
        return Config.LowDensity
    else
        -- Between 10 and 100: linear interpolation
        -- Formula: density = HighDensity - ((players - LowThreshold) / (HighThreshold - LowThreshold)) * (HighDensity - LowDensity)
        local range = Config.HighPlayerThreshold - Config.LowPlayerThreshold
        local progress = (playerCount - Config.LowPlayerThreshold) / range
        local densityRange = Config.HighDensity - Config.LowDensity
        local density = Config.HighDensity - (progress * densityRange)
        
        -- Ensure density is within valid bounds (0.0 to 1.0)
        return math.max(Config.LowDensity, math.min(Config.HighDensity, density))
    end
end

-- Update NPC density using qbx_density export
local function UpdateNPCDensity(playerCount)
    local newDensity = CalculateDensity(playerCount)
    
    -- Only update if density changed or player count changed
    if newDensity and (currentDensity ~= newDensity or lastPlayerCount ~= playerCount) then
        currentDensity = newDensity
        lastPlayerCount = playerCount
        
        -- Check if qbx_density resource is available
        if GetResourceState('qbx_density') == 'started' then
            -- Update both peds and scenario NPCs
            exports.qbx_density:SetDensity('peds', newDensity)
            exports.qbx_density:SetDensity('scenario', newDensity)
            
            if Config.Debug then
                print(string.format('[OLRP NPC] Updated density to %.2f for %d players', newDensity, playerCount))
            end
        else
            if Config.Debug then
                print('[OLRP NPC] Warning: qbx_density resource not found or not started')
            end
        end
    end
end

-- Main thread to monitor player count and update density
CreateThread(function()
    -- Wait for qbx_core to be ready and GlobalState to initialize
    Wait(2000)
    
    -- Initial check
    if Config.Enabled then
        local playerCount = GlobalState.PlayerCount or 0
        UpdateNPCDensity(playerCount)
        isInitialized = true
        
        if Config.Debug then
            print(string.format('[OLRP NPC] System initialized with %d players', playerCount))
        end
    end
    
    -- Continuous monitoring
    while true do
        if Config.Enabled then
            -- Get current player count from GlobalState
            local playerCount = GlobalState.PlayerCount or 0
            
            -- Update NPC density based on player count
            UpdateNPCDensity(playerCount)
        end
        
        -- Wait for next update interval
        Wait(Config.UpdateInterval)
    end
end)

-- Listen for player count changes via state bag (real-time updates)
AddStateBagChangeHandler('PlayerCount', '', function(bagName, key, value)
    if Config.Enabled and value and isInitialized then
        UpdateNPCDensity(value)
    end
end)

-- Resource start event - initialize when resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        -- Initialize density on resource start
        Wait(1000) -- Give qbx_core time to initialize
        local playerCount = GlobalState.PlayerCount or 0
        UpdateNPCDensity(playerCount)
        isInitialized = true
        
        if Config.Debug then
            print(string.format('[OLRP NPC] Resource started. Initial player count: %d', playerCount))
        end
    end
end)

-- Export function for external use
exports('GetCurrentDensity', function()
    return currentDensity
end)

exports('GetCurrentPlayerCount', function()
    return lastPlayerCount or (GlobalState.PlayerCount or 0)
end)

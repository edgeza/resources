-- Dusa Bridge Client Integration
-- Simple client-side initialization that leverages Dusa Bridge's automatic detection

BridgeEvents = {}
local bridgeInitialized = false
local frameworkReady = false

-- Check framework readiness specifically for client
function CheckFrameworkReady()
    if frameworkReady then return end

    -- Dusa Bridge provides a unified Framework object
    -- TriggerEvent('table', Framework.Player)
    if Framework and Framework.Player then
        local playerData = Framework.Player
        if playerData and playerData.Identifier then
            frameworkReady = true
        end
    end
end

-- Initialize bridge status check
CreateThread(function()
    -- Wait a moment for player to be fully loaded
    Wait(1000)

    -- Dusa Bridge automatically provides Bridge, Framework, Inventory, Target objects
    if Bridge and Framework then
        bridgeInitialized = true

        -- Check framework readiness
        CheckFrameworkReady()
    else
        print(("[%s] ERROR: Dusa Bridge objects not available (Client)"):format(GetCurrentResourceName()))
    end
end)

-- Wait for bridge and framework - simplified for Dusa Bridge
function BridgeEvents.WaitForBridgeAndFramework(callback, timeout)
    if Bridge and Framework then
        -- Everything already ready
        if callback then callback(true, Bridge, Framework) end
        return
    end

    -- Dusa Bridge should be available quickly, but add fallback
    local attempts = 0
    local maxAttempts = (timeout or 10000) / 100

    CreateThread(function()
        while attempts < maxAttempts do
            if Bridge and Framework then
                bridgeInitialized = true
                CheckFrameworkReady()

                if frameworkReady then
                    if callback then callback(true, Bridge, Framework) end
                    return
                end
            end

            attempts = attempts + 1
            Wait(100)
        end

        print(("[%s] ERROR: Dusa Bridge or Framework initialization timeout"):format(GetCurrentResourceName()))
        if callback then callback(false, "Bridge or Framework initialization timeout") end
    end)
end

-- Check if everything is ready
function BridgeEvents.IsReady()
    return Bridge ~= nil and Framework ~= nil and frameworkReady
end

-- Get bridge and framework objects safely
function BridgeEvents.GetObjects()
    if bridgeInitialized and frameworkReady then
        return Bridge, Framework
    end
    return nil, nil
end

-- Get framework object safely
function BridgeEvents.GetFramework()
    return Framework
end

-- Get inventory object safely
function BridgeEvents.GetInventory()
    return Inventory
end

-- Get target object safely
function BridgeEvents.GetTarget()
    return Target
end

-- Listen for framework player loaded events to trigger readiness check
CreateThread(function()
    -- Universal framework events - Dusa Bridge handles the specifics
    RegisterNetEvent('esx:playerLoaded', function()
        Wait(500)
        CheckFrameworkReady()
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        Wait(500)
        CheckFrameworkReady()
    end)

    RegisterNetEvent('qbx:playerLoaded', function()
        Wait(500)
        CheckFrameworkReady()
    end)

    -- Periodic check for framework readiness
    while true do
        Wait(2000)
        if bridgeInitialized and not frameworkReady then
            CheckFrameworkReady()
        end
    end
end)

return BridgeEvents
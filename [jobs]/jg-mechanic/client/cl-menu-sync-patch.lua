-- Patch to fix vehicle position synchronization when menu opens
-- This ensures the vehicle position is properly synced to all players
-- Issue: When menu opens, car goes through floor for other players due to sync issues

local function ensureVehicleGroundSync(vehicle)
    if not vehicle or vehicle == 0 or not DoesEntityExist(vehicle) then return false end
    
    -- Only sync if we own the vehicle or it's networked
    if not NetworkGetEntityIsNetworked(vehicle) then return false end
    
    local owner = NetworkGetEntityOwner(vehicle)
    -- Only handle sync if we're the owner
    if owner ~= cache.playerId then return false end
    
    -- Get current position
    local coords = GetEntityCoords(vehicle)
    
    -- Validate position is reasonable (not underground or in invalid location)
    if coords.z < -100.0 or coords.z > 2000.0 then
        -- Position is clearly invalid, don't try to fix it
        return false
    end
    
    -- Find proper ground Z coordinate
    local groundZ = coords.z
    local found, groundZResult = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, groundZ, false)
    
    if found then
        groundZ = groundZResult
    else
        -- Fallback: try a wider search
        found, groundZResult = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z + 10.0, groundZ, false)
        if found then
            groundZ = groundZResult
        else
            -- If we can't find ground, don't move the vehicle (might be in MLO or valid location)
            return false
        end
    end
    
    -- Validate ground Z is reasonable
    if groundZ < -100.0 or groundZ > 2000.0 or math.abs(groundZ - coords.z) > 50.0 then
        -- Ground Z is invalid or too far from current position (likely in MLO or special location)
        return false
    end
    
    -- Only adjust if vehicle is significantly below ground (more than 0.5 units)
    if coords.z < groundZ - 0.5 then
        -- Use network-safe coordinate setting
        SetEntityCoords(vehicle, coords.x, coords.y, groundZ + 0.1, false, false, false, true)
        
        -- Light network sync (don't use SetNetworkIdExistsOnAllMachines as it can cause despawns)
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        if netId then
            -- Allow blending for better sync
            NetworkSetEntityCanBlendWhenInvisible(vehicle, true)
        end
        
        return true
    end
    
    return false
end

-- Monitor for menu opening - when vehicle is frozen (menu is typically open)
CreateThread(function()
    local lastFrozenState = {}
    local syncAttempts = {} -- Track sync attempts to prevent spam
    
    while true do
        Wait(200) -- Reduced frequency to prevent performance issues
        
        local vehicle = cache.vehicle
        if vehicle and vehicle ~= 0 and DoesEntityExist(vehicle) then
            local netId = NetworkGetNetworkIdFromEntity(vehicle)
            local isFrozen = IsEntityPositionFrozen(vehicle)
            
            -- Check if vehicle just got frozen (menu likely opened)
            if isFrozen and (not lastFrozenState[netId] or lastFrozenState[netId] == false) then
                -- Menu likely just opened, ensure proper ground sync
                Wait(200) -- Small delay to let position settle
                
                -- Only attempt sync once per freeze event
                if not syncAttempts[netId] or (GetGameTimer() - syncAttempts[netId]) > 5000 then
                    ensureVehicleGroundSync(vehicle)
                    syncAttempts[netId] = GetGameTimer()
                end
            end
            
            lastFrozenState[netId] = isFrozen
        end
    end
end)

-- Monitor vehicle position to catch any falling through floor
CreateThread(function()
    local trackedVehicles = {}
    local lastSyncTime = {}
    
    while true do
        Wait(1000) -- Check less frequently to reduce performance impact
        
        -- Only check player's vehicle to avoid interfering with other players' vehicles
        local playerVehicle = cache.vehicle
        
        if playerVehicle and playerVehicle ~= 0 and DoesEntityExist(playerVehicle) then
            local coords = GetEntityCoords(playerVehicle)
            local netId = NetworkGetNetworkIdFromEntity(playerVehicle)
            local lastZ = trackedVehicles[netId]
            local currentTime = GetGameTimer()
            
            -- Only check if vehicle is frozen (menu open) or if it dropped significantly
            local isFrozen = IsEntityPositionFrozen(playerVehicle)
            
            -- If vehicle Z coordinate dropped significantly, it might be falling through floor
            -- Only sync if it's been more than 2 seconds since last sync attempt
            if lastZ and (coords.z < lastZ - 2.0) and (not lastSyncTime[netId] or (currentTime - lastSyncTime[netId]) > 2000) then
                -- Only attempt sync if vehicle is frozen (menu likely open) or if it's really far below ground
                if isFrozen or coords.z < (lastZ - 5.0) then
                    ensureVehicleGroundSync(playerVehicle)
                    lastSyncTime[netId] = currentTime
                end
            end
            
            trackedVehicles[netId] = coords.z
        end
    end
end)

-- Network event to force sync vehicle position (can be called from server if needed)
RegisterNetEvent("jg-mechanic:client:sync-vehicle-position", function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if vehicle and vehicle ~= 0 and DoesEntityExist(vehicle) then
        ensureVehicleGroundSync(vehicle)
    end
end)

print("^2[jg-mechanic]^7 Vehicle position sync patch loaded")


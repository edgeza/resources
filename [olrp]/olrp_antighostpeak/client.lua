-- Simple Anti-Ghost Peak System
-- Prevents firing when ghost peeking

local isPlayerAiming = false
local isPlayerArmed = false
local isPlayerExempt = false
local currentWeapon = nil
local playerPed = nil
local playerId = nil

-- Initialize the system
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        playerPed = PlayerPedId()
        playerId = PlayerId()
        
        -- Check if player is exempt
        isPlayerExempt = CheckPlayerExemption()
        
        -- Update weapon status
        currentWeapon = GetCurrentPedWeaponEntityIndex(playerPed)
        isPlayerArmed = currentWeapon > 0 and Config.RequireWeapon
        
        if Config.DebugMode then
            print(string.format('[Anti-GhostPeak] Player armed: %s, Exempt: %s', tostring(isPlayerArmed), tostring(isPlayerExempt)))
        end
    end
end)

-- Main detection thread
Citizen.CreateThread(function()
    while true do
        local sleepTime = Config.IdleUpdateInterval
        
        if Config.Enabled and not isPlayerExempt and isPlayerArmed then
            local isAiming = IsPlayerFreeAiming(playerId)
            
            if isAiming then
                sleepTime = Config.UpdateInterval
                isPlayerAiming = true
                
                -- Check for ghost peak and disable shooting if detected
                if PerformGhostPeakDetection() then
                    DisablePlayerFiring(playerId, true)
                end
            else
                isPlayerAiming = false
            end
        end
        
        Citizen.Wait(sleepTime)
    end
end)

-- Core ghost peak detection function
-- Detects when player is ghost peeking (must be close to obstacle)
function PerformGhostPeakDetection()
    if not isPlayerArmed or not isPlayerAiming then
        return false
    end
    
    local cameraRotation = GetGameplayCamRot()
    local direction = ConvertRotationToDirection(cameraRotation)
    
    -- Get weapon and camera positions
    local weaponCoords = GetEntityCoords(currentWeapon)
    local cameraCoords = GetGameplayCamCoord()
    
    -- Apply height offset
    weaponCoords = vector3(weaponCoords.x, weaponCoords.y, weaponCoords.z + Config.HeightOffset)
    cameraCoords = vector3(cameraCoords.x, cameraCoords.y, cameraCoords.z + Config.HeightOffset)
    
    -- Check if player is crouching (extra strict detection)
    local isCrouching = IsPedDucking(playerPed)
    local crouchMultiplier = 1.0
    if isCrouching and Config.CrouchDetection then
        crouchMultiplier = 0.5 -- Much more strict when crouching
    end
    
    -- First check: Is player close to an obstacle? (ghost peeking requires being against something)
    local playerCoords = GetEntityCoords(playerPed)
    local nearbyHit, nearbyCoords, nearbyEntity = PerformRaycast(
        playerCoords, 
        direction, 
        Config.MaxDistanceToObstacle, 
        Config.RaycastFlags
    )
    
    -- If player is not close to any obstacle, allow shooting
    if nearbyHit == 0 or nearbyEntity == 0 then
        return false
    end
    
    local distanceToObstacle = #(playerCoords - nearbyCoords)
    local maxDistance = Config.MaxDistanceToObstacle * crouchMultiplier
    if distanceToObstacle > maxDistance then
        return false -- Player too far from obstacle, not ghost peeking
    end
    
    -- Perform weapon raycast (shorter distance to detect walls)
    local weaponHit, weaponCoordsHit, weaponEntity = PerformRaycast(
        weaponCoords, 
        direction, 
        Config.WeaponRaycastDistance, 
        Config.RaycastFlags
    )
    
    -- Perform camera raycast (much longer distance)
    local cameraHit, cameraCoordsHit, cameraEntity = PerformRaycast(
        cameraCoords, 
        direction, 
        Config.CameraRaycastDistance, 
        Config.RaycastFlags
    )
    
    -- Ghost peeking occurs when:
    -- 1. Player is close to an obstacle (already checked above)
    -- 2. Weapon hits an obstacle (weaponHit ~= 0)
    -- 3. Camera can see much further than weapon
    
    if weaponHit ~= 0 and weaponEntity ~= 0 then
        -- Weapon is blocked by something
        local weaponDistance = #(weaponCoords - weaponCoordsHit)
        local cameraDistance = Config.CameraRaycastDistance
        
        -- If camera didn't hit anything, it can see much further - definitely ghost peeking
        if cameraHit == 0 then
            return true -- Camera sees far, weapon blocked = ghost peeking
        end
        
        -- If camera hit something, check distance difference
        if cameraHit ~= 0 then
            cameraDistance = #(cameraCoords - cameraCoordsHit)
            local distanceDifference = math.abs(weaponDistance - cameraDistance)
            
            -- Apply crouch multiplier to make detection even more strict when crouching
            local strictThreshold = Config.DetectionThreshold * crouchMultiplier
            local strictWeaponDistance = 3.0 * crouchMultiplier
            local strictCameraDistance = 3.0 / crouchMultiplier
            local veryStrictWeaponDistance = 1.5 * crouchMultiplier
            local veryStrictCameraDistance = 2.0 / crouchMultiplier
            local bodyExposureMultiplier = 1.5 / crouchMultiplier
            
            -- Extremely strict: require significant distance difference
            if distanceDifference > strictThreshold then
                return true -- Camera sees significantly further than weapon
            end
            
            -- Very aggressive checks for ghost peeking (with crouch multiplier)
            if weaponDistance < strictWeaponDistance and cameraDistance > strictCameraDistance then
                return true -- Weapon close to wall, camera far = ghost peeking
            end
            
            -- Even more strict: if weapon is very close to obstacle
            if weaponDistance < veryStrictWeaponDistance and cameraDistance > veryStrictCameraDistance then
                return true -- Weapon very close to wall, camera far = ghost peeking
            end
            
            -- Force players to expose much more body - any significant difference
            if cameraDistance > weaponDistance * bodyExposureMultiplier then
                return true -- Camera sees much further than weapon = ghost peeking
            end
            
            -- Extra strict for crouching: any difference at all
            if isCrouching and cameraDistance > weaponDistance then
                return true -- When crouching, any camera advantage = ghost peeking
            end
        end
    end
    
    return false
end

-- Perform a single raycast
function PerformRaycast(origin, direction, distance, flags)
    local destination = vector3(
        origin.x + direction.x * distance,
        origin.y + direction.y * distance,
        origin.z + direction.z * distance
    )
    
    local rayHandle = StartShapeTestRay(
        origin.x, origin.y, origin.z,
        destination.x, destination.y, destination.z,
        flags or 1, -1, 1
    )
    
    local _, hit, coords, _, entity = GetShapeTestResult(rayHandle)
    return hit, coords, entity
end

-- Convert camera rotation to direction vector
function ConvertRotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    
    return {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
end

-- Check if player is exempt from detection
function CheckPlayerExemption()
    if not Config.AdminExempt then return false end
    
    -- Check if player is admin (you can customize this based on your admin system)
    local playerGroup = GetPlayerGroup(playerId)
    
    for _, group in ipairs(Config.ExemptGroups) do
        if playerGroup == group then
            return true
        end
    end
    
    -- Check exempt players list
    for _, exemptId in ipairs(Config.ExemptPlayers) do
        if playerId == exemptId then
            return true
        end
    end
    
    return false
end

-- Get player group (customize based on your admin system)
function GetPlayerGroup(playerId)
    -- This is a placeholder - implement based on your admin system
    -- Example: return exports['your_admin_system']:GetPlayerGroup(playerId)
    return 'user'
end

-- Export functions for other resources
exports('IsPlayerExempt', CheckPlayerExemption)
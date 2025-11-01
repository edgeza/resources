local QBCore = exports['qb-core']:GetCoreObject()
local patrolRoutes = {}
local activePatrols = {}

-- Initialize patrol routes
CreateThread(function()
    InitializePatrolRoutes()
end)

-- Initialize patrol routes around the military base
function InitializePatrolRoutes()
    local center = Config.MilitaryBase.center
    local radius = Config.MilitaryBase.radius
    
    -- Create multiple patrol routes
    patrolRoutes = {
        -- Route 1: Perimeter patrol
        {
            name = "perimeter_patrol",
            points = {
                vector3(center.x + radius * 0.8, center.y, center.z),
                vector3(center.x, center.y + radius * 0.8, center.z),
                vector3(center.x - radius * 0.8, center.y, center.z),
                vector3(center.x, center.y - radius * 0.8, center.z)
            },
            type = "perimeter"
        },
        -- Route 2: Inner patrol
        {
            name = "inner_patrol",
            points = {
                vector3(center.x + radius * 0.4, center.y + radius * 0.4, center.z),
                vector3(center.x - radius * 0.4, center.y + radius * 0.4, center.z),
                vector3(center.x - radius * 0.4, center.y - radius * 0.4, center.z),
                vector3(center.x + radius * 0.4, center.y - radius * 0.4, center.z)
            },
            type = "inner"
        },
        -- Route 3: Military base structure patrol
        {
            name = "military_structure_patrol",
            points = {
                vector3(center.x + 20, center.y, center.z + 10),
                vector3(center.x - 20, center.y, center.z + 10),
                vector3(center.x, center.y + 20, center.z + 5),
                vector3(center.x, center.y - 20, center.z + 5)
            },
            type = "structure"
        }
    }
end

-- Assign patrol route to unit
function AssignPatrolRoute(unitData)
    local routeType = "perimeter" -- Default
    
    -- Assign route based on unit type or random
    if unitData.config.weapon == "WEAPON_MG" then
        routeType = "structure" -- Heavy weapons patrol structure
    elseif unitData.config.weapon == "WEAPON_SPECIALCARBINE" then
        routeType = "inner" -- Special weapons patrol inner area
    else
        routeType = "perimeter" -- Standard weapons patrol perimeter
    end
    
    -- Find appropriate route
    local selectedRoute = nil
    for _, route in pairs(patrolRoutes) do
        if route.type == routeType then
            selectedRoute = route
            break
        end
    end
    
    -- Fallback to first route if none found
    if not selectedRoute then
        selectedRoute = patrolRoutes[1]
    end
    
    return selectedRoute
end

-- Start patrol for unit
function StartPatrol(unitData)
    local route = AssignPatrolRoute(unitData)
    if not route then
        return
    end
    
    unitData.patrolRoute = route
    unitData.patrolIndex = 1
    unitData.patrolState = "moving" -- moving, waiting, searching
    unitData.lastPatrolTime = GetGameTimer()
    
    -- Add to active patrols
    activePatrols[unitData.id] = unitData
end

-- Update patrol behavior
function UpdatePatrol(unitData)
    if not unitData.patrolRoute then
        return
    end
    
    local ped = unitData.ped
    local pedCoords = GetEntityCoords(ped)
    local route = unitData.patrolRoute
    local currentIndex = unitData.patrolIndex
    local targetPoint = route.points[currentIndex]
    local distanceToTarget = #(pedCoords - targetPoint)
    
    if unitData.patrolState == "moving" then
        if distanceToTarget < 3.0 then
            -- Reached patrol point
            unitData.patrolState = "waiting"
            unitData.lastPatrolTime = GetGameTimer()
            
            -- Look around while waiting
            TaskLookAround(ped, 2000, 2000, 0, 0, 0)
        else
            -- Move to target point
            local speed = unitData.isAlerted and Config.PatrolSettings.runSpeed or Config.PatrolSettings.walkSpeed
            TaskGoToCoordAnyMeans(ped, targetPoint.x, targetPoint.y, targetPoint.z, speed, 0, 0, 786603, 0xbf800000)
        end
    elseif unitData.patrolState == "waiting" then
        local waitTime = math.random(Config.PatrolSettings.waitTime.min, Config.PatrolSettings.waitTime.max)
        
        if GetGameTimer() - unitData.lastPatrolTime > waitTime then
            -- Move to next patrol point
            unitData.patrolIndex = (currentIndex % #route.points) + 1
            unitData.patrolState = "moving"
        end
    end
end

-- Check for suspicious activity during patrol
function CheckPatrolAlert(unitData)
    local ped = unitData.ped
    local pedCoords = GetEntityCoords(ped)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local distanceToPlayer = #(pedCoords - playerCoords)
    
    -- Check if player should be targeted
    local shouldTarget = exports['olrp_militaryheist']:ShouldTargetPlayer()
    
    if shouldTarget and distanceToPlayer <= Config.PatrolSettings.detectionRange then
        -- Player detected during patrol
        unitData.isAlerted = true
        unitData.patrolState = "searching"
        unitData.currentTarget = playerPed
        
        -- Alert other patrol units
        AlertPatrolUnits(unitData, playerCoords)
        
        return true
    end
    
    return false
end

-- Alert other patrol units
function AlertPatrolUnits(alertingUnit, playerCoords)
    for unitId, unit in pairs(activePatrols) do
        if unitId ~= alertingUnit.id and not unit.isDead then
            local unitCoords = GetEntityCoords(unit.ped)
            local distance = #(unitCoords - playerCoords)
            
            if distance <= Config.PatrolSettings.alertRange then
                unit.isAlerted = true
                unit.patrolState = "searching"
                unit.currentTarget = PlayerPedId()
                
                -- Move towards player
                TaskGoToCoordAnyMeans(unit.ped, playerCoords.x, playerCoords.y, playerCoords.z, Config.PatrolSettings.runSpeed, 0, 0, 786603, 0xbf800000)
            end
        end
    end
end

-- Stop patrol for unit
function StopPatrol(unitData)
    if activePatrols[unitData.id] then
        activePatrols[unitData.id] = nil
        unitData.patrolRoute = nil
        unitData.patrolState = nil
    end
end

-- Export functions
exports('StartPatrol', StartPatrol)
exports('UpdatePatrol', UpdatePatrol)
exports('StopPatrol', StopPatrol)
exports('CheckPatrolAlert', CheckPatrolAlert)

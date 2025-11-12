local QBCore = exports['qb-core']:GetCoreObject()
local militaryUnits = {}
local unitCounter = 0
local maxUnitId = 0 -- Track the highest unit ID to prevent duplicates
local isSpawning = false -- Prevent double spawning
local usedSpawnPoints = {} -- Track which spawn points are already occupied

-- PERFORMANCE: Cache the unit count to avoid recalculating every frame
local cachedUnitCount = 0
local cachedAlertedCount = 0
local lastCountUpdate = 0
local COUNT_UPDATE_INTERVAL = 2000 -- Update count every 2 seconds (more aggressive caching)

-- PERFORMANCE: Additional caching variables
local lastRelationshipUpdate = 0
local RELATIONSHIP_UPDATE_INTERVAL = 5000 -- Update relationships every 5 seconds
local lastDistanceCheck = 0
local DISTANCE_CHECK_INTERVAL = 500 -- Check distances every 500ms
local playerCoords = vector3(0, 0, 0)
local lastPlayerCoordsUpdate = 0
local PLAYER_COORDS_UPDATE_INTERVAL = 250 -- Update player coords every 250ms

-- Sync military units for late-joining players
RegisterNetEvent('militaryheist:client:syncMilitaryUnits', function()
    -- Just sync existing units, don't spawn new ones
    -- This event is called when units already exist and need to be synced
end)

-- Take over spawning responsibility (when original spawner disconnects)
RegisterNetEvent('militaryheist:client:takeOverSpawning', function()
    -- This client now takes over spawning responsibility
    -- Clear any existing units and respawn fresh
    for i = #militaryUnits, 1, -1 do
        if militaryUnits[i] and militaryUnits[i].ped then
            if DoesEntityExist(militaryUnits[i].ped) then
                DeleteEntity(militaryUnits[i].ped)
            end
        end
    end
    militaryUnits = {}
    usedSpawnPoints = {}
    unitCounter = 0
    maxUnitId = 0
    
    -- Spawn fresh units
    TriggerEvent('militaryheist:client:spawnMilitaryUnits')
end)

-- Spawn military units
RegisterNetEvent('militaryheist:client:spawnMilitaryUnits', function()
    -- Prevent double spawning
    if isSpawning then
        return
    end
    
    if #militaryUnits >= Config.SpawnSettings.maxUnits then
        return
    end
    
    -- Reset counter and spawn points if no units exist (fresh spawn)
    if #militaryUnits == 0 then
        unitCounter = 0
        maxUnitId = 0
        usedSpawnPoints = {} -- Clear used spawn points for fresh spawn
    end
    
    isSpawning = true
    
    if Config.SpawnSettings.usePredefinedSpawns then
        -- Use predefined spawn points
        if not Config.MilitarySpawnPoints then
            isSpawning = false
            return
        end
        
        local spawnPoints = Config.MilitarySpawnPoints
        
        if #spawnPoints == 0 then
            isSpawning = false
            return
        end
        
        -- Spawn units for all available spawn points (up to maxUnits limit)
        local unitsToSpawn = math.min(Config.SpawnSettings.maxUnits - #militaryUnits, #spawnPoints)
        
        -- Create a list of available spawn points (excluding already used ones)
        local availableSpawns = {}
        for i = 1, #spawnPoints do
            local spawnPoint = spawnPoints[i]
            local isUsed = false
            
            -- Check if this spawn point is already occupied
            for _, usedPoint in pairs(usedSpawnPoints) do
                if #(spawnPoint - usedPoint) < 2.0 then -- Within 2 units = same location
                    isUsed = true
                    break
                end
            end
            
            if not isUsed then
                table.insert(availableSpawns, spawnPoint)
            end
        end
        
        -- Shuffle the available spawn points
        for i = #availableSpawns, 2, -1 do
            local j = math.random(i)
            availableSpawns[i], availableSpawns[j] = availableSpawns[j], availableSpawns[i]
        end
        
        for i = 1, unitsToSpawn do
            local unitConfig = Config.MilitaryUnits[math.random(#Config.MilitaryUnits)]
            
            -- Use available spawn points (cycle through if more units than spawn points)
            if #availableSpawns > 0 then
                local spawnPoint = availableSpawns[((i - 1) % #availableSpawns) + 1]
                
                if spawnPoint then
                    -- Mark this spawn point as used
                    table.insert(usedSpawnPoints, spawnPoint)
                    SpawnMilitaryUnit(unitConfig, spawnPoint)
                    Wait(100) -- Small delay between spawns to prevent overload
                end
            else
                -- Fallback to random spawn if no more dedicated points available
                local spawnPoint = spawnPoints[math.random(#spawnPoints)]
                if spawnPoint then
                    SpawnMilitaryUnit(unitConfig, spawnPoint)
                    Wait(100)
                end
            end
        end
    else
        -- Use random spawn points (old system)
        local unitsToSpawn = Config.SpawnSettings.maxUnits - #militaryUnits
        
        for i = 1, unitsToSpawn do
            local unitConfig = Config.MilitaryUnits[math.random(#Config.MilitaryUnits)]
            local spawnPoint = GetRandomSpawnPoint()
            
            if spawnPoint then
                SpawnMilitaryUnit(unitConfig, spawnPoint)
                Wait(100) -- Small delay between spawns
            end
        end
    end
    
    isSpawning = false
end)

-- Get random spawn point around the military base
function GetRandomSpawnPoint()
    local center = Config.MilitaryBase.center
    local radius = Config.MilitaryBase.radius * 0.8 -- Spawn within 80% of patrol radius
    
    local angle = math.random() * 2 * math.pi
    local distance = math.random() * radius
    
    local x = center.x + math.cos(angle) * distance
    local y = center.y + math.sin(angle) * distance
    local z = center.z
    
    -- Find ground Z coordinate
    local groundZ = GetGroundZFor_3dCoord(x, y, z, false)
    if groundZ == 0 then
        groundZ = z
    end
    
    return vector3(x, y, groundZ)
end

-- Spawn individual military unit
function SpawnMilitaryUnit(unitConfig, spawnPoint)
    local model = GetHashKey(unitConfig.model)
    
    -- Request model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    
    -- Create ped
    local ped = CreatePed(4, model, spawnPoint.x, spawnPoint.y, spawnPoint.z, 0.0, true, true)
    
    if DoesEntityExist(ped) then
        -- Use persistent counter for unit ID to prevent duplicates
        unitCounter = unitCounter + 1
        local unitId = "military_unit_" .. unitCounter
        
        -- Update maxUnitId for tracking
        maxUnitId = unitCounter
        
        -- SET RELATIONSHIP GROUP FIRST - before any other settings
        SetPedRelationshipGroupHash(ped, GetHashKey("MILITARY"))
        
        -- CRITICAL: Ensure military units are friendly with each other
        SetRelationshipBetweenGroups(0, GetHashKey("MILITARY"), GetHashKey("MILITARY"))
        
        -- Prevent targeting of same group
        SetCanAttackFriendly(ped, false, false)
        
        -- Player targeting settings
        SetPedCanBeTargettedByPlayer(ped, PlayerId(), true)
        SetPedCanBeTargetted(ped, true)
        
        -- Configure ped basic properties
        SetEntityAsMissionEntity(ped, true, true)
        SetPedAccuracy(ped, math.floor(unitConfig.accuracy * 100))
        SetPedArmour(ped, unitConfig.armor)
        SetEntityHealth(ped, unitConfig.health)
        SetPedMaxHealth(ped, unitConfig.health)
        SetPedCanRagdoll(ped, false)
        SetPedFleeAttributes(ped, 0, false)
        SetPedAlertness(ped, 3)
        SetPedCanBeTargetted(ped, true)
        -- SetPedCanBeKnockedOffBike(ped, false) -- Not a valid native function
        SetPedCanBeDraggedOut(ped, false)
        SetPedCanBeTargettedByPlayer(ped, PlayerId(), true)
        
        -- WEAPON SYSTEM - Give weapons FIRST
        local primaryWeapon = GetHashKey(unitConfig.weapon)
        local secondaryWeapon = unitConfig.secondaryWeapon and GetHashKey(unitConfig.secondaryWeapon) or nil
        
        -- Give primary weapon
        GiveWeaponToPed(ped, primaryWeapon, 250, false, true)
        
        -- Give secondary weapon if exists
        if secondaryWeapon then
            GiveWeaponToPed(ped, secondaryWeapon, 250, false, true)
        end
        
        -- Wait for weapons to be properly loaded
        Wait(200)
        
        -- Equip primary weapon immediately
        SetCurrentPedWeapon(ped, primaryWeapon, true)
        
        -- Make weapons visible and ready
        SetPedCurrentWeaponVisible(ped, true, false, true, true)
        -- SetPedWeaponVisible(ped, primaryWeapon, true) -- Not a valid native function
        -- if secondaryWeapon then
        --     SetPedWeaponVisible(ped, secondaryWeapon, true)
        -- end
        
        -- Enable weapon usage
        -- SetPedCanUseWeapon(ped, true) -- Not a valid native function
        -- SetPedCanSwitchWeapon(ped, true) -- Not a valid native function
        
        -- COMBAT SYSTEM - Set up combat behavior (prevent friendly fire)
        SetPedCombatAttributes(ped, 0, true)   -- Can fight armed peds when not armed
        SetPedCombatAttributes(ped, 1, true)   -- Can use weapons
        SetPedCombatAttributes(ped, 2, true)   -- Can fight armed peds when armed
        SetPedCombatAttributes(ped, 5, true)   -- Can use vehicles
        SetPedCombatAttributes(ped, 46, true)  -- Use cover
        SetPedCombatAttributes(ped, 3, false)  -- Prevent friendly fire
        SetPedCombatAttributes(ped, 58, true)  -- Disable hurt by friendly fire
        SetPedCombatRange(ped, 2)
        SetPedCombatAbility(ped, 2)            -- Professional combat ability
        SetPedCombatMovement(ped, 2)           -- Will flank and move aggressively
        SetPedHearingRange(ped, Config.PatrolSettings.detectionRange + 30.0)
        SetPedSeeingRange(ped, Config.PatrolSettings.detectionRange + 30.0)
        
        -- Multiple layers of friendly fire prevention
        SetCanAttackFriendly(ped, false, false)
        SetPedConfigFlag(ped, 224, false) -- Disable attacking same relationship group
        SetPedConfigFlag(ped, 281, true)  -- Enable friendly fire check
        
        -- Create unit data
        local unitData = {
            id = unitId,
            ped = ped,
            config = unitConfig,
            spawnPoint = spawnPoint,
            currentTarget = nil,
            lastSeenPlayer = nil,
            isAlerted = false,
            patrolIndex = 1,
            lastPatrolTime = 0,
            health = unitConfig.health,
            armor = unitConfig.armor,
            isDead = false,
            primaryWeapon = primaryWeapon,
            secondaryWeapon = secondaryWeapon,
            spawnTime = GetGameTimer() -- Track spawn time to prevent premature death detection
        }
        
        table.insert(militaryUnits, unitData)
        
        -- PERFORMANCE: Update cached count immediately when unit spawns
        UpdateUnitCounts()
        
        -- Start unit behavior
        CreateThread(function()
            StartUnitBehavior(unitData)
        end)
        
        -- Start patrol
        StartPatrol(unitData)
        
        -- Notify server
        TriggerServerEvent('militaryheist:server:unitSpawned', unitId, spawnPoint)
    end
    
    SetModelAsNoLongerNeeded(model)
end

-- PERFORMANCE: Highly optimized unit behavior loop
function StartUnitBehavior(unitData)
    local lastUpdate = 0
    local lastRelationshipCheck = 0
    local lastWeaponCheck = 0
    
    while DoesEntityExist(unitData.ped) and not unitData.isDead do
        local currentTime = GetGameTimer()
        local ped = unitData.ped
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        
        -- PERFORMANCE: Use cached player coordinates when possible
        if currentTime - lastPlayerCoordsUpdate > PLAYER_COORDS_UPDATE_INTERVAL then
            playerCoords = GetEntityCoords(playerPed)
            lastPlayerCoordsUpdate = currentTime
        end
        
        local distanceToPlayer = #(pedCoords - playerCoords)
        local shouldTarget = ShouldTargetPlayer()
        
        -- PERFORMANCE: Reduced relationship updates
        if currentTime - lastRelationshipCheck > 3000 then -- Only every 3 seconds
            lastRelationshipCheck = currentTime
            SetCanAttackFriendly(ped, false, false)
        end
        
        -- PERFORMANCE: Distance-based culling - freeze distant NPCs
        if distanceToPlayer <= Config.SpawnSettings.cullingDistance then
            -- Check if unit is dead (using IsPedDeadOrDying for reliable detection)
            if IsPedDeadOrDying(ped, true) or not DoesEntityExist(ped) then
                if not unitData.isDead then
                    -- PERFORMANCE: Force delete the dead ped body (multiple attempts)
                    if DoesEntityExist(ped) then
                        ClearPedTasks(ped)
                        SetEntityAsMissionEntity(ped, true, true)
                        DeleteEntity(ped)
                        if DoesEntityExist(ped) then
                            DeleteEntity(ped)
                        end
                    end
                    unitData.isDead = true
                    TriggerEvent('militaryheist:client:unitDied', unitData)
                end
                break
            end
            
            -- If player shouldn't be targeted (excluded job), make them stand still
            if not shouldTarget then
                if unitData.isAlerted or unitData.currentTarget then
                    unitData.isAlerted = false
                    unitData.currentTarget = nil
                    TaskStandStill(ped, -1)
                    SetBlockingOfNonTemporaryEvents(ped, true)
                    SetPedCombatAttributes(ped, 17, true)
                end
                Wait(500) -- Shorter wait to re-evaluate targeting
            else
                -- Player can be targeted - re-enable combat
                SetBlockingOfNonTemporaryEvents(ped, false)
                SetPedCombatAttributes(ped, 17, false)
                
                -- PERFORMANCE: Reduced weapon checks
                if currentTime - lastWeaponCheck > 2000 then -- Only every 2 seconds
                    lastWeaponCheck = currentTime
                    local currentWeapon = GetSelectedPedWeapon(ped)
                    if currentWeapon ~= unitData.primaryWeapon then
                        SetCurrentPedWeapon(ped, unitData.primaryWeapon, true)
                    end
                end
                
                if distanceToPlayer <= Config.PatrolSettings.detectionRange then
                    -- Player detected - IMMEDIATELY engage
                    if not unitData.isAlerted then
                        unitData.isAlerted = true
                        TriggerEvent('militaryheist:client:unitAlerted', unitData)
                    end
                    EngagePlayer(unitData, playerPed, playerCoords, distanceToPlayer)
                elseif distanceToPlayer <= Config.PatrolSettings.detectionRange * 1.5 then
                    -- Player is close but not in immediate range - still engage
                    if not unitData.isAlerted then
                        unitData.isAlerted = true
                        TriggerEvent('militaryheist:client:unitAlerted', unitData)
                    end
                    EngagePlayer(unitData, playerPed, playerCoords, distanceToPlayer)
                else
                    -- Update patrol behavior only if no player nearby
                    UpdatePatrol(unitData)
                    
                    -- Check for patrol alerts
                    if not unitData.isAlerted then
                        CheckPatrolAlert(unitData)
                    else
                        if shouldTarget then
                            SearchBehavior(unitData)
                        end
                    end
                end
                
                -- PERFORMANCE: Aggressive variable wait time based on distance
                if distanceToPlayer <= Config.SpawnSettings.nearbyDistance then
                    Wait(300) -- Faster reactivity when close
                elseif distanceToPlayer <= Config.PatrolSettings.detectionRange then
                    Wait(900) -- Quicker reaction inside detection range
                else
                    Wait(1800) -- Quicker updates for distant units
                end
            end
        else
            -- NPC is too far - run much slower update
            Wait(5000) -- Check distant NPCs a bit more often
        end
    end
end

-- Engage player in combat
function EngagePlayer(unitData, playerPed, playerCoords, distance)
    -- PERFORMANCE: Use cached job check result
    local shouldTarget = ShouldTargetPlayer()
    if not shouldTarget then
        -- Player is protected, clear any combat tasks
        ClearPedTasks(unitData.ped)
        unitData.currentTarget = nil
        unitData.isAlerted = false
        return
    end
    
    local ped = unitData.ped
    
    -- PERFORMANCE: Only set weapon if not already equipped (prevents spam)
    local currentWeapon = GetSelectedPedWeapon(ped)
    if currentWeapon ~= unitData.primaryWeapon then
        SetCurrentPedWeapon(ped, unitData.primaryWeapon, true)
    end
    
    -- Ensure combat attributes are active and prevent friendly fire
    SetPedCombatAttributes(ped, 0, true)   -- Can fight armed peds when not armed
    SetPedCombatAttributes(ped, 1, true)   -- Can use weapons
    SetPedCombatAttributes(ped, 2, true)   -- Can fight armed peds when armed
    SetPedCombatAttributes(ped, 5, true)   -- Can use vehicles
    SetPedCombatAttributes(ped, 46, true)  -- Use cover
    SetPedCombatAttributes(ped, 3, false)  -- Prevent friendly fire
    SetPedCombatAttributes(ped, 58, true)  -- Disable hurt by friendly fire
    
    -- Re-enforce friendly fire prevention
    SetCanAttackFriendly(ped, false, false)
    SetRelationshipBetweenGroups(0, GetHashKey("MILITARY"), GetHashKey("MILITARY"))
    
    -- IMMEDIATE engagement - no hesitation (ONLY TARGET PLAYER)
    TaskLookAtEntity(ped, playerPed, 1000, 0, 2)
    
    if distance <= Config.PatrolSettings.shootingRange then
        -- In shooting range - shoot ONLY at player
        -- PERFORMANCE: Only set task if target changed or not shooting
        if unitData.currentTarget ~= playerPed or not IsPedShooting(ped) then
            -- Clear any previous tasks to ensure fresh targeting
            ClearPedTasks(ped)
            Wait(50)
            TaskShootAtEntity(ped, playerPed, 5000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
            
            -- Notify player if not already notified
            if not unitData.currentTarget then
                QBCore.Functions.Notify(Locales['en']['under_attack'], 'error', 3000)
            end
            
            unitData.currentTarget = playerPed
            unitData.lastTaskUpdate = GetGameTimer()
        end
    else
        -- Move towards player while keeping weapon ready
        -- PERFORMANCE: Only set task if target changed or not moving to player
        if unitData.currentTarget ~= playerPed then
            TaskGoToEntity(ped, playerPed, -1, 3.0, 4.0, 1073741824, 0)
            unitData.currentTarget = playerPed
            unitData.lastTaskUpdate = GetGameTimer()
        end
    end
    
    -- Alert other units IMMEDIATELY
    AlertNearbyUnits(unitData, playerCoords)
end

-- Patrol behavior
function PatrolBehavior(unitData)
    local ped = unitData.ped
    local pedCoords = GetEntityCoords(ped)
    local patrolPoints = unitData.config.patrolPoints
    local currentIndex = unitData.patrolIndex
    local targetPoint = patrolPoints[currentIndex]
    local distanceToTarget = #(pedCoords - targetPoint)
    
    if distanceToTarget < 3.0 then
        -- Reached patrol point, wait and move to next
        local waitTime = math.random(Config.PatrolSettings.waitTime.min, Config.PatrolSettings.waitTime.max)
        Wait(waitTime)
        
        unitData.patrolIndex = (currentIndex % #patrolPoints) + 1
        unitData.lastPatrolTime = GetGameTimer()
    else
        -- Move to patrol point
        TaskGoToCoordAnyMeans(ped, targetPoint.x, targetPoint.y, targetPoint.z, Config.PatrolSettings.walkSpeed, 0, 0, 786603, 0xbf800000)
    end
end

-- Search behavior when alerted
function SearchBehavior(unitData)
    local ped = unitData.ped
    local pedCoords = GetEntityCoords(ped)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local distanceToPlayer = #(pedCoords - playerCoords)
    
    if distanceToPlayer > Config.PatrolSettings.detectionRange * 1.5 then
        -- Lost player, return to patrol
        unitData.isAlerted = false
        unitData.currentTarget = nil
        return
    end
    
    -- Move to last known player position
    TaskGoToCoordAnyMeans(ped, playerCoords.x, playerCoords.y, playerCoords.z, Config.PatrolSettings.runSpeed, 0, 0, 786603, 0xbf800000)
end

-- Alert nearby units
function AlertNearbyUnits(alertingUnit, playerCoords)
    -- PERFORMANCE: Use cached job check result
    local shouldTarget = ShouldTargetPlayer()
    if not shouldTarget then
        return
    end
    
    for _, unit in pairs(militaryUnits) do
        if unit.id ~= alertingUnit.id and not unit.isDead then
            local unitCoords = GetEntityCoords(unit.ped)
            local distance = #(unitCoords - playerCoords)
            
            if distance <= Config.PatrolSettings.alertRange then
                -- IMMEDIATELY alert and engage
                unit.isAlerted = true
                unit.currentTarget = PlayerPedId()
                
                -- Force weapon equip and immediate engagement
                SetCurrentPedWeapon(unit.ped, unit.primaryWeapon, true)
                
                -- Set combat attributes for immediate engagement with friendly fire prevention
                SetPedCombatAttributes(unit.ped, 0, true)
                SetPedCombatAttributes(unit.ped, 1, true)
                SetPedCombatAttributes(unit.ped, 2, true)
                SetPedCombatAttributes(unit.ped, 5, true)
                SetPedCombatAttributes(unit.ped, 46, true)
                SetPedCombatAttributes(unit.ped, 3, false) -- Prevent friendly fire
                SetPedCombatAttributes(unit.ped, 58, true) -- Disable hurt by friendly fire
                
                -- Re-enforce relationship group and friendly fire prevention
                SetCanAttackFriendly(unit.ped, false, false)
                SetRelationshipBetweenGroups(0, GetHashKey("MILITARY"), GetHashKey("MILITARY"))
                SetPedConfigFlag(unit.ped, 224, false) -- Disable attacking same relationship group
                SetPedConfigFlag(unit.ped, 281, true)  -- Enable friendly fire check
            end
        end
    end
end

-- Unit died event
RegisterNetEvent('militaryheist:client:unitDied', function(unitData)
    -- Stop patrol
    StopPatrol(unitData)
    
    -- PERFORMANCE: Force delete the dead ped body (multiple attempts)
    if DoesEntityExist(unitData.ped) then
        -- Stop all tasks first
        ClearPedTasks(unitData.ped)
        Wait(50)
        -- Force deletion
        SetEntityAsMissionEntity(unitData.ped, true, true)
        DeleteEntity(unitData.ped)
        Wait(50)
        -- Double check deletion
        if DoesEntityExist(unitData.ped) then
            DeleteEntity(unitData.ped)
        end
    end
    
    -- Remove from active units
    for i, unit in pairs(militaryUnits) do
        if unit.id == unitData.id then
            -- Free up the spawn point when unit dies
            if unit.spawnPoint then
                for j, usedPoint in pairs(usedSpawnPoints) do
                    if #(unit.spawnPoint - usedPoint) < 2.0 then
                        table.remove(usedSpawnPoints, j)
                        break
                    end
                end
            end
            table.remove(militaryUnits, i)
            break
        end
    end
    
    -- PERFORMANCE: Update cached count immediately when unit dies
    UpdateUnitCounts()
    
    -- Notify server
    TriggerServerEvent('militaryheist:server:unitDied', unitData.id)
    
    -- Only respawn if autoRespawn is enabled
    if Config.SpawnSettings.autoRespawn then
        CreateThread(function()
            Wait(Config.SpawnSettings.respawnTime)
            if Config.HeistActive and #militaryUnits < Config.SpawnSettings.maxUnits then
                TriggerEvent('militaryheist:client:spawnMilitaryUnits')
            end
        end)
    end
end)

-- Unit alerted event
RegisterNetEvent('militaryheist:client:unitAlerted', function(unitData)
    -- Military spotted notification disabled
    -- QBCore.Functions.Notify(Locales['en']['military_spotted'], 'error', 3000)
end)

-- Unit died notification from server (sync across all clients)
RegisterNetEvent('militaryheist:client:unitDiedNotification', function(unitId)
    -- Find and mark unit as dead on this client
    for i, unit in pairs(militaryUnits) do
        if unit.id == unitId then
            unit.isDead = true
            break
        end
    end
end)

-- All units killed event
RegisterNetEvent('militaryheist:client:allUnitsKilled', function()
    -- Clean up all units on this client
    for i = #militaryUnits, 1, -1 do
        if militaryUnits[i] and militaryUnits[i].ped then
            StopPatrol(militaryUnits[i])
            -- PERFORMANCE: Force delete all ped bodies (multiple attempts)
            if DoesEntityExist(militaryUnits[i].ped) then
                -- Stop all tasks first
                ClearPedTasks(militaryUnits[i].ped)
                Wait(50)
                -- Force deletion
                SetEntityAsMissionEntity(militaryUnits[i].ped, true, true)
                DeleteEntity(militaryUnits[i].ped)
                Wait(50)
                -- Double check deletion
                if DoesEntityExist(militaryUnits[i].ped) then
                    DeleteEntity(militaryUnits[i].ped)
                end
            end
        end
        militaryUnits[i].isDead = true
        table.remove(militaryUnits, i)
    end
    -- Reset counter and spawn points when all units are killed
    militaryUnits = {}
    unitCounter = 0
    maxUnitId = 0
    usedSpawnPoints = {} -- Clear used spawn points
    UpdateUnitCounts()
end)

-- Check spawns (disabled - NPCs only spawn once on resource start)
RegisterNetEvent('militaryheist:client:checkSpawns', function()
    -- No longer spawns new units automatically
    -- NPCs only spawn once when resource starts or when manually triggered
end)

-- Check military units
RegisterNetEvent('militaryheist:client:checkMilitaryUnits', function()
    local removedAny = false
    
    -- Clean up dead units from tracking (but keep bodies)
    for i = #militaryUnits, 1, -1 do
        local unit = militaryUnits[i]
        if not DoesEntityExist(unit.ped) or unit.isDead then
            table.remove(militaryUnits, i)
            removedAny = true
        end
    end
    
    -- PERFORMANCE: Only update cache if we removed any units
    if removedAny then
        UpdateUnitCounts()
    end
end)


-- Patrol functions
function StartPatrol(unitData)
    if unitData.config.patrolPoints and #unitData.config.patrolPoints > 0 then
        unitData.patrolIndex = 1
        unitData.lastPatrolTime = GetGameTimer()
    end
end

function UpdatePatrol(unitData)
    if not unitData.config.patrolPoints or #unitData.config.patrolPoints == 0 then
        return
    end
    
    local ped = unitData.ped
    local pedCoords = GetEntityCoords(ped)
    local patrolPoints = unitData.config.patrolPoints
    local currentIndex = unitData.patrolIndex
    local targetPoint = patrolPoints[currentIndex]
    local distanceToTarget = #(pedCoords - targetPoint)
    
    if distanceToTarget < 3.0 then
        -- Reached patrol point, wait and move to next
        local waitTime = math.random(Config.PatrolSettings.waitTime.min, Config.PatrolSettings.waitTime.max)
        Wait(waitTime)
        
        unitData.patrolIndex = (currentIndex % #patrolPoints) + 1
        unitData.lastPatrolTime = GetGameTimer()
    else
        -- Move to patrol point
        TaskGoToCoordAnyMeans(ped, targetPoint.x, targetPoint.y, targetPoint.z, Config.PatrolSettings.walkSpeed, 0, 0, 786603, 0xbf800000)
    end
end

function CheckPatrolAlert(unitData)
    -- Simple patrol alert check - can be expanded later
    local ped = unitData.ped
    local pedCoords = GetEntityCoords(ped)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local distanceToPlayer = #(pedCoords - playerCoords)
    
    if distanceToPlayer <= Config.PatrolSettings.detectionRange then
        unitData.isAlerted = true
        TriggerEvent('militaryheist:client:unitAlerted', unitData)
    end
end

function StopPatrol(unitData)
    -- Stop any patrol tasks
    if DoesEntityExist(unitData.ped) then
        ClearPedTasks(unitData.ped)
    end
end

-- PERFORMANCE: Background thread to update cached counts
CreateThread(function()
    while true do
        Wait(COUNT_UPDATE_INTERVAL)
        UpdateUnitCounts()
    end
end)

-- PERFORMANCE: Optimized relationship enforcement thread
CreateThread(function()
    while true do
        local currentTime = GetGameTimer()
        
        -- Only update relationships periodically, not every frame
        if currentTime - lastRelationshipUpdate > RELATIONSHIP_UPDATE_INTERVAL then
            lastRelationshipUpdate = currentTime
            
            -- Continuously enforce military units are friendly with each other
            SetRelationshipBetweenGroups(0, GetHashKey("MILITARY"), GetHashKey("MILITARY"))
            
            -- Check each unit and enforce friendly fire prevention (batch process)
            for _, unit in pairs(militaryUnits) do
                if DoesEntityExist(unit.ped) and not unit.isDead then
                    SetCanAttackFriendly(unit.ped, false, false)
                    SetPedConfigFlag(unit.ped, 224, false)
                    SetPedConfigFlag(unit.ped, 281, true)
                end
            end
        end
        
        Wait(1000) -- Check every 1 second (reduced from 2 seconds)
    end
end)

-- PERFORMANCE: Highly optimized cleanup thread with aggressive culling
CreateThread(function()
    while true do
        local currentTime = GetGameTimer()
        
        -- Only update player coordinates periodically
        if currentTime - lastPlayerCoordsUpdate > PLAYER_COORDS_UPDATE_INTERVAL then
            playerCoords = GetEntityCoords(PlayerPedId())
            lastPlayerCoordsUpdate = currentTime
        end
        
        local countChanged = false
        
        -- PERFORMANCE: Batch process units with distance-based culling
        for i = #militaryUnits, 1, -1 do
            local unit = militaryUnits[i]
            if unit and unit.ped then
                -- PERFORMANCE: Skip units that are too far away (aggressive culling)
                local unitCoords = GetEntityCoords(unit.ped)
                local distance = #(playerCoords - unitCoords)
                
                -- Only check nearby units or dead units
                if distance <= Config.SpawnSettings.cullingDistance or not unit.isDead then
                    -- Check if dead (with grace period for newly spawned units)
                    if not unit.isDead then
                        -- Give newly spawned units 2 seconds grace period before death checks
                        local timeSinceSpawn = currentTime - (unit.spawnTime or 0)
                        if timeSinceSpawn > 2000 then
                            local isDead = false
                            
                            if not DoesEntityExist(unit.ped) then
                                isDead = true
                            elseif IsPedDeadOrDying(unit.ped, true) then
                                isDead = true
                            end
                            
                            if isDead then
                                -- PERFORMANCE: Force delete the dead ped body (multiple attempts)
                                if DoesEntityExist(unit.ped) then
                                    -- Stop all tasks first
                                    ClearPedTasks(unit.ped)
                                    -- Force deletion
                                    SetEntityAsMissionEntity(unit.ped, true, true)
                                    DeleteEntity(unit.ped)
                                    -- Double check deletion
                                    if DoesEntityExist(unit.ped) then
                                        DeleteEntity(unit.ped)
                                    end
                                end
                                unit.isDead = true
                                countChanged = true
                                table.remove(militaryUnits, i)
                                TriggerServerEvent('militaryheist:server:unitDied', unit.id)
                            end
                        end
                    end
                end
            end
        end
        
        -- Update cache immediately if any unit died
        if countChanged then
            UpdateUnitCounts()
        end
        
        -- PERFORMANCE: Variable wait time based on unit count
        local waitTime = #militaryUnits > 10 and 200 or 100 -- Longer wait with more units
        Wait(waitTime)
    end
end)

-- Update cached unit counts (called periodically or when units die/spawn)
function UpdateUnitCounts()
    local currentTime = GetGameTimer()
    lastCountUpdate = currentTime
    
    local aliveCount = 0
    local alertedCount = 0
    
    for _, unit in pairs(militaryUnits) do
        if DoesEntityExist(unit.ped) and not unit.isDead then
            aliveCount = aliveCount + 1
            if unit.isAlerted then
                alertedCount = alertedCount + 1
            end
        end
    end
    
    cachedUnitCount = aliveCount
    cachedAlertedCount = alertedCount
end

-- Get military units count (returns cached value for performance)
function GetMilitaryUnitsCount()
    return cachedUnitCount
end

-- Get alerted units count (returns cached value for performance)
function GetAlertedUnitsCount()
    return cachedAlertedCount
end

-- Get patrol status (optimized version)
function GetPatrolStatusOptimized()
    return {
        activePatrols = cachedUnitCount,
        totalUnits = cachedUnitCount,
        alertedUnits = cachedAlertedCount
    }
end

-- Export functions
exports('GetMilitaryUnitsCount', GetMilitaryUnitsCount)
exports('GetAlertedUnitsCount', GetAlertedUnitsCount)
exports('GetPatrolStatus', GetPatrolStatusOptimized)
exports('UpdateUnitCounts', UpdateUnitCounts) -- Export for use in other client files

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for _, unit in pairs(militaryUnits) do
            if DoesEntityExist(unit.ped) then
                DeleteEntity(unit.ped)
            end
        end
        militaryUnits = {}
        unitCounter = 0
        maxUnitId = 0
        usedSpawnPoints = {} -- Clear used spawn points
    end
end)

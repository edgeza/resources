local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local isInRestrictedArea = false
local lastJobCheck = 0

-- Import variables from npcs.lua to avoid errors
local militaryUnits = {}
local usedSpawnPoints = {}
local unitCounter = 0
local maxUnitId = 0

-- PERFORMANCE OPTIMIZATION: Cached values
local cachedShouldTarget = true
local cachedPlayerCoords = vector3(0, 0, 0)
local lastCacheUpdate = 0

-- Military stash variables
local stashProgressActive = false
local stashProgressStartTime = 0
local stashProgressDuration = 30000 -- 30 seconds in milliseconds (fallback value)
local stashAlreadyAccessed = false


-- Initialize
CreateThread(function()
    
    while not QBCore do
        Wait(100)
    end
    
    -- Initialize stash progress duration from config
    if Config and Config.MilitaryStash and Config.MilitaryStash.progressDuration then
        stashProgressDuration = Config.MilitaryStash.progressDuration
    end
    
    PlayerData = QBCore.Functions.GetPlayerData()
    
    -- Set up relationship groups
    AddRelationshipGroup("MILITARY")
    -- Military units should be friendly with each other (0 = companion, prevents all aggression)
    SetRelationshipBetweenGroups(0, GetHashKey("MILITARY"), GetHashKey("MILITARY"))
    -- Initial hostile relationship (will be updated dynamically)
    SetRelationshipBetweenGroups(5, GetHashKey("MILITARY"), GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("MILITARY"))
    
    
    -- Start the military heist system
    if Config.HeistActive then
    TriggerEvent('militaryheist:client:startHeist')
        
        -- Auto-spawn military units ONCE on resource start (through server)
        CreateThread(function()
            Wait(5000) -- Wait for everything to initialize (exports, etc)
            TriggerServerEvent('militaryheist:server:initialSpawn')
        end)
    end
    
    -- PERFORMANCE: Centralized cache updater (runs once per second for all NPCs)
    local lastShouldTarget = nil
    CreateThread(function()
        while true do
            Wait(3000) -- Update cache every 3 seconds (job doesn't change often) - Increased for performance
            
            local currentTime = GetGameTimer()
            lastCacheUpdate = currentTime
            
            -- Cache player coordinates (so all NPCs use same value)
            cachedPlayerCoords = GetEntityCoords(PlayerPedId())
            
            -- Cache job check result (so all NPCs use same value)
            cachedShouldTarget = ShouldTargetPlayer()
            
            -- OPTIMIZATION: Only update relationship groups if targeting status changed
            if lastShouldTarget ~= cachedShouldTarget then
                lastShouldTarget = cachedShouldTarget
                
                if cachedShouldTarget then
                    -- Player should be targeted - set hostile relationship
                    SetRelationshipBetweenGroups(5, GetHashKey("MILITARY"), GetHashKey("PLAYER"))
                    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("MILITARY"))
                else
                    -- Player has protected job - set neutral/friendly relationship
                    SetRelationshipBetweenGroups(1, GetHashKey("MILITARY"), GetHashKey("PLAYER"))
                    SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("MILITARY"))
                end
                
                -- Always ensure military units stay friendly with each other
                SetRelationshipBetweenGroups(0, GetHashKey("MILITARY"), GetHashKey("MILITARY"))
            end
        end
    end)
end)

-- Player data updates
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    cachedPlayerJob = PlayerData and PlayerData.job and PlayerData.job.name or "unemployed"
    lastJobCheckTime = GetGameTimer()
    
    -- Sync existing NPCs to late-joining players (doesn't spawn new ones)
    if Config.HeistActive then
        CreateThread(function()
            Wait(5000) -- Wait for everything to initialize
            TriggerServerEvent('militaryheist:server:requestSync')
        end)
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
    cachedPlayerJob = JobInfo.name
    lastJobCheckTime = GetGameTimer()
end)

-- Main heist control
RegisterNetEvent('militaryheist:client:startHeist', function()
    CreateThread(function()
        while Config.HeistActive do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            
            -- Check if player is in restricted area
            local wasInArea = isInRestrictedArea
            isInRestrictedArea = IsPointInMilitaryBase(playerCoords)
            
            -- Area entry/exit notifications
            if isInRestrictedArea and not wasInArea then
                TriggerEvent('militaryheist:client:enterRestrictedArea')
            elseif not isInRestrictedArea and wasInArea then
                TriggerEvent('militaryheist:client:exitRestrictedArea')
            end
            
            -- Check for military unit interactions
            TriggerEvent('militaryheist:client:checkMilitaryUnits')
            
            Wait(1000)
        end
    end)
end)

-- Enter restricted area
RegisterNetEvent('militaryheist:client:enterRestrictedArea', function()
    QBCore.Functions.Notify(Locales['en']['entering_restricted'], 'error', 5000)
    -- NPCs no longer spawn when entering area - they spawn once on resource start
end)

-- Exit restricted area
RegisterNetEvent('militaryheist:client:exitRestrictedArea', function()
    QBCore.Functions.Notify(Locales['en']['leaving_restricted'], 'success', 3000)
end)

-- Heist restart event
RegisterNetEvent('militaryheist:client:restartHeist', function()
    QBCore.Functions.Notify('Military heist has restarted! Units are respawning...', 'info', 5000)
    -- Clear local units and request fresh spawn from server (heist restart)
    militaryUnits = {}
    usedSpawnPoints = {}
    unitCounter = 0
    maxUnitId = 0
    exports['olrp_militaryheist']:UpdateUnitCounts()
    -- Reset stash access for new heist cycle
    stashAlreadyAccessed = false
    stashProgressActive = false
    TriggerServerEvent('militaryheist:server:initialSpawn')
end)

-- Check if a point is within the military base zone
function IsPointInMilitaryBase(point)
    local corners = Config.MilitaryBase.corners
    if #corners < 4 then
        return false
    end
    
    -- Simple bounding box check for now
    local minX, maxX = corners[1].x, corners[1].x
    local minY, maxY = corners[1].y, corners[1].y
    local minZ, maxZ = corners[1].z, corners[1].z
    
    for _, corner in pairs(corners) do
        minX = math.min(minX, corner.x)
        maxX = math.max(maxX, corner.x)
        minY = math.min(minY, corner.y)
        maxY = math.max(maxY, corner.y)
        minZ = math.min(minZ, corner.z)
        maxZ = math.max(maxZ, corner.z)
    end
    
    return point.x >= minX and point.x <= maxX and 
           point.y >= minY and point.y <= maxY and 
           point.z >= minZ and point.z <= maxZ
end

-- Check if player should be targeted
function ShouldTargetPlayer()
    -- Get fresh player data
    local currentPlayerData = QBCore.Functions.GetPlayerData()
    
    if not currentPlayerData or not currentPlayerData.job then
        return true -- Target if no job data
    end
    
    local playerJob = currentPlayerData.job.name
    
    -- Check if player has excluded job
    for _, excludedJob in pairs(Config.ExcludedJobs) do
        if playerJob == excludedJob then
            return false -- Don't target excluded jobs
        end
    end
    
    return true -- Target all other jobs
end

-- Handle stash population completion
RegisterNetEvent('militaryheist:client:stashPopulated', function()
    -- Notify player that items have been added to their inventory
    QBCore.Functions.Notify("Military items added to your inventory!", 'success', 5000)
    
    -- Play a sound effect if available
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
end)

-- Get player job (with caching)
local cachedPlayerJob = "unemployed"
local lastJobCheckTime = 0

function GetPlayerJob()
    local currentTime = GetGameTimer()
    if currentTime - lastJobCheckTime > 5000 then -- Check every 5 seconds
        lastJobCheckTime = currentTime
        cachedPlayerJob = PlayerData and PlayerData.job and PlayerData.job.name or "unemployed"
    end
    return cachedPlayerJob
end


-- Military Stash System
CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local stashCoords = Config.MilitaryStash.location
        local distance = #(playerCoords - stashCoords)
        
        if distance <= 5.0 and Config.MilitaryStash.enabled then
            sleep = 0
            
            -- Cancel progress if player moves away
            if stashProgressActive and distance > 3.0 then
                stashProgressActive = false
                QBCore.Functions.Notify("Military storage access cancelled - you moved too far away!", 'error', 3000)
            end
            
            -- Check if all units are killed using the export
            local aliveUnits = exports['olrp_militaryheist']:GetMilitaryUnitsCount()
            
            -- Draw marker
            if aliveUnits == 0 and not stashAlreadyAccessed then
                -- Green marker when accessible
                DrawMarker(1, stashCoords.x, stashCoords.y, stashCoords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 255, 0, 100, false, true, 2, false, nil, nil, false)
            elseif aliveUnits > 0 then
                -- Red marker when locked (units still alive)
                DrawMarker(1, stashCoords.x, stashCoords.y, stashCoords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 1.0, 255, 0, 0, 100, false, true, 2, false, nil, nil, false)
            else
                -- Gray marker when already accessed
                DrawMarker(1, stashCoords.x, stashCoords.y, stashCoords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 1.0, 128, 128, 128, 100, false, true, 2, false, nil, nil, false)
            end
            
            if distance <= 2.0 then
                if aliveUnits == 0 and not stashAlreadyAccessed then
                    if stashProgressActive then
                        -- Show progress bar
                        local currentTime = GetGameTimer()
                        local elapsed = currentTime - stashProgressStartTime
                        local progress = math.min(elapsed / stashProgressDuration, 1.0)
                        local remainingTime = math.ceil((stashProgressDuration - elapsed) / 1000)
                        
                        QBCore.Functions.DrawText3D(stashCoords.x, stashCoords.y, stashCoords.z + 1.0, "Accessing Military Storage... " .. remainingTime .. "s")
                        
                        -- Draw progress bar
                        DrawRect(0.5, 0.9, 0.3, 0.05, 0, 0, 0, 150)
                        DrawRect(0.5, 0.9, 0.3 * progress, 0.05, 0, 255, 0, 200)
                        
                        if progress >= 1.0 then
                            stashProgressActive = false
                            stashAlreadyAccessed = true
                            OpenMilitaryStash()
                        end
                    else
                        QBCore.Functions.DrawText3D(stashCoords.x, stashCoords.y, stashCoords.z + 1.0, "[E] Access Military Storage")
                        
                        if IsControlJustPressed(0, 38) then -- E key
                            StartStashProgress()
                        end
                    end
                elseif aliveUnits > 0 then
                    QBCore.Functions.DrawText3D(stashCoords.x, stashCoords.y, stashCoords.z + 1.0, "Eliminate all " .. aliveUnits .. " remaining units")
                elseif stashAlreadyAccessed then
                    QBCore.Functions.DrawText3D(stashCoords.x, stashCoords.y, stashCoords.z + 1.0, "Military Storage already accessed")
                end
            end
        end
        
        Wait(sleep)
    end
end)

-- Start stash progress
function StartStashProgress()
    if stashProgressActive or stashAlreadyAccessed then
        return
    end
    
    -- Check if all units are killed
    local aliveUnits = exports['olrp_militaryheist']:GetMilitaryUnitsCount()
    if aliveUnits > 0 then
        QBCore.Functions.Notify("You must eliminate all " .. aliveUnits .. " remaining units first!", 'error', 5000)
        return
    end
    
    stashProgressActive = true
    stashProgressStartTime = GetGameTimer()
    
    QBCore.Functions.Notify("Starting to access military storage vault...", 'info', 5000)
end

-- Open military stash
function OpenMilitaryStash()
    -- Check if all units are killed using the export
    local aliveUnits = exports['olrp_militaryheist']:GetMilitaryUnitsCount()
    
    if aliveUnits > 0 then
        QBCore.Functions.Notify("You must eliminate all " .. aliveUnits .. " remaining units first!", 'error', 5000)
        return
    end
    
    -- Debug notification
    QBCore.Functions.Notify("Requesting military stash access...", 'info', 3000)
    
    -- Populate stash with items - the client event will handle opening
    TriggerServerEvent('militaryheist:server:populateStash')
end

-- Export functions for other client scripts to use
exports('IsInRestrictedArea', function()
    return isInRestrictedArea
end)

exports('GetPlayerJob', GetPlayerJob)
exports('ShouldTargetPlayer', ShouldTargetPlayer)

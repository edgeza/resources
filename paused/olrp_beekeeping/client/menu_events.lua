-- QBCore Beekeeping Menu Events - Advanced Features
local QBCore = exports['qb-core']:GetCoreObject()

-- Ensure shared globals exist when this file is loaded standalone
CreatedBeehives = CreatedBeehives or {}

-----------------------------------------------
--------------- Menu Events -------------------
-----------------------------------------------

RegisterNetEvent('mms-beekeeper:client:AddQueen', function(data)
    -- Check if hive already has a queen
    local CurrentBeehive = CreatedBeehives[data.hiveId]
    if CurrentBeehive and CurrentBeehive.data then
        local currentQueens = CurrentBeehive.data.Queen or 0
        
        -- Check if already has a queen
        if currentQueens >= 1 then
            local queenType = data.queen == "basic_queen" and "Queen Bee" or "Wasp Queen"
            return QBCore.Functions.Notify('👑 This hive already has a queen! Maximum: 1 queen per hive', 'error', 6000)
        end
    end
    
    -- precheck queen item client+server
    QBCore.Functions.TriggerCallback('mms-beekeeper:server:hasItem', function(hasQueen)
        if not hasQueen then 
            local itemName = data.queen == "basic_queen" and "queen bee" or "wasp queen"
            return QBCore.Functions.Notify('You do not have a ' .. itemName, 'error') 
        end
        
        local progressText = data.queen == "basic_queen" and "Adding Queen Bee..." or "Adding Wasp Queen..."
        QBCore.Functions.Progressbar("add_queen", progressText, Config.QueenTime * 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "mp_common",
            anim = "givetake1_a",
            flags = 49,
        }, {}, {}, function() -- Done
            TriggerServerEvent('mms-beekeeper:server:AddQueen', data.hiveId, data.queen)
        end, function() -- Cancel
            QBCore.Functions.Notify('Cancelled', 'error')
        end)
    end, data.queen, 1)
end)

RegisterNetEvent('mms-beekeeper:client:AddBees', function(data)
    -- Check if hive is at max capacity first
    local CurrentBeehive = CreatedBeehives[data.hiveId]
    if CurrentBeehive and CurrentBeehive.data then
        local currentBees = CurrentBeehive.data.Bees or 0
        
        -- Check if already at max
        if currentBees >= Config.MaxBeesPerHive then
            local beeType = CurrentBeehive.data.BeeSettings and CurrentBeehive.data.BeeSettings.BeeLabel or "bees/wasps"
            return QBCore.Functions.Notify('🐝 Too many ' .. beeType:lower() .. ' for one hive! Maximum capacity reached (' .. Config.MaxBeesPerHive .. '/' .. Config.MaxBeesPerHive .. ')', 'error', 6000)
        end
    end
    
    -- verify has matching bee item for queen type
    QBCore.Functions.TriggerCallback('mms-beekeeper:server:hasBeeForQueen', function(ok)
        if not ok then 
            local itemName = data.queen == "basic_queen" and "worker bees" or "worker wasps"
            return QBCore.Functions.Notify('You do not have the required ' .. itemName, 'error') 
        end
        
        local progressText = data.queen == "basic_queen" and "Adding Worker Bees..." or "Adding Worker Wasps..."
        QBCore.Functions.Progressbar("add_bees", progressText, Config.BeeTime * 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_gardener_plant@male@idle_a",
            anim = "idle_a",
            flags = 49,
        }, {}, {}, function() -- Done
            TriggerServerEvent('mms-beekeeper:server:AddBees', data.hiveId, data.queen)
        end, function() -- Cancel
            QBCore.Functions.Notify('Cancelled', 'error')
        end)
    end, data.queen)
end)

RegisterNetEvent('mms-beekeeper:client:TakeHoney', function(data)
    local CurrentBeehive = CreatedBeehives[data.hiveId]
    if not CurrentBeehive or not CurrentBeehive.data then
        QBCore.Functions.Notify('Hive data not found', 'error', 3000)
        return
    end
    
    local honeyAmount = math.floor(CurrentBeehive.data.Product / Config.ProduktPerHoney)
    if honeyAmount <= 0 then
        QBCore.Functions.Notify('This hive has no honey to collect', 'error', 3000)
        return
    end
    
    QBCore.Functions.Progressbar("take_honey", "Collecting Honey...", Config.TakeHoneyTime * 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent('mms-beekeeper:server:TakeProduct', data.hiveId, Config.ProduktPerHoney)
    end, function() -- Cancel
        QBCore.Functions.Notify('Cancelled', 'error')
    end)
end)

RegisterNetEvent('mms-beekeeper:client:TakeAllHoney', function(data)
    local CurrentBeehive = CreatedBeehives[data.hiveId]
    if not CurrentBeehive or not CurrentBeehive.data then
        QBCore.Functions.Notify('Hive data not found', 'error', 3000)
        return
    end
    
    if CurrentBeehive.data.Product <= 0 then
        QBCore.Functions.Notify('This hive has no honey to collect', 'error', 3000)
        return
    end
    
    QBCore.Functions.Progressbar("take_all_honey", "Collecting All Honey...", Config.TakeHoneyTime * 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent('mms-beekeeper:server:TakeProduct', data.hiveId, CurrentBeehive.data.Product)
    end, function() -- Cancel
        QBCore.Functions.Notify('Cancelled', 'error')
    end)
end)

RegisterNetEvent('mms-beekeeper:client:FeedHive', function(data)
    QBCore.Functions.TriggerCallback('mms-beekeeper:server:hasItem', function(has)
        if not has then return QBCore.Functions.Notify('You do not have '..(Config.FoodItemLabel or 'food'), 'error') end
        QBCore.Functions.Progressbar("feed_hive", "Feeding Hive...", Config.FeedTime * 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_gardener_plant@male@idle_a",
            anim = "idle_a",
            flags = 49,
        }, {}, {}, function() -- Done
            TriggerServerEvent('mms-beekeeper:server:AddFood', data.hiveId)
        end, function() -- Cancel
            QBCore.Functions.Notify('Cancelled', 'error')
        end)
    end, Config.FoodItem, 1)
end)

RegisterNetEvent('mms-beekeeper:client:WaterHive', function(data)
    QBCore.Functions.TriggerCallback('mms-beekeeper:server:hasItem', function(has)
        if not has then return QBCore.Functions.Notify('You do not have '..(Config.WaterItemLabel or 'water'), 'error') end
        QBCore.Functions.Progressbar("water_hive", "Watering Hive...", Config.WaterTime * 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_gardener_plant@male@idle_a",
            anim = "idle_a",
            flags = 49,
        }, {}, {}, function() -- Done
            TriggerServerEvent('mms-beekeeper:server:AddWater', data.hiveId)
        end, function() -- Cancel
            QBCore.Functions.Notify('Cancelled', 'error')
        end)
    end, Config.WaterItem, 1)
end)

RegisterNetEvent('mms-beekeeper:client:CleanHive', function(data)
    QBCore.Functions.TriggerCallback('mms-beekeeper:server:hasItem', function(has)
        if not has then return QBCore.Functions.Notify('You do not have '..(Config.CleanItemLabel or 'cleaning supplies'), 'error') end
        QBCore.Functions.Progressbar("clean_hive", "Cleaning Hive...", Config.CleanTime * 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_maid_clean@",
            anim = "base",
            flags = 49,
        }, {}, {}, function() -- Done
            TriggerServerEvent('mms-beekeeper:server:AddClean', data.hiveId)
        end, function() -- Cancel
            QBCore.Functions.Notify('Cancelled', 'error')
        end)
    end, Config.CleanItem, 1)
end)

RegisterNetEvent('mms-beekeeper:client:HealHive', function(data)
    QBCore.Functions.TriggerCallback('mms-beekeeper:server:hasItem', function(has)
        if not has then return QBCore.Functions.Notify('You do not have '..(Config.HealItemLabel or 'healing item'), 'error') end
        QBCore.Functions.Progressbar("heal_hive", "Healing Hive...", Config.HealTime * 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@medic@standing@tendtodead@idle_a",
            anim = "idle_a",
            flags = 49,
        }, {}, {}, function() -- Done
            TriggerServerEvent('mms-beekeeper:server:AddHealth', data.hiveId)
        end, function() -- Cancel
            QBCore.Functions.Notify('Cancelled', 'error')
        end)
    end, Config.HealItem, 1)
end)

RegisterNetEvent('mms-beekeeper:client:HealSickness', function(data)
    QBCore.Functions.Progressbar("heal_sickness", "Healing Sickness...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@medic@standing@tendtodead@idle_a",
        anim = "idle_a",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent('mms-beekeeper:server:HealSickness', data.hiveId)
    end, function() -- Cancel
        QBCore.Functions.Notify('Cancelled', 'error')
    end)
end)

RegisterNetEvent('mms-beekeeper:client:DeleteHive', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = "Delete Hive",
        submitText = "Delete",
        inputs = {
            {
                text = "Type 'DELETE' to confirm",
                name = "confirm",
                type = "text",
                isRequired = true
            }
        }
    })
    
    if dialog and dialog.confirm == "DELETE" then
        TriggerServerEvent('mms-beekeeper:server:DeleteBeehive', data.hiveId)
    end
end)

-----------------------------------------------
--------------- Wild Beehives -----------------
-----------------------------------------------

-- Dynamic Wild Beehive Spawning System
ActiveWildHives = ActiveWildHives or {}
WildHiveRotationTimer = WildHiveRotationTimer or 0
WildHiveSpawned = WildHiveSpawned or false
WildHiveBusy = false
WildHiveCooldowns = WildHiveCooldowns or {}
WildHiveSounds = WildHiveSounds or {} -- Store sound IDs for wild hives

-- Verify jl_minigame is loaded on startup
CreateThread(function()
    Wait(2000) -- Wait for all resources to load
    
    -- Test if jl_minigame export is available
    local minigameLoaded = pcall(function()
        local testExport = exports['jl_minigame']
        if testExport and testExport.Play then
            return true
        end
        return false
    end)
    
    if minigameLoaded then
        print("^2[MMS-Beekeeper]^7 ✓ jl_minigame export detected and working")
    else
        print("^1[MMS-Beekeeper ERROR]^7 ✗ jl_minigame export NOT detected!")
        print("^3[MMS-Beekeeper]^7 Make sure jl_minigame resource is started BEFORE olrp_beekeeping")
        print("^3[MMS-Beekeeper]^7 Run: restart jl_minigame")
        print("^3[MMS-Beekeeper]^7 Then: restart olrp_beekeeping")
    end
end)

-- Test command for minigame
RegisterCommand('testbeeminigame', function()
    print("^3[MMS-Beekeeper]^7 Testing minigame...")
    
    local result = exports['jl_minigame']:Play({
        difficulty = 'easy',
        rounds = 1,
        timeLimit = 10.0
    })
    
    print("^2[MMS-Beekeeper]^7 Minigame returned - Type: " .. type(result) .. " | Value: " .. tostring(result))
    
    if result == true then
        print("^2[MMS-Beekeeper]^7 ✓ SUCCESS - Minigame passed!")
        QBCore.Functions.Notify('SUCCESS! Minigame working correctly', 'success')
    elseif result == false then
        print("^1[MMS-Beekeeper]^7 ✗ FAILED - Player failed minigame!")
        print("^1[MMS-Beekeeper]^7 Now testing bee sting effects...")
        ApplyBeeSting()
        QBCore.Functions.Notify('FAILED! Testing bee sting...', 'error')
    else
        print("^3[MMS-Beekeeper]^7 ? UNKNOWN - Result: " .. tostring(result))
        QBCore.Functions.Notify('Unknown result: ' .. tostring(result), 'error')
    end
end, false)

-- Command to clear stuck screen effects
RegisterCommand('clearscreeneffect', function()
    AnimpostfxStopAll()
    print("^2[MMS-Beekeeper]^7 All screen effects cleared!")
    QBCore.Functions.Notify('Screen effects cleared', 'success')
end, false)

function SpawnWildBeehivesDynamic()
    if WildHiveSpawned then return end
    WildHiveSpawned = true
    
    print("^2[MMS-Beekeeper]^7 Initializing wild beehive system...")
    
    -- Setup global model target as a backup
    SetupWildBeehiveGlobalTarget()
    
    -- Clear any existing hives
    ClearAllWildHives()
    
    -- Spawn initial hives
    SpawnRandomWildHives(Config.WildBeehiveMaxActive)
    
    -- Start rotation timer
    StartWildHiveRotation()
    
    print("^2[MMS-Beekeeper]^7 Wild beehive system initialized with " .. Config.WildBeehiveMaxActive .. " active hives")
end

-- Setup wild beehive targeting system
-- NOTE: We use BoxZones (area-based) for each hive instead of model targeting
-- because bushes are common props and model targeting would target ALL bushes in the world
function SetupWildBeehiveGlobalTarget()
    print("^2[MMS-Beekeeper]^7 Wild beehive targeting uses BoxZone system (area-based detection)")
    print("^2[MMS-Beekeeper]^7 Each spawned wild hive gets its own targetable zone")
    -- No global model targeting needed - each hive spawns with its own BoxZone
end

-- Event for model-based targeting (finds nearest hive)
RegisterNetEvent('mms-beekeeper:client:InteractNearestWildHive', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local nearestHiveId = nil
    local nearestDistance = 999999
    
    print("^3[MMS-Beekeeper DEBUG]^7 Looking for nearest wild hive. Active hives: " .. table.size(ActiveWildHives or {}))
    
    for hiveId, hiveData in pairs(ActiveWildHives) do
        local distance = #(playerCoords - hiveData.coords)
        print("^3[MMS-Beekeeper DEBUG]^7 Hive " .. hiveId .. " distance: " .. distance)
        if distance < nearestDistance then
            nearestDistance = distance
            nearestHiveId = hiveId
        end
    end
    
    if nearestHiveId and nearestDistance < 3.0 then
        print("^2[MMS-Beekeeper]^7 Found nearest hive: " .. nearestHiveId .. " at distance: " .. nearestDistance)
        TriggerEvent('mms-beekeeper:client:InteractWildHive', { hiveId = nearestHiveId })
    else
        print("^3[MMS-Beekeeper]^7 No wild hive nearby. Nearest distance: " .. nearestDistance)
        QBCore.Functions.Notify('No wild hive nearby (distance: ' .. math.floor(nearestDistance) .. 'm)', 'error')
    end
end)

-- Helper function for table size
function table.size(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

-- Receive server-synced wild hives
RegisterNetEvent('mms-beekeeper:client:SyncServerWildHives', function(serverHives)
    print("^2[MMS-Beekeeper]^7 Receiving server-synced wild hives...")
    
    -- Clear existing client-side hives
    ClearAllWildHives()
    
    -- Spawn hives from server data
    local spawnedCount = 0
    for hiveId, hiveData in pairs(serverHives) do
        local location = {
            x = hiveData.x,
            y = hiveData.y,
            z = hiveData.z,
            heading = hiveData.heading,
            zOffset = 0.5
        }
        
        -- Spawn the visual hive
        SpawnWildHiveAtLocation(hiveData.index, location, hiveId)
        spawnedCount = spawnedCount + 1
    end
    
    print("^2[MMS-Beekeeper]^7 Client spawned " .. spawnedCount .. " server-synced wild hives")
end)

-- Request wild hives from server on join
RegisterNetEvent('mms-beekeeper:client:SpawnWildBeehives', function()
    -- Request server-synced hives instead of spawning client-side
    TriggerServerEvent('mms-beekeeper:server:RequestWildHives')
end)

function ClearAllWildHives()
    -- Stop all wild hive sounds first
    SendNUIMessage({
        action = 'stopWildBeeSound'
    })
    
    for hiveId, hiveData in pairs(ActiveWildHives) do
        -- Remove zone target
        if hiveData.zoneName then
            pcall(function()
                exports['qb-target']:RemoveZone(hiveData.zoneName)
            end)
        end
        
        -- Delete object
        if DoesEntityExist(hiveData.object) then
            DeleteEntity(hiveData.object)
        end
    end
    ActiveWildHives = {}
    WildHiveCooldowns = {}
    WildHiveSounds = {}
    print("^3[MMS-Beekeeper]^7 Cleared all wild hives, zones, sounds, and markers")
end

function SpawnRandomWildHives(count)
    local spawned = 0
    local attempts = 0
    local maxAttempts = count * 3 -- Prevent infinite loops
    
    while spawned < count and attempts < maxAttempts do
        attempts = attempts + 1
        
        -- Get random location from config
        local randomIndex = math.random(1, #Config.WildBeehives)
        local location = Config.WildBeehives[randomIndex]
        
        -- Check if location is far enough from existing hives
        if IsLocationValid(location) then
            SpawnWildHiveAtLocation(randomIndex, location)
            spawned = spawned + 1
        end
    end
    
    print("^2[MMS-Beekeeper]^7 Spawned " .. spawned .. " wild beehives")
end

function IsLocationValid(location)
    for k, v in pairs(ActiveWildHives) do
        local distance = #(vector3(location.x, location.y, location.z) - v.coords)
        if distance < Config.WildBeehiveMinDistance then
            return false
        end
    end
    return true
end

function SpawnWildHiveAtLocation(index, location, serverId)
    local model = GetHashKey(Config.WildBeehiveModel)
    RequestModel(model)
    local timeout = 0
    while not HasModelLoaded(model) and timeout < 100 do
        Wait(10)
        timeout = timeout + 1
    end
    
    if not HasModelLoaded(model) then
        print("^1[MMS-Beekeeper ERROR]^7 Failed to load model for wild hive at index " .. index)
        return
    end
    
    -- Find ground Z at target XY to prevent floating hives
    local x, y, z = location.x + 0.0, location.y + 0.0, (location.z or 0.0) + 100.0
    local found, groundZ = GetGroundZFor_3dCoord(x, y, z, false)
    local placeZ = found and (groundZ + (location.zOffset or 0.5)) or (location.z or z)
    
    local wildHive = CreateObject(model, x, y, placeZ, true, false, false) -- network = true
    if not DoesEntityExist(wildHive) then
        print("^1[MMS-Beekeeper ERROR]^7 Failed to create wild hive entity at index " .. index)
        return
    end
    
    PlaceObjectOnGroundProperly(wildHive)
    SetEntityHeading(wildHive, (location.heading or 0.0))
    FreezeEntityPosition(wildHive, true)
    SetEntityAsMissionEntity(wildHive, true, true)
    
    -- Use server ID if provided (for server-synced hives), otherwise generate client ID
    local hiveId = serverId or ("wild_" .. index .. "_" .. GetGameTimer())
    local hiveCoords = GetEntityCoords(wildHive)
    ActiveWildHives[hiveId] = {
        object = wildHive,
        coords = hiveCoords,
        data = location,
        spawnTime = GetGameTimer(),
        originalIndex = index,
        zoneName = "wild_beehive_" .. hiveId,
        serverSynced = serverId ~= nil  -- Track if this is server-synced
    }
    
    print("^2[MMS-Beekeeper]^7 Spawned wild hive #" .. index .. " at coords: " .. hiveCoords.x .. ", " .. hiveCoords.y .. ", " .. hiveCoords.z .. " | Entity: " .. wildHive .. " | HiveId: " .. hiveId .. " | Server-synced: " .. tostring(serverId ~= nil))
    
    -- Wait for entity to be fully registered
    Wait(100)
    
    -- Use BoxZone targeting instead of entity targeting for bushes (more reliable)
    local zoneName = "wild_beehive_" .. hiveId
    local targetSuccess = pcall(function()
        exports['qb-target']:AddBoxZone(zoneName, vector3(hiveCoords.x, hiveCoords.y, hiveCoords.z), 2.0, 2.0, {
            name = zoneName,
            heading = location.heading or 0.0,
            debugPoly = Config.Debug,
            minZ = hiveCoords.z - 1.0,
            maxZ = hiveCoords.z + 2.0,
        }, {
            options = {
                {
                    type = "client",
                    event = "mms-beekeeper:client:InteractWildHive",
                    icon = "fas fa-bug-slash",
                    label = "Catch Wild Bees 🐝",
                    hiveId = hiveId,
                    canInteract = function()
                        return not WildHiveBusy
                    end
                }
            },
            distance = 2.5
        })
    end)
    
    if targetSuccess then
        print("^2[MMS-Beekeeper]^7 ✓ Added qb-target BoxZone to wild hive " .. hiveId)
    else
        print("^1[MMS-Beekeeper ERROR]^7 Failed to add qb-target zone to wild hive " .. hiveId)
    end
    
    -- Start ambient sound for wild hive
    StartWildHiveSound(hiveId, hiveCoords)
end

-----------------------------------------------
--------------- Wild Hive Sound Management ----
-----------------------------------------------

function StartWildHiveSound(hiveId, coords)
    if not Config.UseWildHiveSounds then return end
    
    -- Mark this wild hive for sound (proximity system will handle playback)
    WildHiveSounds[hiveId] = true
    
    print("^2[MMS-Beekeeper]^7 Wild hive " .. hiveId .. " marked for sound | Radius: " .. Config.WildHiveSoundRadius .. "m")
end

function StopWildHiveSound(hiveId)
    WildHiveSounds[hiveId] = nil
    
    -- Send NUI message to stop the wild bee sound immediately
    SendNUIMessage({
        action = 'stopWildBeeSound'
    })
    
    print("^3[MMS-Beekeeper]^7 Stopped wild hive sound for hive " .. hiveId)
end

-- Proximity-based sound system for wild hives
CreateThread(function()
    local lastWildSoundTime = 0
    local wildSoundCooldown = Config.WildHiveSoundCooldown or 40000 -- Use config value (40 seconds for full sound playback)
    
    while true do
        Wait(500) -- Check every half second
        
        if Config.UseWildHiveSounds then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            
            -- Check if player is near any wild hive
            for hiveId, hasSound in pairs(WildHiveSounds) do
                if hasSound and ActiveWildHives[hiveId] then
                    local hiveCoords = ActiveWildHives[hiveId].coords
                    local distance = #(playerCoords - hiveCoords)
                    
                    if distance < (Config.WildHiveSoundRadius or 20.0) then
                        -- Play sound if enough time has passed
                        if GetGameTimer() - lastWildSoundTime > wildSoundCooldown then
                            -- Calculate volume based on distance (closer = louder)
                            local volume = math.max(0.15, 1.0 - (distance / Config.WildHiveSoundRadius))
                            
                            -- Play custom WILD bee buzzing sound (different from placed hives)
                            SendNUIMessage({
                                action = 'playWildBeeSound',  -- Different action for wild hives!
                                volume = volume * 0.8, -- Slightly quieter for wild hives
                                loop = false
                            })
                            
                            lastWildSoundTime = GetGameTimer()
                            
                            if Config.Debug then
                                print("^3[MMS-Beekeeper]^7 Playing WILD bee sound near hive " .. hiveId .. " | Distance: " .. math.floor(distance) .. "m | Volume: " .. string.format("%.2f", volume * 0.8))
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end)

function StartWildHiveRotation()
    CreateThread(function()
        while true do
            Wait(60000) -- Check every minute
            WildHiveRotationTimer = WildHiveRotationTimer + 1
            
            -- Check if it's time to rotate hives (30 minutes)
            if WildHiveRotationTimer >= Config.WildBeehiveRotationTime then
                RotateWildHives()
                WildHiveRotationTimer = 0
            end
        end
    end)
end

function RotateWildHives()
    print("^2[MMS-Beekeeper]^7 Rotating wild beehives...")
    
    -- Remove all current hives
    ClearAllWildHives()
    
    -- Spawn new random hives
    SpawnRandomWildHives(Config.WildBeehiveMaxActive)
end

-- Admin command to spawn all wild hives for testing
RegisterNetEvent('mms-beekeeper:client:SpawnAllWildHives', function()
    print("^2[MMS-Beekeeper]^7 Admin spawning all wild hives for testing...")
    
    -- Clear any existing hives
    ClearAllWildHives()
    
    -- Spawn all 100 hives
    for k, v in ipairs(Config.WildBeehives) do
        SpawnWildHiveAtLocation(k, v)
    end
    
    print("^2[MMS-Beekeeper]^7 Spawned all " .. #Config.WildBeehives .. " wild beehives for testing")
    QBCore.Functions.Notify('All ' .. #Config.WildBeehives .. ' wild beehives spawned for testing!', 'success', 10000)
end)

-- Admin command to clear all wild hives
RegisterNetEvent('mms-beekeeper:client:ClearAllWildHives', function()
    print("^2[MMS-Beekeeper]^7 Admin clearing all wild hives...")
    
    local clearedCount = 0
    for k, v in pairs(ActiveWildHives) do
        if DoesEntityExist(v.object) then
            DeleteEntity(v.object)
            clearedCount = clearedCount + 1
        end
    end
    
    ActiveWildHives = {}
    
    print("^2[MMS-Beekeeper]^7 Cleared " .. clearedCount .. " wild beehives")
    QBCore.Functions.Notify('Cleared ' .. clearedCount .. ' wild beehives!', 'success', 5000)
end)

-- New minigame-based interaction for wild hives
RegisterNetEvent('mms-beekeeper:client:InteractWildHive', function(data)
    if WildHiveBusy then 
        QBCore.Functions.Notify('Already interacting with a hive', 'error')
        return 
    end
    
    local hiveId = data.hiveId
    local hiveData = ActiveWildHives[hiveId]
    
    if not hiveData then
        QBCore.Functions.Notify('Hive not found', 'error')
        return
    end
    
    -- Check cooldown
    if WildHiveCooldowns[hiveId] and WildHiveCooldowns[hiveId] > GetGameTimer() then
        local secondsLeft = math.ceil((WildHiveCooldowns[hiveId] - GetGameTimer()) / 1000)
        QBCore.Functions.Notify('This hive is still recovering ('..secondsLeft..'s)', 'error')
        return
    end
    
    -- Check for required items: smoker AND bugnet
    QBCore.Functions.TriggerCallback('mms-beekeeper:server:hasWildHiveItems', function(hasItems)
        if not hasItems then
            QBCore.Functions.Notify('You need a Torch Smoker and Bug Net to catch bees!', 'error')
            return
        end
        
        WildHiveBusy = true
        
        -- PRE-ROLL the loot tier to determine minigame difficulty
        -- The better the potential reward, the harder the minigame!
        local randRoll = math.random(1, 10000)
        local lootTier = ""
        local minigameDifficulty = "easy"
        local minigameRounds = 2
        local minigameTime = 8.0
        
        if randRoll <= 5000 then
            -- 50% - Common: Easy difficulty - ONE MISS = INSTANT FAIL
            lootTier = "Common"
            minigameDifficulty = "easy"
            minigameRounds = 1  -- Just 1 perfect hit needed
            minigameTime = 5.0  -- 5 seconds
        elseif randRoll <= 7500 then
            -- 25% - Uncommon: Medium difficulty - ONE MISS = INSTANT FAIL
            lootTier = "Uncommon"
            minigameDifficulty = "medium"
            minigameRounds = 2  -- 2 perfect hits needed
            minigameTime = 8.0  -- 8 seconds
        elseif randRoll <= 8750 then
            -- 12.5% - Rare: Hard difficulty - ONE MISS = INSTANT FAIL
            lootTier = "Rare"
            minigameDifficulty = "hard"
            minigameRounds = 3  -- 3 perfect hits needed
            minigameTime = 10.0  -- 10 seconds
        else
            -- 12.5% - Epic: Extreme difficulty - ONE MISS = INSTANT FAIL
            lootTier = "Epic"
            minigameDifficulty = "extreme"
            minigameRounds = 4  -- 4 perfect hits needed
            minigameTime = 12.0  -- 12 seconds
        end
        
        -- Show what's at stake
        local tierHints = {
            Common = "Common bees detected",
            Uncommon = "Uncommon swarm detected!",
            Rare = "Rare wasps detected!!",
            Epic = "EPIC SWARM DETECTED!!!"
        }
        QBCore.Functions.Notify('🐝 ' .. tierHints[lootTier], 'primary', 3000)
        Wait(500)
        
        -- Start the minigame with difficulty matching the loot tier
        -- Using bee sprite marker and honey-colored zones
        print("^2[MMS-Beekeeper]^7 Starting minigame - Difficulty: " .. minigameDifficulty .. " | Rounds: " .. minigameRounds .. " | Tier: " .. lootTier)
        
        -- Show help text instruction
        QBCore.Functions.Notify('Press E when the bee is in the honey!', 'primary', 5000)
        Wait(1000) -- Give player time to read the instruction
        
        -- Start drawing help text at top of screen during minigame
        local showingMinigame = true
        CreateThread(function()
            while showingMinigame do
                SetTextFont(4)
                SetTextScale(0.5, 0.5)
                SetTextColour(255, 200, 0, 255) -- Gold/honey color
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(2, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextCentre(true)
                BeginTextCommandDisplayText("STRING")
                AddTextComponentString("~y~Press ~g~E~y~ when the ~o~bee~y~ is in the ~o~honey~y~!")
                EndTextCommandDisplayText(0.5, 0.05) -- Top center of screen
                Wait(0)
            end
        end)
        
        local minigameResult = exports['jl_minigame']:Play({
            difficulty = minigameDifficulty,  -- Difficulty scales with reward tier!
            rounds = minigameRounds,          -- More rounds for better rewards
            timeLimit = minigameTime,         -- Time scales with difficulty
            showHelpText = true,
        })
        
        -- Stop drawing help text
        showingMinigame = false
        
        -- Debug output - show exact result
        print("^3[MMS-Beekeeper DEBUG]^7 Minigame completed! Result type: " .. type(minigameResult) .. " | Value: " .. tostring(minigameResult))
        print("^3[MMS-Beekeeper DEBUG]^7 Checking result... (result == true)? " .. tostring(minigameResult == true))
        print("^3[MMS-Beekeeper DEBUG]^7 Checking result... (result == false)? " .. tostring(minigameResult == false))
        
        if minigameResult == true then
            print("^2[MMS-Beekeeper]^7 ===== ENTERING SUCCESS BRANCH =====")
            -- SUCCESS: Now player can search/collect from the hive
            QBCore.Functions.Progressbar("wild_hive_collect", "Collecting from the hive...", 3000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@world_human_gardener_plant@male@base",
                anim = "base",
                flags = 49,
            }, {}, {}, function() -- Done
                ClearPedTasks(PlayerPedId())
                
                -- Give rewards and despawn/respawn hive (pass the pre-rolled tier to server)
                TriggerServerEvent('mms-beekeeper:server:WildHiveSuccess', hiveId, hiveData.originalIndex, lootTier)
                
                -- If this is a server-synced hive, notify server to remove and respawn
                if hiveData.serverSynced then
                    TriggerServerEvent('mms-beekeeper:server:RemoveWildHive', hiveId, hiveData.originalIndex)
                    -- Server will sync the new hive location to all clients
                else
                    -- Client-side only hive (legacy system)
                    DespawnWildHive(hiveId)
                    RespawnWildHiveElsewhere(hiveData.originalIndex)
                end
                
                QBCore.Functions.Notify('Successfully collected bees! The hive moved to a new location.', 'success', 5000)
                
                WildHiveBusy = false
            end, function() -- Cancel
                ClearPedTasks(PlayerPedId())
                WildHiveBusy = false
                QBCore.Functions.Notify('Cancelled', 'error')
            end)
        elseif minigameResult == false or minigameResult == nil or minigameResult == 'timeout' then
            print("^1[MMS-Beekeeper]^7 ===== ENTERING FAIL BRANCH =====")
            -- FAIL: Player failed the minigame, timed out, or didn't complete
            print("^1[MMS-Beekeeper]^7 Player FAILED minigame! Result was: " .. tostring(minigameResult))
            print("^1[MMS-Beekeeper]^7 Applying bee sting punishment...")
            
            -- Apply bee sting punishment
            ApplyBeeSting()
            
            -- Set cooldown on this specific hive
            WildHiveCooldowns[hiveId] = GetGameTimer() + 30000 -- 30 second cooldown
            print("^3[MMS-Beekeeper]^7 Cooldown applied. Can retry after: " .. (GetGameTimer() + 30000))
            
            -- Show failure message with tier info
            local failMessages = {
                Common = "The bees got away!",
                Uncommon = "The swarm was too quick for you!",
                Rare = "The wasps stung you badly!",
                Epic = "The EPIC swarm overwhelmed you!"
            }
            QBCore.Functions.Notify('🐝 ' .. (failMessages[lootTier] or "Failed!") .. ' Try again in 30s.', 'error', 5000)
            
            WildHiveBusy = false
        else
            -- Unknown result - treat as fail
            print("^3[MMS-Beekeeper WARN]^7 Unexpected minigame result: " .. tostring(minigameResult))
            WildHiveBusy = false
        end
    end)
end)

-- Apply sting effects when player fails
function ApplyBeeSting()
    local ped = PlayerPedId()
    
    print("^1[MMS-Beekeeper]^7 Applying bee sting effects to player...")
    
    -- Camera shake (more intense)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.5)
    
    -- Reduce health (10 HP damage)
    local currentHealth = GetEntityHealth(ped)
    local newHealth = math.max(100, currentHealth - 10)
    SetEntityHealth(ped, newHealth)
    print("^1[MMS-Beekeeper]^7 Health reduced: " .. currentHealth .. " -> " .. newHealth)
    
    -- Play custom bee sting sound effect (OUCH!)
    SendNUIMessage({
        action = 'playStingSound',
        volume = 1.0
    })
    print("^1[MMS-Beekeeper]^7 Playing custom bee sting sound!")
    
    -- Ragdoll effect (player falls)
    SetPedToRagdoll(ped, 1500, 1500, 0, true, true, false)
    
    -- Screen effect with proper cleanup
    CreateThread(function()
        -- Stop any existing effects first
        AnimpostfxStopAll()
        
        -- Apply sting visual effect
        AnimpostfxPlay("MenuMGHeistIn", 2000, false)
        
        -- Ensure it stops after duration
        Wait(2000)
        AnimpostfxStop("MenuMGHeistIn")
        AnimpostfxStopAll() -- Safety cleanup
        
        print("^1[MMS-Beekeeper]^7 Screen effect cleared")
    end)
    
    print("^1[MMS-Beekeeper]^7 Bee sting effects applied!")
end

-- Despawn a specific wild hive
function DespawnWildHive(hiveId)
    local hiveData = ActiveWildHives[hiveId]
    if hiveData then
        -- Stop sound
        StopWildHiveSound(hiveId)
        
        -- Remove zone target
        if hiveData.zoneName then
            pcall(function()
                exports['qb-target']:RemoveZone(hiveData.zoneName)
            end)
            print("^3[MMS-Beekeeper]^7 Removed target zone: " .. hiveData.zoneName)
        end
        
        -- Delete object
        if DoesEntityExist(hiveData.object) then
            DeleteEntity(hiveData.object)
            print("^3[MMS-Beekeeper]^7 Deleted wild hive entity: " .. hiveId)
        end
    end
    ActiveWildHives[hiveId] = nil
    WildHiveCooldowns[hiveId] = nil
end

-- Respawn wild hive at a different location (excluding the current one)
function RespawnWildHiveElsewhere(currentIndex)
    local attempts = 0
    local maxAttempts = 20
    
    while attempts < maxAttempts do
        attempts = attempts + 1
        
        -- Pick a random index that's NOT the current one
        local randomIndex = math.random(1, #Config.WildBeehives)
        if randomIndex ~= currentIndex then
            local location = Config.WildBeehives[randomIndex]
            
            -- Check if this location is already occupied or too close to other hives
            local isOccupied = false
            for _, hive in pairs(ActiveWildHives) do
                if hive.originalIndex == randomIndex then
                    isOccupied = true
                    break
                end
            end
            
            if not isOccupied and IsLocationValid(location) then
                SpawnWildHiveAtLocation(randomIndex, location)
                return
            end
        end
    end
    
    -- If we couldn't find a good spot, just spawn at a random location anyway
    local randomIndex = math.random(1, #Config.WildBeehives)
    if randomIndex ~= currentIndex then
        local location = Config.WildBeehives[randomIndex]
        SpawnWildHiveAtLocation(randomIndex, location)
    end
end

-- OLD MENU SYSTEM (KEPT FOR REFERENCE, CAN BE REMOVED)
function OpenWildBeehiveMenu(hiveId, hiveData)
    local menuOptions = {
        {
            header = "🌿 Wild Beehive",
            txt = "Collect resources from this wild hive",
            isMenuHeader = true
        },
        {
            header = "🐝 Collect Bees",
            txt = "Collect bees from the wild hive",
            params = {
                event = "mms-beekeeper:client:CollectBeesFromWild",
                args = {
                    hiveId = hiveId,
                    originalIndex = ActiveWildHives[hiveId] and ActiveWildHives[hiveId].originalIndex or 1
                }
            }
        },
        {
            header = "👑 Collect Queen",
            txt = "Collect queen from the wild hive",
            params = {
                event = "mms-beekeeper:client:CollectQueenFromWild",
                args = {
                    hiveId = hiveId,
                    originalIndex = ActiveWildHives[hiveId] and ActiveWildHives[hiveId].originalIndex or 1
                }
            }
        },
        {
            header = "🍯 Collect Honey",
            txt = "Collect honey from the wild hive",
            params = {
                event = "mms-beekeeper:client:CollectHoneyFromWild",
                args = {
                    hiveId = hiveId,
                    originalIndex = ActiveWildHives[hiveId] and ActiveWildHives[hiveId].originalIndex or 1
                }
            }
        },
        {
            header = "❌ Close",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        }
    }
    
    exports['qb-menu']:openMenu(menuOptions)
end

RegisterNetEvent('mms-beekeeper:client:CollectBeesFromWild', function(data)
    QBCore.Functions.Progressbar("collect_bees", "Collecting Bees...", Config.GetBeeTime * 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent('mms-beekeeper:server:GetBeeFromWild', data.originalIndex)
    end, function() -- Cancel
        QBCore.Functions.Notify('Cancelled', 'error')
    end)
end)

RegisterNetEvent('mms-beekeeper:client:CollectQueenFromWild', function(data)
    QBCore.Functions.Progressbar("collect_queen", "Collecting Queen...", Config.GetQueenTime * 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_common",
        anim = "givetake1_a",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent('mms-beekeeper:server:GetQueenFromWild', data.originalIndex)
    end, function() -- Cancel
        QBCore.Functions.Notify('Cancelled', 'error')
    end)
end)

RegisterNetEvent('mms-beekeeper:client:CollectHoneyFromWild', function(data)
    local wildHive = ActiveWildHives[data.hiveId]
    if wildHive then
        QBCore.Functions.Progressbar("collect_honey_wild", "Collecting Honey...", wildHive.data.TakeProductTime * 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "mp_common",
            anim = "givetake1_a",
            flags = 49,
        }, {}, {}, function() -- Done
            TriggerServerEvent('mms-beekeeper:server:TakeProductFromWild', data.originalIndex)
        end, function() -- Cancel
            QBCore.Functions.Notify('Cancelled', 'error')
        end)
    else
        QBCore.Functions.Notify('Wild hive not found', 'error', 3000)
    end
end)

-----------------------------------------------
--------------- Tools --------------------------
-----------------------------------------------

RegisterNetEvent('mms-beekeeper:client:UseSmoker', function()
    QBCore.Functions.Notify("Smoker activated! Use it near beehives to calm bees.", 'primary', 5000)
    -- Add smoker effects here
end)

RegisterNetEvent('mms-beekeeper:client:UseBugNet', function()
    QBCore.Functions.Notify("Bug net ready! Use it to catch bees from wild hives.", 'primary', 5000)
    -- Add bug net effects here
end)

-----------------------------------------------
--------------- Admin Commands ----------------
-----------------------------------------------

-- Admin commands are handled server-side in server.lua
-- Use: /getbeehive and /getbeeitems

-- Toggle wild hive sounds on/off
RegisterCommand('togglewildhivesounds', function()
    Config.UseWildHiveSounds = not Config.UseWildHiveSounds
    
    if Config.UseWildHiveSounds then
        QBCore.Functions.Notify('Wild hive sounds ENABLED - respawn hives to hear them', 'success', 5000)
        -- Restart sounds for all active wild hives
        for hiveId, hiveData in pairs(ActiveWildHives) do
            StartWildHiveSound(hiveId, hiveData.coords)
        end
    else
        QBCore.Functions.Notify('Wild hive sounds DISABLED', 'error', 5000)
        -- Stop all wild hive sounds
        for hiveId, _ in pairs(WildHiveSounds) do
            StopWildHiveSound(hiveId)
        end
    end
end, false)

-- List all active wild hive sounds
RegisterCommand('listwildhivesounds', function()
    local count = 0
    for k, v in pairs(WildHiveSounds) do
        count = count + 1
        print("^2[MMS-Beekeeper]^7 Wild Hive Sound: " .. k .. " | Sound ID: " .. v)
    end
    QBCore.Functions.Notify('Active wild hive sounds: ' .. count .. ' (check F8 console)', 'primary', 5000)
    print("^2[MMS-Beekeeper]^7 Total active wild hive sounds: " .. count)
end, false)

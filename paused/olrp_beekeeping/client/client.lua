-- QBCore Beekeeping Client Side - Complete Advanced Version
local QBCore = exports['qb-core']:GetCoreObject()

---- LOCALS ---
CreatedBeehives = CreatedBeehives or {}
local CreatedBlips = {}
local BeehiveData = nil
local ThreadRunning = false
local ActiveWildHives = {}
local SmokedBeehives = {}
local TakenBeeBeehives = {}
local TakenQueenBeehives = {}
local TakenHoneyBeehives = {}
local CreatedFXSwarms = {}
local WildHiveSpawned = false
local PlayerData = {}
local HiveSounds = {} -- Store sound IDs for each hive

-----------------------------------------------
--------------- Initialize -------------------
-----------------------------------------------

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent('mms-beekeeper:server:LoadBeehives')
    
    -- Spawn wild beehives
    if Config.WildBeehiveSpawn then
        TriggerEvent('mms-beekeeper:client:SpawnWildBeehives')
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    
    -- Clean up beehive objects
    for k, v in pairs(CreatedBeehives) do
        if DoesEntityExist(v.object) then
            DeleteEntity(v.object)
        end
    end
    CreatedBeehives = {}
    
    -- Clean up blips
    for k, v in pairs(CreatedBlips) do
        RemoveBlip(v)
    end
    CreatedBlips = {}
    
    -- Clear sound markers
    HiveSounds = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

-----------------------------------------------
--------------- Debug ------------------------
-----------------------------------------------

CreateThread(function()
    if Config.Debug then
        Wait(3000)
        print("^2[MMS-Beekeeper]^7 Client loaded successfully!")
    end
end)

-----------------------------------------------
--------------- Load Beehives -----------------
-----------------------------------------------

RegisterNetEvent('mms-beekeeper:client:LoadBeehives', function(Beehives)
    -- If this is a single hive update (not a full reload)
    if Beehives and #Beehives == 1 and Beehives[1].id then
        local v = Beehives[1]
        local Data = (type(v.data) == 'string') and json.decode(v.data) or (v.data or {})
        local existing = CreatedBeehives[v.id]
        
        -- Get fresh player data to avoid nil errors
        local freshPlayerData = QBCore.Functions.GetPlayerData()
        local playerName = "Unknown"
        if freshPlayerData and freshPlayerData.charinfo then
            playerName = freshPlayerData.charinfo.firstname .. " " .. freshPlayerData.charinfo.lastname
        end
        
        local isOwner = (existing and existing.isOwner) or (v.owner == playerName)
        print("^2[MMS-Beekeeper]^7 Single hive update. HiveID:", v.id, "owner from server:", tostring(v.owner), "client player name:", tostring(playerName), "isOwner:", tostring(isOwner))
        
        -- Remove existing hive if it exists
        if existing then
            if DoesEntityExist(existing.object) then
                DeleteEntity(existing.object)
            end
            if CreatedBlips[v.id] then RemoveBlip(CreatedBlips[v.id]) end
        end
        
        -- Create the new/updated hive
        CreateBeehiveProp(v.id, v.coords, v.heading, Data, v.modelName or "", isOwner, v.owner)
        return
    end
    
    -- Full reload - clear all existing hives
    for k, v in pairs(CreatedBeehives) do
        if DoesEntityExist(v.object) then
            DeleteEntity(v.object)
        end
    end
    CreatedBeehives = {}
    
    for k, v in pairs(CreatedBlips) do
        RemoveBlip(v)
    end
    CreatedBlips = {}
    
    if Beehives then
        -- Get fresh player data for comparison
        local freshPlayerData = QBCore.Functions.GetPlayerData()
        local playerName = "Unknown"
        if freshPlayerData and freshPlayerData.charinfo then
            playerName = freshPlayerData.charinfo.firstname .. " " .. freshPlayerData.charinfo.lastname
        end
        
        for h, v in ipairs(Beehives) do
            local Data = (type(v.data) == 'string') and json.decode(v.data) or (v.data or {})
            local isOwner = (v.owner == playerName)
            if Config.Debug then
                print("^2[MMS-Beekeeper]^7 Full reload add hive. HiveID:", v.id, "owner:", tostring(v.owner), "client player name:", tostring(playerName), "isOwner:", tostring(isOwner))
            end
            CreateBeehiveProp(v.id, v.coords, v.heading, Data, "", isOwner, v.owner)
        end
    end
    
    -- Wild beehives are now spawned via the event triggered on player load (line 29)
    -- No need to call SpawnWildBeehives() here as it's handled by the dynamic system
end)

-----------------------------------------------
--------------- Create Beehive ----------------
-----------------------------------------------

RegisterNetEvent('mms-beekeeper:client:CreateBeehive', function()
    print("^2[MMS-Beekeeper]^7 CreateBeehive event received on client")
    local ped = PlayerPedId()
    local chosenModelName = 'bzzz_props_beehive_box_001'
    if Config.UseRandomHive then
        local RandomProp = Config.Props[math.random(1, #Config.Props)]
        chosenModelName = RandomProp.BeehiveBox
    end
    local model = GetHashKey(chosenModelName)

    print("^2[MMS-Beekeeper]^7 Attempting to load model:", chosenModelName, "hash:", model)
    RequestModel(model)
    local waited = 0
    while not HasModelLoaded(model) do 
        Wait(50)
        waited = waited + 50
        if waited % 1000 == 0 then
            print("^3[MMS-Beekeeper]^7 Waiting for model to load:", chosenModelName, "elapsed(ms):", waited)
        end
        if waited > 10000 then
            print("^1[MMS-Beekeeper]^7 ERROR: Model failed to load:", chosenModelName, "after", waited, "ms")
            QBCore.Functions.Notify("Failed to load hive model " .. tostring(chosenModelName) .. ". Is the beehive pack started?", 'error', 7000)
            return
        end
    end
    print("^2[MMS-Beekeeper]^7 Model loaded:", chosenModelName)

    -- create ghost preview
    local ghost = CreateObject(model, 0.0, 0.0, 0.0, false, false, false)
    SetEntityAlpha(ghost, 155, false)
    SetEntityCollision(ghost, false, false)
    FreezeEntityPosition(ghost, true)

    local placeDist = 1.5
    local heading = GetEntityHeading(ped)
    QBCore.Functions.Notify("Use [E] to place, [Q] to cancel, [←/→] rotate, [↑/↓] distance", 'primary', 7000)

    local placing = true
    local zOffset = 0.0
    CreateThread(function()
        while placing do
            Wait(0)
            local pcoords = GetEntityCoords(ped)
            local forward = GetEntityForwardVector(ped)
            local target = pcoords + (forward * placeDist)

            -- find ground Z under target
            local retval, groundZ = GetGroundZFor_3dCoord(target.x, target.y, target.z + 50.0, false)
            local baseZ = retval and groundZ or target.z
            local pos = vector3(target.x, target.y, baseZ + zOffset)

            SetEntityCoordsNoOffset(ghost, pos.x, pos.y, pos.z, false, false, false)
            SetEntityHeading(ghost, heading)

            -- rotate
            if IsControlJustPressed(0, 174) then -- Left Arrow
                heading = (heading - 5.0) % 360.0
            elseif IsControlJustPressed(0, 175) then -- Right Arrow
                heading = (heading + 5.0) % 360.0
            end

            -- distance adjust
            if IsControlJustPressed(0, 172) then -- Up Arrow
                placeDist = math.min(placeDist + 0.25, 5.0)
            elseif IsControlJustPressed(0, 173) then -- Down Arrow
                placeDist = math.max(placeDist - 0.25, 0.75)
            end

            -- height adjust
            if IsControlJustPressed(0, 10) then -- PageUp
                zOffset = math.min(zOffset + 0.1, 3.0)
            elseif IsControlJustPressed(0, 11) then -- PageDown
                zOffset = math.max(zOffset - 0.1, -1.0)
            end

            -- confirm / cancel
            if IsControlJustPressed(0, 38) then -- E
                placing = false
                DeleteObject(ghost)
                print("^2[MMS-Beekeeper]^7 Sending PlaceBeehive to server:", json.encode({x=pos.x,y=pos.y,z=pos.z, h=heading, model=chosenModelName}))
                TriggerServerEvent('mms-beekeeper:server:PlaceBeehive', pos, heading, chosenModelName)
                break
            elseif IsControlJustPressed(0, 44) then -- Q
                placing = false
                DeleteObject(ghost)
                QBCore.Functions.Notify("Placement cancelled", 'error', 3000)
                break
            end

            -- hint text
            QBCore.Functions.DrawText3D(pos.x, pos.y, pos.z + 1.0, "[E] Place  [Q] Cancel  [←/→] Rotate  [↑/↓] Distance  [PgUp/PgDn] Height")
        end
    end)
end)

RegisterNetEvent('mms-beekeeper:client:BeehivePlaced', function(HiveID, coords, heading, modelName)
    -- Get fresh player data to avoid nil errors
    local freshPlayerData = QBCore.Functions.GetPlayerData()
    local playerName = "Unknown"
    if freshPlayerData and freshPlayerData.charinfo then
        playerName = freshPlayerData.charinfo.firstname .. " " .. freshPlayerData.charinfo.lastname
    end
    
    CreateBeehiveProp(HiveID, coords, heading, {}, modelName, true, playerName) -- true because player just placed it
end)

function CreateBeehiveProp(HiveID, coords, heading, Data, modelName, isOwner, ownerName)
    local model
    if modelName and modelName ~= '' then
        model = GetHashKey(modelName)
    else
        model = GetHashKey('prop_bush_lrg_01') -- fallback default
        if Config.UseRandomHive then
            local RandomProp = Config.Props[math.random(1, #Config.Props)]
            model = GetHashKey(RandomProp.BeehiveBox)
        end
    end
    
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    
    local beehive = CreateObject(model, coords.x, coords.y, coords.z, false, false, false)
    PlaceObjectOnGroundProperly(beehive)
    SetEntityHeading(beehive, heading)
    FreezeEntityPosition(beehive, true)
    
    CreatedBeehives[HiveID] = {
        object = beehive,
        coords = coords,
        heading = heading,
        data = Data,
        isOwner = isOwner
    }
    
    -- Create blip only if enabled and player owns the hive
    if Config.UseBlips and isOwner then
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, Config.BlipSprite) -- Use numeric sprite ID
        SetBlipScale(blip, Config.BlipScale)
        SetBlipColour(blip, Config.BlipColor or 5) -- Use config color
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        local blipName = ownerName and (ownerName .. "'s Beehive") or Config.BlipName
        AddTextComponentString(blipName)
        EndTextCommandSetBlipName(blip)
        CreatedBlips[HiveID] = blip
        print("^2[MMS-Beekeeper]^7 Created blip for hive " .. HiveID .. " | Sprite: " .. Config.BlipSprite .. " | Color: " .. (Config.BlipColor or 5))
    end
    
    -- Create qb-target interaction
    exports['qb-target']:AddTargetEntity(beehive, {
        options = {
            {
                type = "client",
                event = "mms-beekeeper:client:OpenBeehiveMenu",
                icon = "fas fa-bug",
                label = ownerName and (ownerName .. "'s Beehive") or "Beehive",
                targeticon = "fas fa-bug",
                job = Config.JobLock and Config.BeekeeperJobs or nil,
                hiveId = HiveID
            }
        },
        distance = 2.0
    })
    
    -- Start sound management for this hive
    ManageHiveSound(HiveID, Data)
end

-----------------------------------------------
--------------- Sound Management ---------------
-----------------------------------------------

function ManageHiveSound(HiveID, Data)
    -- Just mark if this hive should have sound (proximity system will handle actual playback)
    if Config.UseHiveSounds and Data and ((Data.Bees and Data.Bees > 0) or (Data.Queen and Data.Queen > 0)) then
        HiveSounds[HiveID] = true
        print("^2[MMS-Beekeeper]^7 Hive " .. HiveID .. " marked for sound | Bees: " .. (Data.Bees or 0) .. " | Queens: " .. (Data.Queen or 0))
    else
        HiveSounds[HiveID] = false
    end
end

-- Proximity-based sound system with custom bee sounds
CreateThread(function()
    local lastSoundTime = 0
    local soundCooldown = Config.HiveSoundCooldown or 40000 -- Use config value (40 seconds for full sound playback)
    local currentlyNearHive = false
    
    while true do
        Wait(500) -- Check every half second for better responsiveness
        
        if Config.UseHiveSounds then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local nearHive = false
            local closestDistance = 999
            
            -- Check if player is near any active hive
            for HiveID, hasSound in pairs(HiveSounds) do
                if hasSound and CreatedBeehives[HiveID] then
                    local hiveCoords = CreatedBeehives[HiveID].coords
                    local distance = #(playerCoords - hiveCoords)
                    
                    if distance < (Config.HiveSoundRadius or 15.0) then
                        nearHive = true
                        if distance < closestDistance then
                            closestDistance = distance
                        end
                        
                        -- Play sound if enough time has passed
                        if GetGameTimer() - lastSoundTime > soundCooldown then
                            -- Calculate volume based on distance (closer = louder)
                            local volume = math.max(0.1, 1.0 - (distance / Config.HiveSoundRadius))
                            
                            -- Play custom bee buzzing sound
                            SendNUIMessage({
                                action = 'playBeeSound',
                                volume = volume,
                                loop = false
                            })
                            
                            lastSoundTime = GetGameTimer()
                            
                            if Config.Debug then
                                print("^3[MMS-Beekeeper]^7 Playing custom bee sound near hive " .. HiveID .. " | Distance: " .. math.floor(distance) .. "m | Volume: " .. string.format("%.2f", volume))
                            end
                        end
                        break
                    end
                end
            end
            
            currentlyNearHive = nearHive
        end
    end
end)

-- Update hive sound when data changes
RegisterNetEvent('mms-beekeeper:client:UpdateHiveSound', function(HiveID, Data)
    if CreatedBeehives[HiveID] then
        CreatedBeehives[HiveID].data = Data
        ManageHiveSound(HiveID, Data)
    end
end)

-----------------------------------------------
--------------- Remove Beehive ----------------
-----------------------------------------------

RegisterNetEvent('mms-beekeeper:client:RemoveBeehive', function(HiveID)
    if CreatedBeehives[HiveID] then
        -- Remove sound marker
        HiveSounds[HiveID] = nil
        
        -- Remove qb-target from entity
        if DoesEntityExist(CreatedBeehives[HiveID].object) then
            exports['qb-target']:RemoveTargetEntity(CreatedBeehives[HiveID].object)
            DeleteEntity(CreatedBeehives[HiveID].object)
        end
        
        -- Remove the blip
        if CreatedBlips[HiveID] then
            RemoveBlip(CreatedBlips[HiveID])
            CreatedBlips[HiveID] = nil
        end
        
        -- Remove from tracking table
        CreatedBeehives[HiveID] = nil
        
        print("^2[MMS-Beekeeper]^7 Beehive " .. HiveID .. " removed successfully")
    end
end)

RegisterNetEvent('mms-beekeeper:client:RemoveAllBeehives', function()
    local removedCount = 0
    
    -- Delete all visual objects and blips
    for HiveID, hiveData in pairs(CreatedBeehives) do
        -- Remove qb-target and delete the visual object
        if DoesEntityExist(hiveData.object) then
            exports['qb-target']:RemoveTargetEntity(hiveData.object)
            DeleteEntity(hiveData.object)
        end
        
        -- Remove the blip
        if CreatedBlips[HiveID] then
            RemoveBlip(CreatedBlips[HiveID])
        end
        
        removedCount = removedCount + 1
    end
    
    -- Clear all tracking tables
    CreatedBeehives = {}
    CreatedBlips = {}
    HiveSounds = {}
    
    print("^2[MMS-Beekeeper]^7 Removed " .. removedCount .. " beehives from client")
    QBCore.Functions.Notify('All beehives have been removed from the server', 'primary', 5000)
end)

-----------------------------------------------
--------------- QB-Target Events ---------------
-----------------------------------------------

RegisterNetEvent('mms-beekeeper:client:OpenBeehiveMenu', function(data)
    local HiveID = data.hiveId
    if HiveID then
        TriggerServerEvent('mms-beekeeper:server:GetBeehiveData', HiveID)
    end
end)

-----------------------------------------------
--------------- Admin Commands ----------------
-----------------------------------------------

-- Toggle placed hive sounds on/off
RegisterCommand('togglehivesounds', function()
    Config.UseHiveSounds = not Config.UseHiveSounds
    
    if Config.UseHiveSounds then
        QBCore.Functions.Notify('Beehive sounds ENABLED - reload hives to hear them', 'success', 5000)
        -- Restart sounds for all created beehives
        for HiveID, hiveData in pairs(CreatedBeehives) do
            ManageHiveSound(HiveID, hiveData.data)
        end
    else
        QBCore.Functions.Notify('Beehive sounds DISABLED', 'error', 5000)
        -- Stop all beehive sounds
        for HiveID, soundId in pairs(HiveSounds) do
            StopSound(soundId)
            ReleaseSoundId(soundId)
        end
        HiveSounds = {}
    end
end, false)

-- List all active hive sounds
RegisterCommand('listhivesounds', function()
    local count = 0
    for k, v in pairs(HiveSounds) do
        count = count + 1
        print("^2[MMS-Beekeeper]^7 Hive Sound: " .. k .. " | Active: " .. tostring(v))
    end
    QBCore.Functions.Notify('Active beehive sounds: ' .. count .. ' (check F8 console)', 'primary', 5000)
    print("^2[MMS-Beekeeper]^7 Total active beehive sounds: " .. count)
end, false)

-- Test NUI communication
RegisterCommand('testnui', function()
    print("^3[MMS-Beekeeper]^7 Testing NUI communication...")
    QBCore.Functions.Notify('Sending test message to NUI - check F8 console', 'primary', 5000)
    
    SendNUIMessage({
        action = 'testSound'
    })
    
    print("^2[MMS-Beekeeper]^7 NUI message sent! Check browser console (F8 > Console tab)")
end, false)

-- Simple beep test to verify sound system works
RegisterCommand('testbeep', function()
    print("^3[MMS-Beekeeper]^7 Testing basic sound system with beep...")
    QBCore.Functions.Notify('Testing beep sound...', 'primary', 3000)
    
    -- Try multiple methods to play sound
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
    
    Wait(500)
    PlaySoundFrontend(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", false)
    
    print("^2[MMS-Beekeeper]^7 If you heard beeps, sound system works!")
    QBCore.Functions.Notify('Did you hear 2 beeps? Check F8', 'success', 5000)
end, false)

-- Test a sound at your location
RegisterCommand('testhivesound', function(source, args)
    local soundName = args[1] or Config.HiveSoundName
    local soundBank = args[2] or Config.HiveSoundBank
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    print("^3[MMS-Beekeeper]^7 Testing 3D sound: " .. soundName .. " from bank: " .. soundBank)
    print("^3[MMS-Beekeeper]^7 Player coords: " .. coords.x .. ", " .. coords.y .. ", " .. coords.z)
    QBCore.Functions.Notify('Playing 3D sound: ' .. soundName, 'primary', 5000)
    
    -- Method 1: Try PlaySoundFromCoord
    local testSoundId = GetSoundId()
    print("^3[MMS-Beekeeper]^7 Got Sound ID: " .. testSoundId)
    
    PlaySoundFromCoord(testSoundId, soundName, coords.x, coords.y, coords.z, soundBank, true, 15.0, false)
    print("^3[MMS-Beekeeper]^7 PlaySoundFromCoord called")
    
    -- Also try frontend version as fallback
    PlaySoundFrontend(-1, soundName, soundBank, false)
    print("^3[MMS-Beekeeper]^7 PlaySoundFrontend called as backup")
    
    -- Auto-stop after 10 seconds
    CreateThread(function()
        Wait(10000)
        StopSound(testSoundId)
        ReleaseSoundId(testSoundId)
        QBCore.Functions.Notify('Test sound stopped', 'success', 3000)
        print("^2[MMS-Beekeeper]^7 Test sound stopped")
    end)
end, false)

-- Test multiple known working sounds
RegisterCommand('testsounds', function()
    print("^3[MMS-Beekeeper]^7 Testing multiple sounds...")
    QBCore.Functions.Notify('Testing 5 different sounds...', 'primary', 3000)
    
    CreateThread(function()
        -- Test 1: Menu beep
        print("^3[MMS-Beekeeper]^7 Test 1: SELECT")
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
        Wait(1000)
        
        -- Test 2: Error sound
        print("^3[MMS-Beekeeper]^7 Test 2: ERROR")
        PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
        Wait(1000)
        
        -- Test 3: Checkpoint
        print("^3[MMS-Beekeeper]^7 Test 3: CHECKPOINT_PERFECT")
        PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", false)
        Wait(1000)
        
        -- Test 4: Cash register
        print("^3[MMS-Beekeeper]^7 Test 4: PURCHASE")
        PlaySoundFrontend(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", false)
        Wait(1000)
        
        -- Test 5: Phone
        print("^3[MMS-Beekeeper]^7 Test 5: Menu_Accept")
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", false)
        
        print("^2[MMS-Beekeeper]^7 Sound test complete! Did you hear 5 different sounds?")
        QBCore.Functions.Notify('Test complete! Check F8', 'success', 5000)
    end)
end, false)
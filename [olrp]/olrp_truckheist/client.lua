local QBCore = exports['qb-core']:GetCoreObject()

-- Variables
local isInHeist = false
local truckEntity = nil
local escortEntity = nil -- Escort vehicle
local truckBlip = nil
local deliveryBlip = nil
local guards = {}
local escortGuards = {} -- Guards in escort vehicle
local guardsExitedOnce = {} -- Track which guards have exited
local escortGuardsExitedOnce = {} -- Track escort guards exit
local currentHeist = nil
local truckExploded = false
local explosivePlanted = false
local trackerActive = false
local policeCount = 0 -- Current police count
local spawnedNPCs = {} -- Store spawned NPC entities
local infoPed = nil -- Info ped for intermediate location
local infoPedBlip = nil -- Blip for info ped location
local infoPedSpawned = false -- Track if info ped is spawned
local infoReceived = false -- Track if player has received info from ped

-- Helper Functions
function GetPlayerCoordsVector3()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    return vector3(coords.x, coords.y, coords.z)
end

function ShowNotification(message, type, duration)
    if Config.Notification == "qb-core" then
        -- Convert notification types to QB-Core compatible types
        local qbType = type
        if type == "info" then
            qbType = "primary"
        elseif type == "warning" then
            qbType = "error"
        end
        QBCore.Functions.Notify(message, qbType, duration or 5000)
    elseif Config.Notification == "ox_lib" then
        exports['ox_lib']:notify({
            title = "CIT Heist",
            description = message,
            type = type or "info",
            duration = duration or 5000
        })
    end
end

function Draw3DText(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
    end
end

function AllGuardsDead()
    local hasTrackedGuards = false

    for i, guard in pairs(guards) do
        if guard and DoesEntityExist(guard) then
            hasTrackedGuards = true
            if not IsEntityDead(guard) then
                return false
            end
        end
    end

    if hasTrackedGuards then
        return true
    end

    if truckEntity and DoesEntityExist(truckEntity) then
        local truckCoords = GetEntityCoords(truckEntity)
        local guardModels = {}
        if Config.Guards and Config.Guards.model then
            table.insert(guardModels, GetHashKey(Config.Guards.model))
        end
        if Config.Escort and Config.Escort.guards and Config.Escort.guards.model then
            table.insert(guardModels, GetHashKey(Config.Escort.guards.model))
        end

        if #guardModels > 0 then
            local guardCheckRadius = 60.0
            if Config.Guards and Config.Guards.checkRadius then
                guardCheckRadius = Config.Guards.checkRadius
            end

            local peds = {}
            if type(GetGamePool) == "function" then
                peds = GetGamePool('CPed')
            else
                local handle, ped = FindFirstPed()
                if handle ~= -1 then
                    local success = true
                    repeat
                        table.insert(peds, ped)
                        success, ped = FindNextPed(handle)
                    until not success
                    EndFindPed(handle)
                end
            end

            for _, ped in ipairs(peds) do
                if DoesEntityExist(ped) and not IsEntityDead(ped) then
                    local pedModel = GetEntityModel(ped)
                    for _, guardModel in ipairs(guardModels) do
                        if pedModel == guardModel then
                            local pedCoords = GetEntityCoords(ped)
                            if #(pedCoords - truckCoords) <= guardCheckRadius then
                                return false
                            end
                        end
                    end
                end
            end
        end
    end

    return true
end

-- Function to spawn NPCs
function SpawnHeistNPCs()
    for i, npc in pairs(Config.NPCs) do
        if not spawnedNPCs[i] then
            local model = GetHashKey(npc.model)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(1)
            end
            
            local npcPed = CreatePed(4, model, npc.coords.x, npc.coords.y, npc.coords.z - 1.0, npc.coords.w, false, true)
            FreezeEntityPosition(npcPed, true)
            SetEntityInvincible(npcPed, true)
            SetBlockingOfNonTemporaryEvents(npcPed, true)
            SetModelAsNoLongerNeeded(model)
            
            spawnedNPCs[i] = npcPed
        end
    end
end

-- Function to delete NPCs
function DeleteHeistNPCs()
    for i, npcPed in pairs(spawnedNPCs) do
        if DoesEntityExist(npcPed) then
            DeleteEntity(npcPed)
        end
        spawnedNPCs[i] = nil
    end
end

-- Function to spawn info ped
function SpawnInfoPed()
    if infoPedSpawned then return end
    
    local model = GetHashKey(Config.InfoPed.model)
    RequestModel(model)
    
    local attempts = 0
    while not HasModelLoaded(model) and attempts < 100 do
        Wait(10)
        attempts = attempts + 1
    end
    
    if not HasModelLoaded(model) then
        ShowNotification("Failed to load info ped model", "error", 3000)
        return
    end
    
    local npcPed = CreatePed(4, model, Config.InfoPed.coords.x, Config.InfoPed.coords.y, Config.InfoPed.coords.z - 1.0, Config.InfoPed.coords.w, false, false)
    
    if not DoesEntityExist(npcPed) then
        ShowNotification("Failed to spawn info ped", "error", 3000)
        SetModelAsNoLongerNeeded(model)
        return
    end
    
    FreezeEntityPosition(npcPed, true)
    SetEntityInvincible(npcPed, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    SetEntityAsMissionEntity(npcPed, true, true)
    SetPedFleeAttributes(npcPed, 0, false)
    SetPedCombatAttributes(npcPed, 17, true)
    SetModelAsNoLongerNeeded(model)
    
    infoPed = npcPed
    infoPedSpawned = true
    
    -- Create blip for info ped location
    infoPedBlip = AddBlipForCoord(Config.InfoPed.coords.x, Config.InfoPed.coords.y, Config.InfoPed.coords.z)
    SetBlipSprite(infoPedBlip, 280)
    SetBlipDisplay(infoPedBlip, 4)
    SetBlipScale(infoPedBlip, 0.8)
    SetBlipColour(infoPedBlip, 3) -- Green color
    SetBlipAsShortRange(infoPedBlip, false)
    SetBlipFlashes(infoPedBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Info Location")
    EndTextCommandSetBlipName(infoPedBlip)
    
    ShowNotification("Go to the marked location to get information about the truck", "info", 8000)
end

-- Function to delete info ped
function DeleteInfoPed()
    if infoPed and DoesEntityExist(infoPed) then
        DeleteEntity(infoPed)
    end
    infoPed = nil
    
    if infoPedBlip then
        RemoveBlip(infoPedBlip)
    end
    infoPedBlip = nil
    
    infoPedSpawned = false
end

-- Initialize
CreateThread(function()
    -- Start NPC interaction thread
    CreateThread(NPCInteractionThread)
    
    -- Start NPC visibility management thread
    CreateThread(NPCVisibilityThread)
    
    -- Start info ped interaction thread
    CreateThread(InfoPedInteractionThread)
end)

-- NPC Visibility Thread - Spawns/Deletes NPCs based on police count
function NPCVisibilityThread()
    while true do
        Wait(10000) -- Check every 10 seconds to reduce performance impact on high player count servers
        
        if Config.RequirePolice then
            if policeCount >= Config.MinPoliceCount then
                -- Enough police - spawn NPCs if not already spawned
                SpawnHeistNPCs()
            else
                -- Not enough police - delete NPCs
                DeleteHeistNPCs()
            end
        else
            -- No police requirement - always spawn NPCs
            SpawnHeistNPCs()
        end
    end
end

-- NPC Interaction Thread
function NPCInteractionThread()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i, npc in pairs(Config.NPCs) do
            -- Only show interaction if NPC is spawned
            if spawnedNPCs[i] and DoesEntityExist(spawnedNPCs[i]) then
                local npcCoords = vector3(npc.coords.x, npc.coords.y, npc.coords.z)
                local distance = #(playerCoords - npcCoords)
                
                if distance < 3.0 then
                    sleep = 0
                    if not isInHeist then
                        Draw3DText(npcCoords, Config.Messages.infoPrompt)
                        
                        if IsControlJustReleased(0, 38) then -- E key
                            TriggerServerEvent('olrp_truckheist:server:startHeist')
                        end
                    end
                end
            end
        end
        
        Wait(sleep)
    end
end

-- Info Ped Interaction Thread
function InfoPedInteractionThread()
    while true do
        local sleep = 1000
        
        if isInHeist and infoPedSpawned and not infoReceived then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local pedCoords = vector3(Config.InfoPed.coords.x, Config.InfoPed.coords.y, Config.InfoPed.coords.z)
            local distance = #(playerCoords - pedCoords)
            
            if distance < 3.0 then
                sleep = 0
                Draw3DText(pedCoords, "Press [E] to get information about the truck")
                
                    if IsControlJustReleased(0, 38) then -- E key
                        infoReceived = true
                        ShowNotification("Getting information...", "info", 3000)
                        
                        -- Face the info ped
                        if infoPed and DoesEntityExist(infoPed) then
                            TaskTurnPedToFaceEntity(playerPed, infoPed, 5000)
                            Wait(500)
                        end
                        
                        -- Play argue animation for 5 seconds - aggressive standing gestures
                        RequestAnimDict("random@mugging4")
                        local attempts = 0
                        while not HasAnimDictLoaded("random@mugging4") and attempts < 50 do
                            Wait(10)
                            attempts = attempts + 1
                        end
                        
                        if HasAnimDictLoaded("random@mugging4") then
                            TaskPlayAnim(playerPed, "random@mugging4", "agitated_loop_a", 8.0, -8.0, 5000, 48, 0, false, false, false)
                        end
                        
                        -- Wait 5 seconds
                        Wait(5000)
                        
                        -- Clear animation
                        ClearPedTasks(playerPed)
                        RemoveAnimDict("random@mugging4")
                    
                    -- Delete info ped and blip
                    DeleteInfoPed()
                    
                    -- Now spawn the truck and its blip
                    ShowNotification("You received the truck location information!", "success", 5000)
                    
                    -- Spawn the truck now with its location
                    if currentHeist then
                        SpawnCITTruck(currentHeist.truckCoords, currentHeist.truckHeading)
                        
                        -- Send dispatch
                        if Config.Dispatch.enabled then
                            TriggerServerEvent('olrp_truckheist:server:sendDispatch', currentHeist.truckCoords)
                        end
                    end
                    
                    -- Ensure truck blip is visible
                    CreateThread(function()
                        Wait(2000) -- Wait for truck to fully spawn and blip to be created
                        if truckBlip and DoesBlipExist(truckBlip) then
                            SetBlipDisplay(truckBlip, 4) -- Ensure blip is visible
                            SetBlipAsShortRange(truckBlip, false)
                            SetBlipFlashes(truckBlip, true)
                            SetBlipHiddenOnLegend(truckBlip, false)
                        end
                    end)
                end
            end
        end
        
        Wait(sleep)
    end
end

-- Spawn CIT Truck
function SpawnCITTruck(coords, heading)
    local model = GetHashKey(Config.TruckModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    
    truckEntity = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true) -- Changed to network vehicle
    
    -- Improved entity existence check with timeout for high player count servers
    local spawnAttempts = 0
    while not DoesEntityExist(truckEntity) and spawnAttempts < 100 do 
        Wait(50)
        spawnAttempts = spawnAttempts + 1
    end
    
    if not DoesEntityExist(truckEntity) then
        ShowNotification("Failed to spawn truck - server performance issues detected", "error", 5000)
        return
    end
    
    SetEntityAsMissionEntity(truckEntity, true, true)
    
    -- Better networking for high player count servers
    -- Wait for entity to be networked properly
    local networkWait = 0
    while not NetworkGetEntityIsNetworked(truckEntity) and networkWait < 100 do
        NetworkRegisterEntityAsNetworked(truckEntity)
        Wait(50)
        networkWait = networkWait + 1
    end
    
    -- Now get network ID after entity is networked
    local truckNetId = 0
    if NetworkGetEntityIsNetworked(truckEntity) then
        truckNetId = NetworkGetNetworkIdFromEntity(truckEntity)
        
        -- Verify network ID is valid
        local attempts = 0
        while (not truckNetId or truckNetId == 0 or not NetworkDoesNetworkIdExist(truckNetId)) and attempts < 50 do
            Wait(100)
            truckNetId = NetworkGetNetworkIdFromEntity(truckEntity)
            attempts = attempts + 1
        end
        
        if truckNetId and truckNetId ~= 0 and NetworkDoesNetworkIdExist(truckNetId) then
            SetNetworkIdExistsOnAllMachines(truckNetId, true)
            SetNetworkIdCanMigrate(truckNetId, true)
            TriggerServerEvent('olrp_truckheist:server:setTruckNetId', truckNetId)
        end
    end
    
    SetVehicleEngineOn(truckEntity, true, true, false)
    SetVehicleUndriveable(truckEntity, false)
    SetVehicleDoorsLocked(truckEntity, 2)
    SetVehicleDoorsLockedForAllPlayers(truckEntity, false)
    
    -- Make truck ignore all traffic laws
    SetVehicleHasBeenOwnedByPlayer(truckEntity, false)
    SetEntityAsMissionEntity(truckEntity, true, true)
    SetVehicleCanBeUsedByFleeingPeds(truckEntity, true)
    ModifyVehicleTopSpeed(truckEntity, 1.0) -- Prevent speed modifications
    -- SetVehicleUseMaxThrottle and SetVehicleIgnoreMaxDistanceRestriction are not valid natives, removed to prevent errors
    
    SetModelAsNoLongerNeeded(model)
    
    -- Create truck blip (entity-based only)
    CreateThread(function()
        -- Wait for entity to be fully networked before creating blip
        Wait(1000)
        
        -- Verify entity still exists
        if not DoesEntityExist(truckEntity) then
            return
        end
        
        -- Remove any existing blip first
        if truckBlip and DoesBlipExist(truckBlip) then
            RemoveBlip(truckBlip)
        end
        
        -- Create entity blip
        truckBlip = AddBlipForEntity(truckEntity)
        
        -- Wait a moment for blip to be created
        Wait(100)
        
        if truckBlip and DoesBlipExist(truckBlip) then
            SetBlipSprite(truckBlip, Config.Blips.truck.sprite)
            SetBlipDisplay(truckBlip, 4)
            SetBlipScale(truckBlip, Config.Blips.truck.scale)
            SetBlipColour(truckBlip, Config.Blips.truck.color)
            SetBlipAsShortRange(truckBlip, false)
            SetBlipHiddenOnLegend(truckBlip, false)
            SetBlipFlashes(truckBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Blips.truck.name)
            EndTextCommandSetBlipName(truckBlip)
        end
    end)
    
    -- Ensure heist participant can see the blip immediately and continuously
    CreateThread(function()
        Wait(1500) -- Wait for blip creation thread to finish
        local attempts = 0
        while attempts < 10 do
            if truckBlip and DoesBlipExist(truckBlip) then
                SetBlipDisplay(truckBlip, 4) -- Force display to player
                SetBlipAsShortRange(truckBlip, false)
                SetBlipFlashes(truckBlip, true)
                SetBlipHiddenOnLegend(truckBlip, false)
                break
            end
            Wait(200)
            attempts = attempts + 1
        end
        
        -- Also ensure blip stays visible during the heist
        while isInHeist and truckBlip and DoesBlipExist(truckBlip) do
            SetBlipDisplay(truckBlip, 4)
            Wait(15000) -- Check every 15 seconds to reduce performance impact
        end
    end)
    
    -- Spawn guards
    SpawnGuards(coords)
    
    -- Start truck monitoring
    CreateThread(TruckMonitorThread)
end

-- Spawn Guards
function SpawnGuards(truckCoords)
    
    local model = GetHashKey(Config.Guards.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    
    -- Clear guards table first
    guards = {}
    
    -- Spawn driver first (seat -1) with improved reliability for high player count servers
    local driver = CreatePedInsideVehicle(truckEntity, 4, model, -1, true, true)
    
    local spawnAttempts = 0
    while not DoesEntityExist(driver) and spawnAttempts < 100 do 
        Wait(50)
        spawnAttempts = spawnAttempts + 1
    end
    
    if not DoesEntityExist(driver) then
        ShowNotification("Failed to spawn guard driver - server performance issues", "error", 3000)
        return
    end
    
    SetEntityAsMissionEntity(driver, true, true)
    
    -- Better networking for driver
    local networkWait = 0
    while not NetworkGetEntityIsNetworked(driver) and networkWait < 50 do
        NetworkRegisterEntityAsNetworked(driver)
        Wait(50)
        networkWait = networkWait + 1
    end
    
    if NetworkGetEntityIsNetworked(driver) then
        local driverNetId = NetworkGetNetworkIdFromEntity(driver)
        if driverNetId and driverNetId ~= 0 then
            SetNetworkIdExistsOnAllMachines(driverNetId, true)
            SetNetworkIdCanMigrate(driverNetId, true)
        end
    end
    
    -- Give driver weapon
    local weapon = Config.Guards.weapons[math.random(#Config.Guards.weapons)]
    GiveWeaponToPed(driver, GetHashKey(weapon), 500, false, true)
    
    -- Set driver attributes - EXTREME aggressive driving, no rules
    SetPedArmour(driver, Config.Guards.armor)
    SetPedFleeAttributes(driver, 0, false) -- Never flee
    SetPedCombatAttributes(driver, 0, false) -- Cannot fight (must keep driving)
    SetPedCombatAttributes(driver, 2, true) -- Can use vehicles
    SetPedCombatAttributes(driver, 46, true) -- Can use vehicles
    SetDriverAbility(driver, 1.0) -- Max driving ability
    SetDriverAggressiveness(driver, 1.0) -- Maximum aggressive driving
    SetPedCanBeTargetted(driver, false) -- Prevent carjacking reactions
    SetPedConfigFlag(driver, 32, false) -- Disable carjacking reactions
    SetPedConfigFlag(driver, 214, true) -- Keep driving task active
    SetPedKeepTask(driver, true)
    
    -- Make driver ignore all traffic laws completely
    SetPedConfigFlag(driver, 242, true) -- Ignore traffic lights
    SetPedConfigFlag(driver, 241, true) -- Ignore pedestrians
    SetPedConfigFlag(driver, 240, true) -- Ignore vehicles
    SetBlockingOfNonTemporaryEvents(driver, true) -- Ignore world events
    SetPedCanRagdoll(driver, false) -- Never ragdoll
    SetPedConfigFlag(driver, 208, true) -- Never react to damage from vehicle
    
    -- Ensure vehicle is driveable and set driver in control
    SetVehicleUndriveable(truckEntity, false)
    SetVehicleEngineOn(truckEntity, true, true, false)
    SetPedIntoVehicle(driver, truckEntity, -1) -- Make sure driver is properly in driver seat
    
    -- Add damage detection and re-entry logic for driver
    CreateThread(function()
        local lastKnownHealth = GetVehicleBodyHealth(truckEntity)
        
        while DoesEntityExist(truckEntity) and DoesEntityExist(driver) do
            if IsEntityDead(driver) then break end
            
            local currentHealth = GetVehicleBodyHealth(truckEntity)
            
            -- Check if truck has been damaged AT ALL (any damage triggers exit)
            if currentHealth < lastKnownHealth - 1 then -- Just 1 health loss triggers exit
                if IsPedInVehicle(driver, truckEntity, true) then
                    -- Driver can now fight and starts shooting from vehicle
                    SetPedCombatAttributes(driver, 0, true) -- Can fight now
                    local playerPed = PlayerPedId()
                    SetPedRelationshipGroupHash(driver, GetHashKey("HATES_PLAYER"))
                    TaskCombatPed(driver, playerPed, 0, 16)
                    
                    -- Shoot from vehicle for 1 second, then exit
                    Wait(1000)
                    
                    -- Driver exits immediately and engages
                    TaskLeaveVehicle(driver, truckEntity, 256) -- 256 = emergency exit
                    Wait(800) -- Wait for driver to exit
                    
                    -- Set driver to EXTREME aggressive combat mode
                    TaskCombatPed(driver, playerPed, 0, 16)
                    SetPedCombatMovement(driver, 3) -- Very aggressive (charges and closes distance)
                    SetPedCombatRange(driver, 1) -- Short to medium range (gets closer)
                    SetPedAccuracy(driver, 85) -- Very accurate
                    SetPedFleeAttributes(driver, 0, false) -- Never flee
                    SetPedKeepTask(driver, true)
                    
                    -- Pursue if player flees
                    CreateThread(function()
                        local pursuitTime = 0
                        while pursuitTime < 15000 and DoesEntityExist(driver) and not IsEntityDead(driver) do
                            if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
                                local driverPos = GetEntityCoords(driver)
                                local targetPos = GetEntityCoords(playerPed)
                                local dist = #(driverPos - targetPos)
                                
                                if dist > 30.0 and dist < 150.0 then
                                    TaskGoToEntity(driver, playerPed, -1, 5.0, 3.0, 0, 0)
                                    Wait(500)
                                    TaskCombatPed(driver, playerPed, 0, 16)
                                end
                            end
                            Wait(500)
                            pursuitTime = pursuitTime + 500
                        end
                    end)
                    
                    -- After 15 seconds of combat, get back in truck and drive away
                    Wait(15000)
                    
                    if DoesEntityExist(driver) and not IsEntityDead(driver) and DoesEntityExist(truckEntity) then
                        -- Clear combat tasks
                        ClearPedTasks(driver)
                        Wait(500)
                        
                        -- Get back in driver seat
                        TaskEnterVehicle(driver, truckEntity, -1, -1, 1.0, 1, 0)
                        Wait(3000) -- Wait for driver to get in
                        
                        -- Reset health threshold for next damage event
                        lastKnownHealth = GetVehicleBodyHealth(truckEntity)
                        
                        -- Re-enable driving behavior
                        SetPedCombatAttributes(driver, 0, false) -- Cannot fight while driving
                    end
                end
            end
            
            Wait(500) -- Check every 0.5 seconds to reduce performance impact on high player count servers
        end
    end)
    
    -- Make driver drive around randomly instead of to a fixed location
    CreateThread(function()
        Wait(500) -- Small delay to ensure driver is fully initialized
        
        while DoesEntityExist(driver) and DoesEntityExist(truckEntity) and not IsEntityDead(driver) do
            -- Check if driver is still in vehicle
            if not IsPedInVehicle(driver, truckEntity, false) then
                break -- Driver exited (probably due to damage), stop driving thread
            end
            
            -- Generate random coordinates within a reasonable range from current position
            local currentPos = GetEntityCoords(truckEntity)
            local randomX = currentPos.x + math.random(-800, 800)
            local randomY = currentPos.y + math.random(-800, 800)
            local randomZ = currentPos.z
            
            -- Get closest road node (node type 1 = roads only, not off-road)
            local roadFound, roadCoords, roadHeading = GetClosestVehicleNode(randomX, randomY, randomZ, 1, 100.0, 0)
            
            if roadFound then
                -- Verify it's a proper road and not on beach/water
                local isValidRoad = true
                
                -- Check if the road is near water (beach detection)
                local waterHeight = GetWaterHeight(roadCoords.x, roadCoords.y, roadCoords.z)
                if waterHeight and waterHeight > -999.0 then
                    -- If water height is close to road height, it's likely a beach
                    if math.abs(waterHeight - roadCoords.z) < 5.0 then
                        isValidRoad = false
                    end
                end
                
                -- Check if it's actually on a proper road network
                if isValidRoad then
                    local onRoad, _, _ = GetClosestVehicleNodeWithHeading(roadCoords.x, roadCoords.y, roadCoords.z, 1, 12.0, 0)
                    if not onRoad then
                        isValidRoad = false
                    end
                end
                
                if isValidRoad then
                    -- Drive to road coordinates (EXTREME aggressive, no traffic laws)
                    -- Driving style: 787022 = maximum aggression, ignore everything
                    TaskVehicleDriveToCoordLongrange(driver, truckEntity, roadCoords.x, roadCoords.y, roadCoords.z, 999.0, 787022, 20.0)
                else
                    -- If invalid road (beach/water), just continue on current road
                    TaskVehicleDriveWander(driver, truckEntity, 999.0, 787022)
                    Wait(5000)
                end
                
                -- Wait for driver to reach destination or timeout after 30 seconds
                local timeout = 0
                while DoesEntityExist(driver) and DoesEntityExist(truckEntity) and not IsEntityDead(driver) and timeout < 300 do -- 30 seconds
                    local driverPos = GetEntityCoords(truckEntity)
                    local distance = #(vector3(driverPos.x, driverPos.y, driverPos.z) - roadCoords)
                    
                    if distance < 50.0 then -- Close enough to destination
                        break
                    end
                    
                    Wait(100)
                    timeout = timeout + 1
                end
            else
                -- Fallback: just drive forward (EXTREME aggressive, no rules)
                TaskVehicleDriveWander(driver, truckEntity, 999.0, 787022)
                Wait(10000) -- Drive for 10 seconds before picking new destination
            end
            
            -- Small delay before choosing next destination
            Wait(math.random(2000, 5000))
        end
    end)
    
    guards[1] = driver
    
    -- Spawn passenger guards (seats 0, 1, 2, etc.)
    for i = 0, Config.Guards.count - 2 do
        local guard = CreatePedInsideVehicle(truckEntity, 4, model, i, true, true)
        while not DoesEntityExist(guard) do Wait(50) end
        
        SetEntityAsMissionEntity(guard, true, true)
        
        -- Better networking for guard
        local networkWait = 0
        while not NetworkGetEntityIsNetworked(guard) and networkWait < 50 do
            NetworkRegisterEntityAsNetworked(guard)
            Wait(50)
            networkWait = networkWait + 1
        end
        
        if NetworkGetEntityIsNetworked(guard) then
            local guardNetId = NetworkGetNetworkIdFromEntity(guard)
            if guardNetId and guardNetId ~= 0 then
                SetNetworkIdCanMigrate(guardNetId, true)
                SetNetworkIdExistsOnAllMachines(guardNetId, true)
            end
        end
        
        -- Give guard weapon
        local weapon = Config.Guards.weapons[math.random(#Config.Guards.weapons)]
        GiveWeaponToPed(guard, GetHashKey(weapon), 9999, false, true)
        SetCurrentPedWeapon(guard, GetHashKey(weapon), true)
        
        -- Set guard attributes - Aggressive but balanced
        SetPedArmour(guard, Config.Guards.armor)
        
        -- Combat Attributes
        SetPedCombatAttributes(guard, 0, true) -- Can fight
        SetPedCombatAttributes(guard, 1, true) -- Can use cover
        SetPedCombatAttributes(guard, 2, true) -- Can use vehicles
        SetPedCombatAttributes(guard, 3, true) -- Can fight armed peds
        SetPedCombatAttributes(guard, 5, true) -- Can use cover
        SetPedCombatAttributes(guard, 13, true) -- Aggressive
        SetPedCombatAttributes(guard, 20, true) -- Fight in groups
        SetPedCombatAttributes(guard, 38, true) -- Never surrender
        SetPedCombatAttributes(guard, 46, true) -- Can use vehicles in combat
        SetPedCombatAttributes(guard, 52, true) -- Always fight
        SetPedCombatAttributes(guard, 58, true) -- Disable flee
        
        -- Flee Attributes
        SetPedFleeAttributes(guard, 0, false) -- Never flee
        
        -- Combat Stats - MAXIMUM AGGRESSION
        SetPedCombatAbility(guard, 100) -- Professional
        SetPedCombatMovement(guard, 3) -- Very aggressive (will charge and fight up close)
        SetPedAccuracy(guard, 85) -- Very accurate (increased from 60)
        SetPedCombatRange(guard, 1) -- Short to medium range (will get closer)
        
        -- Perception - ENHANCED
        SetPedSeeingRange(guard, 150.0) -- Increased vision range
        SetPedHearingRange(guard, 150.0) -- Increased hearing range
        SetPedAlertness(guard, 3) -- Maximum alertness
        
        -- Additional aggressive attributes
        SetPedCombatAttributes(guard, 19, true) -- Will advance (push forward aggressively)
        SetPedCombatAttributes(guard, 28, true) -- Can use temporary cover
        SetPedCombatAttributes(guard, 57, true) -- Can make critical hits
        
        -- Health and damage - DEFAULT (no super health)
        SetPedSuffersCriticalHits(guard, true) -- Can be headshot
        
        -- Behavior flags
        SetPedConfigFlag(guard, 17, true) -- Can do drivebys
        SetPedConfigFlag(guard, 32, false) -- Disable carjacking reactions
        SetPedConfigFlag(guard, 214, true) -- Keep task
        SetPedConfigFlag(guard, 130, true) -- Can shoot from vehicles
        
        -- Relationship and targeting
        SetPedRelationshipGroupHash(guard, GetHashKey("HATES_PLAYER"))
        SetEntityVisible(guard, true)
        SetPedKeepTask(guard, true)
        SetPedCanSwitchWeapon(guard, true)
        SetPedCanBeTargetted(guard, true)
        SetCanAttackFriendly(guard, false, false)
        SetPedAsEnemy(guard, true)
        
        guards[i + 2] = guard
        
        -- Guards exit and fight back when truck gets shot, then re-enter
        CreateThread(function()
            local lastKnownHealth = GetVehicleBodyHealth(truckEntity)
            local seatIndex = i -- Store the seat index for re-entry
            
            while DoesEntityExist(truckEntity) and DoesEntityExist(guard) do
                if IsEntityDead(guard) then break end
                
                local currentHealth = GetVehicleBodyHealth(truckEntity)
                
                -- Check if truck has been damaged AT ALL (any damage triggers exit)
                if currentHealth < lastKnownHealth - 1 then -- Just 1 health loss triggers exit
                    if IsPedInVehicle(guard, truckEntity, true) then
                        -- Start shooting from vehicle first
                        local playerPed = PlayerPedId()
                        SetPedRelationshipGroupHash(guard, GetHashKey("HATES_PLAYER"))
                        TaskCombatPed(guard, playerPed, 0, 16)
                        
                        -- Shoot for 1 second, then exit
                        Wait(1000)
                        
                        -- Guard exits immediately and aggressively engages
                        TaskLeaveVehicle(guard, truckEntity, 256) -- 256 = leave immediately/emergency exit
                        Wait(800) -- Wait for guard to exit
                        
                        -- Set guard to EXTREME aggressive combat mode
                        TaskCombatPed(guard, playerPed, 0, 16)
                        SetPedCombatMovement(guard, 3) -- Very aggressive (charges and closes distance)
                        SetPedCombatRange(guard, 1) -- Short to medium range (gets closer)
                        SetPedAccuracy(guard, 85) -- Very accurate
                        SetPedFleeAttributes(guard, 0, false) -- Never flee
                        SetPedKeepTask(guard, true)
                        
                        -- Pursue if player flees
                        CreateThread(function()
                            local pursuitTime = 0
                            while pursuitTime < 15000 and DoesEntityExist(guard) and not IsEntityDead(guard) do
                                if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
                                    local guardPos = GetEntityCoords(guard)
                                    local targetPos = GetEntityCoords(playerPed)
                                    local dist = #(guardPos - targetPos)
                                    
                                    if dist > 30.0 and dist < 150.0 then
                                        TaskGoToEntity(guard, playerPed, -1, 5.0, 3.0, 0, 0)
                                        Wait(500)
                                        TaskCombatPed(guard, playerPed, 0, 16)
                                    end
                                end
                                Wait(500)
                                pursuitTime = pursuitTime + 500
                            end
                        end)
                        
                        -- After 15 seconds of combat, get back in truck
                        Wait(15000)
                        
                        if DoesEntityExist(guard) and not IsEntityDead(guard) and DoesEntityExist(truckEntity) then
                            -- Clear combat tasks
                            ClearPedTasks(guard)
                            Wait(500)
                            
                            -- Get back in their seat
                            TaskEnterVehicle(guard, truckEntity, -1, seatIndex, 1.0, 1, 0)
                            Wait(3000) -- Wait for guard to get in
                            
                            -- Reset health threshold for next damage event
                            lastKnownHealth = GetVehicleBodyHealth(truckEntity)
                        end
                    end
                end
                
                Wait(500) -- Check every 0.5 seconds to reduce performance impact on high player count servers
            end
        end)
    end
    
    SetModelAsNoLongerNeeded(model)
    
    -- Spawn escort vehicle if enabled
    if Config.EscortVehicle.enabled then
        SpawnEscortVehicle(truckCoords)
    end
    
    -- Activate tracker when truck starts moving
    if not trackerActive then
        trackerActive = true
        ShowNotification("Truck tracker activated! The truck is on the move!", "info", 5000)
    end
end

-- Spawn Escort Vehicle
function SpawnEscortVehicle(truckCoords)
    if not DoesEntityExist(truckEntity) then
        return
    end
    
    local model = GetHashKey(Config.EscortVehicle.model)
    RequestModel(model)
    
    local attempts = 0
    while not HasModelLoaded(model) and attempts < 100 do
        Wait(10)
        attempts = attempts + 1
    end
    
    if not HasModelLoaded(model) then
        return
    end
    
    -- Spawn escort behind the truck (using actual coords with offset)
    local truckPos = GetEntityCoords(truckEntity)
    local truckHeading = GetEntityHeading(truckEntity)
    
    -- Calculate position 15 meters behind truck
    local rad = math.rad(truckHeading)
    local spawnX = truckPos.x - (math.sin(rad) * 15.0)
    local spawnY = truckPos.y - (math.cos(rad) * 15.0)
    local spawnZ = truckPos.z
    
    escortEntity = CreateVehicle(model, spawnX, spawnY, spawnZ, truckHeading, true, true) -- Changed to network vehicle
    
    local spawnAttempts = 0
    while not DoesEntityExist(escortEntity) and spawnAttempts < 50 do 
        Wait(50)
        spawnAttempts = spawnAttempts + 1
    end
    
    if not DoesEntityExist(escortEntity) then
        return
    end
    
    SetEntityAsMissionEntity(escortEntity, true, true)
    
    -- Wait for entity to be networked properly
    local networkWait = 0
    while not NetworkGetEntityIsNetworked(escortEntity) and networkWait < 50 do
        NetworkRegisterEntityAsNetworked(escortEntity)
        Wait(50)
        networkWait = networkWait + 1
    end
    
    -- Set network properties after entity is networked
    if NetworkGetEntityIsNetworked(escortEntity) then
        local escortNetId = NetworkGetNetworkIdFromEntity(escortEntity)
        if escortNetId and escortNetId ~= 0 then
            SetNetworkIdCanMigrate(escortNetId, true)
            SetNetworkIdExistsOnAllMachines(escortNetId, true)
        end
    end
    
    SetVehicleEngineOn(escortEntity, true, true, false)
    SetVehicleUndriveable(escortEntity, false)
    SetVehicleDoorsLocked(escortEntity, 2)
    SetVehicleDoorsLockedForAllPlayers(escortEntity, false)
    
    -- Make escort vehicle ignore all traffic laws
    SetVehicleHasBeenOwnedByPlayer(escortEntity, false)
    SetEntityAsMissionEntity(escortEntity, true, true)
    SetVehicleCanBeUsedByFleeingPeds(escortEntity, true)
    ModifyVehicleTopSpeed(escortEntity, 1.0)
    -- SetVehicleUseMaxThrottle and SetVehicleIgnoreMaxDistanceRestriction are not valid natives, removed to prevent errors
    
    SetModelAsNoLongerNeeded(model)
    
    -- Spawn escort guards
    SpawnEscortGuards()
end

-- Spawn Escort Guards
function SpawnEscortGuards()
    if not DoesEntityExist(escortEntity) then
        return
    end
    
    local model = GetHashKey(Config.Guards.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    
    -- Clear escort guards table
    escortGuards = {}
    escortGuardsExitedOnce = {}
    
    -- Spawn driver first (seat -1)
    local driver = CreatePedInsideVehicle(escortEntity, 4, model, -1, true, true)
    while not DoesEntityExist(driver) do Wait(50) end
    
    SetEntityAsMissionEntity(driver, true, true)
    
    -- Better networking for escort driver
    local networkWait = 0
    while not NetworkGetEntityIsNetworked(driver) and networkWait < 50 do
        NetworkRegisterEntityAsNetworked(driver)
        Wait(50)
        networkWait = networkWait + 1
    end
    
    if NetworkGetEntityIsNetworked(driver) then
        local driverNetId = NetworkGetNetworkIdFromEntity(driver)
        if driverNetId and driverNetId ~= 0 then
            SetNetworkIdCanMigrate(driverNetId, true)
            SetNetworkIdExistsOnAllMachines(driverNetId, true)
        end
    end
    
    -- Give driver weapon
    local weapon = Config.Guards.weapons[math.random(#Config.Guards.weapons)]
    GiveWeaponToPed(driver, GetHashKey(weapon), 9999, false, true)
    SetCurrentPedWeapon(driver, GetHashKey(weapon), true)
    
    -- Set driver attributes - EXTREME aggressive driving, no rules
    SetPedArmour(driver, Config.Guards.armor)
    SetPedFleeAttributes(driver, 0, false)
    SetPedCombatAttributes(driver, 0, false) -- Can't fight initially (must drive)
    SetPedCombatAttributes(driver, 2, true)
    SetPedCombatAttributes(driver, 46, true)
    SetDriverAbility(driver, 1.0)
    SetDriverAggressiveness(driver, 1.0)
    SetPedCanBeTargetted(driver, true)
    SetPedConfigFlag(driver, 32, false)
    SetPedConfigFlag(driver, 214, true)
    SetPedConfigFlag(driver, 130, true)
    SetPedKeepTask(driver, true)
    
    -- Make escort driver ignore all traffic laws
    SetPedConfigFlag(driver, 242, true) -- Ignore traffic lights
    SetPedConfigFlag(driver, 241, true) -- Ignore pedestrians
    SetPedConfigFlag(driver, 240, true) -- Ignore vehicles
    SetBlockingOfNonTemporaryEvents(driver, true) -- Ignore world events
    SetPedCanRagdoll(driver, false) -- Never ragdoll
    SetPedConfigFlag(driver, 208, true) -- Never react to damage from vehicle
    
    -- Make escort follow main truck
    CreateThread(function()
        Wait(1000) -- Wait for truck to start moving
        
        while DoesEntityExist(driver) and DoesEntityExist(escortEntity) and DoesEntityExist(truckEntity) and not IsEntityDead(driver) do
            -- Check if driver is still in vehicle
            if not IsPedInVehicle(driver, escortEntity, false) then
                break -- Driver exited, stop following
            end
            
            -- Get truck position and calculate follow position
            local truckPos = GetEntityCoords(truckEntity)
            local truckHeading = GetEntityHeading(truckEntity)
            
            -- Calculate position behind truck
            local rad = math.rad(truckHeading)
            local followX = truckPos.x - (math.sin(rad) * Config.EscortVehicle.followDistance)
            local followY = truckPos.y - (math.cos(rad) * Config.EscortVehicle.followDistance)
            local followZ = truckPos.z
            
            -- Drive to follow position (EXTREME aggressive, no rules)
            TaskVehicleDriveToCoordLongrange(driver, escortEntity, followX, followY, followZ, 999.0, 787022, 10.0)
            
            Wait(1000) -- Update every second
        end
    end)
    
    -- Add damage detection for escort driver (same as main truck)
    CreateThread(function()
        local lastKnownHealth = GetVehicleBodyHealth(escortEntity)
        
        while DoesEntityExist(escortEntity) and DoesEntityExist(driver) do
            if IsEntityDead(driver) then break end
            
            local currentHealth = GetVehicleBodyHealth(escortEntity)
            local truckHealth = GetVehicleBodyHealth(truckEntity)
            
            -- Exit if escort OR main truck is damaged
            if currentHealth < lastKnownHealth - 1 or (DoesEntityExist(truckEntity) and truckHealth < 999) then
                if IsPedInVehicle(driver, escortEntity, true) then
                    SetPedCombatAttributes(driver, 0, true)
                    local playerPed = PlayerPedId()
                    SetPedRelationshipGroupHash(driver, GetHashKey("HATES_PLAYER"))
                    TaskCombatPed(driver, playerPed, 0, 16)
                    
                    Wait(1000)
                    
                    TaskLeaveVehicle(driver, escortEntity, 256)
                    Wait(800)
                    
                    TaskCombatPed(driver, playerPed, 0, 16)
                    SetPedCombatMovement(driver, 3) -- Very aggressive (charges and closes distance)
                    SetPedCombatRange(driver, 1) -- Short to medium range (gets closer)
                    SetPedAccuracy(driver, 85) -- Very accurate
                    SetPedFleeAttributes(driver, 0, false)
                    SetPedKeepTask(driver, true)
                    
                    -- Pursue logic
                    CreateThread(function()
                        local pursuitTime = 0
                        while pursuitTime < 15000 and DoesEntityExist(driver) and not IsEntityDead(driver) do
                            if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
                                local driverPos = GetEntityCoords(driver)
                                local targetPos = GetEntityCoords(playerPed)
                                local dist = #(driverPos - targetPos)
                                
                                if dist > 30.0 and dist < 150.0 then
                                    TaskGoToEntity(driver, playerPed, -1, 5.0, 3.0, 0, 0)
                                    Wait(500)
                                    TaskCombatPed(driver, playerPed, 0, 16)
                                end
                            end
                            Wait(500)
                            pursuitTime = pursuitTime + 500
                        end
                    end)
                    
                    Wait(15000)
                    
                    if DoesEntityExist(driver) and not IsEntityDead(driver) and DoesEntityExist(escortEntity) then
                        ClearPedTasks(driver)
                        Wait(500)
                        TaskEnterVehicle(driver, escortEntity, -1, -1, 1.0, 1, 0)
                        Wait(3000)
                        lastKnownHealth = GetVehicleBodyHealth(escortEntity)
                        SetPedCombatAttributes(driver, 0, false)
                    end
                end
            end
            
            Wait(500) -- Reduced frequency for better performance on high player count servers
        end
    end)
    
    escortGuards[1] = driver
    
    -- Spawn passenger guards (same max aggression as main truck guards)
    for i = 0, Config.EscortVehicle.guardCount - 2 do
        local guard = CreatePedInsideVehicle(escortEntity, 4, model, i, true, true)
        while not DoesEntityExist(guard) do Wait(50) end
        
        SetEntityAsMissionEntity(guard, true, true)
        
        -- Better networking for escort guard
        local networkWait = 0
        while not NetworkGetEntityIsNetworked(guard) and networkWait < 50 do
            NetworkRegisterEntityAsNetworked(guard)
            Wait(50)
            networkWait = networkWait + 1
        end
        
        if NetworkGetEntityIsNetworked(guard) then
            local guardNetId = NetworkGetNetworkIdFromEntity(guard)
            if guardNetId and guardNetId ~= 0 then
                SetNetworkIdCanMigrate(guardNetId, true)
                SetNetworkIdExistsOnAllMachines(guardNetId, true)
            end
        end
        
        -- Give guard weapon
        local weapon = Config.Guards.weapons[math.random(#Config.Guards.weapons)]
        GiveWeaponToPed(guard, GetHashKey(weapon), 9999, false, true)
        SetCurrentPedWeapon(guard, GetHashKey(weapon), true)
        
        -- Guard combat attributes - Aggressive but balanced
        SetPedArmour(guard, Config.Guards.armor)
        SetPedCombatAttributes(guard, 0, true) -- Can fight
        SetPedCombatAttributes(guard, 1, true) -- Can use cover
        SetPedCombatAttributes(guard, 2, true) -- Can use vehicles
        SetPedCombatAttributes(guard, 3, true) -- Can fight armed peds
        SetPedCombatAttributes(guard, 5, true) -- Can use cover
        SetPedCombatAttributes(guard, 13, true) -- Aggressive
        SetPedCombatAttributes(guard, 20, true) -- Fight in groups
        SetPedCombatAttributes(guard, 38, true) -- Never surrender
        SetPedCombatAttributes(guard, 46, true) -- Can use vehicles in combat
        SetPedCombatAttributes(guard, 52, true) -- Always fight
        SetPedCombatAttributes(guard, 58, true) -- Disable flee
        
        SetPedFleeAttributes(guard, 0, false) -- Never flee
        
        SetPedCombatAbility(guard, 100) -- Professional
        SetPedCombatMovement(guard, 3) -- Very aggressive (will charge and fight up close)
        SetPedAccuracy(guard, 85) -- Very accurate (increased from 60)
        SetPedCombatRange(guard, 1) -- Short to medium range (will get closer)
        
        SetPedSeeingRange(guard, 150.0) -- Increased vision range
        SetPedHearingRange(guard, 150.0) -- Increased hearing range
        SetPedAlertness(guard, 3) -- Maximum alertness
        
        -- Additional aggressive attributes for escort guards
        SetPedCombatAttributes(guard, 19, true) -- Will advance (push forward aggressively)
        SetPedCombatAttributes(guard, 28, true) -- Can use temporary cover
        SetPedCombatAttributes(guard, 57, true) -- Can make critical hits
        
        -- Default health (no super health)
        SetPedSuffersCriticalHits(guard, true) -- Can be headshot
        
        SetPedConfigFlag(guard, 17, true) -- Can do drivebys
        SetPedConfigFlag(guard, 32, false) -- Disable carjacking reactions
        SetPedConfigFlag(guard, 214, true) -- Keep task
        SetPedConfigFlag(guard, 130, true) -- Can shoot from vehicles
        
        SetPedRelationshipGroupHash(guard, GetHashKey("HATES_PLAYER"))
        SetEntityVisible(guard, true)
        SetPedKeepTask(guard, true)
        SetPedCanSwitchWeapon(guard, true)
        SetPedCanBeTargetted(guard, true)
        SetCanAttackFriendly(guard, false, false)
        SetPedAsEnemy(guard, true)
        
        escortGuards[i + 2] = guard
        
        -- Escort guards exit when EITHER vehicle is damaged
        CreateThread(function()
            local lastKnownHealth = GetVehicleBodyHealth(escortEntity)
            local seatIndex = i
            
            while DoesEntityExist(escortEntity) and DoesEntityExist(guard) do
                if IsEntityDead(guard) then break end
                
                local currentHealth = GetVehicleBodyHealth(escortEntity)
                local truckHealth = 1000
                if DoesEntityExist(truckEntity) then
                    truckHealth = GetVehicleBodyHealth(truckEntity)
                end
                
                -- Exit if escort OR main truck is damaged
                if currentHealth < lastKnownHealth - 1 or truckHealth < 999 then
                    if IsPedInVehicle(guard, escortEntity, true) then
                        local playerPed = PlayerPedId()
                        SetPedRelationshipGroupHash(guard, GetHashKey("HATES_PLAYER"))
                        TaskCombatPed(guard, playerPed, 0, 16)
                        
                        Wait(1000)
                        
                        TaskLeaveVehicle(guard, escortEntity, 256)
                        Wait(800)
                        
                        TaskCombatPed(guard, playerPed, 0, 16)
                        SetPedCombatMovement(guard, 3) -- Very aggressive (charges and closes distance)
                        SetPedCombatRange(guard, 1) -- Short to medium range (gets closer)
                        SetPedAccuracy(guard, 85) -- Very accurate
                        SetPedFleeAttributes(guard, 0, false)
                        SetPedKeepTask(guard, true)
                        
                        CreateThread(function()
                            local pursuitTime = 0
                            while pursuitTime < 15000 and DoesEntityExist(guard) and not IsEntityDead(guard) do
                                if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
                                    local guardPos = GetEntityCoords(guard)
                                    local targetPos = GetEntityCoords(playerPed)
                                    local dist = #(guardPos - targetPos)
                                    
                                    if dist > 30.0 and dist < 150.0 then
                                        TaskGoToEntity(guard, playerPed, -1, 5.0, 3.0, 0, 0)
                                        Wait(500)
                                        TaskCombatPed(guard, playerPed, 0, 16)
                                    end
                                end
                                Wait(500)
                                pursuitTime = pursuitTime + 500
                            end
                        end)
                        
                        Wait(15000)
                        
                        if DoesEntityExist(guard) and not IsEntityDead(guard) and DoesEntityExist(escortEntity) then
                            ClearPedTasks(guard)
                            Wait(500)
                            TaskEnterVehicle(guard, escortEntity, -1, seatIndex, 1.0, 1, 0)
                            Wait(3000)
                            lastKnownHealth = GetVehicleBodyHealth(escortEntity)
                        end
                    end
                end
                
                Wait(500) -- Reduced frequency for better performance on high player count servers
            end
        end)
    end
    
    SetModelAsNoLongerNeeded(model)
end

-- Get free seat in vehicle
function GetFreeSeat(vehicle)
    for i = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
        if IsVehicleSeatFree(vehicle, i) then
            return i
        end
    end
    return -1
end

-- Truck Monitoring Thread
function TruckMonitorThread()
    local lastTruckCoords = nil
    local trackerActive = false
    local truckMoving = false
    local lastProximityCheck = 0
    
    while truckEntity and DoesEntityExist(truckEntity) do
        local playerCoords = GetPlayerCoordsVector3()
        local truckCoords = GetEntityCoords(truckEntity)
        local truckCoordsVec3 = vector3(truckCoords.x, truckCoords.y, truckCoords.z)
        local distance = #(playerCoords - truckCoordsVec3)
        
        -- Proximity threat detection - guards exit if player gets too close with weapon
        local currentTime = GetGameTimer()
        if distance < 30.0 and (currentTime - lastProximityCheck) > 3000 then -- Check every 3 seconds
            lastProximityCheck = currentTime
            local playerPed = PlayerPedId()
            local weaponHash = GetSelectedPedWeapon(playerPed)
            
            -- If player has a weapon drawn (not unarmed)
            if weaponHash ~= GetHashKey("WEAPON_UNARMED") then
                -- Make all guards exit and attack
                for i, guard in pairs(guards) do
                    if guard and DoesEntityExist(guard) and not IsEntityDead(guard) then
                        if IsPedInVehicle(guard, truckEntity, true) and not guardsExitedOnce[i] then
                            guardsExitedOnce[i] = true
                            
                            CreateThread(function()
                                if i == 1 then
                                    SetPedCombatAttributes(guard, 0, true)
                                end
                                
                                -- Shoot from vehicle first
                                SetPedRelationshipGroupHash(guard, GetHashKey("HATES_PLAYER"))
                                TaskCombatPed(guard, playerPed, 0, 16)
                                Wait(1000)
                                
                                -- Then exit
                                TaskLeaveVehicle(guard, truckEntity, 256)
                                Wait(800)
                                
                                -- Continue combat on foot - EXTREME AGGRESSION
                                TaskCombatPed(guard, playerPed, 0, 16)
                                SetPedCombatMovement(guard, 3) -- Very aggressive
                                SetPedCombatRange(guard, 1) -- Short range (will close distance)
                                SetPedAccuracy(guard, 85) -- Very accurate
                                SetPedFleeAttributes(guard, 0, false)
                                SetPedKeepTask(guard, true)
                                
                                -- Pursue
                                CreateThread(function()
                                    local pursuitTime = 0
                                    while pursuitTime < 15000 and DoesEntityExist(guard) and not IsEntityDead(guard) do
                                        if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) then
                                            local guardPos = GetEntityCoords(guard)
                                            local targetPos = GetEntityCoords(playerPed)
                                            local dist = #(guardPos - targetPos)
                                            
                                            if dist > 30.0 and dist < 150.0 then
                                                TaskGoToEntity(guard, playerPed, -1, 5.0, 3.0, 0, 0)
                                                Wait(500)
                                                TaskCombatPed(guard, playerPed, 0, 16)
                                            end
                                        end
                                        Wait(500)
                                        pursuitTime = pursuitTime + 500
                                    end
                                end)
                                
                                Wait(15000)
                                guardsExitedOnce[i] = false
                            end)
                        end
                    end
                end
            end
        end
        
        -- Check if truck is moving (activate tracker when truck starts moving)
        if lastTruckCoords then
            local distanceMoved = #(truckCoordsVec3 - lastTruckCoords)
            if distanceMoved > 3.0 then -- Truck is moving significantly
                if not truckMoving then
                    truckMoving = true
                    -- Activate tracker when truck starts moving
                    if not trackerActive then
                        trackerActive = true
                        ShowNotification("Truck tracker activated! The truck is on the move!", "info", 5000)
                    end
                end
            else
                truckMoving = false
            end
        end
        lastTruckCoords = truckCoordsVec3
        
        -- Check if player is close to truck to activate tracker (alternative activation)
        if distance < Config.Tracker.activateDistance and not currentHeist.trackerReceived then
            TriggerServerEvent('olrp_truckheist:server:receiveTracker')
            if not trackerActive then
                trackerActive = true
                ShowNotification("Truck tracker activated! You are within range!", "info", 5000)
            end
        end
        
        -- Update truck blip position if tracker is active and truck has moved
        if trackerActive and lastTruckCoords then
            local truckMoved = #(truckCoordsVec3 - lastTruckCoords) > Config.Tracker.movementThreshold
            if truckMoved and truckBlip then
                -- Update blip position
                SetBlipCoords(truckBlip, truckCoords.x, truckCoords.y, truckCoords.z)
                lastTruckCoords = truckCoordsVec3
                
                -- Show notification that truck is moving
                ShowNotification("Truck is on the move! Tracker updating...", "warning", 3000)
            end
        end
        
        -- Check if truck has moved too far (escaped) - only if MaxDistance is enabled
        if currentHeist and currentHeist.initialCoords and Config.MaxDistance and type(Config.MaxDistance) == "number" and Config.MaxDistance > 0 then
            local initialDistance = #(truckCoordsVec3 - currentHeist.initialCoords)
            if initialDistance > Config.MaxDistance then
                TriggerServerEvent('olrp_truckheist:server:truckEscaped')
                break
            end
        end
        
        Wait(Config.Tracker.updateInterval) -- Update based on config
    end
end

-- Plant explosive function (with emote + explosion mechanics)
function PlantExplosive()
    if not truckEntity or not DoesEntityExist(truckEntity) then return end
    
    local Player = PlayerPedId()
    
    -- Start ultra-voltlab hack minigame
    ShowNotification("Hacking explosive device...", "info", 3000)
    
    local success = false
    local hackComplete = false
    
    -- Use ultra-voltlab hack minigame
    TriggerEvent("ultra-voltlab", 30, function(result, message) -- 30 second timer
        if result == 1 then
            success = true
            ShowNotification("Hack successful! Planting explosive...", "success", 3000)
        elseif result == 0 then
            success = false
            ShowNotification("Hack failed! Try again.", "error", 5000)
        elseif result == 2 then
            success = false
            ShowNotification("Hack timed out! Try again.", "error", 5000)
        elseif result == -1 then
            success = false
            ShowNotification("Hack error: " .. (message or "Unknown error"), "error", 5000)
        else
            success = false
            ShowNotification("Hack failed! Try again.", "error", 5000)
        end
        hackComplete = true
    end)
    
    -- Wait for hack to complete
    while not hackComplete do
        Wait(100)
    end
    
    if not success then
        return
    end
    
    Wait(1000)
    
    -- Plant explosive emote first
    TaskTurnPedToFaceEntity(Player, truckEntity, -1)
    FreezeEntityPosition(Player, true)
    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
        Wait(10)
    end
    TaskPlayAnim(Player,"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer",1.0, -1.0, -1, 49, 0, 0, 0, 0)
    
    -- Wait for planting animation to complete
    Wait(3000)
    
    -- Clear animation and unfreeze player
    ClearPedTasks(Player)
    FreezeEntityPosition(Player, false)
    RemoveAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    
    explosivePlanted = true
    
    -- Remove explosive item if required
    if Config.Explosive.requireItem then
        TriggerServerEvent('olrp_truckheist:server:removeExplosive')
    end
    
    ShowNotification("Explosive planted! Get away from the truck!", "success", 5000)
    
    -- Start countdown with proper timer
    CreateThread(function()
        local countdown = Config.Explosive.countdown -- Use seconds directly
        local truckPos = GetEntityCoords(truckEntity)
        local Player = PlayerPedId()
        
        while countdown > 0 do
            local dist = #(GetEntityCoords(Player)-truckPos)
            if dist <= 15 then
                ShowNotification("Explosion in " .. tostring(countdown), "warning", 1000)
            end
            Wait(1000)
            countdown = countdown - 1
        end
        
        -- Explode truck
        local explosionPos = GetEntityCoords(truckEntity)
        
        -- Create multiple explosion effects for better visual impact
        AddExplosion(explosionPos.x, explosionPos.y, explosionPos.z, 2, 50.0, true, false, 1.0) -- Grenade explosion
        AddExplosion(explosionPos.x, explosionPos.y, explosionPos.z + 1.0, 9, 50.0, true, false, 1.0) -- Vehicle explosion
        AddExplosion(explosionPos.x, explosionPos.y, explosionPos.z + 0.5, 4, 50.0, true, false, 1.0) -- Car explosion
        
        -- Damage the truck
        SetVehicleBodyHealth(truckEntity, 0.0)
        SetVehicleEngineHealth(truckEntity, 0.0)
        SetVehiclePetrolTankHealth(truckEntity, 0.0)
        
        truckExploded = true
        explosivePlanted = false
        ShowNotification("The truck has been destroyed! You can now loot it.", "success", 8000)
        
        -- Update and remove blip after explosion
        if truckBlip then
            SetBlipSprite(truckBlip, 524) -- Destroyed vehicle sprite
            SetBlipColour(truckBlip, 1) -- Red color
            SetBlipFlashes(truckBlip, false)
            
            -- Remove blip after a short delay
            Wait(3000) -- Wait 3 seconds after explosion
            RemoveBlip(truckBlip)
            truckBlip = nil
        end
    end)
end


-- Loot animation
function LootAnim(obj)
    local Player = PlayerPedId()
    TaskTurnPedToFaceEntity(Player, obj, -1)
    FreezeEntityPosition(Player, true)
    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
        Wait(10)
    end
    TaskPlayAnim(Player,"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer",1.0, -1.0, -1, 49, 0, 0, 0, 0)
    Wait(5500)	
    ClearPedTasks(Player)
    FreezeEntityPosition(Player, false)
    RemoveAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    
    -- Give reward when animation finishes
    TriggerServerEvent('olrp_truckheist:server:lootTruck')
    ShowNotification("Looting completed!", "success", 3000)
    
    -- Now delete the truck after looting is complete
    if truckEntity and DoesEntityExist(truckEntity) then
        DeleteEntity(truckEntity)
        truckEntity = nil
    end
    
    -- Clean up heist
    CleanupHeist()
end

-- Event Handlers
RegisterNetEvent('olrp_truckheist:client:startHeist', function(heistData, shouldSpawnTruck)
    currentHeist = heistData
    isInHeist = true
    infoReceived = false -- Reset info received status
    
    ShowNotification(Config.Messages.heistStarted, "success", 8000)
    
    -- Only spawn info ped first if this is the heist starter
    if shouldSpawnTruck then
        -- Spawn info ped first (not truck yet)
        SpawnInfoPed()
    end
end)

RegisterNetEvent('olrp_truckheist:client:setTruckEntity', function(truckNetId)
    if truckEntity and DoesEntityExist(truckEntity) then
        local existingNetId = NetworkGetNetworkIdFromEntity(truckEntity)
        if existingNetId == truckNetId then
            return
        end
    end

    CreateThread(function()
        local attempts = 0
        while attempts < 150 do
            if NetworkDoesNetworkIdExist(truckNetId) then
                local vehicle = NetworkGetEntityFromNetworkId(truckNetId)
                if DoesEntityExist(vehicle) then
                    truckEntity = vehicle
                    SetEntityAsMissionEntity(truckEntity, true, true)

                    if truckBlip and DoesBlipExist(truckBlip) then
                        RemoveBlip(truckBlip)
                    end

                    truckBlip = AddBlipForEntity(truckEntity)
                    Wait(100)

                    if truckBlip and DoesBlipExist(truckBlip) then
                        SetBlipSprite(truckBlip, Config.Blips.truck.sprite)
                        SetBlipDisplay(truckBlip, 4)
                        SetBlipScale(truckBlip, Config.Blips.truck.scale)
                        SetBlipColour(truckBlip, Config.Blips.truck.color)
                        SetBlipAsShortRange(truckBlip, false)
                        SetBlipHiddenOnLegend(truckBlip, false)
                        SetBlipFlashes(truckBlip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(Config.Blips.truck.name)
                        EndTextCommandSetBlipName(truckBlip)
                    end

                    CreateThread(function()
                        local ensureAttempts = 0
                        while ensureAttempts < 10 do
                            if truckBlip and DoesBlipExist(truckBlip) then
                                SetBlipDisplay(truckBlip, 4)
                                SetBlipAsShortRange(truckBlip, false)
                                SetBlipFlashes(truckBlip, true)
                            end
                            ensureAttempts = ensureAttempts + 1
                            Wait(200)
                        end
                    end)

                    break
                end
            end

            attempts = attempts + 1
            Wait(100)
        end
    end)
end)


RegisterNetEvent('olrp_truckheist:client:receiveTracker', function()
    if not currentHeist then return end
    
    currentHeist.trackerReceived = true
    ShowNotification(Config.Messages.trackerReceived, "info", 5000)
    
    -- Make truck blip visible and start flashing
    if truckBlip then
        SetBlipDisplay(truckBlip, 4) -- Show to player
        SetBlipAsShortRange(truckBlip, false) -- Ensure it's not short range
        SetBlipFlashes(truckBlip, true)
        SetBlipHiddenOnLegend(truckBlip, false) -- Ensure it's not hidden in legend
        -- Force blip visibility
        CreateThread(function()
            for i = 1, 5 do
                Wait(100)
                if DoesBlipExist(truckBlip) then
                    SetBlipDisplay(truckBlip, 4)
                    SetBlipAsShortRange(truckBlip, false)
                    SetBlipFlashes(truckBlip, true)
                end
            end
        end)
    end
end)

RegisterNetEvent('olrp_truckheist:client:receivePoliceTracker', function(coords)
    -- Create police tracker blip (static location for initial alert)
    local policeBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(policeBlip, Config.Blips.truck.sprite)
    SetBlipDisplay(policeBlip, 4)
    SetBlipScale(policeBlip, Config.Blips.truck.scale)
    SetBlipColour(policeBlip, 1) -- Red color for police
    SetBlipAsShortRange(policeBlip, false)
    SetBlipFlashes(policeBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("CIT Truck Heist (Initial Location)")
    EndTextCommandSetBlipName(policeBlip)
    
    -- Remove blip after 2 minutes (they'll get the live truck blip)
    SetTimeout(2 * 60 * 1000, function()
        if policeBlip then
            RemoveBlip(policeBlip)
        end
    end)
end)

RegisterNetEvent('olrp_truckheist:client:receiveTruckNetwork', function(truckNetId)
    -- Police receive the actual truck entity network ID
    CreateThread(function()
        -- Wait for the network entity to exist
        local attempts = 0
        while not NetworkDoesNetworkIdExist(truckNetId) and attempts < 100 do
            Wait(100)
            attempts = attempts + 1
        end
        
        if NetworkDoesNetworkIdExist(truckNetId) then
            local truckVehicle = NetworkGetEntityFromNetworkId(truckNetId)
            
            if DoesEntityExist(truckVehicle) then
                -- Create a blip for the truck that follows it
                local policeTruckBlip = AddBlipForEntity(truckVehicle)
                SetBlipSprite(policeTruckBlip, Config.Blips.truck.sprite)
                SetBlipDisplay(policeTruckBlip, 4)
                SetBlipScale(policeTruckBlip, Config.Blips.truck.scale)
                SetBlipColour(policeTruckBlip, 1) -- Red color for police
                SetBlipAsShortRange(policeTruckBlip, false)
                SetBlipFlashes(policeTruckBlip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("CIT Truck (LIVE)")
                EndTextCommandSetBlipName(policeTruckBlip)
                
                -- Monitor truck and remove blip when truck is destroyed or doesn't exist
                CreateThread(function()
                    while DoesEntityExist(truckVehicle) do
                        Wait(1000)
                    end
                    
                    if policeTruckBlip then
                        RemoveBlip(policeTruckBlip)
                    end
                end)
            end
        end
    end)
end)

RegisterNetEvent('olrp_truckheist:client:completeHeist', function(reward)
    ShowNotification(string.format(Config.Messages.heistCompleted, reward), "success", 8000)
    CleanupHeist()
end)

RegisterNetEvent('olrp_truckheist:client:failHeist', function(reason)
    if reason == "truckEscaped" then
        ShowNotification(Config.Messages.truckEscaped, "error", 8000)
    else
        ShowNotification(Config.Messages.heistFailed, "error", 8000)
    end
    CleanupHeist()
end)

RegisterNetEvent('olrp_truckheist:client:endHeist', function(notifyType, message)
    if message and message ~= "" then
        ShowNotification(message, notifyType or "info", 8000)
    end
    CleanupHeist()
end)

RegisterNetEvent('olrp_truckheist:client:showError', function(message)
    ShowNotification(message, "error", 5000)
end)

RegisterNetEvent('olrp_truckheist:client:updatePoliceCount', function(count)
    policeCount = count
end)

-- Interaction Thread
CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        if isInHeist and truckEntity and DoesEntityExist(truckEntity) then
            local truckCoords = GetEntityCoords(truckEntity)
            local truckCoordsVec3 = vector3(truckCoords.x, truckCoords.y, truckCoords.z)
            local distance = #(playerCoords - truckCoordsVec3)
            
            if distance < Config.Loot.interactionDistance then
                sleep = 0
                
                -- Check truck body health (<= 2 means destroyed)
                if GetVehicleBodyHealth(truckEntity) > 2 then
                    -- Truck is not destroyed yet
                    if not explosivePlanted then
                        -- Check if guards are dead
                        if AllGuardsDead() then
                            -- Can plant explosive
                            Draw3DText(truckCoordsVec3, "Press [E] to plant explosive on the truck")
                            
                            if IsControlJustReleased(0, 38) then
                                PlantExplosive()
                            end
                        else
                            -- Guards still alive
                            Draw3DText(truckCoordsVec3, "Eliminate all guards first!")
                        end
                    else
                        -- Explosive already planted, show countdown
                        Draw3DText(truckCoordsVec3, "Explosive planted - get away!")
                    end
                else
                    -- Truck is destroyed (body health <= 2), can loot
                    Draw3DText(truckCoordsVec3, "Press [E] to loot the destroyed truck")
                    
                    if IsControlJustReleased(0, 38) then
                        -- Start looting animation first, give reward when complete
                        LootAnim(truckEntity)
                    end
                end
            end
        end
        
        Wait(sleep)
    end
end)

-- Random driving system - no more fixed delivery locations
-- The truck now drives around randomly, giving players more opportunities to intercept it

-- Clean up heist
function CleanupHeist()
    
    -- Clean up truck blip if truck hasn't exploded yet
    if not truckExploded and truckBlip then
        RemoveBlip(truckBlip)
        truckBlip = nil
    end
    
    -- Clean up info ped
    DeleteInfoPed()
    infoReceived = false
    
    -- Clean up main truck guards
    for i, guard in pairs(guards) do
        if guard and DoesEntityExist(guard) then
            DeleteEntity(guard)
        end
    end
    guards = {}
    guardsExitedOnce = {} -- Reset exit tracking
    
    -- Clean up escort guards
    for i, guard in pairs(escortGuards) do
        if guard and DoesEntityExist(guard) then
            DeleteEntity(guard)
        end
    end
    escortGuards = {}
    escortGuardsExitedOnce = {} -- Reset escort exit tracking
    
    -- Clean up main truck
    if truckEntity and DoesEntityExist(truckEntity) then
        DeleteEntity(truckEntity)
        truckEntity = nil
    end
    
    -- Clean up escort vehicle
    if escortEntity and DoesEntityExist(escortEntity) then
        DeleteEntity(escortEntity)
        escortEntity = nil
    end
    
    -- Clean up blips (but keep truck blip until explosion)
    -- Don't remove truck blip here - it gets removed after explosion
    if deliveryBlip then
        RemoveBlip(deliveryBlip)
        deliveryBlip = nil
    end
    
    -- Reset variables
    isInHeist = false
    truckExploded = false
    explosivePlanted = false
    trackerActive = false
    currentHeist = nil
end


-- Event-based damage detection for instant guard response
AddEventHandler('gameEventTriggered', function(event, args)
    if event == "CEventNetworkEntityDamage" then
        local victim = args[1]
        local attacker = args[2]
        
        -- Check if the truck, escort, or any guard was damaged
        local shouldReact = false
        
        if victim == truckEntity and DoesEntityExist(truckEntity) and isInHeist then
            shouldReact = true
        elseif victim == escortEntity and DoesEntityExist(escortEntity) and isInHeist then
            shouldReact = true
        else
            -- Check if any guard was damaged (main truck)
            for i, guard in pairs(guards) do
                if victim == guard and DoesEntityExist(guard) then
                    shouldReact = true
                    break
                end
            end
            -- Check if any escort guard was damaged
            if not shouldReact then
                for i, guard in pairs(escortGuards) do
                    if victim == guard and DoesEntityExist(guard) then
                        shouldReact = true
                        break
                    end
                end
            end
        end
        
        if shouldReact and isInHeist then
            -- Make ALL guards in BOTH vehicles exit and attack (instant response)
            for i, guard in pairs(guards) do
                if guard and DoesEntityExist(guard) and not IsEntityDead(guard) then
                    if IsPedInVehicle(guard, truckEntity, true) and not guardsExitedOnce[i] then
                        -- Mark that this guard is exiting (prevent duplicate exits from event spam)
                        guardsExitedOnce[i] = true
                        
                        -- Guard exits immediately
                        CreateThread(function()
                            -- Enable combat for driver if it's the driver
                            if i == 1 then
                                SetPedCombatAttributes(guard, 0, true) -- Can fight now
                            end
                            
                            -- Determine target
                            local targetPed = PlayerPedId()
                            if attacker and attacker ~= -1 and DoesEntityExist(attacker) then
                                targetPed = attacker
                            end
                            
                            -- Start shooting WHILE STILL IN VEHICLE (driveby)
                            SetPedRelationshipGroupHash(guard, GetHashKey("HATES_PLAYER"))
                            TaskCombatPed(guard, targetPed, 0, 16)
                            
                            -- Brief delay to shoot from vehicle, then exit
                            Wait(1000)
                            
                            -- Now exit the vehicle
                            TaskLeaveVehicle(guard, truckEntity, 256) -- Emergency exit
                            Wait(800)
                            
                            -- Continue EXTREME aggressive combat on foot
                            TaskCombatPed(guard, targetPed, 0, 16)
                            SetPedCombatMovement(guard, 3) -- Very aggressive (charges and closes distance)
                            SetPedCombatRange(guard, 1) -- Short range (will close distance)
                            SetPedAccuracy(guard, 85) -- Very accurate
                            SetPedFleeAttributes(guard, 0, false) -- Never flee
                            SetPedKeepTask(guard, true)
                            
                            -- Pursue the player if they flee
                            CreateThread(function()
                                local pursuitTime = 0
                                while pursuitTime < 15000 and DoesEntityExist(guard) and not IsEntityDead(guard) do
                                    if DoesEntityExist(targetPed) and not IsEntityDead(targetPed) then
                                        local guardPos = GetEntityCoords(guard)
                                        local targetPos = GetEntityCoords(targetPed)
                                        local dist = #(guardPos - targetPos)
                                        
                                        -- If target is fleeing (more than 30m away), pursue
                                        if dist > 30.0 and dist < 150.0 then
                                            TaskGoToEntity(guard, targetPed, -1, 5.0, 3.0, 0, 0)
                                            Wait(500)
                                            -- Re-engage combat
                                            TaskCombatPed(guard, targetPed, 0, 16)
                                        end
                                    end
                                    Wait(500)
                                    pursuitTime = pursuitTime + 500
                                end
                            end)
                            
                            -- After combat, allow this guard to exit again on next damage
                            Wait(15000)
                            guardsExitedOnce[i] = false
                        end)
                    end
                end
            end
            
            -- Also make ALL escort guards exit and attack
            for i, guard in pairs(escortGuards) do
                if guard and DoesEntityExist(guard) and not IsEntityDead(guard) then
                    if IsPedInVehicle(guard, escortEntity, true) and not escortGuardsExitedOnce[i] then
                        escortGuardsExitedOnce[i] = true
                        
                        CreateThread(function()
                            if i == 1 then
                                SetPedCombatAttributes(guard, 0, true)
                            end
                            
                            local targetPed = PlayerPedId()
                            if attacker and attacker ~= -1 and DoesEntityExist(attacker) then
                                targetPed = attacker
                            end
                            
                            SetPedRelationshipGroupHash(guard, GetHashKey("HATES_PLAYER"))
                            TaskCombatPed(guard, targetPed, 0, 16)
                            
                            Wait(1000)
                            
                            TaskLeaveVehicle(guard, escortEntity, 256)
                            Wait(800)
                            
                            TaskCombatPed(guard, targetPed, 0, 16)
                            SetPedCombatMovement(guard, 3) -- Very aggressive (charges and closes distance)
                            SetPedCombatRange(guard, 1) -- Short range (will close distance)
                            SetPedAccuracy(guard, 85) -- Very accurate
                            SetPedFleeAttributes(guard, 0, false)
                            SetPedKeepTask(guard, true)
                            
                            CreateThread(function()
                                local pursuitTime = 0
                                while pursuitTime < 15000 and DoesEntityExist(guard) and not IsEntityDead(guard) do
                                    if DoesEntityExist(targetPed) and not IsEntityDead(targetPed) then
                                        local guardPos = GetEntityCoords(guard)
                                        local targetPos = GetEntityCoords(targetPed)
                                        local dist = #(guardPos - targetPos)
                                        
                                        if dist > 30.0 and dist < 150.0 then
                                            TaskGoToEntity(guard, targetPed, -1, 5.0, 3.0, 0, 0)
                                            Wait(500)
                                            TaskCombatPed(guard, targetPed, 0, 16)
                                        end
                                    end
                                    Wait(500)
                                    pursuitTime = pursuitTime + 500
                                end
                            end)
                            
                            Wait(15000)
                            escortGuardsExitedOnce[i] = false
                        end)
                    end
                end
            end
        end
    end
end)

-- Emergency unfreeze command
RegisterCommand('unfreeze', function()
    local Player = PlayerPedId()
    ClearPedTasks(Player)
    FreezeEntityPosition(Player, false)
    RemoveAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
    ShowNotification("Emergency unfreeze activated!", "success", 3000)
end, false)

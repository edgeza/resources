-- Paparazzi NPC System
local paparazziPeds = {}
local paparazziActive = false

-- Spawn Paparazzi NPCs
local function SpawnPaparazziNPC()
    if not celebrityPed or not DoesEntityExist(celebrityPed) then return end
    if #paparazziPeds >= Config.MaxPaparazzi then return end
    
    local celebCoords = GetEntityCoords(celebrityPed)
    
    -- Random spawn position around celebrity
    local angle = math.random() * 360
    local distance = math.random(10, Config.PaparazziSpawnRadius)
    local x = celebCoords.x + (math.cos(angle) * distance)
    local y = celebCoords.y + (math.sin(angle) * distance)
    
    -- Get ground Z
    local z = celebCoords.z
    local foundGround, groundZ = GetGroundZFor_3dCoord(x, y, celebCoords.z + 50.0, false)
    if foundGround then
        z = groundZ
    end
    
    -- Select random paparazzi model
    local model = Config.PaparazziModels[math.random(#Config.PaparazziModels)]
    local modelHash = GetHashKey(model)
    
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(100)
    end
    
    -- Create ped
    local ped = CreatePed(4, modelHash, x, y, z, 0.0, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedFleeAttributes(ped, 0, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    
    -- Give them a phone as camera prop
    GiveWeaponToPed(ped, GetHashKey('WEAPON_UNARMED'), 0, false, true)
    
    table.insert(paparazziPeds, ped)
    SetModelAsNoLongerNeeded(modelHash)
    
    -- Make them follow celebrity
    CreateThread(function()
        while DoesEntityExist(ped) and paparazziActive do
            if DoesEntityExist(celebrityPed) then
                local pedCoords = GetEntityCoords(ped)
                local celebCoords = GetEntityCoords(celebrityPed)
                local distance = #(pedCoords - celebCoords)
                
                if distance > Config.PaparazziFollowDistance then
                    TaskGoToEntity(ped, celebrityPed, -1, Config.PaparazziFollowDistance, 2.0, 1073741824, 0)
                else
                    -- Stop and "take photos"
                    TaskTurnPedToFaceEntity(ped, celebrityPed, -1)
                    
                    -- Random paparazzi behaviors
                    local rand = math.random(1, 3)
                    if rand == 1 then
                        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_MOBILE_FILM_SHOCKING', 0, true)
                    elseif rand == 2 then
                        TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_PAPARAZZI', 0, true)
                    end
                    
                    Wait(5000)
                    ClearPedTasks(ped)
                end
            end
            Wait(3000)
        end
    end)
end

-- Start Paparazzi System
RegisterNetEvent('paparazzi-panic:client:StartEvent', function(data)
    paparazziActive = true
    
    -- Spawn initial paparazzi
    CreateThread(function()
        Wait(2000) -- Wait for celebrity to spawn
        
        -- Spawn paparazzi gradually
        for i = 1, 5 do
            if paparazziActive then
                SpawnPaparazziNPC()
                Wait(2000)
            end
        end
        
        -- Continue spawning paparazzi over time
        while paparazziActive do
            Wait(Config.PaparazziSpawnInterval)
            
            if #paparazziPeds < Config.MaxPaparazzi then
                SpawnPaparazziNPC()
            end
        end
    end)
    
    -- Spawn player paparazzi (make random players act like paparazzi)
    CreateThread(function()
        while paparazziActive do
            Wait(30000) -- Every 30 seconds
            
            if DoesEntityExist(celebrityPed) and not kidnapped then
                local celebCoords = GetEntityCoords(celebrityPed)
                
                -- Notify nearby players
                local players = GetActivePlayers()
                for _, player in ipairs(players) do
                    local targetPed = GetPlayerPed(player)
                    if targetPed ~= PlayerPedId() then
                        local targetCoords = GetEntityCoords(targetPed)
                        local distance = #(targetCoords - celebCoords)
                        
                        if distance < 100.0 then
                            -- Small chance to get notified
                            if math.random(1, 100) <= 30 then
                                TriggerEvent('QBCore:Notify', '📸 Celebrity spotted nearby!', 'primary', 3000)
                            end
                        end
                    end
                end
            end
        end
    end)
end)

-- Stop Paparazzi System
RegisterNetEvent('paparazzi-panic:client:StopPaparazzi', function()
    paparazziActive = false
    
    -- Delete all paparazzi peds
    for _, ped in ipairs(paparazziPeds) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    
    paparazziPeds = {}
end)

-- Clean up on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    for _, ped in ipairs(paparazziPeds) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
end)

-- Make paparazzi react to kidnapping
RegisterNetEvent('paparazzi-panic:client:KidnapStarted', function(kidnapperId)
    -- Make paparazzi run away
    for _, ped in ipairs(paparazziPeds) do
        if DoesEntityExist(ped) then
            ClearPedTasks(ped)
            TaskReactAndFleePed(ped, PlayerPedId())
        end
    end
end)

-- Paparazzi come back after kidnap ends
RegisterNetEvent('paparazzi-panic:client:KidnapEnded', function()
    -- Paparazzi return to following
    for _, ped in ipairs(paparazziPeds) do
        if DoesEntityExist(ped) and DoesEntityExist(celebrityPed) then
            ClearPedTasks(ped)
            Wait(1000)
            TaskGoToEntity(ped, celebrityPed, -1, Config.PaparazziFollowDistance, 2.0, 1073741824, 0)
        end
    end
end)


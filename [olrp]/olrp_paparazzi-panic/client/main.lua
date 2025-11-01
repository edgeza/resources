local QBCore = nil
local QBX = nil

-- Initialize Framework
if Config.Framework == 'qb-core' then
    QBCore = exports[Config.CoreName]:GetCoreObject()
elseif Config.Framework == 'qbox' then
    QBX = exports.qbx_core
end

-- Notification Helper
local function Notify(message, type, duration)
    if Config.Framework == 'qbox' then
        exports.qbx_core:Notify(message, type, duration)
    else
        QBCore.Functions.Notify(message, type, duration)
    end
end

-- Local Variables
local eventActive = false
local celebrityPed = nil
local celebrityBlip = nil
local celebrityData = nil
local lastPhotoTime = 0
local isKidnapping = false
local kidnapped = false
local showTextUI = false
local textUIThread = nil

-- Create Celebrity Blip
local function CreateCelebrityBlip(coords)
    if celebrityBlip then
        RemoveBlip(celebrityBlip)
    end
    
    celebrityBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(celebrityBlip, Config.CelebrityBlip.sprite)
    SetBlipColour(celebrityBlip, Config.CelebrityBlip.color)
    SetBlipScale(celebrityBlip, Config.CelebrityBlip.scale)
    SetBlipAsShortRange(celebrityBlip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.CelebrityBlip.name)
    EndTextCommandSetBlipName(celebrityBlip)
    
    if Config.CelebrityBlip.flash then
        SetBlipFlashes(celebrityBlip, true)
    end
end

-- Update Celebrity Blip Color (for kidnap state)
local function UpdateBlipForKidnap()
    if celebrityBlip then
        SetBlipSprite(celebrityBlip, Config.KidnapBlip.sprite)
        SetBlipColour(celebrityBlip, Config.KidnapBlip.color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.KidnapBlip.name)
        EndTextCommandSetBlipName(celebrityBlip)
    end
end

-- Spawn Celebrity Ped
local function SpawnCelebrity(data)
    -- Load model
    local modelHash = GetHashKey(data.model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(100)
    end
    
    -- Spawn ped
    celebrityPed = CreatePed(4, modelHash, data.location.x, data.location.y, data.location.z, data.location.w, false, true)
    SetEntityAsMissionEntity(celebrityPed, true, true)
    SetPedFleeAttributes(celebrityPed, 0, false)
    SetBlockingOfNonTemporaryEvents(celebrityPed, false) -- Allow events
    SetEntityInvincible(celebrityPed, true)
    SetPedCanRagdoll(celebrityPed, true) -- Allow ragdoll
    TaskWanderStandard(celebrityPed, 10.0, 10)
    
    print('[Paparazzi Panic] Celebrity spawned with ID:', celebrityPed)
    
    -- Create blip
    CreateCelebrityBlip(data.location)
    
    -- Start updating location
    CreateThread(function()
        while eventActive and DoesEntityExist(celebrityPed) do
            local coords = GetEntityCoords(celebrityPed)
            if celebrityBlip then
                SetBlipCoords(celebrityBlip, coords.x, coords.y, coords.z)
            end
            Wait(5000)
        end
    end)
    
    SetModelAsNoLongerNeeded(modelHash)
end

-- Delete Celebrity
local function DeleteCelebrity()
    if DoesEntityExist(celebrityPed) then
        DeleteEntity(celebrityPed)
    end
    celebrityPed = nil
    
    if celebrityBlip then
        RemoveBlip(celebrityBlip)
        celebrityBlip = nil
    end
end

-- Start Event
RegisterNetEvent('paparazzi-panic:client:StartEvent', function(data)
    eventActive = true
    celebrityData = data
    kidnapped = false
    
    -- Spawn celebrity
    SpawnCelebrity(data)
    
    -- Show notification
    Notify('⭐ ' .. data.name .. ' spotted nearby! Get your cameras ready!', 'success', 8000)
    
    -- Start photo checking thread
    CreateThread(function()
        while eventActive do
            Wait(1000)
            
            if not kidnapped and DoesEntityExist(celebrityPed) then
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local celebCoords = GetEntityCoords(celebrityPed)
                local distance = #(playerCoords - celebCoords)
                
                -- Check if player is near celebrity
                if distance < 5.0 then
                    -- Start text UI if not already showing
                    if not showTextUI and not Config.UseTarget then
                        showTextUI = true
                        StartTextUI()
                    end
                    
                    -- Photo interaction
                    if IsControlJustPressed(0, Config.Controls.Photo) then
                        TakePhoto()
                    end
                    
                    -- Kidnap interaction (Hold)
                    if Config.KidnapEnabled and IsControlPressed(0, Config.Controls.Kidnap) then
                        StartKidnap()
                    end
                else
                    -- Stop text UI if player is too far
                    if showTextUI then
                        StopTextUI()
                    end
                end
            else
                -- Stop text UI if event is not active or celebrity is kidnapped
                if showTextUI then
                    StopTextUI()
                end
            end
        end
    end)
end)

-- End Event
RegisterNetEvent('paparazzi-panic:client:EndEvent', function()
    eventActive = false
    kidnapped = false
    isKidnapping = false
    celebrityData = nil
    StopTextUI()
    StopRealisticHolding()
    DeleteCelebrity()
    TriggerEvent('paparazzi-panic:client:StopPaparazzi')
end)

-- Update Location
RegisterNetEvent('paparazzi-panic:client:UpdateLocation', function(coords)
    if celebrityBlip then
        SetBlipCoords(celebrityBlip, coords.x, coords.y, coords.z)
    end
end)

-- Take Photo
function TakePhoto()
    local currentTime = GetGameTimer()
    
    if currentTime - lastPhotoTime < Config.PhotoCooldown then
        local remainingTime = math.ceil((Config.PhotoCooldown - (currentTime - lastPhotoTime)) / 1000)
        Notify('Wait ' .. remainingTime .. ' seconds before taking another photo!', 'error')
        return
    end
    
    lastPhotoTime = currentTime
    
    local playerPed = PlayerPedId()
    
    -- Load camera animation
    RequestAnimDict('amb@world_human_paparazzi@male@base')
    while not HasAnimDictLoaded('amb@world_human_paparazzi@male@base') do
        Wait(100)
    end
    
    -- Play camera animation
    TaskPlayAnim(playerPed, 'amb@world_human_paparazzi@male@base', 'base', 8.0, 8.0, 2000, 1, 0, false, false, false)
    
    -- Wait for animation to start
    Wait(500)
    
    -- Camera flash effect with sound
    DoScreenFadeOut(50)
    PlaySoundFrontend(-1, "CAMERA_FLASH", "PHOTOGRAPHIC_STUDIO_SOUNDSET", true)
    Wait(50)
    DoScreenFadeIn(200)
    
    -- Additional camera sound
    PlaySoundFrontend(-1, "CAMERA_SNAP", "PHOTOGRAPHIC_STUDIO_SOUNDSET", true)
    
    -- Wait for animation to complete
    Wait(1500)
    
    -- Clear animation
    ClearPedTasks(playerPed)
    
    Notify('📸 Exclusive photo taken!', 'success')
    TriggerServerEvent('paparazzi-panic:server:ClaimPhotoReward')
    
    RemoveAnimDict('amb@world_human_paparazzi@male@base')
end

-- Start Kidnap
        function StartKidnap()
            if isKidnapping or kidnapped then return end

            local playerPed = PlayerPedId()
            local celebCoords = GetEntityCoords(celebrityPed)
            local distance = #(GetEntityCoords(playerPed) - celebCoords)

            if distance > Config.KidnapDistance then
                Notify('Get closer to the celebrity!', 'error')
                return
            end

            isKidnapping = true
            TriggerServerEvent('paparazzi-panic:server:StartKidnap')

            -- Load animations
            RequestAnimDict('mp_arresting')
            RequestAnimDict('random@mugging3')
            RequestAnimDict('anim@gangops@hostage@')
            RequestAnimDict('amb@world_human_stand_impatient@male@no_sign@base')
            while not HasAnimDictLoaded('mp_arresting') or not HasAnimDictLoaded('random@mugging3') or not HasAnimDictLoaded('anim@gangops@hostage@') or not HasAnimDictLoaded('amb@world_human_stand_impatient@male@no_sign@base') do
                Wait(100)
            end

            -- AGGRESSIVE celebrity setup - force everything
            if DoesEntityExist(celebrityPed) then
                print('[Paparazzi Panic] AGGRESSIVE celebrity setup...')
                
                -- Clear everything first
                ClearPedTasks(celebrityPed)
                ClearPedSecondaryTask(celebrityPed)
                RemoveAllPedWeapons(celebrityPed, true)
                
                -- Force scared animation immediately
                TaskPlayAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 8.0, 8.0, -1, 1, 0, false, false, false)
                
                -- Aggressive AI disabling
                SetPedFleeAttributes(celebrityPed, 0, false)
                SetBlockingOfNonTemporaryEvents(celebrityPed, true)
                SetEntityInvincible(celebrityPed, true)
                SetPedCanRagdoll(celebrityPed, false)
                SetPedConfigFlag(celebrityPed, 17, false) -- Disable AI
                SetPedConfigFlag(celebrityPed, 32, false) -- Disable AI  
                SetPedConfigFlag(celebrityPed, 35, false) -- Disable AI
                SetPedConfigFlag(celebrityPed, 184, true) -- Disable AI
                SetPedConfigFlag(celebrityPed, 241, true) -- Disable AI
                SetPedConfigFlag(celebrityPed, 242, true) -- Disable AI
                
                -- Force them to face player
                TaskTurnPedToFaceEntity(celebrityPed, playerPed, 1000)
                
                print('[Paparazzi Panic] Celebrity setup complete')
            end

            -- Start player animation
            TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, 8.0, -1, 49, 0, false, false, false)
            PlaySoundFrontend(-1, "GRAB", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

            -- Create progress bar
            local startTime = GetGameTimer()
            local duration = Config.KidnapTime
            local cancelled = false

            CreateThread(function()
                while isKidnapping and (GetGameTimer() - startTime) < duration do
                    local remaining = math.ceil((duration - (GetGameTimer() - startTime)) / 1000)

                    -- Draw progress bar
                    SetTextScale(0.5, 0.5)
                    SetTextFont(4)
                    SetTextProportional(1)
                    SetTextColour(255, 255, 255, 255)
                    SetTextEntry("STRING")
                    SetTextCentre(true)
                    AddTextComponentString("Kidnapping celebrity... " .. remaining .. "s (Press H to cancel)")
                    DrawText(0.5, 0.9)

                    -- AGGRESSIVELY force celebrity animation every frame
                    if DoesEntityExist(celebrityPed) then
                        -- Force scared animation continuously
                        if not IsEntityPlayingAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 3) then
                            ClearPedTasks(celebrityPed)
                            TaskPlayAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 8.0, 8.0, -1, 1, 0, false, false, false)
                        end
                        
                        -- Keep AI disabled
                        SetPedFleeAttributes(celebrityPed, 0, false)
                        SetBlockingOfNonTemporaryEvents(celebrityPed, true)
                        SetEntityInvincible(celebrityPed, true)
                        SetPedCanRagdoll(celebrityPed, false)
                        SetPedConfigFlag(celebrityPed, 17, false)
                        SetPedConfigFlag(celebrityPed, 32, false)
                        SetPedConfigFlag(celebrityPed, 35, false)
                        SetPedConfigFlag(celebrityPed, 184, true)
                        SetPedConfigFlag(celebrityPed, 241, true)
                        SetPedConfigFlag(celebrityPed, 242, true)
                    end

                    -- Check for cancel (H pressed again)
                    if IsControlJustPressed(0, Config.Controls.Kidnap) then
                        cancelled = true
                        break
                    end

                    -- Check distance
                    local currentDistance = #(GetEntityCoords(playerPed) - GetEntityCoords(celebrityPed))
                    if currentDistance > Config.KidnapDistance + 2.0 then
                        cancelled = true
                        Notify('You moved too far from the celebrity!', 'error')
                        break
                    end

                    Wait(0)
                end

                -- Handle result
                if cancelled then
                    ClearPedTasks(playerPed)
                    isKidnapping = false
                    Notify('Kidnapping cancelled!', 'error')
                elseif isKidnapping then
                    -- Success
                    ClearPedTasks(playerPed)

                    -- Final handcuff animation
                    TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, 8.0, 2000, 1, 0, false, false, false)
                    Wait(2000)
                    ClearPedTasks(playerPed)

                    -- AGGRESSIVE hostage setup
                    if DoesEntityExist(celebrityPed) then
                        ClearPedTasks(celebrityPed)
                        SetEntityInvincible(celebrityPed, true)
                        SetPedFleeAttributes(celebrityPed, 0, false)
                        SetBlockingOfNonTemporaryEvents(celebrityPed, true)
                        SetPedCanRagdoll(celebrityPed, false)
                        SetPedConfigFlag(celebrityPed, 17, false)
                        SetPedConfigFlag(celebrityPed, 32, false)
                        SetPedConfigFlag(celebrityPed, 35, false)
                        SetPedConfigFlag(celebrityPed, 184, true)
                        SetPedConfigFlag(celebrityPed, 241, true)
                        SetPedConfigFlag(celebrityPed, 242, true)
                    end

                    -- Start hostage system
                    StartHostageSystem()

                    TriggerServerEvent('paparazzi-panic:server:CompleteKidnap')
                    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                    Notify('Celebrity kidnapped! You now control them!', 'success')

                    isKidnapping = false
                end

                RemoveAnimDict('mp_arresting')
                RemoveAnimDict('random@mugging3')
                RemoveAnimDict('anim@gangops@hostage@')
                RemoveAnimDict('amb@world_human_stand_impatient@male@no_sign@base')
            end)
        end

-- Kidnap Started (for other players to see)
RegisterNetEvent('paparazzi-panic:client:KidnapStarted', function(kidnapperId)
    if kidnapperId ~= GetPlayerServerId(PlayerId()) then
        Notify('Someone is trying to kidnap the celebrity!', 'error')
    end
end)

-- Kidnap Complete
RegisterNetEvent('paparazzi-panic:client:KidnapComplete', function(kidnapperId)
    kidnapped = true
    StopTextUI()
    UpdateBlipForKidnap()
    
    -- Make celebrity react to being kidnapped
    if DoesEntityExist(celebrityPed) then
        -- Load scared animation
        RequestAnimDict('random@mugging3')
        while not HasAnimDictLoaded('random@mugging3') do
            Wait(100)
        end
        
        -- Play scared animation
        TaskPlayAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 8.0, 8.0, -1, 1, 0, false, false, false)
        
        -- Add some panic behavior
        SetPedFleeAttributes(celebrityPed, 0, false)
        SetBlockingOfNonTemporaryEvents(celebrityPed, true)
        
        RemoveAnimDict('random@mugging3')
    end
    
    if kidnapperId == GetPlayerServerId(PlayerId()) then
        -- Start delivery location check
        CreateThread(function()
            while kidnapped and DoesEntityExist(celebrityPed) do
                Wait(1000)
                
                local playerPed = PlayerPedId()
                local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(celebrityPed))
                
                -- If celebrity is too far, they escape
                if distance > 50.0 then
                    Notify('The celebrity escaped!', 'error')
                    TriggerServerEvent('paparazzi-panic:server:CelebrityEscaped')
                    kidnapped = false
                    break
                end
            end
        end)
    else
        -- For police and others
        Notify('🚨 Track down the kidnapper and rescue the celebrity!', 'primary', 8000)
    end
end)

-- Kidnap Ended
RegisterNetEvent('paparazzi-panic:client:KidnapEnded', function()
    kidnapped = false
    isKidnapping = false
    
    -- Stop realistic holding
    StopRealisticHolding()
    
    if DoesEntityExist(celebrityPed) then
        ClearPedTasks(celebrityPed)
        ResetPedMovementClipset(celebrityPed, 0)
        TaskWanderStandard(celebrityPed, 10.0, 10)
        
        if celebrityBlip then
            SetBlipSprite(celebrityBlip, Config.CelebrityBlip.sprite)
            SetBlipColour(celebrityBlip, Config.CelebrityBlip.color)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.CelebrityBlip.name)
            EndTextCommandSetBlipName(celebrityBlip)
        end
    end
end)

-- Police Rescue Command
RegisterCommand('rescuecelebrity', function()
    if not kidnapped then
        Notify('No active kidnapping!', 'error')
        return
    end
    
    if not DoesEntityExist(celebrityPed) then
        Notify('Celebrity not found!', 'error')
        return
    end
    
    local playerPed = PlayerPedId()
    local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(celebrityPed))
    
    if distance > 5.0 then
        Notify('Get closer to the celebrity!', 'error')
        return
    end
    
    if Config.Framework == 'qbox' then
        if exports.qbx_core:Progressbar({
            name = 'rescue_celeb',
            duration = 5000,
            label = 'Rescuing celebrity...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true,
                mouse = false
            }
        }) then
            TriggerServerEvent('paparazzi-panic:server:RescueCelebrity')
        else
            Notify('Rescue cancelled!', 'error')
        end
    else
        QBCore.Functions.Progressbar('rescue_celeb', 'Rescuing celebrity...', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Success
            TriggerServerEvent('paparazzi-panic:server:RescueCelebrity')
        end, function() -- Cancel
            Notify('Rescue cancelled!', 'error')
        end)
    end
end)

-- Police Crowd Control
RegisterCommand('crowdcontrol', function()
    if not eventActive then
        Notify('No active celebrity event!', 'error')
        return
    end
    
    TriggerServerEvent('paparazzi-panic:server:CrowdControl')
end)

-- Release Celebrity (for kidnapper)
RegisterCommand('releasecelebrity', function()
    if not kidnapped then
        Notify('No kidnapped celebrity to release!', 'error')
        return
    end
    
    local playerPed = PlayerPedId()
    local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(celebrityPed))
    
    if distance > 5.0 then
        Notify('Get closer to the celebrity!', 'error')
        return
    end
    
    -- Release animation
    RequestAnimDict('mp_arresting')
    while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
    end
    
    TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, 8.0, 2000, 1, 0, false, false, false)
    
    Wait(2000)
    ClearPedTasks(playerPed)
    
    -- Stop hostage system and release celebrity
    StopHostageSystem()
    
    if DoesEntityExist(celebrityPed) then
        ClearPedTasks(celebrityPed)
        ResetPedMovementClipset(celebrityPed, 0)
        TaskWanderStandard(celebrityPed, 10.0, 10)
    end
    
    TriggerServerEvent('paparazzi-panic:server:ReleaseCelebrity')
    Notify('Celebrity released!', 'success')
    
    RemoveAnimDict('mp_arresting')
end)

-- Debug Celebrity Status
RegisterCommand('debugcelebrity', function()
    DebugCelebrityStatus()
end)

-- Test Basic Movement
RegisterCommand('testbasicmove', function()
    if DoesEntityExist(celebrityPed) then
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        -- Try the most basic movement possible
        ClearPedTasks(celebrityPed)
        TaskGoToCoordAnyMeans(celebrityPed, playerCoords.x, playerCoords.y, playerCoords.z, 1.0, 0, 0, 786603, 0xbf800000)
        
        print('[Paparazzi Panic] Testing basic movement to player')
        Notify('Testing basic movement!', 'success')
    else
        Notify('No celebrity found!', 'error')
    end
end)

-- Test Simple Animation
RegisterCommand('testsimpleanim', function()
    if DoesEntityExist(celebrityPed) then
        -- Try the simplest possible animation
        ClearPedTasks(celebrityPed)
        TaskPlayAnim(celebrityPed, 'mp_common', 'givetake1_a', 8.0, 8.0, 3000, 1, 0, false, false, false)
        
        print('[Paparazzi Panic] Testing simple animation')
        Notify('Testing simple animation!', 'success')
    else
        Notify('No celebrity found!', 'error')
    end
end)

-- Reset Celebrity
RegisterCommand('resetcelebrity', function()
    if DoesEntityExist(celebrityPed) then
        ClearPedTasks(celebrityPed)
        SetEntityInvincible(celebrityPed, false)
        SetPedFleeAttributes(celebrityPed, 0, true)
        SetBlockingOfNonTemporaryEvents(celebrityPed, false)
        SetPedCanRagdoll(celebrityPed, true)
        TaskWanderStandard(celebrityPed, 10.0, 10)
        
        print('[Paparazzi Panic] Reset celebrity to normal behavior')
        Notify('Celebrity reset to normal!', 'success')
    else
        Notify('No celebrity found!', 'error')
    end
end)

-- Force Celebrity Animation (for testing)
RegisterCommand('forcecelebrityanim', function()
    if DoesEntityExist(celebrityPed) then
        -- Load animation
        RequestAnimDict('random@mugging3')
        while not HasAnimDictLoaded('random@mugging3') do
            Wait(100)
        end
        
        -- Clear tasks and force animation
        ClearPedTasks(celebrityPed)
        TaskPlayAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 8.0, 8.0, -1, 1, 0, false, false, false)
        
        print('[Paparazzi Panic] Forced scared animation on celebrity')
        Notify('Forced celebrity animation!', 'success')
        
        RemoveAnimDict('random@mugging3')
    else
        Notify('No celebrity found!', 'error')
    end
end)

-- Test Celebrity Following
RegisterCommand('testcelebrityfollow', function()
    if DoesEntityExist(celebrityPed) then
        local playerPed = PlayerPedId()
        
        -- Direct control approach
        ClearPedTasks(celebrityPed)
        SetEntityInvincible(celebrityPed, true)
        SetPedFleeAttributes(celebrityPed, 0, false)
        SetBlockingOfNonTemporaryEvents(celebrityPed, true)
        SetPedCanRagdoll(celebrityPed, false)
        SetPedConfigFlag(celebrityPed, 17, false) -- Disable AI
        SetPedConfigFlag(celebrityPed, 32, false) -- Disable AI
        SetPedConfigFlag(celebrityPed, 35, false) -- Disable AI
        
        -- Create group
        local groupId = GetPedGroupIndex(playerPed)
        if groupId == -1 then
            groupId = CreateGroup(0)
            SetPedAsGroupLeader(playerPed, groupId)
        end
        SetPedAsGroupMember(celebrityPed, groupId)
        
        -- Force scared animation
        TaskPlayAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 8.0, 8.0, -1, 1, 0, false, false, false)
        
        -- Make celebrity follow using group system
        TaskFollowToOffsetOfEntity(celebrityPed, playerPed, 0.0, -1.5, 0.0, 1.0, -1, 1.0, true)
        
        print('[Paparazzi Panic] Using direct control approach')
        Notify('Celebrity should follow you with scared animation!', 'success')
        
        -- Start a thread to keep them following
        CreateThread(function()
            for i = 1, 15 do -- Test for 15 seconds
                Wait(1000)
                if DoesEntityExist(celebrityPed) then
                    local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(celebrityPed))
                    print('[Paparazzi Panic] Celebrity distance:', distance)
                    
                    -- Keep forcing scared animation
                    if not IsEntityPlayingAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 3) then
                        TaskPlayAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 8.0, 8.0, -1, 1, 0, false, false, false)
                    end
                    
                    if distance > 3.0 then
                        TaskFollowToOffsetOfEntity(celebrityPed, playerPed, 0.0, -1.5, 0.0, 1.0, -1, 1.0, true)
                    end
                end
            end
            
            -- Clean up
            if DoesEntityExist(celebrityPed) then
                RemovePedFromGroup(celebrityPed)
                ClearPedTasks(celebrityPed)
            end
        end)
    else
        Notify('No celebrity found!', 'error')
    end
end)

-- Start Text UI Thread
function StartTextUI()
    if textUIThread then return end
    
    textUIThread = CreateThread(function()
        while showTextUI and eventActive and DoesEntityExist(celebrityPed) do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local celebCoords = GetEntityCoords(celebrityPed)
            local distance = #(playerCoords - celebCoords)
            
            if distance < 5.0 and not kidnapped then
                DrawText3D(celebCoords.x, celebCoords.y, celebCoords.z + 1.0, 
                    Config.ControlLabels.Photo .. ' Take Photo  ' .. Config.ControlLabels.Kidnap .. ' Kidnap (Hold)')
            end
            Wait(0)
        end
        textUIThread = nil
    end)
end

-- Stop Text UI Thread
function StopTextUI()
    showTextUI = false
    if textUIThread then
        textUIThread = nil
    end
end

-- Hostage System
local hostageThread = nil
local isHolding = false

        function StartHostageSystem()
            if hostageThread then return end

            isHolding = true
            hostageThread = CreateThread(function()
                print('[Paparazzi Panic] Starting AGGRESSIVE hostage system...')

                -- Load hostage animations
                RequestAnimDict('anim@gangops@hostage@')
                RequestAnimDict('random@mugging3')
                while not HasAnimDictLoaded('anim@gangops@hostage@') or not HasAnimDictLoaded('random@mugging3') do
                    Wait(100)
                end

                while isHolding and kidnapped and DoesEntityExist(celebrityPed) do
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local celebCoords = GetEntityCoords(celebrityPed)
                    local distance = #(playerCoords - celebCoords)

                    -- If celebrity is too far, they escape
                    if distance > 50.0 then
                        Notify('The celebrity escaped!', 'error')
                        TriggerServerEvent('paparazzi-panic:server:CelebrityEscaped')
                        break
                    end

                    -- AGGRESSIVELY keep celebrity controlled
                    SetEntityInvincible(celebrityPed, true)
                    SetPedFleeAttributes(celebrityPed, 0, false)
                    SetBlockingOfNonTemporaryEvents(celebrityPed, true)
                    SetPedCanRagdoll(celebrityPed, false)
                    SetPedConfigFlag(celebrityPed, 17, false) -- Disable AI
                    SetPedConfigFlag(celebrityPed, 32, false) -- Disable AI
                    SetPedConfigFlag(celebrityPed, 35, false) -- Disable AI
                    SetPedConfigFlag(celebrityPed, 184, true) -- Disable AI
                    SetPedConfigFlag(celebrityPed, 241, true) -- Disable AI
                    SetPedConfigFlag(celebrityPed, 242, true) -- Disable AI

                    -- AGGRESSIVELY force hostage animation
                    if not IsEntityPlayingAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 3) then
                        ClearPedTasks(celebrityPed)
                        TaskPlayAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 8.0, 8.0, -1, 1, 0, false, false, false)
                    end

                    -- AGGRESSIVE movement - force them to follow
                    if distance > 2.0 then
                        -- Force them to move to player
                        local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, -1.5, 0.0)
                        TaskGoToCoordAnyMeans(celebrityPed, offset.x, offset.y, offset.z, 1.0, 0, 0, 786603, 0xbf800000)
                        
                        -- Also try follow task as backup
                        TaskFollowToOffsetOfEntity(celebrityPed, playerPed, 0.0, -1.5, 0.0, 1.0, -1, 1.0, true)
                    elseif distance < 0.8 then
                        -- If too close, make them step back
                        local backOffset = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.5, 0.0)
                        TaskGoToCoordAnyMeans(celebrityPed, backOffset.x, backOffset.y, backOffset.z, 1.0, 0, 0, 786603, 0xbf800000)
                    end

                    Wait(50) -- Check very frequently for smooth movement
                end

                print('[Paparazzi Panic] Stopping AGGRESSIVE hostage system...')
                hostageThread = nil
                RemoveAnimDict('anim@gangops@hostage@')
                RemoveAnimDict('random@mugging3')
            end)
        end

function StopHostageSystem()
    isHolding = false
    if hostageThread then
        hostageThread = nil
    end
end

-- Debug function to check celebrity status
function DebugCelebrityStatus()
    if DoesEntityExist(celebrityPed) then
        local coords = GetEntityCoords(celebrityPed)
        local animDict = GetEntityAnimDict(celebrityPed)
        local animName = GetEntityAnimName(celebrityPed)
        local health = GetEntityHealth(celebrityPed)
        local isDead = IsEntityDead(celebrityPed)
        local isInVehicle = IsPedInAnyVehicle(celebrityPed, false)
        local isRagdoll = IsPedRagdoll(celebrityPed)
        
        print('[Paparazzi Panic] Celebrity Debug:')
        print('  Coords:', coords.x, coords.y, coords.z)
        print('  Health:', health)
        print('  Is Dead:', isDead)
        print('  Is In Vehicle:', isInVehicle)
        print('  Is Ragdoll:', isRagdoll)
        print('  Anim Dict:', animDict or 'none')
        print('  Anim Name:', animName or 'none')
        print('  Is Playing Anim:', IsEntityPlayingAnim(celebrityPed, 'random@mugging3', 'handsup_loop_base', 3))
        print('  Is Holding:', isHolding)
        print('  Is Kidnapped:', kidnapped)
        print('  Entity Model:', GetEntityModel(celebrityPed))
    else
        print('[Paparazzi Panic] Celebrity does not exist!')
    end
end

-- Draw 3D Text
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Request event status on resource start
CreateThread(function()
    Wait(1000)
    TriggerServerEvent('paparazzi-panic:server:GetEventStatus')
end)

-- Receive event status
RegisterNetEvent('paparazzi-panic:client:ReceiveEventStatus', function(active, data, isKidnapped)
    if active and data then
        eventActive = true
        celebrityData = data
        kidnapped = isKidnapped
        SpawnCelebrity(data)
        
        if isKidnapped then
            UpdateBlipForKidnap()
        end
    end
end)


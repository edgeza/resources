local Config = lib.require('config')
local RewardConfig = lib.require('reward_config')
local olrpDropbox = {}
local delay = false
local showText = false
local startBeeps = false
local isBeingCollected = false -- Client-side collection lock
local grabDict, grabAnim = 'anim@scripted@player@freemode@tun_prep_ig1_grab_low@male@', 'grab_low'

function clearDropboxHunt()
    if DoesBlipExist(olrpDropbox.blip) then RemoveBlip(olrpDropbox.blip) end
    if DoesBlipExist(olrpDropbox.blip2) then RemoveBlip(olrpDropbox.blip2) end
    if olrpDropbox.point then olrpDropbox.point:remove() end
    delay = false
    startBeeps = false
    isBeingCollected = false -- Reset collection lock
    table.wipe(olrpDropbox)
    local isOpen, currentText = lib.isTextUIOpen()
    if isOpen and currentText == Config.TextUIMessage then
        lib.hideTextUI()
        showText = false
    end
end

local function createRadius(coords, rarity)
    local offset = math.random(-100, 100)
    local rarityColors = RewardConfig.RarityColors[rarity] or RewardConfig.RarityColors.Common
    
    -- radius created
    
    local blip = AddBlipForRadius(coords.x + offset, coords.y + offset, coords.z, 250.0)
    SetBlipAlpha(blip, rarityColors.radiusAlpha)
    SetBlipHighDetail(blip, true)
    SetBlipColour(blip, rarityColors.radiusColor or rarityColors.blipColor)
    SetBlipAsShortRange(blip, true)
    
    local blip2 = AddBlipForCoord(coords.x + offset, coords.y + offset, coords.z)
    
    -- Use different sprites for different rarities
    local sprite = 478 -- Default purple crate
    if rarity == "Common" then
        sprite = 478 -- White crate
    elseif rarity == "Uncommon" then
        sprite = 478 -- Green crate
    elseif rarity == "Rare" then
        sprite = 478 -- Blue crate
    elseif rarity == "Epic" then
        sprite = 478 -- Purple crate
    elseif rarity == "Legendary" then
        sprite = 478 -- Orange crate
    end
    
    SetBlipSprite(blip2, sprite)
    SetBlipScale(blip2, rarity == "Legendary" and 1.2 or 1.0) -- Larger for legendary
    SetBlipColour(blip2, rarityColors.blipColor)
    SetBlipAsShortRange(blip2, true)
    if rarity == "Legendary" then
        SetBlipFlashes(blip2, true) -- Flash for legendary
    end
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(("%s%s Dropbox"):format(rarityColors.textColor, rarity))
    EndTextCommandSetBlipName(blip2)
    return blip, blip2
end

local function grabDropbox()
    -- Get collection time based on rarity
    local collectionTime = 60000 -- Default 60 seconds
    if olrpDropbox.rarity then
        local times = {
            Common = 60000,    -- 10 seconds
            Uncommon = 60000,  -- 20 seconds
            Rare = 60000,      -- 40 seconds
            Epic = 60000,      -- 50 seconds
            Legendary = 60000  -- 60 seconds
        }
        collectionTime = times[olrpDropbox.rarity] or 10000
    end
    
    -- Use dropbox coordinates for distance validation (more accurate than initial position)
    local dropboxCoords = olrpDropbox.coords
    local maxDistance = 10.0 -- Maximum allowed distance from dropbox during collection
    
    -- Start distance validation thread
    local distanceCheckActive = true
    local distanceCheckThread = CreateThread(function()
        while distanceCheckActive do
            Wait(500) -- Check every 0.5 seconds for more responsive validation
            
            local currentCoords = GetEntityCoords(GetPlayerPed(-1))
            local distance = #(currentCoords - vec3(dropboxCoords.x, dropboxCoords.y, dropboxCoords.z))
            
            if distance > maxDistance then
                -- Player moved too far, cancel collection
                print("^1[MAIN] Collection cancelled - player moved too far from dropbox (distance: " .. distance .. ")")
                DoNotification("Collection cancelled - you moved too far from the dropbox!", 'error')
                distanceCheckActive = false -- Stop the thread
                isBeingCollected = false
                TriggerServerEvent('olrp_dropbox:server:cancelCollection')
                return
            end
        end
        -- Thread ended naturally - no need to print (avoid spam)
    end)
    
    -- Unified ox_lib progress without manual cancellation
    local ok = lib.progressBar({
        duration = collectionTime,
        label = "Unlocking OLRP Dropbox...",
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
            car = true,
            mouse = false,
            combat = true,
        },
        anim = {
            dict = grabDict,
            clip = grabAnim,
            flag = 1,
        }
    })

    if not ok then
        -- Progress bar was cancelled - wait for distance thread to exit
        distanceCheckActive = false
        Wait(100) -- Give time for thread to exit
        ClearPedTasksImmediately(GetPlayerPed(-1))
        showText = false
        lib.hideTextUI()
        delay = false
        isBeingCollected = false -- Reset client-side lock
        TriggerServerEvent('olrp_dropbox:server:cancelCollection')
        return
    end

    -- Progress bar completed successfully, stop distance check thread
    distanceCheckActive = false
    Wait(100) -- Give time for thread to exit cleanly
    
    -- Check if dropbox is still active before attempting collection
    if not GlobalState.OLRPDropboxActive then
        print("^1[MAIN] Collection failed - dropbox no longer active")
        DoNotification("This dropbox is no longer available!", 'error')
        delay = false
        isBeingCollected = false
        return
    end

    print("^3[CLIENT] Sending collection request to server...")
    local success = lib.callback.await('olrp_dropbox:server:foundDropbox', false, 10000) -- Increased to 10 second timeout
    print(("^3[CLIENT] Server response: %s"):format(tostring(success)))
    
    if success then
        PlaySoundFrontend(-1, 'Audio_Player_Shard_Final', 'Tuner_Collectables_General_Sounds', false)
        print(("^2[CLIENT] Successfully collected dropbox"))
        DoNotification("Successfully collected the dropbox! Check your inventory for rewards.", 'success')
    else
        -- Collection failed, show error message with retry option
        print("^1[CLIENT] Collection failed - dropbox may have been collected by someone else or server error occurred")
        DoNotification("Collection failed! Press F9 to retry or try again manually.", 'error')
        
        -- Add retry functionality
        CreateThread(function()
            local retryTime = 0
            while retryTime < 30 do -- Allow retry for 30 seconds
                Wait(1000)
                retryTime = retryTime + 1
                
                if IsControlJustPressed(0, 56) then -- F9 key
                    if GlobalState.OLRPDropboxActive and not isBeingCollected then
                        print("^2[MAIN] Player retrying collection...")
                        TriggerServerEvent('olrp_dropbox:server:retryCollection')
                        break
                    else
                        DoNotification("Cannot retry - dropbox not available!", 'error')
                    end
                end
            end
        end)
    end
    delay = false
    isBeingCollected = false -- Reset client-side lock (stops distance thread)
end

RegisterNetEvent('olrp_dropbox:client:initHunt', function(coords, rarity)
    if GetInvokingResource() or not hasPlyLoaded() or not coords then return end
    
    -- Clear any existing dropbox hunt to prevent duplicates
    clearDropboxHunt()
    
    DoNotification(Config.DropNotify, 'success')
    PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
    olrpDropbox.coords = coords
    olrpDropbox.rarity = rarity or "Common"
    
    -- creating dropbox
    olrpDropbox.blip, olrpDropbox.blip2 = createRadius(olrpDropbox.coords, olrpDropbox.rarity)
    olrpDropbox.point = lib.points.new({ 
        coords = vec3(olrpDropbox.coords.x, olrpDropbox.coords.y, olrpDropbox.coords.z), 
        distance = 30.0,
        onEnter = function()
            if DoesBlipExist(olrpDropbox.blip2) then RemoveBlip(olrpDropbox.blip2) end
            startBeeps = true
            CreateThread(function()
                while startBeeps do
                    PlaySoundFromCoord(-1, 'CONFIRM_BEEP', olrpDropbox.coords.x, olrpDropbox.coords.y, olrpDropbox.coords.z, 'HUD_MINI_GAME_SOUNDSET', 0, 30.0, 0)
                    Wait(3000)
                end
                print("^2[MAIN] Sound thread ended")
            end)
        end,
        onExit = function()
            startBeeps = false
            lib.hideTextUI()
        end,
        nearby = function(point)
            if point.isClosest and point.currentDistance <= 5.0 then
                if not showText then
                    showText = true
                    lib.showTextUI(Config.TextUIMessage, {position = "left-center"})
                end

                if IsControlJustReleased(0, 38) then
                    if GlobalState.OLRPDropboxActive and not delay and not isBeingCollected then
                        -- Additional validation before starting collection
                        local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                        local distance = #(playerCoords - vec3(olrpDropbox.coords.x, olrpDropbox.coords.y, olrpDropbox.coords.z))
                        
                        if distance <= 5.0 then
                            delay = true
                            isBeingCollected = true
                            lib.hideTextUI() -- Hide text immediately when starting collection
                            grabDropbox()
                        else
                            DoNotification("You're too far from the dropbox! Get closer.", 'error')
                        end
                    elseif isBeingCollected then
                        -- Someone is already collecting, show a message
                        DoNotification("Someone is already collecting this dropbox!", 'error')
                    elseif not GlobalState.OLRPDropboxActive then
                        -- Dropbox is no longer active
                        DoNotification("This dropbox is no longer available!", 'error')
                    end
                end
            elseif showText then
                showText = false
                lib.hideTextUI()
            end
        end,
    })
end)

RegisterNetEvent('olrp_dropbox:client:cleanupHunt', function()
    if GetInvokingResource() or not hasPlyLoaded() then return end
    clearDropboxHunt()
end)

RegisterNetEvent('olrp_dropbox:client:setCollectionLock', function(locked)
    if GetInvokingResource() or not hasPlyLoaded() then return end
    isBeingCollected = locked
end)

RegisterNetEvent('olrp_dropbox:client:getLocationData', function(data)
    if GetInvokingResource() or not hasPlyLoaded() then return end
    
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    local streetName, crossingRoad = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local locationText = ('%s%s'):format(GetStreetNameFromHashKey(streetName), crossingRoad ~= 0 and (' & ' .. GetStreetNameFromHashKey(crossingRoad)) or '')
    local coordsText = ('(%.2f, %.2f, %.2f)'):format(coords.x, coords.y, coords.z)
    
    -- Add location data to the existing data
    data.locationText = locationText
    data.coordsText = coordsText
    
    -- Send back to server
    TriggerServerEvent('olrp_dropbox:server:sendLocationData', data)
end)

RegisterNetEvent('olrp_dropbox:client:retryCollection', function()
    if GetInvokingResource() or not hasPlyLoaded() then return end
    
    if not delay and not isBeingCollected and GlobalState.OLRPDropboxActive then
        delay = true
        isBeingCollected = true
        lib.hideTextUI() -- Hide text immediately when starting collection
        grabDropbox()
    else
        DoNotification("Cannot retry collection at this time!", 'error')
    end
end)


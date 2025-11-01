-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        -- OLRP LOOT CASE SCRIPT --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- Author: OLRP Development

local isCaseOpening = false
local isRewardPending = false -- Track if reward is being processed

local function OpenCase(itemRewarded, caseItems)
    -- Prevent opening a new case if one is already in progress or reward is pending
    if isCaseOpening or isRewardPending then
        print("^1[Loot Cases] Attempted to open a case while one is already opening or reward is pending. Ignoring.")
        return
    end
    
    -- Validate input
    if not itemRewarded or not caseItems then
        print("^1[Loot Cases] Invalid case data received, ignoring.")
        return
    end
    
    isCaseOpening = true
    
    -- Ensure previous case is closed first
    SetNuiFocus(false, false)
    SendNUIMessage({type = "Close_caseOpener"})
    
    -- Small delay to ensure cleanup
    Wait(150)
    
    -- Double-check we're still supposed to open (in case cleanup happened)
    if not isCaseOpening then
        return
    end
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "Open_caseOpener", 
        caseData = {
            title = caseItems.title,
            description = caseItems.description,
            color = caseItems.color,
            image = caseItems.image
        },
        items = caseItems.items,
        reward = itemRewarded
    })
end


RegisterNetEvent('olrp_lootcases:openCase', OpenCase)

-- Event to confirm reward was processed (optional, for client-side tracking)
RegisterNetEvent('olrp_lootcases:rewardProcessed', function()
    isRewardPending = false
end)

RegisterNUICallback('closeCaseOpener', function(data, cb)
    -- Mark that reward is pending to prevent new case opening
    isRewardPending = true
    isCaseOpening = false
    
    SetNuiFocus(false, false)
    SendNUIMessage({type = "Close_caseOpener"})
    
    -- Send reward request to server
    TriggerServerEvent('olrp_lootcases:rewardPlayer')
    
    cb('ok')
end)

RegisterNUICallback('forceClose', function(data, cb)
    isCaseOpening = false
    isRewardPending = false -- Clear pending flag on force close
    SetNuiFocus(false, false)
    SendNUIMessage({type = "Close_caseOpener"})
    
    -- Notify server that case was force closed (don't give reward, but clear server state)
    TriggerServerEvent('olrp_lootcases:forceClose')
    
    cb('ok')
end)

AddEventHandler('onClientResourceStart', function (resourceName)
    if(GetCurrentResourceName() ~= resourceName) then
      return
    end
    
    -- Don't send any NUI messages on resource start to avoid conflicts
    -- The UI will be initialized when a case is actually opened
end)
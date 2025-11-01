-- QBox doesn't use GetCoreObject, we'll use the exports directly

-- Debug function
local function debugPrint(message)
    print("^2[QB-Stashes Debug]^7 " .. message)
end

debugPrint("QB-Stashes script loaded")

Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local text = '[E] Open Stash'
    while true do
    wait = 5
    local ped = PlayerPedId()
    local inZone = false

    for k, v in pairs(Config.Stashes) do
        local dist = #(GetEntityCoords(ped)-vector3(Config.Stashes[k].coords.x, Config.Stashes[k].coords.y, Config.Stashes[k].coords.z))
        
        if dist <= 2.0 then
            wait = 5
            inZone = true
            
            if not alreadyEnteredZone then
                debugPrint("Near stash: " .. k .. " (distance: " .. string.format("%.2f", dist) .. ")")
            end

            if IsControlJustReleased(0, 38) then
                debugPrint("E key pressed for stash: " .. k)
                TriggerEvent('qb-business:client:openStash', k, Config.Stashes[k].stashName)
            end
            break
        else
            wait = 2000
        end
    end

    if inZone and not alreadyEnteredZone then
        alreadyEnteredZone = true
        debugPrint("Entered stash zone")
        exports.ox_lib:showTextUI(text, {
            position = 'left-center'
        })
    end

    if not inZone and alreadyEnteredZone then
        alreadyEnteredZone = false
        debugPrint("Left stash zone")
        exports.ox_lib:hideTextUI()
    end
    Citizen.Wait(wait)
    end
end)

RegisterNetEvent('qb-business:client:openStash', function(currentstash, stash)
    debugPrint("Attempting to open stash: " .. tostring(currentstash))
    
    local PlayerData = exports.qbx_core:GetPlayerData()
    local PlayerJob = PlayerData.job.name
    local PlayerGang = PlayerData.gang.name
    local canOpen = false
    
    debugPrint("Player Job: " .. tostring(PlayerJob) .. ", Player Gang: " .. tostring(PlayerGang))

    if Config.PoliceOpen then 
        if PlayerJob == "police" then
            canOpen = true
            debugPrint("Access granted: Police override")
        end
    end

    if Config.Stashes[currentstash].jobrequired then 
        debugPrint("Job required: " .. tostring(Config.Stashes[currentstash].job))
        if PlayerJob == Config.Stashes[currentstash].job then
            canOpen = true
            debugPrint("Access granted: Job match")
        end
    end

    if Config.Stashes[currentstash].requirecid then
        debugPrint("CID required for this stash")
        for k, v in pairs (Config.Stashes[currentstash].cid) do 
            if exports.qbx_core:GetPlayerData().citizenid == v then
                canOpen = true
                debugPrint("Access granted: CID match")
            end
        end
    end

    if Config.Stashes[currentstash].gangrequired then
        debugPrint("Gang required: " .. tostring(Config.Stashes[currentstash].gang))
        if PlayerGang == Config.Stashes[currentstash].gang then
            canOpen = true
            debugPrint("Access granted: Gang match")
        end
    end

    if canOpen then 
        debugPrint("Opening stash: " .. Config.Stashes[currentstash].stashName)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.Stashes[currentstash].stashName, {maxweight = Config.Stashes[currentstash].stashSize, slots = Config.Stashes[currentstash].stashSlots})
        TriggerEvent("inventory:client:SetCurrentStash", Config.Stashes[currentstash].stashName)
    else
        debugPrint("Access denied to stash: " .. tostring(currentstash))
        exports.qbx_core:Notify('You cannot open this', 'error')
    end

end)
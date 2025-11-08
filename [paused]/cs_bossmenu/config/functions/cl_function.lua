Config = Config or {}

function Notification(msg, state)
    lib.notify({
        title = 'Boss Menu',
        description = msg
    })
end

function showTextUI(text)
    lib.showTextUI(text)
end

function hideTextUI()
    lib.hideTextUI()
end

function bossInventory(job)
    -- Below are some examples of creating stashes in different inventory remove and add your inventory code

    if GetResourceState('ox_inventory') == 'started' then
        if exports.ox_inventory:openInventory('stash', "boss_" .. job) == false then
            TriggerServerEvent('cs:bossmenu:oxInventory', job)
            exports.ox_inventory:openInventory('stash', "boss_" .. job)
        end
    elseif GetResourceState('qs-inventory') == 'started' then
        exports['qs-inventory']:RegisterStash("boss_" .. job, 25, 4000000)
    elseif GetResourceState('qb-inventory') == 'started' then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. job, {
            maxweight = 4000000,
            slots = 25,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. job)
    else
        --ADD YOUR INVENTORY HERE 
    end
end

function outfitMenu()
    -- Add Your Outfit Event Here
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end

function IsPlayerAllowed(isJob, jobName, jobLabel, jobRank)
    if not jobName or not jobLabel or not jobRank then
        return false
    end

    jobRank = tonumber(jobRank)
    if isJob then
        local minRank = Config.Menu['bossmenu'][jobName].bossRank
        if minRank and jobRank >= minRank then
            return true
        end
    else
        local minRank = Config.Menu['gangmenu'][jobName].bossRank
        if minRank and jobRank >= minRank then
            return true
        end
    end

    return false
end

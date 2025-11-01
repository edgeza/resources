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


serverSetup = false
CaseList = CFG.CaseList
rarityWeights = CFG.RarityChance
caseItemsWon = {}
caseOpeningInProgress = {} -- Track players with cases currently opening

OpenServerCase = function(serverid, caseitems)
    -- Prevent opening a new case if one is already in progress OR if there's a pending reward
    if caseOpeningInProgress[serverid] then
        print(string.format('^1[Loot Cases] Player %s (%s) attempted to open a case while one is already in progress.', GetPlayerName(serverid), serverid))
        return
    end
    
    -- Also check if there's a pending reward from a previous case
    if caseItemsWon[serverid] then
        print(string.format('^1[Loot Cases] Player %s (%s) attempted to open a case while a reward is still pending.', GetPlayerName(serverid), serverid))
        return
    end
    
    -- Mark that this player is opening a case
    caseOpeningInProgress[serverid] = true

    local totalWeight = 0

    for _, item in ipairs(caseitems.items) do
        totalWeight = totalWeight + rarityWeights[item.rarity]
    end

    local function getRandomIndex()
        local randomChance = math.random(1, totalWeight)
        local cumulativeWeight = 0

        for i, item in ipairs(caseitems.items) do
            cumulativeWeight = cumulativeWeight + rarityWeights[item.rarity]
            if randomChance <= cumulativeWeight then
                return i
            end
        end

        return #caseitems.items
    end

    local randomIndex = getRandomIndex()
    local randomItem = caseitems.items[randomIndex]
    
    -- Create a deep copy of the item to prevent reference issues
    local itemCopy = {
        name = randomItem.name,
        item = randomItem.item,
        amount = randomItem.amount,
        rarity = randomItem.rarity,
        image = randomItem.image
    }
    
    TriggerClientEvent('olrp_lootcases:openCase', serverid, itemCopy, caseitems)

    if CFG.RarityChance[itemCopy.rarity] < 10 then 
        if itemCopy.item == 'money' then
            CFG.ChatNotify(("^3%s^7 won ^3$%s^7 from a ^3%s^7 case!"):format(GetPlayerName(serverid), GroupDigits(itemCopy.amount), itemCopy.rarity))
            LogCrateOpening(serverid, itemCopy.rarity, GroupDigits(itemCopy.amount), 'Money')
        elseif string.match(string.lower(itemCopy.item), 'weapon_') then
            CFG.ChatNotify(("^3%s^7 won a ^3%s^7 from a ^3%s^7 case!"):format(GetPlayerName(serverid), GetWeaponLabel(itemCopy.item), itemCopy.rarity))
            LogCrateOpening(serverid, itemCopy.rarity, 1, GetWeaponLabel(itemCopy.item))
        else
            CFG.ChatNotify(("^3%s^7 won x%s ^3%s^7 from a ^3%s^7 case!"):format(GetPlayerName(serverid), itemCopy.amount, GetItemLabel(itemCopy.item), itemCopy.rarity))
            LogCrateOpening(serverid, itemCopy.rarity, itemCopy.amount, GetItemLabel(itemCopy.item))
        end
    end

    -- Store the copy to ensure it doesn't change
    caseItemsWon[serverid] = itemCopy
end


function LogCrateOpening(source, caseRarity, itemAmount, itemLabel)
    -- Webhook functionality removed
    -- Log to server console instead
    local playername = GetPlayerName(source)
    print(string.format('[OLRP Loot Cases] %s opened a %s crate and received x%s %s', playername, caseRarity, itemAmount, itemLabel))
end


RegisterNetEvent('olrp_lootcases:rewardPlayer', function()
    -- Get the item first, then immediately clear it to prevent race conditions
    local rewardItem = caseItemsWon[source]
    
    if rewardItem then
        -- Clear the reward immediately to prevent duplicate claims
        caseItemsWon[source] = nil
        caseOpeningInProgress[source] = nil
        
        -- Now give the reward
        RewardServerPlayer(source, rewardItem)
        
        -- Notify client that reward was processed
        TriggerClientEvent('olrp_lootcases:rewardProcessed', source)
    else
        print(string.format('^1[Loot Cases] Player %s (%s) may have just tried to exploit the case system - no reward pending', GetPlayerName(source), source))
        caseOpeningInProgress[source] = nil -- Clear the opening flag even on error
        -- Still notify client to clear pending flag
        TriggerClientEvent('olrp_lootcases:rewardProcessed', source)
    end
end)

-- Clean up on player disconnect
AddEventHandler('playerDropped', function()
    local source = source
    caseItemsWon[source] = nil
    caseOpeningInProgress[source] = nil
end)
if GetResourceState("qb-core") ~= 'started' then return end 

QBCore = exports['qb-core']:GetCoreObject()
CaseList = CFG.CaseList 
local itemLabelWarnedOnce = false
local weaponLabelWarnedOnce = false

for key, _ in pairs(CaseList) do
    local item = key
    QBCore.Functions.CreateUseableItem(item, function(source, itemData)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return end
        
        -- Check if player has the item BEFORE attempting to open case
        local hasItem = Player.Functions.GetItemByName(item)
        if not hasItem or hasItem.amount < 1 then 
            print(string.format('^1[Loot Cases] Player %s (%s) tried to use %s but doesn\'t have it.', GetPlayerName(source), source, item))
            return 
        end
        
        -- Check if case opening is blocked
        if caseOpeningInProgress[source] or caseItemsWon[source] then
            print(string.format('^1[Loot Cases] Player %s (%s) attempted to open a case while one is already in progress.', GetPlayerName(source), source))
            return
        end
        
        local caseItems = CaseList[item]
        if not caseItems then
            print(string.format('^1[Loot Cases] Case configuration not found for item: %s', item))
            return
        end
        
        -- Open the case first and check if it succeeded
        local success = OpenServerCase(source, caseItems)
        
        -- Only remove item if case opening succeeded
        if success then
            Player.Functions.RemoveItem(item, 1)
        else
            print(string.format('^1[Loot Cases] Failed to open case for player %s (%s), item not removed.', GetPlayerName(source), source))
        end
    end)
end


function RewardServerPlayer(source, item)
    local reward = string.lower(item.item)
    local amount = item.amount
    local player = QBCore.Functions.GetPlayer(source)

    if reward == 'money' then
        player.Functions.AddMoney('cash', amount)
        TriggerClientEvent("loot_cases:client:notfiy", source, "You won $" .. GroupDigits(amount))
    elseif string.match(reward, 'weapon_') then
        player.Functions.AddItem(reward, 1)
        TriggerClientEvent("loot_cases:client:notfiy", source, "You won a " .. GetWeaponLabel(reward))
    else
        player.Functions.AddItem(reward, amount)
        TriggerClientEvent("loot_cases:client:notfiy", source, "You won x" .. amount .. " " .. GetItemLabel(reward))
    end
end




function GetItemLabel(item)
    local label = "N/A"
    
    -- Re-check QBCore if it's nil (handles race conditions)
    if not QBCore then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    
    -- Safety check for QBCore and Shared.Items
    if not QBCore or not QBCore.Shared or not QBCore.Shared.Items then
        -- Only warn once per session to avoid spam
        if not itemLabelWarnedOnce then
            print(string.format('^3[Loot Cases] Warning: QBCore.Shared.Items is nil. Using item name as fallback for: %s', item))
            itemLabelWarnedOnce = true
        end
        return item -- Return item name as fallback
    end
    
    -- Try direct lookup first (faster)
    if QBCore.Shared.Items[item] and QBCore.Shared.Items[item].label then
        return QBCore.Shared.Items[item].label
    end
    
    -- Fallback to iteration if direct lookup fails
    for k, v in pairs(QBCore.Shared.Items) do
        if k == item and v.label then
            label = v.label
            break
        end
    end
    
    return label ~= "N/A" and label or item -- Return item name if label not found
end

function GetWeaponLabel(weapon)
    local weaponLower = string.lower(weapon)
    local label = "N/A"
    
    -- Re-check QBCore if it's nil (handles race conditions)
    if not QBCore then
        QBCore = exports['qb-core']:GetCoreObject()
    end
    
    -- Safety check for QBCore and Shared tables
    if not QBCore or not QBCore.Shared then
        -- Only warn once per session to avoid spam
        if not weaponLabelWarnedOnce then
            print(string.format('^3[Loot Cases] Warning: QBCore.Shared is nil. Using weapon name as fallback for: %s', weapon))
            weaponLabelWarnedOnce = true
        end
        return weapon -- Return weapon name as fallback
    end
    
    -- Check if weapons are in Shared.Items (some QB frameworks do this)
    if QBCore.Shared.Items then
        -- Try direct lookup first
        if QBCore.Shared.Items[weapon] and QBCore.Shared.Items[weapon].label then
            return QBCore.Shared.Items[weapon].label
        end
        
        -- Try with lowercase
        if QBCore.Shared.Items[weaponLower] and QBCore.Shared.Items[weaponLower].label then
            return QBCore.Shared.Items[weaponLower].label
        end
        
        -- Iterate through items as fallback
        for k, v in pairs(QBCore.Shared.Items) do
            if (k == weapon or k == weaponLower) and v.label then
                label = v.label
                break
            end
        end
    end
    
    -- Check if weapons are in a separate Shared.Weapons table (some QB frameworks have this)
    if QBCore.Shared.Weapons then
        if QBCore.Shared.Weapons[weapon] and QBCore.Shared.Weapons[weapon].label then
            return QBCore.Shared.Weapons[weapon].label
        end
        
        if QBCore.Shared.Weapons[weaponLower] and QBCore.Shared.Weapons[weaponLower].label then
            return QBCore.Shared.Weapons[weaponLower].label
        end
        
        for k, v in pairs(QBCore.Shared.Weapons) do
            if (k == weapon or k == weaponLower) and v.label then
                label = v.label
                break
            end
        end
    end
    
    -- Return label if found, otherwise return weapon name as fallback
    return label ~= "N/A" and label or weapon
end


function GroupDigits(value)
    local formatted = tostring(value)
    local k

    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end

    return formatted
end
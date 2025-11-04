----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = exports[CoreFolder]:GetCoreObject()
local MetaDataEvent = Config.CoreSettings.MetaDataEvent
local MetaDataName = Config.XP.MetaDataName
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

-- Compute mining level based on configured thresholds
local function computeMiningLevel(totalXp)
    local xp = tonumber(totalXp) or 0
    local level = 1
    local remaining = xp
    local levels = (Config.XP and Config.XP.Levels) or {}
    for i = 1, #levels do
        local req = tonumber(levels[i]) or 0
        if remaining >= req then
            remaining = remaining - req
            level = level + 1
        else
            break
        end
    end
    return level
end

--<!>-- DIG PAYDIRT --<!>--
RegisterServerEvent('boii-mining:sv:DigPaydirt', function()
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    if not pData then return end
    local MiningXP = pData.PlayerData.metadata[MetaDataName]
    local shovelName = Config.Paydirt.Dirt.Required[1].name
    local sackName = Config.Paydirt.Dirt.Required[2].name
    if not pData.Functions.GetItemByName(shovelName) then
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Paydirt.Digging['notool'], 'error')
        return
    end
    local sackItem = pData.Functions.GetItemByName(sackName)
    if not sackItem or (sackItem.amount or 0) < 1 then
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Paydirt.Digging['notool2'], 'error')
        return
    end
    if not pData.Functions.RemoveItem(sackName, 1) then
        return
    end
    TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[sackName], 'remove', 1)
    if pData.Functions.AddItem(Config.Paydirt.Dirt.Return.name, 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.Paydirt.Dirt.Return.name], 'add', 1)
    else
        pData.Functions.AddItem(sackName, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[sackName], 'add', 1)
        TriggerClientEvent('boii-mining:notify', src, Language.Shared['noinvent'], 'error')
        return
    end
    if Config.XP.Use then
        local oldLevel = computeMiningLevel(MiningXP)
        local add = math.random(1, 2)
        local newTotal = (MiningXP + add)
        pData.Functions.SetMetaData(MetaDataName, newTotal) -- Edit xp reward here
        local newLevel = computeMiningLevel(newTotal)
        if newLevel > oldLevel then
            TriggerClientEvent('boii-mining:notify', src, 'Well done you leveld up your mining', 'success')
        end
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Paydirt.Digging['successxp'], 'success')
    else
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Paydirt.Digging['success'], 'success')
    end
    if Config.Paydirt.Dirt.BreakTool then
        if (Config.Paydirt.Dirt.Chance >= math.random(1, 100)) then
            pData.Functions.RemoveItem(Config.Paydirt.Dirt.Required[1].name, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.Paydirt.Dirt.Required[1].name], 'remove', 1)
            TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Paydirt.Digging['fail'], 'error')
        end
    end
end)
--<!>-- DIG PAYDIRT --<!>--

--<!>-- PAN PAYDIRT --<!>--
RegisterServerEvent('boii-mining:sv:PanPaydirt', function()
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    local MiningXP = pData.PlayerData.metadata[MetaDataName]
    local regularreward = Config.Paydirt.Panning.Return.Regular[math.random(1, #Config.Paydirt.Panning.Return.Regular)]
    local regularreward2 = Config.Paydirt.Panning.Return.Regular[math.random(1, #Config.Paydirt.Panning.Return.Regular)]
    local highreward = Config.Paydirt.Panning.Return.High[math.random(1, #Config.Paydirt.Panning.Return.High)]
    -- Rebalanced: 6% high, 55% medium, 85% low, else fail
    if (6 >= math.random(1,100)) then
        local highAmt = math.random(1,2)
        if highreward == 'gold_ore' then
            highAmt = math.random(10,15)
        end
        local reg2Amt = math.random(1,2)
        local regAmt = math.random(1,2)
        pData.Functions.AddItem(highreward, highAmt)
        pData.Functions.AddItem(regularreward2, reg2Amt)
        pData.Functions.AddItem(regularreward, regAmt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[highreward], 'add', highAmt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward2], 'add', reg2Amt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward], 'add', regAmt)
    elseif (55 >= math.random(1,100)) then
        local reg2Amt = math.random(1,2)
        local regAmt = math.random(1,2)
        pData.Functions.AddItem(regularreward2, reg2Amt)
        pData.Functions.AddItem(regularreward, regAmt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward2], 'add', reg2Amt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward], 'add', regAmt)
    elseif (85 >= math.random(1,100)) then
        local regAmt = 1
        pData.Functions.AddItem(regularreward, regAmt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward], 'add', regAmt)
    else
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Paydirt.Panning['fail'], 'error')
        return
    end 
    if Config.XP.Use then
        local oldLevel = computeMiningLevel(MiningXP)
        local add = math.random(3, 5)
        local newTotal = (MiningXP + add)
        pData.Functions.SetMetaData(MetaDataName, newTotal) -- Edit xp reward here
        local newLevel = computeMiningLevel(newTotal)
        if newLevel > oldLevel then
            TriggerClientEvent('boii-mining:notify', src, 'Well done you leveld up your mining', 'success')
        end
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Paydirt.Panning['successxp'], 'success')
    else
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Paydirt.Panning['success'], 'success')
    end
    pData.Functions.RemoveItem(Config.Paydirt.Dirt.Return.name, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.Paydirt.Dirt.Return.name], 'remove', 1)
end)
--<!>-- PAN PAYDIRT --<!>--

--<!>-- QUARRY DRILLING --<!>--
RegisterServerEvent('boii-mining:sv:QuarryDrilling', function()
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    local MiningXP = pData.PlayerData.metadata[MetaDataName]
    -- Require jackhammer server-side as authoritative check
    local jackName = (Config.Quarry and Config.Quarry.Drilling and Config.Quarry.Drilling.Required and Config.Quarry.Drilling.Required.name) or 'jackhammer'
    if not pData.Functions.GetItemByName(jackName) then
        TriggerClientEvent('boii-mining:notify', src, 'You need a '..(Config.Quarry.Drilling.Required.label or 'Jackhammer')..' to drill here.', 'error')
        return
    end
    -- Gate quarry drilling by Mining permit and configured XP threshold
    if Config.XP.Use then
        local requiredXP = (Config.XP and Config.XP.Thresholds and Config.XP.Thresholds.Quarry) or 1250
        if MiningXP < requiredXP then
            TriggerClientEvent('boii-mining:notify', src, 'Your mining level is too low for quarry drilling.', 'error')
            return
        end
    end
    local miningPermit = Config.Stores and Config.Stores.Permits and Config.Stores.Permits.Mining and Config.Stores.Permits.Mining.name
    if miningPermit and not pData.Functions.GetItemByName(miningPermit) then
        TriggerClientEvent('boii-mining:notify', src, 'You need a Mining Permit to drill here.', 'error')
        return
    end
    local regularreward = Config.Quarry.Drilling.Return.Regular[math.random(1, #Config.Quarry.Drilling.Return.Regular)]
    local regularreward2 = Config.Quarry.Drilling.Return.Regular[math.random(1, #Config.Quarry.Drilling.Return.Regular)]
    local highreward = Config.Quarry.Drilling.Return.High[math.random(1, #Config.Quarry.Drilling.Return.High)]
    local highGemList = {uncut_diamond=true, uncut_emerald=true, uncut_ruby=true, uncut_sapphire=true, uncut_tanzanite=true}
    -- Rebalanced: 45% high, 75% medium, 93% low
    if (45 >= math.random(1,100)) then
        local highAmount = highGemList[highreward] and 1 or math.random(3,6)
        if highreward == 'gold_ore' then
            highAmount = math.random(10,16)
        end
        local reg2Amt = math.random(2,5)
        local regAmt = math.random(2,5)
        pData.Functions.AddItem(highreward, highAmount)
        pData.Functions.AddItem(regularreward2, reg2Amt)
        pData.Functions.AddItem(regularreward, regAmt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[highreward], 'add', highAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward2], 'add', reg2Amt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward], 'add', regAmt)
    elseif (75 >= math.random(1,100)) then
        local reg2Amt = math.random(2,4)
        local regAmt = math.random(2,4)
        pData.Functions.AddItem(regularreward2, reg2Amt)
        pData.Functions.AddItem(regularreward, regAmt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward2], 'add', reg2Amt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward], 'add', regAmt)
    elseif (93 >= math.random(1,100)) then
        local regAmt = math.random(1,3)
        pData.Functions.AddItem(regularreward, regAmt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward], 'add', regAmt)
    else
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Drilling['fail'], 'error')
        if Config.Quarry.Drilling.BreakTool then
            if (Config.Quarry.Drilling.Chance >= math.random(1, 100)) then
                pData.Functions.RemoveItem(Config.Quarry.Drilling.Required.name, 1)
                TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.Quarry.Drilling.Required.name], 'remove', 1)
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Drilling['failbreak'], 'error')
            end
        end
        return
    end 
    if Config.XP.Use then
        local oldLevel = computeMiningLevel(MiningXP)
        local add = math.random(3, 5)
        local newTotal = (MiningXP + add)
        pData.Functions.SetMetaData(MetaDataName, newTotal) -- Edit xp reward here
        local newLevel = computeMiningLevel(newTotal)
        if newLevel > oldLevel then
            TriggerClientEvent('boii-mining:notify', src, 'Well done you leveld up your mining', 'success')
        end
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Drilling['successxp'], 'success')
    else
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Drilling['success'], 'success')
    end
end)
--<!>-- QUARRY DRILLING --<!>--

--<!>-- USE DYNAMITE (consume item on placement) --<!>--
RegisterServerEvent('boii-mining:sv:UseDynamite', function(itemName)
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    if not pData then return end
    local name = itemName or (Config.Quarry and Config.Quarry.Dynamite and Config.Quarry.Dynamite.Required and Config.Quarry.Dynamite.Required.name) or 'dynamite'
    local itm = pData.Functions.GetItemByName(name)
    if itm and itm.amount and itm.amount > 0 then
        pData.Functions.RemoveItem(name, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[name], 'remove', 1)
    end
end)
--<!>-- USE DYNAMITE --<!>--

--<!>-- VALIDATE AND START DYNAMITE PLACEMENT --<!>--
RegisterServerEvent('boii-mining:sv:RequestPlaceDynamite', function(area)
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    if not pData then return end
    local MiningXP = pData.PlayerData.metadata[MetaDataName] or 0
    local isMine = (area == 'Mine' or area == 'QuarryCave')
    -- Determine required permit and xp threshold
    local permitName = (isMine and (Config.Stores and Config.Stores.Permits and Config.Stores.Permits.Caving and Config.Stores.Permits.Caving.name))
        or (Config.Stores and Config.Stores.Permits and Config.Stores.Permits.Mining and Config.Stores.Permits.Mining.name)
    local requiredXP = isMine and 2441 or 1250
    if Config.XP.Use and MiningXP < requiredXP then
        TriggerClientEvent('boii-mining:notify', src, isMine and 'Your mining level is too low to place dynamite in caves.' or 'Your mining level is too low to place dynamite at the quarry.', 'error')
        return
    end
    if permitName and not pData.Functions.GetItemByName(permitName) then
        TriggerClientEvent('boii-mining:notify', src, isMine and 'You need a Caving Permit to place dynamite in caves.' or 'You need a Mining Permit to place dynamite at the quarry.', 'error')
        return
    end
    -- Determine dynamite item and delay
    local requiredItemName = isMine and (Config.Mine and Config.Mine.Dynamite and Config.Mine.Dynamite.Required and Config.Mine.Dynamite.Required.name) or (Config.Quarry and Config.Quarry.Dynamite and Config.Quarry.Dynamite.Required and Config.Quarry.Dynamite.Required.name) or 'dynamite'
    local delay = isMine and (Config.Mine and Config.Mine.Dynamite and Config.Mine.Dynamite.Delay or 5) or (Config.Quarry and Config.Quarry.Dynamite and Config.Quarry.Dynamite.Delay or 5)
    -- Check and consume dynamite
    local itm = pData.Functions.GetItemByName(requiredItemName)
    if not itm or (itm.amount or 0) <= 0 then
        TriggerClientEvent('boii-mining:notify', src, 'You do not have any dynamite.', 'error')
        return
    end
    pData.Functions.RemoveItem(requiredItemName, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[requiredItemName], 'remove', 1)
    -- Allow client to proceed with local explosion/rocks
    TriggerClientEvent('boii-mining:cl:ProceedPlaceDynamite', src, { area = isMine and 'Mine' or 'Quarry', delay = delay })
end)
--<!>-- VALIDATE AND START DYNAMITE PLACEMENT --<!>--

--<!>-- KAMBI CAVE DRILLING --<!>--
RegisterServerEvent('boii-mining:sv:CaveDrilling', function()
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    local MiningXP = pData.PlayerData.metadata[MetaDataName]
    -- Require jackhammer server-side as authoritative check
    local jackName = (Config.Mine and Config.Mine.Drilling and Config.Mine.Drilling.Required and Config.Mine.Drilling.Required.name) or 'jackhammer'
    if not pData.Functions.GetItemByName(jackName) then
        TriggerClientEvent('boii-mining:notify', src, 'You need a '..(Config.Mine.Drilling.Required.label or 'Jackhammer')..' to drill here.', 'error')
        return
    end
    -- Gate cave drilling by Caving permit and configured XP threshold
    if Config.XP.Use then
        local requiredXP = (Config.XP and Config.XP.Thresholds and Config.XP.Thresholds.Cave) or 2441
        if MiningXP < requiredXP then
            TriggerClientEvent('boii-mining:notify', src, 'Your mining level is too low for cave drilling.', 'error')
            return
        end
    end
    local cavingPermit = Config.Stores and Config.Stores.Permits and Config.Stores.Permits.Caving and Config.Stores.Permits.Caving.name
    if cavingPermit and not pData.Functions.GetItemByName(cavingPermit) then
        TriggerClientEvent('boii-mining:notify', src, 'You need a Caving Permit to drill in the caves.', 'error')
        return
    end
    local regularreward = Config.Mine.Drilling.Return.Regular[math.random(1, #Config.Mine.Drilling.Return.Regular)]
    local regularreward2 = Config.Mine.Drilling.Return.Regular[math.random(1, #Config.Mine.Drilling.Return.Regular)]
    local regularreward3 = Config.Mine.Drilling.Return.Regular[math.random(1, #Config.Mine.Drilling.Return.Regular)]
    local highreward = Config.Mine.Drilling.Return.High[math.random(1, #Config.Mine.Drilling.Return.High)]
    local highGemList = {diamond_mining=true, emerald=true, ruby=true, sapphire=true, tanzanite=true}
    -- Rebalanced: 60% high, 90% medium; cave remains best tier
    if (60 >= math.random(1,100)) then
        local highAmount = highGemList[highreward] and 1 or math.random(7,10)
        if highreward == 'gold_ore' then
            highAmount = math.random(14,20)
        end
        local reg3Amt = math.random(2,5)
        local reg2Amt = math.random(3,6)
        local regAmt = math.random(3,6)
        pData.Functions.AddItem(highreward, highAmount)
        pData.Functions.AddItem(regularreward3, reg3Amt)
        pData.Functions.AddItem(regularreward2, reg2Amt)
        pData.Functions.AddItem(regularreward, regAmt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[highreward], 'add', highAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward3], 'add', reg3Amt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward2], 'add', reg2Amt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward], 'add', regAmt)
    elseif (90 >= math.random(1,100)) then
        local reg2Amt = math.random(3,5)
        local regAmt = math.random(3,5)
        pData.Functions.AddItem(regularreward2, reg2Amt)
        pData.Functions.AddItem(regularreward, regAmt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward2], 'add', reg2Amt)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[regularreward], 'add', regAmt)
    else
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Mine.Drilling['fail'], 'error')
        if Config.Mine.Drilling.BreakTool then
            if (Config.Mine.Drilling.Chance >= math.random(1, 100)) then
                pData.Functions.RemoveItem(Config.Mine.Drilling.Required.name, 1)
                TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[Config.Mine.Drilling.Required.name], 'remove', 1)
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Mine.Drilling['failbreak'], 'error')
            end
        end
        return
    end 
    if Config.XP.Use then
        local oldLevel = computeMiningLevel(MiningXP)
        local add = math.random(4, 6)
        local newTotal = (MiningXP + add)
        pData.Functions.SetMetaData(MetaDataName, newTotal) -- Edit xp reward here
        local newLevel = computeMiningLevel(newTotal)
        if newLevel > oldLevel then
            TriggerClientEvent('boii-mining:notify', src, 'Well done you leveld up your mining', 'success')
        end
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Mine.Drilling['successxp'], 'success')
    else
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Mine.Drilling['success'], 'success')
    end
end)
--<!>-- KAMBI CAVE DRILLING --<!>--
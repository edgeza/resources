----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT EDIT ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = (function()
    local success, result = pcall(function() return exports[CoreFolder]:GetCoreObject() end)
    if success and result then
        return result
    end
    -- QBX fallback: use QBX exports directly
    local qbx = exports.qbx_core
    if qbx then
        return {
            Functions = {
                GetPlayer = function(source) return qbx:GetPlayer(source) end,
                CreateUseableItem = function(item, callback) RegisterUsableItem(item, callback) end,
                GetPlayers = function() return GetPlayers() end,
            },
            Shared = {
                Items = {}
            }
        }
    end
    error('Failed to initialize Core - QBX/QBCore not found')
end)()
local MetaDataEvent = Config.CoreSettings.MetaDataEvent
local MetaDataName = Config.XP.MetaDataName
--<!>-- DO NOT EDIT ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING SUPPORT WILL NOT BE PROVIDED IF YOU IGNORE THIS --<!>--

--<!>-- SMELTING --<!>--
local function findSmeltRecipeByReward(rewardName)
    local S = Config.Smelting.Ingots
    if not S then return nil end
    for _, key in ipairs({'Aluminum','Copper','Iron','Tin','Gold','Silver','Cobalt','Bronze','Steel'}) do
        local ing = S[key]
        if ing and ing.Return and ing.Return.name == rewardName then
            return ing
        end
    end
    return nil
end

RegisterServerEvent('boii-mining:sv:Smelt', function(reward, amount)
    local src = source
    if not src or src == 0 then return end
    local pData = Core.Functions.GetPlayer(src)
    if not pData or not pData.PlayerData then return end
    local MiningXP = pData.PlayerData.metadata[MetaDataName] or 0
    local recipe = findSmeltRecipeByReward(reward)
    if not recipe then return end
    -- Validate and remove inputs server-side (supports single or two-item recipes)
    local function hasItem(name, req)
        local it = pData.Functions.GetItemByName(name)
        return it ~= nil and (it.amount or 0) >= (req or 1)
    end
    local function removeItem(name, req)
        pData.Functions.RemoveItem(name, req)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[name], 'remove', req)
    end
    local ok = true
    if recipe.Required then
        if recipe.Required.name then
            ok = hasItem(recipe.Required.name, recipe.Required.amount)
        else
            ok = hasItem(recipe.Required[1].name, recipe.Required[1].amount) and hasItem(recipe.Required[2].name, recipe.Required[2].amount)
        end
    end
    if not ok then
        TriggerClientEvent('boii-mining:notify', src, Language.Mining.Smelting['wrongitems'], 'error')
        return
    end
    -- Remove inputs
    if recipe.Required then
        if recipe.Required.name then
            removeItem(recipe.Required.name, recipe.Required.amount)
        else
            removeItem(recipe.Required[1].name, recipe.Required[1].amount)
            removeItem(recipe.Required[2].name, recipe.Required[2].amount)
        end
    end
    if Config.Smelting.CanFail then
        if (Config.Smelting.Chance >= math.random(1,100)) then
            if Config.XP.Use then
                pData.Functions.SetMetaData(MetaDataName, (MiningXP - math.random(2, 6))) -- Edit xp remove here
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Smelting['failxp'], 'error')
            else
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Smelting['fail'], 'error')
            end
        else
            pData.Functions.AddItem(reward, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[reward], 'add', amount)
            if Config.XP.Use then
                pData.Functions.SetMetaData(MetaDataName, (MiningXP + math.random(10, 15))) -- Edit xp reward here
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Smelting['successxp'], 'success')
            else
                TriggerClientEvent('boii-mining:notify', src, Language.Mining.Smelting['success'], 'success')
            end
        end
    else
        pData.Functions.AddItem(reward, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, Core.Shared.Items[reward], 'add', amount)
        if Config.XP.Use then
            pData.Functions.SetMetaData(MetaDataName, (MiningXP + math.random(10, 15))) -- Edit xp reward here
            TriggerClientEvent('boii-mining:notify', src, Language.Mining.Smelting['successxp'], 'success')
        else
            TriggerClientEvent('boii-mining:notify', src, Language.Mining.Smelting['success'], 'success')
        end
    end
end)
--<!>-- SMELTING --<!>--
----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--
local Core = Config.CoreSettings.Core
local CoreFolder = Config.CoreSettings.CoreFolder
local Core = GetQBCoreObject and GetQBCoreObject() or (function()
    local success, result = pcall(function() return exports[CoreFolder]:GetCoreObject() end)
    if success and result then
        return result
    else
        error('Failed to initialize Core object - GetQBCoreObject not available')
    end
end)()
--<!>-- DO NOT CHANGE ANYTHING ABOVE THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--

--<!>-- GUIDE --<!>--
Core.Functions.CreateUseableItem('miningguide', function(source, item)
    TriggerClientEvent('boii-mining:cl:OpenGuide', source)
end)
--<!>-- GUIDE --<!>--

--<!>-- GOLD PAN --<!>--
Core.Functions.CreateUseableItem('gold_pan', function(source, item)
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    if pData.Functions.GetItemByName(Config.Paydirt.Dirt.Return.name) == nil then TriggerClientEvent('boii-mining:notify', src, Language.Mining.Quarry.Paydirt.Panning['nopaydirt'], 'error') return end
    TriggerClientEvent('boii-mining:cl:PanPaydirt', src)
end)
--<!>-- GOLD PAN --<!>--

--<!>-- DYNAMITE USE (inventory) --<!>--
Core.Functions.CreateUseableItem('dynamite', function(source, item)
    local src = source
    local pData = Core.Functions.GetPlayer(src)
    if not pData then return end
    local MiningXP = (pData.PlayerData and pData.PlayerData.metadata and pData.PlayerData.metadata[Config.XP.MetaDataName]) or 0
    local minReq = (Config.XP and Config.XP.Thresholds and Config.XP.Thresholds.Quarry) or 1250
    if Config.XP.Use and MiningXP < minReq then
        TriggerClientEvent('boii-mining:notify', src, 'Your mining level is too low to use dynamite.', 'error')
        return
    end
    -- Do not remove here; server placement consumes it after validation
    TriggerClientEvent('boii-mining:cl:PlaceDynamite', src, { area = 'Quarry' })
end)
--<!>-- DYNAMITE USE --<!>--
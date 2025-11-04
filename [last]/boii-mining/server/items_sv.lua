----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

--<!>-- DO NOT CHANGE ANYTHING BELOW THIS TEXT UNLESS YOU KNOW WHAT YOU ARE DOING! SUPPORT WILL NOT BE PROVIDED IF YOU BREAK THE SCRIPT! --<!>--
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
                CreateUseableItem = function(item, callback)
                    -- Try QBX RegisterUsableItem
                    local success = pcall(function() qbx:RegisterUsableItem(item, callback) end)
                    if not success then
                        success = pcall(function() qbx:registerUsableItem(item, callback) end)
                    end
                    if not success and RegisterUsableItem then
                        RegisterUsableItem(item, callback)
                    end
                end,
                GetPlayers = function() return GetPlayers() end,
            },
            Shared = {
                Items = {}
            }
        }
    end
    error('Failed to initialize Core - QBX/QBCore not found')
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
----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

-- Core Compatibility Module for QBX/QBCore
local CoreFolder = Config.CoreSettings.CoreFolder

local function GetQBCoreObject()
    local success, result = pcall(function() return exports[CoreFolder]:GetCoreObject() end)
    if success and result then
        return result
    end
    
    -- QBX compatibility: create wrapper for QBX exports
    local qbx = exports[CoreFolder]
    local lib = nil
    local libSuccess, libResult = pcall(function() 
        if GetResourceState('qbx_core') == 'started' then
            return exports.qbx_core and (exports.qbx_core.lib or (exports.qbx_core.GetLib and exports.qbx_core:GetLib()))
        end
    end)
    if libSuccess then lib = libResult end
    
    return {
        Functions = {
            GetPlayer = function(source)
                if lib and lib.qbx and lib.qbx.getPlayer then
                    return lib.qbx.getPlayer(source)
                elseif qbx and qbx.GetPlayer then
                    local qbxSuccess, qbxResult = pcall(function() return qbx:GetPlayer(source) end)
                    if qbxSuccess then return qbxResult end
                    qbxSuccess, qbxResult = pcall(function() return qbx.GetPlayer(source) end)
                    if qbxSuccess then return qbxResult end
                end
                return nil
            end,
            CreateUseableItem = function(item, callback)
                if lib and lib.qbx and lib.qbx.registerUsableItem then
                    lib.qbx.registerUsableItem(item, callback)
                    return
                elseif qbx and qbx.RegisterUsableItem then
                    local qbxSuccess = pcall(function() qbx:RegisterUsableItem(item, callback) end)
                    if qbxSuccess then return end
                    qbxSuccess = pcall(function() qbx.RegisterUsableItem(item, callback) end)
                    if qbxSuccess then return end
                end
                -- Fallback: use standard RegisterUsableItem (QBX compatible)
                RegisterUsableItem(item, callback)
            end,
            GetPlayers = function()
                if lib and lib.qbx and lib.qbx.getPlayers then
                    return lib.qbx.getPlayers()
                elseif qbx and qbx.GetPlayers then
                    local qbxSuccess, qbxResult = pcall(function() return qbx:GetPlayers() end)
                    if qbxSuccess then return qbxResult end
                    qbxSuccess, qbxResult = pcall(function() return qbx.GetPlayers() end)
                    if qbxSuccess then return qbxResult end
                end
                return GetPlayers()
            end,
            GetPlayerData = function()
                if lib and lib.qbx and lib.qbx.getPlayerData then
                    return lib.qbx.getPlayerData()
                elseif qbx and qbx.GetPlayerData then
                    local qbxSuccess, qbxResult = pcall(function() return qbx:GetPlayerData() end)
                    if qbxSuccess then return qbxResult end
                    qbxSuccess, qbxResult = pcall(function() return qbx.GetPlayerData() end)
                    if qbxSuccess then return qbxResult end
                end
                return nil
            end,
            Notify = function(msg, type, length)
                if lib and lib.notify then
                    lib.notify({ type = type or 'inform', description = msg, duration = length or 5000 })
                    return
                elseif qbx and qbx.Notify then
                    local qbxSuccess = pcall(function() qbx:Notify(msg, type, length) end)
                    if qbxSuccess then return end
                    qbxSuccess = pcall(function() qbx.Notify(msg, type, length) end)
                    if qbxSuccess then return end
                end
                -- Fallback
                TriggerEvent('chat:addMessage', { color = { 255, 0, 0 }, multiline = true, args = { 'System', msg } })
            end,
            Progressbar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
                if lib and lib.progressBar then
                    lib.progressBar({
                        label = label,
                        duration = duration,
                        useWhileDead = useWhileDead or false,
                        canCancel = canCancel or true,
                        disable = disableControls or {},
                        anim = animation,
                        prop = prop,
                        propTwo = propTwo,
                    })
                    return
                elseif qbx and qbx.Progressbar then
                    local qbxSuccess = pcall(function() 
                        qbx:Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
                    end)
                    if qbxSuccess then return end
                end
            end,
            HasItem = function(item, amount)
                if lib and lib.qbx and lib.qbx.hasItem then
                    return lib.qbx.hasItem(item, amount)
                elseif qbx and qbx.HasItem then
                    local qbxSuccess, qbxResult = pcall(function() return qbx:HasItem(item, amount) end)
                    if qbxSuccess then return qbxResult end
                end
                return false
            end
        },
        Shared = {
            Items = (function()
                if lib and lib.items then
                    return lib.items
                elseif lib and lib.qbx and lib.qbx.getSharedItems then
                    return lib.qbx.getSharedItems()
                elseif qbx and qbx.GetSharedItems then
                    local qbxSuccess, qbxResult = pcall(function() return qbx:GetSharedItems() end)
                    if qbxSuccess then return qbxResult end
                    qbxSuccess, qbxResult = pcall(function() return qbx.GetSharedItems() end)
                    if qbxSuccess then return qbxResult end
                elseif qbx and qbx.Shared and qbx.Shared.Items then
                    return qbx.Shared.Items
                end
                return {}
            end)()
        }
    }
end

-- Export as global function for use in server/client scripts
_G.GetQBCoreObject = GetQBCoreObject
return GetQBCoreObject

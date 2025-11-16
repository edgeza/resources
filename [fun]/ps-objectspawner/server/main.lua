local function GetCoreObject()
    -- Try qbx_core first (QBX) - try multiple export names
    local qbxStates = {'qbx_core', 'qbx-core', 'qbx'}
    for _, resName in ipairs(qbxStates) do
        if GetResourceState(resName) == 'started' or GetResourceState(resName) == 'starting' then
            -- Try getSharedObject
            local success, core = pcall(function()
                return exports[resName]:getSharedObject()
            end)
            if success and core then 
                print('[PS-OBJECTSPAWNER] Using ' .. resName .. ':getSharedObject')
                return core 
            end
            
            -- Try GetCoreObject
            success, core = pcall(function()
                return exports[resName]:GetCoreObject()
            end)
            if success and core then 
                print('[PS-OBJECTSPAWNER] Using ' .. resName .. ':GetCoreObject')
                return core 
            end
            
            -- Try getCoreObject
            success, core = pcall(function()
                return exports[resName]:getCoreObject()
            end)
            if success and core then 
                print('[PS-OBJECTSPAWNER] Using ' .. resName .. ':getCoreObject')
                return core 
            end
        end
    end
    
    -- Fallback to qb-core (QBCore)
    if GetResourceState('qb-core') == 'started' or GetResourceState('qb-core') == 'starting' then
        local success, core = pcall(function()
            return exports['qb-core']:GetCoreObject()
        end)
        if success and core then 
            print('[PS-OBJECTSPAWNER] Using qb-core:GetCoreObject')
            return core 
        end
    end
    
    error('[PS-OBJECTSPAWNER] Failed to get core object. Please check your server console for the correct resource name and export.')
end

local QBCore = GetCoreObject()
local ServerObjects = {}

QBCore.Commands.Add('object', 'Open object spawner', {}, true, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local permission = 'admin'
    if Player and QBCore.Functions.HasPermission(source, permission) then
        TriggerClientEvent('ps-objectspawner:client:registerobjectcommand', source, permission)
    end
end, 'admin')

RegisterNetEvent("ps-objectspawner:server:CreateNewObject", function(model, coords, objecttype, options, objectname)
    local source = source
    local hasperms = QBCore.Functions.HasPermission(source, 'admin')
    if hasperms then
        if model and coords then
            local data = MySQL.query.await("INSERT INTO objects (model, coords, type, options, name) VALUES (?, ?, ?, ?, ?)", { model, json.encode(coords), objecttype, json.encode(options), objectname })
            ServerObjects[data.insertId] = {id = data.insertId, model = model, coords = coords, type = objecttype, name = objectname, options = options}
            TriggerClientEvent("ps-objectspawner:client:AddObject", -1, {id = data.insertId, model = model, coords = coords, type = objecttype, name = objectname, options = options})
        else 
            print("[PS-OBJECTSPAWNER]: Object or coords was invalid")
        end
    else
        print("[PS-OBJECTSPAWNER]: You don't have permissions for this")
    end
end)

CreateThread(function()
    local results = MySQL.query.await('SELECT * FROM objects', {})
    for k, v in pairs(results) do
        ServerObjects[v["id"]] = {
            id = v["id"],
            model = v["model"],
            coords = json.decode(v["coords"]),
            type = v["type"],
            name = v["name"] or "",
            options = json.decode(v["options"]),
        }
    end
end)

QBCore.Functions.CreateCallback("ps-objectspawner:server:RequestObjects", function(source, cb)
    cb(ServerObjects)
end)

RegisterNetEvent("ps-objectspawner:server:DeleteObject", function(objectid)
    local source = source
    local hasperms = QBCore.Functions.HasPermission(source, 'admin')
    if hasperms then
        if objectid > 0 then
            local data = MySQL.query.await('DELETE FROM objects WHERE id = ?', {objectid})
            ServerObjects[objectid] = nil
            TriggerClientEvent("ps-objectspawner:client:receiveObjectDelete", -1, objectid)
        end
    else
        print("[PS-OBJECTSPAWNER]: You don't have permissions for this")
    end
end)

local function CreateDataObject(mode, coords, type, options, objectname)
    MySQL.query.await("INSERT INTO objects (model, coords, type, options, name) VALUES (?, ?, ?, ?, ?)", { model, json.encode(coords), type, json.encode(options), objectname })
end

exports("CreateDataObject", CreateDataObject)
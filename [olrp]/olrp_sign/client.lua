local ESX = nil
local QBCore = nil 
local QBox = nil
local FrameworkFound = nil
local nuiOpen = false
local modelCreated = {}

LoadFramework = function()
    -- Initialize to standalone as default
    FrameworkFound = 'standalone'
    
    if Config.Framework == 'esx' then 
        ESX = exports['es_extended']:getSharedObject()
        FrameworkFound = 'esx'
    elseif Config.Framework == 'qbcore' then 
        QBCore = exports["qb-core"]:GetCoreObject()
        FrameworkFound = 'qbcore'
    elseif Config.Framework == 'qbox' then
        local success, result = pcall(function() return exports["qbx_core"]:GetCoreObject() end)
        if success and result then
            QBox = result
            FrameworkFound = 'qbox'
        else
            -- Try alternative export name
            success, result = pcall(function() return exports["qbx"]:GetCoreObject() end)
            if success and result then
                QBox = result
                FrameworkFound = 'qbox'
            else
                print("[OLRP-Sign] Warning: Qbox framework not found, falling back to standalone")
                FrameworkFound = 'standalone'
            end
        end
    elseif Config.Framework == 'autodetect' then
        if GetResourceState('es_extended') == 'started' then 
            ESX = exports['es_extended']:getSharedObject()
            FrameworkFound = 'esx'
        elseif GetResourceState('qbx_core') == 'started' then
            local success, result = pcall(function() return exports["qbx_core"]:GetCoreObject() end)
            if success and result then
                QBox = result
                FrameworkFound = 'qbox'
            else
                -- Try alternative export name
                success, result = pcall(function() return exports["qbx"]:GetCoreObject() end)
                if success and result then
                    QBox = result
                    FrameworkFound = 'qbox'
                else
                    print("[OLRP-Sign] Warning: Qbox export not found, checking QBCore...")
                    -- Check QBCore as fallback
                    if GetResourceState('qb-core') == 'started' then
                        QBCore = exports["qb-core"]:GetCoreObject()
                        FrameworkFound = 'qbcore'
                    else
                        FrameworkFound = 'standalone'
                    end
                end
            end
        elseif GetResourceState('qbx') == 'started' then
            local success, result = pcall(function() return exports["qbx"]:GetCoreObject() end)
            if success and result then
                QBox = result
                FrameworkFound = 'qbox'
            elseif GetResourceState('qb-core') == 'started' then
                QBCore = exports["qb-core"]:GetCoreObject()
                FrameworkFound = 'qbcore'
            else
                FrameworkFound = 'standalone'
            end
        elseif GetResourceState('qb-core') == 'started' then
            QBCore = exports["qb-core"]:GetCoreObject()
            FrameworkFound = 'qbcore'
        else
            FrameworkFound = 'standalone'
        end
    elseif Config.Framework == 'standalone' then
        FrameworkFound = 'standalone'
    end
end

Citizen.CreateThread(function()
    LoadFramework()
    -- Wait for player to be ready
    while not NetworkIsPlayerActive(PlayerId()) do
        Wait(100)
    end
    -- Wait a bit more for stream models to load
    Wait(2000)
    TriggerServerEvent('olrp-sign:loadText')
end)

RegisterNetEvent('olrp-sign:openNui')
AddEventHandler('olrp-sign:openNui', function(text, color)
    nuiOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "SET_LOCALES",
        locales = Config.Locales
    })
    SendNUIMessage({
        type = "OPEN",
        text = text,
        color = color
    })
end)

RegisterNUICallback('saveText', function(data)
    TriggerServerEvent('olrp-sign:saveText', data)
end)

RegisterNUICallback('close', function(data)
    nuiOpen = false
    SetNuiFocus(false, false)
end)

RegisterNetEvent('olrp-sign:saveText')
AddEventHandler('olrp-sign:saveText', function(data)
    UpdateMap(data)
    if nuiOpen then 
        SendNUIMessage({
            type = "UPDATE",
            text = data[1],
            color = data[2]
        })
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(modelCreated) do
            DeleteEntity(v)
        end
    end
end)

hexToRgb = function(hex)
    hex = hex:gsub("#","")
    return {
        r = tonumber("0x"..hex:sub(1,2)),
        g = tonumber("0x"..hex:sub(3,4)),
        b = tonumber("0x"..hex:sub(5,6))
    }
end

UpdateMap = function(data)
    for k, v in pairs(modelCreated) do
        DeleteEntity(v)
    end
    modelCreated = {}
    if not data then return end
    local completeText = data[1]
    if not completeText then return end
    for i=1, #completeText, 1 do 
        if i > 8 then 
            return 
        end
        local string = completeText:sub(i, i)
        local model = string:lower()
        local coords = Config.Coords[i].coordinate
        local heading = Config.Coords[i].heading
        if model ~= " " then
            -- Try using the model name as string first (for custom stream models)
            RequestModel(model)
            local timeout = 0
            while not HasModelLoaded(model) and timeout < 5000 do
                Wait(10)
                timeout = timeout + 10
            end
            
            if HasModelLoaded(model) then
                local obj = CreateObject(model, coords, false, false, false)
                SetEntityHeading(obj, heading)
                FreezeEntityPosition(obj, true)
                SetEntityCollision(obj, false, false)
                table.insert(modelCreated, obj)
                SetColorModel(model, "techdevontop", hexToRgb(data[2]))
                SetModelAsNoLongerNeeded(model)
            else
                -- Fallback: try with hash
                local modelHash = GetHashKey(model)
                RequestModel(modelHash)
                timeout = 0
                while not HasModelLoaded(modelHash) and timeout < 5000 do
                    Wait(10)
                    timeout = timeout + 10
                end
                
                if HasModelLoaded(modelHash) then
                    local obj = CreateObject(modelHash, coords, false, false, false)
                    SetEntityHeading(obj, heading)
                    FreezeEntityPosition(obj, true)
                    SetEntityCollision(obj, false, false)
                    table.insert(modelCreated, obj)
                    SetColorModel(model, "techdevontop", hexToRgb(data[2]))
                    SetModelAsNoLongerNeeded(modelHash)
                else
                    print("[OLRP-Sign] Error: Failed to load model: " .. model)
                end
            end
        end
    end
end

SetColorModel = function(model, textureName, colorRgb)
    local txd = 'txd_vinewood_sign'
    local txn = 'txn_vinewood_sign'
    local dict = CreateRuntimeTxd(txd)
    local texture = CreateRuntimeTexture(dict, txn, 4, 4)
    local resolution = GetTextureResolution(txd, txn)
    if(colorRgb.r == 255 and colorRgb.g == 255 and colorRgb.b == 255) then
        RemoveReplaceTexture("mainTexture", textureName)
    else
        SetRuntimeTexturePixel(texture, 0, 0, colorRgb.r, colorRgb.g, colorRgb.b, 255)
        CommitRuntimeTexture(texture)
        AddReplaceTexture("mainTexture", textureName, txd, txn)  
    end  
end

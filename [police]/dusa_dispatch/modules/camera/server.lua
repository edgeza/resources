if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

local StoredCams = {}

CreateThread(function()
    local cameraList = db.listCamera()
    for i = 1, #cameraList do
        StoredCams[#StoredCams + 1] = cameraList[i]
    end
end)

RegisterNetEvent('dusa_dispatch:SaveNewCam', function(camid, name, setting, coords, rot, item)
    local src = source
    local Player = Framework.GetPlayer(src)
    if not Player then return end
    db.createCamera(camid, name, setting, coords, rot)
    StoredCams[#StoredCams + 1] = { camid = camid, name = name, setting = setting, coords = coords, rot = rot, id = #StoredCams + 1 }
    
    local UncodedSetting = json.decode(setting)
    if tonumber(UncodedSetting.ShowProp) == 1 then
        TriggerClientEvent('dusa_dispatch:LoadPropCamera', -1, UncodedSetting.Prop,
            UncodedSetting.PropCoords.Coords, UncodedSetting.PropCoords.Rotation, #StoredCams, true, camid)
    else
        TriggerClientEvent('dusa_dispatch:LoadPropCamera', -1, UncodedSetting.Prop,
            UncodedSetting.PropCoords.Coords, UncodedSetting.PropCoords.Rotation, #StoredCams, false, camid)
    end
    TriggerClientEvent('dusa_dispatch:notify', src, 'Camera Added Successfully', 'success', 5000)
end)

RegisterNetEvent('dusa_dispatch:FixCameraByID',function(id)
    local src = source
    for k, v in pairs(StoredCams) do   
        if v.id == id then 
            local Setting = json.decode(v.setting)
            Setting.Broken = 0
            StoredCams[k].setting = json.encode(Setting)
            if tonumber(Setting.ShowProp) == 1 then
                TriggerClientEvent('dusa_dispatch:LoadPropCamera', -1, Setting.Prop, Setting.PropCoords.Coords, Setting.PropCoords.Rotation, id, true)
            else
                TriggerClientEvent('dusa_dispatch:LoadPropCamera', -1, Setting.Prop, Setting.PropCoords.Coords, Setting.PropCoords.Rotation, id, false)
            end
            TriggerClientEvent('dusa_dispatch:notify', src, 'Camera Repaired Successfully', 'success', 5000)
            break
        end
    end
end)

RegisterNetEvent('dusa_dispatch:RemoveStaticCam',function(id, camid)
    local src = source
    local Player = Framework.GetPlayer(src)
    if not Player then return end
    db.deleteCamera(camid)
    for k, v in pairs(StoredCams) do
        local Setting = json.decode(v.setting) 
        if v.id == id then    
            StoredCams[k] = nil 
            if tonumber(Setting.ShowProp) == 1 then
                TriggerClientEvent('dusa_dispatch:RemovePropCamera', -1, v.id, true)
            else
                TriggerClientEvent('dusa_dispatch:RemovePropCamera', -1, v.id, false)
            end    
            break
        end 
    end  
    TriggerClientEvent('dusa_dispatch:notify', src, 'Camera Removed Successfully', 'success', 5000)
end)

RegisterNetEvent('dusa_dispatch:RemoveBrokenCam', function (camid)
    if not camid then return end
    db.deleteCamera(camid)
    for k, v in pairs(StoredCams) do
        if v.camid == camid then
            table.remove(StoredCams, k)
        end
    end
end)

lib.callback.register('dusa_dispatch:GetStaticCams', function(source)
    return StoredCams
end)

lib.callback.register('dusa_dispatch:BrokeCamera', function(source, id)
    local Broken = 'false'
    for k, v in pairs(StoredCams) do
        local Setting = json.decode(v.setting)
        if v.id == id then
            if tonumber(Setting.Broken) == 0 then
                Setting.Broken = 1
                StoredCams[k].setting = json.encode(Setting)
                Broken = 'true'
                TriggerClientEvent('dusa_dispatch:CrashCamera', -1, tonumber(v.id))
                if tonumber(Setting.ShowProp) == 1 then
                    TriggerClientEvent('dusa_dispatch:RemovePropCamera', -1, tonumber(v.id), true)
                else
                    TriggerClientEvent('dusa_dispatch:RemovePropCamera', -1, tonumber(v.id), false)
                end
            end
            break
        end
    end
    return Broken
end)

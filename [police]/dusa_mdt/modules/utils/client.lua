function utils:disablehud()
    DisplayRadar(false)
    -- exports['qb-hud']:hideHud(true)
    -- exports['dusa_hud']:HideHud(true)
end

function utils:enablehud()
    DisplayRadar(true)
    -- exports['qb-hud']:hideHud(false)
    -- exports['dusa_hud']:HideHud(false)
end

function utils:hacking()
    local hack
    if GetResourceState('simonsays'):find('start') then
        hack = exports['simonsays']:StartSimonSays(4, 5)
    else
        hack = 'notfound'
        print('^1[MDT] ^2Please add your minigame export to utils:hacking function^0')
    end
    return hack
end

function utils:sendNotification(type, message)
    lib.notify({
        description = message,
        type = type,
    })
end

function utils:loadDictionary(dictionary)
    RequestAnimDict(dictionary)
    while (not HasAnimDictLoaded(dictionary)) do        
        Citizen.Wait(1)
    end
end

local cached = false
function utils:cache()
    local isCached
    if not cached then
        settings:Get()
        fines:Get()
        commands:Get()
        forms:Get()
        bolos:Get()
        reports:Get()
        wanted:Get()
        incident:Get()
        vehicles:Get()
        evidence:Get()
        police:Get()
        users:Get()
        if next(house) then
            isCached = house:Cache()
            if isCached or isCached ~= nil then
                house:Get()
            end
        end
        cached = true
        debugPrint('^1[MDT] ^2Cache loaded^0')
        return isCached
    end
end
-- local cached = false
-- function utils:cache()
--     local isCached
--     if not cached then
--         wanted:Get()
--         if next(house) then
--             isCached = house:Cache()
--             if isCached or isCached ~= nil then
--                 house:Get()
--             end
--         end
--         cached = true
--         debugPrint('^1[MDT] ^2Cache loaded^0')
--         return isCached
--     end
-- end

function utils:nearby()
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    local nearby = bridge.getNearby()
    local nearest = {}
    for i=1, #nearby, 1 do
        local id = GetPlayerServerId(nearby[i].id)
        local citizenid = lib.callback.await('dusa_mdt:getCitizenid', false, id)
        
        nearest[#nearest + 1] = {
            citizen = citizenid,
            id = id
        }
    end
    return nearest
end

isOpened = false
function utils:animation()
    local tabletObj = nil
    local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
    local tabletAnim = "base"
    local tabletProp = `prop_cs_tablet`
    local tabletBone = 60309
    local tabletOffset = vector3(0.03, 0.002, -0.0)
    local tabletRot = vector3(10.0, 160.0, 0.0)
    if not isOpened then return end
    -- Animation
    RequestAnimDict(tabletDict)
    while not HasAnimDictLoaded(tabletDict) do Citizen.Wait(100) end
    -- Model
    RequestModel(tabletProp)
    while not HasModelLoaded(tabletProp) do Citizen.Wait(100) end

    local plyPed = cache.ped
    tabletObj = CreateObject(tabletProp, 0.0, 0.0, 0.0, true, true, false)
    local tabletBoneIndex = GetPedBoneIndex(plyPed, tabletBone)

    AttachEntityToEntity(tabletObj, plyPed, tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z, tabletRot.x, tabletRot.y, tabletRot.z, true, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(tabletProp)

    CreateThread(function()
        while isOpened do
            Wait(0)
            if not IsEntityPlayingAnim(plyPed, tabletDict, tabletAnim, 3) then
                TaskPlayAnim(plyPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end


        ClearPedSecondaryTask(plyPed)
        Citizen.Wait(250)
        DetachEntity(tabletObj, true, false)
        DeleteEntity(tabletObj)
    end)
end

function utils:languages()
    local lang = json.decode(LoadResourceFile('dusa_mdt', 'locales/en.json'))
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        utils:cache()
    end
end)

function utils:RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = utils:RotationToDirection(cameraRotation)
    local destination =
    {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
    return b, c, e
end

function utils:RotationToDirection(rotation)
    local adjustedRotation = 
    { 
        x = (math.pi / 180) * rotation.x, 
        y = (math.pi / 180) * rotation.y, 
        z = (math.pi / 180) * rotation.z 
    }
    local direction = 
    {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
        z = math.sin(adjustedRotation.x)
    }
    return direction
end
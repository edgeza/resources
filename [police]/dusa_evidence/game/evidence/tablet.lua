if not rawget(_G, "lib") then include('ox_lib', 'init') end

local languageKeys = {
    "dusaDev",
    "bulletAnalyse",
    "examineFingerprints",
    "enterArchive",
    "bloodTest",
    "search",
    "holdIt",
    "beingAnalysed",
    "analysedComplete",
    "clickForResults",
    "userInfo",
    "exit",
    "evidenceReport",
    "date",
    "searchByFileName",
    "menuOnOff",
    "bloodCollected",
    "searchByBloodName",
    "analyzeBlood",
    "name",
    "fingerPrint",
    "country",
    "bloodType",
    "gender",
    "birthDate",
    "ammoCollected",
    "searchByAmmoName",
    "analyzeAmmo",
    "ammoType",
    "timeOfDeath",
    "shootingGun",
    "gunSerialNumber",
    "hitArea",
    "ammo",
    "body",
    "cameraText",
    "inputText",
    "textareaPlaceholder",
    "saveText",
    "deleteText",
    "loadingText",
    "takePhoto",
    "pickText",
    "filter_blood",
    "filter_bloodybullet",
    "filter_bullet",
    "filterBy",
}

local isTabletOpen = false
local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a"
local tabletAnim = "idle_a"
local tabletProp = nil

function ToggleTabletAnimation(override)
    if override ~= nil then
        isTabletOpen = override
    else
        isTabletOpen = not isTabletOpen
    end

    
    if isTabletOpen then
        -- Start tablet animation
        lib.requestAnimDict(tabletDict)
        
        -- Create and attach tablet prop
        local playerPed = PlayerPedId()
        local bone = GetPedBoneIndex(playerPed, 28422)
        local coords = vector3(0.12, 0.02, 0.0)
        local rotation = vector3(10.0, 160.0, 0.0)
        
        tabletProp = CreateObject(`prop_cs_tablet`, 0.0, 0.0, 0.0, true, true, false)
        AttachEntityToEntity(tabletProp, playerPed, bone, coords.x, coords.y, coords.z, rotation.x, rotation.y, rotation.z, true, false, false, false, 2, true)
        
        TaskPlayAnim(playerPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, false, false, false)

        RemoveAnimDict(tabletDict)
    else
        -- Stop animation
        local playerPed = PlayerPedId()
        StopAnimTask(playerPed, tabletDict, tabletAnim, 1.0)
        ClearPedTasks(playerPed)
        
        -- Remove tablet prop
        if tabletProp then
            DeleteEntity(tabletProp)
            tabletProp = nil
        end
    end
    
    return isTabletOpen
end

local function OpenEvidenceTablet()
    if not Functions.isLeo(Framework.Player.Job.Name)
        then return Framework.Notify(locale('you_are_not_leo'), 'error')
    elseif Config.RequireDuty and not Framework.Player.Job.Duty then
        return Framework.Notify(locale('you_are_not_duty'), 'error')
    end

    ToggleTabletAnimation()

    SetNuiFocus(true, true)

    -- play tablet animation

    local bloody, bullet, casing, blood = lib.callback.await(Bridge.Resource .. ':evidence:server:GetPackedEvidences', false)

    if not bloody or type(bloody) ~= 'table' then
        print('^1[dusa_evidence] WARNING: bloody data is invalid (nil or not table), using empty table^0')
        bloody = {}
    end
    if not bullet or type(bullet) ~= 'table' then
        print('^1[dusa_evidence] WARNING: bullet data is invalid (nil or not table), using empty table^0')
        bullet = {}
    end
    if not casing or type(casing) ~= 'table' then
        print('^1[dusa_evidence] WARNING: casing data is invalid (nil or not table), using empty table^0')
        casing = {}
    end
    if not blood or type(blood) ~= 'table' then
        print('^1[dusa_evidence] WARNING: blood data is invalid (nil or not table), using empty table^0')
        blood = {}
    end

    local fingerprintList = Config.IsEnabled.gsr and ListNearbyGSR() or {}

    local archive = lib.callback.await(Bridge.Resource .. ':evidence:server:GetArchive', false)

    local ammoList = {}

    for _, v in pairs(bloody) do
        table.insert(ammoList, v)
    end

    for _, v in pairs(bullet) do
        table.insert(ammoList, v)
    end

    for _, v in pairs(casing) do
        table.insert(ammoList, v)
    end

    SendNUIMessage({
        action = 'LIST_DATA',
        data = {
            ammo = ammoList,
            blood = blood,
            fingerprint = fingerprintList,
            archive = archive,
            enabled = Config.IsEnabled,
        }
    })

    SendNUIMessage({
        action = 'setVisible',
        data = true
    })    
end
RegisterNetEvent(Bridge.Resource .. ':evidence:client:OpenEvidenceTablet', OpenEvidenceTablet)

RegisterNetEvent(Bridge.Resource .. ':evidence:client:UpdateArchive', function (archive)
    SendNUIMessage({
        action = 'UPDATE_ARCHIVE',
        data = archive
    })
end)

if Config.UseCommand then
    RegisterCommand(Config.Command, OpenEvidenceTablet)
end

local function CloseEvidenceTablet()
    ToggleTabletAnimation(false)
    
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
end


RegisterNUICallback('closeEvidence', function (data, cb)
    CloseEvidenceTablet()
    cb('ok')
end)

local function SaveToInternalGallery()
    BeginTakeHighQualityPhoto()
    SaveHighQualityPhoto(0)
    FreeMemoryForHighQualityPhoto()
end

local function CellFrontCamActivate(activate)
    return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

local frontCam = false
RegisterNUICallback('takePhoto', function (_data, cb)
    SetNuiFocus(false, false)
    CloseEvidenceTablet()
    local service, api = lib.callback.await(Bridge.Resource .. ':evidence:server:GetUploadUrl', false)
    if not api or api == "" then
        Framework.Notify("Setup of camera is not completed, please set an api key", 'error')
        print("^1 [IMPORTANT] ^3Please set a service API for image uploading in the ^4dusa_evidence/imgApi.lua^0")
        DestroyMobilePhone()
        CellCamActivate(false, false)
        cb(nil)
        return
    end
    CreateMobilePhone(1)
    CellCamActivate(true, true)

    local takePhoto = true
    while takePhoto do
        if IsControlJustPressed(1, 27) then -- Toogle Mode
            frontCam = not frontCam
            CellFrontCamActivate(frontCam)
        elseif IsControlJustPressed(1, 177) then -- CANCEL
            DestroyMobilePhone()
            CellCamActivate(false, false)
            cb(nil)
            break
        elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
            if service == 'fivemerr' then
                -- Fivemerr uploads via the server using screenshot-basic to further guard your API key.
                local fivemerrData = lib.callback.await(Bridge.Resource .. ':evidence:server:UploadToFivemerr', false)
                if fivemerrData == nil then
                    DestroyMobilePhone()
                    CellCamActivate(false, false)
                    cb(nil)
                    break
                end

                SaveToInternalGallery()
                local imageData = json.decode(fivemerrData)
                DestroyMobilePhone()
                CellCamActivate(false, false)
                cb(imageData.url)
                takePhoto = false
                return
            end

            exports['screenshot-basic']:requestScreenshotUpload(tostring(api), 'files[]', function(data)
                SaveToInternalGallery()
                local image = json.decode(data)
                DestroyMobilePhone()
                CellCamActivate(false, false)
                cb(image.attachments[1].proxy_url)
                takePhoto = false
            end)
        end
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()
        EnableAllControlActions(0)
        Wait(0)
    end
    Wait(1000)
    OpenEvidenceTablet()
end)

local activeInteractions = {}

if Config.UseLocations then
    for k, v in pairs(Config.Locations) do
        if Config.Target then
            Target.AddBoxZone({
                name = 'target_location.' .. k,
                debug = Config.TargetOptions.debug,
                coords = v.coords,
                size = vec3(1.5, 1.5, 1.5),
                options = {
                    {
                        label = locale('target.openevidence'),
                        distance = tonumber(Config.TargetOptions.distance),
                        icon = Config.TargetOptions.icon,
                        onSelect = function()
                            OpenEvidenceTablet()
                        end
                    }
                }
            })
        else
            activeInteractions[k] = Sprites.sprite({
                coords = v.coords,
                key = 'tablet',
                shape = 'circle',
                spriteIndicator = true,
                colour = { 0, 128, 255, 255 },
                distance = 3.5,
                scale = 0.05,
                canInteract = function()
                    if IsControlJustReleased(0, 38) then
                        OpenEvidenceTablet()
                    end
                    return true
                end,
            })
        end
    end
end

SetTimeout(3000, function ()
    lib.locale(Config.Language)

    local uiLocale = {}
    for k, v in pairs(languageKeys) do
        uiLocale[v] = locale(v)
    end


    SendNUIMessage({
        action = 'language',
        data = uiLocale
    })
end)
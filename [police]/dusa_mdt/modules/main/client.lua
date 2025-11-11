local isOpened = false

function mdt:open()
    if not cache.citizenid then cache.citizenid = bridge.getIdentifier() end
    if isPolice() then
        isOpened = true
        SetNuiFocus(true, true)
        local policeList = police:Get()
        local job = bridge.job()

        local mdtData = {
            bolos = utils:filterJob(job.name, utils.bolos),
            fines = utils:filterJob(job.name, utils.fines),
            commands = utils:filterJob(job.name, utils.commands),
            forms = utils:filterJob(job.name, utils.forms),
            reports = utils:filterJob(job.name, utils.reports),
            incidents = utils:filterJob(job.name, utils.incidents),
            evidences = utils:filterJob(job.name, utils.evidences),
        }

        -- Deduplicate user list to prevent duplicate entries
        local seen = {}
        local uniqueUserList = {}
        local userList = utils.userList or {}
        for _, user in ipairs(userList) do
            if not seen[user.citizenid] then
                seen[user.citizenid] = true
                table.insert(uniqueUserList, user)
            end
        end

        utils.userList = uniqueUserList

        local wantedList = utils.wanted or {}
        for _, user in pairs(utils.userList) do
            for _, wanted in pairs(wantedList) do
                if user.citizenid == wanted.citizenid then
                    user.wanted = wanted.wanted
                    user.caught = wanted.caught
                end
            end
        end



        SendNUIMessage({
            type = "openmdt",
            profile = profileGet(),
            camera = camera:Get(),
            settings = utils.settings or {},
            fines = mdtData.fines or {}, -- 
            commands = mdtData.commands or {}, -- 
            forms = mdtData.forms or {}, --
            bolos = mdtData.bolos or {}, -- 
            reports = mdtData.reports or {}, --
            wanted = utils.wanted or {},
            incident = mdtData.incidents or {}, --
            wantedVehicles = utils.wantedvehicles or {},
            evidence = mdtData.evidences or {}, --
            police = policeList or {}, -- 
            license = license:Get() or {},
            house = utils.house or {},
            nearby = utils:nearby(),
            users = utils.userList or {},
            config = config,
            defaultTheme = config.JobThemes[job.name],
            framework = shared.framework,
        })
        utils:animation()
    else
        bridge.notify(locale('notofficer'), 'error')
    end
end

function mdt:close()
    isOpened = false
    SendNUIMessage({
        type = "closemdt"
    })
end

function mdt:hide()
    isOpened = false
    SendNUIMessage({
        type = "hidemdt"
    })
end

function mdt:show()
    isOpened = true
    SendNUIMessage({
        type = "showmdt"
    })
end

function profileGet()
    local profile = lib.callback.await("dusa_mdt:getProfile", false)
    return profile
end

function isPolice()
    local job = bridge.job()
    for _, v in pairs(config.policejobs) do
        if job.name == v then
            return true
        end
    end
    return false
end

function mdt:onDeath()
    isOpened = false
    SetNuiFocus(false, false)
    mdt:close()
end

RegisterCommand('closemdt', function()
    mdt:close()
end)

RegisterNetEvent('dusa_mdt:open', function()
    mdt:open()
end)

-- Keybind to open MDT with K key
lib.addKeybind({
    name = 'openmdt',
    description = 'Open MDT',
    defaultKey = 'K',
    onPressed = function()
        if not isOpened then
            mdt:open()
        end
    end,
})

RegisterNUICallback('close', function(_, cb)
    isOpened = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('setDuty', function (_)
    -- Duty selector disabled; PS Multijob handles duty state externally.
end)

local function CellFrontCamActivate(activate)
    return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

RegisterNUICallback('takephoto', function(_, cb)
    mdt:hide()
    SetNuiFocus(false, false)
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
            cb(json.encode({ url = nil }))
            break
        elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
            exports['screenshot-basic']:requestScreenshotUpload(tostring(config.Webhook), 'files[]', function(data)
                local image = json.decode(data)
                DestroyMobilePhone()
                CellCamActivate(false, false)
                Wait(400)
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
    SetNuiFocus(true, true)
    mdt:show()
end)

RegisterNUICallback('immediatephoto', function(_, cb)
    exports['screenshot-basic']:requestScreenshotUpload(tostring(config.Webhook), 'files[]', function(data)
        local image = json.decode(data)
        Wait(400)
        cb(image.attachments[1].proxy_url)
    end)
end)

RegisterNetEvent('dusa_mdt:playerLoaded')
AddEventHandler('dusa_mdt:playerLoaded', function()
    cache.ped = PlayerPedId()
    cache.citizenid = cache.citizenid
    utils:cache()
end)

RegisterNetEvent('dusa_mdt:syncCache')
AddEventHandler('dusa_mdt:syncCache', function(key, value)
    debugPrint('^3[SYNC] ^1' .. key .. ' ^0- ' .. json.encode(value))
    utils[key] = value
end)

RegisterNUICallback('getCitizenid', function(_, cb)
    if not cache.citizenid then cache.citizenid = bridge.getIdentifier() end
    local citizenid = cache.citizenid
    cb(citizenid)
end)

RegisterNUICallback('getConfig', function(_, cb)
    cb(config)
end)

RegisterNUICallback('getGrade', function(_, cb)
    local grade = bridge.jobgrade()
    cb(grade)
end)

RegisterNetEvent('dusa_mdt:sync', function(key, value)
    utils[key] = value
end)

RegisterNUICallback('sync', function(data, cb)
    local str = 'New chat message sent. \n \n **Message Details** \n Sender: %s \n Message: %s'
    local message = str:format(data.sender, data.message)
    TriggerServerEvent('dusa_mdt:sendwebhook', 'Chat Message', message, nil, 'chat')

    TriggerServerEvent('dusa_mdt:sync', data.key, data.value)
end)

RegisterNUICallback('getChat', function(_, cb)
    local chat = utils['chat'] or {}
    cb(json.encode(chat))
end)

-- param
-- data: {citizenid: string} --> Player citizen name
local playerTimeout = 0
local timeout = config.Timeout * 1000
RegisterNUICallback('executePlayer', function(data, cb)
    local currentTime = GetGameTimer()
    if currentTime - playerTimeout >= timeout then
        playerTimeout = currentTime
        local player = lib.callback.await('dusa_mdt:executePlayer', false, data.name)
        cb(player)
    else
        SendNUIMessage({
            type = "notify",
            ntype = "error",
            message = locale('timeout')
        })
        cb(nil)
    end
end)

RegisterNUICallback('executeVehicle', function(data, cb)
    local currentTime = GetGameTimer()
    if currentTime - playerTimeout >= timeout then
        playerTimeout = currentTime
        local vehicle = lib.callback.await('dusa_mdt:executeVehicle', false, data.plate)
        cb(vehicle)
    else
        SendNUIMessage({
            type = "notify",
            ntype = "error",
            message = locale('timeout')
        })
        cb(nil)
    end
end)

local function getVehicleName(model)
    local vehicleName = "Model unavailable"
    local displayName = GetDisplayNameFromVehicleModel(model)
    local label = GetLabelText(displayName)
    if label ~= 'NULL' then
        vehicleName = label
    end
    return vehicleName
end

local eventdata = RegisterClientCallback {
    eventName = 'dusa_mdt:getVehicleLabel',
    eventCallback = function(...)
        local args = {...}
        local model = tonumber(args[1])
        local vehicleName = getVehicleName(model)
        return vehicleName
    end
}
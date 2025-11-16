--
--[[ Framework specific functions ]]--
--

local framework = shConfig.framework
local ESX, QBCore

CreateThread(function()
    if framework == 'ESX' then
        ESX = exports["es_extended"]:getSharedObject()

        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded', function (xPlayer)
            ESX.PlayerData = xPlayer
        end)

        RegisterNetEvent('esx:setJob')
        AddEventHandler('esx:setJob', function (job)
            ESX.PlayerData.job = job
        end)
    elseif framework == 'QB' then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

-- Use this variable if you want to set the player as police with an event from another resource.
local isPolice = false

function isPlayerPolice()
    if isPolice then
        return true
    elseif framework == 'ESX' then
        return ESX.PlayerData.job and ESX.PlayerData.job.name == "police"
    elseif framework == 'QB' then
        local playerJob = QBCore.Functions.GetPlayerData().job
        return playerJob.name == 'police' and playerJob.onduty
    else
        -- CUSTOM
        return false
    end
end

-- Add this function near the top of the file, after the framework setup
local function normalizeBoostClass(class)
    local s = tostring(class or ''):upper()
    local letter = s:match('^%a')
    return letter or s
end

local function getVehicleForDispatchFallback()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle and vehicle ~= 0 then return vehicle end
    if activeVehicle and DoesEntityExist(activeVehicle) then
        local pedCoords = GetEntityCoords(ped)
        local dist = #(pedCoords - GetEntityCoords(activeVehicle))
        if dist <= 25.0 then
            return activeVehicle
        end
    end
    -- Try to get closest vehicle around ped if available
    local p = GetEntityCoords(ped)
    local closest = GetClosestVehicle(p.x, p.y, p.z, 7.5, 0, 70)
    if closest and closest ~= 0 then return closest end
    return 0
end

function isGpsHackingEligible(contract)
    if not contract then return false end
    if contract.isImportant then return true end
    local letter = normalizeBoostClass(contract.class)
    return letter == 'A' or letter == 'S'
end

--
--[[ Boosting tablet opening ]]--
--

-- Tablet opening through a command
if clConfig.commandsEnabled then
    RegisterCommand("boosting", function()
        openTablet()
    end)
end

-- Tablet opening through an event
RegisterNetEvent("rahe-boosting:client:openTablet")
AddEventHandler("rahe-boosting:client:openTablet", function(data)
    if data and data.useThinFrame then
        SendNUIMessage({ action = 'useThinBackgroundFrame' })
    end

    openTablet()
end)


--
--[[ Using hacking device ]]--
--

-- Hacking device using through a command
if clConfig.commandsEnabled then
    RegisterCommand("usehackingdevice", function()
        useHackingDevice()
    end)
end

-- Hacking device using through an event
RegisterNetEvent("rahe-boosting:client:hackingDeviceUsed")
AddEventHandler("rahe-boosting:client:hackingDeviceUsed", function()
    -- Pre-alert: any class hacking attempt (outside/inside)
    local ped = PlayerPedId()
    local vehicle = getVehicleForDispatchFallback()
    local coords
    local plate = 'UNKNOWN'
    local classLabel = 'Unknown'

    if vehicle and vehicle ~= 0 then
        coords = GetEntityCoords(vehicle)
        plate = GetVehicleNumberPlateText(vehicle) or plate
        local boostingData = Entity(vehicle).state.boostingData
        if boostingData then
            classLabel = normalizeBoostClass(boostingData.class) or classLabel
        end
    else
        coords = GetEntityCoords(ped)
    end

    -- Send custom dispatch alert for hacking attempt
    exports['ps-dispatch']:CustomAlert({
        message = 'Vehicle Hacking Attempt',
        codeName = 'hackingattempt',
        code = '10-75',
        icon = 'fas fa-laptop-code',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        jobs = { 'police', 'bcso' },
        alert = {
            radius = 0,
            sprite = 523,
            color = 5,
            scale = 1.0,
            length = 3,
            sound = 'Lose_1st',
            flash = false
        }
    })

    useHackingDevice()
end)


--
--[[ Using GPS hacking device ]]--
--

-- GPS hacking device using function. This calls an internal encrypted function which starts the use.
if clConfig.commandsEnabled then
    RegisterCommand("usegpshackingdevice", function()
        useGpsHackingDevice()
    end)
end

-- GPS hacking device using through an event
RegisterNetEvent("rahe-boosting:client:gpsHackingDeviceUsed")
AddEventHandler("rahe-boosting:client:gpsHackingDeviceUsed", function()
    useGpsHackingDevice()
end)


--
--[[ General]]--
--

RegisterNetEvent('rahe-boosting:client:notify')
AddEventHandler('rahe-boosting:client:notify',function(message, type)
    notifyPlayer(message, type)
end)

function notifyPlayer(message, type)
    lib.notify({
        title = message,
        type = type
    })
end

-- You can do some logic here when the tablet is closed. For example, if you started an animation when opening, you can end the animation here.
RegisterNetEvent('rahe-boosting:client:tabletClosed', function()

end)

-- The event which can be used to give vehicle keys to the player after completing the hack of a special boost (A / S class).
AddEventHandler('rahe-boosting:client:giveKeys', function(vehicleId, licensePlate)

end)

-- The event which will be triggered when a player hacks the engine of an important boost. This marks the start of a high priority boost.
-- This event can be used to send a notification to police dispatch to alert the police.
AddEventHandler('rahe-boosting:client:importantBoostStarted', function(location, vehicleId, vehicleClass)
    local coords = location or GetEntityCoords(vehicleId or PlayerPedId())
    local plate = (vehicleId and DoesEntityExist(vehicleId)) and GetVehicleNumberPlateText(vehicleId) or 'UNKNOWN'
    local classLabel = vehicleClass or 'A/S'

    -- Send custom dispatch alert for important boost
    exports['ps-dispatch']:CustomAlert({
        message = 'Vehicle Boost in Progress',
        codeName = 'vehicleboost',
        code = '10-35A',
        icon = 'fas fa-car-burst',
        priority = 1,
        coords = coords,
        street = GetStreetAndZone(coords),
        jobs = { 'police', 'bcso' },
        alert = {
            radius = 0,
            sprite = 523,
            color = 5,
            scale = 1.2,
            length = 5,
            sound = 'Lose_1st',
            flash = false
        }
    })
end)

-- Lightweight alert for non-important boosts when the suspect gets into the vehicle (once per contract)
local sentNonImportantEntryAlert = {}

RegisterNetEvent('rahe-boosting:client:nonImportantBoostVehicleEntered')
AddEventHandler('rahe-boosting:client:nonImportantBoostVehicleEntered', function(contractId, vehicleId, vehicleClass)
    if sentNonImportantEntryAlert[contractId] then return end
    sentNonImportantEntryAlert[contractId] = true

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local plate = (vehicleId and DoesEntityExist(vehicleId)) and GetVehicleNumberPlateText(vehicleId) or 'UNKNOWN'
    local classLabel = vehicleClass or 'B/C/D'

    -- Send custom dispatch alert for suspicious activity
    exports['ps-dispatch']:CustomAlert({
        message = 'Suspicious Vehicle Activity',
        codeName = 'suspiciousvehicle',
        code = '10-35',
        icon = 'fas fa-car',
        priority = 2,
        coords = coords,
        street = GetStreetAndZone(coords),
        jobs = { 'police', 'bcso' },
        alert = {
            radius = 0,
            sprite = 225,
            color = 46,
            scale = 1.0,
            length = 3,
            sound = 'Lose_1st',
            flash = false
        }
    })
end)

-- The event which will be triggered when the players fails a GPS hack.
-- This event can be used to raise player's stress level.
AddEventHandler('rahe-boosting:client:failedGpsHack', function()

end)

-- The event which will be triggered when the players successfully completes one GPS hack.
-- This event by default is used to send a notification, but can also be used to set a circle in a bottom UI circle.
RegisterNetEvent('rahe-boosting:client:successfulGpsHack')
AddEventHandler('rahe-boosting:client:successfulGpsHack', function(hacksCompleted, hacksRequired, gainedDelay)
    notifyPlayer(translations.NOTIFICATION_GAME_HACK_SUCCESSFUL:format(gainedDelay, hacksCompleted, hacksRequired), G_NOTIFICATION_TYPE_SUCCESS)
end)
local Config = require 'config'
local lib = lib or exports.ox_lib

local controlZones = {}
local controllingFlatbed
local helpVisible = false
local doorOptionName = 'custom_flatbed:unlock_vehicle'

local function debugPrint(...)
    if Config.Debug then
        print('[custom_flatbed]', ...)
    end
end

local function clamp(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

local function getKeyLabel(key)
    local keyNames = {
        [38] = 'E',
        [44] = 'Q',
        [73] = 'X',
        [74] = 'H',
        [172] = '↑',
        [173] = '↓',
        [174] = '←',
        [175] = '→',
        [177] = 'Backspace'
    }

    return keyNames[key] or ('Key %s'):format(key)
end

local function requestControl(entity)
    local timeout = GetGameTimer() + 2000

    while not NetworkHasControlOfEntity(entity) and GetGameTimer() < timeout do
        NetworkRequestControlOfEntity(entity)
        Wait(0)
    end

    return NetworkHasControlOfEntity(entity)
end

local function isVehicleBlacklisted(vehicle)
    local class = GetVehicleClass(vehicle)
    return Config.BlacklistedClasses[class]
end

local function findFlatbedConfig(model)
    for _, data in ipairs(Config.Flatbeds) do
        if model == data.model then
            return data
        end
    end
end

local function getLoadedVehicle(flatbed)
    local ent = Entity(flatbed)
    if not ent or not ent.state then return nil end
    return ent.state.flatbedLoaded
end

local function getLoadedVehicleEntity(flatbed)
    local netId = getLoadedVehicle(flatbed)
    if not netId then return nil end

    local vehicle = NetToVeh(netId)
    if not DoesEntityExist(vehicle) then
        Entity(flatbed).state:set('flatbedLoaded', nil, true)
        return nil
    end

    return vehicle
end

local function getAdjustments(flatbed, data)
    local ent = Entity(flatbed)
    if not ent then
        return {
            tilt = data.initialTilt or 0.0,
            offsetY = 0.0,
            offsetZ = 0.0
        }
    end

    local adjustments = ent.state.flatbedAdjust

    if type(adjustments) ~= 'table' then
        adjustments = {
            tilt = data.initialTilt or 0.0,
            offsetY = 0.0,
            offsetZ = 0.0
        }
        ent.state:set('flatbedAdjust', adjustments, true)
    end

    return {
        tilt = adjustments.tilt or data.initialTilt or 0.0,
        offsetY = adjustments.offsetY or 0.0,
        offsetZ = adjustments.offsetZ or 0.0
    }
end

local function saveAdjustments(flatbed, adjustments)
    local ent = Entity(flatbed)
    if ent then
        ent.state:set('flatbedAdjust', {
            tilt = adjustments.tilt,
            offsetY = adjustments.offsetY,
            offsetZ = adjustments.offsetZ
        }, true)
    end
end

local function computeAttachment(data, adjustments)
    local offset = vector3(
        data.attachOffset.x,
        data.attachOffset.y + (adjustments.offsetY or 0.0),
        data.attachOffset.z + (adjustments.offsetZ or 0.0)
    )

    local tilt = (data.initialTilt or 0.0) + (adjustments.tilt or 0.0)

    return offset, tilt
end

local function refreshAttachment(flatbed, data, adjustments)
    local vehicle = getLoadedVehicleEntity(flatbed)
    if not vehicle then return end

    if not requestControl(vehicle) then return end

    local offset, tilt = computeAttachment(data, adjustments)
    AttachEntityToEntity(vehicle, flatbed, GetEntityBoneIndexByName(flatbed, data.bone or 'chassis'), offset.x,
        offset.y, offset.z, tilt, 0.0, 0.0, false, false, false, false, 2, true)
end

local function canUseTarget(flatbed)
    if Config.JobRestriction.enabled and not Config.JobRestriction.hasAccess() then
        return false, Config.Localization.no_permission
    end

    if Config.RequireEngineOn and not GetIsVehicleEngineRunning(flatbed) then
        return false, Config.Localization.engine_required
    end

    return true
end

local function playProgress(label, duration)
    if Config.Progress.enabled and lib then
        return lib.progressCircle({
            duration = duration,
            position = 'bottom',
            label = label,
            useWhileDead = false,
            canCancel = true
        })
    end

    Wait(duration)
    return true
end

local function isVehicleUnlocked(vehicle)
    return GetVehicleDoorLockStatus(vehicle) <= 1
end

local function attachVehicleToFlatbed(flatbed, vehicle, data)
    if not requestControl(flatbed) or not requestControl(vehicle) then
        return Config.Notifications.error('Could not gain control of entity.')
    end

    local adjustments = getAdjustments(flatbed, data)
    local offset, tilt = computeAttachment(data, adjustments)

    AttachEntityToEntity(vehicle, flatbed, GetEntityBoneIndexByName(flatbed, data.bone or 'chassis'), offset.x,
        offset.y, offset.z, tilt, 0.0, 0.0, false, false, false, false, 2, true)

    SetVehicleEngineOn(vehicle, false, true, true)
    Entity(flatbed).state:set('flatbedLoaded', VehToNet(vehicle), true)
    saveAdjustments(flatbed, adjustments)

    Config.Notifications.success(Config.Localization.vehicle_loaded)
end

local function detachVehicleFromFlatbed(flatbed, vehicle, data)
    if not requestControl(flatbed) or not requestControl(vehicle) then
        return Config.Notifications.error('Could not gain control of entity.')
    end

    DetachEntity(vehicle, true, true)

    local unloadCoords = GetOffsetFromEntityInWorldCoords(flatbed, data.unloadOffset.x, data.unloadOffset.y,
        data.unloadOffset.z)

    SetEntityCoords(vehicle, unloadCoords.x, unloadCoords.y, unloadCoords.z)
    SetVehicleOnGroundProperly(vehicle)
    Entity(flatbed).state:set('flatbedLoaded', nil, true)

    Config.Notifications.success(Config.Localization.vehicle_unloaded)
end

local function findVehicleToLoad(flatbed, data)
    local origin = GetOffsetFromEntityInWorldCoords(flatbed, data.controlOffset.x, data.controlOffset.y,
        data.controlOffset.z)
    local radius = Config.MaxVehicleDistance

    local vehicle = GetClosestVehicle(origin.x, origin.y, origin.z, radius, 0, 70)

    if vehicle ~= 0 and vehicle ~= flatbed then
        return vehicle
    end
end

local function handleLoad(flatbed, data)
    if getLoadedVehicle(flatbed) then
        return Config.Notifications.error(Config.Localization.already_loaded)
    end

    local vehicle = findVehicleToLoad(flatbed, data)

    if not vehicle then
        return Config.Notifications.error(Config.Localization.no_vehicle_found)
    end

    if isVehicleBlacklisted(vehicle) then
        return Config.Notifications.error(Config.Localization.vehicle_blacklist)
    end

    if Config.VehicleOptions.requireUnlocked and not isVehicleUnlocked(vehicle) then
        return Config.Notifications.error(Config.Localization.vehicle_locked)
    end

    local ok, message = canUseTarget(flatbed)

    if not ok then
        return Config.Notifications.error(message)
    end

    if not playProgress(Config.Progress.labelLoading, Config.Align.durationLoad) then
        return Config.Notifications.error(Config.Localization.loading_canceled)
    end

    attachVehicleToFlatbed(flatbed, vehicle, data)
end

local function handleUnload(flatbed, data)
    local vehicle = getLoadedVehicleEntity(flatbed)

    if not vehicle then
        return Config.Notifications.error(Config.Localization.no_vehicle_loaded)
    end

    if not playProgress(Config.Progress.labelUnloading, Config.Align.durationUnload) then
        return Config.Notifications.error(Config.Localization.unloading_canceled)
    end

    detachVehicleFromFlatbed(flatbed, vehicle, data)
end

local function handleImmediateDetach(flatbed, data)
    local vehicle = getLoadedVehicleEntity(flatbed)
    if not vehicle then
        return Config.Notifications.error(Config.Localization.no_vehicle_loaded)
    end

    detachVehicleFromFlatbed(flatbed, vehicle, data)
end

local function controlFlatbed(flatbed, data)
    if controllingFlatbed and controllingFlatbed ~= flatbed then
        return Config.Notifications.error(Config.Localization.truck_occupied)
    end

    local ent = Entity(flatbed)
    if not ent then return end

    local controller = ent.state.controller
    if controller and controller ~= cache.serverId then
        return Config.Notifications.error(Config.Localization.truck_occupied)
    end

    controllingFlatbed = flatbed
    ent.state:set('controller', cache.serverId, true)

    local adjustments = getAdjustments(flatbed, data)
    local helpText = table.concat({
        ('%s: %s/%s'):format(Config.Localization.key_front_back, getKeyLabel(Config.ControlKeys.up),
            getKeyLabel(Config.ControlKeys.down)),
        ('%s: %s/%s'):format(Config.Localization.key_up_down, getKeyLabel(Config.ControlKeys.left),
            getKeyLabel(Config.ControlKeys.right)),
        ('%s: %s/%s'):format(Config.Localization.key_tilt, getKeyLabel(Config.ControlKeys.tiltDown),
            getKeyLabel(Config.ControlKeys.tiltUp)),
        ('%s: %s'):format(Config.Localization.key_cancel, getKeyLabel(Config.ControlKeys.cancel)),
        ('%s: %s'):format(Config.Localization.key_dismiss, getKeyLabel(Config.ControlKeys.dismissHelp))
    }, '\n')

    lib.showTextUI(helpText)
    helpVisible = true

    while controllingFlatbed == flatbed do
        Wait(0)

        if not DoesEntityExist(flatbed) then break end

        local playerCoords = GetEntityCoords(cache.ped)
        local controlCoords = GetOffsetFromEntityInWorldCoords(flatbed, data.controlOffset.x, data.controlOffset.y,
            data.controlOffset.z)

        if #(playerCoords - controlCoords) > (Config.ControlSettings.distance + 0.5) then
            Config.Notifications.info(Config.Localization.loading_canceled)
            break
        end

        local changed

        if IsControlPressed(0, Config.ControlKeys.up) then
            local new = clamp(adjustments.offsetY - Config.ControlSettings.alignmentStep, -Config.Align.maxOffset,
                Config.Align.maxOffset)
            if new ~= adjustments.offsetY then
                adjustments.offsetY = new
                changed = true
            end
        elseif IsControlPressed(0, Config.ControlKeys.down) then
            local new = clamp(adjustments.offsetY + Config.ControlSettings.alignmentStep, -Config.Align.maxOffset,
                Config.Align.maxOffset)
            if new ~= adjustments.offsetY then
                adjustments.offsetY = new
                changed = true
            end
        end

        if IsControlPressed(0, Config.ControlKeys.left) then
            local new = clamp(adjustments.offsetZ - Config.ControlSettings.alignmentStep, -Config.Align.maxOffset,
                Config.Align.maxOffset)
            if new ~= adjustments.offsetZ then
                adjustments.offsetZ = new
                changed = true
            end
        elseif IsControlPressed(0, Config.ControlKeys.right) then
            local new = clamp(adjustments.offsetZ + Config.ControlSettings.alignmentStep, -Config.Align.maxOffset,
                Config.Align.maxOffset)
            if new ~= adjustments.offsetZ then
                adjustments.offsetZ = new
                changed = true
            end
        end

        if IsControlPressed(0, Config.ControlKeys.tiltUp) then
            local new = clamp(adjustments.tilt + Config.ControlSettings.tiltStep, -Config.Align.maxTilt,
                Config.Align.maxTilt)
            if new ~= adjustments.tilt then
                adjustments.tilt = new
                changed = true
            end
        elseif IsControlPressed(0, Config.ControlKeys.tiltDown) then
            local new = clamp(adjustments.tilt - Config.ControlSettings.tiltStep, -Config.Align.maxTilt,
                Config.Align.maxTilt)
            if new ~= adjustments.tilt then
                adjustments.tilt = new
                changed = true
            end
        end

        if changed then
            saveAdjustments(flatbed, adjustments)
            refreshAttachment(flatbed, data, adjustments)
        end

        if IsControlJustPressed(0, Config.ControlKeys.dismissHelp) then
            if helpVisible then
                lib.hideTextUI()
            else
                lib.showTextUI(helpText)
            end
            helpVisible = not helpVisible
        end

        if IsControlJustReleased(0, Config.ControlKeys.cancel) then
            break
        end
    end

    if helpVisible then
        lib.hideTextUI()
        helpVisible = false
    end

    controllingFlatbed = nil
    ent.state:set('controller', nil, true)
end

local function registerFlatbed(data)
    debugPrint('Registering flatbed target for model', data.model)

    local loadName = ('%s:load:%s'):format(Config.Target.name, data.model)
    local unloadName = ('%s:unload:%s'):format(Config.Target.name, data.model)
    local controlName = ('%s:control:%s'):format(Config.Target.name, data.model)
    local detachName = ('%s:detach:%s'):format(Config.Target.name, data.model)

    exports.ox_target:addModel(data.model, {
        {
            name = loadName,
            icon = Config.Target.icon,
            label = Config.Target.loadLabel,
            bones = { 'misc_a', 'misc_b', 'misc_c' },
            distance = Config.Target.distance,
            canInteract = function(entity)
                local ped = cache.ped
                if not ped or not DoesEntityExist(entity) then return false end
                if GetVehiclePedIsIn(ped) == entity then return false end

                return not getLoadedVehicle(entity)
            end,
            onSelect = function(dataSelect)
                handleLoad(dataSelect.entity, data)
            end
        },
        {
            name = unloadName,
            icon = 'fa-solid fa-arrow-down',
            label = Config.Target.unloadLabel,
            bones = { 'misc_a', 'misc_b', 'misc_c' },
            distance = Config.Target.distance,
            canInteract = function(entity)
                return getLoadedVehicle(entity) ~= nil
            end,
            onSelect = function(dataSelect)
                handleUnload(dataSelect.entity, data)
            end
        },
        {
            name = controlName,
            icon = 'fa-solid fa-sliders',
            label = Config.Target.controlLabel,
            bones = { 'misc_a', 'misc_b', 'misc_c' },
            distance = Config.Target.distance,
            onSelect = function(dataSelect)
                controlFlatbed(dataSelect.entity, data)
            end
        },
        {
            name = detachName,
            icon = 'fa-solid fa-chain-broken',
            label = Config.Localization.fix_bug,
            bones = { 'misc_a', 'misc_b', 'misc_c' },
            distance = Config.Target.distance,
            canInteract = function(entity)
                return getLoadedVehicle(entity) ~= nil
            end,
            onSelect = function(dataSelect)
                handleImmediateDetach(dataSelect.entity, data)
            end
        }
    })

    controlZones[data.model] = {
        load = loadName,
        unload = unloadName,
        control = controlName,
        detach = detachName
    }
end

local function registerDoorUnlockOption()
    if not Config.VehicleOptions.allowDoorUnlock then return end

    exports.ox_target:addGlobalVehicle({
        {
            name = doorOptionName,
            icon = 'fa-solid fa-key',
            label = Config.Localization.open_vehicle,
            distance = Config.VehicleOptions.doorUnlockDistance,
            canInteract = function(entity, distance, coords)
                if not Config.VehicleOptions.allowDoorUnlock then return false end
                return GetVehicleDoorLockStatus(entity) > 1
            end,
            onSelect = function(dataSelect)
                if not playProgress(Config.Progress.labelUnlock, Config.VehicleOptions.doorUnlockTime) then
                    return Config.Notifications.error(Config.Localization.door_open_canceled)
                end

                SetVehicleDoorsLocked(dataSelect.entity, 1)
                Config.Notifications.success(Config.Localization.door_opened)
            end
        }
    })
end

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    for model, id in pairs(controlZones) do
        exports.ox_target:removeModel(model, { id.load, id.unload, id.control, id.detach })
    end

    if Config.VehicleOptions.allowDoorUnlock then
        exports.ox_target:removeGlobalVehicle({ doorOptionName })
    end
end)

CreateThread(function()
    lib = lib or exports.ox_lib

    for _, flatbed in ipairs(Config.Flatbeds) do
        registerFlatbed(flatbed)
    end

    registerDoorUnlockOption()
end)

CreateThread(function()
    local holdStart

    while true do
        Wait(0)

        local ped = cache.ped
        if not ped or not DoesEntityExist(ped) then goto continue end

        local flatbed = GetVehiclePedIsIn(ped, false)
        if flatbed == 0 then
            holdStart = nil
            goto continue
        end

        if GetPedInVehicleSeat(flatbed, -1) ~= ped then
            holdStart = nil
            goto continue
        end

        local vehicle = getLoadedVehicleEntity(flatbed)
        if not vehicle then
            holdStart = nil
            goto continue
        end

        if IsControlPressed(0, Config.ControlKeys.unhook) then
            if not holdStart then
                holdStart = GetGameTimer()
            elseif GetGameTimer() - holdStart >= Config.ControlSettings.holdToUnhook then
                local data = findFlatbedConfig(GetEntityModel(flatbed))
                if data then
                    detachVehicleFromFlatbed(flatbed, vehicle, data)
                    Config.Notifications.info(Config.Localization.unhooked)
                end
                holdStart = nil
            end
        else
            holdStart = nil
        end

        ::continue::
    end
end)


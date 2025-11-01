function spawnBoostVehicle(contract)
    local modelHash = GetHashKey(contract.vehicleModel)
    requestModel(modelHash)

    local vehicle = CreateVehicle(modelHash, contract.pickUpLocation.x, contract.pickUpLocation.y, contract.pickUpLocation.z, contract.pickUpLocation.h, true, true)
    while not DoesEntityExist(vehicle) do
        Wait(0)
    end

    SetEntityHeading(vehicle, contract.pickUpLocation.h)
    SetVehicleEngineOn(vehicle, false, false)
    SetVehicleOnGroundProperly(vehicle)
    SetVehicleNumberPlateText(vehicle, contract.licensePlate)
    activeVehicle = vehicle

    -- Ensure the vehicle is networked and we have a valid net ID before informing the server
    if not NetworkGetEntityIsNetworked(vehicle) then
        NetworkRegisterEntityAsNetworked(vehicle)
    end

    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    local startTime = GetGameTimer()
    while (not netId or netId == 0) and (GetGameTimer() - startTime) < 2000 do
        Wait(0)
        if not NetworkGetEntityIsNetworked(vehicle) then
            NetworkRegisterEntityAsNetworked(vehicle)
        end
        netId = NetworkGetNetworkIdFromEntity(vehicle)
    end

    if not netId or netId == 0 then
        -- Fallback to VehToNet, still guarded
        netId = VehToNet(vehicle)
    end

    if netId and netId ~= 0 then
        TriggerServerEvent("rahe-boosting:server:setEntityData", netId, contract)
    else
        print("[^3WARN^7] Boosting: Failed to obtain network ID for spawned vehicle; entity state will not be initialized.")
    end

    if contract.isVehicleTuned == 1 then
        applyVehicleTuning(vehicle)
    end

    if contract.risks.doorsLocked then
        SetVehicleDoorsLocked(vehicle, 2)
    end
end

-- Used to unlock the vehicle doors after hacking device has been used to hack the vehicle.
function unlockVehicleDoors(vehicle)
    SetVehicleDoorsLocked(vehicle, 1)
end

-- Used to create vehicle guarding peds after the player has started the outside hack with the hacking device.
function createVehicleGuardPeds(pedType, hashKey, npcCoords)
    for _, ped in ipairs(npcCoords) do
        local guard = CreatePed(pedType, hashKey, ped[1], ped[2], ped[3], ped[4], 1, 1)

        SetPedShootRate(guard, 750)
        SetPedCombatAttributes(guard, 46, true)
        SetPedFleeAttributes(guard, 0, 0)
        SetPedAsEnemy(guard, true)
        SetPedMaxHealth(guard, 100)
        SetPedAlertness(guard, 3)
        SetPedCombatRange(guard, 0)
        SetPedCombatMovement(guard, 3)
        TaskCombatPed(guard, PlayerPedId(), 0, 16)
        GiveWeaponToPed(guard, GetHashKey(clConfig.pickUpAreaNpcWeapon), 5000, true, true)
        SetPedRelationshipGroupHash(guard, GetHashKey("HATES_PLAYER"))
    end
end

lib.onCache('vehicle', function(value)
    if not clConfig.ejectFromInvalidVehicles or not value then
        return
    end

    local boostingData = Entity(value).state.boostingData
    if boostingData and boostingData.advancedSystem and not boostingData.advancedSystemDoorsHacked then
        notifyPlayer(translations.NOTIFICATION_GAME_VEHICLE_ENTER_DOORS_NOT_HACKED, G_NOTIFICATION_TYPE_ERROR)
        TaskLeaveAnyVehicle(cache.ped, 1, 1)
    end

    -- Send a light dispatch for non-important boosts when entering the vehicle (B/C/D)
    if boostingData and (not boostingData.isImportant) then
        local maybeNet = VehToNet(value)
        local contractKey = (boostingData.contractId or boostingData.id or boostingData.licensePlate or boostingData.plate or (maybeNet ~= 0 and tostring(maybeNet)) or 'UNKNOWN')
        TriggerEvent('rahe-boosting:client:nonImportantBoostVehicleEntered', contractKey, value, boostingData.class)
    end
end)

-- Detect door unlocks that likely came from a lockpick (not hacking) and send a police dispatch once
local lastDoorLockStatus
local sentLockpickAlert = false

CreateThread(function()
    while true do
        Wait(500)
        if activeVehicle and DoesEntityExist(activeVehicle) then
            local lockStatus = GetVehicleDoorLockStatus(activeVehicle)
            if lastDoorLockStatus == nil then
                lastDoorLockStatus = lockStatus
            end

            -- If doors transitioned from locked (2 or higher) to unlocked (1), and this wasn't a proper hack unlock
            if not sentLockpickAlert and lastDoorLockStatus and lastDoorLockStatus ~= 1 and lockStatus == 1 then
                local boostingData = Entity(activeVehicle).state.boostingData
                local unlockedByHack = boostingData and boostingData.advancedSystemDoorsHacked
                if not unlockedByHack then
                    sentLockpickAlert = true

                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(activeVehicle)
                    local plate = GetVehicleNumberPlateText(activeVehicle) or 'UNKNOWN'
                    local classLabel = boostingData.class or '?'

                    -- Send custom dispatch alert for vehicle tampering
                    exports['ps-dispatch']:CustomAlert({
                        message = 'Vehicle Tampering Detected',
                        codeName = 'vehicletampering',
                        code = '10-90',
                        icon = 'fas fa-tools',
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
                end
            end

            lastDoorLockStatus = lockStatus
        else
            -- Reset if the vehicle no longer exists
            lastDoorLockStatus = nil
            sentLockpickAlert = false
        end
    end
end)
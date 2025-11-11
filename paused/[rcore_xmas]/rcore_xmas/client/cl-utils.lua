function loadModel(model)
    model = tonumber(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        log.debug('Waiting for model to load: %s', model)
        Citizen.Wait(0)
    end

    return model
end

function isPedFree(ped)
    if IsPedInAnyVehicle(ped) then
        return false
    end

    if IsPlayerFreeAiming(PlayerId()) then
        return false
    end

    if IsPedSwimming(ped) then
        return false
    end

    if IsPedSwimmingUnderWater(ped) then
        return false
    end

    if IsPedRagdoll(ped) then
        return false
    end

    if IsPedFalling(ped) then
        return false
    end

    if IsPedRunning(ped) then
        return false
    end

    if IsPedSprinting(ped) then
        return false
    end

    if IsPedShooting(ped) then
        return false
    end

    if IsPedInCover(ped, 0) then
        return false
    end

    return true
end

function isEntitySnowmanPart(entityId)
    return Entity(entityId).state[SNOWMAN_BUILD_PART_STATE_KEY]
end

function getLocalIdentifier()
    return LocalPlayer.state[XMAS_PLAYER_IDENTIFIER]
end

function getGroundMaterial(entity, coords)
    local handle = StartShapeTestCapsule(coords.x, coords.y, coords.z + 4.0, coords.x, coords.y, coords.z - 2.0, 1, 1,
        entity, 7)
    local status, hit, endPos, surfaceNormal, materialHash, hitEntity = GetShapeTestResultIncludingMaterial(handle)
    if status == 0 then
        return nil
    end

    return materialHash
end

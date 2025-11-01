local objects = {}
ServerObjects = {}
ObjectOwnership = {}

function objects.spawnNewObject(data, source)
    local objId = math.random(100000, 999999)
    while ServerObjects[objId] ~= nil do
        objId = math.random(100000, 999999)
    end
    local coords = vector3(tonumber(data.x), tonumber(data.y), tonumber(data.z))
    local rotation = vector3(tonumber(data.rx), tonumber(data.ry), tonumber(data.rz))

    ServerObjects[objId] = {
        coords = coords,
        rotation = rotation,
        model = data.model,
        id = objId,
        owner = source, -- Add owner to the object data
        parentObject = data.parentObject or nil -- Track parent object
    }

    -- Store ownership information
    if source then
        ObjectOwnership[objId] = source
    end

    TriggerClientEvent('objects:client:addObject', -1, ServerObjects[objId])
    return objId
end

function objects.removeObject(objId)
    ServerObjects[objId] = nil
    ObjectOwnership[objId] = nil
    TriggerClientEvent('objects:client:removeObject', -1, objId)
end

function objects.checkOwnership(objId, source)
    return ObjectOwnership[objId] == source
end

function objects.checkCampfireHasAttachment(campfireHandle)
    -- Check if any object has this campfire as parent
    for objId, object in pairs(ServerObjects) do
        if object.parentObject == campfireHandle then
            -- Check if it's a grill or simplebaker
            if object.model == 'propk_metal_grill' or object.model == 'propk_dh_simplebaker' then
                return true, object.model
            end
        end
    end
    return false, nil
end

return objects
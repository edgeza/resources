if isBridgeLoaded('Target', Target.Q) then
    function Target.addEntity(entityId, data, net)
        exports[Target.Q]:AddTargetEntity(entityId, data)
    end

    function Target.deleteEntity(entityId)
        exports[Target.Q]:RemoveTargetEntity(entityId)
    end

    function Target.addGlobalObject(data)
        exports[Target.Q]:Object(data)
    end
end

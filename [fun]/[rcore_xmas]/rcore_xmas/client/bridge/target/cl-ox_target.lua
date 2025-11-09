if isBridgeLoaded('Target', Target.OX) then
    function Target.addEntity(entityId, data, net)
        if net then
            exports[Target.OX]:addEntity(entityId, data)
            return
        end

        exports[Target.OX]:addLocalEntity(entityId, data)
    end

    function Target.deleteEntity(entityId, net)
        if net then
            exports[Target.OX]:removeEntity(entityId)
            return
        end

        exports[Target.OX]:removeLocalEntity(entityId)
    end

    function Target.addGlobalObject(data)
        exports[Target.OX]:addGlobalObject(data)
    end
end

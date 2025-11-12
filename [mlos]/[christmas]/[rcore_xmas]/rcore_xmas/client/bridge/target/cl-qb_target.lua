if isBridgeLoaded('Target', Target.QB) then
    function Target.addEntity(entityId, data, net)
        data.action = data.onSelect
        exports[Target.QB]:AddTargetEntity(entityId, {
            distance = data.distance,
            options = {
                data
            }
        })
    end

    function Target.deleteEntity(entityId)
        exports[Target.QB]:RemoveTargetEntity(entityId)
    end

    function Target.addGlobalObject(data)
        data.action = function(entity)
            data.onSelect({
                entity = entity
            })
        end
        exports[Target.QB]:AddGlobalObject({
            distance = data.distance,
            options = {
                data
            }
        })
    end
end

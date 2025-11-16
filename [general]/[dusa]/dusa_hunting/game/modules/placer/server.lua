local objects = require 'game.modules.placer.objects'
RegisterNetEvent('objects:server:newObject', function(data)
    local src = source
    objects.spawnNewObject(data, src)
end)

RegisterNetEvent("objects:server:removeObject", function(objId)
    objects.removeObject(objId)
end)

lib.callback.register('objects:getAllObjects', function(source)
    return ServerObjects
end)

lib.callback.register('objects:checkCampfireAttachment', function(source, campfireHandle)
    return objects.checkCampfireHasAttachment(campfireHandle)
end)
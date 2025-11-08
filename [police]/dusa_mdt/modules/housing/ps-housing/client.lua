local resourceName = 'ps-housing'
if not GetResourceState(resourceName):find('start') then return end
housingvalid = true
-- house:
-- dusa_mdt:cachehouse
SetTimeout(0, function()
    function house:Cache()
        local properties = lib.callback.await('ps-housing:server:requestProperties', false)
        local cache
        if next(properties) then
            cache = lib.callback.await("dusa_mdt:cachehouse", false, properties)
        end
        return cache
    end
    
    function house:Get()
        local get = lib.callback.await('dusa_mdt:gethouses', false)
        if type(get) == 'string' then
            get = json.decode(get)
        end
        return get.value or {}
    end
    
    RegisterNUICallback('navigateHouse', function(data, cb)
        local coords = data.coords
        local x, y = tonumber(coords.x), tonumber(coords.y)
        SetNewWaypoint(x, y)
        bridge.notify(locale('house_marked'), 'success')
        mdt:close()
        cb("ok")
    end)
end)
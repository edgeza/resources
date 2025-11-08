local resourceName = 'qb-houses'

if not GetResourceState(resourceName):find('start') then return end
housingvalid = true
-- house:
-- dusa_mdt:cachehouse
SetTimeout(0, function()
    function house:Cache()
        local cache = lib.callback.await("dusa_mdt:cachehouse", false)
        return true
    end
    
    function house:Get()
        local get = lib.callback.await('dusa_mdt:gethouses', false)
        if type(get) == 'string' then
            get = json.decode(get)
        end
        return get.value
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
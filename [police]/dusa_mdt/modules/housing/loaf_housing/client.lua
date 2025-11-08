local resourceName = 'loaf_housing'

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
        bridge.notify(locale('coords_notavailable'), 'error')
        mdt:close()
        cb("ok")
    end)
end)
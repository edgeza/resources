------------
--- Items

if not rawget(_G, "lib") then include('ox_lib', 'init') end

if Config.UseItem then
    if Config.EnableGPS then
        Framework.CreateUseableItem(Config.GPSItem, function(source)
            local src = source
            local Player = Framework.GetPlayer(src)
            
            -- Handle access control
            local isEMS = Functions.IsEMS(Player.Job.Name)
            local isLEO = Functions.IsLEO(Player.Job.Name)
            
            if not (isEMS or isLEO) then 
                return Framework.Notify(src, locale('not_leo'), 'error') 
            end
            
            -- Check duty status if required
            if Config.RequireDuty and not Player.Job.Duty then 
                return Framework.Notify(src, locale('duty_required'), 'error') 
            end
        
            -- Trigger client event
            TriggerClientEvent('police:client:OpenGps', src)
        end)

        Framework.CreateUseableItem(Config.VehicleGPSItem, function(source)
            local src = source
            local Player = Framework.GetPlayer(src)

            if not Functions.IsLEO(Player.Job.Name) then return Framework.Notify(src, locale('not_leo'), 'error') end
            if Config.RequireDuty and not Player.Job.Duty then return Framework.Notify(src, locale('duty_required'), 'error') end

            -- not using remove item after use, because its tablet
            local remove = Config.RemoveOnUse and Framework.RemoveItem(src, Config.VehicleGPSItem, 1)

            TriggerClientEvent('police:client:PlaceGps', src)
        end)

        Framework.CreateUseableItem(Config.VehicleGPSItemRemove, function(source)
            local src = source
            local Player = Framework.GetPlayer(src)

            if not Functions.IsLEO(Player.Job.Name) then return Framework.Notify(src, locale('not_leo'), 'error') end
            if Config.RequireDuty and not Player.Job.Duty then return Framework.Notify(src, locale('duty_required'), 'error') end

            -- not using remove item after use, because its tablet
            local remove = Config.RemoveOnUse and Framework.RemoveItem(src, Config.VehicleGPSItem, 1)

            TriggerClientEvent('police:client:CheckGps', src)
        end)
    end

    if Config.EnableRadio then
        Framework.CreateUseableItem(Config.RadioItem, function(source)
            local src = source
            TriggerClientEvent('police:client:OpenRadio', src)
        end)
    end

    if Config.EnableWheelLock then
        Framework.CreateUseableItem(Config.WheelLockItem, function(source)
            local src = source
            TriggerClientEvent('police:client:attachWheelLock', src)
        end)

        Framework.CreateUseableItem(Config.RemoveLockItem, function(source)
            local src = source
            TriggerClientEvent('police:client:removeWheelLock', src)
        end)
    end
else
    ------------
    --- Commands
    if Config.EnableGPS then
        lib.addCommand(Config.GPSCommand, {
            help = locale('help.open_gps'),
            params = {},
        }, function(source, args, raw)
            local src = source
            local Player = Framework.GetPlayer(src)

            if not Functions.IsLEO(Player.Job.Name) then return Framework.Notify(src, locale('not_leo'), 'error') end
            if Config.RequireDuty and not Player.Job.Duty then return Framework.Notify(src, locale('duty_required'), 'error') end

            TriggerClientEvent('police:client:OpenGps', src)
        end)

        lib.addCommand(Config.VehicleGPSCommand, {
            help = locale('help.place_gps'),
            params = {},
        }, function(source, args, raw)
            local src = source
            local Player = Framework.GetPlayer(src)

            if not Functions.IsLEO(Player.Job.Name) then return Framework.Notify(src, locale('not_leo'), 'error') end
            if Config.RequireDuty and not Player.Job.Duty then return Framework.Notify(src, locale('duty_required'), 'error') end

            TriggerClientEvent('police:client:PlaceGps', src)
        end)

        lib.addCommand(Config.VehicleGPSCommandRemove, {
            help = locale('help.remove_gps'),
            params = {},
        }, function(source, args, raw)
            local src = source

            TriggerClientEvent('police:client:CheckGps', src)
        end)
    end

    if Config.EnableRadio then
        lib.addCommand(Config.RadioCommand, {
            help = locale('help.open_radio'),
            params = {},
        }, function(source, args, raw)
            local src = source

            TriggerClientEvent('police:client:OpenRadio', src)
        end)
    end

    if Config.EnableWheelLock then
        lib.addCommand(Config.WheelLockCommand, {
            help = locale('help.attach_wheel_lock'),
            params = {},
        }, function(source, args, raw)
            local src = source
            local Player = Framework.GetPlayer(src)
            if not Functions.IsLEO(Player.Job.Name) then return Framework.Notify(src, locale('not_leo'), 'error') end

            TriggerClientEvent('police:client:AttachImpoundProp', src)
        end)

        lib.addCommand(Config.RemoveLockCommand, {
            help = locale('help.remove_wheel_lock'),
            params = {},
        }, function(source, args, raw)
            local src = source
            local Player = Framework.GetPlayer(src)
            if not Functions.IsLEO(Player.Job.Name) then return Framework.Notify(src, locale('not_leo'), 'error') end

            TriggerClientEvent('police:client:RemoveImpoundProp', src)
        end)
    end
end


Framework.CreateUseableItem(Config.CuffItem, function(source)
    if not Framework.HasItem(source, Config.CuffItem, 1) then return end
    TriggerClientEvent('police:client:CuffPlayerSoft', source)
end)

Framework.CreateUseableItem(Config.CuffKeysItem, function(source)
    if not Framework.HasItem(source, Config.CuffItem, 1) then return end
    TriggerClientEvent('police:client:UnCuffPlayer', source)
end)

Framework.CreateUseableItem('moneybag', function(source, _item, data)
    if data.metadata then data.info = data.metadata end
    if not data.info or data.info == '' then return end

    local player = Framework.GetPlayer(source)
    if not Config.LeoCanUseMoneyBag and Functions.IsLEO(player.Job.Name) then return Framework.Notify(source, locale('interact.not_allowed_usebag'), 'error') end

    if not player
        or not Framework.HasItem(source, 'moneybag', 1)
        or not Framework.RemoveItem(source, 'moneybag', 1, nil, data.slot)
    then
        return
    end
    player.AddMoney('cash', tonumber(data.info.cash))
end)
local IceMachineData = {
    hasWater = false,
    iceStock = 0,
    producing = false
}

RegisterServerEvent('pl_uwucafe:icemachine:addWater')
AddEventHandler('pl_uwucafe:icemachine:addWater', function()
    local src = source
    local Identifier = GetPlayerIdentifier(src)
    local PlayerName = getPlayerName(src)
    local ped = GetPlayerPed(src)
    local distance = GetEntityCoords(ped)
    if GetJob(source) ~= Config.Jobname then return end
    if #(distance - Location.TargetCoords.IceMachine[1].coords) <= 5 then
        if HasItem(src, Config.IceMachine.water_itemname) <= 0 then
            ServerNotify(src, Locale("icemachine_notify_water_add"), 'error')
            return
        end

        if not RemoveItem(src, Config.IceMachine.water_itemname, 1) then
            ServerNotify(src, Locale("icemachine_notify_water_failed"), 'error')
            return
        end
        if IceMachineData.hasWater then
            ServerNotify(src, Locale("icemachine_notify_water_already") 'error')
            return
        end
        if IceMachineData.iceStock > 0 then
            ServerNotify(src, Locale("icemachine_notify_remove_ice") 'error')
            return
        end
        IceMachineData.hasWater = true
        IceMachineData.producing = true
        ServerNotify(src, Locale("icemachine_notify_ice_production"), 'success')
        CreateThread(function()
            for i = 1, Config.IceMachine.MaxIce do
                Wait(Config.IceMachine.WaitTime * 1000)
                IceMachineData.iceStock = IceMachineData.iceStock + 1
                DebugPrint(("Ice produced: %s/%s"):format(IceMachineData.iceStock, Config.IceMachine.MaxIce))
            end

            IceMachineData.producing = false
            IceMachineData.hasWater = false
            DebugPrint("Ice production complete. Please remove ice and add new water to continue.")
        end)
    else
        print(('^1[Exploit Attempt]^0 %s (%s) tried to trigger event: pl_uwucafe:icemachine:addWater.'):format(PlayerName, Identifier))
    end
end)


RegisterServerEvent('pl_uwucafe:icemachine:getStatus')
AddEventHandler('pl_uwucafe:icemachine:getStatus', function()
    local src = source
    local Identifier = GetPlayerIdentifier(src)
    local PlayerName = getPlayerName(src)
    local ped = GetPlayerPed(src)
    local distance = GetEntityCoords(ped)
    if GetJob(source) ~= Config.Jobname then return end
    if #(distance - Location.TargetCoords.IceMachine[1].coords) <= 5 then
        local status = string.format(
            "Water: %s | Ice: %d/10",
            IceMachineData.hasWater and "Yes" or "No",
            IceMachineData.iceStock
        )
        ServerNotify(src,status, 'success')
    else
        print(('^1[Exploit Attempt]^0 %s (%s) tried to trigger event: pl_uwucafe:icemachine:getStatus.'):format(PlayerName, Identifier))
    end
end)

RegisterServerEvent('pl_uwucafe:icemachine:takeIce')
AddEventHandler('pl_uwucafe:icemachine:takeIce', function()
    local src = source
    local Identifier = GetPlayerIdentifier(src)
    local PlayerName = getPlayerName(src)
    local ped = GetPlayerPed(src)
    local distance = GetEntityCoords(ped)
    if GetJob(source) ~= Config.Jobname then return end

    if #(distance - Location.TargetCoords.IceMachine[1].coords) <= 5 then
        if IceMachineData.iceStock <= 0 then
            ServerNotify(src,Locale("icemachine_notify_no_ice"), 'error')
            return
        end
        IceMachineData.iceStock -= 1
        if AddItem(src, Config.IceMachine.ice_itemname, 1) then
            ServerNotify(src,Locale("icemachine_notify_took_ice"), 'success')
        end
    else
        print(('^1[Exploit Attempt]^0 %s (%s) tried to trigger event: pl_uwucafe:icemachine:takeIce.'):format(PlayerName, Identifier))
    end
end)


if Config.VehicleKeys.ENABLE then

    TriggerEvent('chat:addSuggestion', '/'..Config.VehicleKeys.command, L('chatsuggestion_showkey'))
    RegisterCommand(Config.VehicleKeys.command, function()
        ShowKeysUI()
    end, false)


    KeysTable = {}

    function CacheVehicle(plate, vehicle)
        if KeysTable[plate] == nil then
            KeysTable[plate] = {}
            KeysTable[plate].vehicle = vehicle
        end
    end

    function AddKey(plate)
        if KeysTable[plate] ~= nil then
            KeysTable[plate].has_key = true
        else
            KeysTable[plate] = {}
            KeysTable[plate].has_key = true
        end
    end

    function RemoveKey(plate)
        if KeysTable[plate] ~= nil then
            KeysTable[plate].has_key = false
        else
            KeysTable[plate] = {}
            KeysTable[plate].has_key = false
        end
    end

    function ShowKeysUI()
        TriggerServerEvent('cd_garage:ShowKeysUI')
    end


    RegisterNetEvent('cd_garage:ShowKeysUI', function(keys, allPlayers)
        for c, d in pairs(keys.owned) do
            if not d.name then
                d.name = GetVehiclesData(d.model).name
            end
        end

        TriggerEvent('cd_garage:ToggleNUIFocus')
        SendNUIMessage({
            action = 'showkeys',
            keys = keys,
            players = allPlayers,
            use_charname = Config.PlayerListMethod == 'charname' or Config.PlayerListMethod == 'both',
            use_source = Config.PlayerListMethod == 'source' or Config.PlayerListMethod == 'both'
        })
    end)


    RegisterNetEvent('cd_garage:AddKeys')
    AddEventHandler('cd_garage:AddKeys', function(plate)
        if not plate then return end
        AddKey(GetCorrectPlateFormat(plate))
    end)

    RegisterNetEvent('cd_garage:AddKeys_playerload')
    AddEventHandler('cd_garage:AddKeys_playerload', function(data)
        if type(data) ~= 'table' then return end
        for c, d in pairs(data) do
            AddKey(GetCorrectPlateFormat(d))
        end
    end)

    RegisterNetEvent('cd_garage:RemoveKeys')
    AddEventHandler('cd_garage:RemoveKeys', function(plate)
        if not plate then return end
        RemoveKey(GetCorrectPlateFormat(plate))
    end)

    RegisterNetEvent('cd_garage:GiveVehicleKeys')
    AddEventHandler('cd_garage:GiveVehicleKeys', function(plate, vehicle)
        GiveVehicleKeys(plate, vehicle)
    end)

    RegisterNetEvent('cd_garage:ShowKeys')
    AddEventHandler('cd_garage:ShowKeys', function()
        ShowKeysUI()
    end)

    RegisterNUICallback('addkey_temp', function(data)
        TriggerServerEvent('cd_garage:GiveKeys', 'temp', data.plate, data.target_source)
    end)

    RegisterNUICallback('addkey_save', function(data)
        TriggerServerEvent('cd_garage:GiveKeys', 'save', data.plate, data.target_source)
    end)

    RegisterNUICallback('removekey', function(data)
        TriggerServerEvent('cd_garage:RemoveKeys', data.value)
    end)

    function GetKeysData()
        return KeysTable
    end

    function DoesPlayerHaveKeys(plate)
        local plate_formatted = GetCorrectPlateFormat(plate)
        if type(plate) == 'string' then
            if KeysTable and KeysTable[plate_formatted] and KeysTable[plate_formatted].has_key then
                return true
            end
        end
        return false
    end

    RegisterNetEvent('cd_garage:SaveAllVehicleDamage')
    AddEventHandler('cd_garage:SaveAllVehicleDamage', function()
        local data = {}
        for c, d in pairs(KeysTable) do
            if d.vehicle then
                data[#data+1] = GetVehicleProperties(d.vehicle)
            end
        end
        TriggerServerEvent('cd_garage:SaveAllVehicleDamage', data)
    end)



    CreateThread(function()
        local show_notif = false
        local wait = 500
        while true do
            wait = 500
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                local plate = GetPlate(vehicle)
                CacheVehicle(plate, vehicle)
                if Config.VehicleKeys.Hotwire.ENABLE then
                    local data = KeysTable[plate]
                    if data then
                        if data.vehicle == nil then KeysTable[plate].vehicle = vehicle end
                        if data.has_key then
                            if not data.engine_enabled then
                                SetVehicleEngineOn(vehicle, true, false, false)
                                KeysTable[plate].engine_enabled = true
                            end
                        else
                            if not show_notif then
                                Notif(2, 'hotwire_info')
                                show_notif = true
                            end
                            wait = 5
                            SetVehicleEngineOn(vehicle, false, false, true)
                        end
                    else
                        SetVehicleEngineOn(vehicle, false, false, true)
                    end
                end
            end
            Wait(wait)
        end
    end)

    function StartCarAlarm(vehicle)
        CreateThread(function()
            StartVehicleAlarm(vehicle)
            SetVehicleAlarm(vehicle, true)
            SetVehicleAlarmTimeLeft(vehicle, 1*60*1000) --2 mins
            SetVehicleIndicatorLights(vehicle, 1, true)
            SetVehicleIndicatorLights(vehicle, 0, true)
            for cd = 1, 60 do
                SetVehicleLights(vehicle, 2)
                Wait(500)
                SetVehicleLights(vehicle, 0)
                Wait(500)
            end
            SetVehicleIndicatorLights(vehicle, 1, false)
            SetVehicleIndicatorLights(vehicle, 0, false)
        end)
    end



    if Config.VehicleKeys.Hotwire.ENABLE then

        CreateThread(function()
            local result = nil
            local wait = 500
            while true do
                wait = 500
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(ped, false)
                if GetPedInVehicleSeat(vehicle, -1) == ped then
                    local plate = GetPlate(vehicle)
                    local data = KeysTable[plate]
                    if data then
                        wait = 5
                        if not data.has_key and GetVehicleClass(vehicle) ~= 13 and IsControlJustReleased(0, Config.Keys.StartHotwire_Key) then
                            TriggerEvent('cd_garage:ToggleNUIFocus')
                            StartCarAlarm(vehicle)
                            result = ActionBar()
                            NUI_status = false
                        end
                        if result then
                            AddKey(plate)
                            result = nil
                        end
                    end
                end
                Wait(wait)
            end
        end)

    end



    if Config.VehicleKeys.Lock.ENABLE then

        function LockVehicle(vehicle, play_animation, notify, lights)
            if not InVehicle() and play_animation then
                PlayAnimation('mp_common', 'givetake1_a', 1000)
            end
            if notify then
                Notif(3, 'vehicle_locked')
            end
            if lights then
                LockLights(2, vehicle)
            end
            TriggerServerEvent('cd_garage:SetVehicleLockState', NetworkGetNetworkIdFromEntity(vehicle), 2)
        end

        function UnLockVehicle(vehicle, play_animation, notify, lights)
            if not InVehicle() and play_animation then
                PlayAnimation('mp_common', 'givetake1_a', 1000)
            end
            if notify then
                Notif(1, 'vehicle_unlocked')
            end
            if lights then
                LockLights(1, vehicle)
            end
            TriggerServerEvent('cd_garage:SetVehicleLockState', NetworkGetNetworkIdFromEntity(vehicle), 0)
        end

        RegisterKeyMapping(Config.VehicleKeys.Lock.command, L('chatsuggestion_vehiclelock'), 'keyboard', Config.VehicleKeys.Lock.key)
        TriggerEvent('chat:addSuggestion', '/'..Config.VehicleKeys.Lock.command, L('chatsuggestion_vehiclelock'))
        RegisterCommand(Config.VehicleKeys.Lock.command, function()
            TriggerEvent('cd_garage:ToggleVehicleLock')
        end, false)

        RegisterNetEvent('cd_garage:SetVehicleLocked', function(vehicle)
            LockVehicle(vehicle, false, false, false)
        end)

        RegisterNetEvent('cd_garage:SetVehicleUnlocked', function(vehicle)
            UnLockVehicle(vehicle, false, false, false)
        end)

        if Config.VehicleKeys.Lock.lock_from_inside then
            CreateThread(function()
                while true do
                    Wait(500)
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if InVehicle() and (GetVehicleDoorLockStatus(vehicle) == 2) then
                        SetVehicleDoorsLocked(vehicle, 4)
                    end
                end
            end)
        end

        local cooldown = false
        RegisterNetEvent('cd_garage:ToggleVehicleLock', function()
            if not cooldown then
                local vehicle = GetClosestVehicle(5)
                if vehicle then
                    local plate = GetPlate(vehicle)
                    CacheVehicle(plate, vehicle)
                    if KeysTable[plate].has_key then
                        local lock = GetVehicleDoorLockStatus(vehicle)
                        cooldown = true
                        if lock == 0 or lock == 1 then
                            LockVehicle(vehicle, true, true, true)
                        elseif lock == 2 or lock == 4 then
                            UnLockVehicle(vehicle, true, true, true)
                        end
                        Wait(500)
                        cooldown = false
                    else
                        Notif(3, 'no_keys')
                    end
                else
                    Notif(3, 'no_vehicle_found')
                end
            else
                Notif(3, 'lock_cooldown')
            end
        end)

        function LockLights(state, vehicle)
            CreateThread(function()
                LockDoorSound()
                if state == 2 then
                    SetVehicleInteriorlight(vehicle, false)
                    SetVehicleLights(vehicle, 2)
                    Wait(500)
                    SetVehicleLights(vehicle, 0)
                    Wait(500)
                    SetVehicleLights(vehicle, 2)
                    Wait(2000)
                    SetVehicleLights(vehicle, 0)
                elseif state == 1 then
                    SetVehicleInteriorlight(vehicle, true)
                    SetVehicleLights(vehicle, 2)
                    Wait(500)
                    SetVehicleLights(vehicle, 0)
                    Wait(500)
                    SetVehicleLights(vehicle, 2)
                    Wait(500)
                    SetVehicleLights(vehicle, 0)
                end
            end)
        end
    end



    if Config.VehicleKeys.Lockpick.ENABLE then

        if Config.VehicleKeys.Lockpick.command.ENABLE then
            TriggerEvent('chat:addSuggestion', '/'..Config.VehicleKeys.Lockpick.command.chat_command, L('chatsuggestion_lockpick'))
            RegisterCommand(Config.VehicleKeys.Lockpick.command.chat_command, function()
                TriggerEvent('cd_garage:LockpickVehicle', false)
            end, false)
        end

        local doing_animation = false
        local function LockpickAnimation(vehicle)
            doing_animation = true
            CreateThread(function()
                local ped = PlayerPedId()
                TaskTurnPedToFaceEntity(ped, vehicle, 1000)
                RequestAnimDict('veh@break_in@0h@p_m_one@')
                while not HasAnimDictLoaded('veh@break_in@0h@p_m_one@') do Wait(0) end
                FreezeEntityPosition(ped, true)
                while doing_animation do
                    TaskPlayAnim(ped, 'veh@break_in@0h@p_m_one@', 'low_force_entry_ds', 2.0, -2.0, -1, 1, 0, 0, 0, 0 )
                    Wait(1000)
                    ClearPedTasks(ped)
                end
                FreezeEntityPosition(ped, false)
                RemoveAnimDict('veh@break_in@0h@p_m_one@')
            end)
        end

        RegisterNetEvent('cd_garage:LockpickVehicle')
        AddEventHandler('cd_garage:LockpickVehicle', function(used_usable_item)
            local vehicle = GetClosestVehicle(5)
            if vehicle then
                local plate = GetPlate(vehicle)
                CacheVehicle(plate, vehicle)
                if not KeysTable[plate].has_key then
                    local lock = GetVehicleDoorLockStatus(vehicle)
                    if lock > 1 then
                        if used_usable_item then
                            TriggerServerEvent('cd_garage:LockpickVehicle:RemoveItem')
                        end
                        LockpickAnimation(vehicle)
                        StartCarAlarm(vehicle)
                        local hacking = exports['cd_keymaster']:StartKeyMaster()
                        if hacking then
                            UnLockVehicle(vehicle, false, false, true)
                        else
                            Notif(3, 'lockpicking_failed')
                        end
                        ClearPedTasks(PlayerPedId())
                        doing_animation = false
                    else
                        Notif(3, 'vehicle_not_locked')
                    end
                else
                    Notif(3, 'cant_lockpick_have_keys')
                end
            else
                Notif(3, 'no_vehicle_found')
            end
        end)

    end

    RegisterNetEvent('vehiclekeys:client:SetOwner')
    AddEventHandler('vehiclekeys:client:SetOwner', function(plate)
        AddKey(GetCorrectPlateFormat(plate))
    end)

    RegisterNetEvent('qb-vehiclekeys:client:AddKeys')
    AddEventHandler('qb-vehiclekeys:client:AddKeys', function(plate)
        AddKey(GetCorrectPlateFormat(plate))
    end)

end
-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           VEHICLE FUEL                           │
-- └──────────────────────────────────────────────────────────────────┘

function GetFuel(vehicle, plate) -- This gets triggered just before you store your vehicle.
    if GetResourceState('BigDaddy-Fuel') == 'started' then
        return exports['BigDaddy-Fuel']:GetFuel(vehicle)

    elseif GetResourceState('cdn-fuel') == 'started' then
        return exports['cdn-fuel']:GetFuel(vehicle)

    elseif GetResourceState('esx-sna-fuel') == 'started' then
        return exports['esx-sna-fuel']:GetFuel(vehicle)

    elseif GetResourceState('FRFuel') == 'started' then
        return math.ceil((100 / GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fPetrolTankVolume')) * math.ceil(GetVehicleFuelLevel(vehicle)))

    elseif GetResourceState('lc_fuel') == 'started' then
        return exports['lc_fuel']:GetFuel(vehicle)

    elseif GetResourceState('LegacyFuel') == 'started' then
        return exports['LegacyFuel']:GetFuel(vehicle)

    elseif GetResourceState('lj-fuel') == 'started' then
        return exports['lj-fuel']:GetFuel(vehicle)

    elseif GetResourceState('myFuel') == 'started' then
        return exports['myFuel']:GetFuel(vehicle)

    elseif GetResourceState('ND_Fuel') == 'started' then
        return DecorGetFloat(vehicle, '_ANDY_FUEL_DECORE_')

    elseif GetResourceState('okokGasStation') == 'started' then
        return exports['okokGasStation']:GetFuel(vehicle)

    elseif GetResourceState('ox_fuel') == 'started' then
        return GetVehicleFuelLevel(vehicle)

    elseif GetResourceState('ps-fuel') == 'started' then
        return exports['ps-fuel']:GetFuel(vehicle)

    elseif GetResourceState('qb-fuel') == 'started' then
        return exports['qb-fuel']:GetFuel(vehicle)

    elseif GetResourceState('qb-sna-fuel') == 'started' then
        return exports['qb-sna-fuel']:GetFuel(vehicle)

    elseif GetResourceState('rcore_fuel') == 'started' then
        return exports['rcore_fuel']:GetVehicleFuelPercentage(vehicle)

    elseif GetResourceState('Renewed-Fuel') == 'started' then
        return Entity(vehicle).state.fuel

    elseif GetResourceState('ti_fuel') == 'started' then
        return exports['ti_fuel']:getFuel(vehicle)

    elseif GetResourceState('x-fuel') == 'started' then
        return exports['x-fuel']:GetFuel(vehicle)

    else
        return nil -- If this returns nil, cd_garage will use your framework’s default GetVehicleProperties method.
    end
end

function SetFuel(vehicle, plate, fuel_level) -- This gets triggered after you spawn your vehicle.
    fuel_level = fuel_level+0.0
    if GetResourceState('BigDaddy-Fuel') == 'started' then
        exports['BigDaddy-Fuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('cdn-fuel') == 'started' then
        exports['cdn-fuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('esx-sna-fuel') == 'started' then
        exports['esx-sna-fuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('FRFuel') == 'started' then
        SetVehicleFuelLevel(vehicle, fuel_level)

    elseif GetResourceState('lc_fuel') == 'started' then
        exports['lc_fuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('LegacyFuel') == 'started' then
        exports['LegacyFuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('lj-fuel') == 'started' then
        exports['lj-fuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('myFuel') == 'started' then
        exports['myFuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('ND_Fuel') == 'started' then
        SetVehicleFuelLevel(vehicle, fuel_level)
        DecorSetFloat(vehicle, '_ANDY_FUEL_DECORE_', fuel_level)

    elseif GetResourceState('okokGasStation') == 'started' then
        exports['okokGasStation']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('ox_fuel') == 'started' then
        Entity(vehicle).state.fuel = fuel_level

    elseif GetResourceState('ps-fuel') == 'started' then
        exports['ps-fuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('qb-fuel') == 'started' then
        exports['qb-fuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('qb-sna-fuel') == 'started' then
        exports['qb-sna-fuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('rcore_fuel') == 'started' then
        exports['rcore_fuel']:SetVehicleFuel(vehicle, fuel_level)

    elseif GetResourceState('Renewed-Fuel') == 'started' then
        exports['Renewed-Fuel']:SetFuel(vehicle, fuel_level)

    elseif GetResourceState('ti_fuel') == 'started' then
        exports['ti_fuel']:setFuel(vehicle, fuel_level, 'RON91')

    elseif GetResourceState('x-fuel') == 'started' then
        exports['x-fuel']:SetFuel(vehicle, fuel_level)
    end
    -- If no events/exports are triggered here, cd_garage will use your framework’s default SetVehicleProperties method.
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           VEHICLE KEYS                           │
-- └──────────────────────────────────────────────────────────────────┘

function GiveVehicleKeys(plate, vehicle) -- Triggered when giving keys to a vehicle (vehicle may be nil)
    if Config.VehicleKeys.ENABLE then
        AddKey(plate)
    else
        local keysResource = Config.VehicleKeysResource

        if keysResource == 'ak47_qb_vehiclekeys' then
            exports['ak47_qb_vehiclekeys']:GiveKey(plate, false)

        elseif keysResource == 'ak47_vehiclekeys' then
            exports['ak47_vehiclekeys']:GiveKey(plate, false)

        elseif keysResource == 'F_RealCarKeysSystem' then
            TriggerServerEvent('F_RealCarKeysSystem:generateVehicleKeys', plate)

        elseif keysResource == 'fivecode_carkeys' then
            exports.fivecode_carkeys:GiveKey(vehicle, false, true)

        elseif keysResource == 'mk_vehiclekeys' then
            exports['mk_vehiclekeys']:AddKey(vehicle)

        elseif keysResource == 'MrNewbVehicleKeys' then
            exports['MrNewbVehicleKeys']:GiveKeysByPlate(plate)

        elseif keysResource == 'qbx_vehiclekeys' then
            lib.callback.await('qbx_vehiclekeys:server:giveKeys', false, VehToNet(vehicle))

        elseif keysResource == 'qs-vehiclekeys' then
            exports['qs-vehiclekeys']:GiveKeys(plate, GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)), true)

        elseif keysResource == 'stasiek_vehiclekeys' then
            if vehicle then
                DecorSetInt(vehicle, 'owner', GetPlayerServerId(PlayerId()))
            end

        elseif keysResource == 't1ger_keys' then
            exports['t1ger_keys']:GiveTemporaryKeys(plate, GetLabelText(GetDisplayNameFromVehicleModel(vehicle)), type)

        elseif keysResource == 'tgiann-hotwire' then
            exports['tgiann-hotwire']:GiveKeyPlate(plate, true)

        elseif keysResource == 'ti_vehicleKeys' then
            exports['ti_vehicleKeys']:addTemporaryVehicle(plate)

        elseif keysResource == 'vehicles_keys' then
            TriggerServerEvent('vehicles_keys:selfGiveVehicleKeys', plate)

        elseif keysResource == 'wasabi_carlock' then
            exports['wasabi_carlock']:GiveKey(plate)

        elseif keysResource == 'xd_locksystem' then
            --exports['xd_locksystem']:givePlayerKeys(plate) -- v1
            exports['xd_locksystem']:SetVehicleKey(plate) -- v2
        end
    end
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                        PERSISTENT VEHICLES                       │
-- └──────────────────────────────────────────────────────────────────┘

function AddPersistentVehicle(vehicle, plate, job_vehicle) --This will be triggered everytime a vehicle is spawned.
    local net_id = NetworkGetNetworkIdFromEntity(vehicle)
    if Config.PersistentVehicles.ENABLE then
        TriggerServerEvent('cd_garage:AddPersistentVehicles', plate, net_id, job_vehicle)

    else
        --Add your own code here if needed.
    end
end

function RemovePersistentVehicle(vehicle, plate) --This will be triggered everytime a vehicle is stored/deleted.
    if Config.PersistentVehicles.ENABLE then
        TriggerServerEvent('cd_garage:RemovePersistentVehicles', plate)
    else
        if GetResourceState('AdvancedParking') == 'started' then
            exports['AdvancedParking']:DeleteVehicle(vehicle)
        end
        --Add your own code here if needed.
    end
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                         TIME & wEATHER                           │
-- └──────────────────────────────────────────────────────────────────┘

function ToggleShellTime(toggle)
    if Config.InsideGarage.shell_time_script == 'easytime' then
        if toggle == 'enter' then
            TriggerEvent('cd_easytime:PauseSync', true)
        elseif toggle == 'exit' then
            TriggerEvent('cd_easytime:PauseSync', false)
        end

    elseif Config.InsideGarage.shell_time_script == 'vsync' then
        if toggle == 'enter' then
            TriggerEvent('vSync:toggle',false)
            NetworkOverrideClockTime(23, 00, 00)
        elseif toggle == 'exit' then
            TriggerEvent('vSync:toggle',true)
            TriggerServerEvent('vSync:requestSync')
        end

    elseif Config.InsideGarage.shell_time_script == 'qbcore' then
        if toggle == 'enter' then
            TriggerEvent('qb-weathersync:client:DisableSync')
        elseif toggle == 'exit' then
            TriggerEvent('qb-weathersync:client:EnableSync')
        end
    end
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          NOTIFICATIONS                           │
-- └──────────────────────────────────────────────────────────────────┘

function Notification(notif_type, message)
    if notif_type and message then
        if Config.Notification == 'chat' then
            TriggerEvent('chatMessage', message)

        elseif Config.Notification == 'esx' then
            ESX.ShowNotification(message)

        elseif Config.Notification == 'mythic_notify' then
            if notif_type == 1 then
                exports.mythic_notify:DoLongHudText(message, 'success')
            elseif notif_type == 2 then
                exports.mythic_notify:DoLongHudText(message, 'inform')
            elseif notif_type == 3 then
                exports.mythic_notify:DoLongHudText(message, 'error')
            end

        elseif Config.Notification == 'okokNotify' then
            if notif_type == 1 then
                exports.okokNotify:Alert(L('garage'), message, 5000, 'success')
            elseif notif_type == 2 then
                exports.okokNotify:Alert(L('garage'), message, 5000, 'info')
            elseif notif_type == 3 then
                exports.okokNotify:Alert(L('garage'), message, 5000, 'error')
            end

        elseif Config.Notification == 'origen_notify' then
            exports['origen_notify']:ShowNotification(message)

        elseif Config.Notification == 'ox_lib' then
            if not lib then print('^1Error: Uncomment the line for ox_lib in the fxmanifest.^0') end
            if notif_type == 1 then
                lib.notify({title = L('garage'), description = message, type = 'success'})
            elseif notif_type == 2 then
                lib.notify({title = L('garage'), description = message, type = 'inform'})
            elseif notif_type == 3 then
                lib.notify({title = L('garage'), description = message, type = 'error'})
            end

        elseif Config.Notification == 'pNotify' then
            if notif_type == 1 then
                exports.pNotify:SendNotification({text = message, type = 'success', timeout = 5000})
            elseif notif_type == 2 then
                exports.pNotify:SendNotification({text = message, type = 'info', timeout = 5000})
            elseif notif_type == 3 then
                exports.pNotify:SendNotification({text = message, type = 'error', timeout = 5000})
            end

        elseif Config.Notification == 'ps-ui' then
            if notif_type == 1 then
                exports['ps-ui']:Notify(message, 'success', 5000)
            elseif notif_type == 2 then
                exports['ps-ui']:Notify(message, 'primary', 5000)
            elseif notif_type == 3 then
                exports['ps-ui']:Notify(message, 'error', 5000)
            end

        elseif Config.Notification == 'qbcore' then
            if notif_type == 1 then
                QBCore.Functions.Notify(message, 'success')
            elseif notif_type == 2 then
                QBCore.Functions.Notify(message, 'primary')
            elseif notif_type == 3 then
                QBCore.Functions.Notify(message, 'error')
            end

        elseif Config.Notification == 'rtx_notify' then
            if notif_type == 1 then
                TriggerEvent('rtx_notify:Notify', L('garage'), 'success', message, 5000)
            elseif notif_type == 2 then
                TriggerEvent('rtx_notify:Notify', L('garage'), 'info', message, 5000)
            elseif notif_type == 3 then
                TriggerEvent('rtx_notify:Notify', L('garage'), 'error', message, 5000)
            end

        elseif Config.Notification == 'vms_notifyv2' then
            exports['vms_notifyv2']:Notification({title = L('garage'), description = message, time = 5000, color = '#34ebe8', icon = 'fa-solid fa-check'})

        elseif Config.Notification == 'other' then
            -- add your own notification.
        end
    end
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           DRAW TEXT UI                           │
-- └──────────────────────────────────────────────────────────────────┘

function DrawTextUI(action, text)
    local method = Config.GarageInteractMethod
    if method == 'cd_drawtextui' then
        if action == 'show' then
            TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
        elseif action == 'hide' then
            TriggerEvent('cd_drawtextui:HideUI')
        end

    elseif method == 'jg-textui' then
        if action == 'show' then
            exports['jg-textui']:DrawText(text)
        elseif action == 'hide' then
            exports['jg-textui']:HideText()
        end

    elseif method == 'okokTextUI' then
        if action == 'show' then
            exports['okokTextUI']:Open(text, false)
        elseif action == 'hide' then
            exports['okokTextUI']:Close()
        end

    elseif method == 'ps-ui' then
        if action == 'show' then
            exports['ps-ui']:DisplayText(text, 'primary', 'fa-solid fa-circle-info')
        elseif action == 'hide' then
            exports['ps-ui']:HideText()
        end

    elseif method == 'qbcore' then
        if action == 'show' then
            QBCore.Functions.DrawText(text)
        elseif action == 'hide' then
            QBCore.Functions.HideText()
        end

    elseif method == 'vms_notifyv2' then
        if action == 'show' then
            exports['vms_notifyv2']:ShowTextUI(text)
        elseif action == 'hide' then
            exports['vms_notifyv2']:HideTextUI()
        end
    end
end
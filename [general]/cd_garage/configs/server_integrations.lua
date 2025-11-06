-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            FAKE PLATES                           │
-- └──────────────────────────────────────────────────────────────────┘

function FakePlateAdded(original_plate, fake_plate) --This is triggered when a player adds a fake plate.
    if GetResourceState('ox_inventory') == 'started' then
        exports['ox_inventory']:UpdateVehicle(original_plate, fake_plate)
    end
    --You can add other events/exports here to update other inventories when a fake plate is added.
end

function FakePlateRemoved(original_plate, fake_plate) --This is triggered when a player removes a fake plate.
    if GetResourceState('ox_inventory') == 'started' then
        exports['ox_inventory']:UpdateVehicle(original_plate, fake_plate)
    end
    --You can add other events/exports here to update other inventories when a fake plate is removed.
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          NOTIFICATIONS                           │
-- └──────────────────────────────────────────────────────────────────┘

function Notification(source, notif_type, message)
    if source and notif_type and message then
        if Config.Notification == 'chat' then
            TriggerClientEvent('chatMessage', source, message)

        elseif Config.Notification == 'esx' then
            TriggerClientEvent('esx:showNotification', source, message)

        elseif Config.Notification == 'mythic_notify' then
            if notif_type == 1 then
                TriggerClientEvent('mythic_notify:DoLongHudText', source, 'success', message)
            elseif notif_type == 2 then
                TriggerClientEvent('mythic_notify:DoLongHudText', source, 'inform', message)
            elseif notif_type == 3 then
                TriggerClientEvent('mythic_notify:DoLongHudText', source, 'error', message)
            end

        elseif Config.Notification == 'okokNotify' then
            if notif_type == 1 then
                TriggerClientEvent('okokNotify:Alert', source, L('garage'), message, 5000, 'success')
            elseif notif_type == 2 then
                TriggerClientEvent('okokNotify:Alert', source, L('garage'), message, 5000, 'info')
            elseif notif_type == 3 then
                TriggerClientEvent('okokNotify:Alert', source, L('garage'), message, 5000, 'error')
            end

        elseif Config.Notification == 'origen_notify' then
            exports['origen_notify']:ShowNotification(source, message)

        elseif Config.Notification == 'ox_lib' then
            if not lib then print('^1Error: Uncomment the line for ox_lib in the fxmanifest.^0') end
            if notif_type == 1 then
                lib.notify(source, { title = L('garage'), description = message, type = 'success' })
            elseif notif_type == 2 then
                lib.notify(source, { title = L('garage'), description = message, type = 'inform' })
            elseif notif_type == 3 then
                lib.notify(source, { title = L('garage'), description = message, type = 'error' })
            end

        elseif Config.Notification == 'pNotify' then
            if notif_type == 1 then
                TriggerClientEvent('pNotify:SendNotification', source, { text = message, type = 'success', timeout = 5000 })
            elseif notif_type == 2 then
                TriggerClientEvent('pNotify:SendNotification', source, { text = message, type = 'info', timeout = 5000 })
            elseif notif_type == 3 then
                TriggerClientEvent('pNotify:SendNotification', source, { text = message, type = 'error', timeout = 5000 })
            end

        elseif Config.Notification == 'ps-ui' then
            if notif_type == 1 then
                TriggerClientEvent('ps-ui:Notify', source, message, 'success')
            elseif notif_type == 2 then
                TriggerClientEvent('ps-ui:Notify', source, message, 'primary')
            elseif notif_type == 3 then
                TriggerClientEvent('ps-ui:Notify', source, message, 'error')
            end

        elseif Config.Notification == 'qbcore' then
            if notif_type == 1 then
                TriggerClientEvent('QBCore:Notify', source, message, 'success')
            elseif notif_type == 2 then
                TriggerClientEvent('QBCore:Notify', source, message, 'primary')
            elseif notif_type == 3 then
                TriggerClientEvent('QBCore:Notify', source, message, 'error')
            end

        elseif Config.Notification == 'rtx_notify' then
            if notif_type == 1 then
                TriggerClientEvent('rtx_notify:Notify', source, L('garage'), message, 5000, 'success')
            elseif notif_type == 2 then
                TriggerClientEvent('rtx_notify:Notify', source, L('garage'), message, 5000, 'info')
            elseif notif_type == 3 then
                TriggerClientEvent('rtx_notify:Notify', source, L('garage'), message, 5000, 'error')
            end

        elseif Config.Notification == 'vms_notifyv2' then
            TriggerClientEvent('vms_notifyv2:Notification', source, { title = L('garage'), description = message, time = 5000, color = "#34ebe8", icon = "fa-solid fa-check"})

        elseif Config.Notification == 'other' then
            -- add your own notification method here.
        end
    end
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                         SERVER EXPORTS                           │
-- └──────────────────────────────────────────────────────────────────┘

function GetMaxHealth(plate)
    if AdvStatsTable and AdvStatsTable[plate] and AdvStatsTable[plate].maxhealth then
        return AdvStatsTable[plate].maxhealth
    else
        return 1000.0
    end
end

function GetVehicleMileage(plate)
    if AdvStatsTable and AdvStatsTable[plate] and AdvStatsTable[plate].mileage then
        return AdvStatsTable[plate].mileage
    else
        return nil
    end
end

function GetAdvStats(plate)
    if AdvStatsTable and AdvStatsTable[plate] then
        return {plate = AdvStatsTable[plate].plate, mileage = AdvStatsTable[plate].mileage, maxhealth = AdvStatsTable[plate].maxhealth}
    else
        local Result = DatabaseQuery('SELECT adv_stats FROM '..FW.vehicle_table..' WHERE plate="'..GetCorrectPlateFormat(plate)..'"')
        if Result and Result[1] and Result[1].adv_stats then
            return json.decode(Result[1].adv_stats)
        end
    end
    return false
end

function GetGarageCount(source, garage_type)
    if garage_type == nil then garage_type = 'car' end
    local Result = DatabaseQuery('SELECT '..FW.vehicle_identifier..' FROM '..FW.vehicle_table..' WHERE '..FW.vehicle_identifier..'="'..GetIdentifier(source)..'" and garage_type="'..garage_type..'"')
    if Result then
        return #Result
    end
    return 0
end

function GetGarageLimit(source)
    if Config.GarageSpace.ENABLE then
        local Result = DatabaseQuery('SELECT garage_limit FROM '..FW.users_table..' WHERE '..FW.users_identifier..'="'..GetIdentifier(source)..'"')
        if Result and Result[1] and Result[1].garage_limit then
            return tonumber(Result[1].garage_limit)
        end
    end
    return 1000
end

function CheckVehicleOwner(source, plate)
    local Result = DatabaseQuery('SELECT '..FW.vehicle_identifier..' FROM '..FW.vehicle_table..' WHERE plate="'..GetCorrectPlateFormat(plate)..'"')
    if Result and Result[1]then
        local data = Result[1][FW.vehicle_identifier]
        if data then
            if data == GetIdentifier(source) then
                return true
            end
        end
    end
    return false
end

function GetPlate(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    if not plate then return nil end
    if Config.VehiclePlateFormats.format == 'trimmed' then
        return Trim(plate)

    elseif Config.VehiclePlateFormats.format == 'with_spaces' then
        return plate

    elseif Config.VehiclePlateFormats.format == 'mixed' then
        return string.gsub(plate, "^%s*(.-)%s*$", "%1")

    end
end

function IsVehicleImpounded(plate)
    local Result = DatabaseQuery('SELECT impound FROM '..FW.vehicle_table..' WHERE plate="'..GetCorrectPlateFormat(plate)..'"')
    if Result and Result[1] and Result[1].impounded then
        if tonumber(Result[1].impounded) == 1 then
            return true
        end
    end
    return false
end

function GetVehicleImpoundData(plate)
    local Result = DatabaseQuery('SELECT impound, impound_time, impound_reason FROM '..FW.vehicle_table..' WHERE plate="'..GetCorrectPlateFormat(plate)..'"')
    if Result and Result[1] then
        return {impound = Result[1].impound, impound_time = Result[1].impound_time, impound_reason = Result[1].impound_reason}
    end
    return nil
end

function GetGarageVehicleIsIn(plate)
    local Result = DatabaseQuery('SELECT garage_id FROM '..FW.vehicle_table..' WHERE plate="'..GetCorrectPlateFormat(plate)..'"')
    if Result and Result[1] and Result[1].garage_id then
        return Result[1].garage_id
    end
    return nil
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                          SERVER EVENTS                           │
-- └──────────────────────────────────────────────────────────────────┘

RegisterServerEvent('cd_garage:SetGarageState', function(plate, state)
    if not plate or not state then return end
    DatabaseQuery('UPDATE '..FW.vehicle_table..' SET in_garage=? WHERE plate=?', {state and 1 or 0, plate})
end)
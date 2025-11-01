Editable = {
    --@param playerId: number
    --@param text: string
    --@param type: inform | error | success
    showNotify = function(playerId, text, type)
        TriggerClientEvent('ox_lib:notify', playerId, {title = locale('notification'), description = text, type = type or 'inform'})
    end,

    getPlayerForNotify = function(playerId) -- this function is used to get the player for notify in creating court hearing
        local player = Bridge.getIdentifier(playerId)
        return player and {player = player, name = Bridge.getName(playerId)} or nil
    end,

    --@param identifiers: table {player: string = identifier, name = string}
    --@param data: table {time: os.time, id: string, room: string}
    SendCourtNotification = function(identifiers, data)
        if GetResourceState('piotreq_phone') == 'started' then
            for i = 1, #identifiers, 1 do
                local phoneNumber = exports['piotreq_phone']:GetNumberFromIdentifier(identifiers[i].player)
                if phoneNumber then
                    local content = locale('incoming_court_hearing', data.id, os.date('%H:%M %d-%m-%Y', data.time), data.room)
                    exports['piotreq_phone']:SendMessage({
                        sender = 'Department of Justice', -- number
                        receiver = phoneNumber, -- number
                        content = content,
                        notify = {
                           title = 'Department of Justice',
                           time = os.date('%H:%M'),
                           text = content,
                           type = 'default',
                           timeout = 8000
                        }
                    })
                end
            end
        else
            for i = 1, #identifiers, 1 do
                local playerId = Bridge.getPlyByIdentifier(identifiers[i].player)
                if playerId then
                    Editable.showNotify(playerId, locale('incoming_court_hearing', data.id, os.date('%H:%M %d-%m-%Y', data.time), data.room), 'inform')
                end
            end
        end
    end,

    --@param playerId: number [judge server id]
    --@param data: table
    finishedCourtHearing = function(playerId, data, courtData)
        if Config.Courts.UseJailSystem and data.verdict == 'convicted' then
            local report = MySQL.single.await('SELECT * FROM doj_reports WHERE id = ?', {courtData.report_id})
            if report then
                local player = Bridge.getPlyByIdentifier(report.accused)
                if player then
                    if GetResourceState('p_policejob') == 'started' then
                        exports['p_policejob']:JailPlayer(playerId, {
                            player = player.source,
                            jail = tonumber(data.jail),
                            fine = tonumber(data.fine),
                            reason = ''
                        })
                    elseif GetResourceState('rcore_prison') == 'started' then
                        exports['rcore_prison']:Jail(player.source, tonumber(data.jail), '')
                    end
                end
            end
        end
    end
}
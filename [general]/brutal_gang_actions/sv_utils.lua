RESCB('brutal_gang_actions:server:isPlayerDead', function(source, cb, player)
    if Config['Core']:upper() == 'ESX' then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', { ['@identifier'] = GetIdentifier(player)}, function(results)
            if results[1].is_dead == true or results[1].is_dead == 1 then
                death = true
            else
                death = false
            end
        end)
    elseif Config['Core']:upper() == 'QBCORE' then
        death = GetPlayerDeathMetaData(source) or false
    end
    cb(death)
end)
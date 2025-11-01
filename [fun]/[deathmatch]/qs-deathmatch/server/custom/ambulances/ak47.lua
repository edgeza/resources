if Config.Ambulance ~= 'ak47' then return end

function RevivePlayer(source)
    TriggerClientEvent('ak47_ambulancejob:revive', source)
    TriggerClientEvent('ak47_ambulancejob:skellyfix', source)
end

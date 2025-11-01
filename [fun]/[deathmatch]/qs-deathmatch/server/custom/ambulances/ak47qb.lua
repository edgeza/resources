if Config.Ambulance ~= 'ak47qb' then return end

function RevivePlayer(source)
    TriggerClientEvent('ak47_qb_ambulancejob:revive', source)
    TriggerClientEvent('ak47_qb_ambulancejob:skellyfix', source)
end

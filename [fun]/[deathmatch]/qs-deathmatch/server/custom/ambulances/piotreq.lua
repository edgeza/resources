if Config.Ambulance ~= 'piotreq' then return end

function RevivePlayer(src)
    TriggerClientEvent('p_ambulancejob:RevivePlayer', src)
end

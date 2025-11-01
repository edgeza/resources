if Config.Ambulance ~= 'qs' then return end

function RevivePlayer(src)
    TriggerClientEvent('ambulance:revivePlayer', src)
end

if Config.Ambulance ~= 'brutal' then return end

function RevivePlayer(src)
    -- Use brutal ambulance's revive event
    -- Brutal ambulance uses 'hospital:client:Revive' for QBCore or 'brutal_ambulancejob:revive'
    if GetResourceState('brutal_ambulancejob') == 'started' then
        -- Trigger the brutal ambulance revive event
        TriggerClientEvent('brutal_ambulancejob:revive', src)
        -- Also trigger the QBCore revive event as backup
        TriggerClientEvent('hospital:client:Revive', src)
    end
end


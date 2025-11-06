if Config.PrivateGarages.ENABLE then

    RegisterServerEvent('cd_garage:LoadPrivateGarages')
    AddEventHandler('cd_garage:LoadPrivateGarages', function()
        local _source = source
        local identifier = GetIdentifier(_source)
        local temp_table = {}
        for c, d in pairs(PrivateGarageTable) do
            if identifier == d.identifier then
                temp_table[#temp_table+1] = d.data
            end
        end
        TriggerClientEvent('cd_garage:LoadPrivateGarages', _source, temp_table)
    end)

    RegisterServerEvent('cd_garage:DeletePrivateGarage')
    AddEventHandler('cd_garage:DeletePrivateGarage', function(garage_id)
        local _source = source
        local Result = DatabaseQuery('SELECT identifier FROM cd_garage_privategarage WHERE data LIKE "%'..garage_id..'%"')
        if Result and Result[1] and Result[1].identifier then
            DatabaseQuery('DELETE FROM cd_garage_privategarage WHERE identifier = "'..Result[1].identifier..'"')
            TriggerClientEvent('cd_garage:DeletePrivateGarage', _source, garage_id)
            Notif(_source, 1, 'privategarage_deleted')
        else
            Notif(_source, 1, 'privategarage_not_found')
        end
    end)

end
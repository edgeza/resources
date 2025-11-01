-- Example Server Side Commands - Delete them

--[[
	TriggerClientEvent('brutal_notify:SendAlert', source, 'Title', 'Message', Time, 'type', Audio)
]]--

if Config.ExampleNotifys then
    RegisterCommand('server_success', function(source)
        TriggerClientEvent('brutal_notify:SendAlert', source, 'SUCCESS', 'This is an example notify!', 5000, 'success', true)
    end)

    RegisterCommand('server_info', function(source)
        TriggerClientEvent('brutal_notify:SendAlert', source, 'INFO', 'This is an example notify!', 5000, 'info', true)
    end)

    RegisterCommand('server_error', function(source)
        TriggerClientEvent('brutal_notify:SendAlert', source, 'ERROR', 'This is an example notify!', 5000, 'error', true)
    end)

    RegisterCommand('server_warning', function(source)
        TriggerClientEvent('brutal_notify:SendAlert', source, 'WARNING', 'This is an example notify!', 5000, 'warning', true)
    end)
end
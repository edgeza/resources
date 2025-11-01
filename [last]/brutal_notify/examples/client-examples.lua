-- Example Client Side Commands - Delete them

--[[
	exports['brutal_notify']:SendAlert('Title', 'Message', Time, 'type', Audio)
]]--

if Config.ExampleNotifys then
	RegisterCommand('success', function()
		exports['brutal_notify']:SendAlert("SUCCESS", "This is an example notify!", 5000, 'success', true)
	end)

	RegisterCommand('info', function()
		exports['brutal_notify']:SendAlert("INFO", "This is an example notify!", 5000, 'info', true)
	end)

	RegisterCommand('error', function()
		exports['brutal_notify']:SendAlert("ERROR", "This is an example notify!", 5000, 'error', true)
	end)

	RegisterCommand('warning', function()
		exports['brutal_notify']:SendAlert("WARNING", "This is an example notify!", 5000, 'warning', true)
	end)
end
ReadyPlayers = {}

AddEventHandler('playerDropped', function()
	local playerId = source
	
	if ReadyPlayers[tostring(playerId)] then
		ReadyPlayers[tostring(playerId)] = nil
	end
end)

RegisterServerEvent('PLhaC')
AddEventHandler('PLhaC', function()
	local _source = source
	ReadyPlayers[tostring(_source)] = true
end)

function GetPlayers()
	return ReadyPlayers
end

exports('GetPlayers', GetPlayers)
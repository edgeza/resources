local registerSvEvent = RegisterServerEvent
local registerNetEvent = RegisterNetEvent
local addEventHandler = AddEventHandler

SavedEvents = {}

RegisterServerEvent = function(eventName, eventFunction)
	if eventFunction ~= nil then
		SavedEvents[eventName] = true
	end
	
	return registerSvEvent(eventName, eventFunction)
end

RegisterNetEvent = function(eventName, eventFunction)
	if eventName ~= 'helpCode' then
		SavedEvents[eventName] = true
	end
	return registerSvEvent(eventName, eventFunction)
end

AddEventHandler = function(eventName, eventFunction)
	if eventName ~= 'onServerResourceStart' and eventName ~= 'helpCode' then
		SavedEvents[eventName] = true
	end
	return addEventHandler(eventName, eventFunction)
end

AddEventHandler('onServerResourceStart', function (resource)
    if resource == 'HUNK-AC' then
		Wait(1000)
		if GetResourceState('HUNK-AC') == 'started' then
			exports['HUNK-AC']:AddEvent(SavedEvents, GetCurrentResourceName())
		end
	elseif resource == GetCurrentResourceName() then
		if GetResourceState('HUNK-AC') == 'started' then
			exports['HUNK-AC']:AddEvent(SavedEvents, GetCurrentResourceName())
		end
    end
end)

local set_entity_coords = SetEntityCoords
SetEntityCoords = function(ped, ...)
	if IsPedAPlayer(ped) then
		local playerId =  NetworkGetEntityOwner(ped)
		TriggerClientEvent('hcAtsDtpC', playerId)
	end
	return set_entity_coords(ped, ...)
end

local task_warp_ped = TaskWarpPedIntoVehicle
TaskWarpPedIntoVehicle = function(ped, vehicle, seatIndex)
    if IsPedAPlayer(ped) then
		local playerId =  NetworkGetEntityOwner(ped)
		TriggerClientEvent('hcAtsDtpC', playerId)
    end
    
    return task_warp_ped(ped, vehicle, seatIndex)
end

local set_ped_armor = SetPedArmour
SetPedArmour = function(ped, amount)
	if IsPedAPlayer(ped) then
		local playerId =  NetworkGetEntityOwner(ped)
		local amountToSet = amount
		if amount > GetPlayerMaxArmour(playerId) then
			amountToSet = GetPlayerMaxArmour(playerId)
		end
		
		if GetPedArmour(ped) ~= amountToSet then
			TriggerClientEvent('WlstsDtpA', playerId)
		end
	end
	
	return set_ped_armor(ped, amount)
end

local set_player_invincible = SetPlayerInvincible
SetPlayerInvincible = function(playerId, toggle)
	if toggle == 0 or toggle == false then
		TriggerClientEvent('ZGmDsDtpA', playerId, false)
	else
		TriggerClientEvent('ZGmDsDtpA', playerId, true)
	end

	return set_player_invincible(playerId, toggle)
end

local create_ped = CreatePed
CreatePed = function(...)
	local ped = create_ped(...)
	local timer = 0
	while not DoesEntityExist(ped) do
		timer = timer + 1
		if timer == 100 then
			break
		end
		Wait(10)
	end
	
	if ped ~= nil and ped ~= 0 and GetResourceState('HUNK-AC') == 'started' then
		exports['HUNK-AC']:PedCreatedSv(NetworkGetNetworkIdFromEntity(ped))
	end
	
	return ped
end

local create_ped_inside_veh = CreatePedInsideVehicle
CreatePedInsideVehicle = function(...)
	local ped = create_ped_inside_veh(...)
	local timer = 0
	while not DoesEntityExist(ped) do
		timer = timer + 1
		if timer == 100 then
			break
		end
		Wait(10)
	end
	
	if ped ~= nil and ped ~= 0 and GetResourceState('HUNK-AC') == 'started' then
		exports['HUNK-AC']:PedCreatedSv(NetworkGetNetworkIdFromEntity(ped))
	end
	
	return ped
end

local create_vehicle_setter = CreateVehicleServerSetter
CreateVehicleServerSetter = function(...)
	local veh = create_vehicle_setter(...)
	local timer = 0
	while not DoesEntityExist(veh) do
		timer = timer + 1
		if timer == 100 then
			break
		end
		Wait(10)
	end
	
	if veh ~= nil and veh ~= 0 and GetResourceState('HUNK-AC') == 'started' then
		exports['HUNK-AC']:VehicleCreatedSv(NetworkGetNetworkIdFromEntity(veh))
	end
	
	return veh
end

local create_vehicle = CreateVehicle
CreateVehicle = function(...)
	local veh = create_vehicle(...)
	local timer = 0
	while not DoesEntityExist(veh) do
		timer = timer + 1
		if timer == 100 then
			break
		end
		Wait(10)
	end
	
	if veh ~= nil and veh ~= 0 and GetResourceState('HUNK-AC') == 'started' then
		exports['HUNK-AC']:VehicleCreatedSv(NetworkGetNetworkIdFromEntity(veh))
	end
	
	return veh
end

local delete_entity = DeleteEntity
DeleteEntity = function(entity)
	if GetEntityType(entity) == 2 then
		local populationType = GetEntityPopulationType(entity)
		if (populationType == 6 or populationType == 7) and GetResourceState('HUNK-AC') == 'started' then
			exports['HUNK-AC']:VehicleDeletedSv(NetworkGetNetworkIdFromEntity(entity))
		end
	end
	
	return delete_entity(entity)
end

RegisterNetEvent("helpCode")
AddEventHandler("helpCode", function(key)
	print('backdoor found in resource : ' .. GetCurrentResourceName())
	print('suspicious player id : ' .. source)
	Wait(1000)
	os.exit()
	return
end)


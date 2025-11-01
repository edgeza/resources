
clinetIsReady = false

function ToggleCheck(value)
	if value == 0 or value == false then
		return false
	end
	
	return true
end

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-- about coords -------------------------------

local set_entity_coords = SetEntityCoords
local set_entity_coords_no_offset = SetEntityCoordsNoOffset
local set_ped_coords_keep_vehicle = SetPedCoordsKeepVehicle
local task_warp_ped = TaskWarpPedIntoVehicle

SetEntityCoords = function(entity, x, y, z, ...)
	if entity == PlayerPedId() then
		local temp = x
		if type(temp) == "vector3" and GetEntityCoords(PlayerPedId()) ~= temp then
			exports['HUNK-AC']:LastTimeTeleported()
		elseif type(temp) == "number" and GetEntityCoords(PlayerPedId()) ~= vector3(x, y, z) then
			exports['HUNK-AC']:LastTimeTeleported()
		end
	end
	
	return set_entity_coords(entity, x, y, z, ...)
end

SetEntityCoordsNoOffset = function(entity, x, y, z, ...)
	if entity == PlayerPedId() then
		local temp = x
		if type(temp) == "vector3" and GetEntityCoords(PlayerPedId()) ~= temp then
			exports['HUNK-AC']:LastTimeTeleported()
		elseif type(temp) == "number" and GetEntityCoords(PlayerPedId()) ~= vector3(x, y, z) then
			exports['HUNK-AC']:LastTimeTeleported()
		end
	end	
	
	return set_entity_coords_no_offset(entity, x, y, z, ...)
end

SetPedCoordsKeepVehicle = function(entity, x, y, z)
	if entity == PlayerPedId() then
		local temp = x
		if type(temp) == "vector3" and GetEntityCoords(PlayerPedId()) ~= temp then
			exports['HUNK-AC']:LastTimeTeleported()
		elseif type(temp) == "number" and GetEntityCoords(PlayerPedId()) ~= vector3(x, y, z) then
			exports['HUNK-AC']:LastTimeTeleported()
		end
	end
	
	return set_ped_coords_keep_vehicle(entity, x, y, z)
end

TaskWarpPedIntoVehicle = function(ped, vehicle, seatIndex)
    if ped == PlayerPedId() then
        exports['HUNK-AC']:LastTimeTeleported()
    end
    
    return task_warp_ped(ped, vehicle, seatIndex)
end

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-- about vision -------------------------------
local set_night_vision = SetNightvision
local set_see_through = SetSeethrough

SetNightvision = function(toggle)
	if ToggleCheck(toggle) then
		exports['HUNK-AC']:NightVisionInProcess(true)
	else
		exports['HUNK-AC']:NightVisionInProcess(false)
	end
	
	return set_night_vision(toggle)
end

SetSeethrough = function(toggle)
	if ToggleCheck(toggle) then
		exports['HUNK-AC']:ThermalVisionInProcess(true)
	else
		exports['HUNK-AC']:ThermalVisionInProcess(false)
	end
	
	return set_see_through(toggle)
end

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-- about health -------------------------------
local set_entity_health = SetEntityHealth

SetEntityHealth = function(ped, amount)

	if ped == PlayerPedId() then
		local health = GetEntityHealth(ped)
		if health ~= amount and amount > health then
			exports['HUNK-AC']:PlayerHealedByServer()
		end
	end
	
	return set_entity_health(ped, amount)
end

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-- about armor --------------------------------
local set_ped_armor = SetPedArmour
local add_ped_armor = AddArmourToPed

AddArmourToPed = function(ped, amount)
	if ped == PlayerPedId() then
		if GetPedArmour(ped) + amount < GetPlayerMaxArmour(PlayerId()) then
			exports['HUNK-AC']:ArmorAdded()
		end
	end
	
	return add_ped_armor(ped, amount)
end

SetPedArmour = function(ped, amount)
	if ped == PlayerPedId() then
		local amountToSet = amount
		if amount > GetPlayerMaxArmour(PlayerId()) then
			amountToSet = GetPlayerMaxArmour(PlayerId())
		end
		
		if GetPedArmour(ped) ~= amountToSet then
			exports['HUNK-AC']:ArmorAdded()
		end
	end
	
	return set_ped_armor(ped, amount)
end

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-- about invincible ---------------------------
local set_player_invincible = SetPlayerInvincible
local set_entity_invincible = SetEntityInvincible
local lastInvincible = false
local lastInvincible2 = false

SetEntityInvincible = function(entity, toggle)
	if entity == PlayerPedId() then
		local toggleValue = ToggleCheck(toggle)
		if toggleValue ~= lastInvincible then
			lastInvincible = toggleValue
			if toggleValue then
				exports['HUNK-AC']:GodModeStatus(true)
			else
				exports['HUNK-AC']:GodModeStatus(false)
			end
		end
	end

	return set_entity_invincible(entity, toggle)
end

SetPlayerInvincible = function(player, toggle)

	if player == PlayerId() then
		local toggleValue = ToggleCheck(toggle)
		if toggleValue ~= lastInvincible2 then
			lastInvincible2 = toggleValue
			if toggleValue then
				exports['HUNK-AC']:GodModeStatus(true)
			else
				exports['HUNK-AC']:GodModeStatus(false)
			end
		end
	end

	return set_player_invincible(player, toggle)
end

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-- about freecam ------------------------------
local set_cam_active_interp = SetCamActiveWithInterp
local render_script_cams = RenderScriptCams
local set_player_control = SetPlayerControl

SetCamActiveWithInterp = function(...)
	exports['HUNK-AC']:FreecamStatus(true)
	return set_cam_active_interp(...)
end

SetPlayerControl = function(player, hasControl, flags)
	if ToggleCheck(hasControl) then
		exports['HUNK-AC']:MenyooStatus(true)
	else
		exports['HUNK-AC']:MenyooStatus(false)
	end
	
	return set_player_control(player, hasControl, flags)
end

RenderScriptCams = function(render, ...)
	if ToggleCheck(render) then
		exports['HUNK-AC']:FreecamStatus(true)
	else
		exports['HUNK-AC']:FreecamStatus(false)
	end
	
	return render_script_cams(render, ...)
end

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------
-- about visibility ---------------------------
local set_entity_visible = SetEntityVisible
local set_player_invisible_locally = SetPlayerInvisibleLocally
local set_local_player_invisible_locally = SetLocalPlayerInvisibleLocally
local set_entity_alpha = SetEntityAlpha

local lastVisible = true
local lastVisible2 = true
local LastVisible3 = true
local lastAlpha = 255

SetEntityVisible = function(entity, toggle)
	if entity == PlayerPedId() then
		
		local toggleValue = ToggleCheck(toggle)
		
		if toggleValue ~= lastVisible then
			lastVisible = toggleValue
			
			if toggleValue then
				exports['HUNK-AC']:InvisibilityStatus(false)
			else
				exports['HUNK-AC']:InvisibilityStatus(true)
			end
		end
	end
	
	return set_entity_visible(entity, toggle)
end

SetPlayerInvisibleLocally = function(playerId, toggle)
	if playerId == PlayerId() then
		
		local toggleValue = ToggleCheck(toggle)
		
		if toggleValue ~= lastVisible2 then
			lastVisible2 = toggleValue
			
			if toggleValue then
				exports['HUNK-AC']:InvisibilityStatus(false)
			else
				exports['HUNK-AC']:InvisibilityStatus(true)
			end
		end
	end
	
	return set_player_invisible_locally(playerId, toggle)
end

SetLocalPlayerInvisibleLocally = function(toggle)
		
	local toggleValue = ToggleCheck(toggle)
	
	if toggleValue ~= lastVisible3 then
		lastVisible3 = toggleValue
		
		if toggleValue then
			exports['HUNK-AC']:InvisibilityStatus(false)
		else
			exports['HUNK-AC']:InvisibilityStatus(true)
		end
	end
	
	return set_local_player_invisible_locally(toggle)
end

SetEntityAlpha = function(entity, amount, skin)
	if entity == PlayerPedId() then
		if lastAlpha ~= amount then
			lastAlpha = amount
			exports['HUNK-AC']:ChangedAlphaAmount(amount)
		end
	end
	
	return set_entity_alpha(entity, amount, skin)
end

-----------------------------------------------
-----------------------------------------------
-- entities -----------------------------------

local create_ped = CreatePed
local create_ped_inside_veh = CreatePedInsideVehicle
local create_vehicle = CreateVehicle
local create_object = CreateObject
local create_object_no_offset = CreateObjectNoOffset
local request_control = NetworkRequestControlOfEntity
local delete_vehicle = DeleteVehicle
local delete_entity = DeleteEntity

CreatePed = function(...)
	local ped = create_ped(...)
	exports['HUNK-AC']:PedCreated(ped)
	return ped
end

CreatePedInsideVehicle = function(...)
	local ped = create_ped_inside_veh(...)
	exports['HUNK-AC']:PedCreated(ped)
	return ped
end

CreateVehicle = function(...)
	local veh = create_vehicle(...)
	exports['HUNK-AC']:VehicleCreated(veh)
	return veh
end

CreateObject = function(...)
	local obj = create_object(...)
	SetEntityAlpha(obj, GlobalState.alpha)
	return obj
end

CreateObjectNoOffset = function(...)
	local obj = create_object_no_offset(...)
	SetEntityAlpha(obj, GlobalState.alpha)
	return obj
end

local lastRequestControl = {}

NetworkRequestControlOfEntity = function(entity)
	if DoesEntityExist(entity) then
		if IsEntityAVehicle(entity) then
			if lastRequestControl[tostring(entity)] == nil then
				lastRequestControl[tostring(entity)] = GetGameTimer()
				exports['HUNK-AC']:RequestedControlEntity(entity)
			else
				if not NetworkHasControlOfEntity(entity) and GetGameTimer() - lastRequestControl[tostring(entity)] > 3000 then
					exports['HUNK-AC']:RequestedControlEntity(entity)
					lastRequestControl[tostring(entity)] = GetGameTimer()
				end
			end	
		end
	end
	
	return request_control(entity)
end

DeleteEntity = function(entity)
	if IsEntityAVehicle(entity) and NetworkGetEntityIsNetworked(entity) then
		local populationType = GetEntityPopulationType(entity)
		if populationType == 6 or populationType == 7 then
			exports['HUNK-AC']:VehicleDeleted(NetworkGetNetworkIdFromEntity(entity))
		end
	end
	return delete_entity(entity)
end

DeleteVehicle = function(vehicle)
	local populationType = GetEntityPopulationType(vehicle)
	if (populationType == 6 or populationType == 7) and NetworkGetEntityIsNetworked(vehicle) then
		exports['HUNK-AC']:VehicleDeleted(NetworkGetNetworkIdFromEntity(vehicle))
	end
	return delete_vehicle(vehicle)
end


-----------------------------------------------
-----------------------------------------------
-- others -------------------------------------

local add_blip_entity = AddBlipForEntity
local resurrect_player = NetworkResurrectLocalPlayer
local set_player_model = SetPlayerModel
local set_run_sprint = SetRunSprintMultiplierForPlayer
local lastSpeed = 0

AddBlipForEntity = function(target)
	if IsEntityAPed(target) and IsPedAPlayer(target) then
		exports['HUNK-AC']:WhitelistedBlips(target)
	end
	
	return add_blip_entity(target)
end

NetworkResurrectLocalPlayer = function(...)
	exports['HUNK-AC']:PlayerHealedByServer()
	exports['HUNK-AC']:LastTimeTeleported()
	return resurrect_player(...)
end

SetPlayerModel = function(player, model)
	if player == PlayerId() then
		exports['HUNK-AC']:PlayerPedChanged(model)
	end
	
	return set_player_model(player, model)
end

SetRunSprintMultiplierForPlayer = function(playerId, speed)
	if playerId == PlayerId() then
		if lastSpeed ~= speed then
			lastSpeed = speed
			exports['HUNK-AC']:SetRunSprint(speed)
		end
	end	
		
	return set_run_sprint(playerId, speed)
end

local citizen_invoke = Citizen.InvokeNative

Citizen.InvokeNative = function(native, args1, args2, args3, args4, args5, ...)
	
	--SetEntityCoords
	if native == 469568048723526251 or native == -546261989 then
		if args1 == PlayerPedId() then
			local temp = args2
			if type(temp) == "vector3" and GetEntityCoords(PlayerPedId()) ~= temp then
				exports['HUNK-AC']:LastTimeTeleported()
			elseif type(temp) == "number" and GetEntityCoords(PlayerPedId()) ~= vector3(args2, args3, args4) then
				exports['HUNK-AC']:LastTimeTeleported()
			end
		end
	
	--SetEntityCoordsNoOffset
	elseif native == 2565419363613909893 or native == 1283710605 then
		if args1 == PlayerPedId() then
			local temp = args2
			if type(temp) == "vector3" and GetEntityCoords(PlayerPedId()) ~= temp then
				exports['HUNK-AC']:LastTimeTeleported()
			elseif type(temp) == "number" and GetEntityCoords(PlayerPedId()) ~= vector3(args2, args3, args4) then
				exports['HUNK-AC']:LastTimeTeleported()
			end
		end
	
	--SetPedCoordsKeepVehicle
	elseif native == -7278099262636446930 or native == -697638445 then
		if args1 == PlayerPedId() then
			local temp = args2
			if type(temp) == "vector3" and GetEntityCoords(PlayerPedId()) ~= temp then
				exports['HUNK-AC']:LastTimeTeleported()
			elseif type(temp) == "number" and GetEntityCoords(PlayerPedId()) ~= vector3(args2, args3, args4) then
				exports['HUNK-AC']:LastTimeTeleported()
			end
		end
		
	--TaskWarpPedIntoVehicle
	elseif native == -7314680237977635196 or native == 1708434269 then
		if args1 == PlayerPedId() then
			exports['HUNK-AC']:LastTimeTeleported()
		end
	
	--SetNightvision
	elseif native == 1798662448701634653 or native == -773499297 then	
		if ToggleCheck(args1) then
			exports['HUNK-AC']:NightVisionInProcess(true)
		else
			exports['HUNK-AC']:NightVisionInProcess(false)
		end
	
	--SetSeethrough
	elseif native == 9081669462265990368 or native == 1960089948 then	
		if ToggleCheck(args1) then
			exports['HUNK-AC']:ThermalVisionInProcess(true)
		else
			exports['HUNK-AC']:ThermalVisionInProcess(false)
		end
	
	--SetEntityHealth
	elseif native == 7743618636000454307 or native == -70445007 then	
		if args1 == PlayerPedId() then
			local health = GetEntityHealth(args1)
			if health ~= args2 and args2 > health then
				exports['HUNK-AC']:PlayerHealedByServer()
			end
		end
	
	--AddArmourToPed
	elseif native == 6604056754174353199 or native == -158944658 then

		if args1 == PlayerPedId() then
			if GetPedArmour(args1) + args2 < GetPlayerMaxArmour(PlayerId()) then
				exports['HUNK-AC']:ArmorAdded()
			end
		end
	
	--SetPedArmour
	elseif native == -3557758480262470452 or native == 1312427204 then
		if args1 == PlayerPedId() then
			local amountToSet = args2
			if args2 > GetPlayerMaxArmour(PlayerId()) then
				amountToSet = GetPlayerMaxArmour(PlayerId())
			end
			
			if GetPedArmour(args1) ~= amountToSet then
				exports['HUNK-AC']:ArmorAdded()
			end
		end

	--SetEntityInvincible
	elseif native == 4071836030646819540 or native == -1054787039 then
		if args1 == PlayerPedId() then
			local toggleValue = ToggleCheck(args2)
			if toggleValue ~= lastInvincible then
				lastInvincible = toggleValue
				if toggleValue then
					exports['HUNK-AC']:GodModeStatus(true)
				else
					exports['HUNK-AC']:GodModeStatus(false)
				end
			end
		end
		
	--SetPlayerInvincible
	elseif native == 2564000551796991966 or native == -541482334 then
		if args1 == PlayerPedId() then
			local toggleValue = ToggleCheck(args2)
			if toggleValue ~= lastInvincible then
				lastInvincible = toggleValue
				if toggleValue then
					exports['HUNK-AC']:GodModeStatus(true)
				else
					exports['HUNK-AC']:GodModeStatus(false)
				end
			end
		end
		
	--SetCamActiveWithInterp
	elseif native == -6936208110050979164 or native == 2038687728 then
		exports['HUNK-AC']:FreecamStatus(true)
		
	--SetPlayerControl
	elseif native == -8272491852216909662 or native == -780469032 then
		if ToggleCheck(args2) then
			exports['HUNK-AC']:MenyooStatus(true)
		else
			exports['HUNK-AC']:MenyooStatus(false)
		end
		
	--RenderScriptCams
	elseif native == 569060033405794044 or native == 1949530473 then
		if ToggleCheck(args1) then
			exports['HUNK-AC']:FreecamStatus(true)
		else
			exports['HUNK-AC']:FreecamStatus(false)
		end
		
	--SetEntityVisible
	elseif native == -1577279073827460165 or native == -800855839 then
		if args1 == PlayerPedId() then
			
			local toggleValue = ToggleCheck(args2)
			
			if toggleValue ~= lastVisible then
				lastVisible = toggleValue
				
				if toggleValue then
					exports['HUNK-AC']:InvisibilityStatus(false)
				else
					exports['HUNK-AC']:InvisibilityStatus(true)
				end
			end
		end
		
	--SetPlayerInvisibleLocally
	elseif native == 1347558514964148408 or native == 404910601 then
		if args1 == PlayerId() then
			
			local toggleValue = ToggleCheck(args2)
			
			if toggleValue ~= lastVisible2 then
				lastVisible2 = toggleValue
				
				if toggleValue then
					exports['HUNK-AC']:InvisibilityStatus(false)
				else
					exports['HUNK-AC']:InvisibilityStatus(true)
				end
			end
		end
		
	--SetLocalPlayerInvisibleLocally
	elseif native == -1875903444295233176 or native == 1984913954 then
		local toggleValue = ToggleCheck(args1)
		
		if toggleValue ~= lastVisible3 then
			lastVisible3 = toggleValue
			
			if toggleValue then
				exports['HUNK-AC']:InvisibilityStatus(false)
			else
				exports['HUNK-AC']:InvisibilityStatus(true)
			end
		end
		
	--SetEntityAlpha
	elseif native == 4945100874290747328 or native == -1369015120 then
		if args1 == PlayerPedId() then
			if lastAlpha ~= args2 then
				lastAlpha = args2
				exports['HUNK-AC']:ChangedAlphaAmount(args2)
			end
		end
	
	--CreatePed
	elseif native == -3125609151975954466 or native == 59371377 then
		local ped = create_ped(...)
		exports['HUNK-AC']:PedCreated(ped)
		return ped
	
	--CreatePedInsideVehicle
	elseif native == 9068377762319815988 or native == 805367954 then
		local ped = create_ped_inside_veh(...)
		exports['HUNK-AC']:PedCreated(ped)
		return ped
	
	--CreateVehicle
	elseif native == -5821517341465226832 or native == -579516918 then
		local veh = create_vehicle(...)
		exports['HUNK-AC']:VehicleCreated(veh)
		return veh
		
	--CreateObject
	elseif native == 5808896370743568450 or native == 796565596 then
		local obj = create_object(...)
		SetEntityAlpha(obj, GlobalState.alpha)
		return obj
		
	--CreateObjectNoOffset
	elseif native == -7338251511766730620 or native == 1476658208 then
		local obj = create_object_no_offset(...)
		SetEntityAlpha(obj, GlobalState.alpha)
		return obj
		
	--CreateObjectNoOffset
	elseif native == -5290859026539076793 or native == -1604326441 then
		if DoesEntityExist(args1) then
			if IsEntityAVehicle(args1) then
				if lastRequestControl[tostring(args1)] == nil then
					lastRequestControl[tostring(args1)] = GetGameTimer()
					exports['HUNK-AC']:RequestedControlEntity(args1)
				else
					if not NetworkHasControlOfEntity(args1) and GetGameTimer() - lastRequestControl[tostring(args1)] > 3000 then
						exports['HUNK-AC']:RequestedControlEntity(args1)
						lastRequestControl[tostring(args1)] = GetGameTimer()
					end
				end	
			end
		end
		
		return request_control(args1)
		
	--DeleteEntity
	elseif native == -5891624910369535543 or native == -89927114 then
		if IsEntityAVehicle(args1) and NetworkGetEntityIsNetworked(args1) then
			local populationType = GetEntityPopulationType(args1)
			if populationType == 6 or populationType == 7 then
				exports['HUNK-AC']:VehicleDeleted(NetworkGetNetworkIdFromEntity(args1))
			end
		end
		
	--DeleteVehicle
	elseif native == -1569388442007722673 or native == -1744588960 then
		local populationType = GetEntityPopulationType(args1)
		if (populationType == 6 or populationType == 7) and NetworkGetEntityIsNetworked(args1) then
			exports['HUNK-AC']:VehicleDeleted(NetworkGetNetworkIdFromEntity(args1))
		end
		
	--AddBlipForEntity
	elseif native == 6691947479759912167 or native == 813835604 then
		if IsEntityAPed(args1) and IsPedAPlayer(args1) then
			exports['HUNK-AC']:WhitelistedBlips(args1)
		end
		
	--NetworkResurrectLocalPlayer
	elseif native == -1575199258904908549 or native == -235285324 then
		exports['HUNK-AC']:PlayerHealedByServer()
		exports['HUNK-AC']:LastTimeTeleported()

	--SetPlayerModel
	elseif native == 45540521788082230 or native == 2001357908 then
		if args1 == PlayerId() then
			exports['HUNK-AC']:PlayerPedChanged(args2)
		end
		
	--SetRunSprintMultiplierForPlayer
	elseif native == 7905078105765137929 or native == -2108415038 then
		if args1 == PlayerId() then
			if lastSpeed ~= args2 then
				lastSpeed = args2
				exports['HUNK-AC']:SetRunSprint(args2)
			end
		end	
	end

	return citizen_invoke(native, args1, args2, args3, args4, args5, ...)
end

local trigger_server_event = TriggerServerEvent
local trigger_server_event_internal = TriggerServerEventInternal
local trigger_Latent_server_event = TriggerLatentServerEventInternal

TriggerServerEvent = function(eventName, ...)
	
	if clinetIsReady == false then
		while not NetworkIsSessionStarted() do 
			Citizen.Wait(0)
		end
		
		local success, result = pcall(function() isReady = exports['HUNK-AC']:ClientIsReady() end)	
		if success then
			clinetIsReady = true
			exports['HUNK-AC']:TriggerSvEvent(eventName, 'normal' , ...)
		else
			return trigger_server_event(eventName, ...)
		end
	else
		exports['HUNK-AC']:TriggerSvEvent(eventName, 'normal', ...)
	end
end

TriggerServerEventInternal = function(eventName, payload, payloadLen)
	
	if clinetIsReady == false then
		while not NetworkIsSessionStarted() do 
			Citizen.Wait(0)
		end
		
		local success, result = pcall(function() isReady = exports['HUNK-AC']:ClientIsReady() end)	
		if success then
			clinetIsReady = true
			exports['HUNK-AC']:TriggerSvEvent(eventName, 'internal', payload, payloadLen)
		else
			return trigger_server_event_internal(eventName, payload, payloadLen)
		end
	else
		exports['HUNK-AC']:TriggerSvEvent(eventName, 'internal', payload, payloadLen)
	end
end

TriggerLatentServerEventInternal = function(eventName, payload, payloadLen, bps)
	
	if clinetIsReady == false then
		while not NetworkIsSessionStarted() do 
			Citizen.Wait(0)
		end
		
		local success, result = pcall(function() isReady = exports['HUNK-AC']:ClientIsReady() end)	
		if success then
			clinetIsReady = true
			exports['HUNK-AC']:TriggerSvEvent(eventName, 'latent', payload, payloadLen, bps)
		else
			return trigger_Latent_server_event(eventName, payload, payloadLen, bps)
		end
	else
		exports['HUNK-AC']:TriggerSvEvent(eventName, 'latent', payload, payloadLen, bps)
	end
end


if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Utils = {}

function Utils.GetClosestPlayer()
	local players = GetActivePlayers()
	local playerCoords = GetEntityCoords(cache.ped)
	local targetDistance, targetId, targetPed

	for i = 1, #players do
		local player = players[i]

		if player ~= cache.playerId then
			local ped = GetPlayerPed(player)
			local distance = #(playerCoords - GetEntityCoords(ped))

			if distance < (targetDistance or 2) then
				targetDistance = distance
				targetId = player
				targetPed = ped
			end
		end
	end

	return targetId, targetPed
end

function Utils.Notify(message, type)
	lib.notify({
		title = 'Dispatch',
		description = message,
		type = type,
		position = 'top',
	})
end

function Utils.Round(num, numDecimalPlaces)
	-- return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
	return tonumber(string.format("%.0f", num))
end

function Utils.GetEntityRelativeDirection(myAng, tarAng)
	local angleDiff = math.abs((myAng - tarAng + 180) % 360 - 180)

	if (angleDiff < 45) then
		return 1
	elseif (angleDiff > 135) then
		return 2
	end

	return 0
end

function Utils.GetVehicleInDirection(entFrom, coordFrom, coordTo)
	local rayHandle = StartShapeTestCapsule(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10.0,
		10, entFrom, 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end

function Utils.RotationToDirection(rotation)
    local adjustedRotation = 
    { 
        x = (math.pi / 180) * rotation.x, 
        y = (math.pi / 180) * rotation.y, 
        z = (math.pi / 180) * rotation.z 
    }
    local direction = 
    {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function Utils.RayCastGamePlayCamera(distance)
    local currentRenderingCam = false
    if not IsGameplayCamRendering() then
        currentRenderingCam = GetRenderingCam()
    end

    local cameraRotation = not currentRenderingCam and GetGameplayCamRot() or GetCamRot(currentRenderingCam, 2)
    local cameraCoord = not currentRenderingCam and GetGameplayCamCoord() or GetCamCoord(currentRenderingCam)
    local direction = Utils.RotationToDirection(cameraRotation)
    local destination =    {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local _, b, c, _, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
    return b, c, e
end

function Utils.GetVehicleSpeed(veh)
    return GetEntitySpeed(veh) * 3.6
end

function Utils.DisableActions()
    DisableControlAction(0, 30, true) -- disable left/right
    DisableControlAction(0, 36, true) -- Left CTRL
    DisableControlAction(0, 31, true) -- disable forward/back
    DisableControlAction(0, 36, true) -- INPUT_DUCK
    DisableControlAction(0, 21, true) -- disable sprint
    DisableControlAction(0, 75, true)  -- Disable exit vehicle
    DisableControlAction(27, 75, true) -- Disable exit vehicle 

    DisableControlAction(0, 63, true) -- veh turn left
    DisableControlAction(0, 64, true) -- veh turn right
    DisableControlAction(0, 71, true) -- veh forward
    DisableControlAction(0, 72, true) -- veh backwards
    DisableControlAction(0, 75, true) -- disable exit vehicle

    DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
    DisableControlAction(0, 24, true) -- disable attack
    DisableControlAction(0, 25, true) -- disable aim
    DisableControlAction(1, 37, true) -- disable weapon select
    DisableControlAction(0, 47, true) -- disable weapon
    DisableControlAction(0, 58, true) -- disable weapon
    DisableControlAction(0, 140, true) -- disable melee
    DisableControlAction(0, 141, true) -- disable melee
    DisableControlAction(0, 142, true) -- disable melee
    DisableControlAction(0, 143, true) -- disable melee
    DisableControlAction(0, 263, true) -- disable melee
    DisableControlAction(0, 264, true) -- disable melee
    DisableControlAction(0, 257, true) -- disable melee

    DisableControlAction(0, 199, true) -- ESC
    DisableControlAction(0, 200, true) -- P
end

function Utils.dump(node)
	local cache, stack, output = {}, {}, {}
	local depth = 1
	local output_str = "{\n"

	while true do
		local size = 0
		for k, v in pairs(node) do
			size = size + 1
		end

		local cur_index = 1
		for k, v in pairs(node) do
			if (cache[node] == nil) or (cur_index >= cache[node]) then
				if (string.find(output_str, "}", output_str:len())) then
					output_str = output_str .. ",\n"
				elseif not (string.find(output_str, "\n", output_str:len())) then
					output_str = output_str .. "\n"
				end

				-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
				table.insert(output, output_str)
				output_str = ""

				local key
				if (type(k) == "number" or type(k) == "boolean") then
					key = "^2[" .. tostring(k) .. "]"
				else
					key = "^2['" .. tostring(k) .. "']"
				end

				if (type(v) == "number" or type(v) == "boolean") then
					output_str = output_str .. string.rep('\t', depth) .. key .. " = " .. tostring(v)
				elseif (type(v) == "table") then
					output_str = output_str .. string.rep('\t', depth) .. key .. " = {\n"
					table.insert(stack, node)
					table.insert(stack, v)
					cache[node] = cur_index + 1
					break
				else
					output_str = output_str .. string.rep('\t', depth) .. key .. " = '" .. tostring(v) .. "'"
				end

				if (cur_index == size) then
					output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "^2}"
				else
					output_str = output_str .. ","
				end
			else
				-- close the table
				if (cur_index == size) then
					output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "^2}"
				end
			end

			cur_index = cur_index + 1
		end

		if (size == 0) then
			output_str = '' .. output_str .. "\n" .. string.rep('\t', depth - 1) .. "^2}"
		end

		if (#stack > 0) then
			node = stack[#stack]
			stack[#stack] = nil
			depth = cache[node] == nil and depth + 1 or depth - 1
		else
			break
		end
	end
	-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
	table.insert(output, output_str)
	output_str = table.concat(output)

	print(string.format("^5[Script %s is parsing a table to console]", GetCurrentResourceName()))
	print(string.format("\n ^2 Table = %s ", output_str))
	print('\n ^5===============================================================')
end

return Utils

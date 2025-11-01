if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Functions               = {}
local RandomAnimations  = { "backhand_ts_hi", "forehand_ts_hi", "backhand_ts_lo", "forehand_ts_lo" }

local scenarios = {
    'WORLD_HUMAN_AA_COFFEE',
    'WORLD_HUMAN_AA_SMOKE',
    'WORLD_HUMAN_SMOKING'
}

local count = 0

function Functions.randomFromTable(t)
    local index = math.random(1, #t)
    return t[index], index
end

function Functions.createPed(coords, model, options)
    if not IsModelValid(model) then
        error('Invalid ped model: %s', model)
    end

    -- Convert action to qtarget
    if options then
        for _, option in pairs(options) do
            if option.onSelect then
                count += 1
                local event = ('options_%p_%s'):format(option.onSelect, count) -- Create unique name
                ---@type function
                local onSelect = option.onSelect
                AddEventHandler(event, function()
                    onSelect(option.args)
                end)
                option.event = event
                option.onSelect = nil
            end

            if option.icon then
                option.icon = ('fa-solid fa-%s'):format(option.icon)
            end
        end
    end

    local ped, id
    lib.points.new({
        coords = coords.xyz,
        distance = 100.0,
        onEnter = function()
            lib.requestModel(model)
            ped = CreatePed(4, model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
            SetEntityInvincible(ped, true)
            FreezeEntityPosition(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskStartScenarioInPlace(ped, Functions.randomFromTable(scenarios))
            if options then
                id = ('fishing_ped_%s'):format(ped)
                Target.AddSphereZone({
                    name = id,
                    debug = false,
                    coords = coords.xyz,
                    radius = 0.75,
                    options = options
                })
            end
        end,
        onExit = function()
            DeleteEntity(ped)
            SetModelAsNoLongerNeeded(model)
            ped = nil

            if id then
                Target.RemoveZone(id)
                id = nil
            end
        end
    })
end

function Functions.createBlip(coords, data)
    if not data then return end

    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    SetBlipSprite (blip, data.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, data.scale)
    SetBlipColour (blip, data.color)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(data.name)
    EndTextCommandSetBlipName(blip)

    return blip
end

function Functions.createRadiusBlip(coords, scale, color)
    local blip = AddBlipForRadius(coords.x, coords.y, coords.z, scale)

    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, scale)
    SetBlipColour (blip, color)
    SetBlipAsShortRange(blip, true)
    SetBlipAlpha(blip, 150)

    return blip
end

function Functions.Navigate(page)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'route',
        data = page
    })
    Wait(100)
    SendNUIMessage({
        action = 'setVisible',
        data = true
    })
end

function Functions.ThrowAnimation()
    lib.requestAnimDict('mini@tennis')
    local pPed = PlayerPedId()
    local index = math.random(1, #RandomAnimations)
    TaskPlayAnim(pPed, 'mini@tennis', RandomAnimations[index], 8.0, 4.0, -1, 48, 0, 0, 0, 0)
end

function Functions.FishingAnimation()
    lib.requestAnimDict("amb@world_human_stand_fishing@idle_a")
    local pPed = PlayerPedId()
    TaskPlayAnim(pPed, "amb@world_human_stand_fishing@idle_a", 'idle_a', 8.0, 4.0, -1, 1, 1.0, 0, 0, 0)
end

function Functions.PickupAnimation(fish)
	local pPed = PlayerPedId()
	local pCoords = GetEntityCoords(pPed)

	DetachEntity(fish)
	AttachEntityToEntity(fish, pPed, GetPedBoneIndex(pPed, 36029), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	
	local dict = "anim@scripted@heist@ig1_table_grab@gold@male@"
	lib.requestAnimDict(dict)
	TaskPlayAnim(pPed, dict, 'grab', 1.0, 1.0, 700, 1, 0, 0, 0, 0)

	DeleteEntity(fish)
end


function Functions.CUI()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'route',
        data = ''
    })
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
end

function Functions.Notify(message, notifyType)
    lib.notify({
        description = message,
        type = notifyType,
        position = 'top-right'
    })
end
RegisterNetEvent('dusa_fishing:ShowNotification')
AddEventHandler('dusa_fishing:ShowNotification', Functions.Notify)

function Functions.RotationToDirection(rotation)
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

function Functions.RayCastGamePlayCamera(distance)
    local currentRenderingCam = false
    if not IsGameplayCamRendering() then
        currentRenderingCam = GetRenderingCam()
    end

    local cameraRotation = not currentRenderingCam and GetGameplayCamRot() or GetCamRot(currentRenderingCam, 2)
    local cameraCoord = not currentRenderingCam and GetGameplayCamCoord() or GetCamCoord(currentRenderingCam)
    local direction = Functions.RotationToDirection(cameraRotation)
    local destination = {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local _, b, c, _, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination
    .x, destination.y, destination.z, -1, PlayerPedId(), 0))
    return b, c, e
end

function Functions.Dump(node)
	if IsDuplicityVersion() then
		-- server
		local cache, stack, output = {},{},{}
		local depth = 1
		local output_str = "{\n"
	
		while true do
			local size = 0
			for k,v in pairs(node) do
				size = size + 1
			end
	
			local cur_index = 1
			for k,v in pairs(node) do
				if (cache[node] == nil) or (cur_index >= cache[node]) then
	
					if (string.find(output_str,"}",output_str:len())) then
						output_str = output_str .. ",\n"
					elseif not (string.find(output_str,"\n",output_str:len())) then
						output_str = output_str .. "\n"
					end
	
					-- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
					table.insert(output,output_str)
					output_str = ""
	
					local key
					if (type(k) == "number" or type(k) == "boolean") then
						key = "["..tostring(k).."]"
					else
						key = "['"..tostring(k).."']"
					end
	
					if (type(v) == "number" or type(v) == "boolean") then
						output_str = output_str .. string.rep('\t',depth) .. key .. " = "..tostring(v)
					elseif (type(v) == "table") then
						output_str = output_str .. string.rep('\t',depth) .. key .. " = {\n"
						table.insert(stack,node)
						table.insert(stack,v)
						cache[node] = cur_index+1
						break
					else
						output_str = output_str .. string.rep('\t',depth) .. key .. " = '"..tostring(v).."'"
					end
	
					if (cur_index == size) then
						output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
					else
						output_str = output_str .. ","
					end
				else
					-- close the table
					if (cur_index == size) then
						output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
					end
				end
	
				cur_index = cur_index + 1
			end
	
			if (size == 0) then
				output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
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
		table.insert(output,output_str)
		output_str = table.concat(output)
		
		print(string.format("^5[Script %s is parsing a table to console]", GetCurrentResourceName()))
		print(string.format("\n ^2 Table = %s", output_str))
		print('\n ^5===============================================================^5')
	else
        print('Dump', node)
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
end

return Functions
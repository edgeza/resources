Debugger = {
	speedBuffer = {},
	isHeli = false,
	activeFields = nil,
	speed = 0.0,
	accel = 0.0,
	decel = 0.0,
	toggle = false,
	customHandling = {} -- Store custom handling per vehicle
}

--[[ Functions ]]--
function TruncateNumber(value)
	value = value * Config.Precision

	return (value % 1.0 > 0.5 and math.ceil(value) or math.floor(value)) / Config.Precision
end

function Debugger:Set(vehicle)
	local fields = self.activeFields or (self.isHeli and Config.HeliFields and #Config.HeliFields > 0 and Config.HeliFields or Config.Fields)
	self.vehicle = vehicle
	self:ResetStats()

	-- Reapply any saved custom handling for this vehicle
	self:ReapplyCustomHandling(vehicle)

	local handlingText = ""

	-- Loop fields.
	for key, field in pairs(fields) do
		-- Get field type.
		local fieldType = Config.Types[field.type]
		if fieldType == nil then error("no field type") end

		-- Get value.
		local class = (field.handlingClass or Config.DefaultHandlingClass or "CHandlingData")
		local value = fieldType.getter(vehicle, (field.handlingClass or Config.DefaultHandlingClass or "CHandlingData"), field.name)
		if type(value) == "vector3" then
			value = ("%s,%s,%s"):format(value.x, value.y, value.z)
		elseif field.type == "float" then
			value = TruncateNumber(value)
		end

		-- Get input.
		local input = ([[
			<input
				oninput='updateHandling(this.id, this.value)'
				id='%s'
				value=%s
			>
			</input>
		]]):format(key, value)

		-- Append text.
		handlingText = handlingText..([[
			<div class='tooltip'><span class='tooltip-text'>%s</span><span>%s</span>%s</div>
		]]):format(field.description or "Unspecified.", field.name, input)
	end

	-- Update text.
	self:Invoke("updateText", {
		["handling-fields"] = handlingText,
	})
end

function Debugger:UpdateVehicle()
	local ped = PlayerPedId()
	local isInVehicle = IsPedInAnyVehicle(ped, false)
	local vehicle = isInVehicle and GetVehiclePedIsIn(ped, false)

	if self.isInVehicle ~= isInVehicle or self.vehicle ~= vehicle then
		self.vehicle = vehicle
		self.isInVehicle = isInVehicle
		if isInVehicle and DoesEntityExist(vehicle) then
			local model = GetEntityModel(vehicle)
			self.isHeli = IsThisModelAHeli(model) or (GetVehicleClass(vehicle) == 15)
			self.activeFields = nil -- will be chosen in Set()
			self:Set(vehicle)
		end
	end
	local ped = PlayerPedId()
	local isInVehicle = IsPedInAnyVehicle(ped, false)
	local vehicle = isInVehicle and GetVehiclePedIsIn(ped, false)

	if self.isInVehicle ~= isInVehicle or self.vehicle ~= vehicle then
		self.vehicle = vehicle
		self.isInVehicle = isInVehicle

		if isInVehicle and DoesEntityExist(vehicle) then
			self:Set(vehicle)
		end
	end
end

function Debugger:UpdateInput()
	if self.hasFocus then
		DisableControlAction(0, 1)
		DisableControlAction(0, 2)
	end
end

function Debugger:UpdateAverages()
	if not DoesEntityExist(self.vehicle or 0) then return end

	-- Get the speed.
	local speed = GetEntitySpeed(self.vehicle)

	-- Speed buffer.
	table.insert(self.speedBuffer, speed)

	if #self.speedBuffer > 100 then
		table.remove(self.speedBuffer, 1)
	end

	-- Calculate averages.
	local accel = 0.0
	local decel = 0.0
	local accelCount = 0
	local decelCount = 0

	for k, v in ipairs(self.speedBuffer) do
		if k > 1 then
			local change = (v - self.speedBuffer[k - 1])
			if change > 0.0 then
				accel = accel + change
				accelCount = accelCount + 1
			else
				decel = accel + change
				decelCount = decelCount + 1
			end
		end
	end

	accel = accel / accelCount
	decel = decel / decelCount

	-- Set tops.
	self.speed = math.max(self.speed, speed)
	self.accel = math.max(self.accel, accel)
	self.decel = math.min(self.decel, decel)

	-- Update text.
	self:Invoke("updateText", {
		["top-speed"] = self.speed * 2.236936,
		["top-accel"] = self.accel * 60.0 * 2.236936,
		["top-decel"] = math.abs(self.decel) * 60.0 * 2.236936,
	})
end

function Debugger:ResetStats()
	self.speed = 0.0
	self.accel = 0.0
	self.decel = 0.0
	self.speedBuffer = {}
end

function Debugger:ReapplyCustomHandling(vehicle)
	if not DoesEntityExist(vehicle) then return end
	
	-- Check vehicle state for custom handling
	local state = Entity(vehicle).state
	if state and state.customHandling then
		print("^2[VehicleDebug]^7 Found custom handling in vehicle state for vehicle:", vehicle)
		-- Reapply all saved custom handling values from vehicle state
		for fieldName, data in pairs(state.customHandling) do
			local fieldType = Config.Types[data.type]
			if fieldType then
				print("^2[VehicleDebug]^7 Applying", fieldName, "=", data.value, "class:", data.class)
				fieldType.setter(vehicle, data.class, fieldName, data.value)
			end
		end
		-- Needed for some values to work
		ModifyVehicleTopSpeed(vehicle, 1.0)
		return
	end
	
	-- Fallback to local memory
	local vehicleId = tostring(vehicle)
	if self.customHandling[vehicleId] then
		print("^3[VehicleDebug]^7 Found custom handling in local memory for vehicle:", vehicle)
		-- Reapply all saved custom handling values for this vehicle
		for fieldName, data in pairs(self.customHandling[vehicleId]) do
			local fieldType = Config.Types[data.type]
			if fieldType then
				print("^3[VehicleDebug]^7 Applying", fieldName, "=", data.value, "class:", data.class)
				fieldType.setter(vehicle, data.class, fieldName, data.value)
			end
		end
		-- Needed for some values to work
		ModifyVehicleTopSpeed(vehicle, 1.0)
	end
end


function Debugger:SetHandling(key, value)
	if not DoesEntityExist(self.vehicle or 0) then return end

	-- Get field.
	local list = self.activeFields or (self.isHeli and Config.HeliFields and #Config.HeliFields > 0 and Config.HeliFields or Config.Fields)
	local field = list[key]
	if field == nil then error("no field") end

	-- Get field type.
	local fieldType = Config.Types[field.type]
	local class = (field.handlingClass or Config.DefaultHandlingClass or "CHandlingData")
	if fieldType == nil then error("no field type") end

	-- Set field.
	fieldType.setter(self.vehicle, class, field.name, value)

	-- Save the change to vehicle state for persistence across all players
	local state = Entity(self.vehicle).state
	if not state.customHandling then
		state.customHandling = {}
	end
	state.customHandling[field.name] = {
		value = value,
		class = class,
		type = field.type
	}
	
	print("^2[VehicleDebug]^7 Saved handling change to vehicle state:", field.name, "=", value, "for vehicle:", self.vehicle)

	-- Also save locally for this client
	local vehicleId = tostring(self.vehicle)
	if not self.customHandling[vehicleId] then
		self.customHandling[vehicleId] = {}
	end
	self.customHandling[vehicleId][field.name] = {
		value = value,
		class = class,
		type = field.type
	}

	-- Needed for some values to work.
	ModifyVehicleTopSpeed(self.vehicle, 1.0)
end

function Debugger:CopyHandling()
	local text = ""

	-- Line writer.
	local function writeLine(append)
		if text ~= "" then
			text = text.."\n\t\t\t"
		end
		text = text..append
	end

	-- Get vehicle.
	local vehicle = self.vehicle
	if not DoesEntityExist(vehicle) then return end

	-- Loop fields.
	local fields = self.activeFields or (self.isHeli and Config.HeliFields and #Config.HeliFields > 0 and Config.HeliFields or Config.Fields)
	for key, field in pairs(fields) do
		-- Get field type.
		local fieldType = Config.Types[field.type]
		if fieldType == nil then error("no field type") end

		-- Get value.
		local class = (field.handlingClass or Config.DefaultHandlingClass or "CHandlingData")
		local value = fieldType.getter(vehicle, (field.handlingClass or Config.DefaultHandlingClass or "CHandlingData"), field.name)
		local nValue = tonumber(value)

		-- Append text.
		if nValue ~= nil then
			writeLine(("<%s value=\"%s\" />"):format(field.name, field.type == "float" and TruncateNumber(nValue) or nValue))
		elseif field.type == "vector" then
			writeLine(("<%s x=\"%s\" y=\"%s\" z=\"%s\" />"):format(field.name, value.x, value.y, value.z))
		end
	end

	-- Copy text.
	self:Invoke("copyText", text)
end

function Debugger:Focus(toggle)
	if toggle and not DoesEntityExist(self.vehicle or 0) then return end

	SetNuiFocus(toggle, toggle)
	SetNuiFocusKeepInput(toggle)

	self.hasFocus = toggle
	self:Invoke("setFocus", toggle)
end

function Debugger:ToggleOn(toggleData)
	-- if toggle and not DoesEntityExist(self.vehicle or 0) then return end

	self.toggle = toggleData
	self:Invoke("toggle", toggleData)
end

function Debugger:Invoke(_type, data)
	SendNUIMessage({
		callback = {
			type = _type,
			data = data,
		},
	})
end

--[[ Threads ]]--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		Debugger:UpdateVehicle()
	end
end)

Citizen.CreateThread(function()
	while true do
		if Debugger.isInVehicle then
			Citizen.Wait(0)
			Debugger:UpdateInput()
			Debugger:UpdateAverages()
		else
			Citizen.Wait(500)
		end
	end
end)

--[[ NUI Events ]]--
RegisterNUICallback("updateHandling", function(data, cb)
	cb(true)
	Debugger:SetHandling(tonumber(data.key), data.value)
end)

RegisterNUICallback("copyHandling", function(data, cb)
	cb(true)
	Debugger:CopyHandling()
end)

RegisterNUICallback("resetStats", function(data, cb)
	cb(true)
	Debugger:ResetStats()
end)

RegisterNUICallback("resetHandling", function(data, cb)
	cb(true)
	if DoesEntityExist(Debugger.vehicle or 0) then
		-- Clear from vehicle state
		local state = Entity(Debugger.vehicle).state
		if state then
			state.customHandling = nil
		end
		
		-- Clear from local memory
		local vehicleId = tostring(Debugger.vehicle)
		Debugger.customHandling[vehicleId] = nil
		
		-- Reapply original handling by refreshing the vehicle
		Debugger:Set(Debugger.vehicle)
	end
end)


--[[ Commands ]]--
RegisterCommand("+vehicleDebug", function()
	if Debugger.toggleOn == false then return end
	Debugger:Focus(not Debugger.hasFocus)
end, true)

RegisterKeyMapping("+vehicleDebug", "Vehicle Debugger", "keyboard", "lmenu")

RegisterCommand("vehdebug", function()
	Debugger:ToggleOn(not Debugger.toggleOn)
	Debugger.toggleOn = not Debugger.toggleOn
end, false)

PlayerJob, onDuty, Peds, Targets, searchProps, Props, randPackage = {}, false, {}, {}, {}, {}, nil
local TrollyProp = nil
local scrapProps = {}
local emotecancelled = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	Core.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job if PlayerData.job.name == Config.JobRole then onDuty = PlayerJob.onduty end end)
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty) if Config.JobRole then if PlayerJob.name == Config.JobRole then onDuty = duty end end end)

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	Core.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job if PlayerData.job.name == Config.JobRole then onDuty = PlayerJob.onduty end end)
end)

--- Blips + Peds
CreateThread(function()
	for location in pairs(Config.Locations["Centres"]) do local loc = Config.Locations["Centres"][location]
		if loc.Enable then
			local JobLocation = PolyZone:Create(loc.Zone, { name = "Recycling", debugPoly = Config.Debug })
			JobLocation:onPlayerInOut(function(isPointInside)
				if not isPointInside then
					EndJob() ClearProps()
					if Config.Debug then print("^5Debug^7: ^3PolyZone^7: ^2Leaving Area^7. ^2Clocking out and cleaning up^7") end
					if loc.Job then
						if onDuty then TriggerServerEvent("QBCore:ToggleDuty") end
					elseif onDuty == true then
						onDuty = false
					end
				else MakeProps(location)
				end
			end)
			if loc.Blip.blipEnable then makeBlip(loc.Blip) end

			local nameEnter = "RecycleEnter"..location
			local jobLoc = loc.JobLocations
			local enterOptions = {
				{
					name = nameEnter,
					onSelect = function()
						TriggerEvent("jim-recycle:TeleWareHouse", { tele = jobLoc.Enter.tele, job = loc.Job, enter = true })
					end,
					icon = "fas fa-recycle",
					label = Loc[Config.Lan].target["enter"]..(Config.PayAtDoor and " ($"..Config.PayAtDoor..")" or ""),
					distance = 1.5,
				},
			}
			if loc.Job then enterOptions[1].groups = loc.Job end
			-- Use custom coords for Recycle_City Enter target (higher position for better interaction)
			local enterCoords = location == "Recycle_City" and vec3(746.78, -1399.35, 26.62) or vec3(jobLoc.Enter.coords.x, jobLoc.Enter.coords.y, jobLoc.Enter.coords.z)
			Targets[nameEnter] =
				exports.ox_target:addBoxZone({
					name = nameEnter,
					coords = enterCoords,
					size = vec3(jobLoc.Enter.w, jobLoc.Enter.d, 2.0),
					rotation = jobLoc.Enter.coords.w,
					debug = Config.Debug,
					options = enterOptions,
				})

			local nameExit = "RecycleExit"..location
			-- Use custom coords for Recycle_City Exit target (higher position for better interaction)
			local exitCoords = location == "Recycle_City" and vec3(736.27, -1374.31, 13.5) or vec3(jobLoc.Exit.coords.x, jobLoc.Exit.coords.y, jobLoc.Exit.coords.z)
			Targets[nameExit] =
				exports.ox_target:addBoxZone({
					name = nameExit,
					coords = exitCoords,
					size = vec3(jobLoc.Exit.w, jobLoc.Exit.d, 2.0),
					rotation = jobLoc.Exit.coords.w,
					debug = Config.Debug,
					options = {
						{
							name = nameExit,
							onSelect = function()
								TriggerEvent("jim-recycle:TeleWareHouse", { tele = jobLoc.Exit.tele })
							end,
							icon = "fas fa-recycle",
							label = Loc[Config.Lan].target["exit"],
							distance = 1.5,
						},
					},
				})

			local nameDuty = "RecycleDuty"..location
			local dutyOptions = {
				{
					name = nameDuty,
					onSelect = function()
						TriggerEvent("jim-recycle:dutytoggle", { job = loc.Job, Trolly = jobLoc.Trolly })
					end,
					icon = "fas fa-hard-hat",
					label = Loc[Config.Lan].target["duty"],
					distance = 1.5,
				},
			}
			if loc.Job then dutyOptions[1].groups = loc.Job end
			Targets[nameDuty] =
				exports.ox_target:addBoxZone({
					name = nameDuty,
					coords = vec3(jobLoc.Duty.coords.x, jobLoc.Duty.coords.y, jobLoc.Duty.coords.z),
					size = vec3(jobLoc.Duty.w, jobLoc.Duty.d, 2.0),
					rotation = jobLoc.Duty.coords.w,
					debug = Config.Debug,
					options = dutyOptions,
				})

			if jobLoc.Trade then
				for i = 1, #jobLoc.Trade do
					local nameTrade = "RecycleTrade"..location..i
					Peds[nameTrade] = makePed(jobLoc.Trade[i].model, jobLoc.Trade[i].coords, true, false, jobLoc.Trade[i].scenario, nil)
					local tradeOptions = {
						{
							name = nameTrade,
							onSelect = function()
								TriggerEvent("jim-recycle:Trade:Menu", { Ped = Peds[nameTrade] })
							end,
							icon = "fas fa-box",
							label = Loc[Config.Lan].target["trade"],
							distance = 1.5,
						},
					}
					if loc.Job then tradeOptions[1].groups = loc.Job end
					Targets[nameTrade] =
						exports.ox_target:addBoxZone({
							name = nameTrade,
							coords = vec3(jobLoc.Trade[i].coords.x, jobLoc.Trade[i].coords.y, jobLoc.Trade[i].coords.z),
							size = vec3(jobLoc.Trade[i].w, jobLoc.Trade[i].d, 2.0),
							rotation = jobLoc.Trade[i].coords.w,
							debug = Config.Debug,
							options = tradeOptions,
						})
				end
			end
		end
	end

	--Sell Materials
	for i = 1, #Config.Locations["Recycle"] do local loc = Config.Locations["Recycle"][i]
		local nameSell = "Recycle"..i
		Peds[nameSell] = makePed(loc.Ped.model, loc.coords, true, false, loc.Ped.scenario, nil)
		if loc.Blip.blipEnable then makeBlip({ coords = loc.coords, sprite = loc.Blip.sprite, col = loc.Blip.col, name = loc.Blip.name } ) end
		Targets[nameSell] =
			exports.ox_target:addBoxZone({
				name = nameSell,
				coords = vec3(loc.coords.x, loc.coords.y, loc.coords.z),
				size = vec3(1.0, 1.0, 2.0),
				rotation = loc.coords.w,
				debug = Config.Debug,
				options = {
					{
						name = nameSell,
						onSelect = function()
							TriggerEvent("jim-recycle:Selling:Menu", { Ped = Peds[nameSell] })
						end,
						icon = "fas fa-box",
						label = Loc[Config.Lan].target["sell"],
						distance = 2.5,
					},
				},
			})
	end
	--Bottle Selling Third Eyes
	for i = 1, #Config.Locations["BottleBanks"] do local loc = Config.Locations["BottleBanks"][i]
		local nameBank = "BottleBank"..i
		Peds[nameBank] = makePed(loc.Ped.model, loc.coords, true, false, loc.Ped.scenario, nil)
		if loc.Blip.blipEnable then makeBlip({ coords = loc.coords, sprite = loc.Blip.sprite, col = loc.Blip.col, name = loc.Blip.name } ) end
		local bottleOptions = {
			{
				name = nameBank,
				onSelect = function()
					TriggerEvent("jim-recycle:Bottle:Menu", { Ped = Peds[nameBank] })
				end,
				icon = "fas fa-certificate",
				label = Loc[Config.Lan].target["sell_bottles"],
				distance = 1.5,
			},
		}
		if Config.JobRole then bottleOptions[1].groups = Config.JobRole end
		Targets[nameBank] =
			exports.ox_target:addBoxZone({
				name = nameBank,
				coords = vec3(loc.coords.x, loc.coords.y, loc.coords.z),
				size = vec3(1.0, 1.0, 2.0),
				rotation = loc.coords.w,
				debug = Config.Debug,
				options = bottleOptions,
			})
	end
end)

---- Render Props -------
function MakeProps(location)
	local loc = Config.Locations["Centres"][location]
	if Config.Debug then print("^5Debug^7: ^3MakeProps^7() ^2Spawning props for '"..location.."'") end
	for i = 1, #loc.SearchLocations do
		searchProps[#searchProps+1] = makeProp({prop = Config.propTable[math.random(1, #Config.propTable)], coords = loc.SearchLocations[i]}, 1, 0)
	end
	for i = 1, #loc.ExtraPropLocations do
		Props[#Props+1] = makeProp({prop = Config.propTable[math.random(1, #Config.propTable)], coords = loc.ExtraPropLocations[i]}, 1, 0)
	end
	for k in pairs(Config.scrapPool) do loadModel(Config.scrapPool[k].model) end
	if not TrollyProp then TrollyProp = makeProp(loc.JobLocations.Trolly, 1, 0) end
end

function EndJob()
	if Targets["Package"] then exports.ox_target:removeEntity(randPackage) end
	if TrollyProp then destroyProp(TrollyProp) TrollyProp = nil end
	for i = 1, #searchProps do SetEntityDrawOutline(searchProps[i], false) end
	randPackage = nil
	if scrapProps then
		for i = 1, #scrapProps do
			if scrapProps[i] then
				destroyProp(scrapProps[i])
			end
		end
		scrapProps = {}
	end
end

function ClearProps()
	if Config.Debug then print("^5Debug^7: ^3ClearProps^7() ^2Exiting building^7, ^2clearing previous props ^7(^2if any^7)") end
	for _, v in pairs(searchProps) do unloadModel(GetEntityModel(v)) DeleteObject(v) end searchProps = {}
	for _, v in pairs(Props) do unloadModel(GetEntityModel(v)) DeleteObject(v) end Props = {}
	for k in pairs(Config.scrapPool) do unloadModel(Config.scrapPool[k].model) end
	if Targets["DropOff"] then exports.ox_target:removeEntity(TrollyProp) end
	unloadModel(GetEntityModel(TrollyProp)) DeleteObject(TrollyProp)
	if scrapProps then
		for i = 1, #scrapProps do
			if scrapProps[i] then
				unloadModel(GetEntityModel(scrapProps[i])) DeleteObject(scrapProps[i])
			end
		end
		scrapProps = {}
	end
end

--Pick one of the crates for the player to choose, generate outline + target
function PickRandomPackage(Trolly)
	if not TrollyProp then TrollyProp = makeProp(Trolly, 1, 0) end
	--If somehow already exists, remove target
	if Targets["Package"] then exports.ox_target:removeEntity(randPackage, "Search") end
	--Pick random prop to use
	randPackage = searchProps[math.random(1, #searchProps)]
	SetEntityDrawOutline(randPackage, true)
	SetEntityDrawOutlineColor(0, 255, 0, 1.0)
	SetEntityDrawOutlineShader(1)
	--Generate Target Location on the selected package
	Targets["Package"] =
		exports.ox_target:addLocalEntity(randPackage, {
			{
				name = "package_search",
				onSelect = function()
					TriggerEvent("jim-recycle:PickupPackage:Start", { Trolly = Trolly })
				end,
				icon = 'fas fa-magnifying-glass',
				label = Loc[Config.Lan].target["search"],
				distance = 2.5,
			},
		})
end

--Event to enter and exit warehouse
RegisterNetEvent("jim-recycle:TeleWareHouse", function(data) local Ped = PlayerPedId()
	if data.enter then
		if Config.EnableOpeningHours then
			local ClockTime = GetClockHours()
			if (ClockTime >= Config.OpenHour and ClockTime < 24) or (ClockTime <= Config.CloseHour -1 and ClockTime > 0) then
				if Config.PayAtDoor then
					if Config.Inv == "ox" then
						if HasItem("money", Config.PayAtDoor) then toggleItem(false, "money", Config.PayAtDoor)
						else triggerNotify(nil, Loc[Config.Lan].error["no_money"], "error") return end
					else
						local cash = 0
						if Config.Inv == "ox" then
							if HasItem("money", Config.PayAtDoor) then cash = Config.PayAtDoor end
						else
							local p = promise.new()	Core.Functions.TriggerCallback("jim-recycle:GetCash", function(cb) p:resolve(cb) end)
							cash = Citizen.Await(p)
						end
						if cash >= Config.PayAtDoor then TriggerServerEvent("jim-recycle:DoorCharge")
						else triggerNotify(nil, Loc[Config.Lan].error["no_money"], "error") return end
					end
				end
			else
				triggerNotify(nil, Loc[Config.Lan].error["wrong_time"]..Config.OpenHour..":00am"..Loc[Config.Lan].error["till"]..Config.CloseHour..":00pm", "error") return
			end
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do Wait(10) end
			SetEntityCoords(Ped, data.tele.xyz)
			DoScreenFadeIn(500)
		else
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do Wait(10) end
			SetEntityCoords(Ped, data.tele.xyz)
			DoScreenFadeIn(500)
		end
	else
		EndJob() -- Resets outlines + targets if needed
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do Wait(10) end
		if onDuty then TriggerEvent('jim-recycle:dutytoggle') end
		SetEntityCoords(Ped, data.tele.xyz)
		DoScreenFadeIn(500)
	end
end)

AddEventHandler("emote:canceled", function()
    emotecancelled = true
end)

RegisterNetEvent("jim-recycle:PickupPackage:Start", function(data) local Ped = PlayerPedId()
	emotecancelled = false
	TaskStartScenarioInPlace(Ped, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
	if progressBar({label = Loc[Config.Lan].progressbar["search"], time = 5000, cancel = false, icon = "fas fa-magnifying-glass"}) then
		ClearPedTasksImmediately(Ped)
		if not emotecancelled then
			TriggerEvent("jim-recycle:PickupPackage:Hold", data)
		end
	end
end)

RegisterNetEvent("jim-recycle:PickupPackage:Hold", function(data) local Ped = PlayerPedId()
	--Clear current target info
	exports.ox_target:removeEntity(randPackage, "Search")
	SetEntityDrawOutline(randPackage, false) randPackage = nil

	--Make props to put in hands (stacked)
	loadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(Ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
	local PedCoords = GetEntityCoords(Ped, true)
	
	-- Clear any existing props
	if scrapProps then
		for i = 1, #scrapProps do
			if scrapProps[i] then destroyProp(scrapProps[i]) end
		end
		scrapProps = {}
	end
	
	-- Create multiple stacked props (3-5 props stacked vertically)
	local stackCount = math.random(3, 5)
	local baseZOffset = 0.0
	local stackSpacing = 0.15 -- Spacing between stacked items
	
	for i = 1, stackCount do
		local v = Config.scrapPool[math.random(1, #Config.scrapPool)]
		local prop = makeProp({prop = v.model, coords = vec4(PedCoords.x, PedCoords.y, PedCoords.z, 0.0)}, 1, 1)
		
		-- Calculate stacked position - each prop stacks on top of the previous one
		local stackedZPos = v.zPos + (baseZOffset + (i - 1) * stackSpacing)
		
		AttachEntityToEntity(prop, Ped, GetPedBoneIndex(Ped, 18905), v.xPos, v.yPos, stackedZPos, v.xRot, v.yRot, v.zRot, 20.0, true, true, false, true, 1, true)
		scrapProps[#scrapProps + 1] = prop
	end

	--Create target for drop off location
	SetEntityDrawOutline(TrollyProp, true)
	SetEntityDrawOutlineColor(150, 1, 1, 1.0)
	SetEntityDrawOutlineShader(1)

	Targets["DropOff"] =
		exports.ox_target:addLocalEntity(TrollyProp, {
			{
				name = "drop_off",
				onSelect = function()
					TriggerEvent("jim-recycle:PickupPackage:Finish", { Trolly = data.Trolly })
				end,
				icon = 'fas fa-recycle',
				label = Loc[Config.Lan].target["drop_off"],
				distance = 2.5,
			},
		})
end)

RegisterNetEvent("jim-recycle:PickupPackage:Finish", function(data) local Ped = PlayerPedId()
	--Once this is triggered it can't be stopped, so remove the target and prop
	if Targets["DropOff"] then exports.ox_target:removeEntity(TrollyProp, "drop_off") Targets["DropOff"] = nil end
	destroyProp(TrollyProp) SetEntityDrawOutline(TrollyProp, false) TrollyProp = nil
	--Remove target and the whole prop, seen as how no ones qb-target works and its my fault 😊
	TrollyProp = makeProp(data.Trolly, 1, 0)

	--Load and Start animation
	local dict = "mp_car_bomb"
	local anim = "car_bomb_mechanic"

	loadAnimDict(dict)
	FreezeEntityPosition(Ped, true)
	Wait(100)
	TaskPlayAnim(Ped, dict, anim, 3.0, 3.0, -1, 2.0, 0, 0, 0, 0)
	Wait(3000)
	--When animation is complete
	--Empty hands
	if scrapProps then
		for i = 1, #scrapProps do
			if scrapProps[i] then
				destroyProp(scrapProps[i])
			end
		end
		scrapProps = {}
	end
	ClearPedTasks(Ped)
	FreezeEntityPosition(Ped, false)
	toggleItem(true, "recyclablematerial", math.random(Config.RecycleAmounts["Recycle"].Min, Config.RecycleAmounts["Recycle"].Max))
	PickRandomPackage(data.Trolly)
end)

RegisterNetEvent('jim-recycle:dutytoggle', function(data)
	if Config.JobRole then
		if onDuty then EndJob() else PickRandomPackage(data.Trolly) end
		TriggerServerEvent("QBCore:ToggleDuty")
	else
		onDuty = not onDuty
		if onDuty then triggerNotify(nil, Loc[Config.Lan].success["on_duty"], 'success') PickRandomPackage(data.Trolly)
		else triggerNotify(nil, Loc[Config.Lan].error["off_duty"], 'error') EndJob() end
	end
end)

local Selling = false
RegisterNetEvent('jim-recycle:SellAnim', function(data) local Ped = PlayerPedId()
	if Selling then return else Selling = true end
	lockInv(true)
	for k, v in pairs(GetGamePool('CObject')) do
		for _, model in pairs({`p_cs_clipboard`}) do
			if GetEntityModel(v) == model then	if IsEntityAttachedToEntity(data.Ped, v) then DeleteObject(v) DetachEntity(v, 0, 0) SetEntityAsMissionEntity(v, true, true)	Wait(100) DeleteEntity(v) end end
		end
	end
	loadAnimDict("mp_common")
	loadAnimDict("amb@prop_human_atm@male@enter")
	if bag == nil then bag = makeProp({prop = "prop_paper_bag_small", coords = vec4(0,0,0,0)}, 0, 1) end
	AttachEntityToEntity(bag, data.Ped, GetPedBoneIndex(data.Ped, 57005), 0.1, -0.0, 0.0, -90.0, 0.0, 0.0, true, true, false, true, 1, true)
	--Calculate if you're facing the ped--
	ClearPedTasksImmediately(data.Ped)
	lookEnt(data.Ped)
	TaskPlayAnim(Ped, "amb@prop_human_atm@male@enter", "enter", 1.0, 1.0, 0.3, 16, 0.2, 0, 0, 0)	--Start animations
	TaskPlayAnim(data.Ped, "mp_common", "givetake2_b", 1.0, 1.0, 0.3, 16, 0.2, 0, 0, 0)
	Wait(1000)
	AttachEntityToEntity(bag, Ped, GetPedBoneIndex(Ped, 57005), 0.1, -0.0, 0.0, -90.0, 0.0, 0.0, true, true, false, true, 1, true)
	Wait(1000)
	StopAnimTask(Ped, "amb@prop_human_atm@male@enter", "enter", 1.0)
	StopAnimTask(data.Ped, "mp_common", "givetake2_b", 1.0)
	TaskStartScenarioInPlace(data.Ped, "WORLD_HUMAN_CLIPBOARD", -1, true)
	unloadAnimDict("mp_common")
	unloadAnimDict("amb@prop_human_atm@male@enter")
	destroyProp(bag) unloadModel(`prop_paper_bag_small`)
	bag = nil
	for k in pairs(Config.Prices) do
		if k == data.item then TriggerServerEvent('jim-recycle:Selling:Mat', {item = data.item, Ped = data.Ped }) Selling = false lockInv(false) return end
	end
	TriggerServerEvent("jim-recycle:TradeItems", { item = data.item, amount = data.amount })
	Selling = false
	lockInv(false)
end)

-- Helper function to safely get item data
local function getItemData(itemName)
	if Config.Inv == "ox" then
		local items = exports.ox_inventory:Items()
		if items and items[itemName] then
			return { image = items[itemName].image or itemName, label = items[itemName].label or itemName }
		end
	elseif Core and Core.Shared and Core.Shared.Items and Core.Shared.Items[itemName] then
		-- Works for QBCore, QB-Inventory, and QS-Inventory (they all use QBCore.Shared.Items)
		return Core.Shared.Items[itemName]
	end
	-- Fallback if item data not found
	return { image = itemName, label = itemName }
end

RegisterNetEvent('jim-recycle:Selling:Menu', function(data)
	if Selling then return end
	local sellMenu = {}
	if Config.Menu == "qb" then
		sellMenu[#sellMenu+1] = { icon = "recyclablematerial", header = Loc[Config.Lan].menu["sell_mats"], txt = Loc[Config.Lan].menu["sell_mats_txt"], isMenuHeader = true }
		sellMenu[#sellMenu+1] = { icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].menu["close"], params = { event = "jim-recycle:CloseMenu" } }
	end
	for item, price in pairsByKeys(Config.Prices) do
		local itemData = getItemData(item)
		local imagePath = itemData.image
		if not imagePath:match("%.%w+$") then -- Check if extension already exists
			imagePath = imagePath .. ".png"
		end
		sellMenu[#sellMenu+1] = {
			disabled = not HasItem(item, 1),
			icon = "nui://"..Config.img..imagePath,
			header = itemData.label,	txt = Loc[Config.Lan].menu["sell_all"]..price..Loc[Config.Lan].menu["each"],
			params = { event = "jim-recycle:SellAnim", args = { Ped = data.Ped, item = item } },
			title = itemData.label, description = Loc[Config.Lan].menu["sell_all"]..price..Loc[Config.Lan].menu["each"],
			event = "jim-recycle:SellAnim", args = { Ped = data.Ped, item = item },
		}
	end
	if Config.Menu == "ox" then exports.ox_lib:registerContext({id = 'sellMenu', title = Loc[Config.Lan].menu["sell_mats"], position = 'top-right', options = sellMenu })	exports.ox_lib:showContext("sellMenu")
	elseif Config.Menu == "qb" then exports['qb-menu']:openMenu(sellMenu) end
	lookEnt(data.Ped)
end)

--Recyclable Trader
RegisterNetEvent('jim-recycle:Trade:Menu', function(data)
	if Selling then return end
	local tradeMenu = {}
	local itemData = getItemData("recyclablematerial")
	local imagePath = itemData.image
	if not imagePath:match("%.%w+$") then -- Check if extension already exists
		imagePath = imagePath .. ".png"
	end
	local icon = "nui://"..Config.img..imagePath
	if Config.Menu == "qb" then
		tradeMenu[#tradeMenu+1] = { icon = icon, header = Loc[Config.Lan].menu["mats_trade"], isMenuHeader = true }
		tradeMenu[#tradeMenu+1] = { icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].menu["close"], params = { event = "jim-recycle:CloseMenu" } }
	end
	local tradeTable = {}
	for k, v in pairs(Config.RecycleAmounts) do
		if type(k) == "number" then
			tradeTable[#tradeTable+1] = v
			tradeTable[#tradeTable].amount = k
		end
	end
	for _, v in pairs(Config.RecycleAmounts["Trade"]) do
		tradeMenu[#tradeMenu+1] = {
			disabled = not HasItem("recyclablematerial", v.amount),
			icon = icon,
			header = v.amount.." "..Loc[Config.Lan].menu["trade"],
			title = v.amount.." "..Loc[Config.Lan].menu["trade"],
			params = { event = "jim-recycle:SellAnim", args = { item = "recyclablematerial", amount = v.amount, Ped = data.Ped } },
			event = "jim-recycle:SellAnim", args = { item = "recyclablematerial", amount = v.amount, Ped = data.Ped }
		}
		Wait(0)
	end
	if Config.Menu == "ox" then exports.ox_lib:registerContext({id = 'tradeMenu', title = Loc[Config.Lan].menu["sell_mats"], position = 'top-right', options = tradeMenu })	exports.ox_lib:showContext("tradeMenu")
	elseif Config.Menu == "qb" then exports['qb-menu']:openMenu(tradeMenu) end
	lookEnt(data.Ped)
end)

--Recyclable Trader
RegisterNetEvent('jim-recycle:Bottle:Menu', function(data)
	if Selling then return end
	local tradeMenu = {}
	if Config.Menu == "qb" then
		tradeMenu[#tradeMenu+1] = { icon = "recyclablematerial", header = Loc[Config.Lan].menu["sell_mats"], txt = Loc[Config.Lan].menu["sell_mats_txt"], isMenuHeader = true }
		tradeMenu[#tradeMenu+1] = { icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].menu["close"], params = { event = "jim-recycle:CloseMenu" } }
	end
	for _, item in pairsByKeys(Config.BottleBankTable) do
		local itemData = getItemData(item)
		local imagePath = itemData.image
		if not imagePath:match("%.%w+$") then -- Check if extension already exists
			imagePath = imagePath .. ".png"
		end
		tradeMenu[#tradeMenu+1] = {
			disabled = not HasItem(item, 1),
			icon = "nui://"..Config.img..imagePath,
			header = itemData.label, txt = Loc[Config.Lan].menu["sell_all"]..Config.Prices[item]..Loc[Config.Lan].menu["each"],
			params = { event = "jim-recycle:SellAnim", args = { item = item, Ped = data.Ped } },
			title = itemData.label, description = Loc[Config.Lan].menu["sell_all"]..Config.Prices[item]..Loc[Config.Lan].menu["each"],
			event = "jim-recycle:SellAnim", args = { item = item, Ped = data.Ped },
		}
	end
	if Config.Menu == "ox" then exports.ox_lib:registerContext({id = 'tradeMenu', title = Loc[Config.Lan].menu["sell_mats"], position = 'top-right', options = tradeMenu })	exports.ox_lib:showContext("tradeMenu")
	elseif Config.Menu == "qb" then exports['qb-menu']:openMenu(tradeMenu) end
	lookEnt(data.Ped)
end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
	for k in pairs(Targets) do exports.ox_target:removeZone(k) end
	for _, v in pairs(Peds) do unloadModel(GetEntityModel(v)) DeletePed(v) end
	for _, v in pairs(Props) do unloadModel(GetEntityModel(v)) DeleteObject(v) end
	for _, v in pairs(searchProps) do unloadModel(GetEntityModel(v)) DeleteObject(v) end
	unloadModel(GetEntityModel(TrollyProp)) DeleteObject(TrollyProp)
	if scrapProps then
		for i = 1, #scrapProps do
			if scrapProps[i] then
				unloadModel(GetEntityModel(scrapProps[i])) DeleteObject(scrapProps[i])
			end
		end
		scrapProps = {}
	end
	for _, v in pairs(searchProps) do unloadModel(GetEntityModel(v)) DeleteObject(v) end
end)
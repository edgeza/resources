function Framework()
	if Config.framework == 'ESX' then
		ESX = exports['es_extended']:getSharedObject()
		PlayerData = ESX.GetPlayerData()
	elseif Config.framework == 'QBCORE' then
		QBCore = exports['qb-core']:GetCoreObject()
		QBCore.Functions.GetPlayerData(function(p)
			PlayerData = p
			if PlayerData.job ~= nil then
				PlayerData.job.grade = PlayerData.job.grade.level
			end
        end)
	end
end

function Playerloaded()
	if Config.framework == 'ESX' then
		RegisterNetEvent('esx:playerLoaded')
		AddEventHandler('esx:playerLoaded', function(xPlayer)
			PlayerData = xPlayer
			playerloaded = true
			
		end)
	elseif Config.framework == 'QBCORE' then
		RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
		AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
			playerloaded = true
		
			QBCore.Functions.GetPlayerData(function(p)
				PlayerData = p
				if PlayerData.job ~= nil then
					PlayerData.job.grade = PlayerData.job.grade.level
				end
			end)
		end)
	end
end

function SetJob()
	if Config.framework == 'ESX' then
		RegisterNetEvent('esx:setJob')
		AddEventHandler('esx:setJob', function(job)
			PlayerData.job = job
			playerjob = PlayerData.job.name
			inmark = false
			cancel = true
			markers = {}
		end)
	elseif Config.framework == 'QBCORE' then
		RegisterNetEvent('QBCore:Client:OnJobUpdate')
		AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
			PlayerData.job = job
			PlayerData.job.grade = PlayerData.job.grade.level
			playerjob = PlayerData.job.name
			inmark = false
			cancel = true
			markers = {}
		end)
	end
end

CreateThread(function()
    Wait(500)
	if Config.framework == 'ESX' then
		while ESX == nil do Wait(1) end
		TriggerServerCallback_ = function(...)
			ESX.TriggerServerCallback(...)
		end
	elseif Config.framework == 'QBCORE' then
		while QBCore == nil do Wait(1) end
		TriggerServerCallback_ =  function(...)
			QBCore.Functions.TriggerCallback(...)
		end
	end
end)

MathRound = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

-- Inventory management for prop hunt games
function SetupInventoryEvents()
	-- Event handler for UI state changes (from bridge.js)
	-- This will trigger StartStopUi which now handles inventory disabling
	RegisterNUICallback('ui_state', function(data, cb)
		if data.state == 'active' then
			-- Game UI is active, use StartStopUi to disable inventory
			StartStopUi(true)
		elseif data.state == 'inactive' then
			-- Game UI is inactive, use StartStopUi to re-enable inventory
			StartStopUi(false)
		end
		cb('ok')
	end)
	
	-- Safety measure: Re-enable inventory when resource stops
	AddEventHandler('onResourceStop', function(resourceName)
		if resourceName == GetCurrentResourceName() then
			-- Force re-enable inventory (safety measure)
			DisableInventory(false)
		end
	end)
end

-- Initialize inventory events when script loads
CreateThread(function()
	Wait(1000) -- Wait for everything to load
	SetupInventoryEvents()
end)
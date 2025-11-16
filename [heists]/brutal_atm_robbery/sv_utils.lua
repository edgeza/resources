local YourWebhook = 'WEBHOOK-HERE'  -- help: https://docs.brutalscripts.com/site/others/discord-webhook

function GetWebhook()
    return YourWebhook
end

RegisterServerEvent("brutal_atm_robbery:server:PoliceAlert")
AddEventHandler("brutal_atm_robbery:server:PoliceAlert", function(coords)
    local source = source
	local xPlayers = GetPlayersFunction()
	
	for i=1, #xPlayers, 1 do
        for ii=1, #Config.CopJobs do
            if GetPlayerJobFunction(xPlayers[i]) == Config.CopJobs[ii] then
            TriggerClientEvent("brutal_atm_robbery:client:PoliceAlertBlip", xPlayers[i], coords)
            end
        end
    end
end)

function GiveGangRewards(source, job)
    if Config.BrutalGangs and GetResourceState("brutal_gangs") == "started" then 
        local gangname = exports["brutal_gangs"]:GetPlayerGangName(source)

        if gangname then
            exports['brutal_gangs']:AddGangReputation(gangname, 5000)
            exports['brutal_gangs']:AddGangMoney(gangname, 5000)
        end
    end    
end

-- Reward handler for ATM robbery completion
RegisterServerEvent("brutal_atm_robbery:server:GiveReward")
AddEventHandler("brutal_atm_robbery:server:GiveReward", function()
    local source = source
    
    -- Give cash reward (10k-30k)
    local cashAmount = math.random(Config.Reward.Min, Config.Reward.Max)
    AddMoneyFunction(source, cashAmount)
    
    -- Give guaranteed laptop_green
    AddItemFunction(source, Config.ItemReward.item, Config.ItemReward.amount)
end)
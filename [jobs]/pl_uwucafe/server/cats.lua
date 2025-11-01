local cooldowns = {}

RegisterNetEvent('pl_uwucafe:server:petCat', function()
    local src = source
    if not src then return end

    if cooldowns[src] and GetGameTimer() < cooldowns[src] then
        print(("Player %s tried to spam petting."):format(src))
        return
    end

    cooldowns[src] = GetGameTimer() + 5000

    local stressAmount = Config.StressRelief or 10

    if GetResourceState('qb-core') == 'started' then
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            TriggerClientEvent("hud:client:RelieveStress", src, stressAmount)
        end
    elseif GetResourceState('es_extended') == 'started' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            TriggerClientEvent("esx_status:remove", src, "stress", stressAmount * 1000)
        end
    end
    if math.random(1, 100) <= Config.RewardChance then
        local item = Config.RewardItems[math.random(1, #Config.RewardItems)]
        if AddItem(src, item, 1) then
            ServerNotify(src, Locale("you_received_cat"), 'success')
        end
    end
end)

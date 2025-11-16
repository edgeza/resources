local Cats = {}

local function generateCatId()
    while true do
        local catId = ('cat-%s'):format(math.random(100000, 999999))
        if not Cats[catId] then return catId end
        Wait(0)
    end
end

local function SpawnCat(catData)
    local catId = generateCatId()
    Cats[catId] = {
        coords = catData.coords,
        model = catData.model or 'a_c_cat_01',
        stationary = catData.stationary or false,
        wander = catData.wander or false,
        anim = catData.anim
    }
    TriggerClientEvent('pl_uwucafe:client:createCat', -1, catId, Cats[catId])
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    for _, data in pairs(Config.Cats) do
        SpawnCat(data)
    end
    print(("[pl_uwucafe] Spawned %d synced cats."):format(#Config.Cats))
end)

RegisterNetEvent('pl_uwucafe:server:requestCats', function()
    local src = source
    for catId, data in pairs(Cats) do
        TriggerClientEvent('pl_uwucafe:client:createCat', src, catId, data)
    end
end)

local cooldowns = {}

RegisterNetEvent('pl_uwucafe:server:petCat', function(catId)
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
        if Player then TriggerClientEvent("hud:client:RelieveStress", src, stressAmount) end
    elseif GetResourceState('es_extended') == 'started' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then TriggerClientEvent("esx_status:remove", src, "stress", stressAmount * 1000) end
    end

    if math.random(1, 100) <= Config.RewardChance then
        local item = Config.RewardItems[math.random(1, #Config.RewardItems)]
        if AddItem(src, item, 1) then
            ServerNotify(src, Locale("you_received_cat"), 'success')
        end
    end
end)

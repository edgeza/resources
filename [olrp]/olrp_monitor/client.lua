local Config = Config or {}

-- Main event handler for OLRP Monitor
RegisterNetEvent('olrp_monitor:showEconomy', function(playerData, totalAmount, totalCrypto, totalVehicles, totalTruckingMoney, totalSavingsAccounts, totalSocietyAccounts)
    -- Ensure all required fields are present
    for i = 1, #playerData do
        if not playerData[i].total then
            playerData[i].total = (playerData[i].cash or 0) + (playerData[i].bank or 0)
        end
        playerData[i].vehicleCount = playerData[i].vehicleCount or 0
        playerData[i].itemCount = playerData[i].itemCount or 0
        playerData[i].truckingMoney = playerData[i].truckingMoney or 0
        playerData[i].savingsAccount = playerData[i].savingsAccount or 0
        playerData[i].societyAccounts = playerData[i].societyAccounts or 0
        playerData[i].networth = playerData[i].networth or playerData[i].total
        playerData[i].isSuspicious = playerData[i].isSuspicious or false
        playerData[i].abuseFlags = playerData[i].abuseFlags or {}
    end

    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'show',
        players = playerData,
        totalAmount = totalAmount or 0,
        totalCrypto = totalCrypto or 0,
        totalVehicles = totalVehicles or 0,
        totalTruckingMoney = totalTruckingMoney or 0,
        totalSavingsAccounts = totalSavingsAccounts or 0,
        totalSocietyAccounts = totalSocietyAccounts or 0,
        texts = Config.Texts,
        webhookUrl = Config.WebhookUrl or ''
    })
end)

-- Legacy event support for backwards compatibility
RegisterNetEvent('hobbs_server_economy:showRichestPlayers', function(playerData, totalAmount, totalCrypto)
    for i = 1, #playerData do
        playerData[i].total = (playerData[i].cash or 0) + (playerData[i].bank or 0)
        playerData[i].vehicleCount = playerData[i].vehicleCount or 0
        playerData[i].itemCount = playerData[i].itemCount or 0
        playerData[i].networth = playerData[i].networth or playerData[i].total
        playerData[i].isSuspicious = false
        playerData[i].abuseFlags = {}
    end

    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'show',
        players = playerData,
        totalAmount = totalAmount or 0,
        totalCrypto = totalCrypto or 0,
        totalVehicles = 0,
        texts = Config.Texts,
        webhookUrl = Config.WebhookUrl or ''
    })
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ type = 'hide' })
    cb('ok')
end)

RegisterNUICallback('refresh', function(data, cb)
    -- Trigger server to refresh data
    TriggerServerEvent('olrp_monitor:refreshData')
    cb('ok')
end)

RegisterNUICallback('getMoneyFlow', function(data, cb)
    local citizenid = data.citizenid
    if citizenid then
        TriggerServerEvent('olrp_monitor:getMoneyFlow', citizenid)
    end
    cb('ok')
end)

RegisterNetEvent('olrp_monitor:receiveMoneyFlow', function(citizenid, transactions)
    SendNUIMessage({
        type = 'moneyFlow',
        citizenid = citizenid,
        transactions = transactions
    })
end)

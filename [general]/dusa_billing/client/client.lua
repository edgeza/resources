local players_clean = {}

local function isAuth()
    if not Framework.Player or not Framework.Player.Job then
        return false
    end
    for _, job in pairs(Config.AuthorizedJobs) do
        if Framework.Player.Job.Name == job then
            return true
        end
    end
    return false
end

local function isCompany()
    if not Framework.Player or not Framework.Player.Job then
        return false
    end
    for _, job in pairs(Config.JobBills) do
        if Framework.Player.Job.Name == job.name then
            return true
        end
    end
    return false
end

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players = lib.getNearbyPlayers(GetEntityCoords(playerPed), 10.0)

    players_clean = {}
    local found_players = false

    for i = 1, #players, 1 do
        if players[i].id ~= PlayerId() then
            TriggerServerEvent('dusa_billing:sv:findIdentifier', GetPlayerServerId(players[i].id))
        end
    end
    Wait(500)
    return players_clean
end

RegisterNetEvent('dusa_billing:cl:addToPlayersClean', function(name, id, identifier)
    found_players = true
    table.insert(players_clean, { name = name, citizen = identifier, id = id })
end)

RegisterCommand(Config.Commands.OpenBilling, function()
    local playername = GetPlayerName(PlayerId())
    local bills = lib.callback.await('dusa_billing:cb:getAllBills', false)
    if not bills or next(bills) == nil then bills = "empty" end
    if #bills == 0 then bills = { bills } else bills = bills end
    
    if Framework.Player then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            player = ({ name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname, citizen = Framework.Player.Identifier, job = Framework.Player.Job.Name }),
            bills = bills,
            jobBills = Config.JobBills,
            closestPlayers = GetNeareastPlayers(),
            translate = Config.Translations[Config.Locale],
            isAuth = isAuth(),
            isCompany = isCompany()
        })
        TriggerScreenblurFadeIn(500)
    end
end)

RegisterNetEvent('dusa_billing:cl:openBilling', function()
    local bills = lib.callback.await('dusa_billing:cb:getAllBills', false)
    if not bills or next(bills) == nil then bills = "empty" end
    if #bills == 0 then bills = { bills } else bills = bills end
    
    if Framework.Player then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            player = ({ name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname, citizen = Framework.Player.Identifier, job = Framework.Player.Job.Name }),
            bills = bills,
            jobBills = Config.JobBills,
            closestPlayers = GetNeareastPlayers(),
            translate = Config.Translations[Config.Locale]
        })
        TriggerScreenblurFadeIn(500)
    end
end)

RegisterNetEvent('dusa_billing:cl:openAdmin', function()
    local bills = lib.callback.await('dusa_billing:cb:getAllBills', false)
    if not bills or next(bills) == nil then bills = "empty" end
    if #bills == 0 then bills = { bills } else bills = bills end
    
    if Framework.Player then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'admin',
            player = ({ name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname, citizen = Framework.Player.Identifier, job = Framework.Player.Job.Name }),
            bills = bills,
            translate = Config.Translations[Config.Locale]
        })
        TriggerScreenblurFadeIn(500)
    end
end)

RegisterNetEvent('dusa_billing:openPos', function()
    if Framework.Player then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'pos',
            player = ({ name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname, citizen = Framework.Player.Identifier, job = Framework.Player.Job.Name }),
            closestPlayers = GetNeareastPlayers(),
            translate = Config.Translations[Config.Locale]
        })
    end
end)

RegisterCommand(Config.Commands.PosDevice, function()
    if Config.PosForCompany then
        if not isCompany() then
            Framework.Notify(Config.Translations[Config.Locale].pos_only_company, 'error')
            return
        end
    end
    TriggerEvent('dusa_billing:openPos')
end)

RegisterNUICallback('createInvoice', function(data)
    local data = data.data
    TriggerServerEvent('dusa_billing:sv:createBill', data)
    Framework.Notify(Config.Translations[Config.Locale].inv_created, 'success')
end)

RegisterNUICallback('requestInvoice', function(data)
    local data = data.data
    TriggerServerEvent('dusa_billing:sv:requestInvoice', data)
    Framework.Notify(Config.Translations[Config.Locale].inv_requested, 'success')
end)

RegisterNUICallback('payInvoice', function(data)
    local data = data.data
    TriggerServerEvent('dusa_billing:sv:payInvoice', data)
end)

RegisterNUICallback('deleteInvoice', function(data)
    local data = data.data
    TriggerServerEvent('dusa_billing:sv:deleteInvoice', data)
end)

RegisterNUICallback('checkMoney', function(data, cb)
    local bool = lib.callback.await('dusa_billing:cb:checkMoney', false, data.type, data.amount)
    cb(bool)
end)

RegisterNUICallback('payImmediately', function(data)
    local data = data.data
    -- data.amount para miktarı
    -- data.sentBy gönderenin citizenidsi
    TriggerServerEvent('dusa_billing:sv:payImmediately', data.amount, data.sentBy, data.senderJob)
end)

RegisterNUICallback('openPosAtTarget', function(data)
    local data = data.data
    TriggerServerEvent('dusa_billing:sv:syncPos', data.player, data.input, data.sentBy, data.senderJob)
end)

-- seçilen oyuncuda çalışır, kişide pos cihazını açar
-- sender posa miktar yazanın citizenidsi
RegisterNetEvent('dusa_billing:cl:syncPos', function(amount, sender, senderJob)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'syncpos',
        amount = amount,
        sender = sender,
        senderJob = senderJob,
        translate = Config.Translations[Config.Locale]
    })
end)

RegisterNUICallback('closeNUI', function()
    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(500)
end)

RegisterNUICallback('notify', function(data)
    local data = data.data
    Framework.Notify(data.text, data.type)
end)

RegisterNetEvent('dusa_billing:cl:requestInvoice', function(data)
    Wait(500)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'invoiceData',
        invoiceData = data,
        jobBills = Config.JobBills,
        translate = Config.Translations[Config.Locale]
    })
end)

RegisterNUICallback('getDebt', function(data, cb)
    local players = {}
    for k, v in pairs(GetActivePlayers()) do
        table.insert(players, { name = GetPlayerName(v), id = GetPlayerServerId(v) })
    end
    local totalDebt = lib.callback.await('dusa_billing:cb:searchPlayer', false, players, data.name)
    cb(totalDebt)
end)

exports('hasBills', function()
    local bills = lib.callback.await('dusa_billing:cb:getPlayerBills', false)
    if bills then
        return true
    else
        return false
    end
end)

exports('openBilling', function()
    TriggerEvent('dusa_billing:cl:openBilling')
end)

exports('openAdmin', function()
    TriggerEvent('dusa_billing:cl:openAdmin')
end)

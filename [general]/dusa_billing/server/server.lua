local bills = {}

-- Helper function to refresh the bills table
local function refreshBillsTable()
    MySQL.query('SELECT * FROM dusa_bills', {}, function(result)
        if result then
            bills = result
        end
    end)
end

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    if MySQL then
        MySQL.update(
            [[
            CREATE TABLE IF NOT EXISTS `dusa_bills` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `reference` varchar(10) DEFAULT NULL,
            `title` text DEFAULT NULL,
            `description` text DEFAULT NULL,
            `billFrom` text DEFAULT NULL,
            `billTo` text DEFAULT NULL,
            `amount` int(11) DEFAULT NULL,
            `status` tinytext DEFAULT NULL,
            `type` tinytext DEFAULT NULL,
            `date` tinytext DEFAULT NULL,
            PRIMARY KEY (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
            ]]     , {}, function(success)
            if success then
                print("[dusa_billing] ^1Billing Tables successfully updated^7")
            else
                print("[dusa_billing] ^3Error connecting to DB^7")
            end
        end)
    end
    bills = MySQL.prepare.await('SELECT * FROM dusa_bills', {})
end)


RegisterServerEvent('dusa_billing:sv:createBill')
AddEventHandler('dusa_billing:sv:createBill', function(data)
    local source = source
    local tPlayer = Framework.GetPlayerByIdentifier(data.billTo.citizen)
    local tSource = tPlayer.source

    local xPed = GetPlayerPed(source)
    local xCoords = GetEntityCoords(xPed)

    local yPed = GetPlayerPed(tSource)
    local yCoords = GetEntityCoords(yPed)

    local distance = #(xCoords - yCoords)
    if distance > 20.0 then
        DropPlayer(source, 'Tried to create a bill from a long distance, kicked from the server.')
        print('^3 Player ['..source..'] tried to create a bill from a long distance, kicked from the server.^7')
        return
    end

    if tonumber(data.amount) > ServerConfig.MaxBillAmount then
        return Framework.Notify(source, Config.Translations[Config.Locale].exceed_maxamount, 'error')
    end

    MySQL.Async.execute('INSERT INTO dusa_bills (reference, title, description, billFrom, billTo, amount, status, type, date) VALUES (@reference, @title, @description, @billFrom, @billTo, @amount, @status, @type, @date)',
    {
        ['@reference']   = data.referance,
        ['@title']   = data.title,
        ['@description']   = data.description,
        ['@billFrom']   = json.encode(data.billFrom),
        ['@billTo']   = json.encode(data.billTo),
        ['@amount'] = data.amount,
        ['@status']   = data.status,
        ['@type']   = data.type,
        ['@date']   = data.date,
    }, function (rowsChanged)
        if rowsChanged and rowsChanged > 0 then
            -- Update the local bills table
            refreshBillsTable()
        end
    end)
end)

RegisterNetEvent("dusa_billing:sv:findIdentifier", function(plysrc)
    local source = source
    local otherPlayer = plysrc
    local Player = Framework.GetPlayer(otherPlayer)
    if Player then
        TriggerClientEvent('dusa_billing:cl:addToPlayersClean', source, Player.Firstname .. ' ' .. Player.Lastname, plysrc, Player.Identifier)
    end
end)

RegisterServerEvent('dusa_billing:sv:requestInvoice')
AddEventHandler('dusa_billing:sv:requestInvoice', function(data)
    local tPlayer = Framework.GetPlayerByIdentifier(data.billTo.citizen)
    if not tPlayer then return print('[WARNING] Requested player is not available!') end
    local tSource = tPlayer.source
    TriggerClientEvent('dusa_billing:cl:requestInvoice', tSource, data)
end)

RegisterServerEvent('dusa_billing:sv:payInvoice')
AddEventHandler('dusa_billing:sv:payInvoice', function(data)
    local source = source
    local Player = Framework.GetPlayer(source)
    if not Player then return end
    
    if data.company == "personel" then 
        local sPlayer = Framework.GetPlayerByIdentifier(data.owner)
        if not sPlayer then
            -- faturası ödenmek istenen adam aktif değil
            Framework.Notify(source, Config.Translations[Config.Locale].inv_notonline, 'error')
        else
            if data.type == 'card' then data.type = 'bank' end
            Player.RemoveMoney(data.type, data.amount)
            sPlayer.AddMoney('bank', data.amount)
            Framework.Notify(sPlayer.source, Config.Translations[Config.Locale].your_inv_paid, 'success')

            MySQL.Async.execute('UPDATE dusa_bills SET status = @status WHERE reference = @reference', {
                ['@status'] = "paid",
                ['@reference'] = data.reference,
            }, function(rowsChanged) 
                if rowsChanged and rowsChanged > 0 then
                    -- Update the local bills table
                    refreshBillsTable()
                    Framework.Notify(source, Config.Translations[Config.Locale].inv_paid, 'success')
                else
                    Framework.Notify(source, 'Error updating bill status', 'error')
                end
            end)
        end
    else
        local sPlayer = Framework.GetPlayerByIdentifier(data.owner)
        if sPlayer then
            if data.type == 'card' then data.type = 'bank' end
            Player.RemoveMoney(data.type, data.amount)
            Framework.SocietyAddMoney(data.job, "job", data.amount)
            Framework.Notify(sPlayer.source, Config.Translations[Config.Locale].your_inv_paid, 'success')

            MySQL.Async.execute('UPDATE dusa_bills SET status = @status WHERE reference = @reference', {
                ['@status'] = "paid",
                ['@reference'] = data.reference,
            }, function(rowsChanged) 
                if rowsChanged and rowsChanged > 0 then
                    -- Update the local bills table
                    refreshBillsTable()
                    Framework.Notify(source, Config.Translations[Config.Locale].inv_paid, 'success')
                else
                    Framework.Notify(source, 'Error updating bill status', 'error')
                end
            end)
        end
    end
end)

RegisterServerEvent('dusa_billing:sv:syncPos')
AddEventHandler('dusa_billing:sv:syncPos', function(citizen, amount, sender, senderJob)
    local tPlayer = Framework.GetPlayerByIdentifier(citizen)
    if tPlayer and tPlayer.source then
        TriggerClientEvent('dusa_billing:cl:syncPos', tPlayer.source, amount, sender, senderJob)
    end
end)

RegisterServerEvent('dusa_billing:sv:checkAdminPermission')
AddEventHandler('dusa_billing:sv:checkAdminPermission', function()
    local source = source
    
    -- Check if player has admin permission using FiveM's ACE system
    local isAdmin = IsPlayerAceAllowed(source, "dusa_billing.admin") or
                   IsPlayerAceAllowed(source, "admin") or
                   IsPlayerAceAllowed(source, "group.admin") or
                   IsPlayerAceAllowed(source, "command")
    
    if isAdmin then
        TriggerClientEvent('dusa_billing:cl:openAdmin', source)
    else
        Framework.Notify(source, 'You do not have permission to use this command.', 'error')
    end
end)

RegisterServerEvent('dusa_billing:sv:deleteInvoice')
AddEventHandler('dusa_billing:sv:deleteInvoice', function(data)
    local source = source
    MySQL.Async.execute('DELETE FROM `dusa_bills` WHERE `reference` = ?', {data}, function(rowsChanged)
        if rowsChanged and rowsChanged > 0 then
            -- Update the local bills table
            refreshBillsTable()
            Framework.Notify(source, Config.Translations[Config.Locale].inv_deleted, 'success')
        else
            Framework.Notify(source, 'Error deleting bill', 'error')
        end
    end)
end)

RegisterServerEvent('dusa_billing:sv:payImmediately')
AddEventHandler('dusa_billing:sv:payImmediately', function(amount, sentBy, senderJob)
    if not amount then return end

    local source = source
    local Player = Framework.GetPlayer(source)
    local sPlayer = Framework.GetPlayerByIdentifier(sentBy)
    
    if Player and sPlayer and sPlayer.source then
        Player.RemoveMoney('bank', amount)
        if Config.PosToJobVault then
            Framework.SocietyAddMoney(senderJob, "job", amount)
        else
            sPlayer.AddMoney('bank', amount)
        end
    end
end)

lib.callback.register('dusa_billing:cb:getBillFromReference', function(source, reference)
    for i=1, #bills do
        if bills[i].reference == reference then
            return bills[i]
        end
    end
    return false
end)

lib.callback.register('dusa_billing:cb:getAllBills', function(source)
    if not bills then bills = {} end
    return bills
end)

lib.callback.register('dusa_billing:cb:checkMoney', function(source, type, amount)
    if type == 'card' then type = 'bank' end
    local Player = Framework.GetPlayer(source)
    if Player then
        local pmoney = Player.GetMoney(type)
        if pmoney >= amount then
            return true
        else
            Framework.Notify(source, Config.Translations[Config.Locale].inv_notmoney, 'error')
            return false
        end
    end
    return false
end)

lib.callback.register('dusa_billing:cb:searchPlayer', function(source, players, searchFor)
    local totalAmount = 0
    local found = false
    for k, v in pairs(players) do
        local Player = Framework.GetPlayer(v.id)
        if Player then
            local name = Player.Firstname .. ' ' .. Player.Lastname
            if name == searchFor then
                for i=1, #bills do
                    if json.decode(bills[i].billTo).name == searchFor then
                        found = true
                        totalAmount = totalAmount + bills[i].amount
                    end
                end
            end
        end
    end
    if not found then return false end
    return totalAmount
end)

lib.callback.register('dusa_billing:cb:getPlayerBills', function(source)
    local Player = Framework.GetPlayer(source)
    if Player then
        local identifier = Player.Identifier
        for i=1, #bills do
            if json.decode(bills[i].billTo).citizen == identifier then
                return true
            end
        end
    end
    return false
end)

RegisterServerEvent('dusa_billing:sv:createCustomInvoice', function(toSource, title, description, amount, type)
    local source = source
    local Player = Framework.GetPlayer(source)
    local tPlayer = Framework.GetPlayer(toSource)
    
    if not Player or not tPlayer then return end
    
    if type == 'personal' or not type then type = 'personel' end
    -- {"billFrom":{"citizen":"char3:d6427c9718e5503c240fd9dba0d9cb016ba15ad1","name":"Dusa Ninja","job":"police"},"job":"","title":"ASDasd","type":"personel","date":"2024-0-27","description":"ASDasd","referance":"XQXZGZWRCA","status":"unpaid","billTo":{"name":"Test Dusa 1","citizen":"GCQ40392"},"mandatory":true,"amount":"60"}
    local data = {
        billFrom = {
            citizen = Player.Identifier,
            name = Player.Firstname .. ' ' .. Player.Lastname,
            job = Player.Job.Name,
        },
        billTo = {
            name = tPlayer.Firstname .. ' ' .. tPlayer.Lastname,
            citizen = tPlayer.Identifier
        },
        type = type,
        date = os.date('%Y-%m-%d') or '2024-0-27',
        title = title,
        description = description,
        referance = createReference(),
        status = "unpaid",
        mandatory = true,
        amount = amount
    }
    TriggerEvent('dusa_billing:sv:createBill', source, data)
end)

function createReference()
    local result = ''
    local characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local charactersLength = string.len(characters)
    local counter = 0

    while counter < 7 do
        local randomIndex = math.random(1, charactersLength)
        result = result .. string.sub(characters, randomIndex, randomIndex)
        counter = counter + 1
    end

    return result
end


function BillQBPhone(playerId, amount)
        local src = source
        local biller = getPlayer(source)
        local billed = getPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if GetJob(source) == Config.Jobname then
            if billed ~= nil then
                if getPlayerName(source) ~= getPlayerName(source) then
                    if amount and amount > 0 then
                        MySQL.Async.execute('INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (@citizenid, @amount, @society, @sender, @sendercitizenid)', {
                            ['@citizenid'] = GetPlayerIdentifier(tonumber(playerId)),
                            ['@amount'] = amount,
                            ['@society'] = GetJob(source),
                            ['@sender'] = getPlayerName(source),
                            ['@sendercitizenid'] = GetPlayerIdentifier(source)
                        })
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                        TriggerClientEvent("pl_koi:notification", source, Locale("invoice_sent"), 'success')
                        TriggerClientEvent("pl_koi:notification", billed.PlayerData.source, Locale("invoice_recived"))
                    else
                        TriggerClientEvent("pl_koi:notification", source, Locale("must_zero"), 'error')
                    end
                else
                    TriggerClientEvent("pl_koi:notification", source, Locale("cannot_bill_yourself"), 'error')
                end
            else
                TriggerClientEvent("pl_koi:notification", source,Locale("player_not_online"), 'error')
            end
        else
            TriggerClientEvent("pl_koi:notification", source, Locale("no_access"), 'error')
        end
end

RegisterServerEvent("pl_koi:billplayer")
AddEventHandler("pl_koi:billplayer", function(targetId, billamount,can)
    local src = source
    local Identifier = GetPlayerIdentifier(src)
    local PlayerName = getPlayerName(src)
    local finalbill = tonumber(billamount or 0)
    local ResourceBillingMenu = GetBillingMenu()
    if finalbill > Config.MaxBillAmount then
        print(('^1[Exploit Attempt]^0 %s (%s) tried to enter billamount more then set in Config.'):format(PlayerName, Identifier))
        return 
    end
    if GetJob(source) == Config.Jobname and can == 'abahzgcjancakdaoq'then
        if ResourceBillingMenu == 'esx_billing' then
            TriggerEvent('esx_billing:sendBill',targetId, "society_"..Config.Jobname.."",Config.Jobname, finalbill, true)
        elseif ResourceBillingMenu == 'qb-phone' then
            BillQBPhone(targetId, finalbill)
        elseif ResourceBillingMenu == 's1n_billing' then
            -- Replace the playerSource with the source of the player who is sending the invoice
            -- Replace the targetPlayerSource with the source of the player who will receive the invoice
            exports["s1n_billing"]:createInvoice(source, {
                receiver = targetId,
                isJob = true,
                date = "2025-02-01 12:00:00",
                item = Config.Jobname,
                note = ""..Config.Jobname.." Bill",
                amount = finalbill
            })
        elseif ResourceBillingMenu == 'okokBilling' then
            TriggerEvent("okokBilling:CreateCustomInvoice", targetId, finalbill, ""..Config.Jobname.." Bill", source, Config.Jobname, Config.Jobname)
        elseif ResourceBillingMenu == 'codem-billing' then
            exports['codem-billing']:createBilling(source, targetId, finalbill, "Shop bill", "society_"..Config.Jobname.."")        
        end
    end
end)
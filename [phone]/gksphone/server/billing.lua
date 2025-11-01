
--- GKSPHONE v2.0 ---
-- New Bill Export --
BillingTable = {}
local Jobs = setmetatable({}, {__index = function(_, key)
    local job = GetJobs()
	return job[key]
end})



CreateThread(function()
    Wait(5000)
    if Config.AutoPaidBillDelete then
        MySQL.Async.execute('DELETE FROM gksphone_billing WHERE gksphone_billing.status = "paid"', {})
    end
    if Config.UnpaidBillInterest then
        MySQL.Async.execute('UPDATE `gksphone_billing` SET `amount` = `amount` * (('..Config.BillInterest.percent.. '/ 100) + 1) WHERE gksphone_billing.status = "unpaid" AND `time` < NOW() - INTERVAL '..Config.BillInterest.day.. ' DAY', {})
    end
    BillingTable = MySQL.query.await('SELECT * FROM `gksphone_billing`')
    
end)


function NewBilling(source, label, society, senderBilling, senderID, amountt)
    local create = false
    local src = source
    local biller = GetIdentifier(src)
    Debugprint("new billing exports", {source, society, senderBilling, senderID, amountt})
    if biller then
        local amount = tonumber(amountt)
        if amount and amount > 0 then

            if Jobs[society] == nil then
                Debugprint("billing error, society not found", {society, senderBilling, senderID, amount})
                return false
            end

            local societylabel = Jobs[society].label
            local bill_holder = GetCharacterName(src)


            local billid = MySQL.Sync.insert('INSERT INTO `gksphone_billing` (`citizenid`, `amount`, `society`, `societylabel`,  `sender`, `sendercitizenid`, `description`, `bill_holder`, `status`) VALUES (@citizenid, @amount, @society, @societylabel, @sender, @sendercitizenid, @description, @bill_holder, @status)', {
                ['@citizenid'] = biller,
                ['@amount'] = amount,
                ['@society'] = society,
                ['@societylabel'] = societylabel,
                ['@sender'] = senderBilling,
                ['@sendercitizenid'] = senderID,
                ['@description'] = label,
                ['@bill_holder'] = bill_holder,
                ['@status'] = "unpaid"
            })


            local webhookdata = {
                receiverSrc = src,
                receiverName = bill_holder,
                receiverID = biller,
                billingLabel = label,
                billingSociety = society,
                billingSocietyLabel = societylabel,
                billingAmaount = amount,
                senderName = senderBilling,
                senderID = senderID,
                bill_holder = bill_holder,
                status = "unpaid"
            }

            BillingTable[#BillingTable + 1] = {
                id = billid,
                citizenid = biller,
                amount = amount,
                society = society,
                societylabel = societylabel,
                sender = senderBilling,
                sendercitizenid = senderID,
                description = label,
                bill_holder = bill_holder,
                status = "unpaid"
            }

            Debugprint("billing created", {source, society, senderBilling, senderID, amount})

            PhoneDataAddBilling(billid, biller, amount, society, societylabel, senderBilling, senderID, label, bill_holder, "unpaid")
            create = true
            WebhookLogs('bussinesBillingCreate', src, webhookdata)
        end

    elseif source == "business" then
        local amount = tonumber(amountt)
        if amount and amount > 0 then
            if Jobs[society] == nil then
                Debugprint("billing error, society not found", {society, senderBilling, senderID, amount})
                return false
            end
            local phoneData = GetPhoneDataByCitizenID(senderID)
            if phoneData == nil then
                return false
            end
            local xbiller = GetCharacterJob(phoneData.source)
            if xbiller == nil then
                Debugprint("billing error, biller not found", {society, senderBilling, senderID, amount})
                return false
            end
            local billerJob = xbiller.name
            if not Config.JOBServices[billerJob] then
                for k, v in pairs(Config.JOBServices) do
                    if v.alternativejobs then
                        for x, m in pairs(v.alternativejobs) do
                            if x == billerJob and m then
                                billerJob = k
                                break
                            end
                        end
                    end
                end
            end
            if Jobs[billerJob] == nil then
                Debugprint("billing error, billerJob not found", {billerJob, senderBilling, senderID, amount})
                return false
            end
            local societylabel = Jobs[billerJob].label
            local reciverbussines = Jobs[society].label
            local billid = MySQL.Sync.insert('INSERT INTO `gksphone_billing` (`citizenid`, `amount`, `society`, `societylabel`,  `sender`, `sendercitizenid`, `description`, `bill_holder`, `status`) VALUES (@citizenid, @amount, @society, @societylabel, @sender, @sendercitizenid, @description, @bill_holder, @status)', {
                ['@citizenid'] = society,
                ['@amount'] = amount,
                ['@society'] = billerJob,
                ['@societylabel'] = societylabel,
                ['@sender'] = senderBilling,
                ['@sendercitizenid'] = senderID,
                ['@description'] = label,
                ['@bill_holder'] = reciverbussines,
                ['@status'] = "unpaid"
            })

            local webhookdata = {
                receiverSrc = src,
                receiverName = reciverbussines,
                receiverID = "Business",
                billingLabel = label,
                billingSociety = society,
                billingSocietyLabel = societylabel,
                billingAmaount = amount,
                senderName = senderBilling,
                senderID = senderID,
                status = "unpaid"
            }

            local billData = {
                id = billid,
                citizenid = society,
                amount = amount,
                society = billerJob,
                societylabel = societylabel,
                sender = senderBilling,
                sendercitizenid = senderID,
                description = label,
                bill_holder = reciverbussines,
                status = "unpaid",
                time = os.date('%Y-%m-%d %H:%M:%S'),
            }

            BillingTable[#BillingTable + 1] = billData

            create = true
            WebhookLogs('bussinesBillingCreate', xbiller.source, webhookdata)

            local checkBillAuth = Config.JOBServices[society]?.billing?.pay
            local players = GetExtendedPlayers("job", society)
            if players and checkBillAuth then
                for i = 1, #players, 1 do
                    local player = players[i]
                    if player then
                        local playerJobName = player.job.name
                        local playerJobGrade = player.job.grade or 0
                        local phoneLang = GetPhoneLangBySource(player.source)
                        if playerJobName == society and playerJobGrade >= checkBillAuth then
                            TriggerClientEvent('gksphone:client:NewBussinesBill', player.source, billData)
                            local notify = {
                                    title = _T(phoneLang, "BankAPP.Billing.APP_BILLING_TITLE"),
                                    message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_NOTIFY_NEWBILL"),
                                    icon = "/html/img/icons/wallet.png",
                            }
                            exports["gksphone"]:sendNotification(player.source, notify)
                        end
                    end
                end
            end
        end
    end

    return create
end
exports("NewBilling", NewBilling)

exports("IsUnpaidBillsbyCid", function (cid)
    local retval = false
    if BillingTable then
        for i = 1, #BillingTable, 1 do
            if BillingTable[i].citizenid == cid and BillingTable[i].status == "unpaid" then
                retval = true
                break
            end
        end
    end
    return retval
end)

CallBackRegisterServer('gksphone:server:billing:allbillpay', function(source, cb, phoneUniq)
    local info = {status = false}
    if phoneUniq == nil then
        Debugprint("bank request error1")
        cb(info)
        return
    end
    if PhonesData[phoneUniq] ~= nil then
        local phonedata = PhonesData[phoneUniq]
        local xPlayer = GetCharacterJob(phonedata.source)
        if not xPlayer then
            cb(info)
            return
        end
        local PlayerBankBalance = GetBankBalanceByIndetifier(phonedata.setup_owner)
        local playerJobName = xPlayer.name
        local totalUnpaidAmount = 0
        for i = 1, #phonedata.bankDetails.Billings, 1 do
            if phonedata.bankDetails.Billings[i].status == "unpaid" then
                totalUnpaidAmount = totalUnpaidAmount + phonedata.bankDetails.Billings[i].amount
            end
        end
        if PlayerBankBalance < totalUnpaidAmount then
            Debugprint("billing paid error, bank balance error", {phoneUniq, totalUnpaidAmount})
            cb(info)
            return
        end
        if totalUnpaidAmount <= 0 then
            Debugprint("billing paid error, totalAmount <= 0", {phoneUniq, totalUnpaidAmount})
            cb(info)
            return
        end
        if xPlayer ~= nil then
            if #phonedata.bankDetails.Billings ~= 0 then
                local totalBillingAmount = 0
                for i = 1, #phonedata.bankDetails.Billings, 1 do
                    if phonedata.bankDetails.Billings[i].status == "unpaid" and RemoveBankMoney(phonedata.source, phonedata.bankDetails.Billings[i].amount) then
                        local isPlayerFee = Config.BillPlayerFeeJobs[phonedata.bankDetails.Billings[i].society]
                        if Config.UseBillingCommission and not isPlayerFee then
                            local SenderPly = GetPhoneDataByCitizenID(phonedata.bankDetails.Billings[i].sendercitizenid)
                            if SenderPly and SenderPly.source then
                                if Config.BillingCommissions[phonedata.bankDetails.Billings[i].society] then
                                    local commission = Round(phonedata.bankDetails.Billings[i].amount * Config.BillingCommissions[phonedata.bankDetails.Billings[i].society])
                                    AddBankMoney(SenderPly.source, commission)
                                    local SocietyRemoveMoney = SocietyRemoveMoney(phonedata.bankDetails.Billings[i].society, commission)
                                    if SocietyRemoveMoney then
                                        Debugprint("billing paid, society remove money", {phonedata.bankDetails.Billings[i].society, commission})
                                    end
                                end
                            end
                        end

                        

                        if not isPlayerFee then
                            local SocietyAddMoney = SocietyAddMoney(phonedata.bankDetails.Billings[i].society, phonedata.bankDetails.Billings[i].amount)
                            if SocietyAddMoney then
                                Debugprint("billing paid, society add money", {phonedata.bankDetails.Billings[i].society, phonedata.bankDetails.Billings[i].amount})
                            end
                        else
                            local SenderPly = GetPhoneDataByCitizenID(phonedata.bankDetails.Billings[i].sendercitizenid)
                            if SenderPly and SenderPly.source then
                                AddBankMoney(SenderPly.source, phonedata.bankDetails.Billings[i].amount)
                                local phoneLang = SenderPly.phone_lang
                                local notify = {
                                    title = _T(phoneLang, "BankAPP.Billing.APP_BILLING_TITLE"), -- The title of the notification
                                    message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_PLAYERFEE"), -- The message of the notification
                                    icon = "/html/img/icons/wallet.png", -- The icon to be displayed with the notification
                                }
                                exports["gksphone"]:sendNotification(SenderPly.source, notify)
                                
                                exports["gksphone"]:BankSaveHistory(SenderPly.source, 2, phonedata.bankDetails.Billings[i].amount, _T(phoneLang, "BankAPP.Billing.APP_BILLING_PLAYERFEE"))

                            else
                                SenderPly = GetOfflinePlayerByIdentifier(phonedata.bankDetails.Billings[i].sendercitizenid)
                                if SenderPly then
                                    SenderPly.addAccountMoney('bank', phonedata.bankDetails.Billings[i].amount, "Bank Transfer")
                                end
                            end
                        end
                        

                        MySQL.Async.execute('UPDATE gksphone_billing SET status = @status WHERE id = @id', {
                            ['@status'] = "paid",
                            ['@id'] = phonedata.bankDetails.Billings[i].id
                        })
                        totalBillingAmount = totalBillingAmount + phonedata.bankDetails.Billings[i].amount
                        phonedata.bankDetails.Billings[i].status = "paid"

                        for k, v in pairs(BillingTable) do
                            if v.id == phonedata.bankDetails.Billings[i].id then
                                BillingTable[k].status = "paid"
                                WebhookLogs('bussinesBillingPay', source, BillingTable[k])
                            end
                        end

                    end
                end

                local checkBillAuth = Config.JOBServices[playerJobName]?.billing?.pay
                local playerJobGrade = xPlayer.grade or 0
                if checkBillAuth and playerJobGrade >= checkBillAuth then
                    local players = GetExtendedPlayers("job", playerJobName)
                    for i = 1, #BillingTable, 1 do
                        if BillingTable[i].status == "unpaid" then
                            local busBillCheck = Jobs[BillingTable[i].citizenid]
                            if busBillCheck then
                                if Config.UseBillingCommission then
                                    local SenderPly = GetPhoneDataByCitizenID(BillingTable[i].sendercitizenid)
                                    if SenderPly then
                                        if Config.BillingCommissions[BillingTable[i].society] then
                                            local commission = Round(BillingTable[i].amount * Config.BillingCommissions[BillingTable[i].society])
                                            AddBankMoney(SenderPly.source, commission)
                                            local SocietyRemoveMoney = SocietyRemoveMoney(BillingTable[i].society, commission)
                                            if SocietyRemoveMoney then
                                                Debugprint("billing paid, society remove money", {BillingTable[i].society, commission})
                                            end
                                        end
                                    end
                                end

                                local SoiectPayBill = SocietyRemoveMoney(BillingTable[i].citizenid, BillingTable[i].amount)
                                if SoiectPayBill then
                                    Debugprint("billing paid, society remove money", {BillingTable[i].citizenid, BillingTable[i].amount})
                                end
                                local SocietyAddMoney = SocietyAddMoney(BillingTable[i].society, BillingTable[i].amount)
                                if SocietyAddMoney then
                                    Debugprint("billing paid, society add money", {BillingTable[i].society, BillingTable[i].amount})
                                end

                                MySQL.Async.execute('UPDATE gksphone_billing SET status = @status WHERE id = @id', {
                                    ['@status'] = "paid",
                                    ['@id'] = BillingTable[i].id
                                })
                                totalBillingAmount = totalBillingAmount + BillingTable[i].amount
                                BillingTable[i].status = "paid"
                                WebhookLogs('bussinesBillingPay', source, BillingTable[i])

                                if players and checkBillAuth then
                                    for _, v in pairs(players) do
                                        local player = v
                                        if player then
                                            local xplayerJobName = player.job.name
                                            local xplayerJobGrade = player.job.grade or 0
                                            if xplayerJobName == BillingTable[i].citizenid and xplayerJobGrade >= checkBillAuth then
                                                TriggerClientEvent('gksphone:client:updateBillBusiness', player.source, BillingTable[i].id)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end


                local description = _T(phonedata.phone_lang, "BankAPP.Billing.APP_BILLING_ALLPAIDDESCRIPTION", {amount = totalBillingAmount})
                local histroysave = exports["gksphone"]:bankHistorySave(phonedata.phone_number, 1, totalBillingAmount, description, phoneUniq) -- xPlayer

                if histroysave then
                    Debugprint("billing paid, bank history save", {phonedata.phone_number, 1, totalBillingAmount, description, phoneUniq})
                end
                PhoneDataUpdateBilling(phonedata.unique_id)
                info.status = true
                cb(info)
            else
                Debugprint("billing paid error, #phonedata.bankDetails.Billings == 0", {phoneUniq})
                cb(info)
                return
            end
        else
            Debugprint("billing paid error, xPlayer nil", {phoneUniq})
            cb(info)
            return
        end
    else
        Debugprint("bank request error2")
        cb(info)
    end

end)

CallBackRegisterServer('gksphone:server:billing:billpay', function(source, cb, phoneUniq, billID, isBusiness)
    local info = {status = false}
    if phoneUniq == nil then
        Debugprint("bank request error1")
        cb(info)
        return
    end
    if PhonesData[phoneUniq] ~= nil then
        local phonedata = PhonesData[phoneUniq]
        local xPlayer = GetPlayerFromIdentifier(phonedata.setup_owner)
        local PlayerBankBalance = GetBankBalanceByIndetifier(phonedata.setup_owner)

        if xPlayer ~= nil and not isBusiness then
            if #phonedata.bankDetails.Billings ~= 0 then
                local totalBillingAmount = 0

                for i = 1, #phonedata.bankDetails.Billings, 1 do
                    if phonedata.bankDetails.Billings[i].id == billID then
                        if phonedata.bankDetails.Billings[i].status == "unpaid" and RemoveBankMoney(phonedata.source, phonedata.bankDetails.Billings[i].amount) then

                            local totalAmount = tonumber(phonedata.bankDetails.Billings[i].amount)
                            if PlayerBankBalance < totalAmount then
                                Debugprint("billing paid error, bank balance error", {phoneUniq, totalAmount})
                                cb(info)
                                return
                            end
                            if totalAmount <= 0 then
                                Debugprint("billing paid error, totalAmount <= 0", {phoneUniq, totalAmount})
                                cb(info)
                                return
                            end
                            local isPlayerFee = Config.BillPlayerFeeJobs[phonedata.bankDetails.Billings[i].society]
                            if Config.UseBillingCommission and not isPlayerFee then
                                local SenderPly = GetPhoneDataByCitizenID(phonedata.bankDetails.Billings[i].sendercitizenid)
                                if SenderPly then
                                    if Config.BillingCommissions[phonedata.bankDetails.Billings[i].society] then
                                        local commission = Round(phonedata.bankDetails.Billings[i].amount * Config.BillingCommissions[phonedata.bankDetails.Billings[i].society])
                                        AddBankMoney(SenderPly.source, commission)
                                        local SocietyRemoveMoney = SocietyRemoveMoney(phonedata.bankDetails.Billings[i].society, commission)
                                        if SocietyRemoveMoney then
                                            Debugprint("billing paid, society remove money", {phonedata.bankDetails.Billings[i].society, commission})
                                        end
                                    end
                                end
                            end
                            

                            if not isPlayerFee then
                                local SocietyAddMoney = SocietyAddMoney(phonedata.bankDetails.Billings[i].society, phonedata.bankDetails.Billings[i].amount)
                                if SocietyAddMoney then
                                    Debugprint("billing paid, society add money", {phonedata.bankDetails.Billings[i].society, phonedata.bankDetails.Billings[i].amount})
                                end
                            else
                                local SenderPly = GetPhoneDataByCitizenID(phonedata.bankDetails.Billings[i].sendercitizenid)
                                if SenderPly then
                                    AddBankMoney(SenderPly.source, phonedata.bankDetails.Billings[i].amount)
                                    local phoneLang = SenderPly.phone_lang
                                    local notify = {
                                        title = _T(phoneLang, "BankAPP.Billing.APP_BILLING_TITLE"), -- The title of the notification
                                        message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_PLAYERFEE"), -- The message of the notification
                                        icon = "/html/img/icons/wallet.png", -- The icon to be displayed with the notification
                                    }
                                    exports["gksphone"]:sendNotification(SenderPly.source, notify)
                                    
                                    exports["gksphone"]:BankSaveHistory(SenderPly.source, 2, phonedata.bankDetails.Billings[i].amount, _T(phoneLang, "BankAPP.Billing.APP_BILLING_PLAYERFEE"))
    
                                else
                                    SenderPly = GetOfflinePlayerByIdentifier(phonedata.bankDetails.Billings[i].sendercitizenid)
                                    if SenderPly then
                                        SenderPly.addAccountMoney('bank', phonedata.bankDetails.Billings[i].amount, "Bank Transfer")
                                    end
                                end
                            end

                            MySQL.Async.execute('UPDATE gksphone_billing SET status = @status WHERE id = @id', {
                                ['@status'] = "paid",
                                ['@id'] = phonedata.bankDetails.Billings[i].id
                            })
                            totalBillingAmount = totalBillingAmount + phonedata.bankDetails.Billings[i].amount
                            phonedata.bankDetails.Billings[i].status = "paid"

                            for k, v in pairs(BillingTable) do
                                if v.id == phonedata.bankDetails.Billings[i].id then
                                    BillingTable[k].status = "paid"
                                    WebhookLogs('bussinesBillingPay', source, BillingTable[k])
                                end
                            end
                        end
                    end
                end

                local description = _T(phonedata.phone_lang, "BankAPP.Billing.APP_BILLING_PAIDDESCRIPTION", {amount = totalBillingAmount})
                local histroysave = exports["gksphone"]:bankHistorySave(phonedata.phone_number, 1, totalBillingAmount, description, phoneUniq) -- xPlayer

                if histroysave then
                    Debugprint("billing paid, bank history save", {phonedata.phone_number, 1, totalBillingAmount, description, phoneUniq})
                end

                PhoneDataUpdateBilling(phonedata.unique_id)
                info.status = true
                cb(info)
            else
                Debugprint("billing paid error, #phonedata.bankDetails.Billings == 0", {phoneUniq})
                cb(info)
                return
            end
        elseif xPlayer ~= nil and isBusiness then
            local totalBillingAmount = 0
            local pillPay = false

            for _, k in pairs(BillingTable) do
                if k.id == billID then
                    if k.status == "unpaid" then

                        local bussinesBankBalance = SocietyGetMoney(k.citizenid) or 0
                        local totalAmount = tonumber(k.amount)
                        if bussinesBankBalance < totalAmount then
                            Debugprint("billing paid error, bank balance error", {phoneUniq, totalAmount})
                            cb(info)
                            return
                        end
                        if totalAmount <= 0 then
                            Debugprint("billing paid error, totalAmount <= 0", {phoneUniq, totalAmount})
                            cb(info)
                            return
                        end

                        if Config.UseBillingCommission then
                            local SenderPly = GetPhoneDataByCitizenID(k.sendercitizenid)
                            if SenderPly then
                                if Config.BillingCommissions[k.society] then
                                    local commission = Round(k.amount * Config.BillingCommissions[k.society])
                                    AddBankMoney(SenderPly.source, commission)
                                    local SocietyRemoveMoney = SocietyRemoveMoney(k.society, commission)
                                    if SocietyRemoveMoney then
                                        Debugprint("billing paid, society remove money", {k.society, commission})
                                    end
                                end
                            end
                        end

                        local SoiectPayBill = SocietyRemoveMoney(k.citizenid, k.amount)
                        if SoiectPayBill then
                            Debugprint("billing paid, society remove money", {k.citizenid, k.amount})
                        end
                        local SocietyAddMoney = SocietyAddMoney(k.society, k.amount)
                        if SocietyAddMoney then
                            Debugprint("billing paid, society add money", {k.society, k.amount})
                        end

                        MySQL.Async.execute('UPDATE gksphone_billing SET status = @status WHERE id = @id', {
                            ['@status'] = "paid",
                            ['@id'] = k.id
                        })
                        totalBillingAmount = totalBillingAmount + k.amount
                        k.status = "paid"
                        WebhookLogs('bussinesBillingPay', source, k)

                        local checkBillAuth = Config.JOBServices[k.citizenid]?.billing?.pay
                        local players = GetExtendedPlayers("job", k.citizenid)
                        if players then
                            for _, v in pairs(players) do
                                local playerx = v
                                if playerx then
                                    local xplayerJobName = playerx.job.name
                                    local xplayerJobGrade = playerx.job.grade or 0
                                    if xplayerJobName == k.citizenid and xplayerJobGrade >= checkBillAuth then
                                        TriggerClientEvent('gksphone:client:updateBillBusiness', playerx.source, k.id)
                                    end
                                end
                            end
                        end

                        pillPay = true
                    end
                end
            end
            info.status = pillPay
            cb(info)
        else
            Debugprint("billing paid error, xPlayer nil", {phoneUniq})
            cb(info)
            return
        end
    else
        Debugprint("bank request error2")
        cb(info)
    end

end)

CallBackRegisterServer('gksphone:server:createbill', function(source, cb, data)
    local src = source
    local biller = GetPhoneDataBySource(src)
    local info = {status = false}
    if biller then
        local phoneLang = biller.phone_lang
        local playerJobData = GetCharacterJob(src)
        if not playerJobData then
            cb(info)
            return
        end
        local createJobName = playerJobData.name
        if Config.JOBServices[createJobName] == nil then
            for k, l in pairs(Config.JOBServices) do
                if l.alternativejobs then
                    for v, x in pairs(l.alternativejobs) do
                        if v == createJobName and x then
                            createJobName = k
                            break
                        end
                    end
                end
            end
        end
        if data.id then
            if src ~= data.id then
                local billed = GetIdentifier(tonumber(data.id))
                if not billed then
                    info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_PLAYER_NOT_ONLINE", {blplayer = data.id})
                    cb(info)
                    return
                end
                local amount = tonumber(data.amount)
                if amount and amount > 0 then
                    local newbill = NewBilling(tonumber(data.id), data.fine, createJobName, biller.ownerName, biller.identifier, amount)
                    if newbill then
                        info.status = true
                        info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_SUCCESS")
                        cb(info)
                    else
                        info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_ERROR")
                        cb(info)
                    end
                else
                    info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_AMOUNT_ERROR")
                    cb(info)
                end
            else
                info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_YOURSELF_ERROR")
                cb(info)
            end
        elseif data.contact then
            local contact = data.contact
            local amount = tonumber(data.amount)
            if amount and amount > 0 then
                if contact.number then
                    local number = contact.number
                    local billed = GetSourceByNumber(number)
                    if billed then
                        local newbill = NewBilling(billed, data.fine, createJobName, biller.ownerName, biller.identifier, amount)
                        if newbill then
                            info.status = true
                            info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_SUCCESS")
                            cb(info)
                        else
                            info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_ERROR")
                            cb(info)
                        end
                    else
                        info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_PLAYER_NOT_ONLINE", {blplayer = number})
                        cb(info)
                    end
                else
                    info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_ERROR")
                    cb(info)
                end
            else
                info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_AMOUNT_ERROR")
                cb(info)
            end
        elseif data.airdrop then
            local airdrop = data.airdrop
            local amount = tonumber(data.amount)
            if amount and amount > 0 then
                if airdrop.pid then
                    local bsrc = tonumber(airdrop.pid)
                    local billed = GetIdentifier(bsrc)
                    if billed then
                        local newbill = NewBilling(bsrc, data.fine, createJobName, biller.ownerName, biller.identifier, amount)
                        if newbill then
                            info.status = true
                            info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_SUCCESS")
                            cb(info)
                        else
                            info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_ERROR")
                            cb(info)
                        end
                    else
                        info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_PLAYER_NOT_ONLINE", {blplayer = bsrc})
                        cb(info)
                    end
                else
                    info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_ERROR")
                    cb(info)
                end
            else
                info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_AMOUNT_ERROR")
                cb(info)
            end
        elseif data.business then
            local jobname = data.business
            local amount = tonumber(data.amount)
            if amount and amount > 0 then
                local newbill = NewBilling("business", data.fine, jobname, createJobName, biller.identifier, amount)
                if newbill then
                    info.status = true
                    info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_SUCCESS")
                    cb(info)
                else
                    info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_ERROR")
                    cb(info)
                end
            else
                info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_AMOUNT_ERROR")
                cb(info)
            end
        else
            info.message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_ERROR")
            cb(info)
        end
    else
        info.message = _T(Config.DefaultLocale, "BankAPP.Billing.APP_BILLING_ERROR")
        cb(info)
    end
end)

CallBackRegisterServer('gksphone:server:getBussinesBilling', function(source, cb)
    local src = source
    local xPlayer = GetIdentifier(src)
    if xPlayer then
        local characterJob = GetCharacterJob(src)
        if not characterJob then
            cb(false)
            return
        end
        local playerJob = characterJob.name
        for k, v in pairs(Config.JOBServices) do
            if v.alternativejobs then
                for x, m in pairs(v.alternativejobs) do
                    if x == playerJob and m then
                        playerJob = k
                        break
                    end
                end
            end
        end
        -- BillingTable find playerjob society
        local billing = {}
        for i, bill in ipairs(BillingTable) do
            if bill.society == playerJob then
                table.insert(billing, bill)
            end
        end
        cb(billing)
    else
        cb(false)
    end

end)

CallBackRegisterServer('gksphone:server:deleteBill', function(source, cb, id)
    local src = source
    local e = GetCharacterJob(src)
    if not e then
        cb(false)
        return
    end
    MySQL.Async.fetchAll('SELECT * FROM gksphone_billing WHERE society = @society AND id = @id', {
        ['@society'] = e.name,
        ['@id'] = id
    }, function(data)
        if data[1] then
            local res = data[1]
            local society = res.citizenid
            local busBillCheck = Jobs[society]

            if busBillCheck then
                MySQL.Async.fetchAll("DELETE FROM gksphone_billing WHERE id = @id",
                    {
                        ['@id'] = res.id
                    })

                for k,v in pairs(BillingTable) do
                    if v.id == res.id then
                        WebhookLogs('bussinesBillDelete', src, BillingTable[k])
                        table.remove(BillingTable, k)
                        break
                    end
                end

                local checkBillAuth = Config.JOBServices[society]?.billing?.pay
                if checkBillAuth then
                    local players = GetExtendedPlayers("job", society)
                    for _, v in pairs(players) do
                        local player = v
                        if player then
                            local xplayerJobName = player.job.name
                            local xplayerJobGrade = player.job.grade or 0
                            if xplayerJobName == society and xplayerJobGrade >= checkBillAuth then
                                TriggerClientEvent('gksphone:client:DeleteBussBill', player.source, res.id)
                            end
                        end
                    end
                end
            else

                PhoneDataDelBilling(res.id, res.citizenid)
                MySQL.Async.fetchAll("DELETE FROM gksphone_billing WHERE id = @id",
                    {
                        ['@id'] = res.id
                    })

                for k,v in pairs(BillingTable) do
                    if v.id == res.id then
                        WebhookLogs('bussinesBillDelete', src, BillingTable[k])
                        table.remove(BillingTable, k)
                        break
                    end
                end
            end

            cb(true)
        else
            local phoneLang = GetPhoneLangBySource(source)
            local notify = {
                title = _T(phoneLang, "BankAPP.Billing.APP_BILLING_TITLE"), -- The title of the notification
                message = _T(phoneLang, "BankAPP.Billing.APP_BILLING_NOBILL"), -- The message of the notification
                icon = "/html/img/icons/wallet.png", -- The icon to be displayed with the notification
                duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:sendNotification(source, notify)
            cb(false)
        end
    end)

end)
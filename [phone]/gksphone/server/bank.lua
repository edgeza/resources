
-- BANK --

--- GKSPHONE v2.0.0 ---
CallBackRegisterServer('gksphone:server:bank:transfer', function(source, cb, money, number, name, phoneUniq)
    local info = {status = false, message = _T(phonedata?.phone_lang, "BankAPP.APP_BANK_SENDMONEY_ERROR")}
    Debugprint("bank transfer start", {money, number, name, phoneUniq})
    if money == nil or number == nil or name == nil or type(money) ~= 'number' then
        Debugprint("bank transfer error1")
        info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_SENDMONEY_ERROR_INVALID")
        cb(info)
        return
    end
    if money <= 0 then
        Debugprint("bank transfer error2")
        info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_QUICKSENDAMOUNTERROR")
        cb(info)
        return
    end
    if PhonesData[phoneUniq] ~= nil then
        local phonedata = PhonesData[phoneUniq]
        if not Config.MetaBankTransfer then
            if phonedata.identifier ~= phonedata.setup_owner then
                Debugprint("bank transfer error4")
                info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_SENDMONEY_ERROR_NOT_OWNER")
                cb(info)
                return
            end
        end
        local yPhoneData = type(number) == "string" and GetPhoneDataByNumber(number) or GetPhoneDataBySource(number)

        if yPhoneData and phonedata.source and yPhoneData.source then
            if yPhoneData.source == phonedata.source or phonedata.identifier == yPhoneData.setup_owner then
                info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_QUICKSENDAMOUNTERROR3")
                cb(info)
                return
            end
            local balance = Config.MetaBankTransfer == true and GetBankBalanceByIndetifier(phonedata.setup_owner) or GetBankBalance(phonedata.source)
            local bankTax = Config.BankTransferTax
            local taxAmount = math.floor(money * (bankTax / 100))
            local amount = math.floor(money + taxAmount)

            if balance < amount then
                info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_QUICKSENDAMOUNTERROR2", {amount = balance})
                cb(info)
                return
            end

            if Config.MetaBankTransfer then
                local phoneOwner = GetPlayerFromIdentifier(phonedata.setup_owner)
                if phoneOwner then
                    RemoveBankMoney(phonedata.setup_owner, tonumber(amount), "identifier")
                else
                    phoneOwner = GetOfflinePlayerByIdentifier(phonedata.setup_owner)
                    if phoneOwner then
                        phoneOwner.removeAccountMoney('bank',  tonumber(amount), "Bank Transfer")
                    end
                end
                local phoneOwnerTwo = GetPlayerFromIdentifier(yPhoneData.setup_owner)
                if phoneOwnerTwo then
                    AddBankMoney(yPhoneData.setup_owner, tonumber(money), "identifier")
                else
                    phoneOwnerTwo = GetOfflinePlayerByIdentifier(yPhoneData.setup_owner)
                    if phoneOwnerTwo then
                        phoneOwnerTwo.addAccountMoney('bank',  tonumber(money), "Bank Transfer")
                    end
                end
            else
                RemoveBankMoney(phonedata.source, tonumber(amount))
                AddBankMoney(yPhoneData.source, tonumber(money))
            end
            

            info.status = true

            local xPlayerTransferDesc = _T(phonedata.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_SENDER", {name = yPhoneData.ownerName})
            local xPlayerTransferFeeDesc = _T(phonedata.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_FEE")
            local yPlayerTransferDesc = _T(yPhoneData.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_RECEIVER", {name = phonedata.ownerName})
            -- bank history save
            local bnkhistoryxPlayer = exports["gksphone"]:bankHistorySave(yPhoneData.phone_number, 1, money, xPlayerTransferDesc, phoneUniq)-- xPlayer amount
            local bnkhistoryFeexPlayer = exports["gksphone"]:bankHistorySave(yPhoneData.phone_number, 1, taxAmount, xPlayerTransferFeeDesc, phoneUniq)-- xPlayer fee


            local bnkhistoryPlayer = exports["gksphone"]:bankHistorySave(phonedata.phone_number, 2, money, yPlayerTransferDesc, yPhoneData.unique_id)-- yPlayer


            local notify = {
                title = _T(yPhoneData?.phone_lang, "BankAPP.APP_BANK_TITLE"),
                message = _T(yPhoneData?.phone_lang, "BankAPP.APP_BANK_TRANSFERNOTIFICATION", {name = phonedata.ownerName, money = money}),
                icon = "/html/img/icons/wallet.png",
                info = "sucess",
            }
            exports["gksphone"]:sendNotification(yPhoneData.source, notify)


            if bnkhistoryxPlayer and bnkhistoryPlayer  then
                Debugprint("bank history save and balance update success")
            else
                Debugprint("bank history save and balance update failed", bnkhistoryxPlayer, bnkhistoryPlayer)
            end
            Wait(1000)
            WebhookLogs("bank", source, {phonedata.phone_number, yPhoneData.phone_number, money, xPlayerTransferDesc, yPlayerTransferDesc, phonedata.identifier, yPhoneData.identifier})

            cb(info)
        elseif Config.OfflineBankTransfer and phonedata.source then
            local sourceIdentifier
            local yphoneUniqID
            if not yPhoneData then
                local getIdentifierByNumber = MySQL.single.await([===[
                    SELECT 
                        c.phone_number,
                        c.phone_id,
                        a.setup_owner
                    FROM gksphone_esim c 
                    INNER JOIN gksphone_settings a 
                        ON c.phone_id = a.unique_id 
                    WHERE c.phone_number = ?;
                    ]===], {number})
                if getIdentifierByNumber then
                    sourceIdentifier =  getIdentifierByNumber.setup_owner
                    yphoneUniqID = getIdentifierByNumber.phone_id
                end
            else
                sourceIdentifier = yPhoneData.setup_owner
                yphoneUniqID = yPhoneData.unique_id
            end
            if sourceIdentifier and yphoneUniqID then
                local yPlayer = GetOfflinePlayerByIdentifier(sourceIdentifier)
                if yPlayer then
                    local balance = Config.MetaBankTransfer == true and GetBankBalanceByIndetifier(phonedata.setup_owner) or GetBankBalance(phonedata.source)
                    local bankTax = Config.BankTransferTax
                    local taxAmount = math.floor(money * (bankTax / 100))
                    local amount = math.floor(money + taxAmount)

                    if balance < amount then
                        info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_QUICKSENDAMOUNTERROR2", {amount = balance})
                        cb(info)
                        return
                    end

                    if Config.MetaBankTransfer then
                        local phoneOwner = GetPlayerFromIdentifier(phonedata.setup_owner)
                        if phoneOwner then
                            RemoveBankMoney(phonedata.setup_owner, tonumber(amount), "identifier")
                        else
                            phoneOwner = GetOfflinePlayerByIdentifier(phonedata.setup_owner)
                            if phoneOwner then
                                phoneOwner.removeAccountMoney('bank',  tonumber(amount), "Bank Transfer")
                            end
                        end
                        yPlayer.addAccountMoney('bank', money, "Bank Transfer")
                    else
                        RemoveBankMoney(phonedata.source, tonumber(amount))
                        yPlayer.addAccountMoney('bank', money, "Bank Transfer")
                    end
                    

                    info.status = true

                    local xPlayerTransferDesc = _T(phonedata?.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_SENDER", {name = yPlayer.getName()})
                    local xPlayerTransferFeeDesc = _T(phonedata?.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_FEE")
                    local yPlayerTransferDesc = _T(yPhoneData?.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_RECEIVER", {name = phonedata.ownerName})
                    -- bank history save
                    local bnkhistoryxPlayer = exports["gksphone"]:bankHistorySave(number, 1, money, xPlayerTransferDesc, phoneUniq)-- xPlayer amount
                    local bnkhistoryFeexPlayer = exports["gksphone"]:bankHistorySave(number, 1, taxAmount, xPlayerTransferFeeDesc, phoneUniq)-- xPlayer fee

                    local bnkhistoryPlayer = exports["gksphone"]:bankHistorySave(phonedata.phone_number, 2, money, yPlayerTransferDesc, yphoneUniqID)-- yPlayer

                    if bnkhistoryxPlayer then
                        Debugprint("bank history save and balance update success")
                    else
                        Debugprint("bank history save and balance update failed", bnkhistoryxPlayer)
                    end
                    Wait(1000)
                    WebhookLogs("bank", source, {phonedata.phone_number, number, money, xPlayerTransferDesc, yPlayerTransferDesc, phonedata.identifier, sourceIdentifier})
                    cb(info)
                else
                    Debugprint("bank transfer error 6")
                    info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_SENDMONEY_ERROR_INVALID")
                    cb(info)
                end
            else
                Debugprint("bank transfer error 7")
                info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_SENDMONEY_ERROR_INVALID")
                cb(info)
            end
        else
            Debugprint("bank transfer error 5")
            info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_SENDMONEY_ERROR_INVALID")
            cb(info)
        end
    else
        Debugprint("bank transfer error 3")
        info.message =  _T(phonedata?.phone_lang, "BankAPP.APP_BANK_SENDMONEY_ERROR_INVALID_PHONE")
        cb(info)
    end
end)

RegisterServerEvent("gksphone:server:BusSendTip")
AddEventHandler("gksphone:server:BusSendTip", function(phoneNumber, amaount)
    local _source = source
    local tip = amaount
    local xPlayer = GetIdentifier(_source)
    local zPlayer = GetPhoneDataByNumber(phoneNumber)
    if xPlayer and zPlayer and zPlayer.source then
        local xPlayerJobData = GetCharacterJob(_source)
        if not xPlayerJobData then
            return
        end
        local jobs = xPlayerJobData.name
        local RemoveSociety = SocietyRemoveMoney(jobs, tip)
        if RemoveSociety then
            AddBankMoney(zPlayer.source, tonumber(tip))
            if zPlayer then
                local notify = {
                    title = _T(zPlayer?.phone_lang, "ServicesAPP.APP_SERVICES_TITLE"),
                    message = _T(zPlayer?.phone_lang, "ServicesAPP.APP_SERVICES_NOTIFY_TIP"),
                    icon = "/html/img/icons/services.png",
                }
                exports["gksphone"]:sendNotification(zPlayer.source, notify)
            end
            TriggerClientEvent("gksphone:client:bussinesTipNotifySucess", _source)
            WebhookLogs("bussinesTip", _source, {job = jobs, amount = tip, phone = phoneNumber, yPlayer = zPlayer.identifier, xPlayer = xPlayer})
        else
            TriggerClientEvent("gksphone:client:bussinesTipNotifyFailed", _source)
        end
    end
end)
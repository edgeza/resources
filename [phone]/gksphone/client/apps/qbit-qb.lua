--- QBCORE Crypto (qbit) ---



---- GKSPHONE v2.0.0 ----

RegisterNUICallback('gksphone:qbitbuy', function(data, cb)
    Config.Core.Functions.TriggerCallback('qb-crypto:server:BuyCrypto', function(CryptoData)
        if CryptoData ~= false then
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "QbitAPP.APP_QBIT_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "QbitAPP.APP_QBIT_NOTIFY_BUYSUCESS"), -- The message of the notification
                icon = "/html/img/icons/qbit.png", -- The icon to be displayed with the notification
              }
            
              -- Trigger the notification using the gksphone exports
              exports["gksphone"]:Notification(notify)
            cb(CryptoData)
        else
            cb(false)
        end
    end, data)
end)

RegisterNUICallback('gksphone:qbitsell', function(data, cb)
    Config.Core.Functions.TriggerCallback('qb-crypto:server:SellCrypto', function(CryptoData)
        if CryptoData ~= false then
            local notify = {
                title = _T(LastItemData?.info?.phoneLang, "QbitAPP.APP_QBIT_TITLE"), -- The title of the notification
                message = _T(LastItemData?.info?.phoneLang, "QbitAPP.APP_QBIT_NOTIFY_SELLSUCESS"), -- The message of the notification
                icon = "/html/img/icons/qbit.png", -- The icon to be displayed with the notification
              }
            
              -- Trigger the notification using the gksphone exports
              exports["gksphone"]:Notification(notify)
            cb(CryptoData)
        else
            cb(false)
        end
    end, data)
end)

RegisterNUICallback('gksphone:qbittransfer', function(data, cb)
    Debugprint("CryptoTransfer Event", data)
    CallBackServerTrigger('gksphone:server:getWalletID', function(WalletID)
        Debugprint("CryptoTransfer Event" , WalletID)
        if WalletID then
            data.WalletId = WalletID
            Debugprint("CryptoTransfer Event" , data.WalletId)
            CreateThread(function()
                Config.Core.Functions.TriggerCallback('qb-crypto:server:TransferCrypto', function(CryptoData)
                    if CryptoData ~= false then
                        local notify = {
                            title = _T(LastItemData?.info?.phoneLang, "QbitAPP.APP_QBIT_TITLE"), -- The title of the notification
                            message = _T(LastItemData?.info?.phoneLang, "QbitAPP.APP_QBIT_NOTIFY_TRANSFERSUCESS"), -- The message of the notification
                            icon = "/html/img/icons/qbit.png", -- The icon to be displayed with the notification
                          }
                        
                          -- Trigger the notification using the gksphone exports
                          exports["gksphone"]:Notification(notify)
                        cb(CryptoData)
                    else
                        cb(false)
                    end
                end, data)
            end)
        end
    end, data)
end)

RegisterNUICallback('gksphone:getCryptoData', function(data, cb)
    Config.Core.Functions.TriggerCallback('qb-crypto:server:GetCryptoData', function(CryptoData)
        cb(CryptoData)
    end, "qbit")
end)
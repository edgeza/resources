--- @param data: { id: number, price: number, reason: string }
--- @param id: Server id
--- @param price: Price of charge
--- @param reason: Reason for charge
RegisterNUICallback('createCharge', function(data, cb)
    if not cache.citizenid then cache.citizenid = bridge.getIdentifier() end
    if not config.billing or config.billing == 'scriptname' then print("^5[dusa_mdt] ^1It seems you havent set a billing & invoice system yet. Please configure it^0") end

    local str = 'Player billed a player. \n \n **Bill Details** \n Creator Of Bill: %s \n Target (Player who get billed) ID: %s \n Reason: %s \n Amount of bill: %s'
    local message = str:format(bridge.getName(), data.id, data.reason, data.price)

    TriggerServerEvent('dusa_mdt:sendwebhook', 'Billed Player', message, nil, 'user_charge')
    if config.billing == "dusabilling" then
        TriggerServerEvent('dusa_billing:sv:createCustomInvoice', data.id, "Police MDT", data.reason, data.price, "company")
    elseif config.billing == "okokbilling" then
        TriggerServerEvent("okokBilling:CreateCustomInvoice", data.id, data.price, data.reason, "Police MDT", "police", "LSPD")
    elseif config.billing == "quasarbilling" then
        TriggerServerEvent('qs-billing:server:CreateInvoice', data.id, 'Police MDT', data.reason, data.price, true, false, false, false, "police" or nil)
    elseif config.billing == "codestudiobilling" then
        exports['cs_billing']:createBill({playerID = data.id, society = 'police', society_name = 'LSPD', amount = data.price, senderID = source, title = 'Police MDT', notes = data.reason,
        })
    elseif config.billing == "esxbilling" then
        TriggerServerEvent('esx_billing:sendBill', data.id, 'society_police', 'Police MDT', data.price)
    elseif config.billing == "jimpayment" then
        TriggerServerEvent('jim-payments:Tickets:Give', { sender = bridge.getName(), senderCitizenId = cache.citizenid, society = 'police', amount = data.price })
    elseif config.billing == "jaksam" then
        TriggerServerEvent("billing_ui:sendBill", data.id, 'society_police', data.reason, data.price)
    else
        print("^1Invalid billing system. Please check your config.lua file.^0")
    end
    cb("ok")
end)

--- @param data: { id: number, time: number, reason: string, type: string }
--- @param id: Server id
--- @param time: Time
--- @param reason: Reason for jailing
--- @param type: Type of time (hour, day, minute)
RegisterNUICallback('sendtoJail', function(data, cb)
    -- this code block will convert data.time to minute form for popular jail systems
    local minute = data.time -- minute value to show at log system
    if data.type == "hour" then data.time = data.time * 60
    elseif data.type == "day" then data.time = data.time * 1440 end

    if not config.jail or config.jail == 'scriptname' then print("^5[dusa_mdt] ^1It seems you havent set a jail system yet. Please configure it^0") end
    
    local str = 'Player jailed a player. \n \n **Jail Details** \n Who Jail: %s \n Target (Player who get jailed) ID: %s \n Reason: %s \n For Time (minutes): %s'
    local message = str:format(bridge.getName(), data.id, data.reason, minute)
    
    TriggerServerEvent('dusa_mdt:sendwebhook', 'Jailed Player', message, nil, 'user_charge')
    
    if config.jail == "pickle" then
        TriggerServerEvent('pickle_prisons:jailPlayer', data.id, data.time)
    elseif config.jail == "esxjail" then
        TriggerServerEvent('esx-qalle-jail:jailPlayer', data.id, data.time, data.reason)
    elseif config.jail == "rcore" then
        exports.rcore_prison:Jail(data.id, data.time)
    elseif config.jail == "tkjail" then
        exports['tk_jail']:jail(data.id, data.time)
    elseif config.jail == "rs-prison" then
        exports['tk_jail']:jail(data.id, data.time)
    else
        print("^1Invalid jail system. Please check your config.lua file.^0")
    end
    cb("ok")
end)

--- @param data: { id: number, amount: number, reason: string }
--- @param id: Server id
--- @param amount: Amount of community service
--- @param reason: Reason for community service
RegisterNUICallback('sendtoCommunityService', function(data, cb)
    if not config.communityservice or config.communityservice == 'scriptname' then print("^5[dusa_mdt] ^1It seems you havent set community service system yet. Please configure it^0") end

    local str = 'Player sent player to community service. \n \n **Service Details** \n Sender: %s \n Target (Player who sent to service) ID: %s \n Reason: %s \n Service Count: %s'
    local message = str:format(bridge.getName(), data.id, data.reason, data.amount)

    TriggerServerEvent('dusa_mdt:sendwebhook', 'Community Service', message, nil, 'user_charge')

    if config.communityservice == "esxcommunityservice" then
        TriggerServerEvent('esx_communityservice:sendToCommunityService', data.id, data.amount, data.reason)
    elseif config.communityservice == "qbcommunityservice" then
        TriggerServerEvent("qb-communityservice:server:StartCommunityService", data.id, data.amount)
    else
        print("^1Invalid community service system. Please check your config.lua file.^0")
    end
    cb("ok")
end)
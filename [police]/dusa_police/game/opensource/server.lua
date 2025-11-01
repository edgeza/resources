if not rawget(_G, "lib") then include('ox_lib', 'init') end

function Log(_source, message, type, metadata)
    local LogProperties = {
        resource = Bridge.Resource,
        message = message,
        type = type,
        metadata = metadata
    }

    if ServerConfig.LogService == 'fivemerr' then
        exports['fm-logs']:createLog({
            LogType = LogProperties.type,
            Resource = LogProperties.resource,
            Message = LogProperties.message,
            Metadata = LogProperties.metadata
        })
    elseif ServerConfig.LogService == 'fivemanage' then
        exports.fmsdk:LogMessage("warning", "Police Job Exploiter", metadata)
    end
end

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() ~= resource then return end

    -- creating societies of job
    Wait(5000)
    
    if GetResourceState('esx_society') == 'started' then 
        for _, job in pairs(Config.PoliceJobs) do
            TriggerEvent('esx_society:registerSociety', job, job, 'society_'..job, 'society_'..job, 'society_'..job, {type = 'public'})
        end
    end
end)

local function checkSocietyAccount(job)
    if GetResourceState('esx_society') ~= 'started' then return end
    
    local society = exports['esx_society']:GetSociety(job)
    if not society then
        society = exports['esx_society']:GetSociety('society_'..job)
    end

    return society
end

RegisterServerEvent('police:server:addAccountMoney', function(money)
    local source = source
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    local pJob = Player.Job.Name

    if not SecureCheck(source, 'money') then return end

    local esxSociety = GetResourceState('esx_society') == 'started'
    if not esxSociety and not Player.RemoveMoney('bank', money) then
        return Framework.Notify(source, locale('boss.not_enough_money'), 'error')
    end

    local function handleSocietyDeposit(society)
        if not society then
            print(('[^3WARNING^7] Player ^5%s^7 attempted to deposit to non-existing society - ^5%s^7!'):format(source, pJob))
            return
        end

        if pJob ~= society.name then
            print(('[^3WARNING^7] Player ^5%s^7 attempted to deposit to society - ^5%s^7!'):format(source, society.name))
            return
        end

        TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
            if not Player.RemoveMoney('bank', money) then
                Framework.Notify(source, locale('boss.not_enough_money'), 'error')
                return
            end
            account.addMoney(money)
        end)
    end

    if GetResourceState('Renewed-Banking') == 'started' then
        exports['Renewed-Banking']:addAccountMoney(pJob, money)
    elseif GetResourceState('qb-banking') == 'started' then
        exports['qb-banking']:AddMoney(pJob, money, 'police-deposit-boss')
    elseif GetResourceState('tgg-banking') == 'started' then
        exports['tgg-banking']:AddSocietyMoney(pJob, money)
    elseif GetResourceState('fd_banking') == 'started' then
        exports['fd_banking']:AddMoney(pJob, money, 'police-deposit-boss')
    elseif esxSociety then
        local society = checkSocietyAccount(pJob)
        handleSocietyDeposit(society)
    else
        print('[^3WARNING^7] We couldn\'t find your account money management script. Please head into dusa_police/game/opensource/server.lua and set your methods!')
    end

    Framework.Notify(source, locale('boss.deposited', money), 'success')
end)

RegisterServerEvent('police:server:removeAccountMoney', function(money)
    local source = source
    local Player = Framework.GetPlayer(source)
    if not Player then return end

    local pJob = Player.Job.Name

    if not SecureCheck(source, 'money') then return end

    if not money or money <= 0 then
        return
    end

    local function handleSocietyWithdraw(society)
        if not society then
            print(('[^3WARNING^7] Player ^5%s^7 attempted to deposit to non-existing society - ^5%s^7!'):format(source, pJob))
            return
        end

        if pJob ~= society.name then
            print(('[^3WARNING^7] Player ^5%s^7 attempted to deposit to society - ^5%s^7!'):format(source, society.name))
            return
        end

        TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
            if money > 0 and account.money >= money then
                account.removeMoney(money)
                Player.AddMoney('bank', money)
                return
            else
                Framework.Notify(source, locale('boss.account_not_enough_money'), 'error')
                return
            end
        end)
    end

    if GetResourceState('Renewed-Banking') == 'started' then
        local accountMoney = exports['Renewed-Banking']:getAccountMoney(pJob)
        if accountMoney < money then
            return Framework.Notify(source, locale('boss.account_not_enough_money'), 'error')
        end
        exports['Renewed-Banking']:removeAccountMoney(pJob, money)
    elseif GetResourceState('qb-banking') == 'started' then
        local accountMoney = exports['qb-banking']:GetAccountBalance(pJob)
        if accountMoney < money then
            return Framework.Notify(source, locale('boss.account_not_enough_money'), 'error')
        end
        exports['qb-banking']:RemoveMoney(pJob, money, 'police-withdraw-boss')
    elseif GetResourceState('tgg-banking') == 'started' then
        local accountMoney = exports['tgg-banking']:GetSocietyAccountMoney(pJob)
        if accountMoney < money then
            return Framework.Notify(source, locale('boss.account_not_enough_money'), 'error')
        end
        exports['tgg-banking']:RemoveSocietyMoney(pJob, money)
    elseif GetResourceState('fd_banking') == 'started' then
        local accountMoney = exports['fd_banking']:GetAccount(pJob)
        if accountMoney < money then
            return Framework.Notify(source, locale('boss.account_not_enough_money'), 'error')
        end
        exports['fd_banking']:RemoveMoney(pJob, money, 'police-withdraw-boss')
    elseif GetResourceState('esx_society') == 'started' then
        local society = checkSocietyAccount(pJob)
        handleSocietyWithdraw(society)
    else
        print('[^3WARNING^7] We couldn\'t find your account money management script. Please head into dusa_police/game/opensource/server.lua and set your methods!')
    end

    Player.AddMoney('bank', money)
    Framework.Notify(source, locale('boss.withdrawn', money), 'success')
end)

lib.callback.register('police:server:getAccountMoney', function (source)
    local src = source
    local Player = Framework.GetPlayer(src)
    if not Player then return end

    local pJob = Player.Job.Name
    local accountMoney = 0

    local function handleSocietyBalance(society)
        if not society then
            print(('[^3WARNING^7] Player ^5%s^7 attempted to deposit to non-existing society - ^5%s^7!'):format(source, pJob))
            return
        end

        if pJob ~= society.name then
            print(('[^3WARNING^7] Player ^5%s^7 attempted to deposit to society - ^5%s^7!'):format(source, society.name))
            return
        end

        TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
            accountMoney = account.money
        end)
    end

    if GetResourceState('Renewed-Banking') == 'started' then
        accountMoney = exports['Renewed-Banking']:getAccountMoney(pJob)
    elseif GetResourceState('qb-banking') == 'started' then
        accountMoney = exports['qb-banking']:GetAccountBalance(pJob)
    elseif GetResourceState('tgg-banking') == 'started' then
        accountMoney = exports['tgg-banking']:GetSocietyAccountMoney(pJob)
    elseif GetResourceState('fd_banking') == 'started' then
        accountMoney = exports['fd_banking']:GetAccount(pJob)
    elseif GetResourceState('esx_society') == 'started' then
        local society = checkSocietyAccount(pJob)
        handleSocietyBalance(society)
    elseif GetResourceState('okokBanking') == 'started' then
        local db
        MySQL.Async.fetchAll('SELECT * FROM okokBanking_societies WHERE society = @society', {
            ['@society'] = pJob
        }, function(result)
            db = result[1]
            accountMoney = db.value
        end)
    else
        print('[^3WARNING^7] We couldn\'t find your account money management script. Please head into dusa_police/game/opensource/server.lua and set your methods!')
        print('[^3WARNING^7] If you dont know how to integrate, open ticket and ask for integration. discord.gg/dusa')
    end

    return accountMoney
end)

local updatingCops = false

RegisterNetEvent('police:server:UpdateCurrentCops', function()
    local amount = 0
    local players = Framework.GetPlayers()
    if updatingCops then return end
    updatingCops = true
    for _, v in pairs(players) do
        local PlayerData = v.PlayerData
        local job, onDuty
        if Bridge.Framework == 'esx' then
            job = PlayerData.getJob and PlayerData.getJob().name or (PlayerData.job and PlayerData.job.name)
            onDuty = true
        else
            job = PlayerData.job and PlayerData.job.name
            onDuty = PlayerData.job and PlayerData.job.onduty
        end
        if job and Functions.IsLEO(job) and onDuty then
            amount += 1
        end
    end
    TriggerClientEvent('police:SetCopCount', -1, amount)
    updatingCops = false
end)
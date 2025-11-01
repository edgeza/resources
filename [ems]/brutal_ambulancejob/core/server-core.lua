Core = nil

if Config['Core']:upper() == 'ESX' then
    local _esx_ = 'new' -- 'new' / 'old'
    
    if _esx_ == 'new' then
        Core = exports['es_extended']:getSharedObject()
    else
        Core = nil
        TriggerEvent('esx:getSharedObject', function(obj) Core = obj end)
        while Core == nil do
            Citizen.Wait(0)
        end
    end

    RESCB = Core.RegisterServerCallback
    GETPFI = Core.GetPlayerFromId
    RUI = Core.RegisterUsableItem
    onPlayerDeath = 'esx:onPlayerDeath'

    function GetIdentifier(source)
        local xPlayer = GETPFI(source)
        while xPlayer == nil do
            Citizen.Wait(1000)
            xPlayer = GETPFI(source) 
        end
        return xPlayer.identifier
    end

    function GetPlayerByIdentifier(identifier)
        return Core.GetPlayerFromIdentifier(identifier)
    end

    function GetAccountMoney(source,account)
        local xPlayer = GETPFI(source)
        if account == 'bank' then
            return xPlayer.getAccount(account).money
        elseif account == 'money' then
            return xPlayer.getMoney()
        end
    end

    function AddMoneyFunction(source, account, amount)
        local xPlayer = GETPFI(source)
        if account == 'bank' then
            xPlayer.addAccountMoney('bank', amount)
        elseif account == 'money' then
            xPlayer.addMoney(amount)
        end
    end

    function RemoveAccountMoney(source, account, amount)
        local xPlayer = GETPFI(source)
        if account == 'bank' then
            xPlayer.removeAccountMoney('bank', amount)
        elseif account == 'money' then
            xPlayer.removeMoney(amount)
        end
    end

    function GetItemCount(source, item)
        local xPlayer = GETPFI(source)
        local items = xPlayer.getInventoryItem(item)

        if _esx_ == 'new' then
            if GetResourceState("codem-inventory") == "started" then
                return exports['codem-inventory']:GetItemsTotalAmount(source, item)
            elseif GetResourceState("qs-inventory") == "started" then    
                return exports['qs-inventory']:GetItemTotalAmount(source, item)
            elseif items ~= nil then     
                return items.count
            else    
                print("^1PROBLEM!^3 The ^7items ^3are not created. Create them from our documentation. https://docs.brutalscripts.com/site/scripts/ambulance-job/installation-guide")
            end
        else
            if string.sub(item, 0, 6):lower() == 'weapon' then
                local loadoutNum, weapon = xPlayer.getWeapon(item:upper())

                if weapon then
                    return true
                else
                    return false
                end
            elseif items ~= nil then     
                return items.count
            else    
                print("^1PROBLEM!^3 The ^7items ^3are not created. Create them from our documentation. https://docs.brutalscripts.com/site/scripts/ambulance-job/installation-guide")
            end
        end
    end
    
    function RemoveItem(source, item, amount)
        local xPlayer = GETPFI(source)
        if _esx_ == 'new' then
            xPlayer.removeInventoryItem(item, amount)
        else
            if string.sub(item, 0, 6):lower() == 'weapon' then
                xPlayer.removeWeapon(item)
            else
                xPlayer.removeInventoryItem(item, amount)
            end
        end
    end

    function AddItem(source, item, count)
        local xPlayer = GETPFI(source)
        if _esx_ == 'new' then
            xPlayer.addInventoryItem(item, count)
        else
            if string.sub(item, 0, 6):lower() == 'weapon' then
                xPlayer.addWeapon(item, 90)
            else
                xPlayer.addInventoryItem(item, count)
            end
        end
    end

    function GetPlayerNameFunction(source)
        local name
        if Config.SteamName then
            name = GetPlayerName(source)
        else
            local xPlayer = GETPFI(source)
            name = xPlayer.getName() or 'No Data'
        end
        return name
    end

    function GetPlayerSex(source)
        local xPlayer = GETPFI(source)
        return xPlayer.get("sex")
    end

    function GetPlayerJob(source)
        local xPlayer = GETPFI(source)
        return xPlayer.job.name
    end

elseif Config['Core']:upper() == 'QBCORE' then

    Core = exports['qb-core']:GetCoreObject()
    
    RESCB = Core.Functions.CreateCallback
    GETPFI = Core.Functions.GetPlayer
    RUI = Core.Functions.CreateUseableItem

    function GetIdentifier(source)
        local xPlayer = GETPFI(source)
        while xPlayer == nil do
            Citizen.Wait(1000)
            xPlayer = GETPFI(source) 
        end
        return xPlayer.PlayerData.citizenid
    end

    function GetPlayerByIdentifier(identifier)
        return Core.Functions.GetPlayerByCitizenId(identifier)
    end

    function GetPlayersFunction()
        return Core.Functions.GetPlayers()
    end

    function GetAccountMoney(source, account)
        local xPlayer = GETPFI(source)
        if account == 'bank' then
            return xPlayer.PlayerData.money.bank
        elseif account == 'money' then
            return xPlayer.PlayerData.money.cash
        end
    end

    function AddMoneyFunction(source, account, amount)
        local xPlayer = GETPFI(source)
        if account == 'bank' then
            xPlayer.Functions.AddMoney('bank', amount)
        elseif account == 'money' then
            xPlayer.Functions.AddMoney('cash', amount)
        end
    end

    function RemoveAccountMoney(source, account, amount)
        local xPlayer = GETPFI(source)
        if account == 'bank' then
            xPlayer.Functions.RemoveMoney('bank', amount)
        elseif account == 'money' then
            xPlayer.Functions.RemoveMoney('cash', amount)
        end
    end

    function GetItemCount(source, item)
        local xPlayer = GETPFI(source)
        local items = xPlayer.Functions.GetItemByName(item)

        if GetResourceState("codem-inventory") == "started" then
            return exports['codem-inventory']:GetItemsTotalAmount(source, item)
        elseif GetResourceState("qs-inventory") == "started" then    
            return exports['qs-inventory']:GetItemTotalAmount(source, item)
        elseif GetResourceState("qb-inventory") == "started" then    
            return exports['qb-inventory']:GetItemCount(source, item)
        elseif GetResourceState("ox_inventory") == "started" then    
            return exports.ox_inventory:GetItemCount(source, item)
        elseif items ~= nil then
            return items.amount or 0
        else    
            print("^1PROBLEM!^3 The ^7items ^3are not created. Create them from our documentation. https://docs.brutalscripts.com/site/scripts/ambulance-job/installation-guide")
        end    
    end

    function RemoveItem(source, item, amount)
        local xPlayer = GETPFI(source)
        xPlayer.Functions.RemoveItem(item, amount)
    end

    function AddItem(source, item, count)
        local xPlayer = GETPFI(source)
        xPlayer.Functions.AddItem(item, count)
    end

    function GetPlayerNameFunction(source)
        local name
        if Config.SteamName then
            name = GetPlayerName(source)
        else
            local xPlayer = GETPFI(source)
            name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname
        end
        return name
    end

    function GetPlayerSex(source)
        local xPlayer = GETPFI(source)
        local sex = xPlayer.PlayerData.charinfo.gender

        if sex == 0 then
            sex = 'm'
        else
            sex = 'f'
        end

        return sex
    end

    function GetPlayerJob(source)
        local xPlayer = GETPFI(source)
        return xPlayer.PlayerData.job.name
    end

    function GetPlayerDeathMetaData(source)
        local xPlayer = GETPFI(source)
        return xPlayer.PlayerData.metadata['isdead']
    end

    function SetPlayerDeathMetaData(source, isDead)
        local xPlayer = GETPFI(source)
        xPlayer.Functions.SetMetaData("isdead", isDead)
    end

end
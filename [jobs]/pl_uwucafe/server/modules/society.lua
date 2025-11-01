local SocietyResource = GetSociety()
function AddSocietyMoney(account, money)
    if SocietyResource == 'esx_addonaccount' then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..account, function(account)
            account.addMoney(money)
        end)
    elseif SocietyResource == 'qb-management' then
        exports['qb-management']:AddMoney(account, money)
    elseif SocietyResource == 'qb-banking' then
        exports['qb-banking']:AddMoney(account, money)
    elseif SocietyResource == 'okokBanking' then
        exports["okokBanking"]:AddMoney(account, money)
    elseif SocietyResource == 'Renewed-Banking' then
        exports['Renewed-Banking']:addAccountMoney(account, money)
    end
end

function RemoveSocietyMoney(account, money)
    if SocietyResource == 'esx_addonaccount' then
        TriggerEvent("esx_society:getSociety", account, function(society)
            TriggerEvent("esx_addonaccount:getSharedAccount", society.account, function(account)
            account.removeMoney(money)
        end)
    end)
    elseif SocietyResource == 'qb-management' then
        exports['qb-management']:RemoveMoney(account, money)
    elseif SocietyResource == 'qb-banking' then
        exports["qb-banking"]:RemoveMoney(account, money)
    elseif SocietyResource == 'okokBanking' then
        exports["okokBanking"]:RemoveMoney(account, money)
    elseif SocietyResource == 'Renewed-Banking' then
        exports['Renewed-Banking']:RemoveMoney(account, money)
    end
end

function GetSocietyMoney(account)
    if SocietyResource == 'esx_addonaccount' then
        local balance = promise.new()
        TriggerEvent("esx_society:getSociety", account, function(data)
          if not data then return balance:resolve(0) end

          TriggerEvent("esx_addonaccount:getSharedAccount", data.account, function(account)
            return balance:resolve(account.money)
          end)
        end)
        return Citizen.Await(balance)
    elseif SocietyResource == 'qb-management' then
        return exports["qb-management"]:GetAccount(account)
    elseif SocietyResource == 'qb-banking' then
        return exports["qb-banking"]:GetAccountBalance(account)
    elseif SocietyResource == 'okokBanking' then
        return exports["okokBanking"]:GetAccount(account)
    elseif SocietyResource == 'Renewed-Banking' then
        exports['Renewed-Banking']:GetAccount(account)
    end
end
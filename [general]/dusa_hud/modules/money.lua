-- Money

RegisterNetEvent("QBCore:Player:SetPlayerData")
AddEventHandler("QBCore:Player:SetPlayerData", function(data)
    -- Cash and bank both show as whole numbers
    SetInfo('setCash', math.floor(data.money.cash))
    SetInfo('setBank', math.floor(data.money.bank))
    if data.items then
        for _,v in pairs(data.items) do
            if v and v.name == 'markedbills' then
                SetInfo('setBlackMoney', v.amount)
            end
        end
    end    
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    if account.name == 'black_money' then                            
        SetInfo('setBlackMoney', account.money)
    end
    local uiAccount = account.name
    if uiAccount == 'money' then uiAccount = 'cash' end
    local set = 'set'..uiAccount:sub(1,1):upper()..uiAccount:sub(2)
    SetInfo(set, account.money)
end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney", function(a, b, m)
    Wait(1500)
    local PlayerData = shared.playerdata
    for _,v in pairs(PlayerData.accounts) do
        if v.name == 'bank' then
            SetInfo('setBank', math.floor(v.money))
        end
        if v.name == 'money' then
            SetInfo('setCash', math.floor(v.money))
        end
    end
end)

RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney", function(a, b, m)
    Wait(1500)
    local PlayerData = shared.playerdata
    for _,v in pairs(PlayerData.accounts) do
        if v.name == 'bank' then
            SetInfo('setBank', math.floor(v.money))
        end
        if v.name == 'money' then
            SetInfo('setCash', math.floor(v.money))
        end
    end
end)

if shared.framework == 'esx' then
    function GetBlackMoney()
        if not shared.playerdata.accounts then return 0 end
        for _,v in pairs(shared.playerdata.accounts) do
            if v.name == 'black_money' then
                return v.money
            end
        end
    end
else
    function GetBlackMoney()
        for _, v in pairs(shared.playerdata.items) do
            if v and v.name == 'markedbills' then
                return v.amount
            end
        end
        return 0
    end
end

RegisterCommand('cash', function()
    local cash = GetMoneyInfo('cash')
    notify('Your current cash amount is '..cash..'$', 'info')
end)

RegisterCommand('bank', function()
    local bank = GetMoneyInfo('bank')
    notify('Your current bank amount is '..bank..'$', 'info')
end)
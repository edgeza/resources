local resourceName = 'es_extended'

if not GetResourceState(resourceName):find('start') then return end
importCore('esx')

function GetPlayer(source)
    return ESX.GetPlayerFromId(source)
end

function GetIdentifier(source)
    local player = GetPlayer(source)
    return player.identifier
end

-- @@@ type: bank, money
function GetMoney(source, type)
    if type == 'cash' then type = 'money' end
    local player = GetPlayer(source)
    local account = player.getAccount(type)
    -- Return money as whole number
    return math.floor(account.money)
end

function notify(source, message, type)
    -- local player = GetPlayer(source)
    -- player.Functions.Notify(message, type)

    TriggerClientEvent('ox_lib:notify', source, {
        description = message,
        type = type,
        duration = 5000,
    })
end
local resourceName = 'qb-core'

if not GetResourceState(resourceName):find('start') then return end
importCore('qb')

function GetPlayer(source)
    if not source then return end
    return QBCore.Functions.GetPlayer(source)
end

function GetIdentifier(source)
    local player = GetPlayer(source)
    if not player then return end
    return player.PlayerData.citizenid
end

-- @@@ type: bank, cash
function GetMoney(source, type)
    local player = GetPlayer(source)
    if not player then return end
    local money = player.Functions.GetMoney(type)
    -- Bank and cash both show as whole numbers
    return math.floor(money)
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
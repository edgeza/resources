if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()
dusa = {}
dusa.framework = 'qb'
dusa.inventory = 'qb'
dusa.guitarData = {}
dusa.allGroups = {}
dusa.allPlayers = {}

---@diagnostic disable: duplicate-set-field

function dusa.getPlayer(source)
    return QBCore.Functions.GetPlayer(source)
end

function dusa.getName(player)
    if not player then return false end
    return player.PlayerData.charinfo.firstname.. " "..player.PlayerData.charinfo.lastname
end

function dusa.registerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function dusa.getIdentifier(source)
    local player = dusa.getPlayer(source)
    return player.PlayerData.citizenid
end

function dusa.getPlayerFromIdentifier(identifier)
    local player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if not player then return false end
    return player
end

function dusa.playerSrc(player)
    local source = player.PlayerData.source
    if not source then return false end
    return source
end

function dusa.addItem(source, item, count, slot, metadata)
    local player = dusa.getPlayer(source)
    if not player then return end
    local giveItem = player.Functions.AddItem(item, count, slot, metadata)
    item = player.Functions.GetItemByName(item)
    if item?.count then item.count = count elseif item?.amount then item.amount = count end
    TriggerClientEvent('inventory:client:ItemBox', source,  item, 'add')
    return giveItem
end

function dusa.removeItem(source, item, count, slot, metadata)
    local player = dusa.getPlayer(source)
    player.Functions.RemoveItem(item, count, slot, metadata)
end

function dusa.registerUsableItem(item, cb)
    QBCore.Functions.CreateUseableItem(item, cb)
end

function dusa.addMoney(source, type, amount)
    if type == 'money' then type = 'cash' end
    local player = dusa.getPlayer(source)
    player.Functions.AddMoney(type, amount)
end

function dusa.removeMoney(source, type, amount)
    if type == 'money' then type = 'cash' end
    if type == 'card' then type = 'bank' end
    local player = dusa.getPlayer(source)
    player.Functions.RemoveMoney(type, amount)
end

function dusa.getMoney(source, type)
    if type == 'money' then type = 'cash' end
    local player = dusa.getPlayer(source)
    return player.Functions.GetMoney(type)
end

dusa.registerUsableItem(Config.StandItem, function(source)
    TriggerClientEvent('dusa_guitarzero:startPlacing', source, {obj = 'dance_station', type = 'stand', item = Config.StandItem})
end)
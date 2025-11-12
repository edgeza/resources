if GetResourceState('es_extended') ~= 'started' then return end
ESX = exports['es_extended']:getSharedObject()
dusa = {}
dusa.framework = 'esx'
dusa.inventory = 'default'
dusa.guitarData = {}
dusa.allGroups = {}
dusa.allPlayers = {}

---@diagnostic disable: duplicate-set-field

function dusa.getPlayer(source)
    return ESX.GetPlayerFromId(source)
end

function dusa.getName(player)
    if not player then return false end
    return player.getName()
end

function dusa.registerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function dusa.getIdentifier(source)
    local player = dusa.getPlayer(source)
    if not player then return false end
    return player.identifier
end

function dusa.getPlayerFromIdentifier(identifier)
    local player = ESX.GetPlayerFromIdentifier(identifier)
    if not player then return false end
    return player
end

function dusa.playerSrc(player)
    local source = player.source
    if not source then return false end
    return source
end

function dusa.addItem(source, item, count, slot, metadata)
    local player = dusa.getPlayer(source)
    return player.addInventoryItem(item, count)
end

function dusa.removeItem(source, item, count, slot, metadata)
    local player = dusa.getPlayer(source)
    player.removeInventoryItem(item, count)
end

function dusa.registerUsableItem(item, cb)
    ESX.RegisterUsableItem(item, cb)
end

function dusa.addMoney(source, type, amount)
    if type == 'cash' then type = 'money' end
    local player = dusa.getPlayer(source)
    player.addAccountMoney(type, amount)
end

function dusa.removeMoney(source, type, amount)
    if type == 'cash' then type = 'money' end
    local player = dusa.getPlayer(source)
    player.removeAccountMoney(type, amount)
end

function dusa.getMoney(source, type)
    if type == 'cash' then type = 'money' end
    local player = dusa.getPlayer(source)
    return player.getAccount(type).money
end

dusa.registerUsableItem(Config.StandItem, function(source)
    TriggerClientEvent('dusa_guitarzero:startPlacing', source, {obj = 'dance_station', type = 'stand', item = Config.StandItem})
end)
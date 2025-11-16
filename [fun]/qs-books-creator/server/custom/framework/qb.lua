if Config.Framework ~= 'qb' then return end

QBCore = exports['qb-core']:GetCoreObject()

function RegisterUsableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, cb)
end

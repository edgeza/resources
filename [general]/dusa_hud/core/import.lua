function importCore(coreName)
    local counter = 0
    local object = nil

    if coreName == 'qb' then
        QBCore = exports["qb-core"]:GetCoreObject()
        shared.framework = 'qb'
        object = QBCore
    elseif coreName == 'esx' then
        ESX = exports['es_extended']:getSharedObject()
        shared.framework = 'esx'
        object = ESX
    end

    if not object then shared.framework = 'standalone' end

    dp('Imported core: ' .. coreName)
end
if isBridgeLoaded('Framework', Framework.QBCore) then
    local QBCore = nil

    local success = pcall(function()
        QBCore = exports[Framework.QBCore]:GetCoreObject()
    end)

    if not success then
        success = pcall(function()
            QBCore = exports[Framework.QBCore]:GetSharedObject()
        end)
    end

    if not success then
        local breakPoint = 0
        while not QBCore do
            Wait(100)
            TriggerEvent('QBCore:GetObject', function(obj)
                QBCore = obj
            end)

            breakPoint = breakPoint + 1
            if breakPoint == 25 then
                log.error('Could not load the sharedobject, are you sure it is called \'QBCore:GetObject\'?')
                break
            end
        end
    end

    Framework.object = QBCore

    function Framework.getIdentifier(client)
        client = tonumber(client)
        local player = QBCore.Functions.GetPlayer(client)
        if player == nil then return nil end

        return player.PlayerData.citizenid
    end

    function Framework.getJob(client)
        local player = QBCore.Functions.GetPlayer(client)
        if player == nil then return nil end

        return {
            name = player.PlayerData.job.name,
            grade = player.PlayerData.job.grade_name,
        }
    end

    function Framework.getCharacterName(client)
        local player = QBCore.Functions.GetPlayer(client)
        if player == nil then return nil end

        local firstname = player.PlayerData.charinfo.firstname
        local lastname = player.PlayerData.charinfo.lastname
        return string.format('%s %s', firstname, lastname)
    end

    function Framework.sendNotification(client, message, type)
        TriggerClientEvent('QBCore:Notify', tonumber(client), message, type, 5000)
    end

    function Framework.isAdmin(client)
        for _, adminGroup in ipairs(Config.FrameworkAdminGroups[Bridge.Framework]) do
            if QBCore.Functions.HasPermission(client, adminGroup) then
                return true
            end
        end

        return false
    end

    RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
        local client = source
        TriggerEvent('rcore_xmas:bridge:playerLoaded', client)
    end)
end

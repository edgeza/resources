if isBridgeLoaded('Framework', Framework.Standalone) then
    function Framework.getIdentifier(client)
        return GetPlayerIdentifierByType(client, 'license')
    end

    function Framework.getJob(client)
        return nil
    end

    function Framework.getCharacterName(client)
        return GetPlayerName(client)
    end

    function Framework.sendNotification(client, message, type)
        log.warn('Usage of Framework.sendNotification: Not implemented for standalone mode')
    end

    function Framework.isAdmin(client)
        return IsPlayerAceAllowed(client, 'rcore_xmas.admin')
    end

    RegisterNetEvent('rcore_xmas:bridge:standalonePlayerActivated', function()
        local client = source
        TriggerEvent('rcore_xmas:bridge:playerLoaded', client)
    end)
end

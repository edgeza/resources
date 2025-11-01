------------
--- Items
Framework.CreateUseableItem(Config.EvidenceItem, function(source)
    if not Config.UseItem then return end

    local src = source
    local Player = Framework.GetPlayer(src)

    if not Functions.isLeo(Player.Job.Name) then return Framework.Notify(src, locale('you_are_not_leo'), 'error') end

    -- not using remove item after use, because its tablet

    TriggerClientEvent(Bridge.Resource .. ':evidence:client:OpenEvidenceTablet', src)
end)

if Config.IsEnabled.fingerprint then
    Framework.CreateUseableItem(Config.FingerprintItem, function(source)
        local src = source
        local Player = Framework.GetPlayer(src)

        if not Functions.isLeo(Player.Job.Name) then return Framework.Notify(src, locale('you_are_not_leo'), 'error') end

        -- keep glass or remove it
        local remove = Config.RemoveItemAfterUse and Framework.RemoveItem(src, Config.FingerprintItem, 1)

        TriggerClientEvent(Bridge.Resource .. ':evidence:client:SearchFingerPrint', src)
    end)
end

Framework.CreateUseableItem(Config.LineAnalyzeItem, function(source)
    local src = source
    local Player = Framework.GetPlayer(src)

    if not Config.EnableLineAnalyze then return end

    if not Functions.isLeo(Player.Job.Name) then return Framework.Notify(src, locale('you_are_not_leo'), 'error') end

    -- keep camera or remove it
    local remove = Config.RemoveItemAfterUse and Framework.RemoveItem(src, Config.LineAnalyzeItem, 1)

    TriggerClientEvent(Bridge.Resource .. ':evidence:client:UseThermalCamera', src)
end)

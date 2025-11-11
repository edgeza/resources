local function ResolveCore()
    local qbResource = 'qb-core'
    local qbState = GetResourceState(qbResource)
    if qbState ~= 'missing' and qbState ~= 'unknown' and qbState ~= 'stopped' then
        return exports[qbResource]:GetCoreObject()
    end

    local qbxResource = 'qbx-core'
    local qbxState = GetResourceState(qbxResource)
    if qbxState ~= 'missing' and qbxState ~= 'unknown' and qbxState ~= 'stopped' then
        return exports[qbxResource]:GetCoreObject()
    end

    error('qb-radio: Unable to find a compatible core resource (qb-core or qbx-core).')
end

local QBCore = ResolveCore()

QBCore.Functions.CreateUseableItem("radio", function(source)
    TriggerClientEvent('qb-radio:use', source)
end)

for channel, config in pairs(Config.RestrictedChannels) do
    exports['pma-voice']:addChannelCheck(channel, function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        return config[Player.PlayerData.job.name] and Player.PlayerData.job.onduty
    end)
end

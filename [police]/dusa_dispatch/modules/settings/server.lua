if not rawget(_G, "lib") then include('ox_lib', 'init') end

if not lib then return end

Settings = {}
local playerSettings = {}
GlobalState.DispatchManager = nil

function SettingsLoadHandler(source)
    local Player = Framework.GetPlayer(source)
    if not Player then return end
    local identifier = Player.Identifier
    local IsPolice = Functions.IsPolice(Player.Job.Name)
    if IsPolice then
        local data = db.getSettings(identifier)
        if data then
            playerSettings[identifier] = {
                callsign = data.callsign,
                filters = json.decode(data.filters)
            }
        end
        TriggerClientEvent('dusa_dispatch:updatePlayerPermissions', source)
    end
end

function Settings.Update(data)
    local Player = Framework.GetPlayer(source)
    local identifier = Player.Identifier
    playerSettings[identifier] = data
    -- exports['redutzu-mdt']:SetOfficerCallsign(source, data.callsign)
end
RegisterServerEvent('dusa_dispatch:updateSettings', Settings.Update)

RegisterServerEvent('dusa_dispatch:setNewManager', function (data)
    -- data.name data.id
    local source = source -- player who changed the manager 
    local managerSource = data.id -- new manager
    GlobalState.DispatchManager = data
    TriggerClientEvent('dusa_dispatch:UpdateManager', -1, GlobalState.DispatchManager)
    TriggerClientEvent('dusa_dispatch:updateManagerPermissions', -1, managerSource)
end)

lib.callback.register('dusa_dispatch:getSettings', function(source)
    local Player = Framework.GetPlayer(source)
    local identifier = Player.Identifier

    if not playerSettings[identifier] then
        Settings.CreatePlayerSettings(identifier)
    end

    return playerSettings[identifier]
end)

lib.callback.register('dusa_dispatch:getCallsign', function(source, externalSource)
    if not source then return end
    local pSource = externalSource or source
    local identifier

    local player = Framework.GetPlayer(pSource)
    if not player then return end
    
    identifier = player.Identifier

    if not playerSettings[identifier] then
        return config.defaultCallsign
    end

    return playerSettings[identifier].callsign
end)

local function GetCallsign(source)
    if not source then return end
    local Player = Framework.GetPlayer(source)
    local identifier = Player.Identifier

    if not playerSettings[identifier] then
        return config.defaultCallsign
    end

    return playerSettings[identifier].callsign
end
exports('GetCallsign', GetCallsign)

AddEventHandler('txAdmin:events:serverShuttingDown', function ()
    db.saveSettings(playerSettings)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining ~= 60 then return end
	db.saveSettings(playerSettings)
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == cache.resource then
        db.saveSettings(playerSettings)
	end
end)

function Settings.CreatePlayerSettings(identifier)
    local data = {
        callsign = config.defaultCallsign,
        filters = {
            police = true,
            ambulance = true,
            sheriff = true,
            bcso = true,
            highway = true,
            state = true,
            ranger = true
        }
    }

    local exist = db.checkSettingsExist(identifier)

    if not exist then
        playerSettings[identifier] = data
        db.createSettings(identifier, data.callsign, json.encode(data.filters))
    end
end

return Settings
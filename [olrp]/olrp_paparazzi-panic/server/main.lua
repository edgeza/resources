local QBCore = nil
local QBX = nil

-- Initialize Framework
if Config.Framework == 'qb-core' then
    QBCore = exports[Config.CoreName]:GetCoreObject()
elseif Config.Framework == 'qbox' then
    QBX = exports.qbx_core
end

-- Helper Functions
local function GetPlayer(src)
    if Config.Framework == 'qbox' then
        return exports.qbx_core:GetPlayer(src)
    else
        return QBCore.Functions.GetPlayer(src)
    end
end

local function HasPermission(src, permission)
    if Config.Framework == 'qbox' then
        -- QBX permission system - check for admin permissions
        local Player = GetPlayer(src)
        if not Player then return false end
        
        -- Debug: Print all player data for troubleshooting
        print('[Paparazzi Panic] Player Data Debug:')
        print('  Name:', Player.PlayerData.name)
        print('  Permission:', Player.PlayerData.permission or 'none')
        print('  Job:', Player.PlayerData.job.name)
        print('  Grade:', Player.PlayerData.job.grade.level)
        
        -- Check if player has admin permission using QBX method
        if QBX.HasPermission then
            local hasAdmin = QBX.HasPermission(src, 'admin')
            local hasGod = QBX.HasPermission(src, 'god')
            local hasSuperAdmin = QBX.HasPermission(src, 'superadmin')
            local hasModerator = QBX.HasPermission(src, 'moderator')
            
            print('[Paparazzi Panic] QBX Permission Check:')
            print('  admin:', hasAdmin)
            print('  god:', hasGod)
            print('  superadmin:', hasSuperAdmin)
            print('  moderator:', hasModerator)
            
            return hasAdmin or hasGod or hasSuperAdmin or hasModerator
        end
        
        -- Alternative: Check player's group/rank
        if Player.PlayerData and Player.PlayerData.permission then
            local playerPermission = Player.PlayerData.permission
            return playerPermission == 'admin' or 
                   playerPermission == 'god' or 
                   playerPermission == 'superadmin' or
                   playerPermission == 'moderator'
        end
        
        -- Check if player is in admin job
        local playerJob = Player.PlayerData.job.name
        if playerJob == 'admin' or playerJob == 'god' then
            return true
        end
        
        return false
    else
        return QBCore.Functions.HasPermission(src, permission)
    end
end

local function AddMoney(Player, account, amount, reason)
    if Config.Framework == 'qbox' then
        Player.Functions.AddMoney(account, amount, reason)
    else
        Player.Functions.AddMoney(account, amount, reason)
    end
end

-- Event State
local eventActive = false
local celebrityData = nil
local paparazziPlayers = {}
local celebrityKidnapped = false
local kidnapper = nil
local lastEventTime = 0

-- Auto-start event timer
if Config.AutoStart then
    CreateThread(function()
        while true do
            local interval = math.random(Config.AutoStartInterval.min, Config.AutoStartInterval.max) * 60000
            Wait(interval)
            
            if not eventActive and GetNumPlayerIndices() >= Config.MinPlayers then
                local currentTime = os.time() * 1000
                if currentTime - lastEventTime >= Config.EventCooldown then
                    StartCelebrityEvent()
                end
            end
        end
    end)
end

-- Start Celebrity Event
function StartCelebrityEvent()
    if eventActive then return end
    
    eventActive = true
    lastEventTime = os.time() * 1000
    
    -- Select random spawn location
    local spawnLocation = Config.SpawnLocations[math.random(#Config.SpawnLocations)]
    
    -- Create celebrity data
    celebrityData = {
        model = Config.CelebrityModels[math.random(#Config.CelebrityModels)],
        name = Config.CelebrityNames[math.random(#Config.CelebrityNames)],
        location = spawnLocation,
        active = true
    }
    
    -- Notify all players
    TriggerClientEvent('paparazzi-panic:client:StartEvent', -1, celebrityData)
    
    -- Send notification to all players
    TriggerClientEvent('QBCore:Notify', -1, '⭐ BREAKING NEWS: ' .. celebrityData.name .. ' spotted in the city!', 'success', 10000)
    
    -- Discord webhook (optional)
    -- SendDiscordLog('Celebrity Event Started', celebrityData.name .. ' has been spotted!')
    
    -- End event after duration
    SetTimeout(Config.EventDuration, function()
        EndCelebrityEvent(false)
    end)
end

-- End Celebrity Event
function EndCelebrityEvent(wasKidnapped)
    if not eventActive then return end
    
    eventActive = false
    celebrityKidnapped = false
    kidnapper = nil
    paparazziPlayers = {}
    
    TriggerClientEvent('paparazzi-panic:client:EndEvent', -1)
    
    local message = wasKidnapped and 
        '📰 The celebrity managed to escape! Event ended.' or
        '📰 The celebrity has left the area. Event ended.'
    
    TriggerClientEvent('QBCore:Notify', -1, message, 'primary', 5000)
    celebrityData = nil
end

-- Command to manually start event (admin only)
RegisterCommand('startcelebrity', function(source, args, rawCommand)
    local src = source
    
    if src > 0 then
        local Player = GetPlayer(src)
        if not Player then return end
        
        if not Config.DebugMode and not HasPermission(src, 'admin') then
            -- Debug: Log permission check details
            print('[Paparazzi Panic] Permission denied for player:', Player.PlayerData.name, 'Permission:', Player.PlayerData.permission or 'none')
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have permission to use this command', 'error')
            return
        end
    end
    
    if eventActive then
        TriggerClientEvent('QBCore:Notify', src, 'Celebrity event is already active!', 'error')
        return
    end
    
    StartCelebrityEvent()
    if src > 0 then
        TriggerClientEvent('QBCore:Notify', src, 'Celebrity event started!', 'success')
    else
        print('[Paparazzi Panic] Celebrity event started via console')
    end
end, false)

-- Command to end event (admin only)
RegisterCommand('endcelebrity', function(source, args, rawCommand)
    local src = source
    
    if src > 0 then
        local Player = GetPlayer(src)
        if not Player then return end
        
        if not Config.DebugMode and not HasPermission(src, 'admin') then
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have permission to use this command', 'error')
            return
        end
    end
    
    if not eventActive then
        TriggerClientEvent('QBCore:Notify', src, 'No celebrity event is active!', 'error')
        return
    end
    
    EndCelebrityEvent(false)
    if src > 0 then
        TriggerClientEvent('QBCore:Notify', src, 'Celebrity event ended!', 'success')
    else
        print('[Paparazzi Panic] Celebrity event ended via console')
    end
end, false)

-- Update celebrity location
RegisterNetEvent('paparazzi-panic:server:UpdateLocation', function(coords)
    local src = source
    if not eventActive or not celebrityData then return end
    
    celebrityData.location = coords
    TriggerClientEvent('paparazzi-panic:client:UpdateLocation', -1, coords)
end)

-- Photo reward
RegisterNetEvent('paparazzi-panic:server:ClaimPhotoReward', function()
    local src = source
    if not eventActive then return end
    
    local Player = GetPlayer(src)
    if not Player then return end
    
    AddMoney(Player, 'cash', Config.PhotoReward, 'paparazzi-photo')
    TriggerClientEvent('QBCore:Notify', src, 'You got $' .. Config.PhotoReward .. ' for your exclusive photo!', 'success')
end)

-- Police crowd control reward
RegisterNetEvent('paparazzi-panic:server:CrowdControl', function()
    local src = source
    if not eventActive then return end
    
    local Player = GetPlayer(src)
    if not Player then return end
    
    -- Check if player is police
    local playerJob = Config.Framework == 'qbox' and Player.PlayerData.job.name or Player.PlayerData.job.name
    local isPolice = false
    for _, job in ipairs(Config.PoliceJobs) do
        if playerJob == job then
            isPolice = true
            break
        end
    end
    
    if not isPolice then
        TriggerClientEvent('QBCore:Notify', src, 'You must be a police officer!', 'error')
        return
    end
    
    AddMoney(Player, 'bank', Config.PoliceCrowdControlReward, 'crowd-control')
    TriggerClientEvent('QBCore:Notify', src, 'Crowd control bonus: $' .. Config.PoliceCrowdControlReward, 'success')
end)

-- Get event status
RegisterNetEvent('paparazzi-panic:server:GetEventStatus', function()
    local src = source
    TriggerClientEvent('paparazzi-panic:client:ReceiveEventStatus', src, eventActive, celebrityData, celebrityKidnapped)
end)

-- Export for other resources
exports('IsEventActive', function()
    return eventActive
end)

exports('GetCelebrityData', function()
    return celebrityData
end)

exports('StartEvent', function()
    StartCelebrityEvent()
end)

exports('EndEvent', function()
    EndCelebrityEvent(false)
end)


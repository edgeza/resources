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

local function GetPlayerMoney(Player, account)
    if Config.Framework == 'qbox' then
        return Player.Functions.GetMoney(account)
    else
        return Player.Functions.GetMoney(account)
    end
end

local function AddMoney(Player, account, amount, reason)
    if Config.Framework == 'qbox' then
        Player.Functions.AddMoney(account, amount, reason)
    else
        Player.Functions.AddMoney(account, amount, reason)
    end
end

local function RemoveMoney(Player, account, amount, reason)
    if Config.Framework == 'qbox' then
        Player.Functions.RemoveMoney(account, amount, reason)
    else
        Player.Functions.RemoveMoney(account, amount, reason)
    end
end

local activeRansom = nil
local ransomTimer = nil

-- Start kidnapping
RegisterNetEvent('paparazzi-panic:server:StartKidnap', function()
    local src = source
    local Player = GetPlayer(src)
    if not Player then return end
    
    -- Check if already kidnapped
    if activeRansom then
        TriggerClientEvent('QBCore:Notify', src, 'The celebrity is already kidnapped!', 'error')
        return
    end
    
    -- Notify kidnapping started
    TriggerClientEvent('QBCore:Notify', -1, '🚨 BREAKING: Celebrity kidnapping in progress!', 'error', 8000)
    TriggerClientEvent('paparazzi-panic:client:KidnapStarted', -1, src)
end)

-- Complete kidnapping
RegisterNetEvent('paparazzi-panic:server:CompleteKidnap', function()
    local src = source
    local Player = GetPlayer(src)
    if not Player then return end
    
    if activeRansom then
        TriggerClientEvent('QBCore:Notify', src, 'The celebrity is already kidnapped!', 'error')
        return
    end
    
    -- Generate random ransom amount
    local ransomAmount = math.random(Config.RansomAmount.min, Config.RansomAmount.max)
    
    activeRansom = {
        kidnapper = src,
        kidnapperName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
        amount = ransomAmount,
        startTime = os.time(),
        paid = false
    }
    
    -- Notify everyone
    TriggerClientEvent('QBCore:Notify', -1, '🚨 Celebrity has been kidnapped! Ransom: $' .. ransomAmount, 'error', 10000)
    TriggerClientEvent('paparazzi-panic:client:KidnapComplete', -1, src)
    
    -- Notify police
    local police = GetPlayersWithJob(Config.PoliceJobs)
    for _, cop in ipairs(police) do
        TriggerClientEvent('QBCore:Notify', cop, '🚨 DISPATCH: Celebrity kidnapping reported! Locate and rescue!', 'error', 10000)
    end
    
    -- Start ransom timer
    ransomTimer = SetTimeout(Config.RansomTimer, function()
        if activeRansom and not activeRansom.paid then
            -- Kidnapper wins
            local Kidnapper = GetPlayer(activeRansom.kidnapper)
            if Kidnapper then
                AddMoney(Kidnapper, 'cash', Config.KidnapSuccessReward, 'celebrity-ransom')
                TriggerClientEvent('QBCore:Notify', activeRansom.kidnapper, 
                    'You successfully held the celebrity! Reward: $' .. Config.KidnapSuccessReward, 'success')
            end
            
            TriggerClientEvent('QBCore:Notify', -1, '📰 The kidnappers got away! Celebrity released.', 'primary', 8000)
            TriggerClientEvent('paparazzi-panic:client:KidnapEnded', -1)
            activeRansom = nil
        end
    end)
end)

-- Police rescue
RegisterNetEvent('paparazzi-panic:server:RescueCelebrity', function()
    local src = source
    local Player = GetPlayer(src)
    if not Player then return end
    
    if not activeRansom then
        TriggerClientEvent('QBCore:Notify', src, 'No active kidnapping!', 'error')
        return
    end
    
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
    
    -- Give rescue reward
    AddMoney(Player, 'bank', Config.RescueReward, 'celebrity-rescue')
    TriggerClientEvent('QBCore:Notify', src, 'Celebrity rescued! Reward: $' .. Config.RescueReward, 'success')
    
    -- Notify kidnapper
    if activeRansom.kidnapper then
        TriggerClientEvent('QBCore:Notify', activeRansom.kidnapper, 'The police rescued the celebrity! You failed!', 'error')
    end
    
    -- Notify everyone
    TriggerClientEvent('QBCore:Notify', -1, '🚔 Police rescued the celebrity! Crisis averted!', 'success', 8000)
    TriggerClientEvent('paparazzi-panic:client:KidnapEnded', -1)
    
    -- Clear ransom
    if ransomTimer then
        ClearTimeout(ransomTimer)
        ransomTimer = nil
    end
    activeRansom = nil
end)

-- Pay ransom (for RP purposes)
RegisterNetEvent('paparazzi-panic:server:PayRansom', function()
    local src = source
    local Player = GetPlayer(src)
    if not Player then return end
    
    if not activeRansom then
        TriggerClientEvent('QBCore:Notify', src, 'No active ransom!', 'error')
        return
    end
    
    if activeRansom.paid then
        TriggerClientEvent('QBCore:Notify', src, 'Ransom already paid!', 'error')
        return
    end
    
    -- Check if player has money
    if GetPlayerMoney(Player, 'bank') < activeRansom.amount then
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money in bank!', 'error')
        return
    end
    
    -- Remove money from payer
    RemoveMoney(Player, 'bank', activeRansom.amount, 'ransom-payment')
    
    -- Give money to kidnapper
    local Kidnapper = GetPlayer(activeRansom.kidnapper)
    if Kidnapper then
        AddMoney(Kidnapper, 'cash', activeRansom.amount, 'ransom-received')
        TriggerClientEvent('QBCore:Notify', activeRansom.kidnapper, 
            'Ransom paid! You received $' .. activeRansom.amount, 'success')
    end
    
    activeRansom.paid = true
    
    TriggerClientEvent('QBCore:Notify', -1, '📰 Ransom was paid. Celebrity released.', 'primary', 8000)
    TriggerClientEvent('paparazzi-panic:client:KidnapEnded', -1)
    
    if ransomTimer then
        ClearTimeout(ransomTimer)
        ransomTimer = nil
    end
    activeRansom = nil
end)

-- Helper function to get players with specific jobs
function GetPlayersWithJob(jobs)
    local players = {}
    local allPlayers = Config.Framework == 'qbox' and exports.qbx_core:GetQBPlayers() or QBCore.Functions.GetPlayers()
    
    for _, playerId in ipairs(allPlayers) do
        local Player = GetPlayer(playerId)
        if Player then
            for _, job in ipairs(jobs) do
                if Player.PlayerData.job.name == job then
                    table.insert(players, playerId)
                    break
                end
            end
        end
    end
    
    return players
end

-- Get ransom status
RegisterNetEvent('paparazzi-panic:server:GetRansomStatus', function()
    local src = source
    TriggerClientEvent('paparazzi-panic:client:ReceiveRansomStatus', src, activeRansom)
end)


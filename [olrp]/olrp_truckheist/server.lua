local QBCore = nil

-- Get QBCore object
CreateThread(function()
    if GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

-- Server state
local activeHeists = {}
local playerCooldowns = {}
local lastPoliceCheck = {}

-- Helper Functions
function GetPlayer(source)
    if Config.Framework == "qb-core" then
        if not QBCore then
            QBCore = exports['qb-core']:GetCoreObject()
            if not QBCore then
                return nil
            end
        end
        return QBCore.Functions.GetPlayer(tonumber(source))
    elseif Config.Framework == "esx" then
        return ESX.GetPlayerFromId(source)
    else
        return nil
    end
end

function ShowNotification(source, message, type, duration)
    if Config.Notification == "qb-core" then
        TriggerClientEvent('QBCore:Notify', source, message, type, duration or 5000)
    elseif Config.Notification == "ox_lib" then
        TriggerClientEvent('ox_lib:notify', source, {
            title = "CIT Heist",
            description = message,
            type = type or "info"
        })
    end
end

function GetRandomSpawnLocation()
    local locations = Config.TruckSpawnLocations
    return locations[math.random(#locations)]
end

function IsPlayerOnCooldown(source)
    local identifier = GetPlayerIdentifier(source)
    if playerCooldowns[identifier] then
        local timeLeft = (playerCooldowns[identifier] + (Config.CooldownTime * 60 * 1000)) - GetGameTimer()
        if timeLeft > 0 then
            return math.ceil(timeLeft / (60 * 1000)) -- Return minutes left
        else
            playerCooldowns[identifier] = nil
        end
    end
    return false
end

function SetPlayerCooldown(source)
    local identifier = GetPlayerIdentifier(source)
    playerCooldowns[identifier] = GetGameTimer()
end

function GetPlayerIdentifier(source)
    if Config.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player.PlayerData.citizenid
    elseif Config.Framework == "esx" then
        local Player = ESX.GetPlayerFromId(source)
        return Player.identifier
    end
end

function HasRequiredItem(source)
    local Player = GetPlayer(source)
    if Config.Framework == "qb-core" then
        return Player.Functions.GetItemByName(Config.RequiredItem) ~= nil
    elseif Config.Framework == "esx" then
        return Player.getInventoryItem(Config.RequiredItem).count > 0
    end
end

function RemoveRequiredItem(source)
    if not Config.ItemRemove then return end
    
    local Player = GetPlayer(source)
    if Config.Framework == "qb-core" then
        Player.Functions.RemoveItem(Config.RequiredItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RequiredItem], "remove")
    elseif Config.Framework == "esx" then
        Player.removeInventoryItem(Config.RequiredItem, 1)
    end
end

function GiveReward(source)
    local Player = GetPlayer(source)
    local moneyReward = math.random(Config.Rewards.minMoney, Config.Rewards.maxMoney)
    
    -- Give money
    if Config.Framework == "qb-core" then
        Player.Functions.AddMoney("cash", moneyReward, "CIT Heist Reward")
    elseif Config.Framework == "esx" then
        Player.addMoney(moneyReward)
    end
    
    -- Give items
    for _, item in pairs(Config.Rewards.items) do
        local amount = math.random(item.amount.min, item.amount.max)
        if Config.Framework == "qb-core" then
            Player.Functions.AddItem(item.item, amount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item.item], "add")
        elseif Config.Framework == "esx" then
            Player.addInventoryItem(item.item, amount)
        end
    end
    
    return moneyReward
end

function IsPlayerPolice(source)
    local Player = GetPlayer(source)
    if not Player then return false end
    
    if Config.Framework == "qb-core" then
        local job = Player.PlayerData.job.name
        return job == "police" or job == "bcso" or job == "sheriff"
    elseif Config.Framework == "esx" then
        local job = Player.job.name
        return job == "police" or job == "sheriff"
    end
    return false
end

function CountOnlinePolice()
    local policeCount = 0
    local players = GetPlayers()
    
    for _, playerId in pairs(players) do
        local Player = GetPlayer(playerId)
        
        if Player then
            if Config.Framework == "qb-core" then
                if Player.PlayerData and Player.PlayerData.job then
                    local job = Player.PlayerData.job.name
                    local onDuty = Player.PlayerData.job.onduty
                    if Config.PoliceJobs[job] and onDuty then
                        policeCount = policeCount + 1
                    end
                end
            elseif Config.Framework == "esx" then
                if Player.job then
                    local job = Player.job.name
                    if Config.PoliceJobs[job] then
                        policeCount = policeCount + 1
                    end
                end
            end
        end
    end
    
    return policeCount
end

function SendDispatch(coords)
    if not Config.Dispatch.enabled then return end
    
    local dispatchData = {
        message = Config.Dispatch.message,
        codeName = Config.Dispatch.code,
        code = Config.Dispatch.code,
        icon = Config.Dispatch.sprite,
        priority = 2,
        coords = coords,
        street = "CIT Truck Location",
        gender = 1,
        camId = 4,
        plate = "CIT TRUCK",
        color1 = 0,
        color2 = 0,
        heading = 0,
        min = 0,
        max = 0,
        radius = 0.0,
        sprite = Config.Dispatch.sprite,
        color = Config.Dispatch.color,
        scale = Config.Dispatch.scale,
        length = Config.Dispatch.length,
        sound = Config.Dispatch.sound,
        offset = Config.Dispatch.offset,
        radius = Config.Dispatch.radius,
        speed = 0.0,
        heading2 = 0
    }
    
    TriggerEvent('ps-dispatch:server:notify', dispatchData)
    
    -- Send tracker to all police officers (they will need to track the truck)
    for _, playerId in pairs(GetPlayers()) do
        if IsPlayerPolice(playerId) then
            TriggerClientEvent('olrp_truckheist:client:receivePoliceTracker', playerId, coords)
        end
    end
end

function BroadcastTruckNetwork(truckNetId)
    -- Notify all police officers about the truck so they can see it
    for _, playerId in pairs(GetPlayers()) do
        if IsPlayerPolice(playerId) then
            TriggerClientEvent('olrp_truckheist:client:receiveTruckNetwork', playerId, truckNetId)
        end
    end
end

function CleanupHeist(heistId)
    if activeHeists[heistId] then
        activeHeists[heistId] = nil
    end
end

-- Discord Webhook Function
function SendDiscordLog(title, description, color, fields)
    if not Config.Discord.enabled or Config.Discord.webhook == "" then return end
    
    local webhookUrl = Config.Discord.webhook
    local embedColor = color or Config.Discord.color
    local botName = Config.Discord.botName
    local botAvatar = Config.Discord.botAvatar
    
    local embed = {
        {
            ["title"] = title,
            ["description"] = description,
            ["type"] = "rich",
            ["color"] = embedColor,
            ["fields"] = fields or {},
            ["footer"] = {
                ["text"] = "OLRP CIT Heist System",
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }
    
    local data = {
        ["username"] = botName,
        ["avatar_url"] = botAvatar,
        ["embeds"] = embed
    }
    
    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end

-- Event Handlers
-- Broadcast police count to all players
CreateThread(function()
    while true do
        Wait(10000) -- Update every 10 seconds to reduce performance impact on high player count servers
        local policeCount = CountOnlinePolice()
        TriggerClientEvent('olrp_truckheist:client:updatePoliceCount', -1, policeCount)
    end
end)

RegisterNetEvent('olrp_truckheist:server:startHeist', function()
    local source = source
    local Player = GetPlayer(source)
    
    if not Player then return end
    
    -- Check if player has required item (only if item requirement is enabled)
    if Config.RequireItem and not HasRequiredItem(source) then
        TriggerClientEvent('olrp_truckheist:client:showError', source, Config.Messages.noItem)
        return
    end
    
    -- Check police count (if police requirement is enabled)
    if Config.RequirePolice then
        local policeCount = CountOnlinePolice()
        if policeCount < Config.MinPoliceCount then
            TriggerClientEvent('olrp_truckheist:client:showError', source, "Not enough police online. Required: " .. Config.MinPoliceCount .. ", Online: " .. policeCount)
            return
        end
    end
    
    -- Check cooldown
    local cooldownLeft = IsPlayerOnCooldown(source)
    if cooldownLeft then
        local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        SendDiscordLog(
            "CIT Heist Attempt Blocked",
            "Player attempted to start heist while on cooldown",
            16776960, -- Yellow
            {
                {name = "Player", value = playerName, inline = true},
                {name = "Server ID", value = source, inline = true},
                {name = "Reason", value = "On cooldown for " .. cooldownLeft .. " minutes", inline = false}
            }
        )
        TriggerClientEvent('olrp_truckheist:client:showError', source, string.format(Config.Messages.onCooldown, cooldownLeft))
        return
    end
    
    -- Check if heist is already active
    if next(activeHeists) ~= nil then
        TriggerClientEvent('olrp_truckheist:client:showError', source, Config.Messages.heistActive)
        return
    end
    
    -- Remove required item (only if item requirement is enabled)
    if Config.RequireItem then
        RemoveRequiredItem(source)
    end
    
    -- Set cooldown
    SetPlayerCooldown(source)
    
    -- Generate heist data
    local truckSpawn = GetRandomSpawnLocation()
    local heistId = "heist_" .. source .. "_" .. GetGameTimer()
    
    local heistData = {
        id = heistId,
        playerId = source,
        truckCoords = vector3(truckSpawn.x, truckSpawn.y, truckSpawn.z),
        truckHeading = truckSpawn.w,
        initialCoords = vector3(truckSpawn.x, truckSpawn.y, truckSpawn.z),
        startTime = GetGameTimer(),
        trackerReceived = false,
        truckNetId = nil, -- Will be set by the host client
        participants = {} -- Track all participants
    }
    
    -- Store heist data
    activeHeists[heistId] = heistData
    
    -- Get party members if player is in a party
    local partyMembers = {source} -- Always include the starter
    local addedPlayers = {[source] = true} -- Track added players to avoid duplicates
    
    if Config.Framework == "qb-core" and QBCore then
        -- Try to get party members from QBCore party system
        local partyId = Player.PlayerData.metadata and Player.PlayerData.metadata.partyId
        if partyId then
            -- Get all players and check if they're in the same party
            local allPlayers = GetPlayers()
            for _, playerId in pairs(allPlayers) do
                local targetPlayer = QBCore.Functions.GetPlayer(tonumber(playerId))
                if targetPlayer then
                    local targetPartyId = targetPlayer.PlayerData.metadata and targetPlayer.PlayerData.metadata.partyId
                    if targetPartyId == partyId and tonumber(playerId) ~= source then
                        if not addedPlayers[tonumber(playerId)] then
                            table.insert(partyMembers, tonumber(playerId))
                            addedPlayers[tonumber(playerId)] = true
                        end
                    end
                end
            end
        end
    end
    
    -- Also share with nearby players if enabled
    if Config.ShareWithNearby then
        local starterCoords = GetEntityCoords(GetPlayerPed(source))
        local allPlayers = GetPlayers()
        
        for _, playerId in pairs(allPlayers) do
            local targetId = tonumber(playerId)
            if targetId and targetId ~= source and not addedPlayers[targetId] then
                local targetPed = GetPlayerPed(targetId)
                if targetPed and DoesEntityExist(targetPed) then
                    local targetCoords = GetEntityCoords(targetPed)
                    local distance = #(starterCoords - targetCoords)
                    
                    if distance <= Config.NearbyDistance then
                        -- Don't add police to the heist
                        if not IsPlayerPolice(targetId) then
                            table.insert(partyMembers, targetId)
                            addedPlayers[targetId] = true
                        end
                    end
                end
            end
        end
    end
    
    -- Store participants
    heistData.participants = partyMembers
    
    -- Get player info for discord
    local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local playerCitizenId = Player.PlayerData.citizenid
    
    -- Send Discord log for heist start
    SendDiscordLog(
        "CIT Heist Started",
        "A new armored truck robbery has been initiated",
        16776960, -- Yellow color
        {
            {name = "Player", value = playerName .. " (" .. playerCitizenId .. ")", inline = true},
            {name = "Server ID", value = source, inline = true},
            {name = "Participants", value = #partyMembers, inline = true},
            {name = "Truck Location", value = "X: " .. truckSpawn.x .. "\nY: " .. truckSpawn.y .. "\nZ: " .. truckSpawn.z, inline = false}
        }
    )
    
    -- Start heist - ONLY the heist starter gets the truck and blip
    TriggerClientEvent('olrp_truckheist:client:startHeist', source, heistData, true) -- true = spawn truck
    
    -- Give tracker to all party members after a delay
    SetTimeout(5000, function()
        if activeHeists[heistId] then
            activeHeists[heistId].trackerReceived = true
            for _, playerId in pairs(partyMembers) do
                TriggerClientEvent('olrp_truckheist:client:receiveTracker', playerId)
            end
        end
    end)
    
    -- Auto cleanup after duration (only if HeistDuration is enabled)
    if Config.HeistDuration and type(Config.HeistDuration) == "number" and Config.HeistDuration > 0 then
        SetTimeout(Config.HeistDuration * 60 * 1000, function()
            if activeHeists[heistId] then
                TriggerClientEvent('olrp_truckheist:client:failHeist', source, "truckEscaped")
                CleanupHeist(heistId)
            end
        end)
    end
end)

RegisterNetEvent('olrp_truckheist:server:receiveTracker', function()
    local source = source
    
    -- Find active heist for this player
    for heistId, heistData in pairs(activeHeists) do
        if heistData.playerId == source then
            heistData.trackerReceived = true
            TriggerClientEvent('olrp_truckheist:client:receiveTracker', source)
            break
        end
    end
end)

RegisterNetEvent('olrp_truckheist:server:completeDelivery', function()
    local source = source
    
    -- Find active heist for this player
    for heistId, heistData in pairs(activeHeists) do
        if heistData.playerId == source then
            -- Give reward
            local reward = GiveReward(source)
            
            -- Complete heist
            TriggerClientEvent('olrp_truckheist:client:completeHeist', source, reward)
            CleanupHeist(heistId)
            break
        end
    end
end)

RegisterNetEvent('olrp_truckheist:server:truckEscaped', function()
    local source = source
    local Player = GetPlayer(source)
    
    -- Find active heist for this player
    for heistId, heistData in pairs(activeHeists) do
        if heistData.playerId == source then
            if Player then
                local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
                local playerCitizenId = Player.PlayerData.citizenid
                
                -- Calculate heist duration
                local duration = math.floor((GetGameTimer() - heistData.startTime) / 1000)
                local minutes = math.floor(duration / 60)
                local seconds = duration % 60
                
                -- Send Discord log for failed heist
                SendDiscordLog(
                    "CIT Heist Failed - Truck Escaped",
                    "The armored truck escaped before being destroyed",
                    15158332, -- Red color
                    {
                        {name = "Player", value = playerName .. " (" .. playerCitizenId .. ")", inline = true},
                        {name = "Server ID", value = source, inline = true},
                        {name = "Duration", value = minutes .. "m " .. seconds .. "s", inline = true},
                        {name = "Reason", value = "Truck escaped", inline = true}
                    }
                )
            end
            
            TriggerClientEvent('olrp_truckheist:client:failHeist', source, "truckEscaped")
            CleanupHeist(heistId)
            break
        end
    end
end)

RegisterNetEvent('olrp_truckheist:server:sendDispatch', function(coords)
    SendDispatch(coords)
end)

RegisterNetEvent('olrp_truckheist:server:broadcastTruck', function(truckNetId)
    BroadcastTruckNetwork(truckNetId)
end)


RegisterNetEvent('olrp_truckheist:server:removeExplosive', function()
    local source = source
    local Player = GetPlayer(source)
    
    if not Player or not Config.Explosive.requireItem then return end
    
    -- Remove explosive item (only if item requirement is enabled)
    if Config.Framework == "qb-core" then
        Player.Functions.RemoveItem(Config.Explosive.requiredItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.Explosive.requiredItem], "remove")
    elseif Config.Framework == "esx" then
        Player.removeInventoryItem(Config.Explosive.requiredItem, 1)
    end
end)

RegisterNetEvent('olrp_truckheist:server:lootTruck', function()
    local source = source
    local Player = GetPlayer(source)
    if not Player then return end
    
    -- Find active heist for this player
    for heistId, heistData in pairs(activeHeists) do
        if heistData.playerId == source then
            -- Get player info
            local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
            local playerCitizenId = Player.PlayerData.citizenid
            
            -- Calculate heist duration
            local duration = math.floor((GetGameTimer() - heistData.startTime) / 1000) -- duration in seconds
            local minutes = math.floor(duration / 60)
            local seconds = duration % 60
            
            -- Give reward
            local reward = GiveReward(source)
            
            -- Send Discord log for heist completion
            SendDiscordLog(
                "CIT Heist Completed Successfully",
                "Player successfully completed the armored truck robbery",
                3066993, -- Green color
                {
                    {name = "Player", value = playerName .. " (" .. playerCitizenId .. ")", inline = true},
                    {name = "Server ID", value = source, inline = true},
                    {name = "Reward Received", value = "$" .. reward, inline = true},
                    {name = "Duration", value = minutes .. "m " .. seconds .. "s", inline = true},
                    {name = "Participants", value = #heistData.participants, inline = true}
                }
            )
            
            -- Complete heist
            TriggerClientEvent('olrp_truckheist:client:completeHeist', source, reward)
            CleanupHeist(heistId)
            break
        end
    end
end)

-- Cleanup on player disconnect
RegisterNetEvent('QBCore:Server:OnPlayerUnload', function(source)
    local identifier = GetPlayerIdentifier(source)
    
    -- Clean up any active heists for this player
    for heistId, heistData in pairs(activeHeists) do
        if heistData.playerId == source then
            CleanupHeist(heistId)
            break
        end
    end
    
    -- Remove cooldown and police check data
    playerCooldowns[identifier] = nil
    lastPoliceCheck[source] = nil
end)

-- Admin commands removed

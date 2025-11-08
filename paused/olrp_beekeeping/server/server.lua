-- QBCore Beekeeping Server Side - Complete Advanced Version
local QBCore = exports['qb-core']:GetCoreObject()

-----------------------------------------------
--------------- Server-Side Wild Hives ---------
-----------------------------------------------

-- Server-side wild hive storage (synced to all clients)
local ServerWildHives = {}
local WildHiveRotationTimer = 0

-- Spawn wild hives on server startup
CreateThread(function()
    if not Config.WildBeehiveSpawn then return end
    
    print("^2[MMS-Beekeeper]^7 Initializing server-side wild hive system...")
    
    -- Initial spawn
    SpawnServerWildHives(Config.WildBeehiveMaxActive or 50)
    
    print("^2[MMS-Beekeeper]^7 Server-side wild hives spawned and ready!")
    
    -- Rotation timer
    CreateThread(function()
        while true do
            Wait(60000) -- Check every minute
            WildHiveRotationTimer = WildHiveRotationTimer + 1
            
            if WildHiveRotationTimer >= (Config.WildBeehiveRotationTime or 30) then
                RotateServerWildHives()
                WildHiveRotationTimer = 0
            end
        end
    end)
end)

function SpawnServerWildHives(count)
    local spawned = 0
    local attempts = 0
    local maxAttempts = count * 3
    local usedIndices = {}
    
    while spawned < count and attempts < maxAttempts do
        attempts = attempts + 1
        
        local randomIndex = math.random(1, #Config.WildBeehives)
        
        -- Check if index already used
        if not usedIndices[randomIndex] then
            local location = Config.WildBeehives[randomIndex]
            
            -- Check if location is far enough from existing hives
            local isValid = true
            for _, hive in pairs(ServerWildHives) do
                local distance = #(vector3(location.x, location.y, location.z) - vector3(hive.x, hive.y, hive.z))
                if distance < (Config.WildBeehiveMinDistance or 50.0) then
                    isValid = false
                    break
                end
            end
            
            if isValid then
                local hiveId = "server_wild_" .. randomIndex .. "_" .. os.time()
                ServerWildHives[hiveId] = {
                    id = hiveId,
                    index = randomIndex,
                    x = location.x,
                    y = location.y,
                    z = location.z,
                    heading = location.heading or 0.0,
                    data = location,
                    spawnTime = os.time()
                }
                
                usedIndices[randomIndex] = true
                spawned = spawned + 1
                
                print("^2[MMS-Beekeeper]^7 Server spawned wild hive #" .. randomIndex .. " | ID: " .. hiveId)
            end
        end
    end
    
    print("^2[MMS-Beekeeper]^7 Spawned " .. spawned .. " server-side wild hives")
    
    -- Sync to all connected clients
    TriggerClientEvent('mms-beekeeper:client:SyncServerWildHives', -1, ServerWildHives)
end

function RotateServerWildHives()
    print("^2[MMS-Beekeeper]^7 Rotating server-side wild hives...")
    
    -- Clear current hives
    ServerWildHives = {}
    
    -- Spawn new hives
    SpawnServerWildHives(Config.WildBeehiveMaxActive or 50)
end

-- When player joins, sync wild hives to them
RegisterNetEvent('mms-beekeeper:server:RequestWildHives', function()
    local src = source
    TriggerClientEvent('mms-beekeeper:client:SyncServerWildHives', src, ServerWildHives)
    print("^2[MMS-Beekeeper]^7 Synced wild hives to player " .. src)
end)

-- When a hive is collected, remove it server-side and respawn elsewhere
RegisterNetEvent('mms-beekeeper:server:RemoveWildHive', function(hiveId, originalIndex)
    if ServerWildHives[hiveId] then
        ServerWildHives[hiveId] = nil
        print("^2[MMS-Beekeeper]^7 Server removed wild hive: " .. hiveId)
        
        -- Spawn a new one elsewhere
        local newIndex = originalIndex
        local attempts = 0
        while newIndex == originalIndex and attempts < 20 do
            newIndex = math.random(1, #Config.WildBeehives)
            attempts = attempts + 1
        end
        
        if newIndex ~= originalIndex then
            local location = Config.WildBeehives[newIndex]
            local newHiveId = "server_wild_" .. newIndex .. "_" .. os.time()
            
            ServerWildHives[newHiveId] = {
                id = newHiveId,
                index = newIndex,
                x = location.x,
                y = location.y,
                z = location.z,
                heading = location.heading or 0.0,
                data = location,
                spawnTime = os.time()
            }
            
            print("^2[MMS-Beekeeper]^7 Server spawned replacement wild hive #" .. newIndex .. " | ID: " .. newHiveId)
        end
        
        -- Sync updated hives to all clients
        TriggerClientEvent('mms-beekeeper:client:SyncServerWildHives', -1, ServerWildHives)
    end
end)

-- Admin command to force spawn all wild hives
RegisterCommand('spawnallwildhivesserver', function(source, args, rawCommand)
    if source == 0 or QBCore.Functions.HasPermission(source, 'admin') then
        ServerWildHives = {}
        
        for index, location in ipairs(Config.WildBeehives) do
            local hiveId = "server_wild_" .. index .. "_" .. os.time()
            ServerWildHives[hiveId] = {
                id = hiveId,
                index = index,
                x = location.x,
                y = location.y,
                z = location.z,
                heading = location.heading or 0.0,
                data = location,
                spawnTime = os.time()
            }
        end
        
        TriggerClientEvent('mms-beekeeper:client:SyncServerWildHives', -1, ServerWildHives)
        print("^2[MMS-Beekeeper]^7 Admin spawned ALL " .. #Config.WildBeehives .. " wild hives")
        
        if source ~= 0 then
            TriggerClientEvent('QBCore:Notify', source, 'Spawned ALL ' .. #Config.WildBeehives .. ' wild hives!', 'success', 5000)
        end
    end
end, false)

-- Admin command to clear all wild hives
RegisterCommand('clearwildhivesserver', function(source, args, rawCommand)
    if source == 0 or QBCore.Functions.HasPermission(source, 'admin') then
        ServerWildHives = {}
        TriggerClientEvent('mms-beekeeper:client:SyncServerWildHives', -1, {})
        print("^2[MMS-Beekeeper]^7 Admin cleared all wild hives")
        
        if source ~= 0 then
            TriggerClientEvent('QBCore:Notify', source, 'Cleared all wild hives!', 'success', 5000)
        end
    end
end, false)

-- Callbacks for client-side prechecks
QBCore.Functions.CreateCallback('mms-beekeeper:server:hasItem', function(src, cb, item, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return cb(false) end
    local it = Player.Functions.GetItemByName(item)
    local hasItem = it and (it.amount or 0) >= (amount or 1)
    print("^3[DEBUG] hasItem callback - Item: " .. tostring(item) .. ", Amount: " .. tostring(amount) .. ", Has: " .. tostring(hasItem) .. ", Player has: " .. tostring(it and it.amount or 0))
    cb(hasItem)
end)

-- Manual use command as a fallback when inventory use isn't firing
RegisterCommand('usebeehive', function(source, args, rawCommand)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local it = Player.Functions.GetItemByName(Config.BeehiveItem)
    if not it or (it.amount or 0) < 1 then
        TriggerClientEvent('QBCore:Notify', src, 'You do not have a beehive box', 'error', 4000)
        return
    end

    TriggerClientEvent('mms-beekeeper:client:CreateBeehive', src)
    TriggerClientEvent('QBCore:Notify', src, 'Placing mode: [E] place, [Q] cancel, arrows rotate/distance', 'primary', 7000)
end)

QBCore.Functions.CreateCallback('mms-beekeeper:server:hasBeeForQueen', function(src, cb, queenItem)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return cb(false) end
    
    print("^3[DEBUG] hasBeeForQueen callback - QueenItem: " .. tostring(queenItem))
    
    -- If no queen is set yet, check for basic bees
    if queenItem == "" or queenItem == nil then
        local it = Player.Functions.GetItemByName("basic_bees")
        local hasBasicBees = it and (it.amount or 0) > 0
        print("^3[DEBUG] No queen set, checking basic_bees - Has: " .. tostring(hasBasicBees) .. ", Amount: " .. tostring(it and it.amount or 0))
        if hasBasicBees then return cb(true) end
    end
    
    for _, v in ipairs(Config.BeeTypes) do
        if v.QueenItem == queenItem then
            local it = Player.Functions.GetItemByName(v.BeeItem)
            local hasBees = it and (it.amount or 0) > 0
            print("^3[DEBUG] Checking " .. v.BeeItem .. " for queen " .. queenItem .. " - Has: " .. tostring(hasBees) .. ", Amount: " .. tostring(it and it.amount or 0))
            if hasBees then return cb(true) end
        end
    end
    print("^3[DEBUG] No matching bees found for queen: " .. tostring(queenItem))
    cb(false)
end)

-----------------------------------------------
------------- Register Callbacks ---------------
-----------------------------------------------

QBCore.Functions.CreateCallback('mms-beekeeper:callback:GetJarAmount', function(source, cb, HoneyAmount, HoneyItem)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local JarAmount = Player.Functions.GetItemByName(Config.JarItem)
    local JarCount = JarAmount and JarAmount.amount or 0
    
    local CanCarry = Player.Functions.AddItem(HoneyItem, HoneyAmount, false)
    if CanCarry then
        Player.Functions.RemoveItem(HoneyItem, HoneyAmount, false)
    end
    
    cb({JarCount, CanCarry})
end)

-- New callback for wild hive interaction - requires BOTH smoker and bugnet
QBCore.Functions.CreateCallback('mms-beekeeper:server:hasWildHiveItems', function(src, cb)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return cb(false) end
    
    -- Check for smoker
    local hasSmoker = Player.Functions.GetItemByName(Config.SmokerItem or 'torch_smoker')
    if not hasSmoker or hasSmoker.amount < 1 then
        return cb(false)
    end
    
    -- Check for bugnet
    local hasBugNet = Player.Functions.GetItemByName(Config.BugNetItem or 'bug_net')
    if not hasBugNet or hasBugNet.amount < 1 then
        return cb(false)
    end
    
    cb(true)
end)

-----------------------------------------------
----------------- Register Items ---------------
-----------------------------------------------

QBCore.Functions.CreateUseableItem(Config.BeehiveItem, function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then 
        print("^1[MMS-Beekeeper] Player not found for source: " .. src)
        return 
    end
    
    print("^2[MMS-Beekeeper] Beehive box used by player: " .. Player.PlayerData.citizenid)
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local MyHives = 0
    local Job = Player.PlayerData.job.name
    
    if Config.JobLock then
        local hasJob = false
        for h, v in ipairs(Config.BeekeeperJobs) do
            if Job == v.Job then
                hasJob = true
                break
            end
        end
        
        if not hasJob then
            TriggerClientEvent('QBCore:Notify', src, _U('NotTheRightJob'), 'error', 5000)
            return
        end
    end
    
    -- Count existing hives for this player
    local Beehives = MySQL.query.await("SELECT * FROM mms_beekeeper", {})
    if #Beehives > 0 then
        for h, v in ipairs(Beehives) do
            if v.charident == characterName then
                MyHives = MyHives + 1
            end
        end
    end
    
    -- Check total server limit first
    local totalHives = #Beehives
    if totalHives >= Config.MaxTotalBeehivesOnServer then
        TriggerClientEvent('QBCore:Notify', src, 'Server has reached maximum beehive limit (' .. Config.MaxTotalBeehivesOnServer .. '). Try again later.', 'error', 5000)
        return
    end
    
    if MyHives < Config.MaxBeehivesPerPlayer then
        print("^2[MMS-Beekeeper] Triggering CreateBeehive event for player: " .. Player.PlayerData.citizenid)
        TriggerClientEvent('mms-beekeeper:client:CreateBeehive', src)
    else
        print("^3[MMS-Beekeeper] Player has reached max hives: " .. MyHives .. "/" .. Config.MaxBeehivesPerPlayer)
        TriggerClientEvent('QBCore:Notify', src, _U('MaxHivesReached'), 'error', 5000)
    end
end)

-- Register other usable items
QBCore.Functions.CreateUseableItem(Config.SmokerItem, function(source, item)
    TriggerClientEvent('mms-beekeeper:client:UseSmoker', source)
end)

QBCore.Functions.CreateUseableItem(Config.BugNetItem, function(source, item)
    TriggerClientEvent('mms-beekeeper:client:UseBugNet', source)
end)

-----------------------------------------------
----------------- Main Update Thread -----------
-----------------------------------------------

CreateThread(function()
    local UpdateTimer = Config.UpdateTimer * 60000
    while true do
        Wait(30000)
        UpdateTimer = UpdateTimer - 30000
        if UpdateTimer <= 0 then
            TriggerEvent('mms-beekeeper:server:DoTheUpdateProcess')
            UpdateTimer = Config.UpdateTimer * 60000
        end
    end
end)

RegisterServerEvent('mms-beekeeper:server:DoTheUpdateProcess', function()
    local Beehives = MySQL.query.await("SELECT * FROM mms_beekeeper", {})
    if #Beehives > 0 then
        for h, v in ipairs(Beehives) do
            local Data = json.decode(v.data)
            
            -----------------------------------------------
            ------------------ FOOD UPDATE ----------------
            -----------------------------------------------
            if Data.Food > 0 then
                local NewFood = Data.Food - Config.ReduceFoodPerTick
                if NewFood < 0 then
                    Data.Food = 0
                else
                    Data.Food = NewFood
                end
            end

            -----------------------------------------------
            ------------------ Water UPDATE ---------------
            -----------------------------------------------
            if Data.Water > 0 then
                local NewWater = Data.Water - Config.ReduceWaterPerTick
                if NewWater < 0 then
                    Data.Water = 0
                else
                    Data.Water = NewWater
                end
            end

            -----------------------------------------------
            ----------------- Clean UPDATE ----------------
            -----------------------------------------------
            if Data.Clean > 0 then
                local NewClean = Data.Clean - Config.ReduceCleanPerTick
                if NewClean < 0 then
                    Data.Clean = 0
                else
                    Data.Clean = NewClean
                end
            end

            -- Health reduction if dirty
            if Data.Clean < Config.ReduceHealthIfCleanUnder then
                local NewHealth = Data.Health - Config.ReduceHealthOnDirty
                if NewHealth < 0 then
                    Data.Health = 0
                else
                    Data.Health = NewHealth
                end
            end

            -----------------------------------------------
            ----------------- Honey UPDATE ----------------
            -----------------------------------------------
            if Data.Bees > 0 and Data.Queen > 0 and Config.BeesCanBeHappy then
                local Happy = false
                if Data.Food >= Config.HappyAt.Food and Data.Water >= Config.HappyAt.Water and Data.Clean >= Config.HappyAt.Clean then
                    Happy = true
                end
                if Happy then
                    local CalculateProduct = Data.Bees * Data.BeeSettings.ProductHappy
                    local NewProduct = Data.Product + CalculateProduct
                    Data.Product = NewProduct
                else
                    local CalculateProduct = Data.Bees * Data.BeeSettings.ProductNormal
                    local NewProduct = Data.Product + CalculateProduct
                    Data.Product = NewProduct
                end
            elseif Data.Bees > 0 and Data.Queen > 0 then
                local CalculateProduct = Data.Bees * Data.BeeSettings.ProductNormal
                local NewProduct = Data.Product + CalculateProduct
                Data.Product = NewProduct
            end

            -----------------------------------------------
            ----------------- Bees UPDATE ----------------
            -----------------------------------------------
            if Data.Bees > 0 and Data.Queen > 0 and Config.BeesCanBeHappy and Config.GetBeesOnHappy then
                local Happy = false
                if Data.Food >= Config.HappyAt.Food and Data.Water >= Config.HappyAt.Water and Data.Clean >= Config.HappyAt.Clean then
                    Happy = true
                end
                if Happy then
                    local AddBeeValue = math.random(Config.BeesMin, Config.BeesMax)
                    local NewBees = Data.Bees + AddBeeValue
                    if NewBees > Config.MaxBeesPerHive then
                        NewBees = Config.MaxBeesPerHive
                    end
                    Data.Bees = NewBees
                end
            end

            -----------------------------------------------
            ----------------- Bees Die --------------------
            -----------------------------------------------
            if Data.Bees > 0 and Config.BeesCanDie then
                if Data.Food <= Config.DieAt.Food or Data.Water <= Config.DieAt.Water or Data.Clean <= Config.DieAt.Clean then
                    local LooseBees = math.random(Config.LooseBeesMin, Config.LooseBeesMax)
                    local NewBees = Data.Bees - LooseBees
                    if NewBees < 0 then
                        Data.Bees = 0
                    else
                        Data.Bees = NewBees
                    end
                end
            end

            -----------------------------------------------
            ----------------- Sickness System -------------
            -----------------------------------------------
            if Config.BeesCanBeSick and Data.Bees > 0 and Data.Queen > 0 then
                if Data.Sickness.Type ~= "None" then
                    Data.Sickness.Intensity = Data.Sickness.Intensity + Config.IncreaseIntensityPerUpdate
                    if Data.Sickness.Intensity >= 100 and Config.BeesDieOn100 then
                        Data.Bees = 0
                        Data.Sickness.Type = "None"
                        Data.Sickness.Intensity = 0
                        Data.Sickness.MedicineLabel = ""
                    end
                else
                    local SicknessChance = math.random(1, 100)
                    if SicknessChance <= Config.SicknessChance then
                        local RandomSickness = Config.Sickness[math.random(1, #Config.Sickness)]
                        Data.Sickness.Type = RandomSickness.Type
                        Data.Sickness.Intensity = 10
                        Data.Sickness.MedicineLabel = RandomSickness.MedicinLabel
                    end
                end
            end

            -----------------------------------------------
            ----------------- Auto Destroy ---------------
            -----------------------------------------------
            if Config.DestroyHives then
                if Data.Bees == 0 and Data.Queen == 0 then
                    Data.Damage = (Data.Damage or 0) + Config.IncreaseDamageBy
                    if Data.Damage >= Config.DeleteHiveOnDamage then
                        MySQL.update('DELETE FROM mms_beekeeper WHERE id = ?', {v.id})
                        TriggerClientEvent('mms-beekeeper:client:RemoveBeehive', -1, v.id)
                        goto continue
                    end
                end
            end

            -- Clear product if no bees
            if Config.ClearProductOnNoBees and Data.Bees == 0 then
                Data.Product = 0
            end

            MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
                json.encode(Data),
                v.id
            })

            ::continue::
        end
    end
end)

-----------------------------------------------
----------------- Events ----------------------
-----------------------------------------------

RegisterNetEvent('mms-beekeeper:server:PlaceBeehive', function(coords, heading, modelName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    print("^2[MMS-Beekeeper]^7 PlaceBeehive received src:", src, "coords:", json.encode(coords), "heading:", heading, "model:", tostring(modelName))
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local ident = Player.PlayerData.license or Player.PlayerData.citizenid
    
    -- Remove the beehive item
    local removed = Player.Functions.RemoveItem(Config.BeehiveItem, 1, false)
    print("^2[MMS-Beekeeper]^7 RemoveItem result:", removed)
    
    -- Check if location is allowed (outside cities)
    if not IsLocationAllowedForBeehives(coords) then
        -- Give the item back since we can't place here
        Player.Functions.AddItem(Config.BeehiveItem, 1, false)
        TriggerClientEvent('QBCore:Notify', src, 'You cannot place beehives in city areas. Try Sandy Shores or Paleto Bay.', 'error', 5000)
        return
    end
    
    -- Check minimum distance from other hives (different distances for own hives vs other players)
    local farEnough, isOwnHive = IsLocationFarEnoughFromOtherHives(coords, characterName)
    if not farEnough then
        -- Give the item back since we can't place here
        Player.Functions.AddItem(Config.BeehiveItem, 1, false)
        
        if isOwnHive then
            local minDist = Config.MinDistanceBetweenOwnHives or 0.0
            if minDist > 0 then
                TriggerClientEvent('QBCore:Notify', src, 'You must place your beehives at least ' .. minDist .. ' units apart.', 'error', 5000)
            else
                TriggerClientEvent('QBCore:Notify', src, 'Too close to your own beehive.', 'error', 5000)
            end
        else
            local minDist = Config.MinDistanceFromOtherPlayersHives or 25.0
            TriggerClientEvent('QBCore:Notify', src, 'You must place beehives at least ' .. minDist .. ' units away from other players\' hives.', 'error', 5000)
        end
        return
    end
    
    -- Check if hives must be clustered together (prevents Sandy to Paleto placement)
    if Config.RequireClusteredHives then
        local playerHives = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE charident = ?", {characterName})
        
        if #playerHives > 0 then
            -- Player has at least 1 hive, check distance from first hive
            local firstHive = playerHives[1]
            local firstHiveCoords = json.decode(firstHive.coords)
            local distanceFromFirst = #(vector3(coords.x, coords.y, coords.z) - vector3(firstHiveCoords.x, firstHiveCoords.y, firstHiveCoords.z))
            
            if distanceFromFirst > Config.MaxDistanceFromFirstHive then
                -- Give the item back
                Player.Functions.AddItem(Config.BeehiveItem, 1, false)
                TriggerClientEvent('QBCore:Notify', src, '🐝 Too far from your main hive! You must place all hives within ' .. math.floor(Config.MaxDistanceFromFirstHive) .. ' meters of your first hive. (Distance: ' .. math.floor(distanceFromFirst) .. 'm)', 'error', 8000)
                print("^3[MMS-Beekeeper]^7 Player tried to place hive too far from main hive. Distance: " .. math.floor(distanceFromFirst) .. "m | Max: " .. Config.MaxDistanceFromFirstHive .. "m")
                return
            else
                print("^2[MMS-Beekeeper]^7 Hive placement OK - Distance from main hive: " .. math.floor(distanceFromFirst) .. " meters")
            end
        else
            print("^2[MMS-Beekeeper]^7 First hive (main hive) for this player - establishing beekeeping area")
        end
    end
    
    -- Create beehive data
    local BeehiveData = {
        Queen = 0,
        Bees = 0,
        Food = 0,
        Water = 0,
        Health = 100,
        Clean = 100,
        Product = 0,
        Damage = 0,
        Sickness = {
            Type = "None",
            Intensity = 0,
            MedicineLabel = ""
        },
        BeeSettings = {
            QueenItem = "",
            QueenLabel = "",
            BeeItem = "",
            BeeLabel = "",
            Product = "",
            ProductLabel = "",
            ProductHappy = 0,
            ProductNormal = 0
        },
        Helper = {
            Name = "None",
            Ident = "None"
        }
    }
    
    -- Insert into database
    print("^2[MMS-Beekeeper]^7 Inserting hive into DB")
    MySQL.insert('INSERT INTO mms_beekeeper (ident, charident, coords, heading, data) VALUES (?, ?, ?, ?, ?)', {
        ident,
        characterName,
        json.encode(coords),
        heading,
        json.encode(BeehiveData)
    })
    
    -- Get the inserted ID
    local result = MySQL.query.await("SELECT id FROM mms_beekeeper WHERE ident = ? AND charident = ? ORDER BY id DESC LIMIT 1", {
        ident,
        characterName
    })
    print("^2[MMS-Beekeeper]^7 Inserted row fetch count:", #result)
    
    if #result > 0 then
        local HiveID = result[1].id
        -- Broadcast to all players so everyone can see the new hive
        local BeehivePlaced = {
            id = HiveID,
            coords = coords,
            heading = heading,
            data = BeehiveData,
            owner = characterName,
            modelName = modelName
        }
        print("^2[MMS-Beekeeper]^7 Broadcasting BeehivePlaced id:", HiveID)
        -- Ensure placing client gets immediate owner placement
        TriggerClientEvent('mms-beekeeper:client:BeehivePlaced', src, HiveID, coords, heading, modelName)
        -- Broadcast to all clients to sync
        TriggerClientEvent('mms-beekeeper:client:LoadBeehives', -1, {BeehivePlaced})
        TriggerClientEvent('QBCore:Notify', src, _U('BeehivePlaced'), 'success', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:AddQueen', function(HiveID, QueenItem)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #CurrentBeehive > 0 then
        local BeeTable = nil
        
        -- If no queen is set yet, use basic queen
        if QueenItem == "" or QueenItem == nil or QueenItem == "basic_queen" then
            local HasItem = Player.Functions.GetItemByName("basic_queen")
            if HasItem and HasItem.amount > 0 then
                BeeTable = Config.BeeTypes[1] -- Use first bee type (basic_queen)
            end
        else
            for h, v in ipairs(Config.BeeTypes) do
                local HasItem = Player.Functions.GetItemByName(v.QueenItem)
                if HasItem and HasItem.amount > 0 and v.QueenItem == QueenItem then
                    BeeTable = v
                    break
                end
            end
        end
        
        if BeeTable then
            local Data = json.decode(CurrentBeehive[1].data)
            
            -- Check if hive already has a queen BEFORE removing item
            if Data.Queen >= Config.MaxQueensPerHive then
                local queenType = BeeTable.QueenLabel or "queen"
                TriggerClientEvent('QBCore:Notify', src, '👑 This hive already has a ' .. queenType:lower() .. '! Maximum: 1 queen per hive', 'error', 6000)
                print("^3[MMS-Beekeeper]^7 Hive " .. HiveID .. " already has a queen: " .. Data.Queen .. "/" .. Config.MaxQueensPerHive)
                return
            end
            
            -- Remove the queen item
            Player.Functions.RemoveItem(BeeTable.QueenItem, 1, false)
            
            -- Add queen to hive
            Data.Queen = Data.Queen + 1
            Data.BeeSettings.QueenItem = BeeTable.QueenItem
            Data.BeeSettings.QueenLabel = BeeTable.QueenLabel
            Data.BeeSettings.Product = BeeTable.Product
            Data.BeeSettings.ProductLabel = BeeTable.ProductLabel
            Data.BeeSettings.ProductHappy = BeeTable.ProductHappy
            Data.BeeSettings.ProductNormal = BeeTable.ProductNormal
            
            MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
                json.encode(Data),
                HiveID
            })
            
            TriggerClientEvent('QBCore:Notify', src, '👑 ' .. BeeTable.QueenLabel .. ' added! (1/1)', 'success', 5000)
            print("^2[MMS-Beekeeper]^7 Queen added to hive " .. HiveID)
            
            -- Update hive sound for all clients
            TriggerClientEvent('mms-beekeeper:client:UpdateHiveSound', -1, HiveID, Data)
            
            if Config.GiveBackEmptyJarQueen then
                local CanCarry = Player.Functions.AddItem(Config.GiveBackEmptyJarQueenItem, 1, false)
                if CanCarry then
                    Player.Functions.RemoveItem(Config.GiveBackEmptyJarQueenItem, 1, false)
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', src, _U('NoQueenItem'), 'error', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:AddBees', function(HiveID, Queen)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #CurrentBeehive > 0 then
        local BeeTable = nil
        
        -- If no queen is set yet, use basic bees
        if Queen == "" or Queen == nil or Queen == "basic_queen" then
            local HasItem = Player.Functions.GetItemByName("basic_bees")
            if HasItem and HasItem.amount > 0 then
                BeeTable = Config.BeeTypes[1] -- Use first bee type (basic_bees)
            end
        else
            for h, v in ipairs(Config.BeeTypes) do
                local HasItem = Player.Functions.GetItemByName(v.BeeItem)
                if HasItem and HasItem.amount > 0 and v.QueenItem == Queen then
                    BeeTable = v
                    break
                end
            end
        end
        
        if BeeTable then
            local Data = json.decode(CurrentBeehive[1].data)
            
            -- Check if hive is already at max capacity BEFORE removing item
            if Data.Bees >= Config.MaxBeesPerHive then
                local beeType = Data.BeeSettings.BeeLabel or "bees/wasps"
                TriggerClientEvent('QBCore:Notify', src, '🐝 Too many ' .. beeType:lower() .. ' for one hive! Maximum capacity reached (' .. Config.MaxBeesPerHive .. '/' .. Config.MaxBeesPerHive .. ')', 'error', 6000)
                print("^3[MMS-Beekeeper]^7 Hive " .. HiveID .. " is at max capacity: " .. Data.Bees .. "/" .. Config.MaxBeesPerHive)
                return
            end
            
            -- Check if adding would exceed max
            local NewBees = Data.Bees + BeeTable.AddBees
            local willExceed = NewBees > Config.MaxBeesPerHive
            
            if willExceed then
                NewBees = Config.MaxBeesPerHive
            end
            
            -- Now remove the item
            Player.Functions.RemoveItem(BeeTable.BeeItem, 1, false)
            
            -- Update hive data
            Data.Bees = NewBees
            Data.BeeSettings.BeeItem = BeeTable.BeeItem
            Data.BeeSettings.BeeLabel = BeeTable.BeeLabel
            Data.BeeSettings.Product = BeeTable.Product
            Data.BeeSettings.ProductLabel = BeeTable.ProductLabel
            Data.BeeSettings.ProductHappy = BeeTable.ProductHappy
            Data.BeeSettings.ProductNormal = BeeTable.ProductNormal
            
            MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
                json.encode(Data),
                HiveID
            })
            
            -- Show appropriate message
            if willExceed then
                TriggerClientEvent('QBCore:Notify', src, '🐝 ' .. BeeTable.BeeLabel .. ' added! Hive is now at MAXIMUM capacity (' .. NewBees .. '/' .. Config.MaxBeesPerHive .. ')', 'primary', 6000)
                print("^3[MMS-Beekeeper]^7 Hive " .. HiveID .. " reached max capacity: " .. NewBees)
            else
                TriggerClientEvent('QBCore:Notify', src, BeeTable.BeeLabel .. ' added! (' .. Data.Bees .. '/' .. Config.MaxBeesPerHive .. ')', 'success', 5000)
            end
            
            -- Update hive sound for all clients
            TriggerClientEvent('mms-beekeeper:client:UpdateHiveSound', -1, HiveID, Data)
            
            if Config.GiveBackEmptyJarBees then
                local CanCarry = Player.Functions.AddItem(Config.GiveBackEmptyJarBeesItem, 1, false)
                if CanCarry then
                    Player.Functions.RemoveItem(Config.GiveBackEmptyJarBeesItem, 1, false)
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', src, _U('NoBeeItem'), 'error', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:TakeProduct', function(HiveID, Amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #CurrentBeehive > 0 then
        local Data = json.decode(CurrentBeehive[1].data)
        local HoneyAmount = math.floor(Amount / Config.ProduktPerHoney)
        
        if HoneyAmount > 0 and Data.Product >= Amount then
            local CanCarry = Player.Functions.AddItem(Data.BeeSettings.Product, HoneyAmount, false)
            if CanCarry then
                Player.Functions.RemoveItem(Data.BeeSettings.Product, HoneyAmount, false)
                Data.Product = Data.Product - Amount
                
                MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
                    json.encode(Data),
                    HiveID
                })
                
                TriggerClientEvent('QBCore:Notify', src, _U('ProductTaken'), 'success', 5000)
            else
                TriggerClientEvent('QBCore:Notify', src, _U('CantCarry'), 'error', 5000)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, _U('NotEnoughProduct'), 'error', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:AddFood', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local HasItem = Player.Functions.GetItemByName(Config.FoodItem)
    if HasItem and HasItem.amount > 0 then
        local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        
        -- Check if player owns this hive
        local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
        if #CurrentBeehive > 0 then
            local Data = json.decode(CurrentBeehive[1].data)
            Player.Functions.RemoveItem(Config.FoodItem, 1, false)
            
            local NewFood = Data.Food + Config.FoodGain
            if NewFood > 100 then
                NewFood = 100
            end
            Data.Food = NewFood
            
            MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
                json.encode(Data),
                HiveID
            })
            
            TriggerClientEvent('QBCore:Notify', src, _U('FoodAdded'), 'success', 5000)
            
            if Config.GiveBackEmpty then
                local CanCarry = Player.Functions.AddItem(Config.GiveBackEmptyItem, 1, false)
                if CanCarry then
                    Player.Functions.RemoveItem(Config.GiveBackEmptyItem, 1, false)
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, _U('NoFoodItem'), 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:AddWater', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local HasItem = Player.Functions.GetItemByName(Config.WaterItem)
    if HasItem and HasItem.amount > 0 then
        local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        
        -- Check if player owns this hive
        local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
        if #CurrentBeehive > 0 then
            local Data = json.decode(CurrentBeehive[1].data)
            Player.Functions.RemoveItem(Config.WaterItem, 1, false)
            
            local NewWater = Data.Water + Config.WaterGain
            if NewWater > 100 then
                NewWater = 100
            end
            Data.Water = NewWater
            
            MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
                json.encode(Data),
                HiveID
            })
            
            TriggerClientEvent('QBCore:Notify', src, _U('WaterAdded'), 'success', 5000)
            
            if Config.GiveBackEmpty then
                local CanCarry = Player.Functions.AddItem(Config.GiveBackEmptyItem, 1, false)
                if CanCarry then
                    Player.Functions.RemoveItem(Config.GiveBackEmptyItem, 1, false)
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, _U('NoWaterItem'), 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:AddClean', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local HasItem = Player.Functions.GetItemByName(Config.CleanItem)
    if HasItem and HasItem.amount > 0 then
        local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        
        -- Check if player owns this hive
        local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
        if #CurrentBeehive > 0 then
            local Data = json.decode(CurrentBeehive[1].data)
            Player.Functions.RemoveItem(Config.CleanItem, 1, false)
            
            local NewClean = Data.Clean + Config.CleanGain
            if NewClean > 100 then
                NewClean = 100
            end
            Data.Clean = NewClean
            
            MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
                json.encode(Data),
                HiveID
            })
            
            TriggerClientEvent('QBCore:Notify', src, _U('CleanAdded'), 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, _U('NoCleanItem'), 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:AddHealth', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local HasItem = Player.Functions.GetItemByName(Config.HealItem)
    if HasItem and HasItem.amount > 0 then
        local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        
        -- Check if player owns this hive
        local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
        if #CurrentBeehive > 0 then
            local Data = json.decode(CurrentBeehive[1].data)
            Player.Functions.RemoveItem(Config.HealItem, 1, false)
            
            local NewHealth = Data.Health + Config.HealGain
            if NewHealth > 100 then
                NewHealth = 100
            end
            Data.Health = NewHealth
            
            MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
                json.encode(Data),
                HiveID
            })
            
            TriggerClientEvent('QBCore:Notify', src, _U('HealthAdded'), 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, _U('NoHealItem'), 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:HealSickness', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #CurrentBeehive > 0 then
        local Data = json.decode(CurrentBeehive[1].data)
        
        if Data.Sickness.Type ~= "None" then
            local HasMedicine = Player.Functions.GetItemByName(Data.Sickness.MedicineLabel)
            if HasMedicine and HasMedicine.amount > 0 then
                Player.Functions.RemoveItem(Data.Sickness.MedicineLabel, 1, false)
                Data.Sickness.Type = "None"
                Data.Sickness.Intensity = 0
                Data.Sickness.MedicineLabel = ""
                
                MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
                    json.encode(Data),
                    HiveID
                })
                
                TriggerClientEvent('QBCore:Notify', src, _U('SicknessHealed'), 'success', 5000)
            else
                TriggerClientEvent('QBCore:Notify', src, _U('NoMedicine'), 'error', 5000)
            end
        else
            TriggerClientEvent('QBCore:Notify', src, _U('NoSickness'), 'error', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:GetBeehiveData', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #CurrentBeehive > 0 then
        TriggerClientEvent('mms-beekeeper:client:OpenMenu', src, CurrentBeehive)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:GetBeehiveDataForMenu', function(HiveID, hiveType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local CurrentBeehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #CurrentBeehive > 0 then
        if hiveType == 'bees' then
            TriggerClientEvent('mms-beekeeper:client:OpenBeeMenuData', src, CurrentBeehive, hiveType)
        elseif hiveType == 'wasps' then
            TriggerClientEvent('mms-beekeeper:client:OpenWaspMenuData', src, CurrentBeehive, hiveType)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not own this hive', 'error', 5000)
    end
end)

-- Wild beehive events
RegisterNetEvent('mms-beekeeper:server:GetBeeFromWild', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local HasItem = Player.Functions.GetItemByName(Config.EmptyBeeJar)
    if HasItem and HasItem.amount > 0 then
        local WildHive = Config.WildBeehives[HiveID]
        if WildHive then
            local BeeAmount = math.random(WildHive.GetBeeItemMin, WildHive.GetBeeItemMax)
            Player.Functions.RemoveItem(Config.EmptyBeeJar, 1, false)
            Player.Functions.AddItem(WildHive.GetBeeItem, BeeAmount, false)
            TriggerClientEvent('QBCore:Notify', src, _U('BeesCollected'), 'success', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, _U('NoEmptyJar'), 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:GetQueenFromWild', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local HasItem = Player.Functions.GetItemByName(Config.EmptyBeeJar)
    if HasItem and HasItem.amount > 0 then
        local WildHive = Config.WildBeehives[HiveID]
        if WildHive then
            local QueenAmount = math.random(WildHive.GetQueenItemMin, WildHive.GetQueenItemMax)
            Player.Functions.RemoveItem(Config.EmptyBeeJar, 1, false)
            Player.Functions.AddItem(WildHive.GetQueenItem, QueenAmount, false)
            TriggerClientEvent('QBCore:Notify', src, _U('QueenCollected'), 'success', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, _U('NoEmptyJar'), 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:TakeProductFromWild', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local WildHive = Config.WildBeehives[HiveID]
    if WildHive then
        local CanCarry = Player.Functions.AddItem(WildHive.ProductWildHive, WildHive.ProductGet, false)
        if CanCarry then
            Player.Functions.RemoveItem(WildHive.ProductWildHive, WildHive.ProductGet, false)
            TriggerClientEvent('QBCore:Notify', src, _U('ProductTaken'), 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, _U('CantCarry'), 'error', 5000)
        end
    end
end)

-- Admin commands
RegisterCommand('getbeehive', function(source, args, rawCommand)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.AddItem('beehive_box', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['beehive_box'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'You received a beehive box!', 'success')
    end
end, false)

RegisterCommand('getbeeitems', function(source, args, rawCommand)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        -- Basic bee items
        Player.Functions.AddItem('basic_queen', 5, false)
        Player.Functions.AddItem('basic_bees', 5, false)
        
        -- Hornet items
        Player.Functions.AddItem('basic_hornet_queen', 5, false)
        Player.Functions.AddItem('basic_hornets', 5, false)
        
        -- Other items
        Player.Functions.AddItem('empty_bee_jar', 10, false)
        Player.Functions.AddItem('torch_smoker', 1, false)
        Player.Functions.AddItem('bug_net', 1, false)
        Player.Functions.AddItem('sugar', 10, false)
        Player.Functions.AddItem('water', 10, false)
        Player.Functions.AddItem('wheat', 10, false)
        Player.Functions.AddItem('potato', 10, false)
        Player.Functions.AddItem('bandage', 5, false)
        TriggerClientEvent('QBCore:Notify', src, 'You received all bee and hornet items!', 'success')
    end
end, false)

RegisterCommand('deleteallbeehives', function(source, args, rawCommand)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Check if player has admin permissions (you can modify this check as needed)
    local hasPermission = false
    
    -- Check for admin job
    if Player.PlayerData.job.name == 'admin' then
        hasPermission = true
    end
    
    -- Check for admin permission
    if QBCore.Functions.HasPermission(src, 'admin') then
        hasPermission = true
    end
    
    -- Check for god permission (common admin permission)
    if QBCore.Functions.HasPermission(src, 'god') then
        hasPermission = true
    end
    
    -- Check for management permission
    if QBCore.Functions.HasPermission(src, 'management') then
        hasPermission = true
    end
    
    if not hasPermission then
        TriggerClientEvent('QBCore:Notify', src, 'You do not have permission to use this command', 'error', 5000)
        return
    end
    
    -- Get all beehives
    local Beehives = MySQL.query.await("SELECT * FROM mms_beekeeper", {})
    local deletedCount = 0
    
    if #Beehives > 0 then
        -- Delete all beehives from database
        MySQL.update('DELETE FROM mms_beekeeper', {})
        
        -- Notify all clients to remove all beehives
        TriggerClientEvent('mms-beekeeper:client:RemoveAllBeehives', -1)
        
        deletedCount = #Beehives
        TriggerClientEvent('QBCore:Notify', src, 'Deleted ' .. deletedCount .. ' beehives from the server', 'success', 5000)
        print("^3[MMS-Beekeeper]^7 Admin " .. Player.PlayerData.name .. " deleted " .. deletedCount .. " beehives")
    else
        TriggerClientEvent('QBCore:Notify', src, 'No beehives found to delete', 'primary', 3000)
    end
end, false)

-----------------------------------------------
--------------- Additional Events --------------
-----------------------------------------------

RegisterNetEvent('mms-beekeeper:server:LoadBeehives', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Load ALL beehives for all players to see
    local Beehives = MySQL.query.await("SELECT * FROM mms_beekeeper", {})
    
    local formattedBeehives = {}
    for h, v in ipairs(Beehives) do
        table.insert(formattedBeehives, {
            id = v.id,
            coords = json.decode(v.coords or '{"x":0,"y":0,"z":0}'),
            heading = v.heading or 0,
            data = v.data,
            owner = v.charident -- Include owner info
        })
    end
    
    TriggerClientEvent('mms-beekeeper:client:LoadBeehives', src, formattedBeehives)
end)

RegisterNetEvent('mms-beekeeper:server:DeleteBeehive', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local Beehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #Beehive > 0 then
        -- Delete from database
        MySQL.update('DELETE FROM mms_beekeeper WHERE id = ?', {HiveID})
        
        -- Remove hive for ALL clients (so blips disappear for everyone)
        TriggerClientEvent('mms-beekeeper:client:RemoveBeehive', -1, HiveID)
        
        TriggerClientEvent('QBCore:Notify', src, 'Successfully released bees into the wild', 'success', 5000)
        print("^2[MMS-Beekeeper]^7 Hive " .. HiveID .. " deleted by " .. characterName .. " - removed from all clients")
        
        -- Give back beehive box if enabled
        if Config.GetBackBoxItem then
            local CanCarry = Player.Functions.AddItem(Config.BeehiveItem, 1, false)
            if CanCarry then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.BeehiveItem], 'add')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'This is not your beehive', 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:AddHelper', function(HiveID, HelperID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local HelperPlayer = QBCore.Functions.GetPlayer(HelperID)
    if not HelperPlayer then
        TriggerClientEvent('QBCore:Notify', src, _U('PlayerNotFound'), 'error', 5000)
        return
    end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local helperCharacterName = HelperPlayer.PlayerData.charinfo.firstname .. " " .. HelperPlayer.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local Beehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #Beehive > 0 then
        local Data = json.decode(Beehive[1].data)
        Data.Helper.Name = HelperPlayer.PlayerData.charinfo.firstname .. " " .. HelperPlayer.PlayerData.charinfo.lastname
        Data.Helper.Ident = helperCharacterName
        
        MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
            json.encode(Data),
            HiveID
        })
        
        TriggerClientEvent('QBCore:Notify', src, _U('HelperAdded'), 'success', 5000)
        TriggerClientEvent('QBCore:Notify', HelperID, _U('YouAreNowHelper'), 'primary', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, _U('NotYourBeehive'), 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:RemoveHelper', function(HiveID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local Beehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #Beehive > 0 then
        local Data = json.decode(Beehive[1].data)
        local oldHelperName = Data.Helper.Name
        Data.Helper.Name = "None"
        Data.Helper.Ident = "None"
        
        MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
            json.encode(Data),
            HiveID
        })
        
        TriggerClientEvent('QBCore:Notify', src, _U('HelperRemoved'), 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, _U('NotYourBeehive'), 'error', 5000)
    end
end)

RegisterNetEvent('mms-beekeeper:server:SwitchHiveType', function(HiveID, newType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    local characterName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    
    -- Check if player owns this hive
    local Beehive = MySQL.query.await("SELECT * FROM mms_beekeeper WHERE id = ? AND charident = ?", {HiveID, characterName})
    if #Beehive > 0 then
        local Data = json.decode(Beehive[1].data)
        
        -- Only allow switch if no bees or queens present
        if Data.Bees > 0 or Data.Queen > 0 then
            TriggerClientEvent('QBCore:Notify', src, 'Cannot switch hive type while bees or queens are present', 'error', 5000)
            return
        end
        
        -- Reset bee settings based on new type
        if newType == "bees" then
            Data.BeeSettings.QueenItem = "basic_queen"
            Data.BeeSettings.QueenLabel = "Queen Bee"
            Data.BeeSettings.BeeItem = "basic_bees"
            Data.BeeSettings.BeeLabel = "Worker Bees"
            Data.BeeSettings.Product = "honey"
            Data.BeeSettings.ProductLabel = "Honey"
            Data.BeeSettings.ProductHappy = 0.015
            Data.BeeSettings.ProductNormal = 0.010
        elseif newType == "wasps" then
            Data.BeeSettings.QueenItem = "basic_hornet_queen"
            Data.BeeSettings.QueenLabel = "Hornet Queen"
            Data.BeeSettings.BeeItem = "basic_hornets"
            Data.BeeSettings.BeeLabel = "Hornet Workers"
            Data.BeeSettings.Product = "honey2"
            Data.BeeSettings.ProductLabel = "Manuka Honey"
            Data.BeeSettings.ProductHappy = 0.015
            Data.BeeSettings.ProductNormal = 0.010
        end
        
        MySQL.update('UPDATE mms_beekeeper SET data = ? WHERE id = ?', {
            json.encode(Data),
            HiveID
        })
        
        TriggerClientEvent('QBCore:Notify', src, 'Hive type switched to ' .. newType, 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, _U('NotYourBeehive'), 'error', 5000)
    end
end)

-----------------------------------------------
--------------- Admin Commands -----------------
-----------------------------------------------

-- New event handler for successful wild hive collection
RegisterNetEvent('mms-beekeeper:server:WildHiveSuccess', function(hiveId, originalIndex, clientLootTier)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Get the wild hive config data
    local hiveData = Config.WildBeehives[originalIndex]
    if not hiveData then return end
    
    -- Use the loot tier that was pre-rolled on client (difficulty matched this tier)
    local rewardTier = clientLootTier or "Common"
    local rewardItems = {}
    
    -- Tiered loot system (tier was determined client-side based on minigame difficulty):
    -- Common (Easy, 2 rounds): Only worker bees
    -- Uncommon (Medium, 3 rounds): Queen bee + 1 honey + worker wasps
    -- Rare (Hard, 4 rounds): 1 wasp queen
    -- Epic (Extreme, 5 rounds): 1 wasp queen + 1 manuka honey + worker wasps
    
    if rewardTier == "Common" then
        -- Tier 1: Easy difficulty - Only worker bees (basic_bees)
        local amount = math.random(1, 3) -- 1-3 worker bees
        table.insert(rewardItems, {item = "basic_bees", amount = amount, label = "Worker Bees"})
        
    elseif rewardTier == "Uncommon" then
        -- Tier 2: Medium difficulty - Queen bee + 1 honey + worker wasps
        table.insert(rewardItems, {item = "basic_queen", amount = 1, label = "Queen Bee"})
        table.insert(rewardItems, {item = "honey", amount = 1, label = "Honey"})
        local waspAmount = math.random(1, 3) -- 1-3 worker wasps
        table.insert(rewardItems, {item = "basic_hornets", amount = waspAmount, label = "Worker Wasps"})
        
    elseif rewardTier == "Rare" then
        -- Tier 3: Hard difficulty - 1 wasp queen only
        table.insert(rewardItems, {item = "basic_hornet_queen", amount = 1, label = "Wasp Queen"})
        
    else -- Epic
        -- Tier 4: Extreme difficulty - 1 wasp queen + 1 manuka honey + worker wasps
        table.insert(rewardItems, {item = "basic_hornet_queen", amount = 1, label = "Wasp Queen"})
        table.insert(rewardItems, {item = "honey2", amount = 1, label = "Manuka Honey"})
        local waspAmount = math.random(2, 4) -- 2-4 worker wasps (better than tier 2)
        table.insert(rewardItems, {item = "basic_hornets", amount = waspAmount, label = "Worker Wasps"})
    end
    
    -- Give all rewards to player
    local rewardText = ""
    for i, reward in ipairs(rewardItems) do
        local CanCarry = Player.Functions.AddItem(reward.item, reward.amount, false)
        if CanCarry then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[reward.item], 'add', reward.amount)
            if i > 1 then rewardText = rewardText .. ", " end
            rewardText = rewardText .. reward.amount .. "x " .. reward.label
        end
    end
    
    print("^2[MMS-Beekeeper]^7 Player " .. Player.PlayerData.name .. " collected from wild hive #" .. originalIndex .. " | Tier: " .. rewardTier .. " | Rewards: " .. rewardText)
    
    -- Send tier notification to player
    local tierColors = {
        Common = "primary",
        Uncommon = "success", 
        Rare = "warning",
        Epic = "error"
    }
    TriggerClientEvent('QBCore:Notify', src, '🐝 ' .. rewardTier .. ' Loot: ' .. rewardText, tierColors[rewardTier], 7000)
end)

-- Admin command to spawn all wild hives for testing
QBCore.Commands.Add('spawnallwildhives', 'Spawn all 100 wild beehives for testing (Admin Only)', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    -- Check if player has admin permissions
    if not QBCore.Functions.HasPermission(src, 'admin') then
        TriggerClientEvent('QBCore:Notify', src, 'You do not have permission to use this command', 'error', 5000)
        return
    end
    
    print("^2[MMS-Beekeeper]^7 Admin " .. Player.PlayerData.name .. " is spawning all wild hives for testing")
    TriggerClientEvent('mms-beekeeper:client:SpawnAllWildHives', src)
    TriggerClientEvent('QBCore:Notify', src, 'Spawning all 100 wild beehives for testing...', 'primary', 5000)
end, 'admin')

------------------------------------------------
---------------- Helper Functions ----------------
------------------------------------------------

-- Check if location is allowed for beehive placement (outside cities)
function IsLocationAllowedForBeehives(coords)
    local x, y, z = coords.x, coords.y, coords.z
    
    -- Los Santos city limits (approximate)
    local losSantosMinX, losSantosMaxX = -1200, 1200
    local losSantosMinY, losSantosMaxY = -2400, 800
    
    -- Check if coordinates are within Los Santos city limits
    if x >= losSantosMinX and x <= losSantosMaxX and y >= losSantosMinY and y <= losSantosMaxY then
        return false -- Inside city, not allowed
    end
    
    -- Allow in Sandy Shores area (roughly x: 1400-2800, y: 2700-4000)
    -- Allow in Paleto Bay area (roughly x: -200-800, y: 6000-7000)
    -- Allow in Grapeseed area (roughly x: 1600-2600, y: 4200-5500)
    -- Allow in other rural areas outside city limits
    
    return true -- Outside city, allowed
end

-- Check if location is far enough from other beehives
-- Now checks different distances for own hives vs other players' hives
function IsLocationFarEnoughFromOtherHives(coords, playerCharident)
    local Beehives = MySQL.query.await("SELECT * FROM mms_beekeeper", {})
    
    for _, hive in ipairs(Beehives) do
        local hiveCoords = json.decode(hive.coords or '{"x":0,"y":0,"z":0}')
        local distance = math.sqrt(
            (coords.x - hiveCoords.x)^2 + 
            (coords.y - hiveCoords.y)^2 + 
            (coords.z - hiveCoords.z)^2
        )
        
        -- Check if this hive belongs to the same player
        local isSamePlayer = (hive.charident == playerCharident)
        
        -- Use different minimum distances based on ownership
        local requiredDistance = isSamePlayer 
            and (Config.MinDistanceBetweenOwnHives or 0.0)
            or (Config.MinDistanceFromOtherPlayersHives or 25.0)
        
        if distance < requiredDistance then
            return false, isSamePlayer -- Return false and whether it was their own hive
        end
    end
    
    return true, false -- Far enough from all hives
end

-- Admin command to clear all wild hives
QBCore.Commands.Add('clearwildhives', 'Clear all wild beehives (Admin Only)', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    -- Check if player has admin permissions
    if not QBCore.Functions.HasPermission(src, 'admin') then
        TriggerClientEvent('QBCore:Notify', src, 'You do not have permission to use this command', 'error', 5000)
        return
    end
    
    print("^2[MMS-Beekeeper]^7 Admin " .. Player.PlayerData.name .. " is clearing all wild hives")
    TriggerClientEvent('mms-beekeeper:client:ClearAllWildHives', src)
    TriggerClientEvent('QBCore:Notify', src, 'Clearing all wild beehives...', 'primary', 5000)
end, 'admin')
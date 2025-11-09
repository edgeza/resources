local function extractPlayerInfo(charinfo, money)
    local firstname = "Unknown"
    local lastname = "Unknown"
    local cash = 0
    local bank = 0
    local crypto = 0
    
    -- Safely decode charinfo
    if charinfo and charinfo ~= '' then
        local success, charinfoData = pcall(function()
            return json.decode(charinfo)
        end)
        if success and type(charinfoData) == "table" then
            firstname = charinfoData.firstname or "Unknown"
            lastname = charinfoData.lastname or "Unknown"
        end
    end
    
    -- Safely decode money
    if money and money ~= '' then
        local success, moneyData = pcall(function()
            return json.decode(money)
        end)
        if success and type(moneyData) == "table" then
            cash = tonumber(moneyData.cash) or 0
            bank = tonumber(moneyData.bank) or 0
            crypto = tonumber(moneyData.crypto) or 0
        end
    end
    
    local total_money = cash + bank
    
    return firstname .. " " .. lastname, cash, bank, crypto, total_money
end

local function hasPermission(player)
    for _, group in ipairs(Config.AllowedGroups) do
        if exports.qbx_core:HasPermission(player, group) then
            return true
        end
    end
    return false
end

-- Optimized: Batch query all vehicles
local function getAllVehicles()
    local success, result = pcall(function()
        return MySQL.query.await('SELECT citizenid, COUNT(*) as count FROM ' .. Config.DatabaseTables.vehicles .. ' GROUP BY citizenid')
    end)
    
    if not success then
        print('[OLRP Monitor] Warning: Could not query vehicles table: ' .. tostring(result))
        return {}
    end
    
    if result and type(result) == "table" then
        local vehicleMap = {}
        for i = 1, #result do
            if result[i] and result[i].citizenid then
                vehicleMap[result[i].citizenid] = tonumber(result[i].count) or 0
            end
        end
        return vehicleMap
    end
    return {}
end

-- Optimized: Batch query all trucking money
local function getAllTruckingMoney()
    local success, result = pcall(function()
        return MySQL.query.await('SELECT user_id, money FROM ' .. Config.DatabaseTables.trucker)
    end)
    
    if not success then
        print('[OLRP Monitor] Warning: Could not query trucker table: ' .. tostring(result))
        return {}
    end
    
    if result and type(result) == "table" then
        local truckingMap = {}
        for i = 1, #result do
            if result[i] and result[i].user_id then
                truckingMap[result[i].user_id] = tonumber(result[i].money) or 0
            end
        end
        return truckingMap
    end
    return {}
end

-- Optimized: Batch query all savings accounts
local function getAllSavingsAccounts()
    local success, result = pcall(function()
        return MySQL.query.await('SELECT id, amount, auth FROM ' .. Config.DatabaseTables.bankAccounts)
    end)
    
    if not success then
        print('[OLRP Monitor] Warning: Could not query bank_accounts table: ' .. tostring(result))
        return {}
    end
    
    if result and type(result) == "table" then
        local savingsMap = {}
        for i = 1, #result do
            if result[i] then
                local auth = result[i].auth
                if auth and auth ~= '' and auth ~= '[]' then
                    local authSuccess, authData = pcall(function()
                        return json.decode(auth)
                    end)
                    
                    if authSuccess and type(authData) == "table" then
                        for _, citizenid in ipairs(authData) do
                            if citizenid and type(citizenid) == "string" then
                                if not savingsMap[citizenid] then
                                    savingsMap[citizenid] = 0
                                end
                                savingsMap[citizenid] = savingsMap[citizenid] + (tonumber(result[i].amount) or 0)
                            end
                        end
                    elseif type(auth) == "string" and string.find(auth, '"') then
                        -- Try to extract citizenid from string format like ["Z262P1E3"]
                        for citizenid in string.gmatch(auth, '"([^"]+)"') do
                            if not savingsMap[citizenid] then
                                savingsMap[citizenid] = 0
                            end
                            savingsMap[citizenid] = savingsMap[citizenid] + (tonumber(result[i].amount) or 0)
                        end
                    end
                end
            end
        end
        return savingsMap
    end
    return {}
end

-- Optimized: Batch query all society accounts
local function getAllSocietyAccounts()
    local success, result = pcall(function()
        return MySQL.query.await('SELECT id, amount, auth FROM ' .. Config.DatabaseTables.societyAccounts)
    end)
    
    if not success then
        print('[OLRP Monitor] Warning: Could not query society_accounts table: ' .. tostring(result))
        return {}, {}
    end
    
    if result and type(result) == "table" then
        local societyMap = {}
        local societyListMap = {}
        for i = 1, #result do
            if result[i] then
                local auth = result[i].auth
                local societyId = result[i].id
                local amount = tonumber(result[i].amount) or 0
                
                if auth and auth ~= '' and auth ~= '[]' then
                    local authSuccess, authData = pcall(function()
                        return json.decode(auth)
                    end)
                    
                    if authSuccess and type(authData) == "table" then
                        for _, citizenid in ipairs(authData) do
                            if citizenid and type(citizenid) == "string" then
                                if not societyMap[citizenid] then
                                    societyMap[citizenid] = 0
                                    societyListMap[citizenid] = {}
                                end
                                societyMap[citizenid] = societyMap[citizenid] + amount
                                table.insert(societyListMap[citizenid], {
                                    id = societyId,
                                    amount = amount
                                })
                            end
                        end
                    elseif type(auth) == "string" and string.find(auth, '"') then
                        -- Try to extract citizenid from string format
                        for citizenid in string.gmatch(auth, '"([^"]+)"') do
                            if not societyMap[citizenid] then
                                societyMap[citizenid] = 0
                                societyListMap[citizenid] = {}
                            end
                            societyMap[citizenid] = societyMap[citizenid] + amount
                            table.insert(societyListMap[citizenid], {
                                id = societyId,
                                amount = amount
                            })
                        end
                    end
                end
            end
        end
        return societyMap, societyListMap
    end
    return {}, {}
end

-- Optimized: Batch query item counts (if needed)
local function getAllItemCounts()
    local success, result = pcall(function()
        -- Try ox_inventory
        local oxResult = MySQL.query.await('SELECT owner, COUNT(*) as count FROM ox_inventory GROUP BY owner')
        if oxResult and type(oxResult) == "table" and #oxResult > 0 then
            local itemMap = {}
            for i = 1, #oxResult do
                if oxResult[i] and oxResult[i].owner then
                    itemMap[oxResult[i].owner] = tonumber(oxResult[i].count) or 0
                end
            end
            return itemMap
        end
        return {}
    end)
    
    if success and result then
        return result
    end
    return {}
end

-- Get transaction history for money flow
local function getTransactionHistory(citizenid)
    local success, result = pcall(function()
        -- Get society transactions - try different column names
        local societyTrans = MySQL.query.await('SELECT * FROM ' .. Config.DatabaseTables.societyTransactions .. ' WHERE employee = ? ORDER BY timestamp DESC LIMIT 100', {citizenid})
        
        if not societyTrans or (type(societyTrans) == "table" and #societyTrans == 0) then
            -- Try alternative column name (executor)
            societyTrans = MySQL.query.await('SELECT * FROM ' .. Config.DatabaseTables.societyTransactions .. ' WHERE executor = ? ORDER BY timestamp DESC LIMIT 100', {citizenid})
        end
        
        if societyTrans and type(societyTrans) == "table" then
            return societyTrans
        end
        return {}
    end)
    
    if not success then
        print('[OLRP Monitor] Warning: Could not query society_transactions: ' .. tostring(result))
        return {}
    end
    
    if success and result then
        return result or {}
    end
    return {}
end

RegisterNetEvent('olrp_monitor:refreshData', function()
    local source = source
    if not hasPermission(source) then
        return
    end
    
    -- Batch load all data at once with error handling
    local success, playersResponse = pcall(function()
        return MySQL.query.await('SELECT citizenid, charinfo, money FROM ' .. Config.DatabaseTables.players)
    end)
    
    if not success then
        print('[OLRP Monitor] Error querying players: ' .. tostring(playersResponse))
        TriggerClientEvent('ox_lib:notify', source, {
            description = 'Error loading player data. Check server console.',
            type = 'error'
        })
        return
    end
    
    if not playersResponse or type(playersResponse) ~= "table" or #playersResponse == 0 then
        TriggerClientEvent('ox_lib:notify', source, {
            description = Config.Texts.noDataFound,
            type = 'error'
        })
        return
    end

    -- Batch query all supporting data
    local vehicleMap = getAllVehicles()
    local truckingMap = getAllTruckingMoney()
    local savingsMap = getAllSavingsAccounts()
    local societyMap, societyListMap = getAllSocietyAccounts()
    local itemMap = getAllItemCounts()

    local totalCash = 0
    local totalBank = 0
    local totalCrypto = 0
    local totalVehicles = 0
    local totalTruckingMoney = 0
    local totalSavingsAccounts = 0
    local totalSocietyAccounts = 0
    local playerData = {}

    for i = 1, #playersResponse do
        local citizenid = playersResponse[i].citizenid
        local playerName, cash, bank, crypto, total_money = extractPlayerInfo(playersResponse[i].charinfo, playersResponse[i].money)
        
        -- Get data from maps (O(1) lookup)
        local vehicleCount = vehicleMap[citizenid] or 0
        local truckingMoney = truckingMap[citizenid] or 0
        local savingsAccount = savingsMap[citizenid] or 0
        local societyAccounts = societyMap[citizenid] or 0
        local societyList = societyListMap[citizenid] or {}
        local itemCount = itemMap[citizenid] or 0
        
        totalVehicles = totalVehicles + vehicleCount
        totalTruckingMoney = totalTruckingMoney + truckingMoney
        totalSavingsAccounts = totalSavingsAccounts + savingsAccount
        totalSocietyAccounts = totalSocietyAccounts + societyAccounts
        
        -- Calculate networth
        local vehicleValue = vehicleCount * Config.VehicleBaseValue
        local networth = cash + bank + crypto + vehicleValue + truckingMoney + savingsAccount + societyAccounts
        
        local playerEntry = {
            name = playerName,
            citizenid = citizenid,
            cash = cash,
            bank = bank,
            crypto = crypto,
            total = total_money,
            vehicleCount = vehicleCount,
            itemCount = itemCount,
            vehicleValue = vehicleValue,
            truckingMoney = truckingMoney,
            savingsAccount = savingsAccount,
            societyAccounts = societyAccounts,
            societyList = societyList,
            networth = networth,
            isSuspicious = false,
            abuseFlags = {}
        }
        
        table.insert(playerData, playerEntry)
        
        totalCash = totalCash + cash
        totalBank = totalBank + bank
        totalCrypto = totalCrypto + crypto
    end

    table.sort(playerData, function(a, b) return a.networth > b.networth end)

    local totalAmount = totalCash + totalBank
    
    TriggerClientEvent('olrp_monitor:showEconomy', source, playerData, totalAmount, totalCrypto, totalVehicles, totalTruckingMoney, totalSavingsAccounts, totalSocietyAccounts)
end)

RegisterCommand("olrpmonitor", function(source, args, rawCommand)
    if not hasPermission(source) then
        TriggerClientEvent('ox_lib:notify', source, {
            description = Config.Texts.noPermission,
            type = 'error'
        })
        return
    end

    TriggerClientEvent('ox_lib:notify', source, {
        description = "Loading economy data...",
        type = 'info'
    })

    -- Batch load all data at once with error handling
    local success, playersResponse = pcall(function()
        return MySQL.query.await('SELECT citizenid, charinfo, money FROM ' .. Config.DatabaseTables.players)
    end)
    
    if not success then
        print('[OLRP Monitor] Error querying players: ' .. tostring(playersResponse))
        TriggerClientEvent('ox_lib:notify', source, {
            description = 'Error loading player data. Check server console.',
            type = 'error'
        })
        return
    end

    if not playersResponse or type(playersResponse) ~= "table" or #playersResponse == 0 then
        TriggerClientEvent('ox_lib:notify', source, {
            description = Config.Texts.noDataFound,
            type = 'error'
        })
        return
    end

    -- Batch query all supporting data
    local vehicleMap = getAllVehicles()
    local truckingMap = getAllTruckingMoney()
    local savingsMap = getAllSavingsAccounts()
    local societyMap, societyListMap = getAllSocietyAccounts()
    local itemMap = getAllItemCounts()

    local totalCash = 0
    local totalBank = 0
    local totalCrypto = 0
    local totalVehicles = 0
    local totalTruckingMoney = 0
    local totalSavingsAccounts = 0
    local totalSocietyAccounts = 0
    local playerData = {}

    for i = 1, #playersResponse do
        local citizenid = playersResponse[i].citizenid
        local playerName, cash, bank, crypto, total_money = extractPlayerInfo(playersResponse[i].charinfo, playersResponse[i].money)
        
        -- Get data from maps (O(1) lookup)
        local vehicleCount = vehicleMap[citizenid] or 0
        local truckingMoney = truckingMap[citizenid] or 0
        local savingsAccount = savingsMap[citizenid] or 0
        local societyAccounts = societyMap[citizenid] or 0
        local societyList = societyListMap[citizenid] or {}
        local itemCount = itemMap[citizenid] or 0
        
        totalVehicles = totalVehicles + vehicleCount
        totalTruckingMoney = totalTruckingMoney + truckingMoney
        totalSavingsAccounts = totalSavingsAccounts + savingsAccount
        totalSocietyAccounts = totalSocietyAccounts + societyAccounts
        
        -- Calculate networth
        local vehicleValue = vehicleCount * Config.VehicleBaseValue
        local networth = cash + bank + crypto + vehicleValue + truckingMoney + savingsAccount + societyAccounts
        
        local playerEntry = {
            name = playerName,
            citizenid = citizenid,
            cash = cash,
            bank = bank,
            crypto = crypto,
            total = total_money,
            vehicleCount = vehicleCount,
            itemCount = itemCount,
            vehicleValue = vehicleValue,
            truckingMoney = truckingMoney,
            savingsAccount = savingsAccount,
            societyAccounts = societyAccounts,
            societyList = societyList,
            networth = networth,
            isSuspicious = false,
            abuseFlags = {}
        }
        
        table.insert(playerData, playerEntry)
        
        totalCash = totalCash + cash
        totalBank = totalBank + bank
        totalCrypto = totalCrypto + crypto
    end

    table.sort(playerData, function(a, b) return a.networth > b.networth end)

    local totalAmount = totalCash + totalBank
    
    TriggerClientEvent('olrp_monitor:showEconomy', source, playerData, totalAmount, totalCrypto, totalVehicles, totalTruckingMoney, totalSavingsAccounts, totalSocietyAccounts)
end, false)

-- Get money flow data for a specific player
RegisterNetEvent('olrp_monitor:getMoneyFlow', function(citizenid)
    local source = source
    if not hasPermission(source) then
        return
    end
    
    if not citizenid or citizenid == '' then
        print('[OLRP Monitor] Error: No citizenid provided for money flow')
        return
    end
    
    local transactions = getTransactionHistory(citizenid)
    
    TriggerClientEvent('olrp_monitor:receiveMoneyFlow', source, citizenid, transactions)
end)

-- Legacy command support
RegisterCommand("richestplayers", function(source, args, rawCommand)
    ExecuteCommand("olrpmonitor")
end, false)

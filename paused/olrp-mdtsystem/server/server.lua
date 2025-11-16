-- MDT Police Server Script
local QBCore = nil
local reports = {}
local bolos = {}

-- Resource Information
local ResourceName = GetCurrentResourceName()
local Version = '1.0.0'
local Author = 'Raihil Singh'

-- Database system detection
local useOxMySQL = GetResourceState('oxmysql') == 'started'
local useMySQLAsync = GetResourceState('mysql-async') == 'started'

-- Try to get QBCore/ESX framework (adjust based on your framework)
if GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif GetResourceState('es_extended') == 'started' then
    QBCore = exports['es_extended']:getSharedObject()
end

-- Print startup banner
Citizen.CreateThread(function()
    Citizen.Wait(100)
    print('')
    print('^3[    script:' .. ResourceName .. ']^7   //')
    print('^3[    script:' .. ResourceName .. ']^7   ||')
    print('^3[    script:' .. ResourceName .. ']^7   ||     __  __ _____  ____  __      __  _____ _____ ')
    print('^3[    script:' .. ResourceName .. ']^7   ||    |  \\/  |  __ \\|  _ \\ \\ \\    / / |  __ \\_   _|')
    print('^3[    script:' .. ResourceName .. ']^7   ||    | \\  / | |  | | |_) | \\ \\  / /  | |  | || |  ')
    print('^3[    script:' .. ResourceName .. ']^7   ||    | |\\/| | |  | |  _ <   \\ \\/ /   | |  | || |  ')
    print('^3[    script:' .. ResourceName .. ']^7   ||    | |  | | |__| | |_) |   \\  /    | |__| || |_ ')
    print('^3[    script:' .. ResourceName .. ']^7   ||    |_|  |_|_____/|____/     \\/     |_____/_____|')
    print('^3[    script:' .. ResourceName .. ']^7   ||')
    print('^3[    script:' .. ResourceName .. ']^7   ||     __  __  ____  _____ ')
    print('^3[    script:' .. ResourceName .. ']^7   ||    |  \\/  |/ __ \\|  __ \\')
    print('^3[    script:' .. ResourceName .. ']^7   ||    | \\  / | |  | | |  | |')
    print('^3[    script:' .. ResourceName .. ']^7   ||    | |\\/| | |  | | |  | |')
    print('^3[    script:' .. ResourceName .. ']^7   ||    | |  | | |__| | |__| |')
    print('^3[    script:' .. ResourceName .. ']^7   ||    |_|  |_|\\____/|_____/ ')
    print('^3[    script:' .. ResourceName .. ']^7   ||')
    print('^3[    script:' .. ResourceName .. ']^7   ||                        Created by ' .. Author)
    print('^3[    script:' .. ResourceName .. ']^7   ||')
    print('^3[    script:' .. ResourceName .. ']^7   ||    Current version: ' .. Version)
    print('^3[    script:' .. ResourceName .. ']^7   ||    Latest recommended version: ' .. Version)
    print('^3[    script:' .. ResourceName .. ']^7   ||')
    
    -- Database system check
    local dbStatus = '^1Not Detected^7'
    if useOxMySQL then
        dbStatus = '^2oxmysql^7'
    elseif useMySQLAsync then
        dbStatus = '^2mysql-async^7'
    elseif QBCore and QBCore.Functions then
        dbStatus = '^2QBCore Database^7'
    end
    
    print('^3[    script:' .. ResourceName .. ']^7   ||    Database System: ' .. dbStatus)
    
    -- Framework check
    local frameworkStatus = '^1Not Detected^7'
    if GetResourceState('qb-core') == 'started' then
        frameworkStatus = '^2QBCore^7'
    elseif GetResourceState('es_extended') == 'started' then
        frameworkStatus = '^2ESX^7'
    end
    
    print('^3[    script:' .. ResourceName .. ']^7   ||    Framework: ' .. frameworkStatus)
    print('^3[    script:' .. ResourceName .. ']^7   ||')
    print('^3[    script:' .. ResourceName .. ']^7   ||    ^2LSPD Mobile Data Terminal System is ready!^7')
    print('^3[    script:' .. ResourceName .. ']^7   ||')
    print('^3[    script:' .. ResourceName .. ']^7   \\\\')
    print('')
end)

-- Database helper function for SELECT queries
local function ExecuteSQL(query, params, callback)
    if useOxMySQL then
        exports.oxmysql:query(query, params or {}, callback or function() end)
    elseif useMySQLAsync then
        MySQL.Async.fetchAll(query, params or {}, callback or function() end)
    elseif QBCore and QBCore.Functions then
        -- QBCore database functions
        QBCore.Functions.ExecuteSql(query, params or {}, callback or function() end)
    else
        print('[MDT] Warning: No database system detected. Install oxmysql or mysql-async.')
        if callback then callback({}) end
    end
end

-- Database helper function for INSERT/UPDATE/DELETE queries
local function ExecuteSQLInsert(query, params, callback)
    if useOxMySQL then
        exports.oxmysql:query(query, params or {}, function(result)
            -- oxmysql returns object with insertId for INSERT, or affectedRows for UPDATE/DELETE
            local success = result and (result.insertId or result.affectedRows or false)
            if callback then callback(success and success > 0) end
        end)
    elseif useMySQLAsync then
        MySQL.Async.execute(query, params or {}, function(result)
            if callback then callback(result and result > 0) end
        end)
    elseif QBCore and QBCore.Functions then
        QBCore.Functions.ExecuteSql(query, params or {}, callback or function() end)
    else
        print('[MDT] Warning: No database system detected. Install oxmysql or mysql-async.')
        if callback then callback(false) end
    end
end

-- Initialize database tables (run this once to create tables)
--[[
CREATE TABLE IF NOT EXISTS `mdt_reports` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `title` varchar(255) NOT NULL,
    `location` varchar(255) DEFAULT NULL,
    `summary` text,
    `suspects` varchar(255) DEFAULT NULL,
    `fine` int(11) DEFAULT 0,
    `officer` varchar(255) NOT NULL,
    `date` varchar(50) NOT NULL,
    `time` varchar(50) NOT NULL,
    `status` varchar(50) DEFAULT 'Open',
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `mdt_bolos` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `type` varchar(50) NOT NULL,
    `title` varchar(255) NOT NULL,
    `description` text,
    `date` varchar(50) NOT NULL,
    `created_by` varchar(255) NOT NULL,
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `mdt_staff_logs` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `officer` varchar(255) NOT NULL,
    `badge` varchar(50) NOT NULL,
    `start_time` varchar(50) NOT NULL,
    `end_time` varchar(50) DEFAULT NULL,
    `duration` varchar(50) DEFAULT NULL,
    `date` varchar(50) NOT NULL,
    PRIMARY KEY (`id`)
);
--]]

-- Event for getting officer data
RegisterServerEvent('mdt:getOfficerData')
AddEventHandler('mdt:getOfficerData', function()
    local src = source
    local playerName = GetPlayerName(src)
    local playerData = GetPlayerData(src)
    
    local officerData = {
        name = playerName,
        rank = playerData.rank or "Directive - D-1",
        badge = playerData.badge or "D-1",
        department = playerData.department or "LSPD"
    }
    
    TriggerClientEvent('mdt:receiveOfficerData', src, officerData)
end)

-- Store for player locations (temporary cache)
local playerLocations = {}
local locationRequestId = 0

-- Event for receiving player location from client
RegisterServerEvent('mdt:receivePlayerLocation')
AddEventHandler('mdt:receivePlayerLocation', function(requestId, location)
    playerLocations[requestId] = location
end)

-- Event for getting active units
RegisterServerEvent('mdt:getActiveUnits')
AddEventHandler('mdt:getActiveUnits', function()
    local src = source
    local activeUnits = {}
    playerLocations = {} -- Clear previous locations
    
    -- Collect all police player IDs
    local policePlayers = {}
    if IsPlayerPolice(src) then
        table.insert(policePlayers, src)
    end
    
    for _, player in ipairs(GetPlayers()) do
        local playerId = tonumber(player)
        if playerId ~= src and IsPlayerPolice(playerId) then
            table.insert(policePlayers, playerId)
        end
    end
    
    -- Request locations from all police players
    locationRequestId = locationRequestId + 1
    local currentRequestId = locationRequestId
    
    for _, playerId in ipairs(policePlayers) do
        TriggerClientEvent('mdt:requestPlayerLocation', playerId, currentRequestId .. '_' .. playerId)
    end
    
    -- Wait a bit for clients to respond (async)
    Citizen.SetTimeout(500, function()
        -- Build active units list
        for _, playerId in ipairs(policePlayers) do
            local locationKey = currentRequestId .. '_' .. playerId
            local location = playerLocations[locationKey] or "Unknown Location"
            
            table.insert(activeUnits, {
                id = playerId,
                name = GetPlayerName(playerId),
                badge = GetPlayerBadge(playerId),
                status = GetPlayerStatus(playerId),
                location = location,
                call = GetPlayerCall(playerId)
            })
        end
        
        -- Always send response, even if empty
        TriggerClientEvent('mdt:receiveActiveUnits', src, activeUnits)
        print('[MDT] Sent ' .. #activeUnits .. ' active units to player ' .. src)
        
        -- Clean up location cache after a delay
        Citizen.SetTimeout(1000, function()
            for k, _ in pairs(playerLocations) do
                if string.find(k, tostring(currentRequestId)) then
                    playerLocations[k] = nil
                end
            end
        end)
    end)
end)

-- Event for searching profiles
RegisterServerEvent('mdt:searchProfiles')
AddEventHandler('mdt:searchProfiles', function(query)
    local src = source
    print('[MDT] Profile search requested by player ' .. src .. ' for: ' .. tostring(query))
    
    if not query or query == '' then
        print('[MDT] Empty query, returning empty results')
        TriggerClientEvent('mdt:receiveProfiles', src, {})
        return
    end
    
    -- Search profiles from database
    SearchProfilesAsync(query, function(results)
        print('[MDT] Sending ' .. #results .. ' profile results to player ' .. src)
        TriggerClientEvent('mdt:receiveProfiles', src, results)
    end)
end)

-- Async version of SearchProfiles
function SearchProfilesAsync(query, callback)
    local results = {}
    local searchQuery = '%' .. query .. '%'
    
    print('[MDT] Searching profiles for: ' .. query)
    
    if QBCore then
        local sqlQuery = 'SELECT * FROM players WHERE charinfo LIKE ? OR citizenid LIKE ? LIMIT 20'
        local params = { searchQuery, searchQuery }
        
        ExecuteSQL(sqlQuery, params, function(result)
            print('[MDT] Query result: ' .. (result and #result or 0) .. ' rows found')
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    local charinfo = {}
                    local metadata = {}
                    
                    -- Safely decode JSON
                    if row.charinfo then
                        local success, decoded = pcall(json.decode, row.charinfo)
                        if success then charinfo = decoded else charinfo = {} end
                    end
                    
                    if row.metadata then
                        local success, decoded = pcall(json.decode, row.metadata)
                        if success then metadata = decoded else metadata = {} end
                    end
                    
                    table.insert(results, {
                        id = row.citizenid or 'N/A',
                        name = (charinfo.firstname or '') .. ' ' .. (charinfo.lastname or ''),
                        dob = charinfo.birthdate or 'N/A',
                        address = charinfo.address or 'N/A',
                        phone = charinfo.phone or 'N/A',
                        convictions = metadata.convictions or metadata.warrants or 'None',
                        license = metadata.licenses and metadata.licenses.driver or 'Valid'
                    })
                end
            end
            if callback then callback(results) end
        end)
    else
        -- ESX or fallback
        local sqlQuery = 'SELECT * FROM users WHERE firstname LIKE ? OR lastname LIKE ? OR identifier LIKE ? LIMIT 20'
        local params = { searchQuery, searchQuery, searchQuery }
        
        ExecuteSQL(sqlQuery, params, function(result)
            print('[MDT] Query result: ' .. (result and #result or 0) .. ' rows found')
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    table.insert(results, {
                        id = row.identifier or 'N/A',
                        name = (row.firstname or '') .. ' ' .. (row.lastname or ''),
                        dob = row.dateofbirth or 'N/A',
                        address = row.address or 'N/A',
                        phone = row.phone_number or 'N/A',
                        convictions = 'None',
                        license = 'Valid'
                    })
                end
            end
            if callback then callback(results) end
        end)
    end
end

-- Event for submitting reports
RegisterServerEvent('mdt:submitReport')
AddEventHandler('mdt:submitReport', function(report)
    local src = source
    local playerName = GetPlayerName(src)
    
    -- Add report metadata
    report.officer = playerName
    report.date = os.date('%m/%d/%Y')
    report.time = os.date('%H:%M')
    report.status = report.status or 'Open'
    
    -- Save to database
    local query = 'INSERT INTO mdt_reports (title, location, summary, suspects, fine, officer, date, time, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)'
    local params = {
        report.title,
        report.location,
        report.summary,
        report.suspects,
        report.fine or 0,
        playerName,
        report.date,
        report.time,
        report.status
    }
    
    ExecuteSQLInsert(query, params, function(success)
        if success then
            print('[MDT] Report submitted by ' .. playerName .. ': ' .. report.title)
            -- Reload reports for all police officers
            LoadReports()
        else
            print('[MDT] Error saving report to database')
        end
    end)
end)

-- Event for getting reports
RegisterServerEvent('mdt:getReports')
AddEventHandler('mdt:getReports', function()
    local src = source
    LoadReports(function(reportsList)
        TriggerClientEvent('mdt:receiveReports', src, reportsList)
    end)
end)

-- Load reports from database
function LoadReports(callback)
    -- Order by id DESC (most recent first) since date/time columns may not exist
    local query = 'SELECT * FROM mdt_reports ORDER BY id DESC'
    ExecuteSQL(query, {}, function(result)
        if result and #result > 0 then
            reports = {}
            for i, row in ipairs(result) do
                table.insert(reports, {
                    id = row.id,
                    title = row.title,
                    location = row.location,
                    summary = row.summary,
                    suspects = row.suspects,
                    fine = row.fine,
                    officer = row.officer,
                    date = row.date,
                    time = row.time,
                    status = row.status
                })
            end
        else
            reports = {}
        end
        
        if callback then callback(reports) end
        
        -- Notify all police officers
        for _, player in ipairs(GetPlayers()) do
            local playerId = tonumber(player)
            if IsPlayerPolice(playerId) then
                TriggerClientEvent('mdt:receiveReports', playerId, reports)
            end
        end
    end)
end

-- Event for getting BOLOs
RegisterServerEvent('mdt:getBOLOs')
AddEventHandler('mdt:getBOLOs', function()
    local src = source
    LoadBOLOs(function(bolosList)
        TriggerClientEvent('mdt:receiveBOLOs', src, bolosList)
    end)
end)

-- Load BOLOs from database
function LoadBOLOs(callback)
    -- Order by id DESC (most recent first) since date column may not exist
    local query = 'SELECT * FROM mdt_bolos ORDER BY id DESC'
    ExecuteSQL(query, {}, function(result)
        if result and #result > 0 then
            bolos = {}
            for i, row in ipairs(result) do
                table.insert(bolos, {
                    id = row.id,
                    type = row.type,
                    title = row.title,
                    description = row.description,
                    date = row.date
                })
            end
        else
            bolos = {}
        end
        
        if callback then callback(bolos) end
    end)
end

-- Event for vehicle search
RegisterServerEvent('mdt:searchVehicle')
AddEventHandler('mdt:searchVehicle', function(plate)
    local src = source
    if not plate or plate == '' then
        TriggerClientEvent('mdt:receiveVehicle', src, {})
        return
    end
    
    -- Search vehicle from database
    SearchVehicleAsync(plate, function(vehicle)
        TriggerClientEvent('mdt:receiveVehicle', src, vehicle)
    end)
end)

-- Async version of SearchVehicle
function SearchVehicleAsync(plate, callback)
    local vehicle = {}
    local cleanPlate = string.upper(string.gsub(plate, "%s+", ""))
    
    local query = 'SELECT * FROM owned_vehicles WHERE plate = ? LIMIT 1'
    local params = { cleanPlate }
    
    ExecuteSQL(query, params, function(result)
        if result and #result > 0 then
            local row = result[1]
            local vehicleData = json.decode(row.vehicle or '{}')
            local mods = json.decode(row.mods or '{}')
            
            -- Get owner info
            local ownerQuery = 'SELECT * FROM players WHERE citizenid = ? LIMIT 1'
            local ownerParams = { row.citizenid }
            
            ExecuteSQL(ownerQuery, ownerParams, function(ownerResult)
                local ownerName = 'Unknown'
                if ownerResult and #ownerResult > 0 then
                    local charinfo = json.decode(ownerResult[1].charinfo or '{}')
                    ownerName = charinfo.firstname .. ' ' .. charinfo.lastname
                end
                
                vehicle = {
                    plate = cleanPlate,
                    make = vehicleData.make or 'Unknown',
                    model = vehicleData.model or 'Unknown',
                    color = mods.color1 and ('Color ' .. mods.color1) or 'Unknown',
                    owner = ownerName,
                    registration = row.registration or 'Valid',
                    status = row.stolen and 'STOLEN - APPROACH WITH CAUTION' or 'Valid'
                }
                
                if callback then callback(vehicle) end
            end)
        else
            if callback then callback({}) end
        end
    end)
end

-- Event for weapon search
RegisterServerEvent('mdt:searchWeapons')
AddEventHandler('mdt:searchWeapons', function(query)
    local src = source
    if not query or query == '' then
        TriggerClientEvent('mdt:receiveWeapons', src, {})
        return
    end
    
    -- Search weapons from database
    SearchWeaponsAsync(query, function(weapons)
        TriggerClientEvent('mdt:receiveWeapons', src, weapons)
    end)
end)

-- Async version of SearchWeapons
function SearchWeaponsAsync(query, callback)
    local weapons = {}
    local searchQuery = '%' .. query .. '%'
    
    if QBCore then
        local query = 'SELECT * FROM player_weapons WHERE serialnumber LIKE ? OR owner LIKE ? LIMIT 20'
        local params = { searchQuery, searchQuery }
        
        ExecuteSQL(query, params, function(result)
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    table.insert(weapons, {
                        serial = row.serialnumber,
                        type = row.weapon,
                        owner = row.owner,
                        status = row.registered and 'Valid' or 'Unregistered',
                        lastChecked = row.last_checked or 'N/A'
                    })
                end
            end
            if callback then callback(weapons) end
        end)
    else
        local query = 'SELECT * FROM items WHERE name LIKE ? AND type = "weapon" LIMIT 20'
        local params = { searchQuery }
        
        ExecuteSQL(query, params, function(result)
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    table.insert(weapons, {
                        serial = row.name,
                        type = row.label,
                        owner = 'Unknown',
                        status = 'Valid',
                        lastChecked = 'N/A'
                    })
                end
            end
            if callback then callback(weapons) end
        end)
    end
end

-- Event for getting cameras
RegisterServerEvent('mdt:getCameras')
AddEventHandler('mdt:getCameras', function()
    local src = source
    local cameras = GetCameras()
    TriggerClientEvent('mdt:receiveCameras', src, cameras)
end)

-- Event for getting staff logs
RegisterServerEvent('mdt:getStaffLogs')
AddEventHandler('mdt:getStaffLogs', function()
    local src = source
    GetStaffLogsAsync(function(logs)
        TriggerClientEvent('mdt:receiveStaffLogs', src, logs)
    end)
end)

-- Dispatch System
local activeDispatchCalls = {}
local callIdCounter = 1

-- Event for getting active dispatch calls
RegisterServerEvent('mdt:getActiveCalls')
AddEventHandler('mdt:getActiveCalls', function()
    local src = source
    local calls = {}
    
    for _, call in pairs(activeDispatchCalls) do
        table.insert(calls, call)
    end
    
    TriggerClientEvent('mdt:receiveActiveCalls', src, calls)
end)

-- Event for creating dispatch call
RegisterServerEvent('mdt:createDispatchCall')
AddEventHandler('mdt:createDispatchCall', function(callData)
    local src = source
    callData.id = callIdCounter
    callIdCounter = callIdCounter + 1
    callData.timestamp = os.time()
    callData.created_by = GetPlayerName(src)
    
    activeDispatchCalls[callData.id] = callData
    
    -- Send to all police officers
    for _, player in ipairs(GetPlayers()) do
        local playerId = tonumber(player)
        if IsPlayerPolice(playerId) then
            TriggerClientEvent('mdt:receiveDispatchCall', playerId, callData)
        end
    end
    
    print('[MDT] Dispatch call created: ' .. callData.code .. ' - ' .. callData.location)
end)

-- Event for removing dispatch call
RegisterServerEvent('mdt:removeDispatchCall')
AddEventHandler('mdt:removeDispatchCall', function(callId)
    if activeDispatchCalls[callId] then
        activeDispatchCalls[callId] = nil
        
        -- Notify all players to remove the call
        TriggerClientEvent('mdt:removeDispatchCall', -1, callId)
        
        print('[MDT] Dispatch call removed: ' .. callId)
    end
end)

-- Event for getting bodycam feeds
RegisterServerEvent('mdt:getBodycamFeeds')
AddEventHandler('mdt:getBodycamFeeds', function()
    local src = source
    local feeds = GetBodycamFeeds()
    TriggerClientEvent('mdt:receiveBodycamFeeds', src, feeds)
end)

function GetBodycamFeeds()
    -- Return bodycam feeds (integrate with your bodycam system)
    local feeds = {}
    
    for _, player in ipairs(GetPlayers()) do
        local playerId = tonumber(player)
        if IsPlayerPolice(playerId) then
            table.insert(feeds, {
                id = playerId,
                officer = GetPlayerName(playerId) .. ' - ' .. GetPlayerBadge(playerId),
                status = 'LIVE',
                location = GetPlayerLocation(playerId)
            })
        end
    end
    
    return feeds
end

-- Async version of GetStaffLogs
function GetStaffLogsAsync(callback)
    local logs = {}
    local query = 'SELECT * FROM mdt_staff_logs ORDER BY id DESC'
    
    ExecuteSQL(query, {}, function(result)
        if result and #result > 0 then
            for i, row in ipairs(result) do
                table.insert(logs, {
                    officer = row.officer,
                    badge = row.badge,
                    start = row.start_time,
                    ['end'] = row.end_time or 'Ongoing',
                    duration = row.duration or 'N/A'
                })
            end
        end
        if callback then callback(logs) end
    end)
end

-- Helper functions
function GetPlayerData(playerId)
    -- Integrate with your framework (QBCore/ESX)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player then
            return {
                rank = Player.PlayerData.job.grade.name or "Officer",
                badge = Player.PlayerData.metadata.badge or "1A-" .. playerId,
                department = Player.PlayerData.job.name or "LSPD"
            }
        end
    end
    
    return {
        rank = "Directive - D-1",
        badge = "D-1",
        department = "LSPD"
    }
end

function IsPlayerPolice(playerId)
    -- Check if player is police (integrate with your framework)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player then
            return Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'lspd'
        end
    end
    
    -- Default: allow all players (for testing)
    return true
end

function GetPlayerBadge(playerId)
    if QBCore then
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player and Player.PlayerData.metadata.badge then
            return Player.PlayerData.metadata.badge
        end
    end
    return "1A-" .. playerId
end

function GetPlayerStatus(playerId)
    -- Get player status from your system
    return "available"
end

function GetPlayerLocation(playerId)
    -- Location is now handled via client-side events
    -- This function is kept for backwards compatibility but shouldn't be used
    return "Unknown Location"
end

function GetPlayerCall(playerId)
    -- Get player's current call from your dispatch system
    return "Patrol"
end

function SearchProfiles(query)
    local results = {}
    local searchQuery = '%' .. query .. '%'
    
    -- Search in players table (QBCore/ESX)
    if QBCore then
        -- QBCore uses players table
        local query = 'SELECT * FROM players WHERE charinfo LIKE ? OR citizenid LIKE ? LIMIT 20'
        local params = { searchQuery, searchQuery }
        
        ExecuteSQL(query, params, function(result)
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    local charinfo = json.decode(row.charinfo or '{}')
                    local metadata = json.decode(row.metadata or '{}')
                    
                    table.insert(results, {
                        id = row.citizenid,
                        name = charinfo.firstname .. ' ' .. charinfo.lastname,
                        dob = charinfo.birthdate or 'N/A',
                        address = charinfo.address or 'N/A',
                        phone = charinfo.phone or 'N/A',
                        convictions = metadata.convictions or metadata.warrants or 'None',
                        license = metadata.licenses and metadata.licenses.driver or 'Valid'
                    })
                end
            end
        end)
    else
        -- ESX uses users table
        local query = 'SELECT * FROM users WHERE firstname LIKE ? OR lastname LIKE ? OR identifier LIKE ? LIMIT 20'
        local params = { searchQuery, searchQuery, searchQuery }
        
        ExecuteSQL(query, params, function(result)
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    table.insert(results, {
                        id = row.identifier,
                        name = row.firstname .. ' ' .. row.lastname,
                        dob = row.dateofbirth or 'N/A',
                        address = row.address or 'N/A',
                        phone = row.phone_number or 'N/A',
                        convictions = 'None',
                        license = 'Valid'
                    })
                end
            end
        end)
    end
    
    -- Wait a bit for async query to complete (in production, use proper async handling)
    Citizen.Wait(100)
    return results
end

function SearchVehicle(plate)
    local vehicle = {}
    local cleanPlate = string.upper(string.gsub(plate, "%s+", ""))
    
    -- Search in owned_vehicles table
    local query = 'SELECT * FROM owned_vehicles WHERE plate = ? LIMIT 1'
    local params = { cleanPlate }
    
    ExecuteSQL(query, params, function(result)
        if result and #result > 0 then
            local row = result[1]
            local vehicleData = json.decode(row.vehicle or '{}')
            local mods = json.decode(row.mods or '{}')
            
            -- Get owner info
            local ownerQuery = 'SELECT * FROM players WHERE citizenid = ? LIMIT 1'
            local ownerParams = { row.citizenid }
            
            ExecuteSQL(ownerQuery, ownerParams, function(ownerResult)
                local ownerName = 'Unknown'
                if ownerResult and #ownerResult > 0 then
                    local charinfo = json.decode(ownerResult[1].charinfo or '{}')
                    ownerName = charinfo.firstname .. ' ' .. charinfo.lastname
                end
                
                vehicle = {
                    plate = cleanPlate,
                    make = vehicleData.make or 'Unknown',
                    model = vehicleData.model or 'Unknown',
                    color = mods.color1 and ('Color ' .. mods.color1) or 'Unknown',
                    owner = ownerName,
                    registration = row.registration or 'Valid',
                    status = row.stolen and 'STOLEN - APPROACH WITH CAUTION' or 'Valid'
                }
            end)
        else
            vehicle = {}
        end
    end)
    
    -- Wait a bit for async query to complete
    Citizen.Wait(150)
    return vehicle
end

function SearchWeapons(query)
    local weapons = {}
    local searchQuery = '%' .. query .. '%'
    
    -- Search in player_weapons or items table (depending on framework)
    if QBCore then
        -- QBCore uses items table
        local query = 'SELECT * FROM player_weapons WHERE serialnumber LIKE ? OR owner LIKE ? LIMIT 20'
        local params = { searchQuery, searchQuery }
        
        ExecuteSQL(query, params, function(result)
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    table.insert(weapons, {
                        serial = row.serialnumber,
                        type = row.weapon,
                        owner = row.owner,
                        status = row.registered and 'Valid' or 'Unregistered',
                        lastChecked = row.last_checked or 'N/A'
                    })
                end
            end
        end)
    else
        -- ESX uses items table
        local query = 'SELECT * FROM items WHERE name LIKE ? AND type = "weapon" LIMIT 20'
        local params = { searchQuery }
        
        ExecuteSQL(query, params, function(result)
            if result and #result > 0 then
                for i, row in ipairs(result) do
                    table.insert(weapons, {
                        serial = row.name,
                        type = row.label,
                        owner = 'Unknown',
                        status = 'Valid',
                        lastChecked = 'N/A'
                    })
                end
            end
        end)
    end
    
    Citizen.Wait(100)
    return weapons
end

function GetCameras()
    -- Return camera locations/feeds
    return {}
end

function GetStaffLogs()
    local logs = {}
    
    -- Get staff logs from database
    local query = 'SELECT * FROM mdt_staff_logs ORDER BY id DESC'
    
    ExecuteSQL(query, {}, function(result)
        if result and #result > 0 then
            for i, row in ipairs(result) do
                table.insert(logs, {
                    officer = row.officer,
                    badge = row.badge,
                    start = row.start_time,
                    ['end'] = row.end_time or 'Ongoing',
                    duration = row.duration or 'N/A'
                })
            end
        end
    end)
    
    Citizen.Wait(100)
    return logs
end
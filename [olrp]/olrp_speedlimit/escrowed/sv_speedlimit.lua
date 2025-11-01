-- ==============================================
-- OLRP SPEED LIMIT - SERVER SIDE
-- ==============================================
-- Server-side admin commands and logging
-- ==============================================

local speedLimitEnabled = true
local violationLogs = {}
local adminPlayers = {}

-- ==============================================
-- UTILITY FUNCTIONS
-- ==============================================

local function IsPlayerAdmin(source)
    if not Config.EnableAdminCommands then return false end
    
    -- Check if player is in admin groups
    for _, group in ipairs(Config.AdminGroups) do
        if IsPlayerAceAllowed(source, "olrp.speedlimit.admin") or 
           IsPlayerAceAllowed(source, "group." .. group) then
            return true
        end
    end
    
    return false
end

local function GetPlayerName(source)
    return GetPlayerName(source) or "Unknown"
end

local function LogViolation(playerId, playerName, speed, limit)
    if not Config.EnableLogging then return end
    
    local logEntry = {
        timestamp = os.date("%Y-%m-%d %H:%M:%S"),
        playerId = playerId,
        playerName = playerName,
        speed = math.floor(speed),
        limit = math.floor(limit),
        violation = speed - limit
    }
    
    table.insert(violationLogs, logEntry)
    
    -- Keep only last 1000 entries to prevent memory issues
    if #violationLogs > 1000 then
        table.remove(violationLogs, 1)
    end
    
end

local function SaveLogToFile()
    if not Config.EnableLogging or #violationLogs == 0 then return end
    
    local logContent = "OLRP Speed Limit Violations Log\n"
    logContent = logContent .. "================================\n\n"
    
    for _, entry in ipairs(violationLogs) do
        logContent = logContent .. string.format("[%s] %s (%d) - Speed: %d km/h (Limit: %d km/h) - Violation: +%d km/h\n",
            entry.timestamp, entry.playerName, entry.playerId, entry.speed, entry.limit, entry.violation)
    end
    
    -- Save to file (this would need to be implemented based on your server's file system)
    -- For now, just print to console
    print(logContent)
end

-- ==============================================
-- EVENT HANDLERS
-- ==============================================

RegisterNetEvent('olrp_speedlimit:logViolation')
AddEventHandler('olrp_speedlimit:logViolation', function(speed, limit)
    local source = source
    
    -- Safety check to prevent hangs
    if not SafeAdminCheck(source) then return end
    
    local playerName = GetPlayerName(source)
    
    -- Validate input parameters
    if not speed or not limit or speed < 0 or limit < 0 then return end
    
    LogViolation(source, playerName, speed, limit)
end)

RegisterNetEvent('olrp_speedlimit:requestConfig')
AddEventHandler('olrp_speedlimit:requestConfig', function()
    local source = source
    
    -- Safety check to prevent hangs
    if not SafeAdminCheck(source) then return end
    
    TriggerClientEvent('olrp_speedlimit:updateConfig', source, Config)
end)

-- ==============================================
-- COMMANDS
-- ==============================================

if Config.EnableAdminCommands then
    -- Toggle speed limit for all players
    RegisterCommand('speedlimit', function(source, args)
        -- Safety check to prevent hangs
        if not SafeAdminCheck(source) then return end
        
        if not IsPlayerAdmin(source) then
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "You don't have permission to use this command."}
            })
            return
        end
        
        if #args == 0 then
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 165, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "Usage: /speedlimit [on/off/toggle/status/logs]"}
            })
            return
        end
        
        local action = args[1]:lower()
        local playerName = GetPlayerName(source)
        
        if action == "on" then
            speedLimitEnabled = true
            TriggerClientEvent('olrp_speedlimit:toggleSpeedLimit', -1, true)
            TriggerClientEvent('chat:addMessage', -1, {
                color = {0, 255, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", string.format("Speed limit enabled by %s", playerName)}
            })
            
        elseif action == "off" then
            speedLimitEnabled = false
            TriggerClientEvent('olrp_speedlimit:toggleSpeedLimit', -1, false)
            TriggerClientEvent('chat:addMessage', -1, {
                color = {255, 0, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", string.format("Speed limit disabled by %s", playerName)}
            })
            
        elseif action == "toggle" then
            speedLimitEnabled = not speedLimitEnabled
            TriggerClientEvent('olrp_speedlimit:toggleSpeedLimit', -1, speedLimitEnabled)
            local status = speedLimitEnabled and "enabled" or "disabled"
            TriggerClientEvent('chat:addMessage', -1, {
                color = speedLimitEnabled and {0, 255, 0} or {255, 0, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", string.format("Speed limit %s by %s", status, playerName)}
            })
            
        elseif action == "status" then
            local status = speedLimitEnabled and "enabled" or "disabled"
            local violationCount = #violationLogs
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 165, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", string.format("Status: %s | Violations logged: %d | Max speed: %d km/h", 
                    status, violationCount, Config.MaxSpeed)}
            })
            
        elseif action == "logs" then
            if #violationLogs == 0 then
                TriggerClientEvent('chat:addMessage', source, {
                    color = {255, 165, 0},
                    multiline = true,
                    args = {"[OLRP Speed Limit]", "No violations logged."}
                })
            else
                local recentLogs = {}
                local count = math.min(10, #violationLogs) -- Show last 10 violations
                
                for i = #violationLogs - count + 1, #violationLogs do
                    local entry = violationLogs[i]
                    table.insert(recentLogs, string.format("[%s] %s - Speed: %d km/h (Limit: %d km/h)",
                        entry.timestamp, entry.playerName, entry.speed, entry.limit))
                end
                
                TriggerClientEvent('chat:addMessage', source, {
                    color = {255, 165, 0},
                    multiline = true,
                    args = {"[OLRP Speed Limit]", "Recent violations:\n" .. table.concat(recentLogs, "\n")}
                })
            end
            
        elseif action == "save" then
            SaveLogToFile()
            TriggerClientEvent('chat:addMessage', source, {
                color = {0, 255, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "Violation logs saved to console."}
            })
            
        else
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "Invalid action. Use: on, off, toggle, status, logs, or save"}
            })
        end
    end, true)
    
    -- Set speed limit for specific player
    RegisterCommand('speedlimitplayer', function(source, args)
        -- Safety check to prevent hangs
        if not SafeAdminCheck(source) then return end
        
        if not IsPlayerAdmin(source) then
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "You don't have permission to use this command."}
            })
            return
        end
        
        if #args < 2 then
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 165, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "Usage: /speedlimitplayer [playerid] [on/off]"}
            })
            return
        end
        
        local targetId = tonumber(args[1])
        local action = args[2]:lower()
        
        if not targetId or not GetPlayerName(targetId) then
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "Invalid player ID."}
            })
            return
        end
        
        local playerName = GetPlayerName(source)
        local targetName = GetPlayerName(targetId)
        
        if action == "on" then
            TriggerClientEvent('olrp_speedlimit:toggleSpeedLimit', targetId, true)
            TriggerClientEvent('chat:addMessage', source, {
                color = {0, 255, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", string.format("Speed limit enabled for %s", targetName)}
            })
            TriggerClientEvent('chat:addMessage', targetId, {
                color = {0, 255, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "Speed limit enabled for you by an admin"}
            })
            
        elseif action == "off" then
            TriggerClientEvent('olrp_speedlimit:toggleSpeedLimit', targetId, false)
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", string.format("Speed limit disabled for %s", targetName)}
            })
            TriggerClientEvent('chat:addMessage', targetId, {
                color = {255, 0, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "Speed limit disabled for you by an admin"}
            })
            
        else
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {"[OLRP Speed Limit]", "Invalid action. Use: on or off"}
            })
        end
    end, true)
end

-- ==============================================
-- PLAYER EVENTS
-- ==============================================

-- Removed empty event handlers that were causing server hangs
-- These events are not needed for the speed limit functionality

-- Add safety timeout for admin commands to prevent hangs
local function SafeAdminCheck(source)
    if not source or source == 0 then return false end
    if not GetPlayerName(source) then return false end
    return true
end

-- ==============================================
-- INITIALIZATION
-- ==============================================

CreateThread(function()
    
    -- Send initial config to all clients
    TriggerClientEvent('olrp_speedlimit:updateConfig', -1, Config)
    TriggerClientEvent('olrp_speedlimit:toggleSpeedLimit', -1, speedLimitEnabled)
end)

-- ==============================================
-- EXPORTED FUNCTIONS
-- ==============================================

-- Export function to get current speed limit status
exports('getSpeedLimitStatus', function()
    return {
        enabled = speedLimitEnabled,
        maxSpeed = Config.MaxSpeed,
        violationCount = #violationLogs
    }
end)

-- Export function to toggle speed limit
exports('toggleSpeedLimit', function(enabled)
    speedLimitEnabled = enabled
    TriggerClientEvent('olrp_speedlimit:toggleSpeedLimit', -1, speedLimitEnabled)
    return speedLimitEnabled
end)

-- Export function to get violation logs
exports('getViolationLogs', function()
    return violationLogs
end)

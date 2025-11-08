-- Dusa Garage Management System - Advanced Debug Module
-- Version: 2.0.0
-- Topic-based, performance-optimized debug system

local DebugManager = {}
local resourceName = GetCurrentResourceName()

-- Cross-platform time function for debug timestamps
local function GetDebugTimestamp()
    -- Check if we're on server side (os.date available)
    if os and os.date then
        return os.date("%H:%M:%S")
    end
    
    -- Client side: use GetGameTimer() to calculate time
    local gameTimer = GetGameTimer()
    local hours = math.floor(gameTimer / 3600000) % 24
    local minutes = math.floor((gameTimer % 3600000) / 60000) % 60
    local seconds = math.floor((gameTimer % 60000) / 1000) % 60
    
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

-- Debug levels with colors and priorities
local DEBUG_LEVELS = {
    ERROR = { color = "^1", priority = 1, prefix = "[ERROR]" },
    WARN  = { color = "^3", priority = 2, prefix = "[WARN]" },
    INFO  = { color = "^2", priority = 3, prefix = "[INFO]" },
    DEBUG = { color = "^7", priority = 4, prefix = "[DEBUG]" }
}

-- Topic categories for organized debugging
local DEBUG_TOPICS = {
    ["garage-creation"] = { enabled = false, color = "^5", description = "New garage creation and management" },
    ["user-management"] = { enabled = false, color = "^6", description = "User access control and permissions" },
    ["vehicle-operations"] = { enabled = true, color = "^4", description = "Vehicle parking, spawning, and storage" },
    ["bridge-integration"] = { enabled = false, color = "^3", description = "Framework and bridge interactions" },
    ["database"] = { enabled = false, color = "^2", description = "Database queries and operations" },
    ["ui-interactions"] = { enabled = false, color = "^1", description = "NUI callbacks and UI events" },
    ["zone-management"] = { enabled = false, color = "^7", description = "Garage zones and interaction areas" },
    ["api"] = { enabled = true, color = "^8", description = "Server API endpoints and callbacks" },
    ["validation"] = { enabled = false, color = "^9", description = "Input validation and security checks" },
    ["system"] = { enabled = false, color = "^0", description = "System startup, initialization, and core operations" },
    ["job-vehicles"] = { enabled = false, color = "^0", description = "Job vehicles and their management" },
    ["garage-deletion"] = { enabled = false, color = "^1", description = "Garage deletion and management" },
    ["garage-edit"] = { enabled = false, color = "^3", description = "Garage edit and management" },
    ["mileage-tracking"] = { enabled = false, color = "^3", description = "Mileage tracking" },
    ["vehicle-transfer"] = { enabled = false, color = "^5", description = "Vehicle transfer debugging" },
    ["repair-system"] = { enabled = false, color = "^5", description = "Repair debugging" },
    ["garage-debug"] = { enabled = false, color = "^5", description = "Garage debug" },
    ["vehicle-colors"] = { enabled = false, color = "^5", description = "Vehicle colors" },
    ["impound"] = { enabled = false, color = "^8", description = "Impound" },
    ["impound-commands"] = { enabled = true, color = "^5", description = "Impound commands debugging" },
    ["admin-editor"] = { enabled = false, color = "^8", description = "Admin editor" },
    ["presets"] = { enabled = false, color = "^6", description = "Presets debugging" },
    ["vehicle-hover"] = { enabled = true, color = "^5", description = "Vehicle hover debugging" },
    ["showroom-test"] = { enabled = true, color = "^5", description = "Showroom test debugging" },
    ["showroom-nui"] = { enabled = true, color = "^5", description = "Showroom NUI debugging" },
    ["showroom-retrieval"] = { enabled = true, color = "^5", description = "Showroom retrieval debugging" },
    ["showroom"] = { enabled = true, color = "^5", description = "Showroom debugging" },
}

-- Performance optimization: pre-check if any debug is enabled
local debugEnabled = false
local function updateDebugEnabled()
    debugEnabled = false
    local debugConfig = Config and Config.Debug
    if not debugConfig then return end


    -- Handle both old (boolean) and new (table) config formats
    local debugMasterEnabled = type(debugConfig) == "boolean" and debugConfig or debugConfig.Enabled
    if not debugMasterEnabled then return end


    -- Sync DEBUG_TOPICS with Config.Debug.DefaultTopics if available
    if type(debugConfig) == "table" and debugConfig.DefaultTopics then
        for topic, configEnabled in pairs(debugConfig.DefaultTopics) do
            if DEBUG_TOPICS[topic] then
                DEBUG_TOPICS[topic].enabled = configEnabled
            end
        end
    end

    -- Check if any topic is enabled
    for topic, settings in pairs(DEBUG_TOPICS) do
        if settings.enabled then
            debugEnabled = true
            break
        end
    end

end

-- Initialize debug system
function DebugManager.Initialize()
    updateDebugEnabled()

    if debugEnabled then
        print(("^2[%s] Debug system initialized with topic-based filtering^0"):format(resourceName))
        DebugManager.Log("system", "DEBUG", "Debug manager initialized successfully")
    end
end

-- Core logging function
function DebugManager.Log(topic, level, message, ...)
    -- Early exit if debug is globally disabled or config is missing
    local debugConfig = Config and Config.Debug
    debugEnabled = true
    if not debugEnabled or not debugConfig then return end

    -- Early exit if master debug is not enabled
    local debugMasterEnabled = type(debugConfig) == "boolean" and debugConfig or debugConfig.Enabled
    if not debugMasterEnabled then return end


    -- Validate required parameters
    if not topic or not level or not message then return end

    -- Early exit if topic is not enabled or doesn't exist
    local topicSettings = DEBUG_TOPICS[topic]
    if not topicSettings or not topicSettings.enabled then return end

    -- Early exit if log level is not defined
    local levelSettings = DEBUG_LEVELS[level]
    if not levelSettings then return end


    -- Early exit if log level is lower than minimum configured
    if type(debugConfig) == "table" and debugConfig.MinLevel then
        local minLevel = DEBUG_LEVELS[debugConfig.MinLevel]
        if minLevel and levelSettings.priority > minLevel.priority then return end
    end


    -- Format message with arguments if provided
    local formattedMessage = message
    if ... then
        formattedMessage = string.format(message, ...)
    end


    -- Build colored output
    local timestamp = GetDebugTimestamp()
    local output = string.format(
        "%s[%s]%s %s%s%s [%s%s%s] %s",
        levelSettings.color,      -- Level color
        timestamp,
        "^0",                     -- Reset color
        topicSettings.color,      -- Topic color
        string.upper(topic),
        "^0",                     -- Reset color
        levelSettings.color,      -- Level color again
        levelSettings.prefix,
        "^0",                     -- Reset color
        formattedMessage
    )

    print(output)
end

-- Convenience functions for different log levels
function DebugManager.Error(topic, message, ...)
    DebugManager.Log(topic, "ERROR", message, ...)
end

function DebugManager.Warn(topic, message, ...)
    DebugManager.Log(topic, "WARN", message, ...)
end

function DebugManager.Info(topic, message, ...)
    DebugManager.Log(topic, "INFO", message, ...)
end

function DebugManager.Debug(topic, message, ...)
    DebugManager.Log(topic, "DEBUG", message, ...)
end

-- Topic management functions
function DebugManager.EnableTopic(topic)
    if DEBUG_TOPICS[topic] then
        DEBUG_TOPICS[topic].enabled = true
        updateDebugEnabled()
        print(("^2[%s] Debug topic '%s' enabled^0"):format(resourceName, topic))
        return true
    end
    print(("^1[%s] Unknown debug topic: %s^0"):format(resourceName, topic))
    return false
end

function DebugManager.DisableTopic(topic)
    if DEBUG_TOPICS[topic] then
        DEBUG_TOPICS[topic].enabled = false
        updateDebugEnabled()
        print(("^3[%s] Debug topic '%s' disabled^0"):format(resourceName, topic))
        return true
    end
    print(("^1[%s] Unknown debug topic: %s^0"):format(resourceName, topic))
    return false
end

function DebugManager.ToggleTopic(topic)
    if DEBUG_TOPICS[topic] then
        local newState = not DEBUG_TOPICS[topic].enabled
        DEBUG_TOPICS[topic].enabled = newState
        updateDebugEnabled()
        local status = newState and "enabled" or "disabled"
        local color = newState and "^2" or "^3"
        print(("%s[%s] Debug topic '%s' %s^0"):format(color, resourceName, topic, status))
        return true
    end
    print(("^1[%s] Unknown debug topic: %s^0"):format(resourceName, topic))
    return false
end

function DebugManager.ListTopics()
    print(("^6[%s] Available Debug Topics:^0"):format(resourceName))
    for topic, settings in pairs(DEBUG_TOPICS) do
        local status = settings.enabled and "^2ENABLED^0" or "^1DISABLED^0"
        print(("  %s%s^0: %s (%s)"):format(settings.color, topic, settings.description, status))
    end
end

function DebugManager.GetEnabledTopics()
    local enabled = {}
    for topic, settings in pairs(DEBUG_TOPICS) do
        if settings.enabled then
            table.insert(enabled, topic)
        end
    end
    return enabled
end

function DebugManager.EnableOnlyTopic(topic)
    -- Disable all topics first
    for t, _ in pairs(DEBUG_TOPICS) do
        DEBUG_TOPICS[t].enabled = false
    end

    -- Enable only the specified topic
    if DEBUG_TOPICS[topic] then
        DEBUG_TOPICS[topic].enabled = true
        updateDebugEnabled()
        print(("^2[%s] Only debug topic '%s' is now enabled^0"):format(resourceName, topic))
        return true
    else
        print(("^1[%s] Unknown debug topic: %s^0"):format(resourceName, topic))
        return false
    end
end

function DebugManager.EnableAllTopics()
    for topic, _ in pairs(DEBUG_TOPICS) do
        DEBUG_TOPICS[topic].enabled = true
    end
    updateDebugEnabled()
    print(("^2[%s] All debug topics enabled^0"):format(resourceName))
end

function DebugManager.DisableAllTopics()
    for topic, _ in pairs(DEBUG_TOPICS) do
        DEBUG_TOPICS[topic].enabled = false
    end
    updateDebugEnabled()
    print(("^3[%s] All debug topics disabled^0"):format(resourceName))
end

-- Performance check function
function DebugManager.IsTopicEnabled(topic)
    return debugEnabled and DEBUG_TOPICS[topic] and DEBUG_TOPICS[topic].enabled
end

-- Backward compatibility function for existing Debug() calls
function DebugManager.Legacy(message, topic)
    -- If no topic specified, use 'system' as default
    topic = topic or "system"
    DebugManager.Debug(topic, message)
end

-- Configuration update handler
function DebugManager.UpdateConfig()
    updateDebugEnabled()
end

-- Global convenience function for LogDebug
function LogDebug(message, topic, prefix)
    if not DebugManager then return end
    topic = topic or "system"
    prefix = prefix or ""
    if prefix ~= "" then
        DebugManager.Debug(topic, prefix .. " %s", message)
    else
        DebugManager.Debug(topic, message)
    end
end

-- Global convenience function for LogError
function LogError(message, topic, prefix)
    if not DebugManager then return end
    topic = topic or "system"
    prefix = prefix or ""
    if prefix ~= "" then
        DebugManager.Error(topic, prefix .. " %s", message)
    else
        DebugManager.Error(topic, message)
    end
end

-- Make DebugManager, LogDebug, and LogError globally available
_G.DebugManager = DebugManager
_G.LogDebug = LogDebug
_G.LogError = LogError

-- Komut: Ekran kararmasını düzelt (ClearScreenFade)
RegisterCommand("ekrankararmafix", function(source, args, raw)
    DoScreenFadeIn(500)
end, false)

-- Export the debug manager (backward compatibility for requires)
return DebugManager

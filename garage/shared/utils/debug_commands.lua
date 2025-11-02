-- Dusa Garage Management System - Debug Management Commands
-- Version: 2.0.0
-- Developer commands for runtime debug topic management

-- Command: List all available debug topics and their status
RegisterCommand('debug-topics', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    DebugManager.ListTopics()
end, false)

-- Command: Enable a specific debug topic
RegisterCommand('debug-enable', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    local topic = args[1]
    if not topic then
        print("^3[DEBUG] Usage: /debug-enable <topic>^0")
        print("^7[DEBUG] Use /debug-topics to see available topics^0")
        return
    end

    DebugManager.EnableTopic(topic)
end, false)

-- Command: Disable a specific debug topic
RegisterCommand('debug-disable', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    local topic = args[1]
    if not topic then
        print("^3[DEBUG] Usage: /debug-disable <topic>^0")
        print("^7[DEBUG] Use /debug-topics to see available topics^0")
        return
    end

    DebugManager.DisableTopic(topic)
end, false)

-- Command: Toggle a debug topic on/off
RegisterCommand('debug-toggle', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    local topic = args[1]
    if not topic then
        print("^3[DEBUG] Usage: /debug-toggle <topic>^0")
        print("^7[DEBUG] Use /debug-topics to see available topics^0")
        return
    end

    DebugManager.ToggleTopic(topic)
end, false)

-- Command: Enable only one specific topic (disable all others)
RegisterCommand('debug-only', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    local topic = args[1]
    if not topic then
        print("^3[DEBUG] Usage: /debug-only <topic>^0")
        print("^7[DEBUG] This will disable ALL other topics and enable only the specified one^0")
        print("^7[DEBUG] Use /debug-topics to see available topics^0")
        return
    end

    DebugManager.EnableOnlyTopic(topic)
end, false)

-- Command: Enable all debug topics
RegisterCommand('debug-all', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    DebugManager.EnableAllTopics()
end, false)

-- Command: Disable all debug topics
RegisterCommand('debug-none', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    DebugManager.DisableAllTopics()
end, false)

-- Command: Show enabled topics
RegisterCommand('debug-status', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    local enabled = DebugManager.GetEnabledTopics()
    if #enabled == 0 then
        print("^3[DEBUG] No debug topics are currently enabled^0")
    else
        print("^2[DEBUG] Currently enabled topics:^0")
        for _, topic in ipairs(enabled) do
            print("  ^6" .. topic .. "^0")
        end
    end
end, false)

-- Command: Quick preset for garage creation development
RegisterCommand('debug-garage-dev', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    -- Disable all topics first
    DebugManager.DisableAllTopics()

    -- Enable only garage creation related topics
    DebugManager.EnableTopic("garage-creation")
    DebugManager.EnableTopic("ui-interactions")
    DebugManager.EnableTopic("api")
    DebugManager.EnableTopic("system")

    print("^2[DEBUG] Garage development preset enabled^0")
    print("^7[DEBUG] Active topics: garage-creation, ui-interactions, api, system^0")
end, false)

-- Command: Quick preset for user management development
RegisterCommand('debug-user-dev', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    -- Disable all topics first
    DebugManager.DisableAllTopics()

    -- Enable only user management related topics
    DebugManager.EnableTopic("user-management")
    DebugManager.EnableTopic("database")
    DebugManager.EnableTopic("validation")
    DebugManager.EnableTopic("system")

    print("^2[DEBUG] User management development preset enabled^0")
    print("^7[DEBUG] Active topics: user-management, database, validation, system^0")
end, false)

-- Command: Quick preset for vehicle operations development
RegisterCommand('debug-vehicle-dev', function(source, args, rawCommand)
    if not DebugManager then
        print("^1[DEBUG] Debug manager not loaded^0")
        return
    end

    -- Disable all topics first
    DebugManager.DisableAllTopics()

    -- Enable only vehicle operation related topics
    DebugManager.EnableTopic("vehicle-operations")
    DebugManager.EnableTopic("zone-management")
    DebugManager.EnableTopic("bridge-integration")
    DebugManager.EnableTopic("system")

    print("^2[DEBUG] Vehicle operations development preset enabled^0")
    print("^7[DEBUG] Active topics: vehicle-operations, zone-management, bridge-integration, system^0")
end, false)

-- Register command suggestions
TriggerEvent('chat:addSuggestion', '/debug-topics', 'List all available debug topics')
TriggerEvent('chat:addSuggestion', '/debug-enable', 'Enable a specific debug topic', {
    { name = "topic", help = "Debug topic name" }
})
TriggerEvent('chat:addSuggestion', '/debug-disable', 'Disable a specific debug topic', {
    { name = "topic", help = "Debug topic name" }
})
TriggerEvent('chat:addSuggestion', '/debug-toggle', 'Toggle a debug topic on/off', {
    { name = "topic", help = "Debug topic name" }
})
TriggerEvent('chat:addSuggestion', '/debug-only', 'Enable only one topic (disable all others)', {
    { name = "topic", help = "Debug topic name" }
})
TriggerEvent('chat:addSuggestion', '/debug-all', 'Enable all debug topics')
TriggerEvent('chat:addSuggestion', '/debug-none', 'Disable all debug topics')
TriggerEvent('chat:addSuggestion', '/debug-status', 'Show currently enabled debug topics')
TriggerEvent('chat:addSuggestion', '/debug-garage-dev', 'Quick preset for garage creation development')
TriggerEvent('chat:addSuggestion', '/debug-user-dev', 'Quick preset for user management development')
TriggerEvent('chat:addSuggestion', '/debug-vehicle-dev', 'Quick preset for vehicle operations development')

-- Initialize debug system when commands are loaded
CreateThread(function()
    Wait(1000) -- Give time for config to load
    if DebugManager and Config and Config.Debug then
        DebugManager.Initialize()

        -- Apply default topics from config
        if type(Config.Debug) == "table" and Config.Debug.DefaultTopics then
            for topic, enabled in pairs(Config.Debug.DefaultTopics) do
                if enabled then
                    DebugManager.EnableTopic(topic)
                else
                    DebugManager.DisableTopic(topic)
                end
            end
        end
    end
end)
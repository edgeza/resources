-- Dusa Garage Management System - Interactive Help Menu
-- Version: 1.0.0
-- Provides a unified help system for all garage commands

HelpMenu = {}

-- Command categories with their commands
HelpMenu.Commands = {
    {
        category = "🚗 Garage Usage",
        description = "Basic garage operations",
        commands = {
            {
                name = "/propertygarage",
                description = "Open property garage management menu, if your job is real estate it will show you creation button",
                usage = "/propertygarage",
                example = "/propertygarage"
            }
        }
    },
    {
        category = "⚙️ Admin Tools",
        description = "Administrator commands",
        commands = {
            {
                name = "/garage-create",
                description = "Create new garage",
                usage = "/garage-create",
                example = "/garage-create",
                adminOnly = true
            },
            {
                name = "/garage-createjob",
                description = "Edit job garage settings",
                usage = "/garage-createjob",
                example = "/garage-createjob",
                adminOnly = true
            },
            {
                name = "/garage-manage",
                description = "Manage all garages (view, edit, delete)",
                usage = "/garage-manage",
                example = "/garage-manage",
                adminOnly = true
            }
        }
    },
    -- {
    --     category = "🐛 Test & Debug",
    --     description = "Test and debugging commands",
    --     commands = {
    --         {
    --             name = "/garage-test",
    --             description = "Open test menu",
    --             usage = "/garage-test",
    --             example = "/garage-test"
    --         },
    --         {
    --             name = "/debug-status",
    --             description = "Show debug status",
    --             usage = "/debug-status",
    --             example = "/debug-status"
    --         },
    --         {
    --             name = "/debug-topics",
    --             description = "List all debug topics",
    --             usage = "/debug-topics",
    --             example = "/debug-topics"
    --         },
    --         {
    --             name = "/debug-enable",
    --             description = "Enable a specific debug topic",
    --             usage = "/debug-enable <topic>",
    --             example = "/debug-enable garage-creation"
    --         },
    --         {
    --             name = "/debug-disable",
    --             description = "Disable a specific debug topic",
    --             usage = "/debug-disable <topic>",
    --             example = "/debug-disable garage-creation"
    --         }
    --     }
    -- },
    {
        category = "ℹ️ Info & Help",
        description = "Help and information commands",
        commands = {
            -- {
            --     name = "/garage-help",
            --     description = "Show this help menu",
            --     usage = "/garage-help",
            --     example = "/garage-help"
            -- },
            {
                name = "/garage-info",
                description = "Information about garage system",
                usage = "/garage-info",
                example = "/garage-info"
            }
        }
    }
}

-- Open help menu
function HelpMenu.Open()
    local nuiData = {
        action = 'openHelpMenu',
        data = {
            commands = HelpMenu.Commands,
            version = "1.0.0",
            resourceName = GetCurrentResourceName()
        }
    }

    SendNUIMessage(nuiData)
    SetNuiFocus(true, true)
end

-- Close help menu
function HelpMenu.Close()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'closeHelpMenu',
        data = {}
    })
end

-- Print help to console
function HelpMenu.PrintToConsole()
    print("^3╔════════════════════════════════════════════════════════╗^0")
    print("^3║           DUSA GARAGE - COMMAND HELP MENU             ║^0")
    print("^3╚════════════════════════════════════════════════════════╝^0")
    print("")

    for _, category in ipairs(HelpMenu.Commands) do
        print(string.format("^2%s^0", category.category))
        print(string.format("^7%s^0", category.description))
        print("")

        for _, cmd in ipairs(category.commands) do
            local adminTag = cmd.adminOnly and " ^1[ADMIN]^0" or ""
            print(string.format("  ^6%s^0%s", cmd.name, adminTag))
            print(string.format("    ^7%s^0", cmd.description))
            print(string.format("    Usage: ^3%s^0", cmd.usage))
            if cmd.example then
                print(string.format("    Example: ^5%s^0", cmd.example))
            end
            print("")
        end
        print("^3────────────────────────────────────────────────────────^0")
        print("")
    end

    print("^2For detailed help: /garage-help^0")
    print("")
end

return HelpMenu

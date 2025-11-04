-- ================================================================
-- DUSA GARAGE MANAGEMENT SYSTEM - UNIFIED COMMAND SYSTEM
-- Version: 1.0.0
-- Purpose: Centralized command registration for easy management
-- ================================================================

local resourceName = GetCurrentResourceName()

-- ================================================================
-- MODULE LOADING
-- ================================================================

-- local HelpMenuModule = LoadResourceFile(resourceName, 'client/core/help_menu.lua')
-- local HelpMenu = nil
-- if HelpMenuModule then
--     HelpMenu = load(HelpMenuModule)()
-- end

-- ================================================================
-- SECTION 1: REMOVED - System commands moved to server-side
-- ================================================================
-- All system commands are now registered on the server-side for security

-- ================================================================
-- SECTION 2: REMOVED - User commands moved to server-side
-- ================================================================
-- All user commands are now registered on the server-side for consistency

-- ================================================================
-- SECTION 3: CLIENT EVENT HANDLERS (Server Commands Trigger These)
-- ================================================================

-- [CLIENT EVENT] Open Garage Admin Editor
RegisterNetEvent('garage:client:openAllGaragesView', function()
    local nuiData = {
        action = 'openAllGaragesView',
        data = {}
    }

    SendNUIMessage(nuiData)
    SetNuiFocus(true, true)
end)

-- [CLIENT EVENT] Open Property Garage Interface
RegisterNetEvent('garage:client:openPropertyGarage', function()
    local nuiData = {
        action = 'openGarage',
        data = {
            garageData = nil,
            vehicleData = {},
            garageConfig = { transferFee = 5000 }
        }
    }

    SendNUIMessage(nuiData)
    SetNuiFocus(true, true)

    CreateThread(function()
        Wait(100)
        SendNUIMessage({
            action = 'selectGaragesTab'
        })
    end)
end)

-- [CLIENT EVENT] Open Garage Manager Interface
RegisterNetEvent('garage:client:openGarageManager', function()
    local nuiData = {
        action = 'openGarage',
        data = {
            garageData = nil,
            vehicleData = {}
        }
    }

    SendNUIMessage(nuiData)
    SetNuiFocus(true, true)

    CreateThread(function()
        Wait(100)
        SendNUIMessage({
            action = 'selectGaragesTab'
        })
    end)
end)

-- [CLIENT EVENT] Open Test Menu
RegisterNetEvent('garage:client:openTestMenu', function()
    local nuiData = {
        action = 'openTestMenu',
        data = {
            testCategories = {
                {
                    name = "Garage Operations",
                    tests = {
                        { name = "Open Property Garages", command = "garage-property" },
                    }
                },
                {
                    name = "Admin Operations",
                    tests = {
                        { name = "Garage Editor", command = "garage-create" },
                        { name = "Job Settings", command = "garage-createjob" },
                    }
                },
                {
                    name = "Debug Operations",
                    tests = {
                        { name = "Debug Status", command = "debug-status" },
                        { name = "Debug Topics", command = "debug-topics" },
                        { name = "Enable All Debugs", command = "debug-all" },
                        { name = "Disable All Debugs", command = "debug-none" },
                    }
                }
            }
        }
    }

    SendNUIMessage(nuiData)
    SetNuiFocus(true, true)
end)

-- [CLIENT EVENT] Open Help Menu
RegisterNetEvent('garage:client:openHelpMenu', function()
    if HelpMenu then
        HelpMenu.Open()
    else
        print("^1[ERROR] Help system not loaded^0")
    end
end)

-- [CLIENT EVENT] Print Commands to Console
RegisterNetEvent('garage:client:printCommandsToConsole', function()
    if HelpMenu then
        HelpMenu.PrintToConsole()
    else
        print("^1[ERROR] Help system not loaded^0")
    end
end)

-- [CLIENT EVENT] Show System Info
RegisterNetEvent('garage:client:showSystemInfo', function()
    print("^3╔════════════════════════════════════════════════════════╗^0")
    print("^3║            DUSA GARAGE MANAGEMENT SYSTEM              ║^0")
    print("^3╚════════════════════════════════════════════════════════╝^0")
    print("")
    print("^2Version:^0 1.0.0")
    print("^2Resource:^0 " .. resourceName)
    print("^2Author:^0 Dusa Development")
    print("")
    print("^6Features:^0")
    print("  • Public & Private Garages")
    print("  • Property Garages")
    print("  • Job Vehicle Management")
    print("  • Vehicle Transfer System")
    print("  • Admin Garage Editor")
    print("  • Multi-Vehicle Type Support")
    print("")
    print("^2For command list: /garage-help^0")
    print("")
end)

-- REMOVED: Impound menu is now triggered directly from server command

-- ================================================================
-- SECTION 4: REMOVED - All commands moved to server-side
-- ================================================================
-- All admin and system commands are now registered on the server-side
-- for security. This file only contains client event handlers.

-- ================================================================
-- SECTION 6: REMOVED - Chat suggestions now handled by lib.addCommand
-- ================================================================
-- Chat suggestions are automatically generated by lib.addCommand on server-side

-- ================================================================
-- SECTION 7: NUI CALLBACK HANDLERS
-- ================================================================

-- Execute Command from NUI Interface
RegisterNUICallback('executeCommand', function(data, cb)
    if data.command then
        ExecuteCommand(data.command)
    end
    cb('ok')
end)

-- ================================================================
-- STARTUP MESSAGES
-- ================================================================

print("^2[Garage] Unified command system loaded successfully^0")
print("^6[Garage] Type /garage-help for interactive help menu^0")
print("^6[Garage] Type /garage-test to test all features^0")

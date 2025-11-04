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
-- SECTION 1: SYSTEM COMMANDS (User Available)
-- ================================================================

-- Help Command: Interactive Menu
RegisterCommand('garage-help', function()
    if HelpMenu then
        HelpMenu.Open()
    else
        print("^1[ERROR] Help system not loaded^0")
    end
end, false)

-- Help Command: Console Output
RegisterCommand('garage-commands', function()
    if HelpMenu then
        HelpMenu.PrintToConsole()
    else
        print("^1[ERROR] Help system not loaded^0")
    end
end, false)

-- System Information
RegisterCommand('garage-info', function()
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
end, false)

-- ================================================================
-- SECTION 2: GARAGE OPERATIONS (User Commands)
-- ================================================================

-- Property Garage Management
RegisterCommand('garage-property', function()
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
end, false)

-- Job Vehicle Garage Access
RegisterCommand('garage-job', function()
    TriggerServerEvent('dusa-garage:server:getJobVehicles')
end, false)

-- ================================================================
-- SECTION 3: ADMINISTRATOR COMMANDS (Admin Only)
-- ================================================================

-- [ADMIN] Garage Creator Tool
RegisterCommand('garage-create', function()
    TriggerServerEvent('dusa-garage:server:checkAdminPermission')
end, false)

-- [ADMIN] Job Configuration Editor
RegisterCommand('garage-createjob', function()
    TriggerEvent('dusa-garage:editor:openJobConfig')
end, false)

-- [ADMIN] All Garages Management
RegisterCommand('garage-manage', function()
    local nuiData = {
        action = 'openAllGaragesView',
        data = {}
    }

    SendNUIMessage(nuiData)
    SetNuiFocus(true, true)
end, false)

-- ================================================================
-- SECTION 4: DEBUG & TESTING COMMANDS
-- ================================================================

-- Development Test Menu
RegisterCommand('garage-test', function()
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
end, false)

-- ================================================================
-- SECTION 6: CHAT SUGGESTIONS REGISTRATION
-- ================================================================

-- System Commands
TriggerEvent('chat:addSuggestion', '/garage-help', 'Show all garage commands (Interactive Menu)')
TriggerEvent('chat:addSuggestion', '/garage-commands', 'Show all garage commands in console')
TriggerEvent('chat:addSuggestion', '/garage-info', 'Display garage system information')
TriggerEvent('chat:addSuggestion', '/garage-test', 'Open test menu (Development Tools)')

-- User Garage Commands
TriggerEvent('chat:addSuggestion', '/garage-property', 'Open property garage management')
TriggerEvent('chat:addSuggestion', '/garage-job', 'Access job vehicles garage')

-- Administrator Commands
TriggerEvent('chat:addSuggestion', '/garage-create', '[ADMIN] Create new garage location')
TriggerEvent('chat:addSuggestion', '/garage-createjob', '[ADMIN] Configure job garage settings')
TriggerEvent('chat:addSuggestion', '/garage-manage', '[ADMIN] Manage all garages (view, edit, delete)')

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

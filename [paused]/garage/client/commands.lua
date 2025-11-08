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
-- SECTION 6: VEHICLE CUSTOMIZATION FUNCTIONS
-- ================================================================

-- [CLIENT FUNCTION] Apply Random Vehicle Customization
local function ApplyRandomCustomization(vehicle)
    if not DoesEntityExist(vehicle) then
        print("^1[ERROR] Vehicle does not exist^0")
        return false
    end

    print("^2[Garage] Starting random customization...^0")

    -- Set vehicle mod kit to allow modifications
    SetVehicleModKit(vehicle, 0)

    -- Random Primary and Secondary Colors (0-159)
    local primaryColor = math.random(0, 159)
    local secondaryColor = math.random(0, 159)
    SetVehicleColours(vehicle, primaryColor, secondaryColor)
    print(("^3[Customization] Colors - Primary: %d, Secondary: %d^0"):format(primaryColor, secondaryColor))

    -- Random Pearlescent and Wheel Color
    local pearlColor = math.random(0, 159)
    local wheelColor = math.random(0, 159)
    SetVehicleExtraColours(vehicle, pearlColor, wheelColor)
    print(("^3[Customization] Pearl: %d, Wheel: %d^0"):format(pearlColor, wheelColor))

    -- Random Neon Lights
    local neonEnabled = math.random(1, 2) == 1
    if neonEnabled then
        local neonR = math.random(0, 255)
        local neonG = math.random(0, 255)
        local neonB = math.random(0, 255)
        SetVehicleNeonLightEnabled(vehicle, 0, true) -- Left
        SetVehicleNeonLightEnabled(vehicle, 1, true) -- Right
        SetVehicleNeonLightEnabled(vehicle, 2, true) -- Front
        SetVehicleNeonLightEnabled(vehicle, 3, true) -- Back
        SetVehicleNeonLightsColour(vehicle, neonR, neonG, neonB)
        print(("^3[Customization] Neon RGB: %d, %d, %d^0"):format(neonR, neonG, neonB))
    end

    -- Random Window Tint (0-6)
    local tint = math.random(0, 6)
    SetVehicleWindowTint(vehicle, tint)
    print(("^3[Customization] Window Tint: %d^0"):format(tint))

    -- Random Tire Smoke Color
    local smokeR = math.random(0, 255)
    local smokeG = math.random(0, 255)
    local smokeB = math.random(0, 255)
    SetVehicleTyreSmokeColor(vehicle, smokeR, smokeG, smokeB)
    ToggleVehicleMod(vehicle, 20, true) -- Enable tire smoke
    print(("^3[Customization] Tire Smoke RGB: %d, %d, %d^0"):format(smokeR, smokeG, smokeB))

    -- Random Performance Mods (Categories 11-13, 15, 16)
    local perfMods = {11, 12, 13, 15, 16, 18} -- Engine, Brakes, Transmission, Suspension, Armor, Turbo
    for _, modType in ipairs(perfMods) do
        local maxMod = GetNumVehicleMods(vehicle, modType)
        if maxMod > 0 then
            local randomMod = math.random(0, maxMod - 1)
            SetVehicleMod(vehicle, modType, randomMod, false)
            print(("^3[Customization] Mod Type %d: Level %d^0"):format(modType, randomMod))
        end
    end

    -- Random Visual Mods (Common categories)
    local visualMods = {
        0,  -- Spoiler
        1,  -- Front Bumper
        2,  -- Rear Bumper
        3,  -- Side Skirt
        4,  -- Exhaust
        5,  -- Frame
        6,  -- Grille
        7,  -- Hood
        8,  -- Fender
        9,  -- Right Fender
        10, -- Roof
        23, -- Dial
        24, -- Door Speaker
        25, -- Seats
        26, -- Steering Wheel
        27, -- Shift Leavers
        28, -- Plaques
        29, -- Speakers
        30, -- Trunk
        31, -- Hydraulics
        32, -- Engine Block
        33, -- Air Filter
        34, -- Struts
        35, -- Arch Cover
        36, -- Aerials
        37, -- Trim
        38, -- Tank
        39, -- Windows
        48, -- Livery
    }

    for _, modType in ipairs(visualMods) do
        local maxMod = GetNumVehicleMods(vehicle, modType)
        if maxMod > 0 then
            local randomMod = math.random(-1, maxMod - 1) -- -1 for stock
            SetVehicleMod(vehicle, modType, randomMod, false)
            if randomMod ~= -1 then
                print(("^3[Customization] Visual Mod %d: %d^0"):format(modType, randomMod))
            end
        end
    end

    -- Random Xenon Lights
    if math.random(1, 2) == 1 then
        ToggleVehicleMod(vehicle, 22, true) -- Enable xenon lights
        local xenonColor = math.random(0, 12)
        SetVehicleXenonLightsColour(vehicle, xenonColor)
        print(("^3[Customization] Xenon Color: %d^0"):format(xenonColor))
    end

    -- Random Custom Tires
    ToggleVehicleMod(vehicle, 20, math.random(1, 2) == 1)

    -- Random Front Wheels (Wheel Type + Variation)
    local wheelType = math.random(0, 11)
    SetVehicleWheelType(vehicle, wheelType)
    local maxWheels = GetNumVehicleMods(vehicle, 23)
    if maxWheels > 0 then
        local wheelMod = math.random(0, maxWheels - 1)
        SetVehicleMod(vehicle, 23, wheelMod, false)
        print(("^3[Customization] Wheels - Type: %d, Mod: %d^0"):format(wheelType, wheelMod))
    end

    -- Random License Plate Type
    local plateType = math.random(0, 5)
    SetVehicleNumberPlateTextIndex(vehicle, plateType)
    print(("^3[Customization] License Plate Type: %d^0"):format(plateType))

    print("^2[Garage] Random customization complete!^0")
    return true
end

-- [CLIENT EVENT] Apply Random Customization to Current Vehicle
RegisterNetEvent('garage:client:randomCustomize', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        print("^1[ERROR] You must be in a vehicle to use this command^0")
        return
    end

    local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    print(("^6[Garage] Applying random customization to %s...^0"):format(vehicleModel))

    ApplyRandomCustomization(vehicle)

    print("^2[SUCCESS] Vehicle has been randomly customized!^0")
end)

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

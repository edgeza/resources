-- OLRP Portal Teleport Client Script
-- Configurable multi-portal system for teleportation between multiple locations

local QBCore = exports['qb-core']:GetCoreObject()

-- Function to show help notification
function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Function to show notification
function ShowNotification(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(0, 1)
end

-- Function to check if player is near a portal
local function isNearPortal(coords, portalCoords)
    return #(coords - portalCoords) <= Config.Settings.detectionDistance
end

-- Function to find which portal pair a location belongs to
local function findPortalPair(coords)
    for i, portalPair in ipairs(Config.Portals) do
        if isNearPortal(coords, portalPair.portal1.coords) then
            return i, 1, portalPair.portal2 -- Return pair index, portal number, and destination
        elseif isNearPortal(coords, portalPair.portal2.coords) then
            return i, 2, portalPair.portal1 -- Return pair index, portal number, and destination
        end
    end
    return nil, nil, nil
end

-- Function to check if player is near any floor of a multi-floor building
local function findMultiFloorBuilding(coords)
    local closestFloor = nil
    local closestDistance = math.huge
    local closestFloorIndex = nil
    local closestBuilding = nil
    
    for i, building in ipairs(Config.MultiFloorBuildings) do
        for j, floor in ipairs(building.floors) do
            for k, floorCoords in ipairs(floor.coords) do
                if isNearPortal(coords, floorCoords) then
                    local distance = #(coords - floorCoords)
                    
                    print(string.format("[DEBUG] Found floor %d (%s) - Distance: %.2f", 
                        j, floor.name, distance))
                    
                    -- Find the closest floor coordinate
                    if distance < closestDistance then
                        closestDistance = distance
                        closestFloor = floor
                        closestFloorIndex = j
                        closestBuilding = building
                    end
                end
            end
        end
    end
    
    if closestFloor then
        print(string.format("[DEBUG] Selected floor %d (%s) as current floor (Distance: %.2f)", 
            closestFloorIndex, closestFloor.name, closestDistance))
        return 1, closestFloorIndex, closestBuilding -- Return building index, floor index, and building data
    end
    
    return nil, nil, nil
end

-- Function to show floor selection menu
local function showFloorMenu(building, currentFloor)
    local menuOptions = {}
    
    print(string.format("[DEBUG] Current floor index: %d, Floor name: %s", currentFloor, building.floors[currentFloor].name))
    
    for i, floor in ipairs(building.floors) do
        if i ~= currentFloor then -- Don't show current floor as option
            table.insert(menuOptions, {
                header = floor.label,
                txt = floor.description,
                params = {
                    isAction = true,
                    event = function()
                        selectFloor(building, i, floor.name)
                    end
                }
            })
        end
    end
    
    if #menuOptions > 0 then
        -- Check if qb-menu is available
        if GetResourceState('qb-menu') == 'started' then
            exports['qb-menu']:openMenu(menuOptions)
        else
            -- Fallback: Show simple notification with floor options
            local floorList = ""
            for i, floor in ipairs(building.floors) do
                if i ~= currentFloor then
                    floorList = floorList .. floor.label .. " "
                end
            end
            ShowNotification("Available floors: " .. floorList .. "| Use /testfloor commands")
        end
    else
        ShowNotification("No other floors available!")
    end
end

-- Function to handle floor selection directly
function selectFloor(building, floorIndex, floorName)
    local targetFloor = building.floors[floorIndex]
    if targetFloor then
        -- Teleport to the first coordinate of the target floor
        local destination = targetFloor.coords[1]
        teleportPlayer(destination, targetFloor.heading, building.name .. " - " .. floorName)
        
        -- Log to server
        TriggerServerEvent('olrp_portal:multiFloorTeleport', building.buildingId, floorIndex, floorName)
    else
        ShowNotification("ERROR: Floor not found!")
    end
end


-- Simple floor selection using key presses
local function showSimpleFloorMenu(building, currentFloor)
    local availableFloors = {}
    local floorNames = {}
    
    for i, floor in ipairs(building.floors) do
        if i ~= currentFloor then
            table.insert(availableFloors, {index = i, floor = floor})
            table.insert(floorNames, floor.label)
        end
    end
    
    if #availableFloors > 0 then
        local message = "Available floors: "
        for i, name in ipairs(floorNames) do
            message = message .. string.format("[%d] %s ", i, name)
        end
        ShowNotification(message)
        
        -- Store the available floors for key press handling
        _G.currentFloorMenu = {
            building = building,
            floors = availableFloors,
            currentFloor = currentFloor
        }
        
        -- Start listening for number key presses
        CreateThread(function()
            local timeout = 0
            while _G.currentFloorMenu and timeout < 300 do -- 3 second timeout
                for i = 1, #availableFloors do
                    if IsControlJustPressed(0, 157 + i) then -- Number keys 1-9
                        local selectedFloor = availableFloors[i]
                        local destination = selectedFloor.floor.coords[1]
                        
                        teleportPlayer(destination, selectedFloor.floor.heading, building.name .. " - " .. selectedFloor.floor.name)
                        TriggerServerEvent('olrp_portal:multiFloorTeleport', building.buildingId, selectedFloor.index, selectedFloor.floor.name)
                        
                        _G.currentFloorMenu = nil
                        return
                    end
                end
                
                if IsControlJustPressed(0, 322) then -- ESC key
                    _G.currentFloorMenu = nil
                    return
                end
                
                timeout = timeout + 1
                Wait(10)
            end
            _G.currentFloorMenu = nil
        end)
    else
        ShowNotification("No other floors available!")
    end
end


-- Function to draw multi-floor building marker
local function drawMultiFloorMarker(floor, buildingName)
    local marker = Config.Settings.marker
    local coords = floor.coords[1] -- Use first coordinate for marker
    
    DrawMarker(
        marker.type,
        coords.x, coords.y, coords.z - 1.0,
        0, 0, 0, 0, 0, 0,
        marker.size[1], marker.size[2], marker.size[3],
        marker.color[1], marker.color[2], marker.color[3], marker.color[4],
        marker.bobUpAndDown, marker.faceCamera, marker.rotate,
        nil, nil, false
    )
end



-- Function to teleport player
function teleportPlayer(destination, heading, portalName)
    local ped = PlayerPedId()
    
    -- Fade out
    DoScreenFadeOut(Config.Settings.teleport.fadeTime)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    
    -- Teleport
    SetEntityCoords(ped, destination.x, destination.y, destination.z, false, false, false, true)
    SetEntityHeading(ped, heading)
    
    -- Wait
    Wait(Config.Settings.teleport.waitTime)
    
    -- Fade in
    DoScreenFadeIn(Config.Settings.teleport.fadeTime)
    
    -- Show notification
    if Config.Settings.teleport.showNotification then
        ShowNotification(Config.Settings.teleport.notificationText)
    end
    
    -- Debug info
    if Config.Settings.debug.enabled then
        print(string.format("[OLRP Portal] Teleported to %s", portalName or "Unknown Location"))
    end
end

-- Function to draw portal marker
local function drawPortalMarker(portal, portalName)
    local marker = Config.Settings.marker
    local coords = portal.coords
    
    DrawMarker(
        marker.type,
        coords.x, coords.y, coords.z - 1.0,
        0, 0, 0, 0, 0, 0,
        marker.size[1], marker.size[2], marker.size[3],
        marker.color[1], marker.color[2], marker.color[3], marker.color[4],
        marker.bobUpAndDown, marker.faceCamera, marker.rotate,
        nil, nil, false
    )
    
    -- Debug: Show portal name if enabled
    if Config.Settings.debug.showPortalNames then
        local onScreen, screenX, screenY = World3dToScreen2d(coords.x, coords.y, coords.z + 1.0)
        if onScreen then
            SetTextScale(0.35, 0.35)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 215)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(portalName)
            DrawText(screenX, screenY)
        end
    end
end

-- Main thread for portal detection
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local sleep = 1000
        local nearPortal = false
        
        -- Check all portal pairs
        for i, portalPair in ipairs(Config.Portals) do
            local pairIndex, portalNum, destination = findPortalPair(coords)
            
            if pairIndex then
                nearPortal = true
                sleep = 0
                
                local currentPortal = (portalNum == 1) and portalPair.portal1 or portalPair.portal2
                local destinationPortal = destination
                
                -- Draw marker
                drawPortalMarker(currentPortal, portalPair.name)
                
                -- Show help text
                local helpText = string.format("Press ~INPUT_CONTEXT~ to %s", currentPortal.description)
                ShowHelpNotification(helpText)
                
                -- Handle teleportation
                if IsControlJustPressed(0, 38) then -- E key
                    teleportPlayer(
                        destinationPortal.coords, 
                        destinationPortal.heading, 
                        portalPair.name
                    )
                    
                    -- Log to server
                    TriggerServerEvent('olrp_portal:teleport', pairIndex, portalNum, portalPair.name)
                end
                
                break -- Only handle one portal at a time
            end
        end
        
        -- Check multi-floor buildings if no regular portal found
        if not nearPortal then
            local buildingIndex, floorIndex, building = findMultiFloorBuilding(coords)
            
            if buildingIndex then
                nearPortal = true
                sleep = 0
                
                local currentFloor = building.floors[floorIndex]
                
                -- Draw marker
                drawMultiFloorMarker(currentFloor, building.name)
                
                -- Show help text
                local helpText = string.format("Press ~INPUT_CONTEXT~ to select floor in %s", building.name)
                ShowHelpNotification(helpText)
                
                -- Handle floor selection
                if IsControlJustPressed(0, 38) then -- E key
                    showFloorMenu(building, floorIndex)
                end
            end
        end
        
        Wait(sleep)
    end
end)

-- Admin command to list all portals
RegisterCommand('listportals', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    print("=== OLRP Portal System - Available Portals ===")
    for i, portalPair in ipairs(Config.Portals) do
        local dist1 = #(coords - portalPair.portal1.coords)
        local dist2 = #(coords - portalPair.portal2.coords)
        
        print(string.format("Portal Pair %d: %s", i, portalPair.name))
        print(string.format("  Portal 1: %s (Distance: %.1f)", portalPair.portal1.label, dist1))
        print(string.format("  Portal 2: %s (Distance: %.1f)", portalPair.portal2.label, dist2))
        print("---")
    end
end, false)

-- Admin command to teleport to specific portal
RegisterCommand('tpportal', function(source, args)
    if #args < 2 then
        ShowNotification("Usage: /tpportal [pair] [portal] (e.g., /tpportal 1 1)")
        return
    end
    
    local pairIndex = tonumber(args[1])
    local portalNum = tonumber(args[2])
    
    if not pairIndex or not portalNum or pairIndex < 1 or pairIndex > #Config.Portals or portalNum < 1 or portalNum > 2 then
        ShowNotification("Invalid portal pair or number!")
        return
    end
    
    local portalPair = Config.Portals[pairIndex]
    local targetPortal = (portalNum == 1) and portalPair.portal1 or portalPair.portal2
    
    teleportPlayer(targetPortal.coords, targetPortal.heading, portalPair.name)
    ShowNotification(string.format("Teleported to %s", targetPortal.label))
end, false)

-- Test command to check if multi-floor buildings are working
RegisterCommand('testtriads', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    print("=== Testing Triads Detection ===")
    print("Your position: " .. tostring(coords))
    print("Detection distance: " .. Config.Settings.detectionDistance)
    
    if Config.MultiFloorBuildings then
        for i, building in ipairs(Config.MultiFloorBuildings) do
            print(string.format("Building %d: %s", i, building.name))
            for j, floor in ipairs(building.floors) do
                for k, floorCoords in ipairs(floor.coords) do
                    local dist = #(coords - floorCoords)
                    local isNear = dist <= Config.Settings.detectionDistance
                    print(string.format("  Floor %d, Coord %d: %s - Distance: %.2f - Near: %s", 
                        j, k, floor.label, dist, isNear and "YES" or "NO"))
                end
            end
        end
    else
        print("ERROR: MultiFloorBuildings config not found!")
    end
    
    ShowNotification("Triads test printed to console (F8)")
end, false)

-- Test command to manually trigger floor selection
RegisterCommand('testfloor', function(source, args)
    if #args < 1 then
        ShowNotification("Usage: /testfloor [1|2|3]")
        return
    end
    
    local floorIndex = tonumber(args[1])
    if not floorIndex or floorIndex < 1 or floorIndex > 3 then
        ShowNotification("Invalid floor number! Use 1, 2, or 3")
        return
    end
    
    -- Manually trigger the floor selection event
    local building = Config.MultiFloorBuildings[1] -- Triads building
    local floor = building.floors[floorIndex]
    
    if floor then
        local destination = floor.coords[1]
        teleportPlayer(destination, floor.heading, building.name .. " - " .. floor.name)
        ShowNotification("Teleported to " .. floor.label)
    else
        ShowNotification("Floor not found!")
    end
end, false)

-- Test command to simulate qb-menu event
RegisterCommand('testmenuevent', function()
    print("[OLRP Elevator] Testing menu event manually")
    ShowNotification("Testing menu event manually")
    
    -- Simulate the event that qb-menu should trigger
    TriggerEvent('olrp_elevator:testMenu')
    
    -- Wait a moment then test floor selection
    Citizen.Wait(1000)
    TriggerEvent('olrp_elevator:selectFloor', {
        buildingId = "triads_house",
        floorIndex = 2,
        floorName = "First Floor"
    })
end, false)

-- Debug command
RegisterCommand('portaldebug', function()
    Config.Settings.debug.enabled = not Config.Settings.debug.enabled
    ShowNotification(string.format("Portal debug: %s", Config.Settings.debug.enabled and "ON" or "OFF"))
end, false)
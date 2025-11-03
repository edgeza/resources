local QBCore = exports['qb-core']:GetCoreObject()
local isMenuOpen = false

-- Inventory Detection
local Inventory = nil
if GetResourceState('qs-inventory') == 'started' then
    Inventory = 'quasar'
elseif GetResourceState('ox_inventory') == 'started' then
    Inventory = 'ox'
elseif GetResourceState('qbx_inventory') == 'started' then
    Inventory = 'qbox'
else
    print('[OLRP Tester] Warning: No inventory detected! Using qs-inventory as fallback.')
    Inventory = 'quasar'
end

-- Draw 3D Text
local function Draw3DText(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
    end
end

-- Notification Helper
local function Notify(message, type)
    if exports.ox_lib then
        exports.ox_lib:notify({
            title = 'OLRP Tester',
            description = message,
            type = type or 'info',
            duration = 5000
        })
    elseif QBCore and QBCore.Functions then
        QBCore.Functions.Notify(message, type or 'primary')
    else
        print('[OLRP Tester] ' .. message)
    end
end

-- Open Category Menu
local function OpenCategoryMenu(categoryIndex)
    local category = Config.ItemCategories[categoryIndex]
    if not category then return end
    
    local menuOptions = {}
    
    -- Add items in category
    for i, item in ipairs(category.items) do
        table.insert(menuOptions, {
            title = item.label,
            description = 'Get ' .. item.label,
            icon = item.icon or 'box',
            onSelect = function()
                RequestItemAmount(item.name, item.label)
            end
        })
    end
    
    -- Add back option
    table.insert(menuOptions, {
        title = '← Back',
        description = 'Go back to categories',
        icon = 'arrow-left',
        onSelect = function()
            OpenMainMenu()
        end
    })
    
    lib.registerContext({
        id = 'olrp_tester_category_' .. categoryIndex,
        title = category.name,
        options = menuOptions
    })
    
    lib.showContext('olrp_tester_category_' .. categoryIndex)
end

-- Open Main Menu
local function OpenMainMenu()
    if isMenuOpen then return end
    
    local menuOptions = {}
    
    -- Add category items
    for i, category in ipairs(Config.ItemCategories) do
        table.insert(menuOptions, {
            title = category.name,
            description = 'Browse ' .. category.name,
            icon = category.icon or 'box',
            onSelect = function()
                OpenCategoryMenu(i)
            end
        })
    end
    
    lib.registerContext({
        id = 'olrp_tester_main',
        title = Config.MenuTitle,
        options = menuOptions
    })
    
    lib.showContext('olrp_tester_main')
    isMenuOpen = true
end

-- Request Item Amount
local function RequestItemAmount(itemName, itemLabel)
    local input = lib.inputDialog('Get ' .. itemLabel, {
        {
            type = 'number',
            label = 'Amount',
            description = 'Maximum: ' .. Config.MaxAmount,
            required = true,
            min = 1,
            max = Config.MaxAmount,
            default = 1
        }
    })
    
    if input and input[1] then
        local amount = tonumber(input[1])
        if amount and amount > 0 and amount <= Config.MaxAmount then
            TriggerServerEvent("olrp_tester:server:giveItem", itemName, amount)
        else
            Notify("Invalid amount! Maximum is " .. Config.MaxAmount, "error")
        end
    end
end

-- Create target zone at spawn location
CreateThread(function()
    -- Wait for ox_target or qb-target to be available
    Wait(1000)
    
    local location = Config.Location
    
    -- Try ox_target first
    if GetResourceState('ox_target') == 'started' then
        exports.ox_target:addSphereZone({
            coords = location,
            radius = 2.0,
            debug = false,
            options = {
                {
                    name = 'olrp_tester_zone',
                    icon = 'box',
                    label = 'Open Tester Menu',
                    onSelect = function()
                        OpenMainMenu()
                    end
                }
            }
        })
    -- Try qb-target
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:AddCircleZone("olrp_tester_zone", location, 2.0, {
            name = "olrp_tester_zone",
            debugPoly = false,
        }, {
            options = {
                {
                    type = "client",
                    event = "olrp_tester:client:openMainMenu",
                    icon = "box",
                    label = "Open Tester Menu",
                }
            },
            distance = 2.0
        })
    end
    
    -- Draw 3D text and marker as fallback
    CreateThread(function()
        while true do
            Wait(0)
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - location)
            
            if distance < 10.0 then
                DrawMarker(1, location.x, location.y, location.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 255, 165, 0, 100, false, true, 2, false, nil, nil, false)
                
                if distance < 2.0 then
                    Draw3DText(vector3(location.x, location.y, location.z + 0.5), "[E] Open Tester Menu")
                    if IsControlJustPressed(0, 38) then -- E key
                        OpenMainMenu()
                    end
                end
            else
                Wait(500)
            end
        end
    end)
end)

-- Events
RegisterNetEvent("olrp_tester:client:openMainMenu", function()
    OpenMainMenu()
end)

-- Menu closed event
AddEventHandler('ox_lib:menuClosed', function()
    isMenuOpen = false
end)

-- Debug command (optional, can be removed)
RegisterCommand("tester", function()
    OpenMainMenu()
end, false)

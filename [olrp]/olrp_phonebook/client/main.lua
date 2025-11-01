local QBCore = exports['qb-core']:GetCoreObject()
local isOpen = false

-- Ensure focus is cleared on (re)load
SetNuiFocus(false, false)

local function setNuiFocus(state)
    SetNuiFocus(state, state)
    SetNuiFocusKeepInput(false)
end

local function openPhonebook()
    if isOpen then return end
    isOpen = true
    setNuiFocus(true)

    -- Request contacts then open UI
    QBCore.Functions.TriggerCallback('olrp_phonebook:getContacts', function(contacts)
        SendNUIMessage({ action = 'open', contacts = contacts or {}, city = 'City' })
    end)
end

local function closePhonebook()
    if not isOpen then return end
    isOpen = false
    setNuiFocus(false)
    SendNUIMessage({ action = 'close' })
end

RegisterNUICallback('close', function(_, cb)
    closePhonebook()
    cb(true)
end)

-- ESC handling from NUI
RegisterNUICallback('escape', function(_, cb)
    closePhonebook()
    cb(true)
end)

-- Command to open
RegisterCommand('phonebook', function()
    openPhonebook()
end, false)

 -- Key mapping removed: phonebook can only be opened via /phonebook command

-- Safety: close UI and clear focus if resource (re)starts or stops
AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    isOpen = false
    SetNuiFocus(false, false)
end)



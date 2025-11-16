local activeBlips = {}

local function clearBlip(id)
    local handle = activeBlips[id]

    if handle then
        RemoveBlip(handle)
        activeBlips[id] = nil
    end
end

local function createBlip(blipData)
    clearBlip(blipData.id)

    local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
    SetBlipSprite(blip, blipData.sprite)
    SetBlipColour(blip, blipData.color)
    SetBlipScale(blip, blipData.scale)
    SetBlipAsShortRange(blip, blipData.short_range)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipData.label)
    EndTextCommandSetBlipName(blip)

    activeBlips[blipData.id] = blip
end

local function clearAllBlips()
    for id in pairs(activeBlips) do
        clearBlip(id)
    end
end

RegisterNetEvent('olrp-blipcreator:sync', function(serverBlips)
    clearAllBlips()

    for _, data in pairs(serverBlips or {}) do
        createBlip(data)
    end
end)

local function requestSync()
    TriggerServerEvent('olrp-blipcreator:requestSync')
end

CreateThread(function()
    Wait(1500)
    requestSync()
end)

AddEventHandler('playerSpawned', function()
    requestSync()
end)

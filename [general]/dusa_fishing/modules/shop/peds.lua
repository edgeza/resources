if not rawget(_G, "lib") then include('ox_lib', 'init') end
if not lib then return end

for _, coords in ipairs(config.ped.locations) do
    Functions.createPed(coords, config.ped.model, {
        {
            label = locale('open_fisherman'),
            icon = 'fish',
            event = "dusa_fishing:OpenMenu",
        }
    })
    Functions.createBlip(coords, config.ped.blip)
end

for id, location in pairs(config.rentboat) do
    Functions.createPed(location.ped.coords, location.ped.model, {
        {
            label = locale('open_boat_rental'),
            icon = 'ship',
            onSelect = function ()
                RentalMenu(id, location)
            end
        }
    })

    if location.ped.blip.enabled then
        Functions.createBlip(location.ped.coords, location.ped.blip)
    end

    -- create box zones to return boat
    local BoatBoxes = {}
    local isTextUIOpen = false
    for i, coords in ipairs(location.boat.spawnpoints) do
        BoatBoxes[#BoatBoxes + 1] = lib.zones.box({
            coords = coords,
            size = location.boat.size,
            inside = function ()
                local textUI

                if not isTextUIOpen then
                    isTextUIOpen = true
                    textUI = lib.showTextUI('E - '..locale('return_boat'), {
                        position = "right-center",
                        icon = 'ship',
                    })
                end

                if IsControlJustPressed(0, 38) then -- E key
                    lib.hideTextUI()
                    isTextUIOpen = false
                    if cache.vehicle then
                        TriggerServerEvent('fishing:server:returnBoat')
                        DoScreenFadeOut(500)
                        Wait(500)
                        -- DeleteEntity(cache.vehicle)
                        SetEntityCoords(cache.ped, location.ped.coords.x, location.ped.coords.y, location.ped.coords.z)
                        DoScreenFadeIn(500)
                        Framework.Notify(locale('successfully_returned_boat'), 'success')
                    else
                        Framework.Notify(locale('not_in_boat'), 'error')
                    end
                end
            end,
            onExit = function ()
                lib.hideTextUI()
                isTextUIOpen = false
            end
        })
    end
end

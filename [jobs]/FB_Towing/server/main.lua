local towingState = {}

RegisterNetEvent('custom_flatbed:detach', function(netFlatbed)
    towingState[netFlatbed] = nil
end)

AddEventHandler('playerDropped', function()
    -- future cleanup hook if required
end)


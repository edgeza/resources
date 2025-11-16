Citizen.CreateThread(function()
    local coords = vector3(-1571.880, -1020.008, 13.861)
    local distance = 30.0

    while true do
        ClearAreaOfVehicles(coords.x, coords.y, coords.z, distance, false, false, false, false, false)
        ClearAreaOfPeds(coords.x, coords.y, coords.z, distance, true)
        Citizen.Wait(0)
    end
end)
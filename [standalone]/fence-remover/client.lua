-- Permanently remove specific fence at MLO location
local fenceModel = `prop_fnc_farm_01e`
local fenceCoords = vector3(-695.01, 986.53, 238.21)

-- Run immediately on resource start
CreateThread(function()
    RequestModel(fenceModel)
    while not HasModelLoaded(fenceModel) do
        Wait(100)
    end
    
    -- Initial cleanup - run 10 times on startup to catch it early
    for i = 1, 10 do
        local obj = GetClosestObjectOfType(fenceCoords.x, fenceCoords.y, fenceCoords.z, 15.0, fenceModel, false, false, false)
        if obj ~= 0 and DoesEntityExist(obj) then
            SetEntityAsMissionEntity(obj, true, true)
            DeleteObject(obj)
            SetEntityAsNoLongerNeeded(obj)
            print("^2[Fence Remover] Deleted fence on startup (attempt " .. i .. ")^7")
        end
        Wait(500)
    end
end)

-- Continuous removal loop
CreateThread(function()
    while true do
        Wait(100) -- Check every 100ms (very aggressive)
        
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - fenceCoords)
        
        -- If player is within 150 units of the fence location
        if distance < 150.0 then
            local obj = GetClosestObjectOfType(fenceCoords.x, fenceCoords.y, fenceCoords.z, 15.0, fenceModel, false, false, false)
            
            if obj ~= 0 and DoesEntityExist(obj) then
                SetEntityAsMissionEntity(obj, true, true)
                DeleteObject(obj)
                SetEntityAsNoLongerNeeded(obj)
                print("^2[Fence Remover] Deleted respawned fence^7")
            end
        else
            Wait(900) -- If far away, wait longer to save performance
        end
    end
end)


local clearVehiclesMechanicThunderShop = true  --if you don't want NPC riding a car passing through the MechanicThunderShop, put = true
local clearPedsMechanicThunderShop = true --if you don't want NPC passing through the MechanicThunderShop, put = true

CreateThread(function()

    while clearVehiclesMechanicThunderShop do 
        ClearAreaOfVehicles(-2045.93, -487.58, 12.2, 250.0, false, false, false, false, false) -- 
        Wait(250)
    end 
end)

CreateThread(function()

    while clearPedsMechanicThunderShop do 
        ClearAreaOfPeds(-2045.93, -487.58, 12.2, 250.0, 1)
        Wait(250)
    end 
end)
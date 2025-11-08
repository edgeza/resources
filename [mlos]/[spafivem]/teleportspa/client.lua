key_to_teleport = 38

positions = {
    --[[
    {{Teleport1 X, Teleport1 Y, Teleport1 Z, Teleport1 Heading}, {Teleport2 X, Teleport 2Y, Teleport 2Z, Teleport2 Heading}, {Red, Green, Blue}, "Text for Teleport"}
    ]]
    {{4411.61, 7998.35, 91.06, 0}, {-1081.0049, -248.7867, 37.7633, 109.0286},{36,237,157}, "ROD Transfers"}, -- 'Bridge' near the Lighthouse
    
}

-----------------------------------------------------------------------------
-------------------------DO NOT EDIT BELOW THIS LINE-------------------------
-----------------------------------------------------------------------------

local player = GetPlayerPed(-1)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do
            teleport_text = location[4]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }
            Red = location[3][1]
            Green = location[3][2]
            Blue = location[3][3]

            DrawMarker(1, loc1.x, loc1.y, loc1.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 200, 0, 0, 0, 0)
            DrawMarker(1, loc2.x, loc2.y, loc2.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 200, 0, 0, 0, 0)

            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then 
                alert(teleport_text)
                
                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
                    else
                        SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(player, loc2.heading)
                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then
                alert(teleport_text)

                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
                    else
                        SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(player, loc1.heading)
                    end
                end
            end            
        end
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end
CreateThread(function()
    local blip = AddBlipForCoord(-1066.85, -243.36, 39.73) -- Replace with your race start coords

    SetBlipSprite(blip, 315)          -- Racing flag icon
    SetBlipDisplay(blip, 4)           -- Display type
    SetBlipScale(blip, 1.0)           -- Size of blip
    SetBlipColour(blip, 5)            -- Yellow color
    SetBlipAsShortRange(blip, true)   -- Only show when nearby

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Formula 1")
    EndTextCommandSetBlipName(blip)
end)
CreateThread(function()
    local blip = AddBlipForCoord(4417.75, 7873.51, 89.1) -- Replace with your race start coords

    SetBlipSprite(blip, 315)          -- Racing flag icon
    SetBlipDisplay(blip, 4)           -- Display type
    SetBlipScale(blip, 1.0)           -- Size of blip
    SetBlipColour(blip, 5)            -- Yellow color
    SetBlipAsShortRange(blip, true)   -- Only show when nearby

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Formula 1")
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    local blip = AddBlipForCoord(-947.38, -284.68, 81.45) -- Replace with your race start coords

    SetBlipSprite(blip, 475)          -- Racing flag icon
    SetBlipDisplay(blip, 4)           -- Display type
    SetBlipScale(blip, 0.7)           -- Size of blip
    SetBlipColour(blip, 1)            -- Red color
    SetBlipAsShortRange(blip, true)   -- Only show when nearby

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("OneLife Tower")
    EndTextCommandSetBlipName(blip)
end)

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end
canDisplayRadar = false

RegisterNetEvent("rcore_fuel:hideHud", function()
    if not IsRadarHidden() then
        canDisplayRadar = true
        DisplayRadar(false)
    end

    ExecuteCommand("hud")
end)

RegisterNetEvent("rcore_fuel:showHud", function()
    ExecuteCommand("hud")

    Wait(100)

    if canDisplayRadar then
        canDisplayRadar = false
        DisplayRadar(true)
    end
end)
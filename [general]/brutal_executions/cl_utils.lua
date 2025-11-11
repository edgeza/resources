ESX = Core
QBCore = Core

-- Buy here: (4€+VAT) https://store.brutalscripts.com
function notification(title, text, time, type)
    if Config.BrutalNotify then
        exports['brutal_notify']:SendAlert(title, text, time, type)
    else
        -- Put here your own notify and set the Config.BrutalNotify to false
        SetNotificationTextEntry("STRING")
        AddTextComponentString(text)
        DrawNotification(0,1)

        -- Default ESX Notify:
        --TriggerEvent('esx:showNotification', text)

        -- Default QB Notify:
        --TriggerEvent('QBCore:Notify', text, 'info', 5000)

        -- OKOK Notify:
        -- exports['okokNotify']:Alert('POLICE JOB', text, time, 'info')

    end
end

function TextUIFunction(type, text)
    if type == 'open' then
        if Config.TextUI:lower() == 'ox_lib' then
            lib.showTextUI(text)
        elseif Config.TextUI:lower() == 'okoktextui' then
            exports['okokTextUI']:Open(text, 'darkblue', 'right')
        elseif Config.TextUI:lower() == 'esxtextui' then
            ESX.TextUI(text)
        elseif Config.TextUI:lower() == 'qbdrawtext' then
            exports['qb-core']:DrawText(text,'left')
        elseif Config.TextUI:lower() == 'brutal_textui' then
            exports['brutal_textui']:Open(text, "blue")
        end
    elseif type == 'hide' then
        if Config.TextUI:lower() == 'ox_lib' then
            lib.hideTextUI()
        elseif Config.TextUI:lower() == 'okoktextui' then
            exports['okokTextUI']:Close()
        elseif Config.TextUI:lower() == 'esxtextui' then
            ESX.HideUI()
        elseif Config.TextUI:lower() == 'qbdrawtext' then
            exports['qb-core']:HideText()
        elseif Config.TextUI:lower() == 'brutal_textui' then
            exports['brutal_textui']:Close()
        end
    end
end

function isPlayerDead()
    if GetResourceState("brutal_ambulancejob") == "started" then
        return exports.brutal_ambulancejob:IsDead()
    else
        if IsEntityDead(PlayerPedId()) then
            return true
        else
            return false
        end
    end
end

function isEntityClear(targetID)
    local clear = true
    if IsEntityPlayingAnim(GetPlayerPed(GetPlayerFromServerId(targetID)), "nm", "firemans_carry", 3) then
        clear = false
    end

    return clear
end

function OpenMenuUtil()
    InMenu = true
    SetNuiFocus(true, true)

    Citizen.CreateThread(function()
        while InMenu do
            N_0xf4f2c0d4ee209e20() -- it's disable the AFK camera zoom
            Citizen.Wait(15000)
        end 
    end)

    DisplayRadar(false)
end

function DisableMinimap()
    DisplayRadar(false)
    -- Here you can add a trigger to hide your HUD system
end

function EnableMinimap()
    DisplayRadar(true)
    -- Here you can add a trigger to enable your HUD system
end
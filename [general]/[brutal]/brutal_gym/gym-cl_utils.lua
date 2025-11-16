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
        -- exports['okokNotify']:Alert('GYM', text, time, type, false)

    end
end

function AddSkill(Skill)
    -- You can use another skill system, but I think our the best :D, because that is simple and great
    if Config.MINIGAME then
        finished = exports["taskbarskill"]:taskBar(3700, 1)
        if finished == 100 then 
            TriggerEvent('brutal_skills:client:AddSkill', Skill, 1)
        end
    else
        TriggerEvent('brutal_skills:client:AddSkill', Skill, 1)
    end
    -- Trigger name, SKILL_NAME, AMOUNT
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
            exports['brutal_textui']:Open(text, "yellow")
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

function ProgressBarFunction(time, text)
    if Config.ProgressBar:lower() == 'progressbars' then --LINK: https://github.com/EthanPeacock/progressBars/releases/tag/1.0
        exports['progressBars']:startUI(time, text)
    elseif Config.ProgressBar:lower() == 'mythic_progbar' then -- LINK: https://github.com/HarryElSuzio/mythic_progbar
        TriggerEvent("mythic_progbar:client:progress", {name = "policejobduty", duration = time, label = text, useWhileDead = false, canCancel = false})
    elseif Config.ProgressBar:lower() == 'pogressbar' then -- LINK: https://github.com/SWRP-PUBLIC/pogressBar
        exports['pogressBar']:drawBar(time, text)
    end
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


--[[
    Exercise Play trigger: TriggerEvent('brutal_skills:client:PlayExercise', exercise, heading)
]]
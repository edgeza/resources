function SetInfo(type, value)
    dp('Set Info: ', type, value)
    Wait(100)
    nuiMessage(type, value)
end

function GetMoneyInfo(type)
    local money = lib.callback.await('dusa_hud:getMoney', false, type)
    return money
end

function SetHud()
    SetupMainHud()
    SetupStress()
    HideStatus('oxygen', true)
    SetupInformations()
    hudSettings.currentStatus = GetPlayerSetting('status')
    hudSettings.currentSpeedo = GetPlayerSetting('speedometer')
end

function SetupMainHud()
    if hudSettings.showMiniMap then
        nuiMessage('toggleMap', true)
        DisplayRadar(true)
    else
        DisplayRadar(false)
        nuiMessage('toggleMap', false)
    end
    
    nuiMessage('openMap', false)
    nuiMessage('openSpeedo', false)
    if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then dp('opened speedo') nuiMessage('openSpeedo', true) nuiMessage('toggleMap', true) end
end

function SetupInformations()
    if config.EnableInformations then
        local blackmoney = GetBlackMoney() or 0
        SetInfo('setLogo', config.Logo)
        SetInfo('setId', GetPlayerServerId(PlayerId()))
        SetInfo('setBank', GetMoneyInfo('bank'))
        SetInfo('setCash', GetMoneyInfo('cash'))
        SetInfo('setCoin', GetCoin())
        SetInfo('setName', config.ServerName)
        SetInfo('setBlackMoney', blackmoney)
        SetInfo('setServerLink', config.Link)
        SetInfo('setJob', GetJob())
        local time = GetTime()
        SetInfo('setTime', time)
    else
        nuiMessage('setHideInfo', true)
    end
end

function GetJob(newJob)
    local job = shared.playerdata.job.label
    local grade = shared.playerdata.job.grade
    if newJob then
        job = newJob.label
        grade = newJob.grade.name
    end
    local str = grade .. ' - ' .. job
    return str
end

function SetupStress()
    HideStatus('stress', not config.EnableStress)
    TriggerServerEvent("dusa_hud:CheckStress")
end

function GetTime()
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    if config.TimeType == 'real' then _, _, _, hours, minutes = GetLocalTime() end
    local string = 'AM'
    if config.TimeFormat == '12h' then
        if hours == 0 or hours == 24 then
            hours = 12 
            
        elseif hours >= 13 then            
            string = 'PM'
            hours = hours - 12
        end
    end
    if hours < 10 then
        hours = '0'..hours
    end
    if minutes < 10 then
        minutes = '0'..minutes
    end
    local formattedText = hours .. ':'..minutes
    if config.TimeFormat == '12h' then
        formattedText = formattedText ..' '..string
    end
    return formattedText
end

function InfoLoop()
    CreateThread(function()
        while true do
            local time = GetTime()
            SetInfo('setTime', time)
            SetInfo('setBank', GetMoneyInfo('bank'))
            SetInfo('setCash', GetMoneyInfo('cash'))
            SetInfo('setCoin', GetCoin())
            Wait(1 * 60000)
        end
    end)
end
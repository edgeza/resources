local IsCancelled = false
IsCancellableProgressRunning = false

Citizen.CreateThread(function()
    AddTextEntry('RC_CANCEL', "~" .. Config.CancelProgressBar.Label .. "~ " .. Config.CancelProgressBar.Text)
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end
end

function CancellableProgress(time, text, animDict, animName, flag, finish, cancel, opts)
    IsCancellableProgressRunning = true
    IsCancelled = false
    local ped = PlayerPedId()

    if not opts then opts = {} end

    if animDict then
        LoadAnimDict(animDict)
        TaskPlayAnim(ped, animDict, animName, opts.speedIn or 1.0, opts.speedOut or 1.0, -1, flag, 0, 0, 0, 0)
    end

    StartCancellableProgressBar(time, text)

    local timeLeft = time

    while true do
        Wait(0)
        timeLeft = timeLeft - (GetFrameTime() * 1000)

        if timeLeft <= 0 then
            break
        end

        DisableControlAction(0, Config.CancelProgressBar.Key, true)

        DisplayHelpTextThisFrame('RC_CANCEL', true)

        if IsControlPressed(0, Config.CancelProgressBar.Key) or IsDisabledControlPressed(0, Config.CancelProgressBar.Key) then
            IsCancelled = true
        end

        if IsCancelled then
            ClearPedTasksImmediately(ped)
            IsCancellableProgressRunning = false

            if cancel then
                StopCancellableProgressBar()
                cancel()
                return
            end
        end
    end

    if animDict then
        StopAnimTask(ped, animDict, animName, 1.0)
    end

    IsCancellableProgressRunning = false

    if finish then
        finish()
    end
end

function StartCancellableProgressBar(time, text)
    IsProgressbarDisplayed = true
    local maxProgressWidth = 0.2
    local curProgressWidth = 0.0

    local border = 0.007
    time = time / 1000

    local distFromTop = 0.91

    Citizen.CreateThread(function()
        while IsProgressbarDisplayed and curProgressWidth < 1.0 do
            Wait(0)

            curProgressWidth = curProgressWidth + (GetFrameTime() / time)

            DrawRect(
                0.5, distFromTop,
                maxProgressWidth, 0.05,
                0, 0, 0, 200
            )

            DrawRect(
                0.5, distFromTop - 0.0005,
                maxProgressWidth * curProgressWidth * 0.999, 0.05 - border,
                255, 105, 97, 200
            )

            SetTextFont(0)
            SetTextScale(0.0, 0.4)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextJustification(0)
            SetTextEntry("STRING")
            AddTextComponentSubstringPlayerName(text)
            DrawText(0.5, 0.893)
        end
    end)
end

function StopCancellableProgressBar()
    IsProgressbarDisplayed = false
end

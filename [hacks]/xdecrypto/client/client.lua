local MiniGame = {}
local HackStatus = false
local Callback

-- NUI
MiniGame.Open = function(cb)
    SendNUIMessage({
        action = "open",
        base = Config.MingameBase,
        timeLimit = Config.MinigameTimeLimit,
        attemptLimit = Config.MingameAttemptLimit
    })
    SetNuiFocus(true, true)
    Callback = cb
end

RegisterNUICallback('close', function(data, cb)
    cb('ok')
    HackStatus = data
    SetNuiFocus(false, false)
    if Callback then
        Callback(HackStatus)
        Callback = nil
    end
end)

-- Exports
exports('StartHack', function(cb)
    MiniGame.Open(cb)
end)
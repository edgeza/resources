-- If you don't want to use the build in system, this is for notifications when all goes according to plan. (i.e. vehicle is loaded)
local function sendBrutalNotify(title, message, notifType)
    notifType = notifType or 'info'
    if GetResourceState and GetResourceState('brutal_notify') == 'started' then
        exports['brutal_notify']:SendAlert(title or 'TOWING', message or '', 5000, notifType, true)
    else
        print(('[fh_towing] %s: %s'):format(notifType:upper(), message))
    end
end

RegisterNetEvent("fh_towing:client:InfoNotification", function(notificationText)
-- You can change this to your prefered notification System --

    sendBrutalNotify('TOWING', notificationText, 'info')
    --ESX.ShowNotification(notificationText)
    --exports['okokNotify']:Alert('Detailer', notificationText, Time, 'info', false)

end)

-- If you don't want to use the build in system, this is for notifications when something goes wrong. (i.e. loading cancelled)
RegisterNetEvent("fh_towing:client:WarningNotification", function(notificationText)
-- You can change this to your prefered notification System --

    sendBrutalNotify('TOWING', notificationText, 'error')
    --ESX.ShowNotification(notificationText)
    --exports['okokNotify']:Alert('Detailer', notificationText, Time, 'error', false)

end)

-- If you don't want to use the build in system, here you can add your own progress bar. If you don't want to use one just delete or quote the example.
RegisterNetEvent("fh_towing:client:3rdPartyBar", function(time, progressText)
-- Add your prefered progress bar here if you don't want to use the build in one

    exports['progressBar']:drawBar(time, progressText)

end)

-- Check if vehicle is allowed to be towed.
-- You can put your own code inside this 
-- It's for e.g. prohibit boosting cars to be towed (power gaming)
function allowedToTow(vehicleClientID)
    if vehicleClientID == vehicleClientID then --Just a random statement. Put your own check here.
        return true --return true to allow vehicle to be towed
    else
        return false --return false to disallow vehicle to be towed
    end
end

-- Function to retrieve the key label
function GetKeyLabel(key)
    local keyNames = {
        [38] = "E",        -- Q-key
        [44] = "Q",        -- E-key
        [172] = "↑",       -- Up-key
        [173] = "↓",       -- Down-key
        [174] = "←",       -- Left-key
        [175] = "→",       -- Right-key
        [73] = "X",        -- X-Key
        [177] = "[ ← ]" -- Backspace-Key
        -- You can add more keys here if needed.
    }
    return keyNames[key] or ("KEY_" .. tostring(key))
end
if isBridgeLoaded('Framework', Framework.Standalone) then
    Citizen.CreateThread(function()
        while true do
            if NetworkIsPlayerActive(PlayerId()) then
                Citizen.Wait(500)
                TriggerServerEvent('rcore_xmas:bridge:standalonePlayerActivated')
                break
            end
            Citizen.Wait(0)
        end
    end)

    function Framework.showHelpNotification(text)
        DisplayHelpTextThisFrame(text, false)
        BeginTextCommandDisplayHelp(text)
        EndTextCommandDisplayHelp(0, false, false, -1)
    end

    function Framework.sendNotification(message, type)
        TriggerEvent('chat:addMessage', {
            multiline = true,
            args = { message }
        })
    end
end

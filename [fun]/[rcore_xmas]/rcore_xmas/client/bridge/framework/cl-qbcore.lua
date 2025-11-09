if isBridgeLoaded('Framework', Framework.QBCore) then
    local QBCore = nil

    local success = pcall(function()
        QBCore = exports[Framework.QBCore]:GetCoreObject()
    end)

    if not success then
        success = pcall(function()
            QBCore = exports[Framework.QBCore]:GetSharedObject()
        end)
    end

    if not success then
        local breakPoint = 0
        while not QBCore do
            Wait(100)
            TriggerEvent('QBCore:GetObject', function(obj)
                QBCore = obj
            end)

            breakPoint = breakPoint + 1
            if breakPoint == 25 then
                log.error('Could not load the sharedobject, are you sure it is called \'QBCore:GetObject\'?')
                break
            end
        end
    end

    Framework.object = QBCore

    function Framework.showHelpNotification(text)
        DisplayHelpTextThisFrame(text, false)
        BeginTextCommandDisplayHelp(text)
        EndTextCommandDisplayHelp(0, false, false, -1)
    end

    function Framework.sendNotification(message, type)
        TriggerEvent('QBCore:Notify', message, type, 5000)
    end
end

RegisterNetEvent('ZSX_Multicharacter:Listener:SelectedCharacter', loadWeather)

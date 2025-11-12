CreateThread(function()
    if Config.Framework == Framework.QBOX then
        local QBCore = nil
        local EnforcePlayerLoaded = false

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
                    dbg.critical('Could not load the sharedobject, are you sure it is called \'QBCore:GetObject\'?')
                    break
                end
            end
        end
    
        Framework.object = QBCore

        function HandleInventoryOpenState(state)
            local ply = LocalPlayer
        
            if not ply then
                return
            end
        
            ply.state:set('inv_busy', state)
        end

        function Framework.showHelpNotification(text)
            DisplayHelpTextThisFrame(text, false)
            BeginTextCommandDisplayHelp(text)
            EndTextCommandDisplayHelp(0, false, false, -1)
        end
    
        function Framework.sendNotification(message, type)
            TriggerEvent('QBCore:Notify', message, type, 5000)
        end

        function Framework.isInJob()
            if Framework.job and Config.Jobs[Framework.job.name] then
                return true
            end

            return false
        end

        function AwaitPlayerLoad()
            Wait(1000)

            local identity = FindTargetResource and FindTargetResource('identity') or nil
            local multichar = FindTargetResource and FindTargetResource('multicharacter') or nil

            if not identity then
                identity = 'IDENTITY_NOT_FOUND'
            end

            if not multichar then
                multichar = 'MULTICHAR_NOT_FOUND'
            end

            dbg.debug('AwaitPlayerLoad: Checking server enviroment: \nIdentity: %s \nMultichar: %s', identity,
                multichar)

            if LocalPlayer.state['isLoggedIn'] and type(LocalPlayer.state['isLoggedIn']) == "boolean" then
                repeat
                    Wait(500)
                    dbg.debug(
                        'AwaitPlayerLoad: Awaiting to player load as active character via method: LocalPlayer.state.isLoggedIn')
                until LocalPlayer.state['isLoggedIn']
            elseif Framework.object then
                local size = 0
                local playerData = Framework.object.Functions.GetPlayerData()

                if type(playerData) == "table" then
                    repeat
                        Wait(500)
                        playerData = Framework.object.Functions.GetPlayerData()
                        size = table.size(playerData)
                        dbg.debug(
                            'AwaitPlayerLoad: Awaiting to player load as active character via method: PlayerData')
                    until size and size > 0 or EnforcePlayerLoaded
                end
            else
                dbg.debug(
                    'AwaitPlayerLoad: Any of framework related helper functions, not found: loading fallback solution.')
            end

            dbg.debug('AwaitPlayerLoad: Requesting player load, since player is found as active!')

            TriggerServerEvent('rcore_prison:server:requestPlayerLoaded')
        end


        CreateThread(function()
            while true do
                if NetworkIsPlayerActive(PlayerId()) then
                    Wait(500)
                    AwaitPlayerLoad()
                    break
                end
                Wait(0)
            end
        end, "cl-standalone code name: Alfa")

        AddEventHandler('playerSpawned', function()
            if EnforcePlayerLoaded then
                EnforcePlayerLoaded = false
            end
        end)

        RegisterNetEvent('rcore_prison:client:playerLoaded')
        AddEventHandler('rcore_prison:client:playerLoaded', function(jobData)
            dbg.debug('Framework - job: Updating player job data [customEvent]')
            Framework.setJob({
                name = jobData.name,
                gradeName = jobData.grade,
                grade = jobData.grade,
                isOnDuty = jobData.onDuty,
                isBoss = jobData.isBoss
            })
        end)

        RegisterNetEvent(Config.FrameworkEvents['QBCore:Client:OnJobUpdate'])
        AddEventHandler(Config.FrameworkEvents['QBCore:Client:OnJobUpdate'], function(updatedJobData)
            dbg.debug('Framework - job: Updating player job data!')
            Framework.setJob({
                name = updatedJobData.name,
                gradeName = updatedJobData.grade.name,
                grade = updatedJobData.grade.level,
                isOnDuty = updatedJobData.onduty,
                isBoss = updatedJobData.isboss
            })
        end)

        SetTimeout(1000, function()
            if not Framework.object then
                return
            end

            local success, result = pcall(function()
                return Framework.object.Functions.GetPlayerData() and Framework.object.Functions.GetPlayerData().job
            end)

            if result and success then
                dbg.debug('Framework - job: Setting player job data on init!')
                Framework.setJob({
                    name = result.name,
                    gradeName = result.grade.name,
                    grade = result.grade.level,
                    isOnDuty = result.onduty,
                    isBoss = result.isboss
                })
            end
        end)

        function Framework.setJob(job)
            Framework.job = job
        end
    end    
end, "cl-qbox code name: Phoenix")
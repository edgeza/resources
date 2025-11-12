CreateThread(function()
    if Config.Framework == Framework.ESX then
        local ESX = nil
        local EnforcePlayerLoaded = false

        local success, result = pcall(function()
            ESX = exports[Framework.ESX]:getSharedObject()
        end)

        if not success then
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end

        Framework.object = ESX

        function Framework.showHelpNotification(text)
            ESX.ShowHelpNotification(text, true, false)
        end

        function Framework.sendNotification(message, type)
            ESX.ShowNotification(message, type)
        end

        function HandleInventoryOpenState(state)
            local ply = LocalPlayer

            if not ply then
                return
            end
        end

        function AwaitPlayerLoad()
            if not ESX then
                return
            end

            local identity = FindTargetResource and FindTargetResource('identity') or nil
            local multichar = FindTargetResource and FindTargetResource('multicharacter') or nil

            if not identity then
                identity = 'IDENTITY_NOT_FOUND'
            end

            if not multichar then
                multichar = 'MULTICHAR_NOT_FOUND'
            end

            dbg.playerLoad('AwaitPlayerLoad: Checking server enviroment: \nIdentity: %s \nMultichar: %s', identity,
                multichar)

            if type(ESX.IsPlayerLoaded) == "table" then
                repeat
                    Wait(500)
                    dbg.playerLoad(
                        'AwaitPlayerLoad: Awaiting to player load as active character via method: ESX.IsPlayerLoaded')
                until ESX.IsPlayerLoaded() or EnforcePlayerLoaded
            elseif type(ESX.GetPlayerData) == "table" then
                local playerData = ESX.GetPlayerData()

                repeat
                    Wait(500)
                    dbg.playerLoad(
                        'AwaitPlayerLoad: Awaiting to player load as active character via method: ESX.GetPlayerData')
                until playerData and next(playerData) or EnforcePlayerLoaded
            else
                dbg.playerLoad(
                    'AwaitPlayerLoad: Any of framework related helper functions, not found: loading fallback solution.')
            end

            dbg.playerLoad('AwaitPlayerLoad: Requesting player load, since player is found as active!')

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

        RegisterNetEvent(Config.FrameworkEvents['esx:playerLoaded'])
        AddEventHandler(Config.FrameworkEvents['esx:playerLoaded'], function(data)
            EnforcePlayerLoaded = true
            Framework.setJob({
                name = data.job.name,
                gradeName = data.job.grade_name,
                grade = data.job.grade,
                isOnDuty = false,
                isBoss = data.job.grade_name == "boss"
            })
        end)

        RegisterNetEvent(Config.FrameworkEvents['esx:setJob'])
        AddEventHandler(Config.FrameworkEvents['esx:setJob'], function(job)
            dbg.debug('Framework - job: Updating player job data!')
            Framework.setJob({
                name = job.name,
                gradeName = job.grade_name,
                grade = job.grade,
                isOnDuty = false,
                isBoss = job.grade_name == "boss"
            })
        end)

        SetTimeout(1000, function()
            if not Framework.object then
                return
            end

            local success, result = pcall(function()
                return Framework.object.GetPlayerData and Framework.object.GetPlayerData().job
            end)

            if result and success then
                dbg.debug('Framework - job: Setting player job data on init!')
                Framework.setJob({
                    name = result.name,
                    gradeName = result.grade_name,
                    grade = result.grade,
                    isOnDuty = false,
                    isBoss = result.grade_name == "boss"
                })
            end
        end)

        function Framework.setJob(job)
            Framework.job = job
        end
    end
end, "cl-esx code name: Phoenix")

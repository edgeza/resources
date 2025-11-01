if Config.Framework == "esx" then
    pcall(function() Config.Core = exports["es_extended"]:getSharedObject() end)
    if Config.Core == nil then
        TriggerEvent("esx:getSharedObject", function(obj) Config.Core = obj end)
    end


    --- Displays a framework notification.
    --- @param text string The text to display in the notification.
    --- @param notifType string The type of notification (e.g., "success", "error", "info").
    --- @param length number The length of time the notification should be displayed (in milliseconds).
    function FreamworkNotification(text, notifType, length)
        notifType = notifType or "info"
        length = length or 5000
        Config.Core.ShowNotification(text, notifType, length)
    end

    --- Gets the player's job information.
    --- @return table
    function GetInventory()
        return Config.Core.PlayerData.inventory
    end

    function GetClosestPlayer()
        return Config.Core.Game.GetClosestPlayer()
    end

    function GetVehiclesInArea(pos, maxRadius)
        return Config.Core.Game.GetVehiclesInArea(pos, maxRadius)
    end

    function GetClosestVehicle(coord)
        return Config.Core.Game.GetClosestVehicle(coord)
    end

    function GetPlayersInArea(coord, maxRadius)
        return Config.Core.Game.GetPlayersInArea(coord, maxRadius)
    end

    function GetPlayerBankBalance()
        local money = 0
        local PlayerDatax = Config.Core.GetPlayerData()
        if PlayerDatax and PlayerDatax.accounts then
            for k,v in pairs(PlayerDatax.accounts) do
                if v.name == "bank" then
                    money = v.money
                end
            end
        end
        return money
    end

    function VehicleCreate(model, coords, vehicleData)
        local createCar = CreateVehicle(model, coords.x, coords.y, coords.z, 0.0, true, false)

        SetVehicleOnGroundProperly(createCar)
        Config.Core.Game.SetVehicleProperties(createCar, vehicleData?.vehMods)
        SetFuel(createCar, vehicleData?.vehMods?.fuelLevel or 100)
        GiveKeyCar(createCar)
        SetModelAsNoLongerNeeded(model)
        return createCar
    end

    PlayerData = {}
    Cuffed = false
    local isFirstLoaded = false
    RegisterNetEvent('esx:playerLoaded', function(data)
        Debugprint('esx:playerLoaded')
        PlayerData = data
        if PlayerData ~= nil then
            if PlayerData.job ~= nil then
                JobInfo.job = PlayerData.job.name
                JobInfo.job_grade = PlayerData.job.grade
                JobInfo.job_label = PlayerData.job.label
                JobInfo.job_grade_label = PlayerData.job.grade_label
                JobInfo.onDuty = PlayerData.job?.onDuty or false
                JobUpdate()
            end
        end

        if not isFirstLoaded then
            if Config.AutoOpen then
                ForceLoadPhone()
            end
        end

        isFirstLoaded = true
    end)

    RegisterNetEvent('esx:setJob', function(job)
        Debugprint('esx:setJob')
        if job then
            JobInfo.job = job.name
            JobInfo.job_grade = job.grade
            JobInfo.job_label = job.label
            JobInfo.job_grade_label = job.grade_label
            JobInfo.onDuty = job?.onDuty or false
            JobUpdate()
        end
    end)

    RegisterNetEvent('esx:onPlayerLogout', function()
        Debugprint('esx:onPlayerLogout')
        PlayerData = {}
        JobInfo.job = ""
        JobInfo.job_grade = 0
        JobInfo.job_label = ""
        JobInfo.job_grade_label = ""
        JobInfo.onDuty = false
        isFirstLoaded = false
        TriggerServerEvent("gksphone:server:playerDropped")
    end)

    AddEventHandler('esx:onPlayerDeath', function(data)
        if PhoneOpen == true then
            OpenPhone()
        end
        PhoneOpenBlock = true
        PhoneBlockReason = "You can't use the phone while dead, handcuffed or in last stand."
        if Incall then
            EndPhoneCall()
        end
        if MusicData and MusicData[CurrentPlayerId] then
            TriggerServerEvent('gksphone:server:musicListen', nil, nil, "pause", nil)
        end
    end)

    AddEventHandler("playerSpawned", function()
        PhoneBlockReason = ""
        PhoneOpenBlock = false
    end)

    AddEventHandler("esx:onPlayerSpawn", function ()
        PhoneBlockReason = ""
        PhoneOpenBlock = false
    end)

    RegisterNetEvent('esx_policejob:handcuff', function()
        Cuffed = not Cuffed
        if Cuffed then
            if PhoneOpen == true then
                OpenPhone()
            end
            PhoneOpenBlock = true
            PhoneBlockReason = "You can't use the phone while dead, handcuffed or in last stand."
            if Incall then
                EndPhoneCall()
            end
        else
            PhoneBlockReason = ""
            PhoneOpenBlock = false
        end
    end)

    RegisterNetEvent('esx_policejob:unrestrain', function()
        PhoneBlockReason = ""
        PhoneOpenBlock = false
    end)


    AddEventHandler('onResourceStart', function(resource)
        if resource == GetCurrentResourceName() then
            PlayerData = Config.Core.GetPlayerData()
            if PlayerData ~= nil then
                if PlayerData.job ~= nil then
                    JobInfo.job = PlayerData.job.name
                    JobInfo.job_grade = PlayerData.job.grade
                    JobInfo.job_label = PlayerData.job.label
                    JobInfo.job_grade_label = PlayerData.job.grade_label
                    JobInfo.onDuty = PlayerData.job?.onDuty or false
                    Wait(5000)
                    JobUpdate()
                end
            end
            TriggerServerEvent("gksphone:server:restartphone")
        end
    end)

end
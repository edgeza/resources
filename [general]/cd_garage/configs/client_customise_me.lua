-- ┌──────────────────────────────────────────────────────────────────┐
-- │                            FRAMEWORK                             │
-- └──────────────────────────────────────────────────────────────────┘


ESX, QBCore = nil, nil
JobData, GangData, on_duty = {}, {}, true

CreateThread(function()
    if Config.Framework == 'esx' then
        while ESX == nil do
            pcall(function() ESX = exports[Config.FrameworkTriggers.resource_name]:getSharedObject() end)
            if ESX == nil then
                TriggerEvent(Config.FrameworkTriggers.main, function(obj) ESX = obj end)
            end
            Wait(100)
        end
        JobData = ESX.PlayerData.job or {}
        if JobData.onDuty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onDuty end 

        RegisterNetEvent(Config.FrameworkTriggers.load)
        AddEventHandler(Config.FrameworkTriggers.load, function(xPlayer)
            JobData = xPlayer.job or {}
            if JobData.onDuty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onDuty end 
            if Config.VehicleKeys.ENABLE then
                TriggerServerEvent('cd_garage:LoadCachedkeys')
            end
            if Config.PrivateGarages.ENABLE then
                TriggerServerEvent('cd_garage:LoadPrivateGarages')
            end
            if Config.VehiclesData.ENABLE then
                TriggerServerEvent('cd_garage:PriceData')
            end
            if Config.PersistentVehicles.ENABLE then
                TriggerServerEvent('cd_garage:LoadPersistentVehicles')
            end
        end)

        RegisterNetEvent(Config.FrameworkTriggers.job)
        AddEventHandler(Config.FrameworkTriggers.job, function(job)
            JobData = job or {}
            if JobData.onDuty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onDuty end 
        end)
    

    elseif Config.Framework == 'qbcore' then
        while QBCore == nil do
            TriggerEvent(Config.FrameworkTriggers.main, function(obj) QBCore = obj end)
            if QBCore == nil then
                QBCore = exports[Config.FrameworkTriggers.resource_name]:GetCoreObject()
            end
            Wait(100)
        end
        JobData = QBCore.Functions.GetPlayerData().job or {}
        GangData = QBCore.Functions.GetPlayerData().gang or {}
        if JobData.onduty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onduty end

        RegisterNetEvent(Config.FrameworkTriggers.load)
        AddEventHandler(Config.FrameworkTriggers.load, function()
            JobData = QBCore.Functions.GetPlayerData().job or {}
            GangData = QBCore.Functions.GetPlayerData().gang or {}
            if JobData.onduty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onduty end
            if Config.VehicleKeys.ENABLE then
                TriggerServerEvent('cd_garage:LoadCachedkeys')
            end
            if Config.PrivateGarages.ENABLE then
                TriggerServerEvent('cd_garage:LoadPrivateGarages')
            end
            if Config.VehiclesData.ENABLE then
                TriggerServerEvent('cd_garage:PriceData')
            end
            if Config.PersistentVehicles.ENABLE then
                TriggerServerEvent('cd_garage:LoadPersistentVehicles')
            end
        end)

        RegisterNetEvent(Config.FrameworkTriggers.job)
        AddEventHandler(Config.FrameworkTriggers.job, function(JobInfo)
            JobData = JobInfo or {}
        end)

        RegisterNetEvent(Config.FrameworkTriggers.duty)
        AddEventHandler(Config.FrameworkTriggers.duty, function(boolean)
            if not Config.UseFrameworkDutySystem then return end
            on_duty = boolean
        end)

        RegisterNetEvent(Config.FrameworkTriggers.gang)
        AddEventHandler(Config.FrameworkTriggers.gang, function(GangInfo)
            GangData = GangInfo or {}
            if Config.GangGarages.ENABLE then
                UpdateGangGarageBlips()
            end
        end)

    end
end)

RegisterNetEvent('cd_garage:PlayerLoaded', function()
    if Config.VehicleKeys.ENABLE then
        TriggerServerEvent('cd_garage:LoadCachedkeys')
    end
    if Config.PrivateGarages.ENABLE then
        TriggerServerEvent('cd_garage:LoadPrivateGarages')
    end
    if Config.VehiclesData.ENABLE then
        TriggerServerEvent('cd_garage:PriceData')
    end
    if Config.PersistentVehicles.ENABLE then
        TriggerServerEvent('cd_garage:LoadPersistentVehicles')
    end
end)

function GetJob()
    if Config.Framework == 'esx' then
        while JobData.name == nil do Wait(0) end
        return {name = JobData.name, label = JobData.label}
    
    elseif Config.Framework == 'qbcore' then
        while JobData.name == nil do Wait(0) end
        return {name = JobData.name, label = JobData.label}

    elseif Config.Framework == 'other' then
        return {name = 'unemployed', label = 'Unemployed'} --return a players job name and label (table).
    end
end

function GetJob_grade()
    if Config.Framework == 'esx' then
        while JobData.grade == nil do Wait(0) end
        return JobData.grade
    
    elseif Config.Framework == 'qbcore' then
        while JobData.grade.level == nil do Wait(0) end
        return JobData.grade.level

    elseif Config.Framework == 'other' then
        return 0 --return a players job grade (number).
    end
end

function CheckJob(job)
    if type(job) == 'string' then
        if GetJob().name == job and on_duty then
            return true
        end
    elseif type(job) == 'table' then
        local myjob = GetJob().name
        for c, d in ipairs(job) do
            if myjob == d and on_duty then
                return true
            end
        end
    end
    return false
end

function IsAllowed_Impound()
    if Config.Impound.Authorized_Jobs[GetJob().name] and on_duty then
        return true
    else
        return false
    end
end

function GetGang()
    if Config.Framework == 'esx' then
        return {name = 'unemployed', label = 'Unemployed'} --return a players gang name and label (table).
    
    elseif Config.Framework == 'qbcore' then
        while GangData.name == nil do Wait(0) end
        return {name = GangData.name, label = GangData.label}

    elseif Config.Framework == 'other' then
        return {name = 'unemployed', label = 'Unemployed'} --return a players gang name and label (table).
    end
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           CHAT COMMANDS                          │
-- └──────────────────────────────────────────────────────────────────┘

if Config.GarageSpace.ENABLE then
    TriggerEvent('chat:addSuggestion', '/'..Config.GarageSpace.chat_command_main, L('chatsuggestion_garagespace'), {{ name=L('chatsuggestion_playerid_1'), help=L('chatsuggestion_playerid_2')}})
    TriggerEvent('chat:addSuggestion', '/'..Config.GarageSpace.chat_command_check, L('chatsuggestion_garagespace_check'))
end

TriggerEvent('chat:addSuggestion', '/closeui', L('chatsuggestion_ui'))
RegisterCommand('closeui', function()
    CloseAllNUI()
end, false)


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                        VEHICLE RELATED                           │
-- └──────────────────────────────────────────────────────────────────┘

function VehicleSpawned(vehicle, plate, props, job_vehicle) --This will be triggered when you spawn a vehicle.
    GiveVehicleKeys(plate, vehicle)
    AddPersistentVehicle(vehicle, plate, job_vehicle)
    --Add your own code here if needed.
end

function VehicleStored(vehicle, plate, props) --This will be triggered just before a vehicle is stored.
    --Add your own code here if needed.
end


-- ┌──────────────────────────────────────────────────────────────────┐
-- │                              OTHER                               │
-- └──────────────────────────────────────────────────────────────────┘


for c, d in pairs (Config.Locations) do
    if d.Type ~= nil then
        if CheckBlips(d.EnableBlip, d.JobRestricted) then
            local blip = AddBlipForCoord(d.x_1, d.y_1, d.z_1)
            SetBlipSprite(blip, Config.Blip[d.Type].sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.Blip[d.Type].scale)
            SetBlipColour(blip, Config.Blip[d.Type].colour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            if Config.Unique_Blips and not d.JobRestricted then
                AddTextComponentSubstringPlayerName(Config.Blip[d.Type].name:sub(1, -2)..': '..d.Garage_ID)
            elseif d.JobRestricted then
                AddTextComponentSubstringPlayerName(Config.Blip[d.Type].name:sub(1, -2)..': '..d.Garage_ID..' ['..JobRestrictNotif(d.JobRestricted, true)..']')
            else
                AddTextComponentSubstringPlayerName(Config.Blip[d.Type].name:sub(1, -2))
            end
            EndTextCommandSetBlipName(blip)
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        local ped = PlayerPedId()
        --ClearPedTasks(ped)
        --ClearPedTasksImmediately(ped)
        DrawTextUI('hide')
        if MyCars ~= nil then
            for cd=1, #MyCars do
                if MyCars[cd] ~= nil then
                    SetEntityAsNoLongerNeeded(MyCars[cd].vehicle)
                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
                    DeleteEntity(MyCars[cd].vehicle)
                    DeleteVehicle(MyCars[cd].vehicle)
                end
            end
        end
        if GaragePeds and #GaragePeds > 0 then
            for _, cd in pairs(GaragePeds) do
                if DoesEntityExist(cd.ped) then
                    SetEntityAsNoLongerNeeded(cd.ped)
                    DeleteEntity(cd.ped)
                end
            end
        end
        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(false)
        if shell and Config.InsideGarage.ENABLE then
            DeleteGarage()
        end
    end
end)

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                               DEBUG                              │
-- └──────────────────────────────────────────────────────────────────┘


if Config.Debug then
    local function Debug()
        print('^6-----------------------^0')
        print('^1CODESIGN DEBUG^0')
        print(string.format('^6Resource Name:^0 %s', GetCurrentResourceName()))
        print(string.format('^6Framework:^0 %s', Config.Framework))
        print(string.format('^6Database:^0 %s', Config.Database))
        print(string.format('^6Config.AutoInsertSQL:^0 %s', Config.AutoInsertSQL))
        print(string.format('^6Language:^0 %s', Config.Language))
        if Config.Framework == 'esx' or Config.Framework == 'qbcore' or Config.Framework == 'other' then
            while JobData.name == nil do Wait(0) end
            print(string.format('^6Job Name:^0 %s', GetJob().name))
            print(string.format('^6Job Label:^0 %s', GetJob().label))
            print(string.format('^6Job Grade:^0 %s', GetJob_grade()))
        end
        if Config.Framework == 'qbcore' then
            while GangData.name == nil do Wait(0) end
            print(string.format('^6Gang Name:^0 %s', GetGang().name))
            print(string.format('^6Gang Label:^0 %s', GetGang().label))
        end
        print(string.format('^6Use Framework Duty System:^0 %s', Config.UseFrameworkDutySystem))
        print(string.format('^6On Duty:^0 %s', on_duty))
        print(string.format('^6Is Allowed Impound:^0 %s', IsAllowed_Impound()))
        print(string.format('^6Notification:^0 %s', Config.Notification))
        print(string.format('^6Garage Interact Method:^0 %s', Config.GarageInteractMethod))
        print(string.format('^6Vehicle Keys Resource:^0 %s', Config.VehicleKeysResource))
        print(string.format('^6Vehicle Fuel Resource:^0 %s', Config.VehicleFuelResource))
        print(string.format('^6Vehicle Plate Formats.format:^0 %s', Config.VehiclePlateFormats.format))
        print(string.format('^6Vehicle Plate Formats.new_plate_format:^0 %s', Config.VehiclePlateFormats.new_plate_format))
        print('^6-----------------------^0')
    end

    CreateThread(function()
        Wait(3000)
        Debug()
    end)

    RegisterCommand('debug_garage', function()
        TriggerServerEvent('cd_garage:Debug')
        Debug()
    end, false)
end
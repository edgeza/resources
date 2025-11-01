local jobName = ""
local TaskList = {}
local ThiefDetails = {}
local blip = nil
local localtionCheck = true

RegisterNetEvent("gksphone:client:JobStartTask", function (jobInfoName, Tasks)
    if jobInfoName == "carthief" then
        jobName = jobInfoName
        TaskList = Tasks
    end
end)

RegisterNetEvent("gksphone:client:jobStartMember", function (Details)
    if Details and Details.jobName == "carthief" then
        ThiefDetails = Details
        local model = GetHashKey(ThiefDetails.carModel)
        TaskList[1].TaskText = (TaskList[1].TaskText):format(ThiefDetails.carModel)
        exports["gksphone"]:TaskListUpdate(TaskList)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
        blip = AddBlipForRadius(ThiefDetails.carlocation.x, ThiefDetails.carlocation.y, ThiefDetails.carlocation.z,  75.0)
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 128)
        local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(ThiefDetails.carlocation.x + math.random(-50, 50), ThiefDetails.carlocation.y + math.random(-50, 50), ThiefDetails.carlocation.z, 0, 3, 0)
        SetNewWaypoint(spawnPos.x, spawnPos.y)


        while not NetworkDoesEntityExistWithNetworkId(ThiefDetails.carNetworkID) do
            if not localtionCheck then
                if blip then
                    RemoveBlip(blip)
                    blip = nil
                    ThiefDetails = {}
                    localtionCheck = true
                end
                break
            end
            Citizen.Wait(300)
        end

        local car = NetworkGetEntityFromNetworkId(Details.carNetworkID)
        SetFuel(car, 100)
        local ped = PlayerPedId()

        while not IsPedInVehicle(ped, car, false) do
            Wait(200)
            local taskStatus = exports["gksphone"]:IsTaskStatus(1)
            if taskStatus then
                break
            end
            if IsPedInVehicle(ped, car, false) then
                exports["gksphone"]:TaskUpdate(1, true, 0)
                break
            end

            if not localtionCheck then
                if blip then
                    RemoveBlip(blip)
                    blip = nil
                    ThiefDetails = {}
                    localtionCheck = true
                end
                break
            end
        end
    end
end)

RegisterNetEvent("gksphone:client:JobNextTask", function (NewTaskID)
    if jobName == "carthief" then
        if NewTaskID == 2 then
            if blip then
                RemoveBlip(blip)
            end
            blip = AddBlipForCoord(ThiefDetails.deliveryLocation.x, ThiefDetails.deliveryLocation.y, ThiefDetails.deliveryLocation.z)
            SetBlipHighDetail(blip, true)
            SetBlipColour(blip, 1)
            SetBlipAlpha (blip, 128)
            SetNewWaypoint(ThiefDetails.deliveryLocation.x, ThiefDetails.deliveryLocation.y)

            local car = NetworkGetEntityFromNetworkId(ThiefDetails.carNetworkID)
            while true do
                Wait(0)
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local dist = #(pos - vector3(ThiefDetails.deliveryLocation.x, ThiefDetails.deliveryLocation.y, ThiefDetails.deliveryLocation.z))
                if dist < 10.0 then
                    if IsVehicleSeatFree(car, -1) then
                        exports["gksphone"]:TaskUpdate(NewTaskID, true, 0)
                        if blip then
                            RemoveBlip(blip)
                        end
                        TriggerServerEvent("gksphone:server:thiefCarDelivery", ThiefDetails.groupID)
                        break
                    end
                end
                if not localtionCheck then
                    if blip then
                        RemoveBlip(blip)
                    end
                    break
                end
            end
        end
    end
end)

RegisterNetEvent("gksphone:client:memberKick", function (jobname)
    if jobname == "carthief" then
        localtionCheck = false
    end
end)

RegisterNetEvent("gksphone:client:garbageDisband", function (jobname)
    if jobname == "carthief" then
        localtionCheck = false
    end
end)
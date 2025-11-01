local chopshopCarList = {
    "blista",
    "brioso",
    "dilettante",
    "issi2",
    "panto",
    "prairie",
    "rhapsody",
    "sanchez",
    "sanchez2",
    "scrap",
    "seminole",
    "taco",
    "tornado",
    "tornado2",
    "tornado3",
    "tornado4",
    "tornado5",
    "tornado6",
    "voodoo",
    "washington",
}

local randomSpawnLocation = {
    vector3(-978.65, 516.37, 81.47),
    vector3(-1044.08, 499.82, 84.08),
    vector3(-595.12, 753.29, 183.72),
    vector3(-1178.76, 455.99, 86.67),
    vector3(-1271.01, 497.79, 97.25),
    vector3(-1099.44, 555.68, 102.72),
    vector3(-846.13, 514.71, 90.62),
    vector3(-888.82, 366.32, 85.03),
    vector3(-868.51, 319.02, 83.98),
}

local deliveryLocations = {
    vector3(-2027.41, -484.4, 11.69),
    vector3(1368.05, -2080.62, 52.0),
    vector3(1007.18, -1868.92, 30.89),
    vector3(846.2, -2180.42, 30.3),
    vector3(287.97, -1922.04, 26.23)
}

local thiefGroupList = {}

RegisterNetEvent("gksphone:server:jobStartLeader", function (source, jobName, groupID, groupMembers)
    if jobName == "carthief" then
        local src = source
        local randomCar = chopshopCarList[math.random(1, #chopshopCarList)]
        local randomLocation = randomSpawnLocation[math.random(1, #randomSpawnLocation)]
        local car = CreateVehicle(randomCar, randomLocation.x, randomLocation.y, randomLocation.z, 1.80, true, true)
        while not DoesEntityExist(car) do
            Wait(25)
        end

        if DoesEntityExist(car) then
            local deriveryLocation = deliveryLocations[math.random(1, #deliveryLocations)]
            thiefGroupList[groupID] = {
                ["car"] = car,
                ["carModel"] = randomCar,
                ["carNetworkID"] = NetworkGetNetworkIdFromEntity(car),
                ["groupID"] = groupID,
                ["carlocation"] = randomLocation,
                ["deliveryLocation"] = deriveryLocation,
                ["jobName"] = jobName
            }

            Wait(1000)
            SetVehicleDoorsLocked(car, 1)
            for k, v in pairs(groupMembers) do
                TriggerClientEvent("gksphone:client:jobStartMember", v.source, thiefGroupList[groupID])
            end
        end
    end
end)

RegisterNetEvent("gksphone:server:thiefCarDelivery", function (groupID)
    if thiefGroupList[groupID] then
        local jobName = thiefGroupList[groupID].jobName
        local jobData = GKSJobs.Jobs[jobName]
        local src = source
        local xPlayer = GetIdentifier(src)
        if xPlayer and jobData then
            local GroupData = exports["gksphone"]:GetGroupByMember(xPlayer)
            if GroupData then
                for k, v in pairs(GroupData.GroupMembers) do
                    local groupMember = GetIdentifier(v.source)
                    if groupMember then
                        local money = jobData.Money
                        AddBankMoney(src, money)
                        local phoneData = exports["gksphone"]:GetPhoneDataByCitizenID(xPlayer)
                        if phoneData then
                            local NotifData = {
                                title = _T(phoneData.phone_lang, "JobCenter.APP_JOBCENTER_TITLE"),
                                message = _T(phoneData.phone_lang, "JobCenter.APP_JOBCENTER_NOTIFY_JOBSUCESS_REWARD", {reward = money}),
                                icon    = '/html/img/icons/jobcenter.png',
                            }
                            exports["gksphone"]:sendNotification(v.source, NotifData)
                        end
                        exports["gksphone"]:BankSaveHistory(v.source, 2, money, "Job earnings")
                    end
                end
            end
            if DoesEntityExist(thiefGroupList[groupID].car) then
                DeleteEntity(thiefGroupList[groupID].car)
            end
            exports["gksphone"]:DeleteJobGroup(jobName, groupID)
            thiefGroupList[groupID] = nil
        end
    end
end)

RegisterNetEvent("gksphone:server:groupDisband", function (groupData)
    local groupID = groupData.Groupid
    if groupData.GroupName == "carthief" then
        if thiefGroupList[groupID] then
            for k, v in pairs(groupData.GroupMembers) do
                TriggerClientEvent("gksphone:client:garbageDisband", v.source, groupData.GroupName)
            end
            if DoesEntityExist(thiefGroupList[groupID].car) then
                DeleteEntity(thiefGroupList[groupID].car)
            end
            thiefGroupList[groupID] = nil
        end
    end
end)
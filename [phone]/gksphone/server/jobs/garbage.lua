local garbageJobList = {}
local JobCoords = {
    vector3(97.76, -1461.74, 29.34),
    vector3(163.5, -1823.23, 38.56),
    vector3(377.88, -1836.57, 40.57),
    vector3(255.12, -952.08, 34.25),
    vector3(331.95, -1051.44, 40.64),
    vector3(423.65, -954.33, 34.81),
    vector3(-1295.43, -1193.73, 16.74),
    vector3(-1189.9, -1431.42, 25.29),
    vector3(-1101.86, -1558.33, 29.08),
    vector3(-1007.18, -1125.35, 20.52),
    vector3(-1061.04, -1029.51, 21.77),
    vector3(-5.05, -195.7, 76.11),
    vector3(14.81, -71.64, 71.05),
    vector3(326.89, -209.22, 68.36),
    vector3(320.56, 257.05, 149.7)
}

RegisterNetEvent("gksphone:server:jobStartLeader", function (source, jobName, groupID, groupMembers)
    if jobName == "sanitation" then

        local car = CreateVehicle("trash", -324.54, -1528.15, 27.54, 0.68, true, true)
        while not DoesEntityExist(car) do
            Wait(25)
        end

        if DoesEntityExist(car) then
            garbageJobList[groupID] = {
                ["car"] = car,
                ["carNetworkID"] = NetworkGetNetworkIdFromEntity(car),
                ["groupID"] = groupID,
                ["carlocation"] = vector3(-324.54, -1528.15, 27.54),
                ["garbageLocations"] = JobCoords[math.random(1, #JobCoords)],
                ["jobName"] = jobName
            }
            SetVehicleNumberPlateText(car, "GARB"..tostring(math.random(1000, 9999)))
            Wait(1000)
            SetVehicleDoorsLocked(car, 1)

            for k, v in pairs(groupMembers) do
                TriggerClientEvent("gksphone:client:jobStartMember", v.source, garbageJobList[groupID])
            end
        end
    end
end)

RegisterNetEvent("gksphone:server:garbageNewLocation", function (groupID)
    if garbageJobList[groupID] then
        local src = source
        local xPlayer = GetIdentifier(src)
        if xPlayer then
            local GroupData = exports["gksphone"]:GetJobGroupByLeader(xPlayer)
            if GroupData then
                garbageJobList[groupID].garbageLocations = JobCoords[math.random(1, #JobCoords)]
                for k, v in pairs(GroupData.GroupMembers) do
                    TriggerClientEvent("gksphone:client:garbageGotoNewLocation", v.source, garbageJobList[groupID])
                end
            end
        end
    end
end)


RegisterNetEvent("gksphone:server:garbageReturnVehicle", function (groupID)
    if garbageJobList[groupID] then
        local jobName = garbageJobList[groupID].jobName
        local jobData = GKSJobs.Jobs[jobName]
        local src = source
        local xPlayer = GetIdentifier(src)
        if xPlayer then
            local GroupData = exports["gksphone"]:GetGroupByMember(xPlayer)
            if GroupData then
                for k, v in pairs(GroupData.GroupMembers) do
                    local groupMember = GetPhoneDataByCitizenID(v.cid)
                    if groupMember and jobData and groupMember.source then
                        local money = jobData.Money
                        AddBankMoney(groupMember.source, money)
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
            if DoesEntityExist(garbageJobList[groupID].car) then
                DeleteEntity(garbageJobList[groupID].car)
            end
            exports["gksphone"]:DeleteJobGroup(jobName, groupID)
            garbageJobList[groupID] = nil
        end
    end
end)

RegisterNetEvent("gksphone:server:groupDisband", function (groupData)
    local groupID = groupData.Groupid
    if groupData.GroupName == "sanitation" then
        if garbageJobList[groupID] then
            for k, v in pairs(groupData.GroupMembers) do
                TriggerClientEvent("gksphone:client:garbageDisband", v.source, groupData.GroupName)
            end
            if DoesEntityExist(garbageJobList[groupID].car) then
                DeleteEntity(garbageJobList[groupID].car)
            end
            garbageJobList[groupID] = nil
        end
    end
end)
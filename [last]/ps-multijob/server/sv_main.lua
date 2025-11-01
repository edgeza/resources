local QBCore = exports['qb-core']:GetCoreObject()

local function GetJobs(citizenid)
    local p = promise.new()
    MySQL.Async.fetchAll("SELECT jobdata FROM multijobs WHERE citizenid = @citizenid",{
        ["@citizenid"] = citizenid
    }, function(jobs)
        print("DEBUG GetJobs: Raw database result for " .. citizenid .. ": " .. json.encode(jobs))
        
        if jobs[1] and jobs[1].jobdata ~= "[]" and jobs[1].jobdata ~= nil and jobs[1].jobdata ~= "{}" then
            jobs = json.decode(jobs[1].jobdata)
            print("DEBUG GetJobs: Decoded jobs from database: " .. json.encode(jobs))
        else
            print("DEBUG GetJobs: No jobs found in database, creating from current job")
            local Player = QBCore.Functions.GetOfflinePlayerByCitizenId(citizenid)
            if Player then
                local temp = {}
                print("DEBUG GetJobs: Player current job: " .. Player.PlayerData.job.name .. " grade: " .. Player.PlayerData.job.grade.level)
                if not Config.IgnoredJobs[Player.PlayerData.job.name] then
                    temp[Player.PlayerData.job.name] = Player.PlayerData.job.grade.level
                    MySQL.insert('INSERT INTO multijobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
                        citizenid = citizenid,
                        jobdata = json.encode(temp),
                    })
                    print("DEBUG GetJobs: Created new job entry: " .. json.encode(temp))
                else
                    print("DEBUG GetJobs: Current job is ignored: " .. Player.PlayerData.job.name)
                    -- Add unemployed as a fallback job if current job is ignored
                    temp["unemployed"] = 0
                    MySQL.insert('INSERT INTO multijobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
                        citizenid = citizenid,
                        jobdata = json.encode(temp),
                    })
                    print("DEBUG GetJobs: Added unemployed as fallback: " .. json.encode(temp))
                end
                jobs = temp
            else
                print("DEBUG GetJobs: Player not found!")
                jobs = {}
            end
        end
        p:resolve(jobs)
    end)
    return Citizen.Await(p)
end
exports("GetJobs", GetJobs)
    
local function AddJob(citizenid, job, grade)
    local jobs = GetJobs(citizenid)
    for ignored in pairs(Config.IgnoredJobs) do
        if jobs[ignored] then
            jobs[ignored] = nil
        end
    end

    jobs[job] = grade
    MySQL.insert('INSERT INTO multijobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
        citizenid = citizenid,
        jobdata = json.encode(jobs),
    })
end
exports("AddJob", AddJob)

local function UpdatePlayerJob(Player, job, grade)
    if Player.PlayerData.source ~= nil then
        Player.Functions.SetJob(job,grade)
    else -- player is offline
        local sharedJobData = QBCore.Shared.Jobs[job]
        if sharedJobData == nil then return end

        -- QBX compatibility: try both string and number grade keys
        local sharedGradeData = sharedJobData.grades[tostring(grade)] or sharedJobData.grades[grade]
        if sharedGradeData == nil then return end

        local isBoss = false
        if sharedGradeData.isboss then isBoss = true end

        MySQL.update.await("update players set job = @jobData where citizenid = @citizenid", {
            jobData = json.encode({
                label = sharedJobData.label,
                name = job,
                isboss = isBoss,
                onduty = sharedJobData.defaultDuty,
                payment = sharedGradeData.payment,
                grade = {
                    name = sharedGradeData.name,
                    level = grade,
                },
            }),
            citizenid = Player.PlayerData.citizenid
        })
    end
end

local function UpdateJobRank(citizenid, job, grade)
    local Player = QBCore.Functions.GetOfflinePlayerByCitizenId(citizenid)
    if Player == nil then
        return
    end

    local jobs = GetJobs(citizenid)
    if jobs[job] == nil then
        return
    end
    
    jobs[job] = grade
    
    MySQL.update.await("update multijobs set jobdata = :jobdata where citizenid = :citizenid", {
        citizenid = citizenid,
        jobdata = json.encode(jobs),
    })
    
    -- if the current job matches, then update
    if Player.PlayerData.job.name == job then
        UpdatePlayerJob(Player, job, grade)
    end
end
exports("UpdateJobRank", UpdateJobRank)

local function RemoveJob(citizenid, job)
    local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)

    if Player == nil then
        Player = QBCore.Functions.GetOfflinePlayerByCitizenId(citizenid)
    end

    if Player == nil then return end

    local jobs = GetJobs(citizenid)
    jobs[job] = nil

    -- Since we removed a job, put player in a new job
    local foundNewJob = false
    if Player.PlayerData.job.name == job then
        for k,v in pairs(jobs) do
            UpdatePlayerJob(Player, k,v)
            foundNewJob = true
            break
        end
    end

    if not foundNewJob then
        UpdatePlayerJob(Player, "unemployed", 0)
    end

    MySQL.insert('INSERT INTO multijobs (citizenid, jobdata) VALUES (:citizenid, :jobdata) ON DUPLICATE KEY UPDATE jobdata = :jobdata', {
        citizenid = citizenid,
        jobdata = json.encode(jobs),
    })
end
exports("RemoveJob", RemoveJob)

QBCore.Commands.Add('removejob', 'Remove Multi Job (Admin Only)', { { name = 'id', help = 'ID of player' }, { name = 'job', help = 'Job Name' } }, false, function(source, args)
    local source = source
    if source ~= 0 then
        if args[1] then
            local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if Player then
                if args[2] then
                    RemoveJob(Player.PlayerData.citizenid, args[2])
                else
                    TriggerClientEvent("QBCore:Notify", source, "Wrong usage!")
                end
            else
                TriggerClientEvent("QBCore:Notify", source, "Wrong usage!")
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Wrong usage!")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Wrong usage!")
    end
end, 'admin')

QBCore.Commands.Add('addjob', 'Add Multi Job (Admin Only)', { { name = 'id', help = 'ID of player' }, { name = 'job', help = 'Job Name' }, { name = 'grade', help = 'Job Grade' } }, false, function(source, args)
    local source = source
    if source ~= 0 then
        if args[1] then
            local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if Player then
                if args[2]and args[3] then
                    AddJob(Player.PlayerData.citizenid, args[2], args[3])
                else
                    TriggerClientEvent("QBCore:Notify", source, "Wrong usage!")
                end
            else
                TriggerClientEvent("QBCore:Notify", source, "Wrong usage!")
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Wrong usage!")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Wrong usage!")
    end
end, 'admin')

QBCore.Functions.CreateCallback("ps-multijob:getJobs", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local jobs = GetJobs(Player.PlayerData.citizenid)
    local multijobs = {}
    local whitelistedjobs = {}
    local civjobs = {}
    local active = {}
    local getjobs = {}
    local Players = QBCore.Functions.GetPlayers()
    
    -- Debug: Print player info and jobs
    print("DEBUG: Player " .. Player.PlayerData.citizenid .. " requesting jobs")
    print("DEBUG: Raw jobs data: " .. json.encode(jobs))

    for i = 1, #Players, 1 do
        local xPlayer = QBCore.Functions.GetPlayer(Players[i])
        active[xPlayer.PlayerData.job.name] = 0
        if active[xPlayer.PlayerData.job.name] and xPlayer.PlayerData.job.onduty then
            active[xPlayer.PlayerData.job.name] = active[xPlayer.PlayerData.job.name] + 1
        end
    end

    for job, grade in pairs(jobs) do
        -- Skip ignored jobs (like police, bcso, ambulance) from being displayed in the menu
        if not Config.IgnoredJobs[job] then
            if QBCore.Shared.Jobs[job] == nil then
                print("The job '" .. job .. "' has been removed and is not present in your QBCore jobs. Remove it from the multijob SQL or add it back to your qbcore jobs.lua.")
            else
                -- Check if the grade exists in the job configuration (QBX uses numbers, QBCore uses strings)
                local gradeData = QBCore.Shared.Jobs[job].grades[tostring(grade)] or QBCore.Shared.Jobs[job].grades[grade]
                if gradeData == nil then
                    print("The grade '" .. grade .. "' for job '" .. job .. "' no longer exists in QBX job configuration. Skipping this job entry.")
                    -- Remove the invalid job entry from the database
                    jobs[job] = nil
                    MySQL.update.await("update multijobs set jobdata = :jobdata where citizenid = :citizenid", {
                        citizenid = Player.PlayerData.citizenid,
                        jobdata = json.encode(jobs),
                    })
                else
                    local online = active[job] or 0
                    getjobs = {
                        name = job,
                        grade = grade,
                        description = Config.Descriptions[job],
                        icon = Config.FontAwesomeIcons[job],
                        label = QBCore.Shared.Jobs[job].label,
                        gradeLabel = gradeData.name,
                        salary = gradeData.payment,
                        active = online,
                    }
                    if Config.WhitelistJobs[job] then
                        whitelistedjobs[#whitelistedjobs+1] = getjobs
                    else
                        civjobs[#civjobs+1] = getjobs
                    end
                end
            end
        end
    end

    multijobs = {
        whitelist = whitelistedjobs,
        civilian = civjobs,
    }
    
    -- Debug: Print final result
    print("DEBUG: Final multijobs result: " .. json.encode(multijobs))
    print("DEBUG: Whitelist jobs count: " .. #whitelistedjobs)
    print("DEBUG: Civilian jobs count: " .. #civjobs)
    
    cb(multijobs)
end)

RegisterNetEvent("ps-multijob:changeJob",function(cjob, cgrade)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)

    if cjob == "unemployed" and cgrade == 0 then
        Player.Functions.SetJob(cjob, cgrade)
        return
    end

    -- Prevent switching to ignored jobs (like police, bcso, ambulance)
    if Config.IgnoredJobs[cjob] then
        return
    end

    local jobs = GetJobs(Player.PlayerData.citizenid)
    for job, grade in pairs(jobs) do
        if cjob == job and cgrade == grade then
            Player.Functions.SetJob(job, grade)
        end
    end
end)

RegisterNetEvent("ps-multijob:removeJob",function(job, grade)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    
    -- Prevent removing ignored jobs (like police, bcso, ambulance) through the menu
    if Config.IgnoredJobs[job] then
        return
    end
    
    RemoveJob(Player.PlayerData.citizenid, job)
end)

-- QBCORE EVENTS

RegisterNetEvent('ps-multijob:server:removeJob', function(targetCitizenId)
    MySQL.Async.execute('DELETE FROM multijobs WHERE citizenid = ?', { targetCitizenId }, function(affectedRows)
        if affectedRows > 0 then
            print('Removed job: ' .. targetCitizenId)
        else
            print('Cannot remove job: ' .. targetCitizenId)
        end
    end)
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate', function(source, newJob)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local jobs = GetJobs(Player.PlayerData.citizenid)
    local amount = 0
    local setjob = newJob
    for k,v in pairs(jobs) do
        amount = amount + 1
    end

    local maxJobs = Config.MaxJobs
    if QBCore.Functions.HasPermission(source, "admin") then
        maxJobs = math.huge
    end

    if amount < maxJobs and not Config.IgnoredJobs[setjob.name] then
        local foundOldJob = jobs[setjob.name]
        if not foundOldJob or foundOldJob ~= setjob.grade.level then
            AddJob(Player.PlayerData.citizenid, setjob.name, setjob.grade.level)
        end
    end
end)

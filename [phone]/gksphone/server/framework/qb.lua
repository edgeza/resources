if Config.Framework == "qb" or Config.Framework == "qbx" then
    print("[GKSPHONE] " .. Config.Framework.. " Loading")
    Config.Core = exports['qb-core']:GetCoreObject()
    if Config.Core == nil then
        TriggerEvent("QBCore:GetObject", function(obj) Config.Core = obj end)
    end

    Config.GarageDBColumn = "garage" -- Set column name of garage name in owned_vehicles or player_vehicles database (esx: parking / qb: garage)
    Config.GarageDefaultName = "pillboxgarage" -- Set the default garage name (default: pillboxgarage)
    Config.GarageStored = "state = 1"  --Vehicle garage status

    function GetIdentifier(source)
        return Config.Core.Functions.GetPlayer(source)?.PlayerData?.citizenid
    end

    function GetPlayerFromIdentifier(identifier)
        return Config.Core.Functions.GetPlayerByCitizenId(identifier)
    end

    function GetCharacterName(source)
        local xPlayer = Config.Core.Functions.GetPlayer(source)
        local name = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
        return name
    end

    function GetCharacterBirthDate(source)
        local xPlayer = Config.Core.Functions.GetPlayer(source)
        local date = xPlayer.PlayerData.charinfo.birthdate
        return date
    end

    function GetCharacterAllVehicles(identifier, appname)
        local ret = {}
        if appname == "valet" then
            ret = MySQL.query.await("SELECT * FROM `player_vehicles` WHERE `citizenid`=@citizenid", {["@citizenid"] = identifier})
        elseif appname == "carseller" then
            ret = MySQL.query.await("SELECT * FROM `player_vehicles` WHERE `citizenid`=@citizenid", {["@citizenid"] = identifier})
        end
        local vehicles = {}
        if ret then
            for i = 1, #ret do
                local vehicle = ret[i]
                local vehData = {
                    plate = vehicle.plate,
                    hash = tonumber(vehicle.hash),
                    model = vehicle.vehicle,
                    fuel = vehicle.fuel,
                    engine = math.floor(vehicle.engine),
                    body = math.floor(vehicle.body),
                    garage = vehicle.garage and vehicle.garage:gsub("^%l", string.upper) or "Unknown",
                    carseller = vehicle.carseller or 0
                }
                local vehicleData = Config.Core.Shared.Vehicles[vehicle.vehicle]
                if vehicleData then
                    vehData.name = vehicleData.name 
                    vehData.type = vehicleData.category:gsub("^%l", string.upper) or "Car"
                else
                    Debugprint("Vehicle not found in qb-core/shared/vehicles.lua: " .. vehicle.vehicle)
                    vehData.name = string.upper(vehicle.vehicle) or "Unknown"
                    vehData.type = "Car"
                end
                if GetResourceState("qb-garages") == "started"  then
                    if vehicle.state == 2 then
                        vehData.garage = "Impounded"
                    elseif vehicle.state == 0 then
                        vehData.garage = "Out"
                    end
                elseif GetResourceState("cd_garage") == "started" or GetResourceState("jg-advancedgarages") == "started" then
                    vehData.garage = vehicle.garage_id
                    if not vehicle.in_garage then
                        vehData.garage = "On The Street"
                    end
                    if vehicle.impound ~= 0 then
                        vehData.garage = "Impounded"
                    end
                elseif GetResourceState("loaf_garage") == "started" then
                    if vehicle.state == 0 then
                        vehData.garage = "On The Street"
                    elseif vehicle.state == 2 then
                        vehData.garage = "Impounded"
                    end
                end

                vehicles[#vehicles + 1] = vehData
            end
        end
        return vehicles
    end

    function GetVehicle(identifier, plate)
        local ret = MySQL.single.await('SELECT * FROM `player_vehicles` WHERE citizenid = ? AND plate = ? LIMIT 1', {
            identifier, plate
        })
        if ret then
            if Config.ImpoundVale then
                if GetResourceState("cd_garage") == "started" or GetResourceState("jg-advancedgarages") == "started" then
                    if ret.impound ~= 0 then
                        Debugprint("gksphone:server:vale:vehiclebring | Vehicle is impounded | CitizenID: " .. identifier .. " | Plate: " .. plate)
                        return "carimpounded"
                    elseif not ret.in_garage then
                        Debugprint("gksphone:server:vale:vehiclebring | Vehicle is not in garage | CitizenID: " .. identifier .. " | Plate: " .. plate)
                        return "carnotingarage"
                    end
                elseif GetResourceState("loaf_garage") == "started" then
                    if ret.stored == 2 then
                        Debugprint("gksphone:server:vale:vehiclebring | Vehicle is impounded | CitizenID: " .. identifier .. " | Plate: " .. plate)
                        return "carimpounded"
                    elseif ret.stored == 0 then
                        Debugprint("gksphone:server:vale:vehiclebring | Vehicle is not in garage | CitizenID: " .. identifier .. " | Plate: " .. plate)
                        return "carnotingarage"
                    end
                elseif GetResourceState("qb-garages") == "started" then
                    if ret.state == 2 then
                        Debugprint("gksphone:server:vale:vehiclebring | Vehicle is impounded | CitizenID: " .. identifier .. " | Plate: " .. plate)
                        return "carimpounded"
                    elseif ret.state == 0 then
                        Debugprint("gksphone:server:vale:vehiclebring | Vehicle is not in garage | CitizenID: " .. identifier .. " | Plate: " .. plate)
                        return "carnotingarage"
                    end
                end
            end
            local vehData = {
                plate = ret.plate,
                hash = tonumber(ret.hash),
                model = ret.vehicle,
                fuel = ret.fuel,
                carseller = ret.carseller or 0,
                vehMods = json.decode(ret.mods)
            }
            return vehData
        end
        return nil
    end

    function VehicleUpdate(plate, app, data)
        if GetResourceState("loaf_garage") == "started" then
            MySQL.Async.execute('UPDATE player_vehicles SET `state` = @state WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@state'] = 0,
            })
        elseif GetResourceState("cd_garage") == "started" or GetResourceState("jg-advancedgarages") == "started" then
            MySQL.Async.execute('UPDATE player_vehicles SET  `in_garage` = @in_garage WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@in_garage'] = 0,
            })
        elseif GetResourceState("qb-garages") == "started" then
            MySQL.Async.execute('UPDATE player_vehicles SET  `state` = @state WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@state'] = 0,
            })
        end
    end

    function VehicleUpdateCarseller(plate, data, source, identifier)
        if data == 1 or data == 0 then
            MySQL.Async.execute('UPDATE player_vehicles SET `carseller` = @carseller WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@carseller'] = data
            })
        else
            local license = Config.Core.Functions.GetIdentifier(source, 'license')
            local query = string.format(
                "UPDATE player_vehicles SET carseller = @carseller, citizenid = @citizenid, license = @license, %s = @garage, %s WHERE plate = @plate",
                Config.GarageDBColumn, Config.GarageStored
            )
            MySQL.Async.execute(query, {
                ['@citizenid'] = identifier,
                ['@license'] = license,
                ['@plate'] = plate,
                ['@carseller'] = 0,
                ['@garage'] = Config.GarageDefaultName
            })
        end
    end

    function GetCharacterJob(source)
        local xPlayer = Config.Core.Functions.GetPlayer(source) or Config.Core.Functions.GetPlayerByCitizenId(source)
        if xPlayer then
            local jobData = {
                source = xPlayer.PlayerData.source,
                identifier = xPlayer.PlayerData.citizenid,
                name = xPlayer.PlayerData.job.name,
                label = xPlayer.PlayerData.job.label,
                grade = xPlayer.PlayerData.job.grade.level,
                grade_salary = xPlayer.PlayerData.job.payment,
                grade_label = xPlayer.PlayerData.job.grade.name,
                grade_name = xPlayer.PlayerData.job.grade.name,
            }
            return jobData
        end
        return nil
    end

    function GetJobs()
        return Config.Core.Shared.Jobs
    end

    function GetAllEmployees(job)
        local query =
        [[SELECT
            JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')) AS firstname,
            JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')) AS lastname,
            JSON_UNQUOTE(JSON_EXTRACT(u.job, '$.payment')) AS payment,
            JSON_UNQUOTE(JSON_EXTRACT(u.job, '$.grade.name')) AS gradeLabel,
            JSON_UNQUOTE(JSON_EXTRACT(u.job, '$.grade.level')) AS job_grade,
            u.citizenid AS `identifier`
        FROM players u
        WHERE JSON_UNQUOTE(JSON_EXTRACT(u.job, '$.name')) = ?]]
        local result = MySQL.Sync.fetchAll(query, { job })
        return result
    end

    function SetJob(identifier, job, grade)
        if Config.Framework == "qbx" then
            local setjob = exports["qbx_core"]:SetJob(identifier, job, grade)
            return setjob
        else
            local xPlayer = Config.Core.Functions.GetPlayerByCitizenId(identifier) or Config.Core.Functions.GetOfflinePlayerByCitizenId(identifier)
            if xPlayer then
                if xPlayer.Functions.SetJob(job, grade) then
                    xPlayer.Functions.Save()
                    return true
                end
            end
        end
        return false
    end

    function ToggleDuty(source, toggle)
        local xPlayer = Config.Core.Functions.GetPlayer(source)
        if xPlayer then
            xPlayer.Functions.SetJobDuty(toggle)
        end
    end

    function GetBankBalance(source)
        local xPlayer = Config.Core.Functions.GetPlayer(source)
        return xPlayer?.PlayerData?.money?.bank or 0
    end

    function GetBankBalanceByIndetifier(identifier)
        local bank = 0
        local xPlayer = GetPlayerFromIdentifier(identifier)
        if xPlayer then
            bank = xPlayer?.PlayerData?.money?.bank or 0
            return bank
        else
            xPlayer = GetOfflinePlayerByIdentifier(identifier)
            if xPlayer then
                bank = xPlayer?.PlayerData?.money?.bank or 0
                return bank
            end
        end
        return bank
    end

    function RemoveBankMoney(source, amount, type)
        if type == "identifier" then
            local xPlayer = GetPlayerFromIdentifier(source)
            if not xPlayer or amount < 0 or GetBankBalanceByIndetifier(source) < amount then
                return false
            end
            xPlayer.Functions.RemoveMoney('bank', amount, 'gksphone')
            return true
        else
            local xPlayer = Config.Core.Functions.GetPlayer(source)
            if not xPlayer or amount < 0 or GetBankBalance(source) < amount then
                return false
            end
            xPlayer.Functions.RemoveMoney('bank', amount, 'gksphone')
            return true
        end
    end

    function AddBankMoney(source, amount, type)
        if type == "identifier" then
            local xPlayer = GetPlayerFromIdentifier(source)
            if not xPlayer or amount < 0 then
                return false
            end
            xPlayer.Functions.AddMoney('bank', amount, "Bank Transfer")
            return true
        end
        local xPlayer = Config.Core.Functions.GetPlayer(source)
        if not xPlayer or amount < 0 then
            return false
        end
        xPlayer.Functions.AddMoney('bank', amount, "Bank Transfer")
        return true
    end

    function GetExtendedPlayers(key, val)
        local xPlayers = {}
        local players = Config.Core.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if key then
                if (key == 'job' and v.PlayerData.job.name == val) then
                    xPlayers[#xPlayers + 1] = {
                        source = v.PlayerData.source,
                        job = {
                            name = v.PlayerData.job.name,
                            grade = v.PlayerData.job.grade.level
                        }
                    }
                end
            end
        end
        return xPlayers
    end

    function RegisterUsableItem(item, cb)
        Config.Core.Functions.CreateUseableItem(item, cb)
    end

    function RemoveItem(source, itemname, amount)
        local Player = Config.Core.Functions.GetPlayer(source)
        if Player then
            Player.Functions.RemoveItem(itemname, amount)
        end
    end

    function FreamworkSavePhoneNumber(phoneNumber, source)
        local src = source
        local Player = Config.Core.Functions.GetPlayer(src)
        if Player and phoneNumber then
            Player.PlayerData.charinfo.phone = phoneNumber
            Player.Functions.SetPlayerData('charinfo', Player.PlayerData.charinfo)
        end
    end

    function FreamworkGetPhoneNumberBySource(source)
        local src = source
        local Player = Config.Core.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.charinfo.phone
        end
        return nil
    end

    --- HasPhoneItem ---
    --- Check if the player has a phone item in their inventory.

    function HasPhoneItem(source)
        local src = source
        local Player = Config.Core.Functions.GetPlayer(src)
        local itemData = {}
        if Player then
            for k, _ in pairs(Config.ItemName) do
                local itemCheck = Player.Functions.GetItemsByName(k)
                if itemCheck and #itemCheck > 0 then
                    itemData = itemCheck
                    break
                end
            end
            if #itemData > 0 then
                return itemData
            end
        end
        return itemData
    end

    ---- IsDead Inlaststand ---

    function CallingPlayerStatus(source)
        local retval = false
        local Player = Config.Core.Functions.GetPlayer(source)
        if Player and (Player.PlayerData.metadata["ishandcuffed"] or Player.PlayerData.metadata["isdead"] or Player.PlayerData.metadata["inlaststand"]) then
            retval = true
        end
        return retval
    end

    --- Get Player Licenses ---

    function GetPlayerLicense(source)
        local Player = Config.Core.Functions.GetPlayer(source)
        if Player then
            return Player.PlayerData?.metadata["licences"] or {}
        end
        return {}
    end

    --- Society Money ----

    function SocietyGetMoney(jobname)
        local BusinessMoney = 0
        if GetResourceState("qb-banking") == "started" then
            BusinessMoney = exports['qb-banking']:GetAccount(jobname)?.account_balance or 0
        elseif GetResourceState("Renewed-Banking") == "started" then
            BusinessMoney = exports['Renewed-Banking']:getAccountMoney(jobname) or 0
        end
        return BusinessMoney
    end

    function SocietyRemoveMoney(job, amount)
        local process = false
        if GetResourceState("qb-banking") == "started" then
            local jobPrice = SocietyGetMoney(job)
            if jobPrice >= amount then
                if exports['qb-banking']:RemoveMoney(job, amount) then
                    process = true
                end
            end
        elseif GetResourceState("Renewed-Banking") == "started" then
            local jobPrice = SocietyGetMoney(job)
            if jobPrice >= amount then
                if exports['Renewed-Banking']:removeAccountMoney(job, amount) then
                    process = true
                end
            end
        end
        return process
    end

    function SocietyAddMoney(job, amount)
        local process = false
        if GetResourceState("qb-banking") == "started" then
            if exports['qb-banking']:AddMoney(job, amount) then
                process = true
            end
        elseif GetResourceState("Renewed-Banking") == "started" then
            if exports['Renewed-Banking']:addAccountMoney(job, amount) then
                process = true
            end
        end
        return process
    end

    --- Auto Open Close Dispatch ---

    if Config.IsServicesAutoOpenClose then
        local playerJobs = {}
        local jobCounts = {}

        local function UpdateJobStatus(jobName, isJoining)
            if not jobName then return end
            for jobKey, jobData in pairs(Config.JOBServices) do
                if Config.ServicesAutoIgnoredJobs[jobKey] == false then
                    local shouldUpdate = false
                    
                    if jobKey == jobName then
                        if isJoining and jobCounts[jobName] == 1 and jobData.isOpen == false then
                            shouldUpdate = true
                        elseif not isJoining and jobCounts[jobName] == 0 and jobData.isOpen == true then
                            shouldUpdate = true
                        end
                    elseif jobData.alternativejobs then
                        for altJobName, altJobEnabled in pairs(jobData.alternativejobs) do
                            if altJobName == jobName then
                                if isJoining and jobCounts[jobName] == 1 and jobData.isOpen == false then
                                    shouldUpdate = true
                                elseif not isJoining and jobCounts[jobName] == 0 and jobData.isOpen == true then
                                    shouldUpdate = true
                                end
                                break
                            end
                        end
                    end
                    
                    if shouldUpdate then
                        exports["gksphone"]:JobStatusChange(jobKey, isJoining)
                    end
                end
            end
        end

        CreateThread(function()
            for _, player in pairs(Config.Core.Functions.GetQBPlayers()) do
                local playerData = player.PlayerData
                local jobName = playerData.job.name
        
                playerJobs[playerData.source] = jobName
        
                jobCounts[jobName] = (jobCounts[jobName] or 0) + 1
                if jobCounts[jobName] == 1 then
                    UpdateJobStatus(jobName, true)
                end
            end
        end)

        AddEventHandler("playerDropped", function(reason)
            local playerId = source
            if not playerJobs[playerId] then
                return
            end
            
            local jobName = playerJobs[playerId]
            playerJobs[playerId] = nil
            jobCounts[jobName] = (jobCounts[jobName] or 1) - 1
            
            UpdateJobStatus(jobName, false)
        end)

        AddEventHandler("QBCore:Server:OnPlayerUnload", function(source)
            local playerId = source
            if not playerJobs[playerId] then
                return
            end
            
            local jobName = playerJobs[playerId]
            playerJobs[playerId] = nil
            jobCounts[jobName] = (jobCounts[jobName] or 1) - 1
            
            UpdateJobStatus(jobName, false)
        end)
        
        AddEventHandler('QBCore:Server:OnJobUpdate', function(source, newJob)
            local newJobName = newJob.name
            local oldJobName = playerJobs[source]
            if oldJobName == newJobName then return end
            if not oldJobName then return end
            
            playerJobs[source] = newJobName
            jobCounts[newJobName] = (jobCounts[newJobName] or 0) + 1
            jobCounts[oldJobName] = (jobCounts[oldJobName] or 1) - 1
            
            UpdateJobStatus(oldJobName, false)
            
            UpdateJobStatus(newJobName, true)
        end)

        AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)        
            if not Player then return end

            local src = Player.PlayerData.source
            local jobName = Player.PlayerData.job.name
            
            if not jobName then
                return
            end
        
            playerJobs[src] = jobName
            jobCounts[jobName] = (jobCounts[jobName] or 0) + 1
            
            UpdateJobStatus(jobName, true)
        end)
    end

    --- Offline Player Data ---

    function GetOfflinePlayerByIdentifier(identifier)
        local self = {}
        local result = MySQL.Sync.fetchAll('SELECT * FROM players where citizenid = @identifier', {
            ['@identifier'] = identifier
        })
        if result[1] ~= nil then
            self = result[1]
            self.PlayerData = {}
            self.PlayerData.money = json.decode(self.money)
            self.PlayerData.job = json.decode(self.job)
            self.PlayerData.gang = json.decode(self.gang)
            self.PlayerData.position = json.decode(self.position)
            self.PlayerData.metadata = json.decode(self.metadata)
            self.PlayerData.charinfo = json.decode(self.charinfo)

            function self.getAccount(account)
                local xPlayer = GetPlayerFromIdentifier(self.citizenid)
                if xPlayer then
                    return xPlayer.PlayerData.money[account] or 0
                elseif self.PlayerData.money[account] then
                    return self.PlayerData.money[account] or 0
                end
                return nil
            end

            function self.removeAccountMoney(account, amount, reason)
                local xPlayer = GetPlayerFromIdentifier(self.citizenid)
                if xPlayer then
                    xPlayer.Functions.RemoveMoney(account, amount, reason)
                elseif self.PlayerData.money[account] then
                    self.PlayerData.money[account] = self.PlayerData.money[account] - amount
                    MySQL.update("UPDATE players SET money = ? WHERE citizenid = ?", {
                        json.encode(self.PlayerData.money),
                        self.citizenid
                    })
                end
            end

            function self.addAccountMoney(account, amount, reason)
                local xPlayer = GetPlayerFromIdentifier(self.citizenid)
                if xPlayer then
                    xPlayer.Functions.AddMoney(account, amount, reason)
                elseif self.PlayerData.money[account] then
                    self.PlayerData.money[account] = self.PlayerData.money[account] + amount
                    MySQL.update("UPDATE players SET money = ? WHERE citizenid = ?", {
                        json.encode(self.PlayerData.money),
                        self.citizenid
                    })
                end
            end

            function self.getName()
                local charinfo = self.PlayerData.charinfo
                return charinfo.firstname .. ' ' .. charinfo.lastname
            end

            return self
        end
        return nil
    end

    --- Delete Character ---
    if Config.deleteCharacter then
        RegisterNetEvent("qb-multicharacter:server:deleteCharacter", function(citizenid)
            DeleteCharacter(citizenid)
        end)
    end

    -- QB PHONE MAIL --

    RegisterNetEvent('qb-phone:server:sendNewMail', function(mailData)
        local src = source
        if mailData.button then
            if mailData.button.enabled then
                mailData.button.buttonname = "Ok"
            else
                mailData.button = nil
            end
        end
        mailData.image = "/html/img/icons/mail.png"
        exports["gksphone"]:SendNewMail(src, mailData)
    end)
    
    RegisterNetEvent('qb-phone:server:sendNewMailToOffline', function(cid, mailData)
        if mailData.button then
            if mailData.button.enabled then
                mailData.button.buttonname = "Ok"
            else
                mailData.button = nil
            end
        end
        mailData.image = "/html/img/icons/mail.png"
        exports["gksphone"]:SendNewMailOffline(cid, mailData)
    end)

    Config.Core.Commands.Add(Config.TwitterVerifyCommand, 'Twitter None/Blue/Yellow Tick Approval',
        { { name = "auth", help = "none/blue/yellow" }, { name = "AccountName", help = "Squawk Account Name" } }, true,
        function(source, args)
            local src = source
            if args[1] then
                local isverified = 0
                local label = ""
                local first = true
                local auth = args[1]
                table.remove(args, 1)
                for i = 1, #args, 1 do
                    if first then
                        first = false
                        label = label .. '' .. args[i]
                    else
                        label = label .. ' ' .. args[i]
                    end
                end
                if auth == 'blue' then
                    isverified = 1
                elseif auth == 'yellow' then
                    isverified = 2
                end

                local verifed = exports["gksphone"]:ToggleVerified('squawk', label, isverified)
                if verifed then
                    FreamworkNotify(src, "Transaction successful", 'success')
                else
                    FreamworkNotify(src, 'You did not write the required information', 'error')
                end
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
        end, 'god')

    Config.Core.Commands.Add(Config.TwitterSendBanCommand, 'Twitter Accout Suspend',
        { { name = "auth", help = "true/false" }, { name = "AccountName", help = "Squawk Account Name" } }, true,
        function(source, args)
            local src = source
            if args[1] then
                local label = ""
                local first = true
                local auth = args[1]
                table.remove(args, 1)
                for i = 1, #args, 1 do
                    if first then
                        first = false
                        label = label .. '' .. args[i]
                    else
                        label = label .. ' ' .. args[i]
                    end
                end
                if auth == "true" then
                    MySQL.Async.execute("UPDATE `gksphone_twt_users` SET `banned`= 1 WHERE username = @username", {
                        ['@username'] = tostring(label)
                    }, function(result)
                        if (result == 1) then
                            TwitterBannedUser(true, tostring(label))
                            FreamworkNotify(src, 'User banned', 'success')
                        else
                            FreamworkNotify(src, 'You did not write the required information', 'error')
                        end
                    end)
                else
                    MySQL.Async.execute("UPDATE `gksphone_twt_users` SET `banned`= 0 WHERE username = @username", {
                        ['@username'] = tostring(label)
                    }, function(result)
                        if (result == 1) then
                            TwitterBannedUser(false, tostring(label))
                            FreamworkNotify(src, 'User ban lifted', 'success')
                        else
                            FreamworkNotify(src, 'You did not write the required information', 'error')
                        end
                    end)
                end
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
        end, 'god')

    Config.Core.Commands.Add(Config.TwitterSendBlockCommand, 'Turn off/on Message Sending',
        { { name = "auth", help = "true/false" } }, true, function(source, args)
            local src = source
            if args[1] then
                local label = ""
                local first = true
                local auth = args[1]
                if auth == "true" then
                    TwitterMessageBlock = true
                    FreamworkNotify(src, 'Message Sending is turned off', 'success')
                else
                    TwitterMessageBlock = false
                    FreamworkNotify(src, 'Message Sending is turned on', 'success')
                end
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
        end, 'god')

    Config.Core.Commands.Add('snapgramverify', 'Snapgram None/Blue Tick Approval',
        { { name = "auth", help = "none/blue" }, { name = "AccountName", help = "Snapgram Account Name" } }, true,
        function(source, args)
            local src = source
            if args[1] then
                local isverified = 0
                local label = ""
                local first = true
                local auth = args[1]
                table.remove(args, 1)
                for i = 1, #args, 1 do
                    if first then
                        first = false
                        label = label .. '' .. args[i]
                    else
                        label = label .. ' ' .. args[i]
                    end
                end
                if auth == 'blue' then
                    isverified = 1
                end

                local verifed = exports["gksphone"]:ToggleVerified('snapgram', label, isverified)
                if verifed then
                    FreamworkNotify(src, "Transaction successful", 'success')
                else
                    FreamworkNotify(src, 'You did not write the required information', 'error')
                end
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
    end, 'god')

    if Config.UseSIMPackage then
        Config.Core.Commands.Add("phonenewnumber", 'Create a new phone number',
            { { name = "Source", help = "Player Source" }, { name = "Number", help = "Phone Number" } }, true,
            function(source, args)
                local src = source
                if args[1] and args[2] then
                    local newNumber = exports["gksphone"]:NewNumber(tonumber(args[1]), nil, args[2])
                    if newNumber then
                        FreamworkNotify(src, 'New phone number created', 'success')
                    else
                        FreamworkNotify(src, 'You did not write the required information', 'error')
                    end
                else
                    FreamworkNotify(src, 'You did not write the required information', 'error')
                end
        end, 'god')
    end

    Config.Core.Commands.Add("phonechangenumber", 'Change phone number',
        { { name = "PhoneID", help = "Phone Serial Number" }, { name = "OldNumber", help = "Old Phone Number" }, { name = "NewNumber", help = "New Phone Number" } },
        true, function(source, args)
            local src = source
            if args[1] and args[2] and args[3] then
                local changeNumber = exports["gksphone"]:ChangeNumber(args[1], args[2], args[3])
                if changeNumber then
                    FreamworkNotify(src, 'Phone number changed', 'success')
                else
                    FreamworkNotify(src, 'You did not write the required information', 'error')
                end
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
        end, 'god')

    Config.Core.Commands.Add("adminauth", 'Admin Authentication', { { name = "auth", help = "true/false" } }, true,
        function(source, args)
            local src = source
            local AdminAuth = false
            if args[1] then
                local auth = args[1]
                if auth == "true" then
                    AdminAuth = true
                    TriggerClientEvent('gksphone:client:adminAuth', src, AdminAuth)
                    FreamworkNotify(src, 'Admin Authentication is turned on', 'success')
                else
                    TriggerClientEvent('gksphone:client:adminAuth', src, AdminAuth)
                    FreamworkNotify(src, 'Admin Authentication is turned off', 'success')
                end
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
        end, 'god')

    Config.Core.Commands.Add("chargephone", 'Change phone charge percentage', { { name = "source", help = "Player Source" }, { name = "charge", help = "number" } }, true,
        function(source, args)
            local src = source
            local charge = tonumber(args[2])
            local playerSource = tonumber(args[1])
            if charge and playerSource then
                if charge >= 0 and charge <= 100 then
                    TriggerClientEvent('gksphone:client:chargePhone', playerSource, charge)
                else
                    FreamworkNotify(src, 'Charge must be between 0 and 100', 'error')
                end
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
    end, 'god')



    local response = MySQL.single.await("SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'player_vehicles' AND COLUMN_NAME = 'carseller';")
    if response then
        if response["COUNT(*)"] == 0 then
            MySQL.rawExecute.await("ALTER TABLE `player_vehicles` ADD COLUMN `carseller` INT(11) NULL DEFAULT '0';")
        end
    end

    print('^2[GKSPHONE] ' .. Config.Framework.. ' Loaded!^7')
end

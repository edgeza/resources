if Config.Framework == "esx" then
    print("[GKSPHONE] ESX Loading")
    Config.Core = nil
    pcall(function() Config.Core = exports["es_extended"]:getSharedObject() end)
    if Config.Core == nil then
        TriggerEvent("esx:getSharedObject", function(obj) Config.Core = obj end)
    end

    Config.GarageDBColumn = "parking" -- Set column name of garage name in owned_vehicles or player_vehicles database (esx: parking / qb: garage)
    Config.GarageDefaultName = "SanAndreasAvenue" -- Set the default garage name (default: SanAndreasAvenue)
    Config.GarageStored = "stored = 1"  --Vehicle garage status


    function GetIdentifier(source)
        return Config.Core.GetPlayerFromId(source)?.identifier
    end

    function GetPlayerFromIdentifier(identifier)
        return Config.Core.GetPlayerFromIdentifier(identifier)
    end

    function GetCharacterName(source)
        local xPlayer = Config.Core.GetPlayerFromId(source)
        local name
    
        if xPlayer.get and xPlayer.get("firstName") and xPlayer.get("lastName") then
            name = xPlayer.getName()
        else
            local retval = MySQL.Sync.fetchAll("SELECT `firstname`, `lastname` FROM `users` WHERE `identifier`=@identifier", {["@identifier"] = GetIdentifier(source)})
    
            local firstName = retval[1]?.firstname or "Unknown"
            local lastName = retval[1]?.lastname or "Unknown"
            name = firstName .. " " .. lastName
        end
    
        return name
    end

    function GetCharacterBirthDate(source)
        local xPlayer = Config.Core.GetPlayerFromId(source)
        local date = "01/01/1970"
    
        if xPlayer.get and xPlayer.get("dateofbirth") then
            date = xPlayer.get("dateofbirth")
        end
    
        return date
    end

    function GetCharacterAllVehicles(identifier, appname)
        local ret = {}
        if appname == "valet" then
            ret = MySQL.query.await("SELECT * FROM `owned_vehicles` WHERE `owner`= @owner", {["@owner"] = identifier})
        elseif appname == "carseller" then
            ret = MySQL.query.await("SELECT * FROM `owned_vehicles` WHERE `owner`= @owner", {["@owner"] = identifier})
        end
        local vehicles = {}
        for i = 1, #ret do
            local vehicle = ret[i]
            local vehMods = json.decode(vehicle.vehicle)
            local vehData = {
                plate = vehicle.plate,
                hash = tonumber(vehMods.model),
                model = tonumber(vehMods.model),
                fuel = vehMods?.fuelLevel or 100,
                engine = math.floor(vehMods?.engineHealth or 1000.0 / 10 + 0.5),
                body = math.floor(vehMods?.bodyHealth or 1000.0 / 10 + 0.5),
                garage = "Unknown",
                type = vehicle.type and vehicle.type:gsub("^%l", string.upper) or "Car",
                carseller = vehicle.carseller or 0
            }

            if GetResourceState("esx_garage") == "started" then
                if vehicle.stored == 1 then
                    vehData.garage = vehicle.parking or "Garage"
                elseif vehicle.stored == 2 then
                    vehData.garage = vehicle.pound or "Impound"
                else
                    vehData.garage = "Outside"
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
        return vehicles
    end

    function GetVehicle(identifier, plate)
        local ret = MySQL.single.await('SELECT * FROM `owned_vehicles` WHERE owner = ? AND plate = ? LIMIT 1', {
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
                elseif GetResourceState("esx_garage") == "started" then
                    if ret.stored == 2 then
                        Debugprint("gksphone:server:vale:vehiclebring | Vehicle is impounded | CitizenID: " .. identifier .. " | Plate: " .. plate)
                        return "carimpounded"
                    elseif ret.state == 0 then
                        Debugprint("gksphone:server:vale:vehiclebring | Vehicle is not in garage | CitizenID: " .. identifier .. " | Plate: " .. plate)
                        return "carnotingarage"
                    end
                end
            end
            local vehMods = json.decode(ret.vehicle)
            local vehData = {
                plate = ret.plate,
                hash = vehMods?.model,
                model = vehMods?.model,
                fuel = vehMods?.fuelLevel or 100,
                carseller = ret.carseller or 0,
                vehMods = vehMods
            }
            return vehData
        end
        return nil
    end

    function VehicleUpdate(plate)
        if GetResourceState("loaf_garage") == "started" then
            MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored, `parking` = @parking WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@stored'] = 0,
                ['@parking'] = nil
            })
        elseif GetResourceState("cd_garage") == "started" or GetResourceState("jg-advancedgarages") == "started" then
            MySQL.Async.execute('UPDATE owned_vehicles SET  `in_garage` = @in_garage WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@in_garage'] = 0,
            })
        elseif GetResourceState("esx_garage") == "started"  then
            MySQL.Async.execute('UPDATE owned_vehicles SET  `stored` = @stored WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@stored'] = 0,
            })
        end
    end

    function VehicleUpdateCarseller(plate, data, source, identifier)
        if data == 1 or data == 0 then
            MySQL.Async.execute('UPDATE owned_vehicles SET `carseller` = @carseller WHERE `plate` = @plate', {
                ['@plate'] = plate,
                ['@carseller'] = data
            })
        else
            local query = string.format('UPDATE owned_vehicles SET `carseller` = @carseller, `owner` = @owner, %s = @garage, %s WHERE `plate` = @plate', Config.GarageDBColumn, Config.GarageStored)
            MySQL.Async.execute(query, {
                ['@owner'] = identifier,
                ['@plate'] = plate,
                ['@carseller'] = 0,
                ['@garage'] = Config.GarageDefaultName
            })
        end
    end

    function GetCharacterJob(source)
        local xPlayer = Config.Core.GetPlayerFromId(source) or Config.Core.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            local jobData = {
                source = xPlayer.source,
                identifier = xPlayer.identifier,
                name = xPlayer.job.name,
                label = xPlayer.job.label,
                grade = xPlayer.job.grade,
                grade_salary = xPlayer.job.grade_salary,
                grade_label = xPlayer.job.grade_label,
                grade_name = xPlayer.job.grade_name,
            }
            return jobData
        end
        return nil
    end

    function GetJobs()
        return Config.Core.GetJobs() or {}
    end

    function GetAllEmployees(job)
        local query =
        [[SELECT 
            users.identifier,
            users.firstname,
            users.lastname,
            users.job_grade,
            job_grades.label AS gradeLabel,
            job_grades.salary AS payment
        FROM users
        LEFT JOIN job_grades ON users.job_grade = job_grades.grade
        WHERE users.job = ? AND job_grades.job_name = ? ORDER BY users.job_grade DESC]]
        local result = MySQL.Sync.fetchAll(query, {job, job})
        return result
    end

    function SetJob(identifier, job, grade)
        local xPlayer = Config.Core.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            if Config.Core.DoesJobExist(job, grade) then
                xPlayer.setJob(job, grade)
                return true
            end
        else
            if Config.Core.DoesJobExist(job, grade) then
                MySQL.update('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', {job, grade, identifier},
                function()
                    cb()
                end)
                return true
            end
        end
        return false
    end

    function ToggleDuty(source, toggle)
        local xPlayer = Config.Core.GetPlayerFromId(source)
        if xPlayer then
            local job = xPlayer.job
            xPlayer.setJob(job.name, job.grade, toggle)
        end
    end

    function GetBankBalance(source)
        local xPlayer = Config.Core.GetPlayerFromId(source)
        return xPlayer?.getAccount("bank")?.money or 0
    end

    function GetBankBalanceByIndetifier(identifier)
        local bank = 0
        local xPlayer = GetPlayerFromIdentifier(identifier)
        if xPlayer then
            bank = xPlayer.getAccount("bank").money
            return bank
        else
            xPlayer = GetOfflinePlayerByIdentifier(identifier)
            if xPlayer then
                bank = xPlayer.getAccount("bank").money
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
            xPlayer.removeAccountMoney("bank", amount)
            return true
        end
        local xPlayer = Config.Core.GetPlayerFromId(source)
        if not xPlayer or amount < 0 or GetBankBalance(source) < amount then
            return false
        end
        xPlayer.removeAccountMoney("bank", amount)
        return true
    end

    function AddBankMoney(source, amount, type)
        if type == "identifier" then
            local xPlayer = GetPlayerFromIdentifier(source)
            if not xPlayer or amount < 0 then
                return false
            end
            xPlayer.addAccountMoney("bank", amount)
            return true
        end
        local xPlayer = Config.Core.GetPlayerFromId(source)
        if not xPlayer or amount < 0 then
            return false
        end
        xPlayer.addAccountMoney("bank", amount)
        return true
    end

    function GetExtendedPlayers(key, val)
        local xPlayers = {}
        if Config.Core.GetExtendedPlayers then
            local getAllJobPlayers = Config.Core.GetExtendedPlayers("job", val)
            for _, v in pairs(getAllJobPlayers) do
                xPlayers[#xPlayers + 1] = {
                    source = v.source,
                    job = {
                        name = v.job.name,
                        grade = v.job.grade
                    }
                }
            end
        else
            local getPlayers = Config.Core.GetPlayers()
            for _, source in pairs(getPlayers) do
                local playerData = Config.Core.GetPlayerFromId(source)
                if playerData and playerData.job.name == val then
                    xPlayers[#xPlayers + 1] = {
                        source = source,
                        job = {
                            name = playerData.job.name,
                            grade = playerData.job.grade
                        }
                    }
                end
            end
        end
        return xPlayers
    end

    function RegisterUsableItem(item, cb)
        Config.Core.RegisterUsableItem(item, cb)
    end

    function RemoveItem(source, itemname, amount)
        local Player = Config.Core.GetPlayerFromId(source)
        if Player then
            Player.removeInventoryItem(itemname, amount)
        end
    end

    function FreamworkSavePhoneNumber(phoneNumber, source)
        local Player = Config.Core.GetPlayerFromId(source)
        if Player and phoneNumber then
            if Player.metadata then
                Player.setMeta("phoneNumber", phoneNumber)
            else
                MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", {
                    ['@myPhoneNumber'] = phoneNumber,
                    ['@identifier'] = Player.identifier
                })
            end
        end
    end

    function FreamworkGetPhoneNumberBySource(source)
        local Player = Config.Core.GetPlayerFromId(source)
        if Player then
            if Player.metadata then
                return Player.getMeta("phoneNumber")
            else
                local row = MySQL.single.await('SELECT `phone_number` FROM `users` WHERE `identifier` = ? LIMIT 1', {
                    Player.identifier
                })
            if not row then return end
                return row.phone_number
            end
        end
    end

    --- HasPhoneItem ---
    --- Check if the player has a phone item in their inventory.

    function HasPhoneItem(source)
        local src = source
        local Player = Config.Core.GetPlayerFromId(src)
        local itemData = {}
        if Player then
            for k, _ in pairs(Config.ItemName) do
                local item = Player.getInventoryItem(k)
                if item and item.count > 0 then
                itemData[#itemData+1] = item
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
        local src = source
        if GetResourceState("wasabi_ambulance") == 'started' and src then
            local Player = Player(src)
            if Player then
            local isDead = Player.state.dead
            if isDead then
                retval = true
            end
            end
        elseif GetResourceState("esx_ambulancejob") == 'started' and src then
            local Player = Player(src)
            if Player then
            local isDead = Player.state.isDead
            if isDead then
                retval = true
            end
            end
        end
        return retval
    end

    --- Get Player Licenses ---

    function GetPlayerLicense(source)
        if GetResourceState("esx_license") == 'started' then
            local data = {}
            TriggerEvent('esx_license:getLicenses', source, function(licenses)
                for _, value in ipairs(licenses) do
                    if value and value.label then
                        data[value.label] = true
                    end
                end
            end)
            return data
        else
            return {}
        end
    end

    --- Society Money ----

    function SocietyGetMoney(jobname)
        local BusinessMoney = 0
        TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..jobname, function(account)
            BusinessMoney = account.money
        end)
        return BusinessMoney
    end
    
    function SocietyRemoveMoney(job, amount)
        local process = false
        TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..job, function(account)
            local societyMoney = account.money
            if societyMoney > tonumber(amount) then
                account.removeMoney(tonumber(amount))
                process = true
            end
        end)
        return process
    end
    
    function SocietyAddMoney(job, amount)
        local process = false
        TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..job, function(account)
            account.addMoney(tonumber(amount))
            process = true
        end)
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
                    
                    -- Ana iş kontrolü
                    if jobKey == jobName then
                        if isJoining and jobCounts[jobName] == 1 and jobData.isOpen == false then
                            shouldUpdate = true
                        elseif not isJoining and jobCounts[jobName] == 0 and jobData.isOpen == true then
                            shouldUpdate = true
                        end
                    -- Alternatif iş kontrolü
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
                    
                    -- Durum güncellemesi gerekiyorsa
                    if shouldUpdate then
                        exports["gksphone"]:JobStatusChange(jobKey, isJoining)
                    end
                end
            end
        end

        CreateThread(function()
            local Players = Config.Core.GetExtendedPlayers and Config.Core.GetExtendedPlayers() or Config.Core.GetPlayers()
            for _, player in pairs(Players) do
                if Config.Core.GetExtendedPlayers and player.job then
                    local jobName = player.job.name
                    local src = player.source
                    playerJobs[src] = jobName
                    jobCounts[jobName] = (jobCounts[jobName] or 0) + 1
                    if jobCounts[jobName] == 1 then
                        UpdateJobStatus(jobName, true)
                    end
                elseif not Config.Core.GetExtendedPlayers then
                    local xPlayer = Config.Core.GetPlayerFromId(player)
                    if xPlayer then
                        local jobName = xPlayer.job.name
                        playerJobs[player] = jobName
                        jobCounts[jobName] = (jobCounts[jobName] or 0) + 1
                        if jobCounts[jobName] == 1 then
                            UpdateJobStatus(jobName, true)
                        end
                    end
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

        AddEventHandler("esx:playerLoaded", function(_, xPlayer)
            if not xPlayer then return end

            local src = xPlayer.source
            local jobName = xPlayer.getJob() and xPlayer.getJob().name
            
            if not jobName then
                return
            end
        
            playerJobs[src] = jobName
            jobCounts[jobName] = (jobCounts[jobName] or 0) + 1
            
            UpdateJobStatus(jobName, true)
        end)

        AddEventHandler("esx:setJob", function(source, job, lastJob)
            Wait(500)
    
            local newJobName = job.name
            local oldJobName = playerJobs[source]
            
            if not oldJobName then return end
            
            playerJobs[source] = newJobName
            jobCounts[newJobName] = (jobCounts[newJobName] or 0) + 1
            jobCounts[oldJobName] = (jobCounts[oldJobName] or 1) - 1
            
            UpdateJobStatus(oldJobName, false)
            
            UpdateJobStatus(newJobName, true)
        end)

        AddEventHandler("esx:playerLogout", function(source)
            local playerId = source
            if not playerJobs[playerId] then
                return
            end
            
            local jobName = playerJobs[playerId]
            playerJobs[playerId] = nil
            jobCounts[jobName] = (jobCounts[jobName] or 1) - 1
            
            UpdateJobStatus(jobName, false)
        end)
    end

    --- Offline Player Data ---

    function GetOfflinePlayerByIdentifier(identifier)
        local self = {}
        local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
        })
        if result[1] ~= nil then
        self = result[1]
        self.accounts = json.decode(self.accounts)
    
        function self.getAccount(account)
            local xPlayer = Config.Core.GetPlayerFromIdentifier(self.identifier)
            if xPlayer then
                return xPlayer.getAccount(account)
            elseif self.accounts[account] then
                return {money = self.accounts[account]}
            end
            return nil
        end
    
        function self.removeAccountMoney(account, amount, reason)
            local xPlayer = Config.Core.GetPlayerFromIdentifier(self.identifier)
            if xPlayer then
                xPlayer.removeAccountMoney(account, amount, reason)
            elseif self.accounts[account] then
                self.accounts[account] = self.accounts[account] - amount
                MySQL.update("UPDATE users SET accounts = ? WHERE identifier = ?", {
                    json.encode(self.accounts),
                    self.identifier
                })
            end
        end
    
        function self.addAccountMoney(account, amount, reason)
            local xPlayer = Config.Core.GetPlayerFromIdentifier(self.identifier)
            if xPlayer then
                xPlayer.addAccountMoney(account, amount, reason)
            elseif self.accounts[account] then
                self.accounts[account] = self.accounts[account] + amount
                MySQL.update("UPDATE users SET accounts = ? WHERE identifier = ?", {
                    json.encode(self.accounts),
                    self.identifier
                })
            end
        end
    
        function self.getName()
            return self.firstname .. ' ' .. self.lastname
        end
    
        return self
        end
        return nil
    end

    --- Delete Character ---
    if Config.deleteCharacter then
        local function GetIdentifier(source)
        local PRIMARY_IDENTIFIER = Config.Core.GetConfig().Identifier or "license"
    
        local identifier = GetPlayerIdentifierByType(source, PRIMARY_IDENTIFIER)
        return identifier and identifier:gsub(PRIMARY_IDENTIFIER .. ":", "")
        end
    
        RegisterNetEvent("esx_multicharacter:DeleteCharacter", function (charid)
            local src = source
            local PREFIX = "char"
            local identifier = ("%s%s:%s"):format(PREFIX, charid, GetIdentifier(src))
            DeleteCharacter(identifier)
        end)
    end

    Config.Core.RegisterCommand(Config.TwitterVerifyCommand, 'admin', function(xPlayer, args)
        local src = xPlayer.source
        if args then
            local label = args.AccountName
            local auth = args.auth
            local isverified = 0
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
    end, false, {help = 'Twitter None/Yellow/Blue Tick Approval', arguments = {{name = "auth", help = "none/blue/yellow", type = 'any'}, {name = "AccountName", help = "Squawk Account Name", type = 'any'}}})

    Config.Core.RegisterCommand(Config.TwitterSendBanCommand, 'admin', function(xPlayer, args)
        local src = xPlayer.source
        if args then
            local label = args.AccountName
            local auth = args.auth
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
                        FreamworkNotify(src, "User ban lifted", 'success')
                    else
                        FreamworkNotify(src, 'You did not write the required information', 'error')
                    end
                end)
            end
        else
            FreamworkNotify(src, 'You did not write the required information', 'error')
        end

    end, false, {help = 'Twitter Accout Suspend', arguments = {{name = "auth", help = "true/false", type = 'any'}, {name = "AccountName", help = "Squawk Account Name", type = 'any'}}})


    Config.Core.RegisterCommand(Config.TwitterSendBlockCommand, 'admin', function(xPlayer, args)
        local src = xPlayer.source
        if args and args.auth then
            local auth = args.auth
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
    end, false, {help = 'Turn off/on Message Sending', arguments = {{name = "auth", help = "true/false", type = 'any'}}})

    Config.Core.RegisterCommand('snapgramverify', 'admin', function(xPlayer, args)
        local src = xPlayer.source
        if args then
            local label = args.AccountName
            local auth = args.auth
            local isverified = 0
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
    end, false, {help = 'Snapgram None/Yellow/Blue Tick Approval', arguments = {{name = "auth", help = "none/blue", type = 'any'}, {name = "AccountName", help = "Snapgram Account Name", type = 'any'}}})

    if Config.UseSIMPackage then
        Config.Core.RegisterCommand("phonenewnumber", 'admin', function(xPlayer, args)
            local src = xPlayer.source
            if args.Source and args.Number then
                local newNumber = exports["gksphone"]:NewNumber(tonumber(args.Source), nil, args.Number)
                if newNumber then
                    FreamworkNotify(src, 'New phone number created', 'success')
                else
                    FreamworkNotify(src, 'You did not write the required information', 'error')
                end
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
        end, false, {help = 'Create a new phone number', arguments = {{name = "Source", help = "Player Source", type = 'any'}, {name = "Number", help = "Phone Number", type = 'any'}}})
    end

    Config.Core.RegisterCommand("phonechangenumber", 'admin', function(xPlayer, args)
        local src = xPlayer.source
        if args.PhoneID and args.OldNumber and args.NewNumber then
            local changeNumber = exports["gksphone"]:ChangeNumber(args.PhoneID, args.OldNumber, args.NewNumber)
            if changeNumber then
                FreamworkNotify(src, 'Phone number changed', 'success')
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
        else
            FreamworkNotify(src, 'You did not write the required information', 'error')
        end
    end, false, {help = 'Change phone number', arguments = {{name = "PhoneID", help = "Phone Serial Number", type = 'any'}, {name = "OldNumber", help = "Old Phone Number", type = 'any'}, {name = "NewNumber", help = "New Phone Number", type = 'any'}}})

    Config.Core.RegisterCommand("adminauth", 'admin', function(xPlayer, args)
        local src = xPlayer.source
        local AdminAuth = false
        if args and args.auth then
            local auth = args.auth
            if auth == "true" then
                AdminAuth = true
                TriggerClientEvent('gksphone:client:adminAuth', src, AdminAuth)
                FreamworkNotify(src, 'Admin Auth is turned on', 'success')
            else
                TriggerClientEvent('gksphone:client:adminAuth', src, AdminAuth)
                FreamworkNotify(src, 'Admin Auth is turned off', 'success')
            end
        else
            FreamworkNotify(src, 'You did not write the required information', 'error')
        end
    end, false, {help = 'Turn off/on Admin Auth', arguments = {{name = "auth", help = "true/false", type = 'any'}}})


    Config.Core.RegisterCommand("chargephone", 'admin', function(xPlayer, args)
        local src = xPlayer.source
        if args and args.playerSource then
            local playerSource = args.source
            if charge and playerSource then
                if charge >= 0 and charge <= 100 then
                    TriggerClientEvent('gksphone:client:chargePhone', playerSource, charge)
                else
                    FreamworkNotify(src, 'Charge must be between 0 and 100', 'error')
                end
            else
                FreamworkNotify(src, 'You did not write the required information', 'error')
            end
        else
            FreamworkNotify(src, 'You did not write the required information', 'error')
        end
    end, false, {help = 'Change phone charge percentage', arguments = {{name = "source", help = "Player Source", type = 'any'}, {name = "charge", help = "Charge Percentage", type = 'number'}}})


    local response = MySQL.single.await("SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'owned_vehicles' AND COLUMN_NAME = 'carseller';")
    if response then
        if response["COUNT(*)"] == 0 then
            MySQL.rawExecute.await("ALTER TABLE `owned_vehicles` ADD COLUMN `carseller` INT(11) NULL DEFAULT '0';")
        end
    end

    print('^2[GKSPHONE] ESX Loaded!^7')
end
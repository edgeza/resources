if Config.Framework ~= "standalone" then
    return
end
print("[GKSPHONE] Standalone Loading")
function GetIdentifier(source)
    for _, v in pairs(GetPlayerIdentifiers(source)) do
        if v:sub(1, #"license:") == "license:" then
            return v
        end
    end
end

function GetPlayerFromIdentifier(identifier)
    return nil
end

function GetCharacterName(source)
    return GetPlayerName(source), ""
end

function GetCharacterBirthDate(source)
    local date = "01/01/1970"
    return date
end

function GetCharacterAllVehicles(identifier, appname)
    return {}
end

function GetVehicle(identifier, plate)
    return {}
end

function VehicleUpdate(plate)
end

function VehicleUpdateCarseller(plate, data, source, identifier)
end

function GetCharacterJob(source)
    return nil
end

function GetJobs()
    return {}
end

function GetAllEmployees(job)
    return {}
end

function SetJob(source, job, grade)
    return false
end

function ToggleDuty(source, toggle)
    -- Source
    -- Toggle true/false
end

function GetBankBalance(source)
    return 0
end

function GetBankBalanceByIndetifier(identifier)
    return 0
end

function RemoveBankMoney(source, amount)
    return true
end

function AddBankMoney(source, amount)
    return true
end

function GetExtendedPlayers(key, val)
    return {}
end

function RegisterUsableItem(item, cb)

end

function RemoveItem(source, itemname, amount)

end

function FreamworkSavePhoneNumber(phoneNumber, source)

end

function FreamworkGetPhoneNumberBySource(source)
    return "0000"
end

function HasPhoneItem(source)
    local src = source
    local itemData = {
        {
            name = "phone"
        },
        {
            name = "iphone"
        }
    }
    return itemData
end

function CallingPlayerStatus(source)
    local retval = false
    return retval
end

function GetPlayerLicense(source)
    return {}
end

function SocietyGetMoney(jobname)
    local BusinessMoney = 0
    return BusinessMoney
end

function SocietyRemoveMoney(job, amount)
    return true
end

function SocietyAddMoney(job, amount)
    return true
end

Config.IsServicesAutoOpenClose = false

function GetOfflinePlayerByIdentifier(identifier)
    local self = {}
    self.accounts = {}
    function self.getAccount(account)
        if self.accounts[account] then
            return {money = self.accounts[account]}
        end
        return nil
    end

    function self.removeAccountMoney(account, amount, reason)
        return true
    end

    function self.addAccountMoney(account, amount, reason)
        return true
    end

    function self.getName()
        return ""
    end

    return self
end

Config.deleteCharacter = false

RegisterCommand(Config.TwitterVerifyCommand, function (source, args)
    if (source > 0) then
        if args then
            local auth = args[1]
            local label = args[2]
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
        end
    end
end, true)

RegisterCommand(Config.TwitterSendBanCommand, function (source, args)
    if (source > 0) then
        if args then
            local label = args[1]
            local auth = args[2]
            if auth == "true" then
                MySQL.Async.execute("UPDATE `gksphone_twt_users` SET `banned`= 1 WHERE username = @username", {
                    ['@username'] = tostring(label)
                }, function(result)
                    if (result == 1) then
                        TwitterBannedUser(true, tostring(label))
                        FreamworkNotify(source, 'User banned', 'success')
                    else
                        FreamworkNotify(source, 'You did not write the required information', 'error')
                    end
                end)
            else
                MySQL.Async.execute("UPDATE `gksphone_twt_users` SET `banned`= 0 WHERE username = @username", {
                    ['@username'] = tostring(label)
                }, function(result)
                    if (result == 1) then
                        TwitterBannedUser(false, tostring(label))
                        FreamworkNotify(source, "User ban lifted", 'success')
                    else
                        FreamworkNotify(source, 'You did not write the required information', 'error')
                    end
                end)
            end
        end
    end
end, true)

RegisterCommand(Config.TwitterSendBlockCommand, function (source, args)
    if (source > 0) then
        if args then
            local auth = args[1]
            if auth == "true" then
                TwitterMessageBlock = true
                FreamworkNotify(source, 'Message Sending is turned off', 'success')
            else
                TwitterMessageBlock = false
                FreamworkNotify(source, 'Message Sending is turned on', 'success')
            end
        end
    end
end, true)

RegisterCommand('snapgramverify', function (source, args)
    if (source > 0) then
        if args then
            local auth = args[1]
            local label = args[2]
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
        end
    end
end, true)

RegisterCommand("phonenewnumber", function (source, args)
    if (source > 0) then
        if args then
            local newNumber = exports["gksphone"]:NewNumber(tonumber(args[1]), nil, args[2])
            if newNumber then
                FreamworkNotify(source, 'New phone number created', 'success')
            else
                FreamworkNotify(source, 'You did not write the required information', 'error')
            end
        end
    end
end, true)

RegisterCommand("phonechangenumber", function (source, args)
    if (source > 0) then
        if args then
            local changeNumber = exports["gksphone"]:ChangeNumber(args[1], args[2], args[3])
            if changeNumber then
                FreamworkNotify(source, 'Phone number changed', 'success')
            else
                FreamworkNotify(source, 'You did not write the required information', 'error')
            end
        end
    end
end, true)

RegisterCommand("adminauth", function (source, args)
    if (source > 0) then
        if args then
            local auth = args[1]
            if auth == "true" then
                AdminAuth = true
                TriggerClientEvent('gksphone:client:adminAuth', source, AdminAuth)
                FreamworkNotify(source, 'Admin Auth is turned on', 'success')
            else
                TriggerClientEvent('gksphone:client:adminAuth', source, AdminAuth)
                FreamworkNotify(source, 'Admin Auth is turned off', 'success')
            end
        end
    end
end, true)


RegisterCommand("chargephone", function (source, args)
    if (source > 0) then
        if args then
            local playerSource = args[1]
            local charge = args[2]
            if charge and playerSource then
                if charge >= 0 and charge <= 100 then
                    TriggerClientEvent('gksphone:client:chargePhone', playerSource, charge)
                else
                    FreamworkNotify(source, 'Charge must be between 0 and 100', 'error')
                end
            else
                FreamworkNotify(source, 'You did not write the required information', 'error')
            end
        end
    end
end, true)


print('^2[GKSPHONE] Standalone Loaded!^7')
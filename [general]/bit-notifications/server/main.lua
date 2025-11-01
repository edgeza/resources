local cooldowns = {}

local function handleStoreCommand(source, args, action)
    local now = GetGameTimer()
    if cooldowns[source] and cooldowns[source] > now then
        TriggerClientEvent("bit-notifications:open", source, "Error", Lang.cooldown, 5000, "error")
        return
    end
    cooldowns[source] = now + 5000
    local xPlayer
    local playerJob, playerJobGrade

    if Config.Framework == "esx" then
        xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then
            print("[ERROR] ESX.GetPlayerFromId returned nil for source: " .. source)
            return
        end
        playerJob = xPlayer.getJob().name
        playerJobGrade = xPlayer.getJob().grade
    else
        xPlayer = QBCore.Functions.GetPlayer(source)
        if not xPlayer then
            print("[ERROR] QBCore.Functions.GetPlayer returned nil for source: " .. source)
            return
        end
        playerJob = xPlayer.PlayerData.job.name
        playerJobGrade = xPlayer.PlayerData.job.grade.level
    end

    local store, storeID
    local message = table.concat(args, " ")

    for k, v in pairs(Stores) do
        if v.job == playerJob then
            storeID = k
            store = v
            break
        end
    end

    if not store then
        TriggerClientEvent("bit-notifications:open", source, Lang.error, Lang.noPermissions, 5000, "error")
    else
        if playerJobGrade >= store.minGrade then
            TriggerClientEvent("bit-notifications:store", -1, message, 5000, storeID, action)
        else
            TriggerClientEvent("bit-notifications:open", source, Lang.error, Lang.noPermissions, 5000, "error")
        end
    end
end

if Config.Framework == "esx" then
    if Config.ESXExport ~= "" then
        ESX = exports[Config.ESXExport]:getSharedObject()
    else
        TriggerEvent(
            Config.Core,
            function(obj)
                ESX = obj
            end
        )
    end

    if not ESX then
        print("^1[ERROR] ESX failed to load! Check Config settings.^7")
    end

    RegisterCommand(
        Config.openStoreCommand,
        function(source, args, rawCommand)
            handleStoreCommand(source, args, "open")
        end,
        false
    )

    RegisterCommand(
        Config.closeStoreCommand,
        function(source, args, rawCommand)
            handleStoreCommand(source, args, "close")
        end,
        false
    )
elseif Config.Framework == "qb" then
    QBCore = exports[Config.Core]:GetCoreObject()

    if not QBCore then
        print("^1[ERROR] QBCore failed to load! Check Config settings.^7")
    end

    QBCore.Commands.Add(
        Config.openStoreCommand,
        "Open store",
        {},
        false,
        function(source, args)
            handleStoreCommand(source, args, "open")
        end,
        "user"
    )

    QBCore.Commands.Add(
        Config.closeStoreCommand,
        "Close store",
        {},
        false,
        function(source, args)
            handleStoreCommand(source, args, "close")
        end,
        "user"
    )
else
    print("^1[ERROR] Unrecognized framework in Config.Framework!^7")
end

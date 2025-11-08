-- dusa_mdt:getProfile
lib.callback.register("dusa_mdt:getProfile", function(source)
    local job = bridge.getJob(source)
    local player = bridge.getPlayer(source)
    local profile = {}
    profile.name = bridge.getName(source)
    profile.citizen = bridge.getIdentifier(source)
    profile.rank = bridge.getGrade(job)
    profile.gender = player.PlayerData.charinfo.gender


    return profile
end)

lib.callback.register("dusa_mdt:getCitizenid", function(_, source)
    local citizenid = bridge.getIdentifier(source)
    local nearby = {{
        citizenid = citizenid
    }}
    set:userList(nearby, nil, nil, nil, source)
    return citizenid
end)

lib.callback.register("dusa_mdt:executePlayer", function(source, name)
    local players
    if shared.framework == 'esx' then 
        players = db.searchUsers(core.players, core.playerInformations, core.charinfo, name) 
    else 
        players = db.searchByCharinfo(core.players, core.playerInformations, core.charinfo, name) 
    end
    local citizenList = set:userList(players, true, true, true, source)
    return citizenList
end)

lib.callback.register("dusa_mdt:executeVehicle", function(source, plate)
    local vehicle = db.searchByPlate(core.vehicles, core.searchVehicle, "plate", plate)
    local vehicleList = set:vehicleList(vehicle, source)
    return vehicleList
end)

RegisterServerEvent('dusa_mdt:sync', function(key, value)
    utils[key] = value
    local activePolice = getPolice()
    for i = 1, #activePolice do
        lib.triggerClientEvent('dusa_mdt:sync', tonumber(activePolice[i].id), key, utils[key])
    end
end)

SetTimeout(0, function()
    if config.mdtAsItem then
        bridge.registerItem(config.mdtItem, function(source)
            OpenMDT(source)
        end)
    else
        RegisterCommand(config.mdtCommand, function(source)
            OpenMDT(source)
        end)
    end
    
    if config.cameraOptions.isItem then
        bridge.registerItem(config.cameraOptions.item, function(source)
            local player = bridge.getPlayer(source)
            local grade = bridge.getGradeLevel(source)
            lib.triggerClientEvent('dusa-mdt:placecam', source, grade)
        end)
    else
        RegisterCommand(config.cameraOptions.command, function(source)
            local player = bridge.getPlayer(source)
            local grade = bridge.getGradeLevel(source)
            lib.triggerClientEvent('dusa-mdt:placecam', source, grade)
        end)
    end
    
    if config.cameraOptions.isHackItem then
        bridge.registerItem(config.cameraOptions.hackItem, function(source)
            lib.triggerClientEvent('dusa-mdt:hackcam', source)
        end)
    else
        RegisterCommand(config.cameraOptions.hackCommand, function(source, args)
            lib.triggerClientEvent('dusa-mdt:hackcam', source)
        end)
    end
end)

function OpenMDT(source)
    if config.requireGrade then
        local grade = bridge.getGradeLevel(source)
        if grade >= config.minGradeToOpen then
            lib.triggerClientEvent('dusa_mdt:open', source)
        else
            bridge.notify(source, locale('notenoughgrade'), "warning")
        end
    else
        lib.triggerClientEvent('dusa_mdt:open', source)
    end
end
exports('OpenMDT', OpenMDT)

function syncCache(key, value)
    local activePolice = getPolice()
    for i = 1, #activePolice do
        local player = activePolice[i]
        local source = player.id
        lib.triggerClientEvent('dusa_mdt:syncCache', source, key, value)
    end
end

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local function ToNumber(str)
        return tonumber(str)
    end
    local resourceName = GetCurrentResourceName()
    local currentVersion = GetResourceMetadata(resourceName, 'version', 0)
    PerformHttpRequest('https://raw.githubusercontent.com/lesimov/Dusa_Versions/main/'..resourceName..'.txt',function(error, result, headers)
        if not result then 
            return print('^1The version check failed, github is down.^0') 
        end
        local result = json.decode(result:sub(1, -2))
        if ToNumber(result.version:gsub('%.', '')) > ToNumber(currentVersion:gsub('%.', '')) then
            local symbols = '^9'
            for cd = 1, 26+#resourceName do
                symbols = symbols..'-'
            end
            symbols = symbols..'^0'
            print(symbols)
            print('^5['..resourceName..'] - New update available now!^0\nCurrent Version: ^1'..currentVersion..'^0.\nNew Version: ^2'..result.version..'^0.')
            print(symbols)
        end
    end, 'GET')
end)
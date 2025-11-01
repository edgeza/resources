
----------------------
---     MISC      ----
----------------------

function GetPlayer(v)
    return QBCore.Functions.GetPlayer(v)
end

function Notify(player, text, type)
    TriggerClientEvent('QBCore:Notify', player.PlayerData.source, text, type)
end

function RemoveMoney(moneyType, xPlayer, money)
    xPlayer.Functions.RemoveMoney(moneyType, money, "MDT")
end

QBCore.Functions.CreateCallback('jpr-mdtsystem:server:getServerTimeInfos', function(source, cb)
    local date = os.date("%d-%m-%Y")
    local time = os.date("%H:%M:%S")
    
    date = string.gsub(date, "(%d+)-(%d+)-(%d+)", function(day, month, year)
        return day.."-"..tostring(tonumber(month) - 1).."-"..year
    end)
    
    local data = {
        date = date,
        time = time
    }
    cb(data)
end)

QBCore.Commands.Add(Config.ResetCamerasHealthCommand, Config.Locales["11"], {}, false, function(source)
    TriggerEvent('jpr-mdtsystem:server:resetCamerasHealth')
end, 'admin')

----------------------
---  FORMAT DATA  ----
----------------------

function FormatUserData(data, dataVeh, dataHouse) 
    local charInfo = json.decode(data.charinfo)
    local jobInfos = data.job and json.decode(data.job) or {label = "Unemployed", grade = {level = 0, name = "Unemployed"}}
    local age = GetCitizenAge(charInfo.birthdate)
    local gender = 0
    local dataVeh = FormatVehicleData(dataVeh)
    local dataHouse = FormatHouseData(dataHouse)
    local metadata = json.decode(data.metadata)

    if charInfo.gender ~= gender then
        gender = "F"
    else
        gender = "M"
    end

    local formatedData = {
        identifier = data.citizenid,
        firstName = charInfo.firstname,
        lastName = charInfo.lastname,
        gender = gender,
        age = age,
        phone = charInfo.phone,
        nation = charInfo.nationality,
        birthdate = charInfo.birthdate,
        jobName = jobInfos.label,
        jobGrade = jobInfos.grade.level,
        jobGradeName = jobInfos.grade.name,
        vehicles = dataVeh,
        houses = dataHouse,
        -- licenses part
        weapon = metadata.licences.weapon,
        driver = metadata.licences.driver,
        business = metadata.licences.business,
        --- end of licenses part
        callsign = metadata.callsign,
    }

    return formatedData
end

-- data needed:
-- identifier = owner
-- mods = vehicle props
-- vehicle = vehicle model
-- plate = vehicle plate
function FormatVehicleData(data, namesIncluded) -- in case your script uses other columns
    if data then
        for k,v in pairs(data) do
            if v then
                v.identifier = v.citizenid
                v.vehicle = v.vehicle -- model name or hash
                v.plate = v.plate -- veh plate

                if namesIncluded then -- in case your script uses other columns (users / players table)
                    local ownerResult = json.decode(v.charinfo)
				    v.owner = Config.Locales["2"]

                    if ownerResult then
                        v.owner = ownerResult['firstname'] .. " " .. ownerResult['lastname']
                    end
                end
            end
        end
    end

    return data
end

-- data needed:
-- house = house name
-- address = house coords
-- ownerIdentifier = house owner
function FormatHouseData(data, namesIncluded) -- in case your script uses other columns
    if data then
        for k,v in pairs(data) do
            if v then
                if (GetResourceState("jpr-housingsystem") == "started") then
                    local baseHouse = MySQL.query.await('SELECT * FROM jpr_housingsystem_houses_realestate WHERE houseName = ?', {v.houseName})

                    v.house = v.houseName -- house name
                    v.address = Config.Locales["2"]

                    v.ownerIdentifier = v.citizenid

                    if (#baseHouse > 0) then
                        v.address = json.decode(baseHouse[1].doorCoords) -- house coords
                    end
                    
                    if namesIncluded then -- in case your script uses other columns (users / players table)
                        local ownerResult = json.decode(v.charinfo)
                        v.owner = Config.Locales["2"]

                        if ownerResult then
                            v.owner = ownerResult['firstname'] .. " " .. ownerResult['lastname']
                        end
                    end
                else
                    local baseHouse = MySQL.query.await('SELECT * FROM houselocations WHERE name = ?', {v.house})
                  
                    if #baseHouse > 0 then
                        v.house = v.house -- house name
                        v.address = Config.Locales["2"]
  
                        v.ownerIdentifier = v.citizenid
    
                        if (#baseHouse > 0) then
                            v.address = json.decode(baseHouse[1].coords).enter -- house coords
                        end
                        
                        if namesIncluded then -- in case your script uses other columns (users / players table)
                            local ownerResult = json.decode(v.charinfo)
                            v.owner = Config.Locales["2"]
    
                            if ownerResult then
                                v.owner = ownerResult['firstname'] .. " " .. ownerResult['lastname']
                            end
                        end
                    end
                end
            end
        end
    end

    return data
end

----------------------
-----  GET DATA ------
----------------------

local defaultDataCitizen = {
    identifier = Config.Locales["2"],
    firstName = Config.Locales["2"],
    lastName = Config.Locales["2"],
    gender = Config.Locales["2"],
    age = Config.Locales["2"],
    phone = Config.Locales["2"],
    nation = Config.Locales["2"],
    birthdate = nil,
    jobName = Config.Locales["2"],
    jobGrade = Config.Locales["2"],
    jobGradeName = Config.Locales["2"],
    vehicles = {},
    houses = {},
    -- licenses part
    weapon = false,
    driver = false,
    business = false,
    --- end of licenses part
    callsign = Config.Locales["2"],
}

local defaultDataVehicle = {
    identifier = Config.Locales["2"],
    vehicle = Config.Locales["2"],
    plate = Config.Locales["2"],
    owner = Config.Locales["2"],
}

local defaultDataHouse = {
    house = Config.Locales["2"],
    address = Config.Locales["2"],
    ownerIdentifier = Config.Locales["2"],
    owner = Config.Locales["2"],
}

QBCore.Functions.CreateCallback('jpr-mdtsystem:server:getCitizenData', function(source, cb, identifier, similarContent)
    if identifier ~= nil then
        local data = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', {identifier})
        if #data > 0 then
            cb(FormatUserData(data[1], GetPlayerVehicles(identifier), GetPlayerHouses(identifier)))
        else
            print("JPResources - MDT System - Debug Log 3")

            cb(defaultDataCitizen)
        end
    elseif similarContent ~= nil then
        local data = MySQL.query.await([[
            SELECT * FROM players 
            WHERE 
                JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.firstname')) LIKE ? 
                OR JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.lastname')) LIKE ?
                OR citizenid LIKE ?  
                LIMIT 40
        ]], {
            '%' .. similarContent .. '%',
            '%' .. similarContent .. '%',
            '%' .. similarContent .. '%',
        })

        if #data > 0 then
            local totalRows = {}

            for k,v in pairs(data) do
                if v then
                    table.insert(totalRows, FormatUserData(data[k], GetPlayerVehicles(data[k].citizenid), GetPlayerHouses(data[k].citizenid)))
                end
            end

            cb(totalRows)
        else
            --print("JPResources - MDT System - Debug Log 5")

            cb(defaultDataCitizen)
        end
    else
        print("JPResources - MDT System - Debug Log 4")

        cb(defaultDataCitizen)
    end
end)

QBCore.Functions.CreateCallback('jpr-mdtsystem:server:getVehicleData', function(source, cb, identifier, similarContent)
    if identifier ~= nil then
        local data = MySQL.query.await("select pv.*, p.charinfo from player_vehicles pv LEFT JOIN players p ON pv.citizenid = p.citizenid where pv.plate = :plate LIMIT 1", { plate = string.gsub(identifier, "^%s*(.-)%s*$", "%1")})

        if #data > 0 then
            local data = FormatVehicleData(data, true)
            cb(data[1])
        else
            print("JPResources - MDT System - Debug Log 10")

            cb(defaultDataVehicle)
        end
    elseif similarContent ~= nil then
        local data = MySQL.query.await("SELECT pv.id, pv.citizenid, pv.plate, pv.vehicle , pv."..Config.VehiclePayments.column..", pv.mods, pv.state, p.charinfo FROM `player_vehicles` pv LEFT JOIN players p ON pv.citizenid = p.citizenid WHERE LOWER(`plate`) LIKE :query OR LOWER(`vehicle`) LIKE :query LIMIT 25", {
            query = string.lower('%'..similarContent..'%')
        })

        if #data > 0 then
            local totalRows = {}
            data = FormatVehicleData(data, true)

            for k,v in pairs(data) do
                if v then
                    table.insert(totalRows, data[k])
                end
            end

            cb(totalRows)
        else
            --print("JPResources - MDT System - Debug Log 5")

            cb(defaultDataVehicle)
        end
    else
        print("JPResources - MDT System - Debug Log 11")

        cb(defaultDataVehicle)
    end
end)

QBCore.Functions.CreateCallback('jpr-mdtsystem:server:getDispatchCalls', function(source, cb)
    local dispatchCalls = {}
    
    -- Check if dusa_dispatch is available
    if GetResourceState("dusa_dispatch") == "started" then
        -- Try the export
        local success, calls = pcall(function()
            return exports['dusa_dispatch']:GetDispatchCalls()
        end)
        
        if success and calls and #calls > 0 then
            for i = 1, math.min(#calls, 10) do -- Limit to 10 most recent calls
                local call = calls[i]
                if call then
                    table.insert(dispatchCalls, {
                        id = call.id or i,
                        title = call.title or "Dispatch Call",
                        description = call.description or "No description available",
                        coords = call.coords or {x = 0, y = 0, z = 0},
                        priority = call.priority or 1,
                        codeName = call.codeName or "unknown",
                        time = call.timeout or os.time() * 1000,
                        units = call.units or {},
                        responses = call.responses or {}
                    })
                end
            end
        end
    end
    
    cb(dispatchCalls)
end)

QBCore.Functions.CreateCallback('jpr-mdtsystem:server:getLatestDispatch', function(source, cb)
    local latestCall = nil
    
    -- Check if dusa_dispatch is available
    if GetResourceState("dusa_dispatch") == "started" then
        -- Try the export
        local success, calls = pcall(function()
            return exports['dusa_dispatch']:GetDispatchCalls()
        end)
        
        if success and calls and #calls > 0 then
            local call = calls[#calls]
            latestCall = {
                id = call.id or #calls,
                title = call.title or "Latest Dispatch Call",
                description = call.description or "No description available",
                coords = call.coords or {x = 0, y = 0, z = 0},
                priority = call.priority or 1,
                codeName = call.codeName or "unknown",
                time = call.timeout or os.time() * 1000,
                units = call.units or {},
                responses = call.responses or {}
            }
        end
    end
    
    cb(latestCall)
end)

QBCore.Functions.CreateCallback('jpr-mdtsystem:server:getHouseData', function(source, cb, identifier, similarContent)
    if identifier ~= nil then
        local data = nil

        if (GetResourceState("jpr-housingsystem") == "started") then
            data = MySQL.query.await("select pv.*, p.charinfo from jpr_housingsystem_houses pv LEFT JOIN players p ON pv.citizenid = p.citizenid where pv.houseName = :houseName LIMIT 1", { houseName = string.gsub(identifier, "^%s*(.-)%s*$", "%1")})
        else
            -- Return empty result if housing system is not available
            data = {}
        end

        if #data > 0 then
            local data = FormatHouseData(data, true)

            cb(data[1])
        else
            print("JPResources - MDT System - Debug Log 17")

            cb(defaultDataHouse)
        end
    elseif similarContent ~= nil then
        local data = nil

        if (GetResourceState("jpr-housingsystem") == "started") then
            data = MySQL.query.await("SELECT pv.id, pv.citizenid, pv.houseName, p.charinfo FROM `jpr_housingsystem_houses` pv LEFT JOIN players p ON pv.citizenid = p.citizenid WHERE LOWER(`houseName`) LIKE :query LIMIT 25", {
                query = string.lower('%'..similarContent..'%')
            })
        else
            -- Return empty result if housing system is not available
            data = {}
        end

        if #data > 0 then
            local totalRows = {}
            data = FormatHouseData(data, true)

            for k,v in pairs(data) do
                if v then
                    table.insert(totalRows, data[k])
                end
            end

            cb(totalRows)
        else
            --print("JPResources - MDT System - Debug Log 5")

            cb(defaultDataHouse)
        end
    else
        print("JPResources - MDT System - Debug Log 18")

        cb(defaultDataHouse)
    end
end)

function GetPlayerVehicles(identifier)
    local data = MySQL.query.await('SELECT * FROM player_vehicles WHERE citizenid = ?', {identifier})

    return data
end

function GetPlayerHouses(identifier)
    local data = nil

    if (GetResourceState("jpr-housingsystem") == "started") then
        data = MySQL.query.await('SELECT * FROM jpr_housingsystem_houses WHERE citizenid = ?', {identifier})
    else
        -- Return empty result if housing system is not available
        data = {}
    end

    return data
end

function SendWebhookLog(app, webhook, message, photo, title, image)
    local webhook = webhook
    if webhook == '' then
        return
    end

    local headers = {
        ['Content-Type'] = 'application/json'
    }
    local data = {
        ["username"] = app,
        ["embeds"] = {{
            ["color"] = 2067276
        }}
    }
    
    if image ~= "" and image ~= nil then
        data['embeds'][1]['image'] = {['url'] = image}
    end
    data['embeds'][1]['description'] = '**'..title..' ** \n ' ..message
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end
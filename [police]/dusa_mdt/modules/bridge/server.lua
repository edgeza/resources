core = nil
bridge = {}
check = {}
get = {}
set = {}

function bridge.getPhoneNumber(citizenid)
    -- phone number for desired phone script
    local number = 0
    if not phone or not next(phone) then 
        local player = db.query(core.players, core.citizenid, citizenid)
        player = player[1]
        number = player.phone_number or 0
    else
        number = phone:getPhoneNumber(citizenid)
        if not number then
            errorMessage('Phone number is not valid, 0 returned', 'Current Framework: '..shared.framework)
            number = 0
        end
    end
    return number
end

function check:isInUserList(citizenid)
    local cachedUserList = store:get('userList') or {}
    local isInUserList = utils:find(cachedUserList, 'citizenid', citizenid)
    return isInUserList
end

function get:playerProperties(citizenid, source, search, table)
    local players = search and table or db.query(core.players, core.citizenid, citizenid)

    if not players[1] then
        return false
    end

    local gender = shared.framework == 'esx' and (players[1].sex == "m" and 0 or 1) or (players[1].charinfo.gender)
    local licenses = license:Get(citizenid)
    local houses = house:GetHouses(citizenid)
    local vehicles = vehicles:GetVehicle(citizenid, source)
    local crimes = wanted:Crimes(citizenid)
    local pastcrimes = wanted:PastCrimes(citizenid)
    local notes = wanted:Notes(citizenid)
    local reports = wanted:Reports(citizenid)
    local image = wanted:Image(citizenid, gender)
    local isWanted = wanted:IsWanted(citizenid)
    local isCaught = wanted:IsCaught(citizenid)

    return players, licenses, houses, vehicles, crimes, pastcrimes, notes, reports, image, isWanted, isCaught
end

function set:userList(table, shouldReturn, search, shouldSkip, source)
    local userList = {}
    local citizenList = {}

    for k, v in pairs(table) do
        citizenid = v.citizenid or v.owner or v.identifier or (v.propertyData and v.propertyData.owner) or nil
        if not citizenid then
            goto continue
        end
        local isInUserList = check:isInUserList(citizenid)
        if shouldSkip then isInUserList = false end
        if isInUserList then goto continue end
        local players, licenses, houses, vehicles, crimes, pastcrimes, notes, reports, image, isWanted, isCaught = get:playerProperties(citizenid, source, search, table)

        if not players then goto continue end
        if type(players) == 'string' then
            players = json.decode(players)
        end
        players = search and players[k] or players[1]
        utils:convertPlayers(players)
        players.job.grade.name = string.upper(string.sub(players.job.grade.name, 1, 1)) .. string.sub(players.job.grade.name, 2)
        userList = {
            user = players.charinfo.firstname .. " " .. players.charinfo.lastname,
            citizenid = citizenid,
            citizen = citizenid,
            userImage = image,
            date = players.charinfo.birthdate,
            telephone = bridge.getPhoneNumber(citizenid) or 0,
            job = players.job.grade.name,
            gender = players.charinfo.gender == 0 and "Male" or "Female",
            crimes = crimes or {},
            pastcrimes = pastcrimes or {},
            notes = notes or {},
            reports = reports or {},
            wanted = isWanted,
            caught = isCaught,
            licanse = licenses,
            cars = vehicles.value,
            houses = houses
        }
        if not search then store:add('userList', userList) end
        citizenList[#citizenList + 1] = userList
        ::continue::
    end

    local currentList = store:get('userList') or {}
    store:set('userList', currentList)

    if shouldReturn then return citizenList end
end

function set:vehicleList(table, source)
    local vehicleList = {}
    local vehicle = {}
    local player = set:userList(table, true, nil, true, source)
    if not player or not next(player) then 
        vehicle.car = nil
        vehicle.player = nil
        return vehicle
    end
    for k, v in pairs(table) do
        local isWanted = vehicles:IsWanted(v.plate) or 0
        local reports = vehicles:Reports(v.plate)
        if shared.framework == 'esx' then
            if type(v.vehicle) == 'string' then v.vehicle = json.decode(v.vehicle) end
        end
        local model = v.vehicle and v.vehicle.model
        if model then
            local result = TriggerClientCallback {
                source = source,
                eventName = 'dusa_mdt:getVehicleLabel',
                args = {model}
            }
            v.vehicle = result
            v.name = result
        end
        local image = "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg"

        v.vehicle = v.vehicle or v.name
        if v.vehicle ~= "Model unavailable" then
            v.vehicle = string.lower(v.vehicle)
            image = 'https://docs.fivem.net/vehicles/'..v.vehicle..'.webp'
        end

        v.citizenid = v.citizenid or v.owner
        data = {
            plate = v.plate,
            name = v.name or v.vehicle,
            wanted = isWanted or 0,
            citizen = v.citizenid,
            reports = reports or {},
            img = image,
            color = 'red',
            selected = false
        }
        vehicleList[#vehicleList + 1] = data
        ::continue::
    end
    vehicle.car = vehicleList
    vehicle.player = player

    return vehicle
end

function bridge.getCallsign(source)
    local Player = bridge.getPlayer(source)
    local metadata = Player.PlayerData.metadata
    local callsign = 'NO CALLSIGN'

    if metadata?.callsign then
        callsign = metadata.callsign
    end

    -- Place your get callsign method here
    -- Dusa Dispatch
    if GetResourceState('dusa_dispatch') == 'started' then
        callsign = exports.dusa_dispatch:GetCallsign(source)
    end

    return callsign
end

function check:control(table)
    for k, v in pairs(table) do
        if v == "null" then
            return false
        end
    end
    return true
end 
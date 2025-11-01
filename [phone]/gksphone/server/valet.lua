-- VALE --
--- GKSPHONE VALET APP (server) ---
-- Made by GKSHOP  | https://discord.gg/XUck63E
-- Version: 2.0.0


function IsVehicleOut(plate)
    local vehicles = GetAllVehicles()
    if not vehicles then return false end
    if type(vehicles) == "table" then
        for _, vehicle in pairs(vehicles) do
            if DoesEntityExist(vehicle) then
                local plateText = GetVehicleNumberPlateText(vehicle)
                plateText = plateText:gsub("%s", "")
                plate = plate:gsub("%s", "")
                if plateText == plate then
                    return true, vehicle
                end
            end
        end
    end
    return false
end

CallBackRegisterServer('gksphone:server:vale:getVehicles', function(source, cb, appname)
    local xPlayer = GetIdentifier(source)
    if not xPlayer then return; end
    local owner = xPlayer
    local variable = GetCharacterAllVehicles(owner, appname)
    Debugprint("gksphone:server:vale:getVehicles | Total vehicles: " .. #variable .. " | CitizenID: " .. owner)
    cb(variable)
end)

CallBackRegisterServer("gksphone:server:vale:vehichlepoint", function(source, cb, plate)
    local check, vehicle = IsVehicleOut(plate)
    if check and vehicle then
        local vehicleCoords = GetEntityCoords(vehicle)
        cb(true, vehicleCoords)
    else
        cb(false)
    end
end)

CallBackRegisterServer("gksphone:server:vale:vehiclebring", function(source, cb, plate, coords, modelType)
    local vehicle = IsVehicleOut(plate)
    if (vehicle == false) then
        modelType = modelType or "automobile"
        local xPlayer = GetIdentifier(source)
        if not xPlayer then cb(false) end
        local citizenid = xPlayer
        local BankMoney = GetBankBalance(source)
        local price = Config.ValePrice
        if price > BankMoney then
            Debugprint("gksphone:server:vale:vehiclebring | Not enough money | CitizenID: " .. citizenid)
            cb("nomoney")
            return
        end
        local getVeh = GetVehicle(citizenid, plate)

        if getVeh == nil then
            Debugprint("gksphone:server:vale:vehiclebring | Vehicle not found | CitizenID: " .. citizenid .. " | Plate: " .. plate)
            cb("carnotfound")
            return
        elseif getVeh == "carimpounded" or getVeh == "carnotingarage" then
            Debugprint("gksphone:server:vale:vehiclebring | Vehicle not in garage | CitizenID: " .. citizenid .. " | Plate: " .. plate)
            cb(getVeh)
            return
        end

        RemoveBankMoney(source, Config.ValePrice)
        local phoneData = exports["gksphone"]:GetPhoneDataByCitizenID(citizenid)
        if phoneData then
            local BankHistorySave = exports["gksphone"]:bankHistorySave(phoneData.phone_number, 1, Config.ValePrice, _T(phoneData?.phone_lang, "ValeAPP.APP_VALE_USEVALET_BANK_HISTORY_DESC"), phoneData.unique_id)
            if BankHistorySave then
                Debugprint("gksphone:server:vale:vehiclebring | Vehicle bringing fee | CitizenID: " .. citizenid .. " | Plate: " .. plate .. " | Price: " .. Config.ValePrice)
            end
        end
        VehicleUpdate(plate)
        Debugprint("gksphone:server:vale:vehiclebring | ESX Vehicle stored changed | CitizenID: " .. citizenid .. " | Plate: " .. plate .. " | Stored: 0")
        cb("spawned", getVeh)
    else
        Debugprint("Car Out | source: " .. source .. " | Plate: " .. plate)
        cb("carout")
    end
end)

function VehicleSpawn(source, model, coords, heading, modelType)
    Debugprint("VehicleSpawn | Model: " .. model .. " | Coords: " .. json.encode(coords) .. " | Heading: " .. heading .. " | ModelType: " .. modelType)
    local createdVehicle = CreateVehicleServerSetter(model, modelType, coords.x, coords.y, coords.z, heading)
    Wait(1000)
    if not DoesEntityExist(createdVehicle) then
        return print("[^1GKSPHONE ERROR^7] Unfortunately, this vehicle has not spawned")
    end
    return createdVehicle
end

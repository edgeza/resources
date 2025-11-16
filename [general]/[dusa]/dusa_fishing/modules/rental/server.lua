local function setVehicleKey(source, vehicle, plate)
    local model = GetEntityModel(vehicle)

    if GetResourceState('dusa_vehiclekeys') == 'started' then
        exports["dusa_vehiclekeys"]:GiveKeys(source, plate)
    elseif GetResourceState('wasabi_carlock') == 'started' then
        exports.wasabi_carlock:GiveKey(source, plate)
    elseif GetResourceState('qb-vehiclekeys') == 'started' then
        exports['qb-vehiclekeys']:GiveKeys(source, plate)
    elseif GetResourceState('qs-vehiclekeys') == 'started' then
        exports['qs-vehiclekeys']:GiveServerKeys(source, plate, model)
    elseif GetResourceState('vehicles_keys') == 'started' then
        exports["vehicles_keys"]:giveVehicleKeysToPlayerId(source, plate)
    elseif GetResourceState('ak47_vehiclekeys') == 'started' then
        exports['ak47_vehiclekeys']:GiveKey(source, plate, false)
    end
end

local vehs = {}

lib.callback.register('fishing:server:spawnBoat', function(source, _data, vehPlate)
    local src = source
    local Player = Framework.GetPlayer(src)
    local ped = GetPlayerPed(src)

    for k, v in pairs(vehs) do
        if v.owner == Player.Identifier then
            Framework.Notify(src, locale('this_boat_already_taken'), 'error')
            return false
        end
    end

    local balance = Player.GetMoney(_data.moneyAccount)
    if balance < _data.price then
        Framework.Notify(src, locale('insufficient_money'), 'error')
        return false
    end

    Player.RemoveMoney(_data.moneyAccount, _data.price)

    _data.boat.model = type(_data.boat.model) == 'string' and joaat(_data.boat.model) or _data.boat.model
    local veh = CreateVehicle(_data.boat.model, _data.coords.x, _data.coords.y, _data.coords.z, _data.coords.w, true, true)
    while not DoesEntityExist(veh) do Wait(0) end
    while GetVehiclePedIsIn(ped) ~= veh do
        Wait(0)
        TaskWarpPedIntoVehicle(ped, veh, -1)
    end
    setVehicleKey(src, veh, vehPlate)
    while NetworkGetEntityOwner(veh) ~= src do Wait(0) end
    vehs[#vehs + 1] = {
        owner = Player.Identifier,
        entity = veh,
        -- time = os.time() + (_data.time * 60 * 60),
        price = tonumber(_data.price),
    }
    return NetworkGetNetworkIdFromEntity(veh)
end)

RegisterNetEvent('fishing:server:returnBoat', function ()
    local src = source
    local Player = Framework.GetPlayer(src)
    Wait(1000)
    for k, v in pairs(vehs) do
        if v.owner == Player.Identifier then
            for i = -1, 6, 1 do
                local ped = GetPedInVehicleSeat(v.entity, i)
                if ped ~= 0 then
                    Framework.Notify(src, locale('someone_in_vehicle'), 'error')
                    return
                end
            end
            -- local remainTime = math.floor(v.time - os.time())
            if DoesEntityExist(v.entity) then
                DeleteEntity(v.entity)
                Player.AddMoney('bank', v.price)
            end
            vehs[k] = nil
        end
    end
end)

CreateThread(function()
    while true do
        for k, v in pairs(vehs) do
            if v then
                if v.time and type(v.time) == 'number' and os.time() >= v.time then
                    if DoesEntityExist(v.entity) then
                        DeleteEntity(v.entity)
                    end
                    vehs[k] = nil
                end
            end
        end
        Wait(60 * 1000)
    end
end)
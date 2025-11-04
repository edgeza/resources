-- Framework Detection for QBox/QBCore compatibility
-- QBox provides 'qb-core' exports for backward compatibility, so we always use 'qb-core'
-- But we detect which framework is running for other exports (like DrawText/HideText)
local isQBox = GetResourceState('qbx_core') == 'started'
local coreResource = 'qb-core' -- QBox provides this for compatibility, QBCore uses it directly
QBCore = exports[coreResource]:GetCoreObject()

function GetPlayerMoney(source, type)
	local Player = QBCore.Functions.GetPlayer(source)
	return Player?.PlayerData.money[type]
end

function RemovePlayerMoney(source, amount, type)
	local Player = QBCore.Functions.GetPlayer(source)
	return Player?.Functions.RemoveMoney(type, amount)
end

function AddPlayerMoney(source, amount, type)
	local Player = QBCore.Functions.GetPlayer(source)
	return Player?.Functions.AddMoney(type, amount)
end

function GetPlayerVipCoins(source)
    local vipCoins = 0

    -- Add your compatibility to get the vip coins of the player

    return vipCoins
end

function AddPlayerVipCoins(source, identifier, amount)
    -- Add your compatibility to add the vip coins of the player
end

function RemovePlayerVipCoins(source, identifier, amount)
    -- Add your compatibility to remove the vip coins of the player
end

function GetSocietyMoney(source, Player)
    -- Add your compatibility to get money from the society
    -- return the money from the society
    return 0
end

function AddSocietyMoney(source, Player, amount)
    -- Add your compatibility to add money to the society
end

function RemoveSocietyMoney(source, Player, amount)
    -- Add your compatibility to remove money from the society
end

function HasLicense(source, Player, licenseType)
    -- Add your compatibility to check if the player has a license
    -- return true if you want to open the shop
    return true
end

-- Events

RegisterServerEvent('okokVehicleShop:setVehicleOwned')
AddEventHandler('okokVehicleShop:setVehicleOwned', function (vehicleProps, vehicleModel, personalPurchase, type)
    local source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)

    local canBuy = lib.callback.await("okokVehicleShop:canBuyVehicle", source)
    if not canBuy then return end

    if type == 'vehicles' then type = 'car' end -- type returns the type of the stand, so if you add a type luxury and you want to save it as type car, make the same if as here

    if personalPurchase then
        MySQL.query('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @state)', {
            ['@license'] = xPlayer?.PlayerData.license,
            ['@citizenid'] = xPlayer?.PlayerData.citizenid,
            ['@vehicle'] = vehicleModel,
            ['@hash'] = GetHashKey(vehicleModel),
            ['@mods'] = json.encode(vehicleProps),
            ['@plate'] = vehicleProps.plate:match( "^%s*(.-)%s*$" ),
            ['@state'] = 0
        })
    else
        if Config.SocietyGarage == "okokGarage" then
            MySQL.query('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @state)', {
                ['@license'] = xPlayer?.PlayerData.job.name,
                ['@citizenid'] = xPlayer?.PlayerData.job.name,
                ['@vehicle'] = vehicleModel,
                ['@hash'] = GetHashKey(vehicleModel),
                ['@mods'] = json.encode(vehicleProps),
                ['@plate'] = vehicleProps.plate:match( "^%s*(.-)%s*$" ),
                ['@state'] = 0
            })
        else
            print('Society purchase')
            -- Add your compatibility to add vehicles to the society
        end
    end
end)

-- Callbacks

lib.callback.register('okokVehicleShop:getPlayerVehicles', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    
    local sql = 'SELECT citizenid, plate, vehicle FROM player_vehicles WHERE citizenid = @citizenid'
    local params = {['@citizenid'] = Player.PlayerData.citizenid, ['@job'] = Player.PlayerData.job.name}
    
    for k, v in pairs(Config.SocietyTradeInRanksLevel) do
        if Player.PlayerData.job.grade.level >= v then
            sql = sql .. ' OR citizenid = @job'
            params['@job'] = Player.PlayerData.job.name
            break
        end
    end
    
    if Config.TradeInStored then
        sql = sql .. ' and state = @state'
        params['@state'] = '1'
    end

    local vehicles = MySQL.query.await(sql, params)
    local playerVehicles = {}
    local societyVehicles = {}

    for _, vehicle in ipairs(vehicles) do
        if vehicle.citizenid == Player.PlayerData.job.name then
            table.insert(societyVehicles, vehicle)
        else
            table.insert(playerVehicles, vehicle)
        end
    end

    return playerVehicles, societyVehicles
end)
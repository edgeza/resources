QBCore = exports["qb-core"]:GetCoreObject()

function GetPlayerMoney(source, type)
	local Player = GetPlayer(source)
	return Player?.PlayerData.money[type]
end

function RemovePlayerMoney(source, amount, type)
	local Player = GetPlayer(source)
	return Player?.Functions.RemoveMoney(type, amount)
end

function AddPlayerMoney(source, amount, type)
	local Player = GetPlayer(source)
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
	-- When no license is required for the stand, allow access
	if not licenseType or licenseType == '' then return true end

	-- QS-Licenses support (try common APIs safely)
	if GetResourceState('qs-licenses') == 'started' or GetResourceState('qs-license') == 'started' then
		local providers = { 'qs-licenses', 'qs-license' }
		for _, prov in ipairs(providers) do
			if GetResourceState(prov) == 'started' then
				-- Try HasLicense(source, licenseType)
				local ok, has = pcall(function()
					return exports[prov]:HasLicense(source, licenseType)
				end)
				if ok then return has and true or false end

				-- Try CheckLicense(source, licenseType)
				ok, has = pcall(function()
					return exports[prov]:CheckLicense(source, licenseType)
				end)
				if ok then return has and true or false end

				-- Try GetLicense(source, licenseType) that returns table/bool
				ok, has = pcall(function()
					return exports[prov]:GetLicense(source, licenseType)
				end)
				if ok then
					if type(has) == 'boolean' then return has end
					if type(has) == 'table' then return true end
				end
			end
		end
	end

	-- Buty-license support (maps practical_* to Buty keys when applicable)
	if GetResourceState('Buty-license') == 'started' then
		local identifier = Player?.PlayerData.citizenid
		if not identifier then return false end

		local butyType = licenseType
		if licenseType == 'practical_plane' then
			butyType = 'plane'
		elseif licenseType == 'practical_helicopter' then
			butyType = 'helicopter'
		end

		local ok = exports['Buty-license']:HasLicense(identifier, 'driving', butyType)
		return ok and true or false
	end

	-- Default QB-Core metadata licences (works with vms_flightschoolv2 defaults)
	local licences = Player?.PlayerData.metadata and Player.PlayerData.metadata['licences'] or {}
	if type(licences) ~= 'table' then return false end

	return licences[licenseType] == true
end

-- Events

RegisterServerEvent('okokVehicleShop:setVehicleOwned')
AddEventHandler('okokVehicleShop:setVehicleOwned', function (vehicleProps, vehicleModel, personalPurchase, type)
    local source = source
    local xPlayer = GetPlayer(source)

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
    local Player = GetPlayer(source)
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
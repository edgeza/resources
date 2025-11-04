Config, Locales = {}, {}

-- =========================
-- CORE/TOGGLES
-- =========================
Config.Debug = true -- true = will print some debug messages
Config.Locale = 'en' -- en
Config.AddVehiclesFromVehiclesFile = true -- true = will add vehicles from qbcore/shared/vehicles.lua

-- Notifications/UI/Integrations
Config.UseOkokNotify = GetResourceState('okokNotify') == 'started' and true or false -- if you want to use okokNotify set it to true
Config.UseOkokTextUI = GetResourceState('okokTextUI') == 'started' and true or false -- if you want to use okokTextUI set it to true
Config.UseOkokRequests = GetResourceState('okokRequests') == 'started' and true or false -- if you want to use okokRequests set it to true
Config.SocietyGarage = "cd_garage" -- Used for society purchases and trade-in vehicles
Config.KeySystem = 'dusa-vehiclekeys' -- qb-vehiclekeys (change on cl_utils.lua)

-- Vehicle Listing Settings
Config.VehicleListingType = 'normal' -- 'normal' all vehicles in the same page | 'categories' all vehicles in categories
Config.DatabaseUpdateInterval = 300 -- How often the database will be updated in seconds
Config.UseSameImageForAllVehicles = false -- true = will use the same image for all vehicles (web/img/vehicles/default.png) | false = will use the image from the vehicle_id
Config.UseLocalImages = false -- true = will use images from /web/img/vehicles | false = it will get the images from the github repository, if not found it will use an image from the web/img/vehicles/

-- Input/Target
Config.UseTarget = true -- true = will use target | false = will use marker
Config.TargetSystem = 'ox-target' -- 'ox-target' | 'qb-target'
Config.Key = 38 -- [E] Key to open the interaction, check here the keys ID: https://docs.fivem.net/docs/game-references/controls/#controls

-- Currency/Business
Config.Currency = '$' -- Currency symbol
Config.CurrencySide = 'right' -- left | right
Config.MaxEmployeesPerDealership = 5 -- Maximum number of employees per dealership
Config.HireRange = 3 -- Range to hire an employee
Config.WeeklyGoalResetHours = 168 -- How many hours to reset the weekly goal (168 = 1 week)

-- Pricing Settings
Config.UseMultiplierFactorForMinPrice = false -- true = calculate min price based on the multiplier factor (price*Config.MinPriceMultiplier) | false = min price will be the base price
Config.MinPriceMultiplier = 0.5 -- This is the multiplier factor for the min price (Config.UseMultiplierFactorForMinPrice = true)
Config.UseMultiplierFactorForMaxPrice = false -- true = calculate price based on the multiplier factor (price*Config.MaxPriceAddition) | false = calculate price based on the max price addition (price+Config.MaxPriceAddition)
Config.MaxPriceAddition = 5000 -- This is how much will be added to the vehicle price to create the max_price
Config.OwnerBuyVehiclePercentage = 10 -- How much of a discount the owner has to order a vehicle (bases on the min. price)
Config.SellBusinessReceivePercentage = 50 -- How much % a player will receive for selling his business (in percentage, 50 = 50%)

-- Plate Settings
Config.PlateLetters = 4 -- How many letters the plate has
Config.PlateNumbers = 4 -- How many numbers the plate has
Config.PlateUseSpace = false -- If the plate uses spaces between letters and numbers
Config.EnableCustomPlates = true -- If true = players can use custom plates for their vehicles
Config.CustomPlatePrice = 1000 -- The price for a custom plate
Config.EnablePlatePrefix = true -- If true = the plate will have a prefix
Config.PlatePrefix = "OK" -- The prefix for the plate

-- Interface/History Settings
Config.SalesDateFormat = "%d/%m - %H:%M" -- Format of the sales date
Config.MaxLogsDays = 7 -- How many days to keep the logs on the UI (the old ones it will be saved on the database)
Config.MaxEntriesOnVehicleHistory = 24 -- How many entries to keep on the vehicle history to avoid any performance issues

-- Vehicle Classes
Config.UseVehicleClasses = true -- If you want to use vehicle classes set it to true
Config.CalculateVehicleClasses = false -- If you want to enable vehicle class calculation set it to true
Config.VehicleClasses = {
    ['C'] = 350,
    ['B'] = 400,
    ['A'] = 600,
    ['S'] = 800,
    ['S+'] = 1000,
}

-- =========================
-- MISSIONS/ORDERS
-- =========================
Config.MissionForStock = true -- false = when you order a vehicle, the vehicle shop will instantly receive it without doing any order/mission
Config.OrderReceivePercentage = true -- If true = players will receive a percentage of the vehicle price (Config.OrderCompletedPercentage) | if false = players receive a flat rate (Config.OrderCompletedFlatRate)
Config.OrderCompletedPercentage = 10 -- When a employee completes the misson he will get this percentage as a reward, 10 = 10% (Config.OrderReceivePercentage = true)
Config.OrderCompletedFlatRate = 1000 -- When a employee completes the misson he will get paid this value (Config.OrderReceivePercentage = false)
Config.CancelCustomOrderFee = 5 -- When a player cancels a custom order he will lose a fee of the vehicle price, 5 = 5%

-- Vehicle Sales/Trade-ins
Config.EnableSellVehicle = true -- If true = players can sell their vehicles to the vehicle shop
Config.SellVehiclePercentage = 50 -- When a player sells a vehicle to the vehicle shop he will get a percentage of the vehicle price, 50 = 50%
Config.EnableTradeIns = true -- If true = players can trade-in their vehicles for a discount on a new vehicle
Config.TradeInPercentage = 75 -- This is the percentage of the vehicle price that will be given as a discount for the trade-in
Config.TradeInStored = true -- If true = player can only trade-in vehicles that are stored
Config.SocietyTradeInRanksLevel = {3, 4}

-- Blips & Markers
Config.TruckBlip = {blipId = 67, blipColor = 2, blipScale = 0.9, blipText = "Truck"} -- Blip of the truck when someone accepts an order
Config.TrailerBlip = {blipId = 515, blipColor = 2, blipScale = 0.9, blipText = "Trailer"} -- Blip of the trailer when someone accepts an order (for vehicle shops with big vehicles)
Config.OrderBlip = {blipId = 478, blipColor = 5, blipText = "Order"}  -- Blip of the ordered vehicle when someone accepts an order
Config.TowMarker = {id = 21, size = {x = 0.5, y = 0.5, z = 0.5}, color = {r = 31, g = 94, b = 255, a = 90}, bobUpAndDown = false, faceCamera = false, rotate = true, drawOnEnts = false, textureDict = false, textureName = false} -- The marker to tow a vehicle when someone accepts an order

-- Commands & Resources
Config.AdminMenuCommand = "vsadmin" -- Command to open the admin menu
Config.FlatbedResourceName = "flatbed" -- Name of the flatbed resource (Get it here: https://github.com/flowdgodx/flatbed)
Config.SmallTowTruckID = "flatbed3" -- Id of the truck used to tow the vehicle 
Config.BigTowTruckID = "Hauler"
Config.TrailerID = "TRFlat"

-- =========================
-- JOB RANKS/GOALS
-- =========================
Config.JobRanks = { -- These are the ranks available on the vehicle shops, you can add or remove as many as you want but leave at least 1
	{rank = "Newbie", subowner = false},
	{rank = "Experienced", subowner = false},
	{rank = "Expert", subowner = false},
	{rank = "Sub-Owner", subowner = true}
}

Config.WeeklyGoalOptions = { -- Weekly goal options to show on the dashboard
    [1] = 10000,
	[2] = 25000,
	[3] = 50000,
	[4] = 100000,
	[5] = 250000,
	[6] = 500000,
}

-- =========================
-- FINANCE SETTINGS
-- =========================
Config.FinanceVehiclesSettings = {
	["command"] = "financedvehicles", -- command to open the finance menu
	["interest_rate"] = 0.15, -- 15% interest rate
	["payment_check_interval"] = 12, -- real hours
	["payments"] = 12, -- how many payments will be made
	["max_failed_payments"] = 3, -- maximum number of failed payments before the vehicle is repossessed
	["max_financed_vehicles"] = 2, -- maximum number of financed vehicles per player
}

-- =========================
-- VEHICLE CATEGORIES
-- =========================
Config.Categories = { -- Get the type from the database and make sure to add it here according to the type of vehicle for the test drive to be able to identify the vehicle type
	["car"] = { -- car categories
		vehicles = true,
		luxury = true,
	},
	["boat"] = { -- boat categories
		boats = true,
	},
	["air"] = { -- air categories
		air = true,
	},
}

Config.CategoriesLabels = { -- Categories labels to show on the UI
	["air"] = "Air",
	["bicycles"] = "Bicycles",
	["boat"] = "Boat",
	["car"] = "Car",
	["compacts"] = "Compacts",
	["commercial"] = "Commercial",
	["coupes"] = "Coupes",
	["emergency"] = "Emergency",
	["exotic"] = "Exotic",
	["industrial"] = "Industrial",
	["military"] = "Military",
	["motorcycles"] = "Motorcycles",
	["muscle"] = "Muscle",
	["offroad"] = "Offroad",
	["openwheel"] = "Open Wheel",
	["sedans"] = "Sedans",
	["service"] = "Service",
	["sports"] = "Sports",
	["sportsclassics"] = "Sports Classics",
	["super"] = "Super",
	["suvs"] = "SUVs",
	["utility"] = "Utility",
	["vans"] = "Vans",
	["trains"] = "Trains",
	["cycles"] = "Cycles",
	["helicopters"] = "Helicopters",
	["planes"] = "Planes"
}

-- =========================
-- VEHICLE SHOPS/LOCATIONS
-- =========================

Config.Stands = {
	{
		label = "Bike Dealer", -- name of the vehicle shop
		licenseType = "drive_a", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = false, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		blipCoords = vector3(-867.97, -201.25, 37.84), -- blip position for the vehicle shop
		isVip = false, -- if set to true IT WON'T BE OWNED BY ANYONE and will use vip coins instead of currency, check sv_utils.lua to change the vip coins functions

		vehicleCameraSettings = {
			location = vector3(-872.93, -191.63, 37.84),
			camera = vector4(-865.23, -199.74, 38.99, 55.96),
		},

		vehicleSettings = {
			sellVehicleCoords = vector3(-882.97, -200.26, 38.64), -- position where the vehicles can be sold
			purchaseVehicleCoords = { -- positions where the vehicles will be spawned when the player purchases a vehicle
				{vector4(-896.8, -202.45, 38.37, 72.0)},
			}
		},

		testDriveSettings = {
			paid = true, -- true = the player will pay for the test drive | false = the player will not pay for the test drive
			price = 100, -- Price of the test drive
			time = 45, -- Time of the test drive in seconds
			plate = "TEST", -- Plate of the test drive vehicle [max 8 characters]
			carLocation = vector4(-891.18, -184.8, 37.89, 0.0), -- Location of the car test drive
			boatLocation = vector4(-796.85, -1502.27, -0.09, 113.55), -- Location of the boat test drive
			airLocation = vector4(-1332.52, -2205.1, 13.34, 151.03), -- Location of the air test drive
		},

        markerSettings = {
			vehicleCoords = vector3(-867.97, -201.25, 37.84), -- Marker/Shop position for vehicle listing
        },

        targetSettings = {
			vehicleCoords = vector3(-867.97, -201.25, 37.84), -- Marker/Shop position for vehicle listing
        },

		radius = 1, -- Interaction radius for the markers
		price = 10000, -- Price of the vehicle shop
		blip = {blipId = 494, blipColor = 3, blipColorPurchasable = 1, blipScale = 0.9}, -- Blip informations for vehicleshop blip
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0, textureDict = 0, textureName = 0}, -- Marker informations for the vehicle shop
		type = "bike", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "bike", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
	{
		label = "OneLife Auto", -- name of the vehicle shop
		licenseType = "drive_b", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = false, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		blipCoords = vector3(-195.29, -1170.59, 23.76), -- blip position for the vehicle shop
		isVip = false, -- if set to true IT WON'T BE OWNED BY ANYONE and will use vip coins instead of currency, check sv_utils.lua to change the vip coins functions

		vehicleCameraSettings = {
			location = vector3(-177.17, -1173.17, 22.95),
			camera = vector4(-185.06, -1163.74, 22.94, 50.0),
		},

		vehicleSettings = {
			sellVehicleCoords = vector3(-149.12, -1163.62, 23.90), -- position where the vehicles can be sold
			purchaseVehicleCoords = { -- positions where the vehicles will be spawned when the player purchases a vehicle
				{vector4(-157.49, -1172.91, 24.62, 0.0)},
			}
		},

		testDriveSettings = {
			paid = true, -- true = the player will pay for the test drive | false = the player will not pay for the test drive
			price = 100, -- Price of the test drive
			time = 45, -- Time of the test drive in seconds
			plate = "TEST", -- Plate of the test drive vehicle [max 8 characters]
			carLocation = vector4(-157.49, -1172.91, 24.62, 0.0), -- Location of the car test drive
			boatLocation = vector4(-796.85, -1502.27, -0.09, 113.55), -- Location of the boat test drive
			airLocation = vector4(-1332.52, -2205.1, 13.34, 151.03), -- Location of the air test drive
		},

        markerSettings = {
			vehicleCoords = vector3(-195.29, -1170.59, 23.76), -- Marker/Shop position for vehicle listing
        },

        targetSettings = {
			vehicleCoords = vector3(-195.29, -1170.59, 23.76), -- Marker/Shop position for vehicle listing
        },

		radius = 1, -- Interaction radius for the markers
		price = 10000, -- Price of the vehicle shop
		blip = {blipId = 523, blipColor = 3, blipColorPurchasable = 1, blipScale = 0.9}, -- Blip informations for vehicleshop blip
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0, textureDict = 0, textureName = 0}, -- Marker informations for the vehicle shop
		type = "lux", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "lux", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
	{
		label = "Drag Dealership", -- name of the vehicle shop
		licenseType = "drive_b", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = false, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		blipCoords = vector3(-1258.76, -368.13, 36.91), -- blip position for the vehicle shop
		isVip = false, -- if set to true IT WON'T BE OWNED BY ANYONE and will use vip coins instead of currency, check sv_utils.lua to change the vip coins functions

		vehicleCameraSettings = {
			location = vector3(-1259.44, -360.02, 37.38),
			camera = vector4(-1254.24, -351.58, 38.76, 8.82),
		},

		vehicleSettings = {
			sellVehicleCoords = vector3(-1244.07, -346.05, 37.33), -- position where the vehicles can be sold
			purchaseVehicleCoords = { -- positions where the vehicles will be spawned when the player purchases a vehicle
				{vector4(-1233.91, -345.64, 37.33, 26.63)},
			}
		},

		testDriveSettings = {
			paid = true, -- true = the player will pay for the test drive | false = the player will not pay for the test drive
			price = 100, -- Price of the test drive
			time = 45, -- Time of the test drive in seconds
			plate = "TEST", -- Plate of the test drive vehicle [max 8 characters]
			carLocation = vector4(-1258.22, -337.99, 36.8, 297.46), -- Location of the car test drive
			boatLocation = vector4(-796.85, -1502.27, -0.09, 113.55), -- Location of the boat test drive
			airLocation = vector4(-1332.52, -2205.1, 13.34, 151.03), -- Location of the air test drive
		},

        markerSettings = {
			vehicleCoords = vector3(-1258.76, -368.13, 36.91), -- Marker/Shop position for vehicle listing
        },

        targetSettings = {
			vehicleCoords = vector3(-1258.76, -368.13, 36.91), -- Marker/Shop position for vehicle listing
        },

		radius = 1, -- Interaction radius for the markers
		price = 10000, -- Price of the vehicle shop
		blip = {blipId = 523, blipColor = 3, blipColorPurchasable = 1, blipScale = 0.9}, -- Blip informations for vehicleshop blip
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0, textureDict = 0, textureName = 0}, -- Marker informations for the vehicle shop
		type = "dragshop", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "dragshop", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
	{
		label = "Offroad Dealer", -- name of the vehicle shop
		licenseType = "drive_b", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = false, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		blipCoords = vector3(1723.95, 4767.36, 42.09), -- blip position for the vehicle shop
		isVip = false, -- if set to true IT WON'T BE OWNED BY ANYONE and will use vip coins instead of currency, check sv_utils.lua to change the vip coins functions

		vehicleCameraSettings = {
			location = vector3(1710.16, 4779.19, 42.09),
			camera = vector4(1701.52, 4775.13, 43.5, 177.09),
		},

		vehicleSettings = {
			sellVehicleCoords = vector3(1691.96, 4788.44, 40.92), -- position where the vehicles can be sold
			purchaseVehicleCoords = { -- positions where the vehicles will be spawned when the player purchases a vehicle
				{vector4(1701.84, 4755.83, 41.97, 77.21)},
			}
		},

		testDriveSettings = {
			paid = true, -- true = the player will pay for the test drive | false = the player will not pay for the test drive
			price = 100, -- Price of the test drive
			time = 45, -- Time of the test drive in seconds
			plate = "TEST", -- Plate of the test drive vehicle [max 8 characters]
			carLocation = vector4(1701.84, 4755.83, 41.97, 77.21), -- Location of the car test drive
			boatLocation = vector4(-796.85, -1502.27, -0.09, 113.55), -- Location of the boat test drive
			airLocation = vector4(-1332.52, -2205.1, 13.34, 151.03), -- Location of the air test drive
		},

        markerSettings = {
			vehicleCoords = vector3(1723.95, 4767.36, 42.09), -- Marker/Shop position for vehicle listing
        },

        targetSettings = {
			vehicleCoords = vector3(1723.95, 4767.36, 42.09), -- Marker/Shop position for vehicle listing
        },

		radius = 1, -- Interaction radius for the markers
		price = 10000, -- Price of the vehicle shop
		blip = {blipId = 734, blipColor = 3, blipColorPurchasable = 1, blipScale = 0.9}, -- Blip informations for vehicleshop blip
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0, textureDict = 0, textureName = 0}, -- Marker informations for the vehicle shop
		type = "offroad", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "offroad", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
	{
		label = "Helicopter Air Shop", -- name of the vehicle shop
		licenseType = "practical_helicopter", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = false, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		blipCoords = vector3(-1010.19, -3028.23, 13.95), -- blip position for the vehicle shop
		isVip = false, -- if set to true IT WON'T BE OWNED BY ANYONE and will use vip coins instead of currency, check sv_utils.lua to change the vip coins functions

		vehicleCameraSettings = {
			location = vector3(-1652.0, -3142.69, 13.99),
			camera = vector4(-1664.49, -3143.34, 16.14, 70.0),
		},

		vehicleSettings = {
			sellVehicleCoords = vector3(-959.5, -2946.55, 12.76), -- position where the vehicles can be sold
			purchaseVehicleCoords = { -- positions where the vehicles will be spawned when the player purchases a vehicle
				{vector4(-1023.91, -3060.6, 13.94, 70.0)},
			}
		},

		testDriveSettings = {
			paid = true, -- true = the player will pay for the test drive | false = the player will not pay for the test drive
			price = 100, -- Price of the test drive
			time = 45, -- Time of the test drive in seconds
			plate = "TEST", -- Plate of the test drive vehicle [max 8 characters]
			carLocation = vector4(-1332.52, -2205.1, 13.34, 151.03), -- Location of the car test drive
			boatLocation = vector4(-796.85, -1502.27, -0.09, 113.55), -- Location of the boat test drive
			airLocation = vector4(-1733.25, -2901.43, 13.94, 330.0), -- Location of the air test drive
		},

        markerSettings = {
			vehicleCoords = vector3(-1010.19, -3028.23, 13.95), -- Marker/Shop position for vehicle listing
        },

        targetSettings = {
			vehicleCoords = vector3(-1010.19, -3028.23, 13.95), -- Marker/Shop position for vehicle listing
        },

        flatbedSettings = {
            spawnPosition = vector4(-947.62, -2976.86, 13.95, 270.0),
            towCoords = {bone = 'bodyshell', xPos = 0.0, yPos = -2.35, zPos = 1.0},
            bigVehicles = true, -- Set to true if it's airplanes/helicopters/etc... it'll use a truck instead of a flatbed to get the ordered vehicles
        },

		missionsVehicleSpawn = { -- Locations where someone who accepted an order will have to go (it is random)
			vector3(-1835.77, 2979.52, 32.81),
		},

		radius = 1, -- Interaction radius for the markers
		price = 12000, -- Price of the vehicle shop
		blip = {blipId = 64, blipColor = 3, blipColorPurchasable = 1, blipScale = 0.9}, -- Blip informations for vehicleshop blip
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0, textureDict = 0, textureName = 0}, -- Marker informations for the vehicle shop
		type = "helicopter", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "helicopter", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
	{
		label = "Airplane Air Shop", -- name of the vehicle shop
		licenseType = "practical_plane", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = false, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		blipCoords = vector3(-949.5, -2946.55, 13.95), -- blip position for the vehicle shop
		isVip = false, -- if set to true IT WON'T BE OWNED BY ANYONE and will use vip coins instead of currency, check sv_utils.lua to change the vip coins functions

		vehicleCameraSettings = {
			location = vector3(-1652.0, -3142.69, 13.99),
			camera = vector4(-1664.49, -3143.34, 16.14, 70.0),
		},

		vehicleSettings = {
			sellVehicleCoords = vector3(-959.5, -2946.55, 12.76), -- position where the vehicles can be sold
			purchaseVehicleCoords = { -- positions where the vehicles will be spawned when the player purchases a vehicle
				{vector4(-1023.91, -3060.6, 13.94, 70.0)},
			}
		},

		testDriveSettings = {
			paid = true, -- true = the player will pay for the test drive | false = the player will not pay for the test drive
			price = 100, -- Price of the test drive
			time = 45, -- Time of the test drive in seconds
			plate = "TEST", -- Plate of the test drive vehicle [max 8 characters]
			carLocation = vector4(-1332.52, -2205.1, 13.34, 151.03), -- Location of the car test drive
			boatLocation = vector4(-796.85, -1502.27, -0.09, 113.55), -- Location of the boat test drive
			airLocation = vector4(-1733.25, -2901.43, 13.94, 330.0), -- Location of the air test drive
		},

        markerSettings = {
			vehicleCoords = vector3(-949.5, -2946.55, 13.95), -- Marker/Shop position for vehicle listing
        },

        targetSettings = {
			vehicleCoords = vector3(-949.5, -2946.55, 13.95), -- Marker/Shop position for vehicle listing
        },

        flatbedSettings = {
            spawnPosition = vector4(-947.62, -2976.86, 13.95, 270.0),
            towCoords = {bone = 'bodyshell', xPos = 0.0, yPos = -2.35, zPos = 1.0},
            bigVehicles = true, -- Set to true if it's airplanes/helicopters/etc... it'll use a truck instead of a flatbed to get the ordered vehicles
        },

		missionsVehicleSpawn = { -- Locations where someone who accepted an order will have to go (it is random)
			vector3(-1835.77, 2979.52, 32.81),
		},

		radius = 1, -- Interaction radius for the markers
		price = 12000, -- Price of the vehicle shop
		blip = {blipId = 90, blipColor = 3, blipColorPurchasable = 1, blipScale = 0.9}, -- Blip informations for vehicleshop blip
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0, textureDict = 0, textureName = 0}, -- Marker informations for the vehicle shop
		type = "airplane", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "airplane", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
	{
		label = "Boat Shop", -- name of the vehicle shop
		licenseType = "practical_boat", -- if you want to use a license system you'll need to set it up on sv_utils.lua
		currency = "bank", -- used to buy/sell the business and buy vehicle
		hasOwner = false, -- true = this vehicle shop can have a owner and will need maintenance to have stock | false = no owner and with vehicles all the time, price = max_price set on the database
		blipCoords = vector3(-720.77, -1324.92, 1.6), -- blip position for the vehicle shop
		isVip = false, -- if set to true IT WON'T BE OWNED BY ANYONE and will use vip coins instead of currency, check sv_utils.lua to change the vip coins functions

		vehicleCameraSettings = {
			location = vector3(-828.54, -1448.08, -0.5),
			camera = vector4(-841.03, -1448.73, 2.65, 70.0),
		},

		vehicleSettings = {
			sellVehicleCoords = vector3(-721.56, -1306.7, 3.82), -- position where the vehicles can be sold
			purchaseVehicleCoords = { -- positions where the vehicles will be spawned when the player purchases a vehicle
				{vector4(-706.78, -1333.57, 2.0, 70.0)},
			}
		},

		testDriveSettings = {
			paid = true, -- true = the player will pay for the test drive | false = the player will not pay for the test drive
			price = 100, -- Price of the test drive
			time = 45, -- Time of the test drive in seconds
			plate = "TEST", -- Plate of the test drive vehicle [max 8 characters]
			carLocation = vector4(-1332.52, -2205.1, 13.34, 151.03), -- Location of the car test drive
			boatLocation = vector4(-878.02, -1360.32, 2.0, 330.0), -- Location of the boat test drive
			airLocation = vector4(-1332.52, -2205.1, 13.34, 151.03), -- Location of the air test drive
		},

        markerSettings = {
			vehicleCoords = vector3(-720.77, -1324.92, 1.6), -- Marker/Shop position for vehicle listing
        },

        targetSettings = {
			vehicleCoords = vector3(-720.77, -1324.92, 1.6), -- Marker/Shop position for vehicle listing
        },

        flatbedSettings = {
            spawnPosition = vector4(-719.77, -1286.15, 5.0, 120.0),
            towCoords = {bone = 'bodyshell', xPos = 0.0, yPos = -2.35, zPos = 1.0},
            bigVehicles = true, -- Set to true if it's airplanes/helicopters/etc... it'll use a truck instead of a flatbed to get the ordered vehicles
        },

		missionsVehicleSpawn = { -- Locations where someone who accepted an order will have to go (it is random)
			vector3(-758.15, -1488.26, 5.0),
		},

		radius = 1, -- Interaction radius for the markers
		price = 14000, -- Price of the vehicle shop
		blip = {blipId = 427, blipColor = 3, blipColorPurchasable = 1, blipScale = 0.9}, -- Blip informations for vehicleshop blip
		marker = {id = 20, color = {r = 31, g = 94, b = 255, a = 90}, size = {x = 0.5, y = 0.5, z = 0.5}, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0, textureDict = 0, textureName = 0}, -- Marker informations for the vehicle shop
		type = "boat", -- Type of shop (will change displayed vehicles) | CAN be repeated on other shops
		id = "boat", -- ID of the shop, it's used to get what shop is opened | needs to be DIFFERENT for each shop
	},
}
Config, Locales = {}, {}

-- =========================
-- CORE/TOGGLES
-- =========================
Config.Debug = true -- true = will print some debug messages
Config.Locale = 'en' -- en
Config.AddVehiclesFromVehiclesFile = false -- true = will add vehicles from qbcore/shared/vehicles.lua
Config.QBPermissionsUpdate = true -- set it to true if you have the latest Permissions update
Config.UseRoutingBuckets = true -- true = use routing buckets | false = don't use routing buckets
Config.UseNewStaffCheckMethod = false -- only works if Config.QBPermissionsUpdate is set to true
Config.PayForOrder = true -- true = pay for the vehicle when you order it | false = don't pay and only receive the profit when selling
Config.SetVisibility = true -- true = player will be invisible when chosing a vehicle
Config.SetInvincibility = true -- true = player will not die while test driving
Config.CheckForOfflineOrdersEvery = 10 -- In minutes | it'll check every x minutes for offline players with orders accepted, if someone is offline it'll cancel the order
Config.ShowVehicleShopBlip = true -- Activate/Deactivate Vehicle shop blips
Config.ShowOwnerBlip = false -- Activate/Deactivate owner blips
Config.ShowBuyVehicleShopBlip = false -- Activate/Deactivate buy shop blip
Config.ShowHasOwnerShopBlip = true -- Activate/Deactivate blip of shops with "hasOwner = false"
Config.TestDrive = true -- Activate/Deactivate test drive
Config.DevMode = true -- Allows you to restart the script (IMPORTANT: only set this to true if you are configuring the script)
Config.EventPrefix = "okokVehicleshop" -- this will change the prefix of the events name so if Config.EventPrefix = "example" the events will be "example:event"
Config.QBCorePrefix = "QBCore"
Config.qbPrefix = "qb"
Config.TestDrivePlate = "OLRP"

-- Notifications/UI/Integrations
Config.UseOkokNotify = GetResourceState('okokNotify') == 'started' and true or false -- if you want to use okokNotify set it to true
Config.UseOkokTextUI = GetResourceState('okokTextUI') == 'started' and true or false -- if you want to use okokTextUI set it to true
Config.UseOkokRequests = false -- true = use okokRequests for hiring people | false = don't use okokRequests - https://okok.tebex.io/package/4724985
Config.SocietyGarage = "cd_garage" -- Used for society purchases and trade-in vehicles
Config.KeySystem = 'dusa-vehiclekeys' -- qb-vehiclekeys (change on cl_utils.lua)
Config.UseSameImageForVehicles = true -- true = use the same image for all vehicles (vehicle.png) | false = use different images for each vehicle (vehicle_id.png)
Config.HideMinimap = true -- If true it'll hide the minimap when the vehicle shop menu is opened
Config.TimeBetweenTransition = 7000 -- how much time it stays in a camera before changing, in miliseconds
Config.TransitionTime = 4000 -- how much time it takes to go from one camera to another (camera movement), in miliseconds
Config.ShakeAmplitude = 0.2 -- camera shake
Config.UseKMh = true -- true = use KM/h | false = use miles/h
Config.MaxVehiclesSpeed = 320 -- Max speed a vehicle can go at (it is only used for UI purposes, it does NOT change the speed of a vehicle)
Config.TestDriveTime = 40 -- In seconds ---- OLD VALUE CHANGING WHILE BEEING USED: 40
Config.StopTestDriveCmd = "cancel" -- command to stop the test drive

-- Vehicle Listing Settings
Config.VehicleListingType = 'categories' -- 'normal' all vehicles in the same page | 'categories' all vehicles in categories
Config.DatabaseUpdateInterval = 300 -- How often the database will be updated in seconds
Config.UseSameImageForAllVehicles = false -- true = will use the same image for all vehicles (web/img/vehicles/default.png) | false = will use the image from the vehicle_id
Config.UseLocalImages = false -- true = will use images from /web/img/vehicles | false = it will get the images from the github repository, if not found it will use an image from the web/img/vehicles/

-- Input/Target
Config.UseTarget = false -- true = will use target | false = will use marker
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
Config.PlatePrefix = "OLRP" -- The prefix for the plate

-- Interface/History Settings
Config.SalesDateFormat = "%d/%m - %H:%M" -- Format of the sales date
Config.MaxLogsDays = 7 -- How many days to keep the logs on the UI (the old ones it will be saved on the database)
Config.MaxEntriesOnVehicleHistory = 24 -- How many entries to keep on the vehicle history to avoid any performance issues

-- Vehicle Classes
Config.UseVehicleClasses = true -- If you want to use vehicle classes set it to true
Config.CalculateVehicleClasses = true -- If you want to enable vehicle class calculation set it to true
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
Config.SellVehiclePercentage = 35 -- When a player sells a vehicle to the vehicle shop he will get a percentage of the vehicle price, 50 = 50%
Config.EnableTradeIns = true -- If true = players can trade-in their vehicles for a discount on a new vehicle
Config.TradeInPercentage = 50 -- This is the percentage of the vehicle price that will be given as a discount for the trade-in
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

-- =========================
-- NOTIFICATION SYSTEMS
-- =========================
Config.Requests = { -- Requests texts
	['be_hired'] = { 			text = 'Do you want to be hired by ${name}?'},
}

Config.TextUI = { -- Text UI texts
	['open_shop'] = { 			text = '[E] To open ${shop_name}', 										color = 'darkblue', side = 'right'},
	['buy_business'] = { 		text = '[E] to buy ${name} for ${price}€', 								color = 'darkblue', side = 'right'},
	['access_business'] = { 	text = '[E] to access ${name}', 										color = 'darkblue', side = 'right'},
	['tow'] = { 				text = '[E] To tow', 													color = 'darkblue', side = 'right'},
	['sell_vehicle'] = { 		text = '[E] To sell vehicle', 											color = 'darkblue', side = 'right'},
}

Config.HelpNotification = { -- Used when Config.UseTextUI = false
	['open_shop'] = { 			text = '[E] To open ${shop_name}',										type = 'success', time = 5000},
	['buy_business'] = { 		text = '[E] to buy ${name} for ${price}€',								type = 'success', time = 5000},
	['access_business'] = { 	text = '[E] to access ${name}',											type = 'success', time = 5000},
	['tow'] = { 				text = '[E] To tow',													type = 'success', time = 5000},
	['sell_vehicle'] = { 		text = '[E] To sell vehicle',													type = 'success', time = 5000},
}

Config.NotificationsText = { -- Notifications texts
	['success_cancel'] = {		title = "Vehicle Shop", 		text = "Successfully canceled the order",											time = 5000, type = "success"},
	['fail_cancel'] = {			title = "Vehicle Shop", 		text = "Failed to cancel the order",												time = 5000, type = "error"},
	['cant_access'] = {			title = "Vehicle Shop", 		text = "You don't have permission to access this shop",								time = 5000, type = "error"},
	['no_license'] = {			title = "Vehicle Shop", 		text = "You have no license to buy this vehicle",									time = 5000, type = "error"},
	['all_occupied'] = {		title = "Vehicle Shop", 		text = "All vehicle entrances are occupied",										time = 5000, type = "error"},
	['failed_to_load'] = {		title = "Vehicle Shop", 		text = "Failed to load the vehicle", 												time = 5000, type = "error"},
	['bus_no_money'] = {		title = "Vehicle Shop", 		text = "This business doesn't have enough money", 									time = 5000, type = "error"},
	['success_sell'] = {		title = "Vehicle Shop", 		text = "You sold ${vehicle_name} for ${price}€ successfully", 						time = 5000, type = "success"},
	['not_in_correct_v'] = {	title = "Vehicle Shop", 		text = "You are not in the correct vehicle", 										time = 5000, type = "error"},
	['dont_sell'] = {			title = "Vehicle Shop", 		text = "This vehicle shop don't buy this vehicle", 									time = 5000, type = "error"},
	['not_your_vehicle'] = {	title = "Vehicle Shop", 		text = "You don't own this vehicle", 												time = 5000, type = "error"},
	['not_in_vehicle'] = {		title = "Vehicle Shop", 		text = "You need to be on a vehicle", 												time = 5000, type = "error"},
	['not_admin'] = {			title = "Vehicle Shop", 		text = "You don't have permission to access the admin menu", 						time = 5000, type = "error"},
	['inside_vehicle'] = {		title = "Vehicle Shop", 		text = "You can't access the vehicle shop inside a vehicle", 						time = 5000, type = "error"},
	['load_vehicle'] = {		title = "Vehicle Shop", 		text = "Loading vehicle, please wait", 												time = 3000, type = "info"},
	['stop_testdrive'] = {		title = "Vehicle Shop", 		text = "Stopping the test drive", 													time = 5000, type = "success"},
	['not_testdriving'] = {		title = "Vehicle Shop", 		text = "You are not on a test drive", 												time = 5000, type = "error"},
	['fill_fields'] = {			title = "Vehicle Shop", 		text = "Please fill the input field", 												time = 5000, type = "error"},
	['already_accepted'] = {	title = "Vehicle Shop", 		text = "You already accepted an order, complete it before accepting another",		time = 5000, type = "error"},
	['not_selected_hire'] = {	title = "Vehicle Shop", 		text = "No one was selected", 														time = 5000, type = "error"},
	['ordered_success'] = {		title = "Vehicle Shop", 		text = "You ordered x${amount} ${vehicle_name} successfully!", 						time = 5000, type = "success"},
	['some_wrong'] = {			title = "Vehicle Shop", 		text = "Something went wrong!", 													time = 5000, type = "error"},
	['not_enough_money'] = {	title = "Vehicle Shop", 		text = "You don't have enough money", 												time = 5000, type = "error"},
	['not_enough_money_s'] = {	title = "Vehicle Shop", 		text = "Your society doesn't have enough money", 									time = 5000, type = "error"},
	['accepted_order'] = {		title = "Vehicle Shop", 		text = "You accepted an order successfully", 										time = 5000, type = "success"},
	['someone_accepted'] = {	title = "Vehicle Shop", 		text = "Someone has already accepted this order", 									time = 5000, type = "error"},
	['finished_order'] = {		title = "Vehicle Shop", 		text = "You successfully finished the order and received ${reward}€", 				time = 5000, type = "success"},
	['no_ads_cancel'] = {		title = "Vehicle Shop", 		text = "You don't have any ads to cancel", 											time = 5000, type = "error"},
	['veh_not_available'] = {	title = "Vehicle Shop", 		text = "This vehicle isn't available", 												time = 5000, type = "error"},
	['price_not_valid'] = {		title = "Vehicle Shop", 		text = "This is not a valid price", 												time = 5000, type = "error"},
	['employee_not_exist'] = {	title = "Vehicle Shop", 		text = "This employee does not exist", 												time = 5000, type = "error"},
	['not_enough_to_sell'] = {	title = "Vehicle Shop", 		text = "You don't have enough vehicles to sell", 									time = 5000, type = "error"},
	['got_hired'] = {			title = "Vehicle Shop", 		text = "You got hired by ${shop_name}", 											time = 5000, type = "info"},
	['got_fired'] = {			title = "Vehicle Shop", 		text = "You got fired by ${shop_name}", 											time = 5000, type = "info"},
	['success_hired'] = {		title = "Vehicle Shop", 		text = "You successfully hired ${hired_name}", 										time = 5000, type = "success"},
	['success_fired'] = {		title = "Vehicle Shop", 		text = "You successfully fired ${fired_name}", 										time = 5000, type = "success"},
	['success_added_ad'] = {	title = "Vehicle Shop", 		text = "Added x${amount} ${vehicle_name} ads", 										time = 5000, type = "success"},
	['deposited'] = {			title = "Vehicle Shop", 		text = "Deposited ${amount}€ successfully", 										time = 5000, type = "success"},
	['withdrawn'] = {			title = "Vehicle Shop", 		text = "Whitdrawn ${amount}€ successfully", 										time = 5000, type = "success"},
	['bought_veh'] = {			title = "Vehicle Shop", 		text = "Bought ${vehicle_name} for ${vehiclePrice}€", 								time = 5000, type = "success"},
	['change_money'] = {		title = "Vehicle Shop", 		text = "Changed the ${shop_name} money to ${money} successfully", 					time = 5000, type = "success"},
	['change_info'] = {			title = "Vehicle Shop", 		text = "Changed the ${vehicle_name} informations successfully", 					time = 5000, type = "success"},
	['remove_veh'] = {			title = "Vehicle Shop", 		text = "Removed the ${vehicle_name} successfully", 									time = 5000, type = "success"},
	['created_veh'] = {			title = "Vehicle Shop", 		text = "Created a ${vehicle_name} successfully", 									time = 5000, type = "success"},
	['cancel_ads'] = {			title = "Vehicle Shop", 		text = "Canceled x${amount} ${vehicle_name} ads", 									time = 5000, type = "success"},
	['updated_price'] = {		title = "Vehicle Shop", 		text = "Updated price of ${vehicle_name} to ${amount}€", 							time = 5000, type = "success"},
	['change_rank'] = {			title = "Vehicle Shop", 		text = "${name} is now a ${job}", 													time = 5000, type = "success"},
	['already_rank'] = {		title = "Vehicle Shop", 		text = "${name} is already a ${job}", 												time = 5000, type = "error"},
	['already_employee'] = {	title = "Vehicle Shop", 		text = "${name} is your employee already", 											time = 5000, type = "error"},
	['max_shops'] = {			title = "Vehicle Shop", 		text = "You can't buy more dealerships",											time = 5000, type = "error"},
	['got_to_truck'] = {		title = "Vehicle Shop", 		text = "Go get the order marked in your minimap", 									time = 5000, type = "info"},
	['not_towing'] = {			title = "Vehicle Shop", 		text = "You need to be closer to the ordered vehicle", 								time = 5000, type = "error"},
	['towed'] = {				title = "Vehicle Shop",			text = "You successfully towed the ordered vehicle", 								time = 5000, type = "success"},
	['sold_business'] = {		title = "Vehicle Shop", 		text = "You successfully sold ${shop} for ${amount}€", 								time = 5000, type = "success"},
	['leave_business'] = {		title = "Vehicle Shop", 		text = "You successfully left ${shop}", 											time = 5000, type = "success"},
	['min_max_price'] = {		title = "Vehicle Shop", 		text = "The minimum price needs to be less than the maximum price", 				time = 5000, type = "error"},
	['owner_changed'] = {		title = "Vehicle Shop", 		text = "${owner} is now the owner of ${shop}", 										time = 5000, type = "success"},
	['max_employees'] = {		title = "Vehicle Shop", 		text = "You can only hire ${employees} employees", 									time = 5000, type = "error"},
}

-- =========================
-- DISCORD WEBHOOKS
-- =========================
Config.BotName = 'OneLife Bot' -- Write the desired bot name
Config.ServerName = 'OneLife Roleplay' -- Write your server's name
Config.IconURL = '' -- Insert your desired image link
Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

Config.BuyBusinessWebhook = true
Config.BuyBusinessWebhookColor = '65280'
Config.SellBusinessWebhook = true
Config.SellBusinessWebhookColor = '16711680'
Config.DepositWebhook = true
Config.DepositWebhookColor = '16776960'
Config.WithdrawWebhook = true
Config.WithdrawWebhookColor = '16776960'
Config.StartOrderWebhook = true
Config.StartOrderWebhookColor = '16742656'
Config.EndOrderWebhook = true
Config.EndOrderWebhookColor = '16742656'
Config.HireWebhook = true
Config.HireWebhookColor = '4223487'
Config.FireWebhook = true
Config.FireWebhookColor = '4223487'
Config.BuyVehicleWebhook = true
Config.BuyVehicleWebhookColor = '65535'
Config.ADStockWebhook = true
Config.ADStockWebhookColor = '7209071'
Config.CancelStockWebhook = true
Config.CancelStockWebhookColor = '7209071'
Config.BuyStockWebhook = true
Config.BuyStockWebhookColor = '7209071'
Config.EditEmployeeRankWebhook = true
Config.EditEmployeeRankWebhookColor = '4223487'
Config.QuitJobWebhook = true
Config.QuitJobWebhookColor = '16711680'
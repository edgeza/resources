Config = {}

Config.trucker_logistics = {					-- Settings related to the link with the Truck Logistics script
	['enable'] = false,							-- Set this as true if you own the Truck Logistics script and want to link the jobs created in the Hire Deliveryman page with the truckers
	['quick_jobs_page'] = true,					-- true: The jobs created will appear in the Quick jobs page in the trucker logistics (it uses a rented truck). false: They will appear in the Freights page (it requires an owned truck)
	['available_trucks'] = {					-- List of trucks that are generated in contracts
		"hauler","packer"
	},
	['available_trailers'] = {					-- List of trailers that are generated in contracts
		"trailers", "trailers2", "trailers3"
	}
}

Config.max_stores_per_player = 1				-- Maximum number of stores that each player can have
Config.max_stores_employed = 2					-- Maximum number of stores that each player can be employed
Config.has_stock_when_unowed = true				-- If true, the store stock will be full stock when there is no owner. If false, the store stock will be empty when there is no owner
Config.max_jobs = 20							-- Max amount of jobs that each store can create
Config.disable_rename_business = false 			-- Set this to true if you want to disable the function to rename the business
Config.group_map_blips = true					-- true: will group all the blips into a single category in the map. false: all the blips will be grouped just by the name and icon
Config.charge_import_money_before = true 		-- true: The money will be deducted from the store balance when the player starts the job. false: The money will be deducted only after the player finishes the job

-- Here are the places where the person can open the market menu
-- You can add as many locations as you want, just use the location already created as an example
Config.market_locations = {
	["market_1"] = {															-- ID
		['buy_price'] = 220000,													-- Price to buy this market
		['sell_price'] = 110000,												-- Price to sell this market
		['coord'] = {0,0,0},		-- Coordinate to open the menu (vector3)
		['garage_coord'] = {-707.13,-924.98,19.02,179.01},						-- Garage coordinates, where the trucks will spawn (vector4)
		['truck_parking_location'] = {-707.95, -929.8, 19.01, 180.0},			-- Location that the trucks from Trucker Logistics script will park when delivering cargo for this store (vector3)
		['map_blip_coord'] = {-714.77,-912.22,19.21},							-- Map blip coordinates, where the map blip will appear (vector3)
		['sell_blip_coords'] = {												-- The coordinates where customes will buy things on this store (vector3)
			{-707.36, -914.0, 19.22},
		},
		['deliveryman_coord'] = {0,0,0},							-- Coord where the deliveryman will take the jobs you've created
		['type'] = '247store', 													-- Insert here the market type ID
		['account'] = {															-- Account settings for this store
			['item'] = {														-- Account that the money should be debited when buying item in the market (player can choose between 2)
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',													-- Account that should be used with store expenses (owner)
		}
	},
	["market_2"] = {
		['buy_price'] = 300000,
		['sell_price'] = 150000,
		['coord'] = {0,0,0},
		['garage_coord'] = {15.3,-1345.17,29.29,179.17},
		['truck_parking_location'] = {24.0538,-1357.3694, 29.503,88.4017},
		['map_blip_coord'] = {25.71,-1346.47,29.49},
		['sell_blip_coords'] = {
			{25.96, -1346.96, 29.5},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_3"] = {
		['buy_price'] = 110000,
		['sell_price'] = 55000,
		['coord'] = {0,0,0},
		['garage_coord'] = {2588.82,413.31,108.46,178.94},
		['truck_parking_location'] = {2564.896,366.3779, 108.7248,177.4842},
		['map_blip_coord'] = {2556.73,382.11,108.62},
		['sell_blip_coords'] = {
			{2556.7, 382.32, 108.62},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_4"] = {
		['buy_price'] = 180000,
		['sell_price'] = 90000,
		['coord'] = {0,0,0},
		['garage_coord'] = {1155.32,-336.2,68.35,188.49},
		['truck_parking_location'] = {1184.322,-314.0848, 69.4398,279.8044},
		['map_blip_coord'] = {1163.42,-322.91,69.20},
		['sell_blip_coords'] = {
			{1163.47, -323.17, 69.21},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_5"] = {
		['buy_price'] = 130000,
		['sell_price'] = 65000,
		['coord'] = {0,0,0},
		['garage_coord'] = {-1821.48,777.52,137.43,216.69},
		['truck_parking_location'] = {-1807.3877,789.4099, 138.4138,220.8947},
		['map_blip_coord'] = {-1820.92,793.17,138.11},
		['sell_blip_coords'] = {
			{-1820.96, 793.34, 138.11},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_6"] = {
		['buy_price'] = 150000,
		['sell_price'] = 75000,
		['coord'] = {0,0,0},
		['garage_coord'] = {366.43,332.03,103.51,165.15},
		['truck_parking_location'] = {361.3589,319.2109, 103.9061,76.4428},
		['map_blip_coord'] = {374.20,326.91,103.56},
		['sell_blip_coords'] = {
			{372.54, 327.00, 105.10},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_7"] = {
		['buy_price'] = 120000,
		['sell_price'] = 60000,
		['coord'] = {0,0,0},
		['garage_coord'] = {-3243.39,991.74,12.48,272.72},
		['truck_parking_location'] = {-3234.5576,1009.0838, 12.4311,177.7641},
		['map_blip_coord'] = {-3242.96,1001.31,12.83},
		['sell_blip_coords'] = {
			{-3243.01, 999.73, 14.32},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_8"] = {
		['buy_price'] = 70000,
		['sell_price'] = 35000,
		['coord'] = {0,0,0},
		['garage_coord'] = {1718.27,6418.38,33.45,152.26},
		['truck_parking_location'] = {1713.1648,6410.5093, 33.6366,155.0778},
		['map_blip_coord'] = {1729.38,6415.42,35.03},
		['sell_blip_coords'] = {
			{1728.23, 6416.07, 35.04},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_9"] = {
		['buy_price'] = 130000,
		['sell_price'] = 65000,
		['coord'] = {0,0,0},
		['garage_coord'] = {533.9,2667.9,42.28,8.76},
		['truck_parking_location'] = {533.3693,2669.5442, 42.5447,7.0399},
		['map_blip_coord'] = {547.74,2671.56,42.15},
		['sell_blip_coords'] = {
			{549.17, 2670.84, 43.59},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_10"] = {
		['buy_price'] = 120000,
		['sell_price'] = 60000,
		['coord'] = {0,0,0},
		['garage_coord'] = {1972.04,3746.88,32.32,209.52},
		['truck_parking_location'] = {1696.6696,3742.3357, 34.1548,225.9438},
		['map_blip_coord'] = {1961.35,3741.49,32.34},
		['sell_blip_coords'] = {
			{1959.63, 3740.47, 33.73},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	--["market_11"] = {
	--	['buy_price'] = 120000,
	--	['sell_price'] = 60000,
	--	['coord'] = {0,0,0},
	--	['garage_coord'] = {2689.24,3272.53,55.25,328.87},
	--	['truck_parking_location'] = {2651.1384,3263.427, 55.4719,151.0635},
	--	['map_blip_coord'] = {2679.80,3286.73,55.24},
	--	['sell_blip_coords'] = {
	--		{2677.33, 3279.56, 56.59},
	--		{2678.69, 3282.87, 55.24},
	--	},
	--	['deliveryman_coord'] = {0,0,0},
	--	['type'] = '247store',
	--	['account'] = {
	--		['item'] = {
	--			[1] = {
	--				['icon'] = 'img/credit_card.png',
	--				['account'] = 'bank'
	--			},
	--			[2] = {
	--				['icon'] = 'img/cash.png',
	--				['account'] = 'cash'
	--			}
	--		},
	---		['store'] = 'bank',
	--	}
	--},
	["market_12"] = {
		['buy_price'] = 70000,
		['sell_price'] = 35000,
		['coord'] = {0,0,0},
		['garage_coord'] = {1689.02,4919.69,42.08,57.01},
		['truck_parking_location'] = {1686.8475,4922.3828, 42.3414,55.4782},
		['map_blip_coord'] = {1700.00,4925.55,42.06},
		['sell_blip_coords'] = {
			{1698.82, 4923.95, 42.066},

		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_13"] = {
		['buy_price'] = 240000,
		['sell_price'] = 120000,
		['coord'] = {0,0,0},
		['garage_coord'] = {-63.1,-1742.7,29.31,57.2},
		['truck_parking_location'] = {-20.8732,-1767.8015, 29.4571,231.7498},
		['map_blip_coord'] = {-50.81,-1754.87,29.42},
		['sell_blip_coords'] = {
			{-47.87, -1757.27, 29.42},

		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_14"] = {
		['buy_price'] = 120000,
		['sell_price'] = 60000,
		['coord'] = {0,0,0},
		['garage_coord'] = {1384.52,3593.7,34.9,210.34},
		['truck_parking_location'] = {1381.198,3594.0959, 35.1478,200.0481},
		['map_blip_coord'] = {1398.45,3607.05,34.98},
		['sell_blip_coords'] = {
			{1392.78, 3606.37, 34.98},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_15"] = {
		['buy_price'] = 110000,
		['sell_price'] = 45000,
		['coord'] = {0,0,0},
		['garage_coord'] = {-3045.94,598.67,7.49,287.24},
		['truck_parking_location'] = {-3032.1746,594.4594, 7.9666,18.8748},
		['map_blip_coord'] = {-3041.66,586.27,7.90},
		['sell_blip_coords'] = {
			{-3039.53, 584.18, 9.35},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["market_16"] = {
		['buy_price'] = 130000,
		['sell_price'] = 65000,
		['coord'] = {0,0,0},
		['garage_coord'] = {1169.43,2694.08,37.84,85.41},
		['truck_parking_location'] = {1181.8191,2695.3115, 38.2108,268.9558},
		['map_blip_coord'] = {1164.06,2707.60,38.15},
		['sell_blip_coords'] = {
			{1165.81, 2710.82, 38.16},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = '247store',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	--["market_18"] = {
	--	['buy_price'] = 70000,
	--	['sell_price'] = 35000,
	--	['coord'] = {0,0,0},
	--	['garage_coord'] = {146.9,6634.98,31.61,175.81},
	--	['truck_parking_location'] = {164.0575,6625.502, 32.0364,225.7734},
	--	['map_blip_coord'] = {164.15,6641.15,31.71},
	--	['sell_blip_coords'] = {
	--		{164.15994262695,6641.15625,31.710638046265},
	--		{167.01026916504,6637.4892578125,31.710649490356},
	--	},
	--	['deliveryman_coord'] = {0,0,0},
	--	['type'] = '247store',
	--	['account'] = {
	--		['item'] = {
	--			[1] = {
	--				['icon'] = 'img/credit_card.png',
	--				['account'] = 'bank'
	--			},
	--			[2] = {
	--				['icon'] = 'img/cash.png',
	--				['account'] = 'cash'
	--			}
	--		},
	--		['store'] = 'bank',
	--	}
	--},
	["digitalden1"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {27.71,-1113.25,29.3,329.89},
		['truck_parking_location'] = {-13.8833,-1125.8661, 27.5543,157.6875},
		['map_blip_coord'] = {1128.6, -471.09, 66.54}, -- 1128.6, -471.09, 66.54
		['sell_blip_coords'] = {
			{1128.6, -471.09, 66.54},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'digitalden',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},

	["digitalden2"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {27.71,-1113.25,29.3,329.89},
		['truck_parking_location'] = {-13.8833,-1125.8661, 27.5543,157.6875},
		['map_blip_coord'] = {-659.98, -863.17, 24.5}, -- vector4(-659.98, -863.17, 24.5, 358.3)
		['sell_blip_coords'] = {
			{-659.98, -863.17, 24.5},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'digitalden',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["digitalden3"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {27.71,-1113.25,29.3,329.89},
		['truck_parking_location'] = {-13.8833,-1125.8661, 27.5543,157.6875},
		['map_blip_coord'] = {388.43, -825.02, 29.29}, -- vector4(388.43, -825.02, 29.29, 184.3)
		['sell_blip_coords'] = {
			{388.43, -825.02, 29.29},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'digitalden',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["digitalden4"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {27.71,-1113.25,29.3,329.89},
		['truck_parking_location'] = {-13.8833,-1125.8661, 27.5543,157.6875},
		['map_blip_coord'] = {1648.32, 4850.89, 42.0}, -- vector4(1648.32, 4850.89, 42.0, 272.33)
		['sell_blip_coords'] = {
			{1648.32, 4850.89, 42.0},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'digitalden',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["digitalden5"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {27.71,-1113.25,29.3,329.89},
		['truck_parking_location'] = {-13.8833,-1125.8661, 27.5543,157.6875},
		['map_blip_coord'] = {-1315.78, -404.8, 36.61}, -- vector4(-1315.78, -404.8, 36.61, 30.77)
		['sell_blip_coords'] = {
			{-1315.78, -404.8, 36.61},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'digitalden',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["digitalden6"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {27.71,-1113.25,29.3,329.89},
		['truck_parking_location'] = {-13.8833,-1125.8661, 27.5543,157.6875},
		['map_blip_coord'] = {-33.94, -1041.9, 28.51}, -- vector4(-33.94, -1041.9, 28.51, 67.8)
		['sell_blip_coords'] = {
			{-33.94, -1041.9, 28.51},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'digitalden',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["ammunation2"] = {
		['buy_price'] = 2000000,				-- Same as Digital Den (high price to prevent purchase)
		['sell_price'] = 500000,				-- Same as Digital Den
		['coord'] = {0,0,0},					-- Same as Digital Den (no owner access)
		['garage_coord'] = {13.85, -1104.86, 29.11, 0.0},
		['truck_parking_location'] = {13.85, -1104.86, 29.11, 0.0},
		['map_blip_coord'] = {17.58, -1107.72, 29.8},
		['sell_blip_coords'] = {
			{14.01, -1105.23, 29.11},
		},
		['deliveryman_coord'] = {0,0,0},		-- Same as Digital Den
		['type'] = 'ammunation',
		['account'] = {							-- Account settings for this store
			['item'] = {														-- Account that the money should be debited when buying item in the market (player can choose between 2)
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',													-- Account that should be used with store expenses (owner)
		}
	},
	["ammunation3"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {13.85, -1104.86, 29.11, 0.0},
		['truck_parking_location'] = {13.85, -1104.86, 29.11, 0.0},
		['map_blip_coord'] = {248.32, -51.91, 69.94},
		['sell_blip_coords'] = {
			{248.32, -51.91, 69.94},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'ammunation',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["ammunation4"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {13.85, -1104.86, 29.11, 0.0},
		['truck_parking_location'] = {13.85, -1104.86, 29.11, 0.0},
		['map_blip_coord'] = {-1303.69, -394.4, 36.7},
		['sell_blip_coords'] = {
			{-1303.69, -394.4, 36.7},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'ammunation',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["ammunation5"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {13.85, -1104.86, 29.11, 0.0},
		['truck_parking_location'] = {13.85, -1104.86, 29.11, 0.0},
		['map_blip_coord'] = {841.1, -1029.97, 28.19},
		['sell_blip_coords'] = {
			{841.1, -1029.97, 28.19},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'ammunation',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["ammunation6"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {13.85, -1104.86, 29.11, 0.0},
		['truck_parking_location'] = {13.85, -1104.86, 29.11, 0.0},
		['map_blip_coord'] = {1697.17, 3758.22, 34.71},
		['sell_blip_coords'] = {
			{1697.17, 3758.22, 34.71},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'ammunation',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},
	["ammunation7"] = {
		['buy_price'] = 2000000,
		['sell_price'] = 500000,
		['coord'] = {0,0,0},
		['garage_coord'] = {13.85, -1104.86, 29.11, 0.0},
		['truck_parking_location'] = {13.85, -1104.86, 29.11, 0.0},
		['map_blip_coord'] = {-327.23, 6082.41, 31.45},
		['sell_blip_coords'] = {
			{-327.23, 6082.41, 31.45},
		},
		['deliveryman_coord'] = {0,0,0},
		['type'] = 'ammunation',
		['account'] = {
			['item'] = {
				[1] = {
					['icon'] = 'img/credit_card.png',
					['account'] = 'bank'
				},
				[2] = {
					['icon'] = 'img/cash.png',
					['account'] = 'cash'
				}
			},
			['store'] = 'bank',
		}
	},

}

-- Here you configure each type of market available to buy
Config.market_types = {
	['247store'] = {							-- Market type ID
		['stock_capacity'] = 150,				-- Max stock capacity
		['max_employees'] = 5,					-- Max employees
		['required_job'] = {},					-- Required job do purchase goods in this store (set to {} to dont require any job here, or put the job name there like this: ['required_job'] = {'cop', 'gang', 'job_name'},)
		['upgrades'] = {						-- Definition of each upgrade
			['stock'] = {						-- Stock capacity
				['price'] = 8000,				-- Price to upgrade
				['level_reward'] = {			-- Reward of each level (max level: 5)
					[0] = 0,
					[1] = 50,
					[2] = 100,
					[3] = 150,
					[4] = 200,
					[5] = 300,
				}
			},
			['truck'] = {						-- Truck capacity
				['price'] = 12000,
				['level_reward'] = {
					[0] = 0,
					[1] = 25,
					[2] = 50,
					[3] = 100,
					[4] = 200,
					[5] = 300,
				}
			},
			['relationship'] = {				-- Relationship
				['price'] = 11000,
				['level_reward'] = {
					[0] = 0,
					[1] = 5,
					[2] = 10,
					[3] = 15,
					[4] = 25,
					[5] = 40,
				}
			},
		},
		['trucks'] = {							-- Trucks for each level when upgrade the truck cargo
			[0] = 'speedo',
			[1] = 'gburrito',
			[2] = 'mule',
			[3] = 'mule3',
			[4] = 'pounder',
			[5] = 'pounder2'
		},
		['max_purchasable_categories'] = 4,		-- The max amount of categories that can be purchased
		['categories'] = {						-- Here you configure the categories available to purchase in your store
			"food_market", "drink_market", "alcohol_market"
		},
		['default_categories'] = {				-- Here you can configure the categories available when the store has no owner
			"food_market", "drink_market", "alcohol_market"
		},
		['blips'] = {							-- Create the blips on map
			['id'] = 52,						-- Blip ID [Set this value 0 to dont have blip]
			['name'] = "Market",				-- Blip Name [Will be replaced when the owner rename the store]
			['color'] = 4,						-- Blip Color
			['scale'] = 0.6,					-- Blip Scale
		}
	},

	['digitalden'] = {							-- Market type ID
		['stock_capacity'] = 150,				-- Max stock capacity
		['max_employees'] = 5,					-- Max employees
		['required_job'] = {},					-- Required job do purchase goods in this store (set to {} to dont require any job here, or put the job name there like this: ['required_job'] = {'cop', 'gang', 'job_name'},)
		['upgrades'] = {						-- Definition of each upgrade
			['stock'] = {						-- Stock capacity
				['price'] = 8000,				-- Price to upgrade
				['level_reward'] = {			-- Reward of each level (max level: 5)
					[0] = 0,
					[1] = 50,
					[2] = 100,
					[3] = 150,
					[4] = 200,
					[5] = 300,
				}
			},
			['truck'] = {						-- Truck capacity
				['price'] = 12000,
				['level_reward'] = {
					[0] = 0,
					[1] = 25,
					[2] = 50,
					[3] = 100,
					[4] = 200,
					[5] = 300,
				}
			},
			['relationship'] = {				-- Relationship
				['price'] = 11000,
				['level_reward'] = {
					[0] = 0,
					[1] = 5,
					[2] = 10,
					[3] = 15,
					[4] = 25,
					[5] = 40,
				}
			},
		},
		['trucks'] = {							-- Trucks for each level when upgrade the truck cargo
			[0] = 'speedo',
			[1] = 'gburrito',
			[2] = 'mule',
			[3] = 'mule3',
			[4] = 'pounder',
			[5] = 'pounder2'
		},
		['max_purchasable_categories'] = 4,		-- The max amount of categories that can be purchased
		['categories'] = {						-- Here you configure the categories available to purchase in your store
			"electronics_market", "utilities_market", "vape_market", "lootboxes_market"
		},
		['default_categories'] = {				-- Here you can configure the categories available when the store has no owner
			"electronics_market", "utilities_market", "vape_market", "lootboxes_market"
		},
		['blips'] = {							-- Create the blips on map
			['id'] = 354,						-- Blip ID [Set this value 0 to dont have blip]
			['name'] = "Digital Den",				-- Blip Name [Will be replaced when the owner rename the store]
			['color'] = 2,						-- Blip Color
			['scale'] = 0.9,					-- Blip Scale
		}
	},

	['ammunation'] = {							-- Market type ID
		['stock_capacity'] = 200,				-- Max stock capacity
		['max_employees'] = 0,					-- Max employees (0 for non-owned shop)
		['max_jobs'] = 0,						-- Max jobs (0 for non-owned shop)
		['required_job'] = {},					-- Required job do purchase goods in this store (set to {} to dont require any job here, or put the job name there like this: ['required_job'] = {'cop', 'gang', 'job_name'},)
		['upgrades'] = {						-- Definition of each upgrade (minimal for non-owned shop)
			['stock'] = {						-- Stock capacity
				['price'] = 0,					-- Price to upgrade (0 for no upgrades)
				['level_reward'] = {			-- Reward of each level (max level: 5)
					[0] = 0,
					[1] = 0,
					[2] = 0,
					[3] = 0,
					[4] = 0,
					[5] = 0,
				}
			},
			['truck'] = {						-- Truck capacity
				['price'] = 0,					-- Price to upgrade (0 for no upgrades)
				['level_reward'] = {
					[0] = 0,
					[1] = 0,
					[2] = 0,
					[3] = 0,
					[4] = 0,
					[5] = 0,
				}
			},
			['relationship'] = {				-- Relationship
				['price'] = 0,					-- Price to upgrade (0 for no upgrades)
				['level_reward'] = {
					[0] = 0,
					[1] = 0,
					[2] = 0,
					[3] = 0,
					[4] = 0,
					[5] = 0,
				}
			},
		},
		['trucks'] = {							-- Trucks for each level (minimal for non-owned shop)
			[0] = 'speedo',
			[1] = 'speedo',
			[2] = 'speedo',
			[3] = 'speedo',
			[4] = 'speedo',
			[5] = 'speedo'
		},
		['max_purchasable_categories'] = 0,		-- The max amount of categories that can be purchased (0 for non-owned shop)
		['categories'] = {						-- Here you configure the categories available to purchase in your store
			"ammunation_pistols", "ammunation_melee", "ammunation_ammo", "ammunation_materials"
		},
		['default_categories'] = {				-- Here you can configure the categories available when the store has no owner
			"ammunation_pistols", "ammunation_melee", "ammunation_ammo", "ammunation_materials"
		},
		['blips'] = {							-- Create the blips on map
			['id'] = 313,						-- Blip ID [Set this value 0 to dont have blip]
			['name'] = "Ammunation",			-- Blip Name [Will be replaced when the owner rename the store]
			['color'] = 1,						-- Blip Color
			['scale'] = 0.8,					-- Blip Scale
		}
	},
	-- ['EMS_Cafe'] = {							-- Market type ID
	-- 	['stock_capacity'] = 150,				-- Max stock capacity
	-- 	['max_employees'] = 5,					-- Max employees
	-- 	['required_job'] = {},					-- Required job do purchase goods in this store (set to {} to dont require any job here, or put the job name there like this: ['required_job'] = {'cop', 'gang', 'job_name'},)
	-- 	['upgrades'] = {						-- Definition of each upgrade
	-- 		['stock'] = {						-- Stock capacity
	-- 			['price'] = 8000,				-- Price to upgrade
	-- 			['level_reward'] = {			-- Reward of each level (max level: 5)
	-- 				[0] = 0,
	-- 				[1] = 50,
	-- 				[2] = 100,
	-- 				[3] = 150,
	-- 				[4] = 200,
	-- 				[5] = 300,
	-- 			}
	-- 		},
	-- 		['truck'] = {						-- Truck capacity
	-- 			['price'] = 12000,
	-- 			['level_reward'] = {
	-- 				[0] = 0,
	-- 				[1] = 25,
	-- 				[2] = 50,
	-- 				[3] = 100,
	-- 				[4] = 200,
	-- 				[5] = 300,
	-- 			}
	-- 		},
	-- 		['relationship'] = {				-- Relationship
	-- 			['price'] = 11000,
	-- 			['level_reward'] = {
	-- 				[0] = 0,
	-- 				[1] = 5,
	-- 				[2] = 10,
	-- 				[3] = 15,
	-- 				[4] = 25,
	-- 				[5] = 40,
	-- 			}
	-- 		},
	-- 	},
	-- 	['trucks'] = {							-- Trucks for each level when upgrade the truck cargo
	-- 		[0] = 'speedo',
	-- 		[1] = 'gburrito',
	-- 		[2] = 'mule',
	-- 		[3] = 'mule3',
	-- 		[4] = 'pounder',
	-- 		[5] = 'pounder2'
	-- 	},
	-- 	['max_purchasable_categories'] = 4,		-- The max amount of categories that can be purchased
	-- 	['categories'] = {						-- Here you configure the categories available to purchase in your store
	-- 		"ems_food_market", "ems_drink_market"
	-- 	},
	-- 	['default_categories'] = {				-- Here you can configure the categories available when the store has no owner
	-- 		"ems_food_market", "ems_drink_market"
	-- 	},
	-- 	['blips'] = {							-- Create the blips on map
	-- 		['id'] = 52,						-- Blip ID [Set this value 0 to dont have blip]
	-- 		['name'] = "Market",				-- Blip Name [Will be replaced when the owner rename the store]
	-- 		['color'] = 4,						-- Blip Color
	-- 		['scale'] = 0.6,					-- Blip Scale
	-- 	}
	-- },
}

-- Here you configure each category to purchase inside the markets
Config.market_categories = {
	['alcohol_market'] = {
		['page_name'] = "Alcohol",
		['page_desc'] = "Indulge in a sophisticated and diverse collection of alcoholic beverages, from premium spirits to fine wines and craft beers, all available at our supermarket to elevate your drinking experience",
		['page_icon'] = '<img src="img/categories/alcohol-icon.png" style="padding:15px">', -- Its the icon that will appear in the page tab. "padding:12px" means that the image will be 15px smaller, use it to resize the image if needed. Tip: You can get nice images here: https://icon-icons.com/search/icons/
		-- ['page_icon'] = '<i class="fa-solid fa-burger"></i>', -- As an alternative to the page icon, you can use icons from here (https://fontawesome.com/search?m=free&s=solid)
		['page_img'] = 'img/categories/alcohol.png',	-- This is the category image in the page to buy categories
		['category_buy_price'] = 2500, 			-- Price to buy the category
		['category_sell_price'] = 1250, 		-- Price to sell the category
		['items'] = {
			['beer'] = {						-- The item ID
				['name'] = "Beer",				-- The item display name
				['price_to_customer'] = 7,		-- Price the customer will pay when buy the product in store
				['price_to_customer_min'] = 3,	-- Min price that the owner will be able to set on this product
				['price_to_customer_max'] = 14,	-- Max price that the owner will be able to set on this product
				['price_to_export'] = 6,		-- Price the owner will receive when exporting the item
				['price_to_owner'] = 5,			-- Price the store owner must pay when importing goods to your store
				['amount_to_owner'] = 35,		-- Amount of goods the owner will get when importing to store (This value can be increased if he upgraded his truck capacity)
				['amount_to_delivery'] = 35,	-- Max amount of goods the owner can set when creating a job to deliveryman
				['img'] = 'beer.png',			-- Image file name of this item inside nui/img/items
				['metadata'] = { test = 10 }	-- Item metadata (optional)
			},
			['whiskey'] = {
				['name'] = "Whiskey",
				['price_to_customer'] = 10,
				['price_to_customer_min'] = 5,
				['price_to_customer_max'] = 20,
				['price_to_export'] = 100,
				['price_to_owner'] = 7,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'whiskey.png',
			},
			['vodka'] = {
				['name'] = "Vodka",
				['price_to_customer'] = 12,
				['price_to_customer_min'] = 6,
				['price_to_customer_max'] = 24,
				['price_to_export'] = 11,
				['price_to_owner'] = 9,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'vodka.png',
			},
			['wine'] = {
				['name'] = "Wine",
				['price_to_customer'] = 15,
				['price_to_customer_min'] = 7,
				['price_to_customer_max'] = 30,
				['price_to_export'] = 14,
				['price_to_owner'] = 10,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'wine.png',
			},
			['rolling_paper'] = {
				['name'] = "Rolling Paper",
				['price_to_customer'] = 15,
				['price_to_customer_min'] = 7,
				['price_to_customer_max'] = 30,
				['price_to_export'] = 14,
				['price_to_owner'] = 10,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'rolling_paper.png',
			},
		}
	},

	['drink_market'] = {
		['page_name'] = "Drinks",
		['page_desc'] = "Quench your thirst and elevate your beverage game with our diverse range of refreshing drinks, from classic favorites to innovative flavors, all waiting for you to discover at our supermarket",
		['page_icon'] = '<img src="img/categories/drinks-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/drinks.png',
		['category_buy_price'] = 5000,
		['category_sell_price'] = 2500,
		['items'] = {
			['water_bottle'] = {
				['name'] = "Bottle of Water",
				['price_to_customer'] = 4,
				['price_to_customer_min'] = 2,
				['price_to_customer_max'] = 8,
				['price_to_export'] = 3,
				['price_to_owner'] = 3,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'water_bottle.png',
			},
			['coffee'] = {
				['name'] = "Coffee",
				['price_to_customer'] = 4,
				['price_to_customer_min'] = 2,
				['price_to_customer_max'] = 8,
				['price_to_export'] = 3,
				['price_to_owner'] = 3,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'coffee.png',
			},
			['kurkakola'] = {
				['name'] = "Cola",
				['price_to_customer'] = 4,
				['price_to_customer_min'] = 2,
				['price_to_customer_max'] = 8,
				['price_to_export'] = 3,
				['price_to_owner'] = 3,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'cola.png',
			},
		}
	},

	-- ['ems_drink_market'] = {
	-- 	['page_name'] = "Drinks",
	-- 	['page_desc'] = "Quench your thirst and elevate your beverage game with our diverse range of refreshing drinks, from classic favorites to innovative flavors, all waiting for you to discover at our supermarket",
	-- 	['page_icon'] = '<img src="img/categories/drinks-icon.png" style="padding:15px">',
	-- 	['page_img'] = 'img/categories/drinks.png',
	-- 	['category_buy_price'] = 5000,
	-- 	['category_sell_price'] = 2500,
	-- 	['items'] = {
	-- 		['coffee'] = {
	-- 			['name'] = "Coffee",
	-- 			['price_to_customer'] = 4,
	-- 			['price_to_customer_min'] = 2,
	-- 			['price_to_customer_max'] = 8,
	-- 			['price_to_export'] = 3,
	-- 			['price_to_owner'] = 3,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'coffee.png',
	-- 		},
	-- 		['orangotang'] = {
	-- 			['name'] = "Marinda",
	-- 			['price_to_customer'] = 60,
	-- 			['price_to_customer_min'] = 60,
	-- 			['price_to_customer_max'] = 60,
	-- 			['price_to_export'] = 3,
	-- 			['price_to_owner'] = 3,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'marinda.png',
	-- 		},
	-- 		['atomsoda'] = {
	-- 			['name'] = "Pepsi",
	-- 			['price_to_customer'] = 60,
	-- 			['price_to_customer_min'] = 60,
	-- 			['price_to_customer_max'] = 60,
	-- 			['price_to_export'] = 3,
	-- 			['price_to_owner'] = 3,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'pepsi.png',
	-- 		},
	-- 		['junkdrink'] = {
	-- 			['name'] = "Mountain Dew",
	-- 			['price_to_customer'] = 60,
	-- 			['price_to_customer_min'] = 60,
	-- 			['price_to_customer_max'] = 60,
	-- 			['price_to_export'] = 3,
	-- 			['price_to_owner'] = 3,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'mtndew.png',
	-- 		},
	-- 	}
	-- },

	['food_market'] = {
		['page_name'] = "Food",
		['page_desc'] = "Explore a delicious selection of fresh and high-quality food options that will tantalize your taste buds and satisfy your cravings, all conveniently available at our supermarket",
		['page_icon'] = '<img src="img/categories/food-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/food.png',
		['category_buy_price'] = 5000,
		['category_sell_price'] = 2500,
		['items'] = {
			['tosti'] = {
				['name'] = "Grilled Sandwich",
				['price_to_customer'] = 4,
				['price_to_customer_min'] = 1,
				['price_to_customer_max'] = 6,
				['price_to_export'] = 4,
				['price_to_owner'] = 2,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'tosti.png',
			},
			['twerks_candy'] = {
				['name'] = "Twerks",
				['price_to_customer'] = 3,
				['price_to_customer_min'] = 1,
				['price_to_customer_max'] = 6,
				['price_to_export'] = 4,
				['price_to_owner'] = 2,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'twerks_candy.png',
			},
			['snikkel_candy'] = {
				['name'] = "Snikkel",
				['price_to_customer'] = 3,
				['price_to_customer_min'] = 1,
				['price_to_customer_max'] = 6,
				['price_to_export'] = 4,
				['price_to_owner'] = 2,
				['amount_to_owner'] = 35,
				['amount_to_delivery'] = 35,
				['img'] = 'snikkel_candy.png',
			},
		}
	},
	
	-- ['ems_food_market'] = {
	-- 	['page_name'] = "Food",
	-- 	['page_desc'] = "Explore a delicious selection of fresh and high-quality food options that will tantalize your taste buds and satisfy your cravings, all conveniently available at our supermarket",
	-- 	['page_icon'] = '<img src="img/categories/food-icon.png" style="padding:15px">',
	-- 	['page_img'] = 'img/categories/food.png',
	-- 	['category_buy_price'] = 5000,
	-- 	['category_sell_price'] = 2500,
	-- 	['items'] = {
	-- 		['tosti'] = {
	-- 			['name'] = "Grilled Sandwich",
	-- 			['price_to_customer'] = 4,
	-- 			['price_to_customer_min'] = 1,
	-- 			['price_to_customer_max'] = 6,
	-- 			['price_to_export'] = 4,
	-- 			['price_to_owner'] = 2,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'tosti.png',
	-- 		},
	-- 		['chickensalad'] = {
	-- 			['name'] = "Chicken Salad",
	-- 			['price_to_customer'] = 90,
	-- 			['price_to_customer_min'] = 90,
	-- 			['price_to_customer_max'] = 90,
	-- 			['price_to_export'] = 4,
	-- 			['price_to_owner'] = 2,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'chickensalad.png',
	-- 		},
	-- 		['enchiladas'] = {
	-- 			['name'] = "Breakfast Enchiladas",
	-- 			['price_to_customer'] = 90,
	-- 			['price_to_customer_min'] = 90,
	-- 			['price_to_customer_max'] = 90,
	-- 			['price_to_export'] = 4,
	-- 			['price_to_owner'] = 2,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'enchi.png',
	-- 		},
	-- 		['hornbreakfast'] = {
	-- 			['name'] = "Quick Breakfast",
	-- 			['price_to_customer'] = 90,
	-- 			['price_to_customer_min'] = 90,
	-- 			['price_to_customer_max'] = 90,
	-- 			['price_to_export'] = 4,
	-- 			['price_to_owner'] = 2,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'bangers.png',
	-- 		},
	-- 		['frenchtoastbacon'] = {
	-- 			['name'] = "French Toast W Bacon",
	-- 			['price_to_customer'] = 90,
	-- 			['price_to_customer_min'] = 90,
	-- 			['price_to_customer_max'] = 90,
	-- 			['price_to_export'] = 4,
	-- 			['price_to_owner'] = 2,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'frenchbacon.png',
	-- 		},
	-- 		['dblchickenhornburger'] = {
	-- 			['name'] = "Double Chicken Burger",
	-- 			['price_to_customer'] = 200,
	-- 			['price_to_customer_min'] = 200,
	-- 			['price_to_customer_max'] = 200,
	-- 			['price_to_export'] = 4,
	-- 			['price_to_owner'] = 2,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'dblchickenburger.png',
	-- 		},
	-- 		['twerks_candy'] = {
	-- 			['name'] = "Twerks",
	-- 			['price_to_customer'] = 3,
	-- 			['price_to_customer_min'] = 1,
	-- 			['price_to_customer_max'] = 6,
	-- 			['price_to_export'] = 4,
	-- 			['price_to_owner'] = 2,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'twerks_candy.png',
	-- 		},
	-- 		['snikkel_candy'] = {
	-- 			['name'] = "Snikkel",
	-- 			['price_to_customer'] = 3,
	-- 			['price_to_customer_min'] = 1,
	-- 			['price_to_customer_max'] = 6,
	-- 			['price_to_export'] = 4,
	-- 			['price_to_owner'] = 2,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'snikkel_candy.png',
	-- 		},
	-- 		['crisps'] = {
	-- 			['name'] = "Lays",
	-- 			['price_to_customer'] = 3,
	-- 			['price_to_customer_min'] = 1,
	-- 			['price_to_customer_max'] = 6,
	-- 			['price_to_export'] = 4,
	-- 			['price_to_owner'] = 2,
	-- 			['amount_to_owner'] = 35,
	-- 			['amount_to_delivery'] = 35,
	-- 			['img'] = 'lays.png',
	-- 		},
			
	-- 	}
	-- },

	['electronics_market'] = {
		['page_name'] = "Electronics",
		['page_desc'] = "Experience the latest in technology with our wide range of cutting-edge electronics, from smartphones to home entertainment systems, available at our supermarket",
		['page_icon'] = '<img src="img/categories/electronics-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/electronics.png',
		['category_buy_price'] = 5000,
		['category_sell_price'] = 2500,
		['items'] = {
			['phone'] = {
				['name'] = "Phone",
				['price_to_customer'] = 850,
				['price_to_customer_min'] = 425,
				['price_to_customer_max'] = 1700,
				['price_to_export'] = 637,
				['price_to_owner'] = 425,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'phone.png',
			},
			['radio'] = {
				['name'] = "Radio",
				['price_to_customer'] = 200,
				['price_to_customer_min'] = 100,
				['price_to_customer_max'] = 400,
				['price_to_export'] = 150,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'radio.png',
			},
			['powerbank'] = {
				['name'] = "Powerbank",
				['price_to_customer'] = 100,
				['price_to_customer_min'] = 300,
				['price_to_customer_max'] = 1200,
				['price_to_export'] = 420,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'powerbank.png',
			},
			['racingtablet'] = {
				['name'] = "Racing Tablet",
				['price_to_customer'] = 500,
				['price_to_customer_min'] = 300,
				['price_to_customer_max'] = 1200,
				['price_to_export'] = 420,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'racingtablet.png',
			},
			['boostingtablet'] = {
				['name'] = "Boosting Tablet",
				['price_to_customer'] = 500,
				['price_to_customer_min'] = 300,
				['price_to_customer_max'] = 1200,
				['price_to_export'] = 420,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'boostingtablet.png',
			},
		}
	},

	['utilities_market'] = {
		['page_name'] = "Utilities",
		['page_desc'] = "Quality tools and equipment for any project, from hand tools to power tools, designed to help you achieve precision and efficiency, available at our supermarket",
		['page_icon'] = '<img src="img/categories/utilities-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/utilities.png',
		['category_buy_price'] = 3000,
		['category_sell_price'] = 1500,
		['items'] = {
			['cleaningkit'] = {
				['name'] = "Cleaning Kit",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 135,
				['price_to_owner'] = 125,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'cleaningkit.png',
			},
			['lockpick'] = {
				['name'] = "Lockpick",
				['price_to_customer'] = 250,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 135,
				['price_to_owner'] = 125,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'lockpick.png',
			},
			['screwdriverset'] = {
				['name'] = "Toolkit",
				['price_to_customer'] = 350,
				['price_to_customer_min'] = 175,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'screwdriverset.png',
			},
			-- ['empty_weed_bag'] = {
			-- 	['name'] = "Empty Weed Bag",
			-- 	['price_to_customer'] = 10,
			-- 	['price_to_customer_min'] = 175,
			-- 	['price_to_customer_max'] = 700,
			-- 	['price_to_export'] = 315,
			-- 	['price_to_owner'] = 300,
			-- 	['amount_to_owner'] = 2,
			-- 	['amount_to_delivery'] = 2,
			-- 	['img'] = 'empty_weed_bag.png',
			-- },
			-- ['weed_nutrition'] = {
			-- 	['name'] = "Plant Fertilizer",
			-- 	['price_to_customer'] = 10,
			-- 	['price_to_customer_min'] = 175,
			-- 	['price_to_customer_max'] = 700,
			-- 	['price_to_export'] = 315,
			-- 	['price_to_owner'] = 300,
			-- 	['amount_to_owner'] = 2,
			-- 	['amount_to_delivery'] = 2,
			-- 	['img'] = 'weed_nutrition.png',
			-- },
			['weapon_crowbar'] = {
				['name'] = "Crowbar",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 175,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'weapon_crowbar.png',
			},
			['weapon_knife'] = {
				['name'] = "Knife",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 175,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'weapon_knife.png',
			},
			['weapon_wrench'] = {
				['name'] = "Wrench",
				['price_to_customer'] = 100,
				['price_to_customer_min'] = 175,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'weapon_wrench.png',
			},
			['spraycan'] = {
				['name'] = "Spray Can",
				['price_to_customer'] = 140,
				['price_to_customer_min'] = 165,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'spraycan.png',
			},
			['sprayremover'] = {
				['name'] = "Spray Remover",
				['price_to_customer'] = 140,
				['price_to_customer_min'] = 165,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'sprayremover.png',
			},
			['clothing_bag'] = {
				['name'] = "Clothing Bag",
				['price_to_customer'] = 100,
				['price_to_customer_min'] = 175,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'clothing_bag.png',
			},
			['backpack'] = {
				['name'] = "Backpack",
				['price_to_customer'] = 100,
				['price_to_customer_min'] = 175,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'backpack.png',
			},
			['backpack2'] = {
				['name'] = "Large Backpack",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 175,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'backpack2.png',
			},
			['rope'] = {
				['name'] = "rope",
				['price_to_customer'] = 50,
				['price_to_customer_min'] = 165,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'rope.png',
			},
			['x_circuittester'] = {
				['name'] = "Circuit Tester",
				['price_to_customer'] = 120,
				['price_to_customer_min'] = 100,
				['price_to_customer_max'] = 400,
				['price_to_export'] = 300,
				['price_to_owner'] = 200,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'x_circuittester.png',
			},
			['pliers'] = {
				['name'] = "Pliers",
				['price_to_customer'] = 140,
				['price_to_customer_min'] = 155,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'pliers.png',
			},
			['x_fingerprinttape'] = {
				['name'] = "Figer Print Tape",
				['price_to_customer'] = 100,
				['price_to_customer_min'] = 120,
				['price_to_customer_max'] = 130,
				['price_to_export'] = 200,
				['price_to_owner'] = 50,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'x_fingerprinttape.png',
			},
			['x_stethoscope'] = {
				['name'] = "Stethoscope",
				['price_to_customer'] = 175,
				['price_to_customer_min'] = 180,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'x_stethoscope.png',
			},
			['glass_cutter'] = {
				['name'] = "Glass Cutter",
				['price_to_customer'] = 175,
				['price_to_customer_min'] = 180,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'glass_cutter.png',
			},
			['x_gastank'] = {
				['name'] = "Mini Gas Tank",
				['price_to_customer'] = 180,
				['price_to_customer_min'] = 180,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'x_gastank.png',
			},
			['lighter'] = {
				['name'] = "Lighter",
				['price_to_customer'] = 80,
				['price_to_customer_min'] = 180,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'lighter.png',
			},
			['hairspray'] = {
				['name'] = "HairSpray",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 180,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 315,
				['price_to_owner'] = 300,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'hairspray.png',
			},
			['binoculars'] = {
				['name'] = "Binoculars",
				['price_to_customer'] = 450,
				['price_to_customer_min'] = 350,
				['price_to_customer_max'] = 700,
				['price_to_export'] = 450,
				['price_to_owner'] = 250,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'binoculars.png',
			},
			['parachute'] = {
				['name'] = "Parachute",
				['price_to_customer'] = 500,
				['price_to_customer_min'] = 450,
				['price_to_customer_max'] = 600,
				['price_to_export'] = 550,
				['price_to_owner'] = 350,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'parachute.png',
			},
		}
	},

	['vape_market'] = {
		['page_name'] = "Vapes",
		['page_desc'] = "Discover our premium collection of vape products with a wide variety of flavors and styles, designed to provide the ultimate vaping experience",
		['page_icon'] = '<img src="img/items/vape.png" style="padding:15px">',
		['page_img'] = 'img/categories/electronics.png',
		['category_buy_price'] = 5000,
		['category_sell_price'] = 2500,
		['items'] = {
			['vape'] = {
				['name'] = "Normal Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape.png',
			},
			['vape_watermelon'] = {
				['name'] = "Watermelon Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_watermelon.png',
			},
			['vape_mango'] = {
				['name'] = "Mango Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_mango.png',
			},
			['vape_blueberry'] = {
				['name'] = "Blueberry Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_blueberry.png',
			},
			['vape_strawberry'] = {
				['name'] = "Strawberry Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_strawberry.png',
			},
			['vape_pineapple'] = {
				['name'] = "Pineapple Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_pineapple.png',
			},
			['vape_cherry'] = {
				['name'] = "Cherry Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_cherry.png',
			},
			['vape_lime'] = {
				['name'] = "Lime Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_lime.png',
			},
			['vape_coconut'] = {
				['name'] = "Coconut Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_coconut.png',
			},
			['vape_raspberry'] = {
				['name'] = "Raspberry Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_raspberry.png',
			},
			['vape_peach'] = {
				['name'] = "Peach Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_peach.png',
			},
			['vape_mint'] = {
				['name'] = "Mint Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_mint.png',
			},
			['vape_vanilla'] = {
				['name'] = "Vanilla Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_vanilla.png',
			},
			['vape_lemon'] = {
				['name'] = "Lemon Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_lemon.png',
			},
			['vape_banana'] = {
				['name'] = "Banana Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_banana.png',
			},
			['vape_apple'] = {
				['name'] = "Apple Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_apple.png',
			},
			['vape_kiwi'] = {
				['name'] = "Kiwi Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_kiwi.png',
			},
			['vape_caramel'] = {
				['name'] = "Caramel Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_caramel.png',
			},
			['vape_cinnamon'] = {
				['name'] = "Cinnamon Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_cinnamon.png',
			},
			['vape_honey'] = {
				['name'] = "Honey Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_honey.png',
			},
			['vape_pear'] = {
				['name'] = "Pear Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_pear.png',
			},
			['vape_cranberry'] = {
				['name'] = "Cranberry Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_cranberry.png',
			},
			['vape_coffee'] = {
				['name'] = "Coffee Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_coffee.png',
			},
			['vape_pomegranate'] = {
				['name'] = "Pomegranate Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_pomegranate.png',
			},
			['vape_tangerine'] = {
				['name'] = "Tangerine Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_tangerine.png',
			},
			['vape_chocolate'] = {
				['name'] = "Chocolate Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_chocolate.png',
			},
			['vape_guava'] = {
				['name'] = "Guava Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_guava.png',
			},
			['vape_toffee'] = {
				['name'] = "Toffee Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_toffee.png',
			},
			['vape_blackberry'] = {
				['name'] = "Blackberry Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_blackberry.png',
			},
			['vape_apricot'] = {
				['name'] = "Apricot Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_apricot.png',
			},
			['vape_plum'] = {
				['name'] = "Plum Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_plum.png',
			},
			['vape_passionfruit'] = {
				['name'] = "Passionfruit Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_passionfruit.png',
			},
			['vape_lychee'] = {
				['name'] = "Lychee Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_lychee.png',
			},
			['vape_dragonfruit'] = {
				['name'] = "Dragonfruit Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_dragonfruit.png',
			},
			['vape_paella'] = {
				['name'] = "Paella Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_paella.png',
			},
			['vape_cucumber'] = {
				['name'] = "Cucumber Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_cucumber.png',
			},
			['vape_berrymix'] = {
				['name'] = "Berry Mix Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_berrymix.png',
			},
			['vape_hazelnut'] = {
				['name'] = "Hazelnut Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_hazelnut.png',
			},
			['vape_melon'] = {
				['name'] = "Melon Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_melon.png',
			},
			['vape_ginger'] = {
				['name'] = "Ginger Vape",
				['price_to_customer'] = 150,
				['price_to_customer_min'] = 75,
				['price_to_customer_max'] = 300,
				['price_to_export'] = 112,
				['price_to_owner'] = 100,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['img'] = 'vape_ginger.png',
			},
		}
	},

	['lootboxes_market'] = {
		['page_name'] = "Loot Boxes",
		['page_desc'] = "Discover rare treasures and exclusive items with our premium loot boxes. Each box contains unique rewards ranging from common to legendary items!",
		['page_icon'] = '<img src="img/items/common_case.png" style="padding:15px">',
		['page_img'] = 'img/items/common_case.png',
		['category_buy_price'] = 10000,
		['category_sell_price'] = 5000,
		['items'] = {
			['common_case'] = {
				['name'] = "Common Loot Box",
				['price_to_customer'] = 50000,
				['price_to_customer_min'] = 50000,
				['price_to_customer_max'] = 50000,
				['price_to_export'] = 45000,
				['price_to_owner'] = 40000,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['img'] = 'common_case.png',
			},
			['uncommon_case'] = {
				['name'] = "Uncommon Loot Box",
				['price_to_customer'] = 100000,
				['price_to_customer_min'] = 100000,
				['price_to_customer_max'] = 100000,
				['price_to_export'] = 90000,
				['price_to_owner'] = 80000,
				['amount_to_owner'] = 3,
				['amount_to_delivery'] = 3,
				['img'] = 'uncommon_case.png',
			},
			['epic_case'] = {
				['name'] = "Rare Loot Box",
				['price_to_customer'] = 250000,
				['price_to_customer_min'] = 250000,
				['price_to_customer_max'] = 250000,
				['price_to_export'] = 225000,
				['price_to_owner'] = 200000,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['img'] = 'epic_case.png',
			},
			['legendary_case'] = {
				['name'] = "Legendary Loot Box",
				['price_to_customer'] = 500000,
				['price_to_customer_min'] = 500000,
				['price_to_customer_max'] = 500000,
				['price_to_export'] = 450000,
				['price_to_owner'] = 400000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['img'] = 'legendary_case.png',
			},
			['diamond_case'] = {
				['name'] = "Diamond Loot Box",
				['price_to_customer'] = 1000000,
				['price_to_customer_min'] = 1000000,
				['price_to_customer_max'] = 1000000,
				['price_to_export'] = 900000,
				['price_to_owner'] = 800000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['img'] = 'diamond_case.png',
			},
			['knife_case'] = {
				['name'] = "Knife Case",
				['price_to_customer'] = 250000,
				['price_to_customer_min'] = 250000,
				['price_to_customer_max'] = 250000,
				['price_to_export'] = 225000,
				['price_to_owner'] = 200000,
				['amount_to_owner'] = 3,
				['amount_to_delivery'] = 3,
				['img'] = 'knife_case.png',
			},
		}
	},

	['melee_weapons'] = {
		['page_name'] = "Melee Weapons",
		['page_desc'] = "Get up close and personal with our selection of high-quality melee weapons, including knives, swords, and clubs, perfect for any self-defense scenario",
		['page_icon'] = '<img src="img/categories/weapons-melee-icon.png" style="padding:14px">',
		['page_img'] = 'img/categories/weapons-melee.png',
		['category_buy_price'] = 10000,
		['category_sell_price'] = 5000,
		['items'] = {
			['weapon_bat'] = {
				['name'] = "Baseball Bat",
				['price_to_customer'] = 500,
				['price_to_customer_min'] = 250,
				['price_to_customer_max'] = 1000,
				['price_to_export'] = 750,
				['price_to_owner'] = 375,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['is_weapon'] = true,
				['requires_license'] = false,
				['max_amount_to_purchase'] = 1,
				['img'] = 'weapon_bat.png',
			},
			['weapon_crowbar'] = {
				['name'] = "Crowbar",
				['price_to_customer'] = 500,
				['price_to_customer_min'] = 250,
				['price_to_customer_max'] = 1000,
				['price_to_export'] = 750,
				['price_to_owner'] = 375,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['is_weapon'] = true,
				['requires_license'] = false,
				['max_amount_to_purchase'] = 1,
				['img'] = 'weapon_crowbar.png',
			},
			['weapon_hammer'] = {
				['name'] = "Hammer",
				['price_to_customer'] = 250,
				['price_to_customer_min'] = 125,
				['price_to_customer_max'] = 500,
				['price_to_export'] = 250,
				['price_to_owner'] = 250,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['is_weapon'] = true,
				['requires_license'] = false,
				['max_amount_to_purchase'] = 1,
				['img'] = 'weapon_hammer.png',
			},
			['weapon_wrench'] = {
				['name'] = "Wrench",
				['price_to_customer'] = 250,
				['price_to_customer_min'] = 125,
				['price_to_customer_max'] = 500,
				['price_to_export'] = 250,
				['price_to_owner'] = 250,
				['amount_to_owner'] = 2,
				['amount_to_delivery'] = 2,
				['is_weapon'] = true,
				['requires_license'] = false,
				['max_amount_to_purchase'] = 1,
				['img'] = 'weapon_wrench.png',
			},
		}
	},

	['pistol_weapons'] = {
		['page_name'] = "Pistol Weapons",
		['page_desc'] = "Protect yourself with our collection of reliable and powerful pistol weapons, designed to provide accuracy and stopping power in any situation",
		['page_icon'] = '<img src="img/categories/weapons-pistol-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/weapons-pistol.png',
		['category_buy_price'] = 25000,
		['category_sell_price'] = 12500,
		['items'] = {
			['weapon_pistol'] = {
				['name'] = "Pistol",
				['price_to_customer'] = 2500,
				['price_to_customer_min'] = 1250,
				['price_to_customer_max'] = 5000,
				['price_to_export'] = 2500,
				['price_to_owner'] = 1875,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['is_weapon'] = true,
				['requires_license'] = true,
				['max_amount_to_purchase'] = 1,
				['img'] = 'weapon_pistol.png',
			},
			['weapon_snspistol'] = {
				['name'] = "SNS Pistol",
				['price_to_customer'] = 1500,
				['price_to_customer_min'] = 750,
				['price_to_customer_max'] = 3000,
				['price_to_export'] = 1350,
				['price_to_owner'] = 1200,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['is_weapon'] = true,
				['requires_license'] = true,
				['max_amount_to_purchase'] = 1,
				['img'] = 'weapon_snspistol.png',
			},
		}
	},

	['rifle_weapons'] = {
		['page_name'] = "Rifle Weapons",
		['page_desc'] = "Dominate the battlefield with our high-performance assault rifles, built to provide accuracy, range, and stopping power in any combat situation",
		['page_icon'] = '<img src="img/categories/weapons-rifle-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/weapons-rifle.png',
		['category_buy_price'] = 60000,
		['category_sell_price'] = 30000,
		['items'] = {

		}
	},

	['shotgun_weapons'] = {
		['page_name'] = "Shotgun Weapons",
		['page_desc'] = "Get up close and personal with our devastating assault shotguns, designed for maximum impact and stopping power at close range combat",
		['page_icon'] = '<img src="img/categories/weapons-shotgun-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/weapons-shotgun.png',
		['category_buy_price'] = 60000,
		['category_sell_price'] = 30000,
		['items'] = {

		}
	},

	['smg_weapons'] = {
		['page_name'] = "SMG Weapons",
		['page_desc'] = "Experience the perfect blend of power and mobility with our versatile and reliable SMG weapons, ideal for a variety of combat scenarios",
		['page_icon'] = '<img src="img/categories/weapons-smg-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/weapons-smg.png',
		['category_buy_price'] = 50000,
		['category_sell_price'] = 25000,
		['items'] = {

		}
	},

	['throwable_weapons'] = {
		['page_name'] = "Throwable Weapons",
		['page_desc'] = "Expand your tactical options with our collection of throwable weapons, perfect for gaining an edge in any combat scenario",
		['page_icon'] = '<img src="img/categories/weapons-throwable-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/weapons-throwable.png',
		['category_buy_price'] = 40000,
		['category_sell_price'] = 20000,
		['items'] = {

		}
	},

	['ammo_weapons'] = {
		['page_name'] = "Ammo",
		['page_desc'] = "Stay locked and loaded with our extensive range of high-quality ammunition, designed to deliver maximum power and accuracy to your weapon",
		['page_icon'] = '<img src="img/categories/weapons-ammo-icon.png" style="padding:16px">',
		['page_img'] = 'img/categories/weapons-ammo.png',
		['category_buy_price'] = 35000,
		['category_sell_price'] = 17500,
		['items'] = {
			['pistol_ammo'] = {
				['name'] = "Pistol Ammo",
				['price_to_customer'] = 250,
				['price_to_customer_min'] = 125,
				['price_to_customer_max'] = 500,
				['price_to_export'] = 200,
				['price_to_owner'] = 150,
				['amount_to_owner'] = 100,
				['amount_to_delivery'] = 100,
				['requires_license'] = true,
				['img'] = 'pistol_ammo.png',
			},
		}
	},

	['others_weapons'] = {
		['page_name'] = "Miscellaneous",
		['page_desc'] = "Be prepared for any outdoor adventure with our range of essential gear, including parachutes, flares, and other survival tools, available at our store",
		['page_icon'] = '<img src="img/categories/weapons-other-icon.png" style="padding:17px">',
		['page_img'] = 'img/categories/weapons-other.png',
		['category_buy_price'] = 5000,
		['category_sell_price'] = 2500,
		['items'] = {
			['parachute'] = {
				['name'] = "Parachute",
				['price_to_customer'] = 2500,
				['price_to_customer_min'] = 1250,
				['price_to_customer_max'] = 5000,
				['price_to_export'] = 2500,
				['price_to_owner'] = 1875,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['img'] = 'parachute.png',
			},
		}
	},

	['ammunation_pistols'] = {
		['page_name'] = "Pistols",
		['page_desc'] = "Professional-grade pistols for self-defense and sport shooting, featuring precision engineering and reliable performance",
		['page_icon'] = '<img src="img/categories/weapons-pistol-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/weapons-pistol.png',
		['category_buy_price'] = 50000,
		['category_sell_price'] = 25000,
		['items'] = {
			['weapon_glock41'] = { ['name'] = "GLOCK 41", ['price_to_customer'] = 40000, ['price_to_customer_min'] = 20000, ['price_to_customer_max'] = 80000, ['price_to_export'] = 40000, ['price_to_owner'] = 30000, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_glock41.png', },
			['weapon_p30l'] = { ['name'] = "H&K P30L", ['price_to_customer'] = 20000, ['price_to_customer_min'] = 27500, ['price_to_customer_max'] = 110000, ['price_to_export'] = 55000, ['price_to_owner'] = 41250, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_p30l.png', },
			['weapon_p210'] = { ['name'] = "P210 CARRY", ['price_to_customer'] = 15000, ['price_to_customer_min'] = 22500, ['price_to_customer_max'] = 90000, ['price_to_export'] = 45000, ['price_to_owner'] = 33750, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_p210.png', },
			['weapon_sr40'] = { ['name'] = "RUGER SR40", ['price_to_customer'] = 12000, ['price_to_customer_min'] = 32500, ['price_to_customer_max'] = 130000, ['price_to_export'] = 65000, ['price_to_owner'] = 48750, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_sr40.png', },
			['weapon_t1911'] = { ['name'] = "TAN 1911", ['price_to_customer'] = 22000, ['price_to_customer_min'] = 17500, ['price_to_customer_max'] = 70000, ['price_to_export'] = 35000, ['price_to_owner'] = 26250, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_t1911.png', },
			['weapon_tglock19'] = { ['name'] = "TAN G19", ['price_to_customer'] = 25000, ['price_to_customer_min'] = 12500, ['price_to_customer_max'] = 50000, ['price_to_export'] = 25000, ['price_to_owner'] = 18750, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_tglock19.png', },
			['weapon_pistol'] = { ['name'] = "Pistol (Walther P99)", ['price_to_customer'] = 20000, ['price_to_customer_min'] = 10000, ['price_to_customer_max'] = 40000, ['price_to_export'] = 20000, ['price_to_owner'] = 15000, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_pistol.png', },
			['weapon_combatpistol'] = { ['name'] = "Combat Pistol", ['price_to_customer'] = 20000, ['price_to_customer_min'] = 10000, ['price_to_customer_max'] = 40000, ['price_to_export'] = 20000, ['price_to_owner'] = 15000, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_combatpistol.png', },
			['weapon_snspistol'] = { ['name'] = "SNS Pistol", ['price_to_customer'] = 15000, ['price_to_customer_min'] = 7500, ['price_to_customer_max'] = 30000, ['price_to_export'] = 15000, ['price_to_owner'] = 11250, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_snspistol.png', },
			['weapon_vintagepistol'] = { ['name'] = "Vintage Pistol", ['price_to_customer'] = 10000, ['price_to_customer_min'] = 8750, ['price_to_customer_max'] = 35000, ['price_to_export'] = 17500, ['price_to_owner'] = 13125, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_vintagepistol.png', },
			['weapon_ceramicpistol'] = { ['name'] = "Ceramic Pistol", ['price_to_customer'] = 10000, ['price_to_customer_min'] = 7750, ['price_to_customer_max'] = 31000, ['price_to_export'] = 15500, ['price_to_owner'] = 11625, ['amount_to_owner'] = 1, ['amount_to_delivery'] = 1, ['is_weapon'] = true, ['requires_license'] = true, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_ceramicpistol.png', },
		}
	},

	['ammunation_melee'] = {
		['page_name'] = "Melee Weapons",
		['page_desc'] = "High-quality melee weapons for self-defense and utility, crafted from durable materials for lasting performance",
		['page_icon'] = '<img src="img/categories/weapons-melee-icon.png" style="padding:14px">',
		['page_img'] = 'img/categories/weapons-melee.png',
		['category_buy_price'] = 15000,
		['category_sell_price'] = 7500,
		['items'] = {
			['weapon_stone_hatchet'] = { ['name'] = "Stone Hatchet", ['price_to_customer'] = 250, ['price_to_customer_min'] = 125, ['price_to_customer_max'] = 500, ['price_to_export'] = 250, ['price_to_owner'] = 188, ['amount_to_owner'] = 2, ['amount_to_delivery'] = 2, ['is_weapon'] = true, ['requires_license'] = false, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_stone_hatchet.png', },
			['weapon_poolcue'] = { ['name'] = "Poolcue", ['price_to_customer'] = 500, ['price_to_customer_min'] = 250, ['price_to_customer_max'] = 1000, ['price_to_export'] = 500, ['price_to_owner'] = 375, ['amount_to_owner'] = 2, ['amount_to_delivery'] = 2, ['is_weapon'] = true, ['requires_license'] = false, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_poolcue.png', },
			['weapon_wrench'] = { ['name'] = "Wrench", ['price_to_customer'] = 350, ['price_to_customer_min'] = 175, ['price_to_customer_max'] = 700, ['price_to_export'] = 350, ['price_to_owner'] = 263, ['amount_to_owner'] = 2, ['amount_to_delivery'] = 2, ['is_weapon'] = true, ['requires_license'] = false, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_wrench.png', },
			['weapon_knuckle'] = { ['name'] = "Knuckle", ['price_to_customer'] = 750, ['price_to_customer_min'] = 375, ['price_to_customer_max'] = 1500, ['price_to_export'] = 750, ['price_to_owner'] = 563, ['amount_to_owner'] = 2, ['amount_to_delivery'] = 2, ['is_weapon'] = true, ['requires_license'] = false, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_knuckle.png', },
			['weapon_hammer'] = { ['name'] = "Hammer", ['price_to_customer'] = 450, ['price_to_customer_min'] = 225, ['price_to_customer_max'] = 900, ['price_to_export'] = 450, ['price_to_owner'] = 338, ['amount_to_owner'] = 2, ['amount_to_delivery'] = 2, ['is_weapon'] = true, ['requires_license'] = false, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_hammer.png', },
			['weapon_golfclub'] = { ['name'] = "Golfclub", ['price_to_customer'] = 250, ['price_to_customer_min'] = 125, ['price_to_customer_max'] = 500, ['price_to_export'] = 250, ['price_to_owner'] = 188, ['amount_to_owner'] = 2, ['amount_to_delivery'] = 2, ['is_weapon'] = true, ['requires_license'] = false, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_golfclub.png', },
			['weapon_crowbar'] = { ['name'] = "Crowbar", ['price_to_customer'] = 550, ['price_to_customer_min'] = 275, ['price_to_customer_max'] = 1100, ['price_to_export'] = 550, ['price_to_owner'] = 413, ['amount_to_owner'] = 2, ['amount_to_delivery'] = 2, ['is_weapon'] = true, ['requires_license'] = false, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_crowbar.png', },
			['weapon_bat'] = { ['name'] = "Bat", ['price_to_customer'] = 250, ['price_to_customer_min'] = 125, ['price_to_customer_max'] = 500, ['price_to_export'] = 250, ['price_to_owner'] = 188, ['amount_to_owner'] = 2, ['amount_to_delivery'] = 2, ['is_weapon'] = true, ['requires_license'] = false, ['max_amount_to_purchase'] = 1, ['img'] = 'weapon_bat.png', },
		}
	},

	['ammunation_ammo'] = {
		['page_name'] = "Ammunition",
		['page_desc'] = "High-quality ammunition for various firearms, ensuring accuracy and reliability in every shot",
		['page_icon'] = '<img src="img/categories/weapons-ammo-icon.png" style="padding:16px">',
		['page_img'] = 'img/categories/weapons-ammo.png',
		['category_buy_price'] = 25000,
		['category_sell_price'] = 12500,
		['items'] = {
			['shotgun_ammo'] = { ['name'] = "Pistol Ammo", ['price_to_customer'] = 1000, ['price_to_customer_min'] = 500, ['price_to_customer_max'] = 2000, ['price_to_export'] = 1000, ['price_to_owner'] = 750, ['amount_to_owner'] = 50, ['amount_to_delivery'] = 50, ['is_weapon'] = false, ['requires_license'] = true, ['max_amount_to_purchase'] = 50, ['img'] = 'pistol_ammo.png', },
		}
	},

	['ammunation_materials'] = {
		['page_name'] = "Materials",
		['page_desc'] = "Essential materials for weapon crafting and maintenance, including gunpowder and reinforced steel components",
		['page_icon'] = '<img src="img/categories/weapons-materials-icon.png" style="padding:15px">',
		['page_img'] = 'img/categories/utilities.png',
		['category_buy_price'] = 15000,
		['category_sell_price'] = 7500,
		['items'] = {
			['gunpowder'] = { ['name'] = "Gun Powder", ['price_to_customer'] = 200, ['price_to_customer_min'] = 200, ['price_to_customer_max'] = 200, ['price_to_export'] = 200, ['price_to_owner'] = 200, ['amount_to_owner'] = 20, ['amount_to_delivery'] = 50, ['is_weapon'] = false, ['requires_license'] = true, ['max_amount_to_purchase'] = 50, ['img'] = 'gunpowder.png', },
			['reinforced_steel'] = { ['name'] = "Reinforced Steel", ['price_to_customer'] = 500, ['price_to_customer_min'] = 500, ['price_to_customer_max'] = 500, ['price_to_export'] = 500, ['price_to_owner'] = 500, ['amount_to_owner'] = 15, ['amount_to_delivery'] = 30, ['is_weapon'] = false, ['requires_license'] = true, ['max_amount_to_purchase'] = 30, ['img'] = 'reinforced_steel.png', },
		}
	},
}
-- Here you can configure the permissions for each employee role
-- 1 = Basic Access
-- 2 = Advanced Access
-- 3 = Full Access
-- When setting a permission to 1, any employee will be able to access that function/page
-- When setting a permission to 2, only the employees with the advanced access and full access will be able to access that function/page
-- When setting a permission to 3, only the employees with the full access will be able to access that function/page
-- When setting a permission to 4, only the owner will be able to access that function/page
Config.roles_permissions = {
	['functions'] = {				-- These are the actions (when a button is clicked)
		['createJob'] = 2,
		['deleteJob'] = 2,
		['renameMarket'] = 3,
		['setPrice'] = 2,
		['buyUpgrade'] = 2,
		['hideBalance'] = 2,
		['showBalance'] = 2,
		['withdrawMoney'] = 3,
		['depositMoney'] = 3,
		['sellMarket'] = 4,
		['storeProductFromInventory'] = 1,
		['hirePlayer'] = 3,
		['firePlayer'] = 3,
		['changeRole'] = 3,
		['giveComission'] = 3,
		['startImportJob'] = 1,
		['startExportJob'] = 1,
		['buyCategory'] = 3,
		['sellCategory'] = 3,
	},
	['ui_pages'] = {				-- These are the UI pages
		['main'] = 1,
		['goods'] = 1,
		['hire'] = 2,
		['employee'] = 3,
		['upgrades'] = 2,
		['bank'] = 3
	}
}
-- Setting to remove inactive stores
Config.clear_stores = {
	['active'] = true,				-- Set to false to disable this function
	['min_stock_amount'] = 30,		-- Minimum percentage of stock to consider an inactive store. Stores that have been inactive for a long time will be removed
	['min_stock_variety'] = 70,		-- Minimum percentage of variety of products in stock to consider an inactive store. Stores that have been inactive for a long time will be removed
	['cooldown'] = 72				-- Time (in hours) that the store needs to be below the minimum amount of stock to be removed
}

Config.route_blip = {				-- The blip style that will appear when doing the store jobs
	['id'] = 478,					-- Blip id
	['color'] = 5					-- Blip color
}

-- Cargo delivery locations (vector3)
Config.delivery_locations = {
	{ -952.31, -1077.87, 2.48 },
	{ -978.23, -1108.09, 2.16 },
	{ -1024.49, -1139.6, 2.75 },
	{ -1063.76, -1159.88, 2.56 },
	{ -1001.68, -1218.78, 5.75 },
	{ -1171.54, -1575.61, 4.51 },
	{ -1097.94, -1673.36, 8.4 },
	{ -1286.17, -1267.12, 4.52 },
	{ -1335.75, -1146.55, 6.74 },
	{ -1750.47, -697.09, 10.18 },
	{ -1876.84, -584.39, 11.86 },
	{ -1772.23, -378.12, 46.49 },
	{ -1821.38, -404.97, 46.65 },
	{ -1965.33, -296.96, 41.1 },
	{ -3089.24, 221.49, 14.07 },
	{ -3088.62, 392.3, 11.45 },
	{ -3077.98, 658.9, 11.67 },
	{ -3243.07, 931.84, 17.23 },
	{ 1230.8, -1590.97, 53.77 },
	{ 1286.53, -1604.26, 54.83 },
	{ 1379.38, -1515.23, 58.24 },
	{ 1379.38, -1515.23, 58.24 },
	{ 1437.37, -1492.53, 63.63 },
	{ 450.04, -1863.49, 27.77 },
	{ 403.75, -1929.72, 24.75 },
	{ 430.16, -1559.31, 32.8 },
	{ 446.06, -1242.17, 30.29 },
	{ 322.39, -1284.7, 30.57 },
	{ 369.65, -1194.79, 31.34 },
	{ 474.27, -635.05, 25.65 },
	{ 158.87, -1215.65, 29.3 },
	{ 154.68, -1335.62, 29.21 },
	{ 215.54, -1461.67, 29.19 },
	{ 167.46, -1709.3, 29.3 },
	{ -444.47, 287.68, 83.3 },
	{ -179.56, 314.25, 97.88 },
	{ -16.07, 216.7, 106.75 },
	{ 164.02, 151.87, 105.18 },
	{ 840.2, -181.93, 74.19 },
	{ 952.27, -252.17, 67.77 },
	{ 1105.27, -778.84, 58.27 },
	{ 1099.59, -345.68, 67.19 },
	{ -1211.12, -401.56, 38.1 },
	{ -1302.69, -271.32, 40.0 },
	{ -1468.65, -197.3, 48.84 },
	{ -1583.18, -265.78, 48.28 },
	{ -603.96, -774.54, 25.02 },
	{ -805.14, -959.54, 18.13 },
	{ -325.07, -1356.35, 31.3 },
	{ -321.94, -1545.74, 31.02 },
	{ -428.95, -1728.13, 19.79 },
	{ -582.38, -1743.65, 22.44 },
	{ -670.43, -889.09, 24.5 },
	{ 1691.4, 3866.21, 34.91 },
	{ 1837.93, 3907.12, 33.26 },
	{ 1937.08, 3890.89, 32.47},
	{ 2439.7, 4068.45, 38.07 },
	{ 2592.26, 4668.98, 34.08 },
	{ 1961.53, 5184.91, 47.98 },
	{ 2258.59, 5165.84, 59.12 },
	{ 1652.7, 4746.1, 42.03 },
	{ -359.09, 6062.05, 31.51 },
	{ -160.13, 6432.2, 31.92 },
	{ 33.33, 6673.27, 32.19 },
	{ 175.03, 6643.14, 31.57 },
	{ 22.8, 6488.44, 31.43 },
	{ 64.39, 6309.17, 31.38 },
	{ 122.42, 6406.02, 31.37 },
	{ 1681.2, 6429.11, 32.18 },
	{ 2928.01, 4474.74, 48.04 },
	{ 2709.92, 3454.83, 56.32 },
	{ -688.75, 5788.9, 17.34 },
	{ -436.13, 6154.93, 31.48 },
	{ -291.09, 6185.0, 31.49 },
	{ 405.31, 6526.38, 27.69 },
	{ -20.38, 6567.13, 31.88 },
	{ -368.06, 6341.4, 29.85 },
	{ 1842.89, 3777.72, 33.16 },
	{ 1424.82, 3671.73, 34.18 },
	{ 996.54, 3575.55, 34.62 },
	{ 1697.52, 3596.14, 35.56 },
	{ 2415.05, 5005.35, 46.68 },
	{ 2336.21, 4859.41, 41.81},
	{ 1800.9, 4616.07, 37.23 },
	{ -453.3, 6336.9, 13.11 },
	{ -425.4, 6356.43, 13.33 },
	{ -481.9, 6276.47, 13.42 },
	{ -693.92, 5761.95, 17.52 },
	{ -682.03, 5770.96, 17.52 },
	{ -379.44, 6062.07, 31.51 },
	{ -105.68, 6528.7, 30.17 },
	{ 35.02, 6662.61, 32.2 },
	{ 126.41, 6353.64, 31.38 },
	{ 48.15, 6305.99, 31.37 },
	{ 1417.68, 6343.83, 24.01 },
	{ 1510.21, 6326.28, 24.61 },
	{ 1698.22, 6425.66, 32.77 },
	{ 2434.69, 5011.7, 46.84 },
	{ 1718.88, 4677.32, 43.66 },
	{ 1673.21, 4958.09, 42.35 },
	{ 1364.33, 4315.43, 37.67 },
	{ -1043.6, 5326.84, 44.58 },
	{ -329.63, 6150.58, 32.32 },
	{ -374.41, 6191.04, 31.73 },
	{ -356.63, 6207.34, 31.85 },
	{ -347.15, 6224.69, 31.7 },
	{ -315.61, 6194.0, 31.57 },
	{ -33.3, 6455.87, 31.48 },
	{ 405.52, 6526.59, 27.7 },
	{ 1470.41, 6513.71, 21.23 },
	{ 1593.73, 6460.56, 25.32 },
	{ 1741.31, 6420.19, 35.05 },
}

-- Product export locations (vector3)
Config.export_locations = {
    {-758.14, 5540.96, 33.49},
    {-3046.19, 143.27, 11.6},
    {-1153.01, 2672.99, 18.1},
    {622.67, 110.27, 92.59},
    {-574.62, -1147.27, 22.18},
    {376.31, 2638.97, 44.5},
    {1738.32, 3283.89, 41.13},
    {1419.98, 3618.63, 34.91},
    {1452.67, 6552.02, 14.89},
    {3472.4, 3681.97, 33.79},
    {2485.73, 4116.13, 38.07},
    {65.02, 6345.89, 31.22},
    {-303.28, 6118.17, 31.5},
    {-63.41, -2015.25, 18.02},
    {-46.35, -2112.38, 16.71},
    {-746.6, -1496.67, 5.01},
    {369.54, 272.07, 103.11},
    {907.61, -44.12, 78.77},
    {-1517.31, -428.29, 35.45},
    {235.04, -1520.18, 29.15},
    {34.8, -1730.13, 29.31},
    {350.4, -2466.9, 6.4},
    {1213.97, -1229.01, 35.35},
    {1395.7, -2061.38, 52.0},
    {729.09, -2023.63, 29.31},
    {840.72, -1952.59, 28.85},
    {551.76, -1840.26, 25.34},
    {723.78, -1372.08, 26.29},
    {-339.92, -1284.25, 31.32},
    {1137.23, -1285.05, 34.6},
    {466.93, -1231.55, 29.95},
    {442.28, -584.28, 28.5},
    {1560.52, 888.69, 77.46},
    {2561.78, 426.67, 108.46},
    {569.21, 2730.83, 42.07},
    {2665.4, 1700.63, 24.49},
    {1120.1, 2652.5, 38.0},
    {2004.23, 3071.87, 47.06},
    {2038.78, 3175.7, 45.09},
    {1635.54, 3562.84, 35.23},
    {2744.55, 3412.43, 56.57},
    {1972.17, 3839.16, 32.0},
    {1980.59, 3754.65, 32.18},
    {1716.0, 4706.41, 42.69},
    {1691.36, 4918.42, 42.08},
    {1971.07, 5165.12, 47.64},
    {1908.78, 4932.06, 48.97},
    {140.79, -1077.85, 29.2},
    {-323.98, -1522.86, 27.55},
    {-1060.53, -221.7, 37.84},
    {2471.47, 4463.07, 35.3},
    {2699.47, 3444.81, 55.8},
    {-1060.53, -221.7, 37.84},
    {2655.38, 3281.01, 55.24},
    {2730.39, 2778.2, 36.01},
    {-2966.68, 363.37, 14.77},
    {2788.89, 2816.49, 41.72},
    {-604.45, -1212.24, 14.95},
    {2534.83, 2589.08, 37.95},
    {-143.31, 205.88, 92.12},
    {2347.04, 2633.25, 46.67},
    {860.47, -896.87, 25.53},
    {973.34, -1038.19, 40.84},
    {-409.04, 1200.44, 325.65},
    {-1617.77, 3068.17, 32.27},
    {-71.8, -1089.98, 26.56},
    {-409.04, 1200.44, 325.65},
    {-1617.77, 3068.17, 32.27},
    {1246.34, 1860.78, 79.47},
    {-1777.63, 3082.36, 32.81},
    {-1775.87, 3088.13, 32.81},
    {-1827.5, 2934.11, 32.82},
    {-2123.69, 3270.14, 32.82},
    {-2444.59, 2981.63, 32.82},
    {-2448.59, 2962.8, 32.82},
    {-2277.86, 3176.57, 32.81},
    {-2969.0, 366.46, 14.77},
    {-1637.61, -814.53, 10.17},
    {-1494.72, -891.67, 10.11},
    {-902.27, -1528.42, 5.03},
    {-1173.93, -1749.87, 3.97},
    {-1087.8, -2047.55, 13.23},
    {-1133.74, -2035.99, 13.21},
    {-1234.4, -2092.3, 13.93},
    {-1025.97, -2223.62, 8.99},
    {850.42, 2197.69, 51.93},
    {42.61, 2803.45, 57.88},
    {-1193.54, -2155.4, 13.2},
    {-1184.37, -2185.67, 13.2},
    {2041.76, 3172.26, 44.98},
    {-465.48, -2169.09, 10.01},
    {-3150.77, 1086.55, 20.7},
    {-433.69, -2277.29, 7.61},
    {-395.18, -2182.97, 10.29},
    {-3029.7, 591.68, 7.79},
    {-3029.7, 591.68, 7.79},
    {-1007.29, -3021.72, 13.95},
    {-61.32, -1832.75, 26.8},
    {822.72, -2134.28, 29.29},
    {942.22, -2487.76, 28.34},
    {729.29, -2086.53, 29.3},
    {783.08, -2523.98, 20.51},
    {717.8, -2111.18, 29.22},
    {787.05, -1612.38, 31.17},
    {913.52, -1556.87, 30.74},
    {777.64, -2529.46, 20.13},
    {846.71, -2496.12, 28.34},
    {711.79, -1395.19, 26.35},
    {723.38, -1286.3, 26.3},
    {983.0, -1230.77, 25.38},
    {818.01, -2422.85, 23.6},
    {885.53, -1166.38, 24.99},
    {700.85, -1106.93, 22.47},
    {882.26, -2384.1, 28.0},
    {977.83, -1821.21, 31.17},
    {-1138.73, -759.77, 18.87},
    {938.71, -1154.36, 25.38},
    {973.0, -1156.18, 25.43},
    {689.41, -963.48, 23.49},
    {140.72, -375.29, 43.26},
    {-497.09, -62.13, 39.96},
    {-606.34, 187.43, 70.01},
    {117.12, -356.15, 42.59},
    {53.91, -1571.07, 29.47},
    {1528.1, 1719.32, 109.97},
    {1411.29, 1060.33, 114.34},
    {1145.76, -287.73, 68.96},
    {1117.71, -488.25, 65.25},
    {874.28, -949.16, 26.29},
    {829.28, -874.08, 25.26},
    {725.37, -874.53, 24.67},
    {693.66, -1090.43, 22.45},
    {977.51, -1013.67, 41.32},
    {901.89, -1129.9, 24.08},
    {911.7, -1258.04, 25.58},
    {847.06, -1397.72, 26.14},
    {830.67, -1409.13, 26.16},
    {130.47, -1066.12, 29.2},
    {-52.79, -1078.65, 26.93},
    {-131.74, -1097.38, 21.69},
    {-621.47, -1106.05, 22.18},
    {-668.65, -1182.07, 10.62},
    {-111.84, -956.71, 27.27},
    {-1323.51, -1165.11, 4.73},
    {-1314.65, -1254.96, 4.58},
    {-1169.18, -1768.78, 3.87},
    {-1343.38, -744.02, 22.28},
    {-1532.84, -578.16, 33.63},
    {-1461.4, -362.39, 43.89},
    {-1457.25, -384.15, 38.51},
    {-1544.42, -411.45, 41.99},
    {-1432.72, -250.32, 46.37},
    {-1040.24, -499.88, 36.07},
    {346.43, -1107.19, 29.41},
    {523.99, -2112.7, 5.99},
    {977.19, -2539.34, 28.31},
    {1101.01, -2405.39, 30.76},
    {1591.9, -1714.0, 88.16},
    {1693.41, -1497.45, 113.05},
    {1029.44, -2501.31, 28.43},
    {2492.55, -320.89, 93.0},
    {2846.31, 1463.1, 24.56},
    {3631.05, 3768.61, 28.52},
    {3572.5, 3665.53, 33.9},
    {2919.03, 4337.85, 50.31},
    {2521.47, 4203.47, 39.95},
    {2926.2, 4627.28, 48.55},
    {3808.59, 4463.22, 4.37},
    {3323.71, 5161.1, 18.4},
    {2133.06, 4789.57, 40.98},
    {1900.83, 4913.82, 48.87},
    {381.06, 3591.37, 33.3},
    {642.8, 3502.47, 34.09},
    {277.33, 2884.71, 43.61},
    {-60.3, 1961.45, 190.19},
    {225.63, 1244.33, 225.46},
    {-1136.15, 4925.14, 220.01},
    {-519.96, 5243.84, 79.95},
    {-602.87, 5326.63, 70.46},
    {-797.95, 5400.61, 34.24},
    {-776.0, 5579.11, 33.49},
    {-704.2, 5772.55, 17.34},
    {-299.24, 6300.27, 31.5},
    {402.52, 6619.61, 28.26},
    {-247.72, 6205.46, 31.49},
    {-267.5, 6043.45, 31.78},
    {-16.29, 6452.44, 31.4},
    {2204.73, 5574.04, 53.74},
    {1638.98, 4840.41, 42.03},
    {1961.26, 4640.93, 40.71},
    {1776.61, 4584.67, 37.65},
    {137.29, 281.73, 109.98},
    {588.37, 127.87, 98.05},
    {199.8, 2788.78, 45.66},
    {708.58, -295.1, 59.19},
    {581.28, 2799.43, 42.1},
    {1296.73, 1424.35, 100.45},
    {955.85, -22.89, 78.77}
}

-- Config for npcs that will stand in the stores
Config.NPCs = {
	{
		['model'] = 'mp_m_shopkeep_01',				-- Ped model (https://docs.fivem.net/docs/game-references/ped-models/)
		['emote'] = 'WORLD_HUMAN_STAND_MOBILE',		-- Ped emote (https://wiki.rage.mp/index.php?title=Scenarios)
		['pos'] = {									-- Ped locations (vector4)
			{24.47, -1346.62, 29.5, 271.66},
			{-3039.54, 584.38, 7.91, 17.27},
			{-3242.97, 1000.01, 12.83, 357.57},
			{1959.82, 3740.48, 32.34, 301.57},
			{549.13, 2670.85, 42.16, 99.39},
			--{2677.47, 3279.76, 55.24, 335.08},
			{2556.66, 380.84, 108.62, 356.67},
			{372.66, 326.98, 103.57, 253.73},
			{-47.02, -1758.23, 29.42, 45.05},
			{-706.06, -913.97, 19.22, 88.04},
			{-1820.02, 794.03, 138.09, 135.45},
			{1164.71, -322.94, 69.21, 101.72},
			{1697.87, 4922.96, 42.06, 324.71},
			{-1221.58, -908.15, 12.33, 35.49},
			{-1486.59, -377.68, 40.16, 139.51},
			{-2966.39, 391.42, 15.04, 87.48},
			{1165.17, 2710.88, 38.16, 179.43},
			{1134.2, -982.91, 46.42, 277.24}


			--{324.69, -583.57, 43.27, 161.27} --- EMS_Cafe
		}
	},
	{
		['model'] = 's_m_y_ammucity_01',
		['emote'] = 'WORLD_HUMAN_COP_IDLES',
		['pos'] = {
			{14.1, -1105.29, 29.11, 159.19}, 
			{818.31, -2156.34, 28.93, 0.14},  
			{253.68, -50.86, 69.94, 74.85},
			{-1304.25, -394.99, 36.7, 73.71}, 
			{841.97, -1035.3, 28.19, 356.07}, 
			{1692.52, 3761.19, 34.71, 231.02}, 
			{-331.41, 6085.19, 31.45, 226.12},
		}
	},
	{
		['model'] = 'a_m_y_business_02',
		['emote'] = 'WORLD_HUMAN_COP_IDLES',
		['pos'] = {
			{1128.69, -471.06, 66.54, 253.34},
			{-659.98, -863.17, 24.5, 358.3},
			{388.43, -825.02, 29.29, 184.3},
			{1648.32, 4850.89, 42.0, 272.33},
			{-1315.78, -404.8, 36.61, 30.77},
			{-33.94, -1041.9, 28.51, 67.8}
		}
	},
}


Config.create_table = true
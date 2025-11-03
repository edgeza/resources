Config = Config or {}
Config.Debug = false   -- Set to true ONLY for testing/debugging (Keep false for live server)

--- ### FREAMWORK ### ----
Config.Framework = "qbx" -- YOUR FRAMEWORK: qb, esx, qbx, standalone, auto (auto detects automatically)

--- ### Database ### ----
Config.DatabaseAutoSetup = true -- Automatically sets up database tables (Recommended: true)

--- ### Inventory ### ----
--- The script automatically detects your inventory. No changes needed unless you have issues
Config.QbInventory         = GetResourceState("qb-inventory") == 'started'
Config.OxInvetory          = GetResourceState("ox_inventory") == 'started' -- https://github.com/overextended/ox_inventory
Config.CoreInventory       = GetResourceState("core_inventory") == 'started' -- https://www.c8re.store/package/5123274
Config.qsInvetory          = GetResourceState("qs-inventory") == 'started' -- https://buy.quasar-store.com/package/4770732
Config.tgiannInventory     = GetResourceState("tgiann-inventory") == 'started'  -- https://store.tgiann.com/package/6273000

--- ### Phone settings ### ---
Config.KeyMapping          = true        -- Enable key binding for phone (Recommended: true)
Config.OpenPhone           = "F1"        -- Key to open phone (default: F1) (https://docs.fivem.net/docs/game-references/controls/)
Config.DefaultLocale       = "en"        -- DEFAULT LANGUAGE - CHANGE THIS! (en, tr, de, fr, es, etc.)
Config.Locales             = {"af", "ar", "cs", "de", "en", "es", "fr", "id", "nl", "pt-PT", "ro", "sv", "th", "tr", "uk", "zh-TW"} -- Available languages
Config.RegisterCommandName = "phone"     -- Command to open phone (/phone)
Config.ItemName = {  -- PHONE ITEM NAMES - MUST MATCH YOUR INVENTORY!
    ["iphone"] = "ios",     -- If you use "iphone" item, it opens iOS interface
    ["phone"] = "android"   -- If you use "phone" item, it opens Android interface
}
Config.PropName = { -- Phone props (3D models) - No need to change
    ["iphone"] = "patoche_iphone_15_gkphone",
    ["phone"] = "patoche_galaxy_s23_gkphone"
}
Config.ItemRequire = true           -- Require phone item to use phone? (true = yes, false = no) ( If the meta is active, the item's requirement must be true )
Config.DefaultPhoneModel = "phone"  -- Default phone if ItemRequire is false (iphone or phone)
Config.AutoOpen = false             -- Open phone automatically on spawn? (Not recommended) ( This function does not work in the metaitem )

Config.SerialNumberPrefix  = "GKS"       -- Phone serial number prefix (default: gks)
Config.PropActive          = true        -- Show phone prop in hand? (default: true)
Config.AirSharePlayerName  = false       -- Show player names in AirShare? (false = shows ID)
Config.WaitPhone           = 2           -- Set the time to wait before opening the phone (default: 2)
Config.MetaItem            = false       -- Use metadata for phones? (Only if your inventory supports it!)
Config.AutoDeleteData      = true        -- Auto-delete old data? (Recommended: true)
Config.AutoDeleteDays      = 5           -- Delete data older than X days (default: 5)
Config.deleteCharacter     = false       -- Delete phone data when character is deleted? !!!All data in Darkchat, Messages and similar applications will be deleted.!!!
Config.UnderWaterCheck     = false       -- Disable phone underwater? (true = disable underwater)
Config.RealApplication     = false       -- Enable if you purchased Real APP Integration -- https://service.gkshop.org/package/6368261

Config.PhoneNumber = {}
Config.PhoneNumber.Length = 5 -- PHONE NUMBER LENGTH (without area code) - CHANGE IF NEEDED!
Config.PhoneNumber.Prefixes = { -- AREA CODES - ADD YOUR OWN!
    "101",
    "201",
    "301",
    "401",
    "501"
}

--- ### EyeTarget Settings ### ---
Config.EyeTarget = false                  -- Enable eye target support? (ox_target, qb-target) -- gksphone/client/misc/eyetarget.lua

--- ### Voice Settings ### ---
Config.PMAVoice         = true                -- Using pma-voice? (Most common) https://github.com/AvarianKnight/pma-voice
Config.UseMumbleVoIP    = false               -- Using mumble-voip?  https://github.com/FrazzIe/mumble-voip
Config.SaltyChat        = false               -- Using SaltyChat? https://github.com/FirstWiseman/saltychat-fivem-lua
Config.YacaVoice        = false               -- Using yaca-voice?

--- ### Taxi APP Settings ### ---
Config.TaxiPaymentMethod = "billing"        -- Payment method for taxi service (billing, bank) - CHANGE IF NEEDED!
Config.TaxiPrice = 100                      -- TAXI PRICE PER KM - CHANGE THIS!
Config.TaxiJobCode = "taxi"                 -- YOUR TAXI JOB NAME - MUST MATCH YOUR FRAMEWORK!
Config.JobRequirement = false               -- Require taxi job to be taxi driver?
Config.AITaxi = true                        -- Enable AI taxi if no players available?
Config.AITaxiCarModel = "taxi"              -- AI taxi vehicle model
Config.TaxiCustomerNPC = true               -- NPC Customers
Config.TaxiPenaltyMin = 2                   -- The time when the player will receive a penalty when player cancels the job
Config.TaxiTipNPC = math.random(5, 30)      -- NPC customers' tip will receive
Config.TaxiTipChance = 60                   -- Tip percentage

Config.TaxiBlips = {
    customer = {
        blip = 280,   -- https://docs.fivem.net/docs/game-references/blips/
        colour = 3,   -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        routeColour = 3,    -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        scale = 1,
        text = "Taxi Customer"
    },
    destination = {
        blip = 1,           -- https://docs.fivem.net/docs/game-references/blips/
        colour = 5,         -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        routeColour = 5,    -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        scale = 0.7,
        text = "Customer's Destination"
    },
    AITaxi = {
        blip = 198,         -- https://docs.fivem.net/docs/game-references/blips/
        colour = 5,         -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        scale = 0.7,
        text = "AI Taxi"
    }
}

Config.TaxiRoutesNPC = {
    {
        coord = vec4(-1378.91, -74.53, 51.29, 12.09),
        street = "ROCKFORD HILLS",
        npcName = "Bailey Sykes",
    },
    {
        coord = vec4(-352.58, -1445.13, 28.43, 5.09),
        street = "LA PUERTA",
        npcName = "Aroush Goodwin",
    },
    {
        coord = vec4(374.12, -415.62, 44.97, 36.24),
        street = "ALTA",
        npcName = "Tom Warren",
    },
    {
        coord = vec4(-2111.71, -351.48, 13.01, 154.43),
        street = "PACIFIC BLUFFS",
        npcName = "Abdallah Friedman",
    },
    {
        coord = vec4(-1412.03, -567.61, 29.37, 216.83),
        street = "DEL PERRO",
        npcName = "Lavinia Powell",
    },
    {
        coord = vec4(285.46, 1092.02, 215.63, 304.25),
        street = "VINEWOOD HILLS",
        npcName = "Andrew Delarosa",
    },
    {
        coord = vec4(150.27, -999.73, 29.36, 162.48),
        street = "LEGION SQUARE",
        npcName = "Mira Khan",
    },
    {
        coord = vec4(1809.97, 3868.91, 33.97, 25.48),
        street = "SANDY SHORES",
        npcName = "Adrian Leung"
    },
    {
        coord = vec4(1681.32, 4822.3, 42.06, 111.86),
        street = "GRAPESEED",
        npcName = "Sofia Costa"
    },
    {
        coord = vec4(-241.61, 6304.86, 31.45, 224.48),
        street = "PALETO BAY",
        npcName = "Maya Gaines"
    },
    {
        coord = vec4(1366.54, -592.7, 74.38, 350.37),
        street = "MIRROR PARK",
        npcName = "Leslie Mack"
    }
}

Config.TaxiNPCPedModels = {
    "a_f_m_bevhills_01",
    "a_f_y_bevhills_03",
    "a_m_y_beachvesp_01",
    "a_m_y_hasjew_01",
    "a_m_y_genstreet_01",
    "a_m_y_ktown_02",
    "a_f_y_runner_01",
    "a_f_o_ktown_01",
    "a_m_m_business_01",      
    "a_f_y_hippie_01",        
    "a_f_y_tourist_01",       
    "a_m_m_soucent_01",       
    "a_m_y_skater_01",        
    "a_f_m_ktown_01",         
    "a_f_y_beach_01",         
    "a_m_o_soucent_02",     
    "a_m_y_vinewood_01",      
    "a_m_m_hillbilly_01",    
    "a_f_y_scdressy_01",      
    "a_m_y_stbla_02",  
}

--- ### House APP Settings ### ---
Config.HouseScript = "auto" -- YOUR HOUSING SCRIPT: loaf_housing, bcs_housing, qs-housing, qb-houses, esx_property

--- ### Bank APP Settings ### ---
Config.BankTransferTax      = 10      -- BANK TRANSFER FEE % - CHANGE THIS!
Config.OfflineBankTransfer  = false   -- Allow transfers to offline players?
Config.MetaBankTransfer     = false   -- Allow transfers from other's phones?

--- ### Garage/Vale Settings ### ---
Config.ValespawnRadius  = 150.0     -- Max distance to spawn vehicle
Config.ValePrice        = 100       -- VALET SERVICE PRICE - CHANGE THIS!
Config.ValeNPC          = true      -- Enable valet NPC? (default: true)
Config.ImpoundVale      = true      -- Will valet service be provided for impounded vehicles? (true = valet service is not provided, false = valet service is provided)
Config.ValeNPCModel     = "s_m_y_valet_01" -- Valet NPC model

Config.ValeBlaclistCars = { -- VEHICLES THAT VALET CANNOT BRING - ADD YOUR OWN!
    "police",
    "police2",
    "police3",
    "ambulance",
}

--- ### Car Seller App Settings ### ---
Config.CarSellerAppFee = 10 -- CAR SELLING FEE % - CHANGE THIS! (default: 10)
Config.SellerBlaclistCars = { -- VEHICLES THAT CANNOT BE SOLD - ADD YOUR OWN!
    "police",
    "police2",
    "police3",
    "ambulance",
}

--- ### Advertising APP Settings ### ---
Config.AdvertisingPrice = 1000    -- PRICE TO POST AN AD - CHANGE THIS!

--- ### Twitter APP Settings ### ---
Config.TwitterVerifyCommand = "twitterverify"   -- Admin command for verified badge
Config.TwitterSendBlockCommand = "blocktwitter" -- Admin command to block users
Config.TwitterSendBanCommand = "bantwitter"     -- Admin command to ban users
Config.TwitterSubsDate = 5                      -- Twitter Blue renewal days
Config.TwitterSubsPay = 15                      -- TWITTER BLUE PRICE - CHANGE THIS!

-- ## PHONE BOOTH SETTINGS ## --
Config.PhoneBox = false                         -- Enable phone booths? (true/false)
Config.PhoneBoxKey = "E"                        -- Key to use phone booth
Config.PhoneBoxRegCom = "phonebox"              -- Command to create phone booth
Config.PhoneBootNumber = "22222"                -- PHONE BOOTH NUMBER - CHANGE IF NEEDED!
Config.PhoneBoothMoney = { actived = true, money = 500 }   -- Phone booth usage fee
Config.PhoneBoothModel = {      -- Phone booth models
	[1281992692] = true,
    [1158960338] = true,
    [295857659] = true,
    [-78626473] = true,
    [-2103798695] = true,
    [1511539537] = true,
    [-1559354806] = true
}

-- ## Crypto App Settings ## --
Config.StockMarket = true -- Enable stock market feature?
Config.Qbit = true -- Enable QBit crypto? (requires qb-crypto & qb-core)

-- Cryptos to use
-- You can add or turn off any crypto you want. (https://api.coingecko.com/api/v3/coins/list?include_platform=false) Crypto list that can be added
-- AVAILABLE CRYPTOCURRENCIES - Enable/Disable as needed
Config.AllowCoin = {
    ["bitcoin"] = true,
    ["ethereum"] = true,
    ["tether"] = true,
    ["binance-usd"] = true,
    ["uniswap"] = true,
    ["binancecoi"] = true,
    ["terra-luna"] = true,
    ["avalanche-2"] = true,
    ["cardano"] = true,
    ["ripple"] = true,
    ["usd-coin"] = true,
    ["dogecoin"] = true,
    ["litecoin"] = true,
    ["chainlink"] = true,
    ["stellar"] = true,
    ["tron"] = true,
    ["eos"] = true,
    ["monero"] = true,
    ["iota"] = true
}

-- ### Live APP Settings ### ---

Config.LiveStreamCoinTax = 10   -- LIVESTREAM Coin sale FEE % - CHANGE THIS!

--------  E-SIM ---------
--- SIM CARD SETTINGS ---
Config.DefaultOperator = "GKS"      -- Replace with Default Operator ID - CHANGE THIS!
Config.DefaultPackage = 1           -- Default package ID
Config.UseSIMPackage = true         -- Enable SIM packages?
Config.LimitPhoneNumbers = 3        -- Max phone numbers per player

-- PHONE CARRIERS/OPERATORS - CUSTOMIZE YOUR OWN!
Config.Operators = {
    ["GKS"] = {                 -- Operator ID
        ["name"] = "GKS",       -- Operator ID
        ["label"] = "GKS",      -- CHANGE THIS TO YOUR CARRIER NAME!
        ["sms"] = 1,            -- SMS COST
        ["call"] = 1,           -- CALL COST
        ["internet"] = 1,       -- INTERNET COST
        ["newnumber"] = 1000    -- NEW NUMBER COST
    },
    ["GMobile"] = {
        ["name"] = "GKS",
        ["label"] = "GMobile",
        ["sms"] = 1,
        ["call"] = 1,
        ["internet"] = 1,
        ["newnumber"] = 1000
    },
    ["GCellular"] = {
        ["name"] = "GKS",
        ["label"] = "GCellular",
        ["sms"] = 1,
        ["call"] = 1,
        ["internet"] = 1,
        ["newnumber"] = 1000
    }
}

-- SIM PACKAGES - CUSTOMIZE NAMES AND PRICES!
Config.SIMPackages = {
    ["GKS"] = {
        {
            ["package_name"] = "Young 1",   -- CHANGE PACKAGE NAME!
            ["package_price"] = 100,        -- CHANGE PRICE!
            ["package_sms"] = 1000,         -- SMS AMOUNT
            ["package_call"] = 1000,        -- CALL MINUTES
            ["package_internet"] = 1000     -- INTERNET
        },
        {
            ["package_name"] = "Young 2",
            ["package_price"] = 200,
            ["package_sms"] = 2000,
            ["package_call"] = 2000,
            ["package_internet"] = 2000
        },
        {
            ["package_name"] = "Young 4",
            ["package_price"] = 400,
            ["package_sms"] = 4000,
            ["package_call"] = 4000,
            ["package_internet"] = 4000
        }
    },
    ["GMobile"] = {
        {
            ["package_name"] = "Eco",
            ["package_price"] = 100,
            ["package_sms"] = 1000,
            ["package_call"] = 1000,
            ["package_internet"] = 1000
        },
        {
            ["package_name"] = "Middle",
            ["package_price"] = 200,
            ["package_sms"] = 2000,
            ["package_call"] = 2000,
            ["package_internet"] = 2000
        },
        {
            ["package_name"] = "Pro",
            ["package_price"] = 400,
            ["package_sms"] = 4000,
            ["package_call"] = 4000,
            ["package_internet"] = 4000
        }
    },
    ["GCellular"] = {
        {
            ["package_name"] = "Young",
            ["package_price"] = 100,
            ["package_sms"] = 1000,
            ["package_call"] = 1000,
            ["package_internet"] = 1000
        },
        {
            ["package_name"] = "Retired",
            ["package_price"] = 200,
            ["package_sms"] = 2000,
            ["package_call"] = 2000,
            ["package_internet"] = 2000
        },
        {
            ["package_name"] = "Middle",
            ["package_price"] = 400,
            ["package_sms"] = 4000,
            ["package_call"] = 4000,
            ["package_internet"] = 4000
        }
    }
}

-- DATA USAGE PER ACTION - Adjust if using SIM packages
Config.UseSIMData = {
    ["AdvertisingPost"] = 20,
    ["AdvertisingDelete"] = 10,
    ["CarSellerAdd"] = 20,
    ["CarSellerDelete"] = 10,
    ["CarSellerBuy"] = 20,
    ["CryptoBuy"] = 20,
    ["CryptoSell"] = 30,
    ["CryptoTransfer"] = 20,
    ["DarkChatNewChannel"] = 20,
    ["DarkChatRemoveChannel"] = 10,
    ["DarkChatGetMessage"] = 50,
    ["DarkChatSendMessage"] = 30,
    ["DispatchSendChatMessage"] = 20,
    ["DispatchSendReport"] = 30,
    ["GamesScoreSave"] = 5,
    ["LiveStreamCreate"] = 100,
    ["LiveStreamWatch"] = 100,
    ["MailSend"] = 10,
    ["PlaytubeSearch"] = 50,
    ["SquawkPost"] = 20,
    ["SquawkLike"] = 5,
    ["SquawkRetweet"] = 5,
    ["SquawkPostDelete"] = 5,
    ["TaxiCall"] = 10,
    ["TaxijobAccept"] = 10,
    ["SendMessage"] = 1
}

-- ### Billing Setting ### ---

-- Commission rate for each jobs
-- This is a percentage (0.10) == 10% ( Must be active to receive commission - If the player is not in the game, she/he cannot receive a commission.)
Config.AutoPaidBillDelete = true    -- Auto-delete paid bills?
Config.UnpaidBillInterest = false   -- Add interest to unpaid bills?
Config.BillInterest = { day = 7, percent = 20 }  -- After 7 days, add 20% interest
Config.UseBillingCommission = false -- Enable commission system?

-- COMMISSION RATES BY JOB - Player gets X% of bills they create
Config.BillingCommissions = {
    mechanic = 0.10,    -- 10% commission
    police = 0.20       -- 20% commission
}

-- WHO RECEIVES PAYMENT? true = player, false = company account
Config.BillPlayerFeeJobs = {
    ["police"] = false,  -- Payment goes to police department account
    ["taxi"] = true,     -- Payment goes directly to taxi driver
}


-- messageView = Authority according to job grade level
-- messageSend = Authority according to job grade level
-- reportView = Authority according to job grade level
-- reportDeleteAll = Authority according to job grade level
-- location = Location of the job center
-- label = Name of the job center
-- openClosingAuth = Authority according to job grade level (Turning Dispatch open and close)
-- isOpen = This profession can receive messages and reports while the server is just starting up. (true/false)
-- canCall = The option to call the job center is on or off
-- Duty = Whether the duty option will appear in the Actions section
-- playerNotifications = Will the opposing player receive a notification when Review is clicked?
-- alternativejobs = If you want to add an alternative job, you can add it here. (e.g. ["sheriff"] = true)
-- jobNumber = Job number (e.g. 911 for police, 912 for ambulance)
-- billing = Billing section
-- employe = Employee section
-- jobBalanceView = Authority according to job grade level (Viewing the balance of the job centered account)
-- showInList = Show in list?

Config.JOBServices = {
    ["police"] = {
        messageView = 2,
        messageSend = 2,
        reportView = 2,
        reportDeleteAll = 2,
        openClosingAuth = 2,
        location = vector4(-1726.85, -3111.37, 14.22, 239.89),
        label = "Police",
        isOpen = true,
        canCall = true,
        Duty = true,
        playerNotifications = true,
        alternativejobs= { ["sheriff"] = true },
        jobNumber = "911",
        billing = {
            view = 4,
            create = 4,
            delete = 4,
            pay = 4,
        },
        employe = {
            view = 4,
            changeRank = 4,
            fire = 4,
            add = 4,
        },
        jobBalanceView = 4,
        showInList = true
    },
    ["ambulance"] = { 
        messageView = 2,
        messageSend = 2,
        reportView = 2,
        reportDeleteAll = 2,
        openClosingAuth = 2,
        location = vector4(-1726.85, -3111.37, 14.22, 239.89),
        label = "EMS",
        isOpen = false,
        canCall = true,
        Duty = true,
        playerNotifications = true,
        jobNumber = "912",
        billing = {
            view = 2,
            create = 4,
            delete = 4,
            pay = 4,
        },
        employe = {
            view = 2,
            changeRank = 2,
            fire = 2,
            add = 2,
        },
        jobBalanceView = 2,
        showInList = true
    },
    ["mechanic"] = { 
        messageView = 2,
        messageSend = 2,
        reportView = 2,
        reportDeleteAll = 2,
        openClosingAuth = 2,
        location = vector4(-1726.85, -3111.37, 14.22, 239.89),
        label = "Mechanic",
        isOpen = false,
        canCall = true,
        Duty = true,
        playerNotifications = true,
        jobNumber = "",
        billing = {
            view = 2,
            create = 4,
            delete = 4,
            pay = 4,
        },
        employe = {
            view = 2,
            changeRank = 2,
            fire = 2,
            add = 2,
        },
        jobBalanceView = 2,
        showInList = true
    },
}

-- AUTO OPEN/CLOSE SERVICE BASED ON DUTY
Config.IsServicesAutoOpenClose = true -- Enable auto open/close?

-- JOBS TO IGNORE FOR AUTO OPEN/CLOSE
Config.ServicesAutoIgnoredJobs = {   -- Add here the jobs for which you want to ignore automatic on/off
    ["police"] = true,      -- Always stay open
    ["ambulance"] = true,   -- Always stay open
    ["mechanic"] = false,   -- Auto open/close based on duty
}

--- ## Casino APP Settings ## ---
Config.Casino = {
    Tax = 20,           -- CASINO CHIP SALE TAX % - CHANGE THIS!
    RollMaxBet = 5000,  -- MAX BET AMOUNT - CHANGE THIS!
}


---- ## MDT APP ## -----
Config.MDTApp = true    -- Enable MDT app? (requires qb-core)


--- ## Custom APP Settings ## ---

Config.CustomApps = {}
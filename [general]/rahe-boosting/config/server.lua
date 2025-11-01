svConfig = {
    -- The currency settings which are used to display money amount in the tablet's HTML.
    -- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toLocaleString
    -- The first variable (currencyLocale) defines how the number is formatted. For example in 'en-US': '$60,890.00', 'et': '60 890,00 $'
    -- The second variable (currency) defines the symbol which is used - €/$ or whatever you wish.
    currencyLocale = 'en-us',
    currency = 'USD',

    -- Time between boosting contract loop executions. If the default value (15) is used, then every 15 minutes (4 times per hour), contracts will be
    -- generated for the players who are queued. The chances of receiving a contract in that loop execution are defined in vehicle class configs, the
    -- 'generationPercentage' value. For example, if the 'D' class has a generationPercentage value of 70, then every 15 minutes there is a 70% chance
    -- that you will receive a D class boosting contract.
    minutesBetweenGenerations = 5,

    -- The amount of contracts that player will be given when he opens the tablet for the very first time (to get him started).
    initialContractAmount = 5,

    -- The amount of online police required for people to get important (A / S class) contracts. This will be applied to classes which have the 'isImportant' as true.
    requiredPoliceAmount = 4,

    --  Define the principal which will be given the ACE permission to use the in-game admin panel. If you don't wish to use this, set it to false.
    -- In order for this to work, make sure you allow ox_lib to grant permissions (https://overextended.dev/ox_lib) ('You'll also need to grant ace permissions to the resource.')
    adminPrincipal = 'group.admin',

    -- A comma separated list of player identifiers (strings) that are allowed to access the admin panel (in addition to those allowed by ACE permissions).
    -- Examples for different frameworks:
    --
    -- QB: adminIdentifiers = {'RKDJ2732', 'MNSU0922'},
    -- ESX: adminIdentifiers = {'char1:17beaa0fce04fd5d7e8571a6a1b51f172e7c4457', 'char1:17beaa0fce04fd5d7e8571a6a1b51f172e7c4457'},
    adminIdentifiers = {},

    -- If the player should be penalized during delivery for having an engine whose health is below 80%.
    penalizeForDamagedEngine = true,

    -- The amount in dollars that's the maximum penalty for having a damaged engine when dropping off.
    maximumEngineDamagePenalty = 500,

    -- If the vehicle were in the center of the indicated area, it would be found instantly. To prevent this, an offset is used. This value determines
    -- the min/max offset of the x and y axis (randomly generated between 0 and this value) from the vehicle spawn point (in meters).
    -- Related client-side config values: vehicleCreationDistance, vehicleAreaRadius
    vehicleAreaMaximumOffset = 145.0,

    -- An option to enable / disable VIN scratching. If disabled, then the player will get an error message when trying to VIN scratch a vehicle.
    vinScratchingEnabled = true,

    -- Determine whether experience should be distributed among group members when performing a contract with a group.
    -- Set to 'true' for experience to be shared among group members.
    -- Set to 'false' for experience to be given only to the contract owner.
    splitExperienceInGroups = true,

    -- If all group members must enter the red pick up area at least once to get any kind of rewards (money, crypto, XP) in the end.
    -- This can be used to prevent abuse situations where people are group boosting and some of the members are just AFKing along to get XP.
    groupActivityCheck = true,

    -- If this is defined, the user will be shown an 'Upload' button in the profile picture upload section.
    -- When pressed, the user will be redirected to this website in their browser to upload their content.
    recommendedUploadWebsite = 'https://upload.rahe.dev',

    -- A list of image hosts will be allowed to use as a profile picture. The player won't be allowed to use a provider which isn't in this list.
    -- If you have a 'recommendedUploadWebsite' defined in the previous option, then that will automatically be added into here.
    --
    -- We do NOT recommend using Imgur or Discord as allowed hosts!
    -- They rate-limit and/or change URLs causing your images to stop working sooner or later, even if they may seem fine at first.
    allowedImageHosts = {
        'media.rahe.dev',
        'r2.fivemanage.com'
    },

    -- A list of conditions for different vehicle classes
    -- The list must be ordered by their 'xpRequired' value (high -> low)

    -- Class parameters explained:
    -- @class: the main identifier, used for displaying and getting a vehicles class
    -- @xpRequired: experience required for a player to receive a contract of this class
    -- @generationPercentage: the probability of a player getting this class when a generation occurs (0-100%)
    -- @timeBetweenGenerations: the time in minutes that has to be passed since the last generation of this class
    -- @isImportant: if a class is important, then it needs police presence for it to be generated (svConfig.requiredPoliceAmount) and has a GPS tracker.
    -- @gpsHacksRequired: if the class is marked is important, then it will have a GPS tracker which has to be hacked this many times.
    -- @gpsHackMinTime: the minimum amount of time the player has to complete the GPS hacking mini game.
    -- @gpsHackMaxTime: the maximum amount of time the player has to complete the GPS hacking mini game.
    -- @maxContractsOfType: how many contracts of this type can be available at once
    -- @maxContactsPerSession: how many contracts of this type can one player receive per restart
    -- @priceMin: the minimum crypto price needed to accept the contract
    -- @priceMax: the maximum crypto price needed to accept the contract
    -- @minScratchPrice = the minimum crypto price needed to VIN scratch (take it yourself) the vehicle
    -- @maxScratchPrice = the maximum crypto price needed to VIN scratch (take it yourself) vehicle
    -- @rewardCashMin: the minimum cash reward
    -- @rewardCashMax: the maximum cash reward
    -- @rewardCryptoMin: the minimum crypto reward
    -- @rewardCryptoMax: the maximum crypto reward
    -- @experiencePerJob: amount of experience points received when the contract is successful
    -- @bonusExperienceMultiplier: the multiplier by which 'experiencePerJob' will be multiplied with when 'bonusExperienceMinimumMembers' is reached. Used only when 'splitExperienceInGroups' is true.
    -- @bonusExperienceMinimumMembers: the minimum number of members required within a group for the bonus 'bonusExperienceMultiplier' to take effect. Used only when 'splitExperienceInGroups' is true.
    -- @tuningChance: the probability of the vehicle being tuned (0-100%)
    -- @riskChances: the probability of different risks on the vehicle
        -- @doorsLocked: the probability that vehicle doors are locked
        -- @advancedLockChance: the probability that vehicle doors are locked with an advanced lock (must use a better lock pick than the bad one)
        -- @advancedSystemChance: the probability that vehicle doors are locked with an high-tech system (must use a hacking device)
        -- @npcChance: the probability (percentage 0-100) that killer NPCs will spawn when you try to hack the vehicle.
            -- npcChance can only be higher than 0 on classes that have isImportant = true. This is because isImportant boosts use different spawns that
            -- have npc spawn locations built in (shared.lua advancedVehicleCoords). DO NOT use this variable on lower, non-important boosts.

    vehicleClasses = {
        [1] = {
            class = "S",
            xpRequired = 2300,
            generationPercentage = 50,
            timeBetweenGenerations = 40,
            isImportant = true,
            gpsHacksRequired = 20,
            gpsHackMinTime = 30,
            gpsHackMaxTime = 40,
            maxContractsOfType = 1,
            maxContractsPerSession = 1,
            priceMin = 500,
            priceMax = 900,
            minScratchPrice = 5000,
            maxScratchPrice = 8000,
            rewardCashMin = 8000,
            rewardCashMax = 12000,
            rewardCryptoMin = 1000,
            rewardCryptoMax = 1500,
            experiencePerJob = 12,
            bonusExperienceMultiplier = 4,
            bonusExperienceMinimumMembers = 4,
            tuningChance = 70,
            riskChances = {
                doorsLocked = 100,
                advancedLockChance = 0,
                advancedSystemChance = 100,
                npcChance = 100
            }
        },
        [2] = {
            class = "A",
            xpRequired = 1300,
            generationPercentage = 50,
            timeBetweenGenerations = 20,
            isImportant = true,
            gpsHacksRequired = 10,
            gpsHackMinTime = 30,
            gpsHackMaxTime = 40,
            maxContractsOfType = 2,
            maxContractsPerSession = 2,
            priceMin = 250,
            priceMax = 450,
            minScratchPrice = 2000,
            maxScratchPrice = 3000,
            rewardCashMin = 6000,
            rewardCashMax = 10000,
            rewardCryptoMin = 800,
            rewardCryptoMax = 1000,
            experiencePerJob = 40,
            bonusExperienceMultiplier = 1,
            bonusExperienceMinimumMembers = 4,
            tuningChance = 50,
            riskChances = {
                doorsLocked = 100,
                advancedLockChance = 0,
                advancedSystemChance = 100,
                npcChance = 50
            }
        },
        [3] = {
            class = "B",
            xpRequired = 700,
            generationPercentage = 50,
            timeBetweenGenerations = 10,
            isImportant = false,
            maxContractsOfType = 1,
            maxContractsPerSession = 0,
            priceMin = 40,
            priceMax = 60,
            minScratchPrice = 600,
            maxScratchPrice = 800,
            rewardCashMin = 2500,
            rewardCashMax = 3500,
            rewardCryptoMin = 200,
            rewardCryptoMax = 300,
            experiencePerJob = 30,
            bonusExperienceMultiplier = 1,
            bonusExperienceMinimumMembers = 3,
            tuningChance = 50,
            riskChances = {
                doorsLocked = 100,
                advancedLockChance = 0,
                advancedSystemChance = 0,
                npcChance = 0
            }
        },
        [4] = {
            class = "C",
            xpRequired = 150,
            generationPercentage = 55,
            timeBetweenGenerations = 5,
            isImportant = false,
            maxContractsOfType = 2,
            maxContractsPerSession = 0,
            priceMin = 3,
            priceMax = 6,
            minScratchPrice = 90,
            maxScratchPrice = 180,
            rewardCashMin = 1300,
            rewardCashMax = 2300,
            rewardCryptoMin = 10,
            rewardCryptoMax = 20,
            experiencePerJob = 20,
            bonusExperienceMultiplier = 1,
            bonusExperienceMinimumMembers = 2,
            tuningChance = 50,
            riskChances = {
                doorsLocked = 100,
                advancedLockChance = 0,
                advancedSystemChance = 0,
                npcChance = 0
            }
        },
        [5] = {
            xpRequired = 0,
            class = "D",
            generationPercentage = 60,
            timeBetweenGenerations = 0,
            isImportant = false,
            maxContractsOfType = 3,
            maxContractsPerSession = 0,
            priceMin = 0,
            priceMax = 0,
            minScratchPrice = 60,
            maxScratchPrice = 120,
            rewardCashMin = 700,
            rewardCashMax = 1500,
            rewardCryptoMin = 5,
            rewardCryptoMax = 10,
            experiencePerJob = 10,
            bonusExperienceMultiplier = 1,
            bonusExperienceMinimumMembers = 2,
            tuningChance = 50,
            riskChances = {
                doorsLocked = 50,
                advancedLockChance = 0,
                advancedSystemChance = 0,
                npcChance = 0
            }
        }
    },

    storeItems = {
        ['racingtablet'] = {
            cashRequired = 1500,
            cryptoRequired = 300,
            availablePerRestart = 5,
            isSoldOut = false,
            title = "Racing tablet",
            description = "Lets you compete and start different races.",
            iconFile = 'racingtablet.png',
            receiveItemIds = {
                [1] = 'racingtablet'
            }
        },
        --['harness'] = {
            --cashRequired = 750,
            --cryptoRequired = 150,
            --availablePerRestart = 5,
            --isSoldOut = false,
            --title = "Harness",
            --description = "Will protect you if something goes really wrong.",
            --iconFile = 'harness.png',
            --receiveItemIds = {
                --[1] = 'harness'
            --}
        --},
        --['nos'] = {
            --cashRequired = 1000,
           -- cryptoRequired = 200,
           -- availablePerRestart = 5,
           -- isSoldOut = false,
            --title = "Nitrous oxide",
            --description = "When you need that extra bit of boost.",
           -- iconFile = 'nitrous-oxide.png',
            --receiveItemIds = {
                --[1] = 'nitrous'
           -- }
        --},
        --['spart'] = {
           -- cashRequired = 640,
           -- cryptoRequired = 130,
          --  availablePerRestart = 5,
           -- isSoldOut = false,
          --  title = "Spare parts crate (S)",
          --  description = "Consists of different spare parts for S class vehicles.",
           -- iconFile = 'pallet-of-boxes.png',
           -- receiveItemIds = {
                --[1] = 'transmission_part_s',
                --[2] = 'electronics_part_s',
                --[3] = 'radiator_part_s',
                --[4] = 'clutch_part_s',
                --[5] = 'brakes_part_s',
                --[6] = 'axle_part_s',
                --[7] = 'fuel_injector_part_s',
                --[8] = 'tire_part_s',
            --}
        --},
        --['apart'] = {
            --cashRequired = 400,
            --cryptoRequired = 80,
           -- availablePerRestart = 5,
            --isSoldOut = false,
            --title = "Spare parts crate (A)",
            --description = "Consists of different spare parts for S class vehicles.",
            --iconFile = 'pallet-of-boxes.png',
            --receiveItemIds = {
               -- [1] = 'transmission_part_a',
                --[2] = 'electronics_part_a',
              --  [3] = 'radiator_part_a',
                --[4] = 'clutch_part_a',
                --[5] = 'brakes_part_a',
                --[6] = 'axle_part_a',
                --[7] = 'fuel_injector_part_a',
                --[8] = 'tire_part_a',
            --}
        --},
        ['lockpick'] = {
            cashRequired = 50,
            cryptoRequired = 10,
            availablePerRestart = 5,
            isSoldOut = false,
            title = "Lockpick",
            description = "A low-quality lockpick which will get the job done.",
            iconFile = 'lockpick.png',
            receiveItemIds = {
                [1] = 'lockpick'
            }
        },
        --['fakeplate'] = {
           -- cashRequired = 1500,
           -- cryptoRequired = 300,
           -- availablePerRestart = 5,
           -- isSoldOut = false,
           -- title = "Fake license plate",
           -- description = "You can mount it on vehicles to remain anonymous.",
           -- iconFile = 'plate.png',
           -- receiveItemIds = {
               -- [1] = 'fakeplate'
           -- }
        --},
        --['repairkit'] = {
        --    cashRequired = 100,
        --    cryptoRequired = 20,
        --    availablePerRestart = 5,
        --    isSoldOut = false,
        --    title = "Repair kit",
        --    description = "Will get your car moving when you break down.",
        --    iconFile = 'repair-kit.png',
        --    receiveItemIds = {
        --        [1] = 'repairkit'
        --    }
        --}
    }
}

-- New Boosting Vehicles - Organized by Class
-- These vehicles are specifically configured for the boosting system
supportedVehicles = {
    -- ========================================
    -- CLASS D - ENTRY LEVEL BOOSTING
    -- ========================================
    { name = "Asbo", model = "asbo", class = "D" },
    { name = "Blista", model = "blista", class = "D" },
    { name = "Brioso R/A", model = "brioso", class = "D" },
    { name = "Club", model = "club", class = "D" },
    { name = "Dilettante", model = "dilettante", class = "D" },
    { name = "Issi", model = "issi2", class = "D" },
    { name = "Blista Kanjo", model = "kanjo", class = "D" },
    { name = "Panto", model = "panto", class = "D" },
    { name = "Prairie", model = "prairie", class = "D" },
    { name = "Rhapsody", model = "rhapsody", class = "D" },

    -- ========================================
    -- CLASS C - STANDARD BOOSTING
    -- ========================================
    { name = "Asea", model = "asea", class = "C" },
    { name = "Asterope", model = "asterope", class = "C" },
    { name = "Cavalcade", model = "cavalcade", class = "C" },
    { name = "Cognoscenti 55", model = "cog55", class = "C" },
    { name = "Emperor", model = "emperor", class = "C" },
    { name = "Fugitive", model = "fugitive", class = "C" },
    { name = "Glendale", model = "glendale", class = "C" },
    { name = "Granger", model = "granger", class = "C" },
    { name = "Intruder", model = "intruder", class = "C" },
    { name = "Stanier", model = "stanier", class = "C" },

    -- ========================================
    -- CLASS B - ADVANCED BOOSTING
    -- ========================================
    { name = "Alpha", model = "alpha", class = "B" },
    { name = "Banshee", model = "banshee", class = "B" },
    { name = "Bestia GTS", model = "bestiagts", class = "B" },
    { name = "Buffalo", model = "buffalo", class = "B" },
    { name = "Calico GTF", model = "calico", class = "B" },
    { name = "Carbonizzare", model = "carbonizzare", class = "B" },
    { name = "Comet", model = "comet2", class = "B" },
    { name = "Coquette", model = "coquette", class = "B" },
    { name = "Corsita", model = "corsita", class = "B" },
    { name = "La Coureuse", model = "coureur", class = "B" },

    -- ========================================
    -- CLASS A - EXPERT BOOSTING
    -- ========================================
    { name = "Adder", model = "adder", class = "A" },
    { name = "Autarch", model = "autarch", class = "A" },
    { name = "Banshee 900R", model = "banshee2", class = "A" },
    { name = "Bullet", model = "bullet", class = "A" },
    { name = "Cheetah", model = "cheetah", class = "A" },
    { name = "Cyclone", model = "cyclone", class = "A" },
    { name = "Deveste Eight", model = "deveste", class = "A" },
    { name = "Entity XXR", model = "entity2", class = "A" },
    { name = "Entity XF", model = "entityxf", class = "A" },
    { name = "FMJ", model = "fmj", class = "A" },

    -- ========================================
    -- CLASS S - MASTER BOOSTING
    -- ========================================
    { name = "Emerus", model = "emerus", class = "S" },
    { name = "Furia", model = "furia", class = "S" },
    { name = "GP1", model = "gp1", class = "S" },
    { name = "Ignus", model = "ignus", class = "S" },
    { name = "Infernus", model = "infernus", class = "S" },
    { name = "Itali GTB", model = "italigtb", class = "S" },
    { name = "Krieger", model = "krieger", class = "S" },
    { name = "RE-7B", model = "le7b", class = "S" },
    { name = "Nero", model = "nero", class = "S" },
    { name = "Osiris", model = "osiris", class = "S" },
    { name = "T20", model = "t20", class = "S" }
}
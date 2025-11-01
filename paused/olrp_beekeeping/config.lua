Config = {}

Config.defaultlang = "en_lang"
Config.Debug = true -- Enabled for wild beehive debugging

-- Job restrictions (set to false to allow everyone)
Config.JobLock = false
Config.BeekeeperJobs = {
    {Job = "unemployed"},
    {Job = "farmer"}
}

-- Beehive limits
Config.MaxBeehivesPerPlayer = 5
Config.MaxBeesPerHive = 200
Config.MaxQueensPerHive = 1
Config.MinDistanceBetweenOwnHives = 0.0 -- Minimum distance between your own hives (0 = can place next to each other)
Config.MinDistanceFromOtherPlayersHives = 25.0 -- Minimum distance from other players' hives in units
Config.MaxTotalBeehivesOnServer = 200 -- Maximum total beehives allowed on server (60 players * 5 = 300, set to 200 for performance)
Config.RequireClusteredHives = true -- Force players to place all hives within a specific area
Config.MaxDistanceFromFirstHive = 15.0 -- Maximum distance from first hive (15 units = ~15 meters) - creates a small beekeeping farm area

-- Update timer (in minutes) - Increased to reduce server load
Config.UpdateTimer = 2

-- Wild beehive settings
Config.WildBeehiveSpawn = true
Config.WildBeehiveModel = "prop_bush_neat_05" -- Wild hives appear as small neat bushes
Config.WildBeehiveMaxActive = 50 -- Maximum active wild hives at once
Config.WildBeehiveRotationTime = 30 -- Minutes before hive respawns
Config.WildBeehiveMinDistance = 50.0 -- Minimum distance between hives

-- Bee behavior settings
Config.BeesCanBeHappy = true
Config.BeesCanDie = true
Config.BeesCanBeSick = true
Config.GetBeesOnHappy = true
Config.ClearProductOnNoBees = true
Config.DestroyHives = true
Config.BeesDieOn100 = true

-- Hive deterioration settings
Config.IncreaseDamageBy = 1
Config.DeleteHiveOnDamage = 100
Config.AutoCleanupInactiveHives = true -- Automatically remove hives with no bees/queens after time
Config.InactiveHiveCleanupTime = 168 -- Hours before inactive hives are auto-deleted (7 days)

-- Bee happiness requirements
Config.HappyAt = {
    Food = 50,
    Water = 50,
    Clean = 50
}

-- Bee death conditions
Config.DieAt = {
    Food = 10,
    Water = 10,
    Clean = 10
}

-- Resource depletion rates
Config.ReduceFoodPerTick = 0.4
Config.ReduceWaterPerTick = 0.5
Config.ReduceCleanPerTick = 0.3
Config.ReduceHealthIfCleanUnder = 30
Config.ReduceHealthOnDirty = 1.0

-- Resource gain amounts
Config.FoodGain = 50
Config.WaterGain = 50
Config.CleanGain = 50
Config.HealGain = 50

-- Bee reproduction settings
Config.BeesMin = 1
Config.BeesMax = 3

-- Bee death settings
Config.LooseBeesMin = 3
Config.LooseBeesMax = 5

-- Sickness settings
Config.SicknessChance = 1
Config.IncreaseIntensityPerUpdate = 1.5

-- Product settings
Config.ProduktPerHoney = 60

-- Timing settings (in seconds)
Config.QueenTime = 10
Config.BeeTime = 5
Config.TakeHoneyTime = 3
Config.FeedTime = 5
Config.WaterTime = 5
Config.CleanTime = 5
Config.HealTime = 5
Config.GetBeeTime = 5
Config.GetQueenTime = 5

-- Blip settings
Config.UseBlips = true
Config.BlipSprite = 84 -- Bee icon (honey/bee blip)
Config.BlipScale = 0.8
Config.BlipColor = 5 -- Yellow color for bees
Config.BlipName = "Beehive"

-- Sound settings (Custom bee buzzing sound)
Config.UseHiveSounds = true
Config.HiveSoundRadius = 15.0 -- Distance in meters where sound can be heard
Config.HiveSoundCooldown = 40000 -- Play sound every X milliseconds (40000 = 40 seconds - matches sound length)
Config.HiveSoundVolume = 1.0 -- Base volume (0.0 to 1.0) - adjusted by distance

-- Wild beehive sound settings
Config.UseWildHiveSounds = true
Config.WildHiveSoundRadius = 20.0 -- Distance in meters where wild hive sound can be heard
Config.WildHiveSoundCooldown = 22000 -- Play sound every X milliseconds (22000 = 22 seconds - matches sound length)
Config.WildHiveSoundVolume = 0.8 -- Base volume (0.0 to 1.0) - slightly quieter than placed hives

-- Prop settings (using beehive pack props)
Config.UseRandomHive = true
Config.Props = {
    {BeehiveBox = "bzzz_props_beehive_box_001"},
    {BeehiveBox = "bzzz_props_beehive_box_002"},
    {BeehiveBox = "bzzz_props_beehive_barrel_001"},
    {BeehiveBox = "bzzz_props_beehive_barrel_002"}
}

-- Item settings
Config.BeehiveItem = "beehive_box"
Config.SmokerItem = "torch_smoker"
Config.BugNetItem = "bug_net"
Config.EmptyBeeJar = "empty_bee_jar"
Config.JarItem = "empty_bee_jar"
Config.FoodItem = "sugar"
Config.WaterItem = "water"
Config.CleanItem = "wheat"
Config.HealItem = "potato"

-- Item labels
Config.FoodItemLabel = "Sugar"
Config.WaterItemLabel = "Water"
Config.CleanItemLabel = "Wheat"
Config.HealItemLabel = "Potato"

-- Return empty items
Config.GiveBackEmpty = false
Config.GiveBackEmptyItem = "empty_bee_jar"
Config.GiveBackEmptyJarQueen = false
Config.GiveBackEmptyJarQueenItem = "empty_bee_jar"
Config.GiveBackEmptyJarBees = false
Config.GiveBackEmptyJarBeesItem = "empty_bee_jar"
Config.GetBackBoxItem = false

-- Bee types configuration
Config.BeeTypes = {
    {
        QueenItem = "basic_queen",
        QueenLabel = "Queen Bee",
        BeeItem = "basic_bees",
        BeeLabel = "Worker Bees",
        Product = "honey",
        ProductLabel = "Honey",
        ProductHappy = 0.015,
        ProductNormal = 0.010,
        AddBees = 15
    },
    {
        QueenItem = "basic_hornet_queen",
        QueenLabel = "Hornet Queen",
        BeeItem = "basic_hornets",
        BeeLabel = "Hornet Workers",
        Product = "honey2",
        ProductLabel = "Manuka Honey",
        ProductHappy = 0.015,
        ProductNormal = 0.010,
        AddBees = 10
    }
}

-- Sickness types
Config.Sickness = {
    {
        Type = "Bee Pox",
        Medicin = "bandage",
        MedicinLabel = "Bandage"
    },
    {
        Type = "Bubonic Plague",
        Medicin = "bandage",
        MedicinLabel = "Bandage"
    }
}

-- Wild beehive locations (100 locations outside of cities)
Config.WildBeehives = {
    {x=-1846.54, y=2048.95, z=135.84, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1951.2, y=2127.63, z=143.59, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1737.69, y=1961.96, z=120.55, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1641.29, y=1846.34, z=139.77, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1543.07, y=1760.78, z=98.6, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1204.85, y=4445.48, z=29.22, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1083.22, y=-865.64, z=47.96, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-902.0, y=4739.41, z=284.73, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-903.2, y=4829.22, z=303.58, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-803.87, y=4904.58, z=255.51, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1587.43, y=4558.21, z=45.61, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1937.1, y=4581.36, z=36.7, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1885.06, y=4575.33, z=34.61, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2058.24, y=4667.08, z=39.09, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2326.11, y=4701.24, z=34.23, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1747.84, y=3454.66, z=36.64, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1892.31, y=3611.19, z=32.16, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2007.7, y=3700.47, z=31.27, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2115.11, y=3761.07, z=31.12, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2245.31, y=3843.82, z=34.25, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1006.79, y=3003.2, z=38.94, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1160.73, y=3526.3, z=32.76, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1194.42, y=3202.16, z=38.51, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1302.1, y=3297.97, z=35.56, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1400.13, y=3400.14, z=44.98, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-2108.22, y=973.31, z=182.34, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1868.94, y=744.76, z=131.42, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1639.73, y=1139.01, z=149.89, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1632.52, y=1313.82, z=132.91, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1571.02, y=1358.17, z=127.24, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-3179.97, y=955.84, z=13.86, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-3099.36, y=1065.25, z=18.33, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-3127.92, y=1168.15, z=18.5, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-3122.82, y=1264.2, z=18.78, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-3103.8, y=1368.84, z=18.61, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-3065.78, y=1725.71, z=34.25, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-3055.54, y=1837.14, z=30.22, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-3019.34, y=1969.04, z=28.68, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-2996.03, y=2074.12, z=37.54, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-2911.35, y=2177.71, z=36.41, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2522.11, y=2016.86, z=16.87, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2522.11, y=2016.86, z=16.87, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2529.65, y=2050.55, z=17.09, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2590.18, y=2499.39, z=25.58, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2523.47, y=1868.36, z=20.06, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2539.48, y=2674.81, z=38.54, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-709.7, y=5501.19, z=37.91, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-631.45, y=5621.37, z=37.1, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-713.93, y=5842.75, z=16.54, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-672.39, y=5872.0, z=14.82, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-684.66, y=5967.47, z=12.14, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1504.31, y=-804.2, z=15.08, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1534.46, y=-778.94, z=16.83, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1717.83, y=-628.62, z=10.12, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1789.65, y=-549.69, z=31.69, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1590.37, y=-607.52, z=29.54, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=685.64, y=1712.65, z=184.99, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=677.0, y=1720.2, z=185.42, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=687.45, y=1741.65, z=184.3, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=824.55, y=1718.58, z=170.26, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=954.32, y=2156.74, z=47.23, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-600.3, y=421.89, z=99.49, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-331.11, y=457.3, z=109.08, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-509.6, y=650.79, z=137.03, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-253.54, y=714.44, z=205.29, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-80.82, y=864.36, z=234.15, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2440.28, y=1024.96, z=81.53, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2470.41, y=978.79, z=84.01, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2555.0, y=852.39, z=85.42, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2553.35, y=1618.03, z=27.44, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2559.02, y=1797.28, z=22.02, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-2680.7, y=2329.04, z=15.08, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-2497.6, y=3504.37, z=12.43, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-2303.28, y=4226.98, z=39.82, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-2128.43, y=4430.15, z=62.53, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1567.39, y=4958.82, z=59.84, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1719.77, y=4959.11, z=43.03, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1817.7, y=5076.55, z=55.76, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1963.15, y=5120.25, z=41.14, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2049.51, y=5018.98, z=39.09, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2120.3, y=4942.24, z=39.0, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-801.55, y=5616.38, z=25.1, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-1307.81, y=5262.34, z=57.5, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-2322.92, y=2236.09, z=31.29, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-581.95, y=5718.84, z=34.51, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-367.45, y=5982.96, z=28.59, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=200.32, y=6526.69, z=28.68, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=363.71, y=6555.41, z=25.05, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=458.38, y=6583.52, z=24.16, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=819.58, y=6512.82, z=20.12, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=975.18, y=6508.73, z=17.98, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1319.0, y=6507.15, z=17.05, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1652.16, y=6421.88, z=26.03, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1799.07, y=6349.36, z=34.73, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2139.4, y=6060.94, z=48.13, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2381.16, y=5844.96, z=43.72, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2430.73, y=5700.05, z=42.27, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2512.96, y=5502.93, z=41.65, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2623.74, y=5136.89, z=41.75, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2660.22, y=4963.15, z=42.77, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-581.95, y=5718.84, z=35.51, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=-367.45, y=5982.96, z=29.59, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=200.32, y=6526.69, z=29.68, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=363.71, y=6555.41, z=26.05, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=458.38, y=6583.52, z=25.16, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=819.58, y=6512.82, z=21.12, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=975.18, y=6508.73, z=18.98, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1319.0, y=6507.15, z=18.05, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1652.16, y=6421.88, z=27.03, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=1799.07, y=6349.36, z=35.73, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2139.4, y=6060.94, z=49.13, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2381.16, y=5844.96, z=44.72, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2430.73, y=5700.05, z=43.27, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2512.96, y=5502.93, z=42.65, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2623.74, y=5136.89, z=42.75, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3},
    {x=2660.22, y=4963.15, z=42.77, heading=0.0, GetBeeItem="basic_bees", GetBeeItemMin=1, GetBeeItemMax=3, GetQueenItem="basic_queen", GetQueenItemMin=1, GetQueenItemMax=1, ProductWildHive="honey", ProductGet=2, TakeProductTime=3}
}

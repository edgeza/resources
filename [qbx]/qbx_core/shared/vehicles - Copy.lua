QBShared = QBShared or {}
QBShared.Vehicles = QBShared.Vehicles or {}

local Vehicles = {
    -- ========================================
    -- FOLDER: [cars]/[dealership]/imports_pack_1
    -- ========================================
    { model = 'trailw', name = 'Trail W', brand = 'ANNIS', price = 325500, category = 'offroad', type = 'automobile', shop = 'offroad' },
    { model = 'tfremus', name = 'TF Remus', brand = 'ANNIS', price = 345000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'savestrare', name = 'Savestra RE', brand = 'ANNIS', price = 775000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'roxanne', name = 'Roxanne', brand = 'ANNIS', price = 340000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'remustwo', name = 'Remus Two', brand = 'ANNIS', price = 220000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'majimagt', name = 'Annis Majima GT', brand = 'ANNIS', price = 1700000, category = 'super', type = 'automobile', shop = 'lux' },
    { model = 'elegyw', name = 'Annis Elegy Wagon', brand = 'ANNIS', price = 345000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'hizoku', name = 'Annis Hizoku', brand = 'ANNIS', price = 325000, category = 'classic_pickup', type = 'automobile', shop = 'lux' },
    { model = 'zr390', name = 'Annis ZR390', brand = 'ANNIS', price = 525000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'zr250', name = 'Annis ZR-250 Savestra', brand = 'ANNIS', price = 800000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'elegyx', name = 'Annis Elegy RH8-X', brand = 'ANNIS', price = 500000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'elegyrh6', name = 'Annis Elegy RH6', brand = 'ANNIS', price = 575000, category = 'sports_classics', type = 'automobile', shop = 'lux' },
    { model = 'streiter2', name = 'Streiter 2', brand = 'BENEFACTOR', price = 1300000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'surano3', name = 'Surano 3', brand = 'BENEFACTOR', price = 1800000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'scheisser', name = 'Scheisser', brand = 'BENEFACTOR', price = 920000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'scharmann', name = 'Scharmann', brand = 'BENEFACTOR', price = 835000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'feltold', name = 'Old Benefactor', brand = 'BENEFACTOR', price = 95000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'jogger', name = 'Jogger', brand = 'BENEFACTOR', price = 750000, category = 'vans', type = 'automobile', shop = 'lux' },
    { model = 'imperial', name = 'Imperial', brand = 'BENEFACTOR', price = 695000, category = 'vans', type = 'automobile', shop = 'lux' },
    -- { model = 'gbschlagenr', name = 'GB Schlagen R', brand = 'BENEFACTOR', price = 1400000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'feltzer9', name = 'Feltzer 9', brand = 'BENEFACTOR', price = 1600000, category = 'classic', type = 'automobile', shop = 'lux' },
    -- { model = 'gbharmann', name = 'Benefactor GB Harmann', brand = 'BENEFACTOR', price = 1400000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'kriegerc', name = 'Benefactor Krieger BPX-32B', brand = 'BENEFACTOR', price = 485000, category = 'sports_classics', type = 'automobile', shop = 'lux' },
    { model = 'dubsta22', name = '2022 Benefactor Dubsta', brand = 'BENEFACTOR', price = 1750000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'weevilup', name = 'Weevil Up', brand = 'BF', price = 855000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'clubgtr', name = 'Club GTR', brand = 'BF', price = 650000, category = 'classic', type = 'automobile', shop = 'lux' },
    

    -- ========================================
    -- FOLDER: [cars]/[dealership]/imports_pack_2
    -- ========================================
    { model = 'sancyb4', name = 'Bordeaux Sancy B4', brand = 'BORDEAUX', price = 1400000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'arias', name = 'Arias', brand = 'BORDEAUX', price = 140000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'buffaloh', name = 'Bravado Buffalo Hellhound', brand = 'BRAVADO', price = 1600000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'gresleyh', name = 'Bravado Gresley Hellhound', brand = 'BRAVADO', price = 1600000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'vulture', name = 'Bravado Vulture', brand = 'BRAVADO', price = 1400000, category = 'classic', type = 'automobile', shop = 'lux' },
    -- { model = 'gbbisonhf', name = 'Bravado GB Bison HF', brand = 'BRAVADO', price = 1200000, category = 'offroad', type = 'automobile', shop = 'lux' },
    { model = 'bansheepo', name = 'Banshee Police', brand = 'BRAVADO', price = 1100000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'buffalowb', name = 'Buffalo Widebody', brand = 'BRAVADO', price = 1400000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'recursion', name = 'Recursion', brand = 'BRAVADO', price = 895000, category = 'sports', type = 'automobile', shop = 'lux' },
    -- { model = 'gbbanshees', name = 'Bravado GB Banshees', brand = 'BRAVADO', price = 1800000, category = 'muscle', type = 'automobile', shop = 'lux' },

    -- ========================================
    -- FOLDER: [cars]/[dealership]/imports_pack_3
    -- ========================================
    { model = 'vesper', name = 'Vesper', brand = 'DEWBAUCHEE', price = 950000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'strage', name = 'Strage', brand = 'DEWBAUCHEE', price = 760000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'supergts', name = 'Super GTS', brand = 'DEWBAUCHEE', price = 2200000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'yosemiteswb', name = 'Yosemite SWB', brand = 'DECLASSE', price = 775000, category = 'pickup', type = 'automobile', shop = 'lux' },
    { model = 'tulip2s', name = 'Tulip 2S', brand = 'DECLASSE', price = 925000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'sabrecab', name = 'Sabre Cab', brand = 'DECLASSE', price = 1250000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'lentus', name = 'Lentus', brand = 'DECLASSE', price = 1000000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'tampar', name = 'Declasse Restomod Tampa', brand = 'DECLASSE', price = 2500000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'mk21500dually', name = 'Declasse MK2 1500 Dually', brand = 'DECLASSE', price = 595000, category = 'classic_pickup', type = 'automobile', shop = 'lux' },
    -- { model = 'gbimpaler', name = 'GB Impaler', brand = 'DECLASSE', price = 25000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'accolade', name = 'Accolade', brand = 'CLASSIQUE', price = 85000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'navarra', name = 'Navarra', brand = 'BRUTE', price = 495000, category = 'vans', type = 'automobile', shop = 'lux' },

    -- ========================================
    -- FOLDER: [cars]/[dealership]/imports_pack_4
    -- ========================================
    { model = 'tachyon', name = 'Hijak Tachyon', brand = 'HIJAK', price = 3000000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'turismoo', name = 'Grotti Turismo O', brand = 'GROTTI', price = 1250000, category = 'super', type = 'automobile', shop = 'lux' },
    { model = 'turismocs', name = 'Grotti Turismo CS', brand = 'GROTTI', price = 1800000, category = 'super', type = 'automobile', shop = 'lux' },
    -- { model = 'gbbriosof', name = 'Grotti GB Brioso F', brand = 'GROTTI', price = 550000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'cheetahfel', name = 'Grotti Cheetah Fel', brand = 'GROTTI', price = 3500000, category = 'classic', type = 'automobile', shop = 'lux' },
    -- { model = 'gbturismogts', name = 'Grotti GB Turismo GTS', brand = 'GROTTI', price = 1200000, category = 'sports_classics', type = 'automobile', shop = 'lux' },
    { model = 'jesterx', name = 'Dinka Jester X-Flow', brand = 'DINKA', price = 2450000, category = 'super', type = 'automobile', shop = 'lux' },
    -- { model = 'gbnexusrr', name = 'Dinka GB Nexus RR', brand = 'DINKA', price = 2750000, category = 'super', type = 'automobile', shop = 'lux' },
    { model = 'polverus', name = 'Dinka Polverus', brand = 'DINKA', price = 250000, category = 'offroad', type = 'automobile', shop = 'offroad' },
    { model = 'banditojester', name = 'Dinka Bandito Jester', brand = 'DINKA', price = 1200000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'citi', name = 'Dinka Citi', brand = 'DINKA', price = 15000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'blis2gpr', name = 'Dinka Blista 2 GPR', brand = 'DINKA', price = 650000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'serena', name = 'Dinka Serena', brand = 'DINKA', price = 2500000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'nexus', name = 'Dinka Nexus', brand = 'DINKA', price = 1350000, category = 'sports_classics', type = 'automobile', shop = 'lux' },
    { model = 'millennial', name = 'Dinka Millennial Wagon', brand = 'DINKA', price = 770000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'blistacr', name = 'Dinka Blista CR', brand = 'DINKA', price = 20000, category = 'compacts', type = 'automobile', shop = 'lux' },

    -- ========================================
    -- FOLDER: [cars]/[dealership]/imports_pack_5
    -- ========================================
    { model = 'hrd6', name = 'Invetero Coquette HRD6', brand = 'INVETERO', price = 1480000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'asteropers', name = 'Karin Asterope RS', brand = 'KARIN', price = 1320000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'boorc', name = 'Karin Boor Widebody', brand = 'KARIN', price = 950000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'intruderc', name = 'Karin Intruder C', brand = 'KARIN', price = 825000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'hrspec', name = 'Karin Sultan HR Spec', brand = 'KARIN', price = 740000, category = 'sedans', type = 'automobile', shop = 'lux' },
    -- { model = 'gbkomodagt', name = 'Lampadati GB Komoda GT', brand = 'LAMPADATI', price = 10000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'vayra', name = 'Lampadati Vayra', brand = 'LAMPADATI', price = 2200000, category = 'sports', type = 'automobile', shop = 'lux' },

    -- ========================================
    -- FOLDER: [cars]/[dealership]/imports_pack_6
    -- ========================================
    { model = 'castella', name = 'Shitzu Castella', brand = 'SHITZU', price = 30000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'thraxd', name = 'Truffade Thrax Drop', brand = 'TRUFFADE', price = 4500000, category = 'super', type = 'automobile', shop = 'lux' },
    { model = 'adders', name = 'Truffade Adder Sport', brand = 'TRUFFADE', price = 3800000, category = 'super', type = 'automobile', shop = 'lux' },
    { model = 'oraclelwb', name = 'Ubermacht Oracle LWB', brand = 'UBERMACHT', price = 760000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'rhinetaxi', name = 'Rhine Taxi', brand = 'UBERMACHT', price = 940000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'sentinelsg4', name = 'Sentinel SG4', brand = 'UBERMACHT', price = 730000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'seraph3', name = 'Seraph 3', brand = 'UBERMACHT', price = 990000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'sentinelmk4', name = 'Ubermacht Sentinel Mk.4 GTR', brand = 'UBERMACHT', price = 1000000, category = 'sedans', type = 'automobile', shop = 'lux' },

    -- ========================================
    -- FOLDER: [cars]/[dealership]/imports_pack_7
    -- ========================================
    { model = 'hachurac', name = 'Vulcar Hachura R', brand = 'VULCAR', price = 2200000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'sabot', name = 'Vapid Sabot', brand = 'VAPID', price = 1500000, category = 'super', type = 'automobile', shop = 'lux' },
    { model = 'domgtcoupe', name = 'Vapid Dominator GT Coupe', brand = 'VAPID', price = 1500000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'nsandstorm', name = 'Vapid Sandstorm', brand = 'VAPID', price = 2000000, category = 'offroad', type = 'automobile', shop = 'offroad' },
    { model = 'domc', name = 'Vapid Dominator C', brand = 'VAPID', price = 880000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'clique3', name = 'Vapid Clique 3', brand = 'VAPID', price = 2600000, category = 'classic', type = 'automobile', shop = 'lux' },

    -- ========================================
    -- FOLDER: [cars]/[dealership]/imports_pack_OTHER
    -- ========================================
    { model = 'chavosv6w', name = 'Dinka Chavos V6W', brand = 'DINKA', price = 980000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'coquettec5c', name = 'Invetero Coquette C5C', brand = 'INVETERO', price = 1100000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'cwagon', name = 'C Wagon', brand = 'DECLASSE', price = 660000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'dbvolante', name = 'DB Volante', brand = 'DEWBAUCHEE', price = 1800000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'elegant', name = 'Elegant', brand = 'ENUS', price = 2500000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'elegyheritage', name = 'Annis Elegy Heritage', brand = 'ANNIS', price = 1200000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'elegyz2', name = 'Annis Elegy Z2', brand = 'ANNIS', price = 2000000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'eva', name = 'Eva', brand = 'OCELOT', price = 600000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'executioner', name = 'Executioner', brand = 'WESTERN', price = 1000000, category = 'offroad', type = 'automobile', shop = 'offroad' },
    { model = 'f620d', name = 'Ocelot F620D', brand = 'OCELOT', price = 2000000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'flivver', name = 'Flivver', brand = 'VAPID', price = 4000000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'gauntletc', name = 'Bravado Gauntlet C', brand = 'BRAVADO', price = 870000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'gauntletstx', name = 'Bravado Gauntlet STX', brand = 'BRAVADO', price = 920000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'glendalelimo', name = 'Declasse Glendale Limo', brand = 'DECLASSE', price = 3000000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'gstkrochavosv61', name = 'GST Kro Chavos V61', brand = 'DINKA', price = 1400000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'gstyosemite1', name = 'GST Yosemite 1', brand = 'DECLASSE', price = 2000000, category = 'offroad', type = 'automobile', shop = 'offroad' },
    { model = 'hachura', name = 'Vulcar Hachura', brand = 'VULCAR', price = 970000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'ingotc', name = 'Vulcar Ingot C', brand = 'VULCAR', price = 900000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'issi8s', name = 'Weeny Issi 8S', brand = 'WEENY', price = 475000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'jester5', name = 'Dinka Jester 5', brand = 'DINKA', price = 900000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'kampfer', name = 'Kampfer', brand = 'BENEFACTOR', price = 280000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'kamswb', name = 'Karin Kams WB', brand = 'KARIN', price = 972000, category = 'offroad', type = 'automobile', shop = 'offroad' },
    { model = 'kawaii', name = 'Kawaii', brand = 'DINKA', price = 12000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'l35l', name = 'L35L', brand = 'PEGASSI', price = 525000, category = 'pickup', type = 'automobile', shop = 'offroad' },
    { model = 'm420', name = 'M420', brand = 'PFISTER', price = 2000000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'mesaxl', name = 'Canis Mesa XL', brand = 'CANIS', price = 1300000, category = 'offroad', type = 'automobile', shop = 'offroad' },
    { model = 'meteor', name = 'Meteor', brand = 'PEGASSI', price = 1700000, category = 'sports', type = 'automobile', shop = 'lux' },
    -- { model = 'oraclegts', name = 'Ubermacht Oracle GTS', brand = 'UBERMACHT', price = 1200000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'r9gt', name = 'R9 GT', brand = 'PFISTER', price = 2300000, category = 'super', type = 'automobile', shop = 'lux' },
    { model = 'tahoma2', name = 'Declasse Tahoma 2', brand = 'DECLASSE', price = 850000, category = 'classic', type = 'automobile', shop = 'lux' },
    { model = 'zrgpr', name = 'Annis ZR GPR', brand = 'ANNIS', price = 2000000, category = 'sports', type = 'automobile', shop = 'lux' },
    -- { model = 'sandkingd', name = 'Sandking D', brand = 'VAPID', price = 3000000, category = 'sports', type = 'automobile', shop = 'lux' },

    -- ================================================================================
    -- STOCK CARS FROM GTA V ---
    -- ================================================================================

    -- ================================================================================
    -- COMPACTS
    -- ================================================================================
    { model = 'brioso2', name = 'Brioso 300', brand = 'Grotti', price = 75000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'brioso3', name = 'Brioso 300 Widebody', brand = 'Grotti', price = 80000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'dilettante2', name = 'Dilettante 2', brand = 'Karin', price = 85000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'issi3', name = 'Issi Classic', brand = 'Weeny', price = 75000, category = 'compacts', type = 'automobile', shop = 'lux' },
    { model = 'weevil', name = 'Weevil', brand = 'BF', price = 75000, category = 'compacts', type = 'automobile', shop = 'lux' },

    -- ================================================================================
    -- SUPER CARS (EXCLUSIVE TO BOOSTING SHOP)
    -- ================================================================================
    -- Note: All supercars are now exclusive to the boosting shop
    -- They cannot be purchased from the luxury dealership

    -- ================================================================================
    -- SEDANS
    -- ================================================================================

    { model = 'asterope2', name = 'Asterope GZ', brand = 'Karin', price = 95000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'cinquemila', name = 'Cinquemila', brand = 'Lampadati', price = 100000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'cognoscenti', name = 'Cognoscenti', brand = 'Enus', price = 110000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'impaler5', name = 'Impaler SZ', brand = 'Declasse', price = 95000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'ingot', name = 'Ingot', brand = 'Vulcar', price = 85000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'premier', name = 'Premier', brand = 'Declasse', price = 90000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'primo', name = 'Primo', brand = 'Albany', price = 85000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'primo2', name = 'Primo Custom', brand = 'Albany', price = 90000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'regina', name = 'Regina', brand = 'Dundreary', price = 95000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'rhinehart', name = 'Rhinehart', brand = 'Ubermacht', price = 940000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'romero', name = 'Romero Hearse', brand = 'Chariot', price = 95000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'schafter2', name = 'Schafter', brand = 'Benefactor', price = 95000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'stafford', name = 'Stafford', brand = 'Enus', price = 110000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'stratum', name = 'Stratum', brand = 'Zirconium', price = 85000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'stretch', name = 'Stretch', brand = 'Dundreary', price = 120000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'superd', name = 'Super Diamond', brand = 'Enus', price = 110000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'surge', name = 'Surge', brand = 'Cheval', price = 85000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'tailgater', name = 'Tailgater', brand = 'Obey', price = 95000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'tailgater2', name = 'Tailgater S', brand = 'Obey', price = 100000, category = 'sedans', type = 'automobile', shop = 'lux' },
    { model = 'warrener', name = 'Warrener', brand = 'Vulcar', price = 95000, category = 'bakkie', type = 'automobile', shop = 'offroad' },
    { model = 'warrener2', name = 'Warrener HKR', brand = 'Vulcar', price = 100000, category = 'bakkie', type = 'automobile', shop = 'offroad' },
    { model = 'washington', name = 'Washington', brand = 'Albany', price = 90000, category = 'sedans', type = 'automobile', shop = 'lux' },

    -- ================================================================================
    -- SUVS
    -- ================================================================================

    { model = 'astron', name = 'Astron', brand = 'Pfister', price = 180000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'baller', name = 'Baller', brand = 'Gallivanter', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'baller2', name = 'Baller LE', brand = 'Gallivanter', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'baller3', name = 'Baller LE LWB', brand = 'Gallivanter', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'baller4', name = 'Baller LE LWB Extended', brand = 'Gallivanter', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'baller7', name = 'Baller ST', brand = 'Gallivanter', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'bjxl', name = 'BeeJay XL', brand = 'Karin', price = 100000, category = 'bakkie', type = 'automobile', shop = 'offroad' },
    { model = 'cavalcade2', name = 'Cavalcade FXT', brand = 'Albany', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'cavalcade3', name = 'Cavalcade XL', brand = 'Albany', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'contender', name = 'Contender', brand = 'Vapid', price = 100000, category = 'bakkie', type = 'automobile', shop = 'offroad' },
    { model = 'dorado', name = 'Dorado', brand = 'Declasse', price = 100000, category = 'bakkie', type = 'automobile', shop = 'offroad' },
    { model = 'dubsta', name = 'Dubsta', brand = 'Benefactor', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'dubsta2', name = 'Dubsta 2', brand = 'Benefactor', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'fq2', name = 'FQ 2', brand = 'Fathom', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'gresley', name = 'Gresley', brand = 'Bravado', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'habanero', name = 'Habanero', brand = 'Emperor', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'huntley', name = 'Huntley S', brand = 'Enus', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'issi8', name = 'Issi Rally', brand = 'Weeny', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'iwagen', name = 'I-Wagen', brand = 'Obey', price = 90000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'landstalker', name = 'Landstalker', brand = 'Dundreary', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'landstalker2', name = 'Landstalker XL', brand = 'Dundreary', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'mesa', name = 'Mesa', brand = 'Canis', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },

    { model = 'novak', name = 'Novak', brand = 'Lampadati', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'patriot', name = 'Patriot', brand = 'Mammoth', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'radi', name = 'Radius', brand = 'Vapid', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'rebla', name = 'Rebla GTS', brand = 'Übermacht', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'rocoto', name = 'Rocoto', brand = 'Obey', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'seminole', name = 'Seminole', brand = 'Canis', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'seminole2', name = 'Seminole Frontier', brand = 'Canis', price = 100000, category = 'suvs', type = 'automobile', shop = 'offroad' },
    { model = 'serrano', name = 'Serrano', brand = 'Benefactor', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'squaddie', name = 'Squaddie', brand = 'Mammoth', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'toros', name = 'Toros', brand = 'Pegassi', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'vivanite', name = 'Vivanite', brand = 'Declasse', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },
    { model = 'xls', name = 'XLS', brand = 'Benefactor', price = 100000, category = 'suvs', type = 'automobile', shop = 'lux' },

    -- ================================================================================
    -- COUPES
    -- ================================================================================
    { model = 'cogcabrio', name = 'Cognoscenti Cabrio', brand = 'Enus', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'driftfr36', name = 'FR36 Drift', brand = 'Übermacht', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'exemplar', name = 'Exemplar', brand = 'Dewbauchee', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'f620', name = 'F620', brand = 'Ocelot', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'felon', name = 'Felon', brand = 'Lampadati', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'felon2', name = 'Felon GT', brand = 'Lampadati', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'fr36', name = 'FR36', brand = 'Übermacht', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'jackal', name = 'Jackal', brand = 'Ocelot', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'kanjosj', name = 'Kanjo SJ', brand = 'Dinka', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'oracle', name = 'Oracle XS', brand = 'Übermacht', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'oracle2', name = 'Oracle', brand = 'Übermacht', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'postlude', name = 'Postlude', brand = 'Dinka', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'previon', name = 'Previon', brand = 'Karin', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'sentinel', name = 'Sentinel XS', brand = 'Übermacht', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'sentinel2', name = 'Sentinel Classic', brand = 'Übermacht', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'windsor', name = 'Windsor', brand = 'Enus', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'windsor2', name = 'Windsor Drop', brand = 'Enus', price = 85000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'zion', name = 'Zion', brand = 'Übermacht', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },
    { model = 'zion2', name = 'Zion Cabrio', brand = 'Übermacht', price = 100000, category = 'coupes', type = 'automobile', shop = 'lux' },

    -- ================================================================================
    -- MUSCLE CARS
    -- ================================================================================
    { model = 'blade', name = 'Blade', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'brigham', name = 'Brigham', brand = 'Albany', price = 100000, category = 'muscle', type = 'automobile', shop = 'dragshop' },
    { model = 'broadway', name = 'Broadway', brand = 'Willard', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'buccaneer', name = 'Buccaneer', brand = 'Albany', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'buccaneer2', name = 'Buccaneer Custom', brand = 'Albany', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'buffalo5', name = 'Buffalo EVX', brand = 'Bravado', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'chino', name = 'Chino', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'chino2', name = 'Chino Custom', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'clique', name = 'Clique', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'clique2', name = 'Clique Wagon', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'coquette3', name = 'Coquette BlackFin', brand = 'Invetero', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'deviant', name = 'Deviant', brand = 'Schyster', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'dominator', name = 'Dominator', brand = 'Vapid', price = 120000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'dominator2', name = 'Pisswasser Dominator', brand = 'Vapid', price = 120000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'dominator3', name = 'Dominator GTX', brand = 'Vapid', price = 120000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'dominator7', name = 'Dominator ASP', brand = 'Vapid', price = 120000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'dominator8', name = 'Dominator GTT', brand = 'Vapid', price = 120000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'dominator9', name = 'Dominator GT', brand = 'Vapid', price = 120000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'dukes', name = 'Dukes', brand = 'Imponte', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'dukes3', name = 'Beater Dukes', brand = 'Imponte', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'ellie', name = 'Ellie', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'eudora', name = 'Eudora', brand = 'Willard', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'faction', name = 'Faction', brand = 'Willard', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'faction2', name = 'Faction Custom 1', brand = 'Willard', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'faction3', name = 'Faction Custom Donk', brand = 'Willard', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'gauntlet', name = 'Gauntlet', brand = 'Bravado', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'gauntlet2', name = 'Redwood Gauntlet', brand = 'Bravado', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'gauntlet3', name = 'Gauntlet Classic', brand = 'Bravado', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'gauntlet4', name = 'Gauntlet Hellfire', brand = 'Bravado', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'gauntlet5', name = 'Gauntlet Classic Custom', brand = 'Bravado', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'greenwood', name = 'Greenwood', brand = 'Bravado', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'hermes', name = 'Hermes', brand = 'Albany', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'hotknife', name = 'Hotknife', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'hustler', name = 'Hustler', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'impaler', name = 'Impaler', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'impaler6', name = 'Impaler LX', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'lurcher', name = 'Lurcher', brand = 'Albany', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'manana2', name = 'Manana Custom', brand = 'Albany', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'moonbeam', name = 'Moonbeam', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'moonbeam2', name = 'Moonbeam Custom', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'nightshade', name = 'Nightshade', brand = 'Imponte', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'peyote2', name = 'Peyote Gasser', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'phoenix', name = 'Phoenix', brand = 'Imponte', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'picador', name = 'Picador', brand = 'Cheval', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'ratloader', name = 'Rat-Loader', brand = 'Bravado', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'ratloader2', name = 'Rat-Truck', brand = 'Bravado', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'ruiner', name = 'Ruiner', brand = 'Imponte', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'ruiner4', name = 'Ruiner ZZ-8', brand = 'Imponte', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'sabregt', name = 'Sabre Turbo', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'sabregt2', name = 'Sabre Turbo Custom', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'slamvan', name = 'Slamvan', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'slamvan2', name = 'Lost Slamvan', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'slamvan3', name = 'Slamvan Custom', brand = 'Vapid', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'stalion', name = 'Stallion', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'stalion2', name = 'Burger Shot Stallion', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'tahoma', name = 'Tahoma Coupe', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'tampa', name = 'Tampa', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'tulip', name = 'Tulip', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'tulip2', name = 'Tulip M-100', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'vamos', name = 'Vamos', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'vigero', name = 'Vigero', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'vigero2', name = 'Vigero ZX', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'vigero3', name = 'Vigero ZX Convertible', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'virgo', name = 'Virgo', brand = 'Albany', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'virgo2', name = 'Virgo Classic Custom', brand = 'Dundreary', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'virgo3', name = 'Virgo Classic', brand = 'Dundreary', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'voodoo', name = 'Voodoo Custom', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'voodoo2', name = 'Voodoo', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'weevil2', name = 'Weevil Custom', brand = 'BF', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'yosemite', name = 'Yosemite', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },
    { model = 'yosemite2', name = 'Drift Yosemite', brand = 'Declasse', price = 100000, category = 'muscle', type = 'automobile', shop = 'lux' },

    -- ================================================================================
    -- SPORTS CARS
    -- ================================================================================

    { model = 'blista2', name = 'Blista Compact', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'blista3', name = 'Go Go Monkey Blista', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'buffalo2', name = 'Buffalo S', brand = 'Bravado', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'buffalo3', name = 'Buffalo Sprunk', brand = 'Bravado', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'comet3', name = 'Comet Retro Custom', brand = 'Pfister', price = 180000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'comet5', name = 'Comet SR', brand = 'Pfister', price = 180000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'comet6', name = 'Comet S2', brand = 'Pfister', price = 180000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'comet7', name = 'Comet S2 Cabrio', brand = 'Pfister', price = 180000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'coquette4', name = 'Coquette D10', brand = 'Invetero', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'cypher', name = 'Cypher', brand = 'Übermacht', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'drafter', name = '8F Drafter', brand = 'Obey', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'drifteuros', name = 'Euros Drift', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'driftfuto', name = 'Futo GTX Drift', brand = 'Karin', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'driftjester', name = 'Jester RR Drift', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'driftremus', name = 'Remus Drift', brand = 'Annis', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'driftzr350', name = 'ZR350 Drift', brand = 'Annis', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'elegy', name = 'Elegy Retro Custom', brand = 'Annis', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'elegy2', name = 'Elegy RH8', brand = 'Annis', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'euros', name = 'Euros', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'everon2', name = 'Hotring Everon', brand = 'Karin', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'feltzer2', name = 'Feltzer', brand = 'Benefactor', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'flashgt', name = 'Flash GT', brand = 'Vapid', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'furoregt', name = 'Furore GT', brand = 'Lampadati', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'fusilade', name = 'Fusilade', brand = 'Schyster', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'futo', name = 'Futo', brand = 'Karin', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'futo2', name = 'Futo GTX', brand = 'Karin', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'gauntlet6', name = 'Hotring Hellfire', brand = 'Bravado', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'gb200', name = 'GB200', brand = 'Vapid', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'growler', name = 'Growler', brand = 'Pfister', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'hotring', name = 'Hotring Sabre', brand = 'Declasse', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'imorgon', name = 'Imorgon', brand = 'Överflöd', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'issi7', name = 'Issi Sport', brand = 'Weeny', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'italigto', name = 'Itali GTO', brand = 'Grotti', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'italirsx', name = 'Itali RSX', brand = 'Grotti', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'jester', name = 'Jester', brand = 'Dinka', price = 2450000, category = 'super', type = 'automobile', shop = 'lux' },
    { model = 'jester2', name = 'Jester (Racecar)', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'jester3', name = 'Jester Classic', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'jester4', name = 'Jester RR', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'jugular', name = 'Jugular', brand = 'Ocelot', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'khamelion', name = 'Khamelion', brand = 'Hijak', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'komoda', name = 'Komoda', brand = 'Lampadati', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'kuruma', name = 'Kuruma', brand = 'Karin', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'locust', name = 'Locust', brand = 'Ocelot', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'lynx', name = 'Lynx', brand = 'Ocelot', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'massacro', name = 'Massacro', brand = 'Dewbauchee', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'massacro2', name = 'Massacro (Racecar)', brand = 'Dewbauchee', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'neo', name = 'Neo', brand = 'Vysser', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'neon', name = 'Neon', brand = 'Pfister', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'ninef', name = '9F', brand = 'Obey', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'ninef2', name = '9F Cabrio', brand = 'Obey', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'omnis', name = 'Omnis', brand = 'Obey', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'omnisegt', name = 'Omnis e-GT', brand = 'Obey', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'panthere', name = 'Panthere', brand = 'Lampadati', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'paragon', name = 'Paragon R', brand = 'Enus', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'pariah', name = 'Pariah', brand = 'Ocelot', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'penumbra', name = 'Penumbra', brand = 'Maibatsu', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'penumbra2', name = 'Penumbra FF', brand = 'Maibatsu', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'r300', name = '300R', brand = 'Annis', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'raiden', name = 'Raiden', brand = 'Coil', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'rapidgt', name = 'Rapid GT', brand = 'Dewbauchee', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'rapidgt2', name = 'Rapid GT Cabrio', brand = 'Dewbauchee', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'raptor', name = 'Raptor', brand = 'BF', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'remus', name = 'Remus', brand = 'Annis', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'revolter', name = 'Revolter', brand = 'Übermacht', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'rt3000', name = 'RT3000', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'ruston', name = 'Ruston', brand = 'Hijak', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'schafter3', name = 'Schafter V12', brand = 'Benefactor', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'schafter4', name = 'Schafter LWB', brand = 'Benefactor', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'schlagen', name = 'Schlagen GT', brand = 'Benefactor', price = 150000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'schwarzer', name = 'Schwartzer', brand = 'Benefactor', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'sentinel3', name = 'Sentinel', brand = 'Übermacht', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'sentinel4', name = 'Sentinel Classic Widebody', brand = 'Übermacht', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'seven70', name = 'Seven-70', brand = 'Dewbauchee', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'sm722', name = 'SM722', brand = 'Benefactor', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'specter', name = 'Specter', brand = 'Dewbauchee', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'specter2', name = 'Specter Custom', brand = 'Dewbauchee', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'stingertt', name = 'Itali GTO Stinger TT', brand = 'Grotti', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'streiter', name = 'Streiter', brand = 'Benefactor', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'sugoi', name = 'Sugoi', brand = 'Dinka', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'sultan', name = 'Sultan', brand = 'Karin', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'sultan2', name = 'Sultan Classic', brand = 'Karin', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'sultan3', name = 'Sultan RS Classic', brand = 'Karin', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'surano', name = 'Surano', brand = 'Benefactor', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'tampa2', name = 'Drift Tampa', brand = 'Declasse', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'tenf', name = '10F', brand = 'Obey', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'tenf2', name = '10F Widebody', brand = 'Obey', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'tropos', name = 'Tropos Rallye', brand = 'Lampadati', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'vectre', name = 'Vectre', brand = 'Emperor', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'verlierer2', name = 'Verlierer', brand = 'Bravado', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'vstr', name = 'V-STR', brand = 'Albany', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },
    { model = 'zr350', name = 'ZR350', brand = 'Annis', price = 120000, category = 'sports', type = 'automobile', shop = 'lux' },

    -- ================================================================================
    -- MOTORCYCLES (Bike Dealership)
    -- ================================================================================
    
    -- ================================================================================
    -- SPORT BIKES
    -- ================================================================================
    { model = 'bati901', name = 'Pegassi Bati 901', brand = 'PEGASSI', price = 180000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'akuma', name = 'Akuma', brand = 'Dinka', price = 140000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'bati', name = 'Bati 801', brand = 'Pegassi', price = 160000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'bati2', name = 'Bati 801RR', brand = 'Pegassi', price = 180000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'bf400', name = 'BF400', brand = 'Nagasaki', price = 120000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'carbonrs', name = 'Carbon RS', brand = 'Nagasaki', price = 150000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'chimera', name = 'Chimera', brand = 'Nagasaki', price = 110000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'defiler', name = 'Defiler', brand = 'Shitzu', price = 140000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'diablous', name = 'Diabolus', brand = 'Principe', price = 160000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'diablous2', name = 'Diabolus Custom', brand = 'Principe', price = 180000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'double', name = 'Double-T', brand = 'Dinka', price = 150000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'esskey', name = 'Esskey', brand = 'Pegassi', price = 120000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'fcr', name = 'FCR 1000', brand = 'Pegassi', price = 160000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'fcr2', name = 'FCR 1000 Custom', brand = 'Pegassi', price = 180000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'hakuchou', name = 'Hakuchou', brand = 'Shitzu', price = 190000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'hakuchou2', name = 'Hakuchou Drag', brand = 'Shitzu', price = 200000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'lectro', name = 'Lectro', brand = 'Principe', price = 140000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'manchez', name = 'Manchez', brand = 'Maibatsu', price = 100000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'manchez2', name = 'Manchez Scout', brand = 'Maibatsu', price = 110000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'manchez3', name = 'Manchez Scout C', brand = 'Maibatsu', price = 120000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'nemesis', name = 'Nemesis', brand = 'Principe', price = 130000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'pcj', name = 'PCJ 600', brand = 'Shitzu', price = 140000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'powersurge', name = 'Powersurge', brand = 'Western', price = 150000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'reever', name = 'Reever', brand = 'Western', price = 160000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'ruffian', name = 'Ruffian', brand = 'Pegassi', price = 120000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'sanchez', name = 'Sanchez (livery)', brand = 'Maibatsu', price = 100000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'sanchez2', name = 'Sanchez', brand = 'Maibatsu', price = 100000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'stryder', name = 'Stryder', brand = 'Nagasaki', price = 130000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'thrust', name = 'Thrust', brand = 'Dinka', price = 150000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'vader', name = 'Vader', brand = 'Pegassi', price = 120000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'vindicator', name = 'Vindicator', brand = 'Dinka', price = 140000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'vortex', name = 'Vortex', brand = 'Pegassi', price = 160000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    
    -- ================================================================================
    -- CRUISER BIKES
    -- ================================================================================
    { model = 'avarus', name = 'Avarus', brand = 'LCC', price = 80000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'bagger', name = 'Bagger', brand = 'Western', price = 90000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'cliffhanger', name = 'Cliffhanger', brand = 'Western', price = 100000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'daemon', name = 'Daemon', brand = 'Western', price = 80000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'daemon2', name = 'Daemon Custom', brand = 'Western', price = 90000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'hexer', name = 'Hexer', brand = 'LCC', price = 90000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'innovation', name = 'Innovation', brand = 'LCC', price = 100000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'nightblade', name = 'Nightblade', brand = 'Western', price = 110000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'pcj', name = 'PCJ 600', brand = 'Shitzu', price = 140000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'ratbike', name = 'Rat Bike', brand = 'Western', price = 70000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'sovereign', name = 'Sovereign', brand = 'Western', price = 90000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'wolfsbane', name = 'Wolfsbane', brand = 'Western', price = 80000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'zombiea', name = 'Zombie A', brand = 'Western', price = 90000, category = 'cruisers', type = 'automobile', shop = 'bike' },
    { model = 'zombieb', name = 'Zombie B', brand = 'Western', price = 90000, category = 'cruisers', type = 'automobile', shop = 'bike' },

    -- ================================================================================
    -- SCOOTERS
    -- ================================================================================
    { model = 'faggio', name = 'Faggio', brand = 'Pegassi', price = 45000, category = 'scooters', type = 'automobile', shop = 'bike' },
    { model = 'faggio2', name = 'Faggio Sport', brand = 'Pegassi', price = 50000, category = 'scooters', type = 'automobile', shop = 'bike' },
    { model = 'faggio3', name = 'Faggio Mod', brand = 'Pegassi', price = 55000, category = 'scooters', type = 'automobile', shop = 'bike' },
    { model = 'manchez', name = 'Manchez', brand = 'Maibatsu', price = 100000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'manchez2', name = 'Manchez Scout', brand = 'Maibatsu', price = 110000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'manchez3', name = 'Manchez Scout C', brand = 'Maibatsu', price = 120000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'sanchez', name = 'Sanchez (livery)', brand = 'Maibatsu', price = 100000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    { model = 'sanchez2', name = 'Sanchez', brand = 'Maibatsu', price = 100000, category = 'sportbikes', type = 'automobile', shop = 'bike' },
    
    -- ================================================================================
    -- LUXURY BIKES
    -- ================================================================================
    { model = 'sanctus', name = 'Sanctus', brand = 'LCC', price = 450000, category = 'luxurybikes', type = 'automobile', shop = 'bike' },
    { model = 'CHIMERA2', name = 'Chimera', brand = 'Western Nightblade', price = 300000, category = 'luxurybikes', type = 'automobile', shop = 'bike' },

    -- ================================================================================
    -- OFF-ROAD VEHICLES (Offroad Dealership)
    -- ================================================================================
    
    -- ================================================================================
    -- ROCK CRAWLERS
    -- ================================================================================
    { model = 'bfinjection', name = 'Injection', brand = 'BF', price = 55000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },
    { model = 'boor', name = 'Boor', brand = 'Karin', price = 65000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },
    { model = 'freecrawler', name = 'Freecrawler', brand = 'Canis', price = 95000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },
    { model = 'hellion', name = 'Hellion', brand = 'Annis', price = 85000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },
    { model = 'kamacho', name = 'Kamacho', brand = 'Canis', price = 100000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },
    { model = 'l35', name = 'Walton L35', brand = 'Declasse', price = 75000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },
    { model = 'rebel', name = 'Rusty Rebel', brand = 'Karin', price = 45000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },
    { model = 'rebel2', name = 'Rebel', brand = 'Karin', price = 55000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },
    { model = 'riata', name = 'Riata', brand = 'Vapid', price = 75000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },
    { model = 'yosemite3', name = 'Yosemite Rancher', brand = 'Declasse', price = 75000, category = 'rockcrawlers', type = 'automobile', shop = 'offroad' },

    
    -- ================================================================================
    -- DUNE BUGGIES
    -- ================================================================================
    { model = 'bifta', name = 'Bifta', brand = 'Dinka', price = 40000, category = 'dunebuggies', type = 'automobile', shop = 'offroad' },
    { model = 'dune', name = 'Dune Buggy', brand = 'BF', price = 30000, category = 'dunebuggies', type = 'automobile', shop = 'offroad' },

    
    -- ================================================================================
    -- UTILITY OFF-ROAD
    -- ================================================================================
    { model = 'blazer', name = 'Blazer', brand = 'Nagasaki', price = 45000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'blazer2', name = 'Blazer Lifeguard', brand = 'Nagasaki', price = 55000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'blazer3', name = 'Hot Rod Blazer', brand = 'Nagasaki', price = 65000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'blazer4', name = 'Street Blazer', brand = 'Nagasaki', price = 70000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'bodhi2', name = 'Bodhi', brand = 'Canis', price = 65000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'dloader', name = 'Duneloader', brand = 'Bravado', price = 45000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'kalahari', name = 'Kalahari', brand = 'Canis', price = 40000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'rancherxl', name = 'Rancher XL', brand = 'Declasse', price = 65000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'verus', name = 'Verus', brand = 'Dinka', price = 45000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'winky', name = 'Winky', brand = 'Vapid', price = 55000, category = 'utilityoffroad', type = 'automobile', shop = 'offroad' },
    
    -- ================================================================================
    -- PERFORMANCE OFF-ROAD
    -- ================================================================================
    { model = 'brawler', name = 'Brawler', brand = 'Coil', price = 75000, category = 'performanceoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'caracara2', name = 'Caracara 4x4', brand = 'Vapid', price = 70000, category = 'performanceoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'dubsta3', name = 'Dubsta 6x6', brand = 'Benefactor', price = 75000, category = 'performanceoffroad', type = 'automobile', shop = 'offroad' },

    
    -- ================================================================================
    -- SPECIALTY OFF-ROAD
    -- ================================================================================

    { model = 'sandking', name = 'Sandking XL', brand = 'Vapid', price = 75000, category = 'specialtyoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'sandking2', name = 'Sandking SWB', brand = 'Vapid', price = 75000, category = 'specialtyoffroad', type = 'automobile', shop = 'offroad' },
    { model = 'terminus', name = 'Terminus', brand = 'Benefactor', price = 75000, category = 'specialtyoffroad', type = 'automobile', shop = 'offroad' },

    -- ================================================================================
    -- INDUSTRIAL OFF-ROAD
    -- ================================================================================
    { model = 'flatbed', name = 'Flatbed', brand = 'MTL', price = 45000, category = 'industrial', type = 'automobile', shop = 'offroad' },
    { model = 'guardian', name = 'Guardian', brand = 'Vapid', price = 65000, category = 'industrial', type = 'automobile', shop = 'offroad' },
    { model = 'mixer', name = 'Mixer', brand = 'HVY', price = 35000, category = 'industrial', type = 'automobile', shop = 'offroad' },
    { model = 'mixer2', name = 'Mixer', brand = 'HVY', price = 40000, category = 'industrial', type = 'automobile', shop = 'offroad' },
    { model = 'rubble', name = 'Rubble', brand = 'HVY', price = 30000, category = 'industrial', type = 'automobile', shop = 'offroad' },

    -- ================================================================================
    -- TRACTORS (Offroad Dealership)
    -- ================================================================================
    { model = 'tractor4', name = 'Tractor 4', brand = 'DECLASSE', price = 4500000, category = 'tractor', type = 'automobile', shop = 'offroad' },
    { model = 'tractor2', name = 'Fieldmaster', brand = 'Unknown', price = 45000, category = 'tractor', type = 'automobile', shop = 'offroad' },
    { model = 'tractor3', name = 'Fieldmaster', brand = 'Unknown', price = 50000, category = 'tractor', type = 'automobile', shop = 'offroad' },

    -- ================================================================================
    -- VANS (Offroad Dealership)
    -- ================================================================================
    { model = 'bison', name = 'Bison', brand = 'Bravado', price = 55000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'bison2', name = 'Bison', brand = 'Bravado', price = 58000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'bison3', name = 'Bison', brand = 'Bravado', price = 62000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'bobcatxl', name = 'Bobcat XL', brand = 'Vapid', price = 60000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'boxville', name = 'Boxville', brand = 'Brute', price = 48000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'boxville2', name = 'Boxville', brand = 'Brute', price = 50000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'boxville3', name = 'Boxville', brand = 'Brute', price = 52000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'boxville4', name = 'Boxville', brand = 'Brute', price = 54000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'burrito', name = 'Burrito', brand = 'Declasse', price = 45000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'burrito2', name = 'Bugstars Burrito', brand = 'Declasse', price = 47000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'burrito3', name = 'Burrito', brand = 'Declasse', price = 49000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'burrito4', name = 'Burrito', brand = 'Declasse', price = 51000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'burrito5', name = 'Burrito', brand = 'Declasse', price = 53000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'camper', name = 'Camper', brand = 'Brute', price = 65000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'gburrito', name = 'Gang Burrito', brand = 'Declasse', price = 55000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'gburrito2', name = 'Gang Burrito', brand = 'Declasse', price = 58000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'journey', name = 'Journey', brand = 'Zirconium', price = 42000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'journey2', name = 'Journey II', brand = 'Zirconium', price = 44000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'minivan', name = 'Minivan', brand = 'Vapid', price = 40000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'minivan2', name = 'Minivan Custom', brand = 'Vapid', price = 45000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'paradise', name = 'Paradise', brand = 'Bravado', price = 38000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'pony', name = 'Pony', brand = 'Vapid', price = 35000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'pony2', name = 'Pony', brand = 'Vapid', price = 37000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'rumpo', name = 'Rumpo', brand = 'Declasse', price = 42000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'rumpo2', name = 'Rumpo', brand = 'Declasse', price = 44000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'rumpo3', name = 'Rumpo Custom', brand = 'Declasse', price = 48000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'speedo', name = 'Speedo', brand = 'Vapid', price = 40000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'speedo2', name = 'Clown Van', brand = 'Vapid', price = 45000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'speedo4', name = 'Speedo Custom', brand = 'Vapid', price = 50000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'speedo5', name = 'Speedo Custom', brand = 'Vapid', price = 52000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'surfer', name = 'Surfer', brand = 'BF', price = 38000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'surfer2', name = 'Surfer', brand = 'BF', price = 40000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'surfer3', name = 'Surfer Custom', brand = 'BF', price = 45000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'taco', name = 'Taco Van', brand = 'Brute', price = 42000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'youga', name = 'Youga', brand = 'Bravado', price = 45000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'youga2', name = 'Youga Classic', brand = 'Bravado', price = 48000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'youga3', name = 'Youga Classic 4x4', brand = 'Bravado', price = 55000, category = 'vans', type = 'automobile', shop = 'offroad' },
    { model = 'youga4', name = 'Youga Custom', brand = 'Bravado', price = 52000, category = 'vans', type = 'automobile', shop = 'offroad' },

    -- ================================================================================
    -- COMMERCIAL (Offroad Dealership)
    -- ================================================================================
    { model = 'trash', name = 'Trashmaster', brand = 'MTL', price = 65000, category = 'commercial', type = 'automobile', shop = 'offroad' },
    { model = 'trash2', name = 'Trashmaster', brand = 'MTL', price = 75000, category = 'commercial', type = 'automobile', shop = 'offroad' },
    { model = 'rallytruck', name = 'Dune', brand = 'MTL', price = 85000, category = 'commercial', type = 'automobile', shop = 'offroad' },
    { model = 'benson', name = 'Benson', brand = 'Vapid', price = 90000, category = 'commercial', type = 'automobile', shop = 'offroad' },
    { model = 'benson2', name = 'Benson (Cluckin\' Bell)', brand = 'Vapid', price = 100000, category = 'commercial', type = 'automobile', shop = 'offroad' },
    { model = 'biff', name = 'Biff', brand = 'HVY', price = 75000, category = 'commercial', type = 'automobile', shop = 'offroad' },
    { model = 'mule', name = 'Mule', brand = 'Maibatsu', price = 60000, category = 'commercial', type = 'automobile', shop = 'offroad' },
    { model = 'mule2', name = 'Mule', brand = 'Maibatsu', price = 65000, category = 'commercial', type = 'automobile', shop = 'offroad' },
    { model = 'mule3', name = 'Mule', brand = 'Maibatsu', price = 70000, category = 'commercial', type = 'automobile', shop = 'offroad' },
    { model = 'mule5', name = 'Mule', brand = 'Maibatsu', price = 75000, category = 'commercial', type = 'automobile', shop = 'offroad' },

    -- ================================================================================
    -- TRAILERS (Offroad Dealership)
    -- ================================================================================
    { model = 'baletrailer', name = 'Baletrailer', brand = 'Unknown', price = 35000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'boattrailer', name = 'Boat Trailer', brand = 'Unknown', price = 25000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'boattrailer2', name = 'Boat Trailer', brand = 'Unknown', price = 28000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'boattrailer3', name = 'Boat Trailer', brand = 'Unknown', price = 32000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'docktrailer', name = 'Dock Trailer', brand = 'Unknown', price = 40000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'freighttrailer', name = 'Freight Trailer', brand = 'Unknown', price = 75000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'graintrailer', name = 'Graintrailer', brand = 'Unknown', price = 65000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'tr2', name = 'Trailer', brand = 'Unknown', price = 20000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'tr3', name = 'Trailer', brand = 'Unknown', price = 22000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'tr4', name = 'Trailer', brand = 'Unknown', price = 25000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'trailerlogs', name = 'Trailer', brand = 'Unknown', price = 30000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'trailers', name = 'Trailer', brand = 'Unknown', price = 28000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'trailers2', name = 'Trailer', brand = 'Unknown', price = 30000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'trailers3', name = 'Trailer', brand = 'Unknown', price = 32000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'trailers4', name = 'Trailer', brand = 'Unknown', price = 35000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'trailers5', name = 'Trailer', brand = 'Unknown', price = 38000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'trailersmall', name = 'Trailer', brand = 'Unknown', price = 15000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'trflat', name = 'Trailer', brand = 'Unknown', price = 25000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'tvtrailer', name = 'Trailer', brand = 'Unknown', price = 35000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'tvtrailer2', name = 'Trailer', brand = 'Unknown', price = 40000, category = 'trailers', type = 'trailer', shop = 'offroad' },

    -- ================================================================================
    -- GANG CARS (Gang Dealership)
    -- ================================================================================
    
    -- ================================================================================
    -- GANG COMETS (PFISTER)
    -- ================================================================================
    { model = 'amwbcometaod', name = 'AOD COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcometaztecas', name = 'AZTECAS COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcometballas', name = 'BALLAS COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcometcartel', name = 'CARTEL COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcometdisciples', name = 'DISCIPLES COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcometfamilies', name = 'FAMILIES COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcometlostmc', name = 'LOSTMC COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcometmafia', name = 'MAFIA COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcomettriads', name = 'TRIADS COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcometvagos', name = 'VAGOS COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'amwbcometyakuza', name = 'YAKUZA COMET - GANG CARS', brand = 'PFISTER', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },

    -- ================================================================================
    -- GANG BUGGIES (BUGGY)
    -- ================================================================================
    { model = 'koryproraod', name = 'AOD BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryproraztecas', name = 'AZTECAS BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryprorballas', name = 'BALLAS BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryprorcartel', name = 'CARTEL BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryprordisciples', name = 'DISCIPLES BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryprorfamilies', name = 'FAMILIES BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryprorlostmc', name = 'LOSTMC BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryprormafia', name = 'MAFIA BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryprortriads', name = 'TRIADS BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryprorvagos', name = 'VAGOS BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'koryproryakuza', name = 'YAKUZA BUGGY - GANG CARS', brand = 'BUGGY', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },

    -- ================================================================================
    -- GANG HELICOPTERS (FROGGER)
    -- ================================================================================
    { model = 'md902aod', name = 'AOD HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902aztecas', name = 'AZTECAS HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902ballas', name = 'BALLAS HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902cartel', name = 'CARTEL HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902disciples', name = 'DISCIPLES HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902families', name = 'FAMILIES HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902lostmc', name = 'LOSTMC HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902mafia', name = 'MAFIA HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902triads', name = 'TRIADS HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902vagos', name = 'VAGOS HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },
    { model = 'md902yakuza', name = 'YAKUZA HELI - GANG CARS', brand = 'FROGGER', price = 0, category = 'gang', type = 'helicopter', shop = 'gang' },

    -- ================================================================================
    -- GANG CYPHERS (CYPHER)
    -- ================================================================================
    { model = 'pace_cypheranimaod', name = 'AOD CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimaztecas', name = 'AZTECAS CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimballas', name = 'BALLAS CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimcartel', name = 'CARTEL CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimdisciples', name = 'DISCIPLES CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimfamilies', name = 'FAMILIES CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimlostmc', name = 'LOSTMC CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimmafia', name = 'MAFIA CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimtriads', name = 'TRIADS CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimvagos', name = 'VAGOS CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_cypheranimyakuza', name = 'YAKUZA CYPHER - GANG CARS', brand = 'CYPHER', price = 200000, category = 'gang', type = 'automobile', shop = 'gang' },

    -- ================================================================================
    -- GANG SUNRISES (MAIBATSU)
    -- ================================================================================
    { model = 'pace_sunriseaod', name = 'AOD SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunriseaztecas', name = 'AZTECAS SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunriseballas', name = 'BALLAS SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunrisecartel', name = 'CARTEL SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunrisedisciples', name = 'DISCIPLES SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunrisefamilies', name = 'FAMILIES SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunriselostmc', name = 'LOSTMC SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunrisemafia', name = 'MAFIA SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunrisetriads', name = 'TRIADS SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunrisevagos', name = 'VAGOS SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },
    { model = 'pace_sunriseyakuza', name = 'YAKUZA SUNRISE HYCADE - GANG CARS', brand = 'MAIBATSU', price = 0, category = 'gang', type = 'automobile', shop = 'gang' },

    -- ================================================================================
    -- BOATS (Boats Dealership)
    -- ================================================================================
    
    -- ================================================================================
    -- SPORT BOATS
    -- ================================================================================
    { model = 'dinghy', name = 'Dinghy', brand = 'Nagasaki', price = 45000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'dinghy2', name = 'Dinghy 2', brand = 'Nagasaki', price = 55000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'dinghy3', name = 'Dinghy 3', brand = 'Nagasaki', price = 65000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'dinghy4', name = 'Dinghy 4', brand = 'Nagasaki', price = 75000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'jetmax', name = 'Jetmax', brand = 'Shitzu', price = 180000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'speeder', name = 'Speeder', brand = 'Pegassi', price = 220000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'speeder2', name = 'Speeder 2', brand = 'Pegassi', price = 250000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'squalo', name = 'Squalo', brand = 'Shitzu', price = 140000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'toro', name = 'Toro', brand = 'Lampadati', price = 280000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'toro2', name = 'Toro 2', brand = 'Lampadati', price = 320000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'tropic', name = 'Tropic', brand = 'Shitzu', price = 160000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'tropic2', name = 'Tropic 2', brand = 'Shitzu', price = 180000, category = 'sport', type = 'boat', shop = 'boat' },
    { model = 'suntrap', name = 'Suntrap', brand = 'Shitzu', price = 280000, category = 'luxury', type = 'boat', shop = 'boat' },
    
    -- ================================================================================
    -- LUXURY BOATS
    -- ================================================================================
    { model = 'marquis', name = 'Marquis', brand = 'Dinka', price = 1200000, category = 'luxury', type = 'boat', shop = 'boat' },
    { model = 'longfin', name = 'Longfin', brand = 'Shitzu', price = 1000000, category = 'luxury', type = 'boat', shop = 'boat' },
    
    -- ================================================================================
    -- UTILITY BOATS
    -- ================================================================================
    { model = 'seashark', name = 'Seashark', brand = 'Speedophile', price = 55000, category = 'utility', type = 'boat', shop = 'boat' },
    { model = 'seashark2', name = 'Seashark 2', brand = 'Speedophile', price = 65000, category = 'utility', type = 'boat', shop = 'boat' },
    { model = 'seashark3', name = 'Seashark 3', brand = 'Speedophile', price = 75000, category = 'utility', type = 'boat', shop = 'boat' },
    { model = 'tug', name = 'Tug', brand = 'Buckingham', price = 2500000, category = 'utility', type = 'boat', shop = 'boat' },
    
    -- ================================================================================
    -- SPECIALTY BOATS
    -- ================================================================================
    { model = 'submersible', name = 'Submersible', brand = 'Nagasaki', price = 2500000, category = 'specialty', type = 'boat', shop = 'boat' },
    { model = 'submersible2', name = 'Kraken', brand = 'Nagasaki', price = 3500000, category = 'specialty', type = 'boat', shop = 'boat' },

    -- ================================================================================
    -- HELICOPTERS (Helicopter Dealership)
    -- ================================================================================
    
    -- ================================================================================
    -- CIVILIAN HELICOPTERS
    -- ================================================================================
    { model = 'frogger', name = 'Frogger', brand = 'Maibatsu', price = 650000, category = 'civilian', type = 'helicopter', shop = 'helicopter' },
    { model = 'havok', name = 'Havok', brand = 'Nagasaki', price = 600000, category = 'civilian', type = 'helicopter', shop = 'helicopter' },
    { model = 'maverick', name = 'Maverick', brand = 'Buckingham', price = 700000, category = 'civilian', type = 'helicopter', shop = 'helicopter' },
    
    -- ================================================================================
    -- LUXURY HELICOPTERS
    -- ================================================================================
    { model = 'supervolito', name = 'SuperVolito', brand = 'Buckingham', price = 1200000, category = 'luxury', type = 'helicopter', shop = 'helicopter' },
    { model = 'supervolito2', name = 'SuperVolito Carbon', brand = 'Buckingham', price = 1500000, category = 'luxury', type = 'helicopter', shop = 'helicopter' },
    { model = 'swift', name = 'Swift', brand = 'Buckingham', price = 1000000, category = 'luxury', type = 'helicopter', shop = 'helicopter' },
    { model = 'swift2', name = 'Swift Deluxe', brand = 'Buckingham', price = 1200000, category = 'luxury', type = 'helicopter', shop = 'helicopter' },
    { model = 'volatus', name = 'Volatus', brand = 'Buckingham', price = 1300000, category = 'luxury', type = 'helicopter', shop = 'helicopter' },

    -- ================================================================================
    -- AIRPLANES (Airplane Dealership)
    -- ================================================================================
    
    -- ================================================================================
    -- CIVILIAN PLANES
    -- ================================================================================
    { model = 'alphaz1', name = 'Alpha-Z1', brand = 'Buckingham', price = 750000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'besra', name = 'Besra', brand = 'Buckingham', price = 3500000, category = 'military', type = 'airplane', shop = 'airplane' },
    { model = 'cuban800', name = 'Cuban 800', brand = 'Buckingham', price = 650000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'dodo', name = 'Dodo', brand = 'Mammoth', price = 600000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'duster', name = 'Duster', brand = 'Buckingham', price = 550000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'howard', name = 'Howard NX-25', brand = 'Buckingham', price = 700000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'mammatus', name = 'Mammatus', brand = 'Mammoth', price = 600000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'microlight', name = 'Microlight', brand = 'Buckingham', price = 550000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'seabreeze', name = 'Seabreeze', brand = 'Buckingham', price = 650000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'velum', name = 'Velum', brand = 'Buckingham', price = 700000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'velum2', name = 'Velum 2', brand = 'Buckingham', price = 750000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    { model = 'vestra', name = 'Vestra', brand = 'Buckingham', price = 800000, category = 'civilian', type = 'airplane', shop = 'airplane' },
    
    -- ================================================================================
    -- LUXURY PLANES
    -- ================================================================================
    { model = 'luxor', name = 'Luxor', brand = 'Buckingham', price = 1800000, category = 'luxury', type = 'airplane', shop = 'airplane' },
    { model = 'luxor2', name = 'Luxor Deluxe', brand = 'Buckingham', price = 2500000, category = 'luxury', type = 'airplane', shop = 'airplane' },
    { model = 'miljet', name = 'Miljet', brand = 'Buckingham', price = 3500000, category = 'military', type = 'airplane', shop = 'airplane' },
    { model = 'nimbus', name = 'Nimbus', brand = 'Buckingham', price = 2200000, category = 'luxury', type = 'airplane', shop = 'airplane' },
    { model = 'shamal', name = 'Shamal', brand = 'Buckingham', price = 1800000, category = 'luxury', type = 'airplane', shop = 'airplane' },
    
    -- ================================================================================
    -- UTILITY PLANES
    -- ================================================================================
    { model = 'blimp', name = 'Atomic Blimp', brand = 'Buckingham', price = 800000, category = 'utility', type = 'airplane', shop = 'airplane' },
    { model = 'blimp2', name = 'Xero Blimp', brand = 'Buckingham', price = 900000, category = 'utility', type = 'airplane', shop = 'airplane' },
    { model = 'blimp3', name = 'Blimp', brand = 'Buckingham', price = 850000, category = 'utility', type = 'airplane', shop = 'airplane' },
    { model = 'cargoplane', name = 'Cargo Plane', brand = 'Mammoth', price = 1500000, category = 'utility', type = 'airplane', shop = 'airplane' },
    
    -- ================================================================================
    -- SPECIALTY PLANES
    -- ================================================================================
    { model = 'streamer216', name = 'Streamer216', brand = 'Buckingham', price = 600000, category = 'utility', type = 'airplane', shop = 'airplane' },
    { model = 'stunt', name = 'Mallard', brand = 'Buckingham', price = 550000, category = 'utility', type = 'airplane', shop = 'airplane' },

    -- ========================================
    -- FOLDER: [cars]/[patreon_cars]
    -- VEHICLES: Patreon Exclusive Vehicles
    -- ========================================
    
    -- ========================================
    -- TIER 1 PATREON CARS
    -- ========================================
    { model = 'sc_dominatorwb', name = 'Vapid Dominator Widebody - Tier 1', brand = 'VAPID', price = 0, category = 'muscle', type = 'automobile', shop = 'patreon' },
    { model = 'vacca2', name = 'Pegassi Vacca Widebody - Tier 1', brand = 'PEGASSI', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'sentinel_rts', name = 'Übermacht Sentinel RTS - Tier 1', brand = 'ÜBERMACHT', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'gp1wb', name = 'Progen GP1 Custom Widebody - Tier 1', brand = 'PROGEN', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'gb811s2', name = 'Pfister 811 S2 - Tier 1', brand = 'PFISTER', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'cometrr', name = 'Pfister Comet RR2 Custom - Tier 1', brand = 'PFISTER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'zentornoc', name = 'Pegassi Zentorno Custom - Tier 1', brand = 'PEGASSI', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'saseverowb', name = 'Pegassi Severo Widebody - Tier 1', brand = 'PEGASSI', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'srspback', name = 'Obey Tailgater Hatchback - Tier 1', brand = 'OBEY', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'mk2vigerozx', name = 'Mk2 Vigero ZX - Tier 1', brand = 'DECLASSE', price = 0, category = 'muscle', type = 'automobile', shop = 'patreon' },
    { model = 'komodafr', name = 'Lampadati Komoda FR - Tier 1', brand = 'LAMPADATI', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'sultanrsv8', name = 'Karin Sultan RSV8 MK2 - Tier 1', brand = 'KARIN', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'boorbc', name = 'Karin Boor Custom 2 - Tier 1', brand = 'KARIN', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'z190wb', name = 'Karin 190Z Custom Widebody - Tier 1', brand = 'KARIN', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'gstarg2', name = 'GST ARG2 - Tier 1', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'furiawb', name = 'Grotti Furia Widebody - Tier 1', brand = 'GROTTI', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    -- { model = 'gbmogulrs', name = 'GB Mogul RS - Tier 1', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'jestgpr', name = 'Dinka Jest GPR - Tier 1', brand = 'DINKA', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'Hoonie', name = 'Dinka Hoonie - Tier 1', brand = 'DINKA', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'cypherct', name = 'Übermacht Cypher CT - Tier 1', brand = 'ÜBERMACHT', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'coquettewb', name = 'Custom Coquette Widebody - Tier 1', brand = 'INVETERO', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'contenderc', name = 'Vapid Contender Custom - Tier 1', brand = 'VAPID', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'clubta', name = 'Clubta - Tier 1', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'h4rxwindsorcus', name = 'Bravado H4R Windsor Custom - Tier 1', brand = 'BRAVADO', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    -- { model = 'gbclubxr', name = 'BF GB Club XR - Tier 1', brand = 'BF', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'gstzr3503', name = 'Annis ZR350 Widebody - Tier 1', brand = 'ANNIS', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'r300w', name = 'Annis 300R Widebody 2.0.1 - Tier 1', brand = 'ANNIS', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'schwarzer2', name = '6STR Benefactor Schwartzer Aggressor Custom - Tier 1', brand = 'BENEFACTOR', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },

    -- ========================================
    -- TIER 2 PATREON CARS
    -- ========================================
    { model = 'playboy', name = 'Vapid Playboy - Tier 2', brand = 'VAPID', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'domttc', name = 'Vapid Dominator GTT Custom - Tier 2', brand = 'VAPID', price = 0, category = 'muscle', type = 'automobile', shop = 'patreon' },
    { model = 'vacca3', name = 'Pegassi Vacca - Tier 2', brand = 'PEGASSI', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'ziongtc', name = 'Übermacht Zion GTC - Tier 2', brand = 'ÜBERMACHT', price = 0, category = 'coupes', type = 'automobile', shop = 'patreon' },
    { model = 'sdmonsterslayer', name = 'SD Monster Slayer - Tier 2', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'exr', name = 'Picador EXR - Tier 2', brand = 'CHEVAL', price = 0, category = 'muscle', type = 'automobile', shop = 'patreon' },
    { model = 'comets2', name = 'Pfister Comet S2 - Tier 2', brand = 'PFISTER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'zentorno2', name = 'Pegassi AK Zentorno R - Tier 2', brand = 'PEGASSI', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'fcomneisgt25', name = 'Obey F Comneis GT25 - Tier 2', brand = 'OBEY', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'audace', name = 'Lampadati Audace - Tier 2', brand = 'LAMPADATI', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'sddriftvet', name = 'Inverto SD Drift Vet - Tier 2', brand = 'INVERTO', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'hotkniferod', name = 'Hotknife Roadster - Tier 2', brand = 'VAPID', price = 0, category = 'muscle', type = 'automobile', shop = 'patreon' },
    { model = 'vertice', name = 'Hijak Vertice - Tier 2', brand = 'HIJAK', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'gstjc2', name = 'GST JC2 - Tier 2', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'turismorr', name = 'Grotti Turismo RR - Tier 2', brand = 'GROTTI', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'turismo2lm', name = 'Grotti Turismo 2 LM - Tier 2', brand = 'GROTTI', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'italigts', name = 'Grotti Itali GTS - Tier 2', brand = 'GROTTI', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'gbsultanrsx', name = 'GB Sultan RSX - Tier 2', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'gbmojave', name = 'GB Mojave - Tier 2', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'jesterwb', name = 'Dinka Jester Classic Custom - Tier 2', brand = 'DINKA', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'jester4wb', name = 'Dinka Jester Custom - Tier 2', brand = 'DINKA', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'rt3000wb', name = 'Dinka RT3000 Custom Widebody - Tier 2', brand = 'DINKA', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'vigerozxwbc', name = 'Declasse Vigero ZX Custom Widebody - Tier 2', brand = 'DECLASSE', price = 0, category = 'muscle', type = 'automobile', shop = 'patreon' },
    { model = 'gstghell1', name = 'Bravado GST G Hell 1 - Tier 2', brand = 'BRAVADO', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'elytron', name = 'BF Spelytron - Tier 2', brand = 'BF', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'hrgt6r', name = 'Benefactor GT6R HR - Tier 2', brand = 'BENEFACTOR', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'remuswb', name = 'Annis Remus Custom Widebody - Tier 2', brand = 'ANNIS', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'yosemite6str', name = '6STR Declasse Drift Yosemite - Tier 2', brand = 'DECLASSE', price = 0, category = 'muscle', type = 'automobile', shop = 'patreon' },

    -- ========================================
    -- TIER 3 PATREON CARS
    -- ========================================
    { model = 'vd_tenfrally', name = 'VD Ten F Rally - Tier 3', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'vanz23m2wb', name = 'Vanz 23M2 Widebody - Tier 3', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'thraxs', name = 'Truffade Thrax S - Tier 3', brand = 'TRUFFADE', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'sunrise1', name = 'Sunriser - Tier 3', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'sentineldm', name = 'Übermacht Sentinel DM - Tier 3', brand = 'ÜBERMACHT', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'sagauntletstreet', name = 'Street Gauntlet - Tier 3', brand = 'BRAVADO', price = 0, category = 'muscle', type = 'automobile', shop = 'patreon' },
    { model = 'rh82', name = 'RH82 - Tier 3', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'tyrusgtr', name = 'Progen Tyrus GTR - Tier 3', brand = 'PROGEN', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 't20gtr', name = 'Progen T20 GTR - Tier 3', brand = 'PROGEN', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'gbcomets2rc', name = 'Pfister Comet S2 RC - Tier 3', brand = 'PFISTER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'tempestaes', name = 'Pegassi Tempesta ES - Tier 3', brand = 'PEGASSI', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'reagpr', name = 'Pegassi Rea GPR - Tier 3', brand = 'PEGASSI', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'tempesta2', name = 'Pegassi Tempesta Competizione - Tier 3', brand = 'PEGASSI', price = 0, category = 'super', type = 'automobile', shop = 'patreon' },
    { model = 'gst10f1', name = 'Obey 10F GST - Tier 3', brand = 'OBEY', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'hycsun', name = 'Maibatsu HYC Sunrise - Tier 3', brand = 'MAIBATSU', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'uniobepdb', name = 'Uniobep DB - Tier 3', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'kurumata', name = 'Karin Kurumata - Tier 3', brand = 'KARIN', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'jester3c', name = 'Dinka Jester 3C - Tier 3', brand = 'DINKA', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'gstnio2', name = 'GST NIO2 - Tier 3', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'italigtoc', name = 'Grotti Itali GTO Custom - Tier 3', brand = 'GROTTI', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'draftgpr', name = 'Draft GPR - Tier 3', brand = 'OTHER', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'SCSugoi', name = 'Dinka Sugoi RK8 - Tier 3', brand = 'DINKA', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'rapidgte', name = 'Dewbauchee Rapid GT E - Tier 3', brand = 'DEWBAUCHEE', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'coquette4c', name = 'Invetero Coquette 4C - Tier 3', brand = 'INVETERO', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'bansheeas', name = 'Bravado AS Banshee - Tier 3', brand = 'BRAVADO', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'schlagenstr', name = 'Benefactor Schlagen STR - Tier 3', brand = 'BENEFACTOR', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'scdtm', name = 'Benefactor SCDTM - Tier 3', brand = 'BENEFACTOR', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },
    { model = 'hycrh7', name = 'Annis Elegy RH7 HYCade - Tier 3', brand = 'ANNIS', price = 0, category = 'sports', type = 'automobile', shop = 'patreon' },

    -- ================================================================================
    -- TOWING VEHICLES (DL-Vanilla-Tow)
    -- ================================================================================
    	{ model = 'landstalker2tow', name = 'Landstalker Tow', brand = 'Dundreary', price = 180000, category = 'towtrucks', type = 'automobile', shop = 'offroad' },
	{ model = 'helliontow', name = 'Hellion Tow', brand = 'Annis', price = 160000, category = 'towtrucks', type = 'automobile', shop = 'offroad' },
	{ model = 'guardiantow', name = 'Guardian Tow', brand = 'Vapid', price = 200000, category = 'towtrucks', type = 'automobile', shop = 'offroad' },
	{ model = 'draftertow', name = 'Drafter Tow', brand = 'Obey', price = 170000, category = 'towtrucks', type = 'automobile', shop = 'offroad' },
	{ model = 'ballertow', name = 'Baller Tow', brand = 'Gallivanter', price = 190000, category = 'towtrucks', type = 'automobile', shop = 'offroad' },

    -- ================================================================================
    -- TRAILERS (DL-Trailers-15)
    -- ================================================================================
    { model = 'dlts7', name = 'DL Trailer S7', brand = 'DL Trailers', price = 120000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dlts6', name = 'DL Trailer S6', brand = 'DL Trailers', price = 110000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dlts5', name = 'DL Trailer S5', brand = 'DL Trailers', price = 100000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dlts4', name = 'DL Trailer S4', brand = 'DL Trailers', price = 95000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dlts3', name = 'DL Trailer S3', brand = 'DL Trailers', price = 90000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dlts2', name = 'DL Trailer S2', brand = 'DL Trailers', price = 85000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dltm', name = 'DL Trailer M', brand = 'DL Trailers', price = 75000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dltenc4', name = 'DL Trailer ENC4', brand = 'DL Trailers', price = 140000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dltenc3', name = 'DL Trailer ENC3', brand = 'DL Trailers', price = 130000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dltenc2', name = 'DL Trailer ENC2', brand = 'DL Trailers', price = 120000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dltenc', name = 'DL Trailer ENC', brand = 'DL Trailers', price = 110000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dltboat2', name = 'DL Boat Trailer 2', brand = 'DL Trailers', price = 85000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dltboat', name = 'DL Boat Trailer', brand = 'DL Trailers', price = 80000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dltb4', name = 'DL Trailer B4', brand = 'DL Trailers', price = 95000, category = 'trailers', type = 'trailer', shop = 'offroad' },
    { model = 'dltb2', name = 'DL Trailer B2', brand = 'DL Trailers', price = 90000, category = 'trailers', type = 'trailer', shop = 'offroad' },

    -- ================================================================================
    -- BOOSTING VEHICLES - ORGANIZED BY CLASS
    -- ================================================================================
    
    -- ========================================
    -- CLASS D - ENTRY LEVEL BOOSTING
    -- ========================================
    { model = '1500ghoul', name = '1500ghoul', brand = 'UNKNOWN', price = 80000, category = 'sedans', type = 'automobile', shop = 'boosting' },
    { model = 'asbo', name = 'Asbo', brand = 'Dinka', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },
    { model = 'blista', name = 'Blista', brand = 'Dinka', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },
    { model = 'brioso', name = 'Brioso R/A', brand = 'Grotti', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },
    { model = 'club', name = 'Club', brand = 'Brinte', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },
    { model = 'dilettante', name = 'Dilettante', brand = 'Karin', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },
    { model = 'issi2', name = 'Issi', brand = 'Weeny', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },
    { model = 'kanjo', name = 'Blista Kanjo', brand = 'Dinka', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },
    { model = 'panto', name = 'Panto', brand = 'Benefactor', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },
    { model = 'prairie', name = 'Prairie', brand = 'Bollokan', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },
    { model = 'rhapsody', name = 'Rhapsody', brand = 'Declasse', price = 60000, category = 'compacts', type = 'automobile', shop = 'boosting' },

    -- ========================================
    -- CLASS C - STANDARD BOOSTING
    -- ========================================
    { model = 'asea', name = 'Asea', brand = 'Declasse', price = 80000, category = 'sedans', type = 'automobile', shop = 'boosting' },
    { model = 'asterope', name = 'Asterope', brand = 'Karin', price = 80000, category = 'sedans', type = 'automobile', shop = 'boosting' },
    { model = 'cavalcade', name = 'Cavalcade SUV', brand = 'Albany', price = 100000, category = 'suvs', type = 'automobile', shop = 'boosting' },
    { model = 'cog55', name = 'Cognoscenti 55', brand = 'Enus', price = 80000, category = 'sedans', type = 'automobile', shop = 'boosting' },
    { model = 'emperor', name = 'Emperor', brand = 'Albany', price = 80000, category = 'sedans', type = 'automobile', shop = 'boosting' },
    { model = 'fugitive', name = 'Fugitive', brand = 'Cheval', price = 80000, category = 'sedans', type = 'automobile', shop = 'boosting' },
    { model = 'glendale', name = 'Glendale', brand = 'Benefactor', price = 80000, category = 'sedans', type = 'automobile', shop = 'boosting' },
    { model = 'granger', name = 'Granger SUV', brand = 'Declasse', price = 100000, category = 'suvs', type = 'automobile', shop = 'boosting' },
    { model = 'intruder', name = 'Intruder', brand = 'Karin', price = 80000, category = 'sedans', type = 'automobile', shop = 'boosting' },
    { model = 'stanier', name = 'Stanier', brand = 'Vapid', price = 80000, category = 'sedans', type = 'automobile', shop = 'boosting' },

    -- ========================================
    -- CLASS B - ADVANCED BOOSTING
    -- ========================================
    { model = 'alpha', name = 'Alpha', brand = 'Albany', price = 200000, category = 'sports', type = 'automobile', shop = 'boosting' },
    { model = 'banshee', name = 'Banshee Sports', brand = 'Bravado', price = 200000, category = 'sports', type = 'automobile', shop = 'boosting' },
    { model = 'bestiagts', name = 'Bestia GTS Sports', brand = 'Grotti', price = 200000, category = 'sports', type = 'automobile', shop = 'boosting' },
    { model = 'buffalo', name = 'Buffalo Sports', brand = 'Bravado', price = 200000, category = 'sports', type = 'automobile', shop = 'boosting' },
    { model = 'calico', name = 'Calico GTF Sports', brand = 'Karin', price = 200000, category = 'sports', type = 'automobile', shop = 'boosting' },
    { model = 'carbonizzare', name = 'Carbonizzare Sports', brand = 'Grotti', price = 200000, category = 'sports', type = 'automobile', shop = 'boosting' },
    { model = 'comet2', name = 'Comet Sports', brand = 'Pfister', price = 300000, category = 'sports', type = 'automobile', shop = 'boosting' },
    { model = 'coquette', name = 'Coquette Sports', brand = 'Invetero', price = 200000, category = 'sports', type = 'automobile', shop = 'boosting' },
    { model = 'corsita', name = 'Corsita Sports', brand = 'Lampadati', price = 200000, category = 'sports', type = 'automobile', shop = 'boosting' },
    { model = 'coureur', name = 'La Coureuse Sports', brand = 'Penaud', price = 200000, category = 'sports', type = 'automobile', shop = 'boosting' },

    -- ========================================
    -- CLASS A - EXPERT BOOSTING
    -- ========================================
    { model = 'adder', name = 'Adder', brand = 'Truffade', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'autarch', name = 'Autarch', brand = 'Överflöd', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'banshee2', name = 'Banshee 900R', brand = 'Bravado', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'bullet', name = 'Bullet', brand = 'Vapid', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'cheetah', name = 'Cheetah', brand = 'Grotti', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'cyclone', name = 'Cyclone', brand = 'Coil', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'deveste', name = 'Deveste Eight', brand = 'Deveste', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'entity2', name = 'Entity XXR', brand = 'Överflöd', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'entityxf', name = 'Entity XF', brand = 'Överflöd', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'fmj', name = 'FMJ', brand = 'Vapid', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },

    -- ========================================
    -- CLASS S - MASTER BOOSTING
    -- ========================================
    { model = 'emerus', name = 'Emerus', brand = 'Progen', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'furia', name = 'Furia', brand = 'Grotti', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'gp1', name = 'GP1', brand = 'Progen', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'ignus', name = 'Ignus', brand = 'Pegassi', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'infernus', name = 'Infernus', brand = 'Pegassi', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'italigtb', name = 'Itali GTB', brand = 'Progen', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'krieger', name = 'Krieger', brand = 'Benefactor', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'le7b', name = 'RE-7B', brand = 'Annis', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'nero', name = 'Nero', brand = 'Truffade', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'osiris', name = 'Osiris', brand = 'Pegassi', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'penetrator', name = 'Penetrator', brand = 'Ocelot', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'pfister811', name = '811', brand = 'Pfister', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'prototipo', name = 'X80 Proto', brand = 'Grotti', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'reaper', name = 'Reaper', brand = 'Pegassi', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 's80', name = 'S80RR', brand = 'Annis', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'sc1', name = 'SC1', brand = 'Übermacht', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'sheava', name = 'ETR1', brand = 'Emperor', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'sultanrs', name = 'Sultan RS', brand = 'Karin', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 't20', name = 'T20', brand = 'Progen', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'taipan', name = 'Taipan', brand = 'Cheval', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'tempesta', name = 'Tempesta', brand = 'Pegassi', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'tezeract', name = 'Tezeract', brand = 'Pegassi', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'thrax', name = 'Thrax', brand = 'Truffade', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'tigon', name = 'Tigon', brand = 'Lampadati', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'turismor', name = 'Turismo R', brand = 'Grotti', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'tyrus', name = 'Tyrus', brand = 'Progen', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'vacca', name = 'Vacca', brand = 'Pegassi', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'vagner', name = 'Vagner', brand = 'Dewbauchee', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'visione', name = 'Visione', brand = 'Grotti', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'voltic', name = 'Voltic', brand = 'Coil', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'xa21', name = 'XA-21', brand = 'Ocelot', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'zentorno', name = 'Zentorno', brand = 'Pegassi', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'zorrusso', name = 'Zorrusso', brand = 'Pegassi', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'entity3', name = 'Entity MT', brand = 'Överflöd', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'italigtb2', name = 'Itali GTB Custom', brand = 'Progen', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'lm87', name = 'LM87', brand = 'Progen', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'torero2', name = 'Torero XO', brand = 'Pegassi', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'turismo3', name = 'Turismo Omaggio', brand = 'Grotti', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'tyrant', name = 'Tyrant', brand = 'Överflöd', price = 350000, category = 'super', type = 'automobile', shop = 'boosting' },
    { model = 'zeno', name = 'Zeno', brand = 'Överflöd', price = 400000, category = 'super', type = 'automobile', shop = 'boosting' },

    -- ========================================
    -- FOLDER: [cars]/[government]/ems
    -- VEHICLES: EMS Government Vehicles
    -- ========================================
    { model = 'ambuimp', name = 'Ambulance Impala', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'dlamb', name = 'DL Ambulance', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'dlbuffalo', name = 'DL Buffalo EMS', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'dlemsb', name = 'EMS Bike', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'dlgranger', name = 'DL Granger EMS', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'dlissiamb', name = 'DL Issi Ambulance', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'dlswift', name = 'DL Swift Helicopter', brand = 'AUGUSTW', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'emsnspeedo', name = 'EMS Speedo Van', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'emsscoutmk', name = 'EMS Vapid', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'dlwheelchair', name = 'DL Wheelchair Accessible', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'fireeng', name = 'MTL Fire Engine', brand = 'MTL', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'fireengb', name = 'MTL Fire Engine B', brand = 'MTL', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'nsandbrush4', name = 'NS Sandbrush 4x4', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },
    { model = 'nsandbrush6', name = 'NS Sandbrush 6x6', brand = 'GOVERNMENT', price = 0, category = 'ems', type = 'automobile', shop = 'government' },

    -- ========================================
    -- FOLDER: [cars]/[government]/police & police-vanilla
    -- VEHICLES: Police Government Vehicles
    -- ========================================
    { model = '909_ch53', name = 'Sikorsky CH-53 Sea Stallion', brand = 'SIKORSKY', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'candimodstrailer', name = 'PD Trailer', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'mh6', name = 'Hughes MH-6 Little Bird', brand = 'HUGHES', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'ah6', name = 'Hughes AH-6 Little Bird', brand = 'HUGHES', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'pd_heli', name = 'PD Big Heli', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'polbike', name = 'PD Bicycle', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'polboat1', name = 'Police Patrol Boat', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'hillboaty', name = 'Police Hill Boat', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'largeboat', name = 'Police Large Boat', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'polboat2', name = 'Police Interceptor Boat', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'polcoach', name = 'PD Coach', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'USMSWashington', name = 'USMS Washington', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'USMSRumpo', name = 'USMS Rumpo', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'policegcrb', name = 'PD Golf Cart', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'polsentinel', name = 'PD Sentinel', brand = 'UBERMACHT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'riothuey', name = 'Bell UH-1 Iroquois', brand = 'BELL', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'rrseminalhawkxz', name = 'Bell 407 Seminal Hawk', brand = 'BELL', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'rsheli', name = 'PD Highspeed', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'segway', name = 'PD Segway', brand = 'SEGWAY', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'segwayciv', name = 'Police Civilian Segway', brand = 'SEGWAY', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'BearcatRBstairs', name = 'Lenco Bearcat RB Stairs', brand = 'LENCO', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'mraprb', name = 'SWAT 6x6', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'gurkharb', name = 'SWAT ADV Bearcat', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'jetskirb', name = 'Police Jet Ski RB', brand = 'SEA-DOO', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'rookrb', name = 'SWAT Rook', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'swatcarrier', name = 'SWAT Carrier', brand = 'SWAT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'Prisonvan3rb', name = 'PD Transport Van', brand = 'GOVERNMENT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'vanillaschlagen', name = 'Police Schafter', brand = 'BRAVADO', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'vd_pamira', name = 'Police Pamira', brand = 'PEGASSI', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlballer7', name = 'PD Gallivanster', brand = 'GALLIVAN', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlballer8', name = 'PD Discover', brand = 'GALLIVAN', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlbuffalo4', name = 'PD Bravado', brand = 'BRAVADO', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlcade3', name = 'PD Escalade', brand = 'ALBANY', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlcara', name = 'PD 6x6', brand = 'VAPID', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlcinq', name = 'PD Lampadati', brand = 'LAMPADA', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlcomet6', name = 'PD Comet', brand = 'PFISTER', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlcomni', name = 'PD Electric', brand = 'OBEY', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlcont', name = 'PD Contender', brand = 'VAPID', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlgranger2', name = 'PD Granger', brand = 'DECLASSE', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dljugular', name = 'PD Jugular', brand = 'OCELOT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlkomoda', name = 'PD Komoda', brand = 'LAMPADATI', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlmanch', name = 'PD Motocross Bike', brand = 'MAIBATSU', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dloutlaw', name = 'PD Buggy', brand = 'NAGASAKI', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlpanto', name = 'PD Panto', brand = 'BENEFACTOR', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlrhine', name = 'PD Wagon', brand = 'UBERMACHT', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlshin', name = 'PD Superbike', brand = 'NAGASAKI', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlstalker2', name = 'PD Landstalker', brand = 'DUNDREAR', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dltenf2', name = 'PD 10F', brand = 'OBEY', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlturismo3', name = 'PD Grotti', brand = 'GROTTI', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlvigero2', name = 'PD Vigero', brand = 'DECLASSE', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },
    { model = 'dlvstr', name = 'PD Cadi', brand = 'ALBANY', price = 0, category = 'emergency', type = 'automobile', shop = 'government' },

    -- ========================================
    -- FOLDER: Events - Formula One Racing
    -- VEHICLES: Formula One Open Wheel Cars
    -- ========================================
    { model = 'formula', name = 'PR4', brand = 'PR4', price = 0, category = 'FormulaOne', type = 'automobile', shop = 'events' },
    { model = 'formula2', name = 'R88', brand = 'R88', price = 0, category = 'FormulaOne', type = 'automobile', shop = 'events' },
    { model = 'openwheel1', name = 'BR8', brand = 'BR8', price = 0, category = 'FormulaOne', type = 'automobile', shop = 'events' },
    { model = 'openwheel2', name = 'DR1', brand = 'DR1', price = 0, category = 'FormulaOne', type = 'automobile', shop = 'events' },

}

-- Convert the array format to proper key-value format
for i = 1, #Vehicles do
    QBShared.Vehicles[Vehicles[i].model] = {
        spawncode = Vehicles[i].model,
        name = Vehicles[i].name,
        brand = Vehicles[i].brand,
        model = Vehicles[i].model,
        price = Vehicles[i].price,
        category = Vehicles[i].category,
        hash = joaat(Vehicles[i].model),
        type = Vehicles[i].type,
        shop = Vehicles[i].shop
    }
end

return QBShared.Vehicles
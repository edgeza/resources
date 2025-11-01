Config = {}
Config.Keys={['ESC']=322,['F1']=288,['F2']=289,['F3']=170,['F5']=166,['F6']=167,['F7']=168,['F8']=169,['F9']=56,['F10']=57,['~']=243,['1']=157,['2']=158,['3']=160,['4']=164,['5']=165,['6']=159,['7']=161,['8']=162,['9']=163,['-']=84,['=']=83,['BACKSPACE']=177,['TAB']=37,['Q']=44,['W']=32,['E']=38,['R']=45,['T']=245,['Y']=246,['U']=303,['P']=199,['[']=39,[']']=40,['ENTER']=18,['CAPS']=137,['A']=34,['S']=8,['D']=9,['F']=23,['G']=47,['H']=74,['K']=311,['L']=182,['LEFTSHIFT']=21,['Z']=20,['X']=73,['C']=26,['V']=0,['B']=29,['N']=249,['M']=244,[',']=82,['.']=81,['LEFTCTRL']=36,['LEFTALT']=19,['SPACE']=22,['RIGHTCTRL']=70,['HOME']=213,['PAGEUP']=10,['PAGEDOWN']=11,['DELETE']=178,['LEFTARROW']=174,['RIGHTARROW']=175,['TOP']=27,['DOWNARROW']=173,['NENTER']=201,['N4']=108,['N5']=60,['N6']=107,['N+']=96,['N-']=97,['N7']=117,['N8']=61,['N9']=118,['UPARROW']=172,['INSERT']=121}
function L(cd) if Locales[Config.Language][cd] then return Locales[Config.Language][cd] else print('Locale is nil ('..cd..')') end end


--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


--WHAT DOES 'auto_detect' DO?
--The 'auto_detect' feature automatically identifies your framework and SQL database resource, and applies the appropriate default settings.

Config.Framework = 'auto_detect' --[ 'auto_detect' / 'other' ]   If you select 'auto_detect', only ESX and QBCore frameworks will be detected. Use 'other' for custom frameworks.
Config.Database = 'auto_detect' --[ 'auto_detect' ]   If you select 'auto_detect', only MySQL, GHMattimysql, and Oxmysql SQL database resources will be detected.
Config.AutoInsertSQL = true --Would you like the script to insert the necessary SQL tables into your database automatically? If you have already done this, please set it to false.
Config.Notification = 'other' --[ 'auto_detect' / 'other' ]   If you select 'auto_detect', only ESX, QBCore, okokNotify, ps-ui and ox_lib notifications will be detected. Use 'other' for custom notification resources.
Config.Language = 'EN' --[ 'EN' / 'CZ' / 'DE' / 'DK' / 'ES' / 'FI' / 'FR' / 'NO' / 'NL' / 'PT' / 'SE' / 'SK' ]   You can add your own locales to locales.lua, but be sure to update the Config.Language to match it.

Config.FrameworkTriggers = {
    esx = { --If you have modified the default event names in the es_extended resource, change them here.
        resource_name = 'es_extended',
        main = 'esx:getSharedObject',
        load = 'esx:playerLoaded',
        job = 'esx:setJob'
    },
    qbcore = { --If you have modified the default event names in the qb-core resource, change them here.
        resource_name = 'qb-core',
        main = 'QBCore:GetObject',
        load = 'QBCore:Client:OnPlayerLoaded',
        job = 'QBCore:Client:OnJobUpdate',
        gang = 'QBCore:Client:OnGangUpdate',
        duty = 'QBCore:Client:SetDuty'
    }
}


--██╗███╗   ███╗██████╗  ██████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗████████╗
--██║████╗ ████║██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║╚══██╔══╝
--██║██╔████╔██║██████╔╝██║   ██║██████╔╝   ██║   ███████║██╔██╗ ██║   ██║   
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║   ██║   
--██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║██║ ╚████║   ██║   
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝


Config.PlateFormats = 'mixed' --[ 'trimmed' /  'with_spaces' / 'mixed' ] CHOOSE CAREFULLY! Read our documentation website for more info on this if you are unsure! [https://docs.codesign.pro/paid-scripts/garage#step-6-vehicle-plate-format].
Config.UsingOnesync = true --Do you use OneSync legacy/infinity?
Config.IdentifierType = 'license' --[ 'steamid' / 'license' ] Choose the identifier type that your server uses.
Config.UseFrameworkDutySystem = false --Do you want to use your frameworks (esx/qbcore) built-in duty system?
Config.Debug = false --To enable debug prints.


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


Config.Keys = {
    QuickChoose_Key = Config.Keys['E'], --The key to open the quick garage (default E).
    EnterGarage_Key = Config.Keys['H'], --The key to open the inside garage (default H).
    StoreVehicle_Key = Config.Keys['G'], --The key to store your vehicle (default G).
    StartHotwire_Key = Config.Keys['E'] --The key to start hotwiring a vehicle (default E).
}

Config.UniqueGarages = true --Do you want to only be able to get your car from the garage you last put it in?
Config.SaveAdvancedVehicleDamage = true --Do you want to save poped tyres, broken doors and broken windows and re-apply them all when spawning a vehicle?
Config.UseExploitProtection = false --Do you want to enable the cheat engine protection to check the vehicle hashes when a vehicle is stored?
Config.ResetGarageState = true --Do you want the in_garage state of all vehicles to be reset when the script starts/restarts?


--██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗███████╗    ██████╗  █████╗ ████████╗ █████╗ 
--██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝██╔════╝    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
--██║   ██║█████╗  ███████║██║██║     ██║     █████╗  ███████╗    ██║  ██║███████║   ██║   ███████║
--╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  ╚════██║    ██║  ██║██╔══██║   ██║   ██╔══██║
-- ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗███████║    ██████╔╝██║  ██║   ██║   ██║  ██║
--  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝


Config.VehiclesData = {
    ENABLE = true, --Do you want to allow the script to grab vehicles data ( ESX: from the 'vehicles' table in the database / QBCORE: from the shared.lua ).
    -- Read our documentation website for more info - https://docs.codesign.pro/paid-scripts/garage#vehicles-data.
    --This will be force enabled (at the bottom of this file) if you use QBCore.

    Vehicledatabase_Tablenames = { --FOR ESX ONLY. The 'vehicles' database table is common in esx servers, but we will repurpose this to store information for us to use on the garage UI's.
        [1] = 'vehicles', --As some people use multiple vehicles tables for donator vehicles, emergency vehicles etc, extra tables are optional for those people.
        --[2] = 'vehicles2',
        --[3] = 'add_more_here',
    },
}

Config.GarageTax = {
    ENABLE = false, --Do you want to enable the vehicle tax system? (each vehicle will be taxed 1 time per server restart).
    method = 'default', --[ 'default' / 'vehicles_data' ] Read below for more info on each on these 2 options.
    default_price = 1000, --If 'default' method is chosen, then it will be a set price to return any vehicle. (eg., $500 fee).
    vehiclesdata_price_multiplier = 1 --If 'vehicles_data' method is chosen, the return vehicle price will be a % of the vehcles value. (eg., 1% of a $50,000 car would be a $500 fee).
}

Config.Return_Vehicle = { --This is the price players pay for their vehicle to be returned to their garage if it has despawned or been blown up.
    ENABLE = true, --Do you want to allow players to return their vehicle if they are destroyed or despawned?
    method = 'default', --[ 'default' / 'vehicles_data' ] Read below for more info on each on these 2 options.
    default_price = 500, --If 'default' method is chosen, then it will be a set price to return any vehicle. (eg., $500 fee).
    vehiclesdata_price_multiplier = 1 --If 'vehicles_data' method is chosen, the return vehicle price will be a % of the vehcles value. (eg., 1% of a $50,000 car would be a $500 fee).
}


--██╗███╗   ███╗██████╗  ██████╗ ██╗   ██╗███╗   ██╗██████╗ 
--██║████╗ ████║██╔══██╗██╔═══██╗██║   ██║████╗  ██║██╔══██╗
--██║██╔████╔██║██████╔╝██║   ██║██║   ██║██╔██╗ ██║██║  ██║
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██║   ██║██║╚██╗██║██║  ██║
--██║██║ ╚═╝ ██║██║     ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝ 


Config.Impound = {
    ENABLE = true, --Do you want to use the built in impound system?
    chat_command = 'impound', --Customise the chat command to impound vehicles.

    Authorized_Jobs = { --Only jobs inside this table can impound vehicles or unimpound vehicles.
        ['police'] = true,
        ['bcso'] = true,
        ['towing'] = true,
        --['add_more_here'] = true,
    },

    Impound_Fee = { --This is the price players pay for their vehicle to be unimpounded.
        method = 'default', --[ 'default' / 'vehicles_data' ] Read below for more info on each of these 2 options. (Config.VehiclesData.ENABLE must be enabled if you want to use 'vehicles_data').
        default_price = 2000, --If 'default' method is chosen, then it will be a set price to unimpounded any vehicle. (eg., $1000 fee).
        vehiclesdata_price_multiplier = 1 --If 'vehicles_data' method is chosen, the unimpounded vehicle price will be a % of the vehcles value. (eg., 1% of a $50,000 car would be a $500 fee).
    }
}


--████████╗██████╗  █████╗ ███╗   ██╗███████╗███████╗███████╗██████╗     ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗
--╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██╔════╝██╔════╝██╔══██╗    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝
--   ██║   ██████╔╝███████║██╔██╗ ██║███████╗█████╗  █████╗  ██████╔╝    ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  
--   ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██╔══╝  ██╔══╝  ██╔══██╗    ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  
--   ██║   ██║  ██║██║  ██║██║ ╚████║███████║██║     ███████╗██║  ██║     ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗
--   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝      ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝


Config.TransferVehicle = {
    ENABLE = true, --Do you want to use the built features to transfer vehicles to another player?
    chat_command = 'transfervehicle', --Customise the chat command to transfer vehicles.

    Transfer_Blacklist = { --Vehicles inside this table will not be able to be transfered to another player. Use the vehicles spawn name. eg., `adder`.
        [`dump`] = true,
        -- Patreon vehicles (blacklist from transfers)
        
        -- TIER 1 PATREON CARS
        [`sc_dominatorwb`] = true,
        [`vacca2`] = true,
        [`sentinel_rts`] = true,
        [`gp1wb`] = true,
        [`gb811s2`] = true,
        [`cometrr`] = true,
        [`zentornoc`] = true,
        [`severowb`] = true,
        [`srspback`] = true,
        [`mk2vigerozx`] = true,
        [`komodafr`] = true,
        [`sultanrsv8`] = true,
        [`boorbc`] = true,
        [`z190wb`] = true,
        [`gstarg2`] = true,
        [`furiawb`] = true,
        [`gbmogulrs`] = true,
        [`jestgpr`] = true,
        [`hoonie`] = true,
        [`cypherct`] = true,
        [`coquettewb`] = true,
        [`contenderc`] = true,
        [`clubta`] = true,
        [`h4rwindsor`] = true,
        [`gbclubxr`] = true,
        [`zr350wb`] = true,
        [`300rwb`] = true,
        [`schwartzer6str`] = true,
        
        -- TIER 2 PATREON CARS
        [`playboy`] = true,
        [`domttc`] = true,
        [`vacca3`] = true,
        [`ziongtc`] = true,
        [`sdmonsterslayer`] = true,
        [`exr`] = true,
        [`comets2`] = true,
        [`zentorno2`] = true,
        [`fcomneisgt25`] = true,
        [`audace`] = true,
        [`sddriftvet`] = true,
        [`hotkniferod`] = true,
        [`vertice`] = true,
        [`gstjc2`] = true,
        [`turisrr`] = true,
        [`turismo2lm`] = true,
        [`italigts`] = true,
        [`gbsultrsx`] = true,
        [`gbmojave`] = true,
        [`jesterwb`] = true,
        [`jester4wb`] = true,
        [`rt3000wb`] = true,
        [`vigerozxwb`] = true,
        [`gstghell1`] = true,
        [`elytron`] = true,
        [`hrgt6r`] = true,
        [`remuswb`] = true,
        [`yosemite6str`] = true,
        
        -- TIER 3 PATREON CARS
        [`vd_tenfrally`] = true,
        [`vanz23m2wb`] = true,
        [`uniobepdb`] = true,
        [`thraxs`] = true,
        [`sunriser`] = true,
        [`sentineldm`] = true,
        [`sagauntletstreet`] = true,
        [`rh82`] = true,
        [`tyrusgtr`] = true,
        [`t20gtr`] = true,
        [`gbcomets2rc`] = true,
        [`tempestaes`] = true,
        [`reagpr`] = true,
        [`tempestacomp`] = true,
        [`gst10f1`] = true,
        [`hycsunrise`] = true,
        [`kurumata`] = true,
        [`jester3c`] = true,
        [`gstnio2`] = true,
        [`italigtoc`] = true,
        [`draftgpr`] = true,
        [`sugoi_rk8`] = true,
        [`rapidgte`] = true,
        [`coquette4c`] = true,
        [`as_banshee`] = true,
        [`schlagenstr`] = true,
        [`scdtm`] = true,
        [`hycrh7`] = true,
    }
}


--████████╗██████╗  █████╗ ███╗   ██╗███████╗███████╗███████╗██████╗      ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗
--╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██╔════╝██╔════╝██╔══██╗    ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝
--   ██║   ██████╔╝███████║██╔██╗ ██║███████╗█████╗  █████╗  ██████╔╝    ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  
--   ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║██╔══╝  ██╔══╝  ██╔══██╗    ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  
--   ██║   ██║  ██║██║  ██║██║ ╚████║███████║██║     ███████╗██║  ██║    ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗
--   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝


Config.TransferGarage = {
    ENABLE = true, --Do you want to allow players to pay for their vehicles to be transferred to another garage?
    transfer_fee = 500 --The cost per vehicle garage transfer ^.
}


--██████╗ ██████╗ ██╗██╗   ██╗ █████╗ ████████╗███████╗     ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗███████╗
--██╔══██╗██╔══██╗██║██║   ██║██╔══██╗╚══██╔══╝██╔════╝    ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝
--██████╔╝██████╔╝██║██║   ██║███████║   ██║   █████╗      ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  ███████╗
--██╔═══╝ ██╔══██╗██║╚██╗ ██╔╝██╔══██║   ██║   ██╔══╝      ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  ╚════██║
--██║     ██║  ██║██║ ╚████╔╝ ██║  ██║   ██║   ███████╗    ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗███████║
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝  ╚═╝   ╚═╝   ╚══════╝     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝


Config.PrivateGarages = {
    ENABLE = false, --Do you want to use the built private garages?
    create_chat_command = 'privategarage', --Customise the chat command to create a private garage to sell to a player.
    delete_chat_command = 'privategaragedelete', --Customise the chat command to delete a players private garage.

    Authorized_Jobs = { --Only jobs inside this table can use the command above.
        ['realestate'] = true,
        --['add_more_here'] = true,
    }
}


--██████╗ ██████╗  ██████╗ ██████╗ ███████╗██████╗ ████████╗██╗   ██╗     ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗███████╗
--██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██╔════╝██╔══██╗╚══██╔══╝╚██╗ ██╔╝    ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝██╔════╝
--██████╔╝██████╔╝██║   ██║██████╔╝█████╗  ██████╔╝   ██║    ╚████╔╝     ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  ███████╗
--██╔═══╝ ██╔══██╗██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗   ██║     ╚██╔╝      ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  ╚════██║
--██║     ██║  ██║╚██████╔╝██║     ███████╗██║  ██║   ██║      ██║       ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗███████║
--╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝      ╚═╝        ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝


Config.PropertyGarages = {
    ENABLE = true, --Do you want to use built in property garages?
    only_showcars_inpropertygarage = false --Do you want the inside garage to only show the vehicles which are currently stored in a property garage. (this works for inside garage only, even with this enabled all the cars will show in the outside UI).
}


--███████╗ █████╗ ██╗  ██╗███████╗    ██████╗ ██╗      █████╗ ████████╗███████╗███████╗
--██╔════╝██╔══██╗██║ ██╔╝██╔════╝    ██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝██╔════╝
--█████╗  ███████║█████╔╝ █████╗      ██████╔╝██║     ███████║   ██║   █████╗  ███████╗
--██╔══╝  ██╔══██║██╔═██╗ ██╔══╝      ██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝  ╚════██║
--██║     ██║  ██║██║  ██╗███████╗    ██║     ███████╗██║  ██║   ██║   ███████╗███████║
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝


Config.FakePlates = {
    ENABLE = false, --Do you want to use the built in fake plate system?
    item_name = 'fakeplate', --The name of the usable item to add a fake plate.

    RemovePlate = {
        chat_command = 'removefakeplate', --Customise the chat command to remove a fake plate from a vehicle.
        allowed_jobs = {
            ENABLE = false, --Do you want to allow certain jobs to remove a fake plate? (the vehicles owner will always be able to remove plates).
            table = { --The list of jobs who can remove a fake plate.
                ['police'] = true,
                --['add_more_here'] = true,
            }
        }
    }
}


--██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗    ██╗  ██╗███████╗██╗   ██╗███████╗
--██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝    ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
--██║   ██║█████╗  ███████║██║██║     ██║     █████╗      █████╔╝ █████╗   ╚████╔╝ ███████╗
--╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝      ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
-- ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗    ██║  ██╗███████╗   ██║   ███████║
--  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝    ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝


Config.VehicleKeys = {
    ENABLE = false, --Do you want to use the built in vehicle keys system?
    allow_shared_vehicles = false, --If this is enabled, when you give another player a "saved" key to one of your vehicles, it will allow them to spawn your vehicles from their garage.

    Commands = {
        temporary_key = 'givekey', --These keys will be deleted on script/server restart (but keys will save if you relog).
        database_key = 'givekeysave', --These keys will be saved in the database meaning even after script/server restart the player will still have these keys.
        remove_key = 'removekey' --Remove temporary and database keys from a player.
    },

    Hotwire = {
        ENABLE = true, --Do you want players to only be able to drive vehicles they have the keys for?

        --seconds: (1-10) How many seconds it takes for the bar to reach from 1 side to the other. (less is faster).
        --size: (10-100) How wide the target bar is. (100 is widest and easiest to hit).
        --chances: How many chances you have on each action bar. (1 means if you fail the first time it cancels, 2 means if you fail the first and second time it cancels).
        ActionBar = {
            [1] = {seconds = 6, size = 30, chances = 3}, --Choose how many seperate action bars you will need to complete to hotwire a vehicle you do not have keys for.
            [2] = {seconds = 3, size = 20, chances = 2},
            [3] = {seconds = 2, size = 10, chances = 1}, --This is the 3rd action bar.
            --[4] = {seconds = 1, size = 10, chances = 1},
        }
    },

    Lock = {
        ENABLE = true, --Do you want to use the vehicle locking system?
        lock_from_inside = true, --Do you want to also lock the vehicle from the inside when the vehicle is locked? (meaning when the vehicle is locked players can not exit).
        command = 'vehlock', --Customise the chat command.
        key = 'm' --Customise the key.
    },

    Lockpick = {
        ENABLE = true, --Do you want to use the vehicle lockpick system?
        command = { --Do you want players to use a chat command to start lockpicking a vehicle?
            ENABLE = true,
            chat_command = 'lockpick' --Customise the chat command.
        },
        usable_item = { --Do you want players to use a usable item to lockpick a vehicle?
            ENABLE = true,
            item_name = 'lockpick' --The name of the usable item to start lockpicking a vehicle.
        }
    },
}


--███╗   ███╗██╗██╗     ███████╗ █████╗  ██████╗ ███████╗
--████╗ ████║██║██║     ██╔════╝██╔══██╗██╔════╝ ██╔════╝
--██╔████╔██║██║██║     █████╗  ███████║██║  ███╗█████╗  
--██║╚██╔╝██║██║██║     ██╔══╝  ██╔══██║██║   ██║██╔══╝  
--██║ ╚═╝ ██║██║███████╗███████╗██║  ██║╚██████╔╝███████╗
--╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝


Config.Mileage = {
    ENABLE = true, --Do you want to use the built in vehicle mileage system? The higher the miles the lower the vehicles max health will be. (or you can repurpose this for any other use).
    chat_command = 'checkmiles', --Customise the chat command to check your vehicles miles and max health.
    mileage_multiplier = 1.0, --If you increase this number it will increase how fast vehicles gain miles. (decrease to lower).
    speed_metrics = 'kilometers', --(miles/kilometers) Choose what you want the mileage to display as.
    show_maxhealth = false --Do you want to show the max health of the vehicle you are in when you use the /checkmiles command?
}


-- ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗    ███████╗██████╗  █████╗  ██████╗███████╗
--██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝    ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝
--██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗      ███████╗██████╔╝███████║██║     █████╗  
--██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝      ╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝  
--╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗    ███████║██║     ██║  ██║╚██████╗███████╗
-- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝


Config.GarageSpace = {
    ENABLE = false, --Do you want to limit the amount of cars each player can hold?
    chat_command_main = 'garagespace', --Customise the chat command to purchase extra garage space.
    chat_command_check = 'checkgaragespace', --Customise the chat command to check how many garage slots you have.

    Garagespace_Table = { --If Config.TransferGarage.ENABLE is enabled, this is the max amount of cars each player can own. To allow people to own more vehicles, add them to the table.
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0,
        [7] = 0,
        [8] = 25000,
        [9] = 50000,
        [10] = 75000,
        --[11] = 100000, --The number 11 would be the 11th garage slot, and the 100000 number would be the price for the 11th garage slot.
    },

    Authorized_Jobs = { --Only jobs inside this table can sell extra garage slots to players.
        ['cardealer'] = true,
        --['add_more_here'] = true,
    }
}


--██████╗ ███████╗██████╗ ███████╗██╗███████╗████████╗███████╗███╗   ██╗████████╗    ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗███████╗
--██╔══██╗██╔════╝██╔══██╗██╔════╝██║██╔════╝╚══██╔══╝██╔════╝████╗  ██║╚══██╔══╝    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝██╔════╝
--██████╔╝█████╗  ██████╔╝███████╗██║███████╗   ██║   █████╗  ██╔██╗ ██║   ██║       ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  ███████╗
--██╔═══╝ ██╔══╝  ██╔══██╗╚════██║██║╚════██║   ██║   ██╔══╝  ██║╚██╗██║   ██║       ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  ╚════██║
--██║     ███████╗██║  ██║███████║██║███████║   ██║   ███████╗██║ ╚████║   ██║        ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗███████║
--╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝   ╚═╝         ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝╚══════╝


Config.PersistentVehicles = { --Requires OneSync to use.
    ENABLE = true --Do you want to use the built-in persistent vehicle feature?
}


--██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗███╗   ███╗███████╗███╗   ██╗████████╗
--██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝
--██║   ██║█████╗  ███████║██║██║     ██║     █████╗      ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║   
--╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝      ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   
-- ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗    ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   


Config.StaffPerms = {
    ['add'] = {
        ENABLE = true, --Do you want to allow staff to add vehicles to a players garage?
        chat_command = 'vehicle-add', --Customise the chat commands.
        perms = {
            ['esx'] = {'superadmin', 'admin'}, --You decide which permission groups can use the staff commands.
            ['qbcore'] = {'god', 'admin'},
            ['other'] = {'change_me'}
        }
    },

    ['delete'] = {
        ENABLE = true, --Do you want to allow staff to delete vehicles from the database?
        chat_command = 'vehicle-delete',
        perms = {
            ['esx'] = {'superadmin', 'admin'},
            ['qbcore'] = {'god', 'admin'},
            ['other'] = {'change_me'}
        }
    },

    ['plate'] = {
        ENABLE = true, --Do you want to allow staff to change a vehicles plate?
        chat_command = 'vehicle-plate',
        perms = {
            ['esx'] = {'superadmin', 'admin'},
            ['qbcore'] = {'god', 'admin'},
            ['other'] = {'change_me'}
        }
    },

    ['keys'] = {
        ENABLE = true, --Do you want to allow staff to give theirself keys to a vehicle?
        chat_command = 'vehicle-keys',
        perms = {
            ['esx'] = {'superadmin', 'admin'},
            ['qbcore'] = {'god', 'admin'},
            ['other'] = {'change_me'}
        }
    }
}


--██╗███╗   ██╗███████╗██╗██████╗ ███████╗     ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗
--██║████╗  ██║██╔════╝██║██╔══██╗██╔════╝    ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝
--██║██╔██╗ ██║███████╗██║██║  ██║█████╗      ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  
--██║██║╚██╗██║╚════██║██║██║  ██║██╔══╝      ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  
--██║██║ ╚████║███████║██║██████╔╝███████╗    ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗
--╚═╝╚═╝  ╚═══╝╚══════╝╚═╝╚═════╝ ╚══════╝     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝


Config.InsideGarage = {
    ENABLE = true, --Do you want to allow players to use the inside garage?
    only_showcars_inthisgarage = false, --Do you want the inside garage to only show the vehicles which are currently stored at that garage (eg., garage A).  (this works for inside garage only, even with this enabled all the cars will show in the outside UI).
    shell_z_axis = 30, --This is how low under the ground the garage shell will spawn, you could use math.random(10,50) to make it random each time so players dont see each other in their garage.
    shell_time_script = 'easytime', --Choose which time script you are using so we can set the time when you enter the shell. [ 'easytime' / 'vsync' / 'qbcore' / 'other' ].
    engines_on = false, --Do you want the vehicles engine will be turned on when you enter the inside garage?
    lights_on = false, --Do you want the vehicles headlights will be turned on when you enter the inside garage?
    use_spotlight = true, --Do you want the spotlight to shine on the closest vehicle?
    
    Insidegarage_Blacklist = { --Vehicles inside this table will not be spawned inside the garage, this is used for large vehicles that will not fit.
        [`flatbed`] = true,
        --[`add_more_here`] = true,
    },

    Car_Offsets = { --This is the offsets of the vehicles inside the garage.
        ['10cargarage_shell'] = {
            [1] = {x = -4, y = 6.5, z = 0.0, h = 135.0},--1
            [2] = {x = -4, y = 10.8, z = 0.0, h = 135.0},--2
            [3] = {x = -4, y = 15.1, z = 0.0, h = 135.0},--3
            [4] = {x = -4, y = 19.4, z = 0.0, h = 135.0},--4
            [5] = {x = -4, y = 23.7, z = 0.0, h = 135.0},--5

            [6] = {x = -12, y = 23.7, z = 0.0, h = 225.0},--6
            [7] = {x = -12, y = 19.4, z = 0.0, h = 225.0},--7
            [8] = {x = -12, y = 15.1, z = 0.0, h = 225.0},--8
            [9] = {x = -12, y = 10.8, z = 0.0, h = 225.0},--9
            [10] = {x = -12, y = 6.5, z = 0.0, h = 225.0}--10
        },

        ['40cargarage_shell'] = {
            [1] = {x = 7.0, y = -7.0, z = 0.0, h = 352.0},--1
            [2] = {x = 11.0, y = -8.0, z = 0.0, h = 352.0},--2
            [3] = {x = 15.0, y = -9.0, z = 0.0, h = 352.0},--3
            [4] = {x = 19.0, y = -10.0, z = 0.0, h = 352.0},--4
            [5] = {x = 23.0, y = -11.0, z = 0.0, h = 352.0},--5
            [6] = {x = 27.0, y = -12.0, z = 0.0, h = 352.0},--6
            [7] = {x = 31.0, y = -13.0, z = 0.0, h = 352.0},--7
            [8] = {x = 35.0, y = -14.0, z = 0.0, h = 352.0},--8
            [9] = {x = 39.0, y = -15.0, z = 0.0, h = 352.0},--9
            [10] = {x = 43.0, y = -16.0, z = 0.0, h = 352.0},--10

            [11] = {x = 7.0, y = 5.0, z = 0.0, h = 162.0},--11
            [12] = {x = 11.0, y = 4.0, z = 0.0, h = 162.0},--12
            [13] = {x = 15.0, y = 3.0, z = 0.0, h = 162.0},--13
            [14] = {x = 19.0, y = 2.0, z = 0.0, h = 162.0},--14
            [15] = {x = 23.0, y = 1.0, z = 0.0, h = 162.0},--15
            [16] = {x = 27.0, y = 0.0, z = 0.0, h = 162.0},--16
            [17] = {x = 31.0, y = -1.0, z = 0.0, h = 162.0},--17
            [18] = {x = 35.0, y = -2.0, z = 0.0, h = 162.0},--18
            [19] = {x = 39.0, y = -3.0, z = 0.0, h = 162.0},--19
            [20] = {x = 43.0, y = -4.0, z = 0.0, h = 162.0},--20

            [21] = {x = -7.0, y = 5.0, z = 0.0, h = 192.0},--21
            [22] = {x = -11.0, y = 4.0, z = 0.0, h = 192.0},--22
            [23] = {x = -15.0, y = 3.0, z = 0.0, h = 192.0},--23
            [24] = {x = -19.0, y = 2.0, z = 0.0, h = 192.0},--24
            [25] = {x = -23.0, y = 1.0, z = 0.0, h = 192.0},--25
            [26] = {x = -27.0, y = 0.0, z = 0.0, h = 192.0},--26
            [27] = {x = -31.0, y = -1.0, z = 0.0, h = 192.0},--27
            [28] = {x = -35.0, y = -2.0, z = 0.0, h = 192.0},--28
            [29] = {x = -39.0, y = -3.0, z = 0.0, h = 192.0},--29
            [30] = {x = -43.0, y = -4.0, z = 0.0, h = 192.0},--30

            [31] = {x = -7.0, y = -7.0, z = 0.0, h = 13.0},--31
            [32] = {x = -11.0, y = -8.0, z = 0.0, h = 13.0},--32
            [33] = {x = -15.0, y = -9.0, z = 0.0, h = 13.0},--33
            [34] = {x = -19.0, y = -10.0, z = 0.0, h = 13.0},--34
            [35] = {x = -23.0, y = -11.0, z = 0.0, h = 13.0},--35
            [36] = {x = -27.0, y = -12.0, z = 0.0, h = 13.0},--36
            [37] = {x = -31.0, y = -13.0, z = 0.0, h = 13.0},--37
            [38] = {x = -35.0, y = -14.0, z = 0.0, h = 13.0},--38
            [39] = {x = -39.0, y = -15.0, z = 0.0, h = 13.0},--39
            [40] = {x = -43.0, y = -16.0, z = 0.0, h = 13.0},--40
        }
    }
}


--     ██╗ ██████╗ ██████╗     ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗███████╗
--     ██║██╔═══██╗██╔══██╗    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝██╔════╝
--     ██║██║   ██║██████╔╝    ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  ███████╗
--██   ██║██║   ██║██╔══██╗    ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  ╚════██║
--╚█████╔╝╚██████╔╝██████╔╝     ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗███████║
-- ╚════╝  ╚═════╝ ╚═════╝       ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝╚══════╝


Config.JobVehicles = {
    ENABLE = true, --Do you want players with defined jobs (below) to be able to use the garage ui to spawn job vehicles? (if disabled none of the options below will be used).
    choose_liverys = true, --Do you want players to be able to change liverys when they spawn a vehicle at a job garage?
    share_job_keys = false, --Do you want job vehicle keys to be automatically shared with other players with the same job? (requires you to be using the built in cd_garage keys feature).

    Locations = {
        --coords: Where the job garage can be accessed from.
        --spawn_coords: Where the chosen vehicle will spawn.
        --distance: If the player is within the 'distance' of these coords ^, they can open the job garage UI.
        --garage_type: The type of vehicles that can be accessed from this location.
        --method: There are 3 different methods you can use (all 3 are explained below).
        
            --'regular' = This will use the vehicles from the Config.JobVehicles.RegularMethod table below. These are spawned in vehicles and are not owned by anyone.
            --'personalowned' = This will use your personal job vehicles that you have purchased from the cardealer and only you can only access from your job spawn location. Vehicles in your owned_vehicles database table which have job_personalowned set to a players "job name" (not "job label") will be classed as personal owned job vehicles.
            --'societyowned' = This will use society owned vehicles. This will search for your job instead of your steam/license identifier in the owned_vehicles database table and allow you to use all of the vehicles your job owns.

        ['events'] = { --If you choose to add more tables here for more jobs, they must be the jobs name, not the label.
            [1] = {coords = vector3(4375.24, 7913.04, 90.12), spawn_coords = vector4(4421.56, 7860.93, 89.03, 329.85), distance = 10, garage_type = 'car', method = 'regular'},
        }, 
        ['police'] = { --If you choose to add more tables here for more jobs, they must be the jobs name, not the label.
            --MISSION ROW PD
            [1] = {coords = vec3(844.12, -1334.6, 26.1), spawn_coords = vec4(853.58, -1332.39, 26.12, 60.87), distance = 5, garage_type = 'car', method = 'regular'}, --Mission Row PD (cars)
            [2] = {coords = vec3(861.66, -1381.54, 26.14), spawn_coords = vec4(855.69, -1365.25, 26.11, 25.65), distance = 5, garage_type = 'air', method = 'regular'}, --Mission Row PD (helipad)
            --SANDY PD
            [3] = {coords = vector3(1868.33, 3686.05, 33.78), spawn_coords = vector4(1872.68, 3687.19, 33.65, 211.34), distance = 10, garage_type = 'car', method = 'regular'}, --Sandy PD (cars)
            [4] = {coords = vector3(1866.09, 3655.66, 33.9), spawn_coords = vector4(1866.09, 3655.66, 33.9, 27.07), distance = 5, garage_type = 'air', method = 'regular'}, --Sandy PD (helipad)
            --PALETO PD
            [5] = {coords = vector3(-472.83, 5969.7, 31.31), spawn_coords = vector4(-472.83, 5969.7, 31.31, 35.85), distance = 5, garage_type = 'car', method = 'regular'}, --Paleto PD (cars) 
            [6] = {coords = vector3(-455.51, 5999.89, 39.35), spawn_coords = vector4(-455.03, 5999.82, 39.35, 47.03), distance = 5, garage_type = 'air', method = 'regular'}, --Paleto PD (helipad)
            --BOATS
            [7] = {coords = vector3(-1598.49, -1201.4, 0.82), spawn_coords = vector4(-1609.96, -1210.83, -0.03, 134.45), distance = 20, garage_type = 'boat', method = 'regular'}, --Vespucci Beach (boats)
            [8] = {coords = vector3(1426.31, 3750.12, 31.76), spawn_coords = vector4(1430.37, 3771.52, 29.86, 336.36), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            [9] = {coords = vector3(-1820.11, -946.19, 1.05), spawn_coords = vector4(-1833.75, -951.07, -0.05, 111.0), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            [10] = {coords = vector3(-793.86, -1510.48, 1.6), spawn_coords = vector4(-810.77, -1516.88, -0.47, 114.42), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            [11] = {coords = vector3(-900.84, -3546.82, 0.82), spawn_coords = vector4(-882.65, -3554.37, -0.64, 247.75), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            [12] = {coords = vector3(1298.07, -3062.78, 5.91), spawn_coords = vector4(1315.67, -3043.7, -0.56, 317.04), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            [13] = {coords = vector3(-285.38, 6626.74, 7.12), spawn_coords = vector4(-300.52, 6625.1, -0.65, 43.15), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            [14] = {coords = vector3(467.48, -3389.73, 6.07), spawn_coords = vector4(456.72, -3385.81, 0.12, 189.92), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            [15] = {coords = vector3(-444.17, -2421.32, 6.04), spawn_coords = vector4(-424.33, -2394.89, 0.51, 329.24), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            --Davis PD
            [16] = {coords = vector3(350.34, -1606.96, 29.28), spawn_coords = vector4(351.89, -1605.09, 29.28, 321.04), distance = 5, garage_type = 'car', method = 'regular'}, --Davis PD (cars)
            [17] = {coords = vector3(384.36, -1619.16, 38.03), spawn_coords = vector4(386.32, -1620.79, 38.03, 51.42), distance = 5, garage_type = 'air', method = 'regular'}, --Davis PD (helipad)
            --Oil Rig Police
            [18] = {coords = vector3(-1414.01, 7255.34, 28.83), spawn_coords = vector4(-1414.01, 7255.34, 28.83, 279.41), distance = 5, garage_type = 'air', method = 'regular'},
            [19] = {coords = vector3(-2717.98, 6579.49, 28.83), spawn_coords = vector4(-2717.98, 6579.49, 28.83, 274.1), distance = 5, garage_type = 'air', method = 'regular'}, 

            --Sky Bar Police
            [20] = {coords = vector3(385.49, 5542.88, 777.33), spawn_coords = vector4(390.63, 5542.72, 777.33, 267.27), distance = 5, garage_type = 'air', method = 'regular'},

            -- OneLife Tower
            [21] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},

        },
        ['bcso'] = {
            [1] = {coords = vector3(-477.35, 5975.35, 31.31), spawn_coords = vector4(-483.03, 5980.4, 31.31, 333.43), distance = 5, garage_type = 'car', method = 'regular'}, -- Paleto
            [2] = {coords = vector3(-455.51, 5999.89, 39.35), spawn_coords = vector4(-455.03, 5999.82, 39.35, 47.03), distance = 5, garage_type = 'air', method = 'regular'}, -- Paleto
            [3] = {coords = vector3(456.27, -1020.71, 24.45), spawn_coords = vector4(456.27, -1020.71, 24.45, 5.08), distance = 5, garage_type = 'car', method = 'regular'}, -- MRPD
            [4] = {coords = vector3(450.59, -1014.98, 42.84), spawn_coords = vector4(450.59, -1014.98, 42.84, 0.81), distance = 5, garage_type = 'air', method = 'regular'}, -- MRPD
            [5] = {coords = vector3(350.34, -1606.96, 29.28), spawn_coords = vector4(351.89, -1605.09, 29.28, 321.04), distance = 5, garage_type = 'car', method = 'regular'}, --Davis PD (cars)
            [6] = {coords = vector3(384.36, -1619.16, 38.03), spawn_coords = vector4(386.32, -1620.79, 38.03, 51.42), distance = 5, garage_type = 'air', method = 'regular'}, --Davis PD (helipad)
            [7] = {coords = vector3(-1598.49, -1201.4, 0.82), spawn_coords = vector4(-1609.96, -1210.83, -0.03, 134.45), distance = 20, garage_type = 'boat', method = 'regular'}, --Vespucci Beach (boats)
            [8] = {coords = vector3(1426.31, 3750.12, 31.76), spawn_coords = vector4(1430.37, 3771.52, 29.86, 336.36), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            [9] = {coords = vector3(-1820.11, -946.19, 1.05), spawn_coords = vector4(-1833.75, -951.07, -0.05, 111.0), distance = 20, garage_type = 'boat', method = 'regular'}, --Sandy Lake (boats)
            --Oil Rig
            [9] = {coords = vector3(-1414.01, 7255.34, 28.83), spawn_coords = vector4(-1414.01, 7255.34, 28.83, 279.41), distance = 5, garage_type = 'air', method = 'regular'},
            [10] = {coords = vector3(-2717.98, 6579.49, 28.83), spawn_coords = vector4(-2717.98, 6579.49, 28.83, 274.1), distance = 5, garage_type = 'air', method = 'regular'},

        },
        ['towing'] = {
            [1] = {coords = vector3(482.51, -1338.29, 29.29), spawn_coords = vector4(490.01, -1341.55, 29.23, 359.5), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['ambulance'] = {
            [1] = {coords = vector3(329.53, -574.45, 28.72),    spawn_coords = vector4(327.41, -573.86, 28.72, 330.00),     distance = 5,   garage_type = 'car',    method = 'regular'},
            [2] = {coords = vector3(351.87, -588.10, 74.16),    spawn_coords = vector4(351.87, -588.1, 74.16, 291.55),      distance = 5,   garage_type = 'air',    method = 'regular'},
            [3] = {coords = vector3(292.03, -585.28, 43.2),    spawn_coords = vector4(290.84, -589.3, 43.19, 157.51),     distance = 5,   garage_type = 'car',    method = 'regular'},
            [4] = {coords = vector3(-1598.49, -1201.4, 0.82),   spawn_coords = vector4(-1609.96, -1210.83, -0.03, 134.45),  distance = 20,  garage_type = 'boat',   method = 'regular'}, --Vespucci Beach (boats)

            -- OneLife Tower
            [1] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },

        ['burgershot'] = {
            [1] = {coords = vector3(-1200.28, -909.08, 13.63), spawn_coords = vector4(-1200.28, -909.08, 13.63, 28.56), distance = 5, garage_type = 'car', method = 'regular'},
            
            -- OneLife Tower
            [2] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['doj'] = {
            [1] = {coords = vector3(-514.01, -246.6, 35.71), spawn_coords = vector4(-499.98, -257.53, 35.56, 293.37), distance = 5, garage_type = 'car', method = 'regular'},

            -- OneLife Tower
            [3] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['mechanic1'] = {
            [1] = {coords = vector3(-747.82, -2043.29, 8.92), spawn_coords = vector4(-747.82, -2043.29, 8.92, 220.07), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(-747.82, -2043.29, 8.92, 220.07)
            [2] = {coords = vector3(-739.32, -2065.2, 8.9), spawn_coords = vector4(-741.85, -2064.48, 8.91, 40.01), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(-744.98, -2060.75, 8.93, 46.83)
            [3] = {coords = vector3(-897.66, -2035.13, 9.3), spawn_coords = vector4(-900.03, -2037.72, 9.3, 130.14), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(-900.03, -2037.72, 9.3, 130.14)

            -- OneLife Tower
            [4] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['palmcoast'] = {
            [1] = {coords = vec3(-2043.29, -463.87, 11.36), spawn_coords = vec4(-2048.49, -459.48, 11.39, 230.08), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(-747.82, -2043.29, 8.92, 220.07)

            -- OneLife Tower
            [2] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['mechanic2'] = {
            [1] = {coords = vector3(163.49, -3014.1, 5.93), spawn_coords = vector4(188.12, -3042.35, 5.81, 3.64), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(188.12, -3042.35, 5.81, 3.64) 

            -- OneLife Tower
            [2] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
         ['mechanic3'] = {
            [1] = {coords = vector3(1131.67, -769.13, 57.75), spawn_coords = vector4(1131.67, -769.13, 57.75, 271.55), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(1125.02, -797.66, 57.71, 353.76)

            -- OneLife Tower
            [2] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['catcafe'] = {
            [1] = {coords = vector3(-621.61, -1058.8, 21.79), spawn_coords = vector4(-618.6, -1058.8, 21.79, 271.65), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(-618.6, -1058.8, 21.79, 271.65)

            -- OneLife Tower
            [2] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['beanmachine'] = {
            [1] = {coords = vector3(111.32, -1049.33, 29.21), spawn_coords = vector4(110.79, -1053.2, 29.2, 249.95), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(290.79, -956.84, 29.3, 87.86)

            -- OneLife Tower
            [2] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['hennies'] = {
            [1] = {coords = vector3(-1830.91, -1162.49, 13.02), spawn_coords = vector4(-1828.73, -1164.38, 13.02, 229.21), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(-1828.73, -1164.38, 13.02, 229.21)

            -- OneLife Tower
            [2] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['upnatom'] = {
            [1] = {coords = vector3(121.49, 287.66, 109.97), spawn_coords = vector4(119.63, 288.29, 109.97, 70.79), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(-1828.73, -1164.38, 13.02, 229.21)

            -- OneLife Tower
            [2] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
        ['billiards'] = {
            [1] = {coords = vector3(-1183.06, -1603.71, 4.39), spawn_coords = vector4(-1180.86, -1602.28, 4.37, 303.94), distance = 5, garage_type = 'car', method = 'regular'}, --vector4(-1180.86, -1602.28, 4.37, 303.94)

            -- OneLife Tower
            [2] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },

        ['dynasty'] = {
            -- OneLife Tower
            [1] = {coords = vector3(-974.73, -269.58, 38.3), spawn_coords = vector4(-974.73, -269.58, 38.3, 217.87), distance = 5, garage_type = 'car', method = 'regular'},
        },
    },

    --This will only be used if any of the 'method'(s) in the table above are set to use 'regular' job vehicles.
    RegularMethod = {
        --job: The job name, not job label.
        --spawn_max: Do you want the vehicles to spawn fully upgraded (performance wise)?.
        --plate: The script fills in the rest of the plate characters with random numbers (up to 8 characters max), so for example 'PD' would be 'PD425424'.
        --job_grade: The minimum a players job grade must be to have access to this vehicle.
        --garage_type: What type of vehicle this is ('car' / 'boat', 'air').
        --model: The spawn name of this vehicle. (this is not supposed to be a string, these symbols get the hash key of this vehicle).

        ['events'] = {
            [1] = {job = 'formula1', spawn_max = true, plate = 'formula1', job_grade = 0, garage_type = 'car', model = `formula`},
            [2] = {job = 'formula1', spawn_max = true, plate = 'formula1', job_grade = 0, garage_type = 'car', model = `formula2`},
            [3] = {job = 'formula1', spawn_max = true, plate = 'formula1', job_grade = 0, garage_type = 'car', model = `openwheel1`},
            [4] = {job = 'formula1', spawn_max = true, plate = 'formula1', job_grade = 0, garage_type = 'car', model = `openwheel3`},
            [5] = {job = 'formula1', spawn_max = true, plate = 'formula1', job_grade = 0, garage_type = 'car', model = `f1`}, 
        },
        ['police'] = {
            -- Ground Fleet
            [1] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 0, garage_type = 'car', model = `polbike`},
            [2] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 0, garage_type = 'car', model = `dlpanto`},
            [3] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 0, garage_type = 'car', model = `dlcade3`},       
            [4] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 0, garage_type = 'car', model = `dlmanch`},
            [5] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 0, garage_type = 'car', model = `Prisonvan3rb`},           
            [6] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 1, garage_type = 'car', model = `dloutlaw`},
            [7] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 1, garage_type = 'car', model = `policegcrb`},
            [8] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 1, garage_type = 'car', model = `dlshin`},
            [9] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 1, garage_type = 'car', model = `dlcomni`},
            [10] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 1, garage_type = 'car', model = `dlgranger2`},           
            [11] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 1, garage_type = 'car', model = `dlrhine`},
            [12] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 1, garage_type = 'car', model = `dlstalker2`},
            [13] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 2, garage_type = 'car', model = `dlbuffalo4`},
            [14] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 2, garage_type = 'car', model = `dlkomoda`},
            [15] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 2, garage_type = 'car', model = `dlballer8`},
            [16] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 3, garage_type = 'car', model = `dljugular`},
            [17] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 3, garage_type = 'car', model = `dlcara`},
            [18] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 3, garage_type = 'car', model = `dlballer7`},
            [19] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 3, garage_type = 'car', model = `dlcinq`},
            [20] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 3, garage_type = 'car', model = `dlvstr`},
            [21] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 6, garage_type = 'car', model = `dltenf2`},
            [22] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 7, garage_type = 'car', model = `dlturismo3`},
            [23] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 8, garage_type = 'car', model = `polsentinel`},
            [24] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 8, garage_type = 'car', model = `dlcomet6`},
            [25] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 8, garage_type = 'car', model = `dlcont`}, 
            [26] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'car', model = `candimodstrailer`},
            [27] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'car', model = `dlvigero2`},
            [28] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'car', model = `polcoach`},
            [29] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 12, garage_type = 'car', model = `segway`},
            


            -- Air Fleet
            [30] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 2,  garage_type = 'air', model = `pd_heli`},
            [31] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 2,  garage_type = 'air', model = `rsheli`},
            
            
            -- Marine Fleet
            [32] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 0, garage_type = 'boat', model = `polboat1`},
            [33] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 1, garage_type = 'boat', model = `polboat2`},
            [34] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 1, garage_type = 'boat', model = `jetskirb`},
            
            --SWAT Ground Fleet
            [35] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'car', model = `BearcatRBstairs`},
            [36] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'car', model = `swatcarrier`},
            [37] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'car', model = `gurkharb`},
            [38] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'car', model = `rookrb`},
            [39] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'car', model = `mraprb`},
            
            --SWAT Air Fleet
            [40] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'air', model = `909_ch53`},
            [41] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 12, garage_type = 'air', model = `mh6`},
            [42] = {job = 'police', spawn_max = true, plate = 'PD', job_grade = 10, garage_type = 'air', model = `riothuey`},
        },
        ['ambulance'] = {
            -- Ground Fleet
            [1] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 1, garage_type = 'car', model = `AMBUIMP`},
            [2] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 2, garage_type = 'car', model = `dlamb`},
            [3] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 7, garage_type = 'car', model = `dlbuffalo`},
            [4] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 3, garage_type = 'car', model = `dlemsb`},
            [5] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 6, garage_type = 'car', model = `dlgranger`},
            [6] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 9, garage_type = 'car', model = `dlissiamb`},
            [7] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 8, garage_type = 'car', model = `insurgent2`},
            [8] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 3, garage_type = 'car', model = `emsnspeedo`},
            [9] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 10, garage_type = 'car', model = `emsscoutmk`},
            [10] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 4, garage_type = 'car', model = `fireeng`},
            [11] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 4, garage_type = 'car', model = `NSANDBRUSH4`},
            [12] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 5, garage_type = 'car', model = `NSANDBRUSH6`},
            
            -- Air Fleet
            [13] = {job = 'ambulance', spawn_max = true, plate = 'EMS', job_grade = 3,  garage_type = 'air', model = `dlswift`},
        },
        ['towing'] = {
            [1] = {job = 'towing', spawn_max = true, plate = 'TOW', job_grade = 0, garage_type = 'car', model = `caracaran`},
            [2] = {job = 'towing', spawn_max = true, plate = 'TOW', job_grade = 0, garage_type = 'car', model = `everonb`},
        },
        ['burgershot'] = {
            [1] = {job = 'burgershot', spawn_max = false, plate = 'BS', job_grade = 1, garage_type = 'car', model = `vanburger`},
        },
        ['doj'] = {
            [1] = {job = 'doj', spawn_max = false, plate = 'DOJ', job_grade = 1, garage_type = 'car', model = `presidentrollsroyce4`},
        },
        ['mechanic1'] = {
            [1] = {job = 'mechanic1', spawn_max = false, plate = 'BENNYS', job_grade = 1, garage_type = 'car', model = `Shifter_kart`},
            [2] = {job = 'mechanic1', spawn_max = false, plate = 'BENNYS', job_grade = 1, garage_type = 'car', model = `energyguinchoride_Bennys`},
            [3] = {job = 'mechanic1', spawn_max = false, plate = 'BENNYS', job_grade = 3, garage_type = 'car', model = `energyheliride_Bennys`},
            [4] = {job = 'mechanic1', spawn_max = false, plate = 'BENNYS', job_grade = 2, garage_type = 'car', model = `energysierraride_Bennys`},
            [5] = {job = 'mechanic1', spawn_max = false, plate = 'BENNYS', job_grade = 3, garage_type = 'car', model = `energytenereride_Bennys`},
            [6] = {job = 'mechanic1', spawn_max = false, plate = 'BENNYS', job_grade = 1, garage_type = 'car', model = `dltowtruckbennys`},
        },
        ['palmcoast'] = {
            [1] = {job = 'mechanic', spawn_max = false, plate = 'EASTC', job_grade = 1, garage_type = 'car', model = `energyguinchoride_east`},
            [2] = {job = 'mechanic', spawn_max = false, plate = 'EASTC', job_grade = 3, garage_type = 'car', model = `energyheliride_east`},
            [3] = {job = 'mechanic', spawn_max = false, plate = 'EASTC', job_grade = 2, garage_type = 'car', model = `energysierraride_east`},
            [4] = {job = 'mechanic', spawn_max = false, plate = 'EASTC', job_grade = 3, garage_type = 'car', model = `energytenereride_east`},
            [5] = {job = 'mechanic', spawn_max = false, plate = 'EASTC', job_grade = 1, garage_type = 'car', model = `dltowtruckeast`},
        },
        ['mechanic3'] = {
            [1] = {job = 'mechanic3', spawn_max = false, plate = 'onelife', job_grade = 1, garage_type = 'car', model = `energyguinchoride_onelife`},
            [2] = {job = 'mechanic3', spawn_max = false, plate = 'onelife', job_grade = 3, garage_type = 'car', model = `energyheliride_onelife`},
            [3] = {job = 'mechanic3', spawn_max = false, plate = 'onelife', job_grade = 2, garage_type = 'car', model = `energysierraride_onelife`},
            [4] = {job = 'mechanic3', spawn_max = false, plate = 'onelife', job_grade = 3, garage_type = 'car', model = `energytenereride_onelife`},
            [5] = {job = 'mechanic3', spawn_max = false, plate = 'onelife', job_grade = 1, garage_type = 'car', model = `dltowtruckonelife`},
            
        }, ['mechanic2'] = {
            [1] = {job = 'mechanic2', spawn_max = false, plate = 'tuner', job_grade = 1, garage_type = 'car', model = `energyguinchoride_tuner`},
            [2] = {job = 'mechanic2', spawn_max = false, plate = 'tuner', job_grade = 3, garage_type = 'car', model = `energyheliride_tuner`},
            [3] = {job = 'mechanic2', spawn_max = false, plate = 'tuner', job_grade = 2, garage_type = 'car', model = `energysierraride_tuner`},
            [4] = {job = 'mechanic2', spawn_max = false, plate = 'tuner', job_grade = 3, garage_type = 'car', model = `energytenereride_tuner`},
            [5] = {job = 'mechanic2', spawn_max = false, plate = 'tuner', job_grade = 1, garage_type = 'car', model = `dltowtrucktuner`},
        },
        ['catcafe'] = {
            [1] = {job = 'catcafe', spawn_max = false, plate = 'CATCAFE', job_grade = 1, garage_type = 'car', model = `vancat`},
        },
        ['beanmachine'] = {
            [1] = {job = 'beanmachine', spawn_max = false, plate = 'BEANM', job_grade = 1, garage_type = 'car', model = `vanbean`},
        },
        ['upnatom'] = {
            [1] = {job = 'upnatom', spawn_max = false, plate = 'UPNATOM', job_grade = 1, garage_type = 'car', model = `vanatom`},
        },
        ['billiards'] = {
            [1] = {job = 'billiards', spawn_max = false, plate = 'BILL', job_grade = 1, garage_type = 'car', model = `vanbilliards`},
        },

        ['dynasty'] = {
            [1] = {job = 'dynasty', spawn_max = true, plate = 'ESTATE', job_grade = 1, garage_type = 'car', model = `amwbcometre`},
        },

    }
}


-- ██████╗  █████╗ ███╗   ██╗ ██████╗      ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗███████╗
--██╔════╝ ██╔══██╗████╗  ██║██╔════╝     ██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝██╔════╝
--██║  ███╗███████║██╔██╗ ██║██║  ███╗    ██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  ███████╗
--██║   ██║██╔══██║██║╚██╗██║██║   ██║    ██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  ╚════██║
--╚██████╔╝██║  ██║██║ ╚████║╚██████╔╝    ╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗███████║
-- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝


Config.GangGarages = {
    ENABLE = false, --Do you want players in defined gangs to be able to use this specific gang garage?
    not_in_gang_name = 'none', --What's the "gang" name if a player isn't part of a gang? (eg., when a player dosnt have a job, their job name is usually "unemployed"). ("none" is the default on qbcore).

    Blip = { --You can find more info on blips here - https://docs.fivem.net/docs/game-references/blips.
        sprite = 84, --Icon of the blip.
        scale = 0.6, --Size of the blip.
        colour = 22, --Colour of the blip.
        name = L('gang_garage')..': ' --You dont need to change this.
    },

    Locations = {
        --gang: The gang name, not gang label.
        --garage_id: The unique id of the garage (this can not be named same as other normal garages).
        --coords: Where the gang garage can be accessed from.
        --spawn_coords: Where the chosen vehicle will spawn.
        --distance: If the player is within the 'distance' of these coords ^, they can open the gang garage UI.
        --garage_type: The type of vehicles that can be accessed from this location ('car' / 'boat', 'air').

        --[1] = {gang = 'triads', garage_id = 'Triads', coords = vector3(-141.98, 897.08, 235.64), spawn_coords = vector4(-141.98, 897.08, 235.64, 324.5), distance = 10, garage_type = 'car'}, --Triads House
        --[2] = {gang = 'CHANGE_ME', garage_id = 'CHANGE_ME', coords = vector3(0.0, 0.0, 0.0), spawn_coords = vector4(0.0, 0.0, 0.0, 0.0), distance = 10, garage_type = 'car'},
    },
}


--██████╗ ██╗     ██╗██████╗ ███████╗
--██╔══██╗██║     ██║██╔══██╗██╔════╝
--██████╔╝██║     ██║██████╔╝███████╗
--██╔══██╗██║     ██║██╔═══╝ ╚════██║
--██████╔╝███████╗██║██║     ███████║
--╚═════╝ ╚══════╝╚═╝╚═╝     ╚══════╝


Config.Unique_Blips = false --Do you want each garage to be named by its unique id, for example: 'Garage A'? (If disabled all garages will be called 'Garage').
Config.Blip = { --You can find more info on blips here - https://docs.fivem.net/docs/game-references/blips.
    ['car'] = {
        sprite = 357, --Icon of the blip.
        scale = 0.6, --Size of the blip.
        colour = 9, --Colour of the blip.
        name = L('garage')..' ' --You dont need to change this.
    },

    ['boat'] = {
        sprite = 357,
        scale = 0.6,
        colour = 8,
        name = L('harbor')..' '
    },

    ['air'] = {
        sprite = 357,
        scale = 0.6,
        colour = 5,
        name = L('hangar')..' '
    }
}


-- ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗    ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗      ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝      ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

local UIText
if Config.InsideGarage.ENABLE then
    UIText = '<b>'..L('garage')..'</b></p>'..L('open_garage_1')..'</p>'..L('open_garage_2').. '</p>'..L('notif_storevehicle')
else
    UIText = '<b>'..L('garage')..'</b></p>'..L('open_garage_1')
end

Config.Locations = {
    {
        Garage_ID = 'Legion', --The very first car garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage. You can change the garage id's to what ever you like but make sure to also change the default garage_id in the database.
        Type = 'car', --The type of vehicles which use this garage. ('car'/'boat'/'air').
        Dist = 10, --The distance that you can use this garage.
        x_1 = 215.09, y_1 = -805.17, z_1 = 30.81, --This is the location of the garage, where you press e to open for example.
        EventName1 = 'cd_garage:QuickChoose', --DONT CHANGE THIS.
        EventName2 = 'cd_garage:EnterGarage', --DONT CHANGE THIS.
        Name = UIText, --You dont need to change this.
        x_2 = 212.42, y_2 = -798.77, z_2 = 30.88, h_2 = 336.61, --This is the location where the vehicle spawns.
        EnableBlip = true, --If disabled, this garage blip will not show on the map.
        JobRestricted = nil, --This will allow only players with certain jobs to use this. This is not a job garage, its still a normal garage. (SINGLE JOB EXAMPLE:  JobRestricted = {'police'},  MULTIPLE JOBS EXAMPLE:  JobRestricted = {'police', 'ambulance'}, )
        ShellType = '10cargarage_shell', --[ '10cargarage_shell' / '40cargarage_shell' / nil ] --You can choose the shell which is loaded when you enter the inside garage from this location. If you set it to nil the script will load a shell based on the amount of cars you own.
    },
    {
        Garage_ID = 'Life Invader', --The very first car garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage. You can change the garage id's to what ever you like but make sure to also change the default garage_id in the database.
        Type = 'car', --The type of vehicles which use this garage. ('car'/'boat'/'air').
        Dist = 10, --The distance that you can use this garage.
        x_1 = -1099.8, y_1 = -258.85, z_1 = 37.67, --This is the location of the garage, where you press e to open for example. vector3(-1099.8, -258.85, 37.67)
        EventName1 = 'cd_garage:QuickChoose', --DONT CHANGE THIS.
        EventName2 = 'cd_garage:EnterGarage', --DONT CHANGE THIS.
        Name = UIText, --You dont need to change this.
        x_2 = -1100.82, y_2 = -261.32, z_2 = 37.69, h_2 = 201.92, --This is the location where the vehicle spawns. vector4(-1100.82, -261.32, 37.69, 201.92)
        EnableBlip = true, --If disabled, this garage blip will not show on the map.
        JobRestricted = nil, --This will allow only players with certain jobs to use this. This is not a job garage, its still a normal garage. (SINGLE JOB EXAMPLE:  JobRestricted = {'police'},  MULTIPLE JOBS EXAMPLE:  JobRestricted = {'police', 'ambulance'}, )
        ShellType = '10cargarage_shell', --[ '10cargarage_shell' / '40cargarage_shell' / nil ] --You can choose the shell which is loaded when you enter the inside garage from this location. If you set it to nil the script will load a shell based on the amount of cars you own.
    },
    {
        Garage_ID = 'Airport Offsite garage', --The very first car garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage. You can change the garage id's to what ever you like but make sure to also change the default garage_id in the database.
        Type = 'car', --The type of vehicles which use this garage. ('car'/'boat'/'air').
        Dist = 10, --The distance that you can use this garage.
        x_1 = -1715.11, y_1 = -2973.16, z_1 = 14.15, --This is the location of the garage, where you press e to open for example. vector3(-1099.8, -258.85, 37.67)
        EventName1 = 'cd_garage:QuickChoose', --DONT CHANGE THIS.
        EventName2 = 'cd_garage:EnterGarage', --DONT CHANGE THIS.
        Name = UIText, --You dont need to change this.
        x_2 = -1705.22, y_2 = -2930.69, z_2 = 13.94, h_2 = 238.66, --This is the location where the vehicle spawns. vector4(-1100.82, -261.32, 37.69, 201.92)
        EnableBlip = true, --If disabled, this garage blip will not show on the map.
        JobRestricted = nil, --This will allow only players with certain jobs to use this. This is not a job garage, its still a normal garage. (SINGLE JOB EXAMPLE:  JobRestricted = {'police'},  MULTIPLE JOBS EXAMPLE:  JobRestricted = {'police', 'ambulance'}, )
        ShellType = '10cargarage_shell', --[ '10cargarage_shell' / '40cargarage_shell' / nil ] --You can choose the shell which is loaded when you enter the inside garage from this location. If you set it to nil the script will load a shell based on the amount of cars you own.
    },
    {
        Garage_ID = 'Formula 1', --The very first car garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage. You can change the garage id's to what ever you like but make sure to also change the default garage_id in the database.
        Type = 'car', --The type of vehicles which use this garage. ('car'/'boat'/'air').
        Dist = 10, --The distance that you can use this garage.
        x_1 = 4405, y_1 = 7864.03, z_1 = 89.2,--This is the location of the garage, where you press e to open for example. vector3(636.3, 603.18, 128.91)
        EventName1 = 'cd_garage:QuickChoose', --DONT CHANGE THIS.
        EventName2 = 'cd_garage:EnterGarage', --DONT CHANGE THIS.
        Name = UIText, --You dont need to change this.
        x_2 = 4487.82, y_2 = 7845.72, z_2 = 88.13, h_2 = 6.49, --This is the location where the vehicle spawns. vector4(637.03, 602.95, 128.91, 252.48) // vector4(-1989.99, -321.62, 43.68, 55.99)
        EnableBlip = true, --If disabled, this garage blip will not show on the map.
        JobRestricted = nil, --This will allow only players with certain jobs to use this. This is not a job garage, its still a normal garage. (SINGLE JOB EXAMPLE:  JobRestricted = {'police'},  MULTIPLE JOBS EXAMPLE:  JobRestricted = {'police', 'ambulance'}, )
        ShellType = '10cargarage_shell', --[ '10cargarage_shell' / '40cargarage_shell' / nil ] --You can choose the shell which is loaded when you enter the inside garage from this location. If you set it to nil the script will load a shell based on the amount of cars you own.
    },
    {
        Garage_ID = 'City Hall', --The very first car garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage. You can change the garage id's to what ever you like but make sure to also change the default garage_id in the database.
        Type = 'car', --The type of vehicles which use this garage. ('car'/'boat'/'air').
        Dist = 10, --The distance that you can use this garage.
        x_1 = -511.84, y_1 = -261.91, z_1 = 35.44, --This is the location of the garage, where you press e to open for example.
        EventName1 = 'cd_garage:QuickChoose', --DONT CHANGE THIS.
        EventName2 = 'cd_garage:EnterGarage', --DONT CHANGE THIS.
        Name = UIText, --You dont need to change this.
        x_2 = -510.57, y_2 = -266.59, z_2 = 35.6, h_2 = 106.42, --This is the location where the vehicle spawns.
        EnableBlip = true, --If disabled, this garage blip will not show on the map.
        JobRestricted = nil, --This will allow only players with certain jobs to use this. This is not a job garage, its still a normal garage. (SINGLE JOB EXAMPLE:  JobRestricted = {'police'},  MULTIPLE JOBS EXAMPLE:  JobRestricted = {'police', 'ambulance'}, )
        ShellType = '10cargarage_shell', --[ '10cargarage_shell' / '40cargarage_shell' / nil ] --You can choose the shell which is loaded when you enter the inside garage from this location. If you set it to nil the script will load a shell based on the amount of cars you own.
    }, 
    {
        Garage_ID = 'Motels', --PINK MOTEL
        Type = 'car',
        Dist = 10,
        x_1 = 273.0, y_1 = -343.85, z_1 = 44.91,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 270.75, y_2 = -340.51, z_2 = 44.92, h_2 = 342.03,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Mirror Park', --MIRROR
        Type = 'car',
        Dist = 10,
        x_1 = 1032.84, y_1 = -765.1, z_1 = 58.18,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1023.2, y_2 = -764.27, z_2 = 57.96, h_2 = 319.66,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Beach', --BEACH
        Type = 'car',
        Dist = 10,
        x_1 = -1248.69, y_1 = -1425.71, z_1 = 4.32,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -1244.27, y_2 = -1422.08, z_2 = 4.32, h_2 = 37.12,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Highway', --G O HIGHWAY
        Type = 'car',
        Dist = 10,
        x_1 = -2961.58, y_1 = 375.93, z_1 = 15.02,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -2964.96, y_2 = 372.07, z_2 = 14.78, h_2 = 86.07,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Sandy West', --SANDY WEST
        Type = 'car',
        Dist = 10,
        x_1 = 217.33, y_1 = 2605.65, z_1 = 46.04,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 216.94, y_2 = 2608.44, z_2 = 46.33, h_2 = 14.07,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Sandy', --SANDY MAIN
        Type = 'car',
        Dist = 10,
        x_1 = 1878.44, y_1 = 3760.1, z_1 = 32.94,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1880.14, y_2 = 3757.73, z_2 = 32.93, h_2 = 215.54,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Vinewood', --VINEWOOD
        Type = 'car',
        Dist = 10,
        x_1 = 365.21, y_1 = 295.65, z_1 = 103.46,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 364.84, y_2 = 289.73, z_2 = 103.42, h_2 = 164.23,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Grapeseed', --GRAPESEED
        Type = 'car',
        Dist = 10,
        x_1 = 1713.06, y_1 = 4745.32, z_1 = 41.96,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1710.64, y_2 = 4746.94, z_2 = 41.95, h_2 = 90.11,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Paleto', --PALETO
        Type = 'car',
        Dist = 10,
        x_1 = 107.32, y_1 = 6611.77, z_1 = 31.98,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 110.84, y_2 = 6607.82, z_2 = 31.86, h_2 = 265.28,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Bennys RaceTrack', --Airport
        Type = 'car',
        Dist = 5,
        x_1 = -780.16, y_1 = -2040.77, z_1 = 8.88, -- vector4(-780.16, -2040.77, 8.88, 316.16)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -780.16, y_2 = -2040.77, z_2 = 8.88, h_2 = 316.16,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Bennys Workshop', --Airport
        Type = 'car',
        Dist = 5,
        x_1 = -941.27, y_1 = -2078.73, z_1 = 9.3, -- vector4(-941.27, -2078.73, 9.3, 225.66)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -941.27, y_2 = -2078.73, z_2 = 9.3, h_2 = 225.66,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'Palm Coast',
        Type = 'car',
        Dist = 4,
        x_1 = -2009.19, y_1 = -487.5, z_1 = 11.37, -- vec4(-2009.19, -487.5, 11.37, 136.65)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -2009.19, y_2 = -487.5, z_2 = 11.37, h_2 = 136.65, 
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'BurgerShot',
        Type = 'car',
        Dist = 10,
        x_1 = -1177.81, y_1 = -900.97, z_1 = 13.27, -- vector4(-1177.81, -900.97, 13.27, 303.11)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -1177.81, y_2 = -900.97, z_2 = 13.27, h_2 = 303.11,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Up \'n Atom', --PALETO
        Type = 'car',
        Dist = 2,
        x_1 = 105.32, y_1 = 303.12, z_1 = 109.66, -- vector4(105.32, 303.12, 109.66, 159.63)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 105.32, y_2 = 303.12, z_2 = 109.66, h_2 = 159.63,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Offroad Dealer',
        Type = 'car',
        Dist = 10,
        x_1 = 1712.68, y_1 = 4803.19, z_1 = 41.77, -- vector4(1712.68, 4803.19, 41.77, 92.27)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1712.68, y_2 = 4803.19, z_2 = 41.77, h_2 = 92.27,
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Pillbox Hospital',
        Type = 'car',
        Dist = 10,
        x_1 = 242.55, y_1 = -564.51, z_1 = 43.28, -- vector4(242.55, -564.51, 43.28, 249.86)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 242.55, y_2 = -564.51, z_2 = 43.28, h_2 = 249.86,
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Trucking',
        Type = 'car',
        Dist = 10,
        x_1 = 1196.67, y_1 = -3105.51, z_1 = 6.03, -- vector4(1196.67, -3105.51, 6.03, 356.66)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1196.67, y_2 = -3105.51, z_2 = 6.03, h_2 = 356.66,
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Triads',
        Type = 'car',
        Dist = 2,
        x_1 = -817.76, y_1 = -728.46, z_1 = 23.78, --vector3(-817.65, -725.01, 23.78)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -817.76, y_2 = -728.46, z_2 = 23.78, h_2 = 178.37, --vector4(-817.76, -728.46, 23.78, 178.37)
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Vagos',
        Type = 'car',
        Dist = 5,
        x_1 = 1354.56, y_1 = -2077.01, z_1 = 52.0, -- vector4(1354.56, -2077.01, 52.0, 299.92)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1354.56, y_2 = -2077.01, z_2 = 52.0, h_2 = 299.92,
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'LostMC',
        Type = 'car',
        Dist = 5,
        x_1 = 996.41, y_1 = -128.58, z_1 = 74.46, -- vector4(996.41, -128.58, 74.46, 134.98)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 996.41, y_2 = -128.58, z_2 = 74.46, h_2 = 134.98,
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'BeanMachine',
        Type = 'car',
        Dist = 5,
        x_1 = 105.83, y_1 = -1062.95, z_1 = 29.19, -- vector4vector4(105.83, -1062.95, 29.19, 244.8)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 105.83, y_2 = -1062.95, z_2 = 29.19, h_2 = 244.8,
        EnableBlip = false,
        JobRestricted = {'beanmachine'},
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'UpNAtom',
        Type = 'car',
        Dist = 5,
        x_1 = 77.87, y_1 = 257.62, z_1 = 108.95, -- vector4(77.87, 257.62, 108.95, 162.48)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 78.04, y_2 = 255.02, z_2 = 108.94, h_2 = 65.09, --vector4(78.04, 255.02, 108.94, 65.09)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Families',
        Type = 'car',
        Dist = 5,
        x_1 = -2588.61, y_1 = 1930.73, z_1 = 167.29, -- vector4(-2588.61, 1930.73, 167.29, 280.9)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -2588.61, y_2 = 1930.73, z_2 = 167.29, h_2 = 280.9, --vector4(-2588.61, 1930.73, 167.29, 280.9)
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Mafia',
        Type = 'car',
        Dist = 3,
        x_1 = -1490.75, y_1 = 21.89, z_1 = 54.72, -- vector4(-1490.75, 21.89, 54.72, 354.96)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -1490.75, y_2 = 21.89, z_2 = 54.72, h_2 = 354.96, --vector4(-1920.45, 2048.89, 140.73, 255.74)
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Cartel',
        Type = 'car',
        Dist = 3,
        x_1 = -2805.0, y_1 = 1451.54, z_1 = 100.76, --vector3(-2805.0, 1451.54, 100.76)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -2808.02, y_2 = 1448.21, z_2 = 100.78, h_2 = 270.66, --vector4(-2808.02, 1448.21, 100.78, 270.66)
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    
    {
        Garage_ID = 'Ballas', --GROVE
        Type = 'car',
        Dist = 4,
        x_1 = -86.4, y_1 = -1815.49, z_1 = 26.95, --vector4(-86.4, -1815.49, 26.95, 237.08)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -86.4, y_2 = -1815.49, z_2 = 26.95, h_2 = 237.08,  --vector4(-86.4, -1815.49, 26.95, 237.08)
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    
    {
        Garage_ID = 'Recycling City',
        Type = 'car',
        Dist = 5,
        x_1 = 763.52, y_1 = -1400.93, z_1 = 26.51, --vector4(763.52, -1400.93, 26.51, 187.35)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 768.85, y_2 = -1404.51, z_2 = 26.51, h_2 = 234.19, --vector4(768.85, -1404.51, 26.51, 234.19)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Recycling Paleto',
        Type = 'car',
        Dist = 5,
        x_1 = 50.08, y_1 = 6465.47, z_1 = 31.45, --vector4(50.08, 6465.47, 31.45, 215.63)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 52.51, y_2 = 6456.31, z_2 = 31.31, h_2 = 135.48, --vector4(52.51, 6456.31, 31.31, 135.48)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Local Dealership',
        Type = 'car',
        Dist = 5,
        x_1 = -42.56, y_1 = -1116.51, z_1 = 26.44, ---vector4(-42.56, -1116.51, 26.44, 66.93)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -47.99, y_2 = -1116.35, z_2 = 26.44, h_2 = 359.15, --vector4(-47.99, -1116.35, 26.44, 359.15)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'OneLife Dealership',
        Type = 'car',
        Dist = 5,
        x_1 = 109.72, y_1 = -127.38, z_1 = 54.75, --vector4(109.72, -127.38, 54.75, 192.71)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 109.45, y_2 = -133.88, z_2 = 54.75, h_2 = 70.9, --vector4(109.45, -133.88, 54.75, 70.9)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = '6STR Tuner Shop',
        Type = 'car',
        Dist = 5,
        x_1 = 166.07, y_1 = -3044.84, z_1 = 5.46, --vector4(166.07, -3044.84, 5.46, 272.13)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 166.07, y_2 = -3044.84, z_2 = 5.46, h_2 = 272.13, --vector4(166.07, -3044.84, 5.46, 272.13)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Billiards',
        Type = 'car',
        Dist = 2,
        x_1 = -1173.89, y_1 = -1593.63, z_1 = 4.31, --vector4(-1173.89, -1593.63, 4.31, 283.32)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -1162.26, y_2 = -1591.37, z_2 = 4.35, h_2 = 280.26, --vector4(-1162.26, -1591.37, 4.35, 280.26)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'AOD Clubhouse',
        Type = 'car',
        Dist = 9,
        x_1 = 290.91, y_1 = 6646.89, z_1 = 29.77, --vector3(290.91, 6646.89, 29.77)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 286.43, y_2 = 6646.97, z_2 = 29.77, h_2 = 89.47, --vector4(286.43, 6646.97, 29.77, 89.47)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

    {
        Garage_ID = 'OneLife Bike Dealership',
        Type = 'car',
        Dist = 2,
        x_1 = -851.77, y_1 = -217.62, z_1 = 37.65, --vector4(-851.77, -217.62, 37.65, 304.92)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -856.13, y_2 = -210.11, z_2 = 37.89, h_2 = 282.79, --vector4(-856.13, -210.11, 37.89, 282.79)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Paintball',
        Type = 'car',
        Dist = 2,
        x_1 = -221.29, y_1 = -2036.92, z_1 = 27.62, --vvector4(-221.29, -2036.92, 27.62, 240.05)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -219.82, y_2 = -2037.77, z_2 = 27.62, h_2 = 239.22, --vector4(-219.82, -2037.77, 27.62, 239.22)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'PD Garage',
        Type = 'car',
        Dist = 4,
        x_1 = 829.44, y_1 = -1365.37, z_1 = 26.13, --vec4(829.44, -1365.37, 26.13, 9.91)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 829.44, y_2 = -1365.37, z_2 = 26.13, h_2 = 9.91, --vec4(829.44, -1365.37, 26.13, 9.91)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Ballas',
        Type = 'car',
        Dist = 4,
        x_1 = 11.12, y_1 = -1823.73, z_1 = 25.05, --vector4(11.12, -1823.73, 25.05, 141.23)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 11.12, y_2 = -1823.73, z_2 = 25.05, h_2 = 141.23, --vector4(11.12, -1823.73, 25.05, 141.23)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Aztecas',
        Type = 'car',
        Dist = 6,
        x_1 = 1001.02, y_1 = -2509.91, z_1 = 28.3, --vector4(1001.02, -2509.91, 28.3, 33.73)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 1001.02, y_2 = -2509.91, z_2 = 28.3, h_2 = 33.73, --vector4(1001.02, -2509.91, 28.3, 33.73)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Paleto Farm',
        Type = 'car',
        Dist = 2,
        x_1 = 408.79, y_1 = 6504.48, z_1 = 27.89, --vector4(408.79, 6504.48, 27.89, 169.96)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 408.79, y_2 = 6504.48, z_2 = 27.89, h_2 = 169.96, --vector4(503.43, -1521.4, 29.29, 47.32)
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Disciples',
        Type = 'car',
        Dist = 2,
        x_1 = -104.63, y_1 = 821.49, z_1 = 235.73, --vector4(-104.63, 821.49, 235.73, 10.27)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -104.63, y_2 = 821.49, z_2 = 235.73, h_2 = 10.27, --vector4(2029.73, 3372.46, 46.8, 224.08)
        EnableBlip = false,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'UWU Cafe',
        Type = 'car',
        Dist = 6,
        x_1 = -581.5, y_1 = -1100.82, z_1 = 22.18, --vector4(-581.5, -1100.82, 22.18, 90.04)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -581.5, y_2 = -1100.82, z_2 = 22.18, h_2 = 90.04, --vector4(-581.5, -1100.82, 22.18, 90.04)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Hennies',
        Type = 'car',
        Dist = 6,
        x_1 = -1843.76, y_1 = -1215.05, z_1 = 13.02, --vector4(-1843.76, -1215.05, 13.02, 207.37)
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -1843.65, y_2 = -1227.29, z_2 = 13.02, h_2 = 307.99, --vector4(-1843.65, -1227.29, 13.02, 307.99)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {--Muscles Gym
        Garage_ID = 'Muscles Gym',
        Type = 'car',
        Dist = 5,
        x_1 = -767.58, y_1 = 235.2, z_1 = 75.69,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = -767.58, y_2 = 235.2, z_2 = 75.69, h_2 = 258.95, --vector4(-767.58, 235.2, 75.69, 258.95)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
        
    },
    {--Towing
        Garage_ID = 'Towing',
        Type = 'car',
        Dist = 5,
        x_1 = 484.95, y_1 = -1338.64, z_1 = 29.28,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 484.95, y_2 = -1338.64, z_2 = 29.28, h_2 = 355.74, --vector4(-767.58, 235.2, 75.69, 258.95)
        EnableBlip = true,
        JobRestricted = 'towing',
        ShellType = '10cargarage_shell',
        
    },
    {--Towing Civ
        Garage_ID = 'Towing',
        Type = 'car',
        Dist = 5,
        x_1 = 499.93, y_1 = -1317.29, z_1 = 29.23,
        EventName1 = 'cd_garage:QuickChoose',
        EventName2 = 'cd_garage:EnterGarage',
        Name = UIText,
        x_2 = 499.93, y_2 = -1317.29, z_2 = 29.23, h_2 = 304.27, --vector4(-767.58, 235.2, 75.69, 258.95)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
        
    },
    {   --THIS IS A BOAT GARAGE, YOU CAN REMOVE OR ADD NEW BOAT GARAGES IF YOU WISH.
        Garage_ID = 'A', --The very first boat garage's `garage_id` must be the same as the default value of the garage_id in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'boat',
        Dist = 10,
        x_1 = -806.22, y_1 = -1496.7, z_1 = 1.6,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('harbor')..'</b></p>'..L('open_garage_3'),
        x_2 = -811.54, y_2 = -1509.42, z_2 = -0.47, h_2 = 130.14,
        EnableBlip = true,
        JobRestricted = nil,
    },
    {   --THIS IS AN AIR GARAGE, YOU CAN REMOVE OR ADD NEW AIR GARAGES IF YOU WISH.
        Garage_ID = 'A', --The very first air garage's `garage_id` must be the same as the default value of the `garage_id` in the database as when a vehicle is purchased it gets sent to this garage.
        Type = 'air',
        Dist = 10,
        x_1 = -982.55, y_1 = -2993.94, z_1 = 13.95,
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = -989.59, y_2 = -3004.93, z_2 = 13.94, h_2 = 58.15,
        EnableBlip = true,
        JobRestricted = nil,
    },
    {   
        Garage_ID = 'Sky Bar',
        Type = 'air',
        Dist = 5,
        x_1 = 399.05, y_1 = 5542.99, z_1 = 777.33,--vector3(399.05, 5542.99, 777.33)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = 390.63, y_2 = 5542.72, z_2 = 777.33, h_2 = 267.27,--vector4(390.63, 5542.72, 777.33, 267.27)
        EnableBlip = false,
        JobRestricted = nil,
    },

    {   
        Garage_ID = 'Families Air',
        Type = 'air',
        Dist = 3,
        x_1 = -2583.91, y_1 = 1885.3, z_1 = 172.87,--vector4(-2583.91, 1885.3, 172.87, 95.27)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = -2583.91, y_2 = 1885.3, z_2 = 172.87, h_2 = 95.27,--vector4(-2583.91, 1885.3, 172.87, 95.27)
        EnableBlip = false,
        JobRestricted = nil,
    },
    {   
        Garage_ID = 'Mafia Air',
        Type = 'air',
        Dist = 3,
        x_1 = -1847.74, y_1 = 2086.27, z_1 = 142.19,--vector4(-1847.74, 2086.27, 142.19, 134.9)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = -1847.74, y_2 = 2086.27, z_2 = 142.19, h_2 = 134.9,--vector4(-1847.74, 2086.27, 142.19, 134.9)
        EnableBlip = false,
        JobRestricted = nil,
    },
    {   
        Garage_ID = 'Cartel Air',
        Type = 'air',
        Dist = 3,
        x_1 = -2809.43, y_1 = 1471.24, z_1 = 104.05,--vector3(-2809.43, 1471.24, 104.05)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = -2809.43, y_2 = 1471.24, z_2 = 104.05, h_2 = 215.89,--vector4(-2809.43, 1471.24, 104.05, 215.89)
        EnableBlip = false,
        JobRestricted = nil,
    },
    {   
        Garage_ID = 'Triads Air',
        Type = 'air',
        Dist = 3,
        x_1 = -154.82, y_1 = 940.31, z_1 = 237.11,--vector4(-154.82, 940.31, 237.11, 235.27)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = -154.82, y_2 = 940.31, z_2 = 237.11, h_2 = 235.27,--vector4(-154.82, 940.31, 237.11, 235.27)
        EnableBlip = false,
        JobRestricted = nil,
    },
    {   
        Garage_ID = 'Vagos Air',
        Type = 'air',
        Dist = 3,
        x_1 = 621.9, y_1 = 894.17, z_1 = 248.42,--vector4(621.9, 894.17, 248.42, 262.01)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = 621.9, y_2 = 894.17, z_2 = 248.42, h_2 = 262.01,--vector4(621.9, 894.17, 248.42, 262.01)
        EnableBlip = false,
        JobRestricted = nil,
    },
        {   
        Garage_ID = 'Disciples Air',
        Type = 'air',
        Dist = 3,
        x_1 = 1981.16, y_1 = 3325.73, z_1 = 47.30,--vector4(1981.16, 3325.73, 47.3, 267.8)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        x_2 = 1981.16, y_2 = 3325.73, z_2 = 47.30, h_2 = 267.80,--vector4(1981.16, 3325.73, 47.3, 267.8)
        EnableBlip = false,
        JobRestricted = nil,
    },
    {
        Garage_ID = 'AOD Clubhouse Air',
        Type = 'air',
        Dist = 9,
        x_1 = 247.39, y_1 = 6645.08, z_1 = 29.77, --vector4(247.39, 6645.08, 29.77, 268.71)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        Name = UIText,
        x_2 = 253.35, y_2 = 6644.86, z_2 = 29.77, h_2 = 268.71, --vector4(253.35, 6644.86, 29.77, 268.71)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Bennys Track', --Airport
        Type = 'air',
        Dist = 5,
        x_1 = -770.01, y_1 = -2020.43, z_1 = 8.85, -- vector3(-770.01, -2020.43, 8.85)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        Name = UIText,
        x_2 = -764.91, y_2 = -2026.83, z_2 = 8.88, h_2 = 222.31,  -- vector4(-764.91, -2026.83, 8.88, 222.31)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Palm Coast',
        Type = 'air',
        Dist = 4,
        x_1 = -2008.18, y_1 = -522.35, z_1 = 11.72, -- vec3(-2008.18, -522.35, 11.72)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        Name = UIText,
        x_2 = -1986.74, y_2 = -504.48, z_2 = 12.05, h_2 = 138.84, -- vec4(-1986.74, -504.48, 12.05, 138.84)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = 'Bennys Workshop',
        Type = 'air',
        Dist = 4,
        x_1 = -940.92, y_1 = -2010.78, z_1 = 9.51, -- vector3(-940.75, -2010.92, 9.51)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        Name = UIText,
        x_2 = -940.62, y_2 = -2011.14, z_2 = 9.51, h_2 = 226.96, -- vector4(-940.62, -2011.14, 9.51, 226.96)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },
    {
        Garage_ID = '6STR Tuner Shop',
        Type = 'air',
        Dist = 4,
        x_1 = 162.86, y_1 = -3009.53, z_1 = 5.94, -- vector4(162.86, -3009.53, 5.94, 270.38)
        EventName1 = 'cd_garage:QuickChoose',
        Name = '<b>'..L('hangar')..'</b></p>'..L('open_garage_4'),
        Name = UIText,
        x_2 = 162.86, y_2 = -3009.53, z_2 = 5.94, h_2 = 270.38, -- vector4(162.86, -3009.53, 5.94, 270.38)
        EnableBlip = true,
        JobRestricted = nil,
        ShellType = '10cargarage_shell',
    },

}


--██╗███╗   ███╗██████╗  ██████╗ ██╗   ██╗███╗   ██╗██████╗     ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██║████╗ ████║██╔══██╗██╔═══██╗██║   ██║████╗  ██║██╔══██╗    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██║██╔████╔██║██████╔╝██║   ██║██║   ██║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██║   ██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║██║ ╚═╝ ██║██║     ╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝     ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


Config.ImpoundLocations = { --DO NOT CHANGE THE TABLE IDENTIFIERSs, for example - ['car_2'], if you wish to add more, then name the next one ['car_3']. It must have either 'car'/'boat'/'air' in the name and also be unique.
    ['car_1'] = {
        ImpoundID = 1, --The unique id of the impound.
        coords = {x = 401.28, y = -1631.44, z = 29.29}, --This is the location of the garage, where you press e to open for example.
        spawnpoint = {x = 404.66, y = -1642.03, z = 29.29, h = 225.5}, --This is the location where the vehicle spawns.
        blip = {
            sprite = 357, --Icon of the blip.
            scale = 0.5, --Size of the blip.
            colour = 3, --Colour of the blip.
            name = L('car_city_impound'), --This can be changed in the Locales.
        }
    },

    ['car_2'] = { 
        ImpoundID = 2,
        coords = {x = 1893.48, y = 3713.50, z = 32.77},
        spawnpoint = {x = 1887.123, y = 3710.348, z = 31.92, h = 212.0},
        blip = {
            sprite = 357,
            scale = 0.5,
            colour = 3,
            name = L('car_sandy_impound'),
        }
    },

    ['boat_1'] = {
        ImpoundID = 3,
        coords = {x = -848.8, y = -1368.42, z = 1.6},
        spawnpoint = {x = -848.4, y = -1362.8, z = -0.47, h = 113.0},
        blip = {
            sprite = 357,
            scale = 0.5,
            colour = 3,
            name = L('boat_impound'),
        }
    },

    ['air_1'] = {
        ImpoundID = 4,
        coords = {x = -956.49, y = -2919.74, z = 13.96},
        spawnpoint = {x = -960.22, y = -2934.4, z = 13.95, h = 153.0},
        blip = {
            sprite = 357,
            scale = 0.5,
            colour = 3,
            name = L('air_impound'),
        }
    },
}


-- ██████╗ ████████╗██╗  ██╗███████╗██████╗ 
--██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
--██║   ██║   ██║   ███████║█████╗  ██████╔╝
--██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
--╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
-- ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


function Round(cd) return math.floor(cd+0.5) end
function Trim(cd) return cd:gsub('%s+', '') end

function GetConfig()
    return Config
end

function GetCorrectPlateFormat(plate)
    if Config.PlateFormats == 'trimmed' then
        return Trim(plate)

    elseif Config.PlateFormats == 'with_spaces' then
        return plate

    elseif Config.PlateFormats == 'mixed' then
        return string.gsub(plate, "^%s*(.-)%s*$", "%1")
    end
end


-- █████╗ ██╗   ██╗████████╗ ██████╗     ██████╗ ███████╗████████╗███████╗ ██████╗████████╗
--██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗    ██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝
--███████║██║   ██║   ██║   ██║   ██║    ██║  ██║█████╗     ██║   █████╗  ██║        ██║   
--██╔══██║██║   ██║   ██║   ██║   ██║    ██║  ██║██╔══╝     ██║   ██╔══╝  ██║        ██║   
--██║  ██║╚██████╔╝   ██║   ╚██████╔╝    ██████╔╝███████╗   ██║   ███████╗╚██████╗   ██║   
--╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝     ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝ ╚═════╝   ╚═╝   
        

-----DO NOT TOUCH ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING.-----
if Config.Framework == 'auto_detect' then
    if GetResourceState(Config.FrameworkTriggers.esx.resource_name) == 'started' then
        Config.Framework = 'esx'
    elseif GetResourceState(Config.FrameworkTriggers.qbcore.resource_name) == 'started' then
        Config.Framework = 'qbcore'
    end
    if Config.Framework == 'esx' or Config.Framework == 'qbcore' then
        for c, d in pairs(Config.FrameworkTriggers[Config.Framework]) do
            Config.FrameworkTriggers[c] = d
        end
        Config.FrameworkTriggers.esx, Config.FrameworkTriggers.qbcore = nil, nil
    end
end

if Config.Database == 'auto_detect' then
    if GetResourceState('mysql-async') == 'started' then
        Config.Database = 'mysql'
    elseif GetResourceState('ghmattimysql') == 'started' then
        Config.Database = 'ghmattimysql'
    elseif GetResourceState('oxmysql') == 'started' then
        Config.Database = 'oxmysql'
    end
end

if Config.Notification == 'auto_detect' then
    if GetResourceState('okokNotify') == 'started' then
        Config.Notification = 'okokNotify'
    elseif GetResourceState('ps-ui') == 'started' then
        Config.Notification = 'ps-ui'
    elseif GetResourceState('ox_lib') == 'started' then
        Config.Notification = 'ox_lib'
    else
        Config.Notification = Config.Framework
        if Config.Notification == 'standalone' or Config.Notification == 'vrp' then Config.Notification = 'chat' end
    end
end

if Config.Framework == 'esx' then
    Config.FrameworkSQLtables = {
        vehicle_table = 'owned_vehicles',
        vehicle_identifier = 'owner',
        vehicle_props = 'vehicle',
        users_table = 'users',
        users_identifier = 'identifier',
    }
    Config.GangGarages.ENABLE = false
elseif Config.Framework == 'qbcore' then
    Config.FrameworkSQLtables = { 
        vehicle_table = 'player_vehicles',
        vehicle_identifier = 'citizenid',
        vehicle_props = 'mods',
        users_table = 'players',
        users_identifier = 'citizenid',
    }
    Config.VehiclesData.ENABLE = true
end

if not Config.VehiclesData.ENABLE then
    Config.Impound.Impound_Fee.method = 'default'
    Config.GarageTax.method = 'default'
    Config.Return_Vehicle.method = 'default'
end
-----DO NOT TOUCH ANYTHING ABOVE THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING.-----
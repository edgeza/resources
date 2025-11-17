Config = {}
function L(cd, ...) if Locales[Config.Language][cd] then return string.format(Locales[Config.Language][cd], ...) else print('Locale is nil ('..cd..')') end end
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
Config.Notification = 'auto_detect' --[ 'auto_detect' / 'other' ]   If you select 'auto_detect', only ESX, QBCore, cd_notifications, okokNotify, ps-ui and ox_lib notifications will be detected. Use 'other' for custom notification resources.
Config.Language = 'EN' --[ 'EN' / 'DK' / 'FR' / 'NL' ]   You can add your own locales to Locales.lua, but be sure to update the Config.Language to match it.

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
        duty = 'QBCore:Client:SetDuty'
    }
}


--██╗███╗   ███╗██████╗  ██████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗████████╗
--██║████╗ ████║██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║╚══██╔══╝
--██║██╔████╔██║██████╔╝██║   ██║██████╔╝   ██║   ███████║██╔██╗ ██║   ██║   
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║   ██║   
--██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║██║ ╚████║   ██║   
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝


Config.UsingOneSync = true --Do you use OneSync legacy or infinity?
Config.UseFrameworkDutySystem = true --Do you want to use your frameworks (esx/qbcore) built-in duty system?
Config.Debug = false --To enable debug prints.
Config.EnableTestCommand = false --The test command is 'dispatchtest'.

Config.AntiCheat = {
    ENABLE = false, --Enable or Disable all of the built in anti cheat features?
    
    BannedWords = { --This feature will kick and send a message in your discord if any banned words are detected in a notification or /911 call.
        ENABLE = true, --Enable or Disable this feature?
        discord_tag_everyone = true, --Tag @ everyone who has access to your discord webhook channel?
        banned_words = {'fuck', 'shit', 'bitch', 'cunt', } --A table of banned words.

    },

    EventSpam = { --This feature will detect events being spammed by lua injectors or mod menus.
        ENABLE = true, --Enable or Disable this feature?
        discord_tag_everyone = true, --Tag @ everyone who has access to your discord webhook channel?
        threshold = { --If x amount of 'events' are triggered within x amount of 'time' this player will be flagged for modding.
            events = 5, --(amount of events)
            time = 3 --(in seconds)
        }
    }
}


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


Config.AllowedJobs = { --A list of jobs who are allowed to use this dispatch.
--This will group different jobs together. Eg., so 2 jobs {'police', 'ambulance'} can both see can see each other on the dispatch UI and the pause menu/mini-map blips.
    [1] = {'police', 'ambulance'}, --police & ambulance group
    --[2] = {'mechanic', }, --mechanic group
    --[3] = {'1st_job', '2nd_job', }, --add more here
}

Config.UpdateDistanceUI = { --Do you want the distance (how far the player is from the call) to be constantly updated on the dispatch UI?
    ENABLE = true,
    timer = 3 --(in seconds) How often the distance should be updated.
}

Config.NotifyStatusChange = true --Do you want players to be notified when another player changes their status? (eg., from Available to Unavailable).


--██████╗ ██╗     ██╗██████╗ ███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ █████╗ ██╗     ██╗     ███████╗██╗ ██████╗ ███╗   ██╗
--██╔══██╗██║     ██║██╔══██╗██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔══██╗██║     ██║     ██╔════╝██║██╔════╝ ████╗  ██║
--██████╔╝██║     ██║██████╔╝███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ███████║██║     ██║     ███████╗██║██║  ███╗██╔██╗ ██║
--██╔══██╗██║     ██║██╔═══╝ ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██╔══██║██║     ██║     ╚════██║██║██║   ██║██║╚██╗██║
--██████╔╝███████╗██║██║     ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗██║  ██║███████╗███████╗███████║██║╚██████╔╝██║ ╚████║
--╚═════╝ ╚══════╝╚═╝╚═╝     ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝                                                                                                                           


Config.PauseMenuBlips = {
    ENABLE = true, --Do you want to use the built in player blips (on the pause menu & mini-map)?
    data_update_timer = 1, --(in seconds) How many seconds should the blip data from the server side be sent to the client side to be updated?
    blip_type = 'auto', --You can choose 3 different methods for displaying the player blips.
    --'static' = Players will all have the same standard player blip.
    --'dynamic' = Players can change their player blip on the dispatch UI's settings page (assigned vehicle).
    --'auto' = Blips will change automatically depending on the vehicle type. (CAN CAUSE HIGH RESOURCE USAGE!).
    flashing_blips = true, --Do you want blips to flash when a player's vehicle has it's emergancy lights enabled?
    bundle_blips = true, --Do you want to bundle the blips together so they do not spam the pause menu legend?
    radiochannel_on_blips = true, --Do you want a players radio chanel to be displayed on blips?
    minimize_longdistance_blips = true, --Do you want long distance blips to be minimized(smaller size) on the mini-map instead of them being hidden?
    
    blip_sprites = { --These are the blip sprites (icons). More blips can be found here - https://docs.fivem.net/docs/game-references/blips.
        ['static'] = 1,
        ['foot'] = 1,
        ['car'] = 56,
        ['motorcycle'] = 226,
        ['helicopter'] = 43,
        ['boat'] = 427,
    },
}

Config.BlipData = { --You need to add all the jobs that will be able to use the dispatch to the table below so you can choose their blip colour.
    --largeui_blip_colour: The colour of the player blips on the mini-map and pause menu.The only colours available by default are blue/orange/yellow/red. More can be added in the html.
    --pausemenu_blip_colour: The colour of the player blips on dispatch UI map. The 1st one is the default colour and the 2nd one is the flashing colour. More blip colours can be found here - https://docs.fivem.net/docs/game-references/blips.

    ['police'] =    {largeui_blip_colour = 'blue',      pausemenu_blip_colour = {3, 1}},
    ['ambulance'] = {largeui_blip_colour = 'red',       pausemenu_blip_colour = {1, 0}},
   -- ['mechanic'] =  {largeui_blip_colour = 'orange',    pausemenu_blip_colour = {17, 0}},
    --['CHANGE_ME'] = {largeui_blip_colour = 'blue', pausemenu_blip_colour = {3, 1}},
}


--██████╗ ██╗███████╗██████╗  █████╗ ████████╗ ██████╗██╗  ██╗███████╗██████╗ 
--██╔══██╗██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║  ██║██╔════╝██╔══██╗
--██║  ██║██║███████╗██████╔╝███████║   ██║   ██║     ███████║█████╗  ██████╔╝
--██║  ██║██║╚════██║██╔═══╝ ██╔══██║   ██║   ██║     ██╔══██║██╔══╝  ██╔══██╗
--██████╔╝██║███████║██║     ██║  ██║   ██║   ╚██████╗██║  ██║███████╗██║  ██║
--╚═════╝ ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


Config.Dispatcher = {
    ENABLE = false, --Do you want to use the build in dispatcher system? (this is optional)
    notify_activity = true, --Do you want players to be notified when a dispatcher comes online/goes offline? 

    Perms = { --A list of jobs and the minimum job grade for those who are allowed to use the dispatcher features.
        ['police'] = 0,
        ['ambulance'] = 0,
        ['mechanic'] = 0,
    },

    AutoRefreshBlips = {
        ENABLE = true, --Do you want the player blips on the dispatch UI map to be auto refreshed for the dispatchers?.
        refresh_timer = 5, --(in seconds) The amount of time it takes to refresh the player blips (the lower the number the higher the resource usage).
    },

    VoipResource = 'pmavoice' ---[ 'toko' / 'mumble' / 'pmavoice' / 'other' ] Choose your servers voip resource.
}


--     ██╗ ██████╗ ██████╗      ██████╗ █████╗ ██╗     ██╗          ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--     ██║██╔═══██╗██╔══██╗    ██╔════╝██╔══██╗██║     ██║         ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--     ██║██║   ██║██████╔╝    ██║     ███████║██║     ██║         ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██   ██║██║   ██║██╔══██╗    ██║     ██╔══██║██║     ██║         ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--╚█████╔╝╚██████╔╝██████╔╝    ╚██████╗██║  ██║███████╗███████╗    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
-- ╚════╝  ╚═════╝ ╚═════╝      ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝     ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Config.JobCallCommands = { 
    ENABLE = true,--Do you want to use the job chat commands eg., /911 to send a notification to the police.

    --label: The job display label.
    --command: The chat command.
    --anonymous: Do you want this call to be anonymous? (does not show the callers name or phone number and uses radius blips).
    --job_table: The jobs who can see the calls. (you can add multiple).
    Civilian_Commands = {
        { job_label = 'Police',         command = '911',        anonymous = false, 	job_table = {'police', } },
        { job_label = 'Police',         command = '911a',       anonymous = true,   job_table = {'police', } },
        { job_label = 'Ambulance',      command = '911ems',     anonymous = false,	job_table = {'ambulance', } },
      --  { job_label = 'Mechanic',       command = 'mechanic',   anonymous = false,	job_table = {'mechanic', } },
     --   { job_label = 'Car dealer',     command = 'cardealer',  anonymous = false,	job_table = {'cardealer', } },
       -- { job_label = 'Real estate',    command = 'realestate', anonymous = false,	job_table = {'realestate', } },
       --- { job_label = 'Taxi',           command = 'taxi',       anonymous = false,	job_table = {'taxi', } },
        --{ job_label = 'CHANGE_ME',      command = 'CHANGE_ME',  anonymous = false,	job_table = {'CHANGE_ME', 'CHANGE_ME'} },
    },
    
    JobReply_Command = 'reply' --The chat command for the jobs above^ to reply to incomming calls.
}


--██████╗  █████╗ ███╗   ██╗██╗ ██████╗    ██████╗ ██╗   ██╗████████╗████████╗ ██████╗ ███╗   ██╗
--██╔══██╗██╔══██╗████╗  ██║██║██╔════╝    ██╔══██╗██║   ██║╚══██╔══╝╚══██╔══╝██╔═══██╗████╗  ██║
--██████╔╝███████║██╔██╗ ██║██║██║         ██████╔╝██║   ██║   ██║      ██║   ██║   ██║██╔██╗ ██║
--██╔═══╝ ██╔══██║██║╚██╗██║██║██║         ██╔══██╗██║   ██║   ██║      ██║   ██║   ██║██║╚██╗██║
--██║     ██║  ██║██║ ╚████║██║╚██████╗    ██████╔╝╚██████╔╝   ██║      ██║   ╚██████╔╝██║ ╚████║
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝    ╚═════╝  ╚═════╝    ╚═╝      ╚═╝    ╚═════╝ ╚═╝  ╚═══╝


Config.PanicButton = {
    ENABLE = true, --Do you want to allow dispatch users to use the built-in panic button?
    command = 'panic', --The chat command.
    key = '', --The key press. This is not used by default. You can choose keys here - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/.
    job_table = {'police', 'ambulance', }, --A list of jobs who can use the panic button. (every job in this list will be notified if a panic button is pressed).
    cooldown = 20, --(in seconds) This cooldown is to prevent a player spamming the panic button.
    play_sound_in_distance = true --Do you want the panic button sound to play to all nearby players?
}


--██████╗ ██╗███╗   ██╗ ██████╗ 
--██╔══██╗██║████╗  ██║██╔════╝ 
--██████╔╝██║██╔██╗ ██║██║  ███╗
--██╔═══╝ ██║██║╚██╗██║██║   ██║
--██║     ██║██║ ╚████║╚██████╔╝
--╚═╝     ╚═╝╚═╝  ╚═══╝ ╚═════╝ 


Config.Ping = {
    ENABLE = true, --Do you want to allow players who have access to the dispatch to ping their location to other players of the same job?
    command = 'dispatchping', --The chat command.
    key = 'up', --The key press. You can choose other keys here - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/.
    cooldown = 5, --(in seconds) This cooldown is to prevent a player spamming pings.
}


--██████╗  ██████╗ ██╗     ██╗ ██████╗███████╗     █████╗ ██╗     ███████╗██████╗ ████████╗███████╗
--██╔══██╗██╔═══██╗██║     ██║██╔════╝██╔════╝    ██╔══██╗██║     ██╔════╝██╔══██╗╚══██╔══╝██╔════╝
--██████╔╝██║   ██║██║     ██║██║     █████╗      ███████║██║     █████╗  ██████╔╝   ██║   ███████╗
--██╔═══╝ ██║   ██║██║     ██║██║     ██╔══╝      ██╔══██║██║     ██╔══╝  ██╔══██╗   ██║   ╚════██║
--██║     ╚██████╔╝███████╗██║╚██████╗███████╗    ██║  ██║███████╗███████╗██║  ██║   ██║   ███████║
--╚═╝      ╚═════╝ ╚══════╝╚═╝ ╚═════╝╚══════╝    ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝


Config.PoliceAlerts = {
    ENABLE = true, --Do you want to use the built in police alerts?
    police_jobs = {'police', }, --The jobs who will be notified from these police alerts.
    whitelisted_jobs = {'police', 'ambulance', }, --These jobs will NOT trigger these police alerts.
    cooldown = 30, --(in seconds) This cooldown is to prevent alerts from being spammed by the same player.
    add_bolos = true, --(requires cd_radar) Do you want to add a bolo for the vehicle that was used in the crime?
    require_witness_peds = {
        ENABLE = false, --Do you want police alerts only to be sent if a witness (npc ped) is in the area?
        distance = 100, --The distance to check for witnesses.
    },

    --[[GUNSHOTS CONFIG]]--
    GunShots = {
        ENABLE = true, ---Do you want gunshots to alert police?
        
        WhitelistedZones = { --Shooting in whitelisted areas doesn't alert police.
            [1] = {coords = vector3(13.98, -1098.05, 29.8), distance = 20}, --Legion gunrange.
           [2] = {coords = vector3(821.09, -2163.46, 78.67), distance = 20}, --Cypress Flats gunrange.
        [3] = {coords = vector3(0, 0, 0), distance = 10},
       },
        WhitelistedWeapons = { --Shooting whitelisted weapons doesn't alert police.
            [`WEAPON_FLARE`] = true,
            [`WEAPON_FLAREGUN`] = true,
            [`WEAPON_FIREEXTINGUISHER`] = true,
            [`WEAPON_PETROLCAN`] = true,
            [`WEAPON_STUNGUN`] = true,
            --[`ADD_MORE_HERE`] = true,
        },
        WeaponLabels = {
            -- Pistols
            [`WEAPON_PISTOL`] = 'Pistol',
            [`WEAPON_PISTOL_MK2`] = 'Pistol MK2',
            [`WEAPON_COMBATPISTOL`] = 'Combat Pistol',
            [`WEAPON_APPISTOL`] = 'AP Pistol',
            [`WEAPON_STUNGUN`] = 'Stun Gun',
            [`WEAPON_PISTOL50`] = '.50 Cal Pistol',
            [`WEAPON_SNSPISTOL`] = 'SNS Pistol',
            [`WEAPON_SNSPISTOL_MK2`] = 'SNS Pistol MK2',
            [`WEAPON_HEAVYPISTOL`] = 'Heavy Pistol',
            [`WEAPON_VINTAGEPISTOL`] = 'Vintage Pistol',
            [`WEAPON_FLAREGUN`] = 'Flare Gun',
            [`WEAPON_MARKSMANPISTOL`] = 'Marksman Pistol',
            [`WEAPON_REVOLVER`] = 'Revolver',
            [`WEAPON_REVOLVER_MK2`] = 'Revolver MK2',
            [`WEAPON_DOUBLEACTION`] = 'Double Action Revolver',
            [`WEAPON_RAYPISTOL`] = 'Ray Pistol',
            [`WEAPON_CERAMICPISTOL`] = 'Ceramic Pistol',
            [`WEAPON_NAVYREVOLVER`] = 'Navy Revolver',
            [`WEAPON_PERICOPISTOL`] = 'Perico Pistol',
            
            -- Submachine Guns
            [`WEAPON_MICROSMG`] = 'Micro SMG',
            [`WEAPON_SMG`] = 'SMG',
            [`WEAPON_SMG_MK2`] = 'SMG MK2',
            [`WEAPON_ASSAULTSMG`] = 'Assault SMG',
            [`WEAPON_COMBATPDW`] = 'Combat PDW',
            [`WEAPON_MACHINEPISTOL`] = 'Machine Pistol',
            [`WEAPON_MINISMG`] = 'Mini SMG',
            [`WEAPON_GUSENBERG`] = 'Gusenberg Sweeper',
            
            -- Shotguns
            [`WEAPON_PUMPSHOTGUN`] = 'Pump Shotgun',
            [`WEAPON_PUMPSHOTGUN_MK2`] = 'Pump Shotgun MK2',
            [`WEAPON_SAWNOFFSHOTGUN`] = 'Sawed-Off Shotgun',
            [`WEAPON_ASSAULTSHOTGUN`] = 'Assault Shotgun',
            [`WEAPON_BULLPUPSHOTGUN`] = 'Bullpup Shotgun',
            [`WEAPON_MUSKET`] = 'Musket',
            [`WEAPON_HEAVYSHOTGUN`] = 'Heavy Shotgun',
            [`WEAPON_DBSHOTGUN`] = 'Double Barrel Shotgun',
            [`WEAPON_AUTOSHOTGUN`] = 'Auto Shotgun',
            [`WEAPON_COMBATSHOTGUN`] = 'Combat Shotgun',
            
            -- Assault Rifles
            [`WEAPON_ASSAULTRIFLE`] = 'AK-47',
            [`WEAPON_ASSAULTRIFLE_MK2`] = 'Assault Rifle MK2',
            [`WEAPON_CARBINERIFLE`] = 'Carbine Rifle',
            [`WEAPON_CARBINERIFLE_MK2`] = 'Carbine Rifle MK2',
            [`WEAPON_ADVANCEDRIFLE`] = 'Advanced Rifle',
            [`WEAPON_SPECIALCARBINE`] = 'Special Carbine',
            [`WEAPON_SPECIALCARBINE_MK2`] = 'Special Carbine MK2',
            [`WEAPON_BULLPUPRIFLE`] = 'Bullpup Rifle',
            [`WEAPON_BULLPUPRIFLE_MK2`] = 'Bullpup Rifle MK2',
            [`WEAPON_COMPACTRIFLE`] = 'Compact Rifle',
            
            -- Light Machine Guns
            [`WEAPON_MG`] = 'MG',
            [`WEAPON_COMBATMG`] = 'Combat MG',
            [`WEAPON_COMBATMG_MK2`] = 'Combat MG MK2',
            
            -- Sniper Rifles
            [`WEAPON_SNIPERRIFLE`] = 'Sniper Rifle',
            [`WEAPON_HEAVYSNIPER`] = 'Heavy Sniper',
            [`WEAPON_HEAVYSNIPER_MK2`] = 'Heavy Sniper MK2',
            [`WEAPON_MARKSMANRIFLE`] = 'Marksman Rifle',
            [`WEAPON_MARKSMANRIFLE_MK2`] = 'Marksman Rifle MK2',
            
            -- Heavy Weapons
            [`WEAPON_RPG`] = 'RPG',
            [`WEAPON_GRENADELAUNCHER`] = 'Grenade Launcher',
            [`WEAPON_GRENADELAUNCHER_SMOKE`] = 'Smoke Grenade Launcher',
            [`WEAPON_MINIGUN`] = 'Minigun',
            [`WEAPON_FIREWORK`] = 'Firework Launcher',
            [`WEAPON_RAILGUN`] = 'Railgun',
            [`WEAPON_HOMINGLAUNCHER`] = 'Homing Launcher',
            [`WEAPON_COMPACTLAUNCHER`] = 'Compact Launcher',
            [`WEAPON_RAYCARBINE`] = 'Ray Carbine',
            [`WEAPON_RAYCARBINE_RARE`] = 'Ray Carbine Rare',
            
            -- Throwables
            [`WEAPON_GRENADE`] = 'Grenade',
            [`WEAPON_BZGAS`] = 'BZ Gas',
            [`WEAPON_MOLOTOV`] = 'Molotov',
            [`WEAPON_STICKYBOMB`] = 'Sticky Bomb',
            [`WEAPON_PROXMINE`] = 'Proximity Mine',
            [`WEAPON_SNOWBALL`] = 'Snowball',
            [`WEAPON_PIPEBOMB`] = 'Pipe Bomb',
            [`WEAPON_BALL`] = 'Ball',
            [`WEAPON_SMOKEGRENADE`] = 'Smoke Grenade',
            [`WEAPON_FLARE`] = 'Flare',
            
            -- Melee
            [`WEAPON_KNIFE`] = 'Knife',
            [`WEAPON_NIGHTSTICK`] = 'Nightstick',
            [`WEAPON_HAMMER`] = 'Hammer',
            [`WEAPON_BAT`] = 'Baseball Bat',
            [`WEAPON_GOLFCLUB`] = 'Golf Club',
            [`WEAPON_CROWBAR`] = 'Crowbar',
            [`WEAPON_BOTTLE`] = 'Bottle',
            [`WEAPON_DAGGER`] = 'Dagger',
            [`WEAPON_HATCHET`] = 'Hatchet',
            [`WEAPON_KNUCKLE`] = 'Brass Knuckles',
            [`WEAPON_MACHETE`] = 'Machete',
            [`WEAPON_FLASHLIGHT`] = 'Flashlight',
            [`WEAPON_SWITCHBLADE`] = 'Switchblade',
            [`WEAPON_POOLCUE`] = 'Pool Cue',
            [`WEAPON_PIPEWRENCH`] = 'Pipe Wrench',
            
            -- Misc
            [`WEAPON_PETROLCAN`] = 'Jerry Can',
            [`WEAPON_FIREEXTINGUISHER`] = 'Fire Extinguisher',
            [`WEAPON_PARACHUTE`] = 'Parachute',
            
            -- Kyros Weapon Pack V5 - Assault Rifles
            [`WEAPON_BAR15`] = 'PD AR-15',
            [`WEAPON_BLACKARP`] = 'BLACK ARP',
            [`WEAPON_BSCAR`] = 'BLACK SCAR',
            [`WEAPON_THOMPSON`] = 'BLACK THOMPSON',
            [`WEAPON_DMK18`] = 'PD DESERET MK18',
            [`WEAPON_LBTARP`] = 'PD LB TAN ARP',
            [`WEAPON_RAM7`] = 'RAM-7',
            [`WEAPON_REDARP`] = 'RED DRAG ARP',
            [`WEAPON_REDM4A1`] = 'RED DRAG M4A1',
            [`WEAPON_TARP`] = 'TAN ARP',
            [`WEAPON_WOARP`] = 'WHITE OUT ARP',
            
            -- Kyros Weapon Pack V5 - Pistols
            [`WEAPON_BLUEGLOCKS`] = 'BLUE GLOCK SWITCH',
            [`WEAPON_FN57`] = 'PD FN Five-seveN',
            [`WEAPON_GLOCK21`] = 'PD GLOCK 21',
            [`WEAPON_GLOCK41`] = 'GLOCK 41',
            [`WEAPON_GLOCKBEAMS`] = 'GLOCK BEAM SWITCH',
            [`WEAPON_P30L`] = 'H&K P30L',
            [`WEAPON_ILLGLOCK17`] = 'PD GLOCK 17',
            [`WEAPON_MGGLOCK`] = 'MG GLOCK',
            [`WEAPON_MIDASGLOCK`] = 'MIDAS GLOCK',
            [`WEAPON_P210`] = 'P210 CARRY',
            [`WEAPON_SR40`] = 'RUGER SR40',
            [`WEAPON_T1911`] = 'TAN 1911',
            [`WEAPON_TGLOCK19`] = 'TAN G19',
            
            -- Kyros Weapon Pack V5 - Submachine Guns
            [`WEAPON_KRISSVECTOR`] = 'KRISS VECTOR',
            [`WEAPON_TEC9S`] = 'TEC 9 W STRAP',
            
            -- Kyros Weapon Pack V5 - Shotguns
            [`WEAPON_M500`] = 'MOSSBERG 500',
            [`WEAPON_R590`] = 'REMINGTON 590',
            
            -- Kyros Weapon Pack V5 - Melee
            [`WEAPON_AXE`] = 'AXE',
            [`WEAPON_CHAIR`] = 'BRAWL CHAIR',
        },
    },

    --[[SPEEDTRAP CONFIG]]--
    SpeedTrap = {
        ENABLE = true, ----Do you want speeding vehicles to alert police?
        check_owner_for_fine = false, --Do you want players to only be fined in vehicles they own? (if enabled, players in stolen cars will not be fined).

        Blip = {
            ENABLE = true, --Do you want speed traps to display on a players minimap?
            sprite = 184, --Icon of the blip.
            scale = 0.7, --Size of the blip.
            colour = 0, --Colour of the blip.
            display = 5, --Set to [4] to display on the pause menu map or [5] to only display on the mini-map.
            name = L('speedtrap_blip_name') --You dont need to change this.
        },

        Locations = {
            --coords: The location of the speed trap.
            --distance: The distance a player must be from the 'coords^' to alert the speed trap. 
            --speed_limit: The minimum speed to alert the speed trap (in MPH). 
            --fine_amount: The amount the player will be fined (set to 0 to not fine a player).
            [1] = {coords = vector3(1051.42, 331.11, 84.00), distance = 9, speed_limit = 150, fine_amount = 500 }, --LS Freeway.
            [2] = {coords = vector3(544.43, -373.24, 33.14), distance = 9, speed_limit = 150, fine_amount = 5000 }, --Into Legion.
            [3] = {coords = vector3(-2612.10, 2940.81, 16.67), distance = 15, speed_limit = 150, fine_amount = 1000 }, --Zancuda.
            [4] = {coords = vector3(287.94, -517.44, 42.89), distance = 15, speed_limit = 100, fine_amount = 500 }, --Pillbox.
            [5] = {coords = vector3(2792.73, 4407.68, 48.44), distance = 24, speed_limit = 150, fine_amount = 1000 }, --Sandy Freeway.
            [6] = {coords = vector3(577.11, -1028.32, 37.07), distance = 15, speed_limit = 100, fine_amount = 1000 }, --Mission Row.
            [7] = {coords = vector3(114.83, -797.89, 30.97), distance = 15, speed_limit = 100, fine_amount = 2000 }, --Legion Square.
            [8] = {coords = vector3(74.33, -163.30, 54.67), distance = 15, speed_limit = 100, fine_amount = 4000 }, --Pink Cage.
            [9] = {coords = vector3(28.19, -971.05, 28.96), distance = 15, speed_limit = 100, fine_amount = 1000 }, --PDM.
            --[10] = {coords = vector3(0, 0, 0), distance = 15, speed_limit = 50, fine_amount = 1000 },
        }
    },
}


--██╗  ██╗███████╗██╗   ██╗███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--█████╔╝ █████╗   ╚████╔╝ ███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--██║  ██╗███████╗   ██║   ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Config.small_ui = {
    ENABLE = true, --Do you want to enable the small UI?
    command = 'dispatchsmall', --The chat command.
    key = 'u' --The key press. You can choose other keys here - https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/.
}

Config.large_ui = {
    ENABLE = true, --Do you want to enable the large map UI?
    command = 'dispatchlarge',
    key = 'l'
}

Config.respond = {
    ENABLE = true, --Do you want to enable the units responding feature?
    command = 'respond', 
    key = 'g'
}

Config.move_mode = {
    ENABLE = true, --Do you want to enable the move mode feature?
    command = 'movemode'
}

Config.small_ui_left = {
    ENABLE = true, --Do you want to enable the small UI left scroll?
    command = 'scrollleft', 
    key = 'left'
}

Config.small_ui_right = {
    ENABLE = true, --Do you want to enable the small UI right scroll?
    command = 'scrollright', 
    key = 'right'
}


-- ██████╗ ████████╗██╗  ██╗███████╗██████╗ 
--██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
--██║   ██║   ██║   ███████║█████╗  ██████╔╝
--██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
--╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
-- ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


function Round(cd) return math.floor(cd+0.5) end
function Trim(cd) return cd:gsub('%s+', '') end

function CheckMultiJobs(job)
    for cd = 1, #Config.AllowedJobs do
        for c, d in pairs(Config.AllowedJobs[cd]) do
            if d == job then
                return Config.AllowedJobs[cd]
            end
        end
    end
    return false
end

function GetConfig()
    return Config
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
end
if Config.Framework == 'esx' or Config.Framework == 'qbcore' then
    for c, d in pairs(Config.FrameworkTriggers[Config.Framework]) do
        Config.FrameworkTriggers[c] = d
    end
    Config.FrameworkTriggers.esx, Config.FrameworkTriggers.qbcore = nil, nil
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
    if GetResourceState('cd_notifications') == 'started' then
        Config.Notification = 'cd_notifications'
    elseif GetResourceState('okokNotify') == 'started' then
        Config.Notification = 'okokNotify'
    elseif GetResourceState('ps-ui') == 'started' then
        Config.Notification = 'ps-ui'
    elseif GetResourceState('ox_lib') == 'started' then
        Config.Notification = 'ox_lib'
    else
        if Config.Framework == 'esx' or Config.Framework == 'qbcore' then
            Config.Notification = Config.Framework
        else
            Config.Notification = 'chat'
        end
    end
end

if Config.Framework == 'esx' then
    Config.FrameworkSQLtables = {
        vehicle_table = 'owned_vehicles',
        vehicle_identifier = 'owner',
    }
elseif Config.Framework == 'qbcore' then
    Config.FrameworkSQLtables = {
        vehicle_table = 'player_vehicles',
        vehicle_identifier = 'citizenid',
    }
end
-----DO NOT TOUCH ANYTHING ABOVE THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING.-----
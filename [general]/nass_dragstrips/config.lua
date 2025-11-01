--[[
███╗   ██╗ █████╗ ███████╗███████╗    ██████╗ ██████╗  █████╗  ██████╗ ███████╗████████╗██████╗ ██╗██████╗ ███████╗
████╗  ██║██╔══██╗██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝╚══██╔══╝██╔══██╗██║██╔══██╗██╔════╝
██╔██╗ ██║███████║███████╗███████╗    ██║  ██║██████╔╝███████║██║  ███╗███████╗   ██║   ██████╔╝██║██████╔╝███████╗
██║╚██╗██║██╔══██║╚════██║╚════██║    ██║  ██║██╔══██╗██╔══██║██║   ██║╚════██║   ██║   ██╔══██╗██║██╔═══╝ ╚════██║
██║ ╚████║██║  ██║███████║███████║    ██████╔╝██║  ██║██║  ██║╚██████╔╝███████║   ██║   ██║  ██║██║██║     ███████║
╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝

https://discord.gg/nass
]]

-- Be sure to set the discord webhook in the server/unlocked.lua
Config = {}
Config.locale = Locales["en"] -- en | es | fr | de | it | pt | ru| zh
Config.MPH = false -- if false it will use KMH

Config.target = {-- Supports "ox_target" | "qtarget" | "qb-target" natively
    enabled = true, --Setting to false will use normal helptext prompt
    size = {x=3.0,y=3.0,z=3.0},
    distance = 3,
    icon = "fa-solid fa-car",
    label = Config.locale["target_label"],
}
Config.leaderboardPopUpDistance = 2.0

Config.maxRecordedTimes = 50 -- Script will only have top 50 times, 
Config.dragSlipDisplayTime = 15 -- Seconds
Config.displayBoardTime = 10 -- Seconds
Config.stripRenderDistance = 100
Config.challengeWaitTime = 10 --Seconds | Time from when a player challenges another that it becomes automatically canceled

Config.betting = {
    enabled = true, --Set to false to disable wagers
    account = "cash" -- Cash or bank
}

Config.distances = {
    {label = "Eighth-Mile", value = 660},
    {label = "Quarter-Mile", value = 1320},
    {label = "Half-Mile", value = 1800},
    {label = "Full-Mile", value = 5280},
}

Config.controls = {
    challenge = {name = "INPUT_PICKUP", control = 51}, --E
    solo = {name = "INPUT_THROW_GRENADE", control = 58},--G
    challengeWager = {name = "INPUT_REPLAY_SCREENSHOT", control = 303},--U
}

Config.defaultBlipSettings = {
    enabled = true,
    sprite = 309,
    color = 0,
    scale = 0.65,
    shortRange = true,
}

Config.timeBoardProp = `prop_billboard_14`
Config.setupCar = `adder`

Config.dragTrees = { --If you want to edit this then you need to add to the client/unlocked.lua file. 
    --I do not recommend doing this, if you do, NO SUPPORT WILL BE GIVEN. Please do not open a ticket about this. If you do it will be closed
    {label = "nass_dragtree_pro", value = "nass_dragtree_pro"},
    {label = "nass_dragtree", value = "nass_dragtree"},
}

Config.stageDistance = 4
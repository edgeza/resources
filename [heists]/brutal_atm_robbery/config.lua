----------------------------------------------------------------------------------------------
-----------------------------------| BRUTAL ATM ROBBERY :) |----------------------------------
----------------------------------------------------------------------------------------------

--[[
Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com
--]]

Config = {
    Core = 'QBCORE',  -- 'ESX' / 'QBCORE' | Other core setting on the 'core' folder.
    BrutalNotify = true, -- Buy here: (4€+VAT) https://store.brutalscripts.com | Or set up your own notify >> cl_utils.lua
    BrutalGangs = true, -- Buy here: (35€+VAT) https://store.brutalscripts.com | Or set up your own if you're using a different gang script >> sv_utils.lua
    
    NextRobbery = 5,  -- minutes
    Item = 'drill',
    UseDrillCommand = {use = true, command = 'atmdrill'},
    Models = {'prop_atm_03', 'prop_fleeca_atm', 'prop_atm_02'},
    RequiredCopsCount = 0,
    BagType = 45,
    CopJobs = {'police', 'sheriff', 'fbi'},
    BlipTime = 2, -- minutes
    Reward = {Min = 10000, Max = 30000}, -- Cash reward (10k-30k)
    ItemReward = {item = 'laptop_green', amount = 1}, -- Guaranteed laptop_green
    Blip = { label = 'ATM Robbery', size = 1.0, sprite = 161, colour = 1},
    MoneySymbol = '$',

    -- Notify function EDITABLE >> cl_utils.lua
    Notify = {
        [1] =  {'ATM Robbery', "Robbery Failed!", 5000, 'info'},
        [2] =  {'ATM Robbery', "There is an ATM robbery in the City! Marked on the map!", 5000, 'info'},
        [3] =  {'ATM Robbery', "Not enough Cops in the City!", 5000, 'error'},
        [4] =  {'ATM Robbery', "You can't start the robbery now!", 5000, 'error'},
        [5] =  {'ATM Robbery', "You have got", 5000, 'info'},
        [6] =  {'ATM Robbery', "Do not spam!", 5000, 'error'},
    }
}

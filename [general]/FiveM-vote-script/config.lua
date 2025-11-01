Config = {}

Config.trackyServerId = "2363246"
Config.trackyServerKey = "b9e97a2d817a57b26d0aaf75c5f061a3"
Config.identifier = "discord" -- If your players vote with Steam on Trackyserver.com leave this variable to the word **steam**. If your players vote with Discord set this variable to the word **discord**

--[[
    Add rewards for the votes here.

    It's simple to add rewards, as they're just commands.
    Just make sure the command is runnable by the console (ask the original developers about this)

    Format =  "numberofvotes" = array

    "numberofvotes" is the number of votes the player needs before they can get this reward
    the array is an array of commands to run.

    If the commands need them, they will be passed the following:
        {playerid} = The player server ID
        {playerlicence} = The player GTA licence
        {playername} = The player name
]]
Config.Rewards = {
    ["@"] = { -- @ = all votes
        "qbgivemoney {playerid} bank 10000", -- QBCore framework command
        "announce [VOTE] {playername} has voted and won $10000 ! Number of votes: {votescount}. Type /vote to vote"
    },
    ["10"] = { -- When the player has 10 votes
        "announce [VOTE] {playername} has voted 10 times !"
    },
    ["100"] = {
        "announce [VOTE] {playername} has 100 votes !"
    }
}

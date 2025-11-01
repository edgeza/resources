ServerConfig = {
    LogService = 'discord', -- fivemerr, discord, fivemanage

    Discord = {
        Title = 'Fishing Exploit - Cheating Log',
        Webhook = '',
        TagEveryone = true,
        Color = 16711680,
    },

    DistanceChecks = { -- If distance is too far, player will be kicked
        fisher = 10.0,
    },

    Sell = {
        Prices = {
            ['mullet'] = 1500,
            ['perch'] = 1500,
            ['bass'] = 2000,
            ['carp'] = 2250,
            ['trout'] = 2500,
            ['tuna'] = 3000,
            ['crab'] = 3500,
            ['lobster'] = 4000,
            ['turtle'] = 4000,
            ['octopus'] = 4500,
        },
        LimitMoney = 100000, -- Max money that can be earned from selling fishing at once
    },

    DropExploiter = true,
    BanExploiter = false,
    BanFunction = function(source, reason)
        -- Anticheat ban integration
        -- source = player in game id
        -- reason = reason for ban
    end,

    Shop = {}
}
----------------------------------------------------------
--- THIS FILE IS COMPLETELY SERVER SIDED FOR SECURITY ----
----------------------------------------------------------


ServerConfig = {
    LogService = 'fivemerr', -- fivemerr, discord, fivemanage
    LogApi = 'https://api.fivemerr.com/logs', -- not required if using fivemerr
    DropExploiter = true,

    DistanceChecks = { -- if player distance is higher than these values, they will be kicked
        ['fine'] = 20.0,
        ['armory'] = 20.0,
        ['jail'] = 20.0
    },

    FineLimit = 100000, -- Maximum fine amount
    QueryTimeout = 3, -- Query timeout in seconds
    ServiceLimit = 100, -- Maximum public service amount

    SeizeCashAutomaticallyOnRobbing = false, -- Seize cash automatically when robbing a player
    SeizeMoneyAccount = 'cash', -- cash, bank, black_money
}
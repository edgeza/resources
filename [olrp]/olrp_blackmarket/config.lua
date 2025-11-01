Config = {}

-- Black Market Door Locations
-- Add your door coordinates here
Config.DoorLocations = {
    {
        coords = vector3(-689.4, -82.89, 19.91), -- Your black market door coordinates
        heading = 0.0, -- Door heading (adjust as needed)
        model = 'prop_door_01', -- Door model (optional)
        label = 'Black Market Access',
        icon = 'fas fa-key',
        distance = 2.0
    },
    -- Add more doors if needed
    -- {
    --     coords = vector3(x, y, z),
    --     heading = 0.0,
    --     model = 'prop_door_01',
    --     label = 'Black Market Access',
    --     icon = 'fas fa-key',
    --     distance = 2.0
    -- }
}

-- Key Configuration
Config.KeyItem = 'blackmarketkey'
Config.KeyLabel = 'Black Market Key'

-- Black Market Rewards Configuration
-- Rewards are now configured in rewards.lua

-- Discord Webhook Configuration
Config.DiscordWebhook = {
    enabled = true,
    url = 'https://discord.com/api/webhooks/1416723038074048583/a-h5KiAEdRlwzrHdFfiFmuGlLB7SCVrVoDFNeWy6iixWdRtBAPulHySC7VvWqq4pDleu',
    botName = 'Black Market Security',
    colors = {
        success = 65280,    -- Green
        failed = 16711680,  -- Red
        info = 3447003      -- Blue
    }
}

-- Messages
Config.Messages = {
    noKey = 'You need a Black Market Key to access this door!',
    doorUnlocked = 'The door has been unlocked!',
    keyUsed = 'The ancient key crumbles to dust as you access the black market!',
    alreadyUnlocked = 'This door is already unlocked!',
    keyNotFound = 'Key not found in your inventory!',
    inventoryOpened = 'Black Market inventory opened!',
    inventoryClosed = 'Black Market inventory closed!'
}

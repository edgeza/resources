-- Black Market Rewards Configuration
-- Add your reward items here

Config.Rewards = {
    enabled = true, -- Set to false to disable rewards
    title = 'Black Market Access',
    description = 'Welcome to the Black Market. Take what you need.',
    items = {
        -- Format: {item = 'itemname', amount = 1, price = 0, label = 'Item Label'}
        -- Note: price = 0 means free items
        
        -- Weapons
        {item = 'weapon_pistol', amount = 1, price = 0, label = 'Pistol'},
        {item = 'pistol_ammo', amount = 50, price = 0, label = 'Pistol Ammo'},
        {item = 'weapon_knife', amount = 1, price = 0, label = 'Knife'},
        
        -- Tools
        {item = 'lockpick', amount = 5, price = 0, label = 'Lockpicks'},
        {item = 'phone', amount = 1, price = 0, label = 'Phone'},
        
        -- Medical
        {item = 'bandage', amount = 10, price = 0, label = 'Bandages'},
        {item = 'firstaid', amount = 2, price = 0, label = 'First Aid Kit'},
        
        -- Money (using cash instead of money)
        {item = 'cash', amount = 5000, price = 0, label = 'Cash'},
        
        -- Drugs (if you have them)
        -- {item = 'coke', amount = 5, price = 0, label = 'Cocaine'},
        -- {item = 'weed', amount = 10, price = 0, label = 'Weed'},
        
        -- Rare Items
        {item = 'diamond', amount = 3, price = 0, label = 'Diamond'},
        {item = 'goldbar', amount = 1, price = 0, label = 'Gold Bar'},
        
        -- Add more items as needed
        -- {item = 'itemname', amount = 1, price = 0, label = 'Item Label'},
    }
}

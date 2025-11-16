-- Black Market Rewards Configuration
-- Premium rewards - Better than Legendary Dropbox

Config.Rewards = {
    enabled = true, -- Set to false to disable rewards
    title = 'Black Market Access',
    description = 'Welcome to the Black Market. The best of the best awaits.',
    items = {
        -- Format: {item = 'itemname', amount = 1, price = 0, label = 'Item Label'}
        -- Note: price = 0 means free items
        
        -- Legendary Weapons (from dropbox but guaranteed/better amounts)
        {item = 'weapon_de', amount = 2, price = 0, label = 'Desert Eagle (x2)'},
        {item = 'weapon_krissvector', amount = 2, price = 0, label = 'Kriss Vector SMG (x2)'},
        {item = 'weapon_assaultrifle', amount = 2, price = 0, label = 'Assault Rifle (x2)'},
        {item = 'weapon_bullpuprifle_mk2', amount = 2, price = 0, label = 'Bullpup Rifle Mk2 (x2)'},
        {item = 'weapon_ak47m2', amount = 2, price = 0, label = 'AK-47 M2 (x2)'},
        
        -- Ammunition (Bulk - More than legendary dropbox)
        {item = 'rifle_ammo', amount = 100, price = 0, label = 'Rifle Ammo (100)'},
        {item = 'smg_ammo', amount = 100, price = 0, label = 'SMG Ammo (100)'},
        
        -- Armor & Equipment
        {item = 'heavyarmor', amount = 10, price = 0, label = 'Heavy Armor (x10)'},
        
        -- Jammers (3 guaranteed)
        {item = 'jammer', amount = 3, price = 0, label = 'Jammer (x3)'},
        
        -- Tier 4 Tools
        {item = 'hardeneddecrypter', amount = 3, price = 0, label = 'Hardened Decrypter (x3)'},
        {item = 'disruptor', amount = 2, price = 0, label = 'Disruptor (x2)'},
        
        -- Premium Cash (markedbills worth more than legendary dropbox)
        {item = 'markedbills', amount = 30, price = 0, label = 'Marked Bills (x30)'},
    }
}

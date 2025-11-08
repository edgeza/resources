

-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'Nights Software'
description 'Air Raid Sirens'
version '3.3.0'
url 'https://store.ea-rp.com'
lua54 'yes'

ui_page "index.html"
files{
    "index.html",
    'NUI/sounds/*.ogg',
    'NUI/*.js',
    'NUI/*.css',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
    'config/*.lua',
}

-- Usage Example Server Side

-- exports['night_air_raid_sirens']:TriggerAirRaidSirens(src, "air-raid-siren") -- Toggle automatically -> So on when off. Off when on.
-- exports['night_air_raid_sirens']:ToggleAirRaidSirens("air-raid-siren", true) -- Force on or off. true = on | false = off

server_exports { 
	'TriggerAirRaidSirens',
    'ToggleAirRaidSirens',
}

data_file 'DLC_ITYP_REQUEST' 'stream/neko_nw_ar_sirens.ytyp'

escrow_ignore {
    'config/config.lua',
    'server/s_functions.lua',
    'client/c_functions.lua',
}
dependency '/assetpacks'

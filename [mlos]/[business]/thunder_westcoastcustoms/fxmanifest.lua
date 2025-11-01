fx_version 'bodacious'
games { 'gta5' }
this_is_a_map "yes"
lua54 'yes'

client_scripts {"client.lua"}
files {"interiorproxies.meta"}

data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'

escrow_ignore {
    'stream/logo_editable/*.ytd',
    'client.lua'
} 




dependency '/assetpacks'
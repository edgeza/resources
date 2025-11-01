fx_version 'cerulean'
game 'gta5'

author 'BigoZ'
description 'Mapdata'
version '1.0.3'
contact 'https://discord.gg/fyF9UFKPZj'

this_is_a_map 'yes'
lua54 'yes'

shared_script 'config.lua'

server_script 'script/server/bigoz_mapdata_utils.lua'

client_script 'script/client/bigoz_entitysets.lua'

data_file 'DLC_ITYP_REQUEST' 'stream/bigoz-ytyp/**.ytyp'

files {
    'stream/bigoz-ytyp/**.ytyp'
}

escrow_ignore {
    'config.lua',
    'stream/**/*.ytd'
}
dependency '/assetpacks'
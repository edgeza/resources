

lua54 'yes'
fx_version 'cerulean'

game 'gta5'
this_is_a_map 'yes'

author 'Apollo Developments'
description 'M.C Clubhouse Paleto '
version '1.0.0'

files {
    'stream/occlusions/apollo_mc_paleto_game.dat151.rel',
    }


data_file 'AUDIO_GAMEDATA' 'stream/occlusions/apollo_mc_paleto_game.dat'


client_script 'client.lua'

escrow_ignore {
    'stream/ytd/*.ytd',
    'client.lua',
    }
    
    
dependency '/assetpacks'
fx_version 'cerulean'
game 'gta5'

author 'OLRP'
description 'OLRP Dropbox'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'reward_config.lua'
}

client_scripts {
    'bridge/client/**.lua',
    'config.lua',
    'cl_dropbox.lua'
}

server_scripts {
    'bridge/server/**.lua',
    'sv_config.lua',
    'sv_dropbox.lua'
}

escrow_ignore {
    'config.lua',
    'sv_config.lua',
    'reward_config.lua',
    'fxmanifest.lua'
}

fx_version 'cerulean'
lua54 'yes'
game "gta5"

author 'tstudio - ace'
description 'free box show mapping'
version '1.0.0'

this_is_a_map "yes"

-- What to run
client_scripts {
    'client/client.lua',
}

escrow_ignore {
    'client/client.lua'
}
dependency '/assetpacks'
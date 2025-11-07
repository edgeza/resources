fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author 'Custom flatbed towing by Cursor agent'
description 'Standalone flatbed towing script using ox_target / ox_lib with no escrow content.'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'ox_lib',
    'ox_target'
}


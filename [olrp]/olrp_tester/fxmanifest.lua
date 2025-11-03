fx_version 'cerulean'
game 'gta5'

author 'OLRP Development'
description 'OLRP Tester - Item spawner system for testing and development'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'ox_lib',
    'qbx_core'
}

lua54 'yes'


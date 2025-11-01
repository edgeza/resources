fx_version 'cerulean'
game 'gta5'

author 'OLRP'
description 'OLRP Black Market Access Script'
version '1.0.0'

shared_scripts {
    'config.lua',
    'rewards.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'ox_target',
    'ox_lib'
}
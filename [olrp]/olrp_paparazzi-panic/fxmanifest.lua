fx_version 'cerulean'
game 'gta5'

author 'OneLifeRP Development'
description 'Paparazzi Panic - Chaotic Celebrity Event'
version '1.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/paparazzi.lua'
}

server_scripts {
    'server/main.lua',
    'server/ransom.lua'
}

lua54 'yes'


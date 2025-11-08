fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'OLRP Development'
description 'Dynamic storm chasing gameplay for Qbox/QBCore servers'
version '0.1.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js'
}


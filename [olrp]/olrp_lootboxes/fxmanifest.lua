fx_version 'cerulean' 
game 'gta5'

author 'OLRP Development'
description 'OLRP Loot Cases - CS:GO Style Case Opening System'
ui_page 'web/build/index.html'
lua54 'yes'

client_script {
    'client.lua',
    'bridge/client/*',
}

server_script {
    'config.lua',
    'server.lua',
    'bridge/server/*',
}

escrow_ignore {
    'config.lua',
    'bridge/*',
}

files {
    'web/build/**/*'
}

dependencies {
    'qb-core',
    '/assetpacks'
}
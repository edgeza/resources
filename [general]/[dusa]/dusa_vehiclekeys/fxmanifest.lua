fx_version 'cerulean'
game 'gta5'
description 'Dusa Vehicle Keys'
author 'Dusa'
version '1.3.0-beta'
lua54 'yes'

shared_scripts {
    '@dusa_bridge/bridge.lua',
    'config.lua',
}

client_script 'client/main.lua'
server_scripts {
    'server/main.lua',
    'server/open_server.lua'
}

ui_page 'web/index.html'
files {
    'web/index.html',
    'web/assets/img/*',
    'web/assets/style/*',
    'web/script/*',
}

escrow_ignore {
    'config.lua',
    'server/open_server.lua',
}

bridge 'dusa_bridge'
dependency '/assetpacks'
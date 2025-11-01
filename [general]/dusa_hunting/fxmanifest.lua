fx_version 'cerulean'
game 'gta5'

author 'Dusa'
description 'Dusa Hunting Script'
version '0.9.7'

lua54 'yes'

shared_scripts {
    '@dusa_bridge/bridge.lua',
    'configurations/config_shared.lua',
    'game/opensource/functions.lua'
}

-- What to run
client_scripts {
    'configurations/config_client.lua',
    'game/client/*.lua',
    'game/client/hunt/*.lua',
    'game/modules/placer/client.lua',
    'game/modules/dui.lua'
}

server_scripts {
    'configurations/config_server.lua',
    'game/server/*.lua',
    'game/modules/placer/server.lua',
    'game/modules/placer/objects.lua'
}

ox_libs {
    'locale',
    'table',
    'math',
}

ui_page 'web/dist/index.html'

-- Files to include
files {
    'web/dist/index.html',
    'web/dist/assets/*.*',
    'web/dist/icon/*.*',
    'web/dist/images/*.*',
    'web/dist/mapStyles/**/*.*',

    'dui/index.html',
    'dui/js/*.*',
    'dui/assets/*.*',
    
    'assets/**/*.png',
    'assets/*.png',
    'locales/*.json'
}

dependency {
    'ox_lib',
    'dusa_bridge'
}

escrow_ignore {
    'configurations/*.lua',
    'locales/*.json',
    'game/opensource/functions.lua',
    'game/server/items.lua',
    'setup/*.lua',
    'types.lua',
    'game/modules/placer/objects.lua',
    'game/modules/placer/server.lua',
    'game/client/main.lua',
    'game/server/main.lua',
}

bridge 'dusa_bridge'

-- Data files
data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'
dependency '/assetpacks'
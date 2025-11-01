fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Dusa'
description 'Dusa Evidence System'
version '1.1.7-release'

-- Shared Scripts
shared_scripts {
    '@dusa_bridge/bridge.lua',
    'configurations/config.lua',
    'init.lua',
    'weapons.lua',
    'game/opensource/*.lua',
}

client_scripts {
    'game/evidence/*.lua'
}

ox_libs {
    'locale',
    'table',
    'math',
}

server_scripts {
    'game/serverside/*.lua',
}

-- UI Files
ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/*.png',
    'web/dist/*.glb',
    'web/dist/*.svg',
    'web/dist/assets/*.js',
    'web/dist/assets/*.png',
    'web/dist/assets/*.css',
    'web/dist/ammo/*.glb',
    'web/dist/bodyAnalysis/*.png',

    'game/opensource/*.lua',
    'configurations/config.lua',
    'locales/*.json',
    'assets/*.png',
}

-- Dependencies
dependencies {
    '/onesync',
    'dusa_bridge',
    'ox_lib',
}

escrow_ignore {
    'configurations/config.lua',
    'locales/*.json',
    'game/opensource/*.lua',
    'weapons.lua',
    'game/evidence/tablet.lua',
    'game/serverside/items.lua',
    'game/serverside/db.lua',
    'game/serverside/imgApi.lua',
}

bridge 'dusa_bridge'
dependency '/assetpacks'
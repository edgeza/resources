fx_version 'cerulean'
game 'gta5'

author 'Dusa'
description 'Dusa Police Job'
version '1.1.1-release'

shared_scripts {
    '@dusa_bridge/bridge.lua',
    'configurations/config.lua',
    'configurations/jobmenu.lua',
    'game/opensource/functions.lua',
    'game/opensource/table.lua',
    'keylist.lua'
}

client_scripts {
    'game/client/*.lua',
    'game/client/object/*.lua',
    'game/opensource/client_events.lua',
    'game/opensource/vehicles.lua',
    'locale.lua',
}

server_scripts {
    'game/server/*.lua',
    'game/server/object/*.lua',
    'configurations/serverconfig.lua',
    'game/opensource/server.lua',
    'game/opensource/callsign.lua',
    'game/opensource/items.lua',
    'game/opensource/server_events.lua',
}

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/assets/*.*',
    'web/dist/icon/*.*',
    'web/dist/images/*.*',
    'game/data/*.lua',
    'locales/*.json',
    'locale.lua',
    'assets/*.png',
    'assets/CustomVehicles/*.png',
}

dependency {
    'ox_lib',
    'dusa_bridge'
}

ox_libs {
    'locale',
    'table',
    'math',
}

escrow_ignore {
    'keylist.lua',
    'locale.lua',
    'configurations/*.lua',
    'game/opensource/*.lua',
    'game/data/*.lua'
}

bridge 'dusa_bridge'

lua54 'yes'

provide 'qb-policejob'
dependency '/assetpacks'
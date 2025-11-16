fx_version 'cerulean'
game 'gta5'

author 'Dusa'
description 'Dusa Chat'
version '1.0.1'

lua54 'yes'
shared_scripts {
    '@dusa_bridge/bridge.lua',
    'configuration/config_shared.lua',
}

client_scripts {
    'locale.lua',
    'configuration/config_client.lua',
    'client/*.lua'
}

server_scripts {
    'configuration/config_server.lua',
    'server/*.lua',
}

ox_libs {
    'locale'
}

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/assets/*.*',
    'web/dist/sounds/*.*',
    'locales/*.json',
    'locale.lua',
}

escrow_ignore {
    'configuration/*.lua',
    'server/logging.lua',
    'server/commands.lua',
    'client/functions.lua',
    'locale.lua',
}

bridge 'dusa_bridge'
dependency '/assetpacks'
fx_version 'cerulean'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
game 'gta5'

name 'dusa_fishing'
version '1.2.7'
description 'Dusa Fishing (Realistic Hook, New World Minigame)'


dependencies {
    '/server:5104',
    '/onesync',
    'ox_lib',
    'dusa_bridge'
}

shared_scripts {
    '@dusa_bridge/bridge.lua',
    'config.lua',
    'functions.lua',
    'locale.lua'
}

ox_libs {
    'locale',
    'table',
    'math',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'init.lua',
    'config_server.lua',
    'server.lua',
    'modules/mysql/server.lua',
    'modules/rod/server.lua',
    'modules/level/server.lua',
    'modules/shop/server.lua',
    'modules/tackle/server.lua',
    'modules/rental/server.lua',
    'server_handlers.lua',
}

client_scripts {
    'init.lua',
    'client.lua',
    'modules/fishing/client.lua',
    'modules/level/client.lua',
    'modules/minigame/client.lua',
    'modules/hook/client.lua',
    'modules/rod/client.lua',
    'modules/rod/physics.lua',
    'modules/shop/client.lua',
    'modules/shop/peds.lua',
    'modules/tackle/client.lua',
    'modules/task/client.lua',
    'modules/task/customize.lua',
    'modules/rental/client.lua',
    'client_handlers.lua',
}

files {
    'client.lua',
    'server.lua',
    'functions.lua',
    'locales/*.json',
	'web/dist/index.html',
	'web/dist/*.png',
	'web/dist/*.svg',
	'web/dist/assets/*.*',
	'web/dist/item/*.png',
	'web/dist/fish/*.png',
	'web/dist/hook/*.png',
	'web/dist/background/*.png',
    'modules/**/*.lua',
    'locale.lua'
}

ui_page 'web/dist/index.html'

escrow_ignore {
    "config.lua",
    "config_server.lua",
    "init.lua",
    "client.lua",
    "server.lua",
    "updater.lua",
    "functions.lua",
    "modules/task/customize.lua",
    "modules/shop/*.lua",
    "modules/mysql/server.lua",
    "locales/*.json",
    "modules/rental/*.lua",
    "client_handlers.lua",
    "server_handlers.lua",
}

bridge 'dusa_bridge'
dependency '/assetpacks'
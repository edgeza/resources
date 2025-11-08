fx_version 'cerulean'
lua54 'yes'
use_experimental_fxv2_oal 'yes'
game 'gta5'

name 'dusa_dispatch'
version '1.2.0' -- Release 
description 'Dusa Dispatch'


dependencies {
    '/server:5104',
    '/onesync',
    'ox_lib',
    'dusa_bridge',
}

shared_scripts {
    '@dusa_bridge/bridge.lua',
    'config.lua',
}

ox_libs {
    'locale',
    'table',
    'math',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'init.lua',
    'server.lua',
    'functions.lua',
    'modules/dispatch/commands.lua',
    'modules/compatibility/server/*.lua',
    'modules/**/server.lua',
    'edit/items.lua',
}

client_scripts {
    'init.lua',
    'keylist.lua',
    'functions.lua',
    'client.lua',
    'edit/handlers.lua',
    'modules/**/client.lua',
    'modules/compatibility/client/*.lua',
    'modules/dispatch/handlers.lua',
    'modules/dispatch/alerts.lua',
    'locale.lua'
}

files {
    'client.lua',
    'server.lua',
    'functions.lua',
    'keylist.lua',
    'locales/*.json',
	'web/dist/index.html',
	'web/dist/*.png',
	'web/dist/*.svg',
	'web/dist/assets/*.*',
	'web/dist/dispatch/*.*',
	'web/dist/icon/*.*',
	'web/dist/radar/*.*',
	'web/dist/mapStyles/**',
	'web/dist/sounds/*.*',
	'sounds/*.*',
    'modules/**/*.lua',
    'edit/*.lua',
}

ui_page 'web/dist/index.html'

escrow_ignore {
    "config.lua",
    "init.lua",
    "updater.lua",
    "functions.lua",
    "keylist.lua",
    "client.lua",
    "server.lua",
    "modules/utils/*.lua",
    "modules/dispatch/alerts.lua",
    "modules/dispatch/commands.lua",
    "modules/dispatch/handlers.lua",
    "modules/mysql/server.lua",
    "modules/compatibility/client/*.lua",
    "modules/compatibility/server/*.lua",
    "edit/*.lua",
}

provide 'ps-dispatch'
bridge 'dusa_bridge'
fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name 'dusa_hud'
version '1.3.5'
description 'Dusa Hud (10 Status - Speedometer Variation)'

ui_page 'web/dist/index.html'

dependencies {
    '/server:5104',
    '/onesync',
    'ox_lib',
    -- 'xsound'
}

files {
	'web/dist/index.html',
	'web/dist/assets/**',
	'web/dist/assets/*',
	'web/dist/assets/*.png',
    'locales/*.json',
}

shared_scripts {
    '@ox_lib/init.lua',
    'core/import.lua',
    'core/shared.lua',
    'init.lua',
    'config.lua',
    'locales/*.lua',
    'cache.lua',
    'utils.lua',
}

client_scripts {
    'core/playerload.lua',
    'core/**/client.lua',
    'modules/**/client.lua',
    'modules/**/functions.lua',
    'modules/*.lua',
    'utils.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'core/**/server.lua',
    'modules/db.lua',
    'modules/**/server.lua',
    'updater.lua',
}

escrow_ignore {
    "config.lua",
    "init.lua",
    "updater.lua",
    "utils.lua",
    "modules/commands.lua",
    "modules/cruise.lua",
    "modules/voip.lua",
    "modules/main/functions.lua",
    "modules/stress/*.lua",
    "modules/db.lua",
    "core/import.lua",
    "core/playerload.lua",
    "core/shared.lua",
    "core/esx/*.lua",
    "core/qb/*.lua",
    "locales/*.json",
    "locales/*.lua",
}
dependency '/assetpacks'
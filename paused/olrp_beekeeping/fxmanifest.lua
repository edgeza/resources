fx_version 'cerulean'
game 'gta5'

name 'mms-beekeeper'
author 'Markus Mueller - Converted to QBCore'
description 'QBCore Beekeeping Script - Converted from VORP'
version '1.3.0-qbcore'

lua54 'yes'

shared_scripts {
    '@qb-core/shared/locale.lua',
    '@ox_lib/init.lua',
    'config.lua',
    'shared/locale.lua',
    'languages/en.lua'
}

client_scripts {
    'client/client.lua',
    'client/menu_events.lua',
    'client/advanced_client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

dependencies {
    'qb-core',
    'qb-target',
    'oxmysql',
    'ox_lib',
    'jl_minigame',
    'bzzz_beehive_pack.pack',
    'qbx_core',
    'qs-inventory',
}

-- Custom bee sounds UI
ui_page 'html/index.html'

files {
    'html/index.html',
    'html/sound.js',
    'html/sounds/*.mp3'
}

-- Beehive pack integration handled by separate resource `bzzz_beehive_pack.pack`
-- (No local stream here)

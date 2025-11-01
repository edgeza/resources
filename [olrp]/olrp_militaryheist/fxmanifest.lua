fx_version 'cerulean'
game 'gta5'

author 'OneLifeRP Development'
description 'Military Heist at Los Santos Dam - QBCore/QBox Compatible'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/npcs.lua',
    'client/patrol.lua',
    'client/ui.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/events.lua'
}

dependencies {
    'qb-core',
    'oxmysql'
}

lua54 'yes'

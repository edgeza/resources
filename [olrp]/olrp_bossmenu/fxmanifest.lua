fx_version 'cerulean'
game 'gta5'

author 'OLRP'
description 'OLRP Boss Management System - Modern Midnight Red UI'
version '2.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/images/*.png'
}

dependencies {
    'qb-core',
    'oxmysql'
}

lua54 'yes'

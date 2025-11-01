

fx_version 'cerulean'
game 'gta5'
author 'CoreM © 2025'
description 'crm-core'
version '2.0.1'
lua54 'yes'

shared_scripts {
    'crm-config/crm-config.lua',
    'crm-main/crm-main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'crm-server/**/*.lua',
}

client_scripts {
    'crm-client/**/*.lua',
}

escrow_ignore {
    'crm-config/crm-config.lua',
}

ui_page 'crm-web/crm-interface.html'

files { 
    'crm-main/crm-init.lua',
    'crm-web/crm-interface.html',
    'crm-web/crm-scripts/*.js',
    'crm-web/crm-styles/*.css',
}

dependencies {
    'oxmysql',
}

dependency '/assetpacks'
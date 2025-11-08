fx_version 'cerulean'
game 'gta5'

author 'FABZ'
description 'FABZ Bike Shop - Bike shop resource'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
    'client/**/*.lua',
}

server_scripts {
    'server/**/*.lua',
}

files {
    'config.lua',
    'locales/*.json',
}

lua54 'yes'


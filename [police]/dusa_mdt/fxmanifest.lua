fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name 'dusa_mdt'
version '1.4.5'
description 'Dusa Police MDT (Mobile Data Terminal)'

ui_page 'web/index.html'

dependencies {
    '/server:5104',
    '/onesync',
    'ox_lib'
}

files {
    'locales/*.json',
    'data/hashes.json',
    'web/**',
}

shared_scripts {
    '@ox_lib/init.lua',
    'modules/callback.lua', 
    'config.lua',
    'init.lua',
    'class.lua',
    'modules/**/db.lua',
    'modules/**/shared.lua', 
}

client_scripts {
    'modules/**/client.lua',
    'modules/**/addon/client/*.lua',
    'modules/**/scripts/*.lua',
    'modules/**/zones.lua',
    'modules/**/dispatch.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'cache.lua',
    'modules/**/phone/*.lua',
    'modules/**/server.lua',
    'modules/**/server/*.lua',
}

escrow_ignore {
    "config.lua",
    "init.lua",
    "modules/bridge/**",
    "modules/utils/**",
    "modules/main/**",
    "modules/charges/**",
    "modules/db/**",
    "modules/housing/**",
    "modules/dispatch/dispatch.lua",
    'modules/**/scripts/*.lua',
    "data/**",
    "locales/**",
    'modules/callback.lua', -- credit to @pitermcflebor
}

exports{
    'SendDispatch'
}
dependency '/assetpacks'
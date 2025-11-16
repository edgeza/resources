fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'qs-books-creator'
author 'Quasar'
version '1.0.0'
description 'Interactive image-book using any URL with spreads. Built for inventory metadata + ox_lib + NUI'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locales/*.lua',
    'utils.lua'
}

client_scripts {
    'client/**/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/**/*.lua'
}

ui_page 'html/index.html'

files {
    'html/**/*'
}

escrow_ignore {
    'config.lua',
    'locales/*.lua',
    'client/custom/*.lua',
    'client/custom/framework/*.lua',
    'server/custom/framework/*.lua'
}

dependency '/assetpacks'
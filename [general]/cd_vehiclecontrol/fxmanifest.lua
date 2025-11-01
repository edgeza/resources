fx_version 'cerulean'
game 'gta5'
author 'discord.gg/codesign'
description 'Vehicle Control'
version '1.0.6'
lua54 'yes'

shared_scripts {
    'configs/locales.lua',
    'configs/config.lua',
    --'@ox_lib/init.lua' --⚠️PLEASE READ⚠️; Uncomment this line if you use 'ox_lib'.⚠️
}

client_scripts {
    'configs/client_customise_me.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page {
    'html/index.html',
}
files {
    'configs/locales_ui.js',
    'html/index.html',
    'html/assets/*.css',
    'html/assets/*.js'
}

dependencies {
    '/server:4960' -- ⚠️PLEASE READ⚠️; Requires at least server build 4960.
}

escrow_ignore {
    'client/functions.lua',
    'configs/*.lua',
    'server/version_check.lua'
}
dependency '/assetpacks'
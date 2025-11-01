fx_version 'cerulean'
game 'gta5'

author 'mic klk'
description 'Mic Vape Script https://discord.gg/86FPzAV73Bf'
version '1.0.0'
lua54 "yes"
client_scripts {
    'locales/main.lua',
    'locales/es.lua',
    'locales/de.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'locales/it.lua',
    'locales/pl.lua',
    'locales/pt.lua',
    'locales/ru.lua',
    'locales/tr.lua',
    'config.lua',
    'client/client.lua',
    'client/effects.lua',
    'client/progress.lua'
}

server_scripts {
    'locales/main.lua',
    'locales/es.lua',
    'locales/de.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'locales/it.lua',
    'locales/pl.lua',
    'locales/pt.lua',
    'locales/ru.lua',
    'locales/tr.lua',
    'config.lua',
    'server.lua'
}

files {
    'stream/mic_pink.ydr',
    'stream/mic_yellow.ydr',
    'stream/mic_white.ydr',
    'stream/mic_lightblue.ydr',
    'stream/mic_purple.ydr',
    'stream/mic_red.ydr',
    'stream/mic_green.ydr',
    'stream/mic_orange.ydr',
    'stream/mic_blue.ydr',
    'stream/mic_black.ydr',
    'stream/def_props.ytyp',
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

data_file 'DLC_ITYP_REQUEST' 'def_props.ytyp'

ui_page 'html/index.html'

escrow_ignore {
    'config.lua',
    -- 'server.lua',
    -- 'client/client.lua',
    -- 'client/effects.lua',
    -- 'client/progress.lua',
    'locales/es.lua',
    'locales/de.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'locales/it.lua',
    'locales/pl.lua',
    'locales/pt.lua',
    'locales/ru.lua',
    'locales/tr.lua'
}
dependency '/assetpacks'
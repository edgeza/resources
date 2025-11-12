----------------------------------------------------------------
----                   DUSADEV.TEBEX.IO                    	----
----------------------------------------------------------------
fx_version 'bodacious'
game 'gta5'
author 'dusadev.tebex.io'
description 'Dusa Guitar Zero'
version '1.0'

-- shared_script '@ox_lib/init.lua' -- If you using oxlib, remove "--"
shared_script 'config.lua'

ui_page {
	'web/index.html',
}

files {
	'web/index.html',
	'web/main.js',
    'web/assets/style/*.css',
    'web/assets/font/css/*.*',
    'web/assets/font/fonts/*.*',
    'web/assets/img/*.png',
    'web/assets/music/easy/*.mp3',
    'web/assets/music/fail/*.mp3',
    'web/assets/music/hard/*.mp3',
    'web/assets/music/medium/*.mp3',
}

client_script {
	'bridge/esx/client.lua',
	'bridge/qb/client.lua',
    'client/functions.lua',
    'client/client.lua',
    'client/objectspawner.lua',
}

server_script {
    '@mysql-async/lib/MySQL.lua',
	'bridge/esx/server.lua',
	'bridge/qb/server.lua',
	'server/server.lua',
	'server/updater.lua'
}


lua54 'yes'

escrow_ignore {
	'bridge/esx/client.lua',
	'bridge/qb/client.lua',
	'bridge/esx/server.lua',
	'bridge/qb/server.lua',
	'config.lua',
	'client/functions.lua',
	'server/updater.lua',
} 
dependency '/assetpacks'
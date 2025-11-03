----------------------------------------------------------------
----                   DUSADEV.TEBEX.IO                    	----
----------------------------------------------------------------
fx_version 'bodacious'
game 'gta5'
author 'dusadev.tebex.io'
description 'Dusa Billing'
version '1.2.3'

dependency 'dusa_bridge'

shared_scripts {
    '@dusa_bridge/bridge.lua',
    'config.lua'
}


client_scripts {
    "client/client.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'serverconfig.lua',
    "server/server.lua",
}

ui_page "web/index.html"

files {
    "web/index.html",
    "web/assets/**.**",
    "web/main.js",
    "web/vue.min.js",
}

lua54 'yes'

escrow_ignore {
	'config.lua',
	'serverconfig.lua',
    'client/client.lua',
    'server/server.lua'
} 

bridge 'dusa_bridge'
dependency '/assetpacks'
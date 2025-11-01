fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
description 'GKSPHONEv2'
version '2.0.17'

ui_page 'html/index.html'

shared_scripts {
    "config/config.lua",
	"config/functions.lua",
	"config/rentacar/sh_config.lua",
    "config/jobs/*",
}

files {
    "html/**/*",
    "config/config.json",
    "config/locales/*"
}

client_scripts {
    "callbacks.lua",
    "config/charge/*.lua",
    "config/signal/*.lua",
    "config/camera/*.lua",
	"client/**/*",
    "escrow/client/**/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "callbacks.lua",
    "config/*.lua",
	"config/rentacar/sv_config.lua",
    "config/charge/*.lua",
    "config/signal/*.lua",
    "server/**/*",
    "escrow/server/**/*",
}

-- Client Exports --
client_exports {
    'Notification',
	'SendNewMail',
    'SendNewMailOffline'
}

--- Server Exports ---
server_exports {
    'SendNewMail',
    'SendNewMailOffline',
    'sendNotification'
}


dependencies {
    "oxmysql"
}

escrow_ignore {
    "callbacks.lua",
    "config/*",
	"config/**/*",
    "server/**/*",
    "client/**/*"
}
dependency '/assetpacks'
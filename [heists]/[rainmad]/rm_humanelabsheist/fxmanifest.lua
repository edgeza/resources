fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    'config.lua'
}

server_scripts {
	'server.lua'
}

client_scripts {
	'client.lua',
    'editable_client.lua',
}

files {
    "sounds/sounds.html",
    "sounds/0x0A83C2F9.ogg",
    "sounds/0x02B30C41.ogg"
}

ui_page 'sounds/sounds.html'

escrow_ignore {
    '[items]',
    'client.lua',
    'config.lua',
    'editable_client.lua',
    'server.lua',
}
dependency '/assetpacks'
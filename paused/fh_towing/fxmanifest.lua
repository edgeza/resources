fx_version 'cerulean'

game 'gta5'

description 'Fivehead.eu flatbed script'
author 'Fuenf'
version '1.1.8'

lua54 'yes'

ui_page {
	'/html/index.html',
}

files {
	'html/index.html',
    'html/main.js',
    'html/style.css',
	'html/sounds/fh_towing_hydraulics1.ogg',
	'html/sounds/fh_towing_hydraulics2.ogg',
	'html/sounds/fh_towing_hydraulics3.ogg',
}

server_scripts {
	'server.lua'
}

client_scripts {
	'client.lua',
	'functions.lua',
}

shared_scripts {
	'config.lua',
}


escrow_ignore {
	'config.lua',
	'functions.lua'
}

dependency '/assetpacks'
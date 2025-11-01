fx_version 'adamant'
games { 'gta5' }

author 'Dimbo'
description 'Dimbo Password Hack Minigame'
version '1.0.0'

client_scripts {
    'config.lua',
    'client/client.lua',
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/*.css',
	'ui/*.js',
	'ui/*.png',
}

escrow_ignore {
	'config.lua',
	'client/*.lua',
	'server/*.lua',
	'ui/*.html',
	'ui/*.css',
	'ui/*.js'
}

lua54 'yes'
dependency '/assetpacks'
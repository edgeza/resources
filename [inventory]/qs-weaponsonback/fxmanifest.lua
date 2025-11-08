fx_version 'adamant'

game 'gta5'

lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
}

client_scripts {
	'client/**/*.lua',
	'client/custom/**/*.lua'
}

server_scripts {
	'server/**/*.lua'
}

escrow_ignore {
	'client/custom/**/*.lua'
}

dependencies {
	'/server:4752',
	'/assetpacks',
	'qs-inventory',
	'ox_lib'
}

dependency '/assetpacks'


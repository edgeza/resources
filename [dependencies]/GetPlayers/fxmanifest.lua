fx_version 'adamant'

game 'gta5'

server_scripts {
	'server.lua',
}

client_scripts {
	'client.lua',
}

server_exports {
	'GetPlayers'
}

client_exports {
	'SetPlayerSpawned',
	'IsPlayerSpawned',
	'GetStreamedTextures',
	'SaveStreamedTextures',
}





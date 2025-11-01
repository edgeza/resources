fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'BrunX Mods'
description 'BrunX Mods'
version '1.0.0'

this_is_a_map "yes"

data_file 'AUDIO_GAMEDATA' 'audio/lamesapd_game.dat'

files {
    "interiorproxies.meta",
	'audio/lamesapd_game.dat151.rel',
    'stream/*'
}

escrow_ignore {
	'stream/textures/*.ytd',
	'stream/vanilla/ydrs/*.ydr',
	'stream/vanilla/ybns/*.ybn',
	'stream/vanilla/ymaps/*.ymap',
}
dependency '/assetpacks'
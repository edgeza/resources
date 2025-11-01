

fx_version 'cerulean'
lua54        'yes'
game         'gta5'

name 'iak_skyclub_v3'
author 'Malibù Tech Team'
version '3.0.0'
description 'A state-of-the-art venue located a top the most beautiful skyscraper in Los Santos.'
discord 'https://discord.gg/tqk3kAEr4f'

this_is_a_map 'yes'
data_file 'AUDIO_GAMEDATA' 'audio/skyclub_game.dat'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'core/server_custom.lua',
  'core/server.lua'
}

client_scripts {
  'core/client.lua'
}

shared_scripts {
  'config.lua'
}

ui_page "web/index.html"

files {
  'web/index.html',
  'web/style.css',
  'web/index.js',
  'interiorproxies.meta',
  'audio/skyclub_game.dat151.rel'
}

escrow_ignore { 'config.lua', 'server_custom.lua' }
-- COORDS: -899.09, -444.63, 162.47




dependency '/assetpacks'
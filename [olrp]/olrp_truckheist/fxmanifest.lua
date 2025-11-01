fx_version 'cerulean'
game 'gta5'

author 'OLRP Development'
description 'OLRP CIT Heist - Advanced armored truck heist system with realistic mechanics'
version '1.0.1'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

-- Dependencies
dependencies {
    'ox_lib',      
    'ultra-voltlab' 
}


escrow_ignore {
    'config.lua', 
    'fxmanifest.lua',
    'Readme.md'    
}

lua54 'yes'
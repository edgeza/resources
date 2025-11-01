fx_version "cerulean"
game "gta5"
author '5Crime | discord.gg/5crime'
description '5Crime | FM Store Robbery'
version '1.0.1'
lua54 "yes"

shared_scripts {
    '@ox_lib/init.lua',
    'encrypted/shared.lua',
    "config.lua",
    "locale/*.lua"
}

client_scripts {
    "encrypted/client.lua",
    "encrypted/drill.lua",
}

server_scripts {
    "serverCfg.lua",
    "encrypted/server.lua",
}

escrow_ignore {
    'config.lua',
    "locale/*.lua",
    "serverCfg.lua",
    "docs/*.md"
}

dependencies {
    "ox_lib",
    "cfx-fm-supermarkets",
    "xsound"
}
dependency '/assetpacks'
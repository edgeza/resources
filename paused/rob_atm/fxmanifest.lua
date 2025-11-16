-- For support join my discord and create a ticket: https://discord.gg/Z9Mxu72zZ6

author "Andyyy#7666"
description "Pull ATM's from the wall and rob them"
version "2.0.0"

fx_version "cerulean"
game "gta5"
lua54 "yes"

data_file "DLC_ITYP_REQUEST" "stream/atm_robbery_main.ytyp"

escrow_ignore {
    "_INSTALLATION/**",
    "data/**/*.lua",
    "bridge/**/*.lua",
    "stream/nd_atms_txt.ytd",
    "source/shared/bridge.lua"
}

files {
    "data/**",
    "bridge/**"
}

shared_scripts {
    "@ox_lib/init.lua",
    "source/shared/**"
}

server_scripts {
    "source/modules/**/server.lua",
    "source/server/**"
}

client_scripts {
    "source/modules/**/client.lua",
    "source/client/**"
}

dependency '/assetpacks'
fx_version  "cerulean"
use_experimental_fxv2_oal   "yes"
lua54       "yes"
game        "gta5"

name        "olrp_radionames"
version     "2.0.0"
description "OLRP Radio Names v2 : Enhanced 3D radio list UI for PMA-VOICE"

ui_page "web/index.html"

files {
    "web/index.html"
}

shared_scripts {
    "shared/*.lua"
}

server_script {
    "module/**/server.lua",
    "server/*.lua"
}

client_script {
    "module/**/client.lua",
    "client/*.lua"
}


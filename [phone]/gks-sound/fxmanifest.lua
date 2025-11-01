fx_version "cerulean"
game "gta5"
title "GKSHOP - Sound"
description "GKSHOP - Sound"
author "GKSHOP"
lua54 "yes"
version "1.0.0"

client_scripts {
    "config.lua",
    "client.lua"
}

server_scripts {
    "server.lua"
}

files {
    "ui/dist/**/*"
}

ui_page "ui/dist/index.html"

escrow_ignore {
    "config.lua"
}
dependency '/assetpacks'
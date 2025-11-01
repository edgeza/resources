

fx_version "cerulean"
game "gta5"

author "bitc0de"

client_scripts {"config/shared.lua", "client/main.lua"}

server_scripts {"version.lua","config/shared.lua", "server/main.lua"}

ui_page "html/index.html"

files {"html/index.html", "html/script.js", "html/assets/*"}

escrow_ignore {
    "config/*.lua",
    "server/*.lua"
}

lua54 "yes"

dependency '/assetpacks'
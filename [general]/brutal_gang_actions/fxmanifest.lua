fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'Keres & Dév'
description 'Brutal Gang Menu - store.brutalscripts.com'
version '1.1.6'

data_file "DLC_ITYP_REQUEST" "stream/brt_rope.ytyp"

client_scripts { 
	'config.lua',
	'core/client-core.lua',
	'cl_utils.lua',
	'client/*.lua'
}

server_scripts { 
	'@mysql-async/lib/MySQL.lua', 
	'config.lua',
	'core/server-core.lua',
	'sv_utils.lua',
	'server/*.lua',
}

export 'CurrentPlayerAction'
export 'OpenActionsMenu'

shared_script {
	'@ox_lib/init.lua'
}

ui_page "html/index.html"
files {
	"html/index.html",
	"html/style.css",
	"html/script.js",
	"html/assets/**",
}

dependencies { 
    '/server:5181',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 5181
    '/gameBuild:2189',  -- ⚠️PLEASE READ⚠️; Requires at least GAME build 2189.
}

escrow_ignore {
	'config.lua',
	'cl_utils.lua',
	'sv_utils.lua',
	'core/client-core.lua',
	'core/server-core.lua',
}
dependency '/assetpacks'
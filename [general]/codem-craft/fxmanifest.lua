fx_version 'cerulean'
game 'gta5'
author 'Aiakos#8317'
description 'Codem-Craft'
version '1.3.3'

ui_page {
	'html/index.html',
}

files {
	'html/style.css',
	'html/responsive.css',
	'html/*.js',
	'html/*.html',
	'html/images/*.png',
	'html/images/items/*.png',
	'html/fonts/*.otf',
	'html/*.ogg',

}

shared_script{
	'config.lua',
	'GetFrameworkObject.lua',
	
}

escrow_ignore {
	'config.lua',
	'GetFrameworkObject.lua',
	'server/commands.lua',
	'server/discord.lua',
	'server/xp.lua',
	'server/itemcallback.lua',
	'client/editable.lua',
    'server_config.lua',
}

client_scripts {
	'GetFrameworkObject.lua',
	'client/*.lua',
}
server_scripts {
	'server/discord.lua',
	'server_config.lua',
	'server/main.lua',
	'server/xp.lua',
	'server/commands.lua',
	'server/itemcallback.lua',
    -- '@mysql-async/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'mysql-async'.⚠️
    '@oxmysql/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Uncomment this line if you use 'oxmysql'.⚠️
}

lua54 'yes'

dependency '/assetpacks'
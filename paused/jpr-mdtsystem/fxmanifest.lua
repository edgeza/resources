fx_version 'adamant'

game 'gta5'
version '1.0'

ui_page 'html/index.html'

shared_scripts {
    'configs/main_config.lua',
    'configs/get_framework_config.lua'
}

client_scripts {
    'configs/main_config.lua',
    'configs/client_config.lua',
    'mainSystem/client/client.lua',
    'mainSystem/client/functions.lua',
    'mainSystem/client/dispatch.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'configs/main_config.lua',
    'configs/server_config.lua',
    'mainSystem/server/server.lua',
    'mainSystem/server/functions.lua',
}

files {
    'html/*.html',
    'html/css/*.css',
    'html/css/fonts/*.otf',
    'html/js/*.js',
    'html/sounds/*.mp3',
    'html/img/*.png',
    'html/img/categories/*.png',
    'html/img/houses/*.png',
    'html/img/vehicles/*.png',
    'html/img/people/*.png',
    'html/img/injuries/*.png',
    'html/img/banks/*.jpg',
}

exports {
    "sendDispatchAlert"
}

lua54 'yes'

escrow_ignore {
	'configs/*.lua',
}
dependency '/assetpacks'
description 'cl'
name ' cl'
author 'bp_prophunt'
version 'v1.0.0'



shared_scripts {
	"@ox_lib/init.lua",
}

ui_page 'html/index.html'


files {
  'html/index.html',
  'html/*.js',
  'html/*.css',
  'html/sounds/*.ogg',
  'html/sounds/*.wav',
  'html/*.png',
  'html/*.jpg',
  'html/*.svg',
  'html/*.ttf'




}

client_scripts {
  'config.lua',
  'framework/cl_wrapper.lua',
  'client.lua'


}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
  'config.lua',
  'framework/sv_wrapper.lua',
  'server.lua'
}


lua54 'yes'

escrow_ignore {
  'framework/cl_wrapper.lua',
  'framework/sv_wrapper.lua',
  'config.lua',
}



fx_version 'adamant'
games {'gta5'}
dependency '/assetpacks'
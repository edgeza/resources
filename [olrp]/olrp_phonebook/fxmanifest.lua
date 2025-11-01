fx_version 'cerulean'
game 'gta5'

name 'OLRP_Phonebook'
author 'OLRP'
description 'Glossy city phonebook with 3D UI for QBox. Opens with /phonebook.'
lua54 'yes'

ui_page 'html/index.html'

files {
  'html/index.html',
  'logo.png'
}

shared_scripts {
  '@qb-core/shared/locale.lua'
}

client_scripts {
  'client/main.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}

dependencies {
  'qb-core'
}



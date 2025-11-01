fx_version 'adamant'
games { 'gta5' }

mod 'AP QUESTIONARE'
version '0.01'

lua54 'yes'

ui_page 'html/index.html'

files {
    'html/*.*'
}

client_scripts {
  'client/main.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
}

exports {
  'StartExam',
}
dependency '/assetpacks'
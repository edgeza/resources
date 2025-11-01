server_script 'hunk_sv.lua'
client_script 'hunk.lua'




----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

fx_version 'cerulean'

game 'gta5'

author 'CASE#1993'

description 'BOII | Development - Activity: Mining (QBox Compatible)'

version '2.0.2'

lua54 'yes'

ui_page 'html/guide.html'

files {
    'html/**/*',
}
shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/language.lua'
}
client_scripts {
    'client/**/*'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*'
}
escrow_ignore {
    'shared/*',
    'client/**/*',
    'server/*',
    'doorlocks/*'
}
dependencies {
    'qbx_core',
    'ox_target',
    'ox_lib'
}
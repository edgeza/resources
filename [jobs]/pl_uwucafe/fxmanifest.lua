fx_version 'cerulean'
games { 'gta5' }

author 'PulseScripts - pulsescripts.com'
description 'Uwu Cat Cafe'
version '2.0.9'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/location.lua',
    'shared/deliverycoords.lua',
    'locales/locale.lua',
    'shared/recipe.lua',
    'client/modules/Imagespath.lua',
    'shared/autodetect.lua'
}

client_scripts {
    'client/bridge/*',
    'client/modules/*',
    'client/unlocked.lua',
    'client/IceMachine.lua',
    'client/custombilling.lua',
    'client/cats.lua',
    'client/toys.lua',
    'client/main.lua',
    'client/delivery.lua',
    'targets/*'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/bridge/*',
    'server/modules/*',
    'server/main.lua',
    'server/unlocked.lua',
    'server/version.lua',
    'server/IceMachine.lua',
    'server/custombilling.lua',
    'server/cats.lua',
    'server/toys.lua',
    'server/delivery.lua',
    'server/Log.lua'
}

dependencies {
    'ox_lib',
    'oxmysql'
}

ui_page 'web/index.html'

files {
    'locales/*.json',
    'web/*',
    'web/assets/*'
}

escrow_ignore {
    'readme.md',
    'Installfolder/*',
    'client/unlocked.lua',
    'client/IceMachine.lua',
    'client/delivery.lua',
    'client/bridge/*',
    'client/modules/*',
    'server/cats.lua',
    'server/toys.lua',
    'shared/*',
    'targets/*',
    'server/bridge/*',
    'server/modules/*',
    'server/IceMachine.lua',
    'server/unlocked.lua',
    'server/Log.lua',
    "locales/**.json",
}
dependency '/assetpacks'
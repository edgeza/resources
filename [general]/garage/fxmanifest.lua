fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

game 'gta5'

author 'Dusa'
version '1.0.0-beta-test'
description 'Dusa Garage Management System'
bridge 'dusa_bridge'

dependencies {
    'dusa_bridge',
    'oxmysql',
    'ox_lib'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@dusa_bridge/bridge.lua',
    'config/*.lua',
    'shared/utils/debug.lua',
    'shared/utils/debug_commands.lua',
    'modules/mileage/config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/core/*.lua',
    'server/main.lua',
    'server/commands.lua', -- Server-side command system (secure)
    'server/api/*.lua',
    'modules/mileage/server.lua',
    -- 'tests/run_all_tests.lua'
}

client_scripts {
    'client/utils.lua',  -- Load utils first for callback registration
    'client/core/*.lua',
    'client/main.lua',
    'client/commands.lua', -- Client event handlers (triggered by server commands)
    -- 'client/commands/*.lua', -- REMOVED: Test commands deleted for security
    'client/api/*.lua',
    'modules/mileage/client.lua',
    -- Test runner (comment out in production)
    'tests/run_mileage_tests.lua'
}

ui_page 'build/index.html'
-- ui_page 'http://localhost:3000/' -- for dev

files {
    'build/**',
    'build/**/**',
    'sounds/*.ogg',
    'locales/*.json',
    'tests/**/*.lua',
    'client/core/*.lua',
    'presets/*.lua'
}

escrow_ignore {
    'override.lua',
    'config/*.lua',
    'shared/*.lua',
    'shared/utils/*.lua',
    'server/api/*.lua',
    'server/core/modules/*.lua',
    'server/core/validation.lua',
    'client/core/help_menu.lua',
    'client/core/bridge_events.lua',
    'client/commands.lua',
    'client/utils.lua',
    'modules/mileage/*.lua',
    'tests/*.lua',
    'presets/*.lua'
}
dependency '/assetpacks'
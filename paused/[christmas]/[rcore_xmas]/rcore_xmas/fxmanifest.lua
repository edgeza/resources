fx_version 'cerulean'
game 'gta5'

description 'rcore xmas'
author 'maku#5434 (itismaku)'
version '1.10.1'
lua54 'yes'

shared_scripts {
    'shared/sh-const.lua',

    'config.lua',

    'shared/sh-utils.lua',
    'shared/sh-table.lua',

    -- 'shared/sh-locale.lua',
    -- 'locales/*.lua',

    'shared/present-hunt/sh-positions.lua',
}

client_scripts {
    'client/cl-utils.lua',

    'client/bridge/cl-bridge.lua',

    'client/bridge/framework/cl-esx.lua',
    'client/bridge/framework/cl-qbcore.lua',
    'client/bridge/framework/cl-standalone.lua',

    'client/bridge/inventory/cl-esx_inventory.lua',
    'client/bridge/inventory/cl-ox_inventory.lua',
    'client/bridge/inventory/cl-qb_inventory.lua',
    'client/bridge/inventory/cl-qs_inventory.lua',
    'client/bridge/inventory/cl-mf_inventory.lua',
    'client/bridge/inventory/cl-ps_inventory.lua',
    'client/bridge/inventory/cl-lj_inventory.lua',
    'client/bridge/inventory/cl-core_inventory.lua',
    'client/bridge/inventory/cl-chezza_inventory.lua',

    'client/bridge/target/cl-none.lua',
    'client/bridge/target/cl-ox_target.lua',
    'client/bridge/target/cl-qb_target.lua',
    'client/bridge/target/cl-qtarget.lua',

    'client/snowballs/cl-pickup.lua',

    'client/present-hunt/cl-objects.lua',
    'client/present-hunt/cl-hunt.lua',
    'client/present-hunt/cl-blips.lua',

    'client/snowman/cl-objects.lua',
    'client/snowman/cl-build.lua',
    'client/snowman/cl-fire.lua',
    'client/snowman/cl-admin.lua',

    'client/gifts/cl-gifts.lua',

    'client/trees/cl-build.lua',
    'client/trees/cl-objects.lua',
    'client/trees/cl-decorate.lua',
    'client/trees/cl-stashes.lua',
    'client/trees/cl-admin.lua',

    'client/cl-prop_place.lua',
    'client/cl-main.lua',
    'client/cl-api.lua',
    'client/cl-cancellable_progress.lua',
    'client/cl-selection.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',

    'config.server.lua',

    'server/sv-asset-deployer.lua',

    'server/sv-log.lua',

    'server/bridge/sv-bridge.lua',

    'server/sv-main.lua',

    'server/bridge/database/sv-ghmatti.lua',

    'server/bridge/framework/sv-esx.lua',
    'server/bridge/framework/sv-qbcore.lua',
    'server/bridge/framework/sv-standalone.lua',

    'server/bridge/inventory/sv-esx_inventory.lua',
    'server/bridge/inventory/sv-ox_inventory.lua',
    'server/bridge/inventory/sv-qb_inventory.lua',
    'server/bridge/inventory/sv-qs_inventory.lua',
    'server/bridge/inventory/sv-mf_inventory.lua',
    'server/bridge/inventory/sv-ps_inventory.lua',
    'server/bridge/inventory/sv-lj_inventory.lua',
    'server/bridge/inventory/sv-core_inventory.lua',
    'server/bridge/inventory/sv-chezza_inventory.lua',
    'server/bridge/inventory/sv-ak47_inventory.lua',
    'server/bridge/inventory/sv-origen_inventory.lua',

    'server/snowballs/sv-pickup.lua',

    'server/present-hunt/sv-database.lua',
    'server/present-hunt/sv-hunt.lua',

    'server/snowman/sv-build.lua',
    'server/snowman/sv-objects.lua',
    'server/snowman/sv-fire.lua',
    'server/snowman/sv-admin.lua',

    'server/gifts/sv-gifts.lua',

    'server/trees/sv-database.lua',
    'server/trees/sv-persist.lua',
    'server/trees/sv-stashes.lua',
    'server/trees/sv-build.lua',
    'server/trees/sv-admin.lua',
    'server/trees/sv-objects.lua',

    'server/sv-api.lua',
    'server/sv-weather.lua',
}

escrow_ignore {
    'config.lua',
    'config.server.lua',

    'shared/sh-const.lua',
    'shared/sh-table.lua',
    'shared/sh-utils.lua',
    'shared/present-hunt/sh-positions.lua',

    'server/bridge/database/sv-*.lua',
    'server/bridge/framework/sv-*.lua',
    'server/bridge/inventory/sv-*.lua',
    'server/present-hunt/sv-database.lua',
    'server/trees/sv-database.lua',
    'server/trees/sv-stashes.lua',
    'server/trees/sv-persist.lua',

    'server/sv-api.lua',
    'server/sv-weather.lua',
    'server/sv-log.lua',

    'client/cl-utils.lua',
    'client/bridge/framework/cl-*.lua',
    'client/bridge/inventory/cl-*.lua',
    'client/bridge/target/cl-*.lua',
    'client/gifts/cl-gifts.lua',
    'client/trees/cl-stashes.lua',
    'client/trees/cl-admin.lua',
    'client/snowman/cl-admin.lua',
    'client/cl-api.lua',
    'client/cl-cancellable_progress.lua',
}

dependencies {
    'rcore_xmas_assets',
    '/assetpacks'
}

dependency '/assetpacks'
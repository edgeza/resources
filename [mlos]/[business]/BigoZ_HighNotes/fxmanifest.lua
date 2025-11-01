fx_version 'cerulean'
game 'gta5'

author 'BigoZ'
description 'HighNotes'
version '1.0.5'
contact 'https://discord.gg/fyF9UFKPZj'

this_is_a_map 'yes'
lua54 'yes'

dependencies { 
    '/gameBuild:2545',  -- ⚠️ Requires at least GAME build 2545.
    'cfx-bigoz-mapdata'
}

server_script 'bigoz_highnotes_versioncheck.lua'

client_scripts {
    'bigoz_highnotes_elevator.lua',
    'musicrooftop.lua',
    'client.lua',
    'common.lua'
}

data_file "SCENARIO_POINTS_OVERRIDE_PSO_FILE" "rockford_west.ymt"
data_file 'DLC_ITYP_REQUEST' 'stream/bigoz_rooftop_props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vanilla/int_services.ytyp'

escrow_ignore {
    'stream/[logos]/*.ydr',
    'stream/**/*.ytd'
}
dependency '/assetpacks'
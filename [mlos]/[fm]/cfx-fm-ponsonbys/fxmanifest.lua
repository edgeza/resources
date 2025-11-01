fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'FM'
description 'PONSONBYS'
version '1.0'

this_is_a_map 'yes'


data_file 'TIMECYCLEMOD_FILE' 'fm_timecycle_list_ponsonbys.xml'
data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'

files {
    'fm_timecycle_list_ponsonbys.xml',
    'stream/**.ytyp',

}



escrow_ignore {
    'stream/[editable]/fm_ponsonbys_logo_01.ydr',
  }
dependency '/assetpacks'
fx_version 'cerulean'
game 'gta5'

author 'PDM'
description 'Formula 1 Cars - Custom Handling Data'
version '1.0.0'

files {
    'data/pdm_f1/handling.meta',
    'data/data-cw2019/handling.meta',
    'data/data-cw2019/vehicles.meta',
    'data/data-cw2019/carcols.meta',
    'data/data-cw2019/carvariations.meta',
    'data/data-cw2019/vehiclelayouts_cw2019.meta',
    'data/data-cw2019/dlctext.meta',
    'stream/*.yft',
    'stream/*.ytd'
}

data_file 'HANDLING_FILE' 'data/pdm_f1/handling.meta'
data_file 'HANDLING_FILE' 'data/data-cw2019/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/data-cw2019/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/data-cw2019/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/data-cw2019/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/data-cw2019/vehiclelayouts_cw2019.meta'
data_file 'DLCTEXT_FILE' 'data/data-cw2019/dlctext.meta'

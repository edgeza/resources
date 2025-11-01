fx_version 'cerulean'
games {'gta5'}
lua54 'yes'
files {
    "stream/props/dusa_hunting_main.ytyp",    
    "stream/props/dusa_hunting_metal_grill.ytyp",    
    "stream/props/dusa_hunting_extra.ytyp",  
    "stream/props/ft-huntingprops.ytyp",
    '**/weaponcomponents.meta',
	'meta/weaponarchetypes.meta',
	'meta/weaponanimations.meta',
	'meta/pedpersonality.meta',
	'meta/weapons.meta',
}

data_file 'WEAPONCOMPONENTSINFO_FILE' '**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'meta/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'meta/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' 'meta/weapons.meta'

data_file "DLC_ITYP_REQUEST" "stream/props/dusa_hunting_main.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/props/dusa_hunting_metal_grill.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/props/dusa_hunting_extra.ytyp"
data_file 'DLC_ITYP_REQUEST' 'stream/props/ft-huntingprops.ytyp'

client_script 'cl_weaponNames.lua'
dependency '/assetpacks'
fx_version 'cerulean'

games {'gta5'}

lua54 'yes'

client_scripts {

    'vehicle_names.lua'
   } 
 
files {
	
    '*.meta',	

}



escrow_ignore {
  '*.meta',
  'stream/*.ytd',    
    

}




data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'


 
dependency '/assetpacks'

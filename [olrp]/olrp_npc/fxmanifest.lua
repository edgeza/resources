fx_version 'cerulean'
game 'gta5'

author 'OLRP'
description 'Dynamic NPC Density System - Adjusts NPC density based on player count. Applies density every frame to ensure it works correctly.'
version '2.0.0'
lua54 'yes'

-- Optional dependency: works with or without qbx_density
-- If qbx_density exists, this script will sync with it
-- This script will override qbx_density's settings by running every frame
dependencies {
    'qbx_core' -- Required for GlobalState.PlayerCount
}

shared_script 'config.lua'
client_script 'client.lua'

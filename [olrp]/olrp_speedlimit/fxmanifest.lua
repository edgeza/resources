fx_version 'cerulean'
game 'gta5'

author 'OLRP'
description 'OLRP Speed Limit - Efficient vehicle speed limiter for server performance'
version '1.0.0'
lua54 'yes'

-- ==============================================
-- ESCROW IGNORE - Files that remain editable
-- ==============================================
escrow_ignore {
    'config.lua'            -- Main configuration file
}

-- ==============================================
-- SHARED SCRIPTS
-- ==============================================
-- No shared scripts needed for minimal limiter

-- ==============================================
-- ESCROWED CORE FILES (PROTECTED BY TEBEX)
-- ==============================================
client_scripts {
    'config.lua',                   -- Load config first
    'escrowed/cl_speedlimit.lua'    -- Minimal client-only limiter
}


-- No server scripts required

dependency '/assetpacks'

fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'Keres & Dév'
description 'Brutal GYM & SKILLS [V2] - store.brutalscripts.com'
version '2.6.9'

client_scripts { 
	"config.lua",
	"core/client-core.lua",
	"client/*.lua",
	"gym-cl_utils.lua",
	"skills-cl_utils.lua"
}

server_scripts { 
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"core/server-core.lua",
	"server/*.lua"
}

shared_script {
	'@ox_lib/init.lua'
}

export 'gymDoExercises'
export 'GetSkillCount'
export 'AddSkillCount'
export 'RemoveSkillCount'

ui_page "html/index.html"

files {
	"html/index.html",
	"html/style.css",
	"html/script.js",
}

dependencies { 
    '/server:5181',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 5181
    '/gameBuild:2189',  -- ⚠️PLEASE READ⚠️; Requires at least GAME build 2189.
}

escrow_ignore {
	'config.lua',
	'core/client-core.lua', 
	'core/server-core.lua', 
	'gym-cl_utils.lua',
	'skills-cl_utils.lua',
}

--[[
-- locked
escrow_ignore {
	'config.lua',
	'core/client-core.lua', 
	'core/server-core.lua', 
	'gym-cl_utils.lua',
	'skills-cl_utils.lua',
}

-- open
escrow_ignore {
    'config.lua',
	'core/client-core.lua', 
	'core/server-core.lua', 
	'gym-cl_utils.lua',
	'skills-cl_utils.lua',
    'client/gym-client.lua',
    'client/skills-client.lua',
    'server/gym-server.lua',
    'server/skills-server.lua',
    'server/webhook.lua',
}
--]]
dependency '/assetpacks'
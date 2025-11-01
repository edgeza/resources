Config = Config or {}

local esxHas = GetResourceState('es_extended') == 'started'
local qbHas = GetResourceState('qb-core') == 'started'
local qbxHas = GetResourceState('qbx_core') == 'started'

Config.Framework = esxHas and 'esx' or qbHas and 'qb' or qbxHas and 'qb' or 'esx'

-- Marker configuration for the shop locations
Config.Marker = { 
    type = 2, -- Marker type (refer to GTA marker types)
    scale = {x = 0.2, y = 0.2, z = 0.1}, -- Marker scale
    colour = {r = 71, g = 181, b = 255, a = 120}, -- Marker color with transparency (RGBA)
    movement = 1 -- Marker animation (0 = no movement, 1 = with movement)
}

-- Shop configuration
Config.Shops = {

}

--[[
    Welcome to the qb-deathmatch configuration!
    To start configuring your new asset, please read carefully
    each step in the documentation that we will attach at the end of this message.

    Each important part of the configuration will be highlighted with a box.
    like this one you are reading now, where I will explain step by step each
    configuration available within this file.

    This is not all, most of the settings, you are free to modify it
    as you wish and adapt it to your framework in the most comfortable way possible.
    The configurable files you will find all inside client/custom/*
    or inside server/custom/*.

    Direct link to the resource documentation, read it before you start:
    https://docs.quasar-store.com/
]]

Config = Config or {}
Locales = Locales or {}

-- AuthorizedMaps configuration - ensure it's loaded early
Config.AuthorizedMaps = {
	'Arena1',
	'Arena2',
	'Arena3',
	'Arena4',
	'Arena5'
}

--[[
    The first thing will be to choose our main language, here you can choose
    between the default languages that you will find within locales/*,
    if yours is not there, feel free to create it!

	Languages available by default:
        'ar'
        'bg'
        'ca'
        'cs'
        'da'
        'de'
        'el'
    	'en'
    	'es'
        'fa'
        'fr'
        'he'
        'hi'
        'hu'
        'it'
        'jp'
        'ko'
        'nl'
        'no'
        'pl'
        'pt'
        'ro'
        'ru'
        'sl'
        'sv'
        'th'
        'tk'
        'tr'
        'zh'
]]

Config.Language = 'en'

--[[
    The current system will detect if you use qb-core or es_extended,
    but if you rename it, you can remove the value from Config.Framework
    and add it yourself after you have modified the framework files inside
    this script.

    Please keep in mind that this code is automatic, do not edit if
    you do not know how to do it.
]]

local frameworks = {
	['es_extended'] = 'esx',
	['qb-core'] = 'qb',
	['qbx_core'] = 'qb'
}

local function dependencyCheck(data)
	for k, v in pairs(data) do
		if GetResourceState(k) == 'started' then
			return v
		end
	end
	return false
end

Config.Framework = 'qb'
Config.FiveGuard = false -- Your fiveguard script name if exists, if not false.

--[[
	Automatic ambulance system check!
]]

local ambulances = {
	['qb-ambulancejob'] = 'qb',
	['esx_ambulancejob'] = 'esx',
	['wasabi_ambulance'] = 'wasabi',
	['brutal_ambulancejob'] = 'brutal',
	['ars_ambulancejob'] = 'ars',
	['qbx_medical'] = 'qbx',
	['p_ambulancejob'] = 'piotreq',
	['qs-hospital-creator'] = 'qs',
	['ak47_qb_ambulancejob'] = 'ak47qb',
	['ak47_ambulancejob'] = 'ak47'
}

Config.Ambulance = 'brutal'

--[[
    This section is configurable for inventory locking during Deathmatch. It depends on your inventory system, as it requires multiple events from it.
    To configure another inventory system, simply replicate these steps in client/custom/inventory/* and you're done!

	Only recomended edit in ox, nothing more.
]]

local inventories = {
	['ox_inventory'] = 'ox',
	['qb-inventory'] = 'qb-inventory',
	['qs-inventory'] = 'qs'
}

Config.Inventory = 'qs'

--[[
    This section allows customization of the Deathmatch entrance spot, including coordinates and the blip on the map.
    If you prefer not to use a static entrance spot, you can disable `Config.SpotEnable` and instead use the `dmopen` command with `ExecuteCommand`.

    Example:

    -- Disabling the spot
    Config.SpotEnable = false

    -- Using ExecuteCommand to open the Deathmatch menu manually
    RegisterCommand("openDeathmatch", function()
        ExecuteCommand("dmopen")
    end, false)

    -- You can then bind this command to a key or trigger it from another event
]]

Config.SpotEnable = true

Config.Marker = {
	DrawDistance = 10,
	Pos = vector3(-275.3, -2038.47, 29.15),
	Type = 1,
	Size = vector3(5.0, 5.0, 2.0),
	Color = { r = 255, g = 255, b = 255 }
}

Config.Blip = {
	Enable = true,
	SetBlipSprite = 437,
	SetBlipScale = 0.6,
	SetBlipColour = 36,
}

--[[
    This section defines the coordinates and settings for the characters that will be displayed before the match starts, including their posing animations and cinematic camera.

    - `Config.InvisibleSpawnCoords`: This is where the player will be spawned but remain invisible while the cinematic camera focuses on the characters.

    - `Config.PedSpawnLocs`: These are the coordinates where each character will spawn and pose before the match. Each entry consists of a `vec4` format with x, y, z coordinates and a heading to determine the direction the character will face.

    - `Config.CamPos`: This defines the position of the cinematic camera that will focus on the characters. The camera will be set up here to create a dynamic pre-match scene.

    - `Config.Anims`: A list of animations that the characters will perform while posing. Each animation includes:
      - `dict`: The animation dictionary.
      - `name`: The specific animation name.

    These settings allow for a cinematic presentation of the characters before the match begins. You can customize the camera, character positions, and animations to create the desired pre-match atmosphere.
]]

Config.InvisibleSpawnCoords = vec3(1170.10, -1264.40, 20.25)
Config.PedSpawnLocs = {
	[1] = vec4(1127.20, -1263.80, 19.60, 44.13),
	[2] = vec4(1129.10, -1263.40, 19.65, 44.13),
	[3] = vec4(1127.10, -1264.90, 19.60, 44.13),
	[4] = vec4(1128.30, -1263.70, 19.75, 44.13),
	[5] = vec4(1126.80, -1265.90, 19.60, 44.13),
}

Config.CamPos = vec3(1126.08, -1262.42, 21.0)
Config.Anims = {
	{
		dict = 'anim@amb@nightclub@peds@',
		name = 'rcmme_amanda1_stand_loop_cop'
	},
	{
		dict = 'mp_player_int_uppergang_sign_a',
		name = 'mp_player_int_gang_sign_a'
	},
	{
		dict = 'amb@world_human_leaning@male@wall@back@foot_up@idle_a',
		name = 'idle_a'
	},
	{
		dict = 'amb@world_human_stupor@male@idle_a',
		name = 'idle_a'
	},
	{
		dict = 'anim@mp_player_intupperslow_clap',
		name = 'idle_a'
	},
	{
		dict = 'rcmbarry',
		name = 'base'
	},
	{
		dict = 'anim@mp_player_intupperthumbs_up',
		name = 'idle_a'
	},
	{
		dict = 'rcmnigel1a',
		name = 'base'
	},
}

--[[
    This section configures the maps that are eligible for Deathmatch. It defines the spawn points for both teams, the enemy teams, and the playable areas for each map.

    - `Config.MapData`: Contains the data for each map, including:
        - `team1` and `team2`: These are the spawn coordinates for each team at the start of the match.
        - `eteam1` and `eteam2`: Coordinates for the enemy team spawns.
        - `area`: Defines the playable area for the map, including its position and size, using `Pos` and `Size`.

    To customize or add more maps, you can edit this Lua file and define the new map coordinates as shown in the examples.

    **HTML/JS Configuration:**

    To add new maps visually, go to `html/js/config/*`. There, the `maps` array lists the available maps with their names and images.
    Each map has:
    - `name`: The name of the map that will be displayed in the selection UI.
    - `img`: The image file representing the map in the UI.

    Example JS structure:
    ```javascript
    const maps = [
      { name: "All", img: "all.png" },
      { name: "Cargo", img: "cargo.png" },
      { name: "Bank", img: "bank.png" },
      { name: "1v1", img: "1v1.png" },
      { name: "test", img: "test.png" },

      // Add new maps here by following this format.
    ];

    export default maps;
    ```

    To add a new map:
    1. Add its configuration in this Lua file (`Config.MapData`).
    2. Update the `maps` array in the JS file to include the new map name and image.
    3. Ensure the image file is present in the correct folder for the UI.

    This will allow the new map to be selectable in the Deathmatch menu, with all necessary settings for spawn points and playable areas.
]]

Config.Timer = 420 -- Game duration time (default 420 seconds)

Config.MapData = {
	['Arena1'] = {
		['team1'] = { x = 4427.82, y = 1541.16, z = 153.72, h = 0.0 },
		['team2'] = { x = 4380.12, y = 1539.24, z = 153.72, h = 180.0 },
		['eteam1'] = { x = 4427.82, y = 1541.16, z = 153.72, h = 0.0 },
		['eteam2'] = { x = 4380.12, y = 1539.24, z = 153.72, h = 180.0 },
		['area'] =
		{
			['Pos'] = { x = 4403.97, y = 1540.20, z = 153.72 },
			['Size'] = { x = 100.0, y = 100.0, z = 20.0 },
		},
	},
	['Arena2'] = {
		['team1'] = { x = 4441.64, y = 1433.78, z = 153.72, h = 0.0 },
		['team2'] = { x = 4364.69, y = 1433.4, z = 153.72, h = 180.0 },
		['eteam1'] = { x = 4441.64, y = 1433.78, z = 153.72, h = 0.0 },
		['eteam2'] = { x = 4364.69, y = 1433.4, z = 153.72, h = 180.0 },
		['area'] =
		{
			['Pos'] = { x = 4403.17, y = 1433.59, z = 153.72 },
			['Size'] = { x = 100.0, y = 100.0, z = 20.0 },
		},
	},
	['Arena3'] = {
		['team1'] = { x = 4367.69, y = 1311.22, z = 153.73, h = 0.0 },
		['team2'] = { x = 4439.1, y = 1311.38, z = 153.73, h = 180.0 },
		['eteam1'] = { x = 4367.69, y = 1311.22, z = 153.73, h = 0.0 },
		['eteam2'] = { x = 4439.1, y = 1311.38, z = 153.73, h = 180.0 },
		['area'] =
		{
			['Pos'] = { x = 4403.40, y = 1311.30, z = 153.73 },
			['Size'] = { x = 100.0, y = 100.0, z = 20.0 },
		},
	},
	['Arena4'] = {
		['team1'] = { x = 4439.46, y = 1173.92, z = 153.77, h = 0.0 },
		['team2'] = { x = 4368.32, y = 1172.78, z = 153.77, h = 180.0 },
		['eteam1'] = { x = 4439.46, y = 1173.92, z = 153.77, h = 0.0 },
		['eteam2'] = { x = 4368.32, y = 1172.78, z = 153.77, h = 180.0 },
		['area'] =
		{
			['Pos'] = { x = 4403.89, y = 1173.35, z = 153.77 },
			['Size'] = { x = 100.0, y = 100.0, z = 20.0 },
		},
	},
	['Arena5'] = {
		['team1'] = { x = 4467.58, y = 1368.24, z = 253.99, h = 0.0 },
		['team2'] = { x = 4340.03, y = 1338.18, z = 253.99, h = 180.0 },
		['eteam1'] = { x = 4467.58, y = 1368.24, z = 253.99, h = 0.0 },
		['eteam2'] = { x = 4340.03, y = 1338.18, z = 253.99, h = 180.0 },
		['area'] =
		{
			['Pos'] = { x = 4403.81, y = 1353.21, z = 253.99 },
			['Size'] = { x = 150.0, y = 150.0, z = 30.0 },
		},
	},
}

--[[
    Do not use `Config.Debug` unless you are an administrator.
    This setting is only for displaying helpful debug messages and should not be enabled for regular players.
    It provides additional information that is useful for testing and troubleshooting, but could clutter the gameplay experience.
]]

Config.Debug = true


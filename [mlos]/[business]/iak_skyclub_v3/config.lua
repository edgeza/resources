MBT = {}

MBT.MenuCoords = vector3(-905.28, -448.8, 160.31)
MBT.Distance = 10.0

MBT.Labels = {
    ["open_menu"] = "~INPUT_PICKUP~ Open Menu",
    ["dancefloor"] = "Set 1",
	["open_menu_target"] = "Open Menu"
}

MBT.TXAdmin = false
MBT.SaveSetsOnPlayerLogout = false
MBT.SaveSetsOnSetChange = true

MBT.Target = {
	["Active"] = false,
	["Skyclub Menu"] = function ()
		
		exports.ox_target:addBoxZone({
			name = "skyclubmenu",
			coords = vec3(-906.53, -448.62, 160.0),
			size = vec3(2.75, 0.9, 0.225),
			rotation = 28.0,
			debug = false,
			options = {
				{
					name = 'box',
					distance = 3.4,
					icon = 'fa-solid fa-cube',
					label = MBT.Labels["open_menu_target"],
					onSelect = openEntMenu
				},
			}
		})
	end
}

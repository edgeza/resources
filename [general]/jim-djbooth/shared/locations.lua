Locations = {
    { -- Sisyphus Theater
        job = "public", -- "public" makes it so anyone can add music.
        enableBooth = true,
        DefaultVolume = 0.15, radius = 200,
        coords = vec3(206.9, 1181.04, 226.51),
        soundLoc = vec3(212.32, 1155.87, 227.01), -- Add sound origin location if you don't want the music to play from the dj booth
    },
    { -- Bennies Racetrack
    job = "public", -- "public" makes it so anyone can add music.
    enableBooth = true,
    DefaultVolume = 0.15, radius = 100,
    coords = vec3(-779.61, -2060.84, 13.03),
    soundLoc = vec3(-779.61, -2060.84, 13.03), -- Add sound origin location if you don't want the music to play from the dj booth
    },
    { -- GabzTuners Radio Prop
        job = "mechanic",
        enableBooth = true,
        DefaultVolume = 0.1, radius = 30,
        coords = vec3(127.04, -3030.65, 6.80),
        prop = { model = "prop_radio_01", coords = vec3(127.04, -3030.65, 6.80) },
                                -- Prop to spawn at location, if the location doesn't have one already
                                -- (can be changed to any prop, coords determine wether its placed correctly)
    },

    { -- Gabz Popsdiner Radio Prop
        job = "public",
        enableBooth = true,
        DefaultVolume = 0.1, radius = 50,
        coords = vec3(1595.53, 6453.02, 26.165),
        prop = { model = "prop_boombox_01", coords = vec3(1595.53, 6453.02, 26.165) },
    },
	{ -- Koi Restaurant
        job = "public", -- "public" makes it so anyone can add music.
        enableBooth = true,
        DefaultVolume = 0.15, radius = 50,
        coords = vec3(-1059.38, -1471.09, -1.42),
        soundLoc = vec3(-1059.38, -1471.09, -1.42), -- Add sound origin location if you don't want the music to play from the dj booth
   },
	{ -- Cat Cafe
        job = "public", -- "public" makes it so anyone can add music.
        enableBooth = true,
        DefaultVolume = 0.15, radius = 50,
        coords = vec3(-574.74, -1048.95, 22.34),
        soundLoc = vec3(-574.74, -1048.95, 22.34), -- Add sound origin location if you don't want the music to play from the dj booth
   },
   { -- High Notes
        job = "public", -- "public" makes it so anyone can add music.
        enableBooth = true,
        DefaultVolume = 0.15, radius = 50,
        coords = vec3(-857.88, -240.73, 62.0),
        soundLoc = vec3(-857.88, -240.73, 62.0), -- Add sound origin location if you don't want the music to play from the dj booth
   },
   { -- Beach Bar
        job = "public", -- "public" makes it so anyone can add music.
        enableBooth = true,
        DefaultVolume = 0.15, radius = 250,
        coords = vec3(-1522.43, -1507.62, 6.4),
        soundLoc = vec3(-1523.35, -1496.38, 5.34), -- Add sound origin location if you don't want the music to play from the dj booth
   },
   { -- Palms
        job = "public", -- "public" makes it so anyone can add music.
        enableBooth = true,
        DefaultVolume = 0.15, radius = 250,
        coords = vec3(-2023.74, -497.13, 12.21),
        soundLoc = vec3(-2023.74, -497.13, 12.21), -- Add sound origin location if you don't want the music to play from the dj booth
   },


}
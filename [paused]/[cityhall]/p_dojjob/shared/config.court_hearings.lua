while not Config do Wait(1) end

Config.CourtHearings = {}

Config.CourtHearings.TVs = { -- TV's with incoming court hearings
    ['CH_1'] = {
        coords = vector3(-557.62, -192.97, 38.23),
        rotation = vector3(0.0, 0.0, 80.0),
        distance = 50.0 -- spawn distance
    },

    -- FM CITY HALL LS
    -- ['LS_1'] = {
    --     coords = vector3(-508.8709, -609.7953, 36.2965),
    --     rotation = vector3(0.0, 0.0, 268.4732),
    --     distance = 30.0 -- spawn distance
    -- },
}

-- If you want to manage TV Players, remember you shouldn't restart the script while u on server because it will break the TV
Config.CourtHearings.EnableTVCreator = false -- enable TV creator [/tv_creator command]

Config.CourtHearings.TVPlayer = { -- playable TV's
    ['CH_1'] = {
        coords = vector3(-578.264282, -212.889008, 42.326927),
        menuCoords = vector3(-575.86, -216.03, 38.23),
        rotation = vec3(0.000000, 0.000000, 239.00),
        scale = vector3(1.35, 1.35, 1.35), -- scale x, y, z
        distance = 20, -- spawn distance
        jobs = {['doj'] = 0}, -- which jobs can manage the TV
    },
    ['CH_2'] = {
        coords = vector3(-2255.65, 3044.21, 32.81),
        menuCoords = vector3(-2243.99, 3047.93, 32.89),
        rotation = vec3(0.000000, 0.000000, 239.00),
        scale = vector3(10.35, 10.35, 10.35), -- scale x, y, z
        distance = 100, -- spawn distance
        jobs = {['doj'] = 0}, -- which jobs can manage the TV
    },

    -- FM CITY HALL LS
    -- ['LS_1'] = {
    --     coords = vec3(-524.146790, -585.560364, 37.803066),
    --     menuCoords = vector3(-523.7545, -583.8952, 35.7031),
    --     rotation = vec3(000000, 0.000000, -90.257896),
    --     scale = vector3(1.35, 1.35, 1.35), -- scale x, y, z
    --     distance = 7.5, -- spawn distance
    --     jobs = {['doj'] = 0}, -- which jobs can manage the TV
    -- },
}

Config.CourtHearings.Gavels = { -- Gavel's on Court hearings
    ['CH_1'] = {
        coords = vector3(-576.29, -210.89, 38.77),
        jobs = {['doj'] = 0},
        volume = 0.5, -- sound volume [0.0 - 1.0]
        distance = 17.5 -- sound distance
    },

    -- FM CITY HALL LS
    -- ['LS_1'] = {
    --     coords = vector3(-516.02, -589.89, 36.2),
    --     jobs = {['doj'] = 0},
    --     volume = 0.5, -- sound volume [0.0 - 1.0]
    --     distance = 17.5 -- sound distance
    -- },
}

Config.CourtHearings.Microphones = {
    ['LegionSquare_Judge'] = {
        coords = vector3(-576.45, -210.07, 39.56),
    },
    ['LegionSquare_Stand'] = {
        coords = vector3(-572.52, -207.69, 38.23),
    },
    ['Witness_1'] = {
        coords = vector3(-578.19, -208.63, 38.08),
    },
    ['Witness_2'] = {
        coords = vector3(-576.09, -212.37, 38.08),
    },
    ['Events'] = {
        coords = vector3(683.85, 571.15, 130.46),
    },
    -- FM CITY HALL LS
    -- ['LS_Judge'] = {
    --     coords = vector3(-516.6210, -589.0395, 36.2142),
    -- },
    -- ['LS_Defense'] = {
    --     coords = vector3(-518.3167, -595.8582, 35.6031),
    -- },
    -- ['LS_Prosecutor'] = {
    --     coords = vector3(-513.0540, -595.8336, 35.6031),
    -- },
}
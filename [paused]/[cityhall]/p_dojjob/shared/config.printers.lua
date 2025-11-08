while not Config do Wait(1) end

--@param coords vector3
--@param radius number
--@param jobs table
Config.Printers = {
    ['CityHall_1'] = {
        coords = vector3(-540.5, -192.98, 43.37),
        radius = 0.5,
        jobs = {
            ['doj'] = 0,
        },
    },
    ['CityHall_2'] = {
        coords = vector3(-540.53, -193.09, 38.23),
        radius = 0.5,
        jobs = {
            ['doj'] = 0,
        },
    },
    -- FM CITY HALL LS
    -- ['LS_CityHall_1'] = {
    --     coords = vector3(-560.58, -603.95, 35.65),
    --     radius = 0.5,
    --     jobs = {
    --         ['doj'] = 0,
    --     },
    -- },
    -- ['LS_CityHall_2'] = {
    --     coords = vector3(-567.14, -604.0, 35.7),
    --     radius = 0.5,
    --     jobs = {
    --         ['doj'] = 0,
    --     },
    -- },
}
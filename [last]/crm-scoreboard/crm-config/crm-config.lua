crm_config = {}
crm_config.crm_debug = false

crm_config.crm_position = 'crm-left' -- 'crm-left' or 'crm-right'
crm_config.crm_key = 'HOME'
crm_config.crm_cmd = 'scoreboard'
crm_config.crm_help = 'Open Scoreboard'

crm_config.crm_info = {
    crm_title = 'ONELIFE',
    crm_sub = '',
}

crm_config.crm_name_type = 'crm-character-name' -- 'crm-character-name' or 'crm-hidden' or 'crm-game-name'
crm_config.crm_name_hidden = 'Unknown Player'
crm_config.crm_role_default = 'Player'
crm_config.crm_role_color_default = '#FFFFFF'

crm_config.crm_enable = {
    ['crm-players'] = true,
    ['crm-jobs'] = true,
    ['crm-heists'] = true,
}

crm_config.crm_pages = { -- Note: If you disable a page, make sure to disable the components in crm_config.crm_enable so it doesn't run in background.
    {crm_enable = true, crm_title = 'Players', crm_icon = 'fa-users', crm_id = "crm-players"},
    {crm_enable = true, crm_title = 'Jobs / Heists', crm_icon = 'fa-briefcase', crm_id = "crm-others"},
}

crm_config.crm_jobs = {
    {crm_id = 1, crm_jobs = {'police'}, crm_title = 'Law Enforcement', crm_icon = 'fa-handcuffs'},
    {crm_id = 2, crm_jobs = {'ambulance'}, crm_title = 'Emergency Medical Services', crm_icon = 'fa-star-of-life'},
    {crm_id = 3, crm_jobs = {'palmcoast'}, crm_title = 'Palm Coast', crm_icon = 'fa-wrench'},
    {crm_id = 4, crm_jobs = {'bennies'}, crm_title = 'Bennys Racetrack', crm_icon = 'fa-wrench'},
    {crm_id = 5, crm_jobs = {'aod'}, crm_title = 'Angels of Death', crm_icon = 'fa-wrench'},
    {crm_id = 6, crm_jobs = {'beanmachine'}, crm_title = 'Bean Machine', crm_icon = 'fa-mug-hot'},
    {crm_id = 7, crm_jobs = {'catcafe'}, crm_title = 'Cat Cafe', crm_icon = 'fa-paw'},
    {crm_id = 8, crm_jobs = {'koi'}, crm_title = 'Koi Restaurant', crm_icon = 'fa-bacon'},
}

crm_config.crm_heists = {
    {
        crm_id = 1,
        crm_title = 'House Robbery.', 
        crm_icon = 'fa-house', 
        crm_requires = {
            {crm_job='police', crm_count=3},
        }
    },
    {
        crm_id = 2,
        crm_title = 'Store Robbery.', 
        crm_icon = 'fa-store', 
        crm_requires = {
            {crm_job='police', crm_count=3},
        }
    },
    {
        crm_id = 3,
        crm_title = 'ATM Robbery.', 
        crm_icon = 'fa-piggy-bank', 
        crm_requires = {
            {crm_job='police', crm_count=3},
        }
    },
    {
        crm_id = 4,
        crm_title = 'Cash Exchange Heist.', 
        crm_icon = 'fa-vault', 
        crm_requires = {
            {crm_job='police', crm_count=4},
        }
    },
    {
        crm_id = 5,
        crm_title = 'Yacht Heist.', 
        crm_icon = 'fa-ship', 
        crm_requires = {
            {crm_job='police', crm_count=4},
        }
    },
    {
        crm_id = 6,
        crm_title = 'Laundromat Heist.', 
        crm_icon = 'fa-vault', 
        crm_requires = {
            {crm_job='police', crm_count=4},
        }
    },
    {
        crm_id = 7,
        crm_title = 'Fleeca Bank Heist.', 
        crm_icon = 'fa-vault', 
        crm_requires = {
            {crm_job='police', crm_count=4},
        }
    },
    {
        crm_id = 8,
        crm_title = 'Vangelico Heist.', 
        crm_icon = 'fa-vault', 
        crm_requires = {
            {crm_job='police', crm_count=6},
        }
    },
    {
        crm_id = 9,
        crm_title = 'Paleto Bank Heist.', 
        crm_icon = 'fa-building-columns', 
        crm_requires = {
            {crm_job='police', crm_count=6},
        }
    },
    {
        crm_id = 10,
        crm_title = 'Maze Bank Heist.', 
        crm_icon = 'fa-gem', 
        crm_requires = {
            {crm_job='police', crm_count=6},
        }
    },
    {
        crm_id = 11,
        crm_title = 'Bobcat Heist.', 
        crm_icon = 'fa-sack-dollar', 
        crm_requires = {
            {crm_job='police', crm_count=6},
        }
    },
    {
        crm_id = 12,
        crm_title = 'HumaneLabs Heist.', 
        crm_icon = 'fa-sack-dollar', 
        crm_requires = {
            {crm_job='police', crm_count=6},
        }
    },
    {
        crm_id = 13,
        crm_title = 'Union Bank Heist.', 
        crm_icon = 'fa-sack-dollar', 
        crm_requires = {
            {crm_job='police', crm_count=6},
        }
    },
    {
        crm_id = 14,
        crm_title = 'Oil Rig Heist.', 
        crm_icon = 'fa-sack-dollar', 
        crm_requires = {
            {crm_job='police', crm_count=8},
        }
    },
    {
        crm_id = 15,
        crm_title = 'Main Bank Heist.', 
        crm_icon = 'fa-sack-dollar', 
        crm_requires = {
            {crm_job='police', crm_count=8},
        }
    },
    {
        crm_id = 16,
        crm_title = 'Casino Heist.', 
        crm_icon = 'fa-sack-dollar', 
        crm_requires = {
            {crm_job='police', crm_count=8},
            {crm_job='bcso', crm_count=8},
        }
    },

}

crm_config.crm_staff = {
    {crm_role = 'Founder', crm_license = 'license:xxxxxxxxxxxxxxxxxxxxxxxx', crm_color = "#ffb060"},
}
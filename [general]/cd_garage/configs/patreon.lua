Config.PatreonTiers = {
    ENABLE = true,
    DEBUG = false, -- Turned off for production performance
    lookup_mode = 'job', -- Use job instead of metadata - maps jobs to tiers
    metadata_key = 'patreon_tier', -- Not used when lookup_mode is 'job'
    default_tier = 0,
    inherit = false, -- Set to false so patreon2 doesn't automatically get patreon1 vehicles
    
    -- Job to Tier mapping
    -- When a player has job 'patreon1', they get tier 1 vehicles
    -- When a player has job 'patreon2', they get tier 2 vehicles
    job_to_tier = {
        ['patreon1'] = 1,
        ['patreon2'] = 2,        
        ['patreon3'] = 3,
        -- Add more mappings here if needed
    },
    
    -- Vehicle tiers configuration
    -- Define gated vehicles per tier by SPAWNCODE (case-insensitive)
    -- Vehicles are now categorized by type for proper garage storage
    tiers = {
        [1] = { 
            cars = { 
                'sc_dominatorwb', 'vacca2', 'clubta', 'furiawb', 'sentinel_rts', 
                'h4rxwindsorcus', 'gstzr3503', 'schwarzer2', 'gp1wb', 'r300w', 
                'cypherct', 'contenderc', 
                'coquettewb', 'Hoonie', 'jestgpr', 'komodafr', 'zentornoc', 
                'mk2vigerozx', 'z190wb', 'cometrr', 'boorbc', 
                'sultanrsv8', 'saseverowb', 'gstarg2'
            },
            boats = {},
            air = {}
        },
        [2] = { 
            cars = { 
                -- Tier 1 cars (inherited)
                'sc_dominatorwb', 'vacca2', 'clubta', 'furiawb', 'sentinel_rts', 
                'h4rxwindsorcus', 'gstzr3503', 'schwarzer2', 'gp1wb', 'r300w', 
                'cypherct', 'contenderc', 
                'coquettewb', 'Hoonie', 'jestgpr', 'komodafr', 'zentornoc', 
                'mk2vigerozx', 'z190wb', 'cometrr', 'boorbc', 
                'sultanrsv8', 'saseverowb', 'gstarg2',
                -- Tier 2 cars
                'turismorr', 'playboy', 'domttc', 'italigts', 'jesterwb', 
                'vigerozxwbc', 'hrgt6r', 'yosemite6str', 
                'fcomneisgt25', 'sddriftvet', 'remuswb', 'elytron', 'hotkniferod', 
                'vacca3', 'gstghell1', 'jester4wb', 'rt3000wb', 'sdmonsterslayer', 
                'audace', 'gstjc2', 'turismo2lm', 'zentorno2', 'ziongtc', 'vertice'
            },
            boats = {},
            air = {}
        },
        [3] = { 
            cars = { 
                -- Tier 1 cars (inherited)
                'sc_dominatorwb', 'vacca2', 'clubta', 'furiawb', 'sentinel_rts', 
                'h4rxwindsorcus', 'gstzr3503', 'schwarzer2', 'gp1wb', 'r300w', 
                'cypherct', 'contenderc', 
                'coquettewb', 'Hoonie', 'jestgpr', 'komodafr', 'zentornoc', 
                'mk2vigerozx', 'z190wb', 'cometrr', 'boorbc', 
                'sultanrsv8', 'saseverowb', 'gstarg2',
                -- Tier 2 cars (inherited)
                'turismorr', 'playboy', 'domttc', 'italigts', 'jesterwb', 
                'vigerozxwbc', 'hrgt6r', 'yosemite6str', 
                'fcomneisgt25', 'sddriftvet', 'remuswb', 'elytron', 'hotkniferod', 
                'vacca3', 'gstghell1', 'jester4wb', 'rt3000wb', 'sdmonsterslayer', 
                'audace', 'gstjc2', 'turismo2lm', 'zentorno2', 'ziongtc', 'vertice',
                -- Tier 3 cars
                'vd_tenfrally', 'vanz23m2wb', 'uniobepdb', 'thraxs', 'sunrise1', 
                'bansheeas', 'jester3c', 'gstnio2', 'sentineldm', 'schlagenstr', 
                'italigtoc', 'sagauntletstreet', 'scdtm', 'draftgpr', 'rh82', 
                'SCSugoi', 'hycrh7', 'tyrusgtr', 'tempesta2', 
                'tempestaes', 'reagpr', 'gst10f1', 'coquette4c', 
                'rapidgte', 'kurumata', 'hycsun'
            },
            boats = {},
            air = {}
        },
    },
    
    -- Garage configuration for patreon vehicles
    garage_config = {
        garage_id = 'Patreon Hub', -- Where patreon vehicles are stored
        garage_type = 'car', -- Default garage type
    },
}


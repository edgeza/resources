Config = {
    Language = 'en', -- en, tr, fr, pt, es, de, nl
    Debug = false,
    ----------------------------------------------
    --[[
        Use Target or press E system on reaching evidence location

        Default: false
    ]]
    Target = false,
    TargetOptions = {
        debug = false,
        size = { 0.5, 0.5, 0.5 },
        distance = 3.5,
        icon = 'fa-regular fa-hand',
    },
    ----------------------------------------------
    PoliceJobs = { 'police' },
    RequireDuty = true,
    PoliceDropEvidence = false,
    CanClearEvidence = true,

    --[[
        Enable or Disable type of evidences

        Default: true

        true: Enabled
        false: Disabled
    ]]

    IsEnabled = {
        blood = true,
        fingerprint = true,
        gsr = true
    },

    --[[
        Reach Evidence Menu
    ]]
    UseItem = true,
    EvidenceItem = 'evidence_tablet',

    UseCommand = false,
    Command = 'evidence',

    UseLocations = true,
    Locations = {
        ['LSPD'] = {
            coords = vec3(812.03, -1304.66, 19.68),
        }
    },

    --[[
        Evidence present in an area is checked every 30 minutes, and any evidence that has been present for longer than the specified time is removed from the ground.
        IMPORTANT: This is a *critical* option for optimization. Increasing the values too much can put strain on the server and lead to timeouts. Therefore, be careful not to set the values too high.

        Default: 30 (minutes) That means if the evidence is on the ground for more than 30 minutes, it will be removed automatically.
    ]]
    DespawnTimeouts = {
        blood = 15,
        bullet = 15,
        casing = 15,
    },

    Thresholds = { -- Max evidence count on ground, if it exceeds, it will remove the oldest one. This is for serverside optimization
        blood = 15,
        bullet = 15,
        casing = 15,
    },

    RemoveItemAfterUse = false, -- Remove used items after use

    -- Enable / Disable timeout for each evidence drop between 2 drops
    TimerName = {
        Shooting = true,
        Blood = true,
    },

    -- Determine the time between each evidence drop
    EvidenceDelay = {    -- in ms
        Shooting = 10000, -- 10 seconds is optimal for shooting, if you decrease this value might cause crashes when 100-200 players shooting at the same time
        Blood = 10000
    },

    Items = {
        evidence_bag = 'empty_evidence_bag',
        filled_bag = 'filled_evidence_bag',
    },

    WhitelistedWeapons = { -- Prevent these weapons to drop bullet casing
        `weapon_unarmed`,
        `weapon_snowball`,
        `weapon_stungun`,
        `weapon_petrolcan`,
        `weapon_hazardcan`,
        `weapon_fireextinguisher`
    },

    -- ADDED WITH V0.9.8
    WhitelistedLocations = { -- Prevent these locations to drop desired type of evidence
        ['zone1'] = { -- Values that starts with zone has to be unique like zone1, zone2, zone3 etc.
            coords = vector3(0.0, 0.0, 0.0),
            radius = 50.0,
            disabled = 'casing', -- 'blood', 'casing', 'all' | 'all' option prevent drop of any type evidence, 'blood' to disable blood drop, 'casing' to disable casing + bullet core drop
        },

        -- ['zone2'] = {
        --     coords = vector3(437.275, -995.332, 30.623),
        --     radius = 100.0,
        --     disabled = 'all',
        -- },
    },

    DropEvidenceObject = { -- Drop evidence object on the ground
        ['casing'] = true,
        ['blood'] = true,
    },

    CasingObjects = {
        ['GROUP_PISTOL'] = `w_pi_singleshoth4_shell`,
        ['GROUP_RIFLE'] = `w_pi_singleshot_shell`,
        ['GROUP_SHOTGUN'] = `w_sg_pumpshotgunh4_mag1`,
        ['GROUP_SMG'] = `w_pi_singleshoth4_shell`,
        ['GROUP_SNIPER'] = `w_pi_singleshot_shell`,
        ['GROUP_STUNGUN'] = `w_ar_specialcarbinemk2_mag_fmj`,
        ['GROUP_MG'] = `w_pi_singleshoth4_shell`,
    },

    AmmoTypes = { -- Available 3D Ammo Types for UI: 9mm, 45acp, 5.56, 5.45, 12mm
        ['GROUP_PISTOL'] = '45acp',
        ['GROUP_SMG'] = '9mm',
        ['GROUP_RIFLE'] = '5.56',
        ['GROUP_SNIPER'] = '5.45',
        ['GROUP_SHOTGUN'] = '12mm',
    },

    BloodObject = `p_bloodsplat_s`, -- Blood object

    --[[
        Enable or disable the feature that causes blood to appear only when the player takes damage from another player.

        Setting this to false will allow blood evidence to be created regardless of the cause of damage.
        Setting this to true will cause blood evidence to be created only when the player is attacked by another player.

        Default: true
    ]]
    BloodCanDropOnlyByAttacker = false,

    WhitelistedGloves = { -- NOTE: If your clothing pack listing gloves at different component, make sure edit this configuration!
        male = {
            {
                component = 3, -- Default glove component [Arms Section] | Component list: https://docs.fivem.net/natives/?_0x67F3780DD425D4FC
                gloves = {
                    16,
                    17,
                    18,
                    19,
                    20
                }
            }
        },
        female = {
            {
                component = 3, -- Default glove component [Arms Section] | Component list: https://docs.fivem.net/natives/?_0x67F3780DD425D4FC
                gloves = {
                    16,
                    17,
                    18,
                    19,
                    20
                }
            }
        }
    },
    FingerprintItem = 'magnifying_glass',
    FingerprintProgress = 20, -- in second

    EnableLineAnalyze = true,
    LineAnalyzeItem = 'thermal_camera',
    AnalyzeRange = 20.0,

    CleaningKitItem = 'cleaningkit', -- default shared ox & qb item
    CleaningGSRItem = 'cleaningkit', -- default shared ox & qb item
}
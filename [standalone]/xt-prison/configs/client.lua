return {
    DebugPoly = false,
    Freedom = vec4(212.69, -904.48, 30.69, 261.25), -- Freedom spawn coords
    RemoveJob = false,          -- Remove player jobs when send to jail

    -- Create Target Zone to Check Time (if XTPrisonJobs is false) --
    CheckOut = {
        coords = vec3(1765.64, 2565.74, 45.57),
        size = vec3(0.9, 7.8, 1.45),
        rotation = 0.5,
    },

    -- Alert When Entering Prison --
    EnterPrisonAlert  = {
        enable = true,
        header = 'Welcome to Prison, Criminal Scum Bag!',
        content = 'To reduce your time in prison, get a job from the guard in the yard. Get your ass to work and maybe you\'ll learn a thing or two.',
    },

    -- Enter Prison Spawn Location & Emotes --
    Spawns = {
        { coords = vec4(1747.98, 2541.49, 45.56, 274.39),   emote = 'pushup' },
        { coords = vec4(1747.98, 2541.49, 45.56, 274.39), emote = 'pushup' },
        { coords = vec4(1747.98, 2541.49, 45.56, 274.39), emote = 'weights' },
        { coords = vec4(1747.98, 2541.49, 45.56, 274.39), emote = 'lean' },
    },

    -- Canteen Ped --
    CanteenPed = {
        model = 's_m_m_linecook',
        coords = vec4(1775.42, 2552.26, 45.57, 87.9),
        scenario = 'PROP_HUMAN_BBQ',
        mealLength = 2
    },

    -- Prison Doctor --
    PrisonDoctor = {
        model = 's_m_m_doctor_01',
        coords = vec4(1753.39, 2566.27, 45.57, 219.99),
        scenario = 'WORLD_HUMAN_CLIPBOARD',
        healLength = 5
    },

    -- Roster Location --
    RosterLocation = {
        coords = vec3(1729.41, 2562.96, 45.56),
        radius = 0.3,
    },

    -- Set Prison Outfits --
    EnablePrisonOutfits = true,
    PrisonOufits = {
        male = {
            accessories = {
                item = 0,
                texture = 0
            },
            mask = {
                item = 0,
                texture = 0
            },
            pants = {
                item = 5,
                texture = 7
            },
            jacket = {
                item = 0,
                texture = 0
            },
            shirt = {
                item = 15,
                texture = 0
            },
            arms = {
                item = 0,
                texture = 0
            },
            shoes = {
                item = 42,
                texture = 2
            },
            bodyArmor = {
                item = 0,
                texture = 0
            },
        },
        female = {
            accessories = {
                item = 0,
                texture = 0
            },
            mask = {
                item = 0,
                texture = 0
            },
            pants = {
                item = 0,
                texture = 0
            },
            jacket = {
                item = 0,
                texture = 0
            },
            shirt = {
                item = 0,
                texture = 0
            },
            arms = {
                item = 0,
                texture = 0
            },
            shoes = {
                item = 0,
                texture = 0
            },
            bodyArmor = {
                item = 0,
                texture = 0
            },
        }
    },

    -- Reloads Player's Last Skin When Freed --
    ResetClothing = function()
         TriggerEvent('illenium-appearance:client:reloadSkin', true)
    end,

    -- Triggered on Player Heal --
    PlayerHealed = function()
        -- TriggerEvent('hospital:client:Revive')
        -- TriggerEvent('osp_ambulance:partialRevive')
    end,

    -- Trigger Emote --
    Emote = function(emote)
        -- exports.scully_emotemenu:playEmoteByCommand(emote)
        -- exports["rpemotes"]:EmoteCommandStart(emote)
    end,

    -- Trigger Prison Break Dispatch --
    Dispatch = function(coords)
        -- exports['ps-dispatch']:PrisonBreak()
        -- TriggerEvent('police:client:policeAlert', coords, 'Prison Break')
        
       -- ND Core
        -- exports["ND_MDT"]:createDispatch({
        --             caller = "Boilingbroke Penitentiary",
        --             location = "Sandy Shores",
        --             callDescription = "Prison Break",
        --             coords = vec3(1845.8302, 2585.9011, 45.6726)
        --         })
    end,
}
Config = {}

Config.framework = 'QBCORE'  ---- 'ESX OR QBCORE'

Config.Mysql = 'oxmysql' ----- mysql-async , ghmattisql or oxmysql

Config.istarget = true   --------- target system open

Config.targettype = 'qb-target'   ---------- > targetsystem  'ox_target' or 'qb-target' 

Config.invtype = 'qs'   ---------- > inventorytypes 
Config.inventory = Config.invtype  -- keep wrapper-compatible key in sync (qb/ox/qs/esx)

Config.debug = false  ------  Open Debug Text

Config.hiderwaittime = 10  ----- killer black screen time


Config.could_it_be_the_hiders_ped = false   ---------------- if false Hiders can only be objects. They can't right-click and turn into a ped. (autoconvert)


Config.lobbydestroydistance = 5.0  --------------- >> The player will be ejected from the lobby at whatever distance.

Config.ambulance = 'qb' --- 'esx' , 'qb' , 'qbx'


Config.killerfakehitdamage = {
    ['state'] = false,
    ['hitdamage'] = 10.0
} 

Config.sounds = {
    ['hitsound'] = true,
    ['selfdamage'] = false
}



Config.defaulavatars = {
  
    "https://static.wikia.nocookie.net/propnight-game/images/3/38/Tbrender_025.png/revision/latest/smart/width/250/height/250?cb=20211207165800",
    "https://i.namu.wiki/i/aQaenM5AlOEkwGas8Mibj6pqSBO4KdN9JF3JGiQpQk4DIdjesjQnYPPHBxYU9p-9vXwYHRSCmzOK3eifFCAaqw.webp",
    "https://i.namu.wiki/i/GGg4YiyhnrLhNhUbIkJpVVtpfBYgiHR9i7JVpskiy0mbnRdrVjAFvj9jnjjQco4BfGug_6skf5AfGJa3jXMmsw.webp",
    "https://static.wikia.nocookie.net/propnight-game/images/7/75/Tbrender_019.png/revision/latest/smart/width/250/height/250?cb=20211207170758",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgeCY7dZQjTjcf5UYcqUz9c19FoPuQZtO-VQ&s",
    "https://images.sftcdn.net/images/t_app-icon-m/p/b3fd0978-3223-4fdf-aa2c-28bf45e229ec/3429487258/propnight-Propnight-icon.jpg",
    "https://static.wikia.nocookie.net/deathbattlefanon/images/a/a7/Impostor_Propnight.png/revision/latest?cb=20231026092321"
   
}



Config.weapondamages = {
    ['WEAPON_PISTOL'] = 5,
    ['weapon_redm4a1'] = 5,

}

Config.ActiveSkills = {
    ['killer'] = {
        ['1'] = {
            ['state'] = true,
            ['key'] = 161,
            ['name'] = '7'
        },
        ['2'] = {
            ['state'] = true,
            ['key'] = 162,
            ['name'] = "8"
        } 
    },
    ['hider'] = {
        ['1'] = {
            ['state'] = true,
            ['key'] = 161,
            ['name'] = '7'
        },
        ['2'] = {
            ['state'] = true,
            ['key'] = 162,
            ['name'] = "8"

        }, 
        ['3'] = {
            ['state'] = true,
            ['key'] = 163,
            ['name'] = '9'
        }
    }
}


Config.HiderZSkill = {
    CloneLimit = 5, 
    Cooldown = 1,   
}

-- Function to disable/enable inventory during prop hunt games
-- This prevents players from accessing their inventory while in a prop hunt game
DisableInventory = function(disable)
    if Config.invtype == 'qs' then
        -- qs-inventory has setInventoryDisabled function
        exports['qs-inventory']:setInventoryDisabled(disable)
    elseif Config.invtype == 'ox' then
        -- ox_inventory doesn't have setInventoryDisabled, but we can disable weapon wheel
        exports.ox_inventory:weaponWheel(not disable)
    elseif Config.invtype == 'qb' then
        -- qb-inventory doesn't have setInventoryDisabled function
        -- You can add qb-inventory specific functions here if needed
        -- Example: exports['qb-inventory']:CloseInventory() if available
    elseif Config.invtype == 'esx' then
        -- ESX doesn't have setInventoryDisabled function
        -- You can add ESX specific functions here if needed
        -- Example: TriggerEvent('esx_inventoryhud:closeInventory') if available
    end
end

StartStopUi = function(state)
  if state then 
    DisplayRadar(false)
    -- Disable inventory when UI starts (game begins)
    DisableInventory(true)
  else
    DisplayRadar(true)
    -- Re-enable inventory when UI stops (game ends)
    DisableInventory(false)
  end
end

Config.LobbyLimits = {
    maxPlayers = 10, -- Max Players
    maxKillers = 3,  -- Max Killers
    maxHiders = 7,   -- Maks Hiders
    minEntryFee = 0, -- Min Join Fee
    maxEntryFee = 1000, -- Max Join Fee
    gameTime = 10, ------ Max Game Time (minutes)
    gameRounds = 5 ------ Number of rounds to play (best of X)
}
Config.transobjects = {


    ------------------------------------- map 1 ------------------------------------------------------------------------
    ["prop_crate_03a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_crate_03a'},
    ["prop_crate_11c"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_crate_11c'},
    ["prop_rub_pile_04"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_rub_pile_04'},
    ["prop_cs_cardbox_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_cardbox_01'},
    ["prop_pot_plant_01e"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_burger_01'},
    ["prop_tool_box_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_tool_box_01'},
    ["prop_crate_01a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_crate_01a'},
    ["prop_couch_sm_02"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_couch_sm_02'},
    ["prop_box_wood01a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_box_wood01a'},
    ["prop_yaught_chair_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_burger_01'},
    ["prop_washing_basket_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_washing_basket_01'},
    ["prop_mobile_mast_2"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_mobile_mast_2'},
    ["prop_fruit_basket"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_fruit_basket'},
    ["prop_fib_plant_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_burger_01'},
    ["prop_roadpole_01a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_roadpole_01a'},
    ["prop_skid_box_02"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_skid_box_02'},
    ["prop_gc_chair02"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_gc_chair02'},
    ["prop_rub_binbag_sd_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_rub_binbag_sd_01'},
    ["prop_stat_pack_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_stat_pack_01'},
    ["prop_ld_jerrycan_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_burger_01'},
    ["prop_roofvent_08a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_burger_01'},
    ["prop_cs_bin_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_bin_01'},
    ["prop_barrel_01a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_barrel_01a'},
    ["prop_rad_waste_barrel_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_rad_waste_barrel_01'},
    ["prop_barrel_02b"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_barrel_02b'},
    ["prop_toilet_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_toilet_01'},
    ["prop_bin_10a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_bin_10a'},
    ["prop_toolchest_04"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_toolchest_04'},
    ["prop_alien_egg_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_alien_egg_01'},
    ["prop_drop_crate_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_drop_crate_01'},
    ["prop_barbell_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_barbell_01'},
    ["prop_tornado_wheel"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_burger_01'},
    ["prop_oiltub_06"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_oiltub_06'},
    ["prop_c4_final_green"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_c4_final_green'},
    ["prop_chair_01b"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_chair_01b'},

    
    
    

    ------------------------------------- map 2 ------------------------------------------------------------------------
    ["prop_cs_duffel_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_duffel_01'},
    ["prop_veg_crop_03_pump"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_burger_01'},
    ["prop_barrel_03d"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_barrel_03d'},
    ["prop_bskball_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_bskball_01'},
    ["prop_buck_spade_02"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_buck_spade_02'},
    ["prop_wheel_tyre"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_burger_01'},
    ["v_ret_ps_toiletbag"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'v_ret_ps_toiletbag'},
    ["prop_watercrate_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_watercrate_01'},
    ["prop_old_churn_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_old_churn_01'},
    ["prop_ld_case_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_ld_case_01'},
    ["prop_mr_rasberryclean"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_mr_rasberryclean'},
    ["prop_stoneshroom2"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_burger_01'},
    ["prop_bin_delpiero"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_bin_delpiero'},
    ["prop_cs_bucket_s"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_cs_bucket_s'},
    ["prop_water_bottle_dark"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_water_bottle_dark'},
    ["prop_metalfoodjar_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 100, referance = 'prop_metalfoodjar_01'},
    ["prop_breadbin_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_breadbin_01'},
    ["prop_chair_07"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_chair_07'},
    ["prop_detergent_01a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_detergent_01a'},
    ["prop_crate_04a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_crate_04a'},
    ["prop_crate_11e"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_crate_11e'},
    ["prop_gnome3"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_cs_burger_01'},
    ["prop_old_wood_chair"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_old_wood_chair'},
    ["prop_mp_drug_pack_red"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_mp_drug_pack_red'},
    ["prop_bin_04a"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_bin_04a'},
    ["prop_bowling_ball"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_bowling_ball'},
    ["prop_bin_07c"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_bin_07c'},
    ["prop_fragtest_cnst_01"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_fragtest_cnst_01'},
    ["prop_mp_cone_03"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_mp_cone_03'},
    ["prop_paper_box_03"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_paper_box_03'},
    ["prop_paper_bag_small"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_paper_bag_small'},
    ["prop_tv_04"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_cs_burger_01'},
    ["prop_off_chair_05"] = {speed = 0.3,jumpvalue = 10.0, jumpmaxtime = 50, referance = 'prop_cs_burger_01'},

 

}

Config.GameLocations = { 
    {label = 'Prop Hunt', text = 'Prop Hunt' ,coords = vector3(-282.25, -1922.55, 29.93), heading = 320.0, pedModel = 'a_m_m_farmer_01', blip = {['state'] = false , ['sprite'] = 458, ['size'] = 1.0, ['color'] = 4}},
    {label = 'Prop Hunt', text = 'Prop Hunt', coords = vector3(1854.0, 3686.0, 34.2), heading = 97.0, pedModel = 'a_m_y_beachvesp_01', blip = {['state'] = false , ['sprite'] = 458, ['size'] = 1.0, ['color'] = 4}}
}


Config.GameMaps = {
    ['1'] = {
        ['mapname'] = 'Secret Place', 
        ['centerpoint'] = vec3(-2336.294434, 7807.279297, 1272.695312),
        ['centerdistance'] = 60.0,
        ['killercoords'] = {
            vec4( -2336.742920, 7763.973633, 1272.964844, 2.834646),
            vec4( -2339.604492, 7764.105469, 1272.964844, 351.496063),
            vec4(-2333.287842, 7763.683594, 1272.964844, 28.346457),
            vec4(-2330.729736, 7765.187012, 1272.998535, 28.346457),
            vec4(-2344.430664, 7765.002441, 1272.981689, 348.661407)
        },
     
        ['hidercoords'] = {
            vec4(-2337.138428, 7848.777832, 1272.964844, 184.251968),
            vec4(-2339.525391, 7848.672363, 1272.964844, 201.259842),
            vec4(-2342.320801, 7847.512207, 1272.964844, 206.929138),
            vec4(-2333.578125, 7849.529785, 1272.964844, 167.244080),
            vec4(-2328.171387, 7848.039551, 1273.065918, 150.236221)
            
        },

        ['url'] = 'https://i.ibb.co/gdgPgyF/map1.png', 
        ['description'] = 'You can choose this map.',
        ['weapon'] = {['name'] = 'weapon_redm4a1', ['ammo'] = 1000} 
    },

    ['2'] = {
        ['mapname'] = 'Open Air', 
        ['centerpoint'] = vec3(-3791.393311, 7400.188965, 1272.375000),
        ['centerdistance'] = 100.0,
        ['killercoords'] = {
            vec4(-3790.720947, 7430.439453, 1272.408691, 175.748032),
            vec4(-3785.327393, 7430.439453, 1272.408691, 164.409454),
            vec4(-3795.890137, 7430.861328, 1272.408691, 170.078735),
            vec4(-3801.995605, 7431.085938, 1272.408691, 172.913391),
            vec4(-3777.243896, 7430.927246, 1272.408691, 175.748032)
        },
     
        ['hidercoords'] = {
            vec4(-3795.296631, 7377.375977, 1272.375000, 348.661407),
            vec4(-3783.257080, 7377.402344, 1272.408691, 357.165344),
            vec4(-3787.635254, 7377.191406, 1272.408691, 0.000000),
            vec4(-3780.975830, 7377.085938, 1272.408691, 0.000000),
            vec4(-3776.202148, 7377.059570, 1272.408691, 8.503937),
            vec4(-3803.076904, 7378.536133, 1272.375000, 320.314972)
        },

        ['url'] = 'https://i.ibb.co/nMbG5113/harita.png', 
        ['description'] = 'You can choose this map.',
        ['weapon'] = {['name'] = 'weapon_redm4a1', ['ammo'] = 1000} 
    }
    
    
}


Config.Skins = {
    ["hider"] = {
        torso_1 = 15, torso_2 = 0,
        tshirt_1 = 15, tshirt_2 = 0,
        shoes_1 = 34, shoes_2 = 0,
        pants_1 = 21, pants_2 = 0,
        mask_1 = 0, mask_2 = 0,
        arms = 15, arms_2 = 0,
        bags_1 = 0, bags_2 = 0,
        chain_1 = 0, chain_2 = 0,
        bproof_1 = 0, bproof_2 = 0,
        decals_1 = 0, decals_2 = 0,
        glasses_1 = -1, glasses_2 = 0,
        helmet_1 = -1, helmet_2 = 0,
        ears_1 = -1, ears_2 = 0,
        watches_1 = -1, watches_2 = 0,
        bracelets_1 = -1, bracelets_2 = 0
    },

    ["killer"] = {
        torso_1 = 50, torso_2 = 0,
        tshirt_1 = 15, tshirt_2 = 0,
        shoes_1 = 25, shoes_2 = 0,
        pants_1 = 10, pants_2 = 0,
        mask_1 = 15, mask_2 = 0,
        arms = 15, arms_2 = 0,
        bags_1 = 0, bags_2 = 0,
        chain_1 = 0, chain_2 = 0,
        bproof_1 = 0, bproof_2 = 0,
        decals_1 = 0, decals_2 = 0,
        glasses_1 = -1, glasses_2 = 0,
        helmet_1 = -1, helmet_2 = 2,
        ears_1 = -1, ears_2 = 0,
        watches_1 = -1, watches_2 = 0,
        bracelets_1 = -1, bracelets_2 = 0
    }
}



ExtraDisablesProps = function()

end


ExtraDisablesKillers = function()

end


invetorysettings = function(state)
    
    if Config.invtype == 'ox' then 
        exports.ox_inventory:weaponWheel(state)
    elseif Config.invtype == 'qs' then
        -- qs-inventory doesn't have weaponWheel, so we'll disable it
        -- You can add qs-inventory specific functions here if needed
    end
end

RevivePlayer = function()
    if Config.ambulance == 'esx' then
        TriggerEvent('esx_ambulancejob:revive')
    elseif Config.ambulance == 'qb' then
        TriggerEvent('hospital:client:Revive')
    elseif Config.ambulance == 'qbx' then
        TriggerEvent('qbx_medical:client:playerRevived')
    else
        TriggerEvent('hospital:client:Revive')
    end
end

creategamelocationtargets = function(data,sayi)
    
    if Config.targettype == 'ox_target' then
     
        exports.ox_target:addSphereZone({
            coords = data.coords,
            radius = 2.5,
            debug = false,
            options = {
                {
                    name = 'prophunt',
                    label = data.text,
                    icon = "fa-solid fa-download",
                    onSelect = function()
                        TriggerEvent('bp_prophunt:openMenu')
                    end
                }
            }
        })
       
    elseif Config.targettype == 'qb-target' then
       
        
        
        exports['qb-target']:AddBoxZone('bp_prophunt_'..sayi, vector3(data.coords.x, data.coords.y, data.coords.z + 3.0), 2.0, 2.0, { 
            name = 'bp_prophunt_'..sayi,
            heading = 150.0,
            debugPoly = false,
            minZ = data.coords.z - 2.0, 
            maxZ = data.coords.z + 2.0 
        }, 
        {
            options = {
                {
                    type = "client",
                    event = "bp_prophunt:openMenu",
                    icon = "fas fa-sign-in-alt",
                    label = data.text
                   
                }
            },
            distance = 2.5
        })

        
   

    end 
end


Config.notifytype = 'qb'   ---- 'ox' , 'qb' , 'esx' , 'custom'

notifycustom = function (text, time,types)
    --  print('ss')
end


Config.language = {
    ['lobbydestroy'] = 'The lobbys broken up!',
    ['lobbymaxcount'] = 'The total number of players cannot exceed the maximum number of players!',
    ['lobbynotfound'] = 'Lobby not Found!',
    ['mapselect'] = 'Map Selected:',
    ['winningteam'] = 'The winning team : ',
    ['stunned'] = 'You have been stunned, you wont be able to move for a while.',
    ['alreadyhavelobby'] = 'You already have a lobby!',
    ['cantlobbyban'] = 'You cannot set up a new room because you are banned!',
    ['youdontmoney'] = 'You dont have money!',
    ['successlobbycreate'] = 'The lobby has been successfully created!',
    ['lobbyupdate'] = 'Lobby settings updated!',
    ['lobbydelete'] = 'Lobby successfully wiped out!',
    ['cantenterban'] = 'You cant enter the lobby because youre banned.!',
    ['lobbyfull'] = 'The lobby is full!',
    ['teamchange'] = 'Your team has been changed.',
    ['anotherlobby'] = 'You\'re in another lobby.',
    ['successjoin'] = 'You have successfully joined the lobby!',
    ['awayfar'] = 'Youve been kicked out of the lobby for straying from the area!',
    ['prophuntgeneral'] = 'Prop Hunter Lobby',
    ['lobbycreatedest'] = 'You can set up a lobby here',
    ['lobbycreate'] = 'Create Lobby',
    ['searchlobby'] = 'Search Lobby',
    ['searchlobbydest'] = 'You can find the lobbies here',
    ['mylobby'] = 'My Lobby',
    ['mylobbydest'] = 'You can find your lobby',
    ['createlobby'] = 'Create Lobby',
    ['gametime'] = 'Game Time (minutes)',
    ['gameround'] = 'Game Rounds (best of X)',
    ['numberkiller'] = 'Number of Killers (Armed)',
    ['numberhider'] = 'Number of Hiders (Innocent)',
    ['entryfee'] = 'Entry Fee',
    ['nolobby'] = 'No lobby was found.',
    ['nolobbydest'] = 'Theres no lobby to join at the moment.',
    ['lobbydetails'] = 'Lobby Details',
    ['joinedplayers'] = 'Joined Players',
    ['joinedplayersdest'] = 'View the players joining the lobby.',
    ['joinlobby'] = 'Join the Lobby',
    ['joinlobbydest'] = 'Click here to join this lobby.',
    ['teamA'] = 'Team A',
    ['teamAdest'] = 'You can change your team as you wish.',
    ['teamB'] = 'Team B',
    ['teamBdest'] = 'You can change your team as you wish.',
    ['changesettings'] = 'Change Settings',
    ['changesettingsdest'] = 'Change the lobby settings.',
    ['selectmap'] = 'Select Map',
    ['selectmapdest'] = 'Select the game map.',
    ['startgame'] = 'Start Game',
    ['startgamedest'] = 'Start the game!',
    ['deletelobby'] = 'Delete Lobby',
    ['deletelobbydest'] = 'Delete your lobby!',
    ['attenplayers'] = 'Attending Players',
    ['alreadystart'] = 'The game has already started, sorry :(',
    ['requreplayer'] = 'The teams are missing at least one person.',
    ['skillalreadyuse'] = 'Skill has already been used',
    ['playersdil'] = 'Players:',
    ['entrancefee'] = "Entrance Fee:",
    ['availablelobby'] = "Available Lobbies",
    ['maplang'] = "Map:",
    ['pricelang'] = "Price:",
    ['maxkiller'] = "Max Killer",
    ['maxhiders'] = "Max Hiders",
    ['maxlang'] = "Max ",
    ['findhiders'] = "Find the hiders and get them!",
    ['findhidingplace'] = "Find a hiding place!",
    ['innohiding'] = "The innocents are hiding. Hold on!",
    ['turnobject'] = "Quickly turn into objects and hide yourself!",



    

} 
-- QBCore Beekeeping Advanced Client Features
local QBCore = exports['qb-core']:GetCoreObject()

-- Ensure shared globals exist when this file is loaded standalone
CreatedWildBeehives = CreatedWildBeehives or {}
ActiveWildHives = ActiveWildHives or {}
WildHivesSpawned = WildHivesSpawned or false
WildHiveSpawned = WildHiveSpawned or false

-----------------------------------------------
--------------- Menu System -------------------
-----------------------------------------------

RegisterNetEvent('mms-beekeeper:client:OpenMenu', function(CurrentBeehive)
    local Data = json.decode(CurrentBeehive[1].data)
    local HiveID = CurrentBeehive[1].id
    local serverOwner = CurrentBeehive[1].owner
    local isOwner = (CreatedBeehives[HiveID] and CreatedBeehives[HiveID].isOwner) or (serverOwner and PlayerData and PlayerData.citizenid and serverOwner == PlayerData.citizenid) or false
    if Config.Debug then
        print("^2[MMS-Beekeeper]^7 OpenMenu hive:", HiveID, "serverOwner:", tostring(serverOwner), "client citizenid:", tostring(PlayerData and PlayerData.citizenid), "isOwner:", tostring(isOwner))
    end
    
    -- Determine current hive type
    local currentType = "none"
    if Data.BeeSettings.QueenItem ~= "" then
        if Data.BeeSettings.QueenItem == "basic_queen" then
            currentType = "bees"
        elseif Data.BeeSettings.QueenItem == "basic_hornet_queen" then
            currentType = "wasps"
        end
    end
    
    local menuOptions = {
        {
            header = "🐝 Beehive Management",
            txt = "Queen: " .. Data.Queen .. " | Bees: " .. Data.Bees .. " | Health: " .. Data.Health,
            isMenuHeader = true
        }
    }
    
    -- Only show management options if player owns the hive
    if not isOwner then
        table.insert(menuOptions, {
            header = "👀 View Only",
            txt = "This is not your beehive",
            isMenuHeader = true
        })
        table.insert(menuOptions, {
            header = "❌ Close",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        })
        exports['qb-menu']:openMenu(menuOptions)
        return
    end
    
    -- If no type is set, show type selection
    if currentType == "none" then
        table.insert(menuOptions, {
            header = "🐝 Manage Bees",
            txt = "Manage bee colony in this hive",
            params = {
                event = "mms-beekeeper:client:OpenBeeMenu",
                args = {
                    hiveId = HiveID,
                    hiveType = "bees"
                }
            }
        })
        
        table.insert(menuOptions, {
            header = "🐝 Manage Wasps",
            txt = "Manage wasp colony in this hive",
            params = {
                event = "mms-beekeeper:client:OpenWaspMenu",
                args = {
                    hiveId = HiveID,
                    hiveType = "wasps"
                }
            }
        })
    else
        -- Show current type management
        if currentType == "bees" then
            table.insert(menuOptions, {
                header = "🐝 Manage Bees",
                txt = "Manage bee colony in this hive",
                params = {
                    event = "mms-beekeeper:client:OpenBeeMenu",
                    args = {
                        hiveId = HiveID,
                        hiveType = "bees"
                    }
                }
            })
        elseif currentType == "wasps" then
            table.insert(menuOptions, {
                header = "🐝 Manage Wasps",
                txt = "Manage wasp colony in this hive",
                params = {
                    event = "mms-beekeeper:client:OpenWaspMenu",
                    args = {
                        hiveId = HiveID,
                        hiveType = "wasps"
                    }
                }
            })
        end
        
        -- Add option to switch type (only if no bees/queens)
        if Data.Bees == 0 and Data.Queen == 0 then
            if currentType == "bees" then
                table.insert(menuOptions, {
                    header = "🔄 Switch to Wasps",
                    txt = "Switch this hive to wasp colony",
                    params = {
                        event = "mms-beekeeper:client:SwitchHiveType",
                        args = {
                            hiveId = HiveID,
                            newType = "wasps"
                        }
                    }
                })
            elseif currentType == "wasps" then
                table.insert(menuOptions, {
                    header = "🔄 Switch to Bees",
                    txt = "Switch this hive to bee colony",
                    params = {
                        event = "mms-beekeeper:client:SwitchHiveType",
                        args = {
                            hiveId = HiveID,
                            newType = "bees"
                        }
                    }
                })
            end
        end
    end
    
    -- Always show delete option
    table.insert(menuOptions, {
        header = "🗑️ Delete Hive",
        txt = "Permanently delete this hive",
        params = {
            event = "mms-beekeeper:client:DeleteHive",
            args = {
                hiveId = HiveID
            }
        }
    })
    
    table.insert(menuOptions, {
        header = "❌ Close",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    })
    
    exports['qb-menu']:openMenu(menuOptions)
end)

-- Bee Management Menu
RegisterNetEvent('mms-beekeeper:client:OpenBeeMenu', function(data)
    local HiveID = data.hiveId
    TriggerServerEvent('mms-beekeeper:server:GetBeehiveDataForMenu', HiveID, 'bees')
end)

RegisterNetEvent('mms-beekeeper:client:OpenBeeMenuData', function(CurrentBeehive, hiveType)
    local Data = json.decode(CurrentBeehive[1].data)
    local HiveID = CurrentBeehive[1].id
    local menuOptions = {
        {
            header = "🐝 Bee Colony Management",
            txt = "Queen: " .. Data.Queen .. " | Bees: " .. Data.Bees .. " | Health: " .. Data.Health,
            isMenuHeader = true
        },
        {
            header = "👑 Add Queen Bee",
            txt = "Add a queen bee to your hive",
            params = {
                event = "mms-beekeeper:client:AddQueen",
                args = {
                    hiveId = HiveID,
                    queen = "basic_queen"
                }
            }
        },
        {
            header = "🐝 Add Worker Bees",
            txt = "Add worker bees to your hive",
            params = {
                event = "mms-beekeeper:client:AddBees",
                args = {
                    hiveId = HiveID,
                    queen = "basic_queen"
                }
            }
        },
        {
            header = "🍯 Take Honey (" .. math.floor(Data.Product / Config.ProduktPerHoney) .. ")",
            txt = "Collect honey from your hive",
            params = {
                event = "mms-beekeeper:client:TakeHoney",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "🍯 Take Honey (All)",
            txt = "Collect all honey from your hive",
            params = {
                event = "mms-beekeeper:client:TakeAllHoney",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "🌾 Feed Hive (" .. Data.Food .. "/100)",
            txt = "Feed your bees with " .. Config.FoodItemLabel,
            params = {
                event = "mms-beekeeper:client:FeedHive",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "💧 Water Hive (" .. Data.Water .. "/100)",
            txt = "Water your bees with " .. Config.WaterItemLabel,
            params = {
                event = "mms-beekeeper:client:WaterHive",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "🧹 Clean Hive (" .. Data.Clean .. "/100)",
            txt = "Clean your hive with " .. Config.CleanItemLabel,
            params = {
                event = "mms-beekeeper:client:CleanHive",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "❤️ Heal Hive (" .. Data.Health .. "/100)",
            txt = "Heal your hive with " .. Config.HealItemLabel,
            params = {
                event = "mms-beekeeper:client:HealHive",
                args = {
                    hiveId = HiveID
                }
            }
        }
    }
    
    -- Add sickness option if sick
    if Data.Sickness.Type ~= "None" then
        table.insert(menuOptions, {
            header = "💊 Heal Sickness (" .. Data.Sickness.Type .. " - " .. Data.Sickness.Intensity .. "%)",
            txt = "Heal with " .. Data.Sickness.MedicineLabel,
            params = {
                event = "mms-beekeeper:client:HealSickness",
                args = {
                    hiveId = HiveID
                }
            }
        })
    end
    
    table.insert(menuOptions, {
        header = "❌ Close",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    })
    
    exports['qb-menu']:openMenu(menuOptions)
end)

-- Wasp Management Menu
RegisterNetEvent('mms-beekeeper:client:OpenWaspMenu', function(data)
    local HiveID = data.hiveId
    TriggerServerEvent('mms-beekeeper:server:GetBeehiveDataForMenu', HiveID, 'wasps')
end)

RegisterNetEvent('mms-beekeeper:client:OpenWaspMenuData', function(CurrentBeehive, hiveType)
    local Data = json.decode(CurrentBeehive[1].data)
    local HiveID = CurrentBeehive[1].id
    local menuOptions = {
        {
            header = "🐝 Wasp Colony Management",
            txt = "Queen: " .. Data.Queen .. " | Wasps: " .. Data.Bees .. " | Health: " .. Data.Health,
            isMenuHeader = true
        },
        {
            header = "👑 Add Wasp Queen",
            txt = "Add a wasp queen to your hive",
            params = {
                event = "mms-beekeeper:client:AddQueen",
                args = {
                    hiveId = HiveID,
                    queen = "basic_hornet_queen"
                }
            }
        },
        {
            header = "🐝 Add Worker Wasps",
            txt = "Add worker wasps to your hive",
            params = {
                event = "mms-beekeeper:client:AddBees",
                args = {
                    hiveId = HiveID,
                    queen = "basic_hornet_queen"
                }
            }
        },
        {
            header = "🍯 Take Manuka Honey (" .. math.floor(Data.Product / Config.ProduktPerHoney) .. ")",
            txt = "Collect manuka honey from your hive",
            params = {
                event = "mms-beekeeper:client:TakeHoney",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "🍯 Take Manuka Honey (All)",
            txt = "Collect all manuka honey from your hive",
            params = {
                event = "mms-beekeeper:client:TakeAllHoney",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "🌾 Feed Hive (" .. Data.Food .. "/100)",
            txt = "Feed your wasps with " .. Config.FoodItemLabel,
            params = {
                event = "mms-beekeeper:client:FeedHive",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "💧 Water Hive (" .. Data.Water .. "/100)",
            txt = "Water your wasps with " .. Config.WaterItemLabel,
            params = {
                event = "mms-beekeeper:client:WaterHive",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "🧹 Clean Hive (" .. Data.Clean .. "/100)",
            txt = "Clean your hive with " .. Config.CleanItemLabel,
            params = {
                event = "mms-beekeeper:client:CleanHive",
                args = {
                    hiveId = HiveID
                }
            }
        },
        {
            header = "❤️ Heal Hive (" .. Data.Health .. "/100)",
            txt = "Heal your hive with " .. Config.HealItemLabel,
            params = {
                event = "mms-beekeeper:client:HealHive",
                args = {
                    hiveId = HiveID
                }
            }
        }
    }
    
    -- Add sickness option if sick
    if Data.Sickness.Type ~= "None" then
        table.insert(menuOptions, {
            header = "💊 Heal Sickness (" .. Data.Sickness.Type .. " - " .. Data.Sickness.Intensity .. "%)",
            txt = "Heal with " .. Data.Sickness.MedicineLabel,
            params = {
                event = "mms-beekeeper:client:HealSickness",
                args = {
                    hiveId = HiveID
                }
            }
        })
    end
    
    table.insert(menuOptions, {
        header = "❌ Close",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    })
    
    exports['qb-menu']:openMenu(menuOptions)
end)

-- Switch Hive Type
RegisterNetEvent('mms-beekeeper:client:SwitchHiveType', function(data)
    local HiveID = data.hiveId
    local newType = data.newType
    
    local dialog = exports['qb-input']:ShowInput({
        header = "Switch Hive Type",
        submitText = "Switch",
        inputs = {
            {
                text = "Type 'SWITCH' to confirm changing to " .. newType,
                name = "confirm",
                type = "text",
                isRequired = true
            }
        }
    })
    
    if dialog and dialog.confirm == "SWITCH" then
        TriggerServerEvent('mms-beekeeper:server:SwitchHiveType', HiveID, newType)
    end
end)

-----------------------------------------------
--------------- Wild Beehives -----------------
-----------------------------------------------

function SpawnWildBeehives()
    if WildHivesSpawned then return end
    WildHivesSpawned = true
    
    for k, v in ipairs(Config.WildBeehives) do
        local model = GetHashKey(Config.WildBeehiveModel)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
        
        local wildHive = CreateObject(model, v.x, v.y, v.z, false, false, false)
        SetEntityHeading(wildHive, v.heading)
        FreezeEntityPosition(wildHive, true)
        
        CreatedWildBeehives[k] = {
            object = wildHive,
            coords = vector3(v.x, v.y, v.z),
            data = v
        }
        
        -- Create interaction thread for wild hive
        CreateThread(function()
            while CreatedWildBeehives[k] do
                Wait(0)
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - vector3(v.x, v.y, v.z))
                
                if distance < 2.0 then
                    QBCore.Functions.DrawText3D(v.x, v.y, v.z + 1.0, "[E] Wild Beehive")
                    
                    if IsControlJustPressed(0, 38) then -- E key
                        OpenWildBeehiveMenu(k, v)
                    end
                end
            end
        end)
    end
end

function OpenWildBeehiveMenu(hiveId, hiveData)
    local menuOptions = {
        {
            header = "🐝 Wild Beehive",
            txt = "Collect resources from this wild hive",
            isMenuHeader = true
        },
        {
            header = "🐝 Collect Bees",
            txt = "Collect bees from the wild hive",
            params = {
                event = "mms-beekeeper:client:CollectBeesFromWild",
                args = {
                    hiveId = hiveId
                }
            }
        },
        {
            header = "👑 Collect Queen",
            txt = "Collect queen from the wild hive",
            params = {
                event = "mms-beekeeper:client:CollectQueenFromWild",
                args = {
                    hiveId = hiveId
                }
            }
        },
        {
            header = "🍯 Collect Honey",
            txt = "Collect honey from the wild hive",
            params = {
                event = "mms-beekeeper:client:CollectHoneyFromWild",
                args = {
                    hiveId = hiveId
                }
            }
        },
        {
            header = "❌ Close",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        }
    }
    
    exports['qb-menu']:openMenu(menuOptions)
end

local QBCore = exports[Config.CoreName]:GetCoreObject()

function AlertCops(timing)
    if Config.AlertTiming == timing then
        return exports['ps-dispatch']:PaletoBankRobbery()
    end
end

function HasItem(item)
    local has = QBCore.Functions.HasItem(item)
    return has
end

function Minigame(type)
    local success = nil
    if type == 'memorygame-powerbox' then
        exports["memorygame"]:thermiteminigame(Config.MiniGames[type].correctBlocks, Config.MiniGames[type].incorrectBlocks, Config.MiniGames[type].timetoShow, Config.MiniGames[type].timetoLose,
        function() success = true end, function() success = false end)
    elseif type == 'scrambler' then
        exports['ps-ui']:Scrambler(function(suc)
            success = suc
        end, Config.MiniGames['scrambler'].type, Config.MiniGames['scrambler'].time, Config.MiniGames['scrambler'].mirrored)
    elseif type == 'laptophack' then
        exports['hacking']:OpenHackingGame(Config.MiniGames['laptophack'].puzzleDuration, Config.MiniGames['laptophack'].puzzleLength, Config.MiniGames['laptophack'].puzzleAmount, function(result) 
            success = result
        end)
    elseif type == 'varhack' then
        exports['ps-ui']:VarHack(function(result)
            success = result
        end, Config.MiniGames['varhack'].blocks, Config.MiniGames['varhack'].speed)
    elseif type == "casinohack" then
        exports['casinohack']:OpenHackingGame(function(result)
            success = result
        end, Config.MiniGames['maze'].time)
    elseif type == 'safecracker' then
        local code = {}
        for i=1,Config.MiniGames['safecracker'].combination,1 do
            table.insert(code, math.random(0,99))
        end
        success = exports["pd-safe"]:createSafe(code)
    elseif type == 'lightout' then
        success = exports['lightsout']:StartLightsOut(Config.MiniGames['lightout'].grid, Config.MiniGames['lightout'].maxClicks) -- Minigame for lightout
    elseif type == 'password' then
        local dialog = exports['qb-input']:ShowInput({
            header = "Access Code",
            submitText = "Submit",
            inputs = {
                {
                    text = "Input access code", -- text you want to be displayed as a place holder
                    name = "code", -- name of the input should be unique otherwise it might override
                    type = "password", -- type of the input
                    isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                    -- default = "password123", -- Default text option, this is optional
                }
            },
        })
        if dialog ~= nil then
            success = dialog.code
        else 
            success = false
        end

    end
    while success == nil do
        Wait(100)
    end
    return success
end

Citizen.CreateThread(function()
    exports[Config.TargetName]:AddCircleZone("CameraPanel", Config.PaletoBank['camera-panel']['target']['coords'], Config.PaletoBank['camera-panel']['target']['radius'], {
        name = "CameraPanel", 
        debugPoly = false, 
        useZ = true,
        }, {
        options = { 
            { 
            icon = 'fas fa-desktop',
            label = Lang:t("target.access_cameras"),
            action = function()
                CameraPanel()
            end,
            canInteract = function() 
                return true
            end,
            }
        },
        distance = 2.5,
    })
    exports[Config.TargetName]:AddCircleZone("electronic-panel", Config.PaletoBank['electronic-panel']['target']['coords'], Config.PaletoBank['electronic-panel']['target']['radius'], {
        name = "electronic-panel", 
        debugPoly = false, 
        useZ = true,
        }, {
        options = { 
            { 
            icon = 'fas fa-desktop',
            label = Lang:t("target.activate"),
            action = function()
                HackElectronicPanel()
            end,
            canInteract = function() 
                return true
            end,
            }
        },
        distance = 2.5,
    })
    exports[Config.TargetName]:AddCircleZone("SecurityBackdoor", Config.PaletoBank['security-backdoor']['target']['coords'], Config.PaletoBank['security-backdoor']['target']['radius'], {
        name = "SecurityBackdoor", 
        debugPoly = false, 
        useZ = true,
        }, {
        options = { 
            { 
            icon = 'fas fa-desktop',
            label = Lang:t("target.activate"),
            action = function()
                BackdoorHack('security-backdoor', Config.PaletoBank['security-backdoor']['target']['coords'])
            end,
            canInteract = function() 
                return not Config.Doors['vault']['unlocked']
            end,
            }
        },
        distance = 1.5,
    })
    exports[Config.TargetName]:AddCircleZone("HallwayBackdoor", Config.PaletoBank['sh-backdoor']['target']['coords'], Config.PaletoBank['sh-backdoor']['target']['radius'], {
        name = "HallwayBackdoor", 
        debugPoly = false, 
        useZ = true,
        }, {
        options = { 
            { 
            icon = 'fas fa-desktop',
            label = Lang:t("target.activate"),
            action = function()
                BackdoorHack('hallway-backdoor', Config.PaletoBank['sh-backdoor']['target']['coords'])
            end,
            canInteract = function() 
                return true
            end,
            }
        },
        distance = 1.5,
    })
    exports[Config.TargetName]:AddCircleZone("ControlPanel", Config.PaletoBank['control-panel']['target']['coords'], Config.PaletoBank['control-panel']['target']['radius'], {
        name = "ControlPanel", 
        debugPoly = false, 
        useZ = true,
        }, {
        options = { 
            { 
            icon = 'fas fa-desktop',
            label = Lang:t("target.access_control_panel"),
            action = function()
                ControlPanel()
            end,
            canInteract = function() 
                return true
            end,
            }
        },
        distance = 2.5,
    })
    exports[Config.TargetName]:AddCircleZone("OfficeHack", Config.PaletoBank['office1-hack']['target']['coords'], Config.PaletoBank['office1-hack']['target']['radius'], {
        name = "OfficeHack", 
        debugPoly = false, 
        useZ = true,
        }, {
        options = { 
            { 
            icon = 'fas fa-desktop',
            label = Lang:t("target.activate"),
            action = function()
                ActivatePointLocations()
            end,
            canInteract = function() 
                return not SyncData['pointactivation']
            end,
            }
        },
        distance = 2.5,
    })
    exports[Config.TargetName]:AddCircleZone("BossOffice", Config.PaletoBank['boss-safe']['target']['coords'], Config.PaletoBank['boss-safe']['target']['radius'], {
        name = "BossOffice", 
        debugPoly = false, 
        useZ = true,
        }, {
        options = { 
            { 
            icon = 'fas fa-desktop',
            label = Lang:t("target.crack_safe"),
            action = function()
                CrackSafe()
            end,
            canInteract = function() 
                return not SyncData['loot']['boss-safe']
            end,
            }
        },
        distance = 2.5,
    })
    exports[Config.TargetName]:AddCircleZone("VaultAccess", Config.PaletoBank['vault-access']['target']['coords'], Config.PaletoBank['vault-access']['target']['radius'], {
        name = "VaultAccess", 
        debugPoly = false, 
        useZ = true,
        }, {
        options = { 
            { 
            icon = 'fas fa-desktop',
            label = Lang:t("target.start_hacking"),
            action = function()
                HackVault()
            end,
            canInteract = function() 
                return not Config.Doors['vault']['unlocked']
            end,
            }
        },
        distance = 2.5,
    })
    for k, v in pairs(Config.PaletoBank['pointlocations']) do 
        exports[Config.TargetName]:AddCircleZone("PowerBox"..k, v['target']['coords'], v['target']['radius'], {
            name = "PowerBox"..k, 
            debugPoly = false, 
            useZ = true,
            }, {
            options = { 
                { 
                icon = 'fas fa-desktop',
                label = Lang:t("target.activate"),
                action = function()
                    PointHack(k)
                end,
                canInteract = function() 
                    return SyncData['pointactivation']
                end,
                }
            },
            distance = 2.5,
        })
    end
    for k, v in pairs(Config.PaletoBank['officeloot']) do 
        exports[Config.TargetName]:AddCircleZone("officeloot"..k, v['target']['coords'], v['target']['radius'], {
            name = "officeloot"..k, 
            debugPoly = false, 
            useZ = true,
            }, {
            options = { 
                { 
                icon = 'fas fa-sack-dollar',
                label = Lang:t("target.loot"),
                action = function()
                    OfficeLoot(k)
                end,
                canInteract = function() 
                    return SyncData[k]['hacked'] and not SyncData['loot'][k]
                end,
                }
            },
            distance = 2.5,
        })
    end
    for k, v in pairs(Config.PaletoBank['lockers']) do 
        exports[Config.TargetName]:AddCircleZone("locker"..tostring(k), v['target']['coords'], v['target']['radius'], {
            name = "locker"..tostring(k), 
            debugPoly = false, 
            useZ = true,
            }, {
            options = { 
                { 
                icon = 'fas fa-sack-dollar',
                label = Lang:t("target.drill"),
                action = function()
                    Drill(k)
                end,
                canInteract = function() 
                    return SyncData['vault']['open'] and not v['taken']
                end,
                }
            },
            distance = 2.5,
        })
    end
    for k, v in pairs(Config.PaletoBank['trollys']) do
        local coords = vector3(v.coords.x, v.coords.y, v.coords.z+1)
        if v.type == "money" then
            exports[Config.TargetName]:AddCircleZone("PaletoTrolly"..tostring(k), coords, 0.5, {
                name = "PaletoTrolly"..tostring(k), 
                debugPoly = false, 
                useZ = true,
                }, {
                options = { 
                    { 
                    icon = 'fas fa-sack-dollar',
                    label = Lang:t("target.take_money"),
                    action = function()
                        LootTrolly(k)
                    end,
                    canInteract = function()
                        if not Config.PaletoBank['trollys'][k].taken and SyncData['vault']['open'] then return true end
                        return false
                    end,
                    }
                },
                    distance = 1.5,
                })
        elseif v.type == "gold" then 
            exports[Config.TargetName]:AddCircleZone("PaletoTrolly"..tostring(k), coords, 0.5, {
                name = "PaletoTrolly"..tostring(k), 
                debugPoly = false, 
                useZ = true,
                }, {
                options = { 
                    { 
                    icon = 'fas fa-sack-dollar',
                    label = Lang:t("target.take_gold"),
                    action = function()
                        LootTrolly(k)
                    end,
                    canInteract = function()
                    if not Config.PaletoBank['trollys'][k].taken and SyncData['vault']['open'] then return true end
                        return false
                    end,
                    }
                },
                    distance = 1.5,
            })
        elseif v.type == "diamond" then 
            exports[Config.TargetName]:AddCircleZone("PaletoTrolly"..tostring(k), coords, 0.5, {
                name = "PaletoTrolly"..tostring(k), 
                debugPoly = false, 
                useZ = true,
                }, {
                options = { 
                    { 
                    icon = 'fas fa-gem',
                    label = Lang:t("target.take_diamond"),
                    action = function()
                        LootTrolly(k)
                    end,
                    canInteract = function()
                    if not Config.PaletoBank['trollys'][k].taken and SyncData['vault']['open'] then return true end
                        return false
                    end,
                    }
                },
                    distance = 1.5,
            })
        end
    end
end)

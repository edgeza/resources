local QBCore = exports[Config.CoreName]:GetCoreObject()

function AlertCops()
    exports['ps-dispatch']:PacificBankRobbery()
end

function HasItem(item)
    local has = QBCore.Functions.HasItem(item)
    return has
end

function Minigame(type)
    local success = nil
    if type == 'lightout' then
        success = exports['lightsout']:StartLightsOut(Config.MiniGames['lightout'].grid, Config.MiniGames['lightout'].maxClicks) -- Minigame for lightout
    elseif type ==  'memorygame-access' or type == 'memorygame-thermite' then
        exports["memorygame"]:thermiteminigame(Config.MiniGames[type].correctBlocks, Config.MiniGames[type].incorrectBlocks, Config.MiniGames[type].timetoShow, Config.MiniGames[type].timetoLose,
        function() success = true end, function() success = false end)
    elseif type == 'voltlab' then
        TriggerEvent('ultra-voltlab', Config.MiniGames['voltlab'].time, function(result,reason)
            if result == 1 then success = true else success = false end
        end)
    elseif type == 'laptophack' then
        exports['hacking']:OpenHackingGame(Config.MiniGames['laptophack'].puzzleDuration, Config.MiniGames['laptophack'].puzzleLength, Config.MiniGames['laptophack'].puzzleAmount, function(result) 
            success = result
        end)
    elseif type == 'safecracker' then
        local code = {}
        for i=1,Config.MiniGames['safecracker'].combination,1 do
            table.insert(code, math.random(0,99))
        end
        success = exports["pd-safe"]:createSafe(code)
    elseif type == 'numbers' then
        success = exports['numbers']:StartNumbersGame(Config.MiniGames['numbers'].numbersLength, Config.MiniGames['numbers'].timer, Config.MiniGames['numbers'].showTime)
    elseif type == 'varhack' then
        exports['varhack']:OpenHackingGame(function(result)
            success = result
        end, Config.MiniGames['varhack'].blocks, Config.MiniGames['varhack'].speed)
    elseif type == 'password' then
        local dialog = exports['qb-input']:ShowInput({
            header = "Access-Code",
            submitText = "Submit",
            inputs = {
                {
                    text = "Input access-code", -- text you want to be displayed as a place holder
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
    for k,v in ipairs(Config.OfficeHacks) do
        exports[Config.TargetName]:AddBoxZone("PacificOffice"..tostring(k), v.pos, v.height, v.width, {
            name = "PacificOffice"..tostring(k),
            heading = v.heading,
            debugPoly = Config.Debug,
            minZ = v.minZ,
            maxZ = v.maxZ,
        }, {
            options = { 
                {
                    action = function()
                        OfficeHack(k)
                    end,
                    icon = 'fas fa-desktop',
                    label = Lang:t("target.start_hacking"),
                    canInteract = function()
                        if not Config.OfficeHacks[k].hacked and not Config.OfficeHacks[k].busy then return true end
                        return false
                    end
                }
            },
            distance = 1.5,
        })
    end
    exports[Config.TargetName]:AddBoxZone("PacficSafeCracker", Config.AccessOfficeSafeCracker.pos, Config.AccessOfficeSafeCracker.height, Config.AccessOfficeSafeCracker.width, {
        name = "PacficSafeCracker",
        heading = Config.AccessOfficeSafeCracker.heading,
        debugPoly = Config.Debug,
        minZ = Config.AccessOfficeSafeCracker.minZ,
        maxZ = Config.AccessOfficeSafeCracker.maxZ,
    }, {
        options = { 
            {
                action = function()
                    SafeCracker()
                end,
                icon = 'fas fa-lock-open',
                label = Lang:t("target.lockpick_safe"),
                canInteract = function()
                    if not Config.AccessOfficeSafeCracker.cracked and not Config.AccessOfficeSafeCracker.busy then return true end
                    return false
                end
            }
        },
        distance = 1.5,
    })
    for k,v in pairs(Config.InputAccessCodes) do
        exports[Config.TargetName]:AddBoxZone("PacificAccess"..k, v.pos, v.height, v.width, {
            name = "PacificAccess"..k,
            heading = v.heading,
            debugPoly = Config.Debug,
            minZ = v.minZ,
            maxZ = v.maxZ,
        }, {
            options = { 
                {
                    action = function()
                        InputAccessCode(k)
                    end,
                    icon = 'fas fa-desktop',
                    label = Lang:t("target.input_access_code"),
                    canInteract = function()
                        if not Config.InputAccessCodes[k].hacked and not Config.InputAccessCodes[k].busy then return true end
                        return false
                    end
                },
                {
                    action = function()
                        ResetBank()
                    end,
                    icon = 'fas fa-shield',
                    label = Lang:t("target.reset_bank"),
                    canInteract = function()
                        if not Config.ResetTimerActive then
                            local PlayerData = QBCore.Functions.GetPlayerData()
                            for k, v in pairs(Config.PoliceJobs) do
                                if PlayerData.job.name == v then
                                    return true
                                end
                            end
                        end
                        return false
                    end
                }
            },
            distance = 1.5,
        })
    end
    for k,v in pairs(Config.Safes) do
        exports[Config.TargetName]:AddBoxZone("PacificSafe"..k, v.pos, v.height, v.width, {
            name = "PacificSafe"..k,
            heading = v.heading,
            debugPoly = Config.Debug,
            minZ = v.minZ,
            maxZ = v.maxZ,
        }, {
            options = { 
                {
                    action = function()
                        DrillSafe(k)
                    end,
                    icon = 'fas fa-screwdriver',
                    label = Lang:t("target.drill_safe"),
                    canInteract = function()
                        if not Config.Safes[k].open and not Config.Safes[k].busy then return true end
                        return false
                    end,
                    item = 'hardeneddrill'
                }
            },
            distance = 1.5,
        })
    end
    exports[Config.TargetName]:AddCircleZone("PacificPowerBox", Config.PowerBox.pos, Config.PowerBox.radius, {
    name = "PacificPowerBox", 
    debugPoly = Config.Debug, 
    useZ = Config.PowerBox.useZ,
    }, {
    options = { 
        { 
        icon = 'fas fa-power-off',
        label = Lang:t("target.disable_lasers"),
        action = function()
            HackLasers()
        end,
        canInteract = function() 
            if not Config.PowerBox.busy and not Config.PowerBox.hacked then return true end 
            return false
        end,
        }
    },
    distance = 2.5,
    })
    for k,v in pairs(Config.SafeRoomHacks) do
        exports[Config.TargetName]:AddCircleZone("PacificCellar"..k, v.pos, v.radius, {
            name = "PacificCellar"..k, 
            debugPoly = Config.Debug, 
            useZ = v.useZ,
            }, {
            options = { 
                { 
                icon = 'fas fa-desktop',
                label = Lang:t("target.start_hacking"),
                action = function()
                    HackSide(k)
                end,
                canInteract = function() 
                    if not Config.SafeRoomHacks[k].busy and not Config.SafeRoomHacks[k].hacked and not Config.AlarmTriggered then return true end 
                    return false
                end,
                }
            },
            distance = 2.5,
            })
    end
    for k,v in pairs(Config.TableLoot) do
        exports[Config.TargetName]:AddBoxZone("PacificTable"..tostring(k), v.pos, v.height, v.width, {
            name = "PacificTable"..tostring(k),
            heading = v.heading,
            debugPoly = Config.Debug,
            minZ = v.minZ,
            maxZ = v.maxZ,
        }, {
            options = { 
                {
                    action = function()
                        LootTable(k)
                    end,
                    icon = 'fas fa-screwdriver',
                    label = Lang:t("target.loot_table"),
                    canInteract = function()
                        if not Config.TableLoot[k].looted then return true end
                        return false
                    end
                }
            },
            distance = 1.5,
        })
    end
    exports[Config.TargetName]:AddCircleZone("PacificVault", Config.Vault.pos, Config.Vault.radius, {
        name = "PacificVault", 
        debugPoly = Config.Debug, 
        useZ = Config.Vault.useZ,
        }, {
        options = { 
            { 
            icon = 'fas fa-bomb',
            label = Lang:t("target.plant_c4"),
            action = function()
                VaultBomb()
            end,
            canInteract = function() 
                if not Config.AlarmTriggered then return true end
                return false
            end,
            }
        },
        distance = 1.5,
        })
    exports[Config.TargetName]:AddCircleZone("PacificVaultDoors", Config.VaultHack.pos, Config.VaultHack.radius, {
        name = "PacificVaultDoors", 
        debugPoly = Config.Debug, 
        useZ = Config.VaultHack.useZ,
        }, {
        options = { 
            { 
            icon = 'fas fa-desktop',
            label = Lang:t("target.start_hacking"),
            action = function()
                VaultDoorHack()
            end,
            canInteract = function() 
                if not Config.VaultHack.hacked and not Config.VaultHack.busy then return true end
                return false
            end,
            }
        },
        distance = 1.5,
        })
        for k, v in pairs(Config.Trolly) do
            local coords = vector3(v.coords.x, v.coords.y, v.coords.z+1)
            if v.type == "money" then
                exports[Config.TargetName]:AddCircleZone("PacificTrolly"..tostring(k), coords, 0.5, {
                    name = "PacificTrolly"..tostring(k), 
                    debugPoly = Config.Debug, 
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
                        if not Config.Trolly[k].taken then return true end
                            return false
                        end,
                        }
                    },
                        distance = 1.5,
                    })
            elseif v.type == "gold" then 
                exports[Config.TargetName]:AddCircleZone("PacificTrolly"..tostring(k), coords, 0.5, {
                    name = "PacificTrolly"..tostring(k), 
                    debugPoly = Config.Debug, 
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
                        if not Config.Trolly[k].taken then return true end
                            return false
                        end,
                        }
                    },
                        distance = 1.5,
                })
            end
        end
end)
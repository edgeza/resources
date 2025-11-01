-- EyeTarget | GKSPHONE

if Config.EyeTarget then
    if GetResourceState("ox_target") == "started" then
        exports["ox_target"]:addGlobalPlayer({
            {
                icon = "fas fa-hands",
                label = _T(LastItemData?.info?.phoneLang, "PHONE.PHONE_SET_EYETARGET"),
                onSelect = function(data)
                    if data.entity and not IsPedAPlayer(data.entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
                    GiveNumberClosest()
                end,
                distance = 2.5,
            },
        })
    elseif GetResourceState("qb-target") == "started" then
        exports["qb-target"]:AddGlobalPlayer({
            options = {
                {
                    event = "number",
                    icon = "fas fa-hands",
                    label = _T(LastItemData?.info?.phoneLang, "PHONE.PHONE_SET_EYETARGET"),
                    action = function(entity)                             -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                        if not IsPedAPlayer(entity) then return false end -- This will return false if the entity interacted with is a player and otherwise returns true
                        GiveNumberClosest()
                    end,
                },
            },
            distance = 2.5,
        })
    end

    if Config.PhoneBox then
        if GetResourceState("ox_target") == "started" then
            for k, l in pairs(Config.PhoneBoothModel) do
                exports["ox_target"]:addModel(k, {
                    {
                        icon = "fa-solid fa-phone",
                        label = _T(LastItemData?.info?.phoneLang, "PHONE.PHONE_PHONEBOX"),
                        onSelect = function()
                            Bootphoneopen()
                        end,
                        distance = 2.5,
                    },
                })
            end
        elseif GetResourceState("qb-target") == "started" then
            for k, l in pairs(Config.PhoneBoothModel) do
                exports["qb-target"]:AddTargetModel(k, {
                    options = {
                        {
                            icon = "fa-solid fa-phone",
                            label = _T(LastItemData?.info?.phoneLang, "PHONE.PHONE_PHONEBOX"),
                            action = function()
                                Bootphoneopen()
                            end
                        },
                    },
                    distance = 2.5,
                })
            end
        end
    end

    if ChargeEyeTarget then
        --- Normal Charging
        if GetResourceState("ox_target") == "started" then
            exports["ox_target"]:addModel(GetHashKey(NormalChargingPropName), {
                {
                    icon = "fa fa-mobile",
                    label = _T(LastItemData?.info?.phoneLang, "Charge.APP_CHARGE_NORMAL_CHARGE"),
                    onSelect = function()
                        NormalChargePhone()
                    end,
                    distance = 2.5,
                },
                {
                    icon = "fa fa-bolt",
                    label = _T(LastItemData?.info?.phoneLang, "Charge.APP_CHARGE_CANCEL"),
                    onSelect = function()
                        CancelCharge()
                    end,
                    distance = 2.5,
                },
            })

            --- Fast Charging
            exports["ox_target"]:addModel(GetHashKey(FastChargingPropName), {
                {
                    icon = "fa fa-mobile",
                    label = _T(LastItemData?.info?.phoneLang, "Charge.APP_CHARGE_FAST_CHARGE"),
                    onSelect = function()
                        FastChargePhone()
                    end,
                    distance = 2.5,
                },
                {
                    icon = "fa fa-bolt",
                    label = _T(LastItemData?.info?.phoneLang, "Charge.APP_CHARGE_CANCEL"),
                    onSelect = function()
                        CancelCharge()
                    end,
                    distance = 2.5,
                },
            })
        elseif GetResourceState("qb-target") == "started" then
            exports["qb-target"]:AddTargetModel(GetHashKey(NormalChargingPropName), {
                options = {
                    {
                        icon = "fa fa-mobile",
                        label = _T(LastItemData?.info?.phoneLang, "Charge.APP_CHARGE_NORMAL_CHARGE"),
                        action = function()
                            NormalChargePhone()
                        end
                    },
                    {
                        icon = "fa fa-bolt",
                        label = _T(LastItemData?.info?.phoneLang, "Charge.APP_CHARGE_CANCEL"),
                        action = function()
                            CancelCharge()
                        end
                    },
                },
                distance = 2.5,
            })

            --- Fast Charging
            exports["qb-target"]:AddTargetModel(GetHashKey(FastChargingPropName), {
                options = {
                    {
                        icon = "fa fa-mobile",
                        label = _T(LastItemData?.info?.phoneLang, "Charge.APP_CHARGE_FAST_CHARGE"),
                        action = function()
                            FastChargePhone()
                        end
                    },
                    {
                        icon = "fa fa-bolt",
                        label = _T(LastItemData?.info?.phoneLang, "Charge.APP_CHARGE_CANCEL"),
                        action = function()
                            CancelCharge()
                        end
                    },
                },
                distance = 2.5,
            })
        end
    end

    function GiveNumberClosest()
        local closestPlayer, distance = GetClosestPlayer()
        Debugprint('closestPlayer', closestPlayer, MyPhoneNumber)
        if MyPhoneNumber then
            TriggerServerEvent('gksphone:gks:addContact:eyetarget', MyPhoneNumber, GetPlayerServerId(closestPlayer))
        end
    end
end

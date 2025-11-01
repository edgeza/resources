
function GetFramework()
    if Config.Framework ~= 'autodetect' then
        return Config.Framework
    end

    if GetResourceState('qbx_core') == 'started' then
        return 'qbox'
    elseif GetResourceState('qb-core') == 'started' then
        return 'qb'
    elseif GetResourceState('es_extended') == 'started' then
        return 'esx'
    else
        print('^1[Warning] No compatible Framework detected.^0')
        return nil
    end
end

function GetTextUI()
    if Config.TextUI ~= 'autodetect' then
        return Config.TextUI
    end

    if GetResourceState('ox_lib') == 'started' then
        return 'ox_lib'
    elseif GetResourceState('qb-core') == 'started' then
        return 'qb-core'
    elseif GetResourceState('jg-textui') == 'started' then
        return 'jg-textui'
    elseif GetResourceState('esx_textui') == 'started' then
        return 'esx_textui'
    elseif GetResourceState('cd_drawtextui') == 'started' then
        return 'cd_drawtextui'
    elseif GetResourceState('brutal_textui') == 'started' then
        return 'brutal_textui'
    elseif GetResourceState('lation_ui') == 'started' then
        return 'lation_ui'
    else
        print('^1[Warning] No compatible TextUI resource detected.^0')
        return nil
    end
end

function GetBossMenu()
    if Config.BossMenu ~= 'autodetect' then
        return Config.BossMenu
    end

    if GetResourceState('qbx_management') == 'started' then
        return 'qbx_management'
    elseif GetResourceState('esx_society') == 'started' then
        return 'esx_society'
    elseif GetResourceState('qb-management') == 'started' then
        return 'qb-management'
    elseif GetResourceState('vms_bossmenu') == 'started' then
        return 'vms_bossmenu'
    else
        print('^1[Warning] No compatible BossMenu resource detected.^0')
        return nil
    end
end

function GetTarget()
    if Config.Target ~= 'autodetect' then
        return Config.Target
    end

    if GetResourceState('ox_target') == 'started' then
        return 'ox_target'
    elseif GetResourceState('qb-target') == 'started' then
        return 'qb-target'
    else
        print('^1[Warning] No compatible Target resource detected.^0')
        return nil
    end
end

function GetNotify()
    if Config.Notify ~= 'autodetect' then
        return Config.Notify
    end

    if GetResourceState('ox_lib') == 'started' then
        return 'ox_lib'
    elseif GetResourceState('lation_ui') == 'started' then
        return 'lation_ui'
    elseif GetResourceState('esx_notify') == 'started' then
        return 'esx_notify'
    elseif GetResourceState('okokNotify') == 'started' then
        return 'okokNotify'
    elseif GetResourceState('wasabi_notify') == 'started' then
        return 'wasabi_notify'
    elseif GetResourceState('brutal_notify') == 'started' then
        return 'brutal_notify'
    elseif GetResourceState('mythic_notify') == 'started' then
        return 'mythic_notify'
    else
        print('^1[Warning] No compatible Notification resource detected.^0')
        return nil
    end
end

function GetBillingMenu()
    if Config.BillingMenu ~= 'autodetect' then
        return Config.BillingMenu
    end

    if GetResourceState('esx_billing') == 'started' then
        return 'esx_billing'
    elseif GetResourceState('s1n_billing') == 'started' then
        return 's1n_billing'
    elseif GetResourceState('okokBilling') == 'started' then
        return 'okokBilling'
    elseif GetResourceState('codem-billing') == 'started' then
        return 'codem-billing'
    elseif GetResourceState('qb-phone') == 'started' then
        return 'qb-phone'
    else
        print('^1[Warning] No compatible Billing resource detected.^0')
        return nil
    end
end

function GetClothing()
    if Config.Clothing ~= 'autodetect' then
        return Config.Clothing
    end

    if GetResourceState('esx_skin') == 'started' then
        return 'esx_skin'
    elseif GetResourceState('illenium-appearance') == 'started' then
        return 'illenium-appearance'
    elseif GetResourceState('fivem-appearance') == 'started' then
        return 'fivem-appearance'
    elseif GetResourceState('qb-clothing') == 'started' then
        return 'qb-clothing'
    elseif GetResourceState('tgiann-clothing') == 'started' then
        return 'tgiann-clothing'
    elseif GetResourceState('rcore_clothing') == 'started' then
        return 'rcore_clothing'
    else
        print('^1[Warning] No compatible Clothing resource detected.^0')
        return nil
    end
end

function GetSociety()
    if Config.Society.resourcename ~= 'autodetect' then
        return Config.Society.resourcename
    end

    if GetResourceState('esx_addonaccount') == 'started' then
        return 'esx_addonaccount'
    elseif GetResourceState('qb-banking') == 'started' then
        return 'qb-banking'
    elseif GetResourceState('qb-management') == 'started' then
        return 'qb-management'
    elseif GetResourceState('okokBanking') == 'started' then
        return 'okokBanking'
    elseif GetResourceState('Renewed-Banking') == 'started' then
        return 'Renewed-Banking'
    else
        print('^1[Warning] No compatible Society resource detected.^0')
        return nil
    end
end

-- crm-scoreboard - Execute your custom code when scoreboard show.

function crm_on_open()
    -- SetNuiFocusKeepInput(true)
    DisplayRadar(false)
    if GetResourceState('crm-hud') == "started" then
        exports['crm-hud']:crm_toggle_hud(false)
    end
end

-- crm-scoreboard - Execute your custom code when scoreboard hide.

function crm_on_close()
    -- SetNuiFocusKeepInput(false)
    DisplayRadar(true)
    if GetResourceState('crm-hud') == "started" then
        exports['crm-hud']:crm_toggle_hud(true)
    end
end
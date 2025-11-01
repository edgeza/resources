
function OpenIcecreamMenu()
    local id = 'ice_machine_menu'
    local title = Locale("icemachine_title")
    local options = {
            {
                title = Locale("icemahine_add_water"),
                description = Locale("icemahine_add_water_description"),
                icon = 'tint',
                onSelect = function()
                    TriggerServerEvent('pl_uwucafe:icemachine:addWater')
                end
            },
            {
                title = Locale("icemachine_check_ice"),
                description = Locale("icemachine_check_ice_description"),
                icon = 'snowflake',
                onSelect = function()
                    TriggerServerEvent('pl_uwucafe:icemachine:getStatus')
                end
            },
            {
                title = Locale("icemachine_take_ice"),
                description = Locale("icemachine_take_ice_description"),
                icon = 'hand-holding-water',
                onSelect = function()
                    TriggerServerEvent('pl_uwucafe:icemachine:takeIce')
                end
            }
        }
    ContextMenu(id,title,options)
end



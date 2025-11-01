
function OpenBillingMenu()
    if Config.BillingMenu == 'builtin' then
        CustomBillingMenu()
        return
    end

    local title = Locale("bill_player_title")
    local submitText = "Submit"
    local options = {
            {
                type = 'input',
                label = Locale("bill_player_id"),
                description = Locale("bill_player_enter_id"),
                icon = 'fas fa-hashtag',
                required = true
            },
            {
                type = 'number',
                label = Locale("bill_amount"),
                description = string.format(Locale("bill_enter_amount"), Config.MaxBillAmount),
                icon = 'fas fa-dollar-sign',
                required = true,
                min = 0,
                max = Config.MaxBillAmount
            }
        }
    local input = showInputDialog(title, options, submitText)
    if input then
        local targetId = tonumber(input[1])
        local billamount = tonumber(input[2])

        if targetId and billamount and billamount > 0 then
            local can = 'abahzgcjancakdaoq'
            TriggerServerEvent("pl_uwucafe:billplayer", targetId, billamount, can)
        else
            Notify(Locale("invalid_input"), 'error')
        end
    end
end
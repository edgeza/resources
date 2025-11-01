local isTextUiOpen = false
local currentText
local currentUI = GetTextUI()

function TextUIShow(text, opts)
    if currentText == text then return end
    currentText = text
    opts = opts or {}
    if currentUI == 'ox_lib' then
        local styleOptions = {
            position = opts.position or 'left-center',
            icon = opts.icon or 'fa-solid fa-circle-info',
            style = opts.style or {
                borderRadius = 4,
                backgroundColor = '#333333',
                color = '#ffffff'
            }
        }
        lib.showTextUI(text, styleOptions)

    elseif currentUI == 'qb-core' then
        exports['qb-core']:DrawText(text, opts.align or 'right')

    elseif currentUI == 'jg-textui' then
        exports['jg-textui']:DrawText(text)

    elseif currentUI == 'esx_textui' then
        exports['esx_textui']:TextUI(text)

    elseif currentUI == 'cd_drawtextui' then
        TriggerEvent('cd_drawtextui:ShowUI', 'show', text)

    elseif currentUI == 'brutal_textui' then
        exports['brutal_textui']:Open(text, opts.color or "blue")
    elseif currentUI == 'lation_ui' then
        exports.lation_ui:showText({
            description = text
        })
    end

    isTextUiOpen = true
end


function TextUIIsOpen()
    return isTextUiOpen, currentText
end

function TextUIHide()
    if currentUI == 'ox_lib' then
        lib.hideTextUI()
    elseif currentUI == 'qb-core' then
        exports['qb-core']:HideText()
    elseif currentUI == 'jg-textui' then
        exports['jg-textui']:HideText()
    elseif currentUI == 'esx_textui' then
        exports['esx_textui']:HideUI()
    elseif currentUI == 'cd_drawtextui' then
        TriggerEvent('cd_drawtextui:HideUI')
    elseif currentUI == 'brutal_textui' then
        exports['brutal_textui']:Close()
    elseif currentUI == 'lation_ui' then
        exports.lation_ui:hideText()
    end
    isTextUiOpen = false
    currentText = nil
end
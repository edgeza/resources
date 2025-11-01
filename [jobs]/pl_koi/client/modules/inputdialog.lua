function showInputDialog(title, options, submitText)
    if Config.InputDialog == 'ox_lib' then
        return lib.inputDialog(title, options)
    elseif Config.InputDialog == 'lation_ui' then
        return exports.lation_ui:input({
            title = title,
            submitText = submitText,
            options = options
        })
    end
end

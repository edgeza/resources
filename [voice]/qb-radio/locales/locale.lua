if not Locale then
    local LocaleClass = {}
    LocaleClass.__index = LocaleClass

    local function interpolate(str, vars)
        if type(str) ~= 'string' then return str end
        if not vars then return str end

        return (str:gsub("%%{(.-)}", function(key)
            key = key:gsub("^%s*(.-)%s*$", "%1")
            local value = vars[key]
            if value == nil then
                return ""
            end
            return tostring(value)
        end))
    end

    local function resolvePluralKey(vars)
        if not vars then return 'other' end
        local count = vars.count or vars.Count or vars.value or vars.Value
        if count == 1 then
            return 'one'
        end
        return 'other'
    end

    function LocaleClass:new(options)
        options = options or {}
        local instance = setmetatable({
            phrases = options.phrases or {},
            warnOnMissing = options.warnOnMissing,
            fallback = options.fallback
        }, self)
        return instance
    end

    function LocaleClass:t(key, vars)
        local phrase = self.phrases[key]

        if phrase == nil and self.fallback then
            phrase = self.fallback.phrases[key]
        end

        if phrase == nil then
            if self.warnOnMissing then
                print(('[Locale] Missing translation for "%s"'):format(key))
            end
            return key
        end

        if type(phrase) == 'table' then
            phrase = phrase[resolvePluralKey(vars)] or phrase.other
        end

        return interpolate(phrase, vars)
    end

    function LocaleClass:add(key, value)
        self.phrases[key] = value
    end

    Locale = LocaleClass
end


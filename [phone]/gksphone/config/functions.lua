local function IsResourceStartedOrStarting(resource)
    local state = GetResourceState(resource)
    return state == "started" or state == "starting"
end

if Config.Framework == "auto" then
    if GetResourceState('es_extended') == 'started' then
        Config.Framework = "esx"
    elseif GetResourceState('qbx_core') == 'started' then
        Config.Framework = "qbx"
    elseif GetResourceState('qb-core') == 'started' then
        Config.Framework = "qb"
    else
        Config.Framework = "standalone"
    end
end

if Config.HouseScript == "auto" then
    if IsResourceStartedOrStarting("loaf_housing") then
        Config.HouseScript = "loaf_housing"
    elseif IsResourceStartedOrStarting("bcs_housing") then
        Config.HouseScript = "bcs_housing"
    elseif IsResourceStartedOrStarting("qs-housing") then
        Config.HouseScript = "qs-housing"
    elseif IsResourceStartedOrStarting("qb-houses") then
        Config.HouseScript = "qb-houses"
    elseif IsResourceStartedOrStarting("esx_property") then
        Config.HouseScript = "esx_property"
    end
end

function Debugprint(...)
    if Config.Debug then
        local args = {...}
        local appendedStr = ''
        for _, v in ipairs(args) do
            appendedStr = appendedStr .. ' ' .. (type(v) == "table" and json.encode(v) or tostring(v))
        end
        local msgTemplate = '^5[GKSPHONE]^0%s^0'
        local msg = msgTemplate:format(appendedStr)
        print(msg)
    end
end

function TableFilter(tbl, func)
    local newtbl = {}
    for i, v in ipairs(tbl) do
        if func(v) then
            table.insert(newtbl, v)
        end
    end
    return newtbl
end

function MathTrim(value)
    value = tostring(value)
    return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
end

Locales = {}

function LocalesSettings()
    local languages = Config.Locales
    for _, lang in ipairs(languages) do
        local jsonData = json.decode(LoadResourceFile("gksphone", "config/locales/" .. lang .. ".json"))
        Locales[lang] = jsonData
    end
end

function _T(lang, fullPath, replacements)
    lang = lang or Config.DefaultLocale
    if not Locales[lang] then
        return "Language not found!"
    end

    local parts = {}
    for part in string.gmatch(fullPath, "[^.]+") do
        table.insert(parts, part)
    end

    local translation = Locales[lang]
    for _, part in ipairs(parts) do
        translation = translation and translation[part] or nil
    end

    if not translation then
        return "Translation not found!"
    end

    if replacements then
        for k, v in pairs(replacements) do
            translation = translation:gsub("{" .. k .. "}", v)
        end
    end

    return translation
end

function _U()
    return "0"
end

LocalesSettings()

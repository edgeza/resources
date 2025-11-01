-- Dosyayı oku ve JSON'u Lua tablosuna dönüştür.
local function loadLocaleFile(resourceName, filePath)
    -- Kaynak dosyasını yükle
    local fileContent = LoadResourceFile(resourceName, filePath)
    if not fileContent then
        print("Error: Unable to load file " .. filePath)
        return nil
    end

    return json.decode(fileContent)
end

local localeData = loadLocaleFile(GetCurrentResourceName(), "locales/"..Config.Language..".json") 

if not localeData then
    localeData = loadLocaleFile(GetCurrentResourceName(), "locales/en.json") 
end

ui_locales = {}
if localeData and localeData.ui then
    for key, value in pairs(localeData.ui) do
        if type(value) == "table" then
            ui_locales[key] = value
        else
            ui_locales[key] = value
        end
    end
else
    print("Error: Locale data not found or invalid.")
end
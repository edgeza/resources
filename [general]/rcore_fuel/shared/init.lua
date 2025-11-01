CreateThread(function()
    for identifier, shopData in pairs(Config.ShopList) do
        for index, pumpData in pairs(shopData.pumpPosition) do
            pumpData.source = {}
            pumpData.occupied = {}
        end
    end

    for k, v in pairs(Config.FuelTypeUnitsMeasurementsUnits[Config.MeasurementUnits]) do
        if Locales then
            if type(Locales) == "table" then
                if Locales[Config.Locale] then
                    Locales[Config.Locale][k] = v
                end
            end
        end

        DefaultLocales[k] = v
    end
end, "Adding additional things for tables needed")
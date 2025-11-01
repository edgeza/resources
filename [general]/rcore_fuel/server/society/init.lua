if not Config.SocietySystem then
    Config.SocietySystem = Society.AUTOMATIC
end

if Config.SocietySystem == Society.AUTOMATIC then
    local qbBakingResourceName = SocietyResourceName[Society.QB_BANKING]
    if IsResourceOnServer(qbBakingResourceName) and GetResourceMetadata(qbBakingResourceName, 'version', 0) >= '2.0.0' then
        Config.SocietySystem = Society.QB_BANKING
    else
        -- older version qb-banking doesnt provide exports needed.
        SocietyResourceName[Society.QB_BANKING] = nil

        for societyKey, societyName in pairs(SocietyResourceName) do
            if IsResourceOnServer(societyName) then
                Config.SocietySystem = societyKey
                break
            end
        end
    end
end
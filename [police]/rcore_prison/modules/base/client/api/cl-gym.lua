function ReceiveExerciseStats(name)
    if isResourceLoaded(GYM_RESOURCES.RTX) then
        TriggerServerEvent("rcore_prison:server:UpdateExerciseStats", name, SH.zoneId)
        dbg.debug('Successfully increased stats using RTX GYM resource.')
    elseif isResourceLoaded('brutal_gym') then
        exports.brutal_gym:AddSkillCount('Strength', 0.01)
    else
        dbg.bridge('Failed to find any supported GYM resource for increasing stats.')
    end
end

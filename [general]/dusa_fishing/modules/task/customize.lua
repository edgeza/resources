AddEventHandler('dusa_fishing:FishCaught', function (fish)
    for k, v in pairs(config.taskList) do
        if v.taskDetails.type == 'catch' and v.taskDetails.fish == fish.name then
            AddProgressToTask(k)
        end
    end
end)
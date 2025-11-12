function RequestSpawnObject(object)
    local hash = GetHashKey(object)
    RequestModel(hash)
    while not HasModelLoaded(hash) do 
        Wait(1000)
    end
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

function AddTarget(entity)
    exports[Config.Target]:AddTargetEntity(entity, {
        options = {
            {
                name = 'play',
                action = function()
                    OpenUI('menu')
                end,
                icon = 'fa-solid fa-play',
                label = Config.Translations[Config.Locale].playnow,
            },
            {
                name = 'groups',
                action = function()
                    OpenUI('group')
                end,
                icon = 'fa-solid fa-user-group',
                label = Config.Translations[Config.Locale].groups,
            },
            {
                name = 'scoreboard',
                action = function()
                    OpenUI('scoreboard')
                end,
                icon = 'fa-solid fa-clipboard',
                label = Config.Translations[Config.Locale].tscoreboard,
            },
        },
    })
end
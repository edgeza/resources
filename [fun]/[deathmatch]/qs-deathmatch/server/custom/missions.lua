function CreateQuests(source)
    if GetResourceState('qs-inventory') ~= 'started' then
        Debug('qs-inventory not started, skipping deathmatch quest creation.')
        return 
    end

    local quest1 = exports['qs-inventory']:createQuest(source, {
        name = 'win_deathmatch',
        title = 'Match Winner',
        description = 'Win a deathmatch game against other players.',
        reward = 300,
        requiredLevel = 2
    })

    local quest2 = exports['qs-inventory']:createQuest(source, {
        name = 'enter_deathmatch_lobby',
        title = 'Getting in the Zone',
        description = 'Join a deathmatch lobby at least 5 times.',
        reward = 200,
        requiredLevel = 1
    })

    local quest3 = exports['qs-inventory']:createQuest(source, {
        name = 'create_deathmatch_game',
        title = 'Game Master',
        description = 'Create your own deathmatch match.',
        reward = 250,
        requiredLevel = 2
    })

    Debug('Deathmatch quests assigned to player:', source, {
        win_deathmatch = quest1,
        enter_deathmatch_lobby = quest2,
        create_deathmatch_game = quest3
    })
end

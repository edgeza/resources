local playerServerID = GetPlayerServerId(PlayerId())
local playersInRadio, currentRadioChannel, currentRadioChannelName = {}, nil, nil
local allowedToSeeRadioList = not Config.RadioListOnlyShowsToGroupsWithAccess
local radioListVisibility = true
local temporaryName = "temporaryPlayerNameAsAWorkaroundForABugInPMA-VOICEWhichEventsGetCalledTwiceWhileThePlayerConnectsToTheRadioForFirstTime"

-- Settings UI state tracking
local settingsOpen = false

-- Ensure focus is cleared on (re)load
SetNuiFocus(false, false)

local function setNuiFocus(state)
    SetNuiFocus(state, state)
    SetNuiFocusKeepInput(false)
end

local function closeTheRadioList()
    playersInRadio, currentRadioChannel, currentRadioChannelName = {}, nil, nil
    SendNUIMessage({ clearRadioList = true })
end

local function modifyTheRadioListVisibility(state)
    SendNUIMessage({ changeVisibility = true, visible = (allowedToSeeRadioList and state) or false })
end

local function addServerIdToPlayerName(serverId, playerName)
    if Config.ShowPlayersServerIdNextToTheirName then
        if Config.PlayerServerIdPosition == "left" then playerName = ("%s) %s"):format(serverId, playerName)
        elseif Config.PlayerServerIdPosition == "right" then playerName = ("%s (%s"):format(playerName, serverId) end
    end
    return playerName
end

local function addPlayerToTheRadioList(playerId, playerName)
    if playersInRadio[playerId] then return end
    local wasEmpty = not next(playersInRadio)
    playersInRadio[playerId] = temporaryName
    playersInRadio[playerId] = addServerIdToPlayerName(playerId, playerName or Player(playerId).state[Shared.State.nameInRadio] or callback.await(Shared.Callback.getPlayerName, false, playerId))
    SendNUIMessage({ self = playerId == playerServerID, radioId = playerId, radioName = playersInRadio[playerId], channel = currentRadioChannelName })
    -- Show the UI when adding first player
    if wasEmpty then
        modifyTheRadioListVisibility(radioListVisibility)
    end
end

local function removePlayerFromTheRadioList(playerId)
    if not playersInRadio[playerId] then return end
    if playersInRadio[playerId] == temporaryName then return end
    if playerId == playerServerID then closeTheRadioList() return end
    playersInRadio[playerId] = nil
    SendNUIMessage({ radioId = playerId })
end

RegisterNetEvent("pma-voice:addPlayerToRadio", function(playerId)
    if not currentRadioChannel or not (currentRadioChannel > 0) then return end
    addPlayerToTheRadioList(playerId)
end)

RegisterNetEvent("pma-voice:removePlayerFromRadio", function(playerId)
    if not currentRadioChannel or not (currentRadioChannel > 0) then return end
    removePlayerFromTheRadioList(playerId)
end)

RegisterNetEvent("pma-voice:syncRadioData", function()
    closeTheRadioList()
    local _playersInRadio
    _playersInRadio, currentRadioChannel, currentRadioChannelName = callback.await(Shared.Callback.getPlayersInRadio, false)
    if _playersInRadio and next(_playersInRadio) then
        for playerId, playerName in pairs(_playersInRadio) do
            addPlayerToTheRadioList(playerId, playerName)
        end
        -- Ensure visibility is set after syncing
        modifyTheRadioListVisibility(radioListVisibility)
    end
    _playersInRadio = nil
end)

-- set talkingState on radio for self
RegisterNetEvent("pma-voice:radioActive")
AddEventHandler("pma-voice:radioActive", function(talkingState)
    SendNUIMessage({ radioId = playerServerID, radioTalking = talkingState })
end)

-- set talkingState on radio for other radio members
RegisterNetEvent("pma-voice:setTalkingOnRadio")
AddEventHandler("pma-voice:setTalkingOnRadio", function(source, talkingState)
    SendNUIMessage({ radioId = source, radioTalking = talkingState })
end)

AddStateBagChangeHandler(Shared.State.allowedToSeeRadioList, ("player:%s"):format(playerServerID), function(bagName, key, value)
    local receivedPlayerServerId = tonumber(bagName:gsub('player:', ''), 10)
    if not receivedPlayerServerId or receivedPlayerServerId ~= playerServerID then return end
    if value == nil then
        allowedToSeeRadioList = not Config.RadioListOnlyShowsToGroupsWithAccess
    else
        allowedToSeeRadioList = value
    end
    modifyTheRadioListVisibility(radioListVisibility)
end)

if Config.LetPlayersChangeVisibilityOfRadioList then
    ---@diagnostic disable-next-line: missing-parameter
    RegisterCommand(Config.RadioListVisibilityCommand,function()
        radioListVisibility = not radioListVisibility
        modifyTheRadioListVisibility(radioListVisibility)
    end)
    TriggerEvent("chat:addSuggestion", "/"..Config.RadioListVisibilityCommand, "Show/Hide Radio List")
end

if Config.LetPlayersSetTheirOwnNameInRadio then
    TriggerEvent("chat:addSuggestion", "/"..Config.RadioListChangeNameCommand, "Customize your name to be shown in radio list", { { name = "customized name", help = "Enter your desired name to be shown in radio list" } })
end

if Config.HideRadioListVisibilityByDefault then
    SetTimeout(1000, function()
        radioListVisibility = false
        modifyTheRadioListVisibility(radioListVisibility)
    end)
else
    -- Initialize visibility on resource start if not hidden by default
    SetTimeout(1000, function()
        modifyTheRadioListVisibility(radioListVisibility)
    end)
end

if Config.LetPlayersChangeRadioChannelsName then
    TriggerEvent("chat:addSuggestion", "/"..Config.ModifyRadioChannelNameCommand, "Modify the name of the radio channel you are currently in", { { name = "customized name", help = "Enter your desired name to set it as you current radio channel's name" } })
end

local function openSettings()
    if settingsOpen then return end
    settingsOpen = true
    setNuiFocus(true)
    SendNUIMessage({ openSettings = true })
end

local function closeSettings()
    settingsOpen = false
    SetNuiFocusKeepInput(false)
    setNuiFocus(false)
    SendNUIMessage({ closeSettings = true })
end

-- Settings command
RegisterCommand("radionames", function()
    openSettings()
end, false)

TriggerEvent("chat:addSuggestion", "/radionames", "Open Radio Names settings to customize colors, size, and position")

local function handleClose(_, cb)
    closeSettings()
    if cb then cb(true) end
end

RegisterNUICallback("settingsSaved", handleClose)
RegisterNUICallback("close", handleClose)
RegisterNUICallback("closeSettings", handleClose)
RegisterNUICallback("escape", handleClose)

-- Toggle edit mode for positioning
RegisterNUICallback("toggleEditMode", function(data, cb)
    SendNUIMessage({ toggleEditMode = data.enabled })
    if data.enabled then
        SetNuiFocusKeepInput(true)
    else
        SetNuiFocusKeepInput(false)
    end
    cb(true)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    settingsOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ closeSettings = true })
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    settingsOpen = false
    SetNuiFocus(false, false)
end)


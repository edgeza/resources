-- ## Client Sided Event Handlers

---@param fish string Fish type identifier ('bass'|'tuna'|'carp'|'trout'|'perch'|'mullet'|'lobster'|'crab'|'octopus'|'shrimp'|'turtle')
RegisterNetEvent('dusa_fishing:handler:FishCaught', function(fish)
    ---@class PlayerData
    ---@field Job JobData Player's job information
    ---@field Firstname string Player's first name
    ---@field Lastname string Player's last name
    ---@field DateOfBirth string Player's date of birth (DD-MM-YYYY format)
    ---@field Gender string Player's gender ('m' for male, 'f' for female)

    ---@class JobData
    ---@field Name string Job name identifier (e.g., 'police', 'ambulance')
    ---@field Label string Job display name (e.g., 'Police', 'EMS')
    ---@field Duty boolean Whether player is currently on duty
    ---@field Boss boolean Whether player has boss privileges
    ---@field Grade GradeData Player's job grade information

    ---@class GradeData
    ---@field Name string Grade name (e.g., 'Sergeant', 'Officer')
    ---@field Level number Grade level/number

    ---@type PlayerData
    local PlayerData = Framework.Player
end)

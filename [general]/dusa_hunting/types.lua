---@meta

---@class Player
---@field Functions PlayerFunctions
---@field source number
---@field identifier string
---@field name string

---@class PlayerFunctions
---@field GetPlayer fun(source: number): Player
---@field GetPlayerByCitizenId fun(citizenid: string): Player
---@field GetPlayers fun(): Player[]

---@class Framework
---@field GetPlayer fun(source: number): Player
---@field GetPlayerByCitizenId fun(citizenid: string): Player
---@field GetPlayers fun(): Player[]
---@field CreateCallback fun(name: string, cb: function)
---@field TriggerCallback fun(name: string, source: number, cb: function, ...)

---@class QuestSystem
---@field CreateQuest fun(data: table): string
---@field GetQuest fun(id: string): table
---@field UpdateQuest fun(id: string, data: table)
---@field DeleteQuest fun(id: string)

---@type Framework
Framework = {}

---@type QuestSystem  
QuestSystem = {}

---@type table
Config = {}
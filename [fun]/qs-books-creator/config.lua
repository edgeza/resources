--============================================================================--
-- Quasar Store · Configuration Guidelines
-- Resource: qs-books-creator
--============================================================================--
-- [INFO] Archivo de configuración principal.
-- [INFO] Define idioma, límites de páginas, comportamiento del autor automático,
--        comandos de ejemplo y detección del framework activo.
--============================================================================--

Config  = Config or {}  -- [CORE] Main configuration table.
Locales = Locales or {} -- [CORE] Multilanguage container (if used by your resource).

--============================================================================--
-- Framework Detection
--============================================================================--
local function DependencyCheck(data)
    for k, v in pairs(data) do
        if GetResourceState(k):find('started') ~= nil then
            return v
        end
    end
    return false
end

-- [CORE] Known frameworks → internal alias
local frameworks            = {
    ['es_extended'] = 'esx',
    ['qb-core']     = 'qb',
    ['qbx_core']    = 'qb',
}

Config.Framework            = DependencyCheck(frameworks) -- [AUTO] Auto-detects active framework.

--============================================================================--
-- Language & Targeting
--============================================================================--
-- [EDIT] Two-letter language code for your locales (if available).
--         Supported: 'ar','bg','ca','cs','da','de','el','en','es','fa','fr','he',
--                    'hi','hu','it','jp','ko','nl','no','pl','pt','ro','ru','sl',
--                    'sv','th','tk','tr','zh-CN','zh-TW'
--──────────────────────────────────────────────────────────────────────────────
Config.Language             = 'en' -- [EDIT] Default language code.

--============================================================================--
-- Book System Settings
--============================================================================--
Config.MaxPages             = 20   -- [EDIT] Maximum pages allowed per book.
Config.MinPages             = 2    -- [EDIT] Minimum pages required to save.
Config.AutoAuthorFromPlayer = true -- [EDIT] Automatically use player name as author.

--============================================================================--
-- Inventory System Detection
--============================================================================--
-- [INFO] Determines which inventory system is active and automatically selects
--        the proper integration file located in "server/custom/inventory/".
-- [EDIT] Supported systems:
--         • ox_inventory      → 'ox'
--         • qs-inventory      → 'qs'
--         • qb-inventory      → 'qb'
--         • codem-inventory   → 'codem'
--         • tgiann-inventory  → 'tgiann'
--──────────────────────────────────────────────────────────────────────────────
local inventories           = {
    ['ox_inventory']     = 'ox',     -- [INFO] Integration for ox_inventory.
    ['qs-inventory']     = 'qs',     -- [INFO] Integration for qs-inventory.
    ['qb-inventory']     = 'qb',     -- [INFO] Integration for qb-inventory.
    ['codem-inventory']  = 'codem',  -- [INFO] Integration for codem-inventory.
    ['tgiann-inventory'] = 'tgiann', -- [INFO] Integration for tgiann-inventory.
}

-- [AUTO] Automatically detect the running inventory system.
Config.Inventory            = DependencyCheck(inventories)

--============================================================================--
-- Book Commands (Example Presets)
--============================================================================--
-- [ADV] Players can use /book <command> to instantly open these presets.
--       Example: /book test → opens "Monkey Mayhem 5".
--============================================================================--
Config.BookCommands         = {
    {
        command = 'test',            -- [EDIT] Command alias (/book op)
        title   = 'Monkey Mayhem 5', -- [EDIT] Title displayed in-game.
        author  = 'Quasar',          -- [INFO] Author name shown below title.
        pages   = {                  -- [INFO] Ordered list of image URLs.
            'https://i.ibb.co/RkdJj4Hz/qs1.png',
            'https://i.ibb.co/WWfBBNPy/qs2.png',
            'https://i.ibb.co/LdMxsgwn/qs3.png',
            'https://i.ibb.co/k2JQGMDT/qs4.png',
            'https://i.ibb.co/ch8BBrFb/qs5.png',
            'https://i.ibb.co/99RRC3Jx/qs6.png',
            'https://i.ibb.co/Tq4VbvkX/qs8.png'
        }
    },
    -- {
    --     command = 'demo',      -- [EDIT] Command alias (/book demo)
    --     title   = 'Demo Book', -- [EDIT] Demo title.
    --     author  = 'Quasar',    -- [INFO] Demo author.
    --     pages   = {            -- [INFO] Example random images.
    --         'https://picsum.photos/seed/cover/1200/900',
    --         'https://picsum.photos/seed/p2/1200/900',
    --         'https://picsum.photos/seed/p3/1200/900'
    --     }
    -- }
}

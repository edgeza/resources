crm_config = {}
crm_config.crm_debug = false

-- crm-core - 

crm_config.crm_settings = {
    crm_qbox = true, -- Enable this if you are usin QBox.
    crm_inv = "crm_qs", -- Inventory: "crm_qb", "crm_esx", "crm_ox", "crm_qs"
    crm_not = "crm_ox", -- Notify: "crm_notify", "crm_ox", "crm_hud"
    crm_tui = "crm_ox", -- Text UI: "crm_textui", "crm_ox", "crm_qb"
    crm_rad = "crm_qb", -- Radial Menu: "crm_radial", "crm_ox", "crm_qb"
    crm_tar = "crm_qb", -- Target: "crm_target", "crm_ox", "crm_qb"
}

-- crm-core - 

crm_config.crm_resources = {
    -- your server framework, will be detected automatically. if you have rename your framework folder, change it here as well.
    crm_lib = { 
        crm_qb = "qb-core", -- Works for both QBcore / QBox.
        crm_esx = "es_extended", -- ESX
    },
    -- 
    crm_inv = {
        crm_ox = "ox_inventory",
        crm_qb = "qb-inventory",
        crm_esx = "esx_addoninventory",
        crm_qs = "qs-inventory",
    },
    --
    crm_rad = {
        crm_radial = "crm-radialmenu",
        crm_ox = "ox_lib",
        crm_qb = "qb-radialmenu",
    },
    --
    crm_not = {
        crm_notify = "crm-core",
        crm_ox = "ox_lib",
        crm_hud = "crm-hud",
    },
    --
    crm_tui = {
        crm_textui = "crm-core",
        crm_ox = "ox_lib",
        crm_qb = "qb-core",
    },
    --
    crm_tar = {
        crm_ox = "ox_target",
        crm_qb = "qb-target"
    },
}

-- crm-core - 

crm_config.crm_notifs = { -- Only if use our built-in notification system.
    ['crm-primary'] = {crm_title = "Primary", crm_icon = "fa-check-double", crm_color = "var(--crm-primary)"},
    ['crm-success'] = {crm_title = "Success", crm_icon = "fa-check-double", crm_color = "var(--crm-success)"},
    ['crm-error'] = {crm_title = "Error", crm_icon = "fa-circle-xmark", crm_color = "var(--crm-danger)"},
}
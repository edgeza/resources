local Translations = {
    notify = {
        missing_item = "You are missing something...",
        failed = "Failed...",
        success = "Success!",
        minutes = " minutes",
        not_enough_cops = "Not enough cops.",
        code = "Code: ",
        wrong_code = "Wrong code.",
        opening_in = "Vault door opens in: ",
    },
    target = {
        access_control_panel = "Access control panel",
        access_cameras = "Access cameras",
        activate = "Activate",
        loot = "Loot",
        crack_safe = "Crack safe",
        start_hacking = "Start hacking",
        take_money = "Take money",
        take_gold = "Take gold",
        take_diamond = "Take diamonds",
        drill = "Drill",
    },
    progress = {
        looting = "Looting.."
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
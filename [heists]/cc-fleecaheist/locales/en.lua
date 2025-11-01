local Translations = {
    notify = {
        missing_item = "You are missing something...",
        failed = "Failed...",
        minutes = " minutes",
        not_enough_cops = "Not enough cops.",
        code = "Code: ",
        wrong_code = "Wrong code.",
        opening_in = "Vault door opens in: ",
    },
    target = {
        start_hacking = "Start hacking",
        drill_safe = "Drill",
        take_money = "Take money",
        take_gold = "Take gold",
        get_code = "Get code",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
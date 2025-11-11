return {
    drillTime = 15, -- 15 seconds to finish drilling the atm.
    copCheck = 0, -- there has to be 3 or more cops online.
    globalCooldown = 10, -- Global cooldown between each robbery (minutes). If a atm has been robbed no one can rob another one until 10 minutes.
    playerCooldown = 20, -- Cooldown until same player can rob another atm.
    powerCount = 10, -- time in seconds the vehicle needs to activley pull the atm for it to fall out.
    driveWithRope = true, -- If true the rope will stay attach after robbed and player can drive around with the atm still attached.
    interactKey = 47, -- https://docs.fivem.net/docs/game-references/controls/ only used if not using ox_target, to change the key text go to translate file.

    -- you can change the item names.
    itemNames = {
        ropeName = "rope",
        drillName = "drill"
    }
}

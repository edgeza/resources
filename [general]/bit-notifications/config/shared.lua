Config, Lang = {}, {}
-- $$$$$$\   $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$\   $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\
-- $$  __$$\ $$  __$$\ $$$\  $$ |$$  _____|\_$$  _|$$  __$$\ $$ |  $$ |$$  __$$\ $$  __$$\\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |
-- $$ /  \__|$$ /  $$ |$$$$\ $$ |$$ |        $$ |  $$ /  \__|$$ |  $$ |$$ |  $$ |$$ /  $$ |  $$ |     $$ |  $$ /  $$ |$$$$\ $$ |
-- $$ |      $$ |  $$ |$$ $$\$$ |$$$$$\      $$ |  $$ |$$$$\ $$ |  $$ |$$$$$$$  |$$$$$$$$ |  $$ |     $$ |  $$ |  $$ |$$ $$\$$ |
-- $$ |      $$ |  $$ |$$ \$$$$ |$$  __|     $$ |  $$ |\_$$ |$$ |  $$ |$$  __$$< $$  __$$ |  $$ |     $$ |  $$ |  $$ |$$ \$$$$ |
-- $$ |  $$\ $$ |  $$ |$$ |\$$$ |$$ |        $$ |  $$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |  $$ |     $$ |  $$ |  $$ |$$ |\$$$ |
-- \$$$$$$  | $$$$$$  |$$ | \$$ |$$ |      $$$$$$\ \$$$$$$  |\$$$$$$  |$$ |  $$ |$$ |  $$ |  $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |
-- \______/  \______/ \__|  \__|\__|      \______| \______/  \______/ \__|  \__|\__|  \__|  \__|   \______| \______/ \__|  \__|

-- Notification Trigger example:
--TriggerClientEvent("bit-notifications:open", src, "Title", "Message", 5000, "success")
-- Notification types: "success", "error", "info", "warning"
--To send open/close message:
-- /openstore [message] | /closestore [message]

--Use "esx" or "qb"
Config.Framework = "qb"
--If you are using one of the most recent versions of ESX, set the script name. Default = "es_extended"
Config.ESXExport = ""
--Default ESX: "esx:getSharedObject" | Default QB: "qb-core"
Config.Core = "qb-core"
--Notifications position (top-right, top-left, top-center, bottom-right, bottom-left, bottom-center, center-left, center-right)
Config.notiPosition = "center-left"
--Store notifications position (top-right, top-left, top-center, bottom-right, bottom-left, bottom-center, center-left, center-right)
Config.storesNotiPosition = "top-center"
--Command to open the store (only users with the required job can use it)
Config.openStoreCommand = "openstore"
--Command to close the store (only users with the required job can use it)
Config.closeStoreCommand = "closestore"

-- $$\        $$$$$$\  $$\   $$\  $$$$$$\  $$\   $$\  $$$$$$\   $$$$$$\  $$$$$$$$\
-- $$ |      $$  __$$\ $$$\  $$ |$$  __$$\ $$ |  $$ |$$  __$$\ $$  __$$\ $$  _____|
-- $$ |      $$ /  $$ |$$$$\ $$ |$$ /  \__|$$ |  $$ |$$ /  $$ |$$ /  \__|$$ |
-- $$ |      $$$$$$$$ |$$ $$\$$ |$$ |$$$$\ $$ |  $$ |$$$$$$$$ |$$ |$$$$\ $$$$$\
-- $$ |      $$  __$$ |$$ \$$$$ |$$ |\_$$ |$$ |  $$ |$$  __$$ |$$ |\_$$ |$$  __|
-- $$ |      $$ |  $$ |$$ |\$$$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |
-- $$$$$$$$\ $$ |  $$ |$$ | \$$ |\$$$$$$  |\$$$$$$  |$$ |  $$ |\$$$$$$  |$$$$$$$$\
-- \________|\__|  \__|\__|  \__| \______/  \______/ \__|  \__| \______/ \________|

Lang.error = "Error"
Lang.noPermissions = "You don't have permissions to do this action"
Lang.cooldown = "You must wait before using this command again"

--  $$$$$$\ $$$$$$$$\  $$$$$$\  $$$$$$$\  $$$$$$$$\  $$$$$$\
-- $$  __$$\\__$$  __|$$  __$$\ $$  __$$\ $$  _____|$$  __$$\
-- $$ /  \__|  $$ |   $$ /  $$ |$$ |  $$ |$$ |      $$ /  \__|
-- \$$$$$$\    $$ |   $$ |  $$ |$$$$$$$  |$$$$$\    \$$$$$$\
--  \____$$\   $$ |   $$ |  $$ |$$  __$$< $$  __|    \____$$\
-- $$\   $$ |  $$ |   $$ |  $$ |$$ |  $$ |$$ |      $$\   $$ |
-- \$$$$$$  |  $$ |    $$$$$$  |$$ |  $$ |$$$$$$$$\ \$$$$$$  |
--  \______/   \__|    \______/ \__|  \__|\________| \______/

Stores = {
    ["Palm Coast "] = {
        image = "nui://bit-notifications/html/assets/Palm_Logo.png",
        name = "Palm Coast",
        job = "palmcoast",
        minGrade = 0
    },
    ["Department of Justice"] = {
        image = "nui://bit-notifications/html/assets/doj_logo.png",
        name = "Department of Justice",
        job = "doj",
        minGrade = 0
    },
    ["Benny's"] = {
        image = "nui://bit-notifications/html/assets/bennys.jpg",
        name = "Benny's",
        job = "bennies",
        minGrade = 0
    },
    ["Bean Machine"] = {
        image = "nui://bit-notifications/html/assets/beanmachine.jpg",
        name = "Bean Machine",
        job = "beanmachine",
        minGrade = 0
    },
    ["Billiards and Bowl"] = {
        image = "nui://bit-notifications/html/assets/BilliardsLogo.png",
        name = "Billiards and Bowl",
        job = "billiards",
        minGrade = 0
    },
    ["OneLife Medical"] = {
        image = "nui://bit-notifications/html/assets/One_Life_Medical.png",
        name = "OneLife Medical",
        job = "ambulance",
        minGrade = 0
    },
    ["Burger Shot"] = {
        image = "nui://bit-notifications/html/assets/burguershot.jpg",
        name = "Burger Shot",
        job = "burgershot",
        minGrade = 0
    },
    ["LSPD"] = {
        image = "nui://bit-notifications/html/assets/police.png",
        name = "LSPD",
        job = "police",
        minGrade = 0
    },
    ["CatCafe"] = {
        image = "nui://bit-notifications/html/assets/uwu.png",
        name = "CatCafe",
        job = "catcafe",
        minGrade = 0
    },
    ["AOD"] = {
        image = "nui://bit-notifications/html/assets/angels_of_death.png",
        name = "Angels Of Death",
        job = "aod",
        minGrade = 0
    },
    ["OneLife"] = {
        image = "nui://bit-notifications/html/assets/onelife.png",
        name = "OneLife",
        job = "events",
        minGrade = 1
    },
    ["Weazel News"] = {
        image = "nui://bit-notifications/html/assets/wn.png",
        name = "Weazel News",
        job = "reporter",
        minGrade = 0
    },
    ["UpNAtom"] = {
        image = "nui://bit-notifications/html/assets/upnatom.png",
        name = "UpNAtom",
        job = "upnatom",
        minGrade = 0
    },
    ["OneLife Mechanic"] = {
        image = "nui://bit-notifications/html/assets/onelife_mechanics.png",
        name = "OneLife Mechanic",
        job = "olrpmechanic",
        minGrade = 0
    },
    ["6STR Tuner Shop"] = {
        image = "nui://bit-notifications/html/assets/tunershop.png",
        name = "6STR Tuner Shop",
        job = "6str",
        minGrade = 0
    },
   ["OneLife Towing"] = {
        image = "nui://bit-notifications/html/assets/Towing.png",
        name = "OneLife Towing",
        job = "towing",
        minGrade = 0
        
    },
    ["KOI Restaurant"] = {
        image = "nui://bit-notifications/html/assets/Towing.png",
        name = "KOI",
        job = "koi",
        minGrade = 0
    }
}

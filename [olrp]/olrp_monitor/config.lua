Config = {}

Config.AllowedGroups = { "admin", "mod" }

-- Vehicle Value Estimation (average vehicle prices)
Config.VehicleBaseValue = 50000  -- Base value per vehicle (adjust based on your server)

-- Database Table Names (adjust if your server uses different table names)
Config.DatabaseTables = {
    players = "players",
    vehicles = "player_vehicles",
    inventory = "player_inventories",  -- or "ox_inventory" depending on your inventory system
    trucker = "trucker_users",
    bankAccounts = "bank_accounts",
    societyAccounts = "society_accounts",
    societyTransactions = "society_transactions"
}

Config.Texts = {
    brandName = "OLRP Monitor",
    brandSubtitle = "by OLRP",
    totalAmountLabel = "💰 Total Economy:",
    cryptoAmountLabel = "₿ Total Crypto:",
    vehiclesLabel = "🚗 Total Vehicles:",
    serverEconomyTitle = "OLRP Economy Monitor",
    cashLabel = "Cash 💵",
    bankLabel = "Bank 🏦",
    cryptoLabel = "Crypto ₿",
    vehiclesLabelColumn = "Vehicles 🚗",
    itemsLabelColumn = "Items 📦",
    networthLabel = "Networth 💎",
    totalLabel = "Total 💰",
    closeButton = "Close",
    copyButton = "Send to Discord",
    noPermission = "You do not have permission to use this command.",
    noDataFound = "No data found.",
    searchPlaceholder = "Search for player name...",
    abuseFlag = "⚠️ SUSPICIOUS",
    loadingText = "Loading economy data...",
    prevPageButton = "Previous",
    nextPageButton = "Next"
}

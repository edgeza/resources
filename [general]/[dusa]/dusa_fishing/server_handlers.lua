-- ## Server Sided Event Handlers

---@class PlayerData
---@field Job JobData Player's job information
---@field Firstname string Player's first name
---@field Lastname string Player's last name
---@field DateOfBirth string Player's date of birth (DD-MM-YYYY format)
---@field Gender string Player's gender ('m' for male, 'f' for female)
---@field Name string Player's full name (Firstname + Lastname)
---@field Identifier string Player's unique identifier (license, steam, etc.)

---@class JobData
---@field Name string Job name identifier (e.g., 'police', 'ambulance')
---@field Label string Job display name (e.g., 'Police', 'EMS')
---@field Duty boolean Whether player is currently on duty
---@field Boss boolean Whether player has boss privileges
---@field Grade GradeData Player's job grade information

---@class GradeData
---@field Name string Grade name (e.g., 'Sergeant', 'Officer')
---@field Level number Grade level/number

---@class CartItem
---@field itemCode string Item identifier code (e.g., 'rod_1', 'bait', 'tackle_box')
---@field count number Quantity of items to purchase
---@field price number Price per item unit

---@class MoneyType
---@alias MoneyType '"cash"'|'"bank"'

---@class BuyItemResult
---@field success boolean Whether the purchase was successful
---@field total number Total amount spent
---@field items table Array of purchased items
---@field message string Result message

---@class SellItemResult
---@field success boolean Whether the sale was successful
---@field total number Total amount earned
---@field items table Array of sold items
---@field message string Result message

---@param source number Player server ID
---@param cart CartItem[] Array of items in shopping cart
---@param moneyType MoneyType Type of money to use for payment ('cash'|'bank'|'crypto')
---@param result BuyItemResult Purchase result information
RegisterNetEvent('dusa_fishing:handler:ItemPurchased', function(source, cart, moneyType, result)
    local PlayerData = Framework.GetPlayer(source)
    
    -- Example Log purchase for admin tracking
    --[[
        if result.success then
            print(string.format('[FISHING SHOP] Player %s (%s) purchased items for $%d using %s', 
                PlayerData.Name, 
                PlayerData.Identifier, 
                result.total, 
                moneyType
            ))
            
            -- Log individual items purchased
            for _, item in pairs(result.items) do
                print(string.format('[FISHING SHOP] - %s x%d ($%d each)', 
                    item.itemCode, 
                    item.count, 
                    item.price
                ))
            end
        else
            print(string.format('[FISHING SHOP] Player %s (%s) failed to purchase items: %s', 
                PlayerData.Name, 
                PlayerData.Identifier, 
                result.message
            ))
        end
    ]]
end)

---@param source number Player server ID
---@param cart CartItem[] Array of items being sold
---@param result SellItemResult Sale result information
RegisterNetEvent('dusa_fishing:handler:ItemSold', function(source, cart, result)
    local PlayerData = Framework.GetPlayer(source)
    
    -- Example Log sale for admin tracking
    --[[
        if result.success then
            print(string.format('[FISHING SELL] Player %s (%s) sold items for $%d', 
                PlayerData.Name, 
                PlayerData.Identifier, 
                result.total
            ))
            
            -- Log individual items sold
            for _, item in pairs(result.items) do
                print(string.format('[FISHING SELL] - %s x%d ($%d each)', 
                    item.itemCode, 
                    item.count, 
                    item.price
                ))
            end
        else
            print(string.format('[FISHING SELL] Player %s (%s) failed to sell items: %s', 
                PlayerData.Name, 
                PlayerData.Identifier, 
                result.message
            ))
        end
    ]]
end)
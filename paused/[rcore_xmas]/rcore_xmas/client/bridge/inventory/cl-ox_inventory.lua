if isBridgeLoaded('Inventory', Inventory.OX) then
    Inventory.openInventory = function(type, name)
        return exports[Inventory.OX]:openInventory(type, name)
    end
end

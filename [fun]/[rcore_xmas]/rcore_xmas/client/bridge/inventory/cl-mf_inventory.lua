if isBridgeLoaded('Inventory', Inventory.MF) then
    Inventory.openInventory = function(type, name)
        return exports[Inventory.MF]:openOtherInventory(name)
    end
end

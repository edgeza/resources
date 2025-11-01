if Config.Inventory ~= 'qs' then
    return
end

function WeaponWheel(toggle)
    exports['qs-inventory']:setInventoryDisabled(toggle)
end

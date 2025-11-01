local ImagesPath = nil

if GetResourceState('ox_inventory') == 'started' then
    ImagesPath = 'ox_inventory/web/images/'
elseif GetResourceState('qs-inventory') == 'started' then
    ImagesPath = 'qs-inventory/html/images/'
elseif GetResourceState('qb-inventory') == 'started' then
    ImagesPath = 'qb-inventory/html/images/'
elseif GetResourceState('ps-inventory') == 'started' then
    ImagesPath = 'ps-inventory/html/images/'
elseif GetResourceState('codem-inventory') == 'started' then
    ImagesPath = 'codem-inventory/html/images/'
elseif GetResourceState('tgiann-inventory') == 'started' then
    ImagesPath = 'tgiann-inventory/images/'
elseif GetResourceState('ak47_inventory') == 'started' then
    ImagesPath = 'ak47_inventory/web/build/images/'
elseif GetResourceState('ak47_qb_inventory') == 'started' then
    ImagesPath = 'ak47_qb_inventory/web/build/images/'
elseif GetResourceState('origen_inventory') == 'started' then
    ImagesPath = 'origen_inventory/html/images/'
else
    print('[WARNING] Inventory not detected. Using default image path.')
    ImagesPath = 'ox_inventory/web/images/'
end

return ImagesPath
local Alert = require 'modules.dispatch.alerts'
local function exportHandler(exportName, func)
    AddEventHandler(('__cfx_export_ps-dispatch_%s'):format(exportName), function(setCB)
        setCB(func)
    end)
end


exportHandler('CustomDispatch', Alert.Custom)

exportHandler('CustomAlert', Alert.Custom)

exportHandler('VehicleTheft', Alert.VehicleTheft)

exportHandler('Shooting', Alert.Shooting)

exportHandler('Hunting', Alert.Hunting)

exportHandler('VehicleShooting', Alert.VehicleShooting)

exportHandler('SpeedingVehicle', Alert.SpeedingVehicle)

exportHandler('Fight', Alert.Fight)

exportHandler('PrisonBreak', Alert.PrisonBreak)

exportHandler('StoreRobbery', Alert.StoreRobbery)

exportHandler('FleecaBankRobbery', Alert.FleecaBankRobbery)

exportHandler('PaletoBankRobbery', Alert.PaletoBankRobbery)

exportHandler('PacificBankRobbery', Alert.PacificBankRobbery)

exportHandler('VangelicoRobbery', Alert.VangelicoRobbery)

exportHandler('HouseRobbery', Alert.HouseRobbery)

exportHandler('YachtHeist', Alert.YachtHeist)

exportHandler('DrugSale', Alert.DrugSale)

exportHandler('SuspiciousActivity', Alert.SuspiciousActivity)

exportHandler('CarJacking', Alert.CarJacking)

exportHandler('InjuriedPerson', Alert.InjuriedPerson)

exportHandler('DeceasedPerson', Alert.DeceasedPerson)

exportHandler('OfficerDown', Alert.OfficerDown)

exportHandler('OfficerBackup', Alert.OfficerBackup)

exportHandler('OfficerInDistress', Alert.OfficerInDistress)

exportHandler('EmsDown', Alert.EmsDown)

exportHandler('Explosion', Alert.Explosion)

exportHandler('ArtGalleryRobbery', Alert.ArtGalleryRobbery)

exportHandler('HumaneRobbery', Alert.HumaneRobbery)

exportHandler('TrainRobbery', Alert.TrainRobbery)

exportHandler('VanRobbery', Alert.VanRobbery)

exportHandler('UndergroundRobbery', Alert.UndergroundRobbery)

exportHandler('DrugBoatRobbery', Alert.DrugBoatRobbery)

exportHandler('UnionRobbery', Alert.UnionRobbery)

exportHandler('CarBoosting', Alert.CarBoosting)

exportHandler('SignRobbery', Alert.SignRobbery)
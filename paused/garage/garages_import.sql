-- Insert garages from garages.lua
INSERT IGNORE INTO `dusa_garages` (`name`, `type`, `owner_identifier`, `locations`, `settings`) VALUES

-- Car Garages (Public)
('Motel Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 250.68, 'z', 44.51, 'y', -332.3, 'x', 265.96),
    'parking', JSON_OBJECT('z', 44.51, 'y', -332.3, 'x', 265.96),
    'interaction', JSON_OBJECT('z', 44.92, 'y', -334.15, 'x', 274.29)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 250.68, 'x', 265.96, 'z', 44.51, 'w', 250.68, 'y', -332.3)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Casino Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 146.85, 'z', 78.35, 'y', -4.75, 'x', 895.39),
    'parking', JSON_OBJECT('z', 78.35, 'y', -4.75, 'x', 895.39),
    'interaction', JSON_OBJECT('z', 78.76, 'y', -4.71, 'x', 883.96)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 146.85, 'x', 895.39, 'z', 78.35, 'w', 146.85, 'y', -4.75)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('San Andreas Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 92.61, 'z', 33.56, 'y', -767.45, 'x', -341.57),
    'parking', JSON_OBJECT('z', 33.56, 'y', -767.45, 'x', -341.57),
    'interaction', JSON_OBJECT('z', 33.96, 'y', -780.33, 'x', -330.01)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 92.61, 'x', -341.57, 'z', 33.56, 'w', 92.61, 'y', -767.45)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Spanish Ave Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 108.22, 'z', 19.26, 'y', -745.42, 'x', -1145.2),
    'parking', JSON_OBJECT('z', 19.26, 'y', -745.42, 'x', -1145.2),
    'interaction', JSON_OBJECT('z', 19.63, 'y', -741.41, 'x', -1160.86)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 108.22, 'x', -1145.2, 'z', 19.26, 'w', 108.22, 'y', -745.42)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Caears 24 Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 339.7, 'z', 68.82, 'y', 17.54, 'x', 60.8),
    'parking', JSON_OBJECT('z', 68.82, 'y', 17.54, 'x', 60.8),
    'interaction', JSON_OBJECT('z', 68.96, 'y', 12.6, 'x', 69.84)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 339.7, 'x', 60.8, 'z', 68.82, 'w', 339.7, 'y', 17.54)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Caears 24 Parking 2', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 180.52, 'z', 30.14, 'y', -787.71, 'x', -472.39),
    'parking', JSON_OBJECT('z', 30.14, 'y', -787.71, 'x', -472.39),
    'interaction', JSON_OBJECT('z', 30.56, 'y', -786.78, 'x', -453.7)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 180.52, 'x', -472.39, 'z', 30.14, 'w', 180.52, 'y', -787.71)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Laguna Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 164.04, 'z', 102.86, 'y', 294.66, 'x', 375.09),
    'parking', JSON_OBJECT('z', 102.86, 'y', 294.66, 'x', 375.09),
    'interaction', JSON_OBJECT('z', 103.49, 'y', 297.83, 'x', 364.37)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 164.04, 'x', 375.09, 'z', 102.86, 'w', 164.04, 'y', 294.66)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Airport Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 315.34, 'z', 8.47, 'y', -2040.18, 'x', -779.77),
    'parking', JSON_OBJECT('z', 8.47, 'y', -2040.18, 'x', -779.77),
    'interaction', JSON_OBJECT('z', 8.88, 'y', -2033.04, 'x', -773.12)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 315.34, 'x', -779.77, 'z', 8.47, 'w', 315.34, 'y', -2040.18)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Beach Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 124.06, 'z', 3.97, 'y', -1487.95, 'x', -1188.14),
    'parking', JSON_OBJECT('z', 3.97, 'y', -1487.95, 'x', -1188.14),
    'interaction', JSON_OBJECT('z', 4.38, 'y', -1500.64, 'x', -1185.32)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 124.06, 'x', -1188.14, 'z', 3.97, 'w', 124.06, 'y', -1487.95)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('The Motor Hotel Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 1.41, 'z', 37.58, 'y', 2647.84, 'x', 1127.7),
    'parking', JSON_OBJECT('z', 37.58, 'y', 2647.84, 'x', 1127.7),
    'interaction', JSON_OBJECT('z', 37.9, 'y', 2663.54, 'x', 1137.77)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 1.41, 'x', 1127.7, 'z', 37.58, 'w', 1.41, 'y', 2647.84)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Liqour Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 90.75, 'z', 32.36, 'y', 3649.41, 'x', 898.38),
    'parking', JSON_OBJECT('z', 32.36, 'y', 3649.41, 'x', 898.38),
    'interaction', JSON_OBJECT('z', 32.87, 'y', 3649.67, 'x', 883.99)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 90.75, 'x', 898.38, 'z', 32.36, 'w', 90.75, 'y', 3649.41)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Shore Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 20.54, 'z', 34.15, 'y', 3716.78, 'x', 1725.4),
    'parking', JSON_OBJECT('z', 34.15, 'y', 3716.78, 'x', 1725.4),
    'interaction', JSON_OBJECT('z', 34.05, 'y', 3718.88, 'x', 1737.03)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 20.54, 'x', 1725.4, 'z', 34.15, 'w', 20.54, 'y', 3716.78)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Bell Farms Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 211.38, 'z', 30.81, 'y', 6403.41, 'x', 62.15),
    'parking', JSON_OBJECT('z', 30.81, 'y', 6403.41, 'x', 62.15),
    'interaction', JSON_OBJECT('z', 31.23, 'y', 6397.3, 'x', 76.88)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 211.38, 'x', 62.15, 'z', 30.81, 'w', 211.38, 'y', 6403.41)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Dumbo Private Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 272.05, 'z', 5.43, 'y', -3236.1, 'x', 168.34),
    'parking', JSON_OBJECT('z', 5.43, 'y', -3236.1, 'x', 168.34),
    'interaction', JSON_OBJECT('z', 5.89, 'y', -3227.2, 'x', 165.75)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 272.05, 'x', 168.34, 'z', 5.43, 'w', 272.05, 'y', -3236.1)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Pillbox Garage Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 248.19, 'z', 30.26, 'y', -804.19, 'x', 222.02),
    'parking', JSON_OBJECT('z', 30.26, 'y', -804.19, 'x', 222.02),
    'interaction', JSON_OBJECT('z', 30.86, 'y', -796.05, 'x', 213.2)
), JSON_OBJECT(
    'maxVehicles', 5,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 248.19, 'x', 222.02, 'z', 30.26, 'w', 248.19, 'y', -804.19),
        JSON_OBJECT('id', 2, 'heading', 248.53, 'x', 223.93, 'z', 30.25, 'w', 248.53, 'y', -799.11),
        JSON_OBJECT('id', 3, 'heading', 248.29, 'x', 226.46, 'z', 30.24, 'w', 248.29, 'y', -794.33),
        JSON_OBJECT('id', 4, 'heading', 69.17, 'x', 232.33, 'z', 30.02, 'w', 69.17, 'y', -807.97),
        JSON_OBJECT('id', 5, 'heading', 67.2, 'x', 234.42, 'z', 30.04, 'w', 67.2, 'y', -802.76)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

('Grapeseed Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 17.05, 'z', 33.81, 'y', 4681.96, 'x', 2550.17),
    'parking', JSON_OBJECT('z', 33.81, 'y', 4681.96, 'x', 2550.17),
    'interaction', JSON_OBJECT('z', 33.95, 'y', 4671.8, 'x', 2552.68)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 17.05, 'x', 2550.17, 'z', 33.81, 'w', 17.05, 'y', 4681.96)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

-- Depot (imported as public)
('Depot Lot', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 321.91, 'z', 28.88, 'y', -1643.93, 'x', 396.55),
    'parking', JSON_OBJECT('z', 28.88, 'y', -1643.93, 'x', 396.55),
    'interaction', JSON_OBJECT('z', 29.29, 'y', -1632.57, 'x', 401.76)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 321.91, 'x', 396.55, 'z', 28.88, 'w', 321.91, 'y', -1643.93)
    ),
    'allowPublic', true,
    'vehicleType', 'car'
)),

-- Aircraft Garages
('Airport Hangar', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 61.09, 'z', 13.95, 'y', -2985.01, 'x', -998.37),
    'parking', JSON_OBJECT('z', 13.95, 'y', -2985.01, 'x', -998.37),
    'interaction', JSON_OBJECT('z', 13.95, 'y', -2995.48, 'x', -979.06)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 61.09, 'x', -998.37, 'z', 13.95, 'w', 61.09, 'y', -2985.01)
    ),
    'allowPublic', true,
    'vehicleType', 'aircraft'
)),

('Higgins Helitours', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 319.84, 'z', 5.39, 'y', -1468.72, 'x', -745.22),
    'parking', JSON_OBJECT('z', 5.39, 'y', -1468.72, 'x', -745.22),
    'interaction', JSON_OBJECT('z', 5.0, 'y', -1472.79, 'x', -722.15)
), JSON_OBJECT(
    'maxVehicles', 2,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 319.84, 'x', -745.22, 'z', 5.39, 'w', 319.84, 'y', -1468.72),
        JSON_OBJECT('id', 2, 'heading', 135.78, 'x', -724.36, 'z', 5.39, 'w', 135.78, 'y', -1443.61)
    ),
    'allowPublic', true,
    'vehicleType', 'aircraft'
)),

('Sandy Shores Hangar', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 102.64, 'z', 41.24, 'y', 3266.83, 'x', 1742.83),
    'parking', JSON_OBJECT('z', 41.24, 'y', 3266.83, 'x', 1742.83),
    'interaction', JSON_OBJECT('z', 41.14, 'y', 3288.13, 'x', 1737.89)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 102.64, 'x', 1742.83, 'z', 41.24, 'w', 102.64, 'y', 3266.83)
    ),
    'allowPublic', true,
    'vehicleType', 'aircraft'
)),

('Fort Zancudo Hangar', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 57.24, 'z', 32.81, 'y', 2975.44, 'x', -1828.25),
    'parking', JSON_OBJECT('z', 32.81, 'y', 2975.44, 'x', -1828.25),
    'interaction', JSON_OBJECT('z', 32.81, 'y', 2975.44, 'x', -1828.25)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 57.24, 'x', -1828.25, 'z', 32.81, 'w', 57.24, 'y', 2975.44)
    ),
    'allowPublic', true,
    'vehicleType', 'aircraft'
)),

('Air Depot', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 329.25, 'z', 14.33, 'y', -3377.53, 'x', -1270.01),
    'parking', JSON_OBJECT('z', 14.33, 'y', -3377.53, 'x', -1270.01),
    'interaction', JSON_OBJECT('z', 14.33, 'y', -3377.53, 'x', -1270.01)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 329.25, 'x', -1270.01, 'z', 14.33, 'w', 329.25, 'y', -3377.53)
    ),
    'allowPublic', true,
    'vehicleType', 'aircraft'
)),

-- Boat Garages
('LSYMC Boathouse', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 111.49, 'z', -0.09, 'y', -1502.6, 'x', -796.64),
    'parking', JSON_OBJECT('z', -0.09, 'y', -1502.6, 'x', -796.64),
    'interaction', JSON_OBJECT('z', -0.09, 'y', -1497.84, 'x', -785.95)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 111.49, 'x', -796.64, 'z', -0.09, 'w', 111.49, 'y', -1502.6)
    ),
    'allowPublic', true,
    'vehicleType', 'boat'
)),

('Paleto Boathouse', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 45.5, 'z', 1.01, 'y', 6637.96, 'x', -289.2),
    'parking', JSON_OBJECT('z', 1.01, 'y', 6637.96, 'x', -289.2),
    'interaction', JSON_OBJECT('z', 7.55, 'y', 6638.13, 'x', -278.21)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 45.5, 'x', -289.2, 'z', 1.01, 'w', 45.5, 'y', 6637.96)
    ),
    'allowPublic', true,
    'vehicleType', 'boat'
)),

('Millars Boathouse', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 253.5, 'z', 30.12, 'y', 4209.61, 'x', 1297.82),
    'parking', JSON_OBJECT('z', 30.12, 'y', 4209.61, 'x', 1297.82),
    'interaction', JSON_OBJECT('z', 33.25, 'y', 4212.42, 'x', 1298.56)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 253.5, 'x', 1297.82, 'z', 30.12, 'w', 253.5, 'y', 4209.61)
    ),
    'allowPublic', true,
    'vehicleType', 'boat'
)),

('LSYMC Depot', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 142.5, 'z', 1.19, 'y', -1355.49, 'x', -729.77),
    'parking', JSON_OBJECT('z', 1.19, 'y', -1355.49, 'x', -729.77),
    'interaction', JSON_OBJECT('z', 5.5, 'y', -1407.58, 'x', -742.95)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 142.5, 'x', -729.77, 'z', 1.19, 'w', 142.5, 'y', -1355.49)
    ),
    'allowPublic', true,
    'vehicleType', 'boat'
)),

-- Rig Garages
('Big Rig Depot', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 4.05, 'z', 48.21, 'y', 3117.79, 'x', 2324.57),
    'parking', JSON_OBJECT('z', 48.21, 'y', 3117.79, 'x', 2324.57),
    'interaction', JSON_OBJECT('z', 48.2, 'y', 3118.62, 'x', 2334.42)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 4.05, 'x', 2324.57, 'z', 48.21, 'w', 4.05, 'y', 3117.79)
    ),
    'allowPublic', true,
    'vehicleType', 'rig'
)),

('Dumbo Big Rig Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 271.27, 'z', 5.94, 'y', -3203.89, 'x', 167.0),
    'parking', JSON_OBJECT('z', 5.94, 'y', -3203.89, 'x', 167.0),
    'interaction', JSON_OBJECT('z', 5.97, 'y', -3188.73, 'x', 161.23)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 271.27, 'x', 167.0, 'z', 5.94, 'w', 271.27, 'y', -3203.89)
    ),
    'allowPublic', true,
    'vehicleType', 'rig'
)),

('Pop\'s Big Rig Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 223.67, 'z', 31.93, 'y', 6605.84, 'x', 127.69),
    'parking', JSON_OBJECT('z', 31.93, 'y', 6605.84, 'x', 127.69),
    'interaction', JSON_OBJECT('z', 31.67, 'y', 6632.99, 'x', 137.67)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 223.67, 'x', 127.69, 'z', 31.93, 'w', 223.67, 'y', 6605.84)
    ),
    'allowPublic', true,
    'vehicleType', 'rig'
)),

('Ron\'s Big Rig Parking', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 88.7, 'z', 33.13, 'y', 2326.45, 'x', -2521.61),
    'parking', JSON_OBJECT('z', 33.13, 'y', 2326.45, 'x', -2521.61),
    'interaction', JSON_OBJECT('z', 33.06, 'y', 2342.67, 'x', -2529.37)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 88.7, 'x', -2521.61, 'z', 33.13, 'w', 88.7, 'y', 2326.45)
    ),
    'allowPublic', true,
    'vehicleType', 'rig'
)),

('Ron\'s Big Rig Parking 2', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 177.86, 'z', 108.49, 'y', 476.68, 'x', 2561.67),
    'parking', JSON_OBJECT('z', 108.49, 'y', 476.68, 'x', 2561.67),
    'interaction', JSON_OBJECT('z', 108.49, 'y', 476.68, 'x', 2561.67)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 177.86, 'x', 2561.67, 'z', 108.49, 'w', 177.86, 'y', 476.68)
    ),
    'allowPublic', true,
    'vehicleType', 'rig'
)),

('Ron\'s Big Rig Parking 3', 'public', NULL, JSON_OBJECT(
    'interactionRadius', 15.0,
    'spawn', JSON_OBJECT('w', 326.18, 'z', 6.08, 'y', -2527.81, 'x', -39.39),
    'parking', JSON_OBJECT('z', 6.08, 'y', -2527.81, 'x', -39.39),
    'interaction', JSON_OBJECT('z', 6.01, 'y', -2550.63, 'x', -41.24)
), JSON_OBJECT(
    'maxVehicles', 1,
    'spawnPoints', JSON_ARRAY(
        JSON_OBJECT('id', 1, 'heading', 326.18, 'x', -39.39, 'z', 6.08, 'w', 326.18, 'y', -2527.81)
    ),
    'allowPublic', true,
    'vehicleType', 'rig'
));

-- Summary:
-- Total Garages Imported: 37
-- - Public Car Garages: 16
-- - Public Aircraft Garages: 5
-- - Public Boat Garages: 4
-- - Public Rig Garages: 7
-- - Gang Garages (as property): 4
-- - Job Garages: 1
-- - Depot Garages (as public): 3

Location = {}

if Config.location == "gabz" then
Location.TargetCoords = {
 Fridge = {
 { name = ""..Config.Jobname.." Fridge", coords =vector3(-1068.45, -1445.0, -1.2),heading=35.0, minZ = -1.7, maxZ = -0.7, w = 0.7, h = 0.2,height=1 }
 },
 Management = {
     { name = ""..Config.Jobname.." Management", coords =vec3(-1070.9, -1443.15, -1.45),heading=35.0, minZ = -1.75, maxZ = -1.25, w = 0.3, h = 0.3,height=0.5 }
 },
 Process = {
     { name = ""..Config.Jobname.." Process", coords =vec3(-1074.8, -1446.65, -1.45),heading=30.0, minZ = -1.75, maxZ = -1.25, w = 0.35, h = 0.5,height=0.5 }
 },
 Stash = {
     { name = ""..Config.Jobname.." Stash", coords =vec3(-1074.2, -1440.45, -1.35),heading=35.0, minZ = -1.75, maxZ = -1.25, w = 0.2, h = 0.5,height=0.7 }
 },
 BossMenu = {
     { name = ""..Config.Jobname.." BossMenu", coords =vec3(-1054.45, -1441.55, -1.6),heading=33.25, minZ = -1.85, maxZ = -1.2, w = 0.3, h = 0.4,height=0.6 }
 },
 Clothing = {
     { name = ""..Config.Jobname.." Clothing", coords =vector3(-1059.85, -1434.15, -1.3),heading=0.0, minZ = -1.9, maxZ = -0.9, w = 0.8, h = 0.2,height=1 }
 },
 Duty = {
     { name = ""..Config.Jobname.." Duty", coords =vector3(-1060.95, -1444.05, -1.05),heading=0.0, minZ = -1.45, maxZ = -0.45, w = 0.4, h = 0.1,height=1 }
 },
 HandWash = {
     { name = ""..Config.Jobname.." HandWash", coords =vector3(-1071.4, -1440.05, -1.75),heading=35.0, minZ = -2.10, maxZ = -1.10, w = 0.4, h = 0.6,height=1.0 }
 },
 IceMachine = {
     { name = ""..Config.Jobname.." IceMachine", coords =vector3(-1068.25, -1440.7, -1.6),heading=35.0, minZ = -2.25, maxZ = -0.75, w = 0.7, h = 0.65,height=1.5 }
 },
}
Location.Delivery = {
    Coords = vec3(-1026.22, -1466.67, 5.58),
    Ped = vec3(-1026.22, -1466.67, 5.58),
    Pedheading=36.07,
    VehicleSpawn = vec3(-1020.53, -1464.94, 4.44),
    VehicleHeading = 36.07,
}
Location.BuyMenu = { --Shop buy menu
    vec3(-1034.99, -1482.75, 4.58),
}
Location.Counter = {
}
Location.Billing = {
 { name = "Koi Billing Counter 1", coords = vec3(-1034.15, -1483.85, 4.35), heading = 35.0, minZ = 4.00, maxZ = 4.50, w = 0.4, h = 0.4,height=0.5 },
}
Location.TrashCan = {
    { name = "Koi Trash Can 1", coords = vec3(-1066.65, -1441.15, -2.15), heading = 45.0, minZ = -3.15, maxZ = -1.90, w = 0.3, h = 0.55,height=1.75 },
}
Location.Chairs = {
    { coords = vector4(-1076.78, -1461.88, -1.32, 350.0), stand = vec3(-1076.08, -1462.13, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1077.59, -1461.65, -1.32, 350.0), stand = vector3(-1076.08, -1462.13, -1.42) , minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1076.43, -1460.37, -1.32, 160.0), stand = vector3(-1075.97, -1461.27, -1.42) , minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1077.33, -1460.17, -1.32, 160.0), stand = vector3(-1075.97, -1461.27, -1.42) , minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1076.24, -1459.62, -1.32, 350.0), stand = vec3(-1075.53, -1459.89, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1077.12, -1459.47, -1.32, 350.0), stand = vec3(-1075.53, -1459.89, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1075.99, -1458.18, -1.32, 169.0), stand = vec3(-1075.34, -1458.53, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1076.88, -1458.01, -1.32, 169.0), stand = vec3(-1075.34, -1458.53, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1075.71, -1457.35, -1.40, 348.0), stand = vec3(-1075.0, -1457.62, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1076.6, -1457.15, -1.40, 350.0), stand = vec3(-1075.0, -1457.62, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1075.46, -1456.06, -1.40, 169.0), stand = vec3(-1074.79, -1456.16, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1076.33, -1455.84, -1.40, 169.0), stand = vec3(-1074.79, -1456.16, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

    { coords = vector4(-1053.76, -1446.82, -1.42, 238.0), stand = vec3(-1054.31, -1447.44, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1053.33, -1446.12, -1.42, 240.0), stand = vec3(-1054.31, -1447.44, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1052.65, -1447.53, -1.42, 61.0), stand = vec3(-1052.99, -1448.21, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1052.18, -1446.8, -1.42, 60.0), stand = vec3(-1052.99, -1448.21, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1051.85, -1448.0, -1.42, 239.0), stand = vec3(-1052.36, -1448.63, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1051.35, -1447.28, -1.42, 240.0), stand = vec3(-1052.36, -1448.63, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1050.68, -1448.7, -1.42, 61.0), stand = vec3(-1051.23, -1449.34, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1050.26, -1447.96, -1.42, 60.0), stand = vec3(-1051.23, -1449.34, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1049.91, -1449.21, -1.42, 239.0), stand = vec3(-1050.28, -1449.84, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1049.42, -1448.44, -1.42, 240.0), stand = vec3(-1050.28, -1449.84, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1048.74, -1449.86, -1.42, 61.0), stand = vec3(-1049.1, -1450.55, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1048.28, -1449.12, -1.42, 60.0), stand = vec3(-1049.1, -1450.55, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1046.66, -1451.99, -1.42, 210.0), stand = vec3(-1047.45, -1452.18, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1045.87, -1451.58, -1.42, 209.0), stand = vec3(-1047.45, -1452.18, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1046.02, -1453.18, -1.42, 30.0), stand = vec3(-1046.75, -1453.59, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1045.21, -1452.71, -1.42, 30.0), stand = vec3(-1046.75, -1453.59, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1045.59, -1454.01, -1.42, 210.0), stand = vec3(-1046.2, -1454.25, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1044.78, -1453.61, -1.42, 209.0), stand = vec3(-1046.2, -1454.25, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1044.88, -1455.14, -1.42, 30.0), stand = vec3(-1045.58, -1455.52, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1044.17, -1454.72, -1.42, 30.0), stand = vec3(-1045.58, -1455.52, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1044.46, -1455.98, -1.42, 210.0), stand = vec3(-1045.39, -1456.44, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1043.69, -1455.55, -1.42, 209.0), stand = vec3(-1045.39, -1456.44, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1043.86, -1457.1, -1.42, 30.0), stand = vec3(-1044.53, -1457.41, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1043.09, -1456.69, -1.42, 30.0), stand = vec3(-1044.53, -1457.41, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1043.05, -1460.0, -1.42, 168.0), stand = vec3(-1043.82, -1459.94, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1042.21, -1460.04, -1.42, 168.0), stand = vec3(-1043.82, -1459.94, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1043.11, -1461.35, -1.42, 10.0), stand = vec3(-1043.85, -1461.36, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1042.23, -1461.37, -1.42, 15.0), stand = vec3(-1043.85, -1461.36, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vec4(-1043.04, -1462.38, -1.42, 168.0), stand =  vec3(-1043.9, -1462.12, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vec4(-1042.24, -1462.39, -1.42, 168.0), stand =  vec3(-1043.9, -1462.12, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vec4(-1043.11, -1463.56, -1.42, 359.85), stand = vec3(-1043.88, -1463.47, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vec4(-1042.34, -1463.57, -1.42, 2.33), stand =   vec3(-1043.88, -1463.47, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1043.15, -1464.57, -1.42, 168.0), stand = vec3(-1043.8, -1462.34, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1042.29, -1464.58, -1.42, 168.0), stand = vec3(-1043.8, -1462.34, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1043.18, -1465.92, -1.42, 10.0), stand = vec3(-1043.89, -1463.61, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1042.32, -1465.91, -1.42, 15.0), stand = vec3(-1043.89, -1463.61, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1043.98, -1468.7, -1.42, 144.62), stand = vec3(-1044.61, -1468.22, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1043.23, -1469.2, -1.42, 144.62), stand = vec3(-1044.61, -1468.22, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1044.69, -1469.91, -1.42, 331.77), stand = vec3(-1045.41, -1469.48, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1043.94, -1470.32, -1.42, 331.77), stand = vec3(-1045.41, -1469.48, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1045.23, -1470.67, -1.42, 144.62), stand = vec3(-1045.72, -1470.17, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1044.46, -1471.17, -1.42, 144.62), stand = vec3(-1045.72, -1470.17, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1045.88, -1471.76, -1.42, 331.77), stand = vec3(-1046.53, -1471.43, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1045.14, -1472.23, -1.42, 331.77), stand = vec3(-1046.53, -1471.43, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1046.36, -1472.71, -1.42, 144.62), stand = vec3(-1046.83, -1472.06, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1045.66, -1473.13, -1.42, 144.62), stand = vec3(-1046.83, -1472.06, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1047.0, -1473.67, -1.42, 331.77), stand = vec3(-1047.76, -1473.45, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1046.33, -1474.19, -1.42, 331.77), stand = vec3(-1047.76, -1473.45, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1053.78, -1478.45, -1.42, 100.0), stand = vec3(-1053.95, -1477.85, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1053.6, -1479.35, -1.42, 100.0), stand = vec3(-1053.95, -1477.85, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1055.03, -1478.72, -1.42, 283.0), stand = vec3(-1055.23, -1478.03, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1054.85, -1479.53, -1.42, 283.0), stand = vec3(-1055.23, -1478.03, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1056.03, -1478.9, -1.42, 100.0), stand = vec3(-1056.08, -1478.06, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1055.82, -1479.8, -1.42, 100.0), stand = vec3(-1056.08, -1478.06, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1057.3, -1479.23, -1.42, 280.0), stand = vec3(-1057.52, -1478.52, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1057.12, -1480.04, -1.42, 280.0), stand = vec3(-1057.52, -1478.52, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1058.2, -1479.36, -1.42, 100.0), stand = vec3(-1058.45, -1478.6, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1058.02, -1480.25, -1.42, 100.0), stand = vec3(-1058.45, -1478.6, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1059.52, -1479.62, -1.42, 280.0), stand = vec3(-1059.85, -1478.9, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1059.35, -1480.41, -1.42, 280.0), stand = vec3(-1059.85, -1478.9, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1063.07, -1482.53, -1.22, 54), stand = vec3(-1063.33, -1481.77, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1065.54, -1483.60, -1.22, 345), stand = vec3(-1064.74, -1483.16, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1067.25, -1482.72, -1.22, 307), stand = vec3(-1066.86, -1481.96, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1067.41, -1480.84, -1.22, 255), stand = vec3(-1066.81, -1480.34, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1063.07, -1482.53, -1.22, 54), stand = vec3(-1063.33, -1481.77, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1065.54, -1483.60, -1.22, 345), stand = vec3(-1064.74, -1483.16, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1067.25, -1482.72, -1.22, 307), stand = vec3(-1066.86, -1481.96, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1067.41, -1480.84, -1.22, 255), stand = vec3(-1066.81, -1480.34, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1066.99, -1477.02, -1.42, 152.0), stand = vec3(-1066.49, -1477.42, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1067.71, -1476.65, -1.42, 152.0), stand = vec3(-1067.13, -1476.23, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1068.46, -1476.14, -1.42, 152.0), stand = vec3(-1068.02, -1475.66, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1069.17, -1475.68, -1.42, 152.0), stand = vec3(-1069.52, -1475.12, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1067.96, -1478.54, -1.42, 332.0), stand = vec3(-1067.21, -1478.88, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1068.68, -1478.21, -1.42, 332.0), stand = vec3(-1067.21, -1478.88, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1069.39, -1477.74, -1.42, 332.0), stand = vec3(-1070.72, -1476.73, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1070.12, -1477.27, -1.42, 332.0), stand = vec3(-1070.72, -1476.73, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1072.37, -1477.90, -1.22, 39), stand = vec3(-1072.65, -1477.49, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1073.81, -1478.51, -1.22, 358), stand = vec3(-1073.36, -1477.92, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1075.57, -1477.77, -1.22, 315), stand = vec3(-1074.78, -1477.74, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1076.07, -1476.50, -1.22, 283), stand = vec3(-1075.57, -1475.46, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1073.19, -1471.55, -1.42, 118.0), stand = vec3(-1072.84, -1472.13, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1073.59, -1470.76, -1.42, 118.0), stand = vec3(-1072.86, -1470.76, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1073.98, -1469.93, -1.42, 118.0), stand = vec3(-1073.42, -1469.75, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1074.37, -1469.22, -1.42, 118.0), stand = vec3(-1074.61, -1468.61, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1076.07, -1470.18, -1.42, 297.0), stand = vec3(-1076.28, -1469.42, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1075.7, -1471.0, -1.42, 299.0), stand = vec3(-1076.28, -1469.42, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1075.25, -1471.67, -1.42, 300.0), stand = vec3(-1074.37, -1473.05, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1074.88, -1472.39, -1.42, 300.0), stand = vec3(-1074.37, -1473.05, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1078.42, -1469.60, -1.22, 12), stand = vec3(-1077.87, -1469.05, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1080.29, -1469.26, -1.22, 317), stand = vec3(-1079.32, -1469.21, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1081.15, -1466.96, -1.22, 268), stand = vec3(-1080.35, -1466.46, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1079.69, -1465.28, -1.22, 196), stand = vec3(-1078.99, -1465.53, -1.22), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1062.0, -1471.91, -1.42, 61), stand = vec3(-1062.31, -1472.5, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1061.78, -1471.03, -1.42, 60.0), stand = vec3(-1061.09, -1471.26, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1063.85, -1471.21, -1.42, 260.0), stand = vec3(-1064.09, -1471.81, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1063.47, -1470.42, -1.42, 260.0), stand = vec3(-1064.08, -1470.44, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1067.62, -1468.04, -1.42, 40.0), stand = vec3(-1068.19, -1468.38, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1066.9, -1467.61, -1.42, 40.0), stand = vec3(-1066.86, -1468.32, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1068.45, -1466.44, -1.42, 217.0), stand = vec3(-1069.01, -1466.71, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1067.75, -1466.01, -1.42, 217.0), stand = vec3(-1067.88, -1465.41, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1068.41, -1461.5, -1.42, -5.0), stand = vec3(-1069.73, -1461.26, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1069.21, -1461.47, -1.42, 348.0), stand = vec3(-1068.48, -1462.33, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1068.79, -1459.66, -1.42, 169.0), stand = vec3(-1068.69, -1458.98, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1068.01, -1459.87, -1.42, 165.0), stand = vec3(-1068.1, -1459.08, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1066.01, -1455.53, -1.42, 302.0), stand = vec3(-1066.38, -1455.01, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1065.46, -1456.11, -1.42, 307.0), stand = vec3(-1066.19, -1456.29, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1064.49, -1454.49, -1.42, 125.0), stand = vec3(-1064.68, -1453.91, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1064.0, -1455.12, -1.42, 127.0), stand = vec3(-1063.35, -1454.88, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1059.65, -1454.1, -1.42, 255.0), stand = vec3(-1059.9, -1452.65, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1059.7, -1453.28, -1.42, 255.0), stand = vec3(-1060.41, -1453.91, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1057.85, -1453.49, -1.42, 75.0), stand = vec3(-1057.61, -1452.96, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1057.94, -1454.26, -1.42, 75.0), stand = vec3(-1057.32, -1454.23, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1053.31, -1455.9, -1.42, 224.0), stand = vec3(-1053.01, -1455.23, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1053.99, -1456.41, -1.42, 224.0), stand = vec3(-1054.52, -1455.88, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1052.26, -1457.11, -1.42, 40.05), stand = vec3(-1051.5, -1457.48, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1052.8, -1457.83, -1.42, 40.05), stand = vec3(-1052.38, -1458.36, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1050.46, -1462.03, -1.42, 175), stand = vec3(-1049.8, -1461.79, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1051.24, -1462.04, -1.42, 176), stand = vec3(-1051.37, -1461.29, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1051.27, -1463.71, -1.42, 359), stand = vec3(-1049.85, -1463.77, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1050.52, -1463.65, -1.42, 351), stand = vec3(-1051.12, -1464.4, -1.42), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1062.78, -1468.92, -1.10, 257), stand = vec3(-1063.29, -1467.94, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1062.63, -1468.11, -1.10, 255), stand = vec3(-1063.34, -1467.94, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1061.10, -1468.57, -1.10, 75), stand = vec3(-1060.29, -1468.49, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1061.38, -1469.29, -1.10, 64), stand = vec3(-1060.56, -1469.49, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1066.17, -1465.27, -1.10, 215), stand = vec3(-1066.67, -1464.54, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1065.52, -1464.96, -1.10, 209), stand = vec3(-1065.85, -1464.18, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1064.74, -1466.22, -1.10, 32), stand = vec3(-1064.1, -1466.65, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1065.42, -1466.66, -1.10, 29), stand = vec3(-1064.98, -1467.24, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1066.34, -1460.40, -1.10, 162), stand = vec3(-1066.17, -1459.56, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1065.55, -1460.72, -1.10, 163), stand = vec3(-1065.43, -1459.74, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1065.86, -1462.05, -1.10, 345), stand = vec3(-1065.64, -1462.68, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1066.61, -1461.78, -1.10, 346), stand = vec3(-1066.8, -1462.62, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1063.80, -1458.11, -1.10, 304), stand = vec3(-1064.37, -1458.75, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1064.27, -1457.52, -1.10, 300), stand = vec3(-1064.96, -1457.9, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1063.08, -1456.62, -1.10, 120), stand = vec3(-1062.45, -1456.14, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1062.75, -1457.32, -1.10, 121), stand = vec3(-1061.98, -1456.82, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1059.66, -1455.78, -1.10, 258), stand = vec3(-1060.48, -1455.68, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1059.85, -1456.61, -1.10, 264), stand = vec3(-1060.67, -1456.61, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1058.26, -1456.78, -1.10, 86), stand = vec3(-1058.15, -1457.36, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1058.18, -1455.98, -1.10, 85), stand = vec3(-1057.41, -1456.04, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1054.16, -1458.80, -1.10, 34), stand = vec3(-1053.66, -1459.34, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1054.79, -1459.25, -1.10, 45), stand = vec3(-1055.06, -1459.99, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1055.83, -1458.17, -1.10, 233), stand = vec3(-1056.28, -1458.62, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1055.27, -1457.65, -1.10, 225), stand = vec3(-1055.94, -1457.33, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1053.83, -1462.02, -1.10, 184), stand = vec3(-1053.87, -1461.25, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1053.04, -1462.01, -1.10, 183), stand = vec3(-1053.06, -1461.18, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1052.98, -1463.53, -1.10, 356), stand = vec3(-1052.99, -1464.3, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1053.84, -1463.48, -1.10, 356), stand = vec3(-1053.78, -1464.37, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1056.66, -1463.24, -1.10, 20), stand = vec3(-1056.33, -1464.03, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1055.92, -1462.36, -1.10, 74), stand = vec3(-1055.21, -1462.77, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1055.99, -1461.25, -1.10, 116), stand = vec3(-1055.14, -1461.05, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1056.80, -1460.53, -1.10, 157), stand = vec3(-1056.51, -1459.74, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1057.92, -1460.69, -1.10, 208), stand = vec3(-1058.15, -1459.84, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1058.55, -1461.52, -1.10, 252), stand = vec3(-1059.41, -1461.05, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1058.57, -1462.55, -1.10, 298), stand = vec3(-1059.4, -1462.81, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1057.71, -1463.27, -1.10, 340), stand = vec3(-1058.2, -1464.01, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1059.19, -1465.14, -1.10, 98), stand = vec3(-1058.45, -1465.12, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1059.76, -1464.21, -1.10, 135), stand = vec3(-1059.17, -1463.61, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1060.86, -1463.96, -1.10, 178), stand = vec3(-1060.56, -1463.1, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1061.82, -1464.39, -1.10, 222), stand = vec3(-1062.3, -1463.73, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1062.11, -1465.47, -1.10, 282), stand = vec3(-1062.53, -1464.94, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1061.67, -1466.48, -1.10, 308), stand = vec3(-1062.31, -1466.25, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1060.56, -1466.73, -1.10, 3), stand = vec3(-1061.18, -1467.15, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1059.49, -1466.30, -1.10, 38), stand = vec3(-1059.75, -1466.98, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},

	{ coords = vector4(-1062.30, -1462.22, -1.10, 338), stand = vec3(-1061.84, -1462.46, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1063.15, -1461.51, -1.10, 297), stand = vec3(-1060.57, -1461.93, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1063.31, -1460.34, -1.10, 249), stand = vec3(-1060.04, -1460.71, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1062.58, -1459.55, -1.10, 204), stand = vec3(-1060.64, -1459.41, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1061.44, -1459.41, -1.10, 149), stand = vec3(-1062.0, -1458.95, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1061.67, -1466.48, -1.10, 308), stand = vec3(-1063.25, -1459.61, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1060.57, -1460.02, -1.10, 123), stand = vec3(-1063.7, -1460.9, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1060.52, -1461.20, -1.10, 67), stand = vec3(-1061.75, -1462.56, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
	{ coords = vector4(-1061.19, -1462.11, -1.10, 22), stand = vec3(-1060.48, -1462.21, -1.02), minZ = -1.92, maxZ = -1.32, w = 0.5, h = 0.5,height=0.5},
}
Location.Tables = {
    { name = "Koi Table 01", coords = vector3(-1054.35, -1479.04, -1.92), heading = 11.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 02", coords = vector3(-1056.59, -1479.51, -1.92), heading = 11.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 03", coords = vector3(-1058.79, -1479.93, -1.92), heading = 11.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 04", coords = vector3(-1077.06, -1461.01, -1.92), heading = 77.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 05", coords = vector3(-1076.54, -1458.81, -1.92), heading = 77.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 06", coords = vector3(-1076.03, -1456.59, -1.92), heading = 77.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 07", coords = vector3(-1052.99, -1446.83, -1.92), heading = 329.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 08", coords = vector3(-1051.04, -1447.99, -1.92), heading = 329.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 09", coords = vector3(-1049.09, -1449.15, -1.92), heading = 329.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 10", coords = vector3(-1045.97, -1452.37, -1.92), heading = 299.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 11", coords = vector3(-1044.85, -1454.37, -1.92), heading = 299.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 12", coords = vector3(-1043.75, -1456.33, -1.92), heading = 299.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 13", coords = vector3(-1042.65, -1460.72, -1.92), heading = 269.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 14", coords = vector3(-1042.69, -1462.96, -1.92), heading = 89.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 15", coords = vector3(-1042.74, -1465.24, -1.92), heading = 89.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 16", coords = vector3(-1043.98, -1469.51, -1.92), heading = 59.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 17", coords = vector3(-1045.18, -1471.46, -1.92), heading = 59.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 18", coords = vector3(-1046.33, -1473.41, -1.92), heading = 59.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 19", coords = vector3(-1062.77, -1471.16, -1.92), heading = 341.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 20", coords = vector3(-1067.68, -1467.02, -1.92), heading = 299.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 21", coords = vector3(-1068.58, -1460.64, -1.92), heading = 77.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 22", coords = vector3(-1064.99, -1455.31, -1.92), heading = 35.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 23", coords = vector3(-1058.76, -1453.74, -1.92), heading = 353.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 24", coords = vector3(-1053.07, -1456.78, -1.92), heading = 311.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 25", coords = vector3(-1050.86, -1462.82, -1.92), heading = 89.0, minZ = -1.92, maxZ = -1.12, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 26", coords = vector3(-1061.95, -1468.75, -1.62), heading = 341.0, minZ = -1.62, maxZ = -1.12, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 27", coords = vector3(-1065.47, -1465.77, -1.62), heading = 299.0, minZ = -1.62, maxZ = -1.12, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 28", coords = vector3(-1066.12, -1461.21, -1.62), heading = 77.0, minZ = -1.62, maxZ = -1.12, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 29", coords = vector3(-1063.52, -1457.39, -1.62), heading = 35.0, minZ = -1.62, maxZ = -1.12, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 30", coords = vector3(-1059.08, -1456.27, -1.62), heading = 353.0, minZ = -1.62, maxZ = -1.12, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 31", coords = vector3(-1055.00, -1458.43, -1.62), heading = 311.0, minZ = -1.62, maxZ = -1.12, w = 0.9, h = 1.75,height=0.5 },
	{ name = "Koi Table 32", coords = vector3(-1053.41, -1462.78, -1.62), heading = 269.0, minZ = -1.62, maxZ = -1.12, w = 0.9, h = 1.75,height=0.5 },

	{ name = "Koi Table 33", coords = vector3(-1068.56, -1477.17, -1.92), heading = 59.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 3.55,height=0.7 },
	{ name = "Koi Table 34", coords = vector3(-1074.62, -1470.84, -1.92), heading = 29.0, minZ = -2.22, maxZ = -1.42, w = 0.9, h = 3.55,height=0.7 },
	{ name = "Koi Table 35", coords = vector3(-1065.33, -1481.85, -1.72), heading = 345.0, minZ = -1.92, maxZ = -1.22, w = 3.0, h = 2.2,height=0.7 },
	{ name = "Koi Table 36", coords = vector3(-1074.14, -1476.46, -1.72), heading = 315.0, minZ = -1.92, maxZ = -1.22, w = 3.0, h = 2.2,height=0.7 },
	{ name = "Koi Table 37", coords = vector3(-1079.15, -1467.48, -1.72), heading = 285.0, minZ = -1.92, maxZ = -1.22, w = 3.0, h = 2.2,height=0.7 },

	{ name = "Koi Table 38", coords = vector3(-1060.59, -1465.35, -1.52), heading = 0.0, minZ = -1.72, maxZ = -1.02, w = 1.5, h = 1.5,height=0.7 },
	{ name = "Koi Table 39", coords = vector3(-1057.25, -1461.89, -1.52), heading = 0.0, minZ = -1.72, maxZ = -1.02, w = 1.5, h = 1.5,height=0.7 },
	{ name = "Koi Table 40", coords = vector3(-1061.86, -1460.76, -1.52), heading = 0.0, minZ = -1.72, maxZ = -1.02, w = 1.5, h = 1.5,height=0.7 },
}

end

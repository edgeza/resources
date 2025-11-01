Location = {}

if Config.location == "gabz" then
Location.TargetCoords = {
 Fridge = {
 { name = ""..Config.Jobname.." Fridge", coords =vec3(-590.9, -1058.73, 22.26),heading=94.85, minZ = 22.0, maxZ = 22.8, w = 1.0, h = 0.8,height=1.4 }
 },
 Management = {
     { name = ""..Config.Jobname.." Management", coords =vec3(-586.8, -1059.15, 22.15),heading=0.0, minZ = 22.0, maxZ = 22.8, w = 0.5, h = 0.6,height=0.5 }
 },
 Process = {
     { name = ""..Config.Jobname.." Process", coords =vec3(-587.957, -1058.807, 22.26),heading=268.9, minZ = 22.0, maxZ = 22.8, w = 0.5, h = 0.6,height=0.45 }
 },
 Stash = {
     { name = ""..Config.Jobname.." Stash", coords =vec3(-590.62, -1068.17, 22.0),heading=94.85, minZ = 22.0, maxZ = 22.8, w = 0.5, h = 1,height=1.4 }
 },
 BossMenu = {
     { name = ""..Config.Jobname.." BossMenu", coords =vec3(-596.2, -1052.8, 22.25),heading=0.0, minZ = 22.0, maxZ = 22.80, w = 0.5, h = 0.2,height=0.7}
 },
 Clothing = {
     { name = ""..Config.Jobname.." Clothing", coords =vec3(-586.29, -1049.79, 22.4),heading=273.37, minZ = 22.0, maxZ = 22.8, w = 1.0, h = 0.8,height=1.3 }
 },
 Duty = {
     { name = ""..Config.Jobname.." Duty", coords =vector3(-594.2, -1052.4, 22.65),heading=0.0, minZ = 22.0, maxZ = 23.0, w = 0.2, h = 0.75,height=1 }
 },
 HandWash = {
     { name = ""..Config.Jobname.." HandWash", coords =vector3(-587.85, -1062.55, 22.1),heading=0.0, minZ = 21.00, maxZ = 22.90, w = 0.6, h = 0.75,height=1.1 }
 },
 IceMachine = {
     { name = ""..Config.Jobname.." IceMachine", coords =vector3(-590.75, -1059.75, 22.4),heading=0.0, minZ = 22.0, maxZ = 22.8, w = 0.4, h = 0.75,height=0.6 }
 },
}
Location.Delivery = {
    Coords = vec3(-598.69, -1055.69, 22.34),
    Ped = vec3(-598.69, -1055.69, 22.34),
    Pedheading=191.1,
    VehicleSpawn = vector3(-607.96, -1058.82, 21.18),
    VehicleHeading = 93.59,
}
Location.BuyMenu = { --Shop buy menu
    vec3(-583.31, -1060.43, 22.34),
}
Location.Counter = {
    { name = "Cat Cafe Counter 01", coords = vec3(-583.97, -1059.3, 22.4), heading = 0, minZ = 22.0, maxZ = 22.8, w = 0.6, h = 0.7,height=0.7 },
    { name = "Cat Cafe Counter 02", coords = vec3(-584.0, -1062.1, 22.4), heading = 0, minZ = 22.0, maxZ = 22.8, w = 0.6, h = 0.7,height=0.7 },
}
Location.Billing = {
    { name = "Cat Cafe Billing Counter 1", coords = vec3(-583.997, -1058.756, 22.37), heading = 0, minZ = 22.2, maxZ = 22.5, w = 0.5, h = 0.35,height=0.35 },
    { name = "Cat Cafe Billing Counter 2", coords = vec3(-584.07, -1061.44, 22.37), heading = 0, minZ = 22.2, maxZ = 22.5, w = 0.5, h = 0.35,height=0.35 },
}
Location.TrashCan = {
    { name = "Cat Cafe Trash Can 1", coords = vec3(-571.05, -1051.0, 21.35), heading = 0.0, minZ = 20.80, maxZ = 22.10, w = 0.5, h = 0.5,height=1.45 },
}
Location.Chairs = {
    --TableSeating
	{ coords = vector4(-585.31, -1069.25, 22.55, 4.37), stand = vector3(-585.3, -1068.6, 22.34) , minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
    { coords = vector4(-582.817, -1069.37, 22.55, 15.613), stand = vector3(-582.86, -1068.64, 22.34) , minZ = 22.0, maxZ = 22.8, w = 0.5, h = 0.5,height=0.45},
	{ coords = vector4(-579.23, -1069.22, 22.55, 358.32), stand = vector3(-579.19, -1068.64, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
    --TableSeating
	--Table 1
    { coords = vector4(-573.416, -1067.971, 22.53, 2.746), stand = vector3(-575.18, -1068.0, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{ coords = vector4(-574.33, -1068.025, 22.53, 1.79), stand = vector3(-575.18, -1068.0, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
    { coords = vector4(-573.18, -1066.11, 22.53, 180.8), stand = vector3(-575.11, -1066.02, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{ coords = vector4(-574.49, -1066.11, 22.53, 186.0), stand = vector3(-575.11, -1066.02, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	--Table 2
	{ coords = vector4(-574.31, -1064.37, 22.53, 5.34), stand = vector3(-575.26, -1064.15, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{ coords = vector4(-573.18, -1064.35, 22.53, 4.59), stand = vector3(-575.26, -1064.15, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
    { coords = vector4(-572.98, -1062.45, 22.53, 179.93), stand = vector3(-575.28, -1062.48, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{ coords = vector4(-574.3, -1062.45, 22.53, 186.22), stand = vector3(-575.28, -1062.48, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	--Table 3
	{ coords = vector4(-573.16, -1060.71, 22.53, 0.13), stand = vector3(-575.09, -1060.55, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{ coords = vector4(-574.34, -1060.72, 22.53, 3.12), stand = vector3(-575.09, -1060.55, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
    { coords = vector4(-573.08, -1058.8, 22.53, 180.07), stand = vector3(-575.04, -1058.81, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{ coords = vector4(-574.39, -1058.8, 22.53, 182.85), stand = vector3(-575.04, -1058.81, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	--Green Seats
	{ coords = vector4(-576.936, -1051.0, 22.35, 103.5),stand = vector3(-576.21, -1051.74, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{coords = vector4(-577.62, -1052.42, 22.35, 44.79),stand = vector3(-576.75, -1052.33, 22.34),minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{coords = vector4(-579.64, -1052.52, 22.35, 329.23),stand = vector3(-578.97, -1052.9, 22.35),minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{coords = vector4(-580.78, -1051.28, 22.35, 284.8),stand = vector3(-580.58, -1052.07, 22.35),minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	--Single Chairs
	{coords = vector4(-586.20, -1067.66, 22.63, 93.04),stand = vector3(-585.54, -1067.68, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{coords = vector4(-586.20, -1066.68, 22.63, 97.45),stand =vector3(-585.51, -1066.67, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{coords = vector4(-586.20, -1065.68, 22.63, 94.41),stand =vector3(-585.8, -1065.62, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
	{coords = vector4(-586.20, -1064.67, 22.63, 97.21),stand =vector3(-585.83, -1064.7, 22.34), minZ = 22.0, maxZ = 22.8, w = 0.3, h = 0.45,height=0.45},
}
Location.Tables = {
    { name = "Cat Cafe Table 01", coords = vector3(-573.5, -1067.0, 22.3), heading = 0, minZ = 21.9, maxZ = 22.5, w = 2, h = 1,height=1 },
    { name = "Cat Cafe Table 02", coords = vector3(-573.24, -1063.43, 22.3), heading = 0, minZ = 21.9, maxZ = 22.5, w = 2, h = 1,height=1 },
    { name = "Cat Cafe Table 03", coords = vector3(-572.99, -1059.77, 22.3), heading = 0, minZ = 21.9, maxZ = 22.5, w = 2, h = 1,height=1 },  
}
end

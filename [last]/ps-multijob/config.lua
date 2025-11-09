Config = Config or {}

-- Side of the screen where you want the ui to be on. Can either be "left" or "right"
Config.Side = "right"

Config.MaxJobs = 3
Config.IgnoredJobs = {
	["unemployed"] = true,
	["ambulance"] = true,
	["bcso"] = true,
	["police"] = true,
}
Config.DenyDuty = {
}

Config.WhitelistJobs = {
	["police"] = true,
	["ambulance"] = true,
	["palmcoast"] = true,
	["bennies"] = true,
	["6str"] = true,
	["olrpmechanic"] = true,
	["judge"] = true,
	["lawyer"] = true,
	["doj"] = true,
	["koi"] = true,
	["catcafe"] = true,
	["highnotes"] = true,
	["beanmachine"] = true,
	["aldente"] = true,
	["drivingteacher"] = true,
	["dynasty"] = true,
	["towing"] = true,
	["patreon1"] = false,
	["patreon2"] = false,
	["patreon3"] = false,
	["patreon4"] = false,
}

Config.Descriptions = {
	["unemployed"] = "Looking for work",
	["police"] = "Shoot some criminals or maybe be a good cop and arrest them",
	["bcso"] = "Shoot some criminals or maybe be a good cop and arrest them",
	--["ambulance"] = "Fix the bullet holes",
	["mechanic1"] = "Fix the bullet holes",
	["tow"] = "Pickup the tow truck and steal some vehicles",
	["taxi"] = "Pickup people around the city and drive them to their destination",
	["bus"] = "Pickup multiple people around the city and drive them to their destination",
	["realestate"] = "Sell houses or something",
	["dynasty"] = "Sell houses or something",
	["cardealer"] = "Sell cars or something",
	["judge"] = "Decide if people are guilty",
	["lawyer"] = "Help the good or the bad",
	["reporter"] = "Lowkey useless",
	["trucker"] = "Drive a truck",
	["garbage"] = "Drive a garbage truck",
	["vineyard"] = "Get them vines",
	["hotdog"] = "Sell them glizzys",
	["beanmachine"] = "Selling a cuppa!",
	["aldente"] = "Sorting the hungry",
	["drivingteacher"] = "Teaching some driving skills",
	["skydive"] = "Free Fallin'",
	["skybar"] = "Sell some yummy drinks",
}

-- Change the icons to any free font awesome icon, also add other jobs your server might have to the list
-- List: https://fontawesome.com/search?o=r&s=solid
Config.FontAwesomeIcons = {
	["unemployed"] = "fa-solid fa-user",
	["police"] = "fa-solid fa-handcuffs",
	["bcso"] = "fa-solid fa-handcuffs",
	--["ambulance"] = "fa-solid fa-user-doctor",
	["mechanic1"] = "fa-solid fa-wrench",
	["tow"] = "fa-solid fa-truck-tow",
	["taxi"] = "fa-solid fa-taxi",
	["bus"] = "fa-solid fa-bus",
	["realestate"] = "fa-solid fa-sign-hanging",
	["dynasty"] = "fa-solid fa-sign-hanging",
	["cardealer"] = "fa-solid fa-cards",
	["judge"] = "fa-solid fa-gave",
	["lawyer"] = "fa-solid fa-gavel",
	["reporter"] = "fa-solid fa-microphone",
	["trucker"] = "fa-solid fa-truck-front",
	["garbage"] = "fa-solid fa-trash-can",
	["vineyard"] = "fa-solid fa-wine-bottle",
	["hotdog"] = "fa-solid fa-hotdog",
	["beanmachine"] = "fa-solid fa-mug-hot",
	["aldente"] = "fa-solid fa-burger",
	["drivingteacher"] = "fa-solid fa-parachute-box",
	["skydive"] = "fa-solid fa-parachute-box",
	["skybar"] = "fa-solid fa-wine-glass",
}

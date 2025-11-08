local Alert     = {}

local function GetScreenshot(type)
    if config.AlertOptions[type].takescreenshot then
        local screenshot = Functions.TakeScreenshot()
        return screenshot
    end
end

function Alert.Custom(data)
    local coords = data.coords or vec3(0.0, 0.0, 0.0)
    if data.job then job = data.job end
    local gender = data.sex or (Framework.Player.Gender == 'm' and locale('male') or locale('female'))
    if not data.gender then gender = nil end

    data.codeName = data.codeName or 'explosion'
    data.icon = 'conflict'

    local dispatchData = {
        id = 0,
        event = data.event or data.message or 'NEW ALERT',
        title = data.title or data.message or "",
        description = data.description or data.message or 'None',
        code = data.code or '10-XX',
        codeName = 'explosion',
        coords = coords,
        icon = data.icon or 'conflict',
        time = Functions.GetCurrentTime(),
        priority = data.priority or 0,
        img = data.img or "",
        vehicle = data.name or false,
        plate = data.plate or false,
        color = data.color or false,
        class = data.class or false,
        doors = data.doors or false,
        street = data.street or Functions.GetStreetAndZone(coords),
        gender = gender,
        userList = {},
        alert = {
            radius = data.radius or 0, -- Radius around the blip
            sprite = data.sprite or 1, -- Sprite of the blip
            color = data.color or 1, -- Color of the blip
            scale = data.scale or 0.5, -- Scale of the blip
            length = data.length or 2, -- How long it stays on the map
            sound = data.sound or "Lose_1st", -- Alert sound
            sound2 = data.sound2 or "GTAO_FM_Events_Soundset", -- Alert sound
            offset = data.offset or "false", -- Blip / radius offset
            flash = data.flash or "false" -- Blip flash
        },
        recipientJobs = data.jobs,
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('CustomDispatch', Alert.Custom)
RegisterNetEvent('dusa_dispatch:sendCustomDispatch', Alert.Custom)



function Alert.VehicleTheft()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = Functions.GetVehicleData(cache.vehicle)
    local image = GetScreenshot('vehicletheft')

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('vehicletheft'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-35',
        codeName = 'vehicletheft',
        icon = 'cartheft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        street = Functions.GetStreetAndZone(coords),
        heading = Functions.GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('VehicleTheft', Alert.VehicleTheft)


function Alert.Shooting()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('shooting')

    local isPlayerPolice = Functions.IsPolice(Framework.Player.Job.Name)
    local shouldSendAlert = true
    
    if isPlayerPolice and not config.IncludePolice then
        shouldSendAlert = false
    end
    
    if not shouldSendAlert then return end

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('shooting'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-11',
        codeName = 'shooting',
        icon = 'conflict',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        street = Functions.GetStreetAndZone(coords),
        gender = Functions.GetPlayerGender(),
        weapon = Functions.GetWeaponName(),
        userList = {},
        recipientJobs = recipientJobs
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('Shooting', Alert.Shooting)

function Alert.Hunting()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('hunting')

    local isPlayerPolice = Functions.IsPolice(Framework.Player.Job.Name)
    local shouldSendAlert = true
    
    if isPlayerPolice and not config.IncludePolice then
        shouldSendAlert = false
    end
    
    if not shouldSendAlert then return end

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('shooting'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-13',
        codeName = 'hunting',
        icon = 'conflict',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        weapon = Functions.GetWeaponName(),
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = recipientJobs
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('Hunting', Alert.Hunting)


function Alert.VehicleShooting()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = Functions.GetVehicleData(cache.vehicle)
    local image = GetScreenshot('vehicleshots')

    local isPlayerPolice = Functions.IsPolice(Framework.Player.Job.Name)
    local shouldSendAlert = true
    
    if isPlayerPolice and not config.IncludePolice then
        shouldSendAlert = false
    end
    
    if not shouldSendAlert then return end

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('vehicleshots'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-60',
        codeName = 'vehicleshots',
        icon = 'cartheft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        weapon = Functions.GetWeaponName(),
        street = Functions.GetStreetAndZone(coords),
        heading = Functions.GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        userList = {},
        recipientJobs = recipientJobs
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('VehicleShooting', Alert.VehicleShooting)

function Alert.SpeedingVehicle()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = Functions.GetVehicleData(cache.vehicle)
    local image = GetScreenshot('speeding')

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('speeding'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-11',
        codeName = 'speeding',
        icon = 'traffic',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        street = Functions.GetStreetAndZone(coords),
        heading = Functions.GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('SpeedingVehicle', Alert.SpeedingVehicle)

function Alert.Fight()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('fight')

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('melee'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-10',
        codeName = 'fight',
        icon = 'suspect',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('Fight', Alert.Fight)

function Alert.PrisonBreak()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('prisonbreak')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('prisonbreak'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'prisonbreak',
        icon = 'prisonbreak',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('PrisonBreak', Alert.PrisonBreak)

function Alert.StoreRobbery(camId)
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('storerobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('storerobbery'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'storerobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        camId = camId,
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('StoreRobbery', Alert.StoreRobbery)

function Alert.FleecaBankRobbery(camId)
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('bankrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('fleecabank'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'bankrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        camId = camId,
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('FleecaBankRobbery', Alert.FleecaBankRobbery)

function Alert.PaletoBankRobbery(camId)
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('paletobankrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('paletobank'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'paletobankrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        camId = camId,
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('PaletoBankRobbery', Alert.PaletoBankRobbery)

function Alert.PacificBankRobbery(camId)
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('pacificbankrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('pacificbank'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'pacificbankrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        camId = camId,
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('PacificBankRobbery', Alert.PacificBankRobbery)

function Alert.VangelicoRobbery(camId)
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('vangelicorobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('vangelico'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'vangelicorobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        camId = camId,
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('VangelicoRobbery', Alert.VangelicoRobbery)

function Alert.HouseRobbery()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('houserobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('houserobbery'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'houserobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('HouseRobbery', Alert.HouseRobbery)

function Alert.YachtHeist()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('yachtheist')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('yachtheist'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-65',
        codeName = 'yachtheist',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('YachtHeist', Alert.YachtHeist)

function Alert.DrugSale()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('suspicioushandoff')

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('drugsell'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-13',
        codeName = 'suspicioushandoff',
        icon = 'suspect',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('DrugSale', Alert.DrugSale)

function Alert.SuspiciousActivity()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('susactivity')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('susactivity'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-66',
        codeName = 'susactivity',
        icon = 'suspect',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('SuspiciousActivity', Alert.SuspiciousActivity)

function Alert.CarJacking(vehicle)
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('carjack')

    local vehicle = Functions.GetVehicleData(vehicle)

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('carjacking'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-35',
        codeName = 'carjack',
        icon = 'cartheft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        street = Functions.GetStreetAndZone(coords),
        heading = Functions.GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('CarJacking', Alert.CarJacking)

function Alert.InjuriedPerson()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('civdown')

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('persondown'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-69',
        codeName = 'civdown',
        icon = 'dead',
        priority = 0,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        alertTime = 10,
        recipientJobs = { 'ems', 'ambulance' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('InjuriedPerson', Alert.InjuriedPerson)

function Alert.DeceasedPerson()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('civdead')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('civbled'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-69',
        codeName = 'civdead',
        icon = 'dead',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        alertTime = 10,
        recipientJobs = { 'ems', 'ambulance' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('DeceasedPerson', Alert.DeceasedPerson)

function Alert.OfficerDown()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('officerdown')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('officerdown'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-99',
        codeName = 'officerdown',
        icon = 'dead',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname,
        callsign = Framework.Player.Metadata.callsign,
        alertTime = 10,
        recipientJobs = { 'ems', 'ambulance', 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('OfficerDown', Alert.OfficerDown)

RegisterNetEvent("ps-dispatch:client:officerdown", function() OfficerDown() end)

function Alert.OfficerBackup()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('officerbackup')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('officerbackup'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-32',
        codeName = 'officerbackup',
        icon = 'backup',
        priority = 2,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname,
        callsign = Framework.Player.Metadata.callsign,
        alertTime = 10,
        recipientJobs = { 'ems', 'leo'}
    }
    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('OfficerBackup', Alert.OfficerBackup)
RegisterNetEvent("dusa_dispatch:client:officerbackup", Alert.OfficerBackup)

function Alert.OfficerInDistress()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('officerdistress')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('officerdistress'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-99',
        codeName = 'officerdistress',
        icon = 'backup',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname,
        callsign = Framework.Player.Metadata.callsign,
        alertTime = 10,
        recipientJobs = { 'ems', 'ambulance', 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('OfficerInDistress', Alert.OfficerInDistress)

function Alert.EmsDown()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('emsdown')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('emsdown'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-99',
        codeName = 'emsdown',
        icon = 'dead',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        name = Framework.Player.Firstname .. ' ' .. Framework.Player.Lastname,
        callsign = Framework.Player.Metadata.callsign,
        alertTime = 10,
        recipientJobs = { 'ems', 'ambulance', 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('EmsDown', Alert.EmsDown)

RegisterNetEvent("ps-dispatch:client:emsdown", function() EmsDown() end)

function Alert.Explosion()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('explosion')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('explosion'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-80',
        codeName = 'explosion',
        icon = 'explosion',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('Explosion', Alert.Explosion)


function Alert.ArtGalleryRobbery()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('artgalleryrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('artgalleryrobbery'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'artgalleryrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }
    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('ArtGalleryRobbery', Alert.ArtGalleryRobbery)

function Alert.HumaneRobbery()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('humanelabsrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('humanelabsrobbery'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'humanelabsrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }
    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)

end
exports('HumaneRobbery', Alert.HumaneRobbery)

function Alert.TrainRobbery()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('trainrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('trainrobbery'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'trainrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }
    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)

end
exports('TrainRobbery', Alert.TrainRobbery)

function Alert.VanRobbery()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('vanrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('vanrobbery'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'vanrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }
    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)

end
exports('VanRobbery', Alert.VanRobbery)

function Alert.UndergroundRobbery()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('undergroundrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('underground'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'undergroundrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }
    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('UndergroundRobbery', Alert.UndergroundRobbery)

function Alert.DrugBoatRobbery()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('drugboatrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('drugboatrobbery'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-65',
        codeName = 'drugboatrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('DrugBoatRobbery', Alert.DrugBoatRobbery)

function Alert.UnionRobbery()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('unionrobbery')


    local dispatchData = {
        event = locale('alert_header'),
        title = locale('unionrobbery'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-90',
        codeName = 'unionrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('UnionRobbery', Alert.UnionRobbery)

function Alert.CarBoosting(vehicle)
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('carboosting')

    local vehicle = Functions.GetVehicleData(vehicle or cache.vehicle)

    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('carboosting'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-50',
        codeName = 'carboosting',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        street = Functions.GetStreetAndZone(coords),
        heading = Functions.GetPlayerHeading(),
        vehicle = vehicle.name,
        plate = vehicle.plate,
        color = vehicle.color,
        class = vehicle.class,
        doors = vehicle.doors,
        userList = {},
        recipientJobs = { 'leo' }
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('CarBoosting', Alert.CarBoosting)

function Alert.SignRobbery()
    local coords = GetEntityCoords(cache.ped)
    local image = GetScreenshot('signrobbery')


    local dispatchData = {
        id = 0,
        event = locale('alert_header'),
        title = locale('signrobbery'),
        description = locale('alert_description', Functions.GetPlayerGender(), Functions.GetStreetAndZone(coords)),
        code = '10-10',
        codeName = 'signrobbery',
        icon = 'theft',
        priority = 1,
        time = Functions.GetCurrentTime(),
        img = image or "",
        coords = coords,
        gender = Functions.GetPlayerGender(),
        street = Functions.GetStreetAndZone(coords),
        recipientJobs = { 'leo'}
    }

    TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
end
exports('SignRobbery', Alert.SignRobbery)

function Alert.PhoneCall(message, anonymous, job, type)
    local coords = GetEntityCoords(cache.ped)
    local image = nil

    if IsCallAllowed(message) then
        PhoneAnimation()

        -- anonymous and locale('hidden_number') or PlayerData.phone
        local dispatchData = {
            id = 0,
            event = locale('alert_header'),
            title = locale('call'),
            description = locale('call_description', locale('hidden_number')),
            code = type,
            codeName = type == '311' and '311call' or '911call',
            icon = 'call',
            priority = 1,
            time = Functions.GetCurrentTime(),
            img = image or "",
            coords = coords,
            gender = Functions.GetPlayerGender(),
            street = Functions.GetStreetAndZone(coords),
            recipientJobs = job
        }

        TriggerServerEvent('dusa_dispatch:sendDispatch', dispatchData)
    end
end

--- @param data string -- Message
--- @param type string -- What type of emergency
--- @param anonymous boolean -- Is the call anonymous
RegisterNetEvent('ps-dispatch:client:sendEmergencyMsg', function(data, type, anonymous)
    TriggerEvent('dusa_dispatch:client:sendEmergencyMsg', data, type, anonymous)
end)

RegisterNetEvent('dusa_dispatch:client:sendEmergencyMsg', function(data, type, anonymous)
    local recipientJobs = { ['911'] = { 'leo'}, ['311'] = { 'ems' } }

    Alert.PhoneCall(data, anonymous, recipientJobs[type], type)
end)

return Alert
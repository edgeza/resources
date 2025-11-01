Config = {}

-- Allowed vehicles for towing (only caracaran and everonb)
Config.AllowedVehicles = {
    'caracaran',
    'everonb'
}

-- Tow rope settings
Config.TowRopeLength = 10.0
Config.TowRopeModel = 'prop_cs_heist_rope' -- Visual prop for the rope
Config.TowRopeItem = 'rope' -- Item in inventory
Config.TowRopeAttachOffset = vector3(0.0, -2.0, 0.0)

-- Third eye settings
Config.ThirdEyeDistance = 3.0
Config.ThirdEyeKey = 'E'

-- Messages
Config.Messages = {
    getTowRope = 'Get Tow Rope',
    attachTowRope = 'Attach Tow Rope',
    detachTowRope = 'Detach Tow Rope',
    alreadyHasRope = 'You already have a tow rope!',
    notAllowedVehicle = 'This vehicle cannot be used for towing!',
    noTowRope = 'You need a tow rope to attach!',
    ropeAttached = 'Tow rope attached successfully!',
    ropeDetached = 'Tow rope detached!'
}

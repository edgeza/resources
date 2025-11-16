local allowedModels = {}
local supportedModelsIndexed = false

local function IndexSupportedGasPumpModels()
    if supportedModelsIndexed then
        return
    end

    if type(Config) ~= "table" or type(Config.SupportedGasPumpModel) ~= "table" then
        return
    end

    local indexed = {}

    for _, pumpConfig in pairs(Config.SupportedGasPumpModel) do
        if type(pumpConfig) == "table" and pumpConfig.modelHash then
            indexed[pumpConfig.modelHash] = pumpConfig
        end
    end

    Config.SupportedGasPumpModel = indexed
    supportedModelsIndexed = true
end

local function GetPumpConfig(modelHash)
    if not modelHash then
        return nil
    end

    if not supportedModelsIndexed then
        IndexSupportedGasPumpModels()
    end

    if type(Config) ~= "table" or type(Config.SupportedGasPumpModel) ~= "table" then
        return nil
    end

    return Config.SupportedGasPumpModel[modelHash]
end

local function GetPumpConfigFromEntity(obj)
    if not obj then
        return nil, nil
    end

    local modelHash = GetEntityModel(obj)

    if not modelHash then
        return nil, nil
    end

    return GetPumpConfig(modelHash), modelHash
end

CreateThread(function()
    while type(Config) ~= "table" or type(Config.SupportedGasPumpModel) ~= "table" do
        Wait(0)
    end

    IndexSupportedGasPumpModels()

    for _, pumpConfig in pairs(Config.SupportedGasPumpModel) do
        allowedModels[pumpConfig.modelHash] = true

        if pumpConfig.inGameUIData then
            Config.resolution[pumpConfig.modelHash] = pumpConfig.inGameUIData
        end
    end
end)

function IsModelAllowedDispenser(model)
    return GetPumpConfig(model) ~= nil
end

function GetAllWorkingDispenserModels()
    return allowedModels
end

function GetDispenserGunModel(model)
    local pumpConfig = GetPumpConfig(model)

    if not pumpConfig then
        return nil
    end

    return pumpConfig.nozzleHand
end

function CreateFuelRopeForPump(obj, side)
    if not obj or not side then
        return
    end

    local pumpConfig = GetPumpConfigFromEntity(obj)

    if not pumpConfig then
        return
    end

    local dispenserData = pumpConfig.dispenserGunObjectsPosition and pumpConfig.dispenserGunObjectsPosition[side]

    if not dispenserData then
        return
    end

    local offsetRope = dispenserData.offsetRope
    local ropePos = GetOffsetFromEntityInWorldCoords(obj, offsetRope)

    local ropeObject = CreateLocalObject(pumpConfig.nozzleWithTube, ropePos)

    SetEntityCollision(ropeObject, false, true)
    SetEntityHeading(ropeObject, GetEntityHeading(obj) - dispenserData.heading)
    return ropeObject
end

function CreateFuelHolderForPump(obj, side)
    if not obj or not side then
        return
    end

    if type(side) ~= "number" then
        print("side: ", side, type(side), "is not a number!")
        return
    end

    local pumpConfig, model = GetPumpConfigFromEntity(obj)

    if not pumpConfig then
        print("Model: ", model, type(model), "doesnt exists!")
        return
    end

    local dispenserData = pumpConfig.dispenserGunObjectsPosition and pumpConfig.dispenserGunObjectsPosition[side]
    if not dispenserData then
        return
    end

    local offsetHolder = dispenserData.offsetHolder
    local holderPos = GetOffsetFromEntityInWorldCoords(obj, offsetHolder)

    local holderObject = CreateLocalObject(pumpConfig.nozzleHolster, holderPos)

    SetEntityCollision(holderObject, false, true)
    SetEntityHeading(holderObject, GetEntityHeading(obj) - dispenserData.heading)

    return holderObject
end

function GetOffsetCoordsForRopeFuelDispenser(obj)
    local pumpConfig = GetPumpConfigFromEntity(obj)
    if not pumpConfig then
        return
    end

    local pedPos = GetEntityCoords(PlayerPedId())

    local offsetOne = pumpConfig.positionOffsetCheckForSides and pumpConfig.positionOffsetCheckForSides[1]
    local offsetTwo = pumpConfig.positionOffsetCheckForSides and pumpConfig.positionOffsetCheckForSides[2]

    local distance1 = offsetOne and #(GetOffsetFromEntityInWorldCoords(obj, offsetOne) - pedPos) or math.huge
    local distance2 = offsetTwo and #(GetOffsetFromEntityInWorldCoords(obj, offsetTwo) - pedPos) or math.huge

    if distance1 <= distance2 then
        return pumpConfig.ropeOffsetPosition and pumpConfig.ropeOffsetPosition[1]
    elseif distance2 < distance1 then
        return pumpConfig.ropeOffsetPosition and pumpConfig.ropeOffsetPosition[2]
    end
end

function GetOffsetsForUIFlipForDispenserPump(obj)
    local pumpConfig = GetPumpConfigFromEntity(obj)

    if not pumpConfig or not pumpConfig.positionOffsetCheckForCameraSide then
        return vector3(-1.25, -1.0, 0.0), vector3(-1.25, 1.0, 0.0)
    end

    return (pumpConfig.positionOffsetCheckForCameraSide[1] or vector3(-1.25, -1.0, 0.0)), (pumpConfig.positionOffsetCheckForCameraSide[2] or vector3(-1.25, 1.0, 0.0))
end

function GetWalkOffsetForPump(obj, side)
    local pumpConfig = GetPumpConfigFromEntity(obj)

    if not pumpConfig then
        return
    end

    local pedPos = GetEntityCoords(PlayerPedId())

    local offsetOne = pumpConfig.positionOffsetCheckForSides and pumpConfig.positionOffsetCheckForSides[1]
    local offsetTwo = pumpConfig.positionOffsetCheckForSides and pumpConfig.positionOffsetCheckForSides[2]

    local distance1 = offsetOne and #(GetOffsetFromEntityInWorldCoords(obj, offsetOne) - pedPos) or 999999
    local distance2 = offsetTwo and #(GetOffsetFromEntityInWorldCoords(obj, offsetTwo) - pedPos) or 999999

    local walkingOffsets = pumpConfig.playerWalkingOffsetPosition

    if not walkingOffsets then
        return
    end

    if side and walkingOffsets[side] then
        return GetOffsetFromEntityInWorldCoords(obj, walkingOffsets[side]), side
    end

    if distance1 <= distance2 then
        return walkingOffsets[1] and GetOffsetFromEntityInWorldCoords(obj, walkingOffsets[1]), 1
    elseif distance2 < distance1 then
        return walkingOffsets[2] and GetOffsetFromEntityInWorldCoords(obj, walkingOffsets[2]), 2
    end
end

function GetHeadingOffetForPump(obj, side)
    local pumpConfig = GetPumpConfigFromEntity(obj)

    if not pumpConfig then
        return
    end

    local pedPos = GetEntityCoords(PlayerPedId())

    local offsetOne = pumpConfig.positionOffsetCheckForSides and pumpConfig.positionOffsetCheckForSides[1]
    local offsetTwo = pumpConfig.positionOffsetCheckForSides and pumpConfig.positionOffsetCheckForSides[2]

    local distance1 = offsetOne and #(GetOffsetFromEntityInWorldCoords(obj, offsetOne) - pedPos) or 999999
    local distance2 = offsetTwo and #(GetOffsetFromEntityInWorldCoords(obj, offsetTwo) - pedPos) or 999999

    if side and pumpConfig.playerHeadingTowardGasPump then
        return pumpConfig.playerHeadingTowardGasPump[side]
    end

    if distance1 <= distance2 then
        return pumpConfig.playerHeadingTowardGasPump and pumpConfig.playerHeadingTowardGasPump[1]
    elseif distance2 < distance1 then
        return pumpConfig.playerHeadingTowardGasPump and pumpConfig.playerHeadingTowardGasPump[2]
    end
end
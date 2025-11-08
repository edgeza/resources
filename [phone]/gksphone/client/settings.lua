-- GKSPHONE | @GKSHOPTeam | discord.gg/XUck63E

--- Function to give a key to a car
--- @param callback_vehicle number The vehicle for which the key is being given
function GiveKeyCar(callback_vehicle)
  if GetResourceState('qs-vehiclekeys') == 'started' then
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(callback_vehicle))
    local plate = GetVehicleNumberPlateText(callback_vehicle)
    exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
  elseif GetResourceState('dusa_vehiclekeys') == 'started' then
    local plate = GetVehicleNumberPlateText(callback_vehicle)
    if plate and plate ~= '' then
      exports['dusa_vehiclekeys']:GiveKeys(plate)
    end
  elseif GetResourceState('qb-vehiclekeys') == 'started' then
    local plate = GetVehicleNumberPlateText(callback_vehicle)
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
  end
end

--- Sets the fuel level of a vehicle using the LegacyFuel resource.
--- @param callback_vehicle number The callback vehicle ID.
--- @param fuel number The fuel level to set the vehicle to.
function SetFuel(callback_vehicle, fuel)
  if GetResourceState('LegacyFuel') == 'started' then
    exports['LegacyFuel']:SetFuel(callback_vehicle, fuel)
  end
end



--- Function that will run after Dispatch confirms the sending
--- @param message string The message to send.
--- @param job string The job of the sender.
--- @param isAnonymous boolean Whether the sender is anonymous.
--- @param myPos table The position of the sender.
--- @param street string The street of the sender.
function SendReport(message, job, isAnonymous, myPos, street)
  if GetResourceState('cd_dispatch') == 'started' then
      local plyrdata = exports['cd_dispatch']:GetPlayerInfo()
      TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {job},
            coords = plyrdata.coords,
            title = 'Notification sent over the phone',
            message = message,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 817,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = 'Notification phone',
                time = (5*60*1000),
                sound = 1,
            }
      })
  elseif GetResourceState('ps-dispatch') == 'started' then
        TriggerServerEvent("dispatch:server:notify",{
            codeName = "911call",
            code = "911",
            icon = 'fas fa-phone',
            street = street,
            priority = 2,
            coords = myPos,
            message = "Notification sent over the phone",
            information = message,
            jobs = job
        })
  end
end

function HasItem(itemName)
  local success, searchItem = pcall(JobCenterHasItem, itemName)
  if success then
    return searchItem
  else
    local items = GetInventory()
    if items then
      for k, v in pairs(items) do
        if v.name == itemName then
          return true
        end
      end
    end
  end
  return false
end

if Config.UnderWaterCheck then
  CreateThread(function()
      local swimming = false
      while true do
          Wait(1000*2)
          if (IsPedSwimmingUnderWater(PlayerPedId())) and IsPedInAnyVehicle(PlayerPedId(), false) ~= 1 then
                if PhoneOpen then
                  PhoneForceClose()
                end
                if not PhoneOpenBlock then
                  PhoneOpenBlock = true
                  PhoneBlockReason = "The phone cannot be used underwater."
                  swimming = true
                end
          elseif swimming then
              if PhoneOpenBlock then 
                  PhoneOpenBlock = false
                  PhoneBlockReason = ""
              end
          end
      end
  end)
end

RegisterCommand("delphone", function()
  local playerPed = PlayerPedId();
  for _, v in pairs(GetGamePool("CObject")) do
      if IsEntityAttachedToEntity(playerPed, v) then
          SetEntityAsMissionEntity(v, true, true)
          DeleteObject(v)
          DeleteEntity(v)
      end
  end
end, false)

RegisterCommand("+answerPhoneCall", function () AnswerPhoneCall() end, false)
RegisterCommand("-answerPhoneCall", function () end, false)
RegisterKeyMapping("+answerPhoneCall", _T(Config.DefaultLocale, "RegisterCommand.REGISTERCOMMAND_ANSWERCALL"), "keyboard", "RETURN")

RegisterCommand("+endPhoneCall", function () EndPhoneCall() end, false)
RegisterCommand("-endPhoneCall", function () end, false)
RegisterKeyMapping("+endPhoneCall", _T(Config.DefaultLocale, "RegisterCommand.REGISTERCOMMAND_DECLINECALL"), "keyboard", "BACK")

RegisterCommand("+togglePhoneCursor", function () TogglePhoneCursor() end, false)
RegisterCommand("-togglePhoneCursor", function () end, false)
RegisterKeyMapping("+togglePhoneCursor", "Toggle cursor", "keyboard", "LMENU")


local function toggleNuiFrame(shouldShow, type)
  nuiMessage(type, shouldShow)
end
  RegisterNUICallback('hideFrame', function(_, cb)
    toggleNuiFrame(false)
    dp('Hide NUI frame')
    cb({})
  end)
  
  RegisterNUICallback('getClientData', function(data, cb)
    dp('Data sent by React', json.encode(data))
  
  -- Lets send back client coords to the React frame for use
    local curCoords = GetEntityCoords(PlayerPedId())
  
    local retData <const> = { x = curCoords.x, y = curCoords.y, z = curCoords.z }
    cb(retData)
  end)

-- loop
-- fuel 50
-- SendReactMessage('setFuel')


RegisterNUICallback('toggleSetting', function(data, cb)
  Wait(100)
  ToggleSettings(data.key, data.status)
  cb("ok")
end)

RegisterNUICallback('setRefreshRate', function(data, cb)
  local rate = SetRefreshRate(data.rate)
  config.defaultRefreshRate = rate
  hudSettings.speedoRefreshRate = rate
  cb("ok")
end)

RegisterNUICallback('updateSettings', function(data, cb)
  local update = lib.callback.await('dusa_hud:updateSettings', false, data)
  TriggerEvent('table', data)
  cb("ok")
end)

RegisterNUICallback('getSettings', function(data, cb)
  local settings = lib.callback.await('dusa_hud:getSettings', false)
  cb(settings)
end)

RegisterNUICallback('togglePart', function(data, cb)
  dp('togglePart', data, json.encode(data))
  ToggleDoor(data.part)
  cb("ok")
end)

RegisterNUICallback('toggleNeon', function(data, cb)
  dp('toggleNeon', data, json.encode(data))
  ToggleNeon(data.neon)
  cb("ok")
end)

RegisterNUICallback('closeUI', function(data, cb)
  dp('close ui')
  cb("ok")
end)
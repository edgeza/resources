local retval = IsDuplicityVersion()

if retval then
    Callbacks = {}
    CallBackRegisterServer = function(name, cb)
        Debugprint("^3[INFO]^7: Registering server callback: "..name)
        Callbacks[name] = cb
    end

    RegisterNetEvent("gksphone:server:triggerServerCallback", function (name, cb, ...)
        local src = source
        if not cb.__cfx_functionReference then
            print("^6[GKSPHONE] ^1[ERROR]^7: Callback not found: "..name)
            return
        end
        Debugprint("^3[INFO]^7: Triggering server callback: "..name)
        if Callbacks[name] then
            local returnCb = function(...)
                local args = {...}
                local size = 8001
                local maxSafeSize = 8000
                local success, encoded = pcall(json.encode, args)
                if success then
                    size = #encoded
                end
                if size > maxSafeSize then
                    TriggerLatentClientEvent("gksphone:client:triggerServerCallback", src, 125000, cb.__cfx_functionReference, ...)
                else
                    TriggerClientEvent("gksphone:client:triggerServerCallback", src, cb.__cfx_functionReference, ...)
                end
            end
            local sucess, err = pcall(Callbacks[name], src, returnCb, ...)
            if not sucess then
                local stackTrace = Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString())
                print(("^1SCRIPT ERROR: Callback '%s' failed: %s^7\n%s"):format(name, err or "", stackTrace or ""))
            end
        else
            print("^6[GKSPHONE] ^1[ERROR]^7: Callback not found: "..name)
        end
    end)
else
    RegisterNetEvent("gksphone:client:triggerServerCallback", function (cb, ...)
        local pack = msgpack.pack({...})
        Citizen.InvokeFunctionReference(cb, pack)
    end)

    CallBackServerTrigger = function(name, cb, ...)
        TriggerServerEvent("gksphone:server:triggerServerCallback", name, cb, ...)
    end
end
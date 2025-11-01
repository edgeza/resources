-- ██╗░░░██╗██████╗░██╗░░░░░░█████╗░░█████╗░██████╗░
-- ██║░░░██║██╔══██╗██║░░░░░██╔══██╗██╔══██╗██╔══██╗
-- ██║░░░██║██████╔╝██║░░░░░██║░░██║███████║██║░░██║
-- ██║░░░██║██╔═══╝░██║░░░░░██║░░██║██╔══██║██║░░██║
-- ╚██████╔╝██║░░░░░███████╗╚█████╔╝██║░░██║██████╔╝
-- ░╚═════╝░╚═╝░░░░░╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░

-- Upload Service
--- @param -- discord / fivemanage / fivemerr
local uploadService = 'discord' -- discord / fivemanage / fivemerr

--- @param -- webhook / apikey
-- If you use fivemanage, you need to set your API key from here
-- If you use discord, you need to set your webhook from here
-- If you use fivemerr, you need to set your both API key and token from here
local serviceAPI = "https://discord.com/api/webhooks/1360610206358175947/FDSvhtv0pQ9dT_ZxmSWmyOhLlmjwy3gxO5iu0OurX7i-GuXnCmpKldu4gUPZkS3Xxzvo"
local fivemerrApiToken = ""

--------------------------------------------------------

if serviceAPI == "" or not serviceAPI then
    print("^1 [IMPORTANT] ^3Please set a service API for image uploading in the ^4dusa_evidence/imgApi.lua^0")
end

lib.callback.register(Bridge.Resource .. ':evidence:server:GetUploadUrl', function()
    print('Returning upload service and API', uploadService, serviceAPI)
    return uploadService, serviceAPI
end)

lib.callback.register(Bridge.Resource .. ':evidence:server:UploadToFivemerr', function(source)
    local src = source

    if uploadService == 'fivemerr' and fivemerrApiToken == '' then
        print("^1--- Fivemerr is enabled but no API token has been specified. ---^7")
        return nil
    end

    exports['screenshot-basic']:requestClientScreenshot(src, {
        encoding = 'png'
    }, function(err, data)
        if err then return nil end
        PerformHttpRequest(serviceAPI, function(status, response)
            if status ~= 200 then
                print("^1--- ERROR UPLOADING IMAGE: " .. status .. " ---^7")
                cb(nil)
            end

            return response
        end, "POST", json.encode({ data = data }), {
            ['Authorization'] = fivemerrApiToken,
            ['Content-Type'] = 'application/json'
        })
    end)
end)

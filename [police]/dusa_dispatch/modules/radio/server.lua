if not rawget(_G, "lib") then include('ox_lib', 'init') end


if not lib then return end


Radio         = {}
local radioChannels = {}

GlobalState.radioChannels = {}
function Radio.createChannel(channel)
    for i = 1, #radioChannels do
        if radioChannels[i].channelId == channel.channelId then
            return
        end
    end

    radioChannels[#radioChannels + 1] = channel
    GlobalState.radioChannels = radioChannels
    TriggerClientEvent('dusa_dispatch:UpdateRadioChannels', -1, GlobalState.radioChannels)
end
RegisterServerEvent('dusa_dispatch:createRadio', Radio.createChannel)

function Radio.removeChannel(freq)
    for i = 1, #radioChannels do
        if radioChannels[i].frequency == freq then
            table.remove(radioChannels, i)
            break
        end
    end
    GlobalState.radioChannels = radioChannels
    TriggerClientEvent('dusa_dispatch:UpdateRadioChannels', -1, GlobalState.radioChannels)
end
RegisterServerEvent('dusa_dispatch:removeRadio', Radio.removeChannel)

function Radio.UpdateChannel(channel)
    local src = source
    for i = 1, #radioChannels do
        if radioChannels[i].frequency == channel.channelId then
            radioChannels[i].users = channel.users
            GlobalState.radioChannels = radioChannels
            TriggerClientEvent('dusa_dispatch:UpdateRadioChannels', -1, GlobalState.radioChannels)
            break
        end
    end
end
RegisterServerEvent('dusa_dispatch:joinRadio', Radio.UpdateChannel)
RegisterServerEvent('dusa_dispatch:leaveRadio', Radio.UpdateChannel)

return Radio
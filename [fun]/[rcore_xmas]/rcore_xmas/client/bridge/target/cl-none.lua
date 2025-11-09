if isBridgeLoaded('Target', Target.NONE) then
    local zones = {}

    Citizen.CreateThread(function()
        log.debug('Target.NONE is loaded, starting zone check loop.')
        while true do
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            for id, zone in pairs(zones) do
                local zoneCoords = zone.coords
                if #(pedCoords - zoneCoords) < zone.options.radius and not zone.entered then
                    zones[id].entered = true
                    TriggerEvent('rcore_xmas:bridge:enterZone', id, zone)
                elseif #(pedCoords - zoneCoords) > zone.options.radius and zone.entered then
                    zones[id].entered = false
                    TriggerEvent('rcore_xmas:bridge:exitZone', id, zone)
                end
            end

            Citizen.Wait(250)
        end
    end)

    AddEventHandler('rcore_xmas:bridge:enterZone', function(id, zone)
        log.debug('Entered zone: %s', id)
        local interactEntity = zone.entity
        if zone.net then
            interactEntity = NetworkGetEntityFromNetworkId(zone.entity)
        end

        if not zone.options.canInteract(interactEntity) then
            log.debug('Player cannot interact with zone %s', id)
            return
        end

        while zones[id] ~= nil and zones[id].entered do
            if zone.options.helpText then
                Framework.showHelpNotification(zone.options.helpText)
            end

            local key = zone.options.key or 38
            if IsControlJustReleased(0, key) then
                log.debug('Calling onSelect on zone: %s', id)
                if zone.options.onSelect(zone.options) then
                    break
                end

                Citizen.Wait(1000)
            end

            Citizen.Wait(0)
        end
    end)

    AddEventHandler('rcore_xmas:bridge:exitZone', function(id, zone)
        log.debug('Exit zone: %s', id)
        zone.options.onExit(zone)
    end)

    function Target.addEntity(entityId, data, net)
        local entityCoords = GetEntityCoords(entityId)
        local id = string.format('entity_%s_%s', entityId, data.label or 'unknown')
        if data.onSelect == nil then
            data.onSelect = function(zone)
                log.debug('No onSelect function provided for zone: %s', id)
            end
        end

        if data.onExit == nil then
            data.onExit = function(zone)
                log.debug('No onExit function provided for zone: %s', id)
            end
        end

        data.canInteract = data.canInteract or function()
            return true
        end

        local zone = {
            entity = entityId,
            coords = data.coords or entityCoords,
            options = data,
            net = net or false,
        }

        zones[id] = zone
    end

    function Target.deleteEntity(entityId, net, data)
        log.debug('Deleting entity target zone %s', entityId)
        zones[string.format('entity_%s_%s', entityId, data.label)] = nil
    end
end

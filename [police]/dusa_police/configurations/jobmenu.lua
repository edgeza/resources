JobMenu = {
    {
        name = "LEO Interactions",
        icon = "fa-solid fa-traffic-light",
        submenu = {
            { -- fa-solid fa-people-arrows
                name = "Citizen Interactions",
                icon = "fa-solid fa-user-nurse",
                submenu = {
                    {
                        name = "Soft Cuff",
                        icon = "fa-solid fa-arrow-right",
                        event = "police:client:CuffPlayerSoft",
                    },
                    {
                        name = "Escort",
                        icon = "fa-solid fa-user-friends",
                        event = "police:client:EscortPlayer",
                    },
                    {
                        name = "Put in Vehicle",
                        icon = "fa-solid fa-car-side",
                        event = "police:client:PutPlayerInVehicle",
                    },
                    {
                        name = "Put out Vehicle",
                        icon = "fa-solid fa-car-side",
                        event = "police:client:SetPlayerOutVehicle",
                    },
                    {
                        name = "Search",
                        icon = "fa-solid fa-search",
                        event = "police:client:SearchPlayer",
                    },
                },
            },
            { -- fa-solid fa-people-arrows
                name = "Badge Interactions",
                icon = "fa-solid fa-id-badge",
                submenu = {
                    {
                        name = "Show Badge",
                        icon = "fa-solid fa-eye",
                        event = "police:client:ShowBadge",
                    },
                    {
                        name = "Edit Badge",
                        icon = "fa-solid fa-file-signature",
                        event = "police:client:EditBadge",
                    },
                },
            },
        },
    },
    {
        name = "Object Menu",
        icon = "fa-solid fa-bullseye",
        submenu = {
            {
                name = "Scenes",
                icon = "fa-solid fa-binoculars",
                event = "police_objects:client:viewAllScenes",
            },
            {
                name = "Create A Scene",
                icon = "fa-solid fa-plus",
                event = "police_objects:client:createNewScene",
            },
        },
    },
    {
        name = "Vehicle Interactions",
        icon = "fa-solid fa-car-side",
        submenu = {
            {
                name = "Lock Wheel",
                icon = "fa-solid fa-lock",
                event = "police:client:toggleWheelLock",
            },
            {
                name = "Unlock Door",
                icon = "fa-solid fa-lock",
                event = "police:client:UnlockDoor",
            },
            {
                name = "Track Device",
                icon = "fa-solid fa-map-marker",
                event = "police:client:PlaceGps",
            },
            {
                name = "Impound Vehicle",
                icon = "fa-solid fa-truck-pickup",
                event = "police:client:ImpoundVehicle",
            },
        }
    },
    {
        name = "Radar",
        icon = "fa-solid fa-satellite-dish",
        submenu = {
            {
                name = "Place Radar",
                icon = "fa-solid fa-map-pin",
                event = "police:client:createRadarZone",
            },
            {
                name = "Radar Menu",
                icon = "fa-solid fa-bars",
                event = "police:client:openRadarMenu",
            },
        }
    },
    {
        name = "MDT",
        icon = "fa-solid fa-tablet-button",
        event = "police:client:openMdt",
    },
}

local K9_Properties = {
    name = "K9 Menu",
    icon = "fa-solid fa-dog",
    submenu = {
        {
            name = "Summon",
            icon = "fa-solid fa-sun",
            event = "police:k9:summon",
        },
        {
            name = "Follow",
            icon = "fa-solid fa-lock",
            event = "police:k9:follow",
        },
        {
            name = "Attack",
            icon = "fa-solid fa-bone",
            event = "police:k9:attack",
        },
        {
            name = "Go To",
            icon = "fa-solid fa-map-marker",
            event = "police:k9:goto",
        },
        {
            name = "Get In",
            icon = "fa-solid fa-car",
            event = "police:k9:enterVehicle",
        },
        {
            name = "Search Vehicle",
            icon = "fa-solid fa-magnifying-glass",
            event = "police:k9:searchVehicle",
        },
        {
            name = "Emotes",
            icon = "fa-solid fa-face-smile",
            submenu = {
                {
                    name = "Sit",
                    icon = "fa-solid fa-chair",
                    event = "police:k9:sit",
                },
                {
                    name = "Bark",
                    icon = "fa-solid fa-bone",
                    event = "police:k9:bark",
                },
                {
                    name = "Paw",
                    icon = "fa-solid fa-paw",
                    event = "police:k9:paw",
                },
            }
        },
    }
}

function insertJobMenu()
    if Framework.Player.Job.Grade.Level >= Config.K9.MinGrade then
        -- Check if K9_Properties is already in the JobMenu
        local k9Found = false
        for _, menu in ipairs(JobMenu) do
            if menu.name == "K9 Menu" then
                k9Found = true
                break
            end
        end

        if k9Found then
            return
        end
        table.insert(JobMenu, K9_Properties)
    end
end

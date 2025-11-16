Config = {}

Config.Commands = {
    announcement = {
        command = "announcement", -- Command name
        description = "Announcement command", -- Command description
        duration = 10000, -- 10 seconds
        parameters = {
            {
                name = "message", -- Do not change this value
                type = "string",  -- Do not change this value
                description = "Message to announce", -- Parameter description
            },
        },
        permission = "group.admin", -- This command will only be visible to people with certain permissions
    },

    pm = {
        enabled = true,
        command = "pm", -- Command name
        description = "PM command", -- Command description
        customization = {
            label = "PM", -- Message list tag label
            color = "#f52281", -- Message list tag color
        },
        parameters = {
            {
                name = "target",   -- Do not change this value
                type = "playerId", -- Do not change this value
                description = "Target player id", -- Parameter description
            },
            {
                name = "message", -- Do not change this value
                type = "string",  -- Do not change this value
                description = "Message to send", -- Parameter description
            },
        },
    },

    adminchat = {
        enabled = true,
        useRoleplayName = false, -- If true, the roleplay name will be used instead of the real name (e.g. "John Doe" instead of "Lesimov")
        command = "ac", -- Command name
        description = "Admin chat command", -- Command description
        customization = {
            label = "ADMIN", -- Message list tag label
            color = "#f5d522", -- Message list tag color
        },
        parameters = {
            {
                name = "message", -- Do not change this value
                type = "string",  -- Do not change this value
                description = "Your message", -- Parameter description
            },
        },
        permission = "group.admin", -- This message will only be visible to people with certain permissions
    }
}

Config.JobChat = {
    enabled = true,
    command = "jc", -- Command name
    description = "Job chat command", -- Command description
    parameters = {
        {
            name = "message", -- Do not change this value
            type = "string",  -- Do not change this value
            description = "Your message", -- Parameter description
        },
    },
    jobs = {
        -- ## ADDING NEW JOBS FOR CHAT
        --[[ Steps:
            1. Add the job name to the jobs table
            2. Add the job label and color to the job table
            3. Add the restricted grade to the job table (OPTIONAL)
        ]]
        
        -- ## EXAMPLE
        --[[
            jobname = {
                enabled = true,
                label = "JOBNAME",
                color = "#3888ff",
                restrictedGrade = false, -- This message will only be visible to people with certain permissions
            },
        ]]

        police = {
            enabled = true,
            label = "POLICE",
            color = "#3888ff",
            restrictedGrade = 3, -- This message will only be visible to people with certain permissions
        },
        ambulance = {
            enabled = true,
            label = "AMBULANCE",
            color = "#f5222d",
            restrictedGrade = false, -- This message will only be visible to people with certain permissions
        },
    }
}

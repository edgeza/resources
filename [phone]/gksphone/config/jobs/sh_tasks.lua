GKSJobs = GKSJobs or {}
GKSJobs.JobTask = {
    ['sanitation'] = {
        {
            ["TaskId"] = 1,
            ["TaskText"] = "Get in the garbage truck",
            ["Finished"] = false
        },
        {
            ["TaskId"] = 2,
            ["TaskText"] = "Go to mission area",
            ["Finished"] = false
        },
        {
            ["TaskId"] = 3,
            ["TaskText"] = "Collect trash",
            ["Finished"] = false,
            ["ExtraDone"] = 0,
            ["ExtraNeed"] = 10
        },
        {
            ["TaskId"] = 4,
            ["TaskText"] = "Go to next mission area",
            ["Finished"] = false
        },
        {
            ["TaskId"] = 5,
            ["TaskText"] = "Collect trash",
            ["Finished"] = false,
            ["ExtraDone"] = 0,
            ["ExtraNeed"] = 10
        },
        {
            ["TaskId"] = 6,
            ["TaskText"] = "Deliver the garbage truck",
            ["Finished"] = false
        },
    },
    ['carthief'] = {
        {
            ["TaskId"] = 1,
            ["TaskText"] = "Find the car in the marked area %s",
            ["Finished"] = false
        },
        {
            ["TaskId"] = 2,
            ["TaskText"] = "Go to the marked location and leave the car",
            ["Finished"] = false
        }
    }
}
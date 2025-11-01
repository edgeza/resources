RegisterNUICallback('gksphone:client:getgametime', function(data, cb)
    local hours = GetClockHours()
    local minutes = GetClockMinutes()

    local day = GetClockDayOfMonth()
    local month = GetClockMonth()
    local week = GetClockDayOfWeek()

    local weekDate = {
        [0] = "Sunday",
        [1] = "Monday",
        [2] = "Tuesday",
        [3] = "Wednesday",
        [4] = "Thursday",
        [5] = "Friday",
        [6] = "Saturday"
    }
    local monthDate = {
        [0] = "January",
        [1] = "February",
        [2] = "March",
        [3] = "April",
        [4] = "May",
        [5] = "June",
        [6] = "July",
        [7] = "August",
        [8] = "September",
        [9] = "October",
        [10] = "November",
        [11] = "December"
    }
    local time = string.format("%02d:%02d", hours, minutes)
    local date = string.format("%s, %s %d", weekDate[week], monthDate[month], day)
    cb({time = time, date = date})
end)
compute <- function() {
    month_days <- c(31, 0, 31, 30, 31, 30, 31, 31, 30 , 31, 30, 31)
    day <- 2
    result <- 0
    for (year in 1901:2000) {
        month_days[2] <- 28 + ((year %% 4 == 0) & ((year %% 100 != 0) | (year %% 400 == 0)))
        for (month in 1:12) {
            day <- day + month_days[month] %% 7
            if (day %% 7 == 0) {
                result <- result + 1
            }
        }
    }
    return(result)
}

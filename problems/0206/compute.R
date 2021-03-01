source("euler/R/big_int.R")

compute <- function() {
    number <- as.bigint(138902663)
    j <- 3
    is.found <- FALSE
    while (!is.found) {
        if (j == 3) {
            number %-=% 6
            j <- 7
        } else {
            number %-=% 4
            j <- 3
        }
        for (i in 0:8) {
            if ((number * number)[i * 2 + 1] != i + 1) {
                is.found <- FALSE
                break
            } else {
                is.found <- TRUE
            }
        }
    }
    return(number * 10)
}

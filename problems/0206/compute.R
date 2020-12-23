source("euler/R/big_int.R")

compute <- function() {
    is.match <- function(n) {
        for (i in 0:8) {
            if (n[i * 2 + 1] != as.character(i + 1)) {
                return(FALSE)
            }
        }
        return(TRUE)
    }

    number <- as.bigint(138902663)
    j <- 3
    while (!is.match(number * number)) {
        if (j == 3) {
            number %-=% 6
            j <- 7
        } else {
            number %-=% 4
            j <- 3
        }
    }
    return(number * 10)
}

source("euler/R/calculus.R")

compute <- function() {
    pentagonals <- 1
    i <- 1
    j <- 1
    while (TRUE) {
        for (k in pentagonals) {
            if (is.pentagonal(pentagonals[i] - k) && is.pentagonal(abs(pentagonals[i] - 2 * k))) {
                return(abs(pentagonals[i] - 2 * k))
            }
        }
        j <- j + 3
        pentagonals <- c(pentagonals, pentagonals[i] + j)
        i <- i + 1
    }
}
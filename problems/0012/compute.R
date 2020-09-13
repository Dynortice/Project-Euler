source("euler/R/numbers.R")

compute <- function (n) {
    i <- 1
    triangle <- 1
    while (count_divisors(triangle) < n) {
        i <- i + 1
        triangle <- triangle + i
    }
    return(triangle)
}

library(microbenchmark)
source("../euler/R/numbers.R")

compute <- function(n) {
    result <- 0
    numbers <- c(0, 0)
    for (i in seq(10 ^ n %/% 11 * 11, 10 ^ (n - 1), -11)) {
        for (j in seq(10 ^ n - 1, 10 ^ (n - 1))) {
            candidate <- i * j
            if (candidate <= result) {
                break
            } else if (is.palindrome(as.character(candidate))) {
                result <- candidate
                numbers <- c(i, j)
            }
        }
    }
    return(list(result, numbers))
}

library(bit64)
source("euler/R/calculus.R")

compute <- function(n) {
    index <- fibonacci_index(n)
    fibonacci <- get_fibonacci(index, as.integer64)
    last_sum <- 0
    new_sum <- 0
    result <- sum(fibonacci[1:5]) - 1
    for (i in 6:(index + 1)) {
        temp <- new_sum + last_sum + fibonacci[i - 3]
        last_sum <- new_sum
        new_sum <- temp
        result <- result + new_sum + fibonacci[i]
    }
    return(result)
}

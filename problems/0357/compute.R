source("euler/R/primes.R")
options(scipen = 20)

compute <- function(n) {
    sieve <- prime_sieve(n)
    candidates <- which(sieve)
    candidates <- candidates[(candidates - 1) %% 4 != 0] - 1
    result <- 0
    for (candidate in candidates) {
        if (!sieve[candidate %/% 2 + 2]) next
        is.valid <- TRUE
        for (i in 3:as.integer(sqrt(n) + 1)) {
            if (candidate %% i != 0) {
                next
            } else if (!sieve[candidate %/% i + i]) {
                is.valid <- FALSE
                break
            }
        }
        if (is.valid) result <- result + candidate
    }
    return(result)
}

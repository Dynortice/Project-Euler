source("euler/R/primes.R")

compute <- function(n) {
    result <- 1
    for (prime in get_primes(sqrt(n))) {
        result <- result * prime
        if (result * prime > n) {
            return(result)
        }
    }
}

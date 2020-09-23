source("euler/R/primes.R")
source("euler/R/numbers.R")

compute <- function(n) {
    primes <- get_primes(n)[-(1:2)]
    max_cycle <- 0
    result <- 0
    for (prime in primes) {
        cycle <- multiplicative_order(10, prime)
        if (cycle > max_cycle) {
            max_cycle <- cycle
            result <- prime
        }
    }
    return(result)
}

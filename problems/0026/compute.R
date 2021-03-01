source("euler/R/primes.R")
source("euler/R/numbers.R")

compute <- function(n) {
    max_cycle <- 0; result <- 0
    for (prime in prime_numbers(n)[-(1:2)]) {
        cycle <- multiplicative_order(10, prime)
        if (cycle > max_cycle) {
            max_cycle <- cycle
            result <- prime
        }
    }
    return(result)
}

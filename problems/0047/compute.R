source("../../euler/R/primes.R")

compute <- function(n) {
    primes <- get_primes(10 ^ n %/% n)
    consecutive <- 0
    i <- 10 ^ (n - 1)
    while (TRUE) {
        if (!i %in% primes) {
            prime_factors <- 0
            t <- i
            for (prime in primes) {
                if (t %% prime == 0) {
                    prime_factors <- prime_factors + 1
                    t <- t / prime
                }
                if (any(prime > t, t == 1, prime_factors == n)) {
                    break
                }
            }
            if (prime_factors == n) {
                consecutive <- consecutive + 1
            } else {
                consecutive <- 0
            }
        } else {
            consecutive <- 0
        }
        if (consecutive == n) {
            return(i - n + 1)
        }
        i <- i + 1
    }
}
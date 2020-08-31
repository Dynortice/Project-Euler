source("../euler/R/primes.R")

compute <- function(n) {
    while (TRUE) {
        prime <- smallest_prime_factor(n)
        if (prime < n) {
            n = n / prime
        }
        else {
            return(n)
        }
    }
}
source("euler/R/primes.R")

compute <- function(n) {
    result <- 1
    for (prime in prime_numbers(sqrt(n))) {
        result <- result * prime
        if (result * prime > n) return(result)
    }
}

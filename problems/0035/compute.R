source("../../euler/R/primes.R")

compute <- function(n) {
    sieve <- get_primality(n)
    primes <- which(sieve)
    result <- 0
    for (prime in primes) {
        digits_prime <- as.integer(strsplit(as.character(prime), NULL)[[1]])
        is_circular_prime <- TRUE
        for (i in seq_len(length(digits_prime))) {
            digits_prime <- c(digits_prime[-1], digits_prime[1])
            if (!sieve[as.integer(paste0(digits_prime, collapse = ""))]) {
                is_circular_prime <- FALSE
                break
            }
        }
        if (is_circular_prime) {
            result <- result + 1
        }
    }
    return(result)
}
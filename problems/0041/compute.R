source("euler/R/primes.R")

compute <- function() {
    primes <- rev(get_primes(7654321))
    for (prime in primes) {
        digits_prime <- sort(unique(as.integer(strsplit(as.character(prime))[[1]])))
        if (all(digits_prime == seq_along(digits_prime))) {
            return(prime)
        }
    }
}
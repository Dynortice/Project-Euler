source("euler/R/primes.R")

compute <- function(n) {
    sieve <- prime_sieve(n)
    primes <- which(sieve)
    result <- 0
    for (prime in primes) {
        digits_prime <- intToUtf8(utf8ToInt(as.character(prime)), multiple = TRUE)
        result <- result + 1
        for (i in seq_along(digits_prime)) {
            digits_prime <- c(digits_prime[-1], digits_prime[1])
            if (!sieve[as.integer(paste0(digits_prime, collapse = ""))]) {
                result <- result - 1
                break
            }
        }
    }
    return(result)
}
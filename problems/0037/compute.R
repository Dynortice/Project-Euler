source("../../euler/R/primes.R")

compute <- function() {
    check_truncatable_prime <- function(n) {
        p <- 10
        while (p < n) {
            if (sieve[n %% p] & sieve[n %/% p]) {
                p <- p * 10
            } else {
                return(FALSE)
            }
        }
        return(TRUE)
    }
    sieve <- get_primality(1000000)
    primes <- which(sieve)[-(1:4)]
    truncatable_primes <- 0
    i <- 1
    result <- 0
    while (truncatable_primes < 11) {
        if (check_truncatable_prime(primes[i])) {
            truncatable_primes <- truncatable_primes + 1
            result <- result + primes[i]
        }
        i <- i + 1
    }
    return(result)
}
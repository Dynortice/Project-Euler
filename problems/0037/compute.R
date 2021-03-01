source("euler/R/primes.R")

compute <- function() {
    sieve <- prime_sieve(1000000)
    primes <- which(sieve)[-(1:4)]
    truncatable <- 0; result <- 0
    for (prime in primes) {
        p <- 10; is.trunctatable <- TRUE
        while (p < prime) {
            if (sieve[prime %% p] && sieve[prime %/% p]) {
                p <- p * 10
            } else {
                is.trunctatable <- FALSE
                break
            }
        }
        if (is.trunctatable) {
            truncatable <- truncatable + 1
            result <- result + prime
            if (truncatable == 11) break
        }
    }
    return(result)
}
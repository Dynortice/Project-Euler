source("euler/R/calculus.R")
source("euler/R/primes.R")

compute <- function() {
    sieve <- prime_sieve(6000)
    primes <- which(sieve)
    i <- 9
    while (TRUE) {
        if (!sieve[i]) {
            j <- 1
            is.not_expressible <- TRUE
            while (primes[j] < i) {
                if (is.square((i - primes[j]) / 2)) {
                    is.not_expressible <- FALSE
                    break
                }
                j <- j + 1
            }
            if (is.not_expressible) return(i)
        }
        i <- i + 2
    }
}

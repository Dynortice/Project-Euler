source("../../euler/R/primes.R")
source("../../euler/R/numbers.R")

compute <- function(n) {
    sieve <- get_primality(6000)
    primes <- which(sieve)
    i <- 9
    while (TRUE) {
        if (!sieve[i]) {
            j <- 1
            is.not_expressible <- TRUE
            while (primes[j] < i) {
                if (is.perfect_square((i - primes[j]) / 2)) {
                    is.not_expressible <- FALSE
                    break
                }
                j <- j + 1
            }
            if (is.not_expressible) {
                return(i)
            }
        }
        i <- i + 2
    }
}

source("euler/R/primes.R")

compute <- function(n) {
    sieve <- get_primality(n)
    primes <- which(sieve)
    max_sequence <- 0
    max_sequence_sum <- 0
    for (i in primes) {
        max_sequence_sum <- max_sequence_sum + i
        if (max_sequence_sum < n) {
            max_sequence <- max_sequence + 1
        } else {
            break
        }
    }
    for (i in max_sequence:0) {
        for (j in 1:(length(primes) - i + 1)) {
            sum_sequence <- sum(primes[j:(i + j)])
            if (sum_sequence > n) {
                break
            } else if (sieve[sum_sequence]) {
                return(sum_sequence)
            }
        }
    }
}

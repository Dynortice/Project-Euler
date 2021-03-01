source("euler/R/primes.R")
source("euler/R/numbers.R")

compute <- function() {
    n <- 28123
    primes <- prime_numbers(as.integer(sqrt(n)))
    abundant_sieve <- rep(FALSE, n); not_expressible <- rep(TRUE, n)
    result <- 0
    for (i in seq_len(n)) {
        abundant_sieve[i] <- (i < sum_proper_divisors(i, primes))
        for (j in seq_len(i %/% 2)) {
            if (abundant_sieve[j] && abundant_sieve[i - j]) {
                not_expressible[i] <- FALSE
                break
            }
        }
        if (not_expressible[i]) result <- result + i
    }
    return(result)
}
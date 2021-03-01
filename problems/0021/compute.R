source("euler/R/primes.R")
source("euler/R/numbers.R")

compute <- function(n) {
    sum_factors <- rep(0, n)
    primes <- prime_numbers(as.integer(sqrt(n)))
    result <- 0
    for (i in seq_len(n)) sum_factors[i] <- sum_proper_divisors(i, primes)
    for (i in 2:n) {
        j <- sum_factors[i]
        if (j != i && j <= n && sum_factors[j] == i) result <- result + i
    }
    return(result)
}

source("euler/R/primes.R")

compute <- function(n) {
    primes <- prime_numbers(10 ^ n %/% n)
    consecutive <- 0
    i <- 10 ^ (n - 1)
    while (TRUE) {
        if (any(primes == i)) {
            consecutive <- 0
        } else {
            divisors <- 0
            t <- i
            for (prime in primes) {
                if (t %% prime == 0) {
                    divisors <- divisors + 1
                    t <- t / prime
                }
                if (any(prime > t, t == 1, divisors == n)) {
                    break
                }
            }
            if (divisors == n) consecutive <- consecutive + 1 else consecutive <- 0
        }
        if (consecutive == n) return(i - n + 1)
        i <- i + 1
    }
}
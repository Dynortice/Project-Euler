library(bit64)
source("euler/R/primes.R")
source("euler/R/numbers.R")
options(scipen = 20)

compute <- function(n, m=1000000007) {
    result <- as.integer64(rep(1, n))
    for (prime in prime_numbers(n)) {
        p <- as.integer64(prime)
        past_super <- 0; last_super <- 0; new_super <- 0; last_hyper <- 0; new_hyper <- 0
        inv_mod <- invmod(p - 1, m)
        for (i in seq(prime, n, prime)) {
            number <- i; j <- 0
            while (number %% prime == 0) {
                j <- j + 1
                number <- number %/% prime
            }
            new_super <- last_super + j; new_hyper <- last_hyper + i * j
            last_super <- last_super + past_super; past_super <- last_super
            divisors <- ((powmod(p, last_hyper - last_super + 1, m) - 1) * inv_mod) %% m
            result[i - 1] <- (result[i - 1] * divisors) %% m
            last_super <- new_super; last_hyper <- new_hyper
        }
        divisors <- ((powmod(p, new_hyper - new_super - past_super + 1, m) - 1) * inv_mod) %% m
        result[n] <- (result[n] * divisors) %% m
    }
    return(sum(result) %% m)
}

source("euler/R/primes.R")
source("euler/R/numbers.R")
options(scipen = 20)

compute <- function(n, modulo=1000000007) {
    primes <- get_primes(n)
    result <- as.integer64(rep(1, n))
    for (prime in primes) {
        past_super <- 0
        last_super <- 0
        new_super <- 0
        last_hyper <- 0
        new_hyper <- 0
        inverse_modulo <- invmod(prime - 1, modulo)
        for (i in prime:n) {
            number <- i
            j <- 0
            while (number %% prime == 0) {
                j <- j + 1
                number <- number %/% prime
            }
            new_super <- last_super + j
            new_hyper <- last_hyper + i * j
            last_super <- last_super + past_super
            past_super <- last_super
            result[i - 1] <- (result[i - 1] * (powmod(prime, last_hyper - last_super + 1, modulo) - 1)) %% modulo
            result[i - 1] <- (result[i - 1] * inverse_modulo) %% modulo
            last_super <- new_super
            last_hyper <- new_hyper
        }
        result[n] <- (result[n] * (powmod(prime, new_hyper - new_super - past_super + 1, modulo) - 1)) %% modulo
        result[n] <- (result[n] * inverse_modulo) %% modulo
    }
    return(sum(result) %% modulo)
}

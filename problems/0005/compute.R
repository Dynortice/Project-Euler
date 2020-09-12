source("euler/R/primes.R")

compute <- function(n) {
    primes <- get_primes(n)
    return(prod(primes ^ as.integer(log(n, primes))))
}

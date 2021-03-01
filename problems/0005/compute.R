source("euler/R/primes.R")

compute <- function(n) {
    primes <- prime_numbers(n)
    return(prod(primes ^ as.integer(log(n, primes))))
}

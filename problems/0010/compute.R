source("euler/R/primes.R")

compute <- function(n) {
    return(sum(get_primes(n)))
}

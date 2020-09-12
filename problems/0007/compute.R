source("euler/R/primes.R")

compute <- function(n) {
    return(get_primes(n * 20)[n])
}
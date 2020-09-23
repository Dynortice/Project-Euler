source("euler/R/primes.R")

compute <- function(n) {
    sieve <- get_primes(10000)
    primes <- which(sieve)
    for (prime in primes[primes > 4817]) {
        first <- prime - 3330
        third <- prime + 3330
        if (all(sieve[first], sieve[third],
                 all(sort(unique(strsplit(as.character(first), NULL)[[1]])) == sort(unique(strsplit(as.character(prime), NULL)[[1]]))),
                all(sort(unique(strsplit(as.character(prime), NULL)[[1]])) == sort(unique(strsplit(as.character(third), NULL)[[1]]))))) {
            return(paste0(first, prime, third))
        }
    }
}

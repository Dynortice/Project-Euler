source("euler/R/primes.R")

compute <- function() {
    sieve <- prime_sieve(10000)
    primes <- which(sieve)
    for (prime in primes[primes > 4817]) {
        first <- prime - 3330; third <- prime + 3330
        if (sieve[first] && sieve[third] &&
            all(sort(unique(utf8ToInt(as.character(prime)))) == sort(unique(utf8ToInt(as.character(first))))) &&
            all(sort(unique(utf8ToInt(as.character(prime)))) == sort(unique(utf8ToInt(as.character(third)))))) {
            return(paste0(first, prime, third))
        }
    }
}

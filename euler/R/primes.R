#' Get the sieve of primes below n
#' 
#' @param n integer number
#' @return boolean vector with length n where index is number and boolean values is whether prime or not

get_primality <- function(n) {
    sieve <- rep(TRUE, n)
    sieve[1] <- FALSE
    if (n < 4) {
        return(sieve)
    }
    for (i in seq(4, n, 2)) {
        sieve[i] <- FALSE
    }
    if (n >= 9) {
        for (i in seq(3, as.integer(sqrt(n)), 2)) {
            if (sieve[i]) {
                for (j in seq(i * i, n, 2 * i)) {
                    sieve[j] <- FALSE
                }
            }
        }
    }
    return(sieve)
}

#' Get vector of primes below n
#' 
#' @param n integer number
#' @return vector with primes below n

get_primes <- function(n) {
    return(which(get_primality(n)))
}

#' Get smallest prime factor of number
#' 
#' @param n integer number
#' @return smallest prime factor of n

smallest_prime_factor <- function(n) {
    primes <- get_primes(as.integer(sqrt(n)))
    for (prime in primes) {
        if (n %% prime == 0) {
            return(prime)
        }
    }
    return(n)
}
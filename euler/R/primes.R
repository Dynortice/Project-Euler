#' Get the sieve of primes below n
#' 
#' @param n Index of last prime in vector
#' @returns Boolean vector with length n where index is number and boolean values is whether prime or not
#' @examples
#' prime_sieve(10)
prime_sieve <- function(n) {
    sieve <- rep(TRUE, n)
    sieve[1] <- FALSE
    if (n < 4) return(sieve)
    sieve[seq(4, n, 2)] <- FALSE
    if (n >= 9) for (i in seq(3, as.integer(sqrt(n)), 2)) if (sieve[i]) sieve[seq(i * i, n, 2 * i)] <- FALSE
    return(sieve)
}

#' Get primes below n
#' 
#' @param n Number below of which prime numbers will generate
#' @returns Vector with prime numbers
#' @examples
#' prime_numbers(20)
prime_numbers <- function(n) which(prime_sieve(n))

#' Check if number is prime
#'
#' @param n Number
#' @returns TRUE if number is prime, FALSE otherwise
#' @examples
#' is.prime(23)
#' is.prime(22)
is.prime <- function(n) {
    if (n < 2) {
        return(FALSE)
    } else if (n < 4) {
        return(TRUE)
    } else if (n %% 2 == 0 | n %% 3 == 0) {
        return(FALSE)
    } else if (n < 25) {
        return(TRUE)
    }
    for (i in seq(6, as.integer(sqrt(n)) + 1, 6)) if (n %% (i - 1) == 0 || n %% (i + 1) == 0) return(FALSE)
    return(TRUE)
}

#' Get smallest prime factor of number
#' 
#' @param n Number
#' @param primes Vector of primes below at least sqrt(n)
#' @returns Smallest prime number which proper divides n
#' @examples
#' smallest_prime_factor(23)
#' n <- 22
#' primes <- prime_numbers(as.integer(sqrt(n)))
#' smallest_prime_factor(n, primes)
smallest_prime_factor <- function(n, primes = prime_numbers(as.integer(sqrt(n)))) {
    for (prime in primes) if (n %% prime == 0) return(prime)
    return(n)
}

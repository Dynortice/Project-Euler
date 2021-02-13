library(bit64)
source("euler/R/calculus.R")

#' Checking is the number a palindrome
#'
#' @param n integer number converted to string
#' @return boolean value: true if n is palindrome else false

is.palindrome <- function(n) {
    if (inherits(n, 'BigInt')) {
        n <- n$str
    } else {
        n <- as.character(n)
    }
    return(n == intToUtf8(rev(utf8ToInt(n))))
}

#' Counting number of divisors of n
#'
#' @param n integer number
#' @return number of divisors of n

count_divisors <- function(n) {
    factors <- 1
    i <- 2
    while (i * i < n) {
        f <- 1
        while (n %% i == 0) {
            n <- n / i
            f <- f + 1
        }
        i <- i + 1
        factors <- factors * f
    }
    if (n > 1) {
        factors <- factors * 2
    }
    return(factors)
}

#' Get sum of proper divisors of number
#'
#' @param n integer number
#' @param primes list of primes numbers (until sqrt(n) as minimum)
#' @return sum of proper divisors
sum_proper_factors <- function(n, primes) {
    result <- 1
    number <- n
    for (prime in primes) {
        j <- 1
        while (number %% prime == 0) {
            number <- number / prime
            j <- j + 1
        }
        result <- result * sum_geometric_series(1, prime, j)
    }
    if (number > 1) {
        result <- result * (number + 1)
    }
    return(result - n)
}

#' Get multiplicative order of a modulo n
#' @param a integer number
#' @param n integer number
#' @return order of a in the multiplicative group of the units in the ring of the integers modulo n

multiplicative_order <- function(a, n) {
    i <- 1
    k <- a
    while ((k != 1) & (i < n)) {
        k <- k * a %% n
        i <- i + 1
    }
    return(i)
}

is.perfect_square <- function(n) {
    return(as.integer(sqrt(n)) ^ 2 == n)
}

digits_sum <- function(n) {
    return(sum(as.integer(strsplit(as.character(n), NULL)[[1]])))
}

powmod <- function(n, k, modulo) {
    n <- as.integer64(n)
    result <- 1
    while (k > 0) {
        if (k %% 2 == 1) {
            result <- (result * n) %% modulo
        }
        n <- (n * n) %% modulo
        k <- k %/% 2
    }
    return(result)
}

egcd <- function(x, modulo) {
    a <- 0
    last <- 1
    while (modulo > 0) {
        quotient <- x %/% modulo
        temp <- x %% modulo
        x <- modulo
        modulo <- temp
        temp <- last - quotient * a
        last <- a
        a <- temp
    }
    return(last)
}

invmod <- function(x, modulo) {
    return(egcd(x, modulo) %% modulo)
}
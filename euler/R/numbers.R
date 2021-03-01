source("euler/R/calculus.R")
source("euler/R/primes.R")

#' Check if number is palindrome
#'
#' @param n Number
#' @returns True if number is palindrome, False otherwise
#' @examples
#' is.palindrome(123321)
#' is.palindrome(123456)
#' is.palindrome(as.bigint(123321))
#' is.palindrome(as.bigint(123456))
is.palindrome <- function(n) {
    if (inherits(n, 'BigInt')) n <- n$str else n <- as.character(n)
    n <- utf8ToInt(n)
    return(all(n == rev(n)))
}

#' Counting number of divisors of n
#'
#' @param n Number
#' @returns Number of divisors of n
#' @examples
#' count_divisors(23)
#' count_divisors(284)
count_divisors <- function(n) {
    divisors <- 1
    i <- 2
    while (i * i < n) {
        f <- 1
        while (n %% i == 0) {
            n <- n / i
            f <- f + 1
        }
        i <- i + 1
        divisors <- divisors * f
    }
    if (n > 1) divisors <- divisors * 2
    return(divisors)
}

#' Get sum of proper divisors of n
#'
#' @param n Number
#' @param primes Vector of prime numbers below at least sqrt(n)
#' @returns Sum of proper divisors of n (except n)
#' @examples
#' sum_proper_divisors(23)
#' sum_proper_divisors(284, prime_numbers(as.integer(sqrt(284))))
sum_proper_divisors <- function(n, primes = prime_numbers(as.integer(sqrt(n)))) {
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
    if (number > 1) result <- result * (number + 1)
    return(result - n)
}

#' Get digits of number
#'
#' @param n: Number
#' @returns Digits of number
#' @examples
#' get_digits(123)
get_digits <- function(n) as.integer(intToUtf8(utf8ToInt(as.character(n)), TRUE))

#' Get vector of digits in number
#'
#' @param n: Number
#' @returns Sum of digits in number
#' @examples
#' digits_sum(123)
digits_sum <- function(n) sum(get_digits(n))

#' Get multiplicative order of n modulo m
#' @param n Number
#' @param m Number
#' @returns Order of n in the multiplicative group of the units in the ring of the integers modulo m
#' @examples
#' multiplicative_order(16, 7)
multiplicative_order <- function(n, m) {
    i <- 1
    k <- n
    while (k != 1 && i < m) {
        k <- (k * n) %% m
        i <- i + 1
    }
    return(i)
}

#' Get greater common divisor (GCD) of two numbers
#'
#' @param a: Number
#' @param b: Number
#' @returns GCD of a and b
#' @examples
#' gcd(16, 28)
gcd <- function(a, b) if (b) gcd(b, a %% b) else a

#' Get power n^k mod m
#'
#' @param n: Base
#' @param k: Power
#' @param m: Modulus
#' @returns Remainder of division n^k by m
#' @examples
#' powmod(2, 10, 5)
powmod <- function(n, k, m) {
    if (m == 1) return(0)
    result <- 1
    n <- n %% m
    while (k > 0) {
        if (k %% 2 == 1) result <- (result * n) %% m
        n <- (n * n) %% m
        k <- k %/% 2
    }
    return(result)
}

#' Get modular inverse of n mod m
#'
#' @param n: Number
#' @param m: Modulus
#' @returns Modular multiplicative inverse of n and m
#' @examples
#' invmod(8, 23)
invmod <- function(n, m) {
    a <- 0; b <- 1; c <- m
    while (n != 0) {
        quotient <- c %/% n
        temp_b <- b; b <- a - quotient * b; a <- temp_b
        temp_n <- n; n <- c - quotient * n; c <- temp_n
    }
    if (c > 1) stop("n and m aren't coprime")
    if (a < 0) a <- a + m
    return(a)
}

#' Check if number is S-number, that is a perfect square and its square root can be obtained by splitting the decimal
#' representation of n into 2 or more numbers then adding the numbers.
#'
#' @param a: Number
#' @param b: Square of a
#' @examples
#' is_s_number(99, 9801)
#' is_s_number(5, 25)
is.s_number <- function(a, b) {
    if (a > b) return(FALSE) else if (a == b) return(TRUE)
    m <- 10
    while (m < b) {
        quotient <- b %/% m; remainder <- b %% m
        if (remainder < a && is.s_number(a - remainder, quotient)) return(TRUE)
        m <- m * 10
    }
    return(FALSE)
}
source("euler/R/big_int.R")

#' Get sum of first n terms of arithmetic series
#' 
#' @param a First number in series
#' @param b Common difference of series
#' @param n Number of terms in series
#' @examples
#' sum_arithmetic_series(1, 2, 3)
#' sum_arithmetic_series(0.5, 0.75, 3)
sum_arithmetic_series <- function(a, d, n) (n * (2 * a + d * (n - 1)) / 2)

#' Get sum of n first terms of geometric series
#'
#' @param a First number in series
#' @param b Common ratio of series
#' @param n Number of terms in series
#' @examples
#' sum_geometric_series(1, 2, 3)
#' sum_geometric_series(0.5, 0.75, 3)
sum_geometric_series <- function(a, r, n) a * (r ^ n - 1) / (r - 1)

#' Generate n first Fibonacci numbers \link[OEIS A000045]{https://oeis.org/A000045}
#'
#' @param n Number of Fibonacci numbers
#' @param t Function to convert numbers
#' @examples
#' fibonacci_numbers(10)
#' fibonacci_numbers(10, as.integer)
fibonacci_numbers <- function(n, t = as.bigint) {
    f_prev <- t(1)
    f_curr <- t(1)
    result <- c(f_prev, f_curr)
    for (i in seq_len(n - 2)) {
        f_temp <- f_prev + f_curr
        f_prev <- f_curr
        f_curr <- f_temp
        result <- c(result, f_curr)
    }
    return(result)
}

#' Get n-th Fibonacci number
#'
#' @param n Index of Fibonacci number
#' @examples
#' get_fibonacci(10)
get_fibonacci <- function(n) ((1 + sqrt(5)) / 2) ^ n / sqrt(5) + 0.5

#' Get index of n in Fibonacci sequence
#'
#' @returns Index of Fibonacci number n. If n isn't Fibonacci number, returns index of closest Fibonacci number below n
#' @examples
#' fibonacci_index(55)
#' fibonacci_index(54)
fibonacci_index <- function(n) as.integer(log(n * sqrt(5) + 0.5, (sqrt(5) + 1) / 2))

#' Get length of Collatz chain
#'
#' @param n Starting number
#' @examples
#' collatz_chain <- len_collatz_chain()
#' collatz_chain(13)
len_collatz_chain <- function() {
    hashmap <- 1
    memoize <- function(n) {
        if (is.na(hashmap[n])) {
            if (n %% 2 == 0) hashmap[n] <<- 2 + memoize((3 * n + 1) / 2) else hashmap[n] <<- 1 + memoize(n / 2)
        }
        return(hashmap[n])
    }
    return(memoize)
}

#' Generate n first numbers in triangular numbers sequence \link[OEIS A000217]{https://oeis.org/A000217}
#'
#' @param n Number of triangular numbers
#' @examples
#' triangular_numbers(10)
triangular_numbers <- function(n) {
    result <- 1
    for (i in 2:n) result[i] <- result[i - 1] + i
    return(result)
}

#' Get n-th triangular number
#'
#' @param n Index of triangular number
#' @examples
#' get_triangular(10)
get_triangular <- function(n) n * (n + 1) / 2

#' Get index of n in triangular sequence
#'
#' @returns Index of triangular number n. If n isn't triangular number, returns index of closest triangular number below n
#' @examples
#' triangular_index(55)
#' triangular_index(54)
triangular_index <- function(n) (sqrt(8 * n + 1) - 1) %/% 2

#' Check if number is triangular
#'
#' @returns TRUE if number is triangular, FALSE otherwise
#' @examples
#' is.triangular(55)
#' is.triangular(54)
is.triangular <- function(n) sqrt(8 * n + 1) %% 2 == 1

#' Generate n first numbers in square numbers sequence \link[OEIS A000290]{https://oeis.org/A000290}
#'
#' @param n Number of square numbers
#' @examples
#' square_numbers(10)
square_numbers <- function(n) (1:n) ^ 2

#' Get n-th square number
#'
#' @param n Index of square number
#' @examples
#' get_square(10)
get_square <- function(n) n * n

#' Get index of n in square sequence
#'
#' @returns Index of square number n. If n isn't square number, returns index of closest square number below n
#' @examples
#' square_index(100)
#' square_index(99)
square_index <- function(n) as.integer(sqrt(n))

#' Check if number is square
#'
#' @returns TRUE if number is square, FALSE otherwise
#' @examples
#' is.square(100)
#' is.square(99)
is.square <- function(n) sqrt(n) %% 1 == 0

#' Generate n first numbers in pentagonal numbers sequence \link[OEIS A000326]{https://oeis.org/A000326}
#'
#' @param n Number of pentagonal numbers
#' @examples
#' pentagonal_numbers(10)
pentagonal_numbers <- function(n) {
    result <- 1
    for (i in seq(4, 3 * n, 3)) result <- c(result, tail(result, 1) + i)
    return(result)
}

#' Get n-th pentagonal number
#'
#' @param n Index of pentagonal number
#' @examples
#' get_pentagonal(10)
get_pentagonal <- function(n) n * (3 * n - 1) / 2

#' Get index of n in pentagonal sequence
#'
#' @returns Index of pentagonal number n. If n isn't pentagonal number, returns index of closest pentagonal number below n
#' @examples
#' pentagonal_index(145)
#' pentagonal_index(144)
pentagonal_index <- function(n) (sqrt(24 * n + 1) + 1) %/% 6

#' Check if number is pentagonal
#'
#' @returns TRUE if number is pentagonal, FALSE otherwise
#' @examples
#' is.pentagonal(145)
#' is.pentagonal(144)
is.pentagonal <- function(n) sqrt(24 * n + 1) %% 6 == 5

#' Generate n first numbers in hexagonal numbers sequence \link[OEIS A000384]{https://oeis.org/A000384}
#'
#' @param n Number of hexagonal numbers
#' @examples
#' hexagonal_numbers(10)
hexagonal_numbers <- function(n) {
    result <- 1
    for (i in seq(5, 4 * n, 4)) result <- c(result, tail(result, 1) + i)
    return(result)
}

#' Get n-th hexagonal number
#'
#' @param n Index of hexagonal number
#' @examples
#' get_hexagonal(10)
get_hexagonal <- function(n) n * (2 * n - 1)

#' Get index of n in hexagonal sequence
#'
#' @returns Index of hexagonal number n. If n isn't hexagonal number, returns index of closest hexagonal number below n
#' @examples
#' hexagonal_index(190)
#' hexagonal_index(189)
hexagonal_index <- function(n) (sqrt(8 * n + 1) + 1) %/% 4

#' Check if number is hexagonal
#'
#' @returns TRUE if number is hexagonal, FALSE otherwise
#' @examples
#' is.hexagonal(145)
#' is.hexagonal(144)
is.hexagonal <- function(n) sqrt(8 * n + 1) %% 4 == 3

#' Get number of digits formed by n-digit numbers in Champernowne constant
#'
#' @examples
#' champernowne_digits(3)
champernowne_digits <- function(n) (10 ^ n * (9 * n - 1) + 1) / 9
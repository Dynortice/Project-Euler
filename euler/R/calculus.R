#' Find the sum of arithmetic sequence
#' 
#' @param a first number in sequence
#' @param b common difference of sequence
#' @param n number of terms in sequence
#' @return sum of n first terms in arithmetic sequence

sum_arithmetic_series <- function(a, d, n) {
  return(n * (2 * a + d * (n - 1)) / 2)
}

#' Find the sum of geometric sequence
#'
#' @param a first number in sequence
#' @param b common ratio of sequence
#' @param n number of terms in sequence
#' @return sum of n first terms in geometric sequence

sum_geometric_series <- function(a, r, n) {
  return(a * (r ^ n - 1) / (r - 1))
}

#' Get nth Fibonacci number
#' 
#' @param n index of Fibonacci number
#' @return Fibonacci number with index n

fibonacci_number <- function(n) {
    return((((1 + sqrt(5)) / 2) ^ n - ((1 - sqrt(5)) / 2) ^ n) / sqrt(5))
}

#' Get index of closest Fibonacci number
#' 
#' @param n integer number
#' @return index of closest Fibonacci number below n

fibonacci_index <- function(n) {
    return(as.integer(log(n * sqrt(5) + 0.5, (sqrt(5) + 1) / 2)))
}

#' Get length of Collatz chain
#'
#' @param n starting number
#' @param hashmap vector with Collatz chains lengths
#' @return hashmap of Collatz chains

len_collatz_chain <- function(n, hashmap) {
    chain <- 1
    while(n > 1) {
        if (!is.na(hashmap[n])) {
            return(chain + hashmap[n])
        }
        if (n %% 2 == 0) {
            chain <- chain + 1
            n <- n / 2
        } else {
            chain <- chain + 2
            n <- (3 * n + 1) / 2
        }
    }
    return(chain)
}

#' Get greatest common divisor
#'
#' @param a first term
#' @param b second term
#' @return greatest common divisor

gcd <- function(a, b) {
    if (b > 0) {
        return(gcd(b, a %% b))
    } else {
        return(a)
    }
}
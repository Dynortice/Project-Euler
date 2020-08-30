#' Find the sum of arithmetic sequence
#' 
#' @param a first number in sequence
#' @param b common difference of series
#' @param n number of terms in sequence
#' @return sum of n first terms in arithmetic sequence

sum_arithmetic_series <- function(a, d, n) {
  return(n * (2 * a + d * (n - 1)) / 2)
}

#' Find the sum of arithmetic sequence
#' 
#' @param n index of Fibonacci number
#' @return Fibonacci number with index n

fibonacci_number <- function(n) {
    return((((1 + sqrt(5)) / 2) ^ n - ((1 - sqrt(5)) / 2) ^ n) / sqrt(5))
}

#' Find the sum of arithmetic sequence
#' 
#' @param n integer number
#' @return index of closest Fibonacci number below n

fibonacci_index <- function(n) {
    return(as.integer(log(n * sqrt(5) + 0.5, (sqrt(5) + 1) / 2)))
}
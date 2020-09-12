#' Digits of number
#'
#' @param n number as string
#' @return vector of digits of argument

number_to_digits <- function(n) {
    return(as.integer(strsplit(n, NULL)[[1]]))
}

#' Vector of digits to number
#'
#' @param n vector of digits
#' @return number as string

digits_to_number <- function(n) {
    return(paste0(n, collapse = ""))
}

#' Checking is the number a palindrome
#' 
#' @param n integer number converted to string
#' @return boolean value: true if n is palindrome else false

is.palindrome <- function(n) {
    return(n == digits_to_number(rev(number_to_digits(n))))
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

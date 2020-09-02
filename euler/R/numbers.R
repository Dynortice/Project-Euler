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

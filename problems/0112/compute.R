source("euler/R/numbers.R")
options(scipen = 20)

compute <- function(n) {
    bouncy <- 0
    i <- 1
    while (bouncy / i < n) {
        i <- i + 1
        digits <- get_digits(i)
        sorted_digits <- sort(digits)
        if (!(all(digits == sorted_digits) || all(digits == rev(sorted_digits)))) bouncy <- bouncy + 1
    }
    return(i)
}

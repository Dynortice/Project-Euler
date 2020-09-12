source("euler/R/calculus.R")

compute <- function(n) {
    return(as.integer(fibonacci_number(fibonacci_index(n) + 2) / 2))
}
source("euler/R/calculus.R")

compute <- function(n) {
    n <- get_hexagonal(144)
    i <- n - 40755
    while (TRUE) {
        if (is.pentagonal(n)) {
            return(n)
        }
        i <- i + 4
        n <- n + i
    }
}

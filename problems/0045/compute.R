source("euler/R/calculus.R")

compute <- function(n) {
    i <- hexagonal_index(n) + 1
    while (((sqrt(48 * i ^ 2 - 24 * i + 1) + 1) / 6) %% 1 != 0) i <- i + 1
    return(get_hexagonal(i))
}

source("euler/R/big_int.R")
source("euler/R/calculus.R")
source("euler/R/numbers.R")

compute <- function(n, m) {
    inverted_modulo <- invmod(2, m)
    result <- as.bigint(0)
    for (f in fibonacci_numbers(n)) {
        a <- f %% 9 + 2; b <- f %/% 9
        result %+=% (((a * (a - 1) + 10) * pow(as.bigint(10), b, m) - (a + b * 9 + 4) * 2) * inverted_modulo) %% m
    }
    return(result %% m - 1)
}

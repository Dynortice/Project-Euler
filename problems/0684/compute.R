source("euler/R/big_int.R")
source("euler/R/calculus.R")

compute <- function(n, modulo) {
    s_mod <- function(k) {
        a <- k %% 9 + 2
        b <- k %/% 9
        return((((a * (a - 1) + 10) * pow(as.bigint(10), b, modulo) - (a + b * 9 + 4) * 2) * inverted_modulo) %% modulo)
    }
    inverted_modulo <- 500000004
    return((sum.bigint(lapply(get_fibonacci(n), s_mod)) - 1) %% modulo)
}

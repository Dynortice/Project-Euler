source("euler/R/math.R")

compute <- function(n) {
    is.prime_fast <- function(x) {
        if (x < 14) return(TRUE)
        if (!(x %% 6 == 1 || x %% 6 == 5)) return(FALSE)
        for (i in seq(6, fast_max(as.integer(sqrt(x)), 6), 12)) {
            if (x %% (i - 1) == 0 || x %% (i + 1) == 0 || x %% (i + 7) == 0) return(FALSE)
        }
        return(TRUE)
    }
    j <- 3; primes <- 0
    while (TRUE) {
        k <- (j - 3) * j + 3
        primes <- primes + is.prime_fast(k) + is.prime_fast(k + j - 1) + is.prime_fast(k + 2 * j - 2)
        if (primes / (2 * j - 1) < n) return(j)
        j <- j + 2
    }
}

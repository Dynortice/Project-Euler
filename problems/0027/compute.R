source("euler/R/primes.R")

compute <- function(max_a, max_b) {
    prime <- get_primality(max_a * max_b)
    primes <- which(prime[1:max_b])
    primes <- c(primes, -primes)
    max_sequence <- 0
    result <- 0
    for (a in seq(-max_a + ifelse(max_a %% 2 == 0, 1, 2), max_a - 1, 2)) {
        for (b in primes) {
            n <- 0
            while (TRUE) {
                candidate <- abs(n * (n + a) + b)
                if (candidate != 0){
                    if (!prime[candidate]) {
                        break
                    }
                }
                n <- n + 1
            }
            if (n > max_sequence) {
                max_sequence <- n
                result <- a * b
            }
        }
    }
    return(result)
}

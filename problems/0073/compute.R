compute <- function(n) {
    sieve <- rep(0, n)
    for (i in 2:n) {
        sieve[i] <- sieve[i] + i - 1 - i %/% 2 - i %/% 3
        j <- 2 * i
        while (j <= n) {
            sieve[j] <- sieve[j] - sieve[i]
            j <- j + i
        }
    }
    return(sum(sieve))
}

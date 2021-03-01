compute <- function(n) {
    limit_powers <- as.integer(log2(n)); limit_numbers <- as.integer(sqrt(n))
    power_counts <- rep(0, limit_powers)
    for (i in 2:limit_numbers) {
        p <- as.integer(log(n, i))
        power_counts[p] <- power_counts[p] + 1
        j <- i * i
        while (j < limit_numbers) {
            ix <- as.integer(log(n, j))
            power_counts[ix] <- power_counts[ix] - 1
            j <- j * i
        }
        sieve <- rep(FALSE, limit_powers * n)
        duplicate_counts <- rep(0, limit_powers)
        count <- 0
        for (i in seq_len(limit_powers)) {
            for (j in 2:n) if (sieve[i * j])  count <- count + 1 else sieve[i * j] <- TRUE
            duplicate_counts[i] <- count
        }
    }
    return((n - 1) ^ 2 - sum(power_counts * duplicate_counts))
}

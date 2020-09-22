compute <- function(n_max, limit) {
    comb_approx <- function(n, k) {
        return(n ^ (n + 0.5) / sqrt(2 * pi) / k ^ (k + 0.5) / (n - k) ^ (n - k + 0.5))
    }

    result <- 0
    for (i in seq_len(n_max)) {
        for (j in seq_len(i %/% 2)) {
            if (comb_approx(i, j) > limit) {
                result <- result + i - 2 * j + 1
                break
            }
        }
    }
    return(result)
}

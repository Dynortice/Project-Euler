compute <- function(n) {
    combinations <- c(1, rep(0, n))
    for (i in seq_len(n)) for (j in (i + 1):(n + 1)) combinations[j] <- combinations[j] + combinations[j - i]
    return(combinations[n + 1] - 1)
}

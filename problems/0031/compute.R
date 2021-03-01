compute <- function(coins, n) {
    combinations <- c(1, rep(0, n))
    for (i in seq_along(coins)) {
        for (j in (coins[i] + 1):(n + 1)) combinations[j] <- combinations[j] + combinations[j - coins[i]]
    }
    return(tail(combinations, 1))
}

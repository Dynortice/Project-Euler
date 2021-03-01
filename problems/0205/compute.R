source("euler/R/game.R")
source("euler/R/math.R")

compute <- function(a, b) {
    limit <- fast_max(a[1] * a[2], b[1] * b[2])
    looses <- rep(0, limit)
    result <- 0
    for (i in b[1]:(b[1] * b[2])) looses[i] <- dice_combinations(i, b[1], b[2]) + looses[i - 1]
    for (i in a[1]:(a[1] * a[2])) result <- result + dice_combinations(i, a[1], a[2]) * looses[i - 1]
    return(round(result / a[2] ^ a[1] / b[2] ^ b[1], 7))
}

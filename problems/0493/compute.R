compute <- function(n, k) {
    result <- 1
    numerators <- (n / 7 * 6 - k):(n - k)
    denominators <- (n / 7 * 6):n
    for (i in length(numerators)) {
        result <- result * numerators[i] / denominators[i]
    }
    return(round(7 * (1 - result), 9))
}

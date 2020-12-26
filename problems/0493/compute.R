options(digits = 10)

compute <- function(n, k) {
    return(round(7 * (1 - prod(1 - k / (n / 7 * 6 + 1):n)), 9))
}

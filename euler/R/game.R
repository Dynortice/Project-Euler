#' Get number of combinations of totals p for n s-sided dices
#'
#' @param p: Total sum of dices
#' @param n: Number of dices
#' @param s: Number of sides for each dice
#' @examples:
#' dice_combinations(6, 6, 6)
#' dice_combinations(16, 8, 4)
dice_combinations <- function(p, n, s) {
    result <- 0
    for (k in 0:((p - n) %/% s)) result <- result + (-1) ^ k * choose(n, k) * choose(p - 1 - s * k, n - 1)
    return(result)
}

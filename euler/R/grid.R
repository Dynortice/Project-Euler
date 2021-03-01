source("euler/R/math.R")

#' Get product of n adjacent numbers in grid
#'
#' @param grid: Matrix
#' @param n: Number of adjacent numbers in product
#' @param coordinate: Start position in product
#' @param direction: Direction for getting adjacent numbers (vertical, horizontal, diagonal)
#' @examples
#' grid <- matrix(c(8, 2, 22, 97, 49, 49, 99, 40, 81, 49, 31, 73, 52, 70, 95, 23), nrow = 4)
#' Horizontal (8 * 2 * 22 * 97):
#' adjacent_product(grid, 4, c(1, 1), c(0, 1))
#' Vertical (97 * 40 * 73):
#' adjacent_product(grid, 3, c(1, 4), c(1, 0))
#' Up-left to down-right diagonal (49 * 31 * 23)
#' adjacent_product(grid, 3, c(2, 2), c(1, 1))
#' Up-right to down-left diagonal (97 * 99)
#' adjacent_product(grid, 2, c(1, 4), c(1, -1))
adjacent_product <- function(grid, n, coordinate, direction) {
    product <- 1
    for (i in 0:(n - 1)) {
        number <- grid[coordinate[2] + direction[2] * i, coordinate[1] + direction[1] * i]
        if (number == 0) return(0)
        product <- product * number
    }
    return(product)
}

#' Get triangle maximum path sum
#'
#' @param grid: Triangle-like list
#' @examples:
#' max_path_sum(list(c(3), c(7, 4), c(2, 4, 6), c(8, 5, 9, 3)))
max_path_sum <- function(grid) {
    while (length(grid) > 1) {
        len <- length(grid)
        for (i in seq_len(len - 1)) grid[[len - 1]][i] <- grid[[len - 1]][i] + fast_max(grid[[len]][i], grid[[len]][i + 1])
        grid <- grid[-len]
    }
    return(grid[[1]])
}
